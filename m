Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF03B6364
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278206; cv=none; b=j+CYQQVXErokD/BmkmT54iPrs76HP92bLkK+qwuSWk2Qm7nCHIJ0B0ccGNmwWDF8OyaS2Om5MWVCbDllxtiQpq+/CEK46DgR/j6egkDWNgfXbKXjmo/aKZoYrYQXJHMkUEixzNnHZaS3UIZlmBp/j2/5WnLbwTvghpopPWT6Vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278206; c=relaxed/simple;
	bh=aP8d1yRbQneRm8iOGhTsG7gpXAzUXjAgAft4uwpMaSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr6fehbdDevU0Mh3RX11UuGHFRxMIJWi5mjQpL01xKU5o/SgDH+6zVgEaf1GKKL2h+2dY9m99y6BRVrqwzxAS+QF7RWL8fugGgMpaK+k9X/7L7p12C+Mo8G1h0pTvbYUv4JswOQWEqsisi7oe605AQMhe6lMab1NXLRVTxxC2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J64lkDWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vJyaikfa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J64lkDWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vJyaikfa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED2FB7A010D;
	Mon, 23 Mar 2026 11:03:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278202;
	 x=1774364602; bh=xW+jKAzNecY4fZvIQ5rORm8mqaKA2YZZo5tTMjdrTTk=; b=
	J64lkDWLes3pCKMeqlL4CjYSxRWTWRiTIoA9enXwR3n7JdAqOVFx8vFlpetFmo6m
	ZtfN9wqbrKD98Z7P9Cc+nh0K1wSuJdmeK0gLGijLYW4dsoMdlzP6smoIIiDs+E6w
	feiAuLA2yKjsl2nRjcHzchXw1AkX/LLazZOByTpQ0slck4BNu4BfJh4uglAB9FB1
	E+C5Hdpk8ZUB3/hBoYCVk4fjdVd/EQYq6Ymt90EgtIR3CCHxGg6hNzEiZhcsambW
	MN64W+CHKn9Vp2zp+nSrBV/N505PkRAZDksC3UIHUtWpxA3/89LZ9BWoq/ruZgiQ
	hTG61cJwi1OT3XIICV9LvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278202; x=
	1774364602; bh=xW+jKAzNecY4fZvIQ5rORm8mqaKA2YZZo5tTMjdrTTk=; b=v
	JyaikfaLRmPNwFXrnn/jqE4GMPq0FgtHU+Y8+W/aK6EBTqigweAVSFXk883CjAL0
	equACjgfRKPPXqIDSCPoH5emYrpv0qOLbfxNGGX0ohOyxHmfUyHSE0vKeQe3bf1W
	M6V6BQVa++rAcH1pIpu17PPmctHIF1Vu3mvpvYm/Uv/zNDLEyEQlGqLz3XwtE4Rk
	mTxTzwuyPEWI6XQutSNq2DEJxR7PcoBbfYLyHBDsXi4UULV7tkuertyjfMoXnr/b
	SyWfBM2rQXoJkAsXdByJR3t5pC5Mt7aMeZk3BcjUnTjLeg7HwtRVL57ncQ9dKrIr
	o8zJ9i5EBqWHB03bIjwVQ==
X-ME-Sender: <xms:OlbBaf3RPf_d7LX5YovF8nDimucAw1C_GQEwVXopu0Y4lze3daNZPA>
    <xme:OlbBaUFWywtwvboT5mmqt9XN_QmfnUWCLjjjxgy6d068RoAjZAcaDt35gElNmzsqs
    8611vdun1FYTcRTdqhkqqBsUkW_FItKoWkUGZzNWCjqCJv-oJFINQ>
X-ME-Received: <xmr:OlbBadgVR8uOBJoEXxGkrLFGqEnGkGHTY3U43H1hKWZklsTp_ODJkX7Xj9QlcmtZctSJRq_FKkSrDe1Hfw5jrBKPEDPomx-_uygyuUIq-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OlbBaf-l3gXx8Neh7T5PlUL0dCckjFXopB8TCKPQVo_CVY5xrJcvyQ>
    <xmx:OlbBaUpFypuH7OE_OjAvVX7pB7-G9tXuMrsQ-7wIVpzAm7z0M0CvHg>
    <xmx:OlbBae_nL7kVIe9GPo6NL5SmTX_X8JPcHSjl2A4E87D4YC_P5fqHXw>
    <xmx:OlbBaYUtr9ExLmLWhxSiEFQWCe3FzAVFc3rA1F9IILzqcjyHzoBeTw>
    <xmx:OlbBabOiHCLa7Pk_fmcr2cDuG3KXGB-3IEj0lqNwO375Q4YUcI04Omi6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a364d00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:56 +0100
Subject: [PATCH v2 05/12] builtin/fsck: fix trivial dependence on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-5-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have a bunch of sites in "builtin/fsck.c" that depend on
`the_repository` even though we already have a repository available, or
in cases where we can trivially make it available.

Refactor such sites to use the context-provided repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 98 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 990d836918..59680e6daf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -195,13 +195,13 @@ static int traverse_one_object(struct object *obj)
 	return result;
 }
 
-static int traverse_reachable(void)
+static int traverse_reachable(struct repository *repo)
 {
 	struct progress *progress = NULL;
 	unsigned int nr = 0;
 	int result = 0;
 	if (show_progress)
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(repo,
 						  _("Checking connectivity"), 0);
 	while (pending.nr) {
 		result |= traverse_one_object(object_array_pop(&pending));
@@ -255,7 +255,7 @@ static int mark_unreachable_referents(const struct object_id *oid,
 /*
  * Check a single reachable object
  */
-static void check_reachable_object(struct object *obj)
+static void check_reachable_object(struct repository *repo, struct object *obj)
 {
 	/*
 	 * We obviously want the object to be parsed,
@@ -263,9 +263,9 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
-		if (is_promisor_object(the_repository, &obj->oid))
+		if (is_promisor_object(repo, &obj->oid))
 			return;
-		if (has_object_pack(the_repository, &obj->oid))
+		if (has_object_pack(repo, &obj->oid))
 			return; /* it is in pack - forget about it */
 		printf_ln(_("missing %s %s"),
 			  printable_type(&obj->oid, obj->type),
@@ -278,7 +278,7 @@ static void check_reachable_object(struct object *obj)
 /*
  * Check a single unreachable object
  */
-static void check_unreachable_object(struct object *obj)
+static void check_unreachable_object(struct repository *repo, struct object *obj)
 {
 	/*
 	 * Missing unreachable object? Ignore it. It's not like
@@ -318,19 +318,19 @@ static void check_unreachable_object(struct object *obj)
 				  printable_type(&obj->oid, obj->type),
 				  describe_object(&obj->oid));
 		if (write_lost_and_found) {
-			char *filename = repo_git_path(the_repository, "lost-found/%s/%s",
+			char *filename = repo_git_path(repo, "lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
 				describe_object(&obj->oid));
 			FILE *f;
 
-			if (safe_create_leading_directories_const(the_repository, filename)) {
+			if (safe_create_leading_directories_const(repo, filename)) {
 				error(_("could not create lost-found"));
 				free(filename);
 				return;
 			}
 			f = xfopen(filename, "w");
 			if (obj->type == OBJ_BLOB) {
-				if (odb_stream_blob_to_fd(the_repository->objects, fileno(f),
+				if (odb_stream_blob_to_fd(repo->objects, fileno(f),
 							  &obj->oid, NULL, 1))
 					die_errno(_("could not write '%s'"), filename);
 			} else
@@ -350,23 +350,23 @@ static void check_unreachable_object(struct object *obj)
 	 */
 }
 
-static void check_object(struct object *obj)
+static void check_object(struct repository *repo, struct object *obj)
 {
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
 
 	if (obj->flags & REACHABLE)
-		check_reachable_object(obj);
+		check_reachable_object(repo, obj);
 	else
-		check_unreachable_object(obj);
+		check_unreachable_object(repo, obj);
 }
 
-static void check_connectivity(void)
+static void check_connectivity(struct repository *repo)
 {
 	int i, max;
 
 	/* Traverse the pending reachable objects */
-	traverse_reachable();
+	traverse_reachable(repo);
 
 	/*
 	 * With --connectivity-only, we won't have actually opened and marked
@@ -384,20 +384,20 @@ static void check_connectivity(void)
 		 * and ignore any that weren't present in our earlier
 		 * traversal.
 		 */
-		odb_for_each_object(the_repository->objects, NULL,
+		odb_for_each_object(repo->objects, NULL,
 				    mark_unreachable_referents, NULL, 0);
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
-	max = get_max_object_index(the_repository);
+	max = get_max_object_index(repo);
 	if (verbose)
 		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
 
 	for (i = 0; i < max; i++) {
-		struct object *obj = get_indexed_object(the_repository, i);
+		struct object *obj = get_indexed_object(repo, i);
 
 		if (obj)
-			check_object(obj);
+			check_object(repo, obj);
 	}
 }
 
@@ -770,7 +770,7 @@ static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *data)
 	return 0;
 }
 
-static void fsck_source(struct odb_source *source)
+static void fsck_source(struct repository *repo, struct odb_source *source)
 {
 	struct progress *progress = NULL;
 	struct for_each_loose_cb cb_data = {
@@ -781,7 +781,7 @@ static void fsck_source(struct odb_source *source)
 		fprintf_ln(stderr, _("Checking object directory"));
 
 	if (show_progress)
-		progress = start_progress(the_repository,
+		progress = start_progress(repo,
 					  _("Checking object directories"), 256);
 
 	for_each_loose_file_in_source(source, fsck_loose,
@@ -790,7 +790,7 @@ static void fsck_source(struct odb_source *source)
 	stop_progress(&progress);
 }
 
-static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
+static int fsck_cache_tree(struct repository *repo, struct cache_tree *it, const char *index_path)
 {
 	int i;
 	int err = 0;
@@ -799,7 +799,7 @@ static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 		fprintf_ln(stderr, _("Checking cache tree of %s"), index_path);
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(the_repository, &it->oid);
+		struct object *obj = parse_object(repo, &it->oid);
 		if (!obj) {
 			error(_("%s: invalid sha1 pointer in cache-tree of %s"),
 			      oid_to_hex(&it->oid), index_path);
@@ -813,7 +813,7 @@ static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 			err |= objerror(obj, _("non-tree in cache-tree"));
 	}
 	for (i = 0; i < it->subtree_nr; i++)
-		err |= fsck_cache_tree(it->down[i]->cache_tree, index_path);
+		err |= fsck_cache_tree(repo, it->down[i]->cache_tree, index_path);
 	return err;
 }
 
@@ -839,7 +839,7 @@ static int fsck_resolve_undo(struct index_state *istate,
 			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
 				continue;
 
-			obj = parse_object(the_repository, &ru->oid[i]);
+			obj = parse_object(istate->repo, &ru->oid[i]);
 			if (!obj) {
 				error(_("%s: invalid sha1 pointer in resolve-undo of %s"),
 				      oid_to_hex(&ru->oid[i]),
@@ -871,7 +871,7 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 		mode = istate->cache[i]->ce_mode;
 		if (S_ISGITLINK(mode))
 			continue;
-		blob = lookup_blob(the_repository,
+		blob = lookup_blob(istate->repo,
 				   &istate->cache[i]->oid);
 		if (!blob)
 			continue;
@@ -884,7 +884,7 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 		mark_object_reachable(obj);
 	}
 	if (istate->cache_tree)
-		fsck_cache_tree(istate->cache_tree, index_path);
+		fsck_cache_tree(istate->repo, istate->cache_tree, index_path);
 	fsck_resolve_undo(istate, index_path);
 }
 
@@ -907,7 +907,7 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	if (show_progress) {
 		repo_for_each_pack(r, p)
 			pack_count++;
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(r,
 						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
@@ -1027,11 +1027,11 @@ int cmd_fsck(int argc,
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	repo_config(the_repository, git_fsck_config, &fsck_obj_options);
-	prepare_repo_settings(the_repository);
+	repo_config(repo, git_fsck_config, &fsck_obj_options);
+	prepare_repo_settings(repo);
 
 	if (check_references)
-		fsck_refs(the_repository);
+		fsck_refs(repo);
 
 	/*
 	 * Take a snapshot of the refs before walking objects to avoid looking
@@ -1042,15 +1042,15 @@ int cmd_fsck(int argc,
 	snapshot_refs(&snap, argc, argv);
 
 	/* Ensure we get a "fresh" view of the odb */
-	odb_reprepare(the_repository->objects);
+	odb_reprepare(repo->objects);
 
 	if (connectivity_only) {
-		odb_for_each_object(the_repository->objects, NULL,
+		odb_for_each_object(repo->objects, NULL,
 				    mark_object_for_connectivity, NULL, 0);
 	} else {
-		odb_prepare_alternates(the_repository->objects);
-		for (source = the_repository->objects->sources; source; source = source->next)
-			fsck_source(source);
+		odb_prepare_alternates(repo->objects);
+		for (source = repo->objects->sources; source; source = source->next)
+			fsck_source(repo, source);
 
 		if (check_full) {
 			struct packed_git *p;
@@ -1058,19 +1058,19 @@ int cmd_fsck(int argc,
 			struct progress *progress = NULL;
 
 			if (show_progress) {
-				repo_for_each_pack(the_repository, p) {
+				repo_for_each_pack(repo, p) {
 					if (open_pack_index(p))
 						continue;
 					total += p->num_objects;
 				}
 
-				progress = start_progress(the_repository,
+				progress = start_progress(repo,
 							  _("Checking objects"), total);
 			}
 
-			repo_for_each_pack(the_repository, p) {
+			repo_for_each_pack(repo, p) {
 				/* verify gives error messages itself */
-				if (verify_pack(the_repository,
+				if (verify_pack(repo,
 						p, fsck_obj_buffer,
 						progress, count))
 					errors_found |= ERROR_PACK;
@@ -1104,7 +1104,7 @@ int cmd_fsck(int argc,
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 			struct index_state istate =
-				INDEX_STATE_INIT(the_repository);
+				INDEX_STATE_INIT(repo);
 			char *path, *wt_gitdir;
 
 			/*
@@ -1125,17 +1125,17 @@ int cmd_fsck(int argc,
 		free_worktrees(worktrees);
 	}
 
-	errors_found |= check_pack_rev_indexes(the_repository, show_progress);
-	if (verify_bitmap_files(the_repository))
+	errors_found |= check_pack_rev_indexes(repo, show_progress);
+	if (verify_bitmap_files(repo))
 		errors_found |= ERROR_BITMAP;
 
-	check_connectivity();
+	check_connectivity(repo);
 
-	if (the_repository->settings.core_commit_graph) {
+	if (repo->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-		odb_prepare_alternates(the_repository->objects);
-		for (source = the_repository->objects->sources; source; source = source->next) {
+		odb_prepare_alternates(repo->objects);
+		for (source = repo->objects->sources; source; source = source->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
@@ -1149,11 +1149,11 @@ int cmd_fsck(int argc,
 		}
 	}
 
-	if (the_repository->settings.core_multi_pack_index) {
+	if (repo->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
-		odb_prepare_alternates(the_repository->objects);
-		for (source = the_repository->objects->sources; source; source = source->next) {
+		odb_prepare_alternates(repo->objects);
+		for (source = repo->objects->sources; source; source = source->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
 			strvec_pushl(&midx_verify.args, "multi-pack-index",

-- 
2.53.0.1118.gaef5881109.dirty

