import 'dart:io';
import 'constants.dart';

class ANSIPrinter {
	/// Output RGB Color text
	/// - [text] : text you want output
	/// - [breakLine] : whether break line after output
	/// - [fColor] : foreground color
	/// - [fGray] : foreground color's grey scale value
	/// - [bColor] : background color
	/// - [bGray] : background color's grey scale value
	void printRGB(String text,
		{bool breakLine = true, int? fColor, double? fGray, int? bColor, double? bGray}) {
		assert(breakLine != null);
		if (text == '' || text == null) {
			print('', breakLine: breakLine);
			return;
		}
		if(!stdout.supportsAnsiEscapes) {
			print(text, breakLine: breakLine);
			return;
		}
		var prefix = '';
		if (fColor != null) {
			prefix = '${kESC}38;5;${_convert(fColor, fGray ?? 0.0)}m';
		}
		if (bColor != null) {
			prefix += '${kESC}48;5;${_convert(bColor, bGray ?? 0.0)}m';
		}
		print('$prefix$text${prefix == '' ? '' : '${kESC}m'}',
			breakLine: breakLine);
	}
	
	/// Output terminal text
	/// - [text] : text you want output
	/// - [breakLine] : whether break line after output
	void print(String text, {bool breakLine = true}) {
		stdout.write('$text${breakLine ? '\n' : ''}');
	}
}


int _convert(int rgb, double gray) =>
	(((rgb >> 16 & 0xFF) * 1.0 / 0xFF) * 5).toInt() * 36 +
		(((rgb >> 8 & 0xFF) * 1.0 / 0xFF) * 5).toInt() * 6 +
		(((rgb & 0xFF) * 1.0 / 0xFF) * 5).toInt() * 6 +
		16 + (gray * 23).round();