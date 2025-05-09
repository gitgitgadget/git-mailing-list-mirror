Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89472957A5
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799942; cv=none; b=app1DzA2ArYqealx72CAdouSEuNKq1FiK0ofXrAI4wOnSL0Nv1Miokd0DJH3KV0i50p4AORZvKRv8oCzqqAWEnLfFKp4BEMgrdZBNSHmSC/4MoUQKJJ5SQkxbYow06WyUlD9BVQtmolFIw9ylzdUoEqzYnDIsrUNRCy6zO0RY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799942; c=relaxed/simple;
	bh=TM7d7REZFnXmZXDod1fXzJ7uwyuMGuis3FlEhmE0CMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjbIHPXHjlSMu1EOhJUdFEXosmvprY8h4+O9Hp3gDnFEjOFUsa7wxtTAFwqyc+myQb31Vbb14KDitLGygEdJZCGSJV47Bd4OxOFNohvDUbsdk9QrZ23uOBPya6MBwwx7GhKCWeZK1Odqc7Qd5oWIRjiZF2xhhufsFbCJi66ZFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KEo1ku9/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tu1JdIfB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KEo1ku9/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tu1JdIfB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F0151140126;
	Fri,  9 May 2025 10:12:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 09 May 2025 10:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799936;
	 x=1746886336; bh=bK9OD/eCwCEQlOTSLpwq7Cpa8yccHsY27RV+Uk8XNes=; b=
	KEo1ku9/zTgIBSO4q3ZcHHOrkZEtuZyFn65eXKKQfTNXy5VhBJ+ApsVR+UfvI3eS
	F7UR1StJ1lYPK48jo6NLp7pwEmtwTxMFqOimj2L8adZjcHSs+NGimAYNSTQou4eP
	rw0wJl4i2Rr752Z1Im+gYdhx+RsymxsIGDGaEFuhMA5XxupTf32O7w/wQp0uTL8d
	7Z7b5RTkpPcle9trx5yR2Y66lN2+Pc6YKdOi6uHQStjsovSVLPm94C2TDS3apQLa
	Sjm3Fvvdl8Gh6QetfXqVBtBGxXGlWAXSRGSbIVcaQZGB3oYZjI7sXH+x48/xphHL
	3JLUfPIaSSrnUif2m1xdBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799936; x=
	1746886336; bh=bK9OD/eCwCEQlOTSLpwq7Cpa8yccHsY27RV+Uk8XNes=; b=t
	u1JdIfBoThf5ZrzcFVNegOtixibVP5P+9wFE4SUMzyG40clGzl28gOInyywj+Xp4
	kwIh/3XNoQRBVKU0jaty11b9RxTTcXnl+9lhSEMfcxK3RxzSgk31GHxnk/fenABH
	Y680iOD4VWnxrEOEWFyXENIbotajj8dQ6i4vh7squIJDsp587i1FFoEhdG55U1P3
	IZ3idq/E0SDqoEX244OYucx3NrhH8OcSZTmMotrWyHE9k6Ogi5656NKA8H2OQenS
	56Sm02mulLWxfho7fk7ikghr6ydPx0mgd9In4ko2jPylBy/s8CQ007lOWCHDjG1w
	yKbzftWKvUA7jjXeDMOqA==
X-ME-Sender: <xms:QA0eaNHG08_yP6XhJMRpmQjfmDJQ54QzKrNGfDrtbC05YDanExowCA>
    <xme:QA0eaCWJbZAuYWTfsXhu9ohpeXkadB_H60c9Mw5FINofPum7ivoOQbnY7fhtREnTQ
    U_h1V2WZ_QETTCaKw>
X-ME-Received: <xmr:QA0eaPL6VmNXLk1AxJX9Y2X3JsprSXkiHfs5_gzS8AOAV-kcmh3zw1fEs5e5mDdGI2Z19vTqae0ZW8ierg24oghYJp98fwU1cdT1U4KGUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QA0eaDGxeem2Z3BOjxipPkR00hdL0j93dGZJnUSoS8cdqJkQ9WwMCA>
    <xmx:QA0eaDU8ctGDOX8J4ACgmfnYZtC4gmDIMDA3XWEiJcbxx7f7TbGF6w>
    <xmx:QA0eaOPcfcf_V3IxgBCeay1QLjAwOXG8v6um_80ngzNdznglZh7jrQ>
    <xmx:QA0eaC2Q7PLbT4Dx7SvpUbSHMnLfIQCCoVd5xM1N1GrZSK2bpwuerA>
    <xmx:QA0eaCD1zGCsgbVeQxyIYO01VhvheFWuObUOkkaeTbNAeA0aC6RY5P3O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 526ee775 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:02 +0200
Subject: [PATCH v2 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-2-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

Let's preempt this by renaming the structure to `odb_alternate` now
already. This name is agnostic of how exactly objects are stored while
still specifically pinpointing that this is about an alternate object
database. In the future, it allows us to easily introduce e.g. a
`odb_files_alternate` and other specific implementations over time.

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
 object-store.h              |  25 +++++----
 packfile.c                  |  16 +++---
 path.c                      |   2 +-
 refs.c                      |   2 +-
 repository.c                |  14 ++---
 submodule-config.c          |   2 +-
 t/helper/test-read-graph.c  |   6 +--
 tmp-objdir.c                |  24 ++++-----
 28 files changed, 273 insertions(+), 270 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a783a86e797..628d3a1e92e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -66,7 +66,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
-	struct object_directory *odb = NULL;
+	struct odb_alternate *alternate = NULL;
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
@@ -101,9 +101,9 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	odb = find_odb(the_repository, opts.obj_dir);
-	graph_name = get_commit_graph_filename(odb);
-	chain_name = get_commit_graph_chain_filename(odb);
+	alternate = find_odb(the_repository, opts.obj_dir);
+	graph_name = get_commit_graph_filename(alternate);
+	chain_name = get_commit_graph_chain_filename(alternate);
 	if (open_commit_graph(graph_name, &fd, &st))
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
@@ -120,7 +120,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
+		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, alternate);
 	else
 		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st,
 						      &incomplete_chain);
@@ -221,7 +221,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
-	struct object_directory *odb = NULL;
+	struct odb_alternate *alternate = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
@@ -289,10 +289,10 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	odb = find_odb(the_repository, opts.obj_dir);
+	alternate = find_odb(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(odb, flags, &write_opts))
+		if (write_commit_graph_reachable(alternate, flags, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -318,7 +318,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(odb,
+	if (write_commit_graph(alternate,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a88c0c9c09a..da830fcee57 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -80,10 +80,10 @@ static int count_cruft(const char *basename UNUSED, const char *path,
 	return 0;
 }
 
-static int print_alternate(struct object_directory *odb, void *data UNUSED)
+static int print_alternate(struct odb_alternate *alternate, void *data UNUSED)
 {
 	printf("alternate: ");
-	quote_c_style(odb->path, NULL, stdout, 0);
+	quote_c_style(alternate->path, NULL, stdout, 0);
 	putchar('\n');
 	return 0;
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index cda6eaf1fd6..4de6d3206d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2652,7 +2652,7 @@ int cmd_fetch(int argc,
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		trace2_region_enter("fetch", "write-commit-graph", the_repository);
-		write_commit_graph_reachable(the_repository->objects->odb,
+		write_commit_graph_reachable(the_repository->objects->alternates,
 					     commit_graph_flags,
 					     NULL);
 		trace2_region_leave("fetch", "write-commit-graph", the_repository);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6cac28356ce..9c54286540c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -965,7 +965,7 @@ int cmd_fsck(int argc,
 	     struct repository *repo UNUSED)
 {
 	int i;
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -1007,8 +1007,8 @@ int cmd_fsck(int argc,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next)
-			fsck_object_dir(odb->path);
+		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next)
+			fsck_object_dir(alternate->path);
 
 		if (check_full) {
 			struct packed_git *p;
@@ -1118,11 +1118,11 @@ int cmd_fsck(int argc,
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
-				     "verify", "--object-dir", odb->path, NULL);
+				     "verify", "--object-dir", alternate->path, NULL);
 			if (show_progress)
 				strvec_push(&commit_graph_verify.args, "--progress");
 			else
@@ -1136,11 +1136,11 @@ int cmd_fsck(int argc,
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
 			strvec_pushl(&midx_verify.args, "multi-pack-index",
-				     "verify", "--object-dir", odb->path, NULL);
+				     "verify", "--object-dir", alternate->path, NULL);
 			if (show_progress)
 				strvec_push(&midx_verify.args, "--progress");
 			else
diff --git a/builtin/gc.c b/builtin/gc.c
index 78a2751aa8a..9e9d31c1f39 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -944,7 +944,7 @@ struct repository *repo UNUSED)
 	}
 
 	if (the_repository->settings.gc_write_commit_graph == 1)
-		write_commit_graph_reachable(the_repository->objects->odb,
+		write_commit_graph_reachable(the_repository->objects->alternates,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
@@ -1197,7 +1197,7 @@ static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 	if (loose_object_auto_limit < 0)
 		return 1;
 
-	return for_each_loose_file_in_objdir(the_repository->objects->odb->path,
+	return for_each_loose_file_in_objdir(the_repository->objects->alternates->path,
 					     loose_object_count,
 					     NULL, NULL, &count);
 }
@@ -1232,7 +1232,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	 * Do not start pack-objects process
 	 * if there are no loose objects.
 	 */
-	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
+	if (!for_each_loose_file_in_objdir(r->objects->alternates->path,
 					   bail_on_loose,
 					   NULL, NULL, NULL))
 		return 0;
@@ -1244,7 +1244,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 		strvec_push(&pack_proc.args, "--quiet");
 	else
 		strvec_push(&pack_proc.args, "--no-quiet");
-	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->alternates->path);
 
 	pack_proc.in = -1;
 
@@ -1272,7 +1272,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	else if (data.batch_size > 0)
 		data.batch_size--; /* Decrease for equality on limit. */
 
-	for_each_loose_file_in_objdir(r->objects->odb->path,
+	for_each_loose_file_in_objdir(r->objects->alternates->path,
 				      write_loose_object_to_stdin,
 				      NULL,
 				      NULL,
@@ -1525,7 +1525,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
-	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
+	char *lock_path = xstrfmt("%s/maintenance", r->objects->alternates->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		/*
@@ -2997,7 +2997,7 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 	unsigned int i;
 	int result = 0;
 	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->alternates->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		if (errno == EEXIST)
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ce574a605b..3c51a39c10d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -505,7 +505,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * lazily registered as alternates when needed (and except in an
 	 * unexpected code interaction, it won't be needed).
 	 */
-	add_submodule_odb_by_path(subrepo->objects->odb->path);
+	add_submodule_odb_by_path(subrepo->objects->alternates->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 69a97507324..a77ae465d48 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -294,8 +294,8 @@ int cmd_multi_pack_index(int argc,
 
 	if (the_repository &&
 	    the_repository->objects &&
-	    the_repository->objects->odb)
-		opts.object_dir = xstrdup(the_repository->objects->odb->path);
+	    the_repository->objects->alternates)
+		opts.object_dir = xstrdup(the_repository->objects->alternates->path);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_multi_pack_index_usage, 0);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116ddf..cd7db11d825 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1582,7 +1582,7 @@ static const char alternate_error_advice[] = N_(
 );
 
 static int add_possible_reference_from_superproject(
-		struct object_directory *odb, void *sas_cb)
+		struct odb_alternate *alt_odb, void *sas_cb)
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
index b0a3fee2efa..0c7cd15bb12 100644
--- a/bundle.c
+++ b/bundle.c
@@ -233,7 +233,7 @@ int verify_bundle(struct repository *r,
 		.quiet = 1,
 	};
 
-	if (!r || !r->objects || !r->objects->odb)
+	if (!r || !r->objects || !r->objects->alternates)
 		return error(_("need a repository to verify a bundle"));
 
 	for (i = 0; i < p->nr; i++) {
diff --git a/commit-graph.c b/commit-graph.c
index 1b66486b9c9..58d1eeedb1a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -37,7 +37,7 @@ void git_test_write_commit_graph_or_die(void)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(the_repository->objects->odb,
+	if (write_commit_graph_reachable(the_repository->objects->alternates,
 					 flags, NULL))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
@@ -191,21 +191,21 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-char *get_commit_graph_filename(struct object_directory *obj_dir)
+char *get_commit_graph_filename(struct odb_alternate *alternate)
 {
-	return xstrfmt("%s/info/commit-graph", obj_dir->path);
+	return xstrfmt("%s/info/commit-graph", alternate->path);
 }
 
-static char *get_split_graph_filename(struct object_directory *odb,
+static char *get_split_graph_filename(struct odb_alternate *alternate,
 				      const char *oid_hex)
 {
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", odb->path,
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", alternate->path,
 		       oid_hex);
 }
 
-char *get_commit_graph_chain_filename(struct object_directory *odb)
+char *get_commit_graph_chain_filename(struct odb_alternate *alternate)
 {
-	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", alternate->path);
 }
 
 static struct commit_graph *alloc_commit_graph(void)
@@ -250,7 +250,7 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
-						 struct object_directory *odb)
+						 struct odb_alternate *alternate)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -269,7 +269,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
 
 	if (ret)
-		ret->odb = odb;
+		ret->alternate = alternate;
 	else
 		munmap(graph_map, graph_size);
 
@@ -487,7 +487,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 static struct commit_graph *load_commit_graph_one(struct repository *r,
 						  const char *graph_file,
-						  struct object_directory *odb)
+						  struct odb_alternate *alternate)
 {
 
 	struct stat st;
@@ -498,7 +498,7 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(r, fd, &st, odb);
+	g = load_commit_graph_one_fd_st(r, fd, &st, alternate);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -507,10 +507,10 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
 }
 
 static struct commit_graph *load_commit_graph_v1(struct repository *r,
-						 struct object_directory *odb)
+						 struct odb_alternate *alternate)
 {
-	char *graph_name = get_commit_graph_filename(odb);
-	struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
+	char *graph_name = get_commit_graph_filename(alternate);
+	struct commit_graph *g = load_commit_graph_one(r, graph_name, alternate);
 	free(graph_name);
 
 	return g;
@@ -652,7 +652,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	prepare_alt_odb(r);
 
 	for (i = 0; i < count; i++) {
-		struct object_directory *odb;
+		struct odb_alternate *alternate;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
@@ -665,9 +665,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		}
 
 		valid = 0;
-		for (odb = r->objects->odb; odb; odb = odb->next) {
-			char *graph_name = get_split_graph_filename(odb, line.buf);
-			struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
+		for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+			char *graph_name = get_split_graph_filename(alternate, line.buf);
+			struct commit_graph *g = load_commit_graph_one(r, graph_name, alternate);
 
 			free(graph_name);
 
@@ -701,9 +701,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 }
 
 static struct commit_graph *load_commit_graph_chain(struct repository *r,
-						    struct object_directory *odb)
+						    struct odb_alternate *alternate)
 {
-	char *chain_file = get_commit_graph_chain_filename(odb);
+	char *chain_file = get_commit_graph_chain_filename(alternate);
 	struct stat st;
 	int fd;
 	struct commit_graph *g = NULL;
@@ -719,24 +719,24 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 }
 
 struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct object_directory *odb)
+					   struct odb_alternate *alternate)
 {
-	struct commit_graph *g = load_commit_graph_v1(r, odb);
+	struct commit_graph *g = load_commit_graph_v1(r, alternate);
 
 	if (!g)
-		g = load_commit_graph_chain(r, odb);
+		g = load_commit_graph_chain(r, alternate);
 
 	return g;
 }
 
 static void prepare_commit_graph_one(struct repository *r,
-				     struct object_directory *odb)
+				     struct odb_alternate *alternate)
 {
 
 	if (r->objects->commit_graph)
 		return;
 
-	r->objects->commit_graph = read_commit_graph_one(r, odb);
+	r->objects->commit_graph = read_commit_graph_one(r, alternate);
 }
 
 /*
@@ -747,7 +747,7 @@ static void prepare_commit_graph_one(struct repository *r,
  */
 static int prepare_commit_graph(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	/*
 	 * Early return if there is no git dir or if the commit graph is
@@ -779,10 +779,10 @@ static int prepare_commit_graph(struct repository *r)
 		return 0;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb;
-	     !r->objects->commit_graph && odb;
-	     odb = odb->next)
-		prepare_commit_graph_one(r, odb);
+	for (alternate = r->objects->alternates;
+	     !r->objects->commit_graph && alternate;
+	     alternate = alternate->next)
+		prepare_commit_graph_one(r, alternate);
 	return !!r->objects->commit_graph;
 }
 
@@ -1137,7 +1137,7 @@ struct packed_commit_list {
 
 struct write_commit_graph_context {
 	struct repository *r;
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 	char *graph_name;
 	struct oid_array oids;
 	struct packed_commit_list commits;
@@ -1870,7 +1870,7 @@ static int add_ref_to_set(const char *refname UNUSED,
 	return 0;
 }
 
-int write_commit_graph_reachable(struct object_directory *odb,
+int write_commit_graph_reachable(struct odb_alternate *alternate,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts)
 {
@@ -1890,7 +1890,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 
 	stop_progress(&data.progress);
 
-	result = write_commit_graph(odb, NULL, &commits,
+	result = write_commit_graph(alternate, NULL, &commits,
 				    flags, opts);
 
 	oidset_clear(&commits);
@@ -1906,7 +1906,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	int dirlen;
 	int ret = 0;
 
-	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
+	strbuf_addf(&packname, "%s/pack/", ctx->alternate->path);
 	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
@@ -2058,10 +2058,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		strbuf_addf(&tmp_file,
 			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
-			    ctx->odb->path);
+			    ctx->alternate->path);
 		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
 	} else {
-		ctx->graph_name = get_commit_graph_filename(ctx->odb);
+		ctx->graph_name = get_commit_graph_filename(ctx->alternate);
 	}
 
 	if (safe_create_leading_directories(the_repository, ctx->graph_name)) {
@@ -2071,7 +2071,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_commit_graph_chain_filename(ctx->odb);
+		char *lock_name = get_commit_graph_chain_filename(ctx->alternate);
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
@@ -2159,7 +2159,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->alternate, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -2199,14 +2199,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				}
 			}
 		} else {
-			char *graph_name = get_commit_graph_filename(ctx->odb);
+			char *graph_name = get_commit_graph_filename(ctx->alternate);
 			unlink(graph_name);
 			free(graph_name);
 		}
 
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
-		final_graph_name = get_split_graph_filename(ctx->odb,
+		final_graph_name = get_split_graph_filename(ctx->alternate,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
@@ -2257,7 +2257,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
 		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
 			    (max_commits && num_commits > max_commits))) {
-			if (g->odb != ctx->odb)
+			if (g->alternate != ctx->alternate)
 				break;
 
 			if (unsigned_add_overflows(num_commits, g->num_commits))
@@ -2279,10 +2279,10 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		    "should be 1 with --split=replace");
 
 	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->odb);
+		char *old_graph_name = get_commit_graph_filename(g->alternate);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    g->odb != ctx->odb) {
+		    g->alternate != ctx->alternate) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -2454,13 +2454,13 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->opts && ctx->opts->expire_time)
 		expire_time = ctx->opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb);
+		char *chain_file_name = get_commit_graph_chain_filename(ctx->alternate);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
 	}
 
-	strbuf_addstr(&path, ctx->odb->path);
+	strbuf_addstr(&path, ctx->alternate->path);
 	strbuf_addstr(&path, "/info/commit-graphs");
 	dir = opendir(path.buf);
 
@@ -2502,7 +2502,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(struct object_directory *odb,
+int write_commit_graph(struct odb_alternate *alternate,
 		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
@@ -2533,7 +2533,7 @@ int write_commit_graph(struct object_directory *odb,
 
 	CALLOC_ARRAY(ctx, 1);
 	ctx->r = r;
-	ctx->odb = odb;
+	ctx->alternate = alternate;
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
diff --git a/commit-graph.h b/commit-graph.h
index 20d38c100ce..19d95ade6ea 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -29,8 +29,8 @@ struct repository;
 struct object_database;
 struct string_list;
 
-char *get_commit_graph_filename(struct object_directory *odb);
-char *get_commit_graph_chain_filename(struct object_directory *odb);
+char *get_commit_graph_filename(struct odb_alternate *alternate);
+char *get_commit_graph_chain_filename(struct odb_alternate *alternate);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
 
@@ -89,7 +89,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	uint32_t num_commits_in_base;
 	unsigned int read_generation_data;
@@ -115,12 +115,12 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
-						 struct object_directory *odb);
+						 struct odb_alternate *alternate);
 struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);
 struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct object_directory *odb);
+					   struct odb_alternate *alternate);
 
 struct repo_settings;
 
@@ -173,10 +173,10 @@ struct commit_graph_opts {
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
  */
-int write_commit_graph_reachable(struct object_directory *odb,
+int write_commit_graph_reachable(struct odb_alternate *alternate,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts);
-int write_commit_graph(struct object_directory *odb,
+int write_commit_graph(struct odb_alternate *alternate,
 		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
diff --git a/diagnose.c b/diagnose.c
index b1be74be983..50129cf4be3 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -59,13 +59,13 @@ static void dir_file_stats_objects(const char *full_path,
 			    (uintmax_t)st.st_size);
 }
 
-static int dir_file_stats(struct object_directory *object_dir, void *data)
+static int dir_file_stats(struct odb_alternate *alternate, void *data)
 {
 	struct strbuf *buf = data;
 
-	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+	strbuf_addf(buf, "Contents of %s:\n", alternate->path);
 
-	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+	for_each_file_in_pack_dir(alternate->path, dir_file_stats_objects,
 				  data);
 
 	return 0;
@@ -228,7 +228,7 @@ int create_diagnostics_archive(struct repository *r,
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(r->objects->odb, &buf);
+	dir_file_stats(r->objects->alternates, &buf);
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
diff --git a/http-walker.c b/http-walker.c
index 463f7b119ad..9e7bc37f02e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -543,7 +543,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		odb_loose_path(the_repository->objects->odb, &buf, &req->oid);
+		odb_loose_path(the_repository->objects->alternates, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 3c029cf8947..8ce2ec73947 100644
--- a/http.c
+++ b/http.c
@@ -2662,7 +2662,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->alternates, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2814,7 +2814,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	odb_loose_path(the_repository->objects->odb, &filename, &freq->oid);
+	odb_loose_path(the_repository->objects->alternates, &filename, &freq->oid);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/loose.c b/loose.c
index bb602aaa366..bce4e1c3ee7 100644
--- a/loose.c
+++ b/loose.c
@@ -44,36 +44,36 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
-static int insert_loose_map(struct object_directory *odb,
+static int insert_loose_map(struct odb_alternate *alternate,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct loose_object_map *map = odb->loose_map;
+	struct loose_object_map *map = alternate->loose_map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(odb->loose_objects_cache, compat_oid);
+		oidtree_insert(alternate->loose_objects_cache, compat_oid);
 
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
+static int load_one_loose_object_map(struct repository *repo, struct odb_alternate *alternate)
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!dir->loose_map)
-		loose_object_map_init(&dir->loose_map);
-	if (!dir->loose_objects_cache) {
-		ALLOC_ARRAY(dir->loose_objects_cache, 1);
-		oidtree_init(dir->loose_objects_cache);
+	if (!alternate->loose_map)
+		loose_object_map_init(&alternate->loose_map);
+	if (!alternate->loose_objects_cache) {
+		ALLOC_ARRAY(alternate->loose_objects_cache, 1);
+		oidtree_init(alternate->loose_objects_cache);
 	}
 
-	insert_loose_map(dir, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	insert_loose_map(alternate, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_loose_map(alternate, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_loose_map(alternate, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
@@ -93,7 +93,7 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_loose_map(dir, &oid, &compat_oid);
+		insert_loose_map(alternate, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -107,15 +107,15 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 
 int repo_read_loose_object_map(struct repository *repo)
 {
-	struct object_directory *dir;
+	struct odb_alternate *alternate;
 
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
 	prepare_alt_odb(repo);
 
-	for (dir = repo->objects->odb; dir; dir = dir->next) {
-		if (load_one_loose_object_map(repo, dir) < 0) {
+	for (alternate = repo->objects->alternates; alternate; alternate = alternate->next) {
+		if (load_one_loose_object_map(repo, alternate) < 0) {
 			return -1;
 		}
 	}
@@ -124,7 +124,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
+	kh_oid_map_t *map = repo->objects->alternates->loose_map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -212,7 +212,7 @@ int repo_add_loose_object_map(struct repository *repo, const struct object_id *o
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	inserted = insert_loose_map(repo->objects->odb, oid, compat_oid);
+	inserted = insert_loose_map(repo->objects->alternates, oid, compat_oid);
 	if (inserted)
 		return write_one_object(repo, oid, compat_oid);
 	return 0;
@@ -223,12 +223,12 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct git_hash_algo *to,
 			      struct object_id *dest)
 {
-	struct object_directory *dir;
+	struct odb_alternate *alternate;
 	kh_oid_map_t *map;
 	khiter_t pos;
 
-	for (dir = repo->objects->odb; dir; dir = dir->next) {
-		struct loose_object_map *loose_map = dir->loose_map;
+	for (alternate = repo->objects->alternates; alternate; alternate = alternate->next) {
+		struct loose_object_map *loose_map = alternate->loose_map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index 3d0015f7828..c1adff4404e 100644
--- a/midx.c
+++ b/midx.c
@@ -824,7 +824,7 @@ void clear_midx_file(struct repository *r)
 {
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(r->hash_algo, &midx, r->objects->odb->path);
+	get_midx_filename(r->hash_algo, &midx, r->objects->alternates->path);
 
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
@@ -834,8 +834,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_BITMAP, NULL);
-	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_REV, NULL);
+	clear_midx_files_ext(r->objects->alternates->path, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(r->objects->alternates->path, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
diff --git a/object-file.c b/object-file.c
index dc56a4766df..e48d968c0e0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -55,12 +55,12 @@ static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 	}
 }
 
-const char *odb_loose_path(struct object_directory *odb,
+const char *odb_loose_path(struct odb_alternate *alternate,
 			   struct strbuf *buf,
 			   const struct object_id *oid)
 {
 	strbuf_reset(buf);
-	strbuf_addstr(buf, odb->path);
+	strbuf_addstr(buf, alternate->path);
 	strbuf_addch(buf, '/');
 	fill_loose_path(buf, oid);
 	return buf->buf;
@@ -88,27 +88,27 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_odb(struct object_directory *odb,
+static int check_and_freshen_odb(struct odb_alternate *alternate,
 				 const struct object_id *oid,
 				 int freshen)
 {
 	static struct strbuf path = STRBUF_INIT;
-	odb_loose_path(odb, &path, oid);
+	odb_loose_path(alternate, &path, oid);
 	return check_and_freshen_file(path.buf, freshen);
 }
 
 static int check_and_freshen_local(const struct object_id *oid, int freshen)
 {
-	return check_and_freshen_odb(the_repository->objects->odb, oid, freshen);
+	return check_and_freshen_odb(the_repository->objects->alternates, oid, freshen);
 }
 
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb->next; odb; odb = odb->next) {
-		if (check_and_freshen_odb(odb, oid, freshen))
+	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
+		if (check_and_freshen_odb(alternate, oid, freshen))
 			return 1;
 	}
 	return 0;
@@ -208,12 +208,12 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 static int stat_loose_object(struct repository *r, const struct object_id *oid,
 			     struct stat *st, const char **path)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, oid);
+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+		*path = odb_loose_path(alternate, &buf, oid);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -229,13 +229,13 @@ static int open_loose_object(struct repository *r,
 			     const struct object_id *oid, const char **path)
 {
 	int fd;
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, oid);
+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+		*path = odb_loose_path(alternate, &buf, oid);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
@@ -250,11 +250,11 @@ static int open_loose_object(struct repository *r,
 static int quick_has_loose(struct repository *r,
 			   const struct object_id *oid)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		if (oidtree_contains(odb_loose_cache(odb, oid), oid))
+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+		if (oidtree_contains(odb_loose_cache(alternate, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -750,7 +750,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd, const char *filename)
 {
-	if (the_repository->objects->odb->will_destroy)
+	if (the_repository->objects->alternates->will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
@@ -932,7 +932,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
 		prepare_loose_object_bulk_checkin();
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->alternates, &filename, oid);
 
 	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
@@ -1079,7 +1079,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		goto cleanup;
 	}
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->alternates, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
 	dirlen = directory_size(filename.buf);
@@ -1540,11 +1540,11 @@ int for_each_loose_file_in_objdir(const char *path,
 int for_each_loose_object(each_loose_object_fn cb, void *data,
 			  enum for_each_object_flags flags)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb; odb; odb = odb->next) {
-		int r = for_each_loose_file_in_objdir(odb->path, cb, NULL,
+	for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
+		int r = for_each_loose_file_in_objdir(alternate->path, cb, NULL,
 						      NULL, data);
 		if (r)
 			return r;
@@ -1564,43 +1564,43 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_loose_cache(struct object_directory *odb,
-				  const struct object_id *oid)
+struct oidtree *odb_loose_cache(struct odb_alternate *alternate,
+				const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
+	size_t word_bits = bitsizeof(alternate->loose_objects_subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
 	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= bitsizeof(odb->loose_objects_subdir_seen))
+	    subdir_nr >= bitsizeof(alternate->loose_objects_subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &odb->loose_objects_subdir_seen[word_index];
+	bitmap = &alternate->loose_objects_subdir_seen[word_index];
 	if (*bitmap & mask)
-		return odb->loose_objects_cache;
-	if (!odb->loose_objects_cache) {
-		ALLOC_ARRAY(odb->loose_objects_cache, 1);
-		oidtree_init(odb->loose_objects_cache);
+		return alternate->loose_objects_cache;
+	if (!alternate->loose_objects_cache) {
+		ALLOC_ARRAY(alternate->loose_objects_cache, 1);
+		oidtree_init(alternate->loose_objects_cache);
 	}
-	strbuf_addstr(&buf, odb->path);
+	strbuf_addstr(&buf, alternate->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    odb->loose_objects_cache);
+				    alternate->loose_objects_cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return odb->loose_objects_cache;
+	return alternate->loose_objects_cache;
 }
 
-void odb_clear_loose_cache(struct object_directory *odb)
+void odb_clear_loose_cache(struct odb_alternate *alternate)
 {
-	oidtree_clear(odb->loose_objects_cache);
-	FREE_AND_NULL(odb->loose_objects_cache);
-	memset(&odb->loose_objects_subdir_seen, 0,
-	       sizeof(odb->loose_objects_subdir_seen));
+	oidtree_clear(alternate->loose_objects_cache);
+	FREE_AND_NULL(alternate->loose_objects_cache);
+	memset(&alternate->loose_objects_subdir_seen, 0,
+	       sizeof(alternate->loose_objects_subdir_seen));
 }
 
 static int check_stream_oid(git_zstream *stream,
diff --git a/object-file.h b/object-file.h
index a85b2e5b494..f1601200938 100644
--- a/object-file.h
+++ b/object-file.h
@@ -24,23 +24,23 @@ enum {
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-struct object_directory;
+struct odb_alternate;
 
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oidtree *odb_loose_cache(struct object_directory *odb,
+struct oidtree *odb_loose_cache(struct odb_alternate *alternate,
 				const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct object_directory *odb);
+void odb_clear_loose_cache(struct odb_alternate *alternate);
 
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
  */
-const char *odb_loose_path(struct object_directory *odb,
+const char *odb_loose_path(struct odb_alternate *alternate,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
diff --git a/object-name.c b/object-name.c
index 9288b2dd245..b83ba882b9e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -112,10 +112,10 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
-	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
-		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
+	for (alternate = ds->repo->objects->alternates; alternate && !ds->ambiguous; alternate = alternate->next)
+		oidtree_each(odb_loose_cache(alternate, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
diff --git a/object-store.c b/object-store.c
index 1effcb12273..673a9c6006b 100644
--- a/object-store.c
+++ b/object-store.c
@@ -27,7 +27,7 @@
 #include "write-or-die.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, fspathhash, fspatheq)
+	struct odb_alternate *, 1, fspathhash, fspatheq)
 
 /*
  * This is meant to hold a *small* number of objects that you would
@@ -104,18 +104,18 @@ static int alt_odb_usable(struct object_database *o,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	if (!o->odb_by_path) {
+	if (!o->alternate_by_path) {
 		khiter_t p;
 
-		o->odb_by_path = kh_init_odb_path_map();
-		assert(!o->odb->next);
-		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
+		o->alternate_by_path = kh_init_odb_path_map();
+		assert(!o->alternates->next);
+		p = kh_put_odb_path_map(o->alternate_by_path, o->alternates->path, &r);
 		assert(r == 1); /* never used */
-		kh_value(o->odb_by_path, p) = o->odb;
+		kh_value(o->alternate_by_path, p) = o->alternates;
 	}
 	if (fspatheq(path->buf, normalized_objdir))
 		return 0;
-	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
+	*pos = kh_put_odb_path_map(o->alternate_by_path, path->buf, &r);
 	/* r: 0 = exists, 1 = never used, 2 = deleted */
 	return r == 0 ? 0 : 1;
 }
@@ -124,7 +124,7 @@ static int alt_odb_usable(struct object_database *o,
  * Prepare alternate object database registry.
  *
  * The variable alt_odb_list points at the list of struct
- * object_directory.  The elements on this list come from
+ * odb_alternate.  The elements on this list come from
  * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
  * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
  * whose contents is similar to that environment variable but can be
@@ -141,7 +141,7 @@ static void read_info_alternates(struct repository *r,
 static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
-	struct object_directory *ent;
+	struct odb_alternate *alternate;
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
+	/* pathbuf.buf is already in r->objects->alternate_by_path */
+	alternate->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
-	*r->objects->odb_tail = ent;
-	r->objects->odb_tail = &(ent->next);
-	ent->next = NULL;
-	assert(r->objects->odb_by_path);
-	kh_value(r->objects->odb_by_path, pos) = ent;
+	*r->objects->alternates_tail = alternate;
+	r->objects->alternates_tail = &(alternate->next);
+	alternate->next = NULL;
+	assert(r->objects->alternate_by_path);
+	kh_value(r->objects->alternate_by_path, pos) = alternate;
 
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
+	strbuf_realpath(&objdirbuf, r->objects->alternates->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
@@ -321,9 +321,9 @@ void add_to_alternates_memory(const char *reference)
 			     '\n', NULL, 0);
 }
 
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy)
 {
-	struct object_directory *new_odb;
+	struct odb_alternate *alternate;
 
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
@@ -335,41 +335,41 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
-	new_odb = xcalloc(1, sizeof(*new_odb));
-	new_odb->path = xstrdup(dir);
+	alternate = xcalloc(1, sizeof(*alternate));
+	alternate->path = xstrdup(dir);
 
 	/*
 	 * Disable ref updates while a temporary odb is active, since
 	 * the objects in the database may roll back.
 	 */
-	new_odb->disable_ref_updates = 1;
-	new_odb->will_destroy = will_destroy;
-	new_odb->next = the_repository->objects->odb;
-	the_repository->objects->odb = new_odb;
-	return new_odb->next;
+	alternate->disable_ref_updates = 1;
+	alternate->will_destroy = will_destroy;
+	alternate->next = the_repository->objects->alternates;
+	the_repository->objects->alternates = alternate;
+	return alternate->next;
 }
 
-static void free_object_directory(struct object_directory *odb)
+static void free_object_directory(struct odb_alternate *alternate)
 {
-	free(odb->path);
-	odb_clear_loose_cache(odb);
-	loose_object_map_clear(&odb->loose_map);
-	free(odb);
+	free(alternate->path);
+	odb_clear_loose_cache(alternate);
+	loose_object_map_clear(&alternate->loose_map);
+	free(alternate);
 }
 
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
+void restore_primary_odb(struct odb_alternate *restore_alt, const char *old_path)
 {
-	struct object_directory *cur_odb = the_repository->objects->odb;
+	struct odb_alternate *cur_alt = the_repository->objects->alternates;
 
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
+	the_repository->objects->alternates = restore_alt;
+	free_object_directory(cur_alt);
 }
 
 /*
@@ -442,15 +442,15 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct object_directory *find_odb(struct repository *r, const char *obj_dir)
+struct odb_alternate *find_odb(struct repository *r, const char *obj_dir)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		strbuf_realpath(&odb_path_real, odb->path, 1);
+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+		strbuf_realpath(&odb_path_real, alternate->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
 	}
@@ -458,9 +458,9 @@ struct object_directory *find_odb(struct repository *r, const char *obj_dir)
 	free(obj_dir_real);
 	strbuf_release(&odb_path_real);
 
-	if (!odb)
+	if (!alternate)
 		die(_("could not find object directory matching %s"), obj_dir);
-	return odb;
+	return alternate;
 }
 
 static void fill_alternate_refs_command(struct child_process *cmd,
@@ -527,14 +527,14 @@ struct alternate_refs_data {
 	void *data;
 };
 
-static int refs_from_alternate_cb(struct object_directory *e,
+static int refs_from_alternate_cb(struct odb_alternate *alternate,
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
+	struct odb_alternate *alternate;
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
-		r = fn(ent, cb);
+	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
+		r = fn(alternate, cb);
 		if (r)
 			break;
 	}
@@ -582,14 +582,14 @@ void prepare_alt_odb(struct repository *r)
 
 	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->odb->path, 0);
+	read_info_alternates(r, r->objects->alternates->path, 0);
 	r->objects->loaded_alternates = 1;
 }
 
 int has_alt_odb(struct repository *r)
 {
 	prepare_alt_odb(r);
-	return !!r->objects->odb->next;
+	return !!r->objects->alternates->next;
 }
 
 int obj_read_use_lock = 0;
@@ -972,15 +972,15 @@ struct object_database *odb_new(void)
 
 static void free_object_directories(struct object_database *o)
 {
-	while (o->odb) {
-		struct object_directory *next;
+	while (o->alternates) {
+		struct odb_alternate *next;
 
-		next = o->odb->next;
-		free_object_directory(o->odb);
-		o->odb = next;
+		next = o->alternates->next;
+		free_object_directory(o->alternates);
+		o->alternates = next;
 	}
-	kh_destroy_odb_path_map(o->odb_by_path);
-	o->odb_by_path = NULL;
+	kh_destroy_odb_path_map(o->alternate_by_path);
+	o->alternate_by_path = NULL;
 }
 
 void odb_clear(struct object_database *o)
@@ -996,7 +996,7 @@ void odb_clear(struct object_database *o)
 	o->commit_graph_attempted = 0;
 
 	free_object_directories(o);
-	o->odb_tail = NULL;
+	o->alternates_tail = NULL;
 	o->loaded_alternates = 0;
 
 	for (size_t i = 0; i < o->cached_object_nr; i++)
diff --git a/object-store.h b/object-store.h
index 34b8efbbb83..2dda6e85388 100644
--- a/object-store.h
+++ b/object-store.h
@@ -12,8 +12,11 @@ struct oidtree;
 struct strbuf;
 struct repository;
 
-struct object_directory {
-	struct object_directory *next;
+/*
+ * An alternate part of an object database that stores the actual objects.
+ */
+struct odb_alternate {
+	struct odb_alternate *next;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -52,8 +55,8 @@ struct object_directory {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct object_directory *find_odb(struct repository *r, const char *obj_dir);
-typedef int alt_odb_fn(struct object_directory *, void *);
+struct odb_alternate *find_odb(struct repository *r, const char *obj_dir);
+typedef int alt_odb_fn(struct odb_alternate *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
 void for_each_alternate_ref(alternate_ref_fn, void *);
@@ -75,12 +78,12 @@ void add_to_alternates_memory(const char *dir);
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
  */
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy);
 
 /*
  * Restore a previous ODB replaced by set_temporary_main_odb.
  */
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+void restore_primary_odb(struct odb_alternate *restore_alternate, const char *old_path);
 
 struct packed_git;
 struct multi_pack_index;
@@ -88,7 +91,7 @@ struct cached_object_entry;
 
 /*
  * The object database encapsulates access to objects in a repository. It
- * manages one or more backends that store the actual objects which are
+ * manages one or more alternates that store the actual objects which are
  * configured via alternates.
  */
 struct object_database {
@@ -97,16 +100,16 @@ struct object_database {
 	 * cannot be NULL after initialization). Subsequent directories are
 	 * alternates.
 	 */
-	struct object_directory *odb;
-	struct object_directory **odb_tail;
-	struct kh_odb_path_map *odb_by_path;
+	struct odb_alternate *alternates;
+	struct odb_alternate **alternates_tail;
+	struct kh_odb_path_map *alternate_by_path;
 
 	int loaded_alternates;
 
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will
-	 * populate the "odb" list when prepare_alt_odb() is run.
+	 * populate the "alternates" list when prepare_alt_odb() is run.
 	 */
 	char *alternate_db;
 
diff --git a/packfile.c b/packfile.c
index 8f51665266d..e31e55f0c02 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1018,16 +1018,16 @@ static void prepare_packed_git_mru(struct repository *r)
 
 static void prepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	if (r->objects->packed_git_initialized)
 		return;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		int local = (odb == r->objects->odb);
-		prepare_multi_pack_index_one(r, odb->path, local);
-		prepare_packed_git_one(r, odb->path, local);
+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+		int local = (alternate == r->objects->alternates);
+		prepare_multi_pack_index_one(r, alternate->path, local);
+		prepare_packed_git_one(r, alternate->path, local);
 	}
 	rearrange_packed_git(r);
 
@@ -1037,7 +1037,7 @@ static void prepare_packed_git(struct repository *r)
 
 void reprepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 
 	obj_read_lock();
 
@@ -1050,8 +1050,8 @@ void reprepare_packed_git(struct repository *r)
 	r->objects->loaded_alternates = 0;
 	prepare_alt_odb(r);
 
-	for (odb = r->objects->odb; odb; odb = odb->next)
-		odb_clear_loose_cache(odb);
+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next)
+		odb_clear_loose_cache(alternate);
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
diff --git a/path.c b/path.c
index 3b598b2847f..7be0e0214df 100644
--- a/path.c
+++ b/path.c
@@ -397,7 +397,7 @@ static void adjust_git_path(struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objects->odb->path);
+		replace_dir(buf, git_dir_len + 7, repo->objects->alternates->path);
 	else if (repo_settings_get_hooks_path(repo) && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, repo_settings_get_hooks_path(repo));
 	else if (repo->different_commondir)
diff --git a/refs.c b/refs.c
index dce5c49ca2b..27325d2f3c6 100644
--- a/refs.c
+++ b/refs.c
@@ -2477,7 +2477,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (refs->repo->objects->odb->disable_ref_updates) {
+	if (refs->repo->objects->alternates->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index 07757e6e0c9..dcc03fd9e0a 100644
--- a/repository.c
+++ b/repository.c
@@ -107,9 +107,9 @@ const char *repo_get_common_dir(struct repository *repo)
 
 const char *repo_get_object_directory(struct repository *repo)
 {
-	if (!repo->objects->odb)
+	if (!repo->objects->alternates)
 		BUG("repository hasn't been set up");
-	return repo->objects->odb->path;
+	return repo->objects->alternates->path;
 }
 
 const char *repo_get_index_file(struct repository *repo)
@@ -165,14 +165,14 @@ void repo_set_gitdir(struct repository *repo,
 
 	repo_set_commondir(repo, o->commondir);
 
-	if (!repo->objects->odb) {
-		CALLOC_ARRAY(repo->objects->odb, 1);
-		repo->objects->odb_tail = &repo->objects->odb->next;
+	if (!repo->objects->alternates) {
+		CALLOC_ARRAY(repo->objects->alternates, 1);
+		repo->objects->alternates_tail = &repo->objects->alternates->next;
 	}
-	expand_base_dir(&repo->objects->odb->path, o->object_dir,
+	expand_base_dir(&repo->objects->alternates->path, o->object_dir,
 			repo->commondir, "objects");
 
-	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
+	repo->objects->alternates->disable_ref_updates = o->disable_ref_updates;
 
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
diff --git a/submodule-config.c b/submodule-config.c
index 8630e27947d..0ee0a2884ef 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -810,7 +810,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_submodule_odb_by_path(repo->objects->odb->path);
+				add_submodule_odb_by_path(repo->objects->alternates->path);
 		} else {
 			goto out;
 		}
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8b413b644be..cd8ba0c54e7 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -73,15 +73,15 @@ static void dump_graph_bloom_filters(struct commit_graph *graph)
 int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
+	struct odb_alternate *alternate;
 	int ret = 0;
 
 	setup_git_directory();
-	odb = the_repository->objects->odb;
+	alternate = the_repository->objects->alternates;
 
 	prepare_repo_settings(the_repository);
 
-	graph = read_commit_graph_one(the_repository, odb);
+	graph = read_commit_graph_one(the_repository, alternate);
 	if (!graph) {
 		ret = 1;
 		goto done;
diff --git a/tmp-objdir.c b/tmp-objdir.c
index c38fbeb5e8a..b8fe0fdd7d4 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -17,7 +17,7 @@ struct tmp_objdir {
 	struct repository *repo;
 	struct strbuf path;
 	struct strvec env;
-	struct object_directory *prev_odb;
+	struct odb_alternate *prev_alt;
 	int will_destroy;
 };
 
@@ -46,8 +46,8 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
-	if (t->prev_odb)
-		restore_primary_odb(t->prev_odb, t->path.buf);
+	if (t->prev_alt)
+		restore_primary_odb(t->prev_alt, t->path.buf);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -276,11 +276,11 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (!t)
 		return 0;
 
-	if (t->prev_odb) {
-		if (t->repo->objects->odb->will_destroy)
+	if (t->prev_alt) {
+		if (t->repo->objects->alternates->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		restore_primary_odb(t->prev_odb, t->path.buf);
-		t->prev_odb = NULL;
+		restore_primary_odb(t->prev_alt, t->path.buf);
+		t->prev_alt = NULL;
 	}
 
 	strbuf_addbuf(&src, &t->path);
@@ -309,19 +309,19 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 
 void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 {
-	if (t->prev_odb)
+	if (t->prev_alt)
 		BUG("the primary object database is already replaced");
-	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->prev_alt = set_temporary_primary_odb(t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
 
 struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
 {
-	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
+	if (!the_tmp_objdir || !the_tmp_objdir->prev_alt)
 		return NULL;
 
-	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
-	the_tmp_objdir->prev_odb = NULL;
+	restore_primary_odb(the_tmp_objdir->prev_alt, the_tmp_objdir->path.buf);
+	the_tmp_objdir->prev_alt = NULL;
 	return the_tmp_objdir;
 }
 

-- 
2.49.0.1077.gc0e912fd4c.dirty

