Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F4B28B51F
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481651; cv=none; b=bzYWB5+GpaRc6Y0CaujjZfgbO3Rg8Kctn25/Uh9HIsBLrCjSqm9PNMY1Wfb9tC25EPf2zi+2j3xC7bHCy7OSb5oJRcKyR0nuZsR9c9LZu2KhElY2b55smvECyXM8YheNbTZSIqe6EJ5gXwnYO/5aWQsrP8+DuCeQ/ztisbyPJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481651; c=relaxed/simple;
	bh=RU459qtl5Wpd2NC3vk6zsTUwK55FeZrlfuJAi+mTqKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWgnSDd29l9JsyoXKoIwKbsVH4TCKdPLQgH0uy0ddRfhgSWdpqH/G5oD1QYuSOiNEUamwganmVhdYv8T7eefUn1yAYjJokGJmjR4KmRKvrzZreZvRmbyJo0fJtnb3IAPlEKkIPBvLPzHdxiNE3PKtuIfiW/fjDr5HgfUf4rzOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KjCjC3GA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7vPymKD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KjCjC3GA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7vPymKD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CE357EC01D8;
	Wed,  6 Aug 2025 08:00:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 06 Aug 2025 08:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481648;
	 x=1754568048; bh=XpEAo9FFiFOCFhLrr2tmd0N3LrL8HQXvSJ0HRrCWGQk=; b=
	KjCjC3GA8ErGHBs+PKxCGnIf5o4jGNBVePqDRRj7HAQcQfwkDuas8IkrFFSotwps
	tXeV1aEdHLL8iNe55nX1aTW9r0q0EgX+vPsSW7gT+List9TFz5MYqZFFX43iAaVr
	xwz6PXLmSMHFASNNj1CFC623GQrRW+Qg+pv8arwBKKvnMnkcoIpXFkylNNOSy41N
	r7ipHG4Z3SlMkLt5YmnxWKMGu1oOPJQRwHH3vJTZ8qYXLF8ekOateIQQzFneZqSL
	gw4JJK5So5V7KB8NhXIRO7NucY7G9I5VnEJaUUtFo8dhSoFZg648LGl6CiGCV02c
	KOUzGTX9Fzl9Q0v/2SNCgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481648; x=
	1754568048; bh=XpEAo9FFiFOCFhLrr2tmd0N3LrL8HQXvSJ0HRrCWGQk=; b=F
	7vPymKD5j3D5LGZB4cKI+9uTI+gxtDtV28MWTTKpU/B+68MHaw5HKWXJEOvlLk0K
	GrPqL+JQ5kfoZwlgziSpKdIYO78OXtmgtce/jafV2OhnqV6BgQZBBeFGe4eKgk6b
	cYRVWpydA9AeqJ6U3IKwwUBrIbV9eamdJ06fOhfvO5jMBz3rtbgoajl3T0CM52hp
	NbhQI5UimT4mbXaU8f8i1BpP2eAXpd+nRRRBRO52pr4UXXtAFqWeW0aXcSGRft14
	o+tuexsMi4OBTGMOM9Tr/Myzc9ct5OOvwKejANK72sv+WqCXEn+wlK8KAtdIoeMO
	qWIyTAUpMqLb0PyUp/FBQ==
X-ME-Sender: <xms:8EOTaPddBoFVYGlEa-cKHNOeyPZBPkd0hKTVMh14P6vHRrD9eXONOw>
    <xme:8EOTaAt_6BwztZnKJwgS_hy5L5TE-em7YpeyUk9aI6cC8H_f0rsbb7XlxIZ63WwQJ
    YgGmTA4mEHhj8wdEA>
X-ME-Received: <xmr:8EOTaO8j517LqIpbEdAF8dVUrltHocdU5noU4oj5uw3QLbgmmObcz46irk25VgZPFxOzLGr0e6AozpcnTeqAIbkUQfcXbKV4OaqsNlvx1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:8EOTaL3DHKpfHC_aKiUF2sLxOmSG3Q78rIs1biA_IckY_C1boTxn0Q>
    <xmx:8EOTaDB_U6J5K_6Xcc1MN60-GNciDVxzskfHluQz2QvrdadNV1tWgg>
    <xmx:8EOTaHePS1hMaNxdN2W4amLzPe9TAb4lhm8kVfJT9kbyDYwbStv4KA>
    <xmx:8EOTaA5BNub1S0puKgjC9wemV6HtPxodzx1SZUqNXxXy32wvUgfh-A>
    <xmx:8EOTaMoIlsNrMY1PWp3sIews7e4CQuaPSY10HodRzVRFziG2-z0Th-Fn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c249f749 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:14 +0200
Subject: [PATCH v2 09/10] commit-graph: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-9-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
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
 commit-graph.c   | 77 ++++++++++++++++++++++++++++----------------------------
 commit-graph.h   |  2 +-
 4 files changed, 42 insertions(+), 41 deletions(-)

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
index d351ea5806..35143c356c 100644
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
index 6de624785c..a2471e9bdc 100644
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
2.51.0.rc0.215.g125493bb4a.dirty

