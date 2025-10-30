Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C902351FB5
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820734; cv=none; b=TEF/tYxGsRfxjjuuJ573313Kb+9anTQofsJYkAMkhip3cIQcNj5s9k5VUooQYdAKgXUcWcTljXzJ3y85l6Vq/MGQUjs8ndF7yEMfhu7feBJPwb3+0q00RSuGerN/aF4mRSIFNRyvYFdHOSGyxti94oYBJU6OYjYsGeYt7W4MVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820734; c=relaxed/simple;
	bh=A6ewKw5MhN7xKGglkXhOfaKBVzDEgCP6W0Ld29gMeW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkKhphgeCMGJumWykXUxnQMs2ZTlITBny0Olq65brrps07ICfHPqw29dYo3cpAuSmIDsVZW+PZN9+7iaI30tKFHcAxmcoVFRQRnq1iDYldWUHShInyvp9qVaWSeAJdbVHWe2MXxqBF19LNrZC652zU7rsldXGSxHs34ZJdjfA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z3WzsMHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JixC30zP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z3WzsMHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JixC30zP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 78F0E14000EA;
	Thu, 30 Oct 2025 06:38:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 30 Oct 2025 06:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820731;
	 x=1761907131; bh=r8Ns1/8v1Vfit16IUIq4SmeriyuugxBOF0cftopxEDo=; b=
	Z3WzsMHUryWdA7k3iU45z+0DDvl3YT5zBH24f4nNQBlx5PHJDLYBwyovN5LLgIXe
	Zt/EJQPAUqC3xWPtB95Nw2R04GsAewQ3iL0S5nYVhTI0s7qIbWFiL6/HDsRnwva7
	OiWLJ4Jax9ZJv49RIC7YlQTCVwuz7weabm3yJTbb95afylJ1sAtRnFFTjnKF8YDa
	G4kTZtoZgTwqXbHiOz73B+egs3fopW0w5nOqgygu84kQeqIcHsFyELBj8+orx54u
	wBR8N/EpSK/HbLBOQzKiXrjIH+IrfYdQJi9CskjQVf3xJJyUKxmKzxm6x946WWIk
	AoOwxFWEcWtywuQ7kA/AOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820731; x=
	1761907131; bh=r8Ns1/8v1Vfit16IUIq4SmeriyuugxBOF0cftopxEDo=; b=J
	ixC30zP+Q0qGGRIiPTyM/ffZ7l56/SW9M7be1252ygU1VXaZwL5dDAcsKrlSax9p
	r5pBWe12tjCsexmvQCnqs1oC8G1wIfw2rORovZZqnoPjbruFoolxCVBfO6EAmGi1
	stmyFc8DQgnoEW77bG8Zlr5OxkKbFvmQeon8sThlsV1VTsBD0ONzB46/i1HT/J3M
	UuN8GQVfBkp2jmaINe5leRlC0mTDqhJCsdQzYMVvUNJqu1wsTrHkAG/mMZcXXjzF
	D7zfnF6OF/3fzljlYGJeBlQIqc172A8cg5wqKMigvnQ/B4VIGnZHl9MX138Eubzk
	zUcPkDKSTn9ZdFI9Vn2jA==
X-ME-Sender: <xms:O0ADacp3FeBGizhPOUrU6IJt3d7l7pHb1rXmNKH9b7Wzgw06COhWFA>
    <xme:O0ADaZo9KrAxso0TNpOtTrSudlymt3B65QVyH48dI1_29qURb1UJoBj5yNVcaWWgh
    2ibtBzQxXfFz7XQ0g0Dp0c_b_rhWieFM_CCl1TrvB_Gujxt_taUgw>
X-ME-Received: <xmr:O0ADaWOkNrnPvIpNb1WGzHqYZBsBz2tUZuvmDb-lH6I6MXykmlG1z9HFBrnQ48x-craVzeAO7SBVN_FwnNUyLx2wJuYt8kiq-IZJeD9HYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O0ADaSz-WDI1H6-17uxk4L3O0fhUrsyIG-rOz4Ap9nNpKdZun06eHw>
    <xmx:O0ADaXv2EIqT5UgcmpKHEuQxXm31EeNsnjDN20qKZ-gisE97-SAlcg>
    <xmx:O0ADaT7CpThpINrsEaZnuf8doO8dMEnbNqea57V7Po3l-Qk0OHrNBw>
    <xmx:O0ADaeR7Kmj37jevnED_Ukb62ENohqHhkBnUCh_4mnFKTKknvooVOg>
    <xmx:O0ADaVsEq_Suk6KxGd8nuuc9HLIHVu25XMwul0pyO0FVz8n3RukFxT6u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:38:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5430262 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:38:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:39 +0100
Subject: [PATCH v2 2/8] packfile: move the MRU list into the packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-2-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

Packfiles have two lists associated to them:

  - A list that keeps track of packfiles in the order that they were
    added to a packfile store.

  - A list that keeps track of packfiles in most-recently-used order so
    that packfiles that are more likely to contain a specific object are
    ordered towards the front.

Both of these lists are hosted by `struct packed_git` itself, So to
identify all packfiles in a repository you simply need to grab the first
packfile and then iterate the `->next` pointers or the MRU list. This
pattern has the problem that all packfiles are part of the same list,
regardless of whether or not they belong to the same object source.

With the upcoming pluggable object database effort this needs to change:
packfiles should be contained by a single object source, and reading an
object from any such packfile should use that source to look up the
object. Consequently, we need to break up the global lists of packfiles
into per-object-source lists.

A first step towards this goal is to move those lists out of `struct
packed_git` and into the packfile store. While the packfile store is
currently sitting on the `struct object_database` level, the intent is
to push it down one level into the `struct odb_source` in a subsequent
patch series.

Introduce a new `struct packfile_list` that is used to manage lists of
packfiles and use it to store the list of most-recently-used packfiles
in `struct packfile_store`. For now, the new list type is only used in a
single spot, but we'll expand its usage in subsequent patches.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  9 +++--
 midx.c                 |  2 +-
 packfile.c             | 92 +++++++++++++++++++++++++++++++++++++++++++++-----
 packfile.h             | 19 +++++++++--
 4 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b5454e5df13..5348aebbe9f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1706,8 +1706,8 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 				     uint32_t found_mtime)
 {
 	int want;
+	struct packfile_list_entry *e;
 	struct odb_source *source;
-	struct list_head *pos;
 
 	if (!exclude && local) {
 		/*
@@ -1748,12 +1748,11 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	list_for_each(pos, packfile_store_get_packs_mru(the_repository->objects->packfiles)) {
-		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+	for (e = the_repository->objects->packfiles->mru.head; e; e = e->next) {
+		struct packed_git *p = e->pack;
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
-			list_move(&p->mru,
-				  packfile_store_get_packs_mru(the_repository->objects->packfiles));
+			packfile_list_prepend(&the_repository->objects->packfiles->mru, p);
 		if (want != -1)
 			return want;
 	}
diff --git a/midx.c b/midx.c
index 1d6269f957e..8022be9a45e 100644
--- a/midx.c
+++ b/midx.c
@@ -463,7 +463,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	p = packfile_store_load_pack(r->objects->packfiles,
 				     pack_name.buf, m->source->local);
 	if (p)
-		list_add_tail(&p->mru, &r->objects->packfiles->mru);
+		packfile_list_append(&m->source->odb->packfiles->mru, p);
 	strbuf_release(&pack_name);
 
 	if (!p) {
diff --git a/packfile.c b/packfile.c
index 04649e52920..4d2d3b674f3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -47,6 +47,80 @@ static size_t pack_mapped;
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
+void packfile_list_clear(struct packfile_list *list)
+{
+	struct packfile_list_entry *e, *next;
+
+	for (e = list->head; e; e = next) {
+		next = e->next;
+		free(e);
+	}
+
+	list->head = list->tail = NULL;
+}
+
+static struct packfile_list_entry *packfile_list_remove_internal(struct packfile_list *list,
+								 struct packed_git *pack)
+{
+	struct packfile_list_entry *e, *prev;
+
+	for (e = list->head, prev = NULL; e; prev = e, e = e->next) {
+		if (e->pack != pack)
+			continue;
+
+		if (prev)
+			prev->next = e->next;
+		if (list->head == e)
+			list->head = e->next;
+		if (list->tail == e)
+			list->tail = prev;
+
+		return e;
+	}
+
+	return NULL;
+}
+
+void packfile_list_remove(struct packfile_list *list, struct packed_git *pack)
+{
+	free(packfile_list_remove_internal(list, pack));
+}
+
+void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
+{
+	struct packfile_list_entry *entry;
+
+	entry = packfile_list_remove_internal(list, pack);
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->pack = pack;
+	}
+	entry->next = list->head;
+
+	list->head = entry;
+	if (!list->tail)
+		list->tail = entry;
+}
+
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
+{
+	struct packfile_list_entry *entry;
+
+	entry = packfile_list_remove_internal(list, pack);
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->pack = pack;
+	}
+	entry->next = NULL;
+
+	if (list->tail) {
+		list->tail->next = entry;
+		list->tail = entry;
+	} else {
+		list->head = list->tail = entry;
+	}
+}
+
 void pack_report(struct repository *repo)
 {
 	fprintf(stderr,
@@ -995,10 +1069,10 @@ static void packfile_store_prepare_mru(struct packfile_store *store)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&store->mru);
+	packfile_list_clear(&store->mru);
 
 	for (p = store->packs; p; p = p->next)
-		list_add_tail(&p->mru, &store->mru);
+		packfile_list_append(&store->mru, p);
 }
 
 void packfile_store_prepare(struct packfile_store *store)
@@ -1040,10 +1114,10 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 	return store->packs;
 }
 
-struct list_head *packfile_store_get_packs_mru(struct packfile_store *store)
+struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store)
 {
 	packfile_store_prepare(store);
-	return &store->mru;
+	return store->mru.head;
 }
 
 /*
@@ -2048,7 +2122,7 @@ static int fill_pack_entry(const struct object_id *oid,
 
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
-	struct list_head *pos;
+	struct packfile_list_entry *l;
 
 	packfile_store_prepare(r->objects->packfiles);
 
@@ -2059,10 +2133,11 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	if (!r->objects->packfiles->packs)
 		return 0;
 
-	list_for_each(pos, &r->objects->packfiles->mru) {
-		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+	for (l = r->objects->packfiles->mru.head; l; l = l->next) {
+		struct packed_git *p = l->pack;
+
 		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			list_move(&p->mru, &r->objects->packfiles->mru);
+			packfile_list_prepend(&r->objects->packfiles->mru, p);
 			return 1;
 		}
 	}
@@ -2314,7 +2389,6 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
 	store->odb = odb;
-	INIT_LIST_HEAD(&store->mru);
 	strmap_init(&store->packs_by_path);
 	return store;
 }
diff --git a/packfile.h b/packfile.h
index 9da7f14317b..39ed1073e4a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -12,7 +12,6 @@ struct object_info;
 
 struct packed_git {
 	struct packed_git *next;
-	struct list_head mru;
 	struct pack_window *windows;
 	off_t pack_size;
 	const void *index_data;
@@ -52,6 +51,20 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+struct packfile_list {
+	struct packfile_list_entry *head, *tail;
+};
+
+struct packfile_list_entry {
+	struct packfile_list_entry *next;
+	struct packed_git *pack;
+};
+
+void packfile_list_clear(struct packfile_list *list);
+void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
+void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
+
 /*
  * A store that manages packfiles for a given object database.
  */
@@ -79,7 +92,7 @@ struct packfile_store {
 	} kept_cache;
 
 	/* A most-recently-used ordered version of the packs list. */
-	struct list_head mru;
+	struct packfile_list mru;
 
 	/*
 	 * A map of packfile names to packed_git structs for tracking which
@@ -153,7 +166,7 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 /*
  * Get all packs in most-recently-used order.
  */
-struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store);
 
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns

-- 
2.51.2.997.g839fc31de9.dirty

