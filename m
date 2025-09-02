Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA712F5302
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810158; cv=none; b=uLU9O2tU94GXTwqlqf+4ul2jC9WMxKOXWNRAOju1D07i+HiMqzjyflMg9x0MKoywMSTuaS4i6L8sOA3jgWl96h3+VEK8fKyyqAsrMdff0XagRxs7QAnVqXduaq7ayv7ZMk7vKrvZMV5CIxtPc0+s8jkUD3Fcb+JI4VQMYjpvcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810158; c=relaxed/simple;
	bh=EUhafD4DgJkOkoXOLu5GL95zxCem6SmVhRzfG5OWMr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KegC1P/XhDiJ3oTlDHsJBTGag9ZCNEvwmeosBqbYRNpsQytE/Z4l+uo8CrMtDW/U+DdZu8VU9ZYM4Lz4Xyftl09WY9dqBBCgSbblUbKPfLzPtHW15YkmVDqQh4Fc5uNEoTx/rQ7IH43w+WlrwieuO6UK+w223n6hRueiu2O+NoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qvXQIPPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SWnXpabW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qvXQIPPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWnXpabW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B596AEC047F;
	Tue,  2 Sep 2025 06:49:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 06:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810155;
	 x=1756896555; bh=qwIZzm7ldRdEyQcqDKl9w8GghdOfjA++FMSdeyLFvg0=; b=
	qvXQIPPzns42m+jXWMRse5dfL4PNAT9ElVlxvKlYwOD/buj9xF93vp3SOCNTnFeL
	UwzpcF5HsPP2OPHk2KGoK2q/Z2BMu+o7tMnAUMGMqz1b/Nu1QBoysIp3eEW2bg4m
	j8W/8zkIqydHV3QR1FsAD1rnOq0kfxOBHeGNtVMD3JmC/FpFJG9D0ZFF/YyD4gZZ
	Q8zcXxwyUOJscPsIqeljljfzNxMitObc9WYugoYXdCMrIX0/uOrajBSqU54hHUag
	O19aXFdc8p1WxLNFvlxKsGGtFZD1r230BSEQdOlCZSrWdBZGTrN+hWYYRb+W5z0B
	1RYnaXiGrf/L+ehj1Q3qcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810155; x=
	1756896555; bh=qwIZzm7ldRdEyQcqDKl9w8GghdOfjA++FMSdeyLFvg0=; b=S
	WnXpabWcCWGCI/vRir2XM1TazCb47lMIEqljHkuaLsV0aukoTZMM3wNbzhLVKA3j
	rzRnKe3ubuSD8F6liG1iwyTCN1ncby9DWW9viVXAUO8CUg5WFwpQnQOENFBiWaqW
	HVFKrv67t/7+dbFW4XRZLuIClm8cDdGv4qJgFrGzrxf/a0AQbOkDhyV598mWUNH9
	ARX9geLNMTA/DOaX9uOnOSCumiCopKq4J+zleUx+LHVOB9EkP+boJ81gBeU5LWhi
	hQEZWr4uqnrzYokvmCyX/HXquZkmCFw/hw8tULdsDHt3mCLcOj30ZeKNimIRlluU
	nmgJxlEd2UHoUkzLgJl2g==
X-ME-Sender: <xms:q8u2aC34swcv33qwJ825miVGvxr8NUuNqCFPGG4A-3c5kggegT0dIw>
    <xme:q8u2aAmsJ2up-b0oWBlC8tTxDpvU3zYSq9IbYgU6kmonw0CeTxgzNzPPmnP7AzcgE
    XMZQ4WFGWCaD5KnNA>
X-ME-Received: <xmr:q8u2aBWAYTBNbVk-i_SL8f6Scx_Q77RqJfOJ8MXx3Qoqy0xtxAjo_K7ULweSGcgEIGBZuAA1t2ngK74-LisfhUT2kUxNgVQSTVEA0UrVZqjeyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:q8u2aOsjCLHbkqXtY1SrZ7zgXecs-PiuCYGdMADptEeqjH72DowJ9A>
    <xmx:q8u2aMbGXJvJDc2rhvxUR6DhN74lcdy1a1dzLvMoMP95kGnjQnQQ8A>
    <xmx:q8u2aFXO18kQEcpzsLuCK_gIYCvdA-JjiMJOtNLoj69WLHjQ0ae3VA>
    <xmx:q8u2aJR5ELgnxACsF8Q7UogWVPamODDFURrsGan3Ud1gjqBvy4hOLQ>
    <xmx:q8u2aB6s2_yFPFxyNeE0e5MTcW63zh1wdTCmK7IYMIF9WjM9aOb6TE92>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a797589d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:36 +0200
Subject: [PATCH v3 11/15] packfile: introduce function to load and add
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-11-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
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
index e1a3c0487c..e8b5be645c 100644
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
2.51.0.384.g4c02a37b29.dirty

