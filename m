Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6039C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiKGSgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiKGSg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1126ACF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so17541899wru.8
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNL/PKLtqA4tM5xYWUkVzcVTLyy+kCZ5yTETBBQwE5c=;
        b=chspGvjswddO407jSiwI+Y2/8DsAkHtgq9rQ/UWHbslDAE5wM/HlTXkniM1krOTHZP
         xSpXPRKCSJE5ZCkcARRZ+GAfzM/8RQE/cPBowbL5QOhGPDMfol8o58AAIaBmGxo3zSY6
         otMBjGgGLD0PkzbkL4wL/FK/v9BVzSMocmodfZs47EsyxWxJ1TSoMUK3IH50LPMbmyFX
         O9LQRxxd9B9YDL/huTvK4T6HDf8gJgDN8eLFBKRwZTZXqdNsim/LBV6D68LUsPcw9IVv
         RnjIpy4lBDyxYDugZSJXmrUiG4iG7TvmLfBEO2AMI6eL44IzpqVksT9nDElgvaATkqEj
         6fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNL/PKLtqA4tM5xYWUkVzcVTLyy+kCZ5yTETBBQwE5c=;
        b=BrxLMuuUirb3xAf+CVFQ4HVPgvt7fAQPJv18e3gAwcjCvgp8dPzSY+aVQ5gLx9zX3B
         Z9p8q5CZzpkbKaI9UJZwj6opW0Ln/AU7mR/8czHS9a9Q6m+0gO1UerFgCKgqJ+OiuPGq
         6Av6mgAOn3BLz1VA6KvhuJQUlUylDVnvHpFTcPUoXLU01qcBMKHP4SBywYbEXlmKYlgl
         vrgYSqFa0IQsnMfnNnmEAs5x3P7/xhL9Fzb67y2ddGQGiDXj8XajRDM9L/j28cJBWDEd
         gsGqbY1dnV1X+YHrdR7NE9m3m1BaV3lJlyjuew2A3PMAOm6OYxCakqqxlu+8isiPNiAg
         /ptA==
X-Gm-Message-State: ACrzQf07UL858evbBlxSquvZk6kLjYDlb7bBuEPVZHiKBubPQmc0co+2
        B2SUzfguTw8pMDWQjlUWIEWlMrNqQE0=
X-Google-Smtp-Source: AMsMyM5M3nBpY/ZweaPIz5kyylQ4FD1xXokE9xcywosElzUCEDEtC52fQ0r5g132TWL7ezfbSZUdnA==
X-Received: by 2002:adf:cc92:0:b0:236:77f0:ef5f with SMTP id p18-20020adfcc92000000b0023677f0ef5fmr33181589wrj.198.1667846176435;
        Mon, 07 Nov 2022 10:36:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4f02000000b002366553eca7sm7889447wru.83.2022.11.07.10.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:16 -0800 (PST)
Message-Id: <78e585cf4df2bb82a2569cee226a6b97d0ea7629.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:44 +0000
Subject: [PATCH 10/30] chunk-format: allow trailing table of contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The existing chunk formats use the table of contents at the beginning of
the file. This is intended as a way to speed up the initial loading of
the file, but comes at a cost during writes. Each example needs to fully
compute how big each chunk will be in advance, which usually requires
storing the full file contents in memory.

Future file formats may want to use the chunk format API in cases where
the writing stage is critical to performance, so we may want to stream
updates from an existing file and then only write the table of contents
at the end.

Add a new 'flags' parameter to write_chunkfile() that allows this
behavior. When this is specified, the defensive programming that checks
that the chunks are written with the precomputed sizes is disabled.
Then, the table of contents is written in reverse order at the end of
the hashfile, so a parser can read the chunk list starting from the end
of the file (minus the hash).

The parsing of these table of contents will come in a later change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 chunk-format.c | 53 +++++++++++++++++++++++++++++++++++---------------
 chunk-format.h |  9 ++++++++-
 commit-graph.c |  2 +-
 midx.c         |  2 +-
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index f1b2c8a8b36..3f5cc9b5ddf 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -57,26 +57,31 @@ void add_chunk(struct chunkfile *cf,
 	cf->chunks_nr++;
 }
 
-int write_chunkfile(struct chunkfile *cf, void *data)
+int write_chunkfile(struct chunkfile *cf,
+		    enum chunkfile_flags flags,
+		    void *data)
 {
 	int i, result = 0;
-	uint64_t cur_offset = hashfile_total(cf->f);
 
 	trace2_region_enter("chunkfile", "write", the_repository);
 
-	/* Add the table of contents to the current offset */
-	cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
+	if (!(flags & CHUNKFILE_TRAILING_TOC)) {
+		uint64_t cur_offset = hashfile_total(cf->f);
 
-	for (i = 0; i < cf->chunks_nr; i++) {
-		hashwrite_be32(cf->f, cf->chunks[i].id);
-		hashwrite_be64(cf->f, cur_offset);
+		/* Add the table of contents to the current offset */
+		cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
 
-		cur_offset += cf->chunks[i].size;
-	}
+		for (i = 0; i < cf->chunks_nr; i++) {
+			hashwrite_be32(cf->f, cf->chunks[i].id);
+			hashwrite_be64(cf->f, cur_offset);
 
-	/* Trailing entry marks the end of the chunks */
-	hashwrite_be32(cf->f, 0);
-	hashwrite_be64(cf->f, cur_offset);
+			cur_offset += cf->chunks[i].size;
+		}
+
+		/* Trailing entry marks the end of the chunks */
+		hashwrite_be32(cf->f, 0);
+		hashwrite_be64(cf->f, cur_offset);
+	}
 
 	for (i = 0; i < cf->chunks_nr; i++) {
 		cf->chunks[i].offset = hashfile_total(cf->f);
@@ -85,10 +90,26 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 		if (result)
 			goto cleanup;
 
-		if (hashfile_total(cf->f) - cf->chunks[i].offset != cf->chunks[i].size)
-			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
-			    cf->chunks[i].size, cf->chunks[i].id,
-			    hashfile_total(cf->f) - cf->chunks[i].offset);
+		if (!(flags & CHUNKFILE_TRAILING_TOC)) {
+			if (hashfile_total(cf->f) - cf->chunks[i].offset != cf->chunks[i].size)
+				BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+				    cf->chunks[i].size, cf->chunks[i].id,
+				    hashfile_total(cf->f) - cf->chunks[i].offset);
+		}
+
+		cf->chunks[i].size = hashfile_total(cf->f) - cf->chunks[i].offset;
+	}
+
+	if (flags & CHUNKFILE_TRAILING_TOC) {
+		size_t last_chunk_tail = hashfile_total(cf->f);
+		/* First entry marks the end of the chunks */
+		hashwrite_be32(cf->f, 0);
+		hashwrite_be64(cf->f, last_chunk_tail);
+
+		for (i = cf->chunks_nr - 1; i >= 0; i--) {
+			hashwrite_be32(cf->f, cf->chunks[i].id);
+			hashwrite_be64(cf->f, cf->chunks[i].offset);
+		}
 	}
 
 cleanup:
diff --git a/chunk-format.h b/chunk-format.h
index 7885aa08487..39e8967e950 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -31,7 +31,14 @@ void add_chunk(struct chunkfile *cf,
 	       uint32_t id,
 	       size_t size,
 	       chunk_write_fn fn);
-int write_chunkfile(struct chunkfile *cf, void *data);
+
+enum chunkfile_flags {
+	CHUNKFILE_TRAILING_TOC = (1 << 0),
+};
+
+int write_chunkfile(struct chunkfile *cf,
+		    enum chunkfile_flags flags,
+		    void *data);
 
 int read_table_of_contents(struct chunkfile *cf,
 			   const unsigned char *mfile,
diff --git a/commit-graph.c b/commit-graph.c
index a7d87559328..c927b81250d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1932,7 +1932,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			get_num_chunks(cf) * ctx->commits.nr);
 	}
 
-	write_chunkfile(cf, ctx);
+	write_chunkfile(cf, 0, ctx);
 
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
diff --git a/midx.c b/midx.c
index 7cfad04a240..03d947a5d33 100644
--- a/midx.c
+++ b/midx.c
@@ -1510,7 +1510,7 @@ static int write_midx_internal(const char *object_dir,
 	}
 
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
-	write_chunkfile(cf, &ctx);
+	write_chunkfile(cf, 0, &ctx);
 
 	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
-- 
gitgitgadget

