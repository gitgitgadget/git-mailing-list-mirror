Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7F2E8B9F
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761956; cv=none; b=ts2+IxT0qqWCHjWp8yclb3CRiBIyl0Bi6piPydo0RaDXzqq5iOVNfKAedLz+6OqXrTJRgCKBjWBwI6ApmQ/t1frFZZbKvH/GDdvy1RlLmA38CVaDP3noz6ypKVV8m0heFX7C4yMEwJ3/IUsoIXtMFI0lYuxMFEZztFxFRYbM6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761956; c=relaxed/simple;
	bh=eASxEVbo2VI/mthNnrCFq1vpDRYFamRcK7I4NhT7k/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK4/7Y/o33vhRH2uVbA+bq7UzcuC7OT8cNedWRsUv0jnqxnK0lqfbhfOJLP0OlmmiAMQPft0/l8hy5o17knpR6nQpcAXDcm6YgNKqJrmuk1CQjV/Ccgj0XP6vQi6i8UKBzVnhOqfVlwX2rhllom4eCXOjty328+Ur1uU8qXo75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IkzgU/8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gic7zOfD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IkzgU/8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gic7zOfD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DF6614000B6;
	Thu, 21 Aug 2025 03:39:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 Aug 2025 03:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761954;
	 x=1755848354; bh=OUWK5+Ar9/JM0ezL4bOe6LqMPwdnjxZcPBvlb80ccWc=; b=
	IkzgU/8Qhch655BH3zVDRPS1C3ZekGlPS+XyDk5tpuC7TnYpyc9L8RqlqLaOdF2t
	lSAh11JfTW/ccPsDH0Gae1wdkdizHg4E5+Bya850wvmH/PvJFBy8g4LgTrB4f6N9
	PThuAxFkoNF3u0ssaXB5XY8NZGN61NcI8f3qUVBrIaPuRBBICS8Ho/CnwDKiUUx7
	9ivmqz5ZnHkMb5P0C2qaPFFxvcjfeocPGhyQDG4eTT0LamdBrjJUaMpFAWug1VK6
	EaHldjglu7AU6gfrI1kVlHDew3boJOTYsnU7IEV1Jsnqkkeud+w1GMLHvX4K4q/d
	o4Kd34fbuFrwTkQPFz9oiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761954; x=
	1755848354; bh=OUWK5+Ar9/JM0ezL4bOe6LqMPwdnjxZcPBvlb80ccWc=; b=G
	ic7zOfDg9v/LJKknom6AdIiblf92O3CXqsky70GwSrbmodfKfl87BEMTJ2B4Ve4f
	KmTODX99wfW8Vxapu0c+r0VoQiGn5jbh10XvE7IFRJCVF9Uor79q7OKkoFpVcidi
	0Cu9oIxFe5flQJbeoTIgBSrLF52rHi4aRkNPgHgZVmrNF8SzgwfYgL4S3KhUHYmw
	Zo0eS5VrxvPBG51ImjRWFfdkzB6GxMZVmTA9SMs6IaKGK3RQ7kzZ+ouyusQzpOZu
	5Fxuv6JAspiGbj1OzPkEQBucR2JURJ1GVEytyAvyA410cu36iJXxngPHt8DRaN/r
	OBUq/dfdLf/zvobb5oh3Q==
X-ME-Sender: <xms:Ic2maBOzQcRxt59zHCYonnZk56rPdlz4nkzVJIUN__9Hb_056HQpJg>
    <xme:Ic2maHNZ3lpSdjzKAktpm6p5-ppw38ukwLTruNbEzwxZEEG3NpftLYNWO7h254JAO
    EwFi8O_1MScsxVhuA>
X-ME-Received: <xmr:Ic2maJvr141DTOa_AgAL8-JrLN5XAkQRAExmjPwHdxozYqvfzLmRzDOKAT1xQjM02HE8HRF3EH_ofL9tg0NC1YauEw5iusXPuiBsNTNURQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Ic2maJUO4mmLnhqKyk1k7q-AmOV8ik0lBS7ydYdWjqLUf0ztzYX7tw>
    <xmx:Ic2maJuUR-BI0SLwlVhUF1R2B220a3Nv_-ECOZPMh0d-RUG0cpKBoQ>
    <xmx:Ic2maNWRtKTdENRnHavfoE4uftGa9WiFaJ4OtG4UQzOXUfVtefd1XQ>
    <xmx:Ic2maEk2cuW81kRZ5XBfuVh2MQJIjSSF34CxpFBU0Kl_IEIZAFPyqg>
    <xmx:Is2maP3bqphsktXWkRir_QZJE0LBUF9fHj8tLmM9wDOEzczKKz9Q3yul>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8334bf8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:00 +0200
Subject: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
 packfile.h | 15 ++++++++++++++-
 4 files changed, 45 insertions(+), 29 deletions(-)

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
index 08c3a01f3b..6f901c5ac0 100644
--- a/odb.h
+++ b/odb.h
@@ -130,7 +130,6 @@ struct object_database {
 	 * should only be accessed directly by packfile.c
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
2.51.0.261.g7ce5a0a67e.dirty

