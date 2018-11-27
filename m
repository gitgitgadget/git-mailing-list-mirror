Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C8C1F97F
	for <e@80x24.org>; Tue, 27 Nov 2018 22:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeK1Jy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:54:26 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:33633 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeK1JyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:54:25 -0500
Received: by mail-wm1-f45.google.com with SMTP id l3so1048576wme.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgmvfXeGcCsMYmkKr94/TR5h9OHtUGjhEZqoFsKMtLI=;
        b=SwrvBZsmq3sFcNe5fcfpTWxVTMSuAtCjqEMBmvNG4SMvJwWzBm+FuUNSSkShEOA4Mj
         h9G6Ows01vB0pq/K+E2KxXNgU+DlxFFpsYXA9Z6ZYU8pVLj3Fi/WpkEJhV3qkSeVw6kp
         Fwcy98L+M3KQyZsz/DCDN+WO4XUaS2IRjmERt5RDNx2Z/JXDsp9Pv5hdLxLEkeVwjV7s
         tYAbJhTg116EJpGsk928rpBuTfr4kG4VMqpMa1lWEzYgmb9QrdJYEOMvWKubXWm7x3uI
         n65a9u09ojppsn9B8xwbZT27JTymzeice8SgQLjzn0BcIbRs2iTpagxaAo1qr10OqlkW
         H/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgmvfXeGcCsMYmkKr94/TR5h9OHtUGjhEZqoFsKMtLI=;
        b=IZn/x+oeuiDvJ1rFUbGRopwzSobx++lUX5N2RROYDakiRP4Qyxc6xCIZuxUSyYHUmG
         bosKAg3TN2O0cUrD4nqQnwWVjRLGlO+dvkOXwjHRWh1SRKfLRYFqqZss2IukKlobDCCs
         G+U/aOjnYeZkyk5nIgEG7YFhelPlySMu2j+qlc9u8w1/kQcn6mmgFhaMnkPMoWPUxAPT
         HRuknV2VRhuRck4LohYV+HhRQ8Ly81t4dxdD0WXKMJ8n0O4XAZ+/wyFsuWnXmqD5J/Su
         Xor2den72dKJS6zVUScZ0fCeDxJjkUgHLYAoa5JFvvJlSLd6d1TAvItPG8F/zo5B/cRQ
         S7tA==
X-Gm-Message-State: AA+aEWYwYH5QUmv335N5zruscIGSSyE+si4CAdUVk+gTc0wA/qzhWofj
        sS4mF7najnycO2u6bcz9xsn5QNtT
X-Google-Smtp-Source: AFSGD/XRqjAG0ut1QV9NYg7glrszGbqCEx2SlNuSTFVWrnGFnGunJFj41N15EUWnpfzZQ/j1XLTO2Q==
X-Received: by 2002:a1c:c82:: with SMTP id 124mr630584wmm.143.1543359296779;
        Tue, 27 Nov 2018 14:54:56 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v189-v6sm710604wmd.40.2018.11.27.14.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:54:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] test-lib: add support for GIT_TODO_TESTS
Date:   Tue, 27 Nov 2018 23:54:45 +0100
Message-Id: <20181127225445.30045-5-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
In-Reply-To: <20181127225445.30045-1-avarab@gmail.com>
References: <20181127225445.30045-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the updated t/README documentation being added here
setting this new GIT_TODO_TESTS variable is usually better than
GIT_SKIP_TESTS.

My use-case for this is to get feedback from the CI infrastructure[1]
about which tests are passing due to fixes that have trickled into
git.git.

With the GIT_SKIP_TESTS variable this use-case is painful, you need to
do an occasional manual run without GIT_SKIP_TESTS set. It's much
better to use GIT_TODO_TESTS and get a report of passing TODO tests
from prove(1) at the bottom of the test output. Once those passing
TODO tests have trickled down to 'master' the relevant glob (set for
all of master/next/pu) can be removed.

As seen in the "GIT_TODO_TESTS mixed failure" test the lack of
interaction with existing tests marked as TODO by the test suite
itself is intentional. There's no need to print out something saying
they matched GIT_TODO_TESTS if they're already TODO tests.

1. https://public-inbox.org/git/875zwm15k2.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib-travisci.sh |  2 +-
 t/README           | 18 +++++++++--
 t/t0000-basic.sh   | 81 +++++++++++++++++++++++++++++++++++++++-------
 t/test-lib.sh      | 31 +++++++++++++++---
 4 files changed, 112 insertions(+), 20 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 69dff4d1ec..ad8290bfdb 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -121,7 +121,7 @@ osx-clang|osx-gcc)
 	# t9810 occasionally fails on Travis CI OS X
 	# t9816 occasionally fails with "TAP out of sequence errors" on
 	# Travis CI OS X
-	export GIT_SKIP_TESTS="t9810 t9816"
+	export GIT_TODO_TESTS="t9810 t9816"
 	;;
 GIT_TEST_GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=YesPlease
diff --git a/t/README b/t/README
index c03b268813..922b4fb3bf 100644
--- a/t/README
+++ b/t/README
@@ -207,8 +207,19 @@ ideally be reported as bugs and fixed, or guarded by a prerequisite
 (see "Using test prerequisites" below). But until then they can be
 skipped.
 
-To skip tests, set the GIT_SKIP_TESTS variable. Individual tests can
-be skipped:
+To skip tests, set either the GIT_SKIP_TESTS or GIT_TODO_TESTS
+variables. The difference is that with SKIP the tests won't be run at
+all, whereas they will be run with TODO, but in success or failure
+annotated as a TODO test.
+
+It's usually preferrable to use TODO, since the test suite will report
+those tests that unexpectedly succeed, which may indicate that
+whatever bug broke the test in the past has been fixed, and the test
+should be un-TODO'd. There's no such feedback loop with
+GIT_SKIP_TESTS.
+
+The GIT_SKIP_TESTS and GIT_TODO_TESTS take the same values. Individual
+tests can be skipped:
 
     $ GIT_SKIP_TESTS=t9200.8 sh ./t9200-git-cvsexport-commit.sh
 
@@ -223,7 +234,8 @@ patterns that tells which tests to skip, and either can match the
 
 For an individual test suite --run could be used to specify that
 only some tests should be run or that some tests should be
-excluded from a run.
+excluded from a run. The --run option is a shorthand for setting
+a GIT_SKIP_TESTS pattern.
 
 The argument for --run is a list of individual test numbers or
 ranges with an optional negation prefix that define what tests in
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b87a8f18c2..34c9c5c2a3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -324,9 +324,10 @@ test_expect_success 'test --verbose-only' '
 	EOF
 '
 
-test_expect_success 'GIT_SKIP_TESTS' "
+test_expect_success 'GIT_{SKIP,TODO}_TESTS' "
 	(
 		GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
+		GIT_TODO_TESTS='git.3' && export GIT_TODO_TESTS &&
 		run_sub_test_lib_test git-skip-tests-basic \
 			'GIT_SKIP_TESTS' <<-\\EOF &&
 		for i in 1 2 3
@@ -338,16 +339,17 @@ test_expect_success 'GIT_SKIP_TESTS' "
 		check_sub_test_lib_test git-skip-tests-basic <<-\\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
-		> ok 3 - passing test #3
-		> # passed all 3 test(s)
+		> ok 3 - passing test #3 # TODO (GIT_TODO_TESTS)
+		> # passed all 3 test(s) (including 1/0 ok/failing TODO test(s))
 		> 1..3
 		EOF
 	)
 "
 
-test_expect_success 'GIT_SKIP_TESTS several tests' "
+test_expect_success 'GIT_{SKIP,TODO}_TESTS several tests' "
 	(
 		GIT_SKIP_TESTS='git.2 git.5' && export GIT_SKIP_TESTS &&
+		GIT_TODO_TESTS='git.3 git.6' && export GIT_TODO_TESTS &&
 		run_sub_test_lib_test git-skip-tests-several \
 			'GIT_SKIP_TESTS several tests' <<-\\EOF &&
 		for i in 1 2 3 4 5 6
@@ -359,22 +361,25 @@ test_expect_success 'GIT_SKIP_TESTS several tests' "
 		check_sub_test_lib_test git-skip-tests-several <<-\\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
-		> ok 3 - passing test #3
+		> ok 3 - passing test #3 # TODO (GIT_TODO_TESTS)
 		> ok 4 - passing test #4
 		> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
-		> ok 6 - passing test #6
-		> # passed all 6 test(s)
+		> ok 6 - passing test #6 # TODO (GIT_TODO_TESTS)
+		> # passed all 6 test(s) (including 2/0 ok/failing TODO test(s))
 		> 1..6
 		EOF
 	)
 "
 
-test_expect_success 'GIT_SKIP_TESTS sh pattern' "
+test_expect_success 'GIT_{SKIP,TODO}_TESTS sh pattern' "
 	(
 		GIT_SKIP_TESTS='git.[2-5]' && export GIT_SKIP_TESTS &&
+		# Overlap between SKIP and TODO. No attempt is made to
+		# be smart about it.
+		GIT_TODO_TESTS='git.[4-8]' && export GIT_TODO_TESTS &&
 		run_sub_test_lib_test git-skip-tests-sh-pattern \
 			'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
-		for i in 1 2 3 4 5 6
+		for i in 1 2 3 4 5 6 7 8 9
 		do
 			test_expect_success \"passing test #\$i\" 'true'
 		done
@@ -386,9 +391,12 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 		> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
 		> ok 4 # skip passing test #4 (GIT_SKIP_TESTS)
 		> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
-		> ok 6 - passing test #6
-		> # passed all 6 test(s)
-		> 1..6
+		> ok 6 - passing test #6 # TODO (GIT_TODO_TESTS)
+		> ok 7 - passing test #7 # TODO (GIT_TODO_TESTS)
+		> ok 8 - passing test #8 # TODO (GIT_TODO_TESTS)
+		> ok 9 - passing test #9
+		> # passed all 9 test(s) (including 3/0 ok/failing TODO test(s))
+		> 1..9
 		EOF
 	)
 "
@@ -410,6 +418,55 @@ test_expect_success 'GIT_SKIP_TESTS entire file' "
 	)
 "
 
+test_expect_success 'GIT_TODO_TESTS entire file' "
+	(
+		GIT_TODO_TESTS='git' && export GIT_TODO_TESTS &&
+		run_sub_test_lib_test git-todo-tests-entire-file \
+			'GIT_TODO_TESTS' <<-\\EOF &&
+		for i in 1 2 3
+		do
+			test_expect_success \"failing test #\$i\" 'fail'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-todo-tests-entire-file <<-\\EOF
+		not ok 1 - failing test #1 # TODO (GIT_TODO_TESTS)
+		#	fail
+		not ok 2 - failing test #2 # TODO (GIT_TODO_TESTS)
+		#	fail
+		not ok 3 - failing test #3 # TODO (GIT_TODO_TESTS)
+		#	fail
+		# passed all 3 test(s) (including 0/3 ok/failing TODO test(s))
+		1..3
+		EOF
+	)
+"
+
+test_expect_success 'GIT_TODO_TESTS mixed failure' "
+	(
+		GIT_TODO_TESTS='git' && export GIT_TODO_TESTS &&
+		run_sub_test_lib_test git-todo-tests-mixed \
+			'GIT_TODO_TESTS' <<-\\EOF &&
+		test_expect_success \"success\" 'true'
+		test_expect_success \"success\" 'false'
+		test_expect_failure \"success\" 'true'
+		test_expect_failure \"success\" 'false'
+		test_done
+		EOF
+		check_sub_test_lib_test git-todo-tests-mixed <<-\\EOF
+		ok 1 - success # TODO (GIT_TODO_TESTS)
+		not ok 2 - success # TODO (GIT_TODO_TESTS)
+		#	false
+		ok 3 - success # TODO known breakage vanished
+		not ok 4 - success # TODO known breakage
+		# 1 known breakage(s) vanished; please update test(s)
+		# still have 1 known breakage(s)
+		# passed all remaining 2 test(s) (including 1/1 ok/failing TODO test(s))
+		1..4
+		EOF
+	)
+"
+
 test_expect_success '--run basic' "
 	run_sub_test_lib_test run-basic \
 		'--run basic' --run='1 3 5' <<-\\EOF &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6c6c0af7a1..ccd316e7bd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -456,6 +456,8 @@ test_count=0
 test_fixed=0
 test_broken=0
 test_success=0
+test_todo_success=0
+test_todo_failure=0
 
 test_external_has_tap=0
 
@@ -482,13 +484,29 @@ trap 'exit $?' INT
 # the test_expect_* functions instead.
 
 test_ok_ () {
+	todo_blurb=
+	if match_pattern_list $this_test.$test_count $GIT_TODO_TESTS ||
+		    match_pattern_list $this_test $GIT_TODO_TESTS
+	then
+		todo_blurb=' # TODO (GIT_TODO_TESTS)'
+		test_todo_success=$(($test_todo_success + 1))
+	fi
 	test_success=$(($test_success + 1))
-	say_color "" "ok $test_count - $@"
+	say_color "" "ok $test_count - $@$todo_blurb"
 }
 
 test_failure_ () {
-	test_failure=$(($test_failure + 1))
-	say_color error "not ok $test_count - $1"
+	todo_blurb=
+	if match_pattern_list $this_test.$test_count $GIT_TODO_TESTS ||
+		    match_pattern_list $this_test $GIT_TODO_TESTS
+	then
+		test_success=$(($test_success + 1))
+		test_todo_failure=$(($test_todo_failure + 1))
+		todo_blurb=' # TODO (GIT_TODO_TESTS)'
+	else
+		test_failure=$(($test_failure + 1))
+	fi
+	say_color error "not ok $test_count - $1$todo_blurb"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
@@ -845,13 +863,18 @@ test_done () {
 		test_remaining=$test_count
 		msg="$test_count test(s)"
 	fi
+	msg_todo=
+	if test "$test_todo_success" != 0 || test "$test_todo_failure" != 0
+	then
+		msg_todo=" (including $test_todo_success/$test_todo_failure ok/failing TODO test(s))"
+	fi
 	case "$test_failure" in
 	0)
 		if test $test_external_has_tap -eq 0
 		then
 			if test $test_remaining -gt 0
 			then
-				say_color pass "# passed all $msg"
+				say_color pass "# passed all $msg$msg_todo"
 			fi
 
 			# Maybe print SKIP message
-- 
2.20.0.rc1.379.g1dd7ef354c

