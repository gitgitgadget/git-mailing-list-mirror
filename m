Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A412D3ECC
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926478; cv=none; b=MmN9PDsukF0XU+e2Jca5BxLUntRJcVHCbtpHLIbyqQZvSMCx9kxWpy0JW44Oeu6F1AdZQ7XbJU/6PUs1xMKj2RGAHZ3mT4jRPmFC48pX+R2ikKFPfbB2zLEyEWWK4/+zY2027abD9UbuVLU6mUdwL5EpNVulaJ4sG9WhJG1S7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926478; c=relaxed/simple;
	bh=ybC5w3pZUbYtRWfuvQd8MtjI5PMNCmC1umlLi+NpESo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuvWQCequLqHHzUOqHyTLIazo/LcvUsHSPmfbfvSFr9uGBLciXEQy+hHBWr3HAVlLQqxPRpwk6aGy++YoydBN6U5ndruRmX+DDOXPo38OHdnIUhbkhVHCHBDzqRbkEnmeYEb3qttsv0IGtvwDF6tvotChHzGqdGLW4NpWQ9I5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n8sqV+/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+qgsr58; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n8sqV+/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+qgsr58"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B9F3EC024D;
	Mon, 15 Sep 2025 04:54:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 04:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926475;
	 x=1758012875; bh=zNAazClu5cCdN6j0dz0F0o9WTrbYcRc6vZsivjIXhQU=; b=
	n8sqV+/7ydKk0CaF84hm5pYQiNdYknk4BLcPDUlWkIjt7+9Y/RffSaSvdfylrcPF
	Gy6FqZtjYMcznBsTxcdDVwPoRfgDgXrVGqbVTVQBEtdJn5trA8f4LTjOAAu4i7VG
	46iWiDxo8qhyJPPdZ9aquVmCcJLxyy7Uda0fNWXX6NityiDnuUdg2o9DcL7YI0O+
	VY9AREH43Nz4jbjKapDRiwcQIxIQJKQv+kN8q1MO9LVzPyzNFTGL6T0qBGtQhNCH
	RNIL6fxYMPl71aKLXeKSh0wDFTemiajaNGujNlK+Sz/PsM3UuktZ/ShoLp/yCs1r
	0Q79PFZ57gEYj3LML2N/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926475; x=
	1758012875; bh=zNAazClu5cCdN6j0dz0F0o9WTrbYcRc6vZsivjIXhQU=; b=g
	+qgsr58T5zQkzXp9XizU13ZLHaBfA5SD1cqH44E8OThJTdalKdTWxVT1LczR5uFq
	Pqbl7p9aFAengf2MwNQGCh2CnvC271PcT+M4yxkrh+WW7wJH0wT9Mrl0rv6abYbX
	pd+oCOe2QJrQaf8ZbwI1EuX3TDBPqAnx7dPTQThfrCUG+5PLxZ4wENkFrGL7+YFi
	hlztrV9YT9CKIpXg7M/5vwmV9EZ4+g4/2EaqtxhlL/XKN8qMWHXFcVVbXV2+FvZ/
	nCKROHOOTpX7mr/OO9TPGwzA/UjDN0Ta9EWEo8Fd4cE4Xo5eUtSxbzJCt+GdeBQI
	gnUq1awgWzmXDebcuC4Bw==
X-ME-Sender: <xms:S9THaG7XSFloWYZKYhtYI4uKWuiQHF0VcpNTdhaDVErUrMGy9__D8w>
    <xme:S9THaLYgCxYBaDYK6GI9mIG3O-3L5yC9Rtn04H3y4RdN5ft3XeqDdFWvFpMw1k3Nq
    eYRzdIr0ele4fgb1w>
X-ME-Received: <xmr:S9THaL6bieMEaST-3McYIbW_iIKD-WgDtXN0jr_bYlmg_NWvzyGAAqivpCKCQvM8zV4aN5b9T4kBscCC_hcyxAEi_wrO9acIhdJPHP2FVIQq0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:S9THaODAwQ_3tXtFTfAmjO5RcJrFV1cwoQBJSsCTzsUGN7mpFFLzFQ>
    <xmx:S9THaBe5RNtqxgwPQj7fS0z9KOveuNfUZ_CK3aY-lF2W1ucufcg3eQ>
    <xmx:S9THaNLA-gOprxixXTyWGMgdlhQ0ZUf6yLk0Kzw5dljxXoKoCHWhbg>
    <xmx:S9THaM0GCtCbu5XYS5oIbx4s_MwOgiABLgKnOrS57aK0nIcSs3ScVA>
    <xmx:S9THaBNDx7ZtGd4vku-Ql10XpA_GI-CX3mM8D4oTSYxufPQPnNew9ias>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1e36084 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:20 +0200
Subject: [PATCH v5 02/15] odb: move list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-2-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The object database tracks the list of packfiles it currently knows
about. With the introduction of the `struct packfile_store` we have a
better place to host this list though.

Move the list accordingly. Extract the logic from `odb_clear()` that
knows to close all such packfiles and move it into the new subsystem, as
well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      | 12 ++----------
 odb.h      |  1 -
 packfile.c | 42 +++++++++++++++++++++++++-----------------
 packfile.h | 15 ++++++++++++++-
 4 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/odb.c b/odb.c
index a2289ea97d..7201d01406 100644
--- a/odb.c
+++ b/odb.c
@@ -1038,16 +1038,8 @@ void odb_clear(struct object_database *o)
 
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
-
-	/*
-	 * `close_object_store()` only closes the packfiles, but doesn't free
-	 * them. We thus have to do this manually.
-	 */
-	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
-		next = p->next;
-		free(p);
-	}
-	o->packed_git = NULL;
+	packfile_store_free(o->packfiles);
+	o->packfiles = NULL;
 
 	hashmap_clear(&o->pack_map);
 	string_list_clear(&o->submodule_source_paths, 0);
diff --git a/odb.h b/odb.h
index 33034eaf2f..22a170b434 100644
--- a/odb.h
+++ b/odb.h
@@ -138,7 +138,6 @@ struct object_database {
 	 * should only be accessed directly by packfile.c
 	 */
 	struct packfile_store *packfiles;
-	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
diff --git a/packfile.c b/packfile.c
index 130d3e2507..36bc240107 100644
--- a/packfile.c
+++ b/packfile.c
@@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = current->repo->objects->packed_git; p; p = p->next)
+	for (p = current->repo->objects->packfiles->packs; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -362,13 +362,8 @@ void close_pack(struct packed_git *p)
 void close_object_store(struct object_database *o)
 {
 	struct odb_source *source;
-	struct packed_git *p;
 
-	for (p = o->packed_git; p; p = p->next)
-		if (p->do_not_close)
-			BUG("want to close pack marked 'do-not-close'");
-		else
-			close_pack(p);
+	packfile_store_close(o->packfiles);
 
 	for (source = o->sources; source; source = source->next) {
 		if (source->midx)
@@ -468,7 +463,7 @@ static int close_one_pack(struct repository *r)
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = r->objects->packed_git; p; p = p->next) {
+	for (p = r->objects->packfiles->packs; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -789,8 +784,8 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = r->objects->packed_git;
-	r->objects->packed_git = pack;
+	pack->next = r->objects->packfiles->packs;
+	r->objects->packfiles->packs = pack;
 
 	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
 	hashmap_add(&r->objects->pack_map, &pack->packmap_ent);
@@ -974,7 +969,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 				count += m->num_objects;
 		}
 
-		for (p = r->objects->packed_git; p; p = p->next) {
+		for (p = r->objects->packfiles->packs; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
@@ -1015,7 +1010,7 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 
 static void rearrange_packed_git(struct repository *r)
 {
-	sort_packs(&r->objects->packed_git, sort_pack);
+	sort_packs(&r->objects->packfiles->packs, sort_pack);
 }
 
 static void prepare_packed_git_mru(struct repository *r)
@@ -1024,7 +1019,7 @@ static void prepare_packed_git_mru(struct repository *r)
 
 	INIT_LIST_HEAD(&r->objects->packed_git_mru);
 
-	for (p = r->objects->packed_git; p; p = p->next)
+	for (p = r->objects->packfiles->packs; p; p = p->next)
 		list_add_tail(&p->mru, &r->objects->packed_git_mru);
 }
 
@@ -1073,7 +1068,7 @@ void reprepare_packed_git(struct repository *r)
 struct packed_git *get_packed_git(struct repository *r)
 {
 	prepare_packed_git(r);
-	return r->objects->packed_git;
+	return r->objects->packfiles->packs;
 }
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
@@ -1094,7 +1089,7 @@ struct packed_git *get_all_packs(struct repository *r)
 			prepare_midx_pack(m, i);
 	}
 
-	return r->objects->packed_git;
+	return r->objects->packfiles->packs;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
@@ -1219,7 +1214,7 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 {
 	struct packed_git *p;
 
-	for (p = r->objects->packed_git; p; p = p->next)
+	for (p = r->objects->packfiles->packs; p; p = p->next)
 		if (oidset_contains(&p->bad_objects, oid))
 			return p;
 	return NULL;
@@ -2080,7 +2075,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
 
-	if (!r->objects->packed_git)
+	if (!r->objects->packfiles->packs)
 		return 0;
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
@@ -2343,5 +2338,18 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
 
 void packfile_store_free(struct packfile_store *store)
 {
+	for (struct packed_git *p = store->packs, *next; p; p = next) {
+		next = p->next;
+		free(p);
+	}
 	free(store);
 }
+
+void packfile_store_close(struct packfile_store *store)
+{
+	for (struct packed_git *p = store->packs; p; p = p->next) {
+		if (p->do_not_close)
+			BUG("want to close pack marked 'do-not-close'");
+		close_pack(p);
+	}
+}
diff --git a/packfile.h b/packfile.h
index 8d31fd619a..d7ac8d24b4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -57,6 +57,12 @@ struct packed_git {
  */
 struct packfile_store {
 	struct object_database *odb;
+
+	/*
+	 * The list of packfiles in the order in which they are being added to
+	 * the store.
+	 */
+	struct packed_git *packs;
 };
 
 /*
@@ -66,10 +72,17 @@ struct packfile_store {
 struct packfile_store *packfile_store_new(struct object_database *odb);
 
 /*
- * Free the packfile store and all its associated state.
+ * Free the packfile store and all its associated state. All packfiles
+ * tracked by the store will be closed.
  */
 void packfile_store_free(struct packfile_store *store);
 
+/*
+ * Close all packfiles associated with this store. The packfiles won't be
+ * free'd, so they can be re-opened at a later point in time.
+ */
+void packfile_store_close(struct packfile_store *store);
+
 static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
 				     const struct hashmap_entry *entry,
 				     const struct hashmap_entry *entry2,

-- 
2.51.0.450.g87641ccf93.dirty

