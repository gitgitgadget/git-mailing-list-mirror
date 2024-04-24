Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DE2C1A2
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986060; cv=none; b=F3j/W5Oa6eJ0dPLFQJWKiDRSOsipdseVEzUrTGfiZ+QDre6D+97NiSjeQZGzF0v817lGzeTPYNxqHUucpedcPmBy4dSjZjfl9X6GbB3TOTq3KDACMqya+mZB4BbLvyWPfv5Kc+t95omG+RRcYv555zIYwTAf6vMqtroAqNoljdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986060; c=relaxed/simple;
	bh=abkWUpMoC0T+ghrLh4FiMZLr2+gH+0Kxtin45Yj6fPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSYNa2KFdUNkSHWsn6Sq0N9aaVcq79SI2oGUVFDxR4crJxKspDTDLqR3ulfG0P8BN5Cia2PpbsIeUJ5Wp6+mbGNooz8W0W+dEBHQS3PltCCG7iRJQmVIc95LdqNu+JZvA6JM3xBbqAr5HSX8ljjCWv7ve2JA2BTy1lgQ4Rw8XNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bll0AkuD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bll0AkuD"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150dcdf83fso3186867b3.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986057; x=1714590857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfeotoyLSYB/cVnv0MDF6dF+MaCPywMQ3wYNJf/YyWk=;
        b=bll0AkuDDqxK0O8GeSfHmcDLuaNi1RLO6oHSVIYvSwkFTP4R1qDLyfhdvTR5oM45uP
         KPyQ1NHJpTkPg2e4nagInQGSWQNABPrzje0SfQixHYHH905080TWGHXxN8IARJ286Onu
         LjDgeH5BWj4rKTZ+oszSHQdw4nTcWOzyQ5u3/hPP8RkDLIDz11HZqJ/uQ/gtJXgaiqDC
         JmjbR4ot3tpXskBcN8qiw4NHnIcHfUi1pN/2/CBOofGExkNKSzRsscwPfOnO2BNBrtCt
         JfHxf1mNFnGfdxliCi0Z9jm3kv6+H/w4gXnWPkIkPyk7zOXpctIndSD/3PuVi2qLQeov
         NcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986057; x=1714590857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfeotoyLSYB/cVnv0MDF6dF+MaCPywMQ3wYNJf/YyWk=;
        b=wi5yRITcLoEItI/whfgfD9vD5qGYYhqJ7v1xgWaeYf5Zbq3LcddTDqJz/lc8iYb6ys
         jvgxfVJmRoNaBVTT8i1bwQZuK4WfnaSC5OpMcrd85eAaq4wkLslamNKlJyatQ+ID58vs
         hq4Rr0HYqKUYcCR4aMocIOX5VHIFeI659Lg3K3IFk7tBP3WiUc92npIyDfEVinS7OhRV
         d39hGuko9Ooe6axUiBbSWHNwgq1YMGP3ikh3mC9kalnG6pi8MmDvOegpf5lNrxglNg7Q
         BLg7zVkL7dVzmkwv5AC2S7TquH8lv8ksL7+3vOtL1LhAG06vLTsvlij5sUAaPRX+JtpB
         wpBQ==
X-Gm-Message-State: AOJu0YzAC7bvQ2gCMEXJm/dTx1YKfhcPtw8iw7KkXFVP2oCmyj1ElHZa
	i8y2XSTmNIUoYFyjWyZtKlBPBfR8HczsoBmx6WUTmzGYflaHhTHDM/G3kkFU+R5/PMn/hk7PUJg
	TMny0LGdhwSVJv0sMu/qhAZjqZOWP7BRJ/nAP1jdksXNodWilFgvxGryhlO4Z8UguI3IPoHGGHS
	SyC0ThH85q8D/8u1qUqKLIXW+M8Zxo9yl0h5WLWq8=
X-Google-Smtp-Source: AGHT+IEOm61RnVaRdKY3fpnVywXadgD8TQq4THez310bDQM+j4a/wjjNpli7BI8V4Mu2a6042mShRWTtBrTnxw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a0d:db92:0:b0:618:80c0:1a2e with SMTP id
 d140-20020a0ddb92000000b0061880c01a2emr745986ywe.6.1713986057383; Wed, 24 Apr
 2024 12:14:17 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:07 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <677745110078501e611faf3d1facd1518e0453a2.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 1/7] t0080: turn t-basic unit test into a helper
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
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
2.44.0.769.g3c40516874-goog

