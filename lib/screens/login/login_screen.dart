import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:dio/dio.dart';
import 'package:with_us/constants.dart';
import 'package:with_us/screens/auth/auth_screen.dart';
import 'package:with_us/widgets/rounded_button.dart';
//import 'package:mbtmi/screens/profile/profile.dart';

class LoginScreen extends StatelessWidget {
  get json => null;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Image.asset(
              "assets/images/back_icon.png",
              width: screenWidth * 0.06,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              Image.asset(
                "assets/images/logo.png",
                width: screenWidth * 0.5,
              ),
              const SizedBox(height: 5),
              const Text("함께하는 공부 플랫폼",
                  style: TextStyle(
                      color: kMainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.1),
              RoundedButtonForDialog(
                url: "assets/images/kakao_logo.png",
                text: "카카오톡으로 로그인하기",
                borderSize: 15,
                color: Colors.white,
                textColor: kMainColor,
                borderColor: Colors.grey.withOpacity(0.3),
                press: () {
                  // kakaoLogin();
                  Get.to(() => AuthScreen());
                },
              ),
              RoundedButtonForDialog(
                url: "assets/images/naver_logo.png",
                borderSize: 15,
                text: "네이버로 로그인하기",
                color: Colors.white,
                textColor: kMainColor,
                borderColor: Colors.grey.withOpacity(0.3),
                press: () {
                  Get.to(() => AuthScreen());
                },
              ),
              RoundedButtonForDialog(
                url: "assets/images/google_logo.png",
                borderSize: 15,
                text: "Google로 로그인하기",
                color: Colors.white,
                textColor: kMainColor,
                borderColor: Colors.grey.withOpacity(0.3),
                press: () {
                  Get.to(() => AuthScreen());
                },
              ),
              RoundedButtonForDialog(
                url: "assets/images/apple_logo.png",
                borderSize: 15,
                text: "Apple ID로 로그인하기",
                color: Colors.white,
                textColor: kMainColor,
                borderColor: Colors.grey.withOpacity(0.3),
                press: () {
                  Get.to(() => AuthScreen());
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.15,
                    vertical: screenHeight * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.18,
                      height: 1,
                      child: DecoratedBox(
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      ),
                    ),
                    const Text("or Sign up with"),
                    SizedBox(
                      width: screenWidth * 0.18,
                      height: 1,
                      child: DecoratedBox(
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/kakao_logo.png",
                      height: screenHeight * 0.04,
                    ),
                    Image.asset(
                      "assets/images/naver_logo.png",
                      height: screenHeight * 0.04,
                    ),
                    Image.asset(
                      "assets/images/google_logo.png",
                      height: screenHeight * 0.04,
                    ),
                    Image.asset(
                      "assets/images/apple_logo.png",
                      height: screenHeight * 0.04,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Future kakaoLogin() async {
  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오톡으로 로그인 성공');
    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        debugPrint('카카오계정으로 로그인 성공');
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공');
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
    }
  }
}
