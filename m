Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EC3B2FE9
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278194; cv=none; b=sFgnIjRj/JpYkgNYYmmhEQ4CXLGPDjusiTgugsVr+EskW4TNbqTh86dbX0Cf1wpJaBqbVs9Y9n9hmncCeTzasi92gduzoXz1MEDQAZzvK6wEr9iNdHAHFybHgM8x7O8avYhWZSo3941FHNK83GhVKcgj7iYupBx/KM32divg+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278194; c=relaxed/simple;
	bh=HGcLOKoMe+5kNaZRwlvXavNsK3TU50G8ZFo0LnNXQqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DrcuOUKJgD4CPtEUUPweUBjLRspVDJrLZ8yGW/AWUS1tcMDpB9NYPmecgHUb6+VNan8hrftT/7GGiBmMKPRZvZ+dtV7fDXnvfaB7FwjG8MlePX+RnHKFYjb1F7Hn9rU5/DGrTVjJBPbCRzZX7T/OxvT9g+D9q01SqYi85Ml5MfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dpIFM3kP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJAFpbCx; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dpIFM3kP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJAFpbCx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 242307A0087;
	Mon, 23 Mar 2026 11:03:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 11:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278190;
	 x=1774364590; bh=qAoleExSLrAOfp7H9+FT6NVAnPxYV9wa/v7ByO61Xmo=; b=
	dpIFM3kPv7bA29gEkohLfgjD4/5Q17ozNYE/qDD9yTKE0xlo/RE4jLQNFesP4TlB
	3vX3PbW/yYhXLE+C/5MolAbdyAKn47QhPG37Rx+y1DTKg4zwsRlQGPEuhMczx2QN
	r77UU/LLLxS8M9Py+VVvd68q+yJiRCAabIgNiJT89LkkI4DlGQqiW8brL/u4+6yE
	m6zA8mxf7YowIggid7xpn2HSyrMHeZapmzNeaW48oYyFaENcRLcjchWIVR5qf9Yz
	V7I1WVePiR3CuJQYY+flWfwUrgRP5bBNkt03wI8d0Q9rCEd8DiTyq5k6XlEiKSAx
	VAWAHlMipGaKwydzpVLfEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278190; x=
	1774364590; bh=qAoleExSLrAOfp7H9+FT6NVAnPxYV9wa/v7ByO61Xmo=; b=O
	JAFpbCxxxeOJzezuq1oj6QPl6LTZzJstDarFTY2XoTY/EjNBBv+lBRor5WL3OiSO
	NYRV6mFO5GmPAxZt6n5xv5tJ0die+SVAAv9qyUjvVZ4lwXoiqhYe606qrplQk2T5
	C6Ehg6GlCcS8vStnsNTeWcDMCkKM4UEQzIAR9AU2MVq7ZBDW12T/aL7nwKQpfK+n
	5CkwIo6/PpaQhS+vXEJ92hs3ENjDj/Qkz+K6ckmHlUPIzOXzibQGEI9lEp/y4JAb
	xPgoVl5m/QAu6x6bXWMH+4UcpzFOD7A/BTnLi2p+uD4tMe5FlLY2rTzPKI5CbMIL
	Y3kCE6BNHr+8Z5NgUjKaQ==
X-ME-Sender: <xms:LlbBaTTwGGrN41PJPN_wmJAq5Dm5YKsDBILR1yAIUp_bv5CkRfBa8w>
    <xme:LlbBaayd8PTgTP7kK2E9JYB6Bz-lCndYrn73ncOS2uP0K5y8BhM9SUXuqK6_00N1T
    KEa3JYyxl2YMiDZjiLk0E3F6RHHPCOpvHZGF2SejA-2jYxR063-Kg>
X-ME-Received: <xmr:LlbBaWeg9C6xCxhwb1goCMrJEH4pkytqu0waZF6YpBmIICLW0PHLRnJ7qBf7bE_jc-qFUj0RfMkKSv8xDwbrvktwtlNjuTFpZJ7YdhyDxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtud
    ehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LlbBaeIeEx9FIyzuNSflkxj3QydpxJ2QdbFFNB7tZLvC73Ht3OEoOw>
    <xmx:LlbBafGvAcd8Sv_eHKo2yfqVT-NGHjTtzD2AtJlg2fENp17ejU-8pg>
    <xmx:LlbBaQpbjg2zrYBCEIwLqjH5f0y8cLYuBiVp2DAcGC5lFoEJ7C5Pmw>
    <xmx:LlbBaQRyNCDhzt4HPGMkj2gs9dcroWIqL2C4bZ8MsjmiSzNPrEXU6g>
    <xmx:LlbBaWoozneBlC9OofT55n7FlGYoT4WuEEjn3jsSBb2Voe_yU03WsSAF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9d1e388 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] fsck: drop use of `the_repository`
Date: Mon, 23 Mar 2026 16:02:51 +0100
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxWwWkC/5WNQQ7CIBBFr9LM2jEUEcWV9zBdWJjKpLE0gFXT9
 O7S3sDl+/n//RkSRaYEl2qGSBMnDkMBuavA+vvwIGRXGKSQWhykwFbh2Cfsku3xzdmHV8bsCSO
 NIXEO8YvKOavsmZyuCYpojNTxZzu5NYU9p7W3fU71mv6ln2oUqI9GdcacjNTttSz2/IRmWZYfz
 xsfn9EAAAA=
X-Change-ID: 20260320-b4-pks-fsck-without-the-repository-4ddc4c8ed61e
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

this patch series refactors "{builtin/,}fsck.c" to not depend on
`the_repository` anymore. These refactorings are mostly done to prepare
for upcoming changes where we'll make backend-specific fsck checks
pluggable.

Changes in v2:
  - Propagate the repository via `struct fsck_options`.
  - Link to v1: https://lore.kernel.org/r/20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      fetch-pack: move fsck options into function scope
      fsck: initialize fsck options via a function
      fsck: store repository in fsck options
      fsck: drop USE_THE_REPOSITORY
      builtin/fsck: fix trivial dependence on `the_repository`
      builtin/fsck: stop using `the_repository` when snapshotting refs
      builtin/fsck: stop using `the_repository` when checking refs
      builtin/fsck: stop using `the_repository` when checking reflogs
      builtin/fsck: stop using `the_repository` with loose objects
      builtin/fsck: stop using `the_repository` when checking packed objects
      builtin/fsck: stop using `the_repository` when marking objects
      builtin/fsck: stop using `the_repository` in error reporting

 builtin/fsck.c           | 273 ++++++++++++++++++++++++++---------------------
 builtin/index-pack.c     |   4 +-
 builtin/mktag.c          |   5 +-
 builtin/refs.c           |   6 +-
 builtin/unpack-objects.c |   6 +-
 fetch-pack.c             |   9 +-
 fsck.c                   |  76 ++++++++++---
 fsck.h                   |  42 +++-----
 object-file.c            |   3 +-
 pack-check.c             |   7 +-
 pack.h                   |   9 +-
 11 files changed, 259 insertions(+), 181 deletions(-)

Range-diff versus v1:

 1:  fd589e1813 <  -:  ---------- fsck: drop `the_repository` in `fsck_walk()`
 2:  6d0d46b70d <  -:  ---------- fsck: drop `the_repository` in `fsck_finish()`
 3:  79c3cd644b <  -:  ---------- fsck: refactor interface to parse fsck options
 4:  f5fd9d1489 <  -:  ---------- fsck: drop `the_repository` in `fsck_set_msg_types()`
 5:  58c145905e <  -:  ---------- fsck: stop relying on global state via `parse_oid_hex()`
 -:  ---------- >  1:  1b5958d8db fetch-pack: move fsck options into function scope
 -:  ---------- >  2:  19b502cd82 fsck: initialize fsck options via a function
 -:  ---------- >  3:  34b921be8b fsck: store repository in fsck options
 -:  ---------- >  4:  f8a74307d8 fsck: drop USE_THE_REPOSITORY
 6:  4d255cd44d !  5:  6e3f51757f builtin/fsck: fix trivial dependence on `the_repository`
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static void mark_object_reachable(struct object *obj)
    - 	mark_object(obj, OBJ_ANY, NULL, NULL);
    - }
    - 
    --static int traverse_one_object(struct object *obj)
    -+static int traverse_one_object(struct repository *repo, struct object *obj)
    - {
    --	int result = fsck_walk(the_repository, obj, obj, &fsck_walk_options);
    -+	int result = fsck_walk(repo, obj, obj, &fsck_walk_options);
    - 
    - 	if (obj->type == OBJ_TREE) {
    - 		struct tree *tree = (struct tree *)obj;
     @@ builtin/fsck.c: static int traverse_one_object(struct object *obj)
      	return result;
      }
    @@ builtin/fsck.c: static int traverse_one_object(struct object *obj)
     +		progress = start_delayed_progress(repo,
      						  _("Checking connectivity"), 0);
      	while (pending.nr) {
    --		result |= traverse_one_object(object_array_pop(&pending));
    -+		result |= traverse_one_object(repo, object_array_pop(&pending));
    - 		display_progress(progress, ++nr);
    - 	}
    - 	stop_progress(&progress);
    + 		result |= traverse_one_object(object_array_pop(&pending));
     @@ builtin/fsck.c: static int mark_unreachable_referents(const struct object_id *oid,
      /*
       * Check a single reachable object
    @@ builtin/fsck.c: static void check_connectivity(void)
      	}
      }
      
    -@@ builtin/fsck.c: static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
    +@@ builtin/fsck.c: static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *data)
      	return 0;
      }
      
    --static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    -+static void snapshot_refs(struct repository *repo, struct snapshot *snap,
    -+			  int argc, const char **argv)
    +-static void fsck_source(struct odb_source *source)
    ++static void fsck_source(struct repository *repo, struct odb_source *source)
      {
    - 	struct refs_for_each_ref_options opts = {
    - 		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
    -@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    - 	for (int i = 0; i < argc; i++) {
    - 		const char *arg = argv[i];
    - 		struct object_id oid;
    --		if (!repo_get_oid(the_repository, arg, &oid)) {
    -+		if (!repo_get_oid(repo, arg, &oid)) {
    - 			struct reference ref = {
    - 				.name = arg,
    - 				.oid = &oid,
    -@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    - 		return;
    - 	}
    - 
    --	refs_for_each_ref_ext(get_main_ref_store(the_repository),
    -+	refs_for_each_ref_ext(get_main_ref_store(repo),
    - 			      snapshot_ref, snap, &opts);
    - 
    - 	worktrees = get_worktrees();
    -@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    - 
    - 		strbuf_worktree_ref(wt, &refname, "HEAD");
    - 
    --		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
    -+		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(repo),
    - 							 refname.buf, 0, &head_oid, NULL);
    - 
    - 		if (head_points_at && !is_null_oid(&head_oid)) {
    + 	struct progress *progress = NULL;
    + 	struct for_each_loose_cb cb_data = {
     @@ builtin/fsck.c: static void fsck_source(struct odb_source *source)
      		fprintf_ln(stderr, _("Checking object directory"));
      
      	if (show_progress)
     -		progress = start_progress(the_repository,
    -+		progress = start_progress(source->odb->repo,
    ++		progress = start_progress(repo,
      					  _("Checking object directories"), 256);
      
      	for_each_loose_file_in_source(source, fsck_loose,
    @@ builtin/fsck.c: static void fsck_source(struct odb_source *source)
      }
      
     -static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
    -+static int fsck_cache_tree(struct repository *repo, struct cache_tree *it,
    -+			   const char *index_path)
    ++static int fsck_cache_tree(struct repository *repo, struct cache_tree *it, const char *index_path)
      {
      	int i;
      	int err = 0;
    @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show
      						  "Verifying reverse pack-indexes", pack_count);
      		pack_count = 0;
      	}
    -@@ builtin/fsck.c: static struct option fsck_opts[] = {
    - int cmd_fsck(int argc,
    - 	     const char **argv,
    - 	     const char *prefix,
    --	     struct repository *repo UNUSED)
    -+	     struct repository *repo)
    - {
    - 	struct odb_source *source;
    - 	struct snapshot snap = {
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      	if (name_objects)
      		fsck_enable_object_names(&fsck_walk_options);
      
    --	fsck_options_parse_config(&fsck_obj_options, the_repository);
    +-	repo_config(the_repository, git_fsck_config, &fsck_obj_options);
     -	prepare_repo_settings(the_repository);
    -+	fsck_options_parse_config(&fsck_obj_options, repo);
    ++	repo_config(repo, git_fsck_config, &fsck_obj_options);
     +	prepare_repo_settings(repo);
      
      	if (check_references)
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      	/*
      	 * Take a snapshot of the refs before walking objects to avoid looking
     @@ builtin/fsck.c: int cmd_fsck(int argc,
    - 	 * objects. We can still walk over new objects that are added during the
    - 	 * execution of fsck but won't miss any objects that were reachable.
    - 	 */
    --	snapshot_refs(&snap, argc, argv);
    -+	snapshot_refs(repo, &snap, argc, argv);
    + 	snapshot_refs(&snap, argc, argv);
      
      	/* Ensure we get a "fresh" view of the odb */
     -	odb_reprepare(the_repository->objects);
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      	} else {
     -		odb_prepare_alternates(the_repository->objects);
     -		for (source = the_repository->objects->sources; source; source = source->next)
    +-			fsck_source(source);
     +		odb_prepare_alternates(repo->objects);
     +		for (source = repo->objects->sources; source; source = source->next)
    - 			fsck_source(source);
    ++			fsck_source(repo, source);
      
      		if (check_full) {
    + 			struct packed_git *p;
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      			struct progress *progress = NULL;
      
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      						p, fsck_obj_buffer,
      						progress, count))
      					errors_found |= ERROR_PACK;
    -@@ builtin/fsck.c: int cmd_fsck(int argc,
    - 			stop_progress(&progress);
    - 		}
    - 
    --		if (fsck_finish(the_repository, &fsck_obj_options))
    -+		if (fsck_finish(repo, &fsck_obj_options))
    - 			errors_found |= ERROR_OBJECT;
    - 	}
    - 
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      		for (p = worktrees; *p; p++) {
      			struct worktree *wt = *p;
 7:  65f1c0078b !  6:  6c0507a4c8 builtin/fsck: stop using `the_repository` when snapshotting refs
    @@ builtin/fsck.c: struct snapshot {
      			/*
      			 * Increment default_refs anyway, because this is a
      			 * valid ref.
    -@@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapshot *snap,
    +@@ builtin/fsck.c: static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
    + 	return 0;
    + }
    + 
    +-static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    ++static void snapshot_refs(struct repository *repo,
    ++			  struct snapshot *snap, int argc, const char **argv)
    + {
      	struct refs_for_each_ref_options opts = {
      		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
      	};
    @@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapsh
      	struct worktree **worktrees, **p;
      	const char *head_points_at;
      	struct object_id head_oid;
    -@@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapshot *snap,
    +@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    + 	for (int i = 0; i < argc; i++) {
    + 		const char *arg = argv[i];
    + 		struct object_id oid;
    +-		if (!repo_get_oid(the_repository, arg, &oid)) {
    ++		if (!repo_get_oid(repo, arg, &oid)) {
    + 			struct reference ref = {
    + 				.name = arg,
      				.oid = &oid,
      			};
      
    @@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapsh
      			continue;
      		}
      		error(_("invalid parameter: expected sha1, got '%s'"), arg);
    -@@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapshot *snap,
    +@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    + 		return;
      	}
      
    - 	refs_for_each_ref_ext(get_main_ref_store(repo),
    +-	refs_for_each_ref_ext(get_main_ref_store(the_repository),
     -			      snapshot_ref, snap, &opts);
    ++	refs_for_each_ref_ext(get_main_ref_store(repo),
     +			      snapshot_ref, &data, &opts);
      
      	worktrees = get_worktrees();
      	for (p = worktrees; *p; p++) {
    -@@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapshot *snap,
    +@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
    + 
    + 		strbuf_worktree_ref(wt, &refname, "HEAD");
    + 
    +-		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
    ++		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(repo),
    + 							 refname.buf, 0, &head_oid, NULL);
    + 
    + 		if (head_points_at && !is_null_oid(&head_oid)) {
    +@@ builtin/fsck.c: static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
      				.oid = &head_oid,
      			};
      
    @@ builtin/fsck.c: static void snapshot_refs(struct repository *repo, struct snapsh
      		}
      		strbuf_release(&refname);
      
    +@@ builtin/fsck.c: int cmd_fsck(int argc,
    + 	 * objects. We can still walk over new objects that are added during the
    + 	 * execution of fsck but won't miss any objects that were reachable.
    + 	 */
    +-	snapshot_refs(&snap, argc, argv);
    ++	snapshot_refs(repo, &snap, argc, argv);
    + 
    + 	/* Ensure we get a "fresh" view of the odb */
    + 	odb_reprepare(repo->objects);
 8:  42b9d4ad29 =  7:  844a192db2 builtin/fsck: stop using `the_repository` when checking refs
 9:  3c3af4cbcd =  8:  6557fc60ee builtin/fsck: stop using `the_repository` when checking reflogs
10:  387ba6f851 !  9:  31709b33c8 builtin/fsck: stop using `the_repository` with loose objects
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static void check_connectivity(struct repository *repo)
    - 	}
    - }
    - 
    --static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
    -+static int fsck_obj(struct repository *repo,
    -+		    struct object *obj,
    -+		    void *buffer, unsigned long size)
    - {
    - 	int err;
    - 
    -@@ builtin/fsck.c: static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
    - 			   printable_type(&obj->oid, obj->type),
    - 			   describe_object(&obj->oid));
    - 
    --	if (fsck_walk(the_repository, obj, NULL, &fsck_obj_options))
    -+	if (fsck_walk(repo, obj, NULL, &fsck_obj_options))
    - 		objerror(obj, _("broken links"));
    --	err = fsck_object(the_repository, obj, buffer, size, &fsck_obj_options);
    -+	err = fsck_object(repo, obj, buffer, size, &fsck_obj_options);
    - 	if (err)
    - 		goto out;
    - 
    -@@ builtin/fsck.c: static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
    - 	}
    - 	obj->flags &= ~(REACHABLE | SEEN);
    - 	obj->flags |= HAS_OBJ;
    --	return fsck_obj(obj, buffer, size);
    -+	return fsck_obj(the_repository, obj, buffer, size);
    - }
    - 
    - static int default_refs;
     @@ builtin/fsck.c: static void process_refs(struct repository *repo, struct snapshot *snap)
      	}
      }
    @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *p
      				  contents, &eaten);
      
      	if (!obj) {
    -@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path,
    - 
    - 	obj->flags &= ~(REACHABLE | SEEN);
    - 	obj->flags |= HAS_OBJ;
    --	if (fsck_obj(obj, contents, size))
    -+	if (fsck_obj(data->repo, obj, contents, size))
    - 		errors_found |= ERROR_OBJECT;
    - 
    - 	if (!eaten)
    -@@ builtin/fsck.c: static void fsck_source(struct odb_source *source)
    +@@ builtin/fsck.c: static void fsck_source(struct repository *repo, struct odb_source *source)
      {
      	struct progress *progress = NULL;
      	struct for_each_loose_cb cb_data = {
11:  031a245247 ! 10:  ecbd9abef9 builtin/fsck: stop using `the_repository` when checking packed objects
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static int fsck_obj(struct repository *repo,
    +@@ builtin/fsck.c: static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
      }
      
      static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
    @@ builtin/fsck.c: static int fsck_obj(struct repository *repo,
      	if (!obj) {
      		errors_found |= ERROR_OBJECT;
      		return error(_("%s: object corrupt or missing"),
    -@@ builtin/fsck.c: static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
    - 	}
    - 	obj->flags &= ~(REACHABLE | SEEN);
    - 	obj->flags |= HAS_OBJ;
    --	return fsck_obj(the_repository, obj, buffer, size);
    -+	return fsck_obj(repo, obj, buffer, size);
    - }
    - 
    - static int default_refs;
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      			repo_for_each_pack(repo, p) {
      				/* verify gives error messages itself */
12:  5d61f5a545 ! 11:  9e246797c5 builtin/fsck: stop using `the_repository` when marking objects
    @@ Commit message
     
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int fsck_objects_error_func(struct fsck_options *o UNUSED,
    - 
      static struct object_array pending;
      
    -+struct mark_object_data {
    -+	struct repository *repo;
    -+	struct object *parent;
    -+};
    -+
      static int mark_object(struct object *obj, enum object_type type,
     -		       void *data, struct fsck_options *options UNUSED)
    -+		       void *cb_data, struct fsck_options *options UNUSED)
    ++		       void *data, struct fsck_options *options)
      {
    --	struct object *parent = data;
    -+	struct mark_object_data *data = cb_data;
    -+	struct object *parent = data->parent;
    + 	struct object *parent = data;
      
    - 	/*
    - 	 * The only case data is NULL or type is OBJ_ANY is when
     @@ builtin/fsck.c: static int mark_object(struct object *obj, enum object_type type,
      		return 0;
      	obj->flags |= REACHABLE;
      
     -	if (is_promisor_object(the_repository, &obj->oid))
    -+	if (is_promisor_object(data->repo, &obj->oid))
    ++	if (is_promisor_object(options->repo, &obj->oid))
      		/*
      		 * Further recursion does not need to be performed on this
      		 * object since it is a promisor object (so it does not need to
    @@ builtin/fsck.c: static int mark_object(struct object *obj, enum object_type type
      
      	if (!(obj->flags & HAS_OBJ)) {
     -		if (parent && !odb_has_object(the_repository->objects, &obj->oid,
    -+		if (parent && !odb_has_object(data->repo->objects, &obj->oid,
    ++		if (parent && !odb_has_object(options->repo->objects, &obj->oid,
      					      HAS_OBJECT_RECHECK_PACKED)) {
      			printf_ln(_("broken link from %7s %s\n"
      				    "              to %7s %s"),
     @@ builtin/fsck.c: static int mark_object(struct object *obj, enum object_type type,
    - 	return 0;
    - }
      
    --static void mark_object_reachable(struct object *obj)
    -+static void mark_object_reachable(struct repository *repo, struct object *obj)
    + static void mark_object_reachable(struct object *obj)
      {
     -	mark_object(obj, OBJ_ANY, NULL, NULL);
    -+	struct mark_object_data data = {
    -+		.repo = repo,
    -+	};
    -+	mark_object(obj, OBJ_ANY, &data, NULL);
    ++	mark_object(obj, OBJ_ANY, NULL, &fsck_walk_options);
      }
      
    - static int traverse_one_object(struct repository *repo, struct object *obj)
    - {
    --	int result = fsck_walk(repo, obj, obj, &fsck_walk_options);
    -+	struct mark_object_data data = {
    -+		.repo = repo,
    -+		.parent = obj,
    -+	};
    -+	int result = fsck_walk(repo, obj, &data, &fsck_walk_options);
    - 
    - 	if (obj->type == OBJ_TREE) {
    - 		struct tree *tree = (struct tree *)obj;
    + static int traverse_one_object(struct object *obj)
     @@ builtin/fsck.c: static int mark_used(struct object *obj, enum object_type type UNUSED,
      
      static int mark_unreachable_referents(const struct object_id *oid,
    @@ builtin/fsck.c: static int mark_used(struct object *obj, enum object_type type U
     +				      void *data)
      {
     +	struct repository *repo = data;
    - 	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
    + 	struct fsck_options options;
     -	struct object *obj = lookup_object(the_repository, oid);
    -+	struct object *obj = lookup_object(repo, oid);
    ++	struct object *obj = lookup_object(data, oid);
      
      	if (!obj || !(obj->flags & HAS_OBJ))
      		return 0; /* not part of our original set */
    @@ builtin/fsck.c: static int mark_unreachable_referents(const struct object_id *oi
      			object_as_type(obj, type, 0);
      	}
      
    +-	fsck_options_init(&options, the_repository, FSCK_OPTIONS_DEFAULT);
    ++	fsck_options_init(&options, repo, FSCK_OPTIONS_DEFAULT);
      	options.walk = mark_used;
    --	fsck_walk(the_repository, obj, NULL, &options);
    -+	fsck_walk(repo, obj, NULL, &options);
    + 	fsck_walk(obj, NULL, &options);
      	if (obj->type == OBJ_TREE)
    - 		free_tree_buffer((struct tree *)obj);
    - 
     @@ builtin/fsck.c: static void check_connectivity(struct repository *repo)
      		 * traversal.
      		 */
    @@ builtin/fsck.c: static void check_connectivity(struct repository *repo)
      	}
      
      	/* Look up all the requirements, warn about missing objects.. */
    -@@ builtin/fsck.c: static void fsck_handle_reflog_oid(struct repository *repo,
    - 						     "%s@{%"PRItime"}",
    - 						     refname, timestamp);
    - 			obj->flags |= USED;
    --			mark_object_reachable(obj);
    -+			mark_object_reachable(repo, obj);
    - 		} else if (!is_promisor_object(repo, oid)) {
    - 			error(_("%s: invalid reflog entry %s"),
    - 			      refname, oid_to_hex(oid));
    -@@ builtin/fsck.c: static int fsck_handle_ref(const struct reference *ref, void *cb_data)
    - 	obj->flags |= USED;
    - 	fsck_put_object_name(&fsck_walk_options,
    - 			     ref->oid, "%s", ref->name);
    --	mark_object_reachable(obj);
    -+	mark_object_reachable(repo, obj);
    - 
    - 	return 0;
    - }
    -@@ builtin/fsck.c: static int fsck_cache_tree(struct repository *repo, struct cache_tree *it,
    - 		}
    - 		obj->flags |= USED;
    - 		fsck_put_object_name(&fsck_walk_options, &it->oid, ":");
    --		mark_object_reachable(obj);
    -+		mark_object_reachable(repo, obj);
    - 		if (obj->type != OBJ_TREE)
    - 			err |= objerror(obj, _("non-tree in cache-tree"));
    - 	}
    -@@ builtin/fsck.c: static int fsck_resolve_undo(struct index_state *istate,
    - 			obj->flags |= USED;
    - 			fsck_put_object_name(&fsck_walk_options, &ru->oid[i],
    - 					     ":(%d):%s", i, path);
    --			mark_object_reachable(obj);
    -+			mark_object_reachable(istate->repo, obj);
    - 		}
    - 	}
    - 	return 0;
    -@@ builtin/fsck.c: static void fsck_index(struct index_state *istate, const char *index_path,
    - 				     "%s:%s",
    - 				     is_current_worktree ? "" : index_path,
    - 				     istate->cache[i]->name);
    --		mark_object_reachable(obj);
    -+		mark_object_reachable(istate->repo, obj);
    - 	}
    - 	if (istate->cache_tree)
    - 		fsck_cache_tree(istate->repo, istate->cache_tree, index_path);
     @@ builtin/fsck.c: static void fsck_index(struct index_state *istate, const char *index_path,
      
      static int mark_object_for_connectivity(const struct object_id *oid,
13:  6842133df2 <  -:  ---------- fsck: provide repository in `struct fsck_report_object`
14:  06a88b16cd ! 12:  066e60a2ca builtin/fsck: stop using `the_repository` in error reporting
    @@ builtin/fsck.c: static const char *describe_object(const struct object_id *oid)
      
      	if (type == OBJ_NONE)
     -		type = odb_read_object_info(the_repository->objects,
    -+		type = odb_read_object_info(repo->objects,
    - 					    oid, NULL);
    +-					    oid, NULL);
    ++		type = odb_read_object_info(repo->objects, oid, NULL);
      
      	ret = type_name(type);
    + 	if (!ret)
     @@ builtin/fsck.c: static const char *printable_type(const struct object_id *oid,
      	return ret;
      }
    @@ builtin/fsck.c: static const char *printable_type(const struct object_id *oid,
      		   describe_object(&obj->oid), err);
      	return -1;
      }
    + 
    +-static int fsck_objects_error_func(struct fsck_options *o UNUSED,
    ++static int fsck_objects_error_func(struct fsck_options *o,
    + 				   void *fsck_report,
    + 				   enum fsck_msg_type msg_type,
    + 				   enum fsck_msg_id msg_id UNUSED,
     @@ builtin/fsck.c: static int fsck_objects_error_func(struct fsck_options *o UNUSED,
      	case FSCK_WARN:
      		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
      		fprintf_ln(stderr, _("warning in %s %s: %s"),
     -			   printable_type(oid, object_type),
    -+			   printable_type(report->repo, oid, object_type),
    ++			   printable_type(o->repo, oid, object_type),
      			   describe_object(oid), message);
      		return 0;
      	case FSCK_ERROR:
      		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
      		fprintf_ln(stderr, _("error in %s %s: %s"),
     -			   printable_type(oid, object_type),
    -+			   printable_type(report->repo, oid, object_type),
    ++			   printable_type(o->repo, oid, object_type),
      			   describe_object(oid), message);
      		return 1;
      	default:
    @@ builtin/fsck.c: static int mark_object(struct object *obj, enum object_type type
      		/* ... these references to parent->fld are safe here */
      		printf_ln(_("broken link from %7s %s"),
     -			  printable_type(&parent->oid, parent->type),
    -+			  printable_type(data->repo, &parent->oid, parent->type),
    ++			  printable_type(options->repo, &parent->oid, parent->type),
      			  describe_object(&parent->oid));
      		printf_ln(_("broken link from %7s %s"),
      			  (type == OBJ_ANY ? _("unknown") : type_name(type)),
    @@ builtin/fsck.c: static int mark_object(struct object *obj, enum object_type type
      	if (type != OBJ_ANY && obj->type != type)
      		/* ... and the reference to parent is safe here */
     -		objerror(parent, _("wrong object type in link"));
    -+		objerror(data->repo, parent, _("wrong object type in link"));
    ++		objerror(options->repo, parent, _("wrong object type in link"));
      
      	if (obj->flags & REACHABLE)
      		return 0;
    @@ builtin/fsck.c: static int mark_object(struct object *obj, enum object_type type
      			printf_ln(_("broken link from %7s %s\n"
      				    "              to %7s %s"),
     -				  printable_type(&parent->oid, parent->type),
    -+				  printable_type(data->repo, &parent->oid, parent->type),
    ++				  printable_type(options->repo, &parent->oid, parent->type),
      				  describe_object(&parent->oid),
     -				  printable_type(&obj->oid, obj->type),
    -+				  printable_type(data->repo, &obj->oid, obj->type),
    ++				  printable_type(options->repo, &obj->oid, obj->type),
      				  describe_object(&obj->oid));
      			errors_found |= ERROR_REACHABLE;
      		}
    @@ builtin/fsck.c: static void check_unreachable_object(struct repository *repo, st
      				  describe_object(&obj->oid));
      		if (write_lost_and_found) {
      			char *filename = repo_git_path(repo, "lost-found/%s/%s",
    -@@ builtin/fsck.c: static int fsck_obj(struct repository *repo,
    +@@ builtin/fsck.c: static void check_connectivity(struct repository *repo)
    + 	}
    + }
    + 
    +-static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
    ++static int fsck_obj(struct repository *repo,
    ++		    struct object *obj, void *buffer, unsigned long size)
    + {
    + 	int err;
    + 
    +@@ builtin/fsck.c: static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
      
      	if (verbose)
      		fprintf_ln(stderr, _("Checking %s %s"),
    @@ builtin/fsck.c: static int fsck_obj(struct repository *repo,
     +			   printable_type(repo, &obj->oid, obj->type),
      			   describe_object(&obj->oid));
      
    - 	if (fsck_walk(repo, obj, NULL, &fsck_obj_options))
    + 	if (fsck_walk(obj, NULL, &fsck_obj_options))
     -		objerror(obj, _("broken links"));
     +		objerror(repo, obj, _("broken links"));
    - 	err = fsck_object(repo, obj, buffer, size, &fsck_obj_options);
    + 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
      	if (err)
      		goto out;
    -@@ builtin/fsck.c: static int fsck_obj(struct repository *repo,
    +@@ builtin/fsck.c: static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
      
      		if (show_tags && tag->tagged) {
      			printf_ln(_("tagged %s %s (%s) in %s"),
    @@ builtin/fsck.c: static int fsck_obj(struct repository *repo,
      				  describe_object(&tag->tagged->oid),
      				  tag->tag,
      				  describe_object(&tag->object.oid));
    -@@ builtin/fsck.c: static int fsck_cache_tree(struct repository *repo, struct cache_tree *it,
    +@@ builtin/fsck.c: static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
    + 	}
    + 	obj->flags &= ~(REACHABLE | SEEN);
    + 	obj->flags |= HAS_OBJ;
    +-	return fsck_obj(obj, buffer, size);
    ++	return fsck_obj(repo, obj, buffer, size);
    + }
    + 
    + static int default_refs;
    +@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path,
    + 
    + 	obj->flags &= ~(REACHABLE | SEEN);
    + 	obj->flags |= HAS_OBJ;
    +-	if (fsck_obj(obj, contents, size))
    ++	if (fsck_obj(data->repo, obj, contents, size))
    + 		errors_found |= ERROR_OBJECT;
    + 
    + 	if (!eaten)
    +@@ builtin/fsck.c: static int fsck_cache_tree(struct repository *repo, struct cache_tree *it, const
      		fsck_put_object_name(&fsck_walk_options, &it->oid, ":");
    - 		mark_object_reachable(repo, obj);
    + 		mark_object_reachable(obj);
      		if (obj->type != OBJ_TREE)
     -			err |= objerror(obj, _("non-tree in cache-tree"));
     +			err |= objerror(repo, obj, _("non-tree in cache-tree"));

---
base-commit: 7ff1e8dc1e1680510c96e69965b3fa81372c5037
change-id: 20260320-b4-pks-fsck-without-the-repository-4ddc4c8ed61e

