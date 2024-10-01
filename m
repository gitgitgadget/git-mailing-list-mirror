Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDE19FA65
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775733; cv=none; b=q0CwsHOhuzYRFDNnzfDFr/MCe953b+d/qVjbqJdRzpVhn02qnYRiXt9ZTEyk580OvqR3VhlIkvslcaj0/Gncxfkes3Wed8KgNP2u0vuq5RJmDAym5rrT48fbnJvGS0U3bACLnXYNmb+MlAgsj98loQmzHHuuRr0WwypAFnq6XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775733; c=relaxed/simple;
	bh=nfHg5NPZ610+3Gjkno3QKoUz8ezohvaUdZWAMu/Srrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sES4VSKuiouiOhfASAuMLl5DRHVo2ASYDanA4RUKtYKIEhhbEO4iK8lQXe/skd5qd2GRloJOrXTIwW0PRaG+KWLp8bBP8hHCd74qDu+TAHJBnUfWqEd+f+fGvSXEvE6Dui0oxOPEZdVLggo2QCNw6AkRnfKjlR3ZECtieOIrGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sfowqdyo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeCbCQBg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sfowqdyo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeCbCQBg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A37013811D4;
	Tue,  1 Oct 2024 05:42:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 05:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775731; x=1727862131; bh=ZTNepBofGS
	V4l6zStTlqqGSM4JHp2/ODcUBG5HhB9cA=; b=sfowqdyo4npZZ8q1cuEHTBXXDW
	HomSqPuxbWVkPKpILLOGH83cXGZAH+dFTox5xW6FXPEagB+MWt5Q07Wz+orFZZ4+
	uKuhA0ghjUyO14ZMd/PE6N9ACQIw66CcwBnmNeSOAlh6g74lL7dgmqoVZ6fsrbhi
	qUnYU3RUYEFcpqBPPxEYiwgbnRBKc3D52n8N6jPMF9+Z1I7rZMulP89djBiHZuVJ
	TEB1Xev7FEGm59FVEH812wJPIfk0b3zKZZKlbw+k8yMz5D1RO8Zvw9Fx8yLG8C7Z
	bsYryVY92IoqXlrPBIyLpLfRjdjE4qPAf3fwpUtU4GIPUl14lgPrxqzUQw6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775731; x=1727862131; bh=ZTNepBofGSV4l6zStTlqqGSM4JHp
	2/ODcUBG5HhB9cA=; b=PeCbCQBgTDe4PFmMXPqUWx/b2netn97LBWEU8Kr2KAnA
	hlnT77zfetL5CxH7QKC321MrQk1+P8cvYJnZp/7A7EIhR6svh7tabzWr/TSfnlUH
	R54Xit8wpWC9QkSFE+OFnsFYHE5gFbPjECwPnYeBbF6Rh13ZfjOTAyaJXihGzpSI
	3dof0vpvxWO/fGL0bG4GrwQQL0DkFkkmTTLNK2DKIyeSf4ecwXSne1y7C3Ac4/Yy
	urXdk5zqgfZ/TT/UdAJ11RFDrJoDb6Gj/LQKT0MQhSF4viEuYwpAU0+D4KDc2cjg
	L+O+j/GnT5/dK2E3pcGCtwtuUmgzp65IvHGnEZIfnw==
X-ME-Sender: <xms:8sP7Zl2RxBWfYZcrjd0g2McGlNgw9JLcFF2TABeSyBovy836Yo3rRw>
    <xme:8sP7ZsGO_c6VaUVg-TkFiYXYVlyIY2k-2L1TcXNjhgSjiKBWZUeiOWnV9JP6i2RvN
    gmOKTEZkmFMqvAHMQ>
X-ME-Received: <xmr:8sP7Zl6Gg9_yCWMe4Qt76LIsLbAxCpAmkD8sFT4TF-DqUBM05wcf85pXrfvavdzwoDsTLCefeD8p65Kwp2LGEeUMmCkYTJm0DIo7ioUekuK92Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:88P7Zi0WRP0wQ3Cn6d0JJKvDHds9Uom5BJua5kMfUqECUf3O0xkg5Q>
    <xmx:88P7ZoGjqbXDhNxpwB2vLUUuGScptSgrYrXSisKo3spQXuUjfq6DRg>
    <xmx:88P7Zj8g89u8AlYwcJ0IfyUsDVIg09rx7vW2KEFshqoGqukO-h6A7A>
    <xmx:88P7ZlnmLuSeVcRooOh80WiyDbWmFR0zxistFseG3kO4mQX63t1xBw>
    <xmx:88P7ZkiH63F_vZcbR7G5Dkxy3PJh7gCOcMFxRgHBILne2TRQ5wr8gvIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b3dde72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:21 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 08/25] reftable/writer: handle allocation failures in
 `writer_index_hash()`
Message-ID: <fc2f113cba3542fa8d37fc20d7825b70022f55aa.1727774935.git.ps@pks.im>
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

Handle allocation errors in `writer_index_hash()`. Adjust its only
caller in `reftable_writer_add_ref()` accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 61 +++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 9d5e6072bc..ed61aaf59c 100644
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
2.47.0.rc0.dirty

