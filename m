Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21E158531
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489723; cv=none; b=O4oPX3Q2p+8EqNA5vgFcXjHMI0obrzZIegDp/fJGuMhN8aw6F4AVodKDJpO2FFdDPUy1SROiZpRITGKbnJY0D0mlaH6XectbhHStuiZ+WH2oFMdnzkF0aNhlUnFbx2KPUN8CSmRuHho3mChafj11Jk8arFCs4NW5gA2NvO/+PF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489723; c=relaxed/simple;
	bh=Q4dd8y3RN6w5lA6V2ET3MVcXVFzWlUERSEXM9/J3iNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA14ProFkT4vwSlXQz6DAQ11wGJMmYyeIPRthlWBXrfe1/7wwTev0PlQdBaos2qPVLEe5mK7e22L4GeCTUghWkWfspI2rBR8ChF9dByN3n/nEGuXOgI4RfAkROkm3k8qrfosHh1YUDcZhYe8Ae16p7neHFjKTC4OQ5Lg66TLr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nHu058pA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3Vko5PB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nHu058pA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3Vko5PB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90F2711401C3;
	Mon, 16 Sep 2024 08:28:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 08:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489721; x=1726576121; bh=A0rqFRcFy0
	0LGfQclvGDcrRVIJxbzFkES3TcnPacNFQ=; b=nHu058pAOvUn2n2ZVg0oYOTDPJ
	K4T3HpmYzLPdWw6wzmj6EjmL7hQHbb8UbYChq9xO29SHFX2Q+9V3qDxtO02ZHhtY
	+bR/+0EBN2YgH2K1Vp/OBiCjsIoRgvulHQL2nFsVjBovGCKFKgjsg8ROM9MaCRUL
	Pc1BJuckDXnnExQocGTybZ2B5x2j5HMaXQAENfLbyujvPLmkCkY2pxkCzWPUgycl
	QwPJby+TlMRVA7FqQrBBeJfBHelTtDkIG34x6eU7f17nOvWLrnSGHbLNFrF/YrbR
	odzxIXvTPtIGtnjxjjpBjr8nPJQgTNZPqLhsU8VmvDi+4L8OdMY0eSJRmd3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489721; x=1726576121; bh=A0rqFRcFy00LGfQclvGDcrRVIJxb
	zFkES3TcnPacNFQ=; b=s3Vko5PBKllHQbhcwZPp+Re1PnPZTMGdCq1UDNNcqHvu
	UXYow+B7/Ng2z43ggOGde9AwpWmp67bHvjLIwiEFO4c+gqORHpaGN6SxRzAVE5oZ
	3GeN3TiCgC8apHoQfI2hmukN4RyFycva6GPSxpyT+J5WrPein+EOHbOSFn2mBSZ1
	WKq5/jdijbtfDk9DkNSKLiTnot9rvT1hpxbKsu4aYRGNG/MJHfv/I/vWHLPJyRap
	yU4gLQEsVkLCjO8j9gHHxDYj18XEvWGe6GPtOatpuHyJffrs0Yc39cgrEvpqDd6n
	+az3rQgXmLVEWKXTXabcOeIVNtgcbZXB60R6SdD81Q==
X-ME-Sender: <xms:eSToZuSCQfP1UCpBsv-PIaK53J0eV3jM-D3QvkHSsvayCt6khEg5Kg>
    <xme:eSToZjyvoxge7glR9bI9p5RyBtazTSgcbu-OylWKWabvB6kDBWtAe7enzMpyTkdox
    Vj2aJXYMc36ZJOwRA>
X-ME-Received: <xmr:eSToZr3c0RfgXcjW4FHrWdNGQ96mEn9llSDbVeldO_LO6J22AjfXpVuYhYk7vb4O4AHFjmroWmKh5rMPTkwljHxUacJ59opXyz-1nql8dsurJKIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:eSToZqA2zFlEXsT_50h44Vi6Mm3y1EHMAMiyEGuKRmIKTZ-biiBzjg>
    <xmx:eSToZnjGygx63faY45gBu_rAGSK-FOY8KyplPPjNnlM6Pxu3klGsvA>
    <xmx:eSToZmrtLCic-6nVaxpENXEXPIw7qFr6fzNZj6CZS6e9gXMQ_svZSg>
    <xmx:eSToZqjjw7SUCly7GK5E1rs5JYmiws7g6gtE74eHhuYkG_FWKMJ0Cw>
    <xmx:eSToZqsqi4t_gSwMfHXY0EodDnAcfcSShWSvp7ZrVw9bQDZX2Ki9-rq2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01d87b6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:23 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 08/22] reftable/writer: handle allocation failures in
 `writer_index_hash()`
Message-ID: <7404d648a9d4c28db0ceb94961accfb272b80b76.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation errors in `writer_index_hash()`. Adjust its only
caller in `reftable_writer_add_ref()` accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 61 +++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 9d5e6072bc6..ed61aaf59c5 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -186,18 +186,22 @@ static int obj_index_tree_node_compare(const void *a, const void *b)
 			  &((const struct obj_index_tree_node *)b)->hash);
 }
 
-static void writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
+static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 {
 	uint64_t off = w->next;
-
 	struct obj_index_tree_node want = { .hash = *hash };
+	struct obj_index_tree_node *key;
+	struct tree_node *node;
 
-	struct tree_node *node = tree_search(&want, &w->obj_index_tree,
-					     &obj_index_tree_node_compare, 0);
-	struct obj_index_tree_node *key = NULL;
+	node = tree_search(&want, &w->obj_index_tree,
+			   &obj_index_tree_node_compare, 0);
 	if (!node) {
 		struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
-		key = reftable_malloc(sizeof(struct obj_index_tree_node));
+
+		key = reftable_malloc(sizeof(*key));
+		if (!key)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 		*key = empty;
 
 		strbuf_reset(&key->hash);
@@ -208,12 +212,15 @@ static void writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 		key = node->key;
 	}
 
-	if (key->offset_len > 0 && key->offsets[key->offset_len - 1] == off) {
-		return;
-	}
+	if (key->offset_len > 0 && key->offsets[key->offset_len - 1] == off)
+		return 0;
 
 	REFTABLE_ALLOC_GROW(key->offsets, key->offset_len + 1, key->offset_cap);
+	if (!key->offsets)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	key->offsets[key->offset_len++] = off;
+
+	return 0;
 }
 
 static int writer_add_record(struct reftable_writer *w,
@@ -284,11 +291,11 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 			.ref = *ref
 		},
 	};
-	int err = 0;
+	struct strbuf buf = STRBUF_INIT;
+	int err;
 
-	if (!ref->refname)
-		return REFTABLE_API_ERROR;
-	if (ref->update_index < w->min_update_index ||
+	if (!ref->refname ||
+	    ref->update_index < w->min_update_index ||
 	    ref->update_index > w->max_update_index)
 		return REFTABLE_API_ERROR;
 
@@ -296,24 +303,32 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 
 	err = writer_add_record(w, &rec);
 	if (err < 0)
-		return err;
+		goto out;
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
-		struct strbuf h = STRBUF_INIT;
-		strbuf_add(&h, (char *)reftable_ref_record_val1(ref),
+		strbuf_add(&buf, (char *)reftable_ref_record_val1(ref),
 			   hash_size(w->opts.hash_id));
-		writer_index_hash(w, &h);
-		strbuf_release(&h);
+
+		err = writer_index_hash(w, &buf);
+		if (err < 0)
+			goto out;
 	}
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
-		struct strbuf h = STRBUF_INIT;
-		strbuf_add(&h, reftable_ref_record_val2(ref),
+		strbuf_reset(&buf);
+		strbuf_add(&buf, reftable_ref_record_val2(ref),
 			   hash_size(w->opts.hash_id));
-		writer_index_hash(w, &h);
-		strbuf_release(&h);
+
+		err = writer_index_hash(w, &buf);
+		if (err < 0)
+			goto out;
 	}
-	return 0;
+
+	err = 0;
+
+out:
+	strbuf_release(&buf);
+	return err;
 }
 
 int reftable_writer_add_refs(struct reftable_writer *w,
-- 
2.46.0.551.gc5ee8f2d1c.dirty

