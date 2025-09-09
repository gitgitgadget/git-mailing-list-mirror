Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B132145B
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415833; cv=none; b=oaWETaz3bDAlAlFxeB+f9OBptQ9EhsRuUbWSWj25ANy/yjOrTTlwHChDF3Eyi1CnwgytULiX28vUOQkPXbf1cLdLOaKiIm8sKzliFp3x469sv/IP7N4sdXeI2VwEFzcGscLmGIcIkJrJGvkvDiuQarm3ExyoNQtyhS1f7WLzeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415833; c=relaxed/simple;
	bh=qDQHJM0P8+LXGk7f85hhIoL8U7N+4Phzg1QZV2sUH9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0yaKoyFvzRy+A3R+EEtpy/CWLYEkOq3ZSLhv0HOvN3DpRe9pDqvxbTHb2YtJTIfqQ9eU4WwOnYtDiNdJw4xJ1duBaL7N4bgIgTj09XCfARzdnyPLkl4jDpm4TuqQtcTlPwRZxC4fWZSX2E6b8pLvln5KiSnbxA8jPvrCgHeiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ghAZiMS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTqEDwxA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ghAZiMS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTqEDwxA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7CCF140019F;
	Tue,  9 Sep 2025 07:03:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 07:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415830;
	 x=1757502230; bh=rvnjtHteAxJdE6R+GObOCWOPZ7kkFqWfQyBNCIIx7rU=; b=
	ghAZiMS1o0qXUGosAsTZwpliJkvSGSSpNHSD1os8zVf4z5DR+ZQqZKQDzjH3Czgo
	/NgOjb5i6VYCGqG41vcOEHn+rKlWLapB2gdVo2eaFCe7EIHGTf7Vzy6BfJH2fnRK
	Affx4MNSYkB2FcWCQMp71igJQgyj4AkoMbq6ldY9F0zt+2l2pPSrqJaHYU/mXyFU
	JpJ7dmpqhSG0crlnlUzYj41AdySwXgajtDBgo0rFSo1zb27J6uLMJNTQ9c/gKUSi
	imhS/fyzAwI/RMy/Uo397FC9SEDrV7ii+G3TkcDgFnYMdgU73IQumIz9hWkhIIbw
	M4t96fTBm9BkUTrxRwc9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415830; x=
	1757502230; bh=rvnjtHteAxJdE6R+GObOCWOPZ7kkFqWfQyBNCIIx7rU=; b=o
	TqEDwxA7DzUOZIO9TaITNtJqacbMoMfVxTfT4MyoQ+ah2WsWs69qX8VffE/uBYAw
	hM/efnDdFyZQT6RRBUP5I1DTV0N0wNmnFBHiUW9k5d7sP1YbBvyo+F0Vx9YLQ/PK
	EihRzJAubOHTN5AssxRBhBuB93c5n/HEbXKHayZ6Gn4/H/H+mO8XuC81bBtKdT+Z
	WJK2flOT+YfTcAHYHHTqMdAN0wgdDOzkjoKkttdHi5wSryQP2pXBS5hWeW47czVY
	EEZ5eiLwmx7tb7kPTrOQOCmMxAprXyeYpDW7Op6rmW3rFi3uzRJxMq9+JFoPc7hc
	Edj3Lb3fH2K9YtJT0KAng==
X-ME-Sender: <xms:lgnAaE-yKhZHx4_mP_yk6EArj-ksU0cKapGjxoDIlQU8oLAVHlxraw>
    <xme:lgnAaIN4R1KFIlrLTI1clOU5FkzslmvRTxEKfHo-fG23c9T8UTlrwmGWvZvxvUYnI
    i7B7HBolo8zLAmCng>
X-ME-Received: <xmr:lgnAaAcsGXdi4KOXqdjrTiSVq9whxOdXuJAiS0jDa9oA4sFPPspvva8ayPFo_duTNTOqcrYupuoqJeB1lMHfUZBASR6a_nPN3pofbN4C3JM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lgnAaPXFzzDw1zMW15xd0R6HqBwHajhcgkyOYkEsL4oPFDGtAX7OcQ>
    <xmx:lgnAaAjBKWwtzI_KJfSWvTKW7pVqdfe9scV1kLD-42KGt2KxmdLDpA>
    <xmx:lgnAaG-ozcoF1W_ZFp1DeJpMNGbZruF-Dwh8M4Gq8lYNf1x89edsSQ>
    <xmx:lgnAaKayqZ5uD0F90E-_O0OkRsrwVSFNcxu5ahvAAJISEMBFZBqTuQ>
    <xmx:lgnAaCiCEbrjHJ7jkOPl-DG3Q8BxHklQGwCZZIuQYjB7lxd2rizo4Fbp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5bd668e8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:13 +0200
Subject: [PATCH v4 14/15] packfile: refactor `get_all_packs()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-14-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `get_all_packs()` function prepares the packfile store and then
returns its packfiles. Refactor it to accept a packfile store instead of
a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c          |  3 ++-
 builtin/count-objects.c     |  3 ++-
 builtin/fast-import.c       |  6 ++++--
 builtin/fsck.c              | 11 +++++++----
 builtin/gc.c                | 10 ++++++----
 builtin/pack-objects.c      | 28 +++++++++++++++++++---------
 builtin/pack-redundant.c    |  6 ++++--
 builtin/repack.c            |  9 ++++++---
 connected.c                 |  3 ++-
 http-backend.c              |  5 +++--
 http.c                      |  3 ++-
 object-name.c               |  4 ++--
 pack-bitmap.c               |  4 ++--
 pack-objects.c              |  3 ++-
 packfile.c                  | 12 ++++++------
 packfile.h                  |  7 ++++++-
 server-info.c               |  3 ++-
 t/helper/test-find-pack.c   |  2 +-
 t/helper/test-pack-mtimes.c |  2 +-
 19 files changed, 79 insertions(+), 45 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fce0b06451c..461eb2a6e09 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -852,9 +852,10 @@ static void batch_each_object(struct batch_options *opt,
 
 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
 						 batch_one_object_bitmapped, &payload)) {
+		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *pack;
 
-		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
+		for (pack = packfile_store_get_packs(packs); pack; pack = pack->next) {
 			if (bitmap_index_contains_pack(bitmap, pack) ||
 			    open_pack_index(pack))
 				continue;
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a61d3b46aac..cb03c580553 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -122,6 +122,7 @@ int cmd_count_objects(int argc,
 				      count_loose, count_cruft, NULL, NULL);
 
 	if (verbose) {
+		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
 		unsigned long num_pack = 0;
 		off_t size_pack = 0;
@@ -129,7 +130,7 @@ int cmd_count_objects(int argc,
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 
-		for (p = get_all_packs(the_repository); p; p = p->next) {
+		for (p = packfile_store_get_packs(packs); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index a26e79689d5..fea914cf9eb 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -952,6 +952,7 @@ static int store_object(
 	struct object_id *oidout,
 	uintmax_t mark)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	void *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
@@ -975,7 +976,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1092,6 +1093,7 @@ static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 
 static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
 	unsigned char *in_buf = xmalloc(in_sz);
 	unsigned char *out_buf = xmalloc(out_sz);
@@ -1175,7 +1177,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d2eb9d4fbe9..cabf5401c9f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -867,19 +867,20 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
 
 static int check_pack_rev_indexes(struct repository *r, int show_progress)
 {
+	struct packfile_store *packs = r->objects->packfiles;
 	struct progress *progress = NULL;
 	uint32_t pack_count = 0;
 	int res = 0;
 
 	if (show_progress) {
-		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
+		for (struct packed_git *p = packfile_store_get_packs(packs); p; p = p->next)
 			pack_count++;
 		progress = start_delayed_progress(the_repository,
 						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
-	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
+	for (struct packed_git *p = packfile_store_get_packs(packs); p; p = p->next) {
 		int load_error = load_pack_revindex_from_disk(p);
 
 		if (load_error < 0) {
@@ -999,6 +1000,8 @@ int cmd_fsck(int argc,
 		for_each_packed_object(the_repository,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
+		struct packfile_store *packs = the_repository->objects->packfiles;
+
 		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next)
 			fsck_source(source);
@@ -1009,7 +1012,7 @@ int cmd_fsck(int argc,
 			struct progress *progress = NULL;
 
 			if (show_progress) {
-				for (p = get_all_packs(the_repository); p;
+				for (p = packfile_store_get_packs(packs); p;
 				     p = p->next) {
 					if (open_pack_index(p))
 						continue;
@@ -1019,7 +1022,7 @@ int cmd_fsck(int argc,
 				progress = start_progress(the_repository,
 							  _("Checking objects"), total);
 			}
-			for (p = get_all_packs(the_repository); p;
+			for (p = packfile_store_get_packs(packs); p;
 			     p = p->next) {
 				/* verify gives error messages itself */
 				if (verify_pack(the_repository,
diff --git a/builtin/gc.c b/builtin/gc.c
index b3eec213d25..c0a3b54ce74 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -487,9 +487,10 @@ static int too_many_loose_objects(struct gc_config *cfg)
 static struct packed_git *find_base_packs(struct string_list *packs,
 					  unsigned long limit)
 {
+	struct packfile_store *packfiles = the_repository->objects->packfiles;
 	struct packed_git *p, *base = NULL;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packfiles); p; p = p->next) {
 		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
@@ -508,13 +509,14 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 
 static int too_many_packs(struct gc_config *cfg)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	int cnt;
 
 	if (cfg->gc_auto_pack_limit <= 0)
 		return 0;
 
-	for (cnt = 0, p = get_all_packs(the_repository); p; p = p->next) {
+	for (cnt = 0, p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
@@ -1423,7 +1425,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = get_all_packs(the_repository);
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)
@@ -1492,7 +1494,7 @@ static off_t get_auto_pack_size(void)
 	struct repository *r = the_repository;
 
 	odb_reprepare(r->objects);
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
 			max_size = p->pack_size;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1494afcf3df..914c6e641d0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3831,6 +3831,7 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 
 static void read_packs_list_from_stdin(struct rev_info *revs)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list include_packs = STRING_LIST_INIT_DUP;
 	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
@@ -3855,7 +3856,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_sort(&exclude_packs);
 	string_list_remove_duplicates(&exclude_packs, 0);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		const char *pack_name = pack_basename(p);
 
 		if ((item = string_list_lookup(&include_packs, pack_name)))
@@ -4076,6 +4077,7 @@ static void enumerate_cruft_objects(void)
 
 static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	struct rev_info revs;
 	int ret;
@@ -4105,7 +4107,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
 	 */
-	for (p = get_all_packs(the_repository); p; p = p->next)
+	for (p = packfile_store_get_packs(packs); p; p = p->next)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
 
@@ -4122,6 +4124,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 
 static void read_cruft_objects(void)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list discard_packs = STRING_LIST_INIT_DUP;
 	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
@@ -4142,7 +4145,7 @@ static void read_cruft_objects(void)
 	string_list_sort(&discard_packs);
 	string_list_sort(&fresh_packs);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		const char *pack_name = pack_basename(p);
 		struct string_list_item *item;
 
@@ -4390,11 +4393,12 @@ static void add_unreachable_loose_objects(struct rev_info *revs)
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
 
 	p = (last_found != (void *)1) ? last_found :
-					get_all_packs(the_repository);
+					packfile_store_get_packs(packs);
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
@@ -4404,7 +4408,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 			return 1;
 		}
 		if (p == last_found)
-			p = get_all_packs(the_repository);
+			p = packfile_store_get_packs(packs);
 		else
 			p = p->next;
 		if (p == last_found)
@@ -4436,12 +4440,13 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 
 static void loosen_unused_packed_objects(void)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	uint32_t i;
 	uint32_t loosened_objects_nr = 0;
 	struct object_id oid;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
@@ -4742,12 +4747,13 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 
 static void add_extra_kept_packs(const struct string_list *names)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 
 	if (!names->nr)
 		return;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		const char *name = basename(p->pack_name);
 		int i;
 
@@ -5185,8 +5191,10 @@ int cmd_pack_objects(int argc,
 
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
+		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
-		for (p = get_all_packs(the_repository); p; p = p->next)
+
+		for (p = packfile_store_get_packs(packs); p; p = p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -5198,8 +5206,10 @@ int cmd_pack_objects(int argc,
 		 * want to unset "local" based on looking at packs, as
 		 * it also covers non-local objects
 		 */
+		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
-		for (p = get_all_packs(the_repository); p; p = p->next) {
+
+		for (p = packfile_store_get_packs(packs); p; p = p->next) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index fe81c293e3a..721c4e04d5c 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -566,7 +566,8 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p = get_all_packs(the_repository);
+	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packed_git *p = packfile_store_get_packs(packs);
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
@@ -581,7 +582,8 @@ static struct pack_list * add_pack_file(const char *filename)
 
 static void load_all(void)
 {
-	struct packed_git *p = get_all_packs(the_repository);
+	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packed_git *p = packfile_store_get_packs(packs);
 
 	while (p) {
 		add_pack(p);
diff --git a/builtin/repack.c b/builtin/repack.c
index 5ff27fc8e29..2579090abbd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -265,10 +265,11 @@ static void existing_packs_release(struct existing_packs *existing)
 static void collect_pack_filenames(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		int i;
 		const char *base;
 
@@ -497,10 +498,11 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
 			       const struct pack_objects_args *args)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
@@ -1137,11 +1139,12 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 				      struct existing_packs *existing)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (!(p->is_cruft && p->pack_local))
 			continue;
 
diff --git a/connected.c b/connected.c
index d6e9682fd93..56fedb923d5 100644
--- a/connected.c
+++ b/connected.c
@@ -74,9 +74,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 */
 		odb_reprepare(the_repository->objects);
 		do {
+			struct packfile_store *packs = the_repository->objects->packfiles;
 			struct packed_git *p;
 
-			for (p = get_all_packs(the_repository); p; p = p->next) {
+			for (p = packfile_store_get_packs(packs); p; p = p->next) {
 				if (!p->pack_promisor)
 					continue;
 				if (find_pack_entry_one(oid, p))
diff --git a/http-backend.c b/http-backend.c
index d5dfe762bb5..c95aa51b45c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -603,18 +603,19 @@ static void get_head(struct strbuf *hdr, char *arg UNUSED)
 static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 {
 	size_t objdirlen = strlen(repo_get_object_directory(the_repository));
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct strbuf buf = STRBUF_INIT;
 	struct packed_git *p;
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
 	}
 
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
diff --git a/http.c b/http.c
index af2120b64c7..321648a81e6 100644
--- a/http.c
+++ b/http.c
@@ -2408,6 +2408,7 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	unsigned char *sha1, const char *base_url)
 {
+	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *new_pack, *p;
 	char *tmp_idx = NULL;
 	int ret;
@@ -2416,7 +2417,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	 * If we already have the pack locally, no need to fetch its index or
 	 * even add it to list; we already have all of its objects.
 	 */
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		if (hasheq(p->hash, sha1, the_repository->hash_algo))
 			return 0;
 	}
diff --git a/object-name.c b/object-name.c
index ecffd2d5b12..53356819a3d 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = get_all_packs(ds->repo); p && !ds->ambiguous;
+	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -806,7 +806,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = get_all_packs(mad->repo); p; p = p->next)
+	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 058bdb5d7de..834c300aab7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -664,7 +664,7 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
 			/*
@@ -3362,7 +3362,7 @@ int verify_bitmap_files(struct repository *r)
 		free(midx_bitmap_name);
 	}
 
-	for (struct packed_git *p = get_all_packs(r);
+	for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles);
 	     p; p = p->next) {
 		char *pack_bitmap_name = pack_bitmap_filename(p);
 		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
diff --git a/pack-objects.c b/pack-objects.c
index a9d9855063a..668c1136673 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -86,6 +86,7 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 
 static void prepare_in_pack_by_idx(struct packing_data *pdata)
 {
+	struct packfile_store *packs = pdata->repo->objects->packfiles;
 	struct packed_git **mapping, *p;
 	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
 
@@ -95,7 +96,7 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] = NULL;
-	for (p = get_all_packs(pdata->repo); p; p = p->next, cnt++) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next, cnt++) {
 		if (cnt == nr) {
 			free(mapping);
 			return;
diff --git a/packfile.c b/packfile.c
index 3d975e47f52..8c45d7d1168 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,11 +1027,11 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *get_all_packs(struct repository *r)
+struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
+	packfile_store_prepare(store);
 
-	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+	for (struct odb_source *source = store->odb->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
 		if (!m)
 			continue;
@@ -1039,7 +1039,7 @@ struct packed_git *get_all_packs(struct repository *r)
 			prepare_midx_pack(m, i);
 	}
 
-	return r->objects->packfiles->packs;
+	return store->packs;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
@@ -2099,7 +2099,7 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		 * covers, one kept and one not kept, but the midx returns only
 		 * the non-kept version.
 		 */
-		for (p = get_all_packs(r); p; p = p->next) {
+		for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
 			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
@@ -2196,7 +2196,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	for (p = get_all_packs(repo); p; p = p->next) {
+	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
diff --git a/packfile.h b/packfile.h
index 34c2132863a..86f2c07101f 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,6 +136,12 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Get all packs managed by the given store, including packfiles that are
+ * referenced by multi-pack indices.
+ */
+struct packed_git *packfile_store_get_packs(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -221,7 +227,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct list_head *get_packed_git_mru(struct repository *r);
-struct packed_git *get_all_packs(struct repository *r);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/server-info.c b/server-info.c
index 9bb30d9ab71..d949dea3094 100644
--- a/server-info.c
+++ b/server-info.c
@@ -287,12 +287,13 @@ static int compare_info(const void *a_, const void *b_)
 
 static void init_pack_info(struct repository *r, const char *infofile, int force)
 {
+	struct packfile_store *packs = r->objects->packfiles;
 	struct packed_git *p;
 	int stale;
 	int i;
 	size_t alloc = 0;
 
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 611a13a3261..183a777fc54 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -39,7 +39,7 @@ int cmd__find_pack(int argc, const char **argv)
 	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("cannot parse %s as an object name", argv[0]);
 
-	for (p = get_all_packs(the_repository); p; p = p->next)
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
 		if (find_pack_entry_one(&oid, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index d51aaa3dc40..cfdfae77a6c 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -37,7 +37,7 @@ int cmd__pack_mtimes(int argc, const char **argv)
 	if (argc != 2)
 		usage(pack_mtimes_usage);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		strbuf_addstr(&buf, basename(p->pack_name));
 		strbuf_strip_suffix(&buf, ".pack");
 		strbuf_addstr(&buf, ".mtimes");

-- 
2.51.0.450.g87641ccf93.dirty

