Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246E2F4A13
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926507; cv=none; b=jQss79ROZoWS+DLYOnzaWggltv2B5a2SxAeNIda6J1g9lDGRW7NuGU6nl7tLD1KDAejFRtb+4KoWoO+MZ9+9CapBrnxGTDr/oU4MYDRknXwT99y+2MywEbxuWSsaU9FnL71fHHBUU2xDSeIfQaw/RTHb5zHstierO1rGbnX60eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926507; c=relaxed/simple;
	bh=8GGMlO0AYAZBVSEpiYVw6lLl2NjPxDzza6Sfq1aQXus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dubNXL81+FxlivnyBoBjxJmGSLxwlRihE8zb5I+6AM/0abjKGIVLlNauzJ73dWE9BcVS/+Kor7ASsecrJO5saa6oI5h+UPy8HsiHtNEFpb4DZIZiWTszSd8FfrIb0QM26DryXk6k81QySvJNYrL+st6isMSPyfex8pkdJCY2m9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ITUnqd8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iq4/GQoi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ITUnqd8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iq4/GQoi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 788A514001CE;
	Mon, 15 Sep 2025 04:55:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 04:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926503;
	 x=1758012903; bh=rk5rps5egTc8yj68pac0sng9xznXMgd6/iiUGSPNQ5E=; b=
	ITUnqd8Gk686WohEbWvnWQViJ4wFfDCzcmdqXUCXx3vyesNSjOB/4V0CT84A4N6z
	+/8OUs+CyILVO8z4EyAI5BqxPMDo0HebJe/+fxDvQFUZ+7uee0HlPJLt+MgmHckk
	hbHfzZv5QhWGZlKplFT2dfWHJn1v8IcQqX4Hps0FzZtRzTU3v23JWAy9rOAreUvw
	8nkyvnbBq7pOEwXY20M1HT/zNllHNlVXZVe2p++uycUibHXwtVQ8tMy0fY19+o/l
	RQVkW+E5ZHK0N0Etm4AFZ4PmvU6YaJUSO2gpZPLjO5FmRjS+cAVHKnPV8hURjupZ
	Z2/OWRpU0SCA0kik8El//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926503; x=
	1758012903; bh=rk5rps5egTc8yj68pac0sng9xznXMgd6/iiUGSPNQ5E=; b=i
	q4/GQoiUd+XIxIDBFvL9DLd64i+52afSW2KRUILdZ6AkrhsRwS1QBqiM4GlWvIHt
	Px3dvA/nDC4pDVCAhMNZ4albWzJmEod3SBRTdeNTbw9FkTnVu87OgTqO7/vSvyS6
	J4jlSOo2vnQ5p2g1XeS3JbzBPz9n8AdxALonlvQRcjXMR7vcPida/DTZYyGqJ/bi
	cWW19DKwThNrgc8EpdKEWLU0WQNA8OdctXhWIAL5YFIkY1sKl9WwzGnEDGm46vJj
	kqir4Lv6C/5yS39J066OdRdFCYpAnHQH8h94UhCW+H32TKFG3l9HmbtJg7jgvq2d
	Nk7seaF31CbPUGLBJRJfQ==
X-ME-Sender: <xms:Z9THaPEBm476zT93XPagNw2LZedoJ4CiUXhmb7Ma8gjthi7QgBGnpg>
    <xme:Z9THaH3s_GYg_tdJA4oe80xQgn-RmogKBZvH_y3qu4DR5AExCCQpuciwbjN_ruLdP
    2mMW8g48pvErd_kwA>
X-ME-Received: <xmr:Z9THaHkpBgV1PouMnExJ0ZqpPbA9uif3r5xFTMyfF2gAMlDYAdKAMEryjkLzno07TrzdvbdT8jdz4sdzRGnMgH4tgb5tNET5DahW9FOdThJYAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Z9THaH8bhAtPKpY0rhKCjCBycCfpIxXbkZ1369vu_CJJXqI2sCn6PA>
    <xmx:Z9THaMooBBfkcsZJpYzb0EfDKAxfFwICjzEcCkbxZF9lKQ-7FEQ8Jw>
    <xmx:Z9THaAki3KUAtBmKJUsCF_xgBzzKB3Z-J9sZwHrhn3QD876dw2vjlg>
    <xmx:Z9THaDjVC4u4Y5P8wadYJWh22vmNrjvzAiRc_OK8RmInccrBH6puHA>
    <xmx:Z9THaLIL8xqa92LpMbJzFtAMpNedVBOK8348H-TlC-fQTKEm4HDoLs7Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:55:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 128119ef (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:55:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:29 +0200
Subject: [PATCH v5 11/15] packfile: introduce function to load and add
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-11-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
2.51.0.450.g87641ccf93.dirty

