Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD46314B73
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007282; cv=none; b=rFi0CipqOGHtuF8Ph9juhkS546zzMpKzR9TGlvhZlfonTN/1A9pi8/ilmAeDAGU8X+4MfoP4NC64O3aeMwRVjBK+UEGkHyW/Ifx9tUC2PsoPX9pnpIf1HEbbWJeeND+cQ0s+/N8gE5m/nMEItacwWhRBJvVAl6fmGjXIS/Skan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007282; c=relaxed/simple;
	bh=wUJaStlAR20FjDtkPVn4m/UCpFL9yMPYJWaX7CiYcdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeQxhTOumIqK7fFh+alAdWXRgDN3cAd2s1LGfODK7xCCSsRd8GwgQNP9qN3aMZJMRGyARy5ZbGP70pXUHWbPi0FW2YknGK14UielZYElCSff/LCDS35AhxHRiOLG106NoKD6PYqyF1mjl+sn9NqV5tv3rW6NB8IrRVjkpr9Vcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GTbddlGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iq4WKliX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GTbddlGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iq4WKliX"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53CB4140017C
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 07:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007280;
	 x=1774093680; bh=Tnt2tbMbd07e9evVe/7EK430fncLe9AOzuCoOVYDj0g=; b=
	GTbddlGKletKVpl9MX1giLSaCRhbqeYWEmiiLDjXDfv3R3E6+DF7eLHhs8TwV7i8
	BZgfovQAzSBTHY8nTYHUQZ2NBNpVYaBxKgGvNMilRsDLCB66Lcvd+bZCn9KlKuAb
	RlzHChAgv+r+R8x/saRuRu1v6gGl191TrTTziDPFwYQ4ZaQ69F/Mp28wrzO/qFDP
	ih04KboqN2I5jXhkWtrmw2CKqX5qOijiOFPUdzgZ2sVfl/uW/EtCL/6h+BlnoGjF
	kU5OIxInQOdHT57HZRh6QU1Su98Hc6itTIPkSF/ttnb6rpSuGV/ADfs/DmJy+HkC
	tIQpHevBRpf1Lz8IgEhW/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007280; x=
	1774093680; bh=Tnt2tbMbd07e9evVe/7EK430fncLe9AOzuCoOVYDj0g=; b=i
	q4WKliXNM1iEEu8jsWqfPEfszp6MvAooX6WveT48n5vWXxsRwpO40v2V0W/I42Es
	PXqvSmt97CO99NiBlys4a+W3r76capzkIydrnla/v7aOKmWa3MHW8HAotpw43Zl8
	zJWcvyWrKf0IdUAOrHWGdQU1X26PTVlY5V8SFcfpMgVJ1OMiZHpmOa0hNB6cxAN4
	fntJCR3hlu0k9eR7lO6KiCrIp36+bNBGT9o3117WGXnopfPrRH9JMNnFiGiRFvZU
	tmGaa5scqVzGqsh5I1RoU7dnG7ylBc4miqvIjFgKd+UEAElQA5nSVyC43vUFqL/c
	WNPDSFPd+sUNQTGcUh6sQ==
X-ME-Sender: <xms:8DO9aS6JLdxvpmmWPbK_GrlY3aYjlHYRT_0jJat28QDVmrDnt9cIqA>
    <xme:8DO9aS3Rqqk8jtN8sySuHrUuhigfNkwUcdUngxsbu1YKicLLuhOe6wxcgwHCuo2wi
    rTGu5r2PHfI18v3Hr4H3iDnvalbIa4Qds_d-TW0QECVdm7paDiwsA>
X-ME-Received: <xmr:8DO9aXHpRw1MmacAmtyZyOtqE114J961rVNWmP4mXZ4gfBNPK7Hfw-zOeZ63nAiTamPf9AO34gDvJF0H0ONvZqmh7MvxoSEwGPxL___F8rx1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:8DO9aURs-91KlvCBw07CgJxONjlfVs1-UNSWwF_SrjHxnbrMz6lscg>
    <xmx:8DO9aWAmJ88V0-JURt5WCCssnX7-8gLzh0prquekCB91i-_sweljdA>
    <xmx:8DO9ac2DUMIAr-JyINkB2vi7OMf5sHse-rmWzAiR0FmwIBzKABZ2dA>
    <xmx:8DO9acVVrWjgeHjR8xCZWR6yimWISIKt5H2SIDqfgode-jW8_U5r5Q>
    <xmx:8DO9abZUc0RjnfYbq7B8Nc2gW1XdKtxLuTa7CoYU-TB8e-kGGQziR-XI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20bb9999 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:11 +0100
Subject: [PATCH 06/14] builtin/fsck: fix trivial dependence on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-6-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We have a bunch of sites in "builtin/fsck.c" that depend on
`the_repository` even though we already have a repository available, or
in cases where we can trivially make it available.

Refactor such sites to use the context-provided repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 116 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 57 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ff9951c10c..8a52ad02ae 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -184,9 +184,9 @@ static void mark_object_reachable(struct object *obj)
 	mark_object(obj, OBJ_ANY, NULL, NULL);
 }
 
-static int traverse_one_object(struct object *obj)
+static int traverse_one_object(struct repository *repo, struct object *obj)
 {
-	int result = fsck_walk(the_repository, obj, obj, &fsck_walk_options);
+	int result = fsck_walk(repo, obj, obj, &fsck_walk_options);
 
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
@@ -195,16 +195,16 @@ static int traverse_one_object(struct object *obj)
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
-		result |= traverse_one_object(object_array_pop(&pending));
+		result |= traverse_one_object(repo, object_array_pop(&pending));
 		display_progress(progress, ++nr);
 	}
 	stop_progress(&progress);
@@ -254,7 +254,7 @@ static int mark_unreachable_referents(const struct object_id *oid,
 /*
  * Check a single reachable object
  */
-static void check_reachable_object(struct object *obj)
+static void check_reachable_object(struct repository *repo, struct object *obj)
 {
 	/*
 	 * We obviously want the object to be parsed,
@@ -262,9 +262,9 @@ static void check_reachable_object(struct object *obj)
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
@@ -277,7 +277,7 @@ static void check_reachable_object(struct object *obj)
 /*
  * Check a single unreachable object
  */
-static void check_unreachable_object(struct object *obj)
+static void check_unreachable_object(struct repository *repo, struct object *obj)
 {
 	/*
 	 * Missing unreachable object? Ignore it. It's not like
@@ -317,19 +317,19 @@ static void check_unreachable_object(struct object *obj)
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
@@ -349,23 +349,23 @@ static void check_unreachable_object(struct object *obj)
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
@@ -383,20 +383,20 @@ static void check_connectivity(void)
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
 
@@ -580,7 +580,8 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 	return 0;
 }
 
-static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
+static void snapshot_refs(struct repository *repo, struct snapshot *snap,
+			  int argc, const char **argv)
 {
 	struct refs_for_each_ref_options opts = {
 		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
@@ -592,7 +593,7 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 	for (int i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		struct object_id oid;
-		if (!repo_get_oid(the_repository, arg, &oid)) {
+		if (!repo_get_oid(repo, arg, &oid)) {
 			struct reference ref = {
 				.name = arg,
 				.oid = &oid,
@@ -610,7 +611,7 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 		return;
 	}
 
-	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+	refs_for_each_ref_ext(get_main_ref_store(repo),
 			      snapshot_ref, snap, &opts);
 
 	worktrees = get_worktrees();
@@ -620,7 +621,7 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 
 		strbuf_worktree_ref(wt, &refname, "HEAD");
 
-		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(repo),
 							 refname.buf, 0, &head_oid, NULL);
 
 		if (head_points_at && !is_null_oid(&head_oid)) {
@@ -780,7 +781,7 @@ static void fsck_source(struct odb_source *source)
 		fprintf_ln(stderr, _("Checking object directory"));
 
 	if (show_progress)
-		progress = start_progress(the_repository,
+		progress = start_progress(source->odb->repo,
 					  _("Checking object directories"), 256);
 
 	for_each_loose_file_in_source(source, fsck_loose,
@@ -789,7 +790,8 @@ static void fsck_source(struct odb_source *source)
 	stop_progress(&progress);
 }
 
-static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
+static int fsck_cache_tree(struct repository *repo, struct cache_tree *it,
+			   const char *index_path)
 {
 	int i;
 	int err = 0;
@@ -798,7 +800,7 @@ static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 		fprintf_ln(stderr, _("Checking cache tree of %s"), index_path);
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(the_repository, &it->oid);
+		struct object *obj = parse_object(repo, &it->oid);
 		if (!obj) {
 			error(_("%s: invalid sha1 pointer in cache-tree of %s"),
 			      oid_to_hex(&it->oid), index_path);
@@ -812,7 +814,7 @@ static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 			err |= objerror(obj, _("non-tree in cache-tree"));
 	}
 	for (i = 0; i < it->subtree_nr; i++)
-		err |= fsck_cache_tree(it->down[i]->cache_tree, index_path);
+		err |= fsck_cache_tree(repo, it->down[i]->cache_tree, index_path);
 	return err;
 }
 
@@ -838,7 +840,7 @@ static int fsck_resolve_undo(struct index_state *istate,
 			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
 				continue;
 
-			obj = parse_object(the_repository, &ru->oid[i]);
+			obj = parse_object(istate->repo, &ru->oid[i]);
 			if (!obj) {
 				error(_("%s: invalid sha1 pointer in resolve-undo of %s"),
 				      oid_to_hex(&ru->oid[i]),
@@ -870,7 +872,7 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 		mode = istate->cache[i]->ce_mode;
 		if (S_ISGITLINK(mode))
 			continue;
-		blob = lookup_blob(the_repository,
+		blob = lookup_blob(istate->repo,
 				   &istate->cache[i]->oid);
 		if (!blob)
 			continue;
@@ -883,7 +885,7 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 		mark_object_reachable(obj);
 	}
 	if (istate->cache_tree)
-		fsck_cache_tree(istate->cache_tree, index_path);
+		fsck_cache_tree(istate->repo, istate->cache_tree, index_path);
 	fsck_resolve_undo(istate, index_path);
 }
 
@@ -906,7 +908,7 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	if (show_progress) {
 		repo_for_each_pack(r, p)
 			pack_count++;
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(r,
 						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
@@ -986,7 +988,7 @@ static struct option fsck_opts[] = {
 int cmd_fsck(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     struct repository *repo)
 {
 	struct odb_source *source;
 	struct snapshot snap = {
@@ -1023,11 +1025,11 @@ int cmd_fsck(int argc,
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	fsck_options_parse_config(&fsck_obj_options, the_repository);
-	prepare_repo_settings(the_repository);
+	fsck_options_parse_config(&fsck_obj_options, repo);
+	prepare_repo_settings(repo);
 
 	if (check_references)
-		fsck_refs(the_repository);
+		fsck_refs(repo);
 
 	/*
 	 * Take a snapshot of the refs before walking objects to avoid looking
@@ -1035,17 +1037,17 @@ int cmd_fsck(int argc,
 	 * objects. We can still walk over new objects that are added during the
 	 * execution of fsck but won't miss any objects that were reachable.
 	 */
-	snapshot_refs(&snap, argc, argv);
+	snapshot_refs(repo, &snap, argc, argv);
 
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
+		odb_prepare_alternates(repo->objects);
+		for (source = repo->objects->sources; source; source = source->next)
 			fsck_source(source);
 
 		if (check_full) {
@@ -1054,19 +1056,19 @@ int cmd_fsck(int argc,
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
@@ -1075,7 +1077,7 @@ int cmd_fsck(int argc,
 			stop_progress(&progress);
 		}
 
-		if (fsck_finish(the_repository, &fsck_obj_options))
+		if (fsck_finish(repo, &fsck_obj_options))
 			errors_found |= ERROR_OBJECT;
 	}
 
@@ -1100,7 +1102,7 @@ int cmd_fsck(int argc,
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 			struct index_state istate =
-				INDEX_STATE_INIT(the_repository);
+				INDEX_STATE_INIT(repo);
 			char *path, *wt_gitdir;
 
 			/*
@@ -1121,17 +1123,17 @@ int cmd_fsck(int argc,
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
@@ -1145,11 +1147,11 @@ int cmd_fsck(int argc,
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
2.53.0.1055.ga2ffed1127.dirty

