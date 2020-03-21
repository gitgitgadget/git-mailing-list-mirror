Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6638C54EEB
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F26E2076E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuv+OtFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCUSAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40460 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgCUSAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id w26so4784593edu.7
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=28CBGCc9yqawaGf7vDwPQ6wbL0r+yoh8g33EFa5YymI=;
        b=fuv+OtFAKemf5pyq7lxigCgPPJ0JbiDWqK+2XDIKy7a4kDQ4UpvZeYsvBh4HDHJ7M4
         RSMTzTJx4Iy96a40b/FD7dObKIQy+vfXSsXj4Vzz5mr1kqL5aKawpl2R9nmKrva1j7LQ
         UOp2T/CkGgkBvTKtpkMGvVIlb+BE95Nt8L3cK9baGY6RxaIE4OYwbYKhmUlES8eHf1ZW
         PZRejNOna1YRrYSSry62Fw5epJhynTrkhY4uFYoGgNeO57rp26kzNrq0WbEHIOo6rEwH
         PsaLFNqHvd6mgVu/9TPq1cje/EfENmWG585FUWRVbM7pagMT+OjfXAvNxd+P1lBeWSJk
         htag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=28CBGCc9yqawaGf7vDwPQ6wbL0r+yoh8g33EFa5YymI=;
        b=i15ccRghom32XwROw3LMfKXTBle1MXT2WI12gCFaNuTHcxQ8N3BaNYVaNBZlao5AWF
         ymMkHVY2htevCHrVTw9tdZQER2hBqy1J6qQnBtZEQvaPNizn5qEYUOsndWtZfrCtnVbO
         6G/xRj56UltiKwMkOlXHiuam7EjMoCDR3RurdrR8Mw5UKdtJmTyx2acenDYrdXKRgxFw
         jzFLdGTetaD6fXql+oHuc4uuAoe6Y6DSW7D3opYZSK2LyFnykwz+aChjPLQKkoej5TMr
         ijSrXv+2t9zngUMzZlQNBtUmxRisrkp3KaOuVKEfhOEl8fo8l9Ebn+D4Iq9MRXB8dWSi
         QFcQ==
X-Gm-Message-State: ANhLgQ2Wk7rgGTMq853ecG7/fEDI94ImIL2uBFT6kZP/RMdbqxe10N4Y
        vJpCo/bhsDKV676MRLpNXcgJ1olt
X-Google-Smtp-Source: ADFU+vuEPpuv3X4pVtHOc/WuZILREsdTP23DGEh3YMDAIVXtxwhlDBYO6mUuFThcO1ox8ViwUzxCXg==
X-Received: by 2002:a50:a7a6:: with SMTP id i35mr13750038edc.130.1584813613322;
        Sat, 21 Mar 2020 11:00:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm597421ejx.16.2020.03.21.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:12 -0700 (PDT)
Message-Id: <65772dd46df12d79a41e7ed2d6e1fc197b80d379.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:55 +0000
Subject: [PATCH v2 04/18] unpack-trees: simplify pattern_list freeing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit e091228e17 ("sparse-checkout: update working directory
in-process", 2019-11-21) allowed passing a pre-defined set of patterns
to unpack_trees().  However, if o->pl was NULL, it would still read the
existing patterns and use those.  If those patterns were read into a
data structure that was allocated, naturally they needed to be free'd.
However, despite the same function being responsible for knowing about
both the allocation and the free'ing, the logic for tracking whether to
free the pattern_list was hoisted to an outer function with an
additional flag in unpack_trees_options.  Put the logic back in the
relevant function and discard the now unnecessary flag.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 -
 unpack-trees.c            | 6 ++++--
 unpack-trees.h            | 3 +--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 740da4b6d54..d102a9697fd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -122,7 +122,6 @@ static int update_working_directory(struct pattern_list *pl)
 	o.dst_index = r->index;
 	o.skip_sparse_checkout = 0;
 	o.pl = pl;
-	o.keep_pattern_list = !!pl;
 
 	resolve_undo_clear_index(r->index);
 	setup_work_tree();
diff --git a/unpack-trees.c b/unpack-trees.c
index 3af2e126abf..d2863fa0310 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1503,6 +1503,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
+	int free_pattern_list = 0;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -1519,6 +1520,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		else
 			o->pl = &pl;
 		free(sparse);
+		free_pattern_list = 1;
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
@@ -1686,9 +1688,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 
 done:
-	trace_performance_leave("unpack_trees");
-	if (!o->keep_pattern_list)
+	if (free_pattern_list)
 		clear_pattern_list(&pl);
+	trace_performance_leave("unpack_trees");
 	return ret;
 
 return_failed:
diff --git a/unpack-trees.h b/unpack-trees.h
index 6d7c7b6c2e0..d3516267f36 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -58,8 +58,7 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run,
-		     keep_pattern_list;
+		     dry_run;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
gitgitgadget

