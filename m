Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D60224250
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529766; cv=none; b=uoeV+zF+TD/tWCp+8EN+S61IW99MaPjgyD6bQIe61LA4rkeKvkwxM12/m61aa0bAOPPUxAWax8onzxm7GVKN9Gelt12NHeaGVxTsBRMWPI8MkWdGSGn4V7OYa1SaZTvgJtkQKFr93bxfvQK92uHjAVQel5a2H51tFq03Kafvx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529766; c=relaxed/simple;
	bh=fCPl4bP8er50T5zNWzQTXbF3mUipEEhAMhhDO0OLeF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ktg6YI5rCK+pzwNYf1pGH7BUxs7o7cKSnYCBcG8VDMmo+U6pDzLSlvzhmcMQmG9q7kgKgQsQdSTp6dL53Hqr7eRpN0IL1P25XxCc1J7pVNqyXf2HG7ij7k5VQcl+74Uf//DKaW58ZpWanXWyYsHMKzZkE+QlQPIpOxFj51MeFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v2i2ReJv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqAFxxqk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v2i2ReJv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqAFxxqk"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADADE1140269
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 07:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529761;
	 x=1746616161; bh=xsfxh6xED7hGPUlC6v4X+MHonmbOmf9kwbuKcXSZGss=; b=
	v2i2ReJvnc/mMh223FJMe8x+W86vfXJ9G9YElStvhI+Y0hQCAsIQT/5nYu60gOZv
	8vAE54fHV4076Z/RQyVgKIWp5O/WU+Ldx9lKUt9GFAMA+DYcKHfiTRouBy1zpWcr
	WjtSp+Tz5EAGpNpnG3q+1WWHsX2mKJIfqHyGyXjX5ONnM00jEtorHknxO7I58AkS
	KNnvW8A2PYin54x+cI16UMs3OL/68Rv3PWkFSuKsdzvWZ1xzvOjS6uQv7xE3nMrl
	+RgJQnJJyfOdbUsUJDhi8OtvnWtZc/qJgQIPjEWsL7upZ0fhCVvlah3o0y+uaY6n
	0jVA9bufxByq077g9lnVJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529761; x=
	1746616161; bh=xsfxh6xED7hGPUlC6v4X+MHonmbOmf9kwbuKcXSZGss=; b=f
	qAFxxqk7c6peepUvlGU+UU+44gwjlg65k/LalyzcjdJYn5yxLMQGc8cRJQNEpuL+
	7fL4t0ZumUSpoKvG5zGHwjUfkaLCoAVcFDLKoQrNJ4ERk5Nce+1q3UXI0yPiqLYs
	q9nXpU9MxVgZUu1xgTZe/Wa98/3TxdmTm/VPtugO9Mv+UHaWZKegaFLZ6rVjWDxI
	q2JBKxeBbz2Rcadm7xZb9F9WJIOHgrruQs4HXUh6siaCS6K+moaSdPnf8iQ76X0d
	GLMjZ0WWbj755RJiXLFfk4+D6RsPJOd75bn7LIUDtRjaTdpCvyr6L8U9YGVcVaur
	gcE32aQiV51egWoQCxV4A==
X-ME-Sender: <xms:4e0ZaCPklEh5QAgJXjLf64vd1oUwa6l819Md0tJZCcWicCndmw-pzw>
    <xme:4e0ZaA-xlp7lIuhpSbFupdpTFjqBQsZcEUi6GuHK8lA-TX4LWUbUeWb7l0MpaxWjD
    5W9NSa6iNTlZPIczw>
X-ME-Received: <xmr:4e0ZaJQ1cRz0GwMZoPe69sCyqweoxGYOLnL32M4OLugZAfXlTdwYbDs_OKiztMHAhx8yuU-oS-6YPRjp9_rpbPe6whZ07EJsTKrnwkRb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4e0ZaCs0qtNIL8cjQ_M3Sr6Rl3Sh__v2lGJPET20WXXhuHaC_G1f7g>
    <xmx:4e0ZaKecPqjZc4RohmGBrJpwoX9BJIOes2ErCSNs7sdmKPARRY1a0A>
    <xmx:4e0ZaG1ZQaCC13r8WLQDC1xUNtFL8NoMKceBTvwSPNv_hzr5o7iItQ>
    <xmx:4e0ZaO-SRFvcqQN05ucNMvWPt68JC-W2Ny9F1mc5-lw6H7qRWuBDoQ>
    <xmx:4e0ZaK61MPMJEuWHc3fABoT56V1OfEpn2Fz3tBSzJVmAqaL7Nr5RF9vN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ba7ef30 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:15 +0200
Subject: [PATCH 02/17] object-store: rename `object_directory` to
 `odb_backend`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-2-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
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

Let's preempt this by renaming the structure to `odb_backend` now
already. This name is agnostic of how exactly objects are stored and
allows us to easily introduce e.g. a `files_odb_backend` and other
specific implementations over time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c      |   4 +-
 builtin/count-objects.c     |   2 +-
 builtin/fetch.c             |   2 +-
 builtin/fsck.c              |  14 +++----
 builtin/gc.c                |  14 +++----
 builtin/grep.c              |   2 +-
 builtin/multi-pack-index.c  |   4 +-
 builtin/submodule--helper.c |   2 +-
 bundle.c                    |   2 +-
 commit-graph.c              |  44 +++++++++----------
 commit-graph.h              |  14 +++----
 diagnose.c                  |   4 +-
 http-walker.c               |   2 +-
 http.c                      |   4 +-
 loose.c                     |  20 ++++-----
 midx.c                      |   6 +--
 object-file.c               |  46 ++++++++++----------
 object-file.h               |   8 ++--
 object-name.c               |   6 +--
 object-store.c              | 100 ++++++++++++++++++++++----------------------
 object-store.h              |  23 +++++-----
 packfile.c                  |  16 +++----
 path.c                      |   2 +-
 refs.c                      |   2 +-
 repository.c                |  17 ++++----
 submodule-config.c          |   2 +-
 t/helper/test-read-graph.c  |   6 +--
 tmp-objdir.c                |   4 +-
 28 files changed, 187 insertions(+), 185 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a783a86e797..b4cbdbb1f7b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -66,7 +66,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
-	struct object_directory *odb = NULL;
+	struct odb_backend *odb = NULL;
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
@@ -221,7 +221,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
-	struct object_directory *odb = NULL;
+	struct odb_backend *odb = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a88c0c9c09a..80f2693ac3c 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -80,7 +80,7 @@ static int count_cruft(const char *basename UNUSED, const char *path,
 	return 0;
 }
 
-static int print_alternate(struct object_directory *odb, void *data UNUSED)
+static int print_alternate(struct odb_backend *odb, void *data UNUSED)
 {
 	printf("alternate: ");
 	quote_c_style(odb->path, NULL, stdout, 0);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index cda6eaf1fd6..0b15121ff7c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2652,7 +2652,7 @@ int cmd_fetch(int argc,
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		trace2_region_enter("fetch", "write-commit-graph", the_repository);
-		write_commit_graph_reachable(the_repository->objects->odb,
+		write_commit_graph_reachable(the_repository->objects->backends,
 					     commit_graph_flags,
 					     NULL);
 		trace2_region_leave("fetch", "write-commit-graph", the_repository);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6cac28356ce..0c1df302129 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -965,7 +965,7 @@ int cmd_fsck(int argc,
 	     struct repository *repo UNUSED)
 {
 	int i;
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -1007,8 +1007,8 @@ int cmd_fsck(int argc,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next)
-			fsck_object_dir(odb->path);
+		for (backend = the_repository->objects->backends; backend; backend = backend->next)
+			fsck_object_dir(backend->path);
 
 		if (check_full) {
 			struct packed_git *p;
@@ -1118,11 +1118,11 @@ int cmd_fsck(int argc,
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		for (backend = the_repository->objects->backends; backend; backend = backend->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
-				     "verify", "--object-dir", odb->path, NULL);
+				     "verify", "--object-dir", backend->path, NULL);
 			if (show_progress)
 				strvec_push(&commit_graph_verify.args, "--progress");
 			else
@@ -1136,11 +1136,11 @@ int cmd_fsck(int argc,
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		for (backend = the_repository->objects->backends; backend; backend = backend->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
 			strvec_pushl(&midx_verify.args, "multi-pack-index",
-				     "verify", "--object-dir", odb->path, NULL);
+				     "verify", "--object-dir", backend->path, NULL);
 			if (show_progress)
 				strvec_push(&midx_verify.args, "--progress");
 			else
diff --git a/builtin/gc.c b/builtin/gc.c
index 78a2751aa8a..ea13660dba1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -944,7 +944,7 @@ struct repository *repo UNUSED)
 	}
 
 	if (the_repository->settings.gc_write_commit_graph == 1)
-		write_commit_graph_reachable(the_repository->objects->odb,
+		write_commit_graph_reachable(the_repository->objects->backends,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
@@ -1197,7 +1197,7 @@ static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 	if (loose_object_auto_limit < 0)
 		return 1;
 
-	return for_each_loose_file_in_objdir(the_repository->objects->odb->path,
+	return for_each_loose_file_in_objdir(the_repository->objects->backends->path,
 					     loose_object_count,
 					     NULL, NULL, &count);
 }
@@ -1232,7 +1232,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	 * Do not start pack-objects process
 	 * if there are no loose objects.
 	 */
-	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
+	if (!for_each_loose_file_in_objdir(r->objects->backends->path,
 					   bail_on_loose,
 					   NULL, NULL, NULL))
 		return 0;
@@ -1244,7 +1244,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 		strvec_push(&pack_proc.args, "--quiet");
 	else
 		strvec_push(&pack_proc.args, "--no-quiet");
-	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->backends->path);
 
 	pack_proc.in = -1;
 
@@ -1272,7 +1272,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	else if (data.batch_size > 0)
 		data.batch_size--; /* Decrease for equality on limit. */
 
-	for_each_loose_file_in_objdir(r->objects->odb->path,
+	for_each_loose_file_in_objdir(r->objects->backends->path,
 				      write_loose_object_to_stdin,
 				      NULL,
 				      NULL,
@@ -1525,7 +1525,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
-	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
+	char *lock_path = xstrfmt("%s/maintenance", r->objects->backends->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		/*
@@ -2997,7 +2997,7 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 	unsigned int i;
 	int result = 0;
 	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->backends->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		if (errno == EEXIST)
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ce574a605b..3affe523df1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -505,7 +505,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * lazily registered as alternates when needed (and except in an
 	 * unexpected code interaction, it won't be needed).
 	 */
-	add_submodule_odb_by_path(subrepo->objects->odb->path);
+	add_submodule_odb_by_path(subrepo->objects->backends->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 69a97507324..87173307bf3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -294,8 +294,8 @@ int cmd_multi_pack_index(int argc,
 
 	if (the_repository &&
 	    the_repository->objects &&
-	    the_repository->objects->odb)
-		opts.object_dir = xstrdup(the_repository->objects->odb->path);
+	    the_repository->objects->backends)
+		opts.object_dir = xstrdup(the_repository->objects->backends->path);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_multi_pack_index_usage, 0);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116ddf..13fb4ecfaac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1582,7 +1582,7 @@ static const char alternate_error_advice[] = N_(
 );
 
 static int add_possible_reference_from_superproject(
-		struct object_directory *odb, void *sas_cb)
+		struct odb_backend *odb, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
 	size_t len;
diff --git a/bundle.c b/bundle.c
index b0a3fee2efa..dd4c082f8e7 100644
--- a/bundle.c
+++ b/bundle.c
@@ -233,7 +233,7 @@ int verify_bundle(struct repository *r,
 		.quiet = 1,
 	};
 
-	if (!r || !r->objects || !r->objects->odb)
+	if (!r || !r->objects || !r->objects->backends)
 		return error(_("need a repository to verify a bundle"));
 
 	for (i = 0; i < p->nr; i++) {
diff --git a/commit-graph.c b/commit-graph.c
index 1b66486b9c9..7a85b73cd99 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -37,7 +37,7 @@ void git_test_write_commit_graph_or_die(void)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(the_repository->objects->odb,
+	if (write_commit_graph_reachable(the_repository->objects->backends,
 					 flags, NULL))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
@@ -191,19 +191,19 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-char *get_commit_graph_filename(struct object_directory *obj_dir)
+char *get_commit_graph_filename(struct odb_backend *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir->path);
 }
 
-static char *get_split_graph_filename(struct object_directory *odb,
+static char *get_split_graph_filename(struct odb_backend *odb,
 				      const char *oid_hex)
 {
 	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", odb->path,
 		       oid_hex);
 }
 
-char *get_commit_graph_chain_filename(struct object_directory *odb)
+char *get_commit_graph_chain_filename(struct odb_backend *odb)
 {
 	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
 }
@@ -250,7 +250,7 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
-						 struct object_directory *odb)
+						 struct odb_backend *odb)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -487,7 +487,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 static struct commit_graph *load_commit_graph_one(struct repository *r,
 						  const char *graph_file,
-						  struct object_directory *odb)
+						  struct odb_backend *odb)
 {
 
 	struct stat st;
@@ -507,7 +507,7 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
 }
 
 static struct commit_graph *load_commit_graph_v1(struct repository *r,
-						 struct object_directory *odb)
+						 struct odb_backend *odb)
 {
 	char *graph_name = get_commit_graph_filename(odb);
 	struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
@@ -652,7 +652,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	prepare_alt_odb(r);
 
 	for (i = 0; i < count; i++) {
-		struct object_directory *odb;
+		struct odb_backend *backend;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
@@ -665,9 +665,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		}
 
 		valid = 0;
-		for (odb = r->objects->odb; odb; odb = odb->next) {
-			char *graph_name = get_split_graph_filename(odb, line.buf);
-			struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
+		for (backend = r->objects->backends; backend; backend = backend->next) {
+			char *graph_name = get_split_graph_filename(backend, line.buf);
+			struct commit_graph *g = load_commit_graph_one(r, graph_name, backend);
 
 			free(graph_name);
 
@@ -701,7 +701,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 }
 
 static struct commit_graph *load_commit_graph_chain(struct repository *r,
-						    struct object_directory *odb)
+						    struct odb_backend *odb)
 {
 	char *chain_file = get_commit_graph_chain_filename(odb);
 	struct stat st;
@@ -719,7 +719,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 }
 
 struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct object_directory *odb)
+					   struct odb_backend *odb)
 {
 	struct commit_graph *g = load_commit_graph_v1(r, odb);
 
@@ -730,7 +730,7 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 }
 
 static void prepare_commit_graph_one(struct repository *r,
-				     struct object_directory *odb)
+				     struct odb_backend *odb)
 {
 
 	if (r->objects->commit_graph)
@@ -747,7 +747,7 @@ static void prepare_commit_graph_one(struct repository *r,
  */
 static int prepare_commit_graph(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	/*
 	 * Early return if there is no git dir or if the commit graph is
@@ -779,10 +779,10 @@ static int prepare_commit_graph(struct repository *r)
 		return 0;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb;
-	     !r->objects->commit_graph && odb;
-	     odb = odb->next)
-		prepare_commit_graph_one(r, odb);
+	for (backend = r->objects->backends;
+	     !r->objects->commit_graph && backend;
+	     backend = backend->next)
+		prepare_commit_graph_one(r, backend);
 	return !!r->objects->commit_graph;
 }
 
@@ -1137,7 +1137,7 @@ struct packed_commit_list {
 
 struct write_commit_graph_context {
 	struct repository *r;
-	struct object_directory *odb;
+	struct odb_backend *odb;
 	char *graph_name;
 	struct oid_array oids;
 	struct packed_commit_list commits;
@@ -1870,7 +1870,7 @@ static int add_ref_to_set(const char *refname UNUSED,
 	return 0;
 }
 
-int write_commit_graph_reachable(struct object_directory *odb,
+int write_commit_graph_reachable(struct odb_backend *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts)
 {
@@ -2502,7 +2502,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(struct object_directory *odb,
+int write_commit_graph(struct odb_backend *odb,
 		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
diff --git a/commit-graph.h b/commit-graph.h
index 20d38c100ce..437cb48081d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -29,8 +29,8 @@ struct repository;
 struct object_database;
 struct string_list;
 
-char *get_commit_graph_filename(struct object_directory *odb);
-char *get_commit_graph_chain_filename(struct object_directory *odb);
+char *get_commit_graph_filename(struct odb_backend *odb);
+char *get_commit_graph_chain_filename(struct odb_backend *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
 
@@ -89,7 +89,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
-	struct object_directory *odb;
+	struct odb_backend *odb;
 
 	uint32_t num_commits_in_base;
 	unsigned int read_generation_data;
@@ -115,12 +115,12 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
-						 struct object_directory *odb);
+						 struct odb_backend *odb);
 struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);
 struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct object_directory *odb);
+					   struct odb_backend *odb);
 
 struct repo_settings;
 
@@ -173,10 +173,10 @@ struct commit_graph_opts {
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
  */
-int write_commit_graph_reachable(struct object_directory *odb,
+int write_commit_graph_reachable(struct odb_backend *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts);
-int write_commit_graph(struct object_directory *odb,
+int write_commit_graph(struct odb_backend *odb,
 		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
diff --git a/diagnose.c b/diagnose.c
index b1be74be983..3016ad223d2 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -59,7 +59,7 @@ static void dir_file_stats_objects(const char *full_path,
 			    (uintmax_t)st.st_size);
 }
 
-static int dir_file_stats(struct object_directory *object_dir, void *data)
+static int dir_file_stats(struct odb_backend *object_dir, void *data)
 {
 	struct strbuf *buf = data;
 
@@ -228,7 +228,7 @@ int create_diagnostics_archive(struct repository *r,
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(r->objects->odb, &buf);
+	dir_file_stats(r->objects->backends, &buf);
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
diff --git a/http-walker.c b/http-walker.c
index 463f7b119ad..abb44d73067 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -543,7 +543,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		odb_loose_path(the_repository->objects->odb, &buf, &req->oid);
+		odb_loose_path(the_repository->objects->backends, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 3c029cf8947..302738dd29b 100644
--- a/http.c
+++ b/http.c
@@ -2662,7 +2662,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->backends, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2814,7 +2814,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	odb_loose_path(the_repository->objects->odb, &filename, &freq->oid);
+	odb_loose_path(the_repository->objects->backends, &filename, &freq->oid);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/loose.c b/loose.c
index bb602aaa366..fab7f99868d 100644
--- a/loose.c
+++ b/loose.c
@@ -44,7 +44,7 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
-static int insert_loose_map(struct object_directory *odb,
+static int insert_loose_map(struct odb_backend *odb,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
@@ -59,7 +59,7 @@ static int insert_loose_map(struct object_directory *odb,
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
+static int load_one_loose_object_map(struct repository *repo, struct odb_backend *dir)
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
@@ -107,15 +107,15 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 
 int repo_read_loose_object_map(struct repository *repo)
 {
-	struct object_directory *dir;
+	struct odb_backend *backend;
 
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
 	prepare_alt_odb(repo);
 
-	for (dir = repo->objects->odb; dir; dir = dir->next) {
-		if (load_one_loose_object_map(repo, dir) < 0) {
+	for (backend = repo->objects->backends; backend; backend = backend->next) {
+		if (load_one_loose_object_map(repo, backend) < 0) {
 			return -1;
 		}
 	}
@@ -124,7 +124,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
+	kh_oid_map_t *map = repo->objects->backends->loose_map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -212,7 +212,7 @@ int repo_add_loose_object_map(struct repository *repo, const struct object_id *o
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	inserted = insert_loose_map(repo->objects->odb, oid, compat_oid);
+	inserted = insert_loose_map(repo->objects->backends, oid, compat_oid);
 	if (inserted)
 		return write_one_object(repo, oid, compat_oid);
 	return 0;
@@ -223,12 +223,12 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct git_hash_algo *to,
 			      struct object_id *dest)
 {
-	struct object_directory *dir;
+	struct odb_backend *backend;
 	kh_oid_map_t *map;
 	khiter_t pos;
 
-	for (dir = repo->objects->odb; dir; dir = dir->next) {
-		struct loose_object_map *loose_map = dir->loose_map;
+	for (backend = repo->objects->backends; backend; backend = backend->next) {
+		struct loose_object_map *loose_map = backend->loose_map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index 3d0015f7828..767217678eb 100644
--- a/midx.c
+++ b/midx.c
@@ -824,7 +824,7 @@ void clear_midx_file(struct repository *r)
 {
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(r->hash_algo, &midx, r->objects->odb->path);
+	get_midx_filename(r->hash_algo, &midx, r->objects->backends->path);
 
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
@@ -834,8 +834,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_BITMAP, NULL);
-	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_REV, NULL);
+	clear_midx_files_ext(r->objects->backends->path, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(r->objects->backends->path, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
diff --git a/object-file.c b/object-file.c
index dc56a4766df..4940103ac6d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -55,7 +55,7 @@ static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 	}
 }
 
-const char *odb_loose_path(struct object_directory *odb,
+const char *odb_loose_path(struct odb_backend *odb,
 			   struct strbuf *buf,
 			   const struct object_id *oid)
 {
@@ -88,7 +88,7 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_odb(struct object_directory *odb,
+static int check_and_freshen_odb(struct odb_backend *odb,
 				 const struct object_id *oid,
 				 int freshen)
 {
@@ -99,16 +99,16 @@ static int check_and_freshen_odb(struct object_directory *odb,
 
 static int check_and_freshen_local(const struct object_id *oid, int freshen)
 {
-	return check_and_freshen_odb(the_repository->objects->odb, oid, freshen);
+	return check_and_freshen_odb(the_repository->objects->backends, oid, freshen);
 }
 
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb->next; odb; odb = odb->next) {
-		if (check_and_freshen_odb(odb, oid, freshen))
+	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
+		if (check_and_freshen_odb(backend, oid, freshen))
 			return 1;
 	}
 	return 0;
@@ -208,12 +208,12 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 static int stat_loose_object(struct repository *r, const struct object_id *oid,
 			     struct stat *st, const char **path)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, oid);
+	for (backend = r->objects->backends; backend; backend = backend->next) {
+		*path = odb_loose_path(backend, &buf, oid);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -229,13 +229,13 @@ static int open_loose_object(struct repository *r,
 			     const struct object_id *oid, const char **path)
 {
 	int fd;
-	struct object_directory *odb;
+	struct odb_backend *backend;
 	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, oid);
+	for (backend = r->objects->backends; backend; backend = backend->next) {
+		*path = odb_loose_path(backend, &buf, oid);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
@@ -250,11 +250,11 @@ static int open_loose_object(struct repository *r,
 static int quick_has_loose(struct repository *r,
 			   const struct object_id *oid)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		if (oidtree_contains(odb_loose_cache(odb, oid), oid))
+	for (backend = r->objects->backends; backend; backend = backend->next) {
+		if (oidtree_contains(odb_loose_cache(backend, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -750,7 +750,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd, const char *filename)
 {
-	if (the_repository->objects->odb->will_destroy)
+	if (the_repository->objects->backends->will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
@@ -932,7 +932,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
 		prepare_loose_object_bulk_checkin();
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->backends, &filename, oid);
 
 	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
@@ -1079,7 +1079,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		goto cleanup;
 	}
 
-	odb_loose_path(the_repository->objects->odb, &filename, oid);
+	odb_loose_path(the_repository->objects->backends, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
 	dirlen = directory_size(filename.buf);
@@ -1540,11 +1540,11 @@ int for_each_loose_file_in_objdir(const char *path,
 int for_each_loose_object(each_loose_object_fn cb, void *data,
 			  enum for_each_object_flags flags)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb; odb; odb = odb->next) {
-		int r = for_each_loose_file_in_objdir(odb->path, cb, NULL,
+	for (backend = the_repository->objects->backends; backend; backend = backend->next) {
+		int r = for_each_loose_file_in_objdir(backend->path, cb, NULL,
 						      NULL, data);
 		if (r)
 			return r;
@@ -1564,7 +1564,7 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_loose_cache(struct object_directory *odb,
+struct oidtree *odb_loose_cache(struct odb_backend *odb,
 				  const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
@@ -1595,7 +1595,7 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 	return odb->loose_objects_cache;
 }
 
-void odb_clear_loose_cache(struct object_directory *odb)
+void odb_clear_loose_cache(struct odb_backend *odb)
 {
 	oidtree_clear(odb->loose_objects_cache);
 	FREE_AND_NULL(odb->loose_objects_cache);
diff --git a/object-file.h b/object-file.h
index a85b2e5b494..630a8ef1cbd 100644
--- a/object-file.h
+++ b/object-file.h
@@ -24,23 +24,23 @@ enum {
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-struct object_directory;
+struct odb_backend;
 
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oidtree *odb_loose_cache(struct object_directory *odb,
+struct oidtree *odb_loose_cache(struct odb_backend *odb,
 				const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct object_directory *odb);
+void odb_clear_loose_cache(struct odb_backend *odb);
 
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
  */
-const char *odb_loose_path(struct object_directory *odb,
+const char *odb_loose_path(struct odb_backend *odb,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
diff --git a/object-name.c b/object-name.c
index 9288b2dd245..b80791a9018 100644
--- a/object-name.c
+++ b/object-name.c
@@ -112,10 +112,10 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
-	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
-		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
+	for (backend = ds->repo->objects->backends; backend && !ds->ambiguous; backend = backend->next)
+		oidtree_each(odb_loose_cache(backend, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
diff --git a/object-store.c b/object-store.c
index 1effcb12273..1c57c7b1a32 100644
--- a/object-store.c
+++ b/object-store.c
@@ -27,7 +27,7 @@
 #include "write-or-die.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, fspathhash, fspatheq)
+	struct odb_backend *, 1, fspathhash, fspatheq)
 
 /*
  * This is meant to hold a *small* number of objects that you would
@@ -104,18 +104,18 @@ static int alt_odb_usable(struct object_database *o,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	if (!o->odb_by_path) {
+	if (!o->backend_by_path) {
 		khiter_t p;
 
-		o->odb_by_path = kh_init_odb_path_map();
-		assert(!o->odb->next);
-		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
+		o->backend_by_path = kh_init_odb_path_map();
+		assert(!o->backends->next);
+		p = kh_put_odb_path_map(o->backend_by_path, o->backends->path, &r);
 		assert(r == 1); /* never used */
-		kh_value(o->odb_by_path, p) = o->odb;
+		kh_value(o->backend_by_path, p) = o->backends;
 	}
 	if (fspatheq(path->buf, normalized_objdir))
 		return 0;
-	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
+	*pos = kh_put_odb_path_map(o->backend_by_path, path->buf, &r);
 	/* r: 0 = exists, 1 = never used, 2 = deleted */
 	return r == 0 ? 0 : 1;
 }
@@ -124,7 +124,7 @@ static int alt_odb_usable(struct object_database *o,
  * Prepare alternate object database registry.
  *
  * The variable alt_odb_list points at the list of struct
- * object_directory.  The elements on this list come from
+ * odb_backend.  The elements on this list come from
  * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
  * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
  * whose contents is similar to that environment variable but can be
@@ -141,7 +141,7 @@ static void read_info_alternates(struct repository *r,
 static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
-	struct object_directory *ent;
+	struct odb_backend *backend;
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
@@ -170,19 +170,19 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
 		goto error;
 
-	CALLOC_ARRAY(ent, 1);
-	/* pathbuf.buf is already in r->objects->odb_by_path */
-	ent->path = strbuf_detach(&pathbuf, NULL);
+	CALLOC_ARRAY(backend, 1);
+	/* pathbuf.buf is already in r->objects->backend_by_path */
+	backend->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
-	*r->objects->odb_tail = ent;
-	r->objects->odb_tail = &(ent->next);
-	ent->next = NULL;
-	assert(r->objects->odb_by_path);
-	kh_value(r->objects->odb_by_path, pos) = ent;
+	*r->objects->backends_tail = backend;
+	r->objects->backends_tail = &(backend->next);
+	backend->next = NULL;
+	assert(r->objects->backend_by_path);
+	kh_value(r->objects->backend_by_path, pos) = backend;
 
 	/* recursively add alternates */
-	read_info_alternates(r, ent->path, depth + 1);
+	read_info_alternates(r, backend->path, depth + 1);
 	ret = 0;
  error:
 	strbuf_release(&tmp);
@@ -234,7 +234,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
+	strbuf_realpath(&objdirbuf, r->objects->backends->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
@@ -321,9 +321,9 @@ void add_to_alternates_memory(const char *reference)
 			     '\n', NULL, 0);
 }
 
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
 {
-	struct object_directory *new_odb;
+	struct odb_backend *backend;
 
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
@@ -335,21 +335,21 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
-	new_odb = xcalloc(1, sizeof(*new_odb));
-	new_odb->path = xstrdup(dir);
+	backend = xcalloc(1, sizeof(*backend));
+	backend->path = xstrdup(dir);
 
 	/*
 	 * Disable ref updates while a temporary odb is active, since
 	 * the objects in the database may roll back.
 	 */
-	new_odb->disable_ref_updates = 1;
-	new_odb->will_destroy = will_destroy;
-	new_odb->next = the_repository->objects->odb;
-	the_repository->objects->odb = new_odb;
-	return new_odb->next;
+	backend->disable_ref_updates = 1;
+	backend->will_destroy = will_destroy;
+	backend->next = the_repository->objects->backends;
+	the_repository->objects->backends = backend;
+	return backend->next;
 }
 
-static void free_object_directory(struct object_directory *odb)
+static void free_object_directory(struct odb_backend *odb)
 {
 	free(odb->path);
 	odb_clear_loose_cache(odb);
@@ -357,9 +357,9 @@ static void free_object_directory(struct object_directory *odb)
 	free(odb);
 }
 
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
+void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path)
 {
-	struct object_directory *cur_odb = the_repository->objects->odb;
+	struct odb_backend *cur_odb = the_repository->objects->backends;
 
 	if (strcmp(old_path, cur_odb->path))
 		BUG("expected %s as primary object store; found %s",
@@ -368,7 +368,7 @@ void restore_primary_odb(struct object_directory *restore_odb, const char *old_p
 	if (cur_odb->next != restore_odb)
 		BUG("we expect the old primary object store to be the first alternate");
 
-	the_repository->objects->odb = restore_odb;
+	the_repository->objects->backends = restore_odb;
 	free_object_directory(cur_odb);
 }
 
@@ -442,14 +442,14 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct object_directory *find_odb(struct repository *r, const char *obj_dir)
+struct odb_backend *find_odb(struct repository *r, const char *obj_dir)
 {
-	struct object_directory *odb;
+	struct odb_backend *odb;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
+	for (odb = r->objects->backends; odb; odb = odb->next) {
 		strbuf_realpath(&odb_path_real, odb->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
@@ -527,7 +527,7 @@ struct alternate_refs_data {
 	void *data;
 };
 
-static int refs_from_alternate_cb(struct object_directory *e,
+static int refs_from_alternate_cb(struct odb_backend *e,
 				  void *data)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -563,12 +563,12 @@ void for_each_alternate_ref(alternate_ref_fn fn, void *data)
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
-	struct object_directory *ent;
+	struct odb_backend *backend;
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
-		r = fn(ent, cb);
+	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
+		r = fn(backend, cb);
 		if (r)
 			break;
 	}
@@ -582,14 +582,14 @@ void prepare_alt_odb(struct repository *r)
 
 	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->odb->path, 0);
+	read_info_alternates(r, r->objects->backends->path, 0);
 	r->objects->loaded_alternates = 1;
 }
 
 int has_alt_odb(struct repository *r)
 {
 	prepare_alt_odb(r);
-	return !!r->objects->odb->next;
+	return !!r->objects->backends->next;
 }
 
 int obj_read_use_lock = 0;
@@ -959,7 +959,7 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 		    type_name(expect));
 }
 
-struct object_database *odb_new(void)
+struct object_database *odb_new(struct repository *repo)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
 
@@ -972,15 +972,15 @@ struct object_database *odb_new(void)
 
 static void free_object_directories(struct object_database *o)
 {
-	while (o->odb) {
-		struct object_directory *next;
+	while (o->backends) {
+		struct odb_backend *next;
 
-		next = o->odb->next;
-		free_object_directory(o->odb);
-		o->odb = next;
+		next = o->backends->next;
+		free_object_directory(o->backends);
+		o->backends = next;
 	}
-	kh_destroy_odb_path_map(o->odb_by_path);
-	o->odb_by_path = NULL;
+	kh_destroy_odb_path_map(o->backend_by_path);
+	o->backend_by_path = NULL;
 }
 
 void odb_clear(struct object_database *o)
@@ -996,7 +996,7 @@ void odb_clear(struct object_database *o)
 	o->commit_graph_attempted = 0;
 
 	free_object_directories(o);
-	o->odb_tail = NULL;
+	o->backends_tail = NULL;
 	o->loaded_alternates = 0;
 
 	for (size_t i = 0; i < o->cached_object_nr; i++)
diff --git a/object-store.h b/object-store.h
index 34b8efbbb83..94b678eb63c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -12,8 +12,9 @@ struct oidtree;
 struct strbuf;
 struct repository;
 
-struct object_directory {
-	struct object_directory *next;
+/* The backend used to access objects in a specific object directory. */
+struct odb_backend {
+	struct odb_backend *next;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -52,8 +53,8 @@ struct object_directory {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct object_directory *find_odb(struct repository *r, const char *obj_dir);
-typedef int alt_odb_fn(struct object_directory *, void *);
+struct odb_backend *find_odb(struct repository *r, const char *obj_dir);
+typedef int alt_odb_fn(struct odb_backend *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
 void for_each_alternate_ref(alternate_ref_fn, void *);
@@ -75,12 +76,12 @@ void add_to_alternates_memory(const char *dir);
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
  */
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy);
 
 /*
  * Restore a previous ODB replaced by set_temporary_main_odb.
  */
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path);
 
 struct packed_git;
 struct multi_pack_index;
@@ -97,16 +98,16 @@ struct object_database {
 	 * cannot be NULL after initialization). Subsequent directories are
 	 * alternates.
 	 */
-	struct object_directory *odb;
-	struct object_directory **odb_tail;
-	struct kh_odb_path_map *odb_by_path;
+	struct odb_backend *backends;
+	struct odb_backend **backends_tail;
+	struct kh_odb_path_map *backend_by_path;
 
 	int loaded_alternates;
 
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will
-	 * populate the "odb" list when prepare_alt_odb() is run.
+	 * populate the "backends" list when prepare_alt_odb() is run.
 	 */
 	char *alternate_db;
 
@@ -173,7 +174,7 @@ struct object_database {
 	unsigned packed_git_initialized : 1;
 };
 
-struct object_database *odb_new(void);
+struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
 /*
diff --git a/packfile.c b/packfile.c
index 8f51665266d..69096849654 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1018,16 +1018,16 @@ static void prepare_packed_git_mru(struct repository *r)
 
 static void prepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	if (r->objects->packed_git_initialized)
 		return;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		int local = (odb == r->objects->odb);
-		prepare_multi_pack_index_one(r, odb->path, local);
-		prepare_packed_git_one(r, odb->path, local);
+	for (backend = r->objects->backends; backend; backend = backend->next) {
+		int local = (backend == r->objects->backends);
+		prepare_multi_pack_index_one(r, backend->path, local);
+		prepare_packed_git_one(r, backend->path, local);
 	}
 	rearrange_packed_git(r);
 
@@ -1037,7 +1037,7 @@ static void prepare_packed_git(struct repository *r)
 
 void reprepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
+	struct odb_backend *backend;
 
 	obj_read_lock();
 
@@ -1050,8 +1050,8 @@ void reprepare_packed_git(struct repository *r)
 	r->objects->loaded_alternates = 0;
 	prepare_alt_odb(r);
 
-	for (odb = r->objects->odb; odb; odb = odb->next)
-		odb_clear_loose_cache(odb);
+	for (backend = r->objects->backends; backend; backend = backend->next)
+		odb_clear_loose_cache(backend);
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
diff --git a/path.c b/path.c
index 3b598b2847f..04a9ef5a1b1 100644
--- a/path.c
+++ b/path.c
@@ -397,7 +397,7 @@ static void adjust_git_path(struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objects->odb->path);
+		replace_dir(buf, git_dir_len + 7, repo->objects->backends->path);
 	else if (repo_settings_get_hooks_path(repo) && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, repo_settings_get_hooks_path(repo));
 	else if (repo->different_commondir)
diff --git a/refs.c b/refs.c
index dce5c49ca2b..ff2d5d6e92b 100644
--- a/refs.c
+++ b/refs.c
@@ -2477,7 +2477,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (refs->repo->objects->odb->disable_ref_updates) {
+	if (refs->repo->objects->backends->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index 07757e6e0c9..0ab73846de3 100644
--- a/repository.c
+++ b/repository.c
@@ -52,7 +52,7 @@ static void set_default_hash_algo(struct repository *repo)
 
 void initialize_repository(struct repository *repo)
 {
-	repo->objects = odb_new();
+	repo->objects = odb_new(repo);
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
@@ -107,9 +107,9 @@ const char *repo_get_common_dir(struct repository *repo)
 
 const char *repo_get_object_directory(struct repository *repo)
 {
-	if (!repo->objects->odb)
+	if (!repo->objects->backends)
 		BUG("repository hasn't been set up");
-	return repo->objects->odb->path;
+	return repo->objects->backends->path;
 }
 
 const char *repo_get_index_file(struct repository *repo)
@@ -165,14 +165,15 @@ void repo_set_gitdir(struct repository *repo,
 
 	repo_set_commondir(repo, o->commondir);
 
-	if (!repo->objects->odb) {
-		CALLOC_ARRAY(repo->objects->odb, 1);
-		repo->objects->odb_tail = &repo->objects->odb->next;
+	if (!repo->objects->backends) {
+		CALLOC_ARRAY(repo->objects->backends, 1);
+		repo->objects->backends->odb = repo->objects;
+		repo->objects->backends_tail = &repo->objects->backends->next;
 	}
-	expand_base_dir(&repo->objects->odb->path, o->object_dir,
+	expand_base_dir(&repo->objects->backends->path, o->object_dir,
 			repo->commondir, "objects");
 
-	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
+	repo->objects->backends->disable_ref_updates = o->disable_ref_updates;
 
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
diff --git a/submodule-config.c b/submodule-config.c
index 8630e27947d..c9418f51265 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -810,7 +810,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_submodule_odb_by_path(repo->objects->odb->path);
+				add_submodule_odb_by_path(repo->objects->backends->path);
 		} else {
 			goto out;
 		}
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8b413b644be..45b0043eb93 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -73,15 +73,15 @@ static void dump_graph_bloom_filters(struct commit_graph *graph)
 int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
+	struct odb_backend *backend;
 	int ret = 0;
 
 	setup_git_directory();
-	odb = the_repository->objects->odb;
+	backend = the_repository->objects->backends;
 
 	prepare_repo_settings(the_repository);
 
-	graph = read_commit_graph_one(the_repository, odb);
+	graph = read_commit_graph_one(the_repository, backend);
 	if (!graph) {
 		ret = 1;
 		goto done;
diff --git a/tmp-objdir.c b/tmp-objdir.c
index c38fbeb5e8a..cc4efb3d816 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -17,7 +17,7 @@ struct tmp_objdir {
 	struct repository *repo;
 	struct strbuf path;
 	struct strvec env;
-	struct object_directory *prev_odb;
+	struct odb_backend *prev_odb;
 	int will_destroy;
 };
 
@@ -277,7 +277,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 		return 0;
 
 	if (t->prev_odb) {
-		if (t->repo->objects->odb->will_destroy)
+		if (t->repo->objects->backends->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
 		restore_primary_odb(t->prev_odb, t->path.buf);
 		t->prev_odb = NULL;

-- 
2.49.0.1045.g170613ef41.dirty

