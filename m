Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396327A932
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529769; cv=none; b=bKtRB5ZtbXu3+ELdWzLNgujRA80KfqJfN+1nM/UVUBdkVPFv3U/6zYWDODo+P6qKqI4ERMXj646xcsVoLeGAdi2mFhN1cuKMz59v4QoJ/4d8RozLJnPrvBbQHtOdmQpMtEYxwRBeMmA/Mo3CKvRsdpQmPBYappCaqpuhrjOC4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529769; c=relaxed/simple;
	bh=sE47Rt/WQ7E6Z7XQnHlk+CAz2zO9GZdfLQjms1wRqG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EP/NrEffviAeE/7op5FRkj2tm9+b+BApYxqcsD43jQGtLTaKTGZtHENPqv4L8TOh9OuxLQoAVeZ2wUOBhzGWMYks5RJDsBfhBg5DDH0WO8Ad7TYeCmrRj0K3Y0udDA8NkMVeM7k1mp6RsavKbty5AOGAQBl2zI78rRIwzAvwAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2q6/yaFi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lERnEvMO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2q6/yaFi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lERnEvMO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 30A831380FE3
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 07:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529766;
	 x=1746616166; bh=hwImNP/kWJa70+vtYsnPCpxZZt6YFlCTZPLjfoi6QSA=; b=
	2q6/yaFiwMhZ2ENT34bphUMgv+CoOvnRYNul2EAb983/FmnrIjAyFzOTn8pIU2kl
	/7uF5CEQs5hfYQrGFWhf0iJShjRolXcWs1n87kOnnMnNmv0VjEpRiwWNYFqNPO5/
	0kXaun35syde8OXUZUXtLIIu4C75aa3LkiLHG0yPXu/P//SGNASdYcWiit9PGfDG
	3pjOi85zoqQ7orL1pS5SDBxpS1QCOifrHjfEam2R2EAZMwOVAL+SnkzF+A4vl/jx
	GccZhgwppo/NulKoTZAJcEV4XQprcR9uEaudRPujaHVgOnLYqGqfOrlwsP0a6E0r
	NSCOXZ312FGCBezh4n8BlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529766; x=
	1746616166; bh=hwImNP/kWJa70+vtYsnPCpxZZt6YFlCTZPLjfoi6QSA=; b=l
	ERnEvMO5m65v/QsiC30AgPxhAJP+P4YNSyBbX6Y5ctkYOhaGDgCQBUWDKfAui8Md
	RSckHEP/qXOeXTZ45AzAAnMiNWyU7DQHa0/RMbGAxRBUOs6bvuarLjbwcOGyxKdf
	eZa0+YE7sv6XsftHy+ySHcLwaDon63ogslhj6dquSvjl1gtjqD9RquMMP7ESlZ5A
	o3LbMoQ20ob3UCHreK7Rj9AR5qeEabwx0afWaQ9NQzDUR+UHvdRLtbSHcmfwGnjH
	dMrxe0TKao7Nvl1VH3DUwFeNaEllt124yc3Py/bvS/mqqLoI141YXCe6stX4BLh/
	C1IypdiNevag/+uWoCiwg==
X-ME-Sender: <xms:5u0ZaHR015mWcpoCfTLnmLBUkn5NmA6vUjpTWXLD4MnZViFROGg2VQ>
    <xme:5u0ZaIzpQk5kBt9aq7aLyp2ROCuTAsnST5jn1Ps-dPa00nwqAQWGWRlW0d8B2PwiD
    0of2eWNhF7Fx-YbPQ>
X-ME-Received: <xmr:5u0ZaM2QwRwmNm9qjgxr-AJJqU-n67ZsfLi8yOOCi44RRGYP5-hg2bfURF4JqWPt-OJdV8KfpH4OozfJz0cSoyY3oedEUajL5D_ae0v_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5u0ZaHBBYq6EPFgHSt7Vhxj98uZbCWWNGzbiT5TE7CUzEVafirCh-Q>
    <xmx:5u0ZaAhBJDaBuH_rJzqqZ8OuYxiiYB4JTb86lylhhbBU2DJCqW0KaQ>
    <xmx:5u0ZaLp8IwT3tjjBoTK9jcPAn2eimWREhs9mhn5Ro5aLm_PGjfbccA>
    <xmx:5u0ZaLjIQF_cyoS8V2FVSgBTZjhDdafM_cHuafNViFsQo6UELBitgw>
    <xmx:5u0ZaDOeSs-iBO-jZbGJqA9fj3fEc-Q4kXOvYBu8RNsH5pwU7PTtBaoV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee6ff987 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:21 +0200
Subject: [PATCH 08/17] odb: get rid of `the_repository` when handling
 alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-8-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The functions to manage alternates all depend on `the_repository`.
Refactor them to accept an object database as parameter and adjusting
all callers. The functions are renamed accordingly.

Note that right now the situation is still somewhat weird because we end
up using the path provided by the object store's repository anyway. This
will be adapted over time though so that we instead store the path to
the primary object directory in the object database itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c           | 10 +++++----
 builtin/fsck.c            |  6 +++---
 builtin/grep.c            |  2 +-
 builtin/repack.c          |  3 ++-
 commit-graph.c            |  4 ++--
 loose.c                   |  2 +-
 object-file.c             | 10 ++++-----
 object-name.c             |  2 +-
 odb.c                     | 44 ++++++++++++++++++---------------------
 odb.h                     | 53 ++++++++++++++++++++++++++++++++---------------
 packfile.c                |  4 ++--
 submodule.c               |  3 ++-
 t/helper/test-ref-store.c |  2 +-
 tmp-objdir.c              |  2 +-
 14 files changed, 83 insertions(+), 64 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1eafeefb48d..3aabdf6570b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -171,7 +171,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	} else {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addf(&sb, "%s/objects", ref_git);
-		add_to_alternates_file(sb.buf);
+		odb_add_to_alternates_file(the_repository->objects, sb.buf);
 		strbuf_release(&sb);
 	}
 
@@ -212,12 +212,14 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
-			add_to_alternates_file(line.buf);
+			odb_add_to_alternates_file(the_repository->objects,
+						   line.buf);
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
 		if (!normalize_path_copy(abs_path, abs_path))
-			add_to_alternates_file(abs_path);
+			odb_add_to_alternates_file(the_repository->objects,
+						   abs_path);
 		else
 			warning("skipping invalid relative alternate: %s/%s",
 				src_repo, line.buf);
@@ -352,7 +354,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		struct strbuf alt = STRBUF_INIT;
 		get_common_dir(&alt, src_repo);
 		strbuf_addstr(&alt, "/objects");
-		add_to_alternates_file(alt.buf);
+		odb_add_to_alternates_file(the_repository->objects, alt.buf);
 		strbuf_release(&alt);
 	} else {
 		struct strbuf src = STRBUF_INIT;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 895c9ca5381..ffae00b1723 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1006,7 +1006,7 @@ int cmd_fsck(int argc,
 		for_each_packed_object(the_repository,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
-		prepare_alt_odb(the_repository);
+		odb_prepare_alternates(the_repository->objects);
 		for (backend = the_repository->objects->backends; backend; backend = backend->next)
 			fsck_object_dir(backend->path);
 
@@ -1117,7 +1117,7 @@ int cmd_fsck(int argc,
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-		prepare_alt_odb(the_repository);
+		odb_prepare_alternates(the_repository->objects);
 		for (backend = the_repository->objects->backends; backend; backend = backend->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
@@ -1135,7 +1135,7 @@ int cmd_fsck(int argc,
 	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
-		prepare_alt_odb(the_repository);
+		odb_prepare_alternates(the_repository->objects);
 		for (backend = the_repository->objects->backends; backend; backend = backend->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
diff --git a/builtin/grep.c b/builtin/grep.c
index 7b1940be2a1..610428e6298 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -462,7 +462,7 @@ static int grep_submodule(struct grep_opt *opt,
 
 	/*
 	 * NEEDSWORK: repo_read_gitmodules() might call
-	 * add_to_alternates_memory() via config_from_gitmodules(). This
+	 * odb_add_to_alternates_memory() via config_from_gitmodules(). This
 	 * operation causes a race condition with concurrent object readings
 	 * performed by the worker threads. That's why we need obj_read_lock()
 	 * here. It should be removed once it's no longer necessary to add the
diff --git a/builtin/repack.c b/builtin/repack.c
index 16782320058..8145474cf8d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1256,7 +1256,8 @@ int cmd_repack(int argc,
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
 
-	if (write_bitmaps && po_args.local && has_alt_odb(the_repository)) {
+	if (write_bitmaps && po_args.local &&
+	    odb_has_alternates(the_repository->objects)) {
 		/*
 		 * When asked to do a local repack, but we have
 		 * packfiles that are inherited from an alternate, then
diff --git a/commit-graph.c b/commit-graph.c
index d58d1bf39ed..ff72f7e32ae 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -649,7 +649,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	count = st->st_size / (the_hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 
 	for (i = 0; i < count; i++) {
 		struct odb_backend *backend;
@@ -778,7 +778,7 @@ static int prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return 0;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (backend = r->objects->backends;
 	     !r->objects->commit_graph && backend;
 	     backend = backend->next)
diff --git a/loose.c b/loose.c
index e52397bb3e5..dbeafe05c3b 100644
--- a/loose.c
+++ b/loose.c
@@ -112,7 +112,7 @@ int repo_read_loose_object_map(struct repository *repo)
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	prepare_alt_odb(repo);
+	odb_prepare_alternates(repo->objects);
 
 	for (backend = repo->objects->backends; backend; backend = backend->next) {
 		if (load_one_loose_object_map(repo, backend) < 0) {
diff --git a/object-file.c b/object-file.c
index cc81729ae25..c70a3fc317a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -106,7 +106,7 @@ static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
 	struct odb_backend *backend;
 
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
 		if (check_and_freshen_odb(backend, oid, freshen))
 			return 1;
@@ -211,7 +211,7 @@ static int stat_loose_object(struct repository *r, const struct object_id *oid,
 	struct odb_backend *backend;
 	static struct strbuf buf = STRBUF_INIT;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (backend = r->objects->backends; backend; backend = backend->next) {
 		*path = odb_loose_path(backend, &buf, oid);
 		if (!lstat(*path, st))
@@ -233,7 +233,7 @@ static int open_loose_object(struct repository *r,
 	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (backend = r->objects->backends; backend; backend = backend->next) {
 		*path = odb_loose_path(backend, &buf, oid);
 		fd = git_open(*path);
@@ -252,7 +252,7 @@ static int quick_has_loose(struct repository *r,
 {
 	struct odb_backend *backend;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (backend = r->objects->backends; backend; backend = backend->next) {
 		if (oidtree_contains(odb_loose_cache(backend, oid), oid))
 			return 1;
@@ -1542,7 +1542,7 @@ int for_each_loose_object(each_loose_object_fn cb, void *data,
 {
 	struct odb_backend *backend;
 
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 	for (backend = the_repository->objects->backends; backend; backend = backend->next) {
 		int r = for_each_loose_file_in_objdir(backend->path, cb, NULL,
 						      NULL, data);
diff --git a/object-name.c b/object-name.c
index b80791a9018..919a3e7a9f8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -376,7 +376,7 @@ static int init_object_disambiguation(struct repository *r,
 	ds->hex_pfx[len] = '\0';
 	ds->repo = r;
 	ds->bin_pfx.algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	return 0;
 }
 
diff --git a/odb.c b/odb.c
index 9bd87204737..229e048d573 100644
--- a/odb.c
+++ b/odb.c
@@ -272,10 +272,11 @@ static void read_info_alternates(struct object_database *odb,
 	free(path);
 }
 
-void add_to_alternates_file(const char *reference)
+void odb_add_to_alternates_file(struct object_database *odb,
+				const char *reference)
 {
 	struct lock_file lock = LOCK_INIT;
-	char *alts = repo_git_path(the_repository, "objects/info/alternates");
+	char *alts = repo_git_path(odb->repo, "objects/info/alternates");
 	FILE *in, *out;
 	int found = 0;
 
@@ -308,22 +309,23 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
-		if (the_repository->objects->loaded_alternates)
-			link_alt_odb_entries(the_repository->objects, reference,
+		if (odb->loaded_alternates)
+			link_alt_odb_entries(odb, reference,
 					     '\n', NULL, 0);
 	}
 	free(alts);
 }
 
-void add_to_alternates_memory(const char *reference)
+void odb_add_to_alternates_memory(struct object_database *odb,
+				  const char *reference)
 {
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(odb);
 
-	link_alt_odb_entries(the_repository->objects, reference,
+	link_alt_odb_entries(odb, reference,
 			     '\n', NULL, 0);
 }
 
@@ -335,7 +337,7 @@ struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
@@ -379,12 +381,6 @@ void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path)
 	free_object_directory(cur_odb);
 }
 
-/*
- * Compute the exact path an alternate is at and returns it. In case of
- * error NULL is returned and the human readable error is added to `err`
- * `path` may be relative and should point to $GIT_DIR.
- * `err` must not be null.
- */
 char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
@@ -455,7 +451,7 @@ struct odb_backend *odb_find_backend(struct object_database *odb, const char *ob
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	prepare_alt_odb(odb->repo);
+	odb_prepare_alternates(odb);
 	for (backend = odb->backends; backend; backend = backend->next) {
 		strbuf_realpath(&odb_path_real, backend->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
@@ -573,7 +569,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct odb_backend *backend;
 	int r = 0;
 
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
 		r = fn(backend, cb);
 		if (r)
@@ -582,21 +578,21 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(struct repository *r)
+void odb_prepare_alternates(struct object_database *odb)
 {
-	if (r->objects->loaded_alternates)
+	if (odb->loaded_alternates)
 		return;
 
-	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(odb, odb->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r->objects, r->objects->backends->path, 0);
-	r->objects->loaded_alternates = 1;
+	read_info_alternates(odb, odb->backends->path, 0);
+	odb->loaded_alternates = 1;
 }
 
-int has_alt_odb(struct repository *r)
+int odb_has_alternates(struct object_database *odb)
 {
-	prepare_alt_odb(r);
-	return !!r->objects->backends->next;
+	odb_prepare_alternates(odb);
+	return !!odb->backends->next;
 }
 
 int obj_read_use_lock = 0;
diff --git a/odb.h b/odb.h
index 62967da6cf6..2221af208ee 100644
--- a/odb.h
+++ b/odb.h
@@ -12,6 +12,14 @@ struct oidtree;
 struct strbuf;
 struct repository;
 
+/*
+ * Compute the exact path an alternate is at and returns it. In case of
+ * error NULL is returned and the human readable error is added to `err`
+ * `path` may be relative and should point to $GIT_DIR.
+ * `err` must not be null.
+ */
+char *compute_alternate_path(const char *path, struct strbuf *err);
+
 /* The backend used to access objects in a specific object directory. */
 struct odb_backend {
 	struct odb_backend *next;
@@ -53,27 +61,11 @@ struct odb_backend {
 	char *path;
 };
 
-void prepare_alt_odb(struct repository *r);
-int has_alt_odb(struct repository *r);
-char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct odb_backend *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
 void for_each_alternate_ref(alternate_ref_fn, void *);
 
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-void add_to_alternates_file(const char *dir);
-
-/*
- * Add the directory to the in-memory list of alternates (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-void add_to_alternates_memory(const char *dir);
-
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
@@ -112,7 +104,7 @@ struct object_database {
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will
-	 * populate the "backends" list when prepare_alt_odb() is run.
+	 * populate the "backends" list when odb_prepare_alternates() is run.
 	 */
 	char *alternate_db;
 
@@ -197,6 +189,33 @@ struct odb_backend *odb_find_backend(struct object_database *odb, const char *ob
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern);
 
+/*
+ * Prepare alternate object backends for the given database by reading
+ * "objects/info/alternates" and opening the respective backends.
+ */
+void odb_prepare_alternates(struct object_database *odb);
+
+/*
+ * Check whether the object database has any alternate backends. The primary
+ * object backend does not count as alternate.
+ */
+int odb_has_alternates(struct object_database *odb);
+
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+void odb_add_to_alternates_file(struct object_database *odb,
+				const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+void odb_add_to_alternates_memory(struct object_database *odb,
+				  const char *dir);
+
 void *repo_read_object_file(struct repository *r,
 			    const struct object_id *oid,
 			    enum object_type *type,
diff --git a/packfile.c b/packfile.c
index 0f3d60721a9..263056a6279 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1023,7 +1023,7 @@ static void prepare_packed_git(struct repository *r)
 	if (r->objects->packed_git_initialized)
 		return;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (backend = r->objects->backends; backend; backend = backend->next) {
 		int local = (backend == r->objects->backends);
 		prepare_multi_pack_index_one(r, backend->path, local);
@@ -1048,7 +1048,7 @@ void reprepare_packed_git(struct repository *r)
 	 * the lifetime of the process.
 	 */
 	r->objects->loaded_alternates = 0;
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 
 	for (backend = r->objects->backends; backend; backend = backend->next)
 		odb_clear_loose_cache(backend);
diff --git a/submodule.c b/submodule.c
index 9b1018877df..386be234230 100644
--- a/submodule.c
+++ b/submodule.c
@@ -189,7 +189,8 @@ int register_all_submodule_odb_as_alternates(void)
 	int ret = added_submodule_odb_paths.nr;
 
 	for (i = 0; i < added_submodule_odb_paths.nr; i++)
-		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
+		odb_add_to_alternates_memory(the_repository->objects,
+					     added_submodule_odb_paths.items[i].string);
 	if (ret) {
 		string_list_clear(&added_submodule_odb_paths, 0);
 		trace2_data_intmax("submodule", the_repository,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 2920ca59d72..8d9a271845c 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -79,7 +79,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 		if (!repo_submodule_path_append(the_repository,
 						&sb, gitdir, "objects/"))
 			die("computing submodule path failed");
-		add_to_alternates_memory(sb.buf);
+		odb_add_to_alternates_memory(the_repository->objects, sb.buf);
 		strbuf_release(&sb);
 
 		*refs = repo_get_submodule_ref_store(the_repository, gitdir);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index f9e8277fd7c..2982c646569 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -304,7 +304,7 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
-	add_to_alternates_memory(t->path.buf);
+	odb_add_to_alternates_memory(t->repo->objects, t->path.buf);
 }
 
 void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)

-- 
2.49.0.1045.g170613ef41.dirty

