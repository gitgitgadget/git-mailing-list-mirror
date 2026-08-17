Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E143FB7FC
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964977; cv=none; b=NHCZmQHNApmwrqc19mJk2twWNZEnnGYbtaYLnainMDwRlNiAbSJZRqJltQvq6gl+2CQ19CvZgzmjHhOHdmKYQajEZ7XpRJex3Ky/gLMPMf8j35ceM/XoBPsKAv9CZCuLBXfGfgwYZjgiVzYh+xLYxDYXyCjzjMqYTyg7pXkQGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964977; c=relaxed/simple;
	bh=ZinVjA+yBdzmObnASxKLHWQQyNPrYf4dZWQJTNqrzMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7JOGTv4ch9+1PBowaYBMRrTTujVrc0LtF0fr+U4x4QHLsvHJcDJ/SCaSvhEKB5wA5ghz4xviyOBG/xldvVAOIJ9nCbr/brvYnx/Nl5MhmfZ82A5lvcom8BX2w/tcejZj2CGc1m6IrQ7lEFnavRSLBWVy7YPd+uLxJ7STtke+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XUL+quVz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PpXCrygN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XUL+quVz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PpXCrygN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96DA91400066;
	Mon, 17 Aug 2026 07:09:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 07:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786964974;
	 x=1787051374; bh=LUaMu3wyZV94qk+aHzUCxoNdc+8gwqiDuNjO/aal6kI=; b=
	XUL+quVzTozCNe10wUWzWkraFDpaeE3SM6TyeE29dypcVUtmrNAsb4uG6sTRCqm4
	QUex9gf+AjN6cTZ6b4ptJU8LPWHH+PdgC57hgYxxz8uOBca0Q2Pbqpb/bw52mVjC
	xRJtpEj8TpQ9/pOTuJb40LsRkbzNGYFjYIdOHysYuHANeyJ49KkBoy7UvUM2esNW
	CH6tLbHU68wR4920DJ0hr6ptRl3/V5WaL82EBgHEbpJaKFQryxlZQoCPhLMsgmd0
	d+zY5+DISQjCMCYIkCtq2LPQZWzAjL1HfqRx34Nn9/TD26TIxp7azmDeqCFCE4oa
	cZ0umBqdKlKo8/SzdZ+eEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786964974; x=
	1787051374; bh=LUaMu3wyZV94qk+aHzUCxoNdc+8gwqiDuNjO/aal6kI=; b=P
	pXCrygN9cDrktB1M2yQVP9IFMwvAyyIgLJLmKy2Bm2AC/jkQYLxTzoe9eosFlvVc
	H+pwY51i341bweS3DcUe/F5Py0NfOakn0InN7tE0h3GcUkHxE4HX663AI0WIHoDE
	2/Xc5YCwL+wr36Qyq+hmj88Ad/TtIJ0d+bq9moohjtzAGTAcT4KkVPiwh6tyzEKV
	vBA9e5z+EwjrhtozOkP0DJ1N3eciv5Wif5MiFVQc5XDcaUSIlbdNQYAVkVaoDTQl
	TSQ1AjcgnhhOIQKozp26xHQJ6urydaGrtYUKH33aK40kmv2DmiVpp77B3hrrueuI
	kloDMQWKWi3Y63LxbnZew==
X-ME-Sender: <xms:7uuCals_MSu9gHUhn8Gz80uHjtiRGmyynF5T_zRkOLKrvHU7d5Y9VA>
    <xme:7uuCald89leJV5DlJpAQ4UPiNcO4_WXIxp5NDtHDXOWtgIHa3-VcEOBj-gwf8V1Wo
    JXOfmsZtBTgUu4hr1MU1S6WY-xaaXImkEi9k5LtWjus1PlhMRGkzdw>
X-ME-Received: <xmr:7uuCatwox2crDPCgIiiPOsNXZOAxw8_lwR6yPJ07B7SkFUT-J2eVLE7QqRSVnBtUQXK9j3-HTgZxqatv5dyYUR_YuqWKQL0sBrhyF7ZLGw>
X-ME-Proxy-Cause: dmFkZTE0eWXkes4XlOQBdKc18d880nW6QfIMWFYb7a8QQf4iZJSFuinH1Y7BJmr1nulgyL
    /gCAPq4KSfNVDgdjkIT4hVSdBswG45MGLiWeiqP8FyfzC6A9fqNtxZYerIVMs6pAXrY5OW
    LIip91M1XjiXpn20gjr/OWRRESaE2gszqRePJgKGg8fFk6p3XbPmFvhS/tnb5Y/3RV32Hn
    ouSktO+rf4GbVK1+oj4bVUOHoMv2nVR7YmbbPAAfW+TIjwooYOeYVHrv93kYB8eg7HV8ME
    7+EQZjBmp1WQax6pxz7LcHraJsZKxOFqu4KJNGgu6omnT+HjcMcIXT94xPHduRUXMb7Gms
    8HniJES6w62N1lNkLZGfWKEvai0x43/OOmvJI7+p+rVbT3haPAY5nWvetYA1syqjVzL1bP
    NO16UYz6rEOiQl8Gf/S3qPBjnLBhRl93qIiYxmlNwFf91EHiZUtRKkPDhwbVB7tH/zOXkb
    +14MjNzVds/JhcWLyA6+BQ7EkFMhrn0vbuEFU4juHb1tk4xrh6Ko7JHpFP5KbVH94UgPoL
    na7StHFoP0Pzf4aGSrdptPqerE530lIHxqnoI258qm1NV+SUO9mrgwoegrp6a/JYje+P3c
    2GE+kXcUXepspaguu3yTbcI3Bhq303c77+K2lP+HYP/D2d2CBJqfe55Rp/aA
X-ME-Proxy: <xmx:7uuCarEbcmrnWPbNZMsJeMEOtBJED2FwtGx51iIXdXAQ5109ui1zBw>
    <xmx:7uuCahwG5IkS_a2Jm6TccIHRol6nJ9xF0FVy7yOvqeKbprsTHYIQHQ>
    <xmx:7uuCassP-sswpWSAbdrj7wOGjbQW8iwgdZFnoS-tPZn3upNPV9ATqA>
    <xmx:7uuCau0uuKQJTFzWm5ACnrQ7KxqL792tjlu87o1-InHflcZH3z4vWg>
    <xmx:7uuCapuaSw2VU_9x8DV0XCKoZY08M0P0LcBGD1nfh1m4gNhRNvHRIsQP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:09:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c92f039c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 11:09:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 13:09:23 +0200
Subject: [PATCH v3 3/5] odb: eagerly initialize alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pks-odb-eagerly-prepare-alternates-v3-3-1115a7e02467@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index 22f1425ba5..d4917c3678 100644
--- a/odb.c
+++ b/odb.c
@@ -252,11 +252,6 @@ void odb_add_to_alternates_file(struct object_database *odb,
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
 
@@ -265,12 +260,6 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
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
@@ -376,7 +365,6 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
 		strbuf_realpath(&odb_path_real, source->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
@@ -510,7 +498,6 @@ int odb_for_each_alternate(struct object_database *odb,
 	struct odb_source *alternate;
 	int r = 0;
 
-	odb_prepare_alternates(odb);
 	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
 		r = cb(alternate, payload);
 		if (r)
@@ -519,7 +506,7 @@ int odb_for_each_alternate(struct object_database *odb,
 	return r;
 }
 
-void odb_prepare_alternates(struct object_database *odb)
+static void odb_prepare_alternates(struct object_database *odb)
 {
 	struct strvec sources = STRVEC_INIT;
 
@@ -538,7 +525,6 @@ void odb_prepare_alternates(struct object_database *odb)
 
 int odb_has_alternates(struct object_database *odb)
 {
-	odb_prepare_alternates(odb);
 	return !!odb->sources->next;
 }
 
@@ -598,8 +584,6 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags))
 		return 0;
 
-	odb_prepare_alternates(odb);
-
 	while (1) {
 		struct odb_source *source;
 
@@ -862,7 +846,6 @@ int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid)
 {
 	struct odb_source *source;
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next)
 		if (odb_source_freshen_object(source, oid, NULL))
 			return 1;
@@ -877,7 +860,6 @@ int odb_for_each_object_ext(struct object_database *odb,
 {
 	int ret;
 
-	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
 		if (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
 			continue;
@@ -915,7 +897,6 @@ int odb_count_objects(struct object_database *odb,
 		return 0;
 	}
 
-	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
 		unsigned long c;
 
@@ -995,7 +976,6 @@ int odb_find_abbrev_len(struct object_database *odb,
 		goto out;
 	}
 
-	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
 		ret = odb_source_find_abbrev_len(source, oid, len, &len);
 		if (ret)
@@ -1106,6 +1086,8 @@ struct object_database *odb_new(struct repository *repo,
 	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
+	odb_prepare_alternates(o);
+
 	free(primary_source);
 	return o;
 }
@@ -1166,10 +1148,10 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
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
2.55.0.822.g20453c30eb.dirty

