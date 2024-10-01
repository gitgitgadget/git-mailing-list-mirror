Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A811A0711
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775762; cv=none; b=Z9i5OvCHW0hpMmQAUoOr6nylszYsoKZ/mdIpSppq913lA+mv/HVyRUE0tb1BeeZO6m0mh7gz5RIbq4ZYjXICzOqo7Z5gQylODWqKkJTdlie83+FLJx6UL2pSFLw9Mf0zPlLfP2oQe9S2my9URql+P6Lzn7BkfryGbNOEJnVRItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775762; c=relaxed/simple;
	bh=EKLM4HLY1J3UWglD2PFGKBssb9YjN15+GZauh+oJ4/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXEOiDzk8OEC6kooU0cIel03sPeQu+MlcGsGH0iH04Ls8y9ga2/opnXDkeIgdkH+U4GZlvprSdB02TYTvcbUsU8XXw8tripFdAp5qcUtuOIk4k0qBMPQnf7Iv80lhp7dShzE1cQnXxfc6zwHSe8nqN9nvx26nTpjbfUoQY5GWuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dbJ6p0B2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwJWlEvF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dbJ6p0B2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwJWlEvF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B50B138158D;
	Tue,  1 Oct 2024 05:42:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 05:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775760; x=1727862160; bh=NeH6GWRxfp
	VHTHVAv9F/b20tXGIwoNUozIP2jRdie38=; b=dbJ6p0B2tFY2IhYOmuCmqM+68Z
	Up64axNcHy9lqT5tkvEt6t8sYPRbnqwxZYe/fCLO1xm52kTr5Kt6Fqb2vCUl4mcX
	MDtxmTnZnpU953Qxu3HAdTjENpHHAQ5Oj8/CvqhXHQKUNEPjBxf64LPvEgebCQE/
	SP/PmuKuMtOPoS2kr9iL5m+YKTScCxrPsNJ5bGBvPzfVXC0GjUmI4xzIiixOulWC
	FEZgQHJ8+0wptHRS1ZyowJQVdZp+5WKtIeC8QCmPGc69jveCFtvP9fJjFfHmxdki
	I3hpI5+RLpTG4HCBZeqCw7l2Y7K+kIIbDZ+5dr2f2Zhp+TdiDevXZqoZIHuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775760; x=1727862160; bh=NeH6GWRxfpVHTHVAv9F/b20tXGIw
	oNUozIP2jRdie38=; b=UwJWlEvF8XuTo63Mb2CfGx7bb0eh2QOHRYabjIh3CepS
	nioTL/qmItlTNq6X9NgCT3Q/4pe1m2ozPBFZwxxHGxJKAfTVb9SMbPaHcNHuK9my
	sZzdAAGtd0eq9A44r0W6wSGY8Zg/loxepAxs4KCxv3rQMoKO/Cv8Nz4W8WDL9KtJ
	4L3DaT+4wzP3ARLcloBAGO4Vpw7pv3eU9LF98G3rUm/hBxqBi6O/H5/m9mRxXSeK
	y1o67ieaxhT5Y8MJ9q9OqS18rfXmRZnYmtZeF0/pIQHtu4wjGq1h9NPg/3sv0ePj
	gm4YlIkXvvZ1hl/6+RzVL/rOFCUZQ3Q7Zrfa19X4Jg==
X-ME-Sender: <xms:D8T7ZsKVf5CQqnwh-I4dNTQq3uBdGoQDs-DCblT0ODjyJjOhJ7LY1g>
    <xme:D8T7ZsIrrbmdz6HTLXIJ1Abi3nvdCfawLFgrAf_Bvupu83DvY86xWiM5qNy864OeR
    o3OsrnGz7Pa73Boqw>
X-ME-Received: <xmr:D8T7ZstFRC5G2zROfI6bSAlz5e3lItF0hHHLG-tv1WgI3RUhxv7N8goEYTWjmwiInci6sST6C44NLw5t0Ycc_e0iYYsHSoP6MbRVTvCjmk_Hlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:D8T7ZpaFza9Enox0oYFgyY0E4JPMp9TOy6Q7qHD6SvDY66Llmy508w>
    <xmx:D8T7ZjZpEvfEZ2mQM6ktTJi4zRXXvIN5P06cN_3veGwrXBhzjng5LQ>
    <xmx:D8T7ZlDsCxDo5xD2VIjnYEtc9IgxYdZPeW0OhRF2jT3d2VMDB9huyg>
    <xmx:D8T7ZpYPwTfCqqEMe-DvXyrZWa1HsffKo2GfuujrzlWgwPid3syD2w>
    <xmx:EMT7ZiW7MNiYbN6-Ipuj9wuTDC8lgvqWyu0zrf2MFzKZc1fq5KPVXq4q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d8c9ff9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:51 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 17/25] reftable/iter: handle allocation failures when
 creating indexed table iter
Message-ID: <6799d299fe6dffcc6323f09dda6cd6cd51996056.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

