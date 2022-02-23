Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B6C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiBWOaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbiBWO34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B548B2535
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id x15so5550203wrg.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BGCI4x5Zk/ciGPd5nFuBtrTQZXLO9AYHaRZJH4Gsd48=;
        b=kQGpfjkvZscWL+iwu+XpnpMoRaFj07WAfL1to74H784m7Ssc2Kp7PtM6SuR+ai6p68
         sZ6bdA4YwzKaW3trvcMTcf+hv2E4VVu+X10qPjfWFeHcCmX0CctmJgUBuy9GMNnSxK7c
         0iHN2WjfBtDawsyx9ukKO4JOvatrN81NZD0fO00LRbOsdP12kyzxNyT3QL3A2UV/oE8G
         htwGTWM422Q0atHFu+gRKOxNih1FmCgoB2zxoYt66wWYJyYWf/uCyoS/cPERPaE37GTN
         +GufkVyyEp7ZglrgVNRBJUKjSGu328ZUfG/o2jny+RQcq+LXaAir+0TzbvNCkSIZDLw4
         3n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BGCI4x5Zk/ciGPd5nFuBtrTQZXLO9AYHaRZJH4Gsd48=;
        b=KWAz4I4w/BH10maYZspdSy+/heIBYfpyzTCMuJ1QJowcBWrK+wtJlmBZNSmrRmo6Bg
         9zQHSBXRF5nBU7YCesgri+bXQ8KVohPoZK9UJeite3mqDo7LjvovbuwbXyUX1MJCHs8W
         do8dg93EkyFqlDZSBEBOUrDOoSnQIakc+wnf6qN+kMXqbWiwIj/R7m1mKPh+Dg21sttD
         2JPsksMfQ9AbHb+JehrpaUyNOcCft2uoes2mjKlsCvDzRsmuR9dTkQFUJOdnarvPvTej
         hj+dBh621n71WIx4qveqr+KMUuGoiXUeUM/uA0T+y4AchS2OzE/dC4/OsZOjKDui+u2x
         gT7A==
X-Gm-Message-State: AOAM53197f9wXTp7hsMjdeiHRNUUNQ4IMQmGzPITwPhcTElkIaViuVmT
        xZ4ftTTQ38/BRnyUwe/J4h8Nw40EA+s=
X-Google-Smtp-Source: ABdhPJyoM9JmhRUmRnAIyfWhdNag+rgb+0zwHV+FtJXRv8nYDYRCIdR8tlRfIWnuE7krzwvvf4vdUg==
X-Received: by 2002:a5d:440b:0:b0:1e3:f66:bf59 with SMTP id z11-20020a5d440b000000b001e30f66bf59mr23239543wrq.250.1645626566614;
        Wed, 23 Feb 2022 06:29:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm34404287wry.4.2022.02.23.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:25 -0800 (PST)
Message-Id: <704cce17815b17ec0d07c64c7818c0a2d2fd3105.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:14 +0000
Subject: [PATCH v3 06/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
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

There is some language around the movement of "the working tree of a
linked worktree" which is used once, but the remaining uses are left as
just moving "a linked worktree" for brevity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 85 ++++++++++++++++------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 956c17c4306..234882be45a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -88,75 +88,72 @@ branches from there if `<branch>` is ambiguous but exists on the
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
+Similarly, if the working tree for a linked worktree is moved without
+using `git worktree move`, the main worktree (or bare repository) will be
+unable to locate it. Running `repair` within the recently-moved worktree
+will reestablish the connection. If multiple linked worktrees are moved,
+running `repair` from any worktree with each tree's new `<path>` as an
+argument, will reestablish the connection to all the specified paths.
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

