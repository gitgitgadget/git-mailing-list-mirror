Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13679C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF8020723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnyZ0eun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgE2Ivw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgE2Ivk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC25C08C5D1
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so2613132wro.1
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/A29Mh3EQ2rOKDAMMIAdW+Wb9CGT8wULU5GEW01rZdA=;
        b=mnyZ0eunFnpNpHALPcyMyeAd2tfjL9JaGQr1q67o1n2WXczmamjvERxX2cR34WlgJh
         Lja7LYoUZe7PMEIyw7PdEPJYWCrJw+QnMH31ED+Sa+jggigRmdGAzLX6HrfIrD8wrKFB
         CJ4hUhhZuIaqzqqw8+uWJRzwxgIBzdYbuSQPVibz50ZH/x1dkILZbLis1nv36X5z1D6r
         vod3NxU/up7rfZlF+LemF+iv/eTIbGCre4ZdXlFueQWWYx8NXbgR9mq3CQwUKnMDYhLw
         m+Iq8ApuDTRzbGfj+wNkqpYJ8wt5U5mhcBdT+1wbK7q8tkBGiiaqTNaoH6pHvITVAVns
         lbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/A29Mh3EQ2rOKDAMMIAdW+Wb9CGT8wULU5GEW01rZdA=;
        b=eTpovHQfvqDHb7+Zuc8wMQk4RGJsRlgJfv2TgueXko5xvDBb0mPVb9zTdyzTHVS0+g
         mov+4PWJIhEEWBsaEIO0clnrS1KqEcpGN2Oz7+w62SxuKAUL/QrKTeYUao7yViBix6Tq
         ggD1s9h3cCe8wmp5q285hzDVaMhqsT6TH/05fw7IowLFPk/eTu8OQ2e4/FrmqZJNEh/T
         lf2XQtt/hE19TJjy/hx4DH68kQRnRHmZluMTDcETJlVSk9pRw6aBDlrfVuSBC/Y3uNhj
         MxqAdytly9a+0XhXYFj+1hsY8kvp+Z+NafP79JmQ2OI48IQE1PH0qVK/tewWf7dRI9XN
         JzLA==
X-Gm-Message-State: AOAM533ILLq6uuFJw217IjTh5z7aeORKEERnYH//pEZAJWLJsNU30OpD
        XwSJbd6siZtxjt8c3cI65beD5/KB
X-Google-Smtp-Source: ABdhPJzm+YVWWBYH4C+ImJJfvWgg4A3g1s1b8Rx6w8m44jaL+PC0I3sNcnKYclitAIwc/CMGLz8wvQ==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr8147685wrt.150.1590742297848;
        Fri, 29 May 2020 01:51:37 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 26/34] commit-graph: deduplicate modified path Bloom filters
Date:   Fri, 29 May 2020 10:50:30 +0200
Message-Id: <20200529085038.26008-27-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commits modify the same set of paths, and, consequently, have
identical modified path Bloom filters.

Use a hashmap to find these identical Bloom filters, and omit all
duplicates from the Modified Path Bloom Filters chunk, reducing its
size.

                   MPBF chunk size
                 without       with             Time spent
                    deduplication                deduping
  --------------------------------------------------------
  android-base   8620198     2618764    -69.6%    0.089s
  cmssw         10347018     9094468    -12.1%    0.056s
  cpython         526381      371629    -29.4%    0.013s
  elasticsearch  4733274     3607106    -23.8%    0.029s
  gcc            3724544     3394521     -8.9%    0.072s
  gecko-dev     20591010    17042732    -17.2%    0.235s
  git             160718      139546    -13.2%    0.004s
  glibc           759132      699623     -7.8%    0.009s
  go              458375      421394     -8.1%    0.008s
  jdk           13213208    12158533     -8.0%    0.034s
  linux         26575278    25029700     -5.8%    0.169s
  llvm-project   3988133     3269438    -18.0%    0.085s
  rails           958691      614528    -35.9%    0.015s
  rust           1985782     1682919    -15.3%    0.023s
  tensorflow     4173570     3789768     -9.2%    0.022s
  webkit         5891751     5394507     -8.4%    0.096s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 56b8f33d10..178bbf0113 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -57,6 +57,7 @@
 
 struct modified_path_bloom_filter_info {
 	struct bloom_filter filter;
+	struct modified_path_bloom_filter_info *duplicate_of;
 	/*
 	 * The offset relative to the start of the Modified Path Bloom
 	 * Filters chunk where this Bloom filter has been written,
@@ -1099,6 +1100,9 @@ struct write_commit_graph_context {
 
 		/* Excluding embedded modified path Bloom filters */
 		uint64_t total_filter_size;
+
+		/* Used to find identical modified path Bloom filters */
+		struct hashmap dedup_hashmap;
 	} mpbfctx;
 };
 
@@ -1315,7 +1319,11 @@ static int write_graph_chunk_modified_path_bloom_filters(struct hashfile *f,
 		bfi = modified_path_bloom_filters_peek(
 				&modified_path_bloom_filters, commit);
 
-		if (!bfi || !bfi->filter.nr_bits)
+		if (!bfi)
+			continue;
+		if (bfi->duplicate_of)
+			continue;
+		if (!bfi->filter.nr_bits)
 			continue;
 		if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS)
 			continue;
@@ -1364,6 +1372,9 @@ static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
 			 */
 			filterdata[0] |= 1 << 7;
 			hashwrite(f, filterdata, sizeof(filterdata));
+		} else if (bfi->duplicate_of) {
+			uint64_t offset = htonll(bfi->duplicate_of->offset);
+			hashwrite(f, &offset, sizeof(offset));
 		} else if (bfi->offset != -1) {
 			uint64_t offset = htonll(bfi->offset);
 			hashwrite(f, &offset, sizeof(offset));
@@ -1515,6 +1526,53 @@ static void file_change_cb(struct diff_options *options,
 	handle_modified_file(options->change_fn_data, fullpath);
 }
 
+struct modified_path_bloom_filter_dedup_entry {
+	struct hashmap_entry entry;
+	struct modified_path_bloom_filter_info *bfi;
+};
+
+static int modified_path_bloom_filter_dedup_cmp(const void *unused_cmp_data,
+		const struct hashmap_entry *he1,
+		const struct hashmap_entry *he2,
+		const void *unused_keydata)
+{
+	const struct modified_path_bloom_filter_dedup_entry *a, *b;
+
+	a = container_of(he1, const struct modified_path_bloom_filter_dedup_entry, entry);
+	b = container_of(he2, const struct modified_path_bloom_filter_dedup_entry, entry);
+
+	if (a->bfi->filter.nr_bits != b->bfi->filter.nr_bits)
+		return 1;
+
+	return memcmp(a->bfi->filter.bits, b->bfi->filter.bits,
+		      bloom_filter_bytes(&a->bfi->filter));
+}
+
+static int handle_duplicate_modified_path_bloom_filter(
+		struct modified_path_bloom_filter_context *mpbfctx,
+		struct modified_path_bloom_filter_info *bfi)
+{
+	struct modified_path_bloom_filter_dedup_entry *e, stack_entry;
+	unsigned int h;
+
+	h = memhash(bfi->filter.bits, bloom_filter_bytes(&bfi->filter));
+	hashmap_entry_init(&stack_entry.entry, h);
+	stack_entry.bfi = bfi;
+
+	e = hashmap_get_entry(&mpbfctx->dedup_hashmap, &stack_entry, entry,
+			      NULL);
+	if (e) {
+		bfi->duplicate_of = e->bfi;
+		return 1;
+	} else {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(&e->entry, h);
+		e->bfi = bfi;
+		hashmap_add(&mpbfctx->dedup_hashmap, &e->entry);
+		return 0;
+	}
+}
+
 static void create_modified_path_bloom_filter(
 		struct modified_path_bloom_filter_context *mpbfctx,
 		struct commit *commit)
@@ -1547,17 +1605,20 @@ static void create_modified_path_bloom_filter(
 	bfi = modified_path_bloom_filters_at(&modified_path_bloom_filters,
 					     commit);
 	bfi->offset = -1;
-	if (path_component_count > mpbfctx->embedded_limit) {
+	if (path_component_count > mpbfctx->embedded_limit)
 		bloom_filter_init(&bfi->filter, mpbfctx->num_hashes,
 				  path_component_count);
-		mpbfctx->total_filter_size += sizeof(uint32_t) +
-					      bloom_filter_bytes(&bfi->filter);
-	} else
+	else
 		bloom_filter_init_with_size(&bfi->filter,
 				GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS);
 
 	bloom_filter_set_bits(&bfi->filter, mpbfctx->hashes,
 			      mpbfctx->hashes_nr);
+
+	if (path_component_count > mpbfctx->embedded_limit &&
+	    !handle_duplicate_modified_path_bloom_filter(mpbfctx, bfi))
+		mpbfctx->total_filter_size += sizeof(uint32_t) +
+					      bloom_filter_bytes(&bfi->filter);
 }
 
 static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
@@ -2396,6 +2457,8 @@ int write_commit_graph(const char *obj_dir,
 		diff_setup_done(&ctx->mpbfctx.diffopt);
 
 		strbuf_init(&ctx->mpbfctx.prev_path, PATH_MAX);
+		hashmap_init(&ctx->mpbfctx.dedup_hashmap,
+			     modified_path_bloom_filter_dedup_cmp, NULL, 0);
 	}
 
 	if (ctx->split) {
@@ -2525,6 +2588,9 @@ int write_commit_graph(const char *obj_dir,
 		strbuf_release(&ctx->mpbfctx.prev_path);
 		free(ctx->mpbfctx.hashed_prefix_lengths);
 		free(ctx->mpbfctx.hashes);
+		hashmap_free_entries(&ctx->mpbfctx.dedup_hashmap,
+				struct modified_path_bloom_filter_dedup_entry,
+				entry);
 	}
 
 	free(ctx);
-- 
2.27.0.rc1.431.g5c813f95dc

