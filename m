Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB6C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJQCXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJQCXa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA5544549
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i131-20020a1c3b89000000b003c6c154d528so4702167wma.4
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs/KCUkfn9ByRJHNiJHiUVJxgB62lsS+0U9fDXCTndo=;
        b=il4+4wlzqlAW9tqZ6EC2OpFvk4IMzO455MuBsZAaXDbEXPzaIlAlZs3sfXs9afcBsB
         xIRKGqYXrWLkf/wDngbTv/NfnkfIpLBInziXCNQy/BbGgW9MFs7KkI2jAO0oRgf+BER8
         0Y9ph0W2oBOh3j+EIID9cb0ZOq1ckJp4vS893/3aLWysA9KtB2pzlCRXRw7icGXdCZVz
         jKOjx2nCOaWwjFMM2D9Rgn4jeMQIhCJ82sJ5wkDVTVmXCfFDg9IinFHhIMG1yOMy4EON
         2OGWcavzm7JU1OaPDWlig9GZ8QjidFbOlNHTzOFLkhiikErfS7rqk+NVFwXvYdGDx/LD
         Zzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs/KCUkfn9ByRJHNiJHiUVJxgB62lsS+0U9fDXCTndo=;
        b=4BMjoQgLEoH7F9SzhJRRRtIjNbaeIg5lxgoV09RSTtKaPWXLOkSk05sHNVzbTGvwbf
         uEv3F66hmxFEzEACyjZrC44j9+oKhgwEnidHG+OVG5wqAK8Mfjhu/3YJwus/96sqcF/Y
         DaXAhl9gZqA+Y70wezNWiIqIJgvphPINWn5mIALwn2doInVlZkQxiryXGL38rxDrSCb0
         YNMWcLZCP/TlrXLdwmklh4Wqyinhb87RVdwdRLYh7fDG31AfpJB0R8k0gsWeT/cduUjR
         ULhvEfmtHD7mLuxYaNls4VyPaSK5T7Heji4zN6vtKRsTnD+6NW6HkQwkqyuerK/MPnN7
         tJNA==
X-Gm-Message-State: ACrzQf0JRYRpwlb7vocP19HLL2XoB2OH072gHMdYAQnNSlsd889bdLb/
        HpjwEbKtNGMrSFEVO9BMIk8uqI6YYxc=
X-Google-Smtp-Source: AMsMyM4LjnXqvCouMq5rbWxMgCJp7dhQL6cv9SsE6QxVbFVMCpEz5b+UqwYYgnbaGndqzMpkuEBjBw==
X-Received: by 2002:a05:600c:444f:b0:3c6:deac:d662 with SMTP id v15-20020a05600c444f00b003c6deacd662mr13744870wmn.89.1665973404729;
        Sun, 16 Oct 2022 19:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm7250633wrp.78.2022.10.16.19.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:24 -0700 (PDT)
Message-Id: <2291e0f9b5c61f9668b206b85368829db9384bb3.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:14 +0000
Subject: [PATCH v3 2/9] tree: update cases to use repo_ tree methods
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

For cases which had already had a repository instance,
update those to use the repo_parse_tree* methods.

Leave the remaining invocations that were already using the_repository
alone.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 merge.c     | 4 ++--
 reset.c     | 2 +-
 revision.c  | 4 ++--
 sequencer.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/merge.c b/merge.c
index 2382ff66d35..1efc4440c03 100644
--- a/merge.c
+++ b/merge.c
@@ -63,12 +63,12 @@ int checkout_fast_forward(struct repository *r,
 	memset(&trees, 0, sizeof(trees));
 	memset(&t, 0, sizeof(t));
 
-	trees[nr_trees] = parse_tree_indirect(head);
+	trees[nr_trees] = repo_parse_tree_indirect(r, head);
 	if (!trees[nr_trees++]) {
 		rollback_lock_file(&lock_file);
 		return -1;
 	}
-	trees[nr_trees] = parse_tree_indirect(remote);
+	trees[nr_trees] = repo_parse_tree_indirect(r, remote);
 	if (!trees[nr_trees++]) {
 		rollback_lock_file(&lock_file);
 		return -1;
diff --git a/reset.c b/reset.c
index e3383a93343..a0ac5e8a684 100644
--- a/reset.c
+++ b/reset.c
@@ -153,7 +153,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	tree = parse_tree_indirect(oid);
+	tree = repo_parse_tree_indirect(r, oid);
 	prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
diff --git a/revision.c b/revision.c
index 36e31942cee..dab5ddaf039 100644
--- a/revision.c
+++ b/revision.c
@@ -74,7 +74,7 @@ static void mark_tree_contents_uninteresting(struct repository *r,
 	struct tree_desc desc;
 	struct name_entry entry;
 
-	if (parse_tree_gently(tree, 1) < 0)
+	if (repo_parse_tree_gently(r, tree, 1) < 0)
 		return;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
@@ -181,7 +181,7 @@ static void add_children_by_path(struct repository *r,
 	if (!tree)
 		return;
 
-	if (parse_tree_gently(tree, 1) < 0)
+	if (repo_parse_tree_gently(r, tree, 1) < 0)
 		return;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
diff --git a/sequencer.c b/sequencer.c
index a4d85f1fbdd..a4c09dfa182 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -685,9 +685,9 @@ static int do_recursive_merge(struct repository *r,
 		o.buffer_output = 2;
 	o.show_rename_progress = 1;
 
-	head_tree = parse_tree_indirect(head);
-	next_tree = next ? get_commit_tree(next) : empty_tree(r);
-	base_tree = base ? get_commit_tree(base) : empty_tree(r);
+	head_tree = repo_parse_tree_indirect(r, head);
+	next_tree = next ? repo_get_commit_tree(r, next) : empty_tree(r);
+	base_tree = base ? repo_get_commit_tree(r, base) : empty_tree(r);
 
 	for (i = 0; i < opts->xopts_nr; i++)
 		parse_merge_opt(&o, opts->xopts[i]);
-- 
gitgitgadget

