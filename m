Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48212F6193
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810161; cv=none; b=FWD2+Zj6khMk9lJFKfhnDKLer1Su8fBd9xE5ioMcnsI7PvmNPA+lKgnEAyhuB6cRJ9YO5z8WR9m4lCdYxVCyhmbretL3QVh6BPWXXDDIklGm9eOlskOa8QUEQLl7Vv/I55fTo4k8RMHy7v0ZFYoi9UZF6m4Nbv4gKjktd9iq+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810161; c=relaxed/simple;
	bh=CEUW0ru/5COTELwmVhpxnvrcQ56HWc3J15tRdVmLmJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwhHcIhRdF110sdff1uOWFGzRkREVH0ATEPz6LI42phuQI4ykGmqUFI7P+7ohHhyzwWcTT82D2wGhtKodZ02uyuEkFMqFvvBnKISgBs2/phHuPpCSHrgqTymCbjT3p3im7tLw1Az5ya5y1HtmbDcOBux4h+rVVkvfcO2jR3B1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tS+CabhW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AGao9ROk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tS+CabhW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AGao9ROk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EBD68EC0480;
	Tue,  2 Sep 2025 06:49:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 06:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810158;
	 x=1756896558; bh=yCDMmxAdwEkdgnGzwtqDcv2swQi9Mv+5fdGsW9zIq7o=; b=
	tS+CabhWKBYM562p/ccimKptcKa4PIqwBKe7Ap2QCEr/PaKwA91hgYyiqZEvAVoA
	CWxrQ8lsTy/tEkvcIAVjJtLDxAjTTJYlZtVn3jd9ZZ/EEatX6LDvWRJmwmenoOsX
	olzSlIfp3h5qfb6MraBAlsr5Ftfl3tnV1r+BnSNuFqKi2ZrIR9gnQsAuglg9YC10
	bip7EEg5aWx8xQy0uKEj6XAMdKiPQfBGLwdqPIV2mseGJu6K6wPXqpKson8TdBS5
	mtxOWkfEYc4orc46mxQUrCJaiUPZSn64SJ2E9z2xk2cQ9Hw7Z8XRuCqSR7YWjqV2
	oI+b7GEnf9s/ArpkL9l81Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810158; x=
	1756896558; bh=yCDMmxAdwEkdgnGzwtqDcv2swQi9Mv+5fdGsW9zIq7o=; b=A
	Gao9ROkvOf+NEFdwixn0syQPRtFESzghSvFi/T3vwSjQZsKWk6/uMd4fTv+E6WB8
	SNI00QTbo97YJxG0VbpsG/J/Z3a4+MTqlSb2X2o4irmhBN5p8mLcw5IPUyfy6WAA
	gPHMJLefw1eFfdUm+brRw6cvuCSCZ2cHRLDh6JuPsRYFcTYFjemfyygDW29gYB7T
	OG6FSbvW+nF/WZ7COxejh2bJNUZ+wFMc1F8hokN47bBhfU8JaODJqJQspbhlpNOe
	vaxEYEBt2AqRwIdGXTSJlWlh3Kdk/HKkB/0Q/lRs6NuyKzcyRBx1emt0clCMEbxO
	s2BscYU7/+u5I1289lPXw==
X-ME-Sender: <xms:rsu2aI0Nx7RmWfEUX5SSORs7QNAFqkhri8DZkZRwMCBVUPX06jHcuQ>
    <xme:rsu2aOkF_DUNqxB91Odic0AbBiQoenybgMKm3Gd35Skd6iD60ci6jgkYyBPTH4sqT
    ysBPosOY_eoIGE8Yg>
X-ME-Received: <xmr:rsu2aHUEC3BTqvD1Lkbqg1lykpw6Aicq_-ePe9qx6RLF9G0iBQf60dVcqjtWvNnrnOEiP5cBYHlj-HGI36WhEwJmnMffkkMKkoDXxPPioGonpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:rsu2aMvAo2EVxbsOxYzn-0hCy53MEOjygLedMvepyo4myoDwOfP3aQ>
    <xmx:rsu2aCbSD3uY9WXyyKm0der8TSbKPnmOtT61C7tsCApkK_Y1H8AWJg>
    <xmx:rsu2aDXmy6F00MBj0eqO-p_SYGkRw74QJao4oQK-pcZskHpuX9FM9w>
    <xmx:rsu2aPTj8TpzviAAnWUMs8oVhiseUOSdeqjaXPjcPP5RbTB5hhXFkA>
    <xmx:rsu2aP4Ih0vlWnN4pqioGS7kz5S8ooOWNN685-T-UOJ8CELRy_g2eNnq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bc4ae60 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:37 +0200
Subject: [PATCH v3 12/15] packfile: move `get_multi_pack_index()` into
 "midx.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-12-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `get_multi_pack_index()` function is declared and implemented in the
packfile subsystem, even though it really belongs into the multi-pack
index subsystem. The reason for this is likely that it needs to call
`packfile_store_prepare()`, which is not exposed by the packfile system.
In a subsequent commit we're about to add another caller outside of the
packfile system though, so we'll have to expose the function anyway.

Do so now already and move `get_multi_pack_index()` into the MIDX
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  6 ++++++
 midx.h     |  1 +
 packfile.c |  8 +-------
 packfile.h | 10 +++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 3faeaf2f8f..1d6269f957 100644
--- a/midx.c
+++ b/midx.c
@@ -93,6 +93,12 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
+{
+	packfile_store_prepare(source->odb->packfiles);
+	return source->midx;
+}
+
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
 							  const char *midx_name)
 {
diff --git a/midx.h b/midx.h
index e241d2d690..6e54d73503 100644
--- a/midx.h
+++ b/midx.h
@@ -94,6 +94,7 @@ void get_midx_chain_filename(struct odb_source *source, struct strbuf *out);
 void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext);
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
 int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
diff --git a/packfile.c b/packfile.c
index e8b5be645c..70355ae92b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1003,7 +1003,7 @@ static void packfile_store_prepare_mru(struct packfile_store *store)
 		list_add_tail(&p->mru, &store->mru);
 }
 
-static void packfile_store_prepare(struct packfile_store *store)
+void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
@@ -1033,12 +1033,6 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packfiles->packs;
 }
 
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
-{
-	packfile_store_prepare(source->odb->packfiles);
-	return source->midx;
-}
-
 struct packed_git *get_all_packs(struct repository *r)
 {
 	packfile_store_prepare(r->objects->packfiles);
diff --git a/packfile.h b/packfile.h
index fcefcbbef6..a9e561ac39 100644
--- a/packfile.h
+++ b/packfile.h
@@ -112,6 +112,15 @@ void packfile_store_free(struct packfile_store *store);
  */
 void packfile_store_close(struct packfile_store *store);
 
+/*
+ * Prepare the packfile store by loading packfiles and multi-pack indices for
+ * all alternates. This becomes a no-op if the store is already prepared.
+ *
+ * It shouldn't typically be necessary to call this function directly, as
+ * functions that access the store know to prepare it.
+ */
+void packfile_store_prepare(struct packfile_store *store);
+
 /*
  * Clear the packfile caches and try to look up any new packfiles that have
  * appeared since last preparing the packfiles store.
@@ -213,7 +222,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*

-- 
2.51.0.384.g4c02a37b29.dirty

