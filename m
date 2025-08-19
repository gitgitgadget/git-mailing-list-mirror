Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3D31194C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591615; cv=none; b=bouvniOBSRUvqRfpsKh2LksJPwoFX+Wx5KWuS6XeFaBpAlKSVm+NphzkxMs7Vl9r6nK+e4EDupF8P9fI6T251SkT7LDIaMt5OPGhMRWx5sJk2nJzFx6LzT/1TFFSVEN8AnUMQZWwJ4g9GY+ASMPSy1NFSPRpuvSFB9CAdv2NSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591615; c=relaxed/simple;
	bh=AkP6Xfj2t+j67GXCUXF/CBtEr4lfw/aAuI5wp9K5YE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AedMdKGXpmHWzN6xrtH/9Ows9HA3cfS2cW2M3jt9L0FhZNDyzAY30cgsjMDSaskuJGPPk+7Vt7HXTTedl08gLtZo9Xx7vQJimgcl6ey6l96qDM6BAL/jHwPB/Glmdekgz/AZWskquI5P1t31JPq6nYfxi3k4nwvu/cGsBmFyFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UNNeNQ3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARrOXvtX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UNNeNQ3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARrOXvtX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7190C1D0025D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Aug 2025 04:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591612;
	 x=1755678012; bh=FFiP3YUNNG+NWfVyLJVz9lwXYBQNa6gMTL1aeHSCmMk=; b=
	UNNeNQ3LJ281zWrbvhnS3NIE32urcX4a5/ka2NBCJMoYtz6wG3HSInPYKrcKtlw4
	vtFhnPrPnESIXrwyzGHxbqxHRNCvrAMRU/UmIf/M+hytgfoEMcmR3DbLShzu+N7G
	9oUhpTt6qTtuI4ZBQl3SDriwWAfurcAVfQY6hwc8g21ZLydkTKJUU6W++jUDksW3
	I2WhfPO7ugNUkyYEGdaJzLt8AU5/WzZARcKWq75MxAQQ6QuDSXhf2VdtqdgHVoL9
	dzDO6mEMey3U/xTSo/3jJM39WOQwqp551AFOfLslh6vJ3Dm2YbBLPyelBrMMrxTF
	cNGwOg9DOoxR/ilR74qDVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591612; x=
	1755678012; bh=FFiP3YUNNG+NWfVyLJVz9lwXYBQNa6gMTL1aeHSCmMk=; b=A
	RrOXvtXJ2lR97cE3FM8hGo63bxvSEqtsA24xU5gYZEIw5gco4TwJYfg6bSnU35S8
	cRM5Kqk+fpOxn7SHsXR4TxtRCFtdgyTXN4aNBTujbGPIqMFxkGHyvmR73h4/ks/Y
	s4JPTNDVkzXN4WwtFHctowLuUEm6CquLtSq61twTWCyXZMO4YTdLh0236tIxPSW6
	4H2AnF2R3kgIG7WLErUyxfCZiLEF4FINQCpF4Qyt45spTq2+T3dQFXy4B87Z2UNi
	/Nq0lztL6a9vWDTxMLN+vDhBaLRKGYjI9mXYLh3pSQYfl1nhki2nftO48sQagH2n
	gqhoPjNTG2axYTQDgajXw==
X-ME-Sender: <xms:vDOkaCNL1TlbaQKwrzb8AfbdHhkhsw_KflIM8OxLkxYHnIHh6YSDQw>
    <xme:vDOkaC_buFuLm3wIkyMPmE_MLCsp6aJgegN9q9Ys6f7U4Dd_-yMmcSGXL31xOF4gW
    lyGjW7nWTy8FmyQ8A>
X-ME-Received: <xmr:vDOkaCoOa1wneiJuGhcFGWAC1Wca3Mu-hPcBwJK9hss2Dxk5I69NW9MLpnuiGtSdQYHuFHPA1NGmVkT0FohpvgZ7zzdZpYNIdnHkAR_mmlv6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:vDOkaE65K6RqffYYVOhiYhx251XlDs9lVDGAou7JQDS4CRHQY6UzsA>
    <xmx:vDOkaCPnrGh2GDUssN8aE1yiUcNB5l4r3q1Rb_ivXcgBFrOuG6mGcw>
    <xmx:vDOkaGPlimY1tZ0JiMKXNGpqdjxxt7Pa3qfLpcEqPGhVq0MtvkScWA>
    <xmx:vDOkaK88Ep1-SMZuKdXK1fI2MiABOD5w1D95f_sWd8lndWKplSGvpQ>
    <xmx:vDOkaL3NDxDwgctf58RMAKCwtO0R5P_5ECLllQ3asvhYaN2YhNit2ik6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15f370af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:41 +0200
Subject: [PATCH 12/16] packfile: introduce function to load and add
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-12-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
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
 midx.c                | 18 ++----------------
 packfile.c            | 44 +++++++++++++++++++++++++++++++-------------
 packfile.h            |  8 ++++++++
 5 files changed, 46 insertions(+), 38 deletions(-)

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
index 3cfe7884ad..d30feda019 100644
--- a/midx.c
+++ b/midx.c
@@ -454,7 +454,6 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
-	struct strbuf key = STRBUF_INIT;
 	struct packed_git *p;
 
 	pack_int_id = midx_for_pack(&m, pack_int_id);
@@ -466,22 +465,9 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
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
-		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
-		if (p)
-			packfile_store_add_pack(r->objects->packfiles, p);
-	}
-
+	p = packfile_store_load_pack(r->objects->packfiles,
+				     pack_name.buf, m->local);
 	strbuf_release(&pack_name);
-	strbuf_release(&key);
 
 	if (!p) {
 		m->packs[pack_int_id] = MIDX_PACK_ERROR;
diff --git a/packfile.c b/packfile.c
index 8b5e6b96ce..f7916543a6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -793,6 +793,33 @@ void packfile_store_add_pack(struct packfile_store *store,
 	list_add_tail(&pack->mru, &store->mru);
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
@@ -892,23 +919,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
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
index e751a5d93e..4971f18f51 100644
--- a/packfile.h
+++ b/packfile.h
@@ -119,6 +119,14 @@ void packfile_store_reprepare(struct packfile_store *store);
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
2.51.0.261.g7ce5a0a67e.dirty

