Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717F5C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBYC0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBYC0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD923D0BA
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 6so1023250wrb.11
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbPFkOGqLJfYTC+AoVHTpIIVdv5YX0IKK3PurL7z8Jk=;
        b=IDLlxuikVoezf18Agr0XSLx328Tx6wv4ZT1xfnXeZhtGaf8RC9xuDKV6mnHpephpPt
         WEpLbQtOAONUo9VxW67ZDIBGZM2Kj8FaeSKOUCYY+F/g0dsxk7kwZ6SuPD6QoVOKDHwF
         FMoNqunranyJGErWCw52fx0rNBpmK8cawgRvH1+g0vgwhjP/Qb2ForzlDmGWVR4xDJw/
         G0KvhIAgWyi6osErS6TOjG+SFfXFHuaDgYHCkiUvYrQa4+Eqtdo8brQdDQWLMxfbHq7j
         R6pHwoPGPkGbImVRfazFUsVwnsV9wPZzHTdBc+KGffgeDL8H0dxU9wGhhSD4lFiCbgT6
         tx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbPFkOGqLJfYTC+AoVHTpIIVdv5YX0IKK3PurL7z8Jk=;
        b=dUOcqORMlalstuc85FrUbXvB+J5jstafyRcO7oZxe4UlBHURxPdszwFCb+vXazYsfQ
         i0N4sFUAQGZu41WDVySi/EeUrWBIbFwdEFeOS4JM2+1qbV+2bcVAKnI/QK8JTKlo9+Hw
         Rp3/ccwBTVhJ8u0T4WbkNefzpk09N2uk4cyan0co1v8hFtMftODbM6mpbOl4exLaYkYI
         KkcIODdD6+x+yqUxsUoGvWVG5zFr96e1C7SWaaS8PTaBj/tJBY4U5ihvVVxcQzuISh72
         3a2MgMxv4OEwbE1ctv7CNMYibjOvjURW1Y6IUZhOoRwTkWCTYPg2uqWvBo2x2GLipMFQ
         Hwow==
X-Gm-Message-State: AO0yUKVg40qhs6bkKdRixF/kyhniXVRq+PDzzOumDCWUGAFEtNZ++QOb
        tzBO9joRCILQOsH8mAGugxr8nUqwxnY=
X-Google-Smtp-Source: AK7set8maj3tdMRycn3WPqnHKBqFJPpsnjt50Y68a1SfYXOTR71sDUFHQ5n7k6LHKGo2Qw/fuTMzjg==
X-Received: by 2002:adf:f208:0:b0:2c8:4bca:7fc6 with SMTP id p8-20020adff208000000b002c84bca7fc6mr1564459wro.62.1677291966921;
        Fri, 24 Feb 2023 18:26:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b003eafc47eb09sm918174wmb.43.2023.02.24.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:06 -0800 (PST)
Message-Id: <975dec0f0ebaf72f0e5f5b5379f3d1b761045d2f.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:54 +0000
Subject: [PATCH v2 05/11] sparse-checkout: avoid using internal API of
 unpack-trees
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

struct unpack_trees_options has the following field and comment:

	struct pattern_list *pl; /* for internal use */

Despite the internal-use comment, commit e091228e17 ("sparse-checkout:
update working directory in-process", 2019-11-21) starting setting this
field from an external caller.  At the time, the only way around that
would have been to modify unpack_trees() to take an extra pattern_list
argument, and there's a lot of callers of that function.  However, when
we split update_sparsity() off as a separate function, with
sparse-checkout being the sole caller, the need to update other callers
went away.  Fix this API problem by adding a pattern_list argument to
update_sparsity() and stop setting the internal o.pl field directly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c |  3 +--
 unpack-trees.c            | 18 +++++++++++-------
 unpack-trees.h            |  3 ++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index c3738154918..4b7390ce367 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -219,14 +219,13 @@ static int update_working_directory(struct pattern_list *pl)
 	o.dst_index = r->index;
 	index_state_init(&o.result, r);
 	o.skip_sparse_checkout = 0;
-	o.pl = pl;
 
 	setup_work_tree();
 
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
 	setup_unpack_trees_porcelain(&o, "sparse-checkout");
-	result = update_sparsity(&o);
+	result = update_sparsity(&o, pl);
 	clear_unpack_trees_porcelain(&o);
 
 	if (result == UPDATE_SPARSITY_WARNINGS)
diff --git a/unpack-trees.c b/unpack-trees.c
index 0887d157df4..639e48cc6bb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2091,10 +2091,10 @@ return_failed:
  *
  * CE_NEW_SKIP_WORKTREE is used internally.
  */
-enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
+enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
+					    struct pattern_list *pl)
 {
 	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
-	struct pattern_list pl;
 	int i;
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
@@ -2111,11 +2111,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 	trace_performance_enter();
 
 	/* If we weren't given patterns, use the recorded ones */
-	if (!o->pl) {
-		memset(&pl, 0, sizeof(pl));
+	if (!pl) {
 		free_pattern_list = 1;
-		populate_from_existing_patterns(o, &pl);
+		pl = xcalloc(1, sizeof(*pl));
+		populate_from_existing_patterns(o, pl);
 	}
+	o->pl = pl;
 
 	/* Expand sparse directories as needed */
 	expand_index(o->src_index, o->pl);
@@ -2147,8 +2148,11 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 
 	display_warning_msgs(o);
 	o->show_all_errors = old_show_all_errors;
-	if (free_pattern_list)
-		clear_pattern_list(&pl);
+	if (free_pattern_list) {
+		clear_pattern_list(pl);
+		free(pl);
+		o->pl = NULL;
+	}
 	trace_performance_leave("update_sparsity");
 	return ret;
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index 3a7b3e5f007..f3a6e4f90ef 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -112,7 +112,8 @@ enum update_sparsity_result {
 	UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
 };
 
-enum update_sparsity_result update_sparsity(struct unpack_trees_options *options);
+enum update_sparsity_result update_sparsity(struct unpack_trees_options *options,
+					    struct pattern_list *pl);
 
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
-- 
gitgitgadget

