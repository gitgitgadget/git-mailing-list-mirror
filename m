Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E03296BA6
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761989; cv=none; b=IECpDEqYG62SZMJGCKJHB/eLw9n7NbdlT+hl6IA6eICcUvF1lxRJvzGayrK2ODTwLgkJzJTINZeyF7Amz0bU18imCDQCfXB44QDvRAtK1KXj8F1rh80FZflVNiMWQxo3rDmr74Q6b/nAFvUJrXojjIIfDq81O3Af6vVf6EhonNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761989; c=relaxed/simple;
	bh=PWAcpA752eN7zAf+nODGa2nkdVgetb0leglQDJA61IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etnZubXXulQmZNAVygXvR4o/msGP8khINnGPA0dVpcZmPE0F5OfEy4OGqVglRflddvKVSegx1xPM3ovChEfvurZiTnBcRw7hjMV0ZjMQgIkicIuEFbm26QrrYJAcdnmxlYXtrUymrt/DgxQ+dysZKGS6opqPcH9QK4kfOW+Dhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OK67rbrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDql+8Yh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OK67rbrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDql+8Yh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 17E7AEC00DE;
	Thu, 21 Aug 2025 03:39:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 03:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761986;
	 x=1755848386; bh=YKq5lPwFkCjaxUTpBvIhU2mB41xUu6EHByz8HZLEfJc=; b=
	OK67rbrDfC6f1NsnPidSbJ2RLN+fzrnqi1qUrDHDkTWVofS/mbW9OHJWl+2qIHtZ
	4s9zilVL854X6CPTZg71Vxz/QV7LwxbPgxpztzFjx7/Up1cWgjW3IfUEGhGDYBYY
	FCbaKIOB1NR9UdTYvNtRiA9uq121DIKx9uH2SDGRyv6CsXGuHGSy7k25T2rlFQT9
	2i/Hr7bPVQfqEvkpAIDQp76QjqUcPsRXPp1rTpm7/seTb9MXER+sdfnkG3k+CHCm
	VM9xJMfJ8JNJeMMoyShVQFV6auoJN9aSRr+isOFm4MRqprxTG1Wepi7fdqyQS8ai
	yINt8V1JI7Suww4HR/tXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761986; x=
	1755848386; bh=YKq5lPwFkCjaxUTpBvIhU2mB41xUu6EHByz8HZLEfJc=; b=g
	Dql+8YhHznd4+OQ2eNokWkE4SVSN4NdjQIzjo7B72VJseHpKjo2wGX0XfV4NM59D
	doDJTEzeeOyORFpRkfh2Mwh1nuyTPoXgBmfV5hvJmcR7nP8OZevrGIJPiIBt/BJu
	Wy/cApj+y9QAvhE8ZmDqVM3KQxCsZpkaWtfd7uJnOhP5ILe424X937y9w1X1vxUJ
	hyS+21BGu6RbFtl0oHOyMMPgf4+uxxeKb/5YrM/5qdv6Ni5rhxthS5yq49Vrypp1
	KpBylcZ6PrlXHDuuDFEJDAC4kDY4mgkT8mnyHVl5b/FkgIs+JL6Ord9eDv5V7e1o
	k651T7uelR8cxVGmqwc5A==
X-ME-Sender: <xms:Qc2maB8_-rRuWcs_QiYWlzYMW9EenMMQOk0IgN0-k_t2hx3sZmUt-g>
    <xme:Qc2maI_CVCoFMdhXBNTr42lgso-Lia0g5jtM-hxtp-_wYS57jBK0Mh97uUzvlJakD
    wmgQPqgUE2JRLLvfw>
X-ME-Received: <xmr:Qc2maIfUgXOqqn3PvCvcA5dVH3eGQAzlf24LfZVstveHCQHtEPmxZta-_vrEszKI2k-As7aSxwq2gJ_PUUT1Bgli4_T10YohtYWT1bxILQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Qc2maBFDDjxJcQfpRDTF25H0pT9C1mI_s-XZ1ZNF0aKRYD7mzk8AXQ>
    <xmx:Qc2maGdVkf4yfCnH5zcM0KlwPXtEdMSKXmRfy-G6BwBethGLXGKWoA>
    <xmx:Qc2maLHwYnE6t4cuKGwx_nb2MpsV0vp96bygdH6RiQ_M-qeNzto-7Q>
    <xmx:Qc2maPVBuu8FMYRTRkgqm0gbPUkacwmW8DluPHR4x48qHRVJ_WyPDQ>
    <xmx:Qs2maFl2V27xCssRiSlY3a4teQkzWQS3rp7tHzs0b9idT3EaZbc05mvG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e6eadf7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:10 +0200
Subject: [PATCH v2 12/16] packfile: introduce function to load and add
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-12-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
index a79d0fc1fa..f7a9967c9d 100644
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
index 6641238796..c4e5516f9e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -118,6 +118,14 @@ void packfile_store_reprepare(struct packfile_store *store);
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

