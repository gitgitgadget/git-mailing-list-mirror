Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC32405E3
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295469; cv=none; b=KxIK1bZwDkZesGfJiHdg0YgMNJxVtLvuEFql09VFzjkFfXN4KeUkR/4uulUeVPWeeUArk7sR9go8QMQ/vEKd/XahKNM8foBXYCu2tcb8iAN8ECxq2i/EGFgekMiqfRoWdy+5h6lzP+qdaMezSaZUux6Mkgush3YMOlOYM/YfXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295469; c=relaxed/simple;
	bh=LwTICp9T73j7TC7IIY7jBCDT7qn3e3RdfWE7gd87Um4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ix2OrSt6otCl8psNDudK+GtUFKvZARSXi2EIptbJZq9KKSL55G6mjhOycI6Qvu8FqylOOIAa3Movfuv6fKl+kgSV01ajBp8Jc9DLuQ7pF2I38QTHuzm3X1qDHj9Wt+KeROPBPMGlioJwBlbhDJcz61Bo4l+9v7u9jBGOkshuiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OKeXldb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fx/Hu5h9; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OKeXldb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fx/Hu5h9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 777C31D0013C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 04 Aug 2025 04:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295466;
	 x=1754381866; bh=/ZKKfMS3umjghjL9zN8WptawlFP+EHd5TjP2+rQDCxs=; b=
	OKeXldb0IX/GSfdA0OOo+XeRS2V9tvpZKHKueg8cVSqSjZObnGNx0jxUvtoGL1e4
	JFtMh22jhT1qVA0rj6htlyQQpXAfVjcPy4wgLekPKGaH7C63LymgQKl7nu8JGO1n
	gGfnnyMjhVSazQaKl8oWBZYRVqjEEiMBWh578LK4Wq+lf34DEdkvr6fI3ya62dEe
	aaNXL4UJ6+Ru+qFCYQBl1caJ+CibNn5iC8huAIMObAZQMB/2f62F7CzmVQ0Vf04H
	xYFBzru9RNks2SJpl1vcCsxETEFXW9P/KgAPs6z8pdbTjpLu3zfR8fZbIfPSLLiw
	lOEPvCqGhIQUS5kfItejDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295466; x=
	1754381866; bh=/ZKKfMS3umjghjL9zN8WptawlFP+EHd5TjP2+rQDCxs=; b=f
	x/Hu5h9xy/nIvwCbLZUWhG0TcDOiBYZzOgnnjYPw+wu+tZZ/v9kOdiPyYiBA6Ime
	fgoAdQ/dhpGPD9f0XIxlcedkgI+eQ+YvE300S+WraqBsV/4bPxORDg9JONBtoDMa
	tErUe5xx6F0b1GcD2ArgVFy/dU7wOttRWGo+WmHyiZCcMWm1FFdD/X8IVfrEbbvh
	Lu/cexoZz6oE/5PpXk4KjAMbzmZIqqQ5S6tHVZoQNMGuW+niVpsgYVhhnCOf20sE
	S5hIU1uoNPGmB4a3gkxGg+82y6ngB3+p6DjxILyabjNoGBh9gvQ82VNyzObjXxcZ
	m6axDM2vW6wlB8TYlxmzQ==
X-ME-Sender: <xms:qmyQaH8GAI2uqJq36VjDLj7ePiv48KpVNesW2A9JI47rOWaGAaLwXQ>
    <xme:qmyQaFtJD6qQ_jSW_OtfrEMB0P_ev4kga-hiqQpZnvmQYUQK7JqhX5G6OGeH4VBwm
    YpM_FXhUNRa3_D_SA>
X-ME-Received: <xmr:qmyQaOZ-wxbjio17DVHKVgN2npWEDRxlGB60ZBzCHyNv6niiGijLW0OTEHitIUL3HnPMwtjQ6mODmO1luszbz4s5wo9H1N5wQ39kyC0y8HE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:qmyQaFqhbGbovUfwFx6CZmWvJArdDoP6Sy4xlD8JdexWKCdbiWuVKA>
    <xmx:qmyQaD982sHBfAssSNj1mQlfMYv979964NgCEX-LpKcE7w-lrUIn0w>
    <xmx:qmyQaE-KuhAbfYdU194jEn86CRj66j3z9PWr8QPKX8fG32XeiRbfrg>
    <xmx:qmyQaCt9F5OEbJ-VjpI8FmhPIqwocpHT1jtohuBh10SZbz0GWUGQHw>
    <xmx:qmyQaMnQyomNL0eLmdUD7AjX35BK2GHASBHQ-PoGzlOxoqE6mejMQp0H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79b39246 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:24 +0200
Subject: [PATCH 8/9] commit-graph: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-8-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There's still a bunch of uses of `the_repository` in "commit-graph.c",
which we want to stop using due to it being a global variable. Refactor
the code to stop using `the_repository` in favor of the repository
provided via the calling context.

This allows us to drop the `USE_THE_REPOSITORY_VARIABLE` macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c |  2 +-
 builtin/merge.c  |  2 +-
 commit-graph.c   | 79 ++++++++++++++++++++++++++++----------------------------
 commit-graph.h   |  2 +-
 4 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 63e7158e98..8ca0aede48 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1933,7 +1933,7 @@ int cmd_commit(int argc,
 		      "new index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
-	git_test_write_commit_graph_or_die();
+	git_test_write_commit_graph_or_die(the_repository->objects->sources);
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
diff --git a/builtin/merge.c b/builtin/merge.c
index 18b22c0a26..263cb58471 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1862,7 +1862,7 @@ int cmd_merge(int argc,
 	if (squash) {
 		finish(head_commit, remoteheads, NULL, NULL);
 
-		git_test_write_commit_graph_or_die();
+		git_test_write_commit_graph_or_die(the_repository->objects->sources);
 	} else
 		write_merge_state(remoteheads);
 
diff --git a/commit-graph.c b/commit-graph.c
index b3feb6dfd7..7371db9702 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "csum-file.h"
@@ -27,7 +25,7 @@
 #include "tree.h"
 #include "chunk-format.h"
 
-void git_test_write_commit_graph_or_die(void)
+void git_test_write_commit_graph_or_die(struct odb_source *source)
 {
 	int flags = 0;
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
@@ -36,8 +34,7 @@ void git_test_write_commit_graph_or_die(void)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(the_repository->objects->sources,
-					 flags, NULL))
+	if (write_commit_graph_reachable(source, flags, NULL))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -479,7 +476,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
-		the_repository->hash_algo);
+		hash_algo);
 
 	free_chunkfile(cf);
 	return graph;
@@ -595,7 +592,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 		if (!cur_g ||
 		    !oideq(&oids[n], &cur_g->oid) ||
 		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
-			    the_repository->hash_algo)) {
+			    g->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
 			return 0;
 		}
@@ -665,7 +662,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
 
-		if (get_oid_hex(line.buf, &oids[i])) {
+		if (get_oid_hex_algop(line.buf, &oids[i], r->hash_algo)) {
 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
 				line.buf);
 			valid = 0;
@@ -751,7 +748,7 @@ static void prepare_commit_graph_one(struct repository *r,
  * Return 1 if commit_graph is non-NULL, and 0 otherwise.
  *
  * On the first invocation, this function attempts to load the commit
- * graph if the_repository is configured to have one.
+ * graph if the repository is configured to have one.
  */
 static int prepare_commit_graph(struct repository *r)
 {
@@ -872,7 +869,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 	lex_index = pos - g->num_commits_in_base;
 
 	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, lex_index),
-		the_repository->hash_algo);
+		g->hash_algo);
 }
 
 static struct commit_list **insert_parent_or_die(struct repository *r,
@@ -1115,7 +1112,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 			st_mult(graph_data_width(g->hash_algo),
 				graph_pos - g->num_commits_in_base);
 
-	oidread(&oid, commit_data, the_repository->hash_algo);
+	oidread(&oid, commit_data, g->hash_algo);
 	set_commit_tree(c, lookup_tree(r, &oid));
 
 	return c->maybe_tree;
@@ -1543,7 +1540,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-					the_repository,
+					ctx->r,
 					_("Loading known commits in commit graph"),
 					ctx->oids.nr);
 	for (i = 0; i < ctx->oids.nr; i++) {
@@ -1561,7 +1558,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	 */
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-					the_repository,
+					ctx->r,
 					_("Expanding reachable commits in commit graph"),
 					0);
 	for (i = 0; i < ctx->oids.nr; i++) {
@@ -1582,7 +1579,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-					the_repository,
+					ctx->r,
 					_("Clearing commit marks in commit graph"),
 					ctx->oids.nr);
 	for (i = 0; i < ctx->oids.nr; i++) {
@@ -1699,7 +1696,7 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 	if (ctx->report_progress)
 		info.progress = ctx->progress
 			      = start_delayed_progress(
-					the_repository,
+					ctx->r,
 					_("Computing commit graph topological levels"),
 					ctx->commits.nr);
 
@@ -1734,7 +1731,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	if (ctx->report_progress)
 		info.progress = ctx->progress
 			      = start_delayed_progress(
-					the_repository,
+					ctx->r,
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 
@@ -1811,7 +1808,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		progress = start_delayed_progress(
-			the_repository,
+			ctx->r,
 			_("Computing commit changed paths Bloom filters"),
 			ctx->commits.nr);
 
@@ -1857,6 +1854,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 }
 
 struct refs_cb_data {
+	struct repository *repo;
 	struct oidset *commits;
 	struct progress *progress;
 };
@@ -1869,9 +1867,9 @@ static int add_ref_to_set(const char *refname UNUSED,
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!peel_iterated_oid(data->repo, oid, &peeled))
 		oid = &peeled;
-	if (odb_read_object_info(the_repository->objects, oid, NULL) == OBJ_COMMIT)
+	if (odb_read_object_info(data->repo->objects, oid, NULL) == OBJ_COMMIT)
 		oidset_insert(data->commits, oid);
 
 	display_progress(data->progress, oidset_size(data->commits));
@@ -1888,13 +1886,15 @@ int write_commit_graph_reachable(struct odb_source *source,
 	int result;
 
 	memset(&data, 0, sizeof(data));
+	data.repo = source->odb->repo;
 	data.commits = &commits;
+
 	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		data.progress = start_delayed_progress(
-			the_repository,
+			source->odb->repo,
 			_("Collecting referenced commits"), 0);
 
-	refs_for_each_ref(get_main_ref_store(the_repository), add_ref_to_set,
+	refs_for_each_ref(get_main_ref_store(source->odb->repo), add_ref_to_set,
 			  &data);
 
 	stop_progress(&data.progress);
@@ -1923,7 +1923,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 			       "Finding commits for commit graph in %"PRIuMAX" packs",
 			       pack_indexes->nr),
 			    (uintmax_t)pack_indexes->nr);
-		ctx->progress = start_delayed_progress(the_repository,
+		ctx->progress = start_delayed_progress(ctx->r,
 						       progress_title.buf, 0);
 		ctx->progress_done = 0;
 	}
@@ -1977,7 +1977,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 {
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-			the_repository,
+			ctx->r,
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
 	for_each_packed_object(ctx->r, add_packed_commits, ctx,
@@ -1996,7 +1996,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	ctx->num_extra_edges = 0;
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-			the_repository,
+			ctx->r,
 			_("Finding extra edges in commit graph"),
 			ctx->oids.nr);
 	oid_array_sort(&ctx->oids);
@@ -2075,7 +2075,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		ctx->graph_name = get_commit_graph_filename(ctx->odb_source);
 	}
 
-	if (safe_create_leading_directories(the_repository, ctx->graph_name)) {
+	if (safe_create_leading_directories(ctx->r, ctx->graph_name)) {
 		error(_("unable to create leading directories of %s"),
 			ctx->graph_name);
 		return -1;
@@ -2094,18 +2094,18 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			return -1;
 		}
 
-		if (adjust_shared_perm(the_repository, get_tempfile_path(graph_layer))) {
+		if (adjust_shared_perm(ctx->r, get_tempfile_path(graph_layer))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(graph_layer));
 			return -1;
 		}
 
-		f = hashfd(the_repository->hash_algo,
+		f = hashfd(ctx->r->hash_algo,
 			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
 					       LOCK_DIE_ON_ERROR, 0444);
-		f = hashfd(the_repository->hash_algo,
+		f = hashfd(ctx->r->hash_algo,
 			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
 
@@ -2158,7 +2158,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			       get_num_chunks(cf)),
 			    get_num_chunks(cf));
 		ctx->progress = start_delayed_progress(
-			the_repository,
+			ctx->r,
 			progress_title.buf,
 			st_mult(get_num_chunks(cf), ctx->commits.nr));
 	}
@@ -2216,7 +2216,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		}
 
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
-		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
+		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] =
+			xstrdup(hash_to_hex_algop(file_hash, ctx->r->hash_algo));
 		final_graph_name = get_split_graph_filename(ctx->odb_source,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
@@ -2370,7 +2371,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
-					the_repository,
+					ctx->r,
 					_("Scanning merged commits"),
 					ctx->commits.nr);
 
@@ -2415,7 +2416,7 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
 		current_graph_number--;
 
 		if (ctx->report_progress)
-			ctx->progress = start_delayed_progress(the_repository,
+			ctx->progress = start_delayed_progress(ctx->r,
 							       _("Merging commit-graph"), 0);
 
 		merge_commit_graph(ctx, g);
@@ -2518,7 +2519,7 @@ int write_commit_graph(struct odb_source *source,
 		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_opts *opts)
 {
-	struct repository *r = the_repository;
+	struct repository *r = source->odb->repo;
 	struct write_commit_graph_context ctx = {
 		.r = r,
 		.odb_source = source,
@@ -2618,14 +2619,14 @@ int write_commit_graph(struct odb_source *source,
 			replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
-	ctx.approx_nr_objects = repo_approximate_object_count(the_repository);
+	ctx.approx_nr_objects = repo_approximate_object_count(r);
 
 	if (ctx.append && ctx.r->objects->commit_graph) {
 		struct commit_graph *g = ctx.r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
 			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
-				the_repository->hash_algo);
+				r->hash_algo);
 			oid_array_append(&ctx.oids, &oid);
 		}
 	}
@@ -2733,7 +2734,7 @@ static void graph_report(const char *fmt, ...)
 
 static int commit_graph_checksum_valid(struct commit_graph *g)
 {
-	return hashfile_checksum_valid(the_repository->hash_algo,
+	return hashfile_checksum_valid(g->hash_algo,
 				       g->data, g->data_len);
 }
 
@@ -2756,7 +2757,7 @@ static int verify_one_commit_graph(struct repository *r,
 		struct commit *graph_commit;
 
 		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
-			the_repository->hash_algo);
+			g->hash_algo);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
 			graph_report(_("commit-graph has incorrect OID order: %s then %s"),
@@ -2801,7 +2802,7 @@ static int verify_one_commit_graph(struct repository *r,
 
 		display_progress(progress, ++(*seen));
 		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
-			the_repository->hash_algo);
+			g->hash_algo);
 
 		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
@@ -2905,7 +2906,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
 			total += g->num_commits_in_base;
 
-		progress = start_progress(the_repository,
+		progress = start_progress(r,
 					  _("Verifying commits in commit graph"),
 					  total);
 	}
diff --git a/commit-graph.h b/commit-graph.h
index f26881849d..24c1aca69e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -21,7 +21,7 @@
  * call this method oustide of a builtin, and only if you know what
  * you are doing!
  */
-void git_test_write_commit_graph_or_die(void);
+void git_test_write_commit_graph_or_die(struct odb_source *source);
 
 struct commit;
 struct bloom_filter_settings;

-- 
2.50.1.723.g3e08bea96f.dirty

