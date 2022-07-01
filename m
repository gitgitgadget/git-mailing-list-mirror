Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E493C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiGAKne (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiGAKnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236276463
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k22so2607361wrd.6
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKJPLVAPTJz40GZzZuBwXr50VdnAlTsZdENxepQOPks=;
        b=ogEMUmH0cnGJ/gZCornl6CEcYBQBW8QT6Qw7IRGzhuYuppeaXvvApIY8cMEg6HpDyB
         Pj/Onx/jjFlDXG7tWN6nGcMjfmtLSSG3TCjooVryX8xa7JGvXYP9kpZtFpYW05tZD0LI
         NvZlByTw64FjARlPrV7JKaGR6nA1Rl0eOFPv81xIUD3YDSEj6xWGkb3Nq8Wr+L6NX6Gi
         ymw7P/pxZ3LkFcSHeoEWqINUkypQNSKyjloSVWjxnvXiOT+uE2dL1CN50RPsFg/+mVfZ
         E9oLdJ3aPuju41oKTvLFp/DbY/7ji4jBBc1H7st8x3ldbuHpN/KqSoRLCw4pfTLSoySu
         WzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKJPLVAPTJz40GZzZuBwXr50VdnAlTsZdENxepQOPks=;
        b=2Cy4/eWnOChN30oxj6QVBa/E7suUlE3PTIUJeMf692KNHcHK3vBZkcwQVauQ+rY31u
         F7MgCIcNhtbIXrHHctjoJQUqyqYtM5KkuaCcGxFuTEsLQ2FUZjMiCQAqoPSLaVpQ6BMA
         2ta2Z08zzeT4wf3JjQ4726Gz9GfscRUaMimsatpe+6P0+0r49qSDIt9G0iHinY9WBsUr
         XXRiJinJhMivtEM5ENHX9qUjxDU5ETp7BqezQeKcQF3iEK+flS6NPWEJvkzz4N3+B6HB
         8YeN1LnXDhwDJ+rsIdCSTEgNOEwTMCtFjxFDEfqo29+eDEWemlWHPe4d0akaMAWYQkjr
         6fWQ==
X-Gm-Message-State: AJIora/neuV1EsxKAX7+AnV5pJj0EfkTMIIBmrLRKb2Mcp/eGmKdWu9I
        zcI3p7P/rjS5fmr3Y+xE9VTgmIkAd5K8LQ==
X-Google-Smtp-Source: AGRyM1udQyDtsMuHuFfj8b4E7u6JIB1dTMEa8gDjVEyQ0rnubP59OZME7mDgv2jQmfUOo7ZqgZBnbw==
X-Received: by 2002:a5d:64c3:0:b0:21d:1d20:6f6a with SMTP id f3-20020a5d64c3000000b0021d1d206f6amr13710044wri.371.1656672190390;
        Fri, 01 Jul 2022 03:43:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] checkout: avoid "struct unpack_trees_options" leak
Date:   Fri,  1 Jul 2022 12:42:57 +0200
Message-Id: <patch-v2-08.11-e21d7e4e9df-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1c41d2805e4 (unpack_trees_options: free messages when done,
2018-05-21) we started calling clear_unpack_trees_porcelain() on this
codepath, but missed this error path.

We could call clear_unpack_trees_porcelain() just before we error()
and return when unmerged_cache() fails, but the more correct fix is to
not have the unmerged_cache() check happen in the middle of our
"topts" setup.

Before 23cbf11b5c0 (merge-recursive: porcelain messages for checkout,
2010-08-11) we would not malloc() to setup our "topts", which is when
this started to leak on the error path.

Before that this code wasn't conflating the setup of "topts" and the
unmerged_cache() call in any meaningful way. The initial version in
782c2d65c24 (Build in checkout, 2008-02-07) just does a "memset" of
it, and initializes a single struct member.

Then in 8ccba008ee3 (unpack-trees: allow Porcelain to give different
error messages, 2008-05-17) we added the initialization of the error
message, which as noted above finally started leaking in 23cbf11b5c0.

Let's fix the memory leak, and avoid future issues by initializing the
"topts" with a helper function. There are no functional changes here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2eefda81d8c..1109f1301f4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -710,6 +710,26 @@ static void setup_branch_path(struct branch_info *branch)
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
+static void init_topts(struct unpack_trees_options *topts, int merge,
+		       int show_progress, int overwrite_ignore,
+		       struct commit *old_commit)
+{
+	memset(topts, 0, sizeof(*topts));
+	topts->head_idx = -1;
+	topts->src_index = &the_index;
+	topts->dst_index = &the_index;
+
+	setup_unpack_trees_porcelain(topts, "checkout");
+
+	topts->initial_checkout = is_cache_unborn();
+	topts->update = 1;
+	topts->merge = 1;
+	topts->quiet = merge && old_commit;
+	topts->verbose_update = show_progress;
+	topts->fn = twoway_merge;
+	topts->preserve_ignored = !overwrite_ignore;
+}
+
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
@@ -740,13 +760,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		struct unpack_trees_options topts;
 		const struct object_id *old_commit_oid;
 
-		memset(&topts, 0, sizeof(topts));
-		topts.head_idx = -1;
-		topts.src_index = &the_index;
-		topts.dst_index = &the_index;
-
-		setup_unpack_trees_porcelain(&topts, "checkout");
-
 		refresh_cache(REFRESH_QUIET);
 
 		if (unmerged_cache()) {
@@ -755,17 +768,12 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 
 		/* 2-way merge to the new branch */
-		topts.initial_checkout = is_cache_unborn();
-		topts.update = 1;
-		topts.merge = 1;
-		topts.quiet = opts->merge && old_branch_info->commit;
-		topts.verbose_update = opts->show_progress;
-		topts.fn = twoway_merge;
+		init_topts(&topts, opts->merge, opts->show_progress,
+			   opts->overwrite_ignore, old_branch_info->commit);
 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
-		topts.preserve_ignored = !opts->overwrite_ignore;
 
 		old_commit_oid = old_branch_info->commit ?
 			&old_branch_info->commit->object.oid :
-- 
2.37.0.900.g4d0de1cceb2

