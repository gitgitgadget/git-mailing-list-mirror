Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79407C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBYC02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBYC0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E526CD4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p16so944078wmq.5
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHeljppUIs0/8UhOdXVQYodSdBFtuopxWbZQKEP+H/Y=;
        b=n31davD77mNhkqH308RBeuZMaA/FP5d3Hraw5XOz9NPymNRILnM+SOR2IuGSwTr/ny
         3t3f7YTM+/enzdbexakq5xHMBeHSGweQlqk0pmF8/UheX5kwzJdnF5q8XE90c5jiUPKB
         Z4ZD+QbKIEN75MU6bDX1r7unhALFEF4tTzQVgh7FbhIihlo5Y8+sM3t9F+gpO214nb64
         FOK3w12D9LuSUR6R4RvcIkAve9ORzKSmtrLw6I+FZuKNr4wSVVfi/L84wgGzrWne6XEx
         Fx9HezhDz3mCOm5goHxSlalIAvVN4FqneYTeLuj5mKgrLUg3xg/U3MqL+3otklZcdWod
         6x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHeljppUIs0/8UhOdXVQYodSdBFtuopxWbZQKEP+H/Y=;
        b=Wgi2LjL0rY2xRQJqjRVxjCNCwD0JBMBbxDRXW9GZ5QbQ2ZLcYZGttgd9x3uPB7wk+K
         bE1QO3ZEZ38oF3iv6a2pMRfD5kpRMpA/KYBpdT7HnilYEqym4cNJWMAYeoU2lQUEOzGl
         PfISldzk1bQxEXcqkawfQLngeN/drlkD5kfHPVag+L7U85vUTvYwiz3ZVdVOfFgVsDv3
         YBXP/vZteCcTvXM/LTcT48EZYhcYuwBhDUjX2YOHtw2x+VZLkGIWweNnQsAM7eBhfpYS
         +Y9SuRZ8viaeF0vuvbX3WVhPdqPSm9kSVL0/3Kao5OCeO26Nmox66omeScBwAiD14RmU
         V1eA==
X-Gm-Message-State: AO0yUKWnebFseKrSmOMNYgz24Lezdjv3iz6RW4UqzHgf/R1iSFZngY6g
        E43dk7LZ0RDpjZO+wGmCw5gqiu5h314=
X-Google-Smtp-Source: AK7set8yDgRZpKX96XaXmoPn6GQ0V1ItRePR5CtDBlWbwG6YSJVWQ4x0JxBA3eP7dDpEzQKpHeDQyw==
X-Received: by 2002:a05:600c:154e:b0:3eb:29fe:f912 with SMTP id f14-20020a05600c154e00b003eb29fef912mr2392669wmg.36.1677291967664;
        Fri, 24 Feb 2023 18:26:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be6-20020a05600c1e8600b003e89e3284fasm4801298wmb.36.2023.02.24.18.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:07 -0800 (PST)
Message-Id: <429f195dcfedbe0a54e9a2b7bbbc6c126ca4e485.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:55 +0000
Subject: [PATCH v2 06/11] sparse-checkout: avoid using internal API of
 unpack-trees, take 2
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

Commit 2f6b1eb794 ("cache API: add a "INDEX_STATE_INIT" macro/function,
add release_index()", 2023-01-12) mistakenly added some initialization
of a member of unpack_trees_options that was intended to be
internal-only.  This initialization should be done within
update_sparsity() instead.

Note that while o->result is mostly meant for unpack_trees() and
update_sparsity() mostly operates without o->result,
check_ok_to_remove() does consult it so we need to ensure it is properly
initialized.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 -
 unpack-trees.c            | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 4b7390ce367..8d5ae6f2a60 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -217,7 +217,6 @@ static int update_working_directory(struct pattern_list *pl)
 	o.head_idx = -1;
 	o.src_index = r->index;
 	o.dst_index = r->index;
-	index_state_init(&o.result, r);
 	o.skip_sparse_checkout = 0;
 
 	setup_work_tree();
diff --git a/unpack-trees.c b/unpack-trees.c
index 639e48cc6bb..4fca051cbea 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2101,6 +2101,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 
 	old_show_all_errors = o->show_all_errors;
 	o->show_all_errors = 1;
+	index_state_init(&o->result, o->src_index->repo);
 
 	/* Sanity checks */
 	if (!o->update || o->index_only || o->skip_sparse_checkout)
-- 
gitgitgadget

