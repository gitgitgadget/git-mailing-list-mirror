Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2CAD48
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460836; cv=none; b=nEmtidDHiwuUVgENG/BM+f1afFTknJd2oKkSe62MSfgoX4mzDfdI2Xbir2z0TaFzbU8J7IuT/tfbq2gfOolOomyEm6KpAIwHttDvlrQSbpJpaioiqaszXRQC1vOecZi2kqGxVgvrqNMfTfFfotdaI6iZPgthihHmDp30MyumZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460836; c=relaxed/simple;
	bh=UEmdIB6ikdr0DEu5xb/i4MEW+T+8cEC5yraf66w4/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErIa8jy/x12f/WNmuG9otOFgqjzGSQSRFkbl7C3TBOa4J81wWJuJxAXDJkWw+KoPrSM3hbx47W/2nrfMQbPmTrJkpvm8OWAOa6jfTMrn+nXpy44LNj1oqwCvy3RBapobXJcMA+hzLOgFqTolzsgjSGpRjmk0RD3nVF0/nmmfl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NoDDDdDv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NoDDDdDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709460830; x=1710065630; i=l.s.r@web.de;
	bh=UEmdIB6ikdr0DEu5xb/i4MEW+T+8cEC5yraf66w4/iI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=NoDDDdDv3NqUg4Un9dqPWWSywnPeDUlxfjqZj2a0+I93qcOHJaSFWr+1BC0UEPrH
	 7C/d6RqHRYA36bPClQiMHXReJV2DYqAY0lF6mTf0bu+SR8oROzjYAn+De6Yo2JxpN
	 nSXiOUZsaK1dVovy27vjrIcdXrz19ZeKAcsVzyke14TOBK7KR4hQ1qzshwuzsFyUC
	 OCdS0Rb6lCl2syZjnke9FKPHtMUnwOKXMxvftdBAWGIYr4wQbc7tfFGlcGFxbvYCo
	 HAnW6OwYuVySVdcQXDj1a7MNPfCu7OiMuawlqMfGpgIJix6+Z8kNEqFpEfZplEHfl
	 jfY6D0/2NXWu3A6uwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MaHSb-1rJsNf1k3B-00WIfH; Sun, 03 Mar 2024 11:13:50 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 4/4] t-ctype: avoid duplicating class names
Date: Sun,  3 Mar 2024 11:13:28 +0100
Message-ID: <20240303101330.20187-5-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101330.20187-1-l.s.r@web.de>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8iS+SGIeRDv5JSc5UOGwyJve6pjt0CsURZHkgoKl/nk/7moHrLC
 vPDOKuygcCCwWy5zdyNksdZZB386eP1SVpYFEnhX78nKGwPNukpmogICRSoNLIYww636bCN
 6U7+LbTYR7tSYDgDc6vQLf3OtSAg/JSF+LKXsQ2Tj9Voxz31Q7iCGChSfuDf75ms26IdBoy
 f670pjHMfcQQ1eN92pXpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0jgFxh3H+I8=;wK/uMrnWP4kaOZ3i8oLN7b4/i/q
 jCHJJiSk3C8qqOmwePJm8ndwac5qOy9v0PjujC41dvJXq4degsZO+/8gtt/TuHick1Crh5Tzp
 4TQQQqWD0bYSKGTIkMAKNrP9LTgVfLs62Nu66V+sQIq3tROCxGsYqmXfRqI+TMQEytXPsixXO
 b+STEhftn69acI6HZW+QOXGzkI3+SnEqKSzvwY6qp9hwGJ+FAY/LmgrDY9wV3CFIxD6OObdOh
 eXCTRAZ+Wb9WSyJc/jzqUe6VssbCooIfD099hbs/uZeREzBt9WDkJKqw8PW5KWNLChTJJzNrR
 C6CEHfjgBESTiht5212yQYLDmkdwsJEbmrBYy4TlVuc5Klkc2TJhb9fi3KV5maZDNGEOaUDyJ
 QuBID7gFPwIZwwrferfJ5RfMi19jT9F/CzxlcRs7hGGHvF1A1Dm3Ef53r93BPI6ONYZ4xgg0q
 NMf8DjpQZDHcHtzt239VC3+XhCrn2vooUQO6mceoWo1P8YuQCisf66DRiA3WVlHt28kSBx3Ae
 k00ICA4j0Pc1NCWvPGvaWHjh8CttrFHf4dmmvh/arntSWnAbmMRYABiWh9qanuWaPPui8I02x
 od+ENbb1X+TdWUDnOxsmybnKcDbkwRn6T9ZOoTz/RMrHShawzQ1aYrfF7uTlDxuyp3W6dYqkM
 GT2V0J1Wo7X0u4qsxnAlDUwxMUVsf+NKFzreNoJcziNw9pb17kShJecVGaPcDRiEv+wJ1X8s1
 h92uzGEICpLjb4wC5jmTqSnrTAKIh5wjdkeZVsViNMm5+9U96a0f6WrIxHH5KKzx4DQtyjyf0
 jHUP6pYmpTM1r0yZ7acHhWHM1DjklCLTTHpxZMz4kgnp8=

TEST_CTYPE_FUNC defines a function for testing a character classifier,
TEST_CHAR_CLASS calls it, causing the class name to be mentioned twice.

Avoid the need to define a class-specific function by letting
TEST_CHAR_CLASS do all the work.  This is done by using the internal
functions test__run_begin() and test__run_end(), but they do exist to be
used in test macros after all.

Alternatively we could unroll the loop to provide a very long expression
that tests all 256 characters and EOF and hand that to TEST, but that
seems awkward and hard to read.

No change of behavior or output intended.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 64 ++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index 02d8569aa3..d6ac1fe678 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -1,19 +1,19 @@
 #include "test-lib.h"

-/* Macro to test a character type */
-#define TEST_CTYPE_FUNC(func, string) \
-static void test_ctype_##func(void) { \
+#define TEST_CHAR_CLASS(class, string) do { \
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	for (int i =3D 0; i < 256; i++) { \
-		if (!check_int(func(i), =3D=3D, !!memchr(string, i, len))) \
-			test_msg("      i: 0x%02x", i); \
+	int skip =3D test__run_begin(); \
+	if (!skip) { \
+		for (int i =3D 0; i < 256; i++) { \
+			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
+				test_msg("      i: 0x%02x", i); \
+		} \
+		check(!class(EOF)); \
 	} \
-	check(!func(EOF)); \
-}
-
-#define TEST_CHAR_CLASS(class) TEST(test_ctype_##class(), #class " works"=
)
+	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
+} while (0)

 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
@@ -33,37 +33,21 @@ static void test_ctype_##func(void) { \
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"

-TEST_CTYPE_FUNC(isdigit, DIGIT)
-TEST_CTYPE_FUNC(isspace, " \n\r\t")
-TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
-TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
-TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
-TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
-TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~")
-TEST_CTYPE_FUNC(isascii, ASCII)
-TEST_CTYPE_FUNC(islower, LOWER)
-TEST_CTYPE_FUNC(isupper, UPPER)
-TEST_CTYPE_FUNC(iscntrl, CNTRL)
-TEST_CTYPE_FUNC(ispunct, PUNCT)
-TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
-TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
-
 int cmd_main(int argc, const char **argv) {
-	/* Run all character type tests */
-	TEST_CHAR_CLASS(isspace);
-	TEST_CHAR_CLASS(isdigit);
-	TEST_CHAR_CLASS(isalpha);
-	TEST_CHAR_CLASS(isalnum);
-	TEST_CHAR_CLASS(is_glob_special);
-	TEST_CHAR_CLASS(is_regex_special);
-	TEST_CHAR_CLASS(is_pathspec_magic);
-	TEST_CHAR_CLASS(isascii);
-	TEST_CHAR_CLASS(islower);
-	TEST_CHAR_CLASS(isupper);
-	TEST_CHAR_CLASS(iscntrl);
-	TEST_CHAR_CLASS(ispunct);
-	TEST_CHAR_CLASS(isxdigit);
-	TEST_CHAR_CLASS(isprint);
+	TEST_CHAR_CLASS(isspace, " \n\r\t");
+	TEST_CHAR_CLASS(isdigit, DIGIT);
+	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
+	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
+	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
+	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
+	TEST_CHAR_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
+	TEST_CHAR_CLASS(isascii, ASCII);
+	TEST_CHAR_CLASS(islower, LOWER);
+	TEST_CHAR_CLASS(isupper, UPPER);
+	TEST_CHAR_CLASS(iscntrl, CNTRL);
+	TEST_CHAR_CLASS(ispunct, PUNCT);
+	TEST_CHAR_CLASS(isxdigit, DIGIT "abcdefABCDEF");
+	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");

 	return test_done();
 }
=2D-
2.44.0

