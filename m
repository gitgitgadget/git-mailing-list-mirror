Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36833C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiCKXA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiCKXAU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:00:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A90A1FAA08
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:52:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x15so14976830wru.13
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q8Cbr65tyIqZnEn7mI0m5BmWYi3q7zcXoZuLaTUXEt0=;
        b=UA7xRepdO0rcwEdths9zdQ+Z5Wd3jQ5TgGCiLiZf2zQwhGsgN7eIQegSq+jAve8Pd2
         aGPlKM/nuIdUFj5Ku00qhg9RfP+mIMSxifrQs58tbq9PBdSu6UHDk2iIl07gItvZN7N6
         oBx9hVQrx4mTZNKtvKeSAgT+UYnYM2xQtaOgRZ/1fNG8XIWu4ii1tEW/fE+HMRU0nf8Q
         12Et0K1F3yFJX+hyVUUn91BJgnYExX/yMgEzZRphLovhiT4j9EbQn6quvTcLNq1eQ3KU
         hlmEKsZIIxhS5OBm3978f/TjpGjqJdGjdi1esN6l7BRbvVsoVkay5AaBs76tSWF7eztn
         Z26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q8Cbr65tyIqZnEn7mI0m5BmWYi3q7zcXoZuLaTUXEt0=;
        b=zQktZYsu3Kmh9voYbwS5SpRmFQdqnbaLpgEOSdbcKesPEekGH4X2krX6ZarU3FK5Tn
         VWfOEGwp/yVGR7k1V2y/FLrday2g9VjyjkQsK3cuFPMPcwiZ42oi3dwKXIFYKb+Fy70S
         jqUSwMNXv3g0PVsyZZKhqtmySvHdAEu+RzxTWbz6qeATo3mcXHAzCCE2VYgC7UtQNB3I
         05uOayKLDWCm9ZUHSthWto9Ax6FEdZaw/j/3zyoHsyCeV6raXqWx3izXXN2Yl4i4+8Yx
         KIN8cIIqHwFjcJwxfGgeDbVv4YGuOlt2lWh4mV+rMmzrkytSKZNAtQ0w+DbChX0fZ9V+
         k7gg==
X-Gm-Message-State: AOAM531k+CZeQsUXijhmQX63RBttfBGgoks89rUVa3HxJkGesAs5orcL
        mLOS5oPg5dFYXHpEWstuihiGFHtkySw=
X-Google-Smtp-Source: ABdhPJw+zOFCJA8c2gVS2akn1qqYLrtz1/lYCe4r/tYB0mh6dsNTkQCQaOpuaEGUrD1rw1TGegnjfQ==
X-Received: by 2002:a5d:5104:0:b0:203:855d:c41c with SMTP id s4-20020a5d5104000000b00203855dc41cmr7852686wrt.128.1647033310679;
        Fri, 11 Mar 2022 13:15:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b00389f80668cesm962368wma.28.2022.03.11.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:10 -0800 (PST)
Message-Id: <6693900600f5b27525dfe7de78e73900306e0ab5.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:55 +0000
Subject: [PATCH 08/16] t7527: add parameters to start_daemon to handle args
 and subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! t7527: create test for fsmonitor--daemon

Add parameters to start_daemon() and handle subshell and logging args.

Remove /dev/null from commands.

Fix &&-chaining of functions.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 217 ++++++++++++++++++-----------------
 1 file changed, 111 insertions(+), 106 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 0ccbfb9616f..026382a0d86 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -11,30 +11,85 @@ then
 fi
 
 stop_daemon_delete_repo () {
-	r=$1
-	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
+	r=$1 &&
+	test_might_fail git -C $r fsmonitor--daemon stop &&
 	rm -rf $1
-	return 0
 }
 
 start_daemon () {
-	case "$#" in
-		1) r="-C $1";;
-		*) r="";
-	esac
+	r="" &&
+	tf="" &&
+	t2="" &&
+	tk="" &&
 
-	git $r fsmonitor--daemon start || return $?
-	git $r fsmonitor--daemon status || return $?
+	while test "$#" -ne 0
+	do
+		case "$1" in
+		-C)
+			shift;
+			test "$#" -ne 0 ||
+				{ echo >&2 "error: -C requires arg"; exit 1; }
+			r="-C $1"
+			shift
+			;;
+		-tf)
+			shift;
+			test "$#" -ne 0 ||
+				{ echo >&2 "error: -tf requires arg"; exit 1; }
+			tf="$1"
+			shift
+			;;
+		-t2)
+			shift;
+			test "$#" -ne 0 ||
+				{ echo >&2 "error: -t2 requires arg"; exit 1; }
+			t2="$1"
+			shift
+			;;
+		-tk)
+			shift;
+			test "$#" -ne 0 ||
+				{ echo >&2 "error: -tk requires arg"; exit 1; }
+			tk="$1"
+			shift
+			;;
+		*)
+			echo >&2 "error: unknown option: '$1'"
+			exit 1
+			;;
+		esac
+	done &&
+
+	(
+		if test ! -z "$tf"
+		then
+			GIT_TRACE_FSMONITOR="$tf"
+			export GIT_TRACE_FSMONITOR
+		fi &&
+
+		if test ! -z "$t2"
+		then
+			GIT_TRACE2_PERF="$t2"
+			export GIT_TRACE2_PERF
+		fi &&
+
+		if test ! -z "$tk"
+		then
+			GIT_TEST_FSMONITOR_TOKEN="$tk"
+			export GIT_TEST_FSMONITOR_TOKEN
+		fi &&
 
-	return 0
+		git $r fsmonitor--daemon start &&
+		git $r fsmonitor--daemon status
+	)
 }
 
 # Is a Trace2 data event present with the given catetory and key?
 # We do not care what the value is.
 #
 have_t2_data_event () {
-	c=$1
-	k=$2
+	c=$1 &&
+	k=$2 &&
 
 	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
 }
@@ -43,7 +98,7 @@ test_expect_success 'explicit daemon start and stop' '
 	test_when_finished "stop_daemon_delete_repo test_explicit" &&
 
 	git init test_explicit &&
-	start_daemon test_explicit &&
+	start_daemon -C test_explicit &&
 
 	git -C test_explicit fsmonitor--daemon stop &&
 	test_must_fail git -C test_explicit fsmonitor--daemon status
@@ -63,7 +118,7 @@ test_expect_success 'implicit daemon start' '
 	# but this test case is only concerned with whether the daemon was
 	# implicitly started.)
 
-	GIT_TRACE2_EVENT="$(pwd)/.git/trace" \
+	GIT_TRACE2_EVENT="$PWD/.git/trace" \
 		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
 	nul_to_q <actual >actual.filtered &&
 	grep "builtin:" actual.filtered &&
@@ -86,7 +141,7 @@ test_expect_success 'implicit daemon stop (delete .git)' '
 
 	git init test_implicit_1 &&
 
-	start_daemon test_implicit_1 &&
+	start_daemon -C test_implicit_1 &&
 
 	# deleting the .git directory will implicitly stop the daemon.
 	rm -rf test_implicit_1/.git &&
@@ -110,7 +165,7 @@ test_expect_success 'implicit daemon stop (rename .git)' '
 
 	git init test_implicit_2 &&
 
-	start_daemon test_implicit_2 &&
+	start_daemon -C test_implicit_2 &&
 
 	# renaming the .git directory will implicitly stop the daemon.
 	mv test_implicit_2/.git test_implicit_2/.xxx &&
@@ -128,7 +183,7 @@ test_expect_success 'cannot start multiple daemons' '
 
 	git init test_multiple &&
 
-	start_daemon test_multiple &&
+	start_daemon -C test_multiple &&
 
 	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
 	grep "fsmonitor--daemon is already running" actual &&
@@ -177,8 +232,7 @@ test_expect_success 'setup' '
 # This is here in case something else fails first.
 #
 redundant_stop_daemon () {
-	git fsmonitor--daemon stop
-	return 0
+	test_might_fail git fsmonitor--daemon stop
 }
 
 test_expect_success 'update-index implicitly starts daemon' '
@@ -186,7 +240,7 @@ test_expect_success 'update-index implicitly starts daemon' '
 
 	test_must_fail git fsmonitor--daemon status &&
 
-	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_1" \
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
 		git update-index --fsmonitor &&
 
 	git fsmonitor--daemon status &&
@@ -202,7 +256,7 @@ test_expect_success 'status implicitly starts daemon' '
 
 	test_must_fail git fsmonitor--daemon status &&
 
-	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
 		git status >actual &&
 
 	git fsmonitor--daemon status &&
@@ -214,38 +268,38 @@ test_expect_success 'status implicitly starts daemon' '
 '
 
 edit_files () {
-	echo 1 >modified
-	echo 2 >dir1/modified
-	echo 3 >dir2/modified
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
 	>dir1/untracked
 }
 
 delete_files () {
-	rm -f delete
-	rm -f dir1/delete
+	rm -f delete &&
+	rm -f dir1/delete &&
 	rm -f dir2/delete
 }
 
 create_files () {
-	echo 1 >new
-	echo 2 >dir1/new
+	echo 1 >new &&
+	echo 2 >dir1/new &&
 	echo 3 >dir2/new
 }
 
 rename_files () {
-	mv rename renamed
-	mv dir1/rename dir1/renamed
+	mv rename renamed &&
+	mv dir1/rename dir1/renamed &&
 	mv dir2/rename dir2/renamed
 }
 
 file_to_directory () {
-	rm -f delete
-	mkdir delete
+	rm -f delete &&
+	mkdir delete &&
 	echo 1 >delete/new
 }
 
 directory_to_file () {
-	rm -rf dir1
+	rm -rf dir1 &&
 	echo 1 >dir1
 }
 
@@ -272,25 +326,20 @@ verify_status () {
 # daemon) because these commands might implicitly restart the daemon.
 
 clean_up_repo_and_stop_daemon () {
-	git reset --hard HEAD
-	git clean -fd
-	git fsmonitor--daemon stop
+	git reset --hard HEAD &&
+	git clean -fd &&
+	test_might_fail git fsmonitor--daemon stop &&
 	rm -f .git/trace
 }
 
 test_expect_success 'edit some files' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	edit_files &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: dir1/modified$"  .git/trace &&
 	grep "^event: dir2/modified$"  .git/trace &&
@@ -301,16 +350,11 @@ test_expect_success 'edit some files' '
 test_expect_success 'create some files' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	create_files &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: dir1/new$" .git/trace &&
 	grep "^event: dir2/new$" .git/trace &&
@@ -320,16 +364,11 @@ test_expect_success 'create some files' '
 test_expect_success 'delete some files' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	delete_files &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: dir1/delete$" .git/trace &&
 	grep "^event: dir2/delete$" .git/trace &&
@@ -339,16 +378,11 @@ test_expect_success 'delete some files' '
 test_expect_success 'rename some files' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	rename_files &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: dir1/rename$"  .git/trace &&
 	grep "^event: dir2/rename$"  .git/trace &&
@@ -361,16 +395,11 @@ test_expect_success 'rename some files' '
 test_expect_success 'rename directory' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	mv dirtorename dirrenamed &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: dirtorename/*$" .git/trace &&
 	grep "^event: dirrenamed/*$"  .git/trace
@@ -379,16 +408,11 @@ test_expect_success 'rename directory' '
 test_expect_success 'file changes to directory' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	file_to_directory &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: delete$"     .git/trace &&
 	grep "^event: delete/new$" .git/trace
@@ -397,16 +421,11 @@ test_expect_success 'file changes to directory' '
 test_expect_success 'directory changes to a file' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
-	(
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon
-	) &&
+	start_daemon -tf "$PWD/.git/trace" &&
 
 	directory_to_file &&
 
-	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+	test-tool fsmonitor-client query --token 0 &&
 
 	grep "^event: dir1$" .git/trace
 '
@@ -424,15 +443,7 @@ test_expect_success 'flush cached data' '
 
 	git init test_flush &&
 
-	(
-		GIT_TEST_FSMONITOR_TOKEN=true &&
-		export GIT_TEST_FSMONITOR_TOKEN &&
-
-		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon test_flush
-	) &&
+	start_daemon -C test_flush -tf "$PWD/.git/trace_daemon" -tk true &&
 
 	# The daemon should have an initial token with no events in _0 and
 	# then a few (probably platform-specific number of) events in _1.
@@ -441,8 +452,8 @@ test_expect_success 'flush cached data' '
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
 	nul_to_q <actual_0 >actual_q0 &&
 
-	touch test_flush/file_1 &&
-	touch test_flush/file_2 &&
+	> test_flush/file_1 &&
+	> test_flush/file_2 &&
 
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
 	nul_to_q <actual_1 >actual_q1 &&
@@ -462,7 +473,7 @@ test_expect_success 'flush cached data' '
 
 	grep "^builtin:test_00000002:0Q$" actual_q2 &&
 
-	touch test_flush/file_3 &&
+	> test_flush/file_3 &&
 
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
 	nul_to_q <actual_3 >actual_q3 &&
@@ -485,15 +496,9 @@ test_expect_success 'setup worktree base' '
 test_expect_success 'worktree with .git file' '
 	git -C wt-base worktree add ../wt-secondary &&
 
-	(
-		GIT_TRACE2_PERF="$(pwd)/trace2_wt_secondary" &&
-		export GIT_TRACE2_PERF &&
-
-		GIT_TRACE_FSMONITOR="$(pwd)/trace_wt_secondary" &&
-		export GIT_TRACE_FSMONITOR &&
-
-		start_daemon wt-secondary
-	) &&
+	start_daemon -C wt-secondary \
+		-tf "$PWD/trace_wt_secondary" \
+		-t2 "$PWD/trace2_wt_secondary" &&
 
 	git -C wt-secondary fsmonitor--daemon stop &&
 	test_must_fail git -C wt-secondary fsmonitor--daemon status
-- 
gitgitgadget

