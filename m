Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741EFC352A2
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4314E20730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYY6qaz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBEW4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBEW4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so4808329wrd.9
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QpT3ycOLjE+4ZOVT4HbeudRvlY9BeItDOp6mCLAkgLM=;
        b=GYY6qaz9pny18TG4KQiOQbGW4T/DL90j6Eyyg/9JK2mWQd6AyhS5g9+X04GvVtfPsp
         jvBFgu7u8a4FnS/qo/06II2cP3Wymu9fy0CH9bIRUAGDqdEU8DKhHmLTtxKtWufdWwHx
         e5HMLSTKUm3pyR57qP3OX6ndYuAVnvjYFPGDXguqKieUqRLpKflUYbQyiaRLpZR5FJJN
         0s9ldaIOtDRC5vLVT2M/XrvwUVwLc+5GEDmrwgjSTPicHjR/knycb3T4Sgs+ORqFyopS
         n/ApdemCLUQYbTOQ8kO0xFetSoBcruTOkfxbWm0ZL/eg4DH3mf9PBvDEODwe1RyAIkG9
         h4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QpT3ycOLjE+4ZOVT4HbeudRvlY9BeItDOp6mCLAkgLM=;
        b=rehQt1b/43Q+0CVYw7ZcH/QqJNVOcnh+T4ifcYVyzU3uRMibbpCMJGE5qnYGVE5QvR
         ERsh5T8wLnda1194W8vs+CvGZ1toTyjtCxGaNsUb1eZUENRdudjf74rvKtSZZwSfcEbq
         p5s1dm/GBup9lgnRxb+FoGSkOSO8tVa5GxsRgEHbIEvLKLlioJqCnH5h1kSQawKLa7NX
         cYInEiuXedhEvQAWHA8sEGOxtEc5dbfx1v0UdDexmJinTA2ZGcwN/CnG9bJ+l4dtIKX0
         kqnOqQ9MxsxPrVThW654vWFLH2JtVcIiAseraJ9A7pHQWYoLAiXar81fASA8PbY+c7+H
         KZEw==
X-Gm-Message-State: APjAAAXelse+zT346MU8P2+6T1ffqJhwOXLMjx78aYnrrcOh88oxE17h
        g4qDnn6soHc95Jawhh/XKrMg74ZF
X-Google-Smtp-Source: APXvYqwZqE2mmn4ZXGkHc/oi3VPIA1RObbQ4iOJwZ0t4CxvINyNV9ZwLsfDd+L/HjGw4qgyvDj/oXQ==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr208115wrt.228.1580943396060;
        Wed, 05 Feb 2020 14:56:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm1201681wmi.44.2020.02.05.14.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:35 -0800 (PST)
Message-Id: <58704d81b6b4fbc54715457246aeed783eb32a99.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:25 +0000
Subject: [PATCH v2 06/11] commit-graph: examine commits by generation number
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
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When running 'git commit-graph write --changed-paths', we sort the
commits by pack-order to save time when computing the changed-paths
bloom filters. This does not help when finding the commits via the
--reachable flag.

If not using pack-order, then sort by generation number before
examining the diff. Commits with similar generation are more likely
to have many trees in common, making the diff faster.

On the Linux kernel repository, this change reduced the computation
time for 'git commit-graph write --reachable --changed-paths' from
3m00s to 1m37s.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e125511a1c..32a315058f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -70,6 +70,25 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+static int commit_gen_cmp(const void *va, const void *vb)
+{
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+
+	/* lower generation commits first */
+	if (a->generation < b->generation)
+		return -1;
+	else if (a->generation > b->generation)
+		return 1;
+
+	/* use date as a heuristic when generations are equal */
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
@@ -821,7 +840,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 check_oids:1,
-		 changed_paths:1;
+		 changed_paths:1,
+		 order_by_pack:1;
 
 	const struct split_commit_graph_opts *split_opts;
 	uint32_t total_bloom_filter_data_size;
@@ -1184,7 +1204,11 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
 	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
-	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
+
+	if (ctx->order_by_pack)
+		QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
+	else
+		QSORT(sorted_by_pos, ctx->commits.nr, commit_gen_cmp);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_by_pos[i];
@@ -1902,6 +1926,7 @@ int write_commit_graph(const char *obj_dir,
 	}
 
 	if (pack_indexes) {
+		ctx->order_by_pack = 1;
 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
 			goto cleanup;
 	}
@@ -1911,8 +1936,10 @@ int write_commit_graph(const char *obj_dir,
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commit_hex) {
+		ctx->order_by_pack = 1;
 		fill_oids_from_all_packs(ctx);
+	}
 
 	close_reachable(ctx);
 
-- 
gitgitgadget

