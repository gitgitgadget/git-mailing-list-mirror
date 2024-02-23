Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74B143C63
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731243; cv=none; b=UIQDbeMvHCgO57w5P5krRGgMJOzpvc9e0rP8eozy3oq9iQW/L0pzCbJbi6/KlaIotUIeP2goYqd8XoGuU0af2IYxMmGU9/LM+TDFZlY/E9gAhMzo2mlass84FnaNspyRUlLle2+S0HOxUKiB0SMRU7atkXUlmSAZzguTnEtZ8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731243; c=relaxed/simple;
	bh=DDH7wFYR6nVZ1zmBGZgR/8UW+hIVhJ3OsOCtUx2RZP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OcojqG0qost8dQ9nUvXz3x58EYxiyVxVyOHAhWo8RCTfP0vzRI81WDvuf7M17D14WhX7hk4hb+j+ppklKoZCBxh2LYek66rtT/wfjFQjSeAJ0m3ZWGrbWKa3VfXjVsGbdf/4hE6eMgsCAt7ozdwsvo+zOQzxDgf4jdD9+DOVu5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ/xvLrh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ/xvLrh"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so2540527276.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731240; x=1709336040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J518rWlaP09F54TLZsERPa+sRbw7YYooqKtklLkyZrE=;
        b=DQ/xvLrhHDVCp7daIllBttUW5KSZsfPwenGvq3yY53QzkOFpcNZYfwQ93uOxKCsjxN
         DBEbeLVpZCm+ba8SgoAUGol5iY2W027RE5T9oulfgwx0GGywPsmeyPyWR76xTkKwegRG
         DHaKpnbBNNQ6pbu1zgIX09SQ4mxSPOuhwOiNfjX/uhPWXHa7in938irzzvsdJBxstM5b
         jONLLrurC9ms7VfAKb2+VXAiRuhWzNo1C97O/WaNHpinm+mJKJeamQ26Tog0P6bBHf7T
         egGBbgsfWm8lM6fBBNZWJUf5SE+M0QfYY1LPwr19A5I22T1pNHT8d2wNaz5RUZcy/zbI
         BtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731240; x=1709336040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J518rWlaP09F54TLZsERPa+sRbw7YYooqKtklLkyZrE=;
        b=f+/0cLx7HT1p956bxMdlGBFY99a4cxCfFu3k01HiEtPsIWJSPLpQ+fLwhEh5rx0ebD
         lDciD25YbKW4yMfzqz+WVDJ9y1REBMM/YyuRwa52syq9s7GfZTsAS6cOUmv5VNQac9xE
         MlLAMijqgSgBz0knloD+KMxHzG3oRvuO1AWr2AOCD9uhGzWGvdFkc7cCDIXiX9dIdw/T
         x2GwhOarSiyZ0WtPJT/D18FHjrbAO/KjLjBifcwjAlZyovClZRwcRhT0nf8x+x4pPSo1
         bcrd78S7zg46/Mr8J3Z3X7e71TIaDLzQvfpMFfNiqQGovIbNTSWMEBQvNTFGTP5YI0IJ
         caNA==
X-Gm-Message-State: AOJu0Yz+hYKbVmCuuhg7YdyXm3jYKjNOsSYyeJPrAoRlWqMgXh25bfnR
	dSUWu7ONxL6XtlMyOx51zYPsRXCGPqd6ACsbRFtOktIFozQYWAvOaPsc41j3dv8Q+qHuWwjs38K
	YSWFcktHtzaQ33+L6rPVujA+zlQ7wTNgKCEpjs6hYGC+/Zg7bfATPwJDUQTjEpbnbwWnn9VU2d9
	s1bsc/bM+Du9Qugj3YYR7AMvMYtCa9BrhhyiW3YdY=
X-Google-Smtp-Source: AGHT+IFffw8Mb8VIZ+ysa/e00XBinDw96KfkwSuizCutnkbGB++XsWtU1cjml5Ii3TBPDEytXBoUAGfHB7qpFg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a05:6902:154f:b0:dc6:d678:371d with SMTP
 id r15-20020a056902154f00b00dc6d678371dmr344419ybu.3.1708731240303; Fri, 23
 Feb 2024 15:34:00 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:50 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <677745110078501e611faf3d1facd1518e0453a2.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 1/7] t0080: turn t-basic unit test into a helper
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

While t/unit-tests/t-basic.c uses the unit-test framework added in
e137fe3b29 (unit tests: add TAP unit test framework, 2023-11-09), it is
not a true unit test in that it intentionally fails in order to exercise
various codepaths in the unit-test framework. Thus, we intentionally
exclude it when running unit tests through the various t/Makefile
targets. Instead, it is executed by t0080-unit-test-output.sh, which
verifies its output follows the TAP format expected for the various
pass, skip, or fail cases.

As such, it makes more sense for t-basic to be a helper item for
t0080-unit-test-output.sh, so let's move it to
t/helper/test-example-tap.c and adjust Makefiles as necessary.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                                      |  4 ++--
 t/Makefile                                    |  2 +-
 .../t-basic.c => helper/test-example-tap.c}   |  5 ++--
 t/helper/test-tool.c                          |  1 +
 t/helper/test-tool.h                          |  1 +
 t/t0080-unit-test-output.sh                   | 24 +++++++++----------
 6 files changed, 20 insertions(+), 17 deletions(-)
 rename t/{unit-tests/t-basic.c => helper/test-example-tap.c} (95%)

diff --git a/Makefile b/Makefile
index 23723367b8..ba55d817ee 100644
--- a/Makefile
+++ b/Makefile
@@ -802,6 +802,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
+TEST_BUILTINS_OBJS += test-example-tap.o
 TEST_BUILTINS_OBJS += test-find-pack.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
@@ -1338,7 +1339,6 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
@@ -3218,7 +3218,7 @@ perf: all
 
 .PRECIOUS: $(TEST_OBJS)
 
-t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
diff --git a/t/Makefile b/t/Makefile
index 2d95046f26..4861edafe6 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,7 +48,7 @@ CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.tes
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
-UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
+UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
diff --git a/t/unit-tests/t-basic.c b/t/helper/test-example-tap.c
similarity index 95%
rename from t/unit-tests/t-basic.c
rename to t/helper/test-example-tap.c
index fda1ae59a6..d072ad559f 100644
--- a/t/unit-tests/t-basic.c
+++ b/t/helper/test-example-tap.c
@@ -1,4 +1,5 @@
-#include "test-lib.h"
+#include "test-tool.h"
+#include "t/unit-tests/test-lib.h"
 
 /*
  * The purpose of this "unit test" is to verify a few invariants of the unit
@@ -69,7 +70,7 @@ static void t_empty(void)
 	; /* empty */
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__example_tap(int argc, const char **argv)
 {
 	test_res = TEST(check_res = check_int(1, ==, 1), "passing test");
 	TEST(t_res(1), "passing test and assertion return 1");
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 33b9501c21..bb5c04c9c0 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -29,6 +29,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "env-helper", cmd__env_helper },
 	{ "example-decorate", cmd__example_decorate },
+	{ "example-tap", cmd__example_tap },
 	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b72f07ded9..38001bd1c6 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__env_helper(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
+int cmd__example_tap(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 961b54b06c..83b1e3b7f5 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -8,50 +8,50 @@ test_expect_success 'TAP output from unit tests' '
 	cat >expect <<-EOF &&
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
-	# check "1 == 2" failed at t/unit-tests/t-basic.c:76
+	# check "1 == 2" failed at t/helper/test-example-tap.c:77
 	#    left: 1
 	#   right: 2
 	not ok 3 - failing test
 	ok 4 - failing test and assertion return 0
 	not ok 5 - passing TEST_TODO() # TODO
 	ok 6 - passing TEST_TODO() returns 1
-	# todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/t-basic.c:25
+	# todo check ${SQ}check(x)${SQ} succeeded at t/helper/test-example-tap.c:26
 	not ok 7 - failing TEST_TODO()
 	ok 8 - failing TEST_TODO() returns 0
-	# check "0" failed at t/unit-tests/t-basic.c:30
+	# check "0" failed at t/helper/test-example-tap.c:31
 	# skipping test - missing prerequisite
-	# skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:32
+	# skipping check ${SQ}1${SQ} at t/helper/test-example-tap.c:33
 	ok 9 - test_skip() # SKIP
 	ok 10 - skipped test returns 1
 	# skipping test - missing prerequisite
 	ok 11 - test_skip() inside TEST_TODO() # SKIP
 	ok 12 - test_skip() inside TEST_TODO() returns 1
-	# check "0" failed at t/unit-tests/t-basic.c:48
+	# check "0" failed at t/helper/test-example-tap.c:49
 	not ok 13 - TEST_TODO() after failing check
 	ok 14 - TEST_TODO() after failing check returns 0
-	# check "0" failed at t/unit-tests/t-basic.c:56
+	# check "0" failed at t/helper/test-example-tap.c:57
 	not ok 15 - failing check after TEST_TODO()
 	ok 16 - failing check after TEST_TODO() returns 0
-	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/unit-tests/t-basic.c:61
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:62
 	#    left: "\011hello\\\\"
 	#   right: "there\"\012"
-	# check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-basic.c:62
+	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
 	#    left: "NULL"
 	#   right: NULL
-	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/unit-tests/t-basic.c:63
+	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/helper/test-example-tap.c:64
 	#    left: ${SQ}a${SQ}
 	#   right: ${SQ}\012${SQ}
-	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/unit-tests/t-basic.c:64
+	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/helper/test-example-tap.c:65
 	#    left: ${SQ}\\\\${SQ}
 	#   right: ${SQ}\\${SQ}${SQ}
 	not ok 17 - messages from failing string and char comparison
-	# BUG: test has no checks at t/unit-tests/t-basic.c:91
+	# BUG: test has no checks at t/helper/test-example-tap.c:92
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
 	1..19
 	EOF
 
-	! "$GIT_BUILD_DIR"/t/unit-tests/bin/t-basic >actual &&
+	! test-tool example-tap >actual &&
 	test_cmp expect actual
 '
 
-- 
2.44.0.rc0.258.g7320e95886-goog

