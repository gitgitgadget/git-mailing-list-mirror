Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3E129A78
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159542; cv=none; b=a8CD6TAiD5UjOZjJW/6dw1evLQWZoKlUDgNKRZ/Ow35yokg6X7A6NJNldHKzNdLHEnxU8fXybj3y3xR12O+vHNbtWX7QuslMPLZ7jrmN5x6NXWplxPip6fV7YJKaHuC0VNSPypdcuQMC8ORHgYR7k43l7AsXP+DhosoWAxiUruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159542; c=relaxed/simple;
	bh=Q4dd8y3RN6w5lA6V2ET3MVcXVFzWlUERSEXM9/J3iNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paAByN0HGoEKKls79eDohmJDvXfoIhNfja+NS5QcO/fLZBW4U6SMhqwpPdGM/yn4wL4QkGeNu9YWq8pWP6w+KrVnGgjhV6HsHZlxxZ6E06VM2PzRIWdOmOzZWoHVG/2UlbGP2xUnqhPOGkIqnWdzSifE/U6Smi1Gkj0FAA4rLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tPaI+1DR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCCKUR9P; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tPaI+1DR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCCKUR9P"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F5FC13802E1;
	Tue, 24 Sep 2024 02:32:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Sep 2024 02:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159540; x=1727245940; bh=A0rqFRcFy0
	0LGfQclvGDcrRVIJxbzFkES3TcnPacNFQ=; b=tPaI+1DRCE2L1bI/gU4FZyWnzl
	7dzzmQRLALpoSIKpBAZ+u/yEQSiTMOIDimd0vjzeRFb6HlCfvTrGUcdCgmA58JlW
	Qw8MRN9BZEIkSL5a5833TLy6nuvgcyMeP45Zu1OIhD5APByJmEJP1lH/hx+2hjSv
	vLCdBdcXC2WB0rBW7Vpel3T+nBDAkbPdnrPNLSavjQyf7xnC4N/ZKo247JMrKIYs
	4Oz5lYcuf6HbMDa4+xCi5q/+Bm2BLeAnWZbhaaDkJzGXVdw3rVX1Jjmmz9l7xj5m
	rK+N4SfC2ubT8V1Ud/d8JmByPzJHHpB8sdW6Ec30H9sUjUTTCMHgv9GIvgFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159540; x=1727245940; bh=A0rqFRcFy00LGfQclvGDcrRVIJxb
	zFkES3TcnPacNFQ=; b=ZCCKUR9PncGg7/v74uPmCnO7w9txXU3cl4mPEMn1NJdV
	Zrf2K1wtBX4K5aUr9YR8+UA4kdx+xkQG7pBAPtmhYRaXpUI6TNr0O5Xul2UahKOC
	gamw+ShhQ0YiT5PtVNpUfLDzFl61j4v0nsPT9T/V/llzmIgZuKJlwrX0VeWwYJWc
	9ekI9AyN0RFBtjiHHuYqsa28Zc/HHP7QSVzU8mHpoB7frcExp3weJvrYNanpq82s
	IoxeSjN/24b+B0y6hXJTQh5Ku6iIHSTtuD03KOwe4VR2UJJh6AcSc9GdNwUGcDxo
	dQ5i+TO24wJ5P01vqi7OA7fRlM2v1YM3lxRQ4Wggwg==
X-ME-Sender: <xms:81zyZkhMQh7BiEEyJYFFFLeYYG9amEsyk06qGFerH7akQlhOMeCoIA>
    <xme:81zyZtBGGX3792SUD36b6D_6dYxODW6wd-vQJKhv8oTnKxBqg1Yyz3xPrqIemTACN
    tBEYehm6hK7GPr9pw>
X-ME-Received: <xmr:81zyZsFegpjvjhOwwOXROpPoQmbnOp-Wd6sGlHzcaeFFWX05rB9Mnms5IEFNJfHophQyKE_8F8rKeKya6CXjAp3YdDyaoKDGpvLvvXkCjkQtOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9FzyZlQqcw00-18CeDkorqj4-c1CNX73f0xqMbuYheh-cUFOgAnwMQ>
    <xmx:9FzyZhxCxEvsvYKNFlB0TU0OqPFIstcDDBKs9za2Hqd6WKrs_Zlqjw>
    <xmx:9FzyZj7qq1BYx3MIPhsHfemHE60uuJ1LxtNDeabEhlUJiXhawXFunw>
    <xmx:9FzyZuwBbPUJDv95rEkEsGuhHAS8URi8pm-7bfiNp11NdhNEKT6qfw>
    <xmx:9FzyZp8ZRG-uNLXWjEHCAi7eE4bxSBFFGLyBnJ6RXX0DBWfu95dP05UP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96d4599f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:45 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/22] reftable/writer: handle allocation failures in
 `writer_index_hash()`
Message-ID: <1d47e4250096b4a2e5bd07c357b096d09e74ca07.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

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

