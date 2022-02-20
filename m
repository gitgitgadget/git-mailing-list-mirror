Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F8C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbiBTRzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbiBTRy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359C4D9EB
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d3so7625112wrf.1
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vC1TkCW+XO48wkGTn+/eQuGlj2/Ui8jqQMIkeWhcDhk=;
        b=CCWz+X6s7cFhVobhLSY6RYowIyUR4jcq5w1F5FjxcwWzynSdWQq61ilTA6/FwpbAdI
         8KaavEjXPMQYwzFH2Y39wEt4GhRGHF3Jp6TzlISudphLM4LW16mqwX2gekNni9MIDmQ+
         AFI3ROJ+StkhtDQ5piMXx99nFQs5dU/t5ZhC50e3aQH7qzRXddqt6kESlsTnG4FjRKJQ
         RKbw5P42WzRTG4aNAzA/DLzulCvFE++LyhV+5UsnG0Lx2BEB/PNV4O5quaf1dKYqSLuk
         GI3qVxP9P7MmYzN667134hiLKXPleuZmoICn+516i2Joa/abbirDJOzRposMChHnh+Z6
         +2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vC1TkCW+XO48wkGTn+/eQuGlj2/Ui8jqQMIkeWhcDhk=;
        b=0lMxE/oGHix2nsZzFIacHu9XOsXGoqLlX9qd/+h6jUgdcwz93r3xCmfD05P20xUi7x
         Bx4+V7+Vkv/TT9vQsEfQLL9aJowH6b9Am9q6ImyYsetSDZ0/GQAPyd8MODXdDsecaGY0
         46Tzox/WIQvvfy3ic1SZ9GpTECRvHx1WPkTvqR3jkxBM4GId2n1miILkfEHgOVZ6iaUv
         8ZKKm1Roa2mtifOG2xV6nLpWawHNEJlyD6fUqQ7HWNgOgbcAOmGmOgVk0h3XOce9Az5B
         ZLOhGBu5/QFG5lB0ZyE7jw3J+PNEnYy5uV3GEf3PnSPfrrOF+nd8T0YfEOMk1vQVEvmL
         oU0g==
X-Gm-Message-State: AOAM5315XMoCIQGeI8HkcV0tq6HyFNmihic4OFukoiyZW07cR/WNv8a7
        9tSktq63frQVs9z3LXNANSli87zfey0=
X-Google-Smtp-Source: ABdhPJzgd7/G2OQI3b3YiRjqEpwg5sYGWd0CDGiiBsS8KK/W59GUS3rsrIFdvJ/ENxRlVxeBp3E2uQ==
X-Received: by 2002:a5d:47a1:0:b0:1e8:f787:b7bf with SMTP id 1-20020a5d47a1000000b001e8f787b7bfmr12078934wrb.101.1645379675437;
        Sun, 20 Feb 2022 09:54:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a7bc5c4000000b0037e0c62604fsm5268138wmk.14.2022.02.20.09.54.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:34 -0800 (PST)
Message-Id: <00d261d0a2a4e87e774990d1cef3b875dde373d5.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:23 +0000
Subject: [PATCH 07/11] worktree: use 'worktree' over 'working tree'
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

This is the third of multiple changes to git-worktree.txt, restricted to
the OPTIONS section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e9ba58fb8bc..10021c85e77 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -159,25 +159,25 @@ OPTIONS
 
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
@@ -185,7 +185,7 @@ To remove a locked working tree, specify `--force` twice.
 
 -d::
 --detach::
-	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
+	With `add`, detach `HEAD` in the new worktree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
@@ -211,7 +211,7 @@ This can also be set up as the default behaviour by using the
 	`--track` in linkgit:git-branch[1] for details.
 
 --lock::
-	Keep the working tree locked after creation. This is the
+	Keep the worktree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
 	but without a race condition.
 
@@ -236,22 +236,22 @@ This can also be set up as the default behaviour by using the
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

