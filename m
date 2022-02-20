Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB5DC433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiBTRzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiBTRy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E84D9EA
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d3so7625074wrf.1
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RTwt2oul/T9cuX1Aq7OX8wSa7v5hSVJ9F6TWOKAFUOQ=;
        b=O36mk0qQ29e8ysSD4X/HSD4zADRwy+PVTUOG5Py8emDgWt6H1qr81OLN083AxwJw43
         LE7AKhHM1FncP2q/Xdxtng9VGl5zM3NpTjUjB24KfvdD7R/1y6YjRkkKUL34aSZIlGnr
         hr+RYZTdibkcJ4HLH8kbb4G2uac+3kwVCyvkKQDyWqetU5WUNnI1upYQPOz/e8D2E4Ra
         6g99/iVrtzXy9iWJxpu51KvuhcSI2ag4pkk+UX6IU+3uavJEG8KyIzzsfO+yOvoZE2UJ
         JIF8CpTIJ+KX7wrcxfSJ1SuIxlxk/SfWE9J97SafIKtSv8Ri08e4CRNXWV51NeDmzrVu
         xYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RTwt2oul/T9cuX1Aq7OX8wSa7v5hSVJ9F6TWOKAFUOQ=;
        b=k0HGdgj2lSWdYHDxtp4U4o6lHCcazWkaBf+U0YdsVfqpRab+WmJRdsSsxu4o/yh038
         4wiQKQW23Ge4ccTWSFU23zi/p90FwCaPuR9pfx2vDWmeaW+DsK2ha0K2ZikI0x56Nzb6
         Knv+uKIGIZIuQDyfZxoak0RGmFi4Eq65+1x7V90XQFzZE/Xnz9tprLlH8PU8G5O9XULY
         BjmKvZzOgunuA9qt31Ss/6Jorr7GBQZkGc4WOyx4LkLroWkWz04N3M8bFqanxaY0snBg
         52SY71HYh56JPiGFxQclDFSwlvAJvkaYUKe9aZya15N5Y3Byo2KTdnKnCwFp6Jx8UBId
         OpCg==
X-Gm-Message-State: AOAM5327DFW8a4qxoMZyzgDwmfvTlntyPWMAmW6tQHu/ICL7cOE2AWny
        /7ZMPsEpl2WZRR7hfS9r0IeKOHBRRwU=
X-Google-Smtp-Source: ABdhPJwXSHVC7jsq1F3XK8QvDKzjZXzJ0wxpqvvAazQEkipgyasV6b2ZmUJuQZEcPfExlNxTB7V0Iw==
X-Received: by 2002:a05:6000:1089:b0:1e6:339c:f2f8 with SMTP id y9-20020a056000108900b001e6339cf2f8mr12766519wrw.370.1645379674393;
        Sun, 20 Feb 2022 09:54:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l31sm5636816wms.0.2022.02.20.09.54.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:33 -0800 (PST)
Message-Id: <1fc4a98dc7aac79a22b25670074f68a135b79ef3.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:22 +0000
Subject: [PATCH 06/11] worktree: use 'worktree' over 'working tree'
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

This is the second of multiple changes to git-worktree.txt, restricted
to the COMMANDS section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 85 ++++++++++++++++------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index d9705062e9d..e9ba58fb8bc 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -87,75 +87,72 @@ branches from there if `<branch>` is ambiguous but exists on the
 linkgit:git-config[1].
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, the new working tree is associated with a branch
-(call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
-doesn't exist, a new branch based on `HEAD` is automatically created as
-if `-b <branch>` was given.  If `<branch>` does exist, it will be
-checked out in the new working tree, if it's not checked out anywhere
-else, otherwise the command will refuse to create the working tree (unless
-`--force` is used).
+then, as a convenience, the new worktree is associated with a branch (call
+it `<branch>`) named after `$(basename <path>)`.  If `<branch>` doesn't
+exist, a new branch based on `HEAD` is automatically created as if
+`-b <branch>` was given.  If `<branch>` does exist, it will be checked out
+in the new worktree, if it's not checked out anywhere else, otherwise the
+command will refuse to create the worktree (unless `--force` is used).
 
 list::
 
-List details of each working tree.  The main working tree is listed first,
-followed by each of the linked working trees.  The output details include
-whether the working tree is bare, the revision currently checked out, the
+List details of each worktree.  The main worktree is listed first,
+followed by each of the linked worktrees.  The output details include
+whether the worktree is bare, the revision currently checked out, the
 branch currently checked out (or "detached HEAD" if none), "locked" if
-the worktree is locked, "prunable" if the worktree can be pruned by `prune`
-command.
+the worktree is locked, "prunable" if the worktree can be pruned by the
+`prune` command.
 
 lock::
 
-If a working tree is on a portable device or network share which
-is not always mounted, lock it to prevent its administrative
-files from being pruned automatically. This also prevents it from
-being moved or deleted. Optionally, specify a reason for the lock
-with `--reason`.
+If a worktree is on a portable device or network share which is not always
+mounted, lock it to prevent its administrative files from being pruned
+automatically. This also prevents it from being moved or deleted.
+Optionally, specify a reason for the lock with `--reason`.
 
 move::
 
-Move a working tree to a new location. Note that the main working tree
-or linked working trees containing submodules cannot be moved with this
-command. (The `git worktree repair` command, however, can reestablish
-the connection with linked working trees if you move the main working
-tree manually.)
+Move a worktree to a new location. Note that the main worktree or linked
+worktrees containing submodules cannot be moved with this command. (The
+`git worktree repair` command, however, can reestablish the connection
+with linked worktrees if you move the main worktree manually.)
 
 prune::
 
-Prune working tree information in `$GIT_DIR/worktrees`.
+Prune worktree information in `$GIT_DIR/worktrees`.
 
 remove::
 
-Remove a working tree. Only clean working trees (no untracked files
-and no modification in tracked files) can be removed. Unclean working
-trees or ones with submodules can be removed with `--force`. The main
-working tree cannot be removed.
+Remove a worktree. Only clean worktrees (no untracked files and no
+modification in tracked files) can be removed. Unclean worktrees or ones
+with submodules can be removed with `--force`. The main worktree cannot be
+removed.
 
 repair [<path>...]::
 
-Repair working tree administrative files, if possible, if they have
-become corrupted or outdated due to external factors.
+Repair worktree administrative files, if possible, if they have become
+corrupted or outdated due to external factors.
 +
-For instance, if the main working tree (or bare repository) is moved,
-linked working trees will be unable to locate it. Running `repair` in
-the main working tree will reestablish the connection from linked
-working trees back to the main working tree.
+For instance, if the main worktree (or bare repository) is moved, linked
+worktrees will be unable to locate it. Running `repair` in the main
+worktree will reestablish the connection from linked worktrees back to the
+main worktree.
 +
-Similarly, if a linked working tree is moved without using `git worktree
-move`, the main working tree (or bare repository) will be unable to
-locate it. Running `repair` within the recently-moved working tree will
-reestablish the connection. If multiple linked working trees are moved,
-running `repair` from any working tree with each tree's new `<path>` as
-an argument, will reestablish the connection to all the specified paths.
+Similarly, if a linked worktree is moved without using `git worktree
+move`, the main worktree (or bare repository) will be unable to locate it.
+Running `repair` within the recently-moved worktree will reestablish the
+connection. If multiple linked worktrees are moved, running `repair` from
+any worktree with each tree's new `<path>` as an argument, will
+reestablish the connection to all the specified paths.
 +
-If both the main working tree and linked working trees have been moved
-manually, then running `repair` in the main working tree and specifying the
-new `<path>` of each linked working tree will reestablish all connections
-in both directions.
+If both the main worktree and linked worktrees have been moved manually,
+then running `repair` in the main worktree and specifying the new `<path>`
+of each linked worktree will reestablish all connections in both
+directions.
 
 unlock::
 
-Unlock a working tree, allowing it to be pruned, moved or deleted.
+Unlock a worktree, allowing it to be pruned, moved or deleted.
 
 OPTIONS
 -------
-- 
gitgitgadget

