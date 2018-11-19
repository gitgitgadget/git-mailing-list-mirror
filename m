Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A077D1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 13:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeKSXhJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 18:37:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36318 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeKSXhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 18:37:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so1804042wrr.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aQz2FYxSbiB19h+6FcEOClrWSJDQVFRtWlnhh7V1hQ=;
        b=dwjOq9fQ23qZOhp1UjSLr6JJaaM+B7jocmO3fUtM1OHqrBNUU2TJOufC8fAU55VBC5
         OhsG9mxdMQX6prkq7LvyYHoekOUooL0sc9hbQv2yzPiyW5tR5QI84qMrqEckMLLSLfqI
         rbttB4SfNk7z/58SEDAewEtKF/kIh+10c6KjXAw+DJV/qTnhmnAZmNJi3o8E+l9a0C1i
         uMpYFgDkY31K6YCDIjRlBZEDpQG9lOMTbd7F6057PbGM4IqPmlwNFZjs1QVIUHta0UKO
         f1vjUxY3fCBXrjLZefU70oUgYMYvhivIday0nGpHn3w/IrNAII4ngta3o/1s1fir/Yee
         xY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aQz2FYxSbiB19h+6FcEOClrWSJDQVFRtWlnhh7V1hQ=;
        b=DJa3FtlWtyhLAn6wz+CzRh0sXhW48qRdt9un5m0g42BtPViM+lADr27+NfVKEgJAIt
         18eSWrFv2kFI7dHj3avSU7JzkEwNZuzNsOwt+JFiwlcsWg8faM1VDC1YbuAKvq5Ib6oY
         WVaU0LC7hIdU/6bSjzWVBp7pEtxHGG1IGleNU+MgTixkkbkcwC8vafSyG29cMxHnmDc9
         +Ic2F46rnjFA5jW8MkUR8fu9PstLE8V0wC9sE/PW3MDtVBlOZwobD/2dyblxR3tNeMnW
         vF+6Ctppw5dmEBlz9Vb530GRClYONcJ+lGTQGxpt6t+BLaI7hogtsFYpeovOnahGE6ry
         SvrQ==
X-Gm-Message-State: AGRZ1gKLkIzxr3VtaYttjr+DwOo6SMceco3Otisp9O2WAMrSwS06fMsY
        957VGn8tJzKawmuOC01adHH9+huS
X-Google-Smtp-Source: AJdET5epdxeRai0/VSaQm6tTU1QCqoLBC9A2INjz9en5dJ1vahdq65eK2F2tHwinLrxY8Z+ZSEGwAg==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr18376045wru.300.1542633211227;
        Mon, 19 Nov 2018 05:13:31 -0800 (PST)
Received: from localhost.localdomain (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id y138sm32411013wmc.16.2018.11.19.05.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 05:13:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] tests: send "bug in the test script" errors to the script's stderr
Date:   Mon, 19 Nov 2018 14:13:26 +0100
Message-Id: <20181119131326.2435-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.134.gf0022f8e60
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the functions in our test library check that they were invoked
properly with conditions like this:

  test "$#" = 2 ||
  error "bug in the test script: not 2 parameters to test-expect-success"

If this particular condition is triggered, then 'error' will abort the
whole test script with a bold red error message [1] right away.

However, under certain circumstances the test script will be aborted
completely silently, namely if:

  - a similar condition in a test helper function like
    'test_line_count' is triggered,
  - which is invoked from the test script's "main" shell [2],
  - and the test script is run manually (i.e. './t1234-foo.sh' as
    opposed to 'make t1234-foo.sh' or 'make test') [3]
  - and without the '--verbose' option,

because the error message is printed from within 'test_eval_', where
standard output is redirected either to /dev/null or to a log file.
The only indication that something is wrong is that not all tests in
the script are executed and at the end of the test script's output
there is no "# passed all N tests" message, which are subtle and can
easily go unnoticed, as I had to experience myself.

Send these "bug in the test script" error messages directly to the
test scripts standard error and thus to the terminal, so those bugs
will be much harder to overlook.  Instead of updating all ~20 such
'error' calls with a redirection, let's add a BUG() function to
'test-lib.sh', wrapping an 'error' call with the proper redirection
and also including the common prefix of those error messages, and
convert all those call sites [4] to use this new BUG() function
instead.

[1] That particular error message from 'test_expect_success' is
    printed in color only when running with or without '--verbose';
    with '--tee' or '--verbose-log' the error is printed without
    color, but it is printed to the terminal nonetheless.

[2] If such a condition is triggered in a subshell of a test, then
    'error' won't be able to abort the whole test script, but only the
    subshell, which in turn causes the test to fail in the usual way,
    indicating loudly and clearly that something is wrong.

[3] Well, 'error' aborts the test script the same way when run
    manually or by 'make' or 'prove', but both 'make' and 'prove' pay
    attention to the test script's exit status, and even a silently
    aborted test script would then trigger those tools' usual
    noticable error messages.

[4] Strictly speaking, not all those 'error' calls need that
    redirection to send their output to the terminal, see e.g.
    'test_expect_success' in the opening example, but I think it's
    better to be consistent.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/perf/perf-lib.sh      |  4 ++--
 t/t0001-init.sh         |  4 ++--
 t/t4013-diff-various.sh |  2 +-
 t/t5516-fetch-push.sh   |  2 +-
 t/t9902-completion.sh   |  2 +-
 t/test-lib-functions.sh | 25 ++++++++++++-------------
 t/test-lib.sh           | 10 +++++++---
 7 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 11d1922cf5..2e33ab3ec3 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -82,7 +82,7 @@ test_perf_do_repo_symlink_config_ () {
 
 test_perf_create_repo_from () {
 	test "$#" = 2 ||
-	error "bug in the test script: not 2 parameters to test-create-repo"
+	BUG "not 2 parameters to test-create-repo"
 	repo="$1"
 	source="$2"
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
@@ -184,7 +184,7 @@ test_wrapper_ () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	BUG "not 2 or 3 parameters to test-expect-success"
 	export test_prereq
 	if ! test_skip "$@"
 	then
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 182da069f1..42a263cada 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -319,14 +319,14 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
 	base=GETCWD_TEST_BASE_DIR &&
 	mkdir -p $base/dir &&
 	chmod 100 $base ||
-	error "bug in test script: cannot prepare $base"
+	BUG "cannot prepare $base"
 
 	(cd $base/dir && /bin/pwd -P)
 	status=$?
 
 	chmod 700 $base &&
 	rm -rf $base ||
-	error "bug in test script: cannot clean $base"
+	BUG "cannot clean $base"
 	return $status
 '
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 73f7038253..7d985ff6b1 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -129,7 +129,7 @@ do
 		case "$magic" in
 		noellipses) ;;
 		*)
-			die "bug in t4103: unknown magic $magic" ;;
+			BUG "unknown magic $magic" ;;
 		esac ;;
 	*)
 		cmd="$magic $cmd" magic=
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7316365a24..37e8e80893 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -95,7 +95,7 @@ mk_child() {
 
 check_push_result () {
 	test $# -ge 3 ||
-	error "bug in the test script: check_push_result requires at least 3 parameters"
+	BUG "check_push_result requires at least 3 parameters"
 
 	repo_name="$1"
 	shift
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..b1f901170e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1249,7 +1249,7 @@ test_expect_success 'teardown after ref completion' '
 
 test_path_completion ()
 {
-	test $# = 2 || error "bug in the test script: not 2 parameters to test_path_completion"
+	test $# = 2 || BUG "not 2 parameters to test_path_completion"
 
 	local cur="$1" expected="$2"
 	echo "$expected" >expected &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d158c8d0bf..18784f0152 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -418,14 +418,14 @@ test_declared_prereq () {
 test_verify_prereq () {
 	test -z "$test_prereq" ||
 	expr >/dev/null "$test_prereq" : '[A-Z0-9_,!]*$' ||
-	error "bug in the test script: '$test_prereq' does not look like a prereq"
+	BUG "'$test_prereq' does not look like a prereq"
 }
 
 test_expect_failure () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
+	BUG "not 2 or 3 parameters to test-expect-failure"
 	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
@@ -445,7 +445,7 @@ test_expect_success () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	BUG "not 2 or 3 parameters to test-expect-success"
 	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
@@ -472,7 +472,7 @@ test_expect_success () {
 test_external () {
 	test "$#" = 4 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 3 ||
-	error >&5 "bug in the test script: not 3 or 4 parameters to test_external"
+	BUG "not 3 or 4 parameters to test_external"
 	descr="$1"
 	shift
 	test_verify_prereq
@@ -613,7 +613,7 @@ test_path_is_missing () {
 test_line_count () {
 	if test $# != 3
 	then
-		error "bug in the test script: not 3 parameters to test_line_count"
+		BUG "not 3 parameters to test_line_count"
 	elif ! test $(wc -l <"$3") "$1" "$2"
 	then
 		echo "test_line_count: line count for $3 !$1 $2"
@@ -793,13 +793,12 @@ test_i18ngrep () {
 	eval "last_arg=\${$#}"
 
 	test -f "$last_arg" ||
-	error "bug in the test script: test_i18ngrep requires a file" \
-	      "to read as the last parameter"
+	BUG "test_i18ngrep requires a file to read as the last parameter"
 
 	if test $# -lt 2 ||
 	   { test "x!" = "x$1" && test $# -lt 3 ; }
 	then
-		error "bug in the test script: too few parameters to test_i18ngrep"
+		BUG "too few parameters to test_i18ngrep"
 	fi
 
 	if test -n "$GETTEXT_POISON"
@@ -871,7 +870,7 @@ test_seq () {
 	case $# in
 	1)	set 1 "$@" ;;
 	2)	;;
-	*)	error "bug in the test script: not 1 or 2 parameters to test_seq" ;;
+	*)	BUG "not 1 or 2 parameters to test_seq" ;;
 	esac
 	test_seq_counter__=$1
 	while test "$test_seq_counter__" -le "$2"
@@ -909,7 +908,7 @@ test_when_finished () {
 	# doing so on Bash is better than nothing (the test will
 	# silently pass on other shells).
 	test "${BASH_SUBSHELL-0}" = 0 ||
-	error "bug in test script: test_when_finished does nothing in a subshell"
+	BUG "test_when_finished does nothing in a subshell"
 	test_cleanup="{ $*
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
 }
@@ -918,7 +917,7 @@ test_when_finished () {
 # Usage: test_create_repo <directory>
 test_create_repo () {
 	test "$#" = 1 ||
-	error "bug in the test script: not 1 parameter to test-create-repo"
+	BUG "not 1 parameter to test-create-repo"
 	repo="$1"
 	mkdir -p "$repo"
 	(
@@ -1230,7 +1229,7 @@ test_oid_cache () {
 
 		if ! expr "$k" : '[a-z0-9][a-z0-9]*$' >/dev/null
 		then
-			error 'bug in the test script: bad hash algorithm'
+			BUG 'bad hash algorithm'
 		fi &&
 		eval "test_oid_${k}_$tag=\"\$v\""
 	done
@@ -1245,7 +1244,7 @@ test_oid () {
 	# key-hash pair, so exit with an error.
 	if eval "test -z \"\${$var+set}\""
 	then
-		error "bug in the test script: undefined key '$1'" >&2
+		BUG "undefined key '$1'"
 	fi &&
 	eval "printf '%s' \"\${$var}\""
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index aba66cafa2..8dd40a6f97 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -382,6 +382,10 @@ error () {
 	exit 1
 }
 
+BUG () {
+	error >&7 "bug in the test script: $*"
+}
+
 say () {
 	say_color info "$*"
 }
@@ -709,7 +713,7 @@ test_run_ () {
 		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
 			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
 		then
-			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
+			BUG "broken &&-chain or run-away HERE-DOC: $1"
 		fi
 		trace=$trace_tmp
 	fi
@@ -1209,7 +1213,7 @@ test_lazy_prereq SANITY '
 	chmod -w SANETESTD.1 &&
 	chmod -r SANETESTD.1/x &&
 	chmod -rx SANETESTD.2 ||
-	error "bug in test sript: cannot prepare SANETESTD"
+	BUG "cannot prepare SANETESTD"
 
 	! test -r SANETESTD.1/x &&
 	! rm SANETESTD.1/x && ! test -f SANETESTD.2/x
@@ -1217,7 +1221,7 @@ test_lazy_prereq SANITY '
 
 	chmod +rwx SANETESTD.1 SANETESTD.2 &&
 	rm -rf SANETESTD.1 SANETESTD.2 ||
-	error "bug in test sript: cannot clean SANETESTD"
+	BUG "cannot clean SANETESTD"
 	return $status
 '
 
-- 
2.20.0.rc0.134.gf0022f8e60

