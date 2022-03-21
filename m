Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37115C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbiCUUga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353393AbiCUUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:36:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971623EF10
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q8so10941178wrc.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FXFnODwAQGM92lVsHZLZ9rNyFqH3iwTVWMY3Uv/MC4c=;
        b=Wd6AMOPoQ4tS5qnXtIodR3R+5V5mXY1gnD2hIihcpvSqf3wBAp5AJcUL6P9A9u+pRW
         Fx+vaAtahxo8qqWuHzEhjHKohuuVdud3fh123zo9wLyKoLS0Mte4npr0+ybBhf/IdwQh
         I8AoBZLs9uxw3bkHZz9DxXpjw7CNAKfnbkaE12oDPK3xyYgTYncTKkczU5QqhtfPjfTZ
         mvIx1e1tHjmSJef9ZkOpcJVXB0QWEkarsg4xUK2u2S1ywHS+T/z9cGT3Kb9sqrrp7OEW
         5QeA8sruKBgal2vgPuNVTPG7Au3zzb7DST1zBNjMdPhA5iZC11rb6A1TDaeeN8khOJW2
         hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FXFnODwAQGM92lVsHZLZ9rNyFqH3iwTVWMY3Uv/MC4c=;
        b=3sZklg3VrogqIIIAB3i2evQaO7w5K6i/qlpWz2nt0LbUx1tH9oBbyWMOwOkgGlfT7v
         qc0ouxNxSG2DZ3c3u3jVts4F2kQxxn/R22HWkiIR0Bb1lyzZ6LTdCUjuNrxHY1qBwwXL
         BZKfRNefNWAVaR2ESpv2MR7ZIpFSAmV6pG1rjOtXCIlmiJSCgGfUWiiw8cZSDe46TSeO
         fFlcOi319MwcCSjodAsovyUGk7B4BfryeOc8mXSpFLB0rFOlYSzNpNVZQ7b985J0i+UV
         vgA6ejCz0d2tp5tdSoRFvJtS1zjwN5IHh3kkMflFjj1mQLgIbn08ZIJfUf9zaoXzppUZ
         As7Q==
X-Gm-Message-State: AOAM530bAbSo1Z9xUZvzoIMWGQa1wrFtqPMhv/r86+sPOHQAFIxcLeS9
        r9NP7l1evfNuarOOQqVAY085sPrHHSA=
X-Google-Smtp-Source: ABdhPJwcNEdiqBfnnGgiWO+sG5Q6Q0O3AHhoArlIMUJxUvJZ3h7uHXtIA+S6oYAZXFUPwuhwnmeMjg==
X-Received: by 2002:a5d:47c1:0:b0:204:1797:2c98 with SMTP id o1-20020a5d47c1000000b0020417972c98mr3967144wrc.502.1647894896074;
        Mon, 21 Mar 2022 13:34:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b00203f51aa12asm9603738wrq.55.2022.03.21.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:34:55 -0700 (PDT)
Message-Id: <dbb63c4caa83cc764535a739d20736b706ee44a5.1647894889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 20:34:49 +0000
Subject: [PATCH 4/4] reset: deprecate '--refresh', leaving only '--no-refresh'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

The explicit '--refresh' option was needed in the past when '--quiet',
'reset.quiet', and/or 'reset.refresh' disabled the index refresh in 'reset
--mixed'. Those options have since either been deprecated or made to always
refresh the index by default, leaving only '--[no-]refresh' determining
whether the index is refreshed or not.

Because there is nothing other than '--no-refresh' to disable index refresh,
we do not need a '--refresh' option to counteract some other refresh
disabling.

To ensure users don't use what is effectively a no-op, remove '--refresh'
from the set of 'reset' options, as well as its usage in 'git stash'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt | 3 +--
 builtin/reset.c             | 6 +++---
 builtin/stash.c             | 4 ++--
 t/t7102-reset.sh            | 5 ++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index df167eaa766..ba8dece0c03 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -107,9 +107,8 @@ OPTIONS
 --quiet::
 	Be quiet, only report errors.
 
---refresh::
 --no-refresh::
-	Proactively refresh the index after a mixed reset. Enabled by default.
+	Disable refreshing the index after a mixed reset.
 
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
diff --git a/builtin/reset.c b/builtin/reset.c
index 54324217f93..d9427abc483 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -392,7 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int refresh = -1;
+	int refresh = 1;
 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
 	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
@@ -400,8 +400,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	int intent_to_add = 0;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
-		OPT_BOOL(0, "refresh", &refresh,
-				N_("skip refreshing the index after reset")),
+		OPT_SET_INT(0, "no-refresh", &refresh,
+				N_("skip refreshing the index after reset"), 0),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						N_("reset HEAD and index"), MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
diff --git a/builtin/stash.c b/builtin/stash.c
index 91407d9bbe0..73f2ba88823 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -310,7 +310,7 @@ static int reset_head(void)
 	 * API for resetting.
 	 */
 	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
+	strvec_pushl(&cp.args, "reset", "--quiet", NULL);
 
 	return run_command(&cp);
 }
@@ -1633,7 +1633,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
+			strvec_pushl(&cp.args, "reset", "-q", "--",
 				     NULL);
 			add_pathspecs(&cp.args, ps);
 			if (run_command(&cp)) {
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 22477f3a312..7a9b845df8c 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -492,9 +492,8 @@ test_expect_success '--mixed refreshes the index' '
 	test_reset_refreshes_index "" --quiet
 '
 
-test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
-	# Verify that --[no-]refresh controls index refresh
-	test_reset_refreshes_index "" --refresh &&
+test_expect_success '--mixed --no-refresh sets refresh behavior' '
+	# Verify that --no-refresh controls index refresh
 	! test_reset_refreshes_index "" --no-refresh
 '
 
-- 
gitgitgadget
