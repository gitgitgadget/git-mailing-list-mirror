Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86519F49E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348511; cv=none; b=LvWYvtQq+98UldM2ZAgUBDXB2VNjn+VtL187OQ9JwkMTdPWJWxwbN7fi/uNgvv225T8PBJdcOYCxOlu/qKOiIbE9Wo/AYKlBrSytzMkEETwC7J9JIK+QsmNi40LX/cL6ILxhZeWgXbZv0hjG/1Y4plfkxbgSkQU4YgO2pBCkT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348511; c=relaxed/simple;
	bh=7nox1Wpe5DG1MaLpo5JM326nkMrErWS8GdkcpCm/ZcM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qhZyR7ywpAthJNa6auSDe4BHLOaJqyclNt+qgKD+esfK5hH2WddGilSEenGV9KCoNKtKPgaK7AScQQCqoWhuerwi4KFVw8ucc4wfc13ja51/kSwTm7QPzx/Eh7wHUbWweg3ju5/YCVSlnId/8WabRrQfiOW5g29KyTkdUeQsmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eq48DDYu; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eq48DDYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348500; x=1722953300; i=l.s.r@web.de;
	bh=bzR1SlmrkMSKI7HPa1MSeK04+ukez0ojHH/x1hAo3v0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eq48DDYu/t/FO38pX3Xix0UlsMT6ZGe93Vug8VsePxzIbCwEwtWFYyGRyMPC3iZL
	 2rFTSkCYBSxfvJF+ZGoPcg44w9EADjhF7Ln8PTTpwB9jBTd1iFY5ggwIYTpmaHIQw
	 +w4qiuWpMixSPKlI5trof9LUGRIu1IwSIn1eEalS6Ov4gbn6BF7nP476J9ikk47VX
	 T+O1OImccAwDTQhhAgeBBSWZXV6E5ghcSQsYYyFDsglcVBI9zSXA9sdjGwSaey16g
	 KWxD9MyRNN0I9kr0tqZa7l0Z1oyIpLh/T176aiwmpxfY5u7BNIL/73dpy8i351sVs
	 SPhBXSNd2I6Y8KDBOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGyK-1sryni13gM-00JqBI; Tue, 30
 Jul 2024 16:08:20 +0200
Message-ID: <da902de9-288e-4783-8b4b-a2a968d1e1f8@web.de>
Date: Tue, 30 Jul 2024 16:08:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 3/6] unit-tests: add if_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Kyle Lippincott <spectral@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Language: en-US
In-Reply-To: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qy4EX6n5EtiiBND2qvilFR3s2K0Dkmwj/qZjjxleOKwOcFUW+zm
 rozHj3m9UHMsnLC2vxjiM87TJG+QeVwbBtey90mTtsk8j4YsuijYLKE64cLBz+f3Mm/AiGZ
 GmFFAXML1pYJzjLGRc31wi7FrDVkrJ7onQF7ptjw8i8R/ZLQ7bXnVhXUgxv8uBQ/EwuT1Lt
 wAhDF2uHV/DT8qXadII2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RH2yAvSelXs=;o4+oesZitlq4e/GEbwvZ8zmOzE+
 PpBaq12Ci+/moZK/kTPmaZbAa/TaqMmg6+AKUK3ewZ+T9dwB3P5AQNgCrtvHysihHSMpVwRGJ
 brbMtkiDr8hmW4uJadI7h2z9QzsLw4Ffpqr1Y7qbgn1YGZeP4SGeRPOF0RqLKCSdKeES9mQE+
 Qnyf4WQNuBtFHvDDXFINiSzNua+vk5xMUfgmhhewGbdbuNyofGWuNawWkFxJswGDYpFjdEmbI
 Bydt5T9tNoF6ic84QDlI7a/+adTsShXrfUKwxYYnWYczBwMTohXZR8pFWwVByW0Ux2ABWdhp9
 SH0Y4mxsIuGayKzOV9E+dqYizzprSQWVT6pORl4eSxx1faMkPFAKt1XRdkJ58bB3aHR4QTa86
 6YYNIw0L6RRagdAkHVuapbRJhhoqJvrYNm1tetEDtB2si7jNjKJGzx+YVkK/MJBaXegIOS6s7
 net1rdJ2m4eYp22XGYuM1mH0Y/JYcfplaBPLNVbZzIHuIaMMuNsYl9qEOtVuD08dBzlUq7xVW
 N/X1imgUC5x8GD7Acfnm9CitOmePwPkE8kgjk+6OtVspUP7K4z+DxBAskQpSfOXjA5DlRH834
 tKv7piyjmTneIndyxDppPabYgPmy0/nUhO/MstcEz4cTpGisALOESDOxEKYLyRAsLWBhhjm4h
 icF3qXsx2KY1TFaTPfMryi7xo+OrBEb4p69LZEuFxWAMsUMu8WcfP12ZDqh6DRyjwzUyC1lJk
 CHz6HYyNMDrttE7zmYLDdDu6NWkc3lJRaRNEz50AHJ2J4F7/NwyXMiKeB2YY95CQJ5BJhnLXO
 frR6Sl2lBLch7xpO0Fz7tMug==

The macro TEST only allows defining a test that consists of a single
expression.  Add a new macro, if_test, which provides a way to define
unit tests that are made up of one or more statements.

if_test allows defining self-contained tests en bloc, a bit like
test_expect_success does for regular tests.  It acts like a conditional;
the test body is executed if test_skip_all() had not been called before.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 .clang-format               |  5 +++++
 t/helper/test-example-tap.c | 33 +++++++++++++++++++++++++++++++++
 t/t0080-unit-test-output.sh | 35 ++++++++++++++++++++++++++++++++++-
 t/unit-tests/test-lib.c     | 29 +++++++++++++++++++++++++++++
 t/unit-tests/test-lib.h     | 20 ++++++++++++++++++++
 5 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 6408251577..4c6d317508 100644
=2D-- a/.clang-format
+++ b/.clang-format
@@ -169,6 +169,11 @@ ForEachMacros:
   - 'strmap_for_each_entry'
   - 'strset_for_each_entry'

+# A list of macros that should be interpreted as conditionals instead of =
as
+# function calls.
+IfMacros:
+  - 'if_test'
+
 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index 79c12b01cd..914af88e0a 100644
=2D-- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -94,5 +94,38 @@ int cmd__example_tap(int argc, const char **argv)
 	test_res =3D TEST(t_empty(), "test with no checks");
 	TEST(check_int(test_res, =3D=3D, 0), "test with no checks returns 0");

+	if_test ("if_test passing test")
+		check_int(1, =3D=3D, 1);
+	if_test ("if_test failing test")
+		check_int(1, =3D=3D, 2);
+	if_test ("if_test passing TEST_TODO()")
+		TEST_TODO(check(0));
+	if_test ("if_test failing TEST_TODO()")
+		TEST_TODO(check(1));
+	if_test ("if_test test_skip()") {
+		check(0);
+		test_skip("missing prerequisite");
+		check(1);
+	}
+	if_test ("if_test test_skip() inside TEST_TODO()")
+		TEST_TODO((test_skip("missing prerequisite"), 1));
+	if_test ("if_test TEST_TODO() after failing check") {
+		check(0);
+		TEST_TODO(check(0));
+	}
+	if_test ("if_test failing check after TEST_TODO()") {
+		check(1);
+		TEST_TODO(check(0));
+		check(0);
+	}
+	if_test ("if_test messages from failing string and char comparison") {
+		check_str("\thello\\", "there\"\n");
+		check_str("NULL", NULL);
+		check_char('a', =3D=3D, '\n');
+		check_char('\\', =3D=3D, '\'');
+	}
+	if_test ("if_test test with no checks")
+		; /* nothing */
+
 	return test_done();
 }
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index fe221f3bdb..3c369c88e2 100755
=2D-- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -50,7 +50,40 @@ test_expect_success 'TAP output from unit tests' - <<\E=
OT
 	# BUG: test has no checks at t/helper/test-example-tap.c:94
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
-	1..19
+	ok 20 - if_test passing test
+	# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:100
+	#    left: 1
+	#   right: 2
+	not ok 21 - if_test failing test
+	not ok 22 - if_test passing TEST_TODO() # TODO
+	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:104
+	not ok 23 - if_test failing TEST_TODO()
+	# check "0" failed at t/helper/test-example-tap.c:106
+	# skipping test - missing prerequisite
+	# skipping check '1' at t/helper/test-example-tap.c:108
+	ok 24 - if_test test_skip() # SKIP
+	# skipping test - missing prerequisite
+	ok 25 - if_test test_skip() inside TEST_TODO() # SKIP
+	# check "0" failed at t/helper/test-example-tap.c:113
+	not ok 26 - if_test TEST_TODO() after failing check
+	# check "0" failed at t/helper/test-example-tap.c:119
+	not ok 27 - if_test failing check after TEST_TODO()
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-ex=
ample-tap.c:122
+	#    left: "\011hello\\\\"
+	#   right: "there\"\012"
+	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:12=
3
+	#    left: "NULL"
+	#   right: NULL
+	# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:124
+	#    left: 'a'
+	#   right: '\012'
+	# check "'\\\\' =3D=3D '\\''" failed at t/helper/test-example-tap.c:125
+	#    left: '\\\\'
+	#   right: '\\''
+	not ok 28 - if_test messages from failing string and char comparison
+	# BUG: test has no checks at t/helper/test-example-tap.c:127
+	not ok 29 - if_test test with no checks
+	1..29
 	EOF

 	! test-tool example-tap >actual &&
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 989dc758e6..fa1f95965c 100644
=2D-- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -16,6 +16,8 @@ static struct {
 	unsigned running :1;
 	unsigned skip_all :1;
 	unsigned todo :1;
+	char location[100];
+	char description[100];
 } ctx =3D {
 	.lazy_plan =3D 1,
 	.result =3D RESULT_NONE,
@@ -125,6 +127,8 @@ void test_plan(int count)

 int test_done(void)
 {
+	if (ctx.running && ctx.location[0] && ctx.description[0])
+		test__run_end(1, ctx.location, "%s", ctx.description);
 	assert(!ctx.running);

 	if (ctx.lazy_plan)
@@ -167,13 +171,38 @@ void test_skip_all(const char *format, ...)
 	va_end(ap);
 }

+void test__run_describe(const char *location, const char *format, ...)
+{
+	va_list ap;
+	int len;
+
+	assert(ctx.running);
+	assert(!ctx.location[0]);
+	assert(!ctx.description[0]);
+
+	xsnprintf(ctx.location, sizeof(ctx.location), "%s",
+		  make_relative(location));
+
+	va_start(ap, format);
+	len =3D vsnprintf(ctx.description, sizeof(ctx.description), format, ap);
+	va_end(ap);
+	if (len < 0)
+		die("unable to format message: %s", format);
+	if (len >=3D sizeof(ctx.description))
+		BUG("ctx.description too small to format %s", format);
+}
+
 int test__run_begin(void)
 {
+	if (ctx.running && ctx.location[0] && ctx.description[0])
+		test__run_end(1, ctx.location, "%s", ctx.description);
 	assert(!ctx.running);

 	ctx.count++;
 	ctx.result =3D RESULT_NONE;
 	ctx.running =3D 1;
+	ctx.location[0] =3D '\0';
+	ctx.description[0] =3D '\0';

 	return ctx.skip_all;
 }
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 2de6d715d5..f15dceb29e 100644
=2D-- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -14,6 +14,23 @@
 	test__run_end(test__run_begin() ? 0 : (t, 1),	\
 		      TEST_LOCATION(),  __VA_ARGS__)

+/*
+ * Run a test unless test_skip_all() has been called.  Acts like a
+ * conditional; the test body is expected as a statement or block after
+ * the closing parenthesis.  The description for each test should be
+ * unique.  E.g.:
+ *
+ *  if_test ("something else %d %d", arg1, arg2) {
+ *          prepare();
+ *          test_something_else(arg1, arg2);
+ *          cleanup();
+ *  }
+ */
+#define if_test(...)							\
+	if (test__run_begin() ?						\
+	    (test__run_end(0, TEST_LOCATION(),  __VA_ARGS__), 0) :	\
+	    (test__run_describe(TEST_LOCATION(),  __VA_ARGS__), 1))
+
 /*
  * Print a test plan, should be called before any tests. If the number
  * of tests is not known in advance test_done() will automatically
@@ -153,6 +170,9 @@ union test__tmp {

 extern union test__tmp test__tmp[2];

+__attribute__((format (printf, 2, 3)))
+void test__run_describe(const char *, const char *, ...);
+
 int test__run_begin(void);
 __attribute__((format (printf, 3, 4)))
 int test__run_end(int, const char *, const char *, ...);
=2D-
2.46.0
