Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBBCC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiG2WIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2WIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:08:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1B8BABC
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:08:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso3039661wms.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O0GU26LmL11MGuGqYTVbZWLu1VyGLOc0kf89iY2qhlY=;
        b=d0FLeYtCAYOhFB5G3MQA1p28lp4pEXU9RU1BKyeKEt3b4lpRt3LmNv8V2IWwaT6Rkr
         BkmuzDjrtLH7itW0Y2VwEsuCb83MXSUxtoP3li94NyfF9TAWLdIUnMcqUTytjyf2+a9l
         TNy/OQ/GL//WdaVPuag8D06d3IEpbt0hRu2tKNGTtjIsrvwfeayuL3CqKyo99PrFT+My
         x3qeuW0uDgKx5SR5Zg8Dn0WO2E3mKc1shccRBe93b5uC/jgSe2CeHxfGfF1AghfhN8/3
         HLXPgNJQ30gjW39H7VdIAnqR/Vx66zgdve7XlzJvU1O4B8C12hG9PPrzDOpxPlxDm88t
         dMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O0GU26LmL11MGuGqYTVbZWLu1VyGLOc0kf89iY2qhlY=;
        b=BCKVNcVmZSlhZLkDqUCVg180ZN9vMgtSvuahc3958yHhcYSqjTxAF6/kOEiz/kjTY/
         DVsvQzevcizP/aEoGvhRyimaMBiKrYc74fnEQJuinY1csdJoXkYqaXCglPzI9Dww2BC6
         n/J1IgU7CCqVajyfXozNYcfrLKPg/OhvmI8Di4yS8NSDYyPdxFr4ueTSk6kX1NuQ7rRZ
         7yJA32MBNaxf4wXIiXDHYeFLtnRjRUer+RvnP1sA2RBASRsdaCFefiZagZLncMg53dar
         l6Pw+kaLUDN9xVh++g6Gm0L9IhFDpIqO8gRwsrIGn6sJ+lDOlTgjWc+UDahxQ9TONnlh
         OEMg==
X-Gm-Message-State: AJIora8bgtU1RPQb3zmMBTlsj10xuG5dXfBXmf/holgyTzyxcgh1mXFz
        Hs1n/R9KdCT8w5F57dhVCPvbaS14LcE=
X-Google-Smtp-Source: AGRyM1viiq56lL3xvRoPMM74UOe1f3hG4SYZlBbRA03DgvECWcM7pjsba8z5gCDNB4ibW7FNDnkBpQ==
X-Received: by 2002:a7b:cbce:0:b0:3a3:2d78:f066 with SMTP id n14-20020a7bcbce000000b003a32d78f066mr3843152wmi.66.1659132520175;
        Fri, 29 Jul 2022 15:08:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r126-20020a1c2b84000000b003a2fde6ef62sm5644273wmr.7.2022.07.29.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:08:39 -0700 (PDT)
Message-Id: <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
In-Reply-To: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 22:08:38 +0000
Subject: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

If GIT_PS1_SHOWCONFLICTSTATE is set to "yes", show the word "CONFLICT"
on the command prompt when there are unresolved conflicts.

Example prompt: (main|CONFLICT)

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
    Show 'CONFLICT' indicator at command prompt
    
    This patch adds functionality for bash/zsh to show "CONFLICT" on the
    prompt in cases where there are unresolved conflicts. The feature is
    only enabled after setting an environment variable.
    
    The conflict state is determined by running git ls-files --unmerged. In
    my testing, the performance was very good. It took around 0.01 seconds
    to run git ls-files --unmerged regardless of the number of conflicts, or
    their depth, even on very large projects (Linux kernel). However, if
    anybody has any concerns with this, I'm open to other options.
    
    Any tests that were impacted (with the conflict prompt feature enabled)
    were duplicated. The original test was left as-is (no changes, and
    conflict prompt feature disabled). The new version of each test enables
    the conflict prompt feature and confirms the prompt includes
    "|CONFLICT".
    
    ------------------------------------------------------------------------
    
    Changes since v1:
    
     * This feature is now disabled by default.
     * Created new tests for conflict state (instead of modifying existing
       tests).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1302%2Fjustinrdonnelly%2Fconflict-indicator-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1302/justinrdonnelly/conflict-indicator-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1302

Range-diff vs v1:

 1:  e380826dcaf ! 1:  7154d695426 git-prompt: show 'CONFLICT' indicator at command prompt
     @@ Metadata
      Author: Justin Donnelly <justinrdonnelly@gmail.com>
      
       ## Commit message ##
     -    git-prompt: show 'CONFLICT' indicator at command prompt
     +    git-prompt: show presence of unresolved conflicts at command prompt
      
     -    When there are unresolved conflicts, show the word 'CONFLICT' on the
     -    command prompt. Similar to other state indicators, this provides
     -    information to the user about the current state of the repository.
     +    If GIT_PS1_SHOWCONFLICTSTATE is set to "yes", show the word "CONFLICT"
     +    on the command prompt when there are unresolved conflicts.
      
          Example prompt: (main|CONFLICT)
      
     @@ contrib/completion/git-prompt.sh
       # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
       # by setting GIT_PS1_OMITSPARSESTATE.
       #
     -+# When there is a conflict, the prompt will include "|CONFLICT". This can
     -+# be omitted by setting GIT_PS1_OMITCONFLICTSTATE.
     ++# If you would like to see a notification on the prompt when there are
     ++# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
     ++# prompt will include "|CONFLICT".
      +#
       # If you would like to see more information about the identity of
       # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
     @@ contrib/completion/git-prompt.sh: __git_ps1 ()
       	fi
       
      +	local conflict="" # state indicator for unresolved conflicts
     -+	if [[ -z "${GIT_PS1_OMITCONFLICTSTATE-}" ]] &&
     ++	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
      +	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
      +		conflict="|CONFLICT"
      +	fi
     @@ contrib/completion/git-prompt.sh: __git_ps1 ()
       		if [ "${__git_printf_supports_v-}" != yes ]; then
      
       ## t/t9903-bash-prompt.sh ##
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - interactive rebase' '
     - '
     - 
     - test_expect_success 'prompt - rebase merge' '
     --	printf " (b2|REBASE 1/3)" >expected &&
     -+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
     - 	git checkout b2 &&
     +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase merge' '
       	test_when_finished "git checkout main" &&
       	test_must_fail git rebase --merge b1 b2 &&
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase merge' '
     + 	test_when_finished "git rebase --abort" &&
     +-	__git_ps1 >"$actual" &&
     ++	(
     ++		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     ++	test_cmp expected "$actual"
     ++'
     ++
     ++test_expect_success 'prompt - rebase merge conflict' '
     ++	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
     ++	git checkout b2 &&
     ++	test_when_finished "git checkout main" &&
     ++	test_must_fail git rebase --merge b1 b2 &&
     ++	test_when_finished "git rebase --abort" &&
     ++	(
     ++		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     + 	test_cmp expected "$actual"
       '
       
     - test_expect_success 'prompt - rebase am' '
     --	printf " (b2|REBASE 1/3)" >expected &&
     -+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
     - 	git checkout b2 &&
     +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase am' '
       	test_when_finished "git checkout main" &&
       	test_must_fail git rebase --apply b1 b2 &&
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase am' '
     + 	test_when_finished "git rebase --abort" &&
     +-	__git_ps1 >"$actual" &&
     ++	(
     ++		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     ++	test_cmp expected "$actual"
     ++'
     ++
     ++test_expect_success 'prompt - rebase am conflict' '
     ++	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
     ++	git checkout b2 &&
     ++	test_when_finished "git checkout main" &&
     ++	test_must_fail git rebase --apply b1 b2 &&
     ++	test_when_finished "git rebase --abort" &&
     ++	(
     ++		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     + 	test_cmp expected "$actual"
       '
       
     - test_expect_success 'prompt - merge' '
     --	printf " (b1|MERGING)" >expected &&
     -+	printf " (b1|MERGING|CONFLICT)" >expected &&
     - 	git checkout b1 &&
     +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - merge' '
       	test_when_finished "git checkout main" &&
       	test_must_fail git merge b2 &&
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - merge' '
     + 	test_when_finished "git reset --hard" &&
     +-	__git_ps1 >"$actual" &&
     ++	(
     ++		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     ++	test_cmp expected "$actual"
     ++'
     ++
     ++test_expect_success 'prompt - merge conflict' '
     ++	printf " (b1|MERGING|CONFLICT)" >expected &&
     ++	git checkout b1 &&
     ++	test_when_finished "git checkout main" &&
     ++	test_must_fail git merge b2 &&
     ++	test_when_finished "git reset --hard" &&
     ++	(
     ++		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     + 	test_cmp expected "$actual"
       '
       
     - test_expect_success 'prompt - cherry-pick' '
     --	printf " (main|CHERRY-PICKING)" >expected &&
     -+	printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
     +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pick' '
     + 	printf " (main|CHERRY-PICKING)" >expected &&
       	test_must_fail git cherry-pick b1 b1^ &&
       	test_when_finished "git cherry-pick --abort" &&
     - 	__git_ps1 >"$actual" &&
     +-	__git_ps1 >"$actual" &&
     ++	(
     ++		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     ++		__git_ps1 >"$actual"
     ++	) &&
       	test_cmp expected "$actual" &&
     -+	printf " (main|CHERRY-PICKING)" >expected &&
       	git reset --merge &&
       	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
     - 	__git_ps1 >"$actual" &&
     +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pick' '
     + 	test_cmp expected "$actual"
     + '
     + 
     ++test_expect_success 'prompt - cherry-pick conflict' '
     ++	printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
     ++	test_must_fail git cherry-pick b1 b1^ &&
     ++	test_when_finished "git cherry-pick --abort" &&
     ++	(
     ++		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     ++		__git_ps1 >"$actual"
     ++	) &&
     ++	test_cmp expected "$actual"
     ++'
     ++
     + test_expect_success 'prompt - revert' '
     + 	printf " (main|REVERTING)" >expected &&
     + 	test_must_fail git revert b1^ b1 &&


 contrib/completion/git-prompt.sh | 12 +++++-
 t/t9903-bash-prompt.sh           | 70 ++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1435548e004..57972c2845c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -84,6 +84,10 @@
 # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
 # by setting GIT_PS1_OMITSPARSESTATE.
 #
+# If you would like to see a notification on the prompt when there are
+# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
+# prompt will include "|CONFLICT".
+#
 # If you would like to see more information about the identity of
 # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
 # to one of these values:
@@ -508,6 +512,12 @@ __git_ps1 ()
 		r="$r $step/$total"
 	fi
 
+	local conflict="" # state indicator for unresolved conflicts
+	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
+	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
+		conflict="|CONFLICT"
+	fi
+
 	local w=""
 	local i=""
 	local s=""
@@ -572,7 +582,7 @@ __git_ps1 ()
 	fi
 
 	local f="$h$w$i$s$u$p"
-	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a30f5719c3..47eb98893ef 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -188,7 +188,23 @@ test_expect_success 'prompt - rebase merge' '
 	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --merge b1 b2 &&
 	test_when_finished "git rebase --abort" &&
-	__git_ps1 >"$actual" &&
+	(
+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - rebase merge conflict' '
+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout main" &&
+	test_must_fail git rebase --merge b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	(
+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
+		__git_ps1 >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
 
@@ -198,7 +214,23 @@ test_expect_success 'prompt - rebase am' '
 	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --apply b1 b2 &&
 	test_when_finished "git rebase --abort" &&
-	__git_ps1 >"$actual" &&
+	(
+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - rebase am conflict' '
+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout main" &&
+	test_must_fail git rebase --apply b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	(
+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
+		__git_ps1 >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
 
@@ -208,7 +240,23 @@ test_expect_success 'prompt - merge' '
 	test_when_finished "git checkout main" &&
 	test_must_fail git merge b2 &&
 	test_when_finished "git reset --hard" &&
-	__git_ps1 >"$actual" &&
+	(
+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - merge conflict' '
+	printf " (b1|MERGING|CONFLICT)" >expected &&
+	git checkout b1 &&
+	test_when_finished "git checkout main" &&
+	test_must_fail git merge b2 &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
+		__git_ps1 >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
 
@@ -216,7 +264,10 @@ test_expect_success 'prompt - cherry-pick' '
 	printf " (main|CHERRY-PICKING)" >expected &&
 	test_must_fail git cherry-pick b1 b1^ &&
 	test_when_finished "git cherry-pick --abort" &&
-	__git_ps1 >"$actual" &&
+	(
+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
+		__git_ps1 >"$actual"
+	) &&
 	test_cmp expected "$actual" &&
 	git reset --merge &&
 	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
@@ -224,6 +275,17 @@ test_expect_success 'prompt - cherry-pick' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - cherry-pick conflict' '
+	printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
+	test_must_fail git cherry-pick b1 b1^ &&
+	test_when_finished "git cherry-pick --abort" &&
+	(
+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - revert' '
 	printf " (main|REVERTING)" >expected &&
 	test_must_fail git revert b1^ b1 &&

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
