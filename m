Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034C1F5851
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106028; cv=none; b=alHIOLjzqrmrfeuMoTkJWWtx3sgzfBj6jOW5Ejzch+cYmoapUJYDiyBWiVEDMBWjIpSx0iO8kEgq23gfSdiqgYfnyVQFGk6vCJo7vr8khK0rKf0QnmzHH+JbLwqlPYKjbj4X1XUFwjwJjdM1fZdunbLUdVZ4NK2V5c4jL9nLfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106028; c=relaxed/simple;
	bh=yeimKQTAoeet9H+M9jVhqrU8Oh/K3xLyBTNfjho/fVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSP3GKAxD/nSilPw29Zxci4WjLh90DIF+DvDzVV5J93eZf+5EA/Ch6Awvbfl+sTfCAZoa7LhsY0Y1rN4pvuR4yVy4ZpcWcvNylJHTUzTNOMQY/LmK9bMPSsYDuSTqAnUnp/nkICbgCbtmArE4GErFPZKcYHC2fT1vGpg1Fq2NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cE8xVWby; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qy74JxSC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cE8xVWby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qy74JxSC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FE5325400E4;
	Thu,  5 Jun 2025 02:47:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 02:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106022;
	 x=1749192422; bh=SZjLlegO5O+2sLRmMJQgLg0pAAqVtSYQ0jugyczDtUk=; b=
	cE8xVWbydhsLl09tYn8kpuemBgYzR4fIx+9GpR5GuNjakAq/aWukrVjZUJGjqzFY
	AUZ43XPzXazFEBLQXf4zFc4VNFL9l1hKoZ7UHsiET65A8SG/Bvt09SHRlSFzhLZd
	gB4AhksBThoA3F2mCWPoQOhbRsB3/fBqD3fQcD6vqzmemiig7OhnM4c3sd2hv0/3
	mJo9AzEWscZ66UnFpiBarOzcCdlL79Ql7fddxIpJPGSoK6YHZGhHbGfoZgW1wh/f
	E9dmJNoGEH2uFiMFlKbBL2oRQ86cycAi9owEAtRFIn0A7ZG5szSsB8zf1LJ44AO5
	GCAcox8p2q/pIvDiBeXCkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106022; x=
	1749192422; bh=SZjLlegO5O+2sLRmMJQgLg0pAAqVtSYQ0jugyczDtUk=; b=Q
	y74JxSCb/qN6e0Y1w8bKn2NQLxVOlY5aOVx0OVWNqR9QWzFAi63uSbZgXbv0cmzG
	8lKetCwhbv4LlM4jxVqpL7kpie+81vLi9Xy2yzAX/CH/IXgb+YwTbMmfBdTmd4Gw
	MpUuFAOOU02PHhy/Dgq1KWGmyt949KcSSo6pkNnvUWFclHV/Vr8+Y0ntwCXsSPL9
	QsEKXkrt7cis10IHLrGcGWdcFOjcIn7VhGLSICQlXqJ2XLrzicFETVt8XalMf4sU
	SW3EkgKDDGKdZgL4tfiJtVjVFfp+//81RYPPRlUD7pNolqIyu3fsVf7mOJEw2od+
	5dOjgsO0h364xsOxkTl1w==
X-ME-Sender: <xms:Zj1BaPHFTWw2jcqDwIAAg79tKE__GGxhiuLw9nates585P2Xd7ThMw>
    <xme:Zj1BaMXpFb0cITkyAyrH0pQsYtgu8PFECOOCB9cHwhTcbTfy_x8HXpxWnISvsW89l
    UbCadUD6fdYLfwsqQ>
X-ME-Received: <xmr:Zj1BaBLfV4G86Rs75UwD8JbNNc4dU-ke7jKRB0YOA0FKBMYElinGiKAnuqWSSGXuM5xqEW4sAm6HfAX3lYYMi0hcVcoFw1DkkNdeIk5J_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:Zj1BaNGST4pGnJnR8-3sc_S7jCpQ4oUjSVmpHfaQ35NUmHId7LEh8w>
    <xmx:Zj1BaFUNuTR3Vf61xaP1D6VNGC3_nArRzBZbi_Wp_fgFi_QqlTBOQw>
    <xmx:Zj1BaIOnBzYnmsjQpJ3AkhtJqwUwzUpDZMRmubZeUBn8vwCi4jNqZA>
    <xmx:Zj1BaE2WI1vY2_eJxNbv9pAeyqu5xjsXUBnJ16RD-0dqXcClrshPQQ>
    <xmx:Zj1BaMuVKktFl4zDIfLhr0VY56s1uW5D-kkXKOgSPqPT14xsN9lx_yAo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a68ea65e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:46:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:52 +0200
Subject: [PATCH v5 02/17] object-store: rename `object_directory` to
 `odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-2-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The `object_directory` structure is used as an access point for a single
object directory like ".git/objects". While the structure isn't yet
fully self-contained, the intent is for it to eventually contain all
information required to access objects in one specific location.

While the name "object directory" is a good fit for now, this will
change over time as we continue with the agenda to make pluggable object
databases a thing. Eventually, objects may not be accessed via any kind
of directory at all anymore, but they could instead be backed by any
kind of durable storage mechanism. While it seems quite far-fetched for
now, it is thinkable that eventually this might even be some form of a
database, for example.

As such, the current name of this structure will become worse over time
as we evolve into the direction of pluggable ODBs. Immediate next steps
will start to carve out proper self-contained object directories, which
requires us to pass in these object directories as parameters. Based on
our modern naming schema this means that those functions should then be
named after their subsystem, which means that we would start to bake the
current name into the codebase more and more.

Let's preempt this by renaming the structure. There have been a couple
alternatives that were discussed:

  - `odb_backend` was discarded because it led to the association that
    one object database has a single backend, but the model is that one
    alternate has one backend. Furthermore, "backend" is more about the
    actual backing implementation and less about the high-level concept.

  - `odb_alternate` was discarded because it is a bit of a stretch to
    also call the main object directory an "alternate".

Instead, pick `odb_source` as the new name. It makes it sufficiently
clear that there can be multiple sources and does not cause confusion
when mixed with the already-existing "alternate" terminology.

In the future, this change allows us to easily introduce for example a
`odb_files_source` and other format-specific implementations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c      |  18 +++----
 builtin/count-objects.c     |   4 +-
 builtin/fetch.c             |   2 +-
 builtin/fsck.c              |  14 ++---
 builtin/gc.c                |  14 ++---
 builtin/grep.c              |   2 +-
 builtin/multi-pack-index.c  |   4 +-
 builtin/submodule--helper.c |   6 +--
 bundle.c                    |   2 +-
 commit-graph.c              |  94 +++++++++++++++++-----------------
 commit-graph.h              |  14 ++---
 diagnose.c                  |   8 +--
 http-walker.c               |   2 +-
 http.c                      |   4 +-
 loose.c                     |  42 +++++++--------
 midx.c                      |   6 +--
 object-file.c               |  80 ++++++++++++++---------------
 object-file.h               |   8 +--
 object-name.c               |   6 +--
 object-store.c              | 122 ++++++++++++++++++++++----------------------
 object-store.h              |  38 +++++++++-----
 packfile.c                  |  16 +++---
 path.c                      |   2 +-
 refs.c                      |   2 +-
 repository.c                |  14 ++---
 submodule-config.c          |   2 +-
 t/helper/test-read-graph.c  |   6 +--
 tmp-objdir.c                |  24 ++++-----
 28 files changed, 284 insertions(+), 272 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a783a86e797..98a84315342 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -66,7 +66,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
-	struct object_directory *odb = NULL;
+	struct odb_source *source = NULL;
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
@@ -101,9 +101,9 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	odb = find_odb(the_repository, opts.obj_dir);
-	graph_name = get_commit_graph_filename(odb);
-	chain_name = get_commit_graph_chain_filename(odb);
+	source = find_odb(the_repository, opts.obj_dir);
+	graph_name = get_commit_graph_filename(source);
+	chain_name = get_commit_graph_chain_filename(source);
 	if (open_commit_graph(graph_name, &fd, &st))
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
@@ -120,7 +120,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
+		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, source);
 	else
 		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st,
 						      &incomplete_chain);
@@ -221,7 +221,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
-	struct object_directory *odb = NULL;
+	struct odb_source *source = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
@@ -289,10 +289,10 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	odb = find_odb(the_repository, opts.obj_dir);
+	source = find_odb(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(odb, flags, &write_opts))
+		if (write_commit_graph_reachable(source, flags, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -318,7 +318,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(odb,
+	if (write_commit_graph(source,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a88c0c9c09a..58e0af433d1 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -80,10 +80,10 @@ static int count_cruft(const char *basename UNUSED, const char *path,
 	return 0;
 }
 
-static int print_alternate(struct object_directory *odb, void *data UNUSED)
+static int print_alternate(struct odb_source *alternate, void *data UNUSED)
 {
 	printf("alternate: ");
-	quote_c_style(odb->path, NULL, stdout, 0);
+	quote_c_style(alternate->path, NULL, stdout, 0);
 	putchar('\n');
 	return 0;
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 40a0e8d2443..a890e2864d1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2653,7 +2653,7 @@ int cmd_fetch(int argc,
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		trace2_region_enter("fetch", "write-commit-graph", the_repository);
-		write_commit_graph_reachable(the_repository->objects->odb,
+		write_commit_graph_reachable(the_repository->objects->sources,
 					     commit_graph_flags,
 					     NULL);
 		trace2_region_leave("fetch", "write-commit-graph", the_repository);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index e7d96a9c8ea..6e1474f63d5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -956,7 +956,7 @@ int cmd_fsck(int argc,
 	     struct repository *repo UNUSED)
 {
 	int i;
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -998,8 +998,8 @@ int cmd_fsck(int argc,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next)
-			fsck_object_dir(odb->path);
+		for (source = the_repository->objects->sources; source; source = source->next)
+			fsck_object_dir(source->path);
 
 		if (check_full) {
 			struct packed_git *p;
@@ -1109,11 +1109,11 @@ int cmd_fsck(int argc,
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		for (source = the_repository->objects->sources; source; source = source->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
-				     "verify", "--object-dir", odb->path, NULL);
+				     "verify", "--object-dir", source->path, NULL);
 			if (show_progress)
 				strvec_push(&commit_graph_verify.args, "--progress");
 			else
@@ -1127,11 +1127,11 @@ int cmd_fsck(int argc,
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		for (source = the_repository->objects->sources; source; source = source->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
 			strvec_pushl(&midx_verify.args, "multi-pack-index",
-				     "verify", "--object-dir", odb->path, NULL);
+				     "verify", "--object-dir", source->path, NULL);
 			if (show_progress)
 				strvec_push(&midx_verify.args, "--progress");
 			else
diff --git a/builtin/gc.c b/builtin/gc.c
index e33ba946e43..50a09eb07e3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1018,7 +1018,7 @@ int cmd_gc(int argc,
 	}
 
 	if (the_repository->settings.gc_write_commit_graph == 1)
-		write_commit_graph_reachable(the_repository->objects->odb,
+		write_commit_graph_reachable(the_repository->objects->sources,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
@@ -1271,7 +1271,7 @@ static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 	if (loose_object_auto_limit < 0)
 		return 1;
 
-	return for_each_loose_file_in_objdir(the_repository->objects->odb->path,
+	return for_each_loose_file_in_objdir(the_repository->objects->sources->path,
 					     loose_object_count,
 					     NULL, NULL, &count);
 }
@@ -1306,7 +1306,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	 * Do not start pack-objects process
 	 * if there are no loose objects.
 	 */
-	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
+	if (!for_each_loose_file_in_objdir(r->objects->sources->path,
 					   bail_on_loose,
 					   NULL, NULL, NULL))
 		return 0;
@@ -1318,7 +1318,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 		strvec_push(&pack_proc.args, "--quiet");
 	else
 		strvec_push(&pack_proc.args, "--no-quiet");
-	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->sources->path);
 
 	pack_proc.in = -1;
 
@@ -1346,7 +1346,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	else if (data.batch_size > 0)
 		data.batch_size--; /* Decrease for equality on limit. */
 
-	for_each_loose_file_in_objdir(r->objects->odb->path,
+	for_each_loose_file_in_objdir(r->objects->sources->path,
 				      write_loose_object_to_stdin,
 				      NULL,
 				      NULL,
@@ -1611,7 +1611,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
-	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
+	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		/*
@@ -3083,7 +3083,7 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 	unsigned int i;
 	int result = 0;
 	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->sources->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		if (errno == EEXIST)
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ce574a605b..76b1938bba5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -505,7 +505,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * lazily registered as alternates when needed (and except in an
 	 * unexpected code interaction, it won't be needed).
 	 */
-	add_submodule_odb_by_path(subrepo->objects->odb->path);
+	add_submodule_odb_by_path(subrepo->objects->sources->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 69a97507324..f55bf53da83 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -294,8 +294,8 @@ int cmd_multi_pack_index(int argc,
 
 	if (the_repository &&
 	    the_repository->objects &&
-	    the_repository->objects->odb)
-		opts.object_dir = xstrdup(the_repository->objects->odb->path);
+	    the_repository->objects->sources)
+		opts.object_dir = xstrdup(the_repository->objects->sources->path);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_multi_pack_index_usage, 0);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116ddf..758bc6d0f24 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1582,7 +1582,7 @@ static const char alternate_error_advice[] = N_(
 );
 
 static int add_possible_reference_from_superproject(
-		struct object_directory *odb, void *sas_cb)
+		struct odb_source *alt_odb, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
 	size_t len;
@@ -1591,12 +1591,12 @@ static int add_possible_reference_from_superproject(
 	 * If the alternate object store is another repository, try the
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
-	if (strip_suffix(odb->path, "/objects", &len)) {
+	if (strip_suffix(alt_odb->path, "/objects", &len)) {
 		struct repository alternate;
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
-		strbuf_add(&sb, odb->path, len);
+		strbuf_add(&sb, alt_odb->path, len);
 
 		if (repo_init(&alternate, sb.buf, NULL) < 0)
 			die(_("could not get a repository handle for gitdir '%s'"),
diff --git a/bundle.c b/bundle.c
index b0a3fee2efa..2ce7525f90d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -233,7 +233,7 @@ int verify_bundle(struct repository *r,
 		.quiet = 1,
 	};
 
-	if (!r || !r->objects || !r->objects->odb)
+	if (!r || !r->objects || !r->objects->sources)
 		return error(_("need a repository to verify a bundle"));
 
 	for (i = 0; i < p->nr; i++) {
diff --git a/commit-graph.c b/commit-graph.c
index 905fcbdf0e8..12d32cdad1d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -37,7 +37,7 @@ void git_test_write_commit_graph_or_die(void)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(the_repository->objects->odb,
+	if (write_commit_graph_reachable(the_repository->objects->sources,
 					 flags, NULL))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
@@ -191,21 +191,21 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-char *get_commit_graph_filename(struct object_directory *obj_dir)
+char *get_commit_graph_filename(struct odb_source *source)
 {
-	return xstrfmt("%s/info/commit-graph", obj_dir->path);
+	return xstrfmt("%s/info/commit-graph", source->path);
 }
 
-static char *get_split_graph_filename(struct object_directory *odb,
+static char *get_split_graph_filename(struct odb_source *source,
 				      const char *oid_hex)
 {
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", odb->path,
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", source->path,
 		       oid_hex);
 }
 
-char *get_commit_graph_chain_filename(struct object_directory *odb)
+char *get_commit_graph_chain_filename(struct odb_source *source)
 {
-	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", source->path);
 }
 
 static struct commit_graph *alloc_commit_graph(void)
@@ -250,7 +250,7 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
-						 struct object_directory *odb)
+						 struct odb_source *source)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -269,7 +269,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
 
 	if (ret)
-		ret->odb = odb;
+		ret->odb_source = source;
 	else
 		munmap(graph_map, graph_size);
 
@@ -487,7 +487,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 static struct commit_graph *load_commit_graph_one(struct repository *r,
 						  const char *graph_file,
-						  struct object_directory *odb)
+						  struct odb_source *source)
 {
 
 	struct stat st;
@@ -498,7 +498,7 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(r, fd, &st, odb);
+	g = load_commit_graph_one_fd_st(r, fd, &st, source);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -507,10 +507,10 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
 }
 
 static struct commit_graph *load_commit_graph_v1(struct repository *r,
-						 struct object_directory *odb)
+						 struct odb_source *source)
 {
-	char *graph_name = get_commit_graph_filename(odb);
-	struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
+	char *graph_name = get_commit_graph_filename(source);
+	struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
 	free(graph_name);
 
 	return g;
@@ -652,7 +652,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	prepare_alt_odb(r);
 
 	for (i = 0; i < count; i++) {
-		struct object_directory *odb;
+		struct odb_source *source;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
@@ -665,9 +665,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		}
 
 		valid = 0;
-		for (odb = r->objects->odb; odb; odb = odb->next) {
-			char *graph_name = get_split_graph_filename(odb, line.buf);
-			struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
+		for (source = r->objects->sources; source; source = source->next) {
+			char *graph_name = get_split_graph_filename(source, line.buf);
+			struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
 
 			free(graph_name);
 
@@ -701,9 +701,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 }
 
 static struct commit_graph *load_commit_graph_chain(struct repository *r,
-						    struct object_directory *odb)
+						    struct odb_source *source)
 {
-	char *chain_file = get_commit_graph_chain_filename(odb);
+	char *chain_file = get_commit_graph_chain_filename(source);
 	struct stat st;
 	int fd;
 	struct commit_graph *g = NULL;
@@ -719,24 +719,24 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 }
 
 struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct object_directory *odb)
+					   struct odb_source *source)
 {
-	struct commit_graph *g = load_commit_graph_v1(r, odb);
+	struct commit_graph *g = load_commit_graph_v1(r, source);
 
 	if (!g)
-		g = load_commit_graph_chain(r, odb);
+		g = load_commit_graph_chain(r, source);
 
 	return g;
 }
 
 static void prepare_commit_graph_one(struct repository *r,
-				     struct object_directory *odb)
+				     struct odb_source *source)
 {
 
 	if (r->objects->commit_graph)
 		return;
 
-	r->objects->commit_graph = read_commit_graph_one(r, odb);
+	r->objects->commit_graph = read_commit_graph_one(r, source);
 }
 
 /*
@@ -747,7 +747,7 @@ static void prepare_commit_graph_one(struct repository *r,
  */
 static int prepare_commit_graph(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	/*
 	 * Early return if there is no git dir or if the commit graph is
@@ -779,10 +779,10 @@ static int prepare_commit_graph(struct repository *r)
 		return 0;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb;
-	     !r->objects->commit_graph && odb;
-	     odb = odb->next)
-		prepare_commit_graph_one(r, odb);
+	for (source = r->objects->sources;
+	     !r->objects->commit_graph && source;
+	     source = source->next)
+		prepare_commit_graph_one(r, source);
 	return !!r->objects->commit_graph;
 }
 
@@ -1137,7 +1137,7 @@ struct packed_commit_list {
 
 struct write_commit_graph_context {
 	struct repository *r;
-	struct object_directory *odb;
+	struct odb_source *odb_source;
 	char *graph_name;
 	struct oid_array oids;
 	struct packed_commit_list commits;
@@ -1870,7 +1870,7 @@ static int add_ref_to_set(const char *refname UNUSED,
 	return 0;
 }
 
-int write_commit_graph_reachable(struct object_directory *odb,
+int write_commit_graph_reachable(struct odb_source *source,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts)
 {
@@ -1890,7 +1890,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 
 	stop_progress(&data.progress);
 
-	result = write_commit_graph(odb, NULL, &commits,
+	result = write_commit_graph(source, NULL, &commits,
 				    flags, opts);
 
 	oidset_clear(&commits);
@@ -1906,7 +1906,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	int dirlen;
 	int ret = 0;
 
-	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
+	strbuf_addf(&packname, "%s/pack/", ctx->odb_source->path);
 	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
@@ -2060,10 +2060,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		strbuf_addf(&tmp_file,
 			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
-			    ctx->odb->path);
+			    ctx->odb_source->path);
 		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
 	} else {
-		ctx->graph_name = get_commit_graph_filename(ctx->odb);
+		ctx->graph_name = get_commit_graph_filename(ctx->odb_source);
 	}
 
 	if (safe_create_leading_directories(the_repository, ctx->graph_name)) {
@@ -2073,7 +2073,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_commit_graph_chain_filename(ctx->odb);
+		char *lock_name = get_commit_graph_chain_filename(ctx->odb_source);
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
@@ -2161,7 +2161,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb_source, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -2201,14 +2201,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				}
 			}
 		} else {
-			char *graph_name = get_commit_graph_filename(ctx->odb);
+			char *graph_name = get_commit_graph_filename(ctx->odb_source);
 			unlink(graph_name);
 			free(graph_name);
 		}
 
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
-		final_graph_name = get_split_graph_filename(ctx->odb,
+		final_graph_name = get_split_graph_filename(ctx->odb_source,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
@@ -2259,7 +2259,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
 		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
 			    (max_commits && num_commits > max_commits))) {
-			if (g->odb != ctx->odb)
+			if (g->odb_source != ctx->odb_source)
 				break;
 
 			if (unsigned_add_overflows(num_commits, g->num_commits))
@@ -2281,10 +2281,10 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		    "should be 1 with --split=replace");
 
 	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->odb);
+		char *old_graph_name = get_commit_graph_filename(g->odb_source);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    g->odb != ctx->odb) {
+		    g->odb_source != ctx->odb_source) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -2456,13 +2456,13 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->opts && ctx->opts->expire_time)
 		expire_time = ctx->opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb);
+		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb_source);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
 	}
 
-	strbuf_addstr(&path, ctx->odb->path);
+	strbuf_addstr(&path, ctx->odb_source->path);
 	strbuf_addstr(&path, "/info/commit-graphs");
 	dir = opendir(path.buf);
 
@@ -2504,7 +2504,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(struct object_directory *odb,
+int write_commit_graph(struct odb_source *source,
 		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
@@ -2513,7 +2513,7 @@ int write_commit_graph(struct object_directory *odb,
 	struct repository *r = the_repository;
 	struct write_commit_graph_context ctx = {
 		.r = r,
-		.odb = odb,
+		.odb_source = source,
 		.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
 		.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
 		.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
diff --git a/commit-graph.h b/commit-graph.h
index 20d38c100ce..0e661db1b54 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -29,8 +29,8 @@ struct repository;
 struct object_database;
 struct string_list;
 
-char *get_commit_graph_filename(struct object_directory *odb);
-char *get_commit_graph_chain_filename(struct object_directory *odb);
+char *get_commit_graph_filename(struct odb_source *source);
+char *get_commit_graph_chain_filename(struct odb_source *source);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
 
@@ -89,7 +89,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
-	struct object_directory *odb;
+	struct odb_source *odb_source;
 
 	uint32_t num_commits_in_base;
 	unsigned int read_generation_data;
@@ -115,12 +115,12 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
-						 struct object_directory *odb);
+						 struct odb_source *source);
 struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);
 struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct object_directory *odb);
+					   struct odb_source *source);
 
 struct repo_settings;
 
@@ -173,10 +173,10 @@ struct commit_graph_opts {
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
  */
-int write_commit_graph_reachable(struct object_directory *odb,
+int write_commit_graph_reachable(struct odb_source *source,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts);
-int write_commit_graph(struct object_directory *odb,
+int write_commit_graph(struct odb_source *source,
 		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
diff --git a/diagnose.c b/diagnose.c
index b1be74be983..d08d5643aac 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -59,13 +59,13 @@ static void dir_file_stats_objects(const char *full_path,
 			    (uintmax_t)st.st_size);
 }
 
-static int dir_file_stats(struct object_directory *object_dir, void *data)
+static int dir_file_stats(struct odb_source *source, void *data)
 {
 	struct strbuf *buf = data;
 
-	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+	strbuf_addf(buf, "Contents of %s:\n", source->path);
 
-	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+	for_each_file_in_pack_dir(source->path, dir_file_stats_objects,
 				  data);
 
 	return 0;
@@ -228,7 +228,7 @@ int create_diagnostics_archive(struct repository *r,
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(r->objects->odb, &buf);
+	dir_file_stats(r->objects->sources, &buf);
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
diff --git a/http-walker.c b/http-walker.c
index 463f7b119ad..c374e6b2056 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -543,7 +543,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		odb_loose_path(the_repository->objects->odb, &buf, &req->oid);
+		odb_loose_path(the_repository->objects->sources, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 3c029cf8947..5e15bbab3f1 100644
--- a/http.c
+++ b/http.c
@@ -2662,7 +2662,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->sources, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2814,7 +2814,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	odb_loose_path(the_repository->objects->odb, &filename, &freq->oid);
+	odb_loose_path(the_repository->objects->sources, &filename, &freq->oid);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/loose.c b/loose.c
index bb602aaa366..fe65d5b9b0f 100644
--- a/loose.c
+++ b/loose.c
@@ -44,36 +44,36 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
-static int insert_loose_map(struct object_directory *odb,
+static int insert_loose_map(struct odb_source *source,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct loose_object_map *map = odb->loose_map;
+	struct loose_object_map *map = source->loose_map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(odb->loose_objects_cache, compat_oid);
+		oidtree_insert(source->loose_objects_cache, compat_oid);
 
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
+static int load_one_loose_object_map(struct repository *repo, struct odb_source *source)
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!dir->loose_map)
-		loose_object_map_init(&dir->loose_map);
-	if (!dir->loose_objects_cache) {
-		ALLOC_ARRAY(dir->loose_objects_cache, 1);
-		oidtree_init(dir->loose_objects_cache);
+	if (!source->loose_map)
+		loose_object_map_init(&source->loose_map);
+	if (!source->loose_objects_cache) {
+		ALLOC_ARRAY(source->loose_objects_cache, 1);
+		oidtree_init(source->loose_objects_cache);
 	}
 
-	insert_loose_map(dir, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_loose_map(source, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_loose_map(source, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
@@ -93,7 +93,7 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_loose_map(dir, &oid, &compat_oid);
+		insert_loose_map(source, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -107,15 +107,15 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 
 int repo_read_loose_object_map(struct repository *repo)
 {
-	struct object_directory *dir;
+	struct odb_source *source;
 
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
 	prepare_alt_odb(repo);
 
-	for (dir = repo->objects->odb; dir; dir = dir->next) {
-		if (load_one_loose_object_map(repo, dir) < 0) {
+	for (source = repo->objects->sources; source; source = source->next) {
+		if (load_one_loose_object_map(repo, source) < 0) {
 			return -1;
 		}
 	}
@@ -124,7 +124,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
+	kh_oid_map_t *map = repo->objects->sources->loose_map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -212,7 +212,7 @@ int repo_add_loose_object_map(struct repository *repo, const struct object_id *o
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	inserted = insert_loose_map(repo->objects->odb, oid, compat_oid);
+	inserted = insert_loose_map(repo->objects->sources, oid, compat_oid);
 	if (inserted)
 		return write_one_object(repo, oid, compat_oid);
 	return 0;
@@ -223,12 +223,12 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct git_hash_algo *to,
 			      struct object_id *dest)
 {
-	struct object_directory *dir;
+	struct odb_source *source;
 	kh_oid_map_t *map;
 	khiter_t pos;
 
-	for (dir = repo->objects->odb; dir; dir = dir->next) {
-		struct loose_object_map *loose_map = dir->loose_map;
+	for (source = repo->objects->sources; source; source = source->next) {
+		struct loose_object_map *loose_map = source->loose_map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index cd6e766ce2b..3c5bc821730 100644
--- a/midx.c
+++ b/midx.c
@@ -832,7 +832,7 @@ void clear_midx_file(struct repository *r)
 {
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(r->hash_algo, &midx, r->objects->odb->path);
+	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
 
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
@@ -842,8 +842,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_BITMAP, NULL);
-	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_REV, NULL);
+	clear_midx_files_ext(r->objects->sources->path, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(r->objects->sources->path, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
diff --git a/object-file.c b/object-file.c
index 1ac04c28916..6bad1d3dd1c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -55,12 +55,12 @@ static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 	}
 }
 
-const char *odb_loose_path(struct object_directory *odb,
+const char *odb_loose_path(struct odb_source *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid)
 {
 	strbuf_reset(buf);
-	strbuf_addstr(buf, odb->path);
+	strbuf_addstr(buf, source->path);
 	strbuf_addch(buf, '/');
 	fill_loose_path(buf, oid);
 	return buf->buf;
@@ -88,27 +88,27 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_odb(struct object_directory *odb,
+static int check_and_freshen_odb(struct odb_source *source,
 				 const struct object_id *oid,
 				 int freshen)
 {
 	static struct strbuf path = STRBUF_INIT;
-	odb_loose_path(odb, &path, oid);
+	odb_loose_path(source, &path, oid);
 	return check_and_freshen_file(path.buf, freshen);
 }
 
 static int check_and_freshen_local(const struct object_id *oid, int freshen)
 {
-	return check_and_freshen_odb(the_repository->objects->odb, oid, freshen);
+	return check_and_freshen_odb(the_repository->objects->sources, oid, freshen);
 }
 
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb->next; odb; odb = odb->next) {
-		if (check_and_freshen_odb(odb, oid, freshen))
+	for (source = the_repository->objects->sources->next; source; source = source->next) {
+		if (check_and_freshen_odb(source, oid, freshen))
 			return 1;
 	}
 	return 0;
@@ -202,12 +202,12 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 static int stat_loose_object(struct repository *r, const struct object_id *oid,
 			     struct stat *st, const char **path)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, oid);
+	for (source = r->objects->sources; source; source = source->next) {
+		*path = odb_loose_path(source, &buf, oid);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -223,13 +223,13 @@ static int open_loose_object(struct repository *r,
 			     const struct object_id *oid, const char **path)
 {
 	int fd;
-	struct object_directory *odb;
+	struct odb_source *source;
 	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, oid);
+	for (source = r->objects->sources; source; source = source->next) {
+		*path = odb_loose_path(source, &buf, oid);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
@@ -244,11 +244,11 @@ static int open_loose_object(struct repository *r,
 static int quick_has_loose(struct repository *r,
 			   const struct object_id *oid)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		if (oidtree_contains(odb_loose_cache(odb, oid), oid))
+	for (source = r->objects->sources; source; source = source->next) {
+		if (oidtree_contains(odb_loose_cache(source, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -694,7 +694,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd, const char *filename)
 {
-	if (the_repository->objects->odb->will_destroy)
+	if (the_repository->objects->sources->will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
@@ -876,7 +876,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
 		prepare_loose_object_bulk_checkin();
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->sources, &filename, oid);
 
 	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
@@ -1023,7 +1023,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		goto cleanup;
 	}
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->sources, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
 	dirlen = directory_size(filename.buf);
@@ -1437,11 +1437,11 @@ int for_each_loose_file_in_objdir(const char *path,
 int for_each_loose_object(each_loose_object_fn cb, void *data,
 			  enum for_each_object_flags flags)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb; odb; odb = odb->next) {
-		int r = for_each_loose_file_in_objdir(odb->path, cb, NULL,
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		int r = for_each_loose_file_in_objdir(source->path, cb, NULL,
 						      NULL, data);
 		if (r)
 			return r;
@@ -1461,43 +1461,43 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_loose_cache(struct object_directory *odb,
-				  const struct object_id *oid)
+struct oidtree *odb_loose_cache(struct odb_source *source,
+				const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
+	size_t word_bits = bitsizeof(source->loose_objects_subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
 	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= bitsizeof(odb->loose_objects_subdir_seen))
+	    subdir_nr >= bitsizeof(source->loose_objects_subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &odb->loose_objects_subdir_seen[word_index];
+	bitmap = &source->loose_objects_subdir_seen[word_index];
 	if (*bitmap & mask)
-		return odb->loose_objects_cache;
-	if (!odb->loose_objects_cache) {
-		ALLOC_ARRAY(odb->loose_objects_cache, 1);
-		oidtree_init(odb->loose_objects_cache);
+		return source->loose_objects_cache;
+	if (!source->loose_objects_cache) {
+		ALLOC_ARRAY(source->loose_objects_cache, 1);
+		oidtree_init(source->loose_objects_cache);
 	}
-	strbuf_addstr(&buf, odb->path);
+	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    odb->loose_objects_cache);
+				    source->loose_objects_cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return odb->loose_objects_cache;
+	return source->loose_objects_cache;
 }
 
-void odb_clear_loose_cache(struct object_directory *odb)
+void odb_clear_loose_cache(struct odb_source *source)
 {
-	oidtree_clear(odb->loose_objects_cache);
-	FREE_AND_NULL(odb->loose_objects_cache);
-	memset(&odb->loose_objects_subdir_seen, 0,
-	       sizeof(odb->loose_objects_subdir_seen));
+	oidtree_clear(source->loose_objects_cache);
+	FREE_AND_NULL(source->loose_objects_cache);
+	memset(&source->loose_objects_subdir_seen, 0,
+	       sizeof(source->loose_objects_subdir_seen));
 }
 
 static int check_stream_oid(git_zstream *stream,
diff --git a/object-file.h b/object-file.h
index 6f411424523..9a18859b2e0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -24,23 +24,23 @@ enum {
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-struct object_directory;
+struct odb_source;
 
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oidtree *odb_loose_cache(struct object_directory *odb,
+struct oidtree *odb_loose_cache(struct odb_source *source,
 				const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct object_directory *odb);
+void odb_clear_loose_cache(struct odb_source *source);
 
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
  */
-const char *odb_loose_path(struct object_directory *odb,
+const char *odb_loose_path(struct odb_source *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
diff --git a/object-name.c b/object-name.c
index 9288b2dd245..544634d0f40 100644
--- a/object-name.c
+++ b/object-name.c
@@ -112,10 +112,10 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
-	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
-		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
+	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
+		oidtree_each(odb_loose_cache(source, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
diff --git a/object-store.c b/object-store.c
index f4e8f99d90f..5c04a1018f7 100644
--- a/object-store.c
+++ b/object-store.c
@@ -27,7 +27,7 @@
 #include "write-or-die.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, fspathhash, fspatheq)
+	struct odb_source *, 1, fspathhash, fspatheq)
 
 /*
  * This is meant to hold a *small* number of objects that you would
@@ -104,18 +104,18 @@ static int alt_odb_usable(struct object_database *o,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	if (!o->odb_by_path) {
+	if (!o->source_by_path) {
 		khiter_t p;
 
-		o->odb_by_path = kh_init_odb_path_map();
-		assert(!o->odb->next);
-		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
+		o->source_by_path = kh_init_odb_path_map();
+		assert(!o->sources->next);
+		p = kh_put_odb_path_map(o->source_by_path, o->sources->path, &r);
 		assert(r == 1); /* never used */
-		kh_value(o->odb_by_path, p) = o->odb;
+		kh_value(o->source_by_path, p) = o->sources;
 	}
 	if (fspatheq(path->buf, normalized_objdir))
 		return 0;
-	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
+	*pos = kh_put_odb_path_map(o->source_by_path, path->buf, &r);
 	/* r: 0 = exists, 1 = never used, 2 = deleted */
 	return r == 0 ? 0 : 1;
 }
@@ -124,7 +124,7 @@ static int alt_odb_usable(struct object_database *o,
  * Prepare alternate object database registry.
  *
  * The variable alt_odb_list points at the list of struct
- * object_directory.  The elements on this list come from
+ * odb_source.  The elements on this list come from
  * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
  * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
  * whose contents is similar to that environment variable but can be
@@ -141,7 +141,7 @@ static void read_info_alternates(struct repository *r,
 static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
-	struct object_directory *ent;
+	struct odb_source *alternate;
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
@@ -170,19 +170,19 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
 		goto error;
 
-	CALLOC_ARRAY(ent, 1);
-	/* pathbuf.buf is already in r->objects->odb_by_path */
-	ent->path = strbuf_detach(&pathbuf, NULL);
+	CALLOC_ARRAY(alternate, 1);
+	/* pathbuf.buf is already in r->objects->source_by_path */
+	alternate->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
-	*r->objects->odb_tail = ent;
-	r->objects->odb_tail = &(ent->next);
-	ent->next = NULL;
-	assert(r->objects->odb_by_path);
-	kh_value(r->objects->odb_by_path, pos) = ent;
+	*r->objects->sources_tail = alternate;
+	r->objects->sources_tail = &(alternate->next);
+	alternate->next = NULL;
+	assert(r->objects->source_by_path);
+	kh_value(r->objects->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(r, ent->path, depth + 1);
+	read_info_alternates(r, alternate->path, depth + 1);
 	ret = 0;
  error:
 	strbuf_release(&tmp);
@@ -234,7 +234,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
+	strbuf_realpath(&objdirbuf, r->objects->sources->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
@@ -321,9 +321,9 @@ void add_to_alternates_memory(const char *reference)
 			     '\n', NULL, 0);
 }
 
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 {
-	struct object_directory *new_odb;
+	struct odb_source *source;
 
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
@@ -335,41 +335,41 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
-	new_odb = xcalloc(1, sizeof(*new_odb));
-	new_odb->path = xstrdup(dir);
+	source = xcalloc(1, sizeof(*source));
+	source->path = xstrdup(dir);
 
 	/*
 	 * Disable ref updates while a temporary odb is active, since
 	 * the objects in the database may roll back.
 	 */
-	new_odb->disable_ref_updates = 1;
-	new_odb->will_destroy = will_destroy;
-	new_odb->next = the_repository->objects->odb;
-	the_repository->objects->odb = new_odb;
-	return new_odb->next;
+	source->disable_ref_updates = 1;
+	source->will_destroy = will_destroy;
+	source->next = the_repository->objects->sources;
+	the_repository->objects->sources = source;
+	return source->next;
 }
 
-static void free_object_directory(struct object_directory *odb)
+static void free_object_directory(struct odb_source *source)
 {
-	free(odb->path);
-	odb_clear_loose_cache(odb);
-	loose_object_map_clear(&odb->loose_map);
-	free(odb);
+	free(source->path);
+	odb_clear_loose_cache(source);
+	loose_object_map_clear(&source->loose_map);
+	free(source);
 }
 
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
+void restore_primary_odb(struct odb_source *restore_alt, const char *old_path)
 {
-	struct object_directory *cur_odb = the_repository->objects->odb;
+	struct odb_source *cur_alt = the_repository->objects->sources;
 
-	if (strcmp(old_path, cur_odb->path))
+	if (strcmp(old_path, cur_alt->path))
 		BUG("expected %s as primary object store; found %s",
-		    old_path, cur_odb->path);
+		    old_path, cur_alt->path);
 
-	if (cur_odb->next != restore_odb)
+	if (cur_alt->next != restore_alt)
 		BUG("we expect the old primary object store to be the first alternate");
 
-	the_repository->objects->odb = restore_odb;
-	free_object_directory(cur_odb);
+	the_repository->objects->sources = restore_alt;
+	free_object_directory(cur_alt);
 }
 
 /*
@@ -442,15 +442,15 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct object_directory *find_odb(struct repository *r, const char *obj_dir)
+struct odb_source *find_odb(struct repository *r, const char *obj_dir)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		strbuf_realpath(&odb_path_real, odb->path, 1);
+	for (source = r->objects->sources; source; source = source->next) {
+		strbuf_realpath(&odb_path_real, source->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
 	}
@@ -458,9 +458,9 @@ struct object_directory *find_odb(struct repository *r, const char *obj_dir)
 	free(obj_dir_real);
 	strbuf_release(&odb_path_real);
 
-	if (!odb)
+	if (!source)
 		die(_("could not find object directory matching %s"), obj_dir);
-	return odb;
+	return source;
 }
 
 static void fill_alternate_refs_command(struct child_process *cmd,
@@ -527,14 +527,14 @@ struct alternate_refs_data {
 	void *data;
 };
 
-static int refs_from_alternate_cb(struct object_directory *e,
+static int refs_from_alternate_cb(struct odb_source *alternate,
 				  void *data)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
 	struct alternate_refs_data *cb = data;
 
-	if (!strbuf_realpath(&path, e->path, 0))
+	if (!strbuf_realpath(&path, alternate->path, 0))
 		goto out;
 	if (!strbuf_strip_suffix(&path, "/objects"))
 		goto out;
@@ -563,12 +563,12 @@ void for_each_alternate_ref(alternate_ref_fn fn, void *data)
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
-	struct object_directory *ent;
+	struct odb_source *alternate;
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
-		r = fn(ent, cb);
+	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
+		r = fn(alternate, cb);
 		if (r)
 			break;
 	}
@@ -582,14 +582,14 @@ void prepare_alt_odb(struct repository *r)
 
 	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->odb->path, 0);
+	read_info_alternates(r, r->objects->sources->path, 0);
 	r->objects->loaded_alternates = 1;
 }
 
 int has_alt_odb(struct repository *r)
 {
 	prepare_alt_odb(r);
-	return !!r->objects->odb->next;
+	return !!r->objects->sources->next;
 }
 
 int obj_read_use_lock = 0;
@@ -963,15 +963,15 @@ struct object_database *odb_new(void)
 
 static void free_object_directories(struct object_database *o)
 {
-	while (o->odb) {
-		struct object_directory *next;
+	while (o->sources) {
+		struct odb_source *next;
 
-		next = o->odb->next;
-		free_object_directory(o->odb);
-		o->odb = next;
+		next = o->sources->next;
+		free_object_directory(o->sources);
+		o->sources = next;
 	}
-	kh_destroy_odb_path_map(o->odb_by_path);
-	o->odb_by_path = NULL;
+	kh_destroy_odb_path_map(o->source_by_path);
+	o->source_by_path = NULL;
 }
 
 void odb_clear(struct object_database *o)
@@ -986,7 +986,7 @@ void odb_clear(struct object_database *o)
 	o->commit_graph_attempted = 0;
 
 	free_object_directories(o);
-	o->odb_tail = NULL;
+	o->sources_tail = NULL;
 	o->loaded_alternates = 0;
 
 	for (size_t i = 0; i < o->cached_object_nr; i++)
diff --git a/object-store.h b/object-store.h
index a3be27d1171..d199d757d76 100644
--- a/object-store.h
+++ b/object-store.h
@@ -13,8 +13,20 @@ struct oidtree;
 struct strbuf;
 struct repository;
 
-struct object_directory {
-	struct object_directory *next;
+/*
+ * The source is the part of the object database that stores the actual
+ * objects. It thus encapsulates the logic to read and write the specific
+ * on-disk format. An object database can have multiple sources:
+ *
+ *   - The primary source, which is typically located in "$GIT_DIR/objects".
+ *     This is where new objects are usually written to.
+ *
+ *   - Alternate sources, which are configured via "objects/info/alternates" or
+ *     via the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable. These
+ *     alternate sources are only used to read objects.
+ */
+struct odb_source {
+	struct odb_source *next;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -44,8 +56,8 @@ struct object_directory {
 	int will_destroy;
 
 	/*
-	 * Path to the alternative object store. If this is a relative path,
-	 * it is relative to the current working directory.
+	 * Path to the source. If this is a relative path, it is relative to
+	 * the current working directory.
 	 */
 	char *path;
 };
@@ -53,8 +65,8 @@ struct object_directory {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct object_directory *find_odb(struct repository *r, const char *obj_dir);
-typedef int alt_odb_fn(struct object_directory *, void *);
+struct odb_source *find_odb(struct repository *r, const char *obj_dir);
+typedef int alt_odb_fn(struct odb_source *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
 void for_each_alternate_ref(alternate_ref_fn, void *);
@@ -76,12 +88,12 @@ void add_to_alternates_memory(const char *dir);
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
  */
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy);
 
 /*
  * Restore a previous ODB replaced by set_temporary_main_odb.
  */
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+void restore_primary_odb(struct odb_source *restore_alternate, const char *old_path);
 
 struct packed_git;
 struct multi_pack_index;
@@ -89,7 +101,7 @@ struct cached_object_entry;
 
 /*
  * The object database encapsulates access to objects in a repository. It
- * manages one or more backends that store the actual objects which are
+ * manages one or more sources that store the actual objects which are
  * configured via alternates.
  */
 struct object_database {
@@ -98,16 +110,16 @@ struct object_database {
 	 * cannot be NULL after initialization). Subsequent directories are
 	 * alternates.
 	 */
-	struct object_directory *odb;
-	struct object_directory **odb_tail;
-	struct kh_odb_path_map *odb_by_path;
+	struct odb_source *sources;
+	struct odb_source **sources_tail;
+	struct kh_odb_path_map *source_by_path;
 
 	int loaded_alternates;
 
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will
-	 * populate the "odb" list when prepare_alt_odb() is run.
+	 * populate the "sources" list when prepare_alt_odb() is run.
 	 */
 	char *alternate_db;
 
diff --git a/packfile.c b/packfile.c
index c735b4d0135..60661ad0095 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1029,16 +1029,16 @@ static void prepare_packed_git_mru(struct repository *r)
 
 static void prepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	if (r->objects->packed_git_initialized)
 		return;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		int local = (odb == r->objects->odb);
-		prepare_multi_pack_index_one(r, odb->path, local);
-		prepare_packed_git_one(r, odb->path, local);
+	for (source = r->objects->sources; source; source = source->next) {
+		int local = (source == r->objects->sources);
+		prepare_multi_pack_index_one(r, source->path, local);
+		prepare_packed_git_one(r, source->path, local);
 	}
 	rearrange_packed_git(r);
 
@@ -1048,7 +1048,7 @@ static void prepare_packed_git(struct repository *r)
 
 void reprepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_source *source;
 
 	obj_read_lock();
 
@@ -1061,8 +1061,8 @@ void reprepare_packed_git(struct repository *r)
 	r->objects->loaded_alternates = 0;
 	prepare_alt_odb(r);
 
-	for (odb = r->objects->odb; odb; odb = odb->next)
-		odb_clear_loose_cache(odb);
+	for (source = r->objects->sources; source; source = source->next)
+		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
diff --git a/path.c b/path.c
index 3b598b2847f..c347829aa66 100644
--- a/path.c
+++ b/path.c
@@ -397,7 +397,7 @@ static void adjust_git_path(struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objects->odb->path);
+		replace_dir(buf, git_dir_len + 7, repo->objects->sources->path);
 	else if (repo_settings_get_hooks_path(repo) && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, repo_settings_get_hooks_path(repo));
 	else if (repo->different_commondir)
diff --git a/refs.c b/refs.c
index dce5c49ca2b..5f6a386cc93 100644
--- a/refs.c
+++ b/refs.c
@@ -2477,7 +2477,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (refs->repo->objects->odb->disable_ref_updates) {
+	if (refs->repo->objects->sources->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index 07757e6e0c9..7528beccddf 100644
--- a/repository.c
+++ b/repository.c
@@ -107,9 +107,9 @@ const char *repo_get_common_dir(struct repository *repo)
 
 const char *repo_get_object_directory(struct repository *repo)
 {
-	if (!repo->objects->odb)
+	if (!repo->objects->sources)
 		BUG("repository hasn't been set up");
-	return repo->objects->odb->path;
+	return repo->objects->sources->path;
 }
 
 const char *repo_get_index_file(struct repository *repo)
@@ -165,14 +165,14 @@ void repo_set_gitdir(struct repository *repo,
 
 	repo_set_commondir(repo, o->commondir);
 
-	if (!repo->objects->odb) {
-		CALLOC_ARRAY(repo->objects->odb, 1);
-		repo->objects->odb_tail = &repo->objects->odb->next;
+	if (!repo->objects->sources) {
+		CALLOC_ARRAY(repo->objects->sources, 1);
+		repo->objects->sources_tail = &repo->objects->sources->next;
 	}
-	expand_base_dir(&repo->objects->odb->path, o->object_dir,
+	expand_base_dir(&repo->objects->sources->path, o->object_dir,
 			repo->commondir, "objects");
 
-	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
+	repo->objects->sources->disable_ref_updates = o->disable_ref_updates;
 
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
diff --git a/submodule-config.c b/submodule-config.c
index 8630e27947d..b30d9365fbd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -810,7 +810,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_submodule_odb_by_path(repo->objects->odb->path);
+				add_submodule_odb_by_path(repo->objects->sources->path);
 		} else {
 			goto out;
 		}
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8b413b644be..53b633e2ba6 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -73,15 +73,15 @@ static void dump_graph_bloom_filters(struct commit_graph *graph)
 int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
+	struct odb_source *source;
 	int ret = 0;
 
 	setup_git_directory();
-	odb = the_repository->objects->odb;
+	source = the_repository->objects->sources;
 
 	prepare_repo_settings(the_repository);
 
-	graph = read_commit_graph_one(the_repository, odb);
+	graph = read_commit_graph_one(the_repository, source);
 	if (!graph) {
 		ret = 1;
 		goto done;
diff --git a/tmp-objdir.c b/tmp-objdir.c
index c38fbeb5e8a..056484404be 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -17,7 +17,7 @@ struct tmp_objdir {
 	struct repository *repo;
 	struct strbuf path;
 	struct strvec env;
-	struct object_directory *prev_odb;
+	struct odb_source *prev_source;
 	int will_destroy;
 };
 
@@ -46,8 +46,8 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
-	if (t->prev_odb)
-		restore_primary_odb(t->prev_odb, t->path.buf);
+	if (t->prev_source)
+		restore_primary_odb(t->prev_source, t->path.buf);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -276,11 +276,11 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (!t)
 		return 0;
 
-	if (t->prev_odb) {
-		if (t->repo->objects->odb->will_destroy)
+	if (t->prev_source) {
+		if (t->repo->objects->sources->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		restore_primary_odb(t->prev_odb, t->path.buf);
-		t->prev_odb = NULL;
+		restore_primary_odb(t->prev_source, t->path.buf);
+		t->prev_source = NULL;
 	}
 
 	strbuf_addbuf(&src, &t->path);
@@ -309,19 +309,19 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 
 void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 {
-	if (t->prev_odb)
+	if (t->prev_source)
 		BUG("the primary object database is already replaced");
-	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->prev_source = set_temporary_primary_odb(t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
 
 struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
 {
-	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
+	if (!the_tmp_objdir || !the_tmp_objdir->prev_source)
 		return NULL;
 
-	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
-	the_tmp_objdir->prev_odb = NULL;
+	restore_primary_odb(the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
+	the_tmp_objdir->prev_source = NULL;
 	return the_tmp_objdir;
 }
 

-- 
2.50.0.rc1.591.g9c95f17f64.dirty

