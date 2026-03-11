Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E126ED3A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198892; cv=none; b=LCg1+yymVwi1RsOuB6H0XIl9plxnp4MjU59/VuSobs2QNTupxADGSI/qlV5cZnpY4H3VYabBRlyFYSneo/WED1XrVJ2A4KZAnruTNfho5ccqLhf8aNqOx2bB4MPYnAW2kUMocV9YWqFH/NaJr8E0Ay+PN+ogOs0TMSP8NTadczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198892; c=relaxed/simple;
	bh=9I40iICAFJncWjAqZAeDLdDL/JSM8klPnVQ1Z4ONeKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci/UeaC97RdY6KKYIg4TidE63qKw5NttcmCuQiBO3MkRB1cyTxQBSZrcD2vP5rmEVnrmvjBOE/xTLeXQXTb0Lmm9WQjpyyvpWxbaGd0pPTewfOjV+rqv9VpGAzqf4VNQdrvhhTT/hYjUAN59mvVyFa7r+AzLpiISHbgP8p/E9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1CktSzZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1CktSzZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so161005565e9.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198889; x=1773803689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nw9NC9d0uH+5V/fvKnKO8/IZxKkoXQaRQC0SrnqQhmk=;
        b=A1CktSzZhopIXUhJ9OuQHgRj/kWjrWUVPOYTC++47iYbJDgs55ZeVkxLjE5XqvPC1/
         k/K1q2naHnwIayWgArqQzU7Rt8vyzg4nrAA8JVN8/0JFbjoBq2xSQkTolvfyQgW9i2dj
         wFBAipkg3MuSeZT6wJu4IvJYSHKO88yLPw/yNP1OZXAv1aHOdbICz/8JuuEVorRKjA3d
         1nKiE0oTt8q1VMjEDQCepkRISohDykiNlEEvs6OwNF9F5SzhA6KAW4mW8muACfWUZY84
         KStXXpGJPWDRooELAtl/b1FIQzzimLFql/d0ikUgE+6kaNQ8X9WEbiMTTKg+BYT3WUco
         85AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198889; x=1773803689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nw9NC9d0uH+5V/fvKnKO8/IZxKkoXQaRQC0SrnqQhmk=;
        b=v4DqRfJz91Las5rzypZdrpynMDwUPc6Jg1adlzblM9PnwbQKJcQ10wfE+Cz4LfslZs
         WnORUozHksirpwttVQYFbdLVhyuuhhttpRM2va6ooDs/jYjPosIbLmEA76/QB8QUPa+z
         7EbEapUin9MS/9cBAxnmmMTtRqndoUYv0WtrV4JAY/LpXo2zHCshjwXThgahv+ZPiHsL
         cCNAbLH/MyWO2rh2IcAVoGerK1kh5tmcUktAWC1ZSgGeGVEAZ4NdY2IP3VrjWKi2vwpd
         +eKwCU5Ju0v4s4S5WPIiIwpXPnlKk3Q6QuSPbPdYkXOSGKsWEa5QK/7uOqtK58JtjuKh
         Sz1A==
X-Gm-Message-State: AOJu0Yw1VV1VRgYG/3N6pZux2MqVzTYNWLQwoDiCRRWcJlwbxNBmuY6C
	Ph7Qpu6EAVIUU14aVaf7yaVyoFGogZjS9osDt6Toj7OzCbKpaJPmUhu0g18nol4M
X-Gm-Gg: ATEYQzztPzKzqe3wi/4Wao60IyrE2RZ3bfgszumGOxhFUafdGTcaWbBYuGnjOigoV2h
	Mh8pQJIT0e9W2ciJhH+22mUMvw8fOedrEK7wHCs8Rjzxohb8BHq58G3ivP0/udioMJ/lv3sx008
	4P76blz895S8BK1D59eqWJog8hb5FsC7QkVd5pqQsO89QwhOZayfg2lfIrl7aGQcKkl0FcjGfpI
	TMW+ELOYzUSdEFtN6mXbroXbmrqCl4nOUUDT6KduEZRWUGMwmnRWTQO56OelbfuwROSBYgg3hfh
	dsiLo0sf+lQQv42gQbdVvZzf2AfIdNYhry3LDtbxAMQ7AP/yUSJZcrY8IJYTpR7OT+bCvjbULfJ
	ynh3iFlDPvv2b2a7cieGYySF6O83c7n8Rhsqy7IEckg9KHRyYp79i4IvBi+f8H34ZaEuNVY9h9n
	/PtP4Pb0Epqf/XGaHLK/I6h0VWoIN0+hqRYl9nWVVUjugEFW9+8cvf+DFZ6tpFvSzLDYx0bZ2I8
	J2/QLk+UVMvO5WQgCpvMRENkhb9t5NJ4lC9C22wP/CPG9jTK204GSE4eUA=
X-Received: by 2002:a05:600c:45c3:b0:485:3e00:9440 with SMTP id 5b1f17b1804b1-4854b1396d2mr15106095e9.24.1773198889162;
        Tue, 10 Mar 2026 20:14:49 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm15393495e9.0.2026.03.10.20.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:14:48 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v2] test-lib: print escape sequence names
Date: Wed, 11 Mar 2026 04:14:42 +0100
Message-ID: <20260311031442.11942-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310183513.1077875-1-pabloosabaterr@gmail.com>
References: <20260310183513.1077875-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing expected/actual characters in failed checks, use
their names (\a, \b, \n, ...) instead of their octal representation,
making it easier to read.

Add tests to test-example-tap.c
Update t0080-unit-test-output.sh to match the desired output

Teach 'print_one_char()' the equivalent name

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes from v1:
reverted unrelated test change '\'' to '\\'' in t0080

 t/helper/test-example-tap.c |  4 +++
 t/t0080-unit-test-output.sh | 52 +++++++++++++++++++++++--------------
 t/unit-tests/test-lib.c     | 19 ++++++++++++--
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index 229d495ecf..998a1f0b42 100644
--- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -63,6 +63,8 @@ static void t_messages(void)
 	check_str("NULL", NULL);
 	check_char('a', ==, '\n');
 	check_char('\\', ==, '\'');
+	check_char('\a', ==, '\v');
+	check_char('\x00', ==, '\x01');
 }
 
 static void t_empty(void)
@@ -123,6 +125,8 @@ int cmd__example_tap(int argc UNUSED, const char **argv UNUSED)
 		check_str("NULL", NULL);
 		check_char('a', ==, '\n');
 		check_char('\\', ==, '\'');
+		check_char('\a', ==, '\v');
+		check_char('\x00', ==, '\x01');
 	}
 	if_test ("if_test test with no checks")
 		; /* nothing */
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 3db10f095c..66838a00b2 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -6,10 +6,10 @@ test_description='Test the output of the unit test framework'
 
 test_expect_success 'TAP output from unit tests' - <<\EOT
 	cat >expect <<-EOF &&
-	# BUG: check outside of test at t/helper/test-example-tap.c:75
+	# BUG: check outside of test at t/helper/test-example-tap.c:77
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
-	# check "1 == 2" failed at t/helper/test-example-tap.c:79
+	# check "1 == 2" failed at t/helper/test-example-tap.c:81
 	#    left: 1
 	#   right: 2
 	not ok 3 - failing test
@@ -34,53 +34,65 @@ test_expect_success 'TAP output from unit tests' - <<\EOT
 	not ok 15 - failing check after TEST_TODO()
 	ok 16 - failing check after TEST_TODO() returns 0
 	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:62
-	#    left: "\011hello\\\\"
-	#   right: "there\"\012"
+	#    left: "\thello\\\\"
+	#   right: "there\"\n"
 	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
 	#    left: "NULL"
 	#   right: NULL
 	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:64
 	#    left: 'a'
-	#   right: '\012'
+	#   right: '\n'
 	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:65
 	#    left: '\\\\'
 	#   right: '\\''
+	# check "'\a' == '\v'" failed at t/helper/test-example-tap.c:66
+	#    left: '\a'
+	#   right: '\v'
+	# check "'\x00' == '\x01'" failed at t/helper/test-example-tap.c:67
+	#    left: '\000'
+	#   right: '\001'
 	not ok 17 - messages from failing string and char comparison
-	# BUG: test has no checks at t/helper/test-example-tap.c:94
+	# BUG: test has no checks at t/helper/test-example-tap.c:96
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
 	ok 20 - if_test passing test
-	# check "1 == 2" failed at t/helper/test-example-tap.c:100
+	# check "1 == 2" failed at t/helper/test-example-tap.c:102
 	#    left: 1
 	#   right: 2
 	not ok 21 - if_test failing test
 	not ok 22 - if_test passing TEST_TODO() # TODO
-	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:104
+	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:106
 	not ok 23 - if_test failing TEST_TODO()
-	# check "0" failed at t/helper/test-example-tap.c:106
+	# check "0" failed at t/helper/test-example-tap.c:108
 	# skipping test - missing prerequisite
-	# skipping check '1' at t/helper/test-example-tap.c:108
+	# skipping check '1' at t/helper/test-example-tap.c:110
 	ok 24 - if_test test_skip() # SKIP
 	# skipping test - missing prerequisite
 	ok 25 - if_test test_skip() inside TEST_TODO() # SKIP
-	# check "0" failed at t/helper/test-example-tap.c:113
+	# check "0" failed at t/helper/test-example-tap.c:115
 	not ok 26 - if_test TEST_TODO() after failing check
-	# check "0" failed at t/helper/test-example-tap.c:119
+	# check "0" failed at t/helper/test-example-tap.c:121
 	not ok 27 - if_test failing check after TEST_TODO()
-	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:122
-	#    left: "\011hello\\\\"
-	#   right: "there\"\012"
-	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:123
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:124
+	#    left: "\thello\\\\"
+	#   right: "there\"\n"
+	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:125
 	#    left: "NULL"
 	#   right: NULL
-	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:124
+	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:126
 	#    left: 'a'
-	#   right: '\012'
-	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:125
+	#   right: '\n'
+	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:127
 	#    left: '\\\\'
 	#   right: '\\''
+	# check "'\a' == '\v'" failed at t/helper/test-example-tap.c:128
+	#    left: '\a'
+	#   right: '\v'
+	# check "'\x00' == '\x01'" failed at t/helper/test-example-tap.c:129
+	#    left: '\000'
+	#   right: '\001'
 	not ok 28 - if_test messages from failing string and char comparison
-	# BUG: test has no checks at t/helper/test-example-tap.c:127
+	# BUG: test has no checks at t/helper/test-example-tap.c:131
 	not ok 29 - if_test test with no checks
 	1..29
 	EOF
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 87e1f5c201..72ee20a06f 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -396,8 +396,23 @@ int check_uint_loc(const char *loc, const char *check, int ok,
 static void print_one_char(char ch, char quote)
 {
 	if ((unsigned char)ch < 0x20u || ch == 0x7f) {
-		/* TODO: improve handling of \a, \b, \f ... */
-		printf("\\%03o", (unsigned char)ch);
+		char esc;
+		switch (ch) {
+		case '\a': esc = 'a'; break;
+		case '\b': esc = 'b'; break;
+		case '\t': esc = 't'; break;
+		case '\n': esc = 'n'; break;
+		case '\v': esc = 'v'; break;
+		case '\f': esc = 'f'; break;
+		case '\r': esc = 'r'; break;
+		default: esc = 0; break;
+		}
+		if (esc) {
+			putc('\\', stdout);
+			putc(esc, stdout);
+		} else {
+			printf("\\%03o", (unsigned char)ch);
+		}
 	} else {
 		if (ch == '\\' || ch == quote)
 			putc('\\', stdout);
-- 
2.43.0

