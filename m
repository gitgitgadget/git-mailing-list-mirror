Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17AEC352A2
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81782214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAUNvZX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBEW4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37945 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBEW4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so4791777wmj.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2TLBjdWLrXSfqSUr6v2jJ7iqQPtYG/lF7TdWsMjx+Q0=;
        b=iAUNvZX2B7mj4EUdyL4vrrTNhGleB1kdyUf4H536qCP9aCzSbnADduscpuRz3JdhQr
         Mw+yHVVX1BJ1k41ExS4kGFEJywG/EIpCJxbAL/ppu6fsLeTP/swB5MQKhT128gb6Xgrt
         zgw0QNTlgo51q754nBXsPCUf59er37i6FamA3AVggXrdciDeNJzpwyvbg/TYpVjY8hfu
         i0SRabaKnhAcle0uvrqqDNWDW8mMekN6Qr7Lv9miDEpIsNiQ3UYIkKEBnJ+fXWEqawud
         zwa1JDEyjVj10AG5Q8hPcP4OFGHj1kJ+IxJHJzluPx6ZKifDhSfnYlUcGvrvX+TZ5Wuw
         T4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2TLBjdWLrXSfqSUr6v2jJ7iqQPtYG/lF7TdWsMjx+Q0=;
        b=ijTNjmu+15ANb0qpL9QPXLf5+5rtBv6GNzEWNcgz68YOlLQx3Z1Bm/hjl1ibEDk1uv
         u7PEb5e3W+efrqSxa+GuvDCb+T94ktVwQRQt/famdTJhFyg6gVAUjtAWcAqBcVKiiVhR
         SeOvnyvvObr7msV+53f5u8aeEZu+0MMuMgjn6qIr8JwbPg3rams6LBGQ+eO2Z9dXt8CD
         /5euaagf7fHmudPAWzeD33LIsSu5EhTkleeHXGN49QOYpX4iaF5NHYtV2H4xuVYNbCHt
         Cd5rVXwOSqO0R5SDV8EuhFerMooBxSFzjOQiiDimFhvMDXkB+HPzm4rJk7/OLJE8nXnu
         PLqw==
X-Gm-Message-State: APjAAAW3keQeWJjgWWSkW7NuvwRUvipIPKpIIaf+Ep4wl8p9IS0jMXOI
        2iMKuIO7C2OcjhPzK7BbzEB6zDdu
X-Google-Smtp-Source: APXvYqygemMfm9pBSKyjWGMnaj5hBKPAyQ1ViE8+nR6AGkb9XTtFFm4sQhlMB/04z44K3vVDNPSwEw==
X-Received: by 2002:a7b:caf2:: with SMTP id t18mr8443095wml.131.1580943394548;
        Wed, 05 Feb 2020 14:56:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm8620955wmd.1.2020.02.05.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:34 -0800 (PST)
Message-Id: <c17bbcbc66ea77bb480391804d1f2db66ffa0926.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:23 +0000
Subject: [PATCH v2 04/11] commit-graph: compute Bloom filters for changed
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Compute Bloom filters for the paths that changed between a commit and its
first parent using the implementation in bloom.c, when the
COMMIT_GRAPH_WRITE_CHANGED_PATHS flag is set. This computation is done on a
commit-by-commit basis. We will write these Bloom filters to the commit graph
file in the next change.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 32 +++++++++++++++++++++++++++++++-
 commit-graph.h |  3 ++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3c4d411326..724bfcffc4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,7 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "bloom.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -795,9 +796,11 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1;
+		 check_oids:1,
+		 changed_paths:1;
 
 	const struct split_commit_graph_opts *split_opts;
+	uint32_t total_bloom_filter_data_size;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1140,6 +1143,28 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void compute_bloom_filters(struct write_commit_graph_context *ctx)
+{
+	int i;
+	struct progress *progress = NULL;
+
+	load_bloom_filters();
+
+	if (ctx->report_progress)
+		progress = start_progress(
+			_("Computing commit diff Bloom filters"),
+			ctx->commits.nr);
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
+		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
+		display_progress(progress, i + 1);
+	}
+
+	stop_progress(&progress);
+}
+
 static int add_ref_to_list(const char *refname,
 			   const struct object_id *oid,
 			   int flags, void *cb_data)
@@ -1794,6 +1819,8 @@ int write_commit_graph(const char *obj_dir,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
+	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
+	ctx->total_bloom_filter_data_size = 0;
 
 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1888,6 +1915,9 @@ int write_commit_graph(const char *obj_dir,
 
 	compute_generation_numbers(ctx);
 
+	if (ctx->changed_paths)
+		compute_bloom_filters(ctx);
+
 	res = write_commit_graph_file(ctx);
 
 	if (ctx->split)
diff --git a/commit-graph.h b/commit-graph.h
index 7f5c933fa2..952a4b83be 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -76,7 +76,8 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
 };
 
 struct split_commit_graph_opts {
-- 
gitgitgadget

