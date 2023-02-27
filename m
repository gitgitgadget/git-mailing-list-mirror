Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B99FC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjB0P2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjB0P2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA45903F
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso4069333wmp.4
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8Cfw/c/+MlKLD/ZLO8612wMe8zuxoFzxBZtOVpPexg=;
        b=OlQeRwhQHvBmM1htuMjW+bqYGeWIovx3S9MhunrWj0ExIgyMQT9S0LpCp7iisT+RhP
         H3KzUuwyb8os1OlL7YpgsIQjLQ8An90C5+RzdFOAg7Q1kAUSW0SY6NpRw/vgSD5Y66Oi
         Htle5PsU60AcW2LpPF8/59njoNKCEqP1P4nfCgWqI9j8gi4UXzT/Mxf7N47zWqjDZx36
         V7ybPLfhLL21VwYHOSYLY5JEMYJFXMC799RXKdYEhXh62zMahMGejp+zSZtUyiKzsjee
         1+N8amYY8kTURVHfoOthqe5+B4l7MTQDhr2KbZ38UqCncLec6zNHNsMS6usmaNOEEdcr
         38kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8Cfw/c/+MlKLD/ZLO8612wMe8zuxoFzxBZtOVpPexg=;
        b=3ImQw2EFeTYjshGz7jbc2GQklk/DuP7MnwfcoN61nCAlbT27jil9wHsZZj/n6F5pGE
         YhavZwqtzfvI6L0rPGDFuW5ekI+zuibPAxs2MBSEPYuQFdRZ6/qzGT+ZxrrEGG1Ycig/
         fK7p4XQrCxXvxB/+ZHmQHQ57aaOyERCw6ZE2VLdjvD53Ic3CK3wDAYKXu3BMRJRHa/sL
         0Aa0BW2P9LClgRbJbRdhbHh0p9pHty7ZyOsi8Ci6q62s8J0TOoe06qVROqEzXI+IAg9F
         PLo59D1ktzhIAbafoPBL7JaaZOXq46bv0bqTLjJLA9lt5OQmCsxAORGBkK2g/g5O4Mi9
         2ysg==
X-Gm-Message-State: AO0yUKWqFyavW7eYAoZc1FdCxzlFQAtcsx+eQibFQEaHa0eGTkkaHPIs
        xxdHbLnGjEa1NVuKSRVBQAwx8CHhwFk=
X-Google-Smtp-Source: AK7set8lirAY49GjhlDYe4VGEV4cEAHYGSKqB0+mwgg+Nl84OHemPqlPum39+KKvrmDLDgHkE39IiQ==
X-Received: by 2002:a05:600c:4fcf:b0:3eb:3945:d3f1 with SMTP id o15-20020a05600c4fcf00b003eb3945d3f1mr4602527wmq.5.1677511708075;
        Mon, 27 Feb 2023 07:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b003dc1d668866sm13027434wmi.10.2023.02.27.07.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:27 -0800 (PST)
Message-Id: <09140cb2ac53773eae19f06e51d6276e03689fc1.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:15 +0000
Subject: [PATCH v3 08/13] sparse-checkout: avoid using internal API of
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
index 6e4ca6fe800..c8dacd76c5f 100644
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

