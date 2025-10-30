Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9852DBF75
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820748; cv=none; b=SpqsN1pykCKALbbngsW0QFRZa4vqCcU3NqlZAIxWn6fUq5indQNIJ7VaBEV/WA4+Mnqu2vo+tkdJZjSL7sWPkFf9uj4js4pV5uPVTha0BqjB3mApvdLMRwgt8vAq0LVTeYHRI8KDkiPb4Uj1Z9eYTZ+jKPBJLlu3igfH20118DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820748; c=relaxed/simple;
	bh=CVPhveHP/a5vjR1QXm7k244OK5Mcq5uD/D+R2AHF/dY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/tKXIMJsV3GkUq/WgxpZkizRADht71grITl/dG0AvZ+nOiZjdd8d9Ay1SEyU1oObAdrFu4Wh+sFOGbMYXEsTWTpIhixCwMkUBCSCw8vA2rv2VBbncT2ylKPRCfYSUEiBSFsS+adtRIvIRzdJ1F0ovfn8+eyU/YHq/yY+BLCD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pd4Oz5ME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEfUrT+y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pd4Oz5ME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEfUrT+y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3EE1AEC01BD;
	Thu, 30 Oct 2025 06:39:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Oct 2025 06:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820744;
	 x=1761907144; bh=TasZfdAqFCWZrERCw/KzBmuB9l5Y8TTvzRJrXHF8X8E=; b=
	pd4Oz5MER4rXZc2a0bHk2924yxizbroeQ7im3zwEBcX9uoYf8t4LUv397C+DLk0l
	LJKqXmv86Awk1mixGtyqmI0yT3pUk5K40ForyPcl8BblU/flWOAIOnem9rERDlsW
	5nXZjPPF1cq5qftO9+rf54G6xpmDZJpq8aVgPSfSqDZrc8ZpRGuN8OJUYODQ0bhL
	/HL5ipQKIJazHGbXHWxKqbzFMXLTfRu7KGEA50RK52Q15+IJunaN+GwN68opaBtz
	aXTsGV8uY7bOUI1yOfBLafVDnNUsSBeSup2dmqVAyoFAVUxQ+4GzVveOtFLPKujs
	K0K+14zCby+sokVG0tkb4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820744; x=
	1761907144; bh=TasZfdAqFCWZrERCw/KzBmuB9l5Y8TTvzRJrXHF8X8E=; b=d
	EfUrT+yUpZOBqGlynQYaKDu2DscJUxXFQYip/UPjf5yC9k+j4WFa12EpOpGswhj7
	GgMdZ9g2uGjeYGncU/E/P6oZizbqcKnqTESOUosW/CDNS5xa9Q02guH1niA//PUN
	fkL9wXH9rAzen6YP2NfSSK7ikrooLGs7acc4KUZn6yMLHBnKtTlaupr9x3MQGw37
	r0HPsl0ESu2Mdho3bzvBePCYKUPA+dzxHMI79Zc00kEtbVCZfyf/qLaAjIqBVxS5
	8WiYxARUbYFG4wSGYep2K43vzlDIHaZ/2vuaAoG9uoijmg4xoefO6Te2G1qy+hN1
	GnEsSrXSNXj1Q2d6eJHSA==
X-ME-Sender: <xms:SEADaV_jACmwvJyE91BACgcZUXOgKQZBQY7iREIySfT2taM-yOaHOA>
    <xme:SEADaQvqaqLzErvx8JU85Q2Avgu7cDOpszGRIvXomuzKzrw2g3WehxneHeT_R5MEd
    kkr4oPnA0K577a80qsqdM6Vnfzsp4JUF3p5oCHdi2_WzDSpNpoqFj4>
X-ME-Received: <xmr:SEADaYCW2e8aeO96-BrWSPh6gqBaUvp23KaoqZiztSvYWmp8fE_e92o5qvtrfhp_icX43JhvLfDvUPg24_rIWjVlqXr6YiGJpgc4q5pccQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:SEADaYUi_DPeh1J_FCJaEQ5O-Ta_0yjO_dMFYj0AJokot9jNTyLyvA>
    <xmx:SEADaWBmO3-6GOhJwO9JtS6a5C9S3YdEdlwupfTXGRJDXHvBd7cVKw>
    <xmx:SEADab8kW3ml1xKOXYD4t1ZjDv_v7pkmAE7Lc0l-VnXfJeCSYEhofQ>
    <xmx:SEADadFS0Zi-apNixyAZBi6zH74_8jMIbWxCiUDxZLrwc_gcBJcyyA>
    <xmx:SEADabjcaVvOVsMHWDTDEmknmDz5JrbTWZT5g3vfZA8b2pWTieK3BysN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:39:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 221d1ac1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:39:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:43 +0100
Subject: [PATCH v2 6/8] packfile: move list of packs into the packfile
 store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-6-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

Move the list of packs into the packfile store. This follows the same
logic as in a previous commit, where we moved the most-recently-used
list of packs, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  4 +--
 packfile.c            | 83 +++++++++++++++++++++++----------------------------
 packfile.h            | 16 +++-------
 3 files changed, 43 insertions(+), 60 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 215295c1561..6fe6e9bc61d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -978,7 +978,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
+	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1179,7 +1179,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
+	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/packfile.c b/packfile.c
index b07509b69bd..71e95ae11c5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -356,13 +356,14 @@ static void scan_windows(struct packed_git *p,
 
 static int unuse_one_window(struct packed_git *current)
 {
-	struct packed_git *p, *lru_p = NULL;
+	struct packfile_list_entry *e;
+	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = current->repo->objects->packfiles->packs; p; p = p->next)
-		scan_windows(p, &lru_p, &lru_w, &lru_l);
+	for (e = current->repo->objects->packfiles->packs.head; e; e = e->next)
+		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
 		pack_mapped -= lru_w->len;
@@ -542,14 +543,15 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 
 static int close_one_pack(struct repository *r)
 {
-	struct packed_git *p, *lru_p = NULL;
+	struct packfile_list_entry *e;
+	struct packed_git *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = r->objects->packfiles->packs; p; p = p->next) {
-		if (p->pack_fd == -1)
+	for (e = r->objects->packfiles->packs.head; e; e = e->next) {
+		if (e->pack->pack_fd == -1)
 			continue;
-		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
+		find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
 	}
 
 	if (lru_p)
@@ -868,8 +870,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = store->packs;
-	store->packs = pack;
+	packfile_list_prepend(&store->packs, pack);
 
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
@@ -1046,9 +1047,10 @@ static void prepare_packed_git_one(struct odb_source *source)
 	string_list_clear(data.garbage, 0);
 }
 
-DEFINE_LIST_SORT(static, sort_packs, struct packed_git, next);
+DEFINE_LIST_SORT(static, sort_packs, struct packfile_list_entry, next);
 
-static int sort_pack(const struct packed_git *a, const struct packed_git *b)
+static int sort_pack(const struct packfile_list_entry *a,
+		     const struct packfile_list_entry *b)
 {
 	int st;
 
@@ -1058,7 +1060,7 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 	 * remote ones could be on a network mounted filesystem.
 	 * Favor local ones for these reasons.
 	 */
-	st = a->pack_local - b->pack_local;
+	st = a->pack->pack_local - b->pack->pack_local;
 	if (st)
 		return -st;
 
@@ -1067,21 +1069,19 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 	 * and more recent objects tend to get accessed more
 	 * often.
 	 */
-	if (a->mtime < b->mtime)
+	if (a->pack->mtime < b->pack->mtime)
 		return 1;
-	else if (a->mtime == b->mtime)
+	else if (a->pack->mtime == b->pack->mtime)
 		return 0;
 	return -1;
 }
 
 static void packfile_store_prepare_mru(struct packfile_store *store)
 {
-	struct packed_git *p;
-
 	packfile_list_clear(&store->mru);
 
-	for (p = store->packs; p; p = p->next)
-		packfile_list_append(&store->mru, p);
+	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
+		packfile_list_append(&store->mru, e->pack);
 }
 
 void packfile_store_prepare(struct packfile_store *store)
@@ -1096,7 +1096,11 @@ void packfile_store_prepare(struct packfile_store *store)
 		prepare_multi_pack_index_one(source);
 		prepare_packed_git_one(source);
 	}
-	sort_packs(&store->packs, sort_pack);
+
+	sort_packs(&store->packs.head, sort_pack);
+	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
+		if (!e->next)
+			store->packs.tail = e;
 
 	packfile_store_prepare_mru(store);
 	store->initialized = true;
@@ -1108,7 +1112,7 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *packfile_store_get_packs(struct packfile_store *store)
+struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store)
 {
 	packfile_store_prepare(store);
 
@@ -1120,7 +1124,7 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 			prepare_midx_pack(m, i);
 	}
 
-	return store->packs;
+	return store->packs.head;
 }
 
 struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store)
@@ -1276,11 +1280,11 @@ void mark_bad_packed_object(struct packed_git *p, const struct object_id *oid)
 const struct packed_git *has_packed_and_bad(struct repository *r,
 					    const struct object_id *oid)
 {
-	struct packed_git *p;
+	struct packfile_list_entry *e;
 
-	for (p = r->objects->packfiles->packs; p; p = p->next)
-		if (oidset_contains(&p->bad_objects, oid))
-			return p;
+	for (e = r->objects->packfiles->packs.head; e; e = e->next)
+		if (oidset_contains(&e->pack->bad_objects, oid))
+			return e->pack;
 	return NULL;
 }
 
@@ -2088,19 +2092,6 @@ int is_pack_valid(struct packed_git *p)
 	return !open_packed_git(p);
 }
 
-struct packed_git *find_oid_pack(const struct object_id *oid,
-				 struct packed_git *packs)
-{
-	struct packed_git *p;
-
-	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(oid, p))
-			return p;
-	}
-	return NULL;
-
-}
-
 static int fill_pack_entry(const struct object_id *oid,
 			   struct pack_entry *e,
 			   struct packed_git *p)
@@ -2139,7 +2130,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
 
-	if (!r->objects->packfiles->packs)
+	if (!r->objects->packfiles->packs.head)
 		return 0;
 
 	for (l = r->objects->packfiles->mru.head; l; l = l->next) {
@@ -2404,19 +2395,19 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
 
 void packfile_store_free(struct packfile_store *store)
 {
-	for (struct packed_git *p = store->packs, *next; p; p = next) {
-		next = p->next;
-		free(p);
-	}
+	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
+		free(e->pack);
+	packfile_list_clear(&store->packs);
+
 	strmap_clear(&store->packs_by_path, 0);
 	free(store);
 }
 
 void packfile_store_close(struct packfile_store *store)
 {
-	for (struct packed_git *p = store->packs; p; p = p->next) {
-		if (p->do_not_close)
+	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
+		if (e->pack->do_not_close)
 			BUG("want to close pack marked 'do-not-close'");
-		close_pack(p);
+		close_pack(e->pack);
 	}
 }
diff --git a/packfile.h b/packfile.h
index a53336d722a..d95275e666c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -11,7 +11,6 @@
 struct object_info;
 
 struct packed_git {
-	struct packed_git *next;
 	struct pack_window *windows;
 	off_t pack_size;
 	const void *index_data;
@@ -83,7 +82,7 @@ struct packfile_store {
 	 * The list of packfiles in the order in which they are being added to
 	 * the store.
 	 */
-	struct packed_git *packs;
+	struct packfile_list packs;
 
 	/*
 	 * Cache of packfiles which are marked as "kept", either because there
@@ -163,13 +162,14 @@ void packfile_store_add_pack(struct packfile_store *store,
  * repository.
  */
 #define repo_for_each_pack(repo, p) \
-	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next)
+	for (struct packfile_list_entry *e = packfile_store_get_packs(repo->objects->packfiles); \
+	     ((p) = (e ? e->pack : NULL)); e = e->next)
 
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
  */
-struct packed_git *packfile_store_get_packs(struct packfile_store *store);
+struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
 
 /*
  * Get all packs in most-recently-used order.
@@ -266,14 +266,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
  */
 unsigned long repo_approximate_object_count(struct repository *r);
 
-/*
- * Find the pack within the "packs" list whose index contains the object "oid".
- * For general object lookups, you probably don't want this; use
- * find_pack_entry() instead.
- */
-struct packed_git *find_oid_pack(const struct object_id *oid,
-				 struct packed_git *packs);
-
 void pack_report(struct repository *repo);
 
 /*

-- 
2.51.2.997.g839fc31de9.dirty

