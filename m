Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C9C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B909206F6
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGLJR118"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFGTem (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTel (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 15:34:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1086C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 12:34:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so7547267pfp.9
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grBDVGfTxOWNldmRHA/7nrIMJ1CkfmCknC0lE8SxwQY=;
        b=uGLJR118w0DWRqE0B4rqaV1esNHg/yWlsHZlA9HVO15tTvC5ys6bZVhmeAHNAh+1ix
         hcmbM4JiMaLCQ2N/FsZXnYbvpg3gAvtBBbllT9yPvrahJIISfT9d1kS/5aXuLTHs2k80
         JTDyekjPrF0dWYowgf323V5vPJ5VjDsDo/cBj1Wk/bs6KsQtlsvLuWmgnLRDl7FC38H1
         6B2x1ocoKAMCG3d4DHqAHDQi9OH6I9iw3YfvhRhfFNlOsgjr/OpQIQLWyN4ZoQsTHeua
         a3jbOVExuMQ7KNbYL+O9LXNJ/yVFroEGSs2/snXE2oCktTj+UqFi5Cnti2pyvtb0Js//
         hQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grBDVGfTxOWNldmRHA/7nrIMJ1CkfmCknC0lE8SxwQY=;
        b=LQlxTmEmkiqDjMxkTQJKkiADi2iTghNSAytoBCL6FiyM0Wk0h3Pd42ne+XrcAuBv+y
         e8QBX9Uhkahs7+V5A+xY+GcJFZOXGn7sJkeXgfZ6nvzNy0DkyxNkAqol2WgfJrSXjnwn
         QKP/QW0NVvKjjy7bDr4BPZLgg30DxVEZzC6xHhYURZu4JB7tnHgtxb7nb39iXe1r8V1R
         3EOSu/+TC6UAsTYL9WUE3LSqI4wfE0SbWJVQsd559F6Jz690/UlN4SICSiebpHQGinf5
         fxBkg6vTxtysgApBHeMkf/BNoXjYGiIS+92RNJvKCjRmtvO9hLp60m60BsMSsyaiN84O
         leFw==
X-Gm-Message-State: AOAM530YwpSFlod2c+H5Q1mN7MGp4iqLfGQkbNplfQiKmNfKNrjGLz7A
        AhNyOhL/uN5gRzyyGytPFHlgcmK1
X-Google-Smtp-Source: ABdhPJzkaHz3jrRtNg1oLDMKUpKHYY6pQF3b1vQyMhZfSivtcmVvE2l6pkMefBODPrn+yJZ0V6IHXQ==
X-Received: by 2002:aa7:9ad5:: with SMTP id x21mr18534093pfp.257.1591558480791;
        Sun, 07 Jun 2020 12:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:58e:925f:60d1:f386:43d2:4abb])
        by smtp.gmail.com with ESMTPSA id n69sm158595pfd.171.2020.06.07.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 12:34:40 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v2 2/4] commit: move members graph_pos, generation to a slab
Date:   Mon,  8 Jun 2020 01:02:35 +0530
Message-Id: <20200607193237.699335-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607193237.699335-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We remove members `graph_pos` and `generation` from the struct commit.
The default assignments in init_commit_node() are no longer valid,
which is fine as the slab helpers return appropriate default values and
the assignments are removed.

We will replace existing use of commit->generation and commit->graph_pos
by commit_graph_data slab helpers using
`contrib/coccinelle/commit.cocci'.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 alloc.c                         |  2 --
 blame.c                         |  2 +-
 bloom.c                         |  6 ++--
 commit-graph.c                  | 60 ++++++++++++++++-----------------
 commit-graph.h                  |  2 +-
 commit-reach.c                  | 50 +++++++++++++--------------
 commit.c                        |  6 ++--
 contrib/coccinelle/commit.cocci | 18 ++++++++++
 revision.c                      | 16 ++++-----
 9 files changed, 89 insertions(+), 73 deletions(-)

diff --git a/alloc.c b/alloc.c
index 1c64c4dd16..f37fb3b8b6 100644
--- a/alloc.c
+++ b/alloc.c
@@ -108,8 +108,6 @@ void init_commit_node(struct repository *r, struct commit *c)
 {
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index(r);
-	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
-	c->generation = GENERATION_NUMBER_INFINITY;
 }
 
 void *alloc_commit_node(struct repository *r)
diff --git a/blame.c b/blame.c
index da7e28800e..82fa16d658 100644
--- a/blame.c
+++ b/blame.c
@@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
 	if (!bd)
 		return 1;
 
-	if (origin->commit->generation == GENERATION_NUMBER_INFINITY)
+	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
 		return 1;
 
 	filter = get_bloom_filter(r, origin->commit, 0);
diff --git a/bloom.c b/bloom.c
index 9b86aa3f59..df62e3763d 100644
--- a/bloom.c
+++ b/bloom.c
@@ -34,14 +34,14 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 {
 	uint32_t lex_pos, start_index, end_index;
 
-	while (c->graph_pos < g->num_commits_in_base)
+	while (commit_graph_position(c) < g->num_commits_in_base)
 		g = g->base_graph;
 
 	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
 	if (!g->chunk_bloom_indexes)
 		return 0;
 
-	lex_pos = c->graph_pos - g->num_commits_in_base;
+	lex_pos = commit_graph_position(c) - g->num_commits_in_base;
 
 	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
 
@@ -188,7 +188,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
-		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
+		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
 			r->objects->commit_graph->chunk_bloom_indexes) {
 			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
 				return filter;
diff --git a/commit-graph.c b/commit-graph.c
index 7d887a6a2c..f7cca4def4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -142,9 +142,9 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *b = *(const struct commit **)vb;
 
 	/* lower generation commits first */
-	if (a->generation < b->generation)
+	if (commit_graph_generation(a) < commit_graph_generation(b))
 		return -1;
-	else if (a->generation > b->generation)
+	else if (commit_graph_generation(a) > commit_graph_generation(b))
 		return 1;
 
 	/* use date as a heuristic when generations are equal */
@@ -719,7 +719,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
-	c->graph_pos = pos;
+	commit_graph_data_at(c)->graph_pos = pos;
 	return &commit_list_insert(c, pptr)->next;
 }
 
@@ -733,8 +733,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
-	item->graph_pos = pos;
-	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	commit_graph_data_at(item)->graph_pos = pos;
+	commit_graph_data_at(item)->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -763,7 +763,7 @@ static int fill_commit_in_graph(struct repository *r,
 	 * Store the "full" position, but then use the
 	 * "local" position for the rest of the calculation.
 	 */
-	item->graph_pos = pos;
+	commit_graph_data_at(item)->graph_pos = pos;
 	lex_index = pos - g->num_commits_in_base;
 
 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
@@ -776,7 +776,7 @@ static int fill_commit_in_graph(struct repository *r,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	commit_graph_data_at(item)->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 
 	pptr = &item->parents;
 
@@ -808,8 +808,8 @@ static int fill_commit_in_graph(struct repository *r,
 
 static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
 {
-	if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
-		*pos = item->graph_pos;
+	if (commit_graph_position(item) != COMMIT_NOT_FROM_GRAPH) {
+		*pos = commit_graph_position(item);
 		return 1;
 	} else {
 		struct commit_graph *cur_g = g;
@@ -865,11 +865,11 @@ static struct tree *load_tree_for_commit(struct repository *r,
 	struct object_id oid;
 	const unsigned char *commit_data;
 
-	while (c->graph_pos < g->num_commits_in_base)
+	while (commit_graph_position(c) < g->num_commits_in_base)
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
+			GRAPH_DATA_WIDTH * (commit_graph_position(c) - g->num_commits_in_base);
 
 	hashcpy(oid.hash, commit_data);
 	set_commit_tree(c, lookup_tree(r, &oid));
@@ -883,7 +883,7 @@ static struct tree *get_commit_tree_in_graph_one(struct repository *r,
 {
 	if (c->maybe_tree)
 		return c->maybe_tree;
-	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
+	if (commit_graph_position(c) == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
 
 	return load_tree_for_commit(r, g, (struct commit *)c);
@@ -1070,7 +1070,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl((*list)->generation << 2);
+		packedDate[0] |= htonl(commit_graph_generation((*list)) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1269,7 +1269,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 			continue;
 		if (ctx->split) {
 			if ((!parse_commit(commit) &&
-			     commit->graph_pos == COMMIT_NOT_FROM_GRAPH) ||
+			     commit_graph_position(commit) == COMMIT_NOT_FROM_GRAPH) ||
 			    flags == COMMIT_GRAPH_SPLIT_REPLACE)
 				add_missing_parents(ctx, commit);
 		} else if (!parse_commit_no_graph(commit))
@@ -1302,8 +1302,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		if (ctx->commits.list[i]->generation != GENERATION_NUMBER_INFINITY &&
-		    ctx->commits.list[i]->generation != GENERATION_NUMBER_ZERO)
+		if (commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_INFINITY &&
+		    commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1314,22 +1314,22 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			uint32_t max_generation = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
-				    parent->item->generation == GENERATION_NUMBER_ZERO) {
+				if (commit_graph_generation(parent->item) == GENERATION_NUMBER_INFINITY ||
+				    commit_graph_generation(parent->item) == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (parent->item->generation > max_generation) {
-					max_generation = parent->item->generation;
+				} else if (commit_graph_generation(parent->item) > max_generation) {
+					max_generation = commit_graph_generation(parent->item);
 				}
 			}
 
 			if (all_parents_computed) {
-				current->generation = max_generation + 1;
+				commit_graph_data_at(current)->generation = max_generation + 1;
 				pop_commit(&list);
 
-				if (current->generation > GENERATION_NUMBER_MAX)
-					current->generation = GENERATION_NUMBER_MAX;
+				if (commit_graph_generation(current) > GENERATION_NUMBER_MAX)
+					commit_graph_data_at(current)->generation = GENERATION_NUMBER_MAX;
 			}
 		}
 	}
@@ -1514,7 +1514,7 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 			if (ctx->split) {
 				struct commit *c = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
-				if (!c || c->graph_pos != COMMIT_NOT_FROM_GRAPH)
+				if (!c || commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
 					continue;
 			}
 
@@ -1548,7 +1548,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
 		if (ctx->split && flags != COMMIT_GRAPH_SPLIT_REPLACE &&
-		    ctx->commits.list[ctx->commits.nr]->graph_pos != COMMIT_NOT_FROM_GRAPH)
+		    commit_graph_position(ctx->commits.list[ctx->commits.nr]) != COMMIT_NOT_FROM_GRAPH)
 			continue;
 
 		if (ctx->split && flags == COMMIT_GRAPH_SPLIT_REPLACE)
@@ -2336,8 +2336,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			if (graph_parents->item->generation > max_generation)
-				max_generation = graph_parents->item->generation;
+			if (commit_graph_generation(graph_parents->item) > max_generation)
+				max_generation = commit_graph_generation(graph_parents->item);
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2347,7 +2347,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!graph_commit->generation) {
+		if (!commit_graph_generation(graph_commit)) {
 			if (generation_zero == GENERATION_NUMBER_EXISTS)
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
@@ -2367,10 +2367,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (max_generation == GENERATION_NUMBER_MAX)
 			max_generation--;
 
-		if (graph_commit->generation != max_generation + 1)
+		if (commit_graph_generation(graph_commit) != max_generation + 1)
 			graph_report(_("commit-graph generation for commit %s is %u != %u"),
 				     oid_to_hex(&cur_oid),
-				     graph_commit->generation,
+				     commit_graph_generation(graph_commit),
 				     max_generation + 1);
 
 		if (graph_commit->date != odb_commit->date)
diff --git a/commit-graph.h b/commit-graph.h
index 9d22f98f44..2d1fecf481 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -142,7 +142,7 @@ struct commit_graph_data {
 	uint32_t generation;
 };
 
-/* 
+/*
  * Commits should be parsed before accessing generation, graph positions.
  */
 uint32_t commit_graph_generation(const struct commit *);
diff --git a/commit-reach.c b/commit-reach.c
index 4ca7e706a1..3b2f863f5f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -59,13 +59,13 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 
-		if (min_generation && commit->generation > last_gen)
+		if (min_generation && commit_graph_generation(commit) > last_gen)
 			BUG("bad generation skip %8x > %8x at %s",
-			    commit->generation, last_gen,
+			    commit_graph_generation(commit), last_gen,
 			    oid_to_hex(&commit->object.oid));
-		last_gen = commit->generation;
+		last_gen = commit_graph_generation(commit);
 
-		if (commit->generation < min_generation)
+		if (commit_graph_generation(commit) < min_generation)
 			break;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
@@ -176,7 +176,7 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
-		uint32_t min_generation = array[i]->generation;
+		uint32_t min_generation = commit_graph_generation(array[i]);
 
 		if (redundant[i])
 			continue;
@@ -186,8 +186,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 			filled_index[filled] = j;
 			work[filled++] = array[j];
 
-			if (array[j]->generation < min_generation)
-				min_generation = array[j]->generation;
+			if (commit_graph_generation(array[j]) < min_generation)
+				min_generation = commit_graph_generation(array[j]);
 		}
 		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
@@ -323,16 +323,16 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
 			return ret;
-		if (reference[i]->generation < min_generation)
-			min_generation = reference[i]->generation;
+		if (commit_graph_generation(reference[i]) < min_generation)
+			min_generation = commit_graph_generation(reference[i]);
 	}
 
-	if (commit->generation > min_generation)
+	if (commit_graph_generation(commit) > min_generation)
 		return ret;
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     commit->generation);
+				     commit_graph_generation(commit));
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
@@ -467,7 +467,7 @@ static enum contains_result contains_test(struct commit *candidate,
 	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
 
-	if (candidate->generation < cutoff)
+	if (commit_graph_generation(candidate) < cutoff)
 		return CONTAINS_NO;
 
 	return CONTAINS_UNKNOWN;
@@ -492,8 +492,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	for (p = want; p; p = p->next) {
 		struct commit *c = p->item;
 		load_commit_graph_info(the_repository, c);
-		if (c->generation < cutoff)
-			cutoff = c->generation;
+		if (commit_graph_generation(c) < cutoff)
+			cutoff = commit_graph_generation(c);
 	}
 
 	result = contains_test(candidate, want, cache, cutoff);
@@ -544,9 +544,9 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	const struct commit *a = *(const struct commit * const *)_a;
 	const struct commit *b = *(const struct commit * const *)_b;
 
-	if (a->generation < b->generation)
+	if (commit_graph_generation(a) < commit_graph_generation(b))
 		return -1;
-	if (a->generation > b->generation)
+	if (commit_graph_generation(a) > commit_graph_generation(b))
 		return 1;
 	return 0;
 }
@@ -585,7 +585,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 
 		list[nr_commits] = (struct commit *)from_one;
 		if (parse_commit(list[nr_commits]) ||
-		    list[nr_commits]->generation < min_generation) {
+		    commit_graph_generation(list[nr_commits]) < min_generation) {
 			result = 0;
 			goto cleanup;
 		}
@@ -621,7 +621,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 
 					if (parse_commit(parent->item) ||
 					    parent->item->date < min_commit_date ||
-					    parent->item->generation < min_generation)
+					    commit_graph_generation(parent->item) < min_generation)
 						continue;
 
 					commit_list_insert(parent->item, &stack);
@@ -665,8 +665,8 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
 
-			if (from_iter->item->generation < min_generation)
-				min_generation = from_iter->item->generation;
+			if (commit_graph_generation(from_iter->item) < min_generation)
+				min_generation = commit_graph_generation(from_iter->item);
 		}
 
 		from_iter = from_iter->next;
@@ -677,8 +677,8 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
 
-			if (to_iter->item->generation < min_generation)
-				min_generation = to_iter->item->generation;
+			if (commit_graph_generation(to_iter->item) < min_generation)
+				min_generation = commit_graph_generation(to_iter->item);
 		}
 
 		to_iter->item->object.flags |= PARENT2;
@@ -721,8 +721,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		struct commit *c = *item;
 
 		parse_commit(c);
-		if (c->generation < min_generation)
-			min_generation = c->generation;
+		if (commit_graph_generation(c) < min_generation)
+			min_generation = commit_graph_generation(c);
 
 		if (!(c->object.flags & PARENT1)) {
 			c->object.flags |= PARENT1;
@@ -755,7 +755,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 
 			parse_commit(p);
 
-			if (p->generation < min_generation)
+			if (commit_graph_generation(p) < min_generation)
 				continue;
 
 			if (p->object.flags & PARENT2)
diff --git a/commit.c b/commit.c
index 87686a7055..ad9a76dcc6 100644
--- a/commit.c
+++ b/commit.c
@@ -339,7 +339,7 @@ struct tree *repo_get_commit_tree(struct repository *r,
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
 
-	if (commit->graph_pos != COMMIT_NOT_FROM_GRAPH)
+	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return get_commit_tree_in_graph(r, commit);
 
 	return NULL;
@@ -731,9 +731,9 @@ int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void
 	const struct commit *a = a_, *b = b_;
 
 	/* newer commits first */
-	if (a->generation < b->generation)
+	if (commit_graph_generation(a) < commit_graph_generation(b))
 		return 1;
-	else if (a->generation > b->generation)
+	else if (commit_graph_generation(a) > commit_graph_generation(b))
 		return -1;
 
 	/* use date as a heuristic when generations are equal */
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index 778e4704f6..af6dd4c20c 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -32,3 +32,21 @@ expression c;
 - c->maybe_tree
 + repo_get_commit_tree(specify_the_right_repo_here, c)
   ...>}
+
+@@
+struct commit *c;
+expression E;
+@@
+(
+- c->generation = E;
++ commit_graph_data_at(c)->generation = E;
+|
+- c->graph_pos = E;
++ commit_graph_data_at(c)->graph_pos = E;
+|
+- c->generation
++ commit_graph_generation(c)
+|
+- c->graph_pos
++ commit_graph_position(c)
+)
diff --git a/revision.c b/revision.c
index 60cca8c0b9..cb1b200e9f 100644
--- a/revision.c
+++ b/revision.c
@@ -720,7 +720,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	if (!revs->repo->objects->commit_graph)
 		return -1;
 
-	if (commit->generation == GENERATION_NUMBER_INFINITY)
+	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
 	filter = get_bloom_filter(revs->repo, commit, 0);
@@ -3314,7 +3314,7 @@ static void explore_to_depth(struct rev_info *revs,
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
 	while ((c = prio_queue_peek(&info->explore_queue)) &&
-	       c->generation >= gen_cutoff)
+	       commit_graph_generation(c) >= gen_cutoff)
 		explore_walk_step(revs);
 }
 
@@ -3330,7 +3330,7 @@ static void indegree_walk_step(struct rev_info *revs)
 	if (parse_commit_gently(c, 1) < 0)
 		return;
 
-	explore_to_depth(revs, c->generation);
+	explore_to_depth(revs, commit_graph_generation(c));
 
 	for (p = c->parents; p; p = p->next) {
 		struct commit *parent = p->item;
@@ -3354,7 +3354,7 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
 	while ((c = prio_queue_peek(&info->indegree_queue)) &&
-	       c->generation >= gen_cutoff)
+	       commit_graph_generation(c) >= gen_cutoff)
 		indegree_walk_step(revs);
 }
 
@@ -3414,8 +3414,8 @@ static void init_topo_walk(struct rev_info *revs)
 		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
 		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
 
-		if (c->generation < info->min_generation)
-			info->min_generation = c->generation;
+		if (commit_graph_generation(c) < info->min_generation)
+			info->min_generation = commit_graph_generation(c);
 
 		*(indegree_slab_at(&info->indegree, c)) = 1;
 
@@ -3473,8 +3473,8 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 		if (parse_commit_gently(parent, 1) < 0)
 			continue;
 
-		if (parent->generation < info->min_generation) {
-			info->min_generation = parent->generation;
+		if (commit_graph_generation(parent) < info->min_generation) {
+			info->min_generation = commit_graph_generation(parent);
 			compute_indegrees_to_depth(revs, info->min_generation);
 		}
 
-- 
2.27.0

