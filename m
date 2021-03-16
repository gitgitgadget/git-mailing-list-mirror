Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE22C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2633664F71
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhCPAyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhCPAyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:54:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B0C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u18so16126329plc.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2AhOuynnxz3rTaWffeciWEZJbuzWh556g87pLPwc1po=;
        b=Ra4tD3kRcenJaBmHG3YoL1SHp5GWfBE8V54PDYFhvs2YGKmCXPKxEsXS7AEPV9i8qy
         8YwL+vTN/O5PvFAdEThEKqzWXUHAC9j/rbmdCAGLT/TBAvIWl0mhCzMpCXe/fhbyOl4/
         Olfsq7YsMuozn9I71zlTADYErxyPk+0gk5zHDndwTvsxN+bUucJ07InnPZD6JRv3XRIB
         1hvHUsAal31PTdDDvmnA6oqTKtUXmy9odayxHgGxJDzm1qwoUS70kE8YXXnlF8ZJQ+AD
         F+W7xa+YOJS/gHWxlpyEzDGS9QjkiA1u8vkj6t0XK9cho/B5Bc6VN71OCLKXi7PaKeE/
         o/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AhOuynnxz3rTaWffeciWEZJbuzWh556g87pLPwc1po=;
        b=a17BZygC8cWvjipJwnoCdHadr2GrZihw9GUVkeyt1S9rXaor8TrYOPSnTh99/1cFaO
         0G0+S7HAjLJ6AgkwqF1D1lUYr6HxdSKKS7nrLSCbcaN/UQeiuu7p+YwtnA6Y2Dd+wUOW
         LIDhLP3fcuwvWilq3Zhybm9LWtEARmmkQXWXzFJOSi0C9wOqDRIgn183Jv+IPCYlrJ6u
         jMyILXgGV4WFWEuM76sHM2bZY6pQOohMz77DvFremJK/rwposeRcsfa+3eJGCyQDX6eR
         7sB2mauFYMr6raHOdhcWGtsVy1VgDwTehKaJTW1VMjQ4liO1cUEYcl9NYZN2wxRiHpv2
         kDgQ==
X-Gm-Message-State: AOAM532iEDDaf3lPhiSlyfowRna2kAmHnM7f+HC7Ig1DmgEiHflvzr00
        6/07fmkfSg4NIzztXTv38ii6qBYUhug=
X-Google-Smtp-Source: ABdhPJx906FRIVO7byzbGIGCpq5OG6q0mIR3Wt0QLdf4wD3fAm5SMEhOJ6zeFkfDpHu0GCYEA3luUw==
X-Received: by 2002:a17:90b:1082:: with SMTP id gj2mr1873351pjb.155.1615856075138;
        Mon, 15 Mar 2021 17:54:35 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id y24sm14449791pfn.213.2021.03.15.17.54.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:54:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] git-completion.bash: fix `git <args>... stash branch` bug
Date:   Mon, 15 Mar 2021 17:54:19 -0700
Message-Id: <be727d0171b16e488a357a959176e60bf9210d40.1615855962.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615855962.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When completions are offered for `git stash branch<TAB>`, the user is
supposed to receive refs. This works in the case where the main git
command is called without arguments but if options are provided, such as
`git -C dir stash branch<TAB>`, then the `$cword -eq 3` provides
incorrect results.

Count the words relative to the first instance of "stash" so that we
ignore arguments to the main git command.

Unfortunately, this still does not work 100% correctly. For example, in
the case of something like `git -C stash stash branch<TAB>`, this will
incorrectly identify the first "stash" as the command. This seems to be
an edge-case that we can ignore, though, as other functions, such as
_git_worktree(), suffer from the same problem.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe79f6b71c..da46f46e3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3016,6 +3016,9 @@ _git_stash ()
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	local stash_idx="$(__git_find_on_cmdline --show-idx stash)"
+	stash_idx="${stash_idx% *}"
+
 	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
 		subcommand="push"
 	fi
@@ -3060,7 +3063,7 @@ _git_stash ()
 	branch,--*)
 		;;
 	branch,*)
-		if [ $cword -eq 3 ]; then
+		if [ $((cword - stash_idx)) -eq 2 ]; then
 			__git_complete_refs
 		else
 			__gitcomp_nl "$(__git stash list \
-- 
2.31.0.rc2.261.g7f71774620

