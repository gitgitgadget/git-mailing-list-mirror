Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCCC433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiCYT2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiCYT20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50011EA5C3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35so4951905wms.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PzYiX4KZSbUNaf88GIbxOE1hs0cGSW6c+HsGJS4mMWY=;
        b=mrFAtsagPaLDR2LMTSGqfGNLkKId/YluN3oKCrYLc1kniLYBcSpGNLMUz+/qq/6TTY
         mbVe2tVzeDNjVw9zeFgLnP/SWxR/NwNX31PZj2+bKn23fNfZIbpTKP0RLOwQAAz32Et6
         NqwEdLiCQNjQI5EhF2pgj6N0+MQrKwBCzFaH1qqwFl+G38ioSLbylqDcpE+QPWnDLbr+
         /qq8akVU+j39JVSE7o8fKwmG1YGSNFH4ANvPD5s0DF4G8PKAhGHS0ySHZCy0VbyGgnOP
         fiQoiDnEvZhYkWwq/UCL+oL/Nw/SEu8yMusVOGVVg9bqL/m6YODFVdYr/B1OXFUA0OI4
         RtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PzYiX4KZSbUNaf88GIbxOE1hs0cGSW6c+HsGJS4mMWY=;
        b=KGMZvvhEwajB4r37QFXVy9e4069my0XqbXaYHZEfhjilAEafjgesMqbcJPr5/DvAOF
         J0MlemtvaTMEB1v3RAMoRRAkxt8OnIT2tO8QBs48aVFOKKVkPC6W7NTaK4Anz+8fam70
         aYVZbOZ5yAynuaGgD2t8qj0zAiI+Cw5nQyAVGT0/uMx6tcIg43sUtw+OuV0L67E+6LAJ
         qaiEOCDgSO4C6YLyTP1NhqWD1cF+/98VbDUUwQ+BeNyGyf3DgXQB/tLWy7ZSrDJ+6xOx
         Z3uvWQbYRFY1jfYNQnCWZLNKqph3LE7lx3qfJoOlDtsJj/83hAjDStOPbXSiHqYCckuq
         Eadg==
X-Gm-Message-State: AOAM531sRJ6IVpZfrts6Id5iU9MHR9+LlfzYaIUvyCo8TkpNZ817Aoj/
        UvdLdf3OyWOopAofGbIO4EQUoukO7dY=
X-Google-Smtp-Source: ABdhPJyJEU2VZajejUv5EHzTvUNhjCVNQoNhwQXlSgISl7ISlbtDCnDb3MOS9VnR0XD2v5ft2X5BvA==
X-Received: by 2002:a05:600c:600a:b0:38c:6c9e:f9c7 with SMTP id az10-20020a05600c600a00b0038c6c9ef9c7mr20229007wmb.26.1648231418259;
        Fri, 25 Mar 2022 11:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v124-20020a1cac82000000b0037c3d08e0e7sm9020097wme.29.2022.03.25.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:37 -0700 (PDT)
Message-Id: <bc94e379b030da1295b524c8c47159368d7b63ba.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:04 +0000
Subject: [PATCH v9 21/30] t7527: create test for fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 494 +++++++++++++++++++++++++++++++++++
 1 file changed, 494 insertions(+)
 create mode 100755 t/t7527-builtin-fsmonitor.sh

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..062e01c0dfc
--- /dev/null
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -0,0 +1,494 @@
+#!/bin/sh
+
+test_description='built-in file system watcher'
+
+. ./test-lib.sh
+
+if ! test_have_prereq FSMONITOR_DAEMON
+then
+	skip_all="fsmonitor--daemon is not supported on this platform"
+	test_done
+fi
+
+stop_daemon_delete_repo () {
+	r=$1 &&
+	test_might_fail git -C $r fsmonitor--daemon stop &&
+	rm -rf $1
+}
+
+start_daemon () {
+	r= tf= t2= tk= &&
+
+	while test "$#" -ne 0
+	do
+		case "$1" in
+		-C)
+			r="-C ${2?}"
+			shift
+			;;
+		--tf)
+			tf="${2?}"
+			shift
+			;;
+		--t2)
+			t2="${2?}"
+			shift
+			;;
+		--tk)
+			tk="${2?}"
+			shift
+			;;
+		-*)
+			BUG "error: unknown option: '$1'"
+			;;
+		*)
+			BUG "error: unbound argument: '$1'"
+			;;
+		esac
+		shift
+	done &&
+
+	(
+		if test -n "$tf"
+		then
+			GIT_TRACE_FSMONITOR="$tf"
+			export GIT_TRACE_FSMONITOR
+		fi &&
+
+		if test -n "$t2"
+		then
+			GIT_TRACE2_PERF="$t2"
+			export GIT_TRACE2_PERF
+		fi &&
+
+		if test -n "$tk"
+		then
+			GIT_TEST_FSMONITOR_TOKEN="$tk"
+			export GIT_TEST_FSMONITOR_TOKEN
+		fi &&
+
+		git $r fsmonitor--daemon start &&
+		git $r fsmonitor--daemon status
+	)
+}
+
+# Is a Trace2 data event present with the given catetory and key?
+# We do not care what the value is.
+#
+have_t2_data_event () {
+	c=$1 &&
+	k=$2 &&
+
+	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
+}
+
+test_expect_success 'explicit daemon start and stop' '
+	test_when_finished "stop_daemon_delete_repo test_explicit" &&
+
+	git init test_explicit &&
+	start_daemon -C test_explicit &&
+
+	git -C test_explicit fsmonitor--daemon stop &&
+	test_must_fail git -C test_explicit fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon start' '
+	test_when_finished "stop_daemon_delete_repo test_implicit" &&
+
+	git init test_implicit &&
+	test_must_fail git -C test_implicit fsmonitor--daemon status &&
+
+	# query will implicitly start the daemon.
+	#
+	# for test-script simplicity, we send a V1 timestamp rather than
+	# a V2 token.  either way, the daemon response to any query contains
+	# a new V2 token.  (the daemon may complain that we sent a V1 request,
+	# but this test case is only concerned with whether the daemon was
+	# implicitly started.)
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace" \
+		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
+	nul_to_q <actual >actual.filtered &&
+	grep "builtin:" actual.filtered &&
+
+	# confirm that a daemon was started in the background.
+	#
+	# since the mechanism for starting the background daemon is platform
+	# dependent, just confirm that the foreground command received a
+	# response from the daemon.
+
+	have_t2_data_event fsm_client query/response-length <.git/trace &&
+
+	git -C test_implicit fsmonitor--daemon status &&
+	git -C test_implicit fsmonitor--daemon stop &&
+	test_must_fail git -C test_implicit fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon stop (delete .git)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1" &&
+
+	git init test_implicit_1 &&
+
+	start_daemon -C test_implicit_1 &&
+
+	# deleting the .git directory will implicitly stop the daemon.
+	rm -rf test_implicit_1/.git &&
+
+	# [1] Create an empty .git directory so that the following Git
+	#     command will stay relative to the `-C` directory.
+	#
+	#     Without this, the Git command will override the requested
+	#     -C argument and crawl out to the containing Git source tree.
+	#     This would make the test result dependent upon whether we
+	#     were using fsmonitor on our development worktree.
+	#
+	sleep 1 &&
+	mkdir test_implicit_1/.git &&
+
+	test_must_fail git -C test_implicit_1 fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon stop (rename .git)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_2" &&
+
+	git init test_implicit_2 &&
+
+	start_daemon -C test_implicit_2 &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	mv test_implicit_2/.git test_implicit_2/.xxx &&
+
+	# See [1] above.
+	#
+	sleep 1 &&
+	mkdir test_implicit_2/.git &&
+
+	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
+'
+
+test_expect_success 'cannot start multiple daemons' '
+	test_when_finished "stop_daemon_delete_repo test_multiple" &&
+
+	git init test_multiple &&
+
+	start_daemon -C test_multiple &&
+
+	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
+	grep "fsmonitor--daemon is already running" actual &&
+
+	git -C test_multiple fsmonitor--daemon stop &&
+	test_must_fail git -C test_multiple fsmonitor--daemon status
+'
+
+# These tests use the main repo in the trash directory
+
+test_expect_success 'setup' '
+	>tracked &&
+	>modified &&
+	>delete &&
+	>rename &&
+	mkdir dir1 &&
+	>dir1/tracked &&
+	>dir1/modified &&
+	>dir1/delete &&
+	>dir1/rename &&
+	mkdir dir2 &&
+	>dir2/tracked &&
+	>dir2/modified &&
+	>dir2/delete &&
+	>dir2/rename &&
+	mkdir dirtorename &&
+	>dirtorename/a &&
+	>dirtorename/b &&
+
+	cat >.gitignore <<-\EOF &&
+	.gitignore
+	expect*
+	actual*
+	EOF
+
+	git -c core.fsmonitor=false add . &&
+	test_tick &&
+	git -c core.fsmonitor=false commit -m initial &&
+
+	git config core.fsmonitor true
+'
+
+# The test already explicitly stopped (or tried to stop) the daemon.
+# This is here in case something else fails first.
+#
+redundant_stop_daemon () {
+	test_might_fail git fsmonitor--daemon stop
+}
+
+test_expect_success 'update-index implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
+		git update-index --fsmonitor &&
+
+	git fsmonitor--daemon status &&
+	test_might_fail git fsmonitor--daemon stop &&
+
+	# Confirm that the trace2 log contains a record of the
+	# daemon starting.
+	test_subcommand git fsmonitor--daemon start <.git/trace_implicit_1
+'
+
+test_expect_success 'status implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
+		git status >actual &&
+
+	git fsmonitor--daemon status &&
+	test_might_fail git fsmonitor--daemon stop &&
+
+	# Confirm that the trace2 log contains a record of the
+	# daemon starting.
+	test_subcommand git fsmonitor--daemon start <.git/trace_implicit_2
+'
+
+edit_files () {
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	>dir1/untracked
+}
+
+delete_files () {
+	rm -f delete &&
+	rm -f dir1/delete &&
+	rm -f dir2/delete
+}
+
+create_files () {
+	echo 1 >new &&
+	echo 2 >dir1/new &&
+	echo 3 >dir2/new
+}
+
+rename_files () {
+	mv rename renamed &&
+	mv dir1/rename dir1/renamed &&
+	mv dir2/rename dir2/renamed
+}
+
+file_to_directory () {
+	rm -f delete &&
+	mkdir delete &&
+	echo 1 >delete/new
+}
+
+directory_to_file () {
+	rm -rf dir1 &&
+	echo 1 >dir1
+}
+
+# The next few test cases confirm that our fsmonitor daemon sees each type
+# of OS filesystem notification that we care about.  At this layer we just
+# ensure we are getting the OS notifications and do not try to confirm what
+# is reported by `git status`.
+#
+# We run a simple query after modifying the filesystem just to introduce
+# a bit of a delay so that the trace logging from the daemon has time to
+# get flushed to disk.
+#
+# We `reset` and `clean` at the bottom of each test (and before stopping the
+# daemon) because these commands might implicitly restart the daemon.
+
+clean_up_repo_and_stop_daemon () {
+	git reset --hard HEAD &&
+	git clean -fd &&
+	test_might_fail git fsmonitor--daemon stop &&
+	rm -f .git/trace
+}
+
+test_expect_success 'edit some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	edit_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1/modified$"  .git/trace &&
+	grep "^event: dir2/modified$"  .git/trace &&
+	grep "^event: modified$"       .git/trace &&
+	grep "^event: dir1/untracked$" .git/trace
+'
+
+test_expect_success 'create some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	create_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1/new$" .git/trace &&
+	grep "^event: dir2/new$" .git/trace &&
+	grep "^event: new$"      .git/trace
+'
+
+test_expect_success 'delete some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	delete_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1/delete$" .git/trace &&
+	grep "^event: dir2/delete$" .git/trace &&
+	grep "^event: delete$"      .git/trace
+'
+
+test_expect_success 'rename some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	rename_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1/rename$"  .git/trace &&
+	grep "^event: dir2/rename$"  .git/trace &&
+	grep "^event: rename$"       .git/trace &&
+	grep "^event: dir1/renamed$" .git/trace &&
+	grep "^event: dir2/renamed$" .git/trace &&
+	grep "^event: renamed$"      .git/trace
+'
+
+test_expect_success 'rename directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	mv dirtorename dirrenamed &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace
+'
+
+test_expect_success 'file changes to directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	file_to_directory &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: delete$"     .git/trace &&
+	grep "^event: delete/new$" .git/trace
+'
+
+test_expect_success 'directory changes to a file' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	directory_to_file &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1$" .git/trace
+'
+
+# The next few test cases exercise the token-resync code.  When filesystem
+# drops events (because of filesystem velocity or because the daemon isn't
+# polling fast enough), we need to discard the cached data (relative to the
+# current token) and start collecting events under a new token.
+#
+# the 'test-tool fsmonitor-client flush' command can be used to send a
+# "flush" message to a running daemon and ask it to do a flush/resync.
+
+test_expect_success 'flush cached data' '
+	test_when_finished "stop_daemon_delete_repo test_flush" &&
+
+	git init test_flush &&
+
+	start_daemon -C test_flush --tf "$PWD/.git/trace_daemon" --tk true &&
+
+	# The daemon should have an initial token with no events in _0 and
+	# then a few (probably platform-specific number of) events in _1.
+	# These should both have the same <token_id>.
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
+	nul_to_q <actual_0 >actual_q0 &&
+
+	>test_flush/file_1 &&
+	>test_flush/file_2 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
+	nul_to_q <actual_1 >actual_q1 &&
+
+	grep "file_1" actual_q1 &&
+
+	# Force a flush.  This will change the <token_id>, reset the <seq_nr>, and
+	# flush the file data.  Then create some events and ensure that the file
+	# again appears in the cache.  It should have the new <token_id>.
+
+	test-tool -C test_flush fsmonitor-client flush >flush_0 &&
+	nul_to_q <flush_0 >flush_q0 &&
+	grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
+	nul_to_q <actual_2 >actual_q2 &&
+
+	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+
+	>test_flush/file_3 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
+	nul_to_q <actual_3 >actual_q3 &&
+
+	grep "file_3" actual_q3
+'
+
+# The next few test cases create repos where the .git directory is NOT
+# inside the one of the working directory.  That is, where .git is a file
+# that points to a directory elsewhere.  This happens for submodules and
+# non-primary worktrees.
+
+test_expect_success 'setup worktree base' '
+	git init wt-base &&
+	echo 1 >wt-base/file1 &&
+	git -C wt-base add file1 &&
+	git -C wt-base commit -m "c1"
+'
+
+test_expect_success 'worktree with .git file' '
+	git -C wt-base worktree add ../wt-secondary &&
+
+	start_daemon -C wt-secondary \
+		--tf "$PWD/trace_wt_secondary" \
+		--t2 "$PWD/trace2_wt_secondary" &&
+
+	git -C wt-secondary fsmonitor--daemon stop &&
+	test_must_fail git -C wt-secondary fsmonitor--daemon status
+'
+
+# NEEDSWORK: Repeat one of the "edit" tests on wt-secondary and
+# confirm that we get the same events and behavior -- that is, that
+# fsmonitor--daemon correctly watches BOTH the working directory and
+# the external GITDIR directory and behaves the same as when ".git"
+# is a directory inside the working directory.
+
+test_expect_success 'cleanup worktrees' '
+	stop_daemon_delete_repo wt-secondary &&
+	stop_daemon_delete_repo wt-base
+'
+
+test_done
-- 
gitgitgadget

