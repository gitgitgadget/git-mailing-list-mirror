Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835915B0E2
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025463; cv=none; b=ED/yitWNyDGOUBN1oxOoDuameLlnUP86Trkx4IKmgNL3XEmN8nalVZHLPeMuGxjAyeI3YTA68hSNPKph8vzhB8KXXSiE3k3vIjy3mS3MnLaL/aqS6cktLWMxhL6bOLQw4cVhaEjQmdJubdeJVq+qO+mChms45q3Qtas482+zLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025463; c=relaxed/simple;
	bh=o62CKTIvI1Bf3LeBdOeVxugbTn71QMnHEOdZQlI6UVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kMR5BiqmiXiibpaqZeDmh+CEmpkJsJfRidk3Pyfg1IsfnRpD3zq4unsOFaIcAhbQVd6jNZm0Dv9Az+GMVsnXwjbMzMbFwqfCrd5bm13nNBxrGeMfRCGy1Ug4n3/gwHwx7TORaeONwWhYhp6uUv9xIMNtIYWck7DLRTRKAyZ2kpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18fnC6JU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18fnC6JU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c296333so58573597b3.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025461; x=1715630261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDw6O8iYt3nuF7enVVC/N8T20/aisT3WXkf8IlWKiCE=;
        b=18fnC6JUm3dExRtj1GjJFzV8Lvm+mRx5uGGTD/tVhswunTwrRVSZ61HJSkXG4fHiwp
         lxVmL73fD8l10C4oFd3Y8BDE6MRoue1TODi1NU8lgvrd12cUDrk6I+itxkf9gjSGSVCg
         NHDyNJNiAHzCewJ0T/xxUSYDK7MIiJgpboyAKD91TzhEj1Fe9egSSV7fLdJdi81lVZck
         /YRSqAozCzd8InOFEMa/x30zB7laUrR05rwRG+y4FRTL+zt11HXaOYzmNkAkVszPpPAt
         b9AOMJojuE8bld061wecjkXn2PnjM8VapWDm3q6SIGwDZqOElFvIrG00DtUOGh93UyCJ
         CswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025461; x=1715630261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDw6O8iYt3nuF7enVVC/N8T20/aisT3WXkf8IlWKiCE=;
        b=o1BBDicY0hjVXHWxCgyhn22EGCvGSOI7pfxIzFYAbkdyZax/Qae9UNFxuZ4i4NAsw2
         xzo5qRha8MABTqCYR8/iCPBuJnuBg2b3Opo4I+pLHtamUHJYoVcVUw2Afm8t89SBx+I1
         isFws0jbkriRkmOMGtzybpKLFJyY1+A6C6Dth58tBOK5AxAEF24rvzK2u3kZwscMwq9+
         qmzbWZSCXmPL4qpkfU9kvH8FQvpUcYhfr0G2mO/glr+UXjYIit3HU7iT4pCQT839CBDE
         QgboFxMGm6wSktLztwJIKVzFABShJxzTQ8Jbwn71Ypl7HTdr0FRM1gAVwpn3IX7xEPvo
         gBxQ==
X-Gm-Message-State: AOJu0YzQA+vfMkdxCdHmRdgTVq1nvgTLVTYL2SYFUWtmHGUw5madHs0Y
	gxujNzy5paOZJGrBcoTKI60gVH1Gb5x62bRSI+W5Mxjw7nGvJ+A1zNViHm+6bbuJb7HXztSAuBB
	PoPDCvG1xRpeWkDRCq98MDLy/6o1pM57n3I37kW4RIp7jxPGdA1rWeYPHx+v9yJEqs3OJ99/1X6
	ISxltQk8ktfRZnGYShUsa9Um60Zg4KNS6KYdK/qJk=
X-Google-Smtp-Source: AGHT+IGDqPLDv7yUeSxrpCQ3rz88TTRk5JXL4wwTERmwJEHBCeguZX8ExCtgrN/Eh09m2iju2v8q+bsxMDqDRA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a0d:ea04:0:b0:618:5009:cb71 with SMTP id
 t4-20020a0dea04000000b006185009cb71mr156090ywe.5.1715025460840; Mon, 06 May
 2024 12:57:40 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:31 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <677745110078501e611faf3d1facd1518e0453a2.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 1/7] t0080: turn t-basic unit test into a helper
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
2.45.0.rc1.225.g2a3ae87e7f-goog

