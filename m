Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE5C4332F
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiBVASk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbiBVASd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6925581
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so29737726wrg.11
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hrlmiApyqNDFMdN5yr+/7ShYPjSY4TX/K8+UbrnSPtY=;
        b=YfFsrZ94yO+EmxHrQpC9PBGn/m6NdZVuvygBEKBf4glBX5cVKQpfJIRvYkluD0FYOj
         TEZjxISNCluP+YhL1/zPIktYoysedq1XnUBaXh/Pue2WG5ThlSvrkd8euByOl0ZmcxIe
         RCL6DM/9g1zsdb8V3tumNonJiHiZ1nFa2sKCFry/oIRVNCvnnfxvyp+fV3cKMTX/WyPv
         d+ZSg3EM4ZvEXptGZ1yVze3lgv3czaaLcEw77yL9GTw2ucVOpCCx9aVqnWJrDXO0Eqzk
         N5bEHz1de6Qe0+zqIeMoFp6v3r9W/Dw0we1LZq0ZN0R7+a2jofDH9i0pAlj6BkDG2Gkg
         EV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hrlmiApyqNDFMdN5yr+/7ShYPjSY4TX/K8+UbrnSPtY=;
        b=HPlKF0h5utB/p8Grt407n8BmIHSVNBu/kjTFmsmjveLf2zf2nC5TxH33n6QtDd7BQK
         UL7hu1X47Gf0bbn6dgVqVnh3fTtbYMHdvbZnZAmWvKUaKRnrbp7sGU25SHnaWTDOs+6e
         trccmja3OyWEdczWPGMLPp047jZ+NWF1xnSiS9GereQFtsceRsP0amvNXifXSxaXrMLd
         dH7FI4q4xwDIiuqaf3S18f8EYNtvjdOc69ivFsSJfX3p+N2V7f0pZIq0c0nqXXUhjWwj
         PffqBPo7c62VG89Ytaouw4+Ui6jOZ8EiwaoyjnAw6bv/YZnMXO7lgF+umK14w53VxWHP
         A8Zw==
X-Gm-Message-State: AOAM5330dWcSLu5zByxuq3OsDr8eHwysDV+skU4ndcmmxq1HGTapC/k+
        ODr/tC0wCz65jxi728pA117G7vFsR2k=
X-Google-Smtp-Source: ABdhPJyV2Gsj5A53jMYKddovqPrTPtOCbiLSBSxQiULtZaAG+MKQaA19fAshn528T6P8TNqlCRtMSQ==
X-Received: by 2002:adf:df86:0:b0:1e3:126f:440c with SMTP id z6-20020adfdf86000000b001e3126f440cmr17568740wrl.140.1645489087433;
        Mon, 21 Feb 2022 16:18:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm32502332wri.22.2022.02.21.16.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:07 -0800 (PST)
Message-Id: <d1c4b687cbc5e198be4a7d667df6a5313d5c8e50.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:56 +0000
Subject: [PATCH v2 07/11] worktree: use 'worktree' over 'working tree'
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
index 00edf343610..358325ac073 100644
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

