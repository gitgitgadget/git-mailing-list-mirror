Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D71EC433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiBTRzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiBTRzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:55:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D0527F2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so23280184wrc.6
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y8Qz3MaqXaurVUb6IgC9RYMR3mVOeLMByogw65qYR4s=;
        b=ewi4ZoO20VxWsF4liqpczaWNtfXxlZV97WeEE5z2077cfJ91OJQ6A6+q2XwAh/rLYf
         xA5g4sBpj8/A1P3vb4ILooYAiH0c18TJvLWp9Iu2L4yoyqOcJ7dop4pSdU8DrL+n+jgH
         qo6KZe7efkzYgMQn0LBnd/VaX//52bGzL7fPvxL/omUGw2F/UmPkJdMSddMwlT+fkNIU
         jPjgvwssrybEVijXnCVrc43v9E1op7tRH4KQdGuXXcVnv8x22bgK2V7ESCFrYNP4XJBU
         nUccBGOgnMnn8Fs7NMKMFLZY8RNvdfin+mGOotJ9RARRWNWCwWlSjSvLYP6d/2euOi8/
         43Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y8Qz3MaqXaurVUb6IgC9RYMR3mVOeLMByogw65qYR4s=;
        b=No4P7LeBZeXlKWi3gNL6hrzGCwzgEogwovpp3m54raHKj9p/rjehRxuvD/8ysbXHvV
         OJZgHiIbIxP3zgFx2BfJsxuwzbwSKZ7mZ95AMTGaf9Z4WqZ8xEKgzrKkgInZyQEenU15
         fqPa2r1xF6CVSLAWhntlNA7tEAwAf6tNyEFxWR6ednj9O8YQYrMN5LgTQ3xmZFs3/vDq
         p6fWdQBzGH4Iu9rLHPDeFe4bKPfEstiMvwEHlMkUJqoFfPOXJ+0KfWuOZaCF/tRTscHF
         a2ZOmlAVjb/t+uZGRamrppwuY7O/JCFyYvjzXobHgHf4fL/dJGbF/dRqFApoy8uH92EX
         r9rQ==
X-Gm-Message-State: AOAM532Kp78369jjoK4Q0q+Jw/wyyGJAxDxVhcxLRkIEjz8QGK2GoM8Y
        0hj+HLihBPnAJKt4wj8+NzeSJbFK09E=
X-Google-Smtp-Source: ABdhPJxEeN19ZViD9RK+rAqJHdRG2RIvb6F//tq2jYT6tTHVHMyQ2SdMfdxZciMuzNm+AFDHQv9qIg==
X-Received: by 2002:a05:6000:144a:b0:1e6:2783:b3fd with SMTP id v10-20020a056000144a00b001e62783b3fdmr12853372wrx.156.1645379679704;
        Sun, 20 Feb 2022 09:54:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm5245809wmi.37.2022.02.20.09.54.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:39 -0800 (PST)
Message-Id: <91773337675b05b0c0e323211899c64d5b8102e6.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:27 +0000
Subject: [PATCH 11/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the last of multiple changes to git-worktree.txt, starting at
the LIST OUTPUT FORMAT section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 923b44d3fb2..1d5111ddba5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -382,11 +382,11 @@ $ git worktree list
 /path/to/other-linked-worktree  1234abc  (detached HEAD)
 ------------
 
-The command also shows annotations for each working tree, according to its state.
+The command also shows annotations for each worktree, according to its state.
 These annotations are:
 
- * `locked`, if the working tree is locked.
- * `prunable`, if the working tree can be pruned via `git worktree prune`.
+ * `locked`, if the worktree is locked.
+ * `prunable`, if the worktree can be pruned via `git worktree prune`.
 
 ------------
 $ git worktree list
@@ -404,14 +404,14 @@ $ git worktree list --verbose
 /path/to/linked-worktree              abcd1234 [master]
 /path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
 /path/to/locked-worktree-with-reason  1234abcd (brancha)
-	locked: working tree path is mounted on a portable device
+	locked: worktree path is mounted on a portable device
 /path/to/prunable-worktree            5678abc1 (detached HEAD)
 	prunable: gitdir file points to non-existent location
 ------------
 
 Note that the annotation is moved to the next line if the additional
 information is available, otherwise it stays on the same line as the
-working tree itself.
+worktree itself.
 
 Porcelain Format
 ~~~~~~~~~~~~~~~~
@@ -420,7 +420,7 @@ label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a label
 only or with a value depending upon whether a reason is available.  The first
-attribute of a working tree is always `worktree`, an empty line indicates the
+attribute of a worktree is always `worktree`, an empty line indicates the
 end of the record.  For example:
 
 ------------
@@ -470,9 +470,9 @@ EXAMPLES
 You are in the middle of a refactoring session and your boss comes in and
 demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
-working tree is in such a state of disarray (with new, moved, and removed
+worktree is in such a state of disarray (with new, moved, and removed
 files, and other bits and pieces strewn around) that you don't want to risk
-disturbing any of it. Instead, you create a temporary linked working tree to
+disturbing any of it. Instead, you create a temporary linked worktree to
 make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
 
-- 
gitgitgadget
