Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C52DC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiBWOaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiBWO35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E54B250B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q23so5214224wra.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DvAQ1Jj0UNMTlwQf2YLVg4GozQk01H9LWc5JpnkR4Bo=;
        b=HQvQj/uMYTonOgKQ+KsdN4/80iLdwf2m2P6LI8yLWZSQD4kdweDijGMKxm/JfopRz7
         MG/MMTVNepDzPcxFKyUxztUCz0xwCtBySL1Bbu5hRIqXQ2wAz09fHqbaLijuaN/3r2PW
         +Wi1z/bZSn1v70ik8H7Oa1c6xelaYFHD4Ex6iE3OMPYKfh4/AFm4u4EROCcnVXTcZqqb
         I4bZFsfdR0alqcqR9XzS9zueBPrx3AG7znVUh//NYB+YEzE8UInKLrPMP3XHjkAW+N49
         4PrQC9OcNen1EOwaXOh+ys37DRASBv7x9+RMB31BcqmWu5mbKmuv/KpBQ1JOCy3+A2zE
         4C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DvAQ1Jj0UNMTlwQf2YLVg4GozQk01H9LWc5JpnkR4Bo=;
        b=GUti4ATHMa0p6+0CFgHVuI+82kQZSzoQHXlblnbrY36lvB15ufA4f8li9jaScqAv5b
         MSWrxw49/YjrrU/ufntV9pkhXcfgQ29PywixZFOl7El7AKVzBCGjg6Feo+NfwxHOZrN1
         mbJ7mm36hdWuKXV/0/tGJDdE67qWEPzLoILueF+pkQMEXb3IGhZz4U7WfrtUkTyVZorn
         Ie4j5dY8dz77hzj7+GvkYCL/b89hp5QEGCoz1swdKruAx+UizkjB0x/18d/mGKocJh3n
         0SjqwczfPfX3mo8pX8Vs2ac43trMCic8kq9uM6Dtl9YSTdGYIuiWwo9NdKSW7c+oaOQ8
         GC0Q==
X-Gm-Message-State: AOAM532TOOcYbV1hdIS4PbVKlckujCpFx43+8EWx+Ca4Jbu4mtHHGYyi
        mo7sZIiZgAr3aVzdgk+m5cjiGMU6nj0=
X-Google-Smtp-Source: ABdhPJzroU6XABVPCFqhiaqGkNBFOdqU2Hy7vrrl4EzU4ZgC7y7xct3AE/NkharbVbrlsmySyxDWVA==
X-Received: by 2002:a05:6000:18ad:b0:1e8:cbe1:afd with SMTP id b13-20020a05600018ad00b001e8cbe10afdmr23254277wri.352.1645626567634;
        Wed, 23 Feb 2022 06:29:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm47771840wrv.107.2022.02.23.06.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:27 -0800 (PST)
Message-Id: <bee53e679ff385fec972c7bfa02186052c013e77.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:15 +0000
Subject: [PATCH v3 07/11] worktree: use 'worktree' over 'working tree'
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

This is the third of multiple changes to git-worktree.txt, restricted to
the OPTIONS section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 234882be45a..329d3a9e4ea 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -160,25 +160,25 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when
+	By default, `add` refuses to create a new worktree when
 	`<commit-ish>` is a branch name and is already checked out by
-	another working tree, or if `<path>` is already assigned to some
-	working tree but is missing (for instance, if `<path>` was deleted
+	another worktree, or if `<path>` is already assigned to some
+	worktree but is missing (for instance, if `<path>` was deleted
 	manually). This option overrides these safeguards. To add a missing but
-	locked working tree path, specify `--force` twice.
+	locked worktree path, specify `--force` twice.
 +
-`move` refuses to move a locked working tree unless `--force` is specified
-twice. If the destination is already assigned to some other working tree but is
+`move` refuses to move a locked worktree unless `--force` is specified
+twice. If the destination is already assigned to some other worktree but is
 missing (for instance, if `<new-path>` was deleted manually), then `--force`
 allows the move to proceed; use `--force` twice if the destination is locked.
 +
-`remove` refuses to remove an unclean working tree unless `--force` is used.
-To remove a locked working tree, specify `--force` twice.
+`remove` refuses to remove an unclean worktree unless `--force` is used.
+To remove a locked worktree, specify `--force` twice.
 
 -b <new-branch>::
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
-	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
+	`<commit-ish>`, and check out `<new-branch>` into the new worktree.
 	If `<commit-ish>` is omitted, it defaults to `HEAD`.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
@@ -186,7 +186,7 @@ To remove a locked working tree, specify `--force` twice.
 
 -d::
 --detach::
-	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
+	With `add`, detach `HEAD` in the new worktree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
@@ -212,7 +212,7 @@ This can also be set up as the default behaviour by using the
 	`--track` in linkgit:git-branch[1] for details.
 
 --lock::
-	Keep the working tree locked after creation. This is the
+	Keep the worktree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
 	but without a race condition.
 
@@ -237,22 +237,22 @@ This can also be set up as the default behaviour by using the
 With `list`, output additional information about worktrees (see below).
 
 --expire <time>::
-	With `prune`, only expire unused working trees older than `<time>`.
+	With `prune`, only expire unused worktrees older than `<time>`.
 +
-With `list`, annotate missing working trees as prunable if they are
-older than `<time>`.
+With `list`, annotate missing worktrees as prunable if they are older than
+`<time>`.
 
 --reason <string>::
-	With `lock` or with `add --lock`, an explanation why the working tree is locked.
+	With `lock` or with `add --lock`, an explanation why the worktree
+	is locked.
 
 <worktree>::
-	Working trees can be identified by path, either relative or
-	absolute.
+	Worktrees can be identified by path, either relative or absolute.
 +
-If the last path components in the working tree's path is unique among
-working trees, it can be used to identify a working tree. For example if
-you only have two working trees, at `/abc/def/ghi` and `/abc/def/ggg`,
-then `ghi` or `def/ghi` is enough to point to the former working tree.
+If the last path components in the worktree's path is unique among
+worktrees, it can be used to identify a worktree. For example if you only
+have two worktrees, at `/abc/def/ghi` and `/abc/def/ggg`, then `ghi` or
+`def/ghi` is enough to point to the former worktree.
 
 REFS
 ----
-- 
gitgitgadget

