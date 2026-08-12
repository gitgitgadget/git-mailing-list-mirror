Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24473EC82E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526058; cv=none; b=O5lI2jbJ5lbOuB9MFvt1Q2KRcEQNLefgssGZkoRiZH6VQZfdTbeysQyP5SSCu4chInBJQ+b3BSjnpR5dwBhawmPbaGn62wu3qynhln5SqWnl8zIxaiP+bpSBAcA9Xu4WHBQ0o5LMmElIkN2ABb7AQ5dPinWv+FLMNQhIewpxGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526058; c=relaxed/simple;
	bh=gCSJUDRrjjgtE3/+ZcVir/VnJgvNnOhYHDqR/Iuko2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGy3UxiCyevIoI/M3emVY6lmBHMmHFbYa0+u+e/H6ykJofdF98QBlW5r32P1kTy1fbZEhXdCueKYIfhbQepRlkNIOdSIwsuIIfjqi6SC3r039/TwnADSUhlOWNhCCbwalGwFIhxVkbB9iancs9K6kzMrSqY2T2mI/8B6SEfPCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UmIwuG5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PF2oN5Oa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UmIwuG5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PF2oN5Oa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6463314000FD;
	Wed, 12 Aug 2026 05:14:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 05:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786526053;
	 x=1786612453; bh=gfH9IlnICXIfTpbOLPTQm5StGSSI6v/5qj3jxWlxcWg=; b=
	UmIwuG5CSNmmhRuIUDwnwerDEiB8AGU895jt0fokCNaJgg81gIwiOVyHkOqJvBXl
	Tlb1QQaodeKrdu6l/ayL4XYe+PcJjold2KgZVZixD5IOtAVHbV6EJ5Uz5/PsY33A
	3CIlbfxPDSFGRGIqIseN1F+SKfjeSumsayq5dUJYxtSjmLG7avwcizZ5t7x0/unQ
	Pka6873YOUwXWNPNS8d3PuMyqLuHsgndvAscGuLEJsv9mTVstGHFUgO9/mZQLsYb
	64Vleg5XrCx+pyNWew195705Q3jml+r43jOFHs6vv7SEksnSHH7wvVQ5Mi3aA+FP
	p9+8btFZLYModQFAB4XX2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786526053; x=
	1786612453; bh=gfH9IlnICXIfTpbOLPTQm5StGSSI6v/5qj3jxWlxcWg=; b=P
	F2oN5OaxSb/NQUhCvogWGRQfXOL4DfRKG7NTe+4c3lijs3bXMo+HeJs3v+nuk8sm
	9LltOLq2NxQ+8Sm6zSPaK785Cm0cJaVK05fTkQdco7cpkiS7pFFAevNQCLpn6QVI
	SGfV5XbiFKdNaWro4CsCfUQp0AzKXHaIqTOcIu8e4blpLRVcuDYZRNr00iaeGiUS
	MOZ7eaplPjsFhWY9n77L0WkYBWPo2WUOXQBPYwNDoBtEKIGhAJJ25dMU99ojUSJU
	FFytMQY65O2ZSEXA+y9XuwLtmsfcTbcACTHjuTxS+H2E3Zlg5gT968+hatIVNr1b
	f/bpvncKsvbwtxMfchwaQ==
X-ME-Sender: <xms:ZTl8aiiOZ6TPNVcOHIpcFm4HaUwry45m_RpTTX2__J4c73WlBEV72Q>
    <xme:ZTl8apAWQ5-ouXiMmgpRCbYBpGPQFmzsMLREdbu70NDyLx_lu6xS45WsvTFx6wsfx
    lGrSiPEDhYwN3xENBxeH0UuEhcgHcubzHADqwHtilGrEhtONQ0mXg>
X-ME-Received: <xmr:ZTl8anvx3vYsq2-iDr5-MCEZDIx2KmPpmmnEZp11TkMKekMzyzfJJvDlAzyMZAbtvitsdQonfE-f3BHVOOXCDUfRxsDvC3FofHGdnv3nyA>
X-ME-Proxy-Cause: dmFkZTF1ikDNmXNl5XfIDqNninmRif7z5Lfmk3ugFf8hnACpeOQdPc2+dupsug77UWHRuJ
    ticuIOQAWRQqnot4uWGkntmyebsNZTngCzpPOWfx/lFuuZBmBi2uQHZfr34nIjb/e0h4Dw
    3VNRvI6VS16N4Nj2LqWKUw9pR1IgRPRfdlaR1VVFYN8LkIWZt13QKLSKAVxpwT3xe4h+km
    8hZ16tHZuM1LONjYn+6T7T79X/mNt6nPWXAZ0PXJoseOpSegd0GdL85AMtzsZKLj2vnRg6
    fbvduZbsoj9tt4XW4dwiQuyDQiSRjQH/j4vxPXl/AJBvq7t4K/jKtbi4/vAprm/TOnmnM5
    goMJELQKGYwXDWVenA6jrBBIkciBwIMka4x5I2vGRExYp9I0YeA5kVZTWAnUqX2PfZqWPz
    KfDd4DSAwvGeYCT48dw7djjBQONp/9+6AMWaTjH8vGv0IGYfROU3HZ/iliSvnM4KFWTlcg
    0l/lNwhHVZDXjhRFebUqe8W6LlzlfxjailnkHSDk/O3zfceWDXjte2fuuAXixYdCdWT7FK
    deoweDI7M5GEipPe2bV3teN2SyOamcOMfm5FIg9pGoKuOqgGZ2ALc/5PBKzSoqgH4nH2/P
    zGR8A1xlb+3Xl40lx3iRkb2wwzpqnTSYE4ZP0/q7pQZB2xfFkhVTUTcVao8A
X-ME-Proxy: <xmx:ZTl8amacH9kSKWReVikB6aw_5H6yROhw3njzHdg_q0sH3V_W220-yA>
    <xmx:ZTl8aiW5x2RmIQb71SkeW8TV3efDOqQbAPmBR6XkGQkznJ7bs9XdMA>
    <xmx:ZTl8ai7-FLtrm6qadUwvP1e21oJFZMs5CTL9TVKFGGxQN54zG8P3qQ>
    <xmx:ZTl8alhASpYiIPew3b41ASOC3oYKSumrgdXEFnJMI3oKOG4tV9AR_A>
    <xmx:ZTl8aqQrFRR6sojlrl3AVnkLh-OKwMOWvG5YtXA7qahZrZiWHdCoUk2c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:14:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23409ea5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 09:14:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Aug 2026 11:13:58 +0200
Subject: [PATCH v2 2/4] odb: eagerly initialize alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pks-odb-eagerly-prepare-alternates-v2-2-522b9a5bc1ea@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When creating the object database we initialize the main object database
source, but we don't yet initialize its alternates. Instead, we have
many calls to `odb_prepare_alternates()` cluttered around the code base
whenever we are about to iterate through the sources.

This lazy loading doesn't really add much value: the moment where we
read any object we _have_ to load the alternates anyway. So given that
most of our commands would access the object database this optimization
is not really buying us much in the first place. Quite on the contrary,
it makes the code harder to understand and is a potential source of bugs
in case any callsite forgot to prepare alternates before we iterate
through the sources.

Historically though there was a reason why we deferred lazy-loading: it
may happen that the repository has "core.ignoreCase" configured, and we
use that to deduplicate the list of alternates in case we had the same
alternate configured multiple times, but with different casing. We used
to initialize the object database before we had fully configured the
owning repository though, and consequently we couldn't access that
configuration yet. This has changed in the preceding commit though where
we started to parse "core.ignoreCase" manually.

Eagerly prepare alternates both when creating the object database and
when flushing its caches. Drop the now-unneeded calls to prepare the
alternates that are scattered across the code base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c         |  3 ---
 builtin/pack-objects.c |  3 ---
 commit-graph.c         |  4 ----
 loose.c                |  1 -
 object-name.c          |  1 -
 odb.c                  | 26 ++++----------------------
 odb.h                  |  6 ------
 odb/streaming.c        |  1 -
 pack-bitmap.c          |  2 --
 packfile.c             |  1 -
 packfile.h             |  2 --
 11 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a6c054e45b..892c5661d9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1069,7 +1069,6 @@ int cmd_fsck(int argc,
 		odb_for_each_object(repo->objects, NULL,
 				    mark_object_for_connectivity, repo, 0);
 	} else {
-		odb_prepare_alternates(repo->objects);
 		for (source = repo->objects->sources; source; source = source->next)
 			fsck_source(repo, source);
 
@@ -1155,7 +1154,6 @@ int cmd_fsck(int argc,
 	if (repo->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-		odb_prepare_alternates(repo->objects);
 		for (source = repo->objects->sources; source; source = source->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
@@ -1173,7 +1171,6 @@ int cmd_fsck(int argc,
 	if (repo->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 
-		odb_prepare_alternates(repo->objects);
 		for (source = repo->objects->sources; source; source = source->next) {
 			child_process_init(&midx_verify);
 			midx_verify.git_cmd = 1;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..48d37e8e32 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1779,8 +1779,6 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		*found_offset = 0;
 	}
 
-	odb_prepare_alternates(the_repository->objects);
-
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
@@ -4520,7 +4518,6 @@ static void add_objects_in_unpacked_packs(void)
 		.source_infop = &source_info,
 	};
 
-	odb_prepare_alternates(to_pack.repo->objects);
 	for (source = to_pack.repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 
diff --git a/commit-graph.c b/commit-graph.c
index 49e8f63930..983c11ce85 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -651,8 +651,6 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
-	odb_prepare_alternates(odb);
-
 	for (i = 0; i < count; i++) {
 		struct odb_source *source;
 
@@ -768,7 +766,6 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return NULL;
 
-	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		r->objects->commit_graph = read_commit_graph_one(source);
 		if (r->objects->commit_graph)
@@ -2018,7 +2015,6 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
 
-	odb_prepare_alternates(ctx->r->objects);
 	for (source = ctx->r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		odb_source_for_each_object(&files->packed->base, &oi, add_packed_commits_oi,
diff --git a/loose.c b/loose.c
index aa3cb1b4fc..c159d29d2d 100644
--- a/loose.c
+++ b/loose.c
@@ -115,7 +115,6 @@ int repo_read_loose_object_map(struct repository *repo)
 {
 	struct odb_source *source;
 
-	odb_prepare_alternates(repo->objects);
 	for (source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		if (loose_object_map_load(files->loose) < 0)
diff --git a/object-name.c b/object-name.c
index 83efba0ba6..34a08d76dd 100644
--- a/object-name.c
+++ b/object-name.c
@@ -280,7 +280,6 @@ static int init_object_disambiguation(struct repository *r,
 
 	ds->len = len;
 	ds->repo = r;
-	odb_prepare_alternates(r->objects);
 	return 0;
 }
 
diff --git a/odb.c b/odb.c
index 51da386f22..2ae8228dd2 100644
--- a/odb.c
+++ b/odb.c
@@ -237,11 +237,6 @@ void odb_add_to_alternates_file(struct object_database *odb,
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 						const char *dir)
 {
-	/*
-	 * Make sure alternates are initialized, or else our entry may be
-	 * overwritten when they are.
-	 */
-	odb_prepare_alternates(odb);
 	return odb_add_alternate_recursively(odb, dir, 0);
 }
 
@@ -250,12 +245,6 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 {
 	struct odb_source *source;
 
-	/*
-	 * Make sure alternates are initialized, or else our entry may be
-	 * overwritten when they are.
-	 */
-	odb_prepare_alternates(odb);
-
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
@@ -361,7 +350,6 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
 		strbuf_realpath(&odb_path_real, source->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
@@ -495,7 +483,6 @@ int odb_for_each_alternate(struct object_database *odb,
 	struct odb_source *alternate;
 	int r = 0;
 
-	odb_prepare_alternates(odb);
 	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
 		r = cb(alternate, payload);
 		if (r)
@@ -504,7 +491,7 @@ int odb_for_each_alternate(struct object_database *odb,
 	return r;
 }
 
-void odb_prepare_alternates(struct object_database *odb)
+static void odb_prepare_alternates(struct object_database *odb)
 {
 	struct strvec sources = STRVEC_INIT;
 
@@ -523,7 +510,6 @@ void odb_prepare_alternates(struct object_database *odb)
 
 int odb_has_alternates(struct object_database *odb)
 {
-	odb_prepare_alternates(odb);
 	return !!odb->sources->next;
 }
 
@@ -583,8 +569,6 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags))
 		return 0;
 
-	odb_prepare_alternates(odb);
-
 	while (1) {
 		struct odb_source *source;
 
@@ -847,7 +831,6 @@ int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid)
 {
 	struct odb_source *source;
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next)
 		if (odb_source_freshen_object(source, oid, NULL))
 			return 1;
@@ -862,7 +845,6 @@ int odb_for_each_object_ext(struct object_database *odb,
 {
 	int ret;
 
-	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
 		if (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
 			continue;
@@ -900,7 +882,6 @@ int odb_count_objects(struct object_database *odb,
 		return 0;
 	}
 
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
 		unsigned long c;
 
@@ -980,7 +961,6 @@ int odb_find_abbrev_len(struct object_database *odb,
 		goto out;
 	}
 
-	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
 		ret = odb_source_find_abbrev_len(source, oid, len, &len);
 		if (ret)
@@ -1091,6 +1071,8 @@ struct object_database *odb_new(struct repository *repo,
 	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
+	odb_prepare_alternates(o);
+
 	free(primary_source);
 	return o;
 }
@@ -1151,10 +1133,10 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
 		o->loaded_alternates = 0;
+		odb_prepare_alternates(o);
 		o->object_count_valid = 0;
 	}
 
-	odb_prepare_alternates(o);
 	for (source = o->sources; source; source = source->next)
 		odb_source_prepare(source, flags);
 
diff --git a/odb.h b/odb.h
index 71af7450a9..fbafee174b 100644
--- a/odb.h
+++ b/odb.h
@@ -273,12 +273,6 @@ void odb_for_each_alternate_ref(struct object_database *odb,
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern);
 
-/*
- * Prepare alternate object sources for the given database by reading
- * "objects/info/alternates" and opening the respective sources.
- */
-void odb_prepare_alternates(struct object_database *odb);
-
 /*
  * Check whether the object database has any alternates. The primary object
  * source does not count as alternate.
diff --git a/odb/streaming.c b/odb/streaming.c
index 20531e864c..37642768e9 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -184,7 +184,6 @@ static int istream_source(struct odb_read_stream **out,
 {
 	struct odb_source *source;
 
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next)
 		if (!odb_source_read_object_stream(out, source, oid))
 			return 0;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e85bd69ba4..e0fb57d332 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -717,7 +717,6 @@ static int open_bitmap(struct repository *r,
 
 	assert(!bitmap_git->map);
 
-	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 
@@ -3417,7 +3416,6 @@ int verify_bitmap_files(struct repository *r)
 	struct packed_git *p;
 	int res = 0;
 
-	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
diff --git a/packfile.c b/packfile.c
index 0eee45055f..d870de90ed 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1938,7 +1938,6 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 {
 	struct odb_source *source;
 
-	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0))
diff --git a/packfile.h b/packfile.h
index e1f77152b5..10de24f477 100644
--- a/packfile.h
+++ b/packfile.h
@@ -77,8 +77,6 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 {
 	struct repo_for_each_pack_data data = { 0 };
 
-	odb_prepare_alternates(repo->objects);
-
 	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);

-- 
2.55.0.679.g6767b8d81c.dirty

