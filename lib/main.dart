import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int randomNumber = 100000;

  @override
  void initState() {
    super.initState();
    random();
  }

  void random() {
    setState(() {
      Random random = Random();
      randomNumber = random.nextInt(1000000);
    });
  }

  Color accentPurpleColor = const Color(0xFF6A53A1);
  Color primaryColor = const Color(0xFF121212);
  Color accentPinkColor = const Color(0xFFF99BBD);
  Color accentDarkGreenColor = const Color(0xFF115C49);
  Color accentYellowColor = const Color(0xFFFFB612);
  Color accentOrangeColor = const Color(0xFFEA7A3B);

  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.headline3!.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    var otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi OTP'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Masukkan Kode :',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$randomNumber',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 40,
              ),
              OtpTextField(
                numberOfFields: 6,
                borderColor: accentPurpleColor,
                focusedBorderColor: accentPurpleColor,
                styles: otpTextStyles,
                showFieldAsBox: false,
                borderWidth: 4.0,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  if (int.parse(verificationCode) == randomNumber) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text("Berhasil"),
                            content: Text('Kode dimasukkan benar'),
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text("Gagal"),
                            content: Text('Kode dimasukkan salah'),
                          );
                        });
                  }
                }, // end
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: random,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
