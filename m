Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67122158D80
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832724; cv=none; b=nJIr1usMCmXUJQ9fPxnEcteJj/az+CCSuG9VpJQ/f2CdCEuaQfkOQbX3QTgCsMA1/27lQuu239yyb67LKrqfIqaAtrtU5ttNH1vlaeh/qWZvzFaC1P/w63cF3+wavWQknA/21QzYfi2y2fuUXrIDKK7Ztxg/Bj/wFdr8zwMLxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832724; c=relaxed/simple;
	bh=DNeJwx2Ixw+KgNGRRO+ADQTKTagL6sw4+Y/rHzYkZOs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IsG1SuxswgNUFk6TaJdhBgo8FSZvvAsTHYrRufrytIEF/rNITbsrpAf/sxoGJqSqyu3HFa0pXM5XSbOqOZ1D/DlzTiMcHrwIR7eSSLvHZBBVcXFN3pLzQYAdYREJDYX/4F1dP3+N+ckjFcSF0LfybmZcJB2hy+ggir3mYreswFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FGYhiVrm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FGYhiVrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832712; x=1722437512; i=l.s.r@web.de;
	bh=G0fsCcC4GBxvPK3VY3VIpbfkzJnGygXB7gkw0Bkt0po=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FGYhiVrmTs4jhBzr1VUD7Lgga8P2eZgluKgztg/DqTAxNcG/sE+/f9A4zsR3vYVd
	 K5rfIVrn7Bib61UWOxpMhEwQcJZSMI6ZQ4FMeg0plketifI4kuf9G13+8aJjGdDa2
	 rqGV4wour0oE6DvYgCX9uT5iQSI7VVAwEnnfDiwd1vnnSDfimS4PuLRgySL59clW4
	 KGaAIPz7JHr2C024cLY7tqQVBT/ROSNiQcUlqcxjoUq17WTm5A2Z5afPBUNZApxJl
	 fUOc8b95h3m433vqv45CJAWIhgDWY5uS30f4FjmVf0z3YHcb3ZMdm0tgYiw6lIrME
	 nqOGIgX8GLNNX8KwOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1sLGvu1dTy-00svFz; Wed, 24
 Jul 2024 16:51:52 +0200
Message-ID: <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
Date: Wed, 24 Jul 2024 16:51:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/7] unit-tests: add for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Language: en-US
In-Reply-To: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9f/h/mdeQpqgMaQ5/DcYFGAA2m/Nbiwd0gSj7ejbQjFyoJ1Mt4/
 BlT0ZGhmm/bvjqeNDdpZ/qsGz7pw2+CVjXhWahIfQp3gv18/pLikWrdcFrXwy0korsc4M4m
 ezqkwXx7BeI9FIi4s1syjlNvNNhb6Gonvf/37MyLgsLDiOfNV7io9R3VWgz7Ct5SFR/FvfE
 9mT3OJo4goQWlsvMhz7ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jUSUcF5pHao=;mGXdNDJ7EP4QzkYn2WpnDPbMXQp
 EzOQu8NJ+V+8Hl3Lzj11rAROoplhSaZ4lF7BwLLlBPqTEhGFbT4A4wRB2IsrIEPZwXq3cTzv6
 odKmFwCG5lzOF7lxM9OgOP1Ef+jXhlaLS0YxrAG20hHL2Q+QO6z4wRa7ybVA6isN69flTrNwJ
 iSWU+9DfF9OTdBpk63tWHedC6G9w9lBac7Te6MZ2hxRFxalWKj/rZI0BiOMus/Z5CljZQZQc+
 e8G48IBL1cDu6wpK75IiPAMaaTrAoomIw1ysmm/lcWrAw6b2GtrNieXEWlJa7blSdIw4BClFD
 GE48/PRA9F9H9+rZSlKSdHG9WlwiyNYTM9huGg5ovLN6pQFWQ/xuoV3877BlKFeyPNHJljGLq
 RBLhehTltLxKEn1yXQToYvGe1KpRVSBe8+OLa9yOJkW6OOe9Co79DVH/lV3Dkq2Nft4F4vfWb
 zQSMFhLmvvnz64ax2ngM4FPyKPRQu9yKb1b3ihYxJAw0zUGxgl6g/beNf2/VUvr87xmS04xHn
 DrwYIkI9fel8EwFYxmRpyJ0IQk6thewx18iRJSbRzhGAVlNwzdaXKcvNvxCpG40CUYk+1ZSsn
 f6Aj06NnHoDaKbRidtsj8PRvBNgd93Rso8acb+r0Vj5L/HokK79G5dvysFSr01t5HvKmoMIVS
 nN2Yjb8TqFYYt03YWWpUlMT+MvJ4lfaRTdJUh9cVaUi6Icw+KFb+AQdj5hp82pdkYap1RZbbS
 coCYfLredsdsGgE1D5jZs+4+4LXsRKItXRUSQegMT/axfYwWoDygs4zFFhDdvY0anhDTovJSa
 MDx9qTFbhP1e9gaZBj+6dOHw==

The macro TEST only allows defining a test that consists of a single
expression.  Add a new macro, for_test, which provides a way to define
unit tests that are made up of one or more statements.

for_test allows defining self-contained tests en bloc, a bit like
test_expect_success does for regular tests.  It acts like a for loop
that runs at most once; the test body is executed if test_skip_all()
had not been called before.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 .clang-format               |  2 ++
 t/helper/test-example-tap.c | 33 +++++++++++++++++++++++++++++++++
 t/t0080-unit-test-output.sh | 35 ++++++++++++++++++++++++++++++++++-
 t/unit-tests/test-lib.h     | 20 ++++++++++++++++++++
 4 files changed, 89 insertions(+), 1 deletion(-)

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
index 79c12b01cd..5e49fb1e7e 100644
=2D-- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -94,5 +94,38 @@ int cmd__example_tap(int argc, const char **argv)
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
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index fe221f3bdb..5185154414 100755
=2D-- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -50,7 +50,40 @@ test_expect_success 'TAP output from unit tests' - <<\E=
OT
 	# BUG: test has no checks at t/helper/test-example-tap.c:94
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
-	1..19
+	ok 20 - for_test passing test
+	# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:100
+	#    left: 1
+	#   right: 2
+	not ok 21 - for_test failing test
+	not ok 22 - for_test passing TEST_TODO() # TODO
+	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:104
+	not ok 23 - for_test failing TEST_TODO()
+	# check "0" failed at t/helper/test-example-tap.c:106
+	# skipping test - missing prerequisite
+	# skipping check '1' at t/helper/test-example-tap.c:108
+	ok 24 - for_test test_skip() # SKIP
+	# skipping test - missing prerequisite
+	ok 25 - for_test test_skip() inside TEST_TODO() # SKIP
+	# check "0" failed at t/helper/test-example-tap.c:113
+	not ok 26 - for_test TEST_TODO() after failing check
+	# check "0" failed at t/helper/test-example-tap.c:119
+	not ok 27 - for_test failing check after TEST_TODO()
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
+	not ok 28 - for_test messages from failing string and char comparison
+	# BUG: test has no checks at t/helper/test-example-tap.c:127
+	not ok 29 - for_test test with no checks
+	1..29
 	EOF

 	! test-tool example-tap >actual &&
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 2de6d715d5..598c6ff9f3 100644
=2D-- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -14,6 +14,26 @@
 	test__run_end(test__run_begin() ? 0 : (t, 1),	\
 		      TEST_LOCATION(),  __VA_ARGS__)

+/*
+ * Run a test unless test_skip_all() has been called.  Acts like a for
+ * loop that runs at most once, with the test description between the
+ * parentheses and the test body as a statement or block after them.
+ * Supports continue to end the test early, but not break. The
+ * description for each test should be unique.  E.g.:
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
