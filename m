Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2951F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfEHPyD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41754 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfEHPx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so22540270edd.8
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WApkO7gw8Q6Vx5z25239OQBkt/ImHB6i0jsiyxFuzMw=;
        b=ST7Wlosu7auY/7hZmvBrlR/InwqmAc/K+AOxXKTMh040351dbrrzCCIPRrkQG20gN2
         JT4Q/yAX9j8nnCwdckRmXOKD4TApXbji7NxaBTMpy5p8YEEbZq86lr4kavcx0sCH/x8L
         duGtsPH6+Fkogjh49EuDV2xQSDKI5cgSfSDe4lvm1Jm1joh8NG0uOOCnzUf7jJlxg5hg
         zOPpWJokJ5x25PXRxIf277JshLNHUbbtM78HD96/SFdQpxhZz+jrcuCAnRtnWG54sUtM
         42w7kpzuhiXJCZ3O19RVfJtSvKjZSjC4exWU3nT1hPLLxdRo8VxlzH530eNmk/ha2m8h
         OIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WApkO7gw8Q6Vx5z25239OQBkt/ImHB6i0jsiyxFuzMw=;
        b=tXWjnZy8DTr2Q7poWY+DDoyO4kX4SF1YP8hdRCrq99MRgjEeMpfMojhtsE/GLRiysZ
         U+gA5vf4fMNrIsaJHj5yuNWeIzDZ8lwPWFRETHCVMub/22owwXiYZ7iyxAG92R9aumbS
         OQxI1Ybmr+j9JTdmyNH2hFFn8fqqMitcyizvBJLd3WuKaEkB8xDg77418G8R6xGyogRR
         g0cf2rOhTiPbwTIFa0DWSr0mi8WYHFvKWz8iysjR7iGEJsZwScHPl+OwYbMDJF25jr6D
         hOrsj8E9QrsHlTm59yBp9WdO7zpVBu17T7k0Q34IAeGCmVSvcZU4TP2+vDgMhVJhRE50
         VqGg==
X-Gm-Message-State: APjAAAVK2AQ1Sr3r0D1z1a+KLYg1UJ2lxi64o2zhp2dYNNZqpO5yTC/A
        yR8MV34HBwZPtEAKJxUO+CDozd9VuCU=
X-Google-Smtp-Source: APXvYqwl1m4Vn0UBSGpHpuaPXYyt7nIaYNWTXkLT05BEbSFIqDJA5tUE+xMxnGT63b7nUmPKMDxw4Q==
X-Received: by 2002:a05:6402:1256:: with SMTP id l22mr41019931edw.22.1557330837057;
        Wed, 08 May 2019 08:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g30sm3500737edg.57.2019.05.08.08.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:56 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:56 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:40 GMT
Message-Id: <3eee3667cf32c1049fa1f39264d36a33aa31d0f0.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/17] commit-graph: extract write_commit_graph_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

Extract write_commit_graph_file() that takes all of the information
in the context struct and writes the data to a commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 155 +++++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 75 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 16cdd7afb2..7723156964 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1015,21 +1015,91 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-int write_commit_graph(const char *obj_dir,
-		       struct string_list *pack_indexes,
-		       struct string_list *commit_hex,
-		       unsigned int flags)
+static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
-	struct write_commit_graph_context *ctx;
+	uint32_t i;
 	struct hashfile *f;
-	uint32_t i, count_distinct = 0;
-	char *graph_name = NULL;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
-	int num_chunks;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
+	int num_chunks = ctx->num_extra_edges ? 4 : 3;
+
+	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+	if (safe_create_leading_directories(ctx->graph_name)) {
+		UNLEAK(ctx->graph_name);
+		error(_("unable to create leading directories of %s"),
+			ctx->graph_name);
+		return errno;
+	}
+
+	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
+	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+
+	hashwrite_be32(f, GRAPH_SIGNATURE);
+
+	hashwrite_u8(f, GRAPH_VERSION);
+	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, 0); /* unused padding byte */
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	if (ctx->num_extra_edges)
+		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
+	else
+		chunk_ids[3] = 0;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
+
+	for (i = 0; i <= num_chunks; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		hashwrite(f, chunk_write, 12);
+	}
+
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Writing out commit graph in %d pass",
+			       "Writing out commit graph in %d passes",
+			       num_chunks),
+			    num_chunks);
+		ctx->progress = start_delayed_progress(
+			progress_title.buf,
+			num_chunks * ctx->commits.nr);
+	}
+	write_graph_chunk_fanout(f, ctx);
+	write_graph_chunk_oids(f, hashsz, ctx);
+	write_graph_chunk_data(f, hashsz, ctx);
+	if (ctx->num_extra_edges)
+		write_graph_chunk_extra_edges(f, ctx);
+	stop_progress(&ctx->progress);
+	strbuf_release(&progress_title);
+
+	close_commit_graph(ctx->r);
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	commit_lock_file(&lk);
+
+	return 0;
+}
+
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       unsigned int flags)
+{
+	struct write_commit_graph_context *ctx;
+	uint32_t i, count_distinct = 0;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
@@ -1096,75 +1166,10 @@ int write_commit_graph(const char *obj_dir,
 
 	compute_generation_numbers(ctx);
 
-	num_chunks = ctx->num_extra_edges ? 4 : 3;
-
-	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
-	if (safe_create_leading_directories(ctx->graph_name)) {
-		UNLEAK(ctx->graph_name);
-		error(_("unable to create leading directories of %s"),
-			ctx->graph_name);
-		res = errno;
-		goto cleanup;
-	}
-
-	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
-	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
-
-	hashwrite_be32(f, GRAPH_SIGNATURE);
-
-	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0); /* unused padding byte */
-
-	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
-	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
-	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (ctx->num_extra_edges)
-		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
-	else
-		chunk_ids[3] = 0;
-	chunk_ids[4] = 0;
-
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
-
-	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunk_ids[i]);
-		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
-		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
-	}
-
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Writing out commit graph in %d pass",
-			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
-		ctx->progress = start_delayed_progress(
-			progress_title.buf,
-			num_chunks * ctx->commits.nr);
-	}
-	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
-	if (ctx->num_extra_edges)
-		write_graph_chunk_extra_edges(f, ctx);
-	stop_progress(&ctx->progress);
-	strbuf_release(&progress_title);
-
-	close_commit_graph(ctx->r);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-	commit_lock_file(&lk);
+	res = write_commit_graph_file(ctx);
 
 cleanup:
-	free(graph_name);
+	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
 	free(ctx);
-- 
gitgitgadget

