Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4E1DD88E
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417861; cv=none; b=LSaaZO76yDTnj318Y41cZEjW7keWyG7iW6+OK6ajnr1FYINAKBWnstbZ6AWHekZVp2GiawWikmQ9+2FYXYJfVlatknAXbn1tqdr0K1aTxRtttTUq37aMNbWiYWZjyGw0IG+Wgcn+l+bGBS9/k5JGaBkPs2rp7aBXJ5RNS5oiqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417861; c=relaxed/simple;
	bh=KXSwA6f0SeS/2qYXgTdmsxG+zDQDwvetQntAbwC+ppg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/HcBIXh4Ca1TDp3r5LQdX6deo2qoCmQUo3XzAHar4W8ppT4RzieZxHCyu3PLw515bkN8IbX4NL5G7aMplGRN7Vu9/sc4UoiMaJtGrmCIOzuvOL/1xG+RbR9IiIDTfhVXcT6LRH/fG9RlNMnpeFdDamY3mkbk6jy4jbwpSFiO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BHUcTHom; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pcXqOU0c; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BHUcTHom";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pcXqOU0c"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FC5E13801DB
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 17 Dec 2024 01:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417857;
	 x=1734504257; bh=PWZ4zntwz7m8mLaaD75Uy/XfOIyAlQuVuGRYOlDa2AM=; b=
	BHUcTHom+wMFORP76FFP2jGNDVyBardDXTIl8KxZXx69l93s/iFUvy9RMQiXZjc5
	wtLFW8sdfkFt6Dc19pvXX8PQddUpSn85iiAiEufWQ52nJLWQkV/WeJl/sO/k9FxD
	o33cjNnsgNFmIEKUN6WSoS369jnEi9cFEAu1s41ob0j5i65/Lg/n8EXSZd9NfD35
	aMoZ08GuD1wRcmO/1UIuwCLzR8MpGkLoJ+18NHE/KpvXI2G8OinRgpArsFJG7EC7
	bzwBXFZ0CTTMjziz/8JCQBHnH6qFp3wgRbK3opkH0923k8gS890JQpN6NcFoeUhX
	EUhVywCnRkX84J3zkLilNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417857; x=
	1734504257; bh=PWZ4zntwz7m8mLaaD75Uy/XfOIyAlQuVuGRYOlDa2AM=; b=p
	cXqOU0crOaVMxVNcpzVUt11jVk6mYksrrVODrBWHmIxI36Wa3Nw3PqCrcqLjvKZ3
	5ayOkYAl/AQxSjA4hUG2/Ee5K+CwqaHOjsOiIT54mg2kQAxMTAA3CJtoEGI/w/3j
	Sd32CW0F8uskisgs2SSm2BiIDt/CaaDvYF0GLW2fgX7XpLj8D3PEYtSPhCldLuM3
	NJiLIf70WLhuLJjDkZU1GVgoitoNMgk8zf6HD2ap/PCKPIP2ywT44xPm9FpWCQri
	djspZaHG53taxDN23ZanDjxxpVQTNXQ+KeXQEWoHuEMduf0IYEt2Jc3/oT7acNeb
	r6xROfiXaOAdwUG49WTdA==
X-ME-Sender: <xms:wB1hZ59Z6dHzbFKBkIOggSBdRS5jwJk4_dAeZOSzJJbw4J1octD_xw>
    <xme:wB1hZ9seas9bsbvVm2nnx2DeG0FEHhwXOdMKmNzCPcjCIKkYex4KqN5jtgO1fnmuR
    -nFMn4Mdhcg_ojWmA>
X-ME-Received: <xmr:wB1hZ3A9LPscMU6d2qTKcN8SXA4-NV4iycxGoBs-KVY6XP3bcSmWnXUswAhURI7VzUc_vxfb03W6Pa10SDJX6NK_1sve9rkHlO8KHfoeg1KXQ5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wB1hZ9c0LLnr6Ic-bKDY2qzWru9DyBWM0hQRjrvy64iro_0P-3ELlA>
    <xmx:wB1hZ-Ntw_PNeqS40C0zP7iXsXy5M4IrJBiNh7pdzo61mKxqemIq3g>
    <xmx:wB1hZ_lXGgfM-qucOIjnNc8-01cnu5-8Hzldk4ofGYe2j_s6T5wW4Q>
    <xmx:wB1hZ4u8aiu2nm5CHqliLncJpqtR7kZXS-tUkan15TNwMQhN5uhF_A>
    <xmx:wR1hZw1k7pqWn1J41BfS_atsGFYYBKM2qSHb4ZC5eegfjsKsJRYGA8If>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1fe53667 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:48 +0100
Subject: [PATCH 01/14] progress: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-1-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "progress" subsystem by passing in a
repository when initializing `struct progress`. Furthermore, store a
pointer to the repository in that struct so that we can pass it to the
trace2 API when logging information.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c          |  4 +++-
 builtin/commit-graph.c   |  1 +
 builtin/fsck.c           | 12 ++++++++----
 builtin/index-pack.c     |  7 +++++--
 builtin/log.c            |  3 ++-
 builtin/pack-objects.c   | 21 ++++++++++++++-------
 builtin/prune.c          |  3 ++-
 builtin/remote.c         |  3 ++-
 builtin/rev-list.c       |  3 ++-
 builtin/unpack-objects.c |  3 ++-
 commit-graph.c           | 20 +++++++++++++++++---
 delta-islands.c          |  3 ++-
 diffcore-rename.c        |  1 +
 entry.c                  |  4 +++-
 midx-write.c             | 11 ++++++++---
 midx.c                   | 13 +++++++++----
 pack-bitmap-write.c      |  6 ++++--
 pack-bitmap.c            |  4 +++-
 preload-index.c          |  4 +++-
 progress.c               | 34 ++++++++++++++++++++--------------
 progress.h               | 13 +++++++++----
 prune-packed.c           |  3 ++-
 pseudo-merge.c           |  3 ++-
 read-cache.c             |  3 ++-
 t/helper/test-progress.c |  6 +++++-
 unpack-trees.c           |  4 +++-
 walker.c                 |  3 ++-
 27 files changed, 136 insertions(+), 59 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 867032e4c16878ffd56df8a73162b89ca4bd2694..dd78288530f06efa99ec7a1ca767aa388805fd97 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1193,7 +1193,9 @@ int cmd_blame(int argc,
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
 	if (show_progress)
-		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
+		pi.progress = start_delayed_progress(the_repository,
+						     _("Blaming lines"),
+						     num_lines);
 
 	assign_blame(&sb, opt);
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index bd70d052e706b6e34b5aaaceef158c63ea4863d5..8ca75262c59c480a33b53ce9010a882970066957 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -305,6 +305,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		oidset_init(&commits, 0);
 		if (opts.progress)
 			progress = start_delayed_progress(
+				the_repository,
 				_("Collecting commits from input"), 0);
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0196c54eb68ee54c22de72d64b3f31602594e50b..7a4dcb0716052ff1b9236ea66b8901960fe1c55d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -197,7 +197,8 @@ static int traverse_reachable(void)
 	unsigned int nr = 0;
 	int result = 0;
 	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+		progress = start_delayed_progress(the_repository,
+						  _("Checking connectivity"), 0);
 	while (pending.nr) {
 		result |= traverse_one_object(object_array_pop(&pending));
 		display_progress(progress, ++nr);
@@ -703,7 +704,8 @@ static void fsck_object_dir(const char *path)
 		fprintf_ln(stderr, _("Checking object directory"));
 
 	if (show_progress)
-		progress = start_progress(_("Checking object directories"), 256);
+		progress = start_progress(the_repository,
+					  _("Checking object directories"), 256);
 
 	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
 				      &cb_data);
@@ -879,7 +881,8 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	if (show_progress) {
 		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
 			pack_count++;
-		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);
+		progress = start_delayed_progress(the_repository,
+						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
@@ -989,7 +992,8 @@ int cmd_fsck(int argc,
 					total += p->num_objects;
 				}
 
-				progress = start_progress(_("Checking objects"), total);
+				progress = start_progress(the_repository,
+							  _("Checking objects"), total);
 			}
 			for (p = get_all_packs(the_repository); p;
 			     p = p->next) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d773809c4c96604b7668b48d3c231460bd94c79b..05691104c36b4f18bf1287acac3f2a3719ea0261 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -282,7 +282,8 @@ static unsigned check_objects(void)
 	max = get_max_object_index();
 
 	if (verbose)
-		progress = start_delayed_progress(_("Checking objects"), max);
+		progress = start_delayed_progress(the_repository,
+						  _("Checking objects"), max);
 
 	for (i = 0; i < max; i++) {
 		foreign_nr += check_object(get_indexed_object(i));
@@ -1249,6 +1250,7 @@ static void parse_pack_objects(unsigned char *hash)
 
 	if (verbose)
 		progress = start_progress(
+				the_repository,
 				progress_title ? progress_title :
 				from_stdin ? _("Receiving objects") : _("Indexing objects"),
 				nr_objects);
@@ -1329,7 +1331,8 @@ static void resolve_deltas(struct pack_idx_option *opts)
 	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry);
 
 	if (verbose || show_resolving_progress)
-		progress = start_progress(_("Resolving deltas"),
+		progress = start_progress(the_repository,
+					  _("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
 
 	nr_dispatched = 0;
diff --git a/builtin/log.c b/builtin/log.c
index cb41a035c6ead57e4d466ae0042a40435ebcde2f..317335e60d450128685d9fce99eb8fe8f9860fd9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2495,7 +2495,8 @@ int cmd_format_patch(int argc,
 	rev.add_signoff = cfg.do_signoff;
 
 	if (show_progress)
-		progress = start_delayed_progress(_("Generating patches"), total);
+		progress = start_delayed_progress(the_repository,
+						  _("Generating patches"), total);
 	while (0 <= --nr) {
 		int shown;
 		display_progress(progress, total - nr);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1c3b8426515c42f14c536eea559dd377212855f6..d51c021d99d9f470c04b7ec52565ab2f4c1c19ae 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1264,7 +1264,8 @@ static void write_pack_file(void)
 	struct object_entry **write_order;
 
 	if (progress > pack_to_stdout)
-		progress_state = start_progress(_("Writing objects"), nr_result);
+		progress_state = start_progress(the_repository,
+						_("Writing objects"), nr_result);
 	ALLOC_ARRAY(written_list, to_pack.nr_objects);
 	write_order = compute_write_order();
 
@@ -2400,7 +2401,8 @@ static void get_object_details(void)
 	struct object_entry **sorted_by_offset;
 
 	if (progress)
-		progress_state = start_progress(_("Counting objects"),
+		progress_state = start_progress(the_repository,
+						_("Counting objects"),
 						to_pack.nr_objects);
 
 	CALLOC_ARRAY(sorted_by_offset, to_pack.nr_objects);
@@ -3220,7 +3222,8 @@ static void prepare_pack(int window, int depth)
 		unsigned nr_done = 0;
 
 		if (progress)
-			progress_state = start_progress(_("Compressing objects"),
+			progress_state = start_progress(the_repository,
+							_("Compressing objects"),
 							nr_deltas);
 		QSORT(delta_list, n, type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
@@ -3648,7 +3651,8 @@ static void add_objects_in_unpacked_packs(void);
 static void enumerate_cruft_objects(void)
 {
 	if (progress)
-		progress_state = start_progress(_("Enumerating cruft objects"), 0);
+		progress_state = start_progress(the_repository,
+						_("Enumerating cruft objects"), 0);
 
 	add_objects_in_unpacked_packs();
 	add_unreachable_loose_objects();
@@ -3674,7 +3678,8 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	revs.ignore_missing_links = 1;
 
 	if (progress)
-		progress_state = start_progress(_("Enumerating cruft objects"), 0);
+		progress_state = start_progress(the_repository,
+						_("Enumerating cruft objects"), 0);
 	ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
 						     set_cruft_mtime, 1);
 	stop_progress(&progress_state);
@@ -3693,7 +3698,8 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	if (progress)
-		progress_state = start_progress(_("Traversing cruft objects"), 0);
+		progress_state = start_progress(the_repository,
+						_("Traversing cruft objects"), 0);
 	nr_seen = 0;
 	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
 
@@ -4625,7 +4631,8 @@ int cmd_pack_objects(int argc,
 	prepare_packing_data(the_repository, &to_pack);
 
 	if (progress && !cruft)
-		progress_state = start_progress(_("Enumerating objects"), 0);
+		progress_state = start_progress(the_repository,
+						_("Enumerating objects"), 0);
 	if (stdin_packs) {
 		/* avoids adding objects in excluded packs */
 		ignore_packed_keep_in_core = 1;
diff --git a/builtin/prune.c b/builtin/prune.c
index aeff9ca1b35c3f09c6bd334cbf52864df437fe05..1c357fffd8cde6816ecb598fb6588462f3074c09 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -64,7 +64,8 @@ static void perform_reachability_traversal(struct rev_info *revs)
 		return;
 
 	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+		progress = start_delayed_progress(the_repository,
+						  _("Checking connectivity"), 0);
 	mark_reachable_objects(revs, 1, expire, progress);
 	stop_progress(&progress);
 	initialized = 1;
diff --git a/builtin/remote.c b/builtin/remote.c
index b2b13a7dd2acd466081e7bb49186d45f167dce9f..95440bc9ff284eb109079e95f5a5f438040e7fd7 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -820,7 +820,8 @@ static int mv(int argc, const char **argv, const char *prefix,
 		 * Count symrefs twice, since "renaming" them is done by
 		 * deleting and recreating them in two separate passes.
 		 */
-		progress = start_progress(_("Renaming remote references"),
+		progress = start_progress(the_repository,
+					  _("Renaming remote references"),
 					  rename.remote_branches->nr + rename.symrefs_nr);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3196da7b2d23e33fafde57a1af1c42a5c985f0b0..8a7db9b546196c76ce8e374915fffa378f1199c5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -735,7 +735,8 @@ int cmd_rev_list(int argc,
 		revs.limited = 1;
 
 	if (show_progress)
-		progress = start_delayed_progress(show_progress, 0);
+		progress = start_delayed_progress(the_repository,
+						  show_progress, 0);
 
 	if (use_bitmap_index) {
 		if (!try_bitmap_count(&revs, filter_provided_objects))
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2197d6d9332117636f31abadb5aff70424ba305d..842a90353a50b6a4be863237d2804e5ef509d478 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -590,7 +590,8 @@ static void unpack_all(void)
 	use(sizeof(struct pack_header));
 
 	if (!quiet)
-		progress = start_progress(_("Unpacking objects"), nr_objects);
+		progress = start_progress(the_repository,
+					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
 	begin_odb_transaction();
 	for (i = 0; i < nr_objects; i++) {
diff --git a/commit-graph.c b/commit-graph.c
index 0df66e5a243390bc1224b28e2b55c541f9d93fb1..2a2999a6b886905276a0c39dda6135f0c92aa361 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1534,6 +1534,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
+					the_repository,
 					_("Loading known commits in commit graph"),
 					ctx->oids.nr);
 	for (i = 0; i < ctx->oids.nr; i++) {
@@ -1551,6 +1552,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	 */
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
+					the_repository,
 					_("Expanding reachable commits in commit graph"),
 					0);
 	for (i = 0; i < ctx->oids.nr; i++) {
@@ -1571,6 +1573,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
+					the_repository,
 					_("Clearing commit marks in commit graph"),
 					ctx->oids.nr);
 	for (i = 0; i < ctx->oids.nr; i++) {
@@ -1688,6 +1691,7 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 	if (ctx->report_progress)
 		info.progress = ctx->progress
 			      = start_delayed_progress(
+					the_repository,
 					_("Computing commit graph topological levels"),
 					ctx->commits.nr);
 
@@ -1722,6 +1726,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	if (ctx->report_progress)
 		info.progress = ctx->progress
 			      = start_delayed_progress(
+					the_repository,
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 
@@ -1798,6 +1803,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		progress = start_delayed_progress(
+			the_repository,
 			_("Computing commit changed paths Bloom filters"),
 			ctx->commits.nr);
 
@@ -1877,6 +1883,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 	data.commits = &commits;
 	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		data.progress = start_delayed_progress(
+			the_repository,
 			_("Collecting referenced commits"), 0);
 
 	refs_for_each_ref(get_main_ref_store(the_repository), add_ref_to_set,
@@ -1908,7 +1915,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 			       "Finding commits for commit graph in %"PRIuMAX" packs",
 			       pack_indexes->nr),
 			    (uintmax_t)pack_indexes->nr);
-		ctx->progress = start_delayed_progress(progress_title.buf, 0);
+		ctx->progress = start_delayed_progress(the_repository,
+						       progress_title.buf, 0);
 		ctx->progress_done = 0;
 	}
 	for (i = 0; i < pack_indexes->nr; i++) {
@@ -1959,6 +1967,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 {
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
+			the_repository,
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
 	for_each_packed_object(ctx->r, add_packed_commits, ctx,
@@ -1977,6 +1986,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	ctx->num_extra_edges = 0;
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
+			the_repository,
 			_("Finding extra edges in commit graph"),
 			ctx->oids.nr);
 	oid_array_sort(&ctx->oids);
@@ -2136,6 +2146,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			       get_num_chunks(cf)),
 			    get_num_chunks(cf));
 		ctx->progress = start_delayed_progress(
+			the_repository,
 			progress_title.buf,
 			st_mult(get_num_chunks(cf), ctx->commits.nr));
 	}
@@ -2348,6 +2359,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
+					the_repository,
 					_("Scanning merged commits"),
 					ctx->commits.nr);
 
@@ -2392,7 +2404,8 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
 		current_graph_number--;
 
 		if (ctx->report_progress)
-			ctx->progress = start_delayed_progress(_("Merging commit-graph"), 0);
+			ctx->progress = start_delayed_progress(the_repository,
+							       _("Merging commit-graph"), 0);
 
 		merge_commit_graph(ctx, g);
 		stop_progress(&ctx->progress);
@@ -2874,7 +2887,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
 			total += g->num_commits_in_base;
 
-		progress = start_progress(_("Verifying commits in commit graph"),
+		progress = start_progress(the_repository,
+					  _("Verifying commits in commit graph"),
 					  total);
 	}
 
diff --git a/delta-islands.c b/delta-islands.c
index 1c465a6041914538bcb8be51c500653d8fa1a626..3aec43fada36f7052b825dcb2ac0e1ad79f028b7 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -267,7 +267,8 @@ void resolve_tree_islands(struct repository *r,
 	QSORT(todo, nr, tree_depth_compare);
 
 	if (progress)
-		progress_state = start_progress(_("Propagating island marks"), nr);
+		progress_state = start_progress(the_repository,
+						_("Propagating island marks"), nr);
 
 	for (i = 0; i < nr; i++) {
 		struct object_entry *ent = todo[i].entry;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 10bb0321b10d5896aaa6a26a624d2066598bf51f..91b77993c7827f9ddc7b444b42f480b8209fd821 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1567,6 +1567,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	trace2_region_enter("diff", "inexact renames", options->repo);
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
+				the_repository,
 				_("Performing inexact rename detection"),
 				(uint64_t)num_destinations * (uint64_t)num_sources);
 	}
diff --git a/entry.c b/entry.c
index 53a1c393582b2e6be4398985ca3c5f4fadece3cb..81b321e53d1b960976723ec1da49483bfd223ce8 100644
--- a/entry.c
+++ b/entry.c
@@ -188,7 +188,9 @@ int finish_delayed_checkout(struct checkout *state, int show_progress)
 
 	dco->state = CE_RETRY;
 	if (show_progress)
-		progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
+		progress = start_delayed_progress(the_repository,
+						  _("Filtering content"),
+						  dco->paths.nr);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_DUP;
diff --git a/midx-write.c b/midx-write.c
index 0066594fa6310b37903972e150c7cd1d7e232c38..b3827b936bdb1df12c73fb7d9b98ff65fc875cc3 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1131,7 +1131,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	ctx.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
-		ctx.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
+		ctx.progress = start_delayed_progress(r,
+						      _("Adding packfiles to multi-pack-index"), 0);
 	else
 		ctx.progress = NULL;
 
@@ -1539,7 +1540,9 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	CALLOC_ARRAY(count, m->num_packs);
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Counting referenced objects"),
+		progress = start_delayed_progress(
+					  r,
+					  _("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
@@ -1549,7 +1552,9 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	stop_progress(&progress);
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
+		progress = start_delayed_progress(
+					  r,
+					  _("Finding and deleting unreferenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
diff --git a/midx.c b/midx.c
index f8a75cafd4efeabd273268ba04cddefaa434e5b2..d91088efb87ca0d59b1ad215556a8cfe1612b8af 100644
--- a/midx.c
+++ b/midx.c
@@ -907,7 +907,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		midx_report(_("incorrect checksum"));
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Looking for referenced packfiles"),
+		progress = start_delayed_progress(r,
+						  _("Looking for referenced packfiles"),
 						  m->num_packs + m->num_packs_in_base);
 	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 		if (prepare_midx_pack(r, m, i))
@@ -927,7 +928,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
+		progress = start_sparse_progress(r,
+						 _("Verifying OID order in multi-pack-index"),
 						 m->num_objects - 1);
 
 	for (curr = m; curr; curr = curr->base_midx) {
@@ -959,14 +961,17 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Sorting objects by packfile"),
+		progress = start_sparse_progress(r,
+						 _("Sorting objects by packfile"),
 						 m->num_objects);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
+		progress = start_sparse_progress(r,
+						 _("Verifying object offsets"),
+						 m->num_objects);
 	for (i = 0; i < m->num_objects + m->num_objects_in_base; i++) {
 		struct object_id oid;
 		struct pack_entry e;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4f8be53c2bd75f83a0555e2a5510c2bbca07b36d..a06a1f35c619b3b01e63a506a6d4312e14cf181c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -590,7 +590,8 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	int closed = 1; /* until proven otherwise */
 
 	if (writer->show_progress)
-		writer->progress = start_progress("Building bitmaps",
+		writer->progress = start_progress(the_repository,
+						  "Building bitmaps",
 						  writer->selected_nr);
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 			    the_repository);
@@ -710,7 +711,8 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 	}
 
 	if (writer->show_progress)
-		writer->progress = start_progress("Selecting bitmap commits", 0);
+		writer->progress = start_progress(the_repository,
+						  "Selecting bitmap commits", 0);
 
 	for (;;) {
 		struct commit *chosen = NULL;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index bceb6da042772df7afa741bafe7e4893473cbca8..48e3b99efb2f554f685392f5e23f47fb1954ffdc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2578,7 +2578,9 @@ void test_bitmap_walk(struct rev_info *revs)
 	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
 	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
 	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
-	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
+	tdata.prg = start_progress(revs->repo,
+				   "Verifying bitmap entries",
+				   result_popcnt);
 	tdata.seen = 0;
 
 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
diff --git a/preload-index.c b/preload-index.c
index ab94d6f39967ea4358f51ff8384aa60927bfe259..40ab2abafb8de500a5f2ec678a584a5fd5e1bc16 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -132,7 +132,9 @@ void preload_index(struct index_state *index,
 
 	memset(&pd, 0, sizeof(pd));
 	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
-		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
+		pd.progress = start_delayed_progress(the_repository,
+						     _("Refreshing index"),
+						     index->cache_nr);
 		pthread_mutex_init(&pd.mutex, NULL);
 	}
 
diff --git a/progress.c b/progress.c
index a8fdfceb5cd12879ebac80589bb5b5e8661c2627..8d5ae70f3a9ec7042bf12782190f6514014b0287 100644
--- a/progress.c
+++ b/progress.c
@@ -9,7 +9,6 @@
  */
 
 #define GIT_TEST_PROGRESS_ONLY
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -37,6 +36,7 @@ struct throughput {
 };
 
 struct progress {
+	struct repository *repo;
 	const char *title;
 	uint64_t last_value;
 	uint64_t total;
@@ -254,10 +254,12 @@ void display_progress(struct progress *progress, uint64_t n)
 		display(progress, n, NULL);
 }
 
-static struct progress *start_progress_delay(const char *title, uint64_t total,
+static struct progress *start_progress_delay(struct repository *r,
+					     const char *title, uint64_t total,
 					     unsigned delay, unsigned sparse)
 {
 	struct progress *progress = xmalloc(sizeof(*progress));
+	progress->repo = r;
 	progress->title = title;
 	progress->total = total;
 	progress->last_value = -1;
@@ -270,7 +272,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
 	set_progress_signal();
-	trace2_region_enter("progress", title, the_repository);
+	trace2_region_enter("progress", title, r);
 	return progress;
 }
 
@@ -284,14 +286,16 @@ static int get_default_delay(void)
 	return delay_in_secs;
 }
 
-struct progress *start_delayed_progress(const char *title, uint64_t total)
+struct progress *start_delayed_progress(struct repository *r,
+					const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, get_default_delay(), 0);
+	return start_progress_delay(r, title, total, get_default_delay(), 0);
 }
 
-struct progress *start_progress(const char *title, uint64_t total)
+struct progress *start_progress(struct repository *r,
+				const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 0, 0);
+	return start_progress_delay(r, title, total, 0, 0);
 }
 
 /*
@@ -303,15 +307,17 @@ struct progress *start_progress(const char *title, uint64_t total)
  * When "sparse" is set, stop_progress() will automatically force the done
  * message to show 100%.
  */
-struct progress *start_sparse_progress(const char *title, uint64_t total)
+struct progress *start_sparse_progress(struct repository *r,
+				       const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 0, 1);
+	return start_progress_delay(r, title, total, 0, 1);
 }
 
-struct progress *start_delayed_sparse_progress(const char *title,
+struct progress *start_delayed_sparse_progress(struct repository *r,
+					       const char *title,
 					       uint64_t total)
 {
-	return start_progress_delay(title, total, get_default_delay(), 1);
+	return start_progress_delay(r, title, total, get_default_delay(), 1);
 }
 
 static void finish_if_sparse(struct progress *progress)
@@ -341,14 +347,14 @@ static void force_last_update(struct progress *progress, const char *msg)
 
 static void log_trace2(struct progress *progress)
 {
-	trace2_data_intmax("progress", the_repository, "total_objects",
+	trace2_data_intmax("progress", progress->repo, "total_objects",
 			   progress->total);
 
 	if (progress->throughput)
-		trace2_data_intmax("progress", the_repository, "total_bytes",
+		trace2_data_intmax("progress", progress->repo, "total_bytes",
 				   progress->throughput->curr_total);
 
-	trace2_region_leave("progress", progress->title, the_repository);
+	trace2_region_leave("progress", progress->title, progress->repo);
 }
 
 void stop_progress_msg(struct progress **p_progress, const char *msg)
diff --git a/progress.h b/progress.h
index 3a945637c81c22734b563325b66956ee4fb33b0b..ed068c7bab845b17f55d4ed8f0907497ad23fd47 100644
--- a/progress.h
+++ b/progress.h
@@ -3,6 +3,7 @@
 #include "gettext.h"
 
 struct progress;
+struct repository;
 
 #ifdef GIT_TEST_PROGRESS_ONLY
 
@@ -14,10 +15,14 @@ void progress_test_force_update(void);
 
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
-struct progress *start_progress(const char *title, uint64_t total);
-struct progress *start_sparse_progress(const char *title, uint64_t total);
-struct progress *start_delayed_progress(const char *title, uint64_t total);
-struct progress *start_delayed_sparse_progress(const char *title,
+struct progress *start_progress(struct repository *r,
+				const char *title, uint64_t total);
+struct progress *start_sparse_progress(struct repository *r,
+				       const char *title, uint64_t total);
+struct progress *start_delayed_progress(struct repository *r,
+					const char *title, uint64_t total);
+struct progress *start_delayed_sparse_progress(struct repository *r,
+					       const char *title,
 					       uint64_t total);
 void stop_progress_msg(struct progress **p_progress, const char *msg);
 static inline void stop_progress(struct progress **p_progress)
diff --git a/prune-packed.c b/prune-packed.c
index d1c65ab10ed6004aae8265ce05f8db9ae3a33ad9..7dad2fc0c169cf456ba646536cddae399b0555bd 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -37,7 +37,8 @@ static int prune_object(const struct object_id *oid, const char *path,
 void prune_packed_objects(int opts)
 {
 	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
+		progress = start_delayed_progress(the_repository,
+						  _("Removing duplicate objects"), 256);
 
 	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
 				      prune_object, NULL, prune_subdir, &opts);
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 971f54cfe1a895aed00f6d0a65c62aafc83a0cc8..893b763fe45490875ea226eaffff0c7cb1dafb06 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -459,7 +459,8 @@ void select_pseudo_merges(struct bitmap_writer *writer)
 		return;
 
 	if (writer->show_progress)
-		progress = start_progress("Selecting pseudo-merge commits",
+		progress = start_progress(the_repository,
+					  "Selecting pseudo-merge commits",
 					  writer->pseudo_merge_groups.nr);
 
 	refs_for_each_ref(get_main_ref_store(the_repository),
diff --git a/read-cache.c b/read-cache.c
index 15d79839c205176f9161f537aa706dac44b3023c..38c36caa7fef4d44da74c29e059839d88426df15 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1523,7 +1523,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int t2_sum_scan = 0;
 
 	if (flags & REFRESH_PROGRESS && isatty(2))
-		progress = start_delayed_progress(_("Refresh index"),
+		progress = start_delayed_progress(the_repository,
+						  _("Refresh index"),
 						  istate->cache_nr);
 
 	trace_performance_enter();
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 44be2645e9c7cb66e54b07832bd84f6efe6fc772..1f75b7bd199aff9e332c2601e444ce7b165e78c2 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -17,10 +17,14 @@
  *
  * See 't0500-progress-display.sh' for examples.
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
 #define GIT_TEST_PROGRESS_ONLY
+
 #include "test-tool.h"
 #include "parse-options.h"
 #include "progress.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 
@@ -64,7 +68,7 @@ int cmd__progress(int argc, const char **argv)
 			else
 				die("invalid input: '%s'", line.buf);
 
-			progress = start_progress(title, total);
+			progress = start_progress(the_repository, title, total);
 		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
 			uint64_t item_count = strtoull(end, &end, 10);
 			if (*end != '\0')
diff --git a/unpack-trees.c b/unpack-trees.c
index b3be5d542f5fc5a02b8838101f7334ff44b2c626..334cb84f6531b588688d5a43c538c8d1a5f7e768 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -372,7 +372,8 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 			total++;
 	}
 
-	return start_delayed_progress(_("Updating files"), total);
+	return start_delayed_progress(the_repository,
+				      _("Updating files"), total);
 }
 
 static void setup_collided_checkout_detection(struct checkout *state,
@@ -1773,6 +1774,7 @@ static int clear_ce_flags(struct index_state *istate,
 	strbuf_reset(&prefix);
 	if (show_progress)
 		istate->progress = start_delayed_progress(
+					the_repository,
 					_("Updating index flags"),
 					istate->cache_nr);
 
diff --git a/walker.c b/walker.c
index 7cc9dbea46d64d6bd3336025d640f284a6202157..1cf3da02193531a17fd11dbd2e8aadf36f38b200 100644
--- a/walker.c
+++ b/walker.c
@@ -172,7 +172,8 @@ static int loop(struct walker *walker)
 	uint64_t nr = 0;
 
 	if (walker->get_progress)
-		progress = start_delayed_progress(_("Fetching objects"), 0);
+		progress = start_delayed_progress(the_repository,
+						  _("Fetching objects"), 0);
 
 	while (process_queue) {
 		struct object *obj = process_queue->item;

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

