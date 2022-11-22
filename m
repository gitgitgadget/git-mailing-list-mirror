Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DCC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiKVWHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiKVWHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:07:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E46EC72DE
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:07:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 189-20020a1c02c6000000b003d02dd48c45so148501wmc.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZk+8dbzaujFXT7tXvEhDfg2AtKnuIDmiYQv2Xco8BI=;
        b=QyjJd9IRqXIx8Ucd6kjyekOzOzf9+ZdaGhqjru3nBsJNr/vk93lEPa/9uPN21YXbBI
         Df1QX2jTtOW4LY3NgLMCnQrUkTYvHfoM5KELu2Pxts2LegXtRskZW69+/JoBhlSVAHDt
         gpIqd3rPvkb2TwkVSd2vFi8hUWFSwwuOOUUPKDNWlPMGBBEGyYZNXsiKiHOc/rPzxYfk
         hEd14Hcsqc48kmWqSYc4+DuElqtLODogqq4l2KZxO1LBMTSe/BLzBtVRHIYEMinN+qrp
         tDXKd0zoiJ8Wiye9Cg4xUNSQ0bDm/4v4tU9GneYbxuaYnnp4oDpt8xmyhh/ggnDUBg9O
         EBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZk+8dbzaujFXT7tXvEhDfg2AtKnuIDmiYQv2Xco8BI=;
        b=jwjdbmuUZk2PphmjKAxKQhISoYrCd4Hl4QfF+V5uX1WSOj3CHf3Mb2ftikT6y9AWPN
         rwvNp39qtHq4BFPouUflsU6tdJC3Ij1F4pnjolsDgDtaJ4hhgkUcRaSQ5IDcN1derNo9
         x0gmFuFGOLrsIForHqoFySzVQCDz0k2zjtr0WrR7o5oN8ivNcvch/yY5iUgy7L1Gj8Pu
         ntK0LOMoRe66zype152+mSeHG2I7UZF1txhlQmurkQvxJqnOQd9ZNb0ken1qlJDoGxfP
         3OZVhC7UsabvN9OpNDB+u4HiHy7k7Tl/5D0CXn7g4EYjQZOJ+oO0PiXsL2Wvp8uJ/fu0
         YTEg==
X-Gm-Message-State: ANoB5pnvTAHdVZyYB13YUnsa5L1kw1ed0Dbhg6Bgug+z2m25cdVoW/c7
        LWqi4Eyq1wZZnJOnLyMyt7pdB3M+t5A=
X-Google-Smtp-Source: AA0mqf4oMK52e04AMUQ1WGRdDDjQ+3blOF6cIghKnzQxAGsImlUPWeV/WGy95f6o0VXkwVzyoqlVZg==
X-Received: by 2002:a05:600c:34d3:b0:3cf:a7a8:b712 with SMTP id d19-20020a05600c34d300b003cfa7a8b712mr4331973wmq.124.1669154824536;
        Tue, 22 Nov 2022 14:07:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b002366dd0e030sm15004754wru.68.2022.11.22.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:07:04 -0800 (PST)
Message-Id: <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com>
References: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 22:07:02 +0000
Subject: [PATCH v8] status: modernize git-status "slow untracked files" advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Rudy Rigot <rudy.rigot@gmail.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rudy Rigot <rudy.rigot@gmail.com>

`git status` can be slow when there are a large number of
untracked files and directories since Git must search the entire
worktree to enumerate them.  When it is too slow, Git prints
advice with the elapsed search time and a suggestion to disable
the search using the `-uno` option.  This suggestion also carries
a warning that might scare off some users.

However, these days, `-uno` isn't the only option.  Git can reduce
the size and time of the untracked file search when the
`core.untrackedCache` and `core.fsmonitor` features are enabled by
caching results from previous `git status` invocations.

Therefore, update the `git status` man page to explain the various
configuration options, and update the advice to provide more
detail about the current configuration and to refer to the updated
documentation.

Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
---
    status: modernize git-status "slow untracked files" advice
    
    Here is version 8 for this patch.
    
    Changes since v7:
    
     * Moved tests from new test script to existing one, in order not to
       needlessly waste a test script number for such a small feature. Two
       caveats:
       * The use of test_config in a subshell result in: 'error: bug in the
         test script: test_when_finished does nothing in a subshell', so
         I've had to resort to using plain old git config instead.
       * A test higher in the script is doing git config --global
         advice.statusuoption false, so I now have to set it locally in my
         isolated test repo.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v7:

 1:  871a9becbdf ! 1:  16e3721515b status: modernize git-status "slow untracked files" advice
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
       --------
       linkgit:gitignore[5]
      
     - ## t/t7065-wtstatus-slow.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='test status when slow untracked files'
     -+
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+GIT_TEST_UF_DELAY_WARNING=1
     -+export GIT_TEST_UF_DELAY_WARNING
     -+
     -+. ./test-lib.sh
     -+
     -+test_expect_success setup '
     -+	cat >.gitignore <<-\EOF &&
     -+	/actual
     -+	/expected
     -+	/out
     -+	EOF
     -+	git add .gitignore &&
     -+	git commit -m "Add .gitignore"
     + ## t/t7508-status.sh ##
     +@@ t/t7508-status.sh: test_expect_success 'racy timestamps will be fixed for dirty worktree' '
     + 	! test_is_magic_mtime .git/index
     + '
     + 
     ++test_expect_success 'setup slow status advice' '
     ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main git init slowstatus &&
     ++	(
     ++		cd slowstatus &&
     ++		cat >.gitignore <<-\EOF &&
     ++		/actual
     ++		/expected
     ++		/out
     ++		EOF
     ++		git add .gitignore &&
     ++		git commit -m "Add .gitignore" &&
     ++		git config advice.statusuoption true
     ++	)
      +'
      +
     -+test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
     -+	test_unconfig core.untrackedCache &&
     -+	test_unconfig core.fsmonitor &&
     -+	git status >out &&
     -+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     -+	cat >expected <<-\EOF &&
     -+	On branch main
     -+
     -+	It took X seconds to enumerate untracked files.
     -+	See '"'"'git help status'"'"' for information on how to improve this.
     -+
     -+	nothing to commit, working tree clean
     -+	EOF
     -+	test_cmp expected actual
     ++test_expect_success 'slow status advice when core.untrackedCache and fsmonitor are unset' '
     ++	(
     ++		cd slowstatus &&
     ++		git config core.untrackedCache false &&
     ++		git config core.fsmonitor false &&
     ++		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
     ++		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     ++		cat >expected <<-\EOF &&
     ++		On branch main
     ++
     ++		It took X seconds to enumerate untracked files.
     ++		See '"'"'git help status'"'"' for information on how to improve this.
     ++
     ++		nothing to commit, working tree clean
     ++		EOF
     ++		test_cmp expected actual
     ++	)
      +'
      +
     -+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
     -+	test_config core.untrackedCache true &&
     -+	test_unconfig core.fsmonitor &&
     -+	git status >out &&
     -+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     -+	cat >expected <<-\EOF &&
     -+	On branch main
     -+
     -+	It took X seconds to enumerate untracked files.
     -+	See '"'"'git help status'"'"' for information on how to improve this.
     -+
     -+	nothing to commit, working tree clean
     -+	EOF
     -+	test_cmp expected actual
     ++test_expect_success 'slow status advice when core.untrackedCache true, but not fsmonitor' '
     ++	(
     ++		cd slowstatus &&
     ++		git config core.untrackedCache true &&
     ++		git config core.fsmonitor false &&
     ++		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
     ++		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     ++		cat >expected <<-\EOF &&
     ++		On branch main
     ++
     ++		It took X seconds to enumerate untracked files.
     ++		See '"'"'git help status'"'"' for information on how to improve this.
     ++
     ++		nothing to commit, working tree clean
     ++		EOF
     ++		test_cmp expected actual
     ++	)
      +'
      +
     -+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
     -+	test_config core.untrackedCache true &&
     -+	test_config core.fsmonitor true &&
     -+	git status >out &&
     -+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     -+	cat >expected <<-\EOF &&
     -+	On branch main
     -+
     -+	It took X seconds to enumerate untracked files,
     -+	but the results were cached, and subsequent runs may be faster.
     -+	See '"'"'git help status'"'"' for information on how to improve this.
     -+
     -+	nothing to commit, working tree clean
     -+	EOF
     -+	test_cmp expected actual
     ++test_expect_success 'slow status advice when core.untrackedCache true, and fsmonitor' '
     ++	(
     ++		cd slowstatus &&
     ++		git config core.untrackedCache true &&
     ++		git config core.fsmonitor true &&
     ++		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
     ++		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     ++		cat >expected <<-\EOF &&
     ++		On branch main
     ++
     ++		It took X seconds to enumerate untracked files,
     ++		but the results were cached, and subsequent runs may be faster.
     ++		See '"'"'git help status'"'"' for information on how to improve this.
     ++
     ++		nothing to commit, working tree clean
     ++		EOF
     ++		test_cmp expected actual
     ++	)
      +'
      +
     -+test_done
     + test_done
      
       ## wt-status.c ##
      @@


 Documentation/git-status.txt | 59 +++++++++++++++++++++++++++++
 t/t7508-status.sh            | 73 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 28 +++++++++++---
 3 files changed, 155 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 5e438a7fdc1..570c36e07c1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -457,6 +457,65 @@ during the write may conflict with other simultaneous processes, causing
 them to fail. Scripts running `status` in the background should consider
 using `git --no-optional-locks status` (see linkgit:git[1] for details).
 
+UNTRACKED FILES AND STATUS SPEED
+--------------------------------
+
+`git status` can be very slow in large worktrees if/when it
+needs to search for untracked files and directories. There are
+many configuration options available to speed this up by either
+avoiding the work or making use of cached results from previous
+Git commands. There is no single optimum set of settings right
+for everyone.  Here is a brief summary of the relevant options
+to help you choose which is right for you.
+
+* First, you may want to run `git status` again. Your current
+	configuration may already be caching `git status` results,
+	so it could be faster on subsequent runs.
+
+* The `--untracked-files=no` flag or the
+	`status.showUntrackedfiles=false` config (see above for both) :
+	indicate that `git status` should not report untracked
+	files. This is the fastest option. `git status` will not list
+	the untracked files, so you need to be careful to remember if
+	you create any new files and manually `git add` them.
+
+* `advice.statusUoption=false` (see linkgit:git-config[1]) :
+	this config option disables a warning message when the search
+	for untracked files takes longer than desired. In some large
+	repositories, this message may appear frequently and not be a
+	helpful signal.
+
+* `core.untrackedCache=true` (see linkgit:git-update-index[1]) :
+	enable the untracked cache feature and only search directories
+	that have been modified since the previous `git status` command.
+	Git remembers the set of untracked files within each directory
+	and assumes that if a directory has not been modified, then
+	the set of untracked files within has not changed.  This is much
+	faster than enumerating the contents of every directory, but still
+	not without cost, because Git still has to search for the set of
+	modified directories. The untracked cache is stored in the
+	`.git/index` file. The reduced cost of searching for untracked
+	files is offset slightly by the increased size of the index and
+	the cost of keeping it up-to-date. That reduced search time is
+	usually worth the additional size.
+
+* `core.untrackedCache=true` and `core.fsmonitor=true` or
+	`core.fsmonitor=<hook_command_pathname>` (see
+	linkgit:git-update-index[1]) : enable both the untracked cache
+	and FSMonitor features and only search directories that have
+	been modified since the previous `git status` command.  This
+	is faster than using just the untracked cache alone because
+	Git can also avoid searching for modified directories.  Git
+	only has to enumerate the exact set of directories that have
+	changed recently. While the FSMonitor feature can be enabled
+	without the untracked cache, the benefits are greatly reduced
+	in that case.
+
+Note that after you turn on the untracked cache and/or FSMonitor
+features it may take a few `git status` commands for the various
+caches to warm up before you see improved command times.  This is
+normal.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 2b7ef6c41a4..02d641f0413 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1676,4 +1676,77 @@ test_expect_success 'racy timestamps will be fixed for dirty worktree' '
 	! test_is_magic_mtime .git/index
 '
 
+test_expect_success 'setup slow status advice' '
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main git init slowstatus &&
+	(
+		cd slowstatus &&
+		cat >.gitignore <<-\EOF &&
+		/actual
+		/expected
+		/out
+		EOF
+		git add .gitignore &&
+		git commit -m "Add .gitignore" &&
+		git config advice.statusuoption true
+	)
+'
+
+test_expect_success 'slow status advice when core.untrackedCache and fsmonitor are unset' '
+	(
+		cd slowstatus &&
+		git config core.untrackedCache false &&
+		git config core.fsmonitor false &&
+		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
+		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+		cat >expected <<-\EOF &&
+		On branch main
+
+		It took X seconds to enumerate untracked files.
+		See '"'"'git help status'"'"' for information on how to improve this.
+
+		nothing to commit, working tree clean
+		EOF
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'slow status advice when core.untrackedCache true, but not fsmonitor' '
+	(
+		cd slowstatus &&
+		git config core.untrackedCache true &&
+		git config core.fsmonitor false &&
+		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
+		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+		cat >expected <<-\EOF &&
+		On branch main
+
+		It took X seconds to enumerate untracked files.
+		See '"'"'git help status'"'"' for information on how to improve this.
+
+		nothing to commit, working tree clean
+		EOF
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'slow status advice when core.untrackedCache true, and fsmonitor' '
+	(
+		cd slowstatus &&
+		git config core.untrackedCache true &&
+		git config core.fsmonitor true &&
+		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
+		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+		cat >expected <<-\EOF &&
+		On branch main
+
+		It took X seconds to enumerate untracked files,
+		but the results were cached, and subsequent runs may be faster.
+		See '"'"'git help status'"'"' for information on how to improve this.
+
+		nothing to commit, working tree clean
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..1f6d64e759f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,8 +18,10 @@
 #include "worktree.h"
 #include "lockfile.h"
 #include "sequencer.h"
+#include "fsmonitor-settings.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
+#define UF_DELAY_WARNING_IN_MS (2 * 1000)
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1205,6 +1207,13 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
+static int uf_was_slow(uint32_t untracked_in_ms)
+{
+	if (getenv("GIT_TEST_UF_DELAY_WARNING"))
+		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
+	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
+}
+
 static void show_merge_in_progress(struct wt_status *s,
 				   const char *color)
 {
@@ -1814,6 +1823,7 @@ static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
@@ -1870,13 +1880,21 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
+		if (advice_enabled(ADVICE_STATUS_U_OPTION) && uf_was_slow(s->untracked_in_ms)) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+			if (fsm_mode > FSMONITOR_MODE_DISABLED) {
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took %.2f seconds to enumerate untracked files,\n"
+						"but the results were cached, and subsequent runs may be faster."),
+						s->untracked_in_ms / 1000.0);
+			} else {
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took %.2f seconds to enumerate untracked files."),
+						s->untracked_in_ms / 1000.0);
+			}
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-					   "may speed it up, but you have to be careful not to forget to add\n"
-					   "new files yourself (see 'git help status')."),
-					 s->untracked_in_ms / 1000.0);
+					_("See 'git help status' for information on how to improve this."));
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 		}
 	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
