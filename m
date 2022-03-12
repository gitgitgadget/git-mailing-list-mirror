Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C8C433FE
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiCLAKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCLAKD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:10:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CB2272E9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q14so15240824wrc.4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G8iZRRwMTxy0bYpRI49zaPbtptzDjIEH6Cj3OnBPU5c=;
        b=hgcwO7X1uTY18T0ZqTPTeOG4ota23EnAbOiQTLyP9NUfRQBw/7ZunTIXV9LGcdEyNH
         Ym/hhay2knLB2Kr0zbe6PmjnIG7+mRP1oPWS49CgxTMMJ9m4kZ/Vmyuet+rZJTFAkVWM
         yxXvCkMqOEHF6CsXh4m4W9clvM+QVM87z2VeVVladsUjJ5mGpIZC7AJ73jcFcb4DfAE+
         O+Cnywp0bkhqhNselYZZGoxCuJDIEeOG5Xg1cCmJXGHQeh8y6bAmPFTr0nK7oIiDvQ2D
         m2cmQl5IDo2d/VWomfB8H1x/XzIjY6uXTqY0upzTdiUvRxwvu76jhZyZEruWE0yCkOAc
         1CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G8iZRRwMTxy0bYpRI49zaPbtptzDjIEH6Cj3OnBPU5c=;
        b=bzRheqmNI4d63ZlWKTwFfm56w/bL7BzGNclVkcnM9zrNwbSDFYJUQk3uXNiudthfhF
         WVWLcIu7Z4HVyFdiQJM3oB/M1Y5M+jFcvnZy7xT+8UjeXQVMTN2rPdL35lhzRJL4i7cn
         qJBhWHPnIj64OVMTHkuOVFdMQ7u78GgNpHnJc+YMAleEIgUbkbXech9jwweJA/ajnlAU
         s/p4WWKNghG96qewQYROIz3eVcb1RFZTRcswMLsDg/TRnsnDqx4tbUWQMM28RX6kKuWm
         Wn5AXwlbmgUZTMx7/6WAmP490KccRIgNsiUcxqQ+TNTyGRWOiEmmdxS8PYQmMTenwUbv
         +U2Q==
X-Gm-Message-State: AOAM531Xf2atROWj8xN7/MDHghXHvcXztmxLtkENxw+mrze0EP0PuRvT
        NUyr85faSzvR4V1diJuHV+B/bmy22hg=
X-Google-Smtp-Source: ABdhPJwvKKMYT8YM0NpAG5eE9cw/iQl3lxg0fmil7yKo9P0dE4tnjBfZlyfPttpFwmiGyd6U1+XtcA==
X-Received: by 2002:a5d:588a:0:b0:1f1:e6fb:4e7 with SMTP id n10-20020a5d588a000000b001f1e6fb04e7mr9023531wrf.716.1647043735271;
        Fri, 11 Mar 2022 16:08:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm8121653wrg.62.2022.03.11.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:54 -0800 (PST)
Message-Id: <052499bbc93cb6a60a3b7f7861de78dd4075fd7f.1647043729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 00:08:49 +0000
Subject: [PATCH 5/5] stash: make internal resets quiet and refresh index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the options '-q' and '--refresh' to the 'git reset' executed in
'reset_head()', and '--refresh' to the 'git reset -q' executed in
'do_push_stash(...)'.

'stash' is implemented such that git commands invoked  as part of it (e.g.,
'clean', 'read-tree', 'reset', etc.) have their informational output
silenced. However, the 'reset' in 'reset_head()' is *not* called with '-q',
leading to the potential for a misleading printout from 'git stash apply
--index' if the stash included a removed file:

Unstaged changes after reset: D      <deleted file>

Not only is this confusing in its own right (since, after the reset, 'git
stash' execution would stage the deletion in the index), it would be printed
even when the stash was applied with the '-q' option. As a result, the
messaging is removed entirely by calling 'git status' with '-q'.

Additionally, because the default behavior of 'git reset -q' is to skip
refreshing the index, but later operations in 'git stash' subcommands expect
a non-stale index, enable '--refresh' as well.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c  |  5 ++--
 t/t3903-stash.sh | 12 ++++++++++
 t/t7102-reset.sh | 60 +++++++++++++++++++++++++++++++-----------------
 3 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3e8af210fde..91407d9bbe0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -310,7 +310,7 @@ static int reset_head(void)
 	 * API for resetting.
 	 */
 	cp.git_cmd = 1;
-	strvec_push(&cp.args, "reset");
+	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
 
 	return run_command(&cp);
 }
@@ -1633,7 +1633,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			strvec_pushl(&cp.args, "reset", "-q", "--", NULL);
+			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
+				     NULL);
 			add_pathspecs(&cp.args, ps);
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f36e121210e..17f2ad2344c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -261,6 +261,18 @@ test_expect_success 'apply -q is quiet' '
 	test_must_be_empty output.out
 '
 
+test_expect_success 'apply --index -q is quiet' '
+	# Added file, deleted file, modified file all staged for commit
+	echo foo >new-file &&
+	echo test >file &&
+	git add new-file file &&
+	git rm other-file &&
+
+	git stash &&
+	git stash apply --index -q >output.out 2>&1 &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'save -q is quiet' '
 	git stash save --quiet >output.out 2>&1 &&
 	test_must_be_empty output.out
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 5e68180f3b2..f2076545133 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -482,7 +482,7 @@ test_index_refreshed () {
 	git rm --cached file2 &&
 
 	# Step 2
-	git reset $1 --mixed HEAD &&
+	git reset $@ --mixed HEAD &&
 
 	# Step 3
 	git read-tree -m HEAD~1
@@ -491,48 +491,66 @@ test_index_refreshed () {
 test_expect_success '--mixed refreshes the index' '
 	# Verify default behavior (with no config settings or command line
 	# options)
-	test_index_refreshed &&
+	test_index_refreshed
 '
 test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
 	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
 	# determine refresh behavior
 
-	# Config setting
-	test_must_fail test_index_refreshed -c reset.quiet=true &&
-	test_index_refreshed -c reset.quiet=true &&
-
 	# Command line option
-	test_must_fail test_index_refreshed --quiet &&
+	! test_index_refreshed --quiet &&
 	test_index_refreshed --no-quiet &&
 
-	# Command line option overrides config setting
-	test_must_fail test_index_refreshed -c reset.quiet=false --quiet &&
-	test_index_refreshed -c reset.refresh=true --no-quiet
+	# Config: reset.quiet=false
+	test_config reset.quiet false &&
+	(
+		test_index_refreshed &&
+		! test_index_refreshed --quiet
+	) &&
+
+	# Config: reset.quiet=true
+	test_config reset.quiet true &&
+	(
+		! test_index_refreshed &&
+		test_index_refreshed --no-quiet
+	)
 '
 
 test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
 	# Verify that --[no-]refresh and `reset.refresh` control index refresh
 
-	# Config setting
-	test_index_refreshed -c reset.refresh=true &&
-	test_must_fail test_index_refreshed -c reset.refresh=false &&
-
 	# Command line option
 	test_index_refreshed --refresh &&
-	test_must_fail test_index_refreshed --no-refresh &&
+	! test_index_refreshed --no-refresh &&
+
+	# Config: reset.refresh=false
+	test_config reset.refresh false &&
+	(
+		! test_index_refreshed &&
+		test_index_refreshed --refresh
+	) &&
 
-	# Command line option overrides config setting
-	test_index_refreshed -c reset.refresh=false --refresh &&
-	test_must_fail test_index_refreshed -c reset.refresh=true --no-refresh
+	# Config: reset.refresh=true
+	test_config reset.refresh true &&
+	(
+		test_index_refreshed &&
+		! test_index_refreshed --no-refresh
+	)
 '
 
 test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
 	# Verify that *both* --refresh and `reset.refresh` override the
 	# default non-refresh behavior of --quiet
+
 	test_index_refreshed --refresh --quiet &&
-	test_index_refreshed --refresh -c reset.quiet=true &&
-	test_index_refreshed -c reset.refresh=true --quiet &&
-	test_index_refreshed -c reset.refresh=true -c reset.quiet=true
+
+	# Config: reset.quiet=true
+	test_config reset.quiet true &&
+	test_index_refreshed --refresh &&
+
+	# Config: reset.quiet=true, reset.refresh=true
+	test_config reset.refresh true &&
+	test_index_refreshed
 '
 
 test_expect_success '--mixed preserves skip-worktree' '
-- 
gitgitgadget
