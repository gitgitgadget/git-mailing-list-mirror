Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE14200121
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866551; cv=none; b=AsXzdDq337cwv6xXEhQIVx/lq3aGwXoQZNyNyvnpEILahRwrxxc2gizUpEty4pAJMEZRortSFbZ/s3Da506Iq6C+wWHq9aC1MhqvSK/0Qft3YPfsayb7LnEHKivjamT4jiBsU1wmy6jQX2PRME5KLuJQswk34aLCQGxYk5EzK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866551; c=relaxed/simple;
	bh=nfHg5NPZ610+3Gjkno3QKoUz8ezohvaUdZWAMu/Srrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nt5LMbkmJSnjbqRlss58pdxVoQCOUPxEfUdxVqpyLpup7iVjnpkikIqkIhguUJUTiTclDNLMzDNVXjvnsJo5ZwiAmQQQw8bw0E7U4r/EUPyUaNTQGDScuBa0pO/VXpehge8Ilfl2HPfCSk9HT6Dz9Q1CEmGuW8/oJdDxd5L2jiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDxssU4H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxV2rYSG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDxssU4H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxV2rYSG"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6143E1380601;
	Wed,  2 Oct 2024 06:55:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 06:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866549; x=1727952949; bh=ZTNepBofGS
	V4l6zStTlqqGSM4JHp2/ODcUBG5HhB9cA=; b=RDxssU4HFF2daMdlhidBbWX1o3
	cPcUc/mOzTOuH4iwdwJYE7ADqKULpwuHv9fbKNUYvL8i4mPQWo4vifpghk6dJq+M
	cSytYQHK2CGQ2x3lB3UaVqEnPPopzF3K/8H2Ppp60Hx5J690AYKR914DVQide9Wc
	8YcyCrVd78XZGh+7bqnz6jEHR/Td/bIJ5YNooysBvAdtaSTtIl1QfwBaQRXI4nTq
	dTCcOX0dfQ1HqwKu5jREKB/HhGGcuXFVivUkeyzK5M06A77qfQyZqw+psB9a7ADo
	xfBc6jk4//FDp1DIIIiwn8MC1ig86vFpZRMnGuX7hA6vQqwYMIHVx+Btu3ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866549; x=1727952949; bh=ZTNepBofGSV4l6zStTlqqGSM4JHp
	2/ODcUBG5HhB9cA=; b=XxV2rYSG2YiLiamGLf7mUxvFjZ5q/GaONfrd3Ug3h8yR
	X6/8AhkEQsRsb81qWTwWsPyIsqS7yWkON+YSEnHlldPZvct4Ur9XmkZbu+/yqeof
	U48FRExz+WRnuEzs9xVHafLO9+iqLu5KX2AFSIs4zttl+mnNIyqvnVNswwsN3l6j
	pSzr0Ilxiu9gVBuj98b+8+Wlik7+vLGnelhwM9EullW8bnW72F6wnz8LI7jSyYhF
	htZJP6/77cCvr6Mys2UUdj12FYcvJtxq048N3Sjknq014NA2KzWrkyoOGcL7rMe1
	Dhxx5lCvFNSLO501q4HJlcak0jeWy5RixTCad00xLQ==
X-ME-Sender: <xms:tSb9ZlT8DDMV00KUT2CXa8SSTnW-3hhU9h3YLskLvQN8GvshpDfNfw>
    <xme:tSb9ZuwDoSR_veAX8wlVKWlO9zYbTjTKmpN4CBzpplsrfYYNP9n_ZbCcB1LAzijHz
    K0BprNgOGAtVvI7Wg>
X-ME-Received: <xmr:tSb9Zq0LBX9iO8H39jQS1-fz2-LFXU0XnzbfOrCwRZMBBqEy6mgBv6rO12PSHgJlr7JZhcdWtNUEOmqX8PSb0wTxPOHe1WbjEB5thYxhlgtRsKN->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:tSb9ZtDSAqyPtci4RXWeVrgSIBf0KtRsowy3v0T2-lqXNOvBCdcpDA>
    <xmx:tSb9ZuhmnrqCi9daJTVVpf6HP_CnGUlKRcN56uu27REubx47NYrUFA>
    <xmx:tSb9ZhrdrFRNDCU26Sdk41i-LWXLhEyTaZxPPAUNFP2CJ2ii3ZcDNg>
    <xmx:tSb9ZpgR1S7CGjWHbh-SO7AKKHY3_WpK2Pm-O4XB2031_H0eW-KY1A>
    <xmx:tSb9Zmc7TqeXMVOfigrfvps7-7o128Aidj3JRmg9Sh6mabxBiuxoEFqK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6ea1aa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:58 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 08/25] reftable/writer: handle allocation failures in
 `writer_index_hash()`
Message-ID: <fc2f113cba3542fa8d37fc20d7825b70022f55aa.1727866394.git.ps@pks.im>
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

