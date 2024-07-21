Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14146BA
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721542917; cv=none; b=cOSB6j6Z2RvmlRPwo4TWURSRWeZQaLNktNmTXHNKQO6LhLEE4RXPcI1xKCQFkBsEa2F2VYzoQo7YzXlxaquj22SFLs7alTYR/AuxfePHRH3N3G2U67Zjui3lbef9oSyDZK8DwLWG4EL1w725bthkeAyfSN35L00WJ79q/6uwpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721542917; c=relaxed/simple;
	bh=dupydwXUlCLTQ+HOiYuoQMBVFY6Zsde9HK+hkCxdaE4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NbWCTKNNxlFqS6t7CjC0oZuatWxRUQXCGX84GvvYfTrJbBGJVXQwS2+EnEOm+WCpDLOrRpZH30bii6XEjucYgqwf3UUnL6G3uyxQ+ayGFJABR9RBNR921saj0nIfme0md8IRj+ikJTF/sooA6MuExKK6YKbHy0/uOf5aAtMxa2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=adpsIWrd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="adpsIWrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721542896; x=1722147696; i=l.s.r@web.de;
	bh=BsdGOclOgA+AAnq2AZigRN/T38TxorFYa5NOYfprbAw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=adpsIWrdrjilgyjAs1yrMAataZIb9M55nbRwZ40pO5XlLcUnPy/4du9mIL+U9G9d
	 KJp12+FXoAODO6MsYEJnVU34JFL6QD01+L8nKyROxNpaeqNZipxJYURzmVF7/wE8d
	 5MY8Rv+WXwowa6teU51PG55bZ8pJDnHZfE9bqMYC/XeS+K8rEWkayQmkhkseI0Ycn
	 K2iZ9dWN4W3oyV1ZOq7DvbYTRB0z6Y7CFjryODewOx3Bo1rDpdNb7bZYWsFjSf30G
	 C3bOeQJmxzX0uPNRshcmMnvwzdnZTa/WEjjiI+bbp5wbcOvDmqTpbmEMlmIsLSseU
	 tC6AfsmAZxb6OQFHkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8Bw1-1sRrZj2d2B-0083b2; Sun, 21
 Jul 2024 08:21:36 +0200
Message-ID: <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
Date: Sun, 21 Jul 2024 08:21:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/6] unit-tests: add for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Language: en-US
In-Reply-To: <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e51r28F2E11nfh59sqCtUF5jHbzDvaG6TxyKLwAXtvldi9PnpPJ
 PB631aqNwCSoGyV83jWdW6krInC2zTO0VBuIEq8PkghESgmad5MTyq1pCZYa2qwagaCo0+B
 Aryoyh4zvvz6pG8mznuh5OjXUpDrT0t2ewqsQNZnH3gvV6iN586GRSW02J1NG8rxal4IUP9
 jYyhEJRkGJyHXUMXdbehw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b7xvAIDZtmY=;Fg2fRTV20/0+DB7FL0yt5zc7oII
 WMlPtjuN7Sxp/nc5gWx7m6qQQqOkNDbL7I7WO1t6QkNYTkZVFQ3ApYIpCbKVaRBa/53kmDM/F
 yUlU2R8hJUTO0nqcTWvVpRnK0wSmjwblWOy5p3fGzKBXmXrcED5LofC9EWXNdqbPqVfSbQW7L
 Y08Eiea+kq9qmVhmfrW9nMqNYjFLz7wCz2EjLinsS2VfIaXO7BAp/NgX14lII9EgtGXDkNRb+
 4FbvjspeR7ob4OJD/xHVeAJGJZM6TyuXOWAPqnXdUak5a+HPdkbNreRqy5idQI/D4qOrlHVHg
 uJ+n5x6NLmlmb5+8oa1kpoBqrKKgkMMafrqyG9dg8R9MMgcSOjOaiaXdM0zUyyzQRxrGv2Pqi
 lSzgGMW+PkFjbL7CWotTSzHM/a2BTZAhZgIZmOA4BVm6Mun/ozrd27Wcwe/olxUSf1S0mtAbm
 Y8AuEa8VYSFfA6eT55IAJY4lfOl3fHYcIZ+Vp+PjcAko49WSf4ndzaGjh/Is9928jrqvScYdt
 OYQ2k7VdhdZXySDPCQEGJtMY3TUVbu23R7EqfusDFwk0EqBRAs/3CydtNEyFbEKoR6fuuVaNE
 T+Opp6wp55iD+75pjV7sdRGwPYQtW703ImneZimnsAVJRf1WIQ1uBaiq7AxYAWY4VQttId6Jg
 MPW25Y0XLfikpJAVwkHDBBiGImOT7BKHiWiRD089QKFjvJiH8irYXQ0oOSm2LV8XpQuWkz8ps
 7yO+lYLj82m0hCvf1f8rbFwYk+gZAUno23zs6yerxVMjmWPXpua/+xqQtmN9RmMKQy31eSUF3
 LY8z9AIP4UYb6H1dofdUSX0Q==

The macro TEST only allows defining a test that consists of a single
expression.  Add a new macro, for_test, which provides a way to define
unit tests that are made up of one or more statements.

for_test allows defining self-contained tests en bloc, a bit like
test_expect_success does for regular tests.  It acts like a for loop
that runs at most once; the test body is executed if test_skip_all()
had not been called before.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 .clang-format               |  2 ++
 t/helper/test-example-tap.c | 33 +++++++++++++++++++++++++++++++++
 t/t0080/expect              | 35 ++++++++++++++++++++++++++++++++++-
 t/unit-tests/test-lib.h     | 19 +++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 6408251577..863dc87dfc 100644
=2D-- a/.clang-format
+++ b/.clang-format
@@ -151,6 +151,7 @@ Cpp11BracedListStyle: false
 # function calls. Taken from:
 #   git grep -h '^#define [^[:space:]]*for_\?each[^[:space:]]*(' |
 #   sed "s/^#define /  - '/; s/(.*$/'/" | sort | uniq
+# Added for_test from t/unit-tests/test-lib.h manually as a special case.
 ForEachMacros:
   - 'for_each_builtin'
   - 'for_each_string_list_item'
@@ -168,6 +169,7 @@ ForEachMacros:
   - 'strintmap_for_each_entry'
   - 'strmap_for_each_entry'
   - 'strset_for_each_entry'
+  - 'for_test'

 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1
diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index d072ad559f..51d5e6e75b 100644
=2D-- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -92,5 +92,38 @@ int cmd__example_tap(int argc, const char **argv)
 	test_res =3D TEST(t_empty(), "test with no checks");
 	TEST(check_int(test_res, =3D=3D, 0), "test with no checks returns 0");

+	for_test ("for_test passing test")
+		check_int(1, =3D=3D, 1);
+	for_test ("for_test failing test")
+		check_int(1, =3D=3D, 2);
+	for_test ("for_test passing TEST_TODO()")
+		TEST_TODO(check(0));
+	for_test ("for_test failing TEST_TODO()")
+		TEST_TODO(check(1));
+	for_test ("for_test test_skip()") {
+		check(0);
+		test_skip("missing prerequisite");
+		check(1);
+	}
+	for_test ("for_test test_skip() inside TEST_TODO()")
+		TEST_TODO((test_skip("missing prerequisite"), 1));
+	for_test ("for_test TEST_TODO() after failing check") {
+		check(0);
+		TEST_TODO(check(0));
+	}
+	for_test ("for_test failing check after TEST_TODO()") {
+		check(1);
+		TEST_TODO(check(0));
+		check(0);
+	}
+	for_test ("for_test messages from failing string and char comparison") {
+		check_str("\thello\\", "there\"\n");
+		check_str("NULL", NULL);
+		check_char('a', =3D=3D, '\n');
+		check_char('\\', =3D=3D, '\'');
+	}
+	for_test ("for_test test with no checks")
+		; /* nothing */
+
 	return test_done();
 }
diff --git a/t/t0080/expect b/t/t0080/expect
index 0cfa0dc6d8..583f41b8c9 100644
=2D-- a/t/t0080/expect
+++ b/t/t0080/expect
@@ -40,4 +40,37 @@ not ok 17 - messages from failing string and char compa=
rison
 # BUG: test has no checks at t/helper/test-example-tap.c:92
 not ok 18 - test with no checks
 ok 19 - test with no checks returns 0
-1..19
+ok 20 - for_test passing test
+# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:98
+#    left: 1
+#   right: 2
+not ok 21 - for_test failing test
+not ok 22 - for_test passing TEST_TODO() # TODO
+# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:102
+not ok 23 - for_test failing TEST_TODO()
+# check "0" failed at t/helper/test-example-tap.c:104
+# skipping test - missing prerequisite
+# skipping check '1' at t/helper/test-example-tap.c:106
+ok 24 - for_test test_skip() # SKIP
+# skipping test - missing prerequisite
+ok 25 - for_test test_skip() inside TEST_TODO() # SKIP
+# check "0" failed at t/helper/test-example-tap.c:111
+not ok 26 - for_test TEST_TODO() after failing check
+# check "0" failed at t/helper/test-example-tap.c:117
+not ok 27 - for_test failing check after TEST_TODO()
+# check "!strcmp("\thello\\", "there\"\n")" failed at t/helper/test-examp=
le-tap.c:120
+#    left: "\011hello\\"
+#   right: "there\"\012"
+# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:121
+#    left: "NULL"
+#   right: NULL
+# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:122
+#    left: 'a'
+#   right: '\012'
+# check "'\\' =3D=3D '\''" failed at t/helper/test-example-tap.c:123
+#    left: '\\'
+#   right: '\''
+not ok 28 - for_test messages from failing string and char comparison
+# BUG: test has no checks at t/helper/test-example-tap.c:125
+not ok 29 - for_test test with no checks
+1..29
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 2de6d715d5..12afd47ac9 100644
=2D-- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -14,6 +14,25 @@
 	test__run_end(test__run_begin() ? 0 : (t, 1),	\
 		      TEST_LOCATION(),  __VA_ARGS__)

+/*
+ * Run a test unless test_skip_all() has been called.  Acts like a for
+ * loop that runs at most once, with the test description between the
+ * parentheses and the test body as a statement or block after them.
+ * The description for each test should be unique.  E.g.:
+ *
+ *  for_test ("something else %d %d", arg1, arg2) {
+ *          prepare();
+ *          test_something_else(arg1, arg2);
+ *          cleanup();
+ *  }
+ */
+#define for_test(...)							\
+	for (int for_test_running_ =3D test__run_begin() ?		\
+		(test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) : 1;\
+	     for_test_running_;						\
+	     test__run_end(1, TEST_LOCATION(), __VA_ARGS__),		\
+		for_test_running_ =3D 0)
+
 /*
  * Print a test plan, should be called before any tests. If the number
  * of tests is not known in advance test_done() will automatically
=2D-
2.45.2
