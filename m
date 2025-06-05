Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB51FE44B
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106028; cv=none; b=rFfP0eR3lip1nwE/vtHwzKDuSSzZRCKNYdtLTIqJznRXQrPw4yDHK9vLsApVQI+AKQ4q1F879TogR6z51pmXG8ZlpS4PIXOgLUgevvbaHXd0yCasMTXfA+ZaYNqSa1nyad/HuAaMl8OCrXQbLHlX66kbRu1gaiBwhCOSuSEicPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106028; c=relaxed/simple;
	bh=QXBAw06wFI9Me7HARVajL6LM4yT3Gjy4SBZM7kKNftw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STTxfOOk35nGt8R8NKX8AAIhB0M+KN/k+Z2XSAzjnpPbihkb7iob/VWq7m4sfQd7SM6x9pfFmPd8r2SB8S0IhyTlbe+ifACu0u1ew6ntu3z78rg3qzcpU4cMe1Ci7YPVNd8J4M5sAjN1kZEE4nIHJ6kGh5bva+SypcqhMJhogr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gzxR6p11; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OG77dYOW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gzxR6p11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OG77dYOW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8646A11400E0;
	Thu,  5 Jun 2025 02:47:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 02:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106025;
	 x=1749192425; bh=4RnAyy0QpfGuHeqoTJ83vfKpMPVGP4dtYpbD38XdAwk=; b=
	gzxR6p11GYhbfngqbNHSpMEGJCp4D3qXT7RtCNJ8yQOHGqyNcEvFPPZImxHD/mrk
	hjXTdo5RjXH9ECyXFw/816naP2udtc6Q++hOVvhyWenSzqO6WMu6xBXD+LuqMZkF
	pMKDm9pwmTcDDrOnAlrEZtdK+8pg+oiRFxdkbWMWsBqW24Y8i7XypySiR3wLNhkJ
	Y6zKMjVCHSr9hYmJZ0lvaTqdoHDzh6nmc6vXTDRfiflkw1VspG5rFx6pJw4silEo
	48yt6pAW29GPpfQzKACl548GaM6/fW9MzdIDFvOUsZTbJec3VyCDk69/6HqY8+m7
	uWf/qpWc/m8z5qkhBKjG2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106025; x=
	1749192425; bh=4RnAyy0QpfGuHeqoTJ83vfKpMPVGP4dtYpbD38XdAwk=; b=O
	G77dYOWCTXHcDRQ3XyVJoAwKBmszCOxDtKA/GSi14WwUJ/LrbP/fWhW4Kt4lFS4X
	rSun5oO1RlfRkQean76K+JiC7S0Xbrd0zZ+QgwqWGkBTJ5yuYpWJaE4E1wRkJO25
	6YEP7zsfemq287VzIGAc01rlrK2EUgQNPDyPEe0aemsfcprohsW7xn2n5bjk9V/t
	FFEUYTDfiPC2WRwF/hf6orLEGqOGTfaNr0aq81lcQn+oBQr6Ye1ZR9MTOwIU9/1h
	7vMPB3s/A4ZyhZTXuhzjL0knRpufDACOkTg6DaMC6W4G+pFDxruvPFST/OdJuOE0
	SkFcdZNu0wc6m3gFTW++A==
X-ME-Sender: <xms:aT1BaL_aqIFXtNdRnwNeFCiOOxj5AnzQpfkJtHocr3v1rgSbxX9-qg>
    <xme:aT1BaHvZdnuv9juGT5KOCrWy4s7TJchhMJ5QDMjuTNr6qGRM9j4aM79gDKtdpwN4c
    fWsx4tGjtEhrohf3w>
X-ME-Received: <xmr:aT1BaJBzw3eST84WQ12p2YVMDwhxlrSdZwWXKw_Nh-etzKbwwuq4m3EqW5I7euwKicXncfYOl-y5hmiR2mVWuCsmCzj2LiYKwtXxIYo2bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:aT1BaHcAr0XCAFQxBeT5A7_JwTsFimkap3kayL63y3Db8d_h1er0CQ>
    <xmx:aT1BaAPh5cGfYgYlsASLZItZoVB0AY9WJOSqdjysJYvayEudPg5RPA>
    <xmx:aT1BaJkctKBG6WChG_oTpFs3GIOpKbQSpM9PAJAmuCwrd_E6WzQmgQ>
    <xmx:aT1BaKs0C7xgqvVHJ2hkMsONDhffVweN68bfkP1_6hXOtO5aRi_F1w>
    <xmx:aT1BaBHmuEj-U2ZMXQnarl9Ryhh1YmByZjfA2-uD78u1mF7Dkr57d8c8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 029ad569 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:58 +0200
Subject: [PATCH v5 08/17] odb: get rid of `the_repository` when handling
 alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-8-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
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
index 9abd7b25580..014aa1344e2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -997,7 +997,7 @@ int cmd_fsck(int argc,
 		for_each_packed_object(the_repository,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
-		prepare_alt_odb(the_repository);
+		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next)
 			fsck_object_dir(source->path);
 
@@ -1108,7 +1108,7 @@ int cmd_fsck(int argc,
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-		prepare_alt_odb(the_repository);
+		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
@@ -1126,7 +1126,7 @@ int cmd_fsck(int argc,
 	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
-		prepare_alt_odb(the_repository);
+		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
diff --git a/builtin/grep.c b/builtin/grep.c
index a1d7ee7af39..336cfcab6fb 100644
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
index 6ced5b366e7..59265f89385 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -649,7 +649,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	count = st->st_size / (the_hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 
 	for (i = 0; i < count; i++) {
 		struct odb_source *source;
@@ -778,7 +778,7 @@ static int prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return 0;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources;
 	     !r->objects->commit_graph && source;
 	     source = source->next)
diff --git a/loose.c b/loose.c
index fab4041c03d..519f5db7935 100644
--- a/loose.c
+++ b/loose.c
@@ -112,7 +112,7 @@ int repo_read_loose_object_map(struct repository *repo)
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	prepare_alt_odb(repo);
+	odb_prepare_alternates(repo->objects);
 
 	for (source = repo->objects->sources; source; source = source->next) {
 		if (load_one_loose_object_map(repo, source) < 0) {
diff --git a/object-file.c b/object-file.c
index 2d3af8a77c0..04da19a1a3b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -106,7 +106,7 @@ static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
 	struct odb_source *source;
 
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 	for (source = the_repository->objects->sources->next; source; source = source->next) {
 		if (check_and_freshen_odb(source, oid, freshen))
 			return 1;
@@ -205,7 +205,7 @@ static int stat_loose_object(struct repository *r, const struct object_id *oid,
 	struct odb_source *source;
 	static struct strbuf buf = STRBUF_INIT;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		*path = odb_loose_path(source, &buf, oid);
 		if (!lstat(*path, st))
@@ -227,7 +227,7 @@ static int open_loose_object(struct repository *r,
 	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		*path = odb_loose_path(source, &buf, oid);
 		fd = git_open(*path);
@@ -246,7 +246,7 @@ static int quick_has_loose(struct repository *r,
 {
 	struct odb_source *source;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		if (oidtree_contains(odb_loose_cache(source, oid), oid))
 			return 1;
@@ -1439,7 +1439,7 @@ int for_each_loose_object(each_loose_object_fn cb, void *data,
 {
 	struct odb_source *source;
 
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		int r = for_each_loose_file_in_objdir(source->path, cb, NULL,
 						      NULL, data);
diff --git a/object-name.c b/object-name.c
index 544634d0f40..381536e900e 100644
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
index 73410920a88..42862ef7fe7 100644
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
 
@@ -335,7 +337,7 @@ struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
@@ -379,12 +381,6 @@ void restore_primary_odb(struct odb_source *restore_alt, const char *old_path)
 	free_object_directory(cur_alt);
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
@@ -455,7 +451,7 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	prepare_alt_odb(odb->repo);
+	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
 		strbuf_realpath(&odb_path_real, source->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
@@ -573,7 +569,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct odb_source *alternate;
 	int r = 0;
 
-	prepare_alt_odb(the_repository);
+	odb_prepare_alternates(the_repository->objects);
 	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
 		r = fn(alternate, cb);
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
 
-	read_info_alternates(r->objects, r->objects->sources->path, 0);
-	r->objects->loaded_alternates = 1;
+	read_info_alternates(odb, odb->sources->path, 0);
+	odb->loaded_alternates = 1;
 }
 
-int has_alt_odb(struct repository *r)
+int odb_has_alternates(struct object_database *odb)
 {
-	prepare_alt_odb(r);
-	return !!r->objects->sources->next;
+	odb_prepare_alternates(odb);
+	return !!odb->sources->next;
 }
 
 int obj_read_use_lock = 0;
diff --git a/odb.h b/odb.h
index 5de952608f3..eba16929a81 100644
--- a/odb.h
+++ b/odb.h
@@ -13,6 +13,14 @@ struct oidtree;
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
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -65,27 +73,11 @@ struct odb_source {
 	char *path;
 };
 
-void prepare_alt_odb(struct repository *r);
-int has_alt_odb(struct repository *r);
-char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct odb_source *, void *);
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
@@ -124,7 +116,7 @@ struct object_database {
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will
-	 * populate the "sources" list when prepare_alt_odb() is run.
+	 * populate the "sources" list when odb_prepare_alternates() is run.
 	 */
 	char *alternate_db;
 
@@ -209,6 +201,33 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern);
 
+/*
+ * Prepare alternate object sources for the given database by reading
+ * "objects/info/alternates" and opening the respective sources.
+ */
+void odb_prepare_alternates(struct object_database *odb);
+
+/*
+ * Check whether the object database has any alternates. The primary object
+ * source does not count as alternate.
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
+ * Add the directory to the in-memory list of alternate sources (along with any
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
index 346c2f9ce90..ac0e29e99b9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1034,7 +1034,7 @@ static void prepare_packed_git(struct repository *r)
 	if (r->objects->packed_git_initialized)
 		return;
 
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		int local = (source == r->objects->sources);
 		prepare_multi_pack_index_one(r, source->path, local);
@@ -1059,7 +1059,7 @@ void reprepare_packed_git(struct repository *r)
 	 * the lifetime of the process.
 	 */
 	r->objects->loaded_alternates = 0;
-	prepare_alt_odb(r);
+	odb_prepare_alternates(r->objects);
 
 	for (source = r->objects->sources; source; source = source->next)
 		odb_clear_loose_cache(source);
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
index bef2f917cd2..4120badf5ce 100644
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
2.50.0.rc1.591.g9c95f17f64.dirty

