Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78579C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 19:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJOTzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJOTzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 15:55:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB2322B03
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 12:54:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id iv17so5631846wmb.4
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VJimzqNY9KtS/xTMuZGE5tHoFhcCQiyJk7d7ZSTpQc8=;
        b=fJi6ekcaeGk5SMgmsCpOSbRgwt0dzp+Flc08Bkoeqyh5PzhP0w5F8ZNy6SxoKvrya3
         4jss9Lf5HQ+haeekQeKPls4PMHuY30nsjBQIezI6wjPdwW9CkwRaeWT88slEK+73L1lX
         SeUR7d9OqOZmJFvJVxS0bVWC3bZaMX9Tj0M+QNDfZdCrT2kZDnjGQyzMU6YpeDW7OjWA
         iWCv86mYVPQM1kIuiORr+V+/4am6YArc2b9JWvqY+IX2K1Thx9HW526TwHwlLdsX+3i1
         I5lTe1M4bMq7EbxSgQm5shjhu3693yEa9Ouh8HsYm645N5pgepQ9CFBD8wZcYIcCIBux
         Rq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJimzqNY9KtS/xTMuZGE5tHoFhcCQiyJk7d7ZSTpQc8=;
        b=sQqQ4Dnqy6PIJJe0l7nMMGnPNEMb3aWuMzcPH92zzK6oS3bplyLg9BE8LvS82Aa4a8
         njqxFDq510pDTekUn5YsOKrGaD48hfPTXyH/zBSDBtvioWw0T3ro9rrBGDJ4zCrO0lbU
         io8ETixS1m3zFJAmd4m7L9G0KQxjH2OQOlOUQF9ek81/Dh4KCkL/gTEu/oBr1Y+vAWJu
         05pvpCOgw7DrPYGEQo+c337ILYBp8VZsBnJPYoFTu7h9lBOS53eWD5PxORmspE692M3w
         XbS+YUQHbCxOOkkJnvJPPQNrXppQe5l7TgFPMe+CxQ0k4WsB0Eob6vl2N634JeMrEAex
         ZI8Q==
X-Gm-Message-State: ACrzQf2OLv7i23d/Y40uX/d3NRVXWmdki4Px+Sprs0u+hSQtri0iaMz+
        WqX3tle/WiQjjPPN5Dj2GeuR8GhoSRg=
X-Google-Smtp-Source: AMsMyM4Iz83gCpOo3o77g4OQRctEftZWbJdURtQNrNh8tZbWdiWB9gaBbUDEX0apzX1O1XISeltKXA==
X-Received: by 2002:a05:600c:4f56:b0:3b4:b6b0:42d4 with SMTP id m22-20020a05600c4f5600b003b4b6b042d4mr2476931wmq.143.1665863697392;
        Sat, 15 Oct 2022 12:54:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b003c6b70a4d69sm5783938wms.42.2022.10.15.12.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 12:54:56 -0700 (PDT)
Message-Id: <pull.1365.git.git.1665863696303.gitgitgadget@gmail.com>
From:   "Bob van der Linden via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Oct 2022 19:54:55 +0000
Subject: [PATCH] completion: support amend and reword in git commit fixup
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bob van der Linden <bobvanderlinden@gmail.com>,
        Bob van der Linden <bobvanderlinden@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bob van der Linden <bobvanderlinden@gmail.com>

The option `git commit --fixup=` has the ability to create amend and
reword commits, by specifying `--fixup=amend:REF` and
`--fixup=reword:REF`.

This patch allows completion of amend: and reword: prefixes when a user
has already typed the --fixup= option.

In addition, this patch fixes completion of refs that can be
filled in after the amend: and reword: prefixes. Previously `amend:` and
`reword:` were considered part of the ref to complete, which always
resulted in 0 potential completions.

Signed-off-by: Bob van der Linden <bobvanderlinden@gmail.com>
---
    completion: support amend and reword in git commit fixup option
    
    I'd like to use git commit --fixup= more in my day-to-day work. However,
    it dawned on me that the options --fixup=amend: and --fixup=reword: were
    not supported by bash completion.
    
    I attempted to solve this by first adding amend: and reword: to the
    completions of --fixup=. In addition, I made sure that --fixup=amend:ref
    does not consider amend: to be part of the reference, thus allowing
    completion of references when --fixup=amend: and --fixup=reword: are
    used.
    
    The patch also includes completion tests for --fixup=, --fixup=amend:
    and --fixup=reword:.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1365%2Fbobvanderlinden%2Fpr-fixup-amend-reword-completion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1365/bobvanderlinden/pr-fixup-amend-reword-completion-v1
Pull-Request: https://github.com/git/git/pull/1365

 contrib/completion/git-completion.bash | 11 +++++++-
 t/t9902-completion.sh                  | 35 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d8..8d1a713dc4d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1672,8 +1672,17 @@ _git_commit ()
 			" "" "${cur##--cleanup=}"
 		return
 		;;
+	--fixup=amend:*|--fixup=reword:*)
+		__git_complete_refs --cur="${cur#*:}"
+		return
+		;;
+	--fixup=*)
+		__git_complete_refs --cur="${cur#*=}"
+		__gitcomp_direct_append "$(compgen -W "amend: reword:" "${cur#*=}")"
+		return
+		;;
 	--reuse-message=*|--reedit-message=*|\
-	--fixup=*|--squash=*)
+	--squash=*)
 		__git_complete_refs --cur="${cur#*=}"
 		return
 		;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43de868b800..bb3dcab5d9d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1444,6 +1444,41 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
+test_expect_success 'git commit - with --fixup=, completes references along with amend: and reword:' '
+	test_completion "git commit --fixup=" <<-\EOF
+	HEAD Z
+	main Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/main-in-other Z
+	amend:Z
+	reword:Z
+	EOF
+'
+
+test_expect_success 'git commit - with --fixup=amend:, completes references' '
+	test_completion "git commit --fixup=amend:" <<-\EOF
+	HEAD Z
+	main Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/main-in-other Z
+	EOF
+'
+
+test_expect_success 'git commit - with --fixup=reword:, completes references' '
+	test_completion "git commit --fixup=reword:" <<-\EOF
+	HEAD Z
+	main Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/main-in-other Z
+	EOF
+'
+
 test_expect_success 'setup sparse-checkout tests' '
 	# set up sparse-checkout repo
 	git init sparse-checkout &&

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget
