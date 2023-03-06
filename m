Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E37C6FA99
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCFOHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCFOHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36020692
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso8255233wmi.4
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV0fO6kStkffZHpmPplRcpbqu+IzTW2g86XUKU3MSkw=;
        b=nGiGIL1rUEUx6z34OlXw/poBM8ImO6pAwAXBM69z6aTm71CS5DrqY9RFGoIYBHBvbm
         eFrSqKmjr6xNB6xhcQ8Ae+VCjw1DVBQ1leFcalCBUb1Yeh8hG5d6r+8eNe6tApXv3/0Y
         LDzsIIP9XwOF5950W1zZGfO+x34lSWNp2DTZAKR5V1GjSlrGTxU+F+tbhCV2wtIG371T
         5pPwH/ZF1fQCasuWO/t9lpvWrEyY6dPQ+QxaRWGVDRXZF5oAHygljlJqtujAg2sek1rT
         DihMa6bU7foPNKLbiWfUKE/XBhk4ibpfRAiEKzjhSWYxRCL0tqDZp9cDvLBN3Sw730Sn
         3+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV0fO6kStkffZHpmPplRcpbqu+IzTW2g86XUKU3MSkw=;
        b=jecx8QrKKuBpMnU8A7GMd+NI7thvCxSw9ZBMLlIj7h63tANNTziDm2KhdDlYW1gglH
         87THXO2EYlZeJUQ/AAKd4wcqIJmB5M+vcOsezAQvJ9LWtAmT0iVSO5qm37l/TmqAdkbc
         FTD9QKpSLmkeoVwM//HKWAsc+x151D5sqKpzzT5m7QdpfA7VUbqXqBApJ061p4Nz0evl
         PuJmE05wGhY73Zl+RjEUnsgObSmbmeVMmLqZJWJMEs9DZUumbMDyyzfMbG/kxSymt43Z
         wGZe6fbU48RyxZR9hVchjRpQAHByHMCYDxyQNANO8IgIkcAImUZnASy9lud/9H2ORYBW
         y6OA==
X-Gm-Message-State: AO0yUKW7b/2jCL6YCG09yeoCfz4f2R7p+W+hEgIVnduDoo32O3Efpyqg
        1xWQMlol3amrRHuuLI9wa9blYLmY4+0=
X-Google-Smtp-Source: AK7set89cE+ANu5p+od9EG3BsNN3CttySxjg3zQCr4CtbfQq7p21MMxLjY6j9VZQ7eUpkMJNhUIr9w==
X-Received: by 2002:a05:600c:350f:b0:3ea:d620:57a7 with SMTP id h15-20020a05600c350f00b003ead62057a7mr9288367wmq.8.1678111602482;
        Mon, 06 Mar 2023 06:06:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a056000014100b002c5534db60bsm10232139wrx.71.2023.03.06.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:42 -0800 (PST)
Message-Id: <853891c0b14b2a97c980a436a755f9005415ea7a.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:34 +0000
Subject: [PATCH 4/8] commit-graph: combine generation computations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This patch extracts the common code used to compute topological levels
and corrected committer dates into a common routine,
compute_reachable_generation_numbers_1().

This new routine dispatches to call the necessary functions to get and
set the generation number for a given commit through a vtable (the
compute_generation_info struct).

Computing the generation number itself is done in
compute_generation_from_max(), which dispatches its implementation based
on the generation version requested, or issuing a BUG() for unrecognized
generation versions.

This patch cleans up the two places that currently compute topological
levels and corrected commit dates by reducing the amount of duplicated
code. It also makes it possible to introduce a function which
dynamically computes those values for commits that aren't stored in a
commit-graph, which will be required for the forthcoming ahead-behind
rewrite.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c | 171 +++++++++++++++++++++++++++++++------------------
 1 file changed, 107 insertions(+), 64 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b3..deccf984a0d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1446,24 +1446,53 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static void compute_topological_levels(struct write_commit_graph_context *ctx)
+struct compute_generation_info {
+	struct repository *r;
+	struct packed_commit_list *commits;
+	struct progress *progress;
+	int progress_cnt;
+
+	timestamp_t (*get_generation)(struct commit *c, void *data);
+	void (*set_generation)(struct commit *c, timestamp_t gen, void *data);
+	void *data;
+};
+
+static timestamp_t compute_generation_from_max(struct commit *c,
+					       timestamp_t max_gen,
+					       int generation_version)
+{
+	switch (generation_version) {
+	case 1: /* topological levels */
+		if (max_gen > GENERATION_NUMBER_V1_MAX - 1)
+			max_gen = GENERATION_NUMBER_V1_MAX - 1;
+		return max_gen + 1;
+
+	case 2: /* corrected commit date */
+		if (c->date && c->date > max_gen)
+			max_gen = c->date - 1;
+		return max_gen + 1;
+
+	default:
+		BUG("attempting unimplemented version");
+	}
+}
+
+static void compute_reachable_generation_numbers_1(
+			struct compute_generation_info *info,
+			int generation_version)
 {
 	int i;
 	struct commit_list *list = NULL;
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-					_("Computing commit graph topological levels"),
-					ctx->commits.nr);
-	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = ctx->commits.list[i];
-		uint32_t level;
+	for (i = 0; i < info->commits->nr; i++) {
+		struct commit *c = info->commits->list[i];
+		timestamp_t gen;
+		repo_parse_commit(info->r, c);
+		gen = info->get_generation(c, info->data);
 
-		repo_parse_commit(ctx->r, c);
-		level = *topo_level_slab_at(ctx->topo_levels, c);
+		display_progress(info->progress, info->progress_cnt + 1);
 
-		display_progress(ctx->progress, i + 1);
-		if (level != GENERATION_NUMBER_ZERO)
+		if (gen != GENERATION_NUMBER_ZERO && gen != GENERATION_NUMBER_INFINITY)
 			continue;
 
 		commit_list_insert(c, &list);
@@ -1471,38 +1500,91 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 			struct commit *current = list->item;
 			struct commit_list *parent;
 			int all_parents_computed = 1;
-			uint32_t max_level = 0;
+			uint32_t max_gen = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				repo_parse_commit(ctx->r, parent->item);
-				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
+				repo_parse_commit(info->r, parent->item);
+				gen = info->get_generation(parent->item, info->data);
 
-				if (level == GENERATION_NUMBER_ZERO) {
+				if (gen == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
 				}
 
-				if (level > max_level)
-					max_level = level;
+				if (gen > max_gen)
+					max_gen = gen;
 			}
 
 			if (all_parents_computed) {
 				pop_commit(&list);
-
-				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
-					max_level = GENERATION_NUMBER_V1_MAX - 1;
-				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+				gen = compute_generation_from_max(
+						current, max_gen,
+						generation_version);
+				info->set_generation(current, gen, info->data);
 			}
 		}
 	}
+}
+
+static timestamp_t get_topo_level(struct commit *c, void *data)
+{
+	struct write_commit_graph_context *ctx = data;
+	return *topo_level_slab_at(ctx->topo_levels, c);
+}
+
+static void set_topo_level(struct commit *c, timestamp_t t, void *data)
+{
+	struct write_commit_graph_context *ctx = data;
+	*topo_level_slab_at(ctx->topo_levels, c) = (uint32_t)t;
+	display_progress(ctx->progress, ctx->progress_cnt + 1);
+}
+
+static void compute_topological_levels(struct write_commit_graph_context *ctx)
+{
+	struct compute_generation_info info = {
+		.r = ctx->r,
+		.progress = ctx->progress,
+		.commits = &ctx->commits,
+		.get_generation = get_topo_level,
+		.set_generation = set_topo_level,
+		.data = ctx,
+	};
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+					_("Computing commit graph topological levels"),
+					ctx->commits.nr);
+
+	compute_reachable_generation_numbers_1(&info, 1);
+
 	stop_progress(&ctx->progress);
 }
 
+static timestamp_t get_generation_from_graph_data(struct commit *c, void *data)
+{
+	return commit_graph_data_at(c)->generation;
+}
+
+static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
+{
+	struct write_commit_graph_context *ctx = data;
+	struct commit_graph_data *g = commit_graph_data_at(c);
+	g->generation = (uint32_t)t;
+	display_progress(ctx->progress, ctx->progress_cnt + 1);
+}
+
 static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
 	int i;
-	struct commit_list *list = NULL;
+	struct compute_generation_info info = {
+		.r = ctx->r,
+		.progress = ctx->progress,
+		.commits = &ctx->commits,
+		.get_generation = get_generation_from_graph_data,
+		.set_generation = set_generation_v2,
+		.data = ctx,
+	};
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -1517,47 +1599,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		}
 	}
 
-	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = ctx->commits.list[i];
-		timestamp_t corrected_commit_date;
-
-		repo_parse_commit(ctx->r, c);
-		corrected_commit_date = commit_graph_data_at(c)->generation;
-
-		display_progress(ctx->progress, i + 1);
-		if (corrected_commit_date != GENERATION_NUMBER_ZERO)
-			continue;
-
-		commit_list_insert(c, &list);
-		while (list) {
-			struct commit *current = list->item;
-			struct commit_list *parent;
-			int all_parents_computed = 1;
-			timestamp_t max_corrected_commit_date = 0;
-
-			for (parent = current->parents; parent; parent = parent->next) {
-				repo_parse_commit(ctx->r, parent->item);
-				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
-
-				if (corrected_commit_date == GENERATION_NUMBER_ZERO) {
-					all_parents_computed = 0;
-					commit_list_insert(parent->item, &list);
-					break;
-				}
-
-				if (corrected_commit_date > max_corrected_commit_date)
-					max_corrected_commit_date = corrected_commit_date;
-			}
-
-			if (all_parents_computed) {
-				pop_commit(&list);
-
-				if (current->date && current->date > max_corrected_commit_date)
-					max_corrected_commit_date = current->date - 1;
-				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
-			}
-		}
-	}
+	compute_reachable_generation_numbers_1(&info, 2);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
@@ -1565,6 +1607,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
 			ctx->num_generation_data_overflows++;
 	}
+
 	stop_progress(&ctx->progress);
 }
 
-- 
gitgitgadget

