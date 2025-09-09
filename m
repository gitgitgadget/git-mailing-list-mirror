Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E4321430
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415826; cv=none; b=JDNgsCAUQXFBo48U0dg7supoqcH1jlGSGoO9aR322676QdQvFv0HpOF8nBGIQBvxO2MY1Rh0vRJelCGNdaqt+WRVMCzyg/jR6OQZiJ+e1IclDDz0oMdW0D7m/X9pA0lgD2Dc9U+Isyjwkkb5oAuPqE2iPFxtrnYG6nTVSel00ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415826; c=relaxed/simple;
	bh=NNT4SNeZfDCma/QCy+ksVNf3crQpg1kgdGOVicTLIVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkGyYRZh84WlztryEFDmGs2LVn3anX3aiPyqWd8QqM9LAmxMr98BiM4U3mMdSmL61RWdxqkrdVWxtOwh/kYxTwvBhDktBmZ9oTtDSTunB9UaoShEFKrV8JaKIzWazXxRh63OR6iWBI9Fk5XtDy7mx2UPO+xO3ADaQ9tJFQ8SHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bi2NgxsI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXCrTxsm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bi2NgxsI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXCrTxsm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 383E2EC0F5E;
	Tue,  9 Sep 2025 07:03:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Sep 2025 07:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415824;
	 x=1757502224; bh=29Ejp2oseP2HPcCR2UkoWn9HsOJ4vG7w3PCslzlRDO4=; b=
	Bi2NgxsIntVOzFZmT1v6MmYu7EvLyHb7u1zOrszYGHhoXG12Q8bQutudj1Dh3I2W
	IxNmauotbF/PIpGO7JZoKJwcSonVeE4bqT04RgTAdWJL43LrnLu2tMBtkxx5LvM6
	1xwEnKq/KFJBvNsFrJtvPsgEbyL/ZMhuXjiLw74etfIFl9GDI1i3KMohuejHZFDI
	Ue+MqWc45pLhDqC+1o7YS99qw/T4+Msoy1+ANf+dhr/fXM9X+oetZGVREcF+5rzk
	3xecrhyzBIMZSeP/B5PQpGbQCCMMnyuwszsEuq7zjeXDI84yOXAQXo/XCs+AyFqo
	UWaop98v2e9SdFLBGmyOFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415824; x=
	1757502224; bh=29Ejp2oseP2HPcCR2UkoWn9HsOJ4vG7w3PCslzlRDO4=; b=G
	XCrTxsmYbibfBhRafHl+Qin2X3tLflb5C4PDBiY1HXMj4VDwVOViTUtGqoeT+zhy
	awY/NBVniN28TdIZiaRl713tye0tobfd++8iahnFJEydhNhofg0qhK55zXK4oJsP
	zel5RVEefqF4uFaYDRWHT1lQpiAw0aWTiaWcf92W5oDrGcZnM4TTybitTvSubOvn
	nN+NiqCepQbdEptAR6wp5Ch7hMy9gCKLCwKeQCC0mbkkJ4CPUe2KrDBv/bB9x9BI
	Yo+q+CR6Eu/1ZYli4MvV/wzjCfF/RcFo4gOp67ehaElLiWUaSMsZLWe6FMMZ8Tv5
	Be9kTr9L3ja4W5GHIN6CA==
X-ME-Sender: <xms:kAnAaDQ_w30VEqWeqPJdvr85nISrDrfnG4GGvvhMsDIL-5Ibx8LmBA>
    <xme:kAnAaAQ07fXCCBBN7c6mqaqwa6HIMyKgKCT3EacWAr19mMfCmS-ExxzxBjRwJIdLx
    RFzbbjGO75WJiM25w>
X-ME-Received: <xmr:kAnAaPTnC8SGny0mdRXaf5oxNu1waGFNOeeCmDRVg3khTuJ7qc0nRdmjWdQxzoe4C2LwGnuc0QCrr-DVjKpjBstB1h4zM91MxVHRHkgwuxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:kAnAaN63fM2ylhbMaIspe3ayrX6vlvxIuQQntTrHovJXC7bvST7Wig>
    <xmx:kAnAaD0X8JMGk8PSc1QW_6XquRtE_8xz5XInO-AxffNINQpyJymJCw>
    <xmx:kAnAaAD7j1okxgzlngUUsl21Ak1j6k5nMzNjkVdujnBCpQdsM2QvPw>
    <xmx:kAnAaGMgQUZx9o79f9F81ijExktmXYqjU2QDkFYNtbXdmyUDi8o6Jw>
    <xmx:kAnAaBGWBB6tt-PyawA6mTrm1GvdswILyBBQNblTGwgZxicRM5Zp6BNY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df2e13d1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:11 +0200
Subject: [PATCH v4 12/15] packfile: move `get_multi_pack_index()` into
 "midx.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-12-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
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
index acfa6042ba..e3ac7a2993 100644
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
2.51.0.450.g87641ccf93.dirty

