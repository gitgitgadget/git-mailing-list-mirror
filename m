Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0920126A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866580; cv=none; b=CHikziB2uu7e2GSHFCw2zyQpKIdhMlhnAa3F+2d/BaSEvy7LnKbfqw6yMhU//HQLduFq9qWKmreWXGzo2IPchoGMfEKe1JVnEGpUE2W8/9SJMsKbDEHUN9InRTfCV+T/9kBw3m/yjedS5+cpjSgCd6Q9Gsbc+v8a0oigup/5weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866580; c=relaxed/simple;
	bh=EKLM4HLY1J3UWglD2PFGKBssb9YjN15+GZauh+oJ4/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLNyPRxYEwc1e1QhW/H/2ARZ70mt5ef1CHlmGnRMsgIUl3LuEj7pB/pkwaSYyL83zJiSYXZysJfV2Cjbh0faeBjzSdijdgaaYBuT7XXXJeE0Dp4iAHMfPAQXYpra/ZdSi61BdlXQygd33iKShVrnizjMX4JCMLjzyZbvKIWLUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kTOgMILs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VP0GP94R; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kTOgMILs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VP0GP94R"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3091114020B;
	Wed,  2 Oct 2024 06:56:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 06:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866577; x=1727952977; bh=NeH6GWRxfp
	VHTHVAv9F/b20tXGIwoNUozIP2jRdie38=; b=kTOgMILsPNbW/wkOB0mprhxysM
	zrn1emBihZiWXj7q6DFgLVfOhZB8Udmc5s8awQ8QW5GdigvD9MiAlHbSFsbFRcTC
	sySzqTEU6uWuui1K0HNZe7vDuD/uvEKJ6HD340B+QQ1j/1LwDPBu4zdQLN/+7UPB
	L9Lw01LUC8seKakJG8hv5g7bvKjZdVYhyhWbxF6DWVFm/N567vwTKbtr+sCRNXlC
	LaSyDQom8vpcIdh4t9OClho+dOG7R4hAQqS0J03Xifb8PfUeeGF5IDT06bZHxi0l
	Rspzz8brl4VMXyjYNJW+8TzhjtBeNQgeDeOQvd6I5PNAomEeEtWvdlN2LbPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866577; x=1727952977; bh=NeH6GWRxfpVHTHVAv9F/b20tXGIw
	oNUozIP2jRdie38=; b=VP0GP94ROF85EkhX6pgDFQWCKOa0KCRwdiB/LPGjPekF
	Wh20+0+MP2vqsS8k9PT0iaEhGjqPeqrS60xWCr9gELSnhACP4PU+UZjXq0O3OLVV
	Ue/lXfPrW/SRxG0VgtCBjlIjua3pGe9cdMiEYBpE4OToZupt1dvmZEw2VnThmPFu
	xUrIsXvoYB6fYpSMthzeP3lfQcIGW1tcXjWGyElDzZRstW1XwL5I9Sy6dnXPnzQb
	AVgt20M4BffoSxjlbElsa+RxRxky+5DeKdXb8QI33vlACIe/GG/MXyjG5VEC0hlm
	z1XcGiec6zEtabBGJjzr33f7aFLr4LnZwJeyubKPXA==
X-ME-Sender: <xms:0Sb9Zv-4TVvpMNmdlyM1WuwFznJ3CX-8AwiT6CAZxaGNiYJwKqRvwQ>
    <xme:0Sb9Zrv6VqkpShZlOoCr2-zoA9d7fu8s0ueM1PTkJbfMz59SvNJII957Lp4QZGN2e
    gm4v-8ziW0e9osVmw>
X-ME-Received: <xmr:0Sb9ZtAbEYVBcKC9ayu5d6UAogf2U3czz1CWyTy81g3_eAO2Qhw7fNgH7P52NUE84Y_yAJn-CdY-zf9E9jsXOTPPGtouSHNSm7DVMeH4BGhba11Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:0Sb9Zrcj6U9kg-1q9OS1l09a-_A1rj4qoSoZTJ82vfE6AtvgEX1Wrw>
    <xmx:0Sb9ZkNjUlcqYPlD99mfQwVkIpdYvPJz11v5Es6z75aQyiCtxQGJ5g>
    <xmx:0Sb9ZtkR7U9g0tac7Nf73AwQUVDwNVHuA34OZarXo0MqV65QyejsfQ>
    <xmx:0Sb9ZusgoxozaqTtk7VMkj3v5NavJBbqGPJEDbNmuEpFU1UInVtWpA>
    <xmx:0Sb9ZhrCYcwfLlgMU2-vRVZylGbYKpsFpcWROADqOaE7n_UrS8u8eoHl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a88b320b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:26 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 17/25] reftable/iter: handle allocation failures when
 creating indexed table iter
Message-ID: <6799d299fe6dffcc6323f09dda6cd6cd51996056.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `new_indexed_table_ref_iter()`. While at
it, rename the function to match our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 20 ++++++++++++++++----
 reftable/iter.h   |  2 +-
 reftable/reader.c |  7 ++++++-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 416a9f6996..d319538f80 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -181,14 +181,20 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 	}
 }
 
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len)
 {
 	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
-	struct indexed_table_ref_iter *itr = reftable_calloc(1, sizeof(*itr));
+	struct indexed_table_ref_iter *itr;
 	int err = 0;
 
+	itr = reftable_calloc(1, sizeof(*itr));
+	if (!itr) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	*itr = empty;
 	itr->r = r;
 	strbuf_add(&itr->oid, oid, oid_len);
@@ -197,10 +203,16 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
 	itr->offset_len = offset_len;
 
 	err = indexed_table_ref_iter_next_block(itr);
+	if (err < 0)
+		goto out;
+
+	*dest = itr;
+	err = 0;
+
+out:
 	if (err < 0) {
+		*dest = NULL;
 		reftable_free(itr);
-	} else {
-		*dest = itr;
 	}
 	return err;
 }
diff --git a/reftable/iter.h b/reftable/iter.h
index befc4597df..b3225bc7ad 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -82,7 +82,7 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 					  struct indexed_table_ref_iter *itr);
 
 /* Takes ownership of `offsets` */
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len);
 
diff --git a/reftable/reader.c b/reftable/reader.c
index f696e992df..0179e4e73d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -715,7 +715,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		goto done;
 	}
 
-	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
+	err = indexed_table_ref_iter_new(&itr, r, oid, hash_size(r->hash_id),
 					 got.u.obj.offsets,
 					 got.u.obj.offset_len);
 	if (err < 0)
@@ -740,6 +740,11 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	int err;
 
 	REFTABLE_ALLOC_ARRAY(ti, 1);
+	if (!ti) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	table_iter_init(ti, r);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0)
-- 
2.47.0.rc0.dirty

