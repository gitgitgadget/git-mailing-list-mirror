Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427AC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCTL12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCTL1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE276185
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso7276777wmo.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktm0kB86VsEKCsVJG3XyhHWxo96yIiCHmCV7DDi5gzI=;
        b=TMvc/C3Dp3clffCP6ZXCgE5nW8V0TRUaJ0kOzXRP9RxeAzqXDY4q87gY4oqQGrQx/e
         tiGaGRKK6v/hNqp2FJUsI5gAEwwvl/eoizhKFw72VJEUtWDPEDhmdlYevOxONPFXmxaE
         Jea2HVinC5oYZ6eQnWLkJo2clgilojxdAQdOJTxUFAsJILC7n3/3K6DHf/Og9JOn5PMG
         hjUq+t1eSZWfFLzfR8fxw56qoBhTEp+69TCPXdm30/GRC0h2xhQv7WQlBOnIUwCw+tSg
         rS2LEVyPjKau11tfDRf/zfTyH9yE9dEcuonI5i5e3QO9Ap9I/h91RV34t3682Eje/LEG
         H9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktm0kB86VsEKCsVJG3XyhHWxo96yIiCHmCV7DDi5gzI=;
        b=V0wOOINuS7vUcEjHUKzI6QbY2yZGbSpRcIT81Ar6fOctFrTU3AwhFRFUrzcFHB9MUH
         nOdqSMxgWDc4qxWiC/3MQySDVwiPSivgho4x7037rNMF62l0cUz1YFk3cCrYPR9FgFi6
         93OC9ZxIoGbTgEjM04ZAvk9jP97hGpL9awS365Rs1f+AscIxdsQzvFNRqOKSXwlRwsaH
         rdeoiwMZAGOnBMya2aqZ3C6VO3u2fctMGJS70B/3gYH9b94B4qd6qP414CIrn8cY8t+T
         oR8WvYv/rwlXoaBeVexvtp5lhztQBC2V6bjR2bK0VEYZ824agrdYEEKxKSgF3myy56vz
         6JvA==
X-Gm-Message-State: AO0yUKVK6A8uJlLzF0Xp1le03kL8VvKScaEDelj/kCsVQ8hfHgLQ9Jk/
        koFXUczod7mog0IvbLO/Ycm/VG5PVxo=
X-Google-Smtp-Source: AK7set+HRVVHN8sjiqBsjjVhkgOpsjn5MPCy4A9gqETOu+SJuVOT1dWyCD3PGAJSXtw5hhuQO/LERg==
X-Received: by 2002:a1c:f601:0:b0:3ed:8bef:6a04 with SMTP id w1-20020a1cf601000000b003ed8bef6a04mr9880512wmc.27.1679311619750;
        Mon, 20 Mar 2023 04:26:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003ed2987690dsm10223179wmr.26.2023.03.20.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:26:59 -0700 (PDT)
Message-Id: <79a57f30a850177ce6400b9e898f24981635541a.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:49 +0000
Subject: [PATCH v4 3/9] commit-graph: refactor compute_topological_levels()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This patch extracts the common code used to compute topological levels
and corrected committer dates into a common routine,
compute_reachable_generation_numbers(). For ease of reading, it only
modifies compute_topological_levels() to use this new routine, leaving
compute_generation_numbers() to be modified in the next change.

This new routine dispatches to call the necessary functions to get and
set the generation number for a given commit through a vtable (the
compute_generation_info struct).

Computing the generation number itself is done in
compute_generation_from_max(), which dispatches its implementation based
on the generation version requested, or issuing a BUG() for unrecognized
generation versions. This does not use a vtable because the logic
depends only on the generation number version, not where the data is
being loaded from or being stored to. This is a subtle point that will
make more sense in a future change that modifies the in-memory
generation values instead of just preparing values for writing to a
commit-graph file.

This change looks like it adds a lot of new code. However, two upcoming
changes will be quite small due to the work being done in this change.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 23 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b3..4356c8c1f4b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1446,24 +1446,52 @@ static void close_reachable(struct write_commit_graph_context *ctx)
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
+static void compute_reachable_generation_numbers(
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
-
-		repo_parse_commit(ctx->r, c);
-		level = *topo_level_slab_at(ctx->topo_levels, c);
+	for (i = 0; i < info->commits->nr; i++) {
+		struct commit *c = info->commits->list[i];
+		timestamp_t gen;
+		repo_parse_commit(info->r, c);
+		gen = info->get_generation(c, info->data);
+		display_progress(info->progress, info->progress_cnt + 1);
 
-		display_progress(ctx->progress, i + 1);
-		if (level != GENERATION_NUMBER_ZERO)
+		if (gen != GENERATION_NUMBER_ZERO && gen != GENERATION_NUMBER_INFINITY)
 			continue;
 
 		commit_list_insert(c, &list);
@@ -1471,31 +1499,63 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
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
+}
+
+static void compute_topological_levels(struct write_commit_graph_context *ctx)
+{
+	struct compute_generation_info info = {
+		.r = ctx->r,
+		.commits = &ctx->commits,
+		.get_generation = get_topo_level,
+		.set_generation = set_topo_level,
+		.data = ctx,
+	};
+
+	if (ctx->report_progress)
+		info.progress = ctx->progress
+			      = start_delayed_progress(
+					_("Computing commit graph topological levels"),
+					ctx->commits.nr);
+
+	compute_reachable_generation_numbers(&info, 1);
+
 	stop_progress(&ctx->progress);
 }
 
-- 
gitgitgadget

