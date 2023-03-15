Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C2C7618D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjCORqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA3565468
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p16so13113321wmq.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV0fO6kStkffZHpmPplRcpbqu+IzTW2g86XUKU3MSkw=;
        b=nbksY50vvwHevRr1QI+2+IuEXMH5/8BVHtNHaWRI6qDYSUso2BkAOqcybqm+Co9UaL
         bJ6ZdVvrb2QDqZVR+6VUEzrqJY7885QTtM2I+qJ7f1o5jNmS8Klo3ICt6/m+AqYMCKjf
         kwxE0r9Ag3rAYuyWppqL4kgMsxl5hR6uvGgImPAg+Iv98ucrE4F8xXyClmEYUgGJOhfr
         JMVKl4rkdek1j8W1u0TTNRuVdH8Qhhy6gV+LlvFoN0ZCnStaORDapPUX37C6qLmWZVyk
         9wGJV+gGAxUlwTpP2Kw4QMtaTdgKHkbrl2D/BprddlyJdbov/enbsK5OlDaKjBb3wU9M
         nz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV0fO6kStkffZHpmPplRcpbqu+IzTW2g86XUKU3MSkw=;
        b=N9vnV82CvZ51nWnKgN70WeuzUBQPjeowuIftXs8ieXdfLEUrTNqrRgVjEhjT7NHSiT
         EcYdAW5yP7xVGfpLqdaOmAdufqsGyUW91lGO7XXDPbnOs+1e3NInXoJaKmOXsRklfcoK
         iQLo+nRX+KljEIWYj+r3JQRz9jcKdx9x8DtU4gO6pnB/NCjZn8S8bxxS1FuJnqT0gIKY
         iNRQtGx2BMR0pYmDLawpnRvUMDIGAVKw2Uq4sFBaUB3jEGGsYrYdIyG51u29lfXJKtCk
         F3I13brl5XKsfhqCuj+raF/UgMY7C/gIYqBx61/nXR17uXTOxeTsFwKfT5eNr6+HLzPN
         sjiA==
X-Gm-Message-State: AO0yUKW+ODLgwxHW14DIITdnBn3KKQ2GtQE08QrkqDQRzr+gN49Zf0Gh
        brKkwvYT9B+JrcgZkOnn1G9MzjEruug=
X-Google-Smtp-Source: AK7set/qbyFhBUWmFhJIbEfFMr+5lsAd74TTOYXW4Z5XMXzsNKcTTvhalVRkN3QPfYcYw2jsTYVghw==
X-Received: by 2002:a05:600c:1d0b:b0:3ed:24f7:2b48 with SMTP id l11-20020a05600c1d0b00b003ed24f72b48mr5271761wms.8.1678902346867;
        Wed, 15 Mar 2023 10:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b003ebf73acf9asm7584995wms.3.2023.03.15.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:46 -0700 (PDT)
Message-Id: <3b15e9df770a118331a1b25f51de8ce97c1b7cab.1678902343.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:38 +0000
Subject: [PATCH v3 3/8] commit-graph: combine generation computations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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

