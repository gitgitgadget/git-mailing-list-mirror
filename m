Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC48FC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjBWJPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjBWJPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44C38EB8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:06 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k37so5118054wms.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJhf7dQDATYC8458SdQ5AfO6WHa/J8BLTw9GkB4B6u4=;
        b=WEb5l2PA8KRIpsCOEVImQCDBr77A/6We1xhKgEScUqRMSKmqG1rRaGHOdsQ79hX/lh
         seEOpt/uIA6yq+z1TZ3ICiDX+a1T29xQjciVunEy8pJoFmen/VO3BKu5ZgoDgJoTht2R
         HxTxalNzotJnEPLOTl53SOtN3ItbyoXsLxk9c4pXVtb/Iq9xPhtb8yg52/nVGH2kAm5J
         WChfqH+aNwaroBIEKR7pnH5pLMwhMP+8+jgJlF4eDmPJQ7JPgXvMW5DpLxzPDv7n8BpY
         w018udL8+1U1Ze3ZFNpkK97++xszYPXCGB1FxU7PMloHV1tqwupbNe4dqx20fh5gRCeO
         SEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJhf7dQDATYC8458SdQ5AfO6WHa/J8BLTw9GkB4B6u4=;
        b=L+2RLf3q/I/wGdRV04wqEMm3Jtww7OnZl5zwYls20R2vwxuF39oUQXOP0z6F4KdS95
         HzF+sD1dbjjlLRM6rq2AWrv0kUwmYU5uQhmQkoSmUO/3CRIoQQ5cvdaLaartznmhGmfi
         pPE0jWQajIu8HFUdnWe71yGyF3e0K2MGVjAgVF4JtHRBnmqLY8u5Ymzon5Dm1mgL6jiA
         kdYCyE+wWI/F2Dqq5gJs2ddqFJw436bVoTwGam8qLqVtsq7AVBu5ZCKvaH7uPKKc4AeT
         mfrjpBLBH14HUD3xTWEv31Sf6P0DYYf2Qyy27kIEb+69hWOJ4XuTkaQ+Qn5OGCB33ooQ
         Eg0g==
X-Gm-Message-State: AO0yUKWcfa4YOlM5H6vRHBJhjj9KWpHwzEcB6P0uvrOZ6DH2RJ5DdTYC
        OVnROzZ851DerFuVpGed1/cdDfDWoy4=
X-Google-Smtp-Source: AK7set8jWhh66YSVq4Aq4Mp0VjDvYr0co48LIaHeUOvn+GR1P5+XD3hZWgC5MrZGcqPqSN63MQZlOQ==
X-Received: by 2002:a05:600c:1818:b0:3e8:96d9:579f with SMTP id n24-20020a05600c181800b003e896d9579fmr4859069wmp.40.1677143704799;
        Thu, 23 Feb 2023 01:15:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm8405765wro.92.2023.02.23.01.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:04 -0800 (PST)
Message-Id: <508837fc182b0adba96c3fcbd468f47f8f0a0aef.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:54 +0000
Subject: [PATCH 05/11] sparse-checkout: avoid using internal API of
 unpack-trees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 unpack-trees.c            | 17 ++++++++++-------
 unpack-trees.h            |  3 ++-
 3 files changed, 13 insertions(+), 10 deletions(-)

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
index 0887d157df4..d9c9f330233 100644
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
@@ -2147,8 +2148,10 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 
 	display_warning_msgs(o);
 	o->show_all_errors = old_show_all_errors;
-	if (free_pattern_list)
-		clear_pattern_list(&pl);
+	if (free_pattern_list) {
+		clear_pattern_list(pl);
+		free(pl);
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

