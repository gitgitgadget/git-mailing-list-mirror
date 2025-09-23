Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC6313536
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622665; cv=none; b=pOYnAywZkvIKxccjX9OQu3TjBsBKv+OqKIAX60GypsHKGU37E5cEUAOM5fotEhdFRkpJBKoronelakA8qJzX7BD5k5lwicwuQwhowsOhgpVodoQ7xMBch2rjdx7P+Bymfbr9aB6U28k+QQPTYBsC8wCfa1F6OIchEBkHIlWJvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622665; c=relaxed/simple;
	bh=gcos+c52pZrX6VYTinwHlwxiQUEDCKxnUcfDDsMjyIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LamMKtAvd6sQiclcxDeA9aOGqMfAUeed3Xc9hCO/auwpBNo95zHsSnNaiYk5rCxzkO3e3JnA5OIEQkgbOeclsDUHbhKCR4zdr3jDrnuKDY/zngNaL2UTWDVX8db/8g/7QKXpMts7dd9di7foK/krXsoO7a2yuPaJwJN3/FnEmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jRtAk+zo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZDAiZHf/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jRtAk+zo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDAiZHf/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 403857A0067;
	Tue, 23 Sep 2025 06:17:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 06:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622663;
	 x=1758709063; bh=94mXCh+12EakhxfWkqI2tDlZasZF1cdj6EBUQDd5kqs=; b=
	jRtAk+zo8a3Hox73ln2ZDpkU1v7LB9JXI0gXk+tx/VYLk+UIR5i1/hwrUMBpuq6n
	4qxRatjSwPgdFE5+Na9uZaS2pID/Y/KOiNWhEdejfwMBNRs3WNHEayw8mdI+6p6B
	oerLQZJgiHGyj7lYyL59jVy32ubQ//hI3TsPEErd2AAy0p+AgePpeimXmY0ZCWd2
	ubb3hnPRwFb4so4tzaYvqXA8S0VeosAgiQfC4197CCvYv0YW2at7WA3EvoFl8g7/
	53BRAeoGFX7PUKACoE5ZO1Z+Ckg3J3i8Pk7BFL8llnQQHsEcuPcwWkF6yxOJBycK
	wcRzKMLNOHnqRzmqnk1uZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622663; x=
	1758709063; bh=94mXCh+12EakhxfWkqI2tDlZasZF1cdj6EBUQDd5kqs=; b=Z
	DAiZHf/Sq823P4OGMsN35kCpboHpXOOuk5jqUuszfiB8BHwd/63+Nm9FRCHU/T8P
	kSMHe2m8v197dqOrkP/cqiUEcu66/ak+peo89hT8/TJthnDcybMIoBFl6BwvKm7g
	Ns7STm+GQZ7WgBTPNCwHQcQIZcf/X7NWk4DrdnmBN3pgYvn03AUlvH43JLK8UzaS
	kN8VSGPEk9K5Ktp+3LbO2IY4jQoF2qDTvRuaJo5lFZfUADflpY/fx/lV0V5o2EQy
	I/SFhHRBRmT++SDaqLhDu967lS/d56dVkgkgbgzFNAV98NtpTNNsbM/tiQqNrUsS
	jvJ2G+lraXBa4M5+DATjg==
X-ME-Sender: <xms:xnPSaJNNYo-vhiICU2iizAunOIAFxAJ3c7tpDgj6ILBH_yzVrRjECA>
    <xme:xnPSaPpaglP5OfV_5jnOGlgbDVNgTEQGFcM15TYZNTI8wWKAqDX-ZcE_q0TPxjccv
    4ahVybpf7CaBy4nWW2FdfG6-EggMKcbRiW92EvNjP7qZ3wdGHoY>
X-ME-Received: <xmr:xnPSaCGzeJ8WFGNY7A8_cnZis_Qsd37W-GMBbz3vYte0aASKTTQwSP270e0TuP5-y8jS9bpXBRHbipVYFvkAqThOxNnpUGkuQzZO9_1mLKpG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:xnPSaMparftHLEi_F1T02nG6a9ehc0gtyKIxM60FohmNUXh-sdQgnw>
    <xmx:x3PSaDbzDi0OuKe7PQYIsgFxbK5jxsf1O_2GYr3CxUYM4Sbjd_6GXA>
    <xmx:x3PSaNUw2DbfT_4E2Nar99U6tY79VoqZj7XVlI_TK5PMWwiKL7TNiQ>
    <xmx:x3PSaE-fUF6xbkc8E4o_RMec7dlHzuO1B2Cs5SXQBbibRKn85x9FIw>
    <xmx:x3PSaBoJsI4AyWPbPuFz_RWZmbsxWMcL9qVh5QgMrDqf9rzmCFczBnN5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0ab0097 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:10 +0200
Subject: [PATCH v6 11/15] packfile: introduce function to load and add
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-11-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

We have a recurring pattern where we essentially perform an upsert of a
packfile in case it isn't yet known by the packfile store. The logic to
do so is non-trivial as we have to reconstruct the packfile's key, check
the map of packfiles, then create the new packfile and finally add it to
the store.

Introduce a new function that does this dance for us. Refactor callsites
to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  4 ++--
 builtin/index-pack.c  | 10 +++-------
 midx.c                | 23 ++++-------------------
 packfile.c            | 44 +++++++++++++++++++++++++++++++-------------
 packfile.h            |  8 ++++++++
 5 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index e9d82b31c3..a26e79689d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -897,11 +897,11 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = add_packed_git(pack_data->repo, idx_name, strlen(idx_name), 1);
+		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
+						 idx_name, 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		packfile_store_add_pack(the_repository->objects->packfiles, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ed490dfad4..2b78ba7fe4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1640,13 +1640,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
 			    hash, "idx", 1);
 
-	if (do_fsck_object) {
-		struct packed_git *p;
-		p = add_packed_git(the_repository, final_index_name,
-				   strlen(final_index_name), 0);
-		if (p)
-			packfile_store_add_pack(the_repository->objects->packfiles, p);
-	}
+	if (do_fsck_object)
+		packfile_store_load_pack(the_repository->objects->packfiles,
+					 final_index_name, 0);
 
 	if (!from_stdin) {
 		printf("%s\n", hash_to_hex(hash));
diff --git a/midx.c b/midx.c
index 69c44be71c..3faeaf2f8f 100644
--- a/midx.c
+++ b/midx.c
@@ -443,7 +443,6 @@ int prepare_midx_pack(struct multi_pack_index *m,
 {
 	struct repository *r = m->source->odb->repo;
 	struct strbuf pack_name = STRBUF_INIT;
-	struct strbuf key = STRBUF_INIT;
 	struct packed_git *p;
 
 	pack_int_id = midx_for_pack(&m, pack_int_id);
@@ -455,25 +454,11 @@ int prepare_midx_pack(struct multi_pack_index *m,
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
 		    m->pack_names[pack_int_id]);
-
-	/* pack_map holds the ".pack" name, but we have the .idx */
-	strbuf_addbuf(&key, &pack_name);
-	strbuf_strip_suffix(&key, ".idx");
-	strbuf_addstr(&key, ".pack");
-	p = hashmap_get_entry_from_hash(&r->objects->packfiles->map,
-					strhash(key.buf), key.buf,
-					struct packed_git, packmap_ent);
-	if (!p) {
-		p = add_packed_git(r, pack_name.buf, pack_name.len,
-				   m->source->local);
-		if (p) {
-			packfile_store_add_pack(r->objects->packfiles, p);
-			list_add_tail(&p->mru, &r->objects->packfiles->mru);
-		}
-	}
-
+	p = packfile_store_load_pack(r->objects->packfiles,
+				     pack_name.buf, m->source->local);
+	if (p)
+		list_add_tail(&p->mru, &r->objects->packfiles->mru);
 	strbuf_release(&pack_name);
-	strbuf_release(&key);
 
 	if (!p) {
 		m->packs[pack_int_id] = MIDX_PACK_ERROR;
diff --git a/packfile.c b/packfile.c
index af806aba09..9224ca424c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -792,6 +792,33 @@ void packfile_store_add_pack(struct packfile_store *store,
 	hashmap_add(&store->map, &pack->packmap_ent);
 }
 
+struct packed_git *packfile_store_load_pack(struct packfile_store *store,
+					    const char *idx_path, int local)
+{
+	struct strbuf key = STRBUF_INIT;
+	struct packed_git *p;
+
+	/*
+	 * We're being called with the path to the index file, but `pack_map`
+	 * holds the path to the packfile itself.
+	 */
+	strbuf_addstr(&key, idx_path);
+	strbuf_strip_suffix(&key, ".idx");
+	strbuf_addstr(&key, ".pack");
+
+	p = hashmap_get_entry_from_hash(&store->map, strhash(key.buf), key.buf,
+					struct packed_git, packmap_ent);
+	if (!p) {
+		p = add_packed_git(store->odb->repo, idx_path,
+				   strlen(idx_path), local);
+		if (p)
+			packfile_store_add_pack(store, p);
+	}
+
+	strbuf_release(&key);
+	return p;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -891,23 +918,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 			 const char *file_name, void *_data)
 {
 	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
-	struct packed_git *p;
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
 	    !(data->m && midx_contains_pack(data->m, file_name))) {
-		struct hashmap_entry hent;
-		char *pack_name = xstrfmt("%.*s.pack", (int)base_len, full_name);
-		unsigned int hash = strhash(pack_name);
-		hashmap_entry_init(&hent, hash);
-
-		/* Don't reopen a pack we already have. */
-		if (!hashmap_get(&data->r->objects->packfiles->map, &hent, pack_name)) {
-			p = add_packed_git(data->r, full_name, full_name_len, data->local);
-			if (p)
-				packfile_store_add_pack(data->r->objects->packfiles, p);
-		}
-		free(pack_name);
+		char *trimmed_path = xstrndup(full_name, full_name_len);
+		packfile_store_load_pack(data->r->objects->packfiles,
+					 trimmed_path, data->local);
+		free(trimmed_path);
 	}
 
 	if (!report_garbage)
diff --git a/packfile.h b/packfile.h
index ba4b0cef9c..fcefcbbef6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -127,6 +127,14 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Open the packfile and add it to the store if it isn't yet known. Returns
+ * either the newly opened packfile or the preexisting packfile. Returns a
+ * `NULL` pointer in case the packfile could not be opened.
+ */
+struct packed_git *packfile_store_load_pack(struct packfile_store *store,
+					    const char *idx_path, int local);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;

-- 
2.51.0.536.g15c5d4f767.dirty

