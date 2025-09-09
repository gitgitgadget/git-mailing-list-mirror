Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DD31D754
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415823; cv=none; b=jGQk+9Wz8TW1uIaF0MfkmAy8n6OvLbYwQEa/MPO/M9orr4lDjoJd/wIDIdGXG1J+MbOYl01cgogoPENQw/zdQDkmBDTXOsuVPRnJnOiHBCyvlh7zP8LxqVy75EnPcGke/S453MtmItEpqMeBuU+Gp3ldrbXZ3HCeS5GG95kLEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415823; c=relaxed/simple;
	bh=/Q1dFahHIxMm9OMReYUVAu+/7a4yn8HQC7tcWVqq1Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4IvmJ7ukTjXyOK+pIPpY/iiql8f9AAGxVrLQuNR2StC6RzYr0Q38u/J78nFGF7kBFZ4RQLBWMRlPsRfre0NQyHk0Cx6cTdh7Rok1Vcp5XuOhMvQVLcy3tbNbyRXTqXs4tg+IQ5E1TfJAHJRsWM8U0wZvrNhZwqSuqJl+K8AUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWpW0hAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMYXejDq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWpW0hAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMYXejDq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC9FD1400100;
	Tue,  9 Sep 2025 07:03:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 07:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415820;
	 x=1757502220; bh=SdR6QWKL0IZnf8WCCI5ueMSJ3JYCYHiKtsaWjJ1t9nk=; b=
	kWpW0hABMbsRFMcRjUq7qSRwkjWY5rCw5JDh9kxp2JnXMv/EgDcT5DFhgfs37azw
	ovMUg6U1qS6RePlvH0Bj4hJkPFiaQUezhFHd4pzbrIIEnDPzsKZV/ql3opn+/S4W
	yPxvePdDerokUKjx1XvFrNNgUXycAr/DaNdnLx++BcFpP/qXERuZaExLWOZtTjyM
	Pd7W+Ocxtj0I/CUnsWiRNc/M8d1MQwe/+k9eaJ8WDc+Cvn7tdFjHadvnbLbsKi4o
	6yy95Wkn92BWzC3H2bzfdjPnq62nTXz8LoDLTOIga15II/mRyUvM1wZmE3yQ+ven
	wT8JaxONdoBgR8Yytf6lkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415820; x=
	1757502220; bh=SdR6QWKL0IZnf8WCCI5ueMSJ3JYCYHiKtsaWjJ1t9nk=; b=S
	MYXejDqLKaBBjx0SO/iqGahosG/a0KZjvj/S29oB6GTLlwLr/XrxjJFV+xMz5FRS
	WMiIbxBEEJSn8CxuvZHCiyTfgjVatBCHOXpm8k42aWASMpdY0sEvI4NzWqvDQq96
	E2/zyef1eTkRY1BEYgM9FqSLjJYnB/FkdChBxl5Xr+mxua3DvFBXcLDCGRKId3Tg
	24ogeXV5TyVP72qDgd7ZubDFDXon1eFJJV4Jkhm13leiRK1ZohAfD7bePP/FKIV1
	k6+wbyAv63XbiKWsxBZFodn1TFS+N9Mzp1TUNKxdZ5rlYf1myjBvNvZTOQtPAm+M
	YDx6bZYKf+mhcbyvzfXPw==
X-ME-Sender: <xms:jAnAaCeQFUz0S1JOM3HRUGfgr8AsFGMySj86LORC-St-Irts1Y78fQ>
    <xme:jAnAaHv9tx2kjZixbfeOBlQwrvMyNLEvD9AVCdgww3A6C7RRQwHiByt8OZcYR6LYO
    QBxkx4O_s_ZVTFxBw>
X-ME-Received: <xmr:jAnAaJ-ZGNLoiJWwxjxB5VErhNYSqAmHMUXJ9PoAeRReHf0dU1AH9fCFNQ0IFSTyUhuxTDSKh5kWHqMJeQ4UbW9EiI9Vr0z3xKKE-Nqbegw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:jAnAaK3_J0Rfb2P70w3HFe5vjNzd7yn3rnTsidET_sswscuAcUTP1w>
    <xmx:jAnAaGCkNbLu-shSkjhyuA6IxqAP9jnkg-UsHCpi8GKOxNyfW94gSg>
    <xmx:jAnAaOeEPjHYXtu-kLEIf_V-CmR5D5-eAb0xuWOX2DPTHXmL0CanjQ>
    <xmx:jAnAaL5ha_G2DdQM1g0u2Q1re9PXzYQXkQpKyo2rsQaGfb66a81oSw>
    <xmx:jAnAaIbtKFTG8X0fhQIHuk0AB_Azq1i-LgV7_FrfwpkR_g8UXc-Ej37L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdbb2072 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:10 +0200
Subject: [PATCH v4 11/15] packfile: introduce function to load and add
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-11-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
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
index 599bad1279..acfa6042ba 100644
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

