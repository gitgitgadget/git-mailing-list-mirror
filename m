Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211E7C64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBYC0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBYC0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA219F2D
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso117867wmb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54dRuSmDoDZRSvOtTbEmZzMk9W9OyB/i/B/eNUPRFMY=;
        b=F/t4QXvy8Cbukt8eL87PwPurGA4DhDwfAYQ1GnrhB1LpUh4MQg+30bxdfjQ34KVRgv
         wKfj4XliAvLCb1A6ro/Mmwi2lqNzBtq1rK+R5rh4hfzL6meMDYsUDOiM3bTrn39oKxkn
         PrGvDYDbd3rP4a1l0d2aBW6RGgICM1StvBaw1rWWmRYpEmHpnREHxGKCD512dDiiaHKi
         URUGf22euFdjfvsTu4mMN4sB6yiVfVpKT8XdMQG2jDjeYjTvwzWHEMmK0OlAOO3/QgA2
         Fc4JJTLIvlxxZmyXpWvqOwQJMulWNqQ/yhMwoh33ossHhdKanzVooX78s4Xb/ibGCOFe
         F4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54dRuSmDoDZRSvOtTbEmZzMk9W9OyB/i/B/eNUPRFMY=;
        b=xmBQDTV+upOQivgHkX+KqU+unSr4S2gXVV6NK8zo2MQrzbOwo349S7WUZg9kS0EVXi
         XGLMxsXRiuH7co/Lb7zn/1y63vGab3yeCE4QjoSPv40gvYdpervYHIxbpQ+gkvfjSdqJ
         lPcuatUIINLfiC36SOCmkUYztiEwjqJG/Yn+hsASmWxZte/fBtSvlWp4CGwnD5om+vsz
         64Zb+AF2aR6VNCMYA4UOIJS5loR8mZ7BPHg+U/uLyG0WW5KF76DGDxhrWrc6hikdsXz4
         GvUwn5AZb/VnLZjZzoPWk8He9qY+0yXzJB1qH06xOT0VIWJPLhMzZZskqb0YXVjUD3gi
         7uAw==
X-Gm-Message-State: AO0yUKUJmKXMGFWj86ptChirM75BHH1N+No92GJoP7s1NFjh2U+hTVSa
        SM2o3qf0wJvDYun3/7EbVO0rlB8iuuo=
X-Google-Smtp-Source: AK7set8J8vMtZ8bN4o0GkBrJpgqlQt2aEsaN/X5mXGCfFPonuXNiO2/1jSJyUp2qNs/Pa3dtpU4HRA==
X-Received: by 2002:a05:600c:34cb:b0:3eb:a4e:a2b2 with SMTP id d11-20020a05600c34cb00b003eb0a4ea2b2mr3733435wmq.4.1677291966267;
        Fri, 24 Feb 2023 18:26:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b002c704271b05sm381992wrv.66.2023.02.24.18.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:05 -0800 (PST)
Message-Id: <f5a58123034a708b49aac7076197ad2ccdd3cba1.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:53 +0000
Subject: [PATCH v2 04/11] unpack-trees: clean up some flow control
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The update_sparsity() function was introduced in commit 7af7a25853
("unpack-trees: add a new update_sparsity() function", 2020-03-27).
Prior to that, unpack_trees() was used, but that had a few bugs because
the needs of the caller were different, and different enough that
unpack_trees() could not easily be modified to handle both usecases.

The implementation detail that update_sparsity() was written by copying
unpack_trees() and then streamlining it, and then modifying it in the
needed ways still shows through in that there are leftover vestiges in
both functions that are no longer needed.  Clean them up.  In
particular:

  * update_sparsity() allows a pattern list to be passed in, but
    unpack_trees() never should use a different pattern list.  Add a
    check and a BUG() if this gets violated.
  * update_sparsity() has a check early on that will BUG() if
    o->skip_sparse_checkout is set; as such, there's no need to check
    for that condition again later in the code.  We can simply remove
    the check and its corresponding goto label.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3d05e45a279..0887d157df4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1873,6 +1873,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 	if (o->dir)
 		BUG("o->dir is for internal use only");
+	if (o->pl)
+		BUG("o->pl is for internal use only");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
@@ -1899,7 +1901,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
-	if (!o->skip_sparse_checkout && !o->pl) {
+	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
 		populate_from_existing_patterns(o, &pl);
@@ -2113,8 +2115,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
 		populate_from_existing_patterns(o, &pl);
-		if (o->skip_sparse_checkout)
-			goto skip_sparse_checkout;
 	}
 
 	/* Expand sparse directories as needed */
@@ -2142,7 +2142,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 			ret = UPDATE_SPARSITY_WARNINGS;
 	}
 
-skip_sparse_checkout:
 	if (check_updates(o, o->src_index))
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
-- 
gitgitgadget

