Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC431194B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591584; cv=none; b=aKEPFuoB9zxLnepccW62UzcIqdYz9y2JSpI6mNelEzcezMrjG+X7KMF+kciywzbpn7Ujitaaz92pWB8MV+tfLViydm1KoUhvJ0k2R5Uo04pjAT/JaSIivRdEwRfpWUQtoyWgOiB9+kvESvkEHPjSu7abKDd6w+ZsC+MWKg8izd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591584; c=relaxed/simple;
	bh=djk+k8F6rpzho9pATrLWzwlDUX25ZqfGX9aLEjLlz1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4uzKci3+o+vhFfmi+Y1dK6XPSfFqfSsi2YzIKLFA0PmGUY99d2FGkZkQRu1ZtTUELg1OhFtMfYKRITbPQ7uleDzwOU35Ou/Y1ZFZQ3qSHLOAqfPuc9Hz4hkB1Hvxhbza3MrDKM60IyLYLJnXGeDCeC1nKsbe3O5ZpUPDEWwGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XYUPYbTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVkYvLgS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XYUPYbTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVkYvLgS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78E657A0281
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 19 Aug 2025 04:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591581;
	 x=1755677981; bh=Xd9NxhcafCZ+7c1ys4V0Q5Ht81Jq3Exq3f21d5WdNS4=; b=
	XYUPYbTEZFA/tgbGcJXFe0tnGh17nnidzqH3y1OA24Sw3s9FRuVdm1WpjzDSdpED
	S75MfFfOCEDmdSOcOd/nVeHaOkrQLoiBj0yBIqxoTAZXQxv6aA7Gw1ZzG8q3op5b
	7eGW2ck0XcS+G9Dd4y5SGShBHhHFSQwwhDZgaOM/jXkORVceGdCuSAmqaGAGght/
	DstUu+jJxgo4poh5aa6AddLTI9Sdfv4OgeLSGoUzUJqEAfuYhFqT46S2Yfh9Xvi2
	hiLBudR4FzFxT36cocH2DJjuU21GpLJc9C1LEPYpLxKt3q011dZGCaG83GG6JmI1
	fPyZcVGA58eragh7wbbabQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591581; x=
	1755677981; bh=Xd9NxhcafCZ+7c1ys4V0Q5Ht81Jq3Exq3f21d5WdNS4=; b=I
	VkYvLgSMXsOyxP2BNk+fWn3hM+GNOIilEPYjbTray0g7O4VeLaLeivBGxJ687Tdn
	/Rew26lUbPBQXlxgG83FHmGR22yW4A5ALwbhcf5UJjvJHvsT673kLEhg51K74f34
	7o1WGFUV+RKcef/7v+jWccYBTJm43Q/YBogIbYoryTfCUzgi1/Ik9YFKYYqKka/V
	ZvSjXztVmjCn3J+5OfpG1tQm+vHNm61+H1p8BagP4LMlCEB3VGUwyda8v3EiAzhk
	9iImMaWo+6xu5dPFlUqoasvaAm8whYZbfDv0cQhXV2MhnOvHrGsjbv2pPBwLgBfJ
	skVNYaPNxPJQJw5lWjsGw==
X-ME-Sender: <xms:nTOkaHNDikOf7MBKLgDZYmq74Ybwf5g2Xa_fI7VZAjn_veIDh_6BSQ>
    <xme:nTOkaD91nl6yiE70T_TqO5umVnVjbCQ9UrUrzuhHl1qf2q7zJ0WLcRdK0lJrHgXiK
    HTRd28al3iAQJfO1g>
X-ME-Received: <xmr:nTOkaPoGWMeYlMz047Ii9FD_SJWFIZhLDa2RSW1YGqATWAoNpw5bBfwrcr9ju09Vh_L7g5jZkZI_gDVd-1YUeNYv5zGJJALDEYbmNDABAtxv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:nTOkaN6JXNI2_6Or_rOznB5L6bgpmM6mWzg9Sc-R72kb4rBX2bI37A>
    <xmx:nTOkaHMUlxMYPJVX-8TN5FEGAmt1GSsbgw9-SN8hSkFiBFPVI_0UXA>
    <xmx:nTOkaHMQtrbg7PhOmxWl7lIALH-5rPzafhEtzCr-81x7t8rzLtD4WA>
    <xmx:nTOkaH_y4xo8j_GbhFlafDBldYWaqxtfXjZo-0ohVAmkabM1cjPgrA>
    <xmx:nTOkaE3iVa0ANdif2AMNtCvSk3e4XOQTEaxMLdJCSSrvkeywtvdlJ7d->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0dd4266e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:31 +0200
Subject: [PATCH 02/16] odb: move list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-2-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The object database tracks the list of packfiles it currently knows
about. With the introduction of the `struct packfile_store` we have a
better place to host this list though.

Move the list accordingly. Extract the logic from `odb_clear()` that
knows to close all such packfiles and move it into the new subsystem, as
well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      | 11 +----------
 odb.h      |  1 -
 packfile.c | 47 ++++++++++++++++++++++++++++++-----------------
 packfile.h | 16 +++++++++++++++-
 4 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/odb.c b/odb.c
index 34b70d0074..17a9135cbd 100644
--- a/odb.c
+++ b/odb.c
@@ -1038,16 +1038,7 @@ void odb_clear(struct object_database *o)
 
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
 
 	hashmap_clear(&o->pack_map);
 	string_list_clear(&o->submodule_source_paths, 0);
diff --git a/odb.h b/odb.h
index 026ba9386d..273ad0ceaa 100644
--- a/odb.h
+++ b/odb.h
@@ -131,7 +131,6 @@ struct object_database {
 	 */
 	struct packfile_store *packfiles;
 
-	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
diff --git a/packfile.c b/packfile.c
index 8fbf1cfc2d..6478e4cc30 100644
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
 
@@ -1074,7 +1069,7 @@ void reprepare_packed_git(struct repository *r)
 struct packed_git *get_packed_git(struct repository *r)
 {
 	prepare_packed_git(r);
-	return r->objects->packed_git;
+	return r->objects->packfiles->packs;
 }
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
@@ -1095,7 +1090,7 @@ struct packed_git *get_all_packs(struct repository *r)
 			prepare_midx_pack(r, m, i);
 	}
 
-	return r->objects->packed_git;
+	return r->objects->packfiles->packs;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
@@ -1220,7 +1215,7 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 {
 	struct packed_git *p;
 
-	for (p = r->objects->packed_git; p; p = p->next)
+	for (p = r->objects->packfiles->packs; p; p = p->next)
 		if (oidset_contains(&p->bad_objects, oid))
 			return p;
 	return NULL;
@@ -2081,7 +2076,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 		if (source->midx && fill_midx_entry(r, oid, e, source->midx))
 			return 1;
 
-	if (!r->objects->packed_git)
+	if (!r->objects->packfiles->packs)
 		return 0;
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
@@ -2344,5 +2339,23 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
 
 void packfile_store_free(struct packfile_store *store)
 {
+	packfile_store_close(store);
+
+	for (struct packed_git *p = store->packs, *next; p; p = next) {
+		next = p->next;
+		free(p);
+	}
+
 	free(store);
 }
+
+void packfile_store_close(struct packfile_store *store)
+{
+	struct packed_git *p;
+
+	for (p = store->packs; p; p = p->next)
+		if (p->do_not_close)
+			BUG("want to close pack marked 'do-not-close'");
+		else
+			close_pack(p);
+}
diff --git a/packfile.h b/packfile.h
index 8d31fd619a..1404b80917 100644
--- a/packfile.h
+++ b/packfile.h
@@ -57,6 +57,13 @@ struct packed_git {
  */
 struct packfile_store {
 	struct object_database *odb;
+
+	/*
+	 * The list of packfiles in the order in which they are being added to
+	 * the store. The local packfile typically sits at the head of this
+	 * list.
+	 */
+	struct packed_git *packs;
 };
 
 /*
@@ -66,10 +73,17 @@ struct packfile_store {
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
2.51.0.261.g7ce5a0a67e.dirty

