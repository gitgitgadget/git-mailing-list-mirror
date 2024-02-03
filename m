Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7E80B
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921439; cv=none; b=Lt2+QWQ00IdIbHpKdNhJM51PUiR3V+2kb9f39i8hE6tEDwdZjMnSzbcOpPLPPe6FX+OdpgK/+/buMh1CKpV//r2GieOyS6nAxCCUW1U2womTgoidOSQDT2jzvvhoi/UHlI5G7nZ6qmQIQN0TYZLw5kRXJe3w+xrZ2hF0hGlzwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921439; c=relaxed/simple;
	bh=PXLH0pY3oA0Yi6rs6XgHa8cM5sjwAoNNTh4VytQrCNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eS8s1mVn/wxKK45iASJ0C40leNixqilbZB/DETtFs4PcLE+fpdw7uWKLUMlVur9+3zXV65lXIN1UnYt80GsXduX2kAr64+K6QNuvz0DQTuTmMDokgIKtQwcah0udPfAF3qhqwG3f+AUABVRBm4I8PreTUyREg99ywZhXzNvdmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi1MeWP+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi1MeWP+"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60420dcb127so17001647b3.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921436; x=1707526236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OB9yBM/Qv2VlOAI02pRTqgA5ieBc/fQLzo/91PcTd0E=;
        b=Gi1MeWP+qnG875wjyWge7yJtRBrH+/OdQKvEy63pb4ooqkYjqaYIDSwKH82joi4te6
         VsrHyBFiDxoONJnDG13q4S+9m1vS9kS+cy0jrPGp/230rBAfi3C/oaZg3pkOf8339Z8Y
         sixWGnhUABKypckrjPxzkDrbkCeGPF1x6qENfc1uoEQR9bXp7HyKn0UGCGvrf5NDwv+W
         ic0Fh7WwsyfVImCnwpneTM07SQoevlJn0NTKbhaElOhSe+ImjKXJ/qcUHMzHEJpUocEi
         W1KdsdR7/Gm5z3Co6NwraOfI9x/2swMYNLXTzFiHjEEmkZyb3rXqKvk3LToUVBjbMVdT
         ystg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921436; x=1707526236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB9yBM/Qv2VlOAI02pRTqgA5ieBc/fQLzo/91PcTd0E=;
        b=r6D6RYSM4jOoCzd36P/SYeMAyBEFDgYYNM/FvOQaV3datPTd+dom/km7Jnjgc3+stK
         7ZTt7BbRuXM9eJSx1seE2z+vMLGazrM+Kja/5rNzr3stb6FNPXJ4bX2cViyyG9x36VIs
         6+1QcH+HMQgrAzgaKfRIyr1zbue7I1v4kG8F/FEoyVOFc2zL7NuAR3S+2ObmwM5VTkcM
         C44/LE7WMw7EfO47FtSi3R7yHLL8eSlYXNhb7uIH1ZSX+hRVBz0a6aQXTLjbu9j6Rymz
         2L6LJgqb/pFLRFQAGi+lmwI6nUXzpQnafem/m5eckZvbiTT3m18DFlUyB+QIs4YvhOYW
         dPHg==
X-Gm-Message-State: AOJu0Yx57c9G0XiwA0rUdprs30UxIV39KRDgZTUE/DEyqDJu1E6Ue1/t
	av3OfIPkWdSGesEi0gk/qco48FhDYlRjPACMlnfoyWkcnDpuneOcfonowzY6lPOP3PCNhB1OjZw
	ioGxt+8EDO7WJlyusn/4fBUru3L/V7JXQAndZvXd72JIVbmRArkeXOYxAnCP66H/Ji7xlAE1qaQ
	vOi1aiUv3sTghdtIdeMUJRg8Di6tw4Er0xCu/l40Y=
X-Google-Smtp-Source: AGHT+IFDEc+wulD8wlqlFOtchbycnj8m+B4WH4BaLKrYQnbiPf98cVPVE7nye0AIpHfAl3bi8vhEt1jDJoF+2Q==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a05:690c:ece:b0:5ff:6e82:ea31 with SMTP
 id cs14-20020a05690c0ece00b005ff6e82ea31mr44916ywb.3.1706921436138; Fri, 02
 Feb 2024 16:50:36 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:26 -0800
In-Reply-To: <cover.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
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

This has the additional benefit that test harnesses seeking to run all
unit tests can find them with a simple glob of "t/unit-tests/bin/t-*",
with no exceptions needed. This will be important in a later patch where
we add support for running the unit tests via a test-tool subcommand.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                                      |  4 ++--
 t/Makefile                                    |  3 +--
 .../t-basic.c => helper/test-example-tap.c}   |  5 ++--
 t/helper/test-tool.c                          |  1 +
 t/helper/test-tool.h                          |  1 +
 t/t0080-unit-test-output.sh                   | 24 +++++++++----------
 6 files changed, 20 insertions(+), 18 deletions(-)
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
index 281f4c3534..1283c90c10 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -44,8 +44,7 @@ TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
-UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
-UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
+UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
diff --git a/t/unit-tests/t-basic.c b/t/helper/test-example-tap.c
similarity index 95%
rename from t/unit-tests/t-basic.c
rename to t/helper/test-example-tap.c
index fda1ae59a6..21e4848e78 100644
--- a/t/unit-tests/t-basic.c
+++ b/t/helper/test-example-tap.c
@@ -1,4 +1,5 @@
-#include "test-lib.h"
+#include "t/unit-tests/test-lib.h"
+#include "test-tool.h"
 
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
2.43.0.594.gd9cf4e227d-goog

