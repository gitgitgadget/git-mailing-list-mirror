Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B817C7A3
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683718; cv=none; b=VZUfyJ4637Rw67YwqhPBsYpx1ZIPiYYQJM5rpxjy+VbMsJhHo6Oh0JYb+J+8GU/Ilz/9Hjv/55tayU7XKfMPIxx6LEArE2ejTBUb9K5aeQdI8+3KACWvQ6BBBbq+hCBtP9V1AR8TX+BnjiBQheXYx40B77BaJtlt4nIiWhJccTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683718; c=relaxed/simple;
	bh=Tdb1CFFSOyLBbHN9KDPxKvVzANsghah5HsWCnBU7vsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp0pA4sQsxACVXqykGOU/7tghEPOR2irArFueqiTBPqcD8ab8MnzTRgwpMV+O8TGUseRj0Xvx47xj6wzdBFF/ylmqgtmeRpmcspzg1vbD0WfTyE+ReDCHETAO+3JTrm7Ye4As2FqKbY5aqB6b8MoPtXv5orxonfze3Mj5Em87so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kbQ7Fbhf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF9UW4o6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kbQ7Fbhf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF9UW4o6"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC5DD1140194;
	Mon, 30 Sep 2024 04:08:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Sep 2024 04:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683715; x=1727770115; bh=8xwf1O8ziI
	OARHNcWanLo7JE9a/svmQNQAyl6i0RFVY=; b=kbQ7FbhfrFH7kDTdyvW5xNoiw9
	MWrFatbcoD2rop+ZPAAX6e8YTm8LRt8ruw7IC+H9Vupfow87gS90NOfRvdbot2Wb
	h5gCWeVWyR8WBjj+2bn0rmRa0V0Fj1Q1Vy0scrLVi3YozjGmFlDVmEebLIQL3TlF
	247eDdyZrkGl71Dq1n1wri4tgYLERhcH/klYsS5RJ7y4ISPsQEshzH33Vl6ideVF
	/BZbg3oHsjR7Z3fTT1405uhta/vTNnZ51QOauHC7fGE+48CxJ++gH9zbNVN9k1bX
	s+UmKzRboX4FCzXMr5zNUG6Oq9MwriGlDiN3moyHSrgpymCwo6g9WCZnyiuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683715; x=1727770115; bh=8xwf1O8ziIOARHNcWanLo7JE9a/s
	vmQNQAyl6i0RFVY=; b=QF9UW4o6YCaGmqGwvwwJUmTT3DniLB5qzclLrm7T6fV3
	vJ0S3Tq+tz6hNhLQU8WU71NDRydM8EL57hxWDkr6NVk5BhFpZiUdShX7NI0d+Pet
	meqjd9r7DQMek5Q26/4HkCccvSF5LffHbvOy5KmtPDqKJjgnX1kaS45oLG+Uo4In
	1C+uRGzrx5Gzws9FmQYn4MLUKSnuSHpagc0f3syjQf5xmS8eoGVRFvH68IMxazcU
	ZlA+7v2HS/uonBCSLa4c5/VVmk9FKSwNSb3w/ATKtJpB2eeKUes+Svp8/n6e5InU
	wgQ7kyXxQo8zBAK5wuJuaJgD+Mt9I2QwJFufTE0V7A==
X-ME-Sender: <xms:g1z6Zkns-IrkVzILx70OF7ZSqHx1WJ2xCaoJUEyJfSJeTNk--Ej7Jg>
    <xme:g1z6Zj1NiDk3S1aSF7QnDnPXSPQ4ZtYYldNOonDGq4DTDuAZUZev70R9nDiySAsBR
    1F2riQ91qnxMH9JBw>
X-ME-Received: <xmr:g1z6ZioJCgahqqwfDIjuzaIPYbLnZDbaj1dmccyPp0w1fV1Ns4wg34mp7zadrfIub8rUYoAcORoiu1dWrW0gpgzV3j8pIZWYZH3OcgJDKWKqcic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvg
    gsrdguvg
X-ME-Proxy: <xmx:g1z6ZgkPHbqq1w_Hnt4CgbTyhi3-WWqpeqY5ospPrYJMHMK4mVpFNg>
    <xmx:g1z6Zi1BcUDwWmXmKMzNrh1eHYz05H9vWJDuM-w4xGXq_iCopGx_7w>
    <xmx:g1z6ZnvKKc2M0VOZSfMFNIW1q7PvtQOF70_ZhmAjLHD-8JJx3wbDZQ>
    <xmx:g1z6ZuVJt6w2tEKjnpPTSLDEqidJnstcQdwaXpF8t1X09q_juBXo4A>
    <xmx:g1z6ZlRQkFj0OSR5hOwilhiWgTX8zwhCNdPMWglk5tmOiczhjfPJ6FCE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 303ca769 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:49 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 08/22] reftable/writer: handle allocation failures in
 `writer_index_hash()`
Message-ID: <42bc57fd001b04e799a43e2749715f2696ffe0db.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

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
2.46.2.852.g229c0bf0e5.dirty

