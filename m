Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375536AF5
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140831; cv=none; b=UnocyYoM64tv+JyBpqCn16J/3hZpVlpi3kN9PApOwAA1tRgWg4uuJBcq1Aw/TFRH3WGUpeNGrpRwUSPytW/Tev36HQ3OWHAWM5zHjwtKiwDyN2OFMnM7gWFYP2XCnCXla9tJUJ2RBFsU2LfqhJ55XFgkbsgVhJEJh0xG94hWsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140831; c=relaxed/simple;
	bh=e1vDbCaIeRFSB916uV/W3/0TS9EgZkJ/HiNpgi8jZZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocYzW0WXbAWnvA/DORYprI5X16kSjEotFv2zRZRBTn9BJ8KdfAxhokQHrdTcmDXOCGl+X4cetQiaL0y2gzlEGWW0cZrFK71a55fjT2E4RREhcinRzc6RUmrIXVtrDaUKqkHj6WQI882OMB3Dcy1g74NrmwxywDYh1p4CNWge8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gDI4D2j3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Po9zE8PG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gDI4D2j3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Po9zE8PG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B3CE613801D2;
	Thu, 17 Oct 2024 00:53:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 00:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140827; x=1729227227; bh=So2zO1PSIp
	+KUagfBzDouiUvBG3FI4ll3m4Bya08o1c=; b=gDI4D2j3KDgp0V99UUPjNFG1v3
	Vje03ddeXmIdfFHiUe8GzbBIpEWEvNj3gZ9CJsOjX4TunFn5CDMEHqkjUzajHnV/
	Z1Jn072o+6yxw080OHMEUvcUZGhGIYboWZkv9JwAd8QBSM2Q7deTtxQ9LZM3yxgL
	9ZK+Z354mdCpzZJKV7jTkhRJJKxNOpYmHn6fpzrZZ0NjPVC2YIpm+NhvmgS1qC5E
	limV3JxrzwU2ww53ufnc7GeQDjinIMyXTB0+vbjK8YuC1ZvYz0d8UDGUZ/uhzQdE
	aWtiKsvB77WgdQDc2uCBAxXAN/YGP40UhmwN5H5g8F7l5QkKNp4b5BQntZzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140827; x=1729227227; bh=So2zO1PSIp+KUagfBzDouiUvBG3F
	I4ll3m4Bya08o1c=; b=Po9zE8PGAZZW+QPyfqCdqLEj4JlWoXGDjsajmUIx9eIE
	KEoxftTK5uyN0d8a3CQOXgJTY7Z0ktBsYOLCQDmyi+8CD6fzVe9F15K8NKulmOq9
	Nbe58Jq6STr2LVq4lllK3dzgMxlSHt0nXw40PqprvtLQHndSQWKG5bmbjPX0/GNm
	scunePPp32d6nGgKlSHGVapPOu4w14Yx9fsS/WP33SSqmbaPlGo4nJ20nZJ88P6D
	VJqDcngIB1H5ym1SqYoO2WdYNQRSvCgxRYOW/d4882539/3lK6dboWxQ3PgusNrR
	KY+8akHCNIny2A1XYnUC346UmGJLjIsuzoSk8GC4/A==
X-ME-Sender: <xms:W5gQZ0Hv927Semm4EXN0IdBBcQRfKImYJ8aQ8VG3tzvZJVZG5E9lQw>
    <xme:W5gQZ9VgZzaeGMkeuOO7UsWHIvcp9ZDGg4vpNbw_zMkrxfF8j0PP0dxgVLtEATiWs
    v4ETA6JGHvFkbgobw>
X-ME-Received: <xmr:W5gQZ-Lwv_x_hD2RZwyiGrt4Pb6o619tGCM3rb7z7l-22UZ61X_xnThPgiHvnkd33DrfrKkf-BaZUQq5alL-LuxAcsdczJglBcsHNKlc2h2AqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufi
    grrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:W5gQZ2EIYGGmH3oBhJjjS_PwyiDtrzFCY4IMe2pykUiFi4pEUqSphw>
    <xmx:W5gQZ6V7GtGVgVvHzU6ACuJ8lpzWtDQAbtQdcWAfHWdrNhvsfaCsCg>
    <xmx:W5gQZ5N_X2YEOLaWpP-C7vkS5vFYKrv06ZEYbHunFph99qAKemv31A>
    <xmx:W5gQZx31aOsc0gHwzDZDjiHjQDH19yqWHltuRrgeBUCv4uZvZyrwCQ>
    <xmx:W5gQZ8fb_7AlytzIrWPlN-57QjJdZSqGGeaJXfJgZ_Ne7MqfX2ymeUal>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:53:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39b6d224 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:27 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:53:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 01/10] reftable: stop using `strbuf_addbuf()`
Message-ID: <7408482c152bbf465ecd098059b1477fd38c251a.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

We're about to introduce our own `reftable_buf` type to replace
`strbuf`. Get rid of the seldomly-used `strbuf_addbuf()` function such
that we have to reimplement one less function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 2 +-
 reftable/record.c | 6 +++---
 reftable/writer.c | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8d41a2f99ed..cd4180eac7b 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -60,7 +60,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	w->next += n;
 
 	strbuf_reset(&w->last_key);
-	strbuf_addbuf(&w->last_key, key);
+	strbuf_add(&w->last_key, key->buf, key->len);
 	w->entries++;
 	return 0;
 }
diff --git a/reftable/record.c b/reftable/record.c
index 30d563e16d3..87157f2c386 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1031,7 +1031,7 @@ static void reftable_index_record_key(const void *r, struct strbuf *dest)
 {
 	const struct reftable_index_record *rec = r;
 	strbuf_reset(dest);
-	strbuf_addbuf(dest, &rec->last_key);
+	strbuf_add(dest, rec->last_key.buf, rec->last_key.len);
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
@@ -1041,7 +1041,7 @@ static int reftable_index_record_copy_from(void *rec, const void *src_rec,
 	const struct reftable_index_record *src = src_rec;
 
 	strbuf_reset(&dst->last_key);
-	strbuf_addbuf(&dst->last_key, &src->last_key);
+	strbuf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
 	dst->offset = src->offset;
 
 	return 0;
@@ -1085,7 +1085,7 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	int n = 0;
 
 	strbuf_reset(&r->last_key);
-	strbuf_addbuf(&r->last_key, &key);
+	strbuf_add(&r->last_key, key.buf, key.len);
 
 	n = get_var_int(&r->offset, &in);
 	if (n < 0)
diff --git a/reftable/writer.c b/reftable/writer.c
index b032a47decb..031d8149a9c 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -225,7 +225,7 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 		*key = empty;
 
 		strbuf_reset(&key->hash);
-		strbuf_addbuf(&key->hash, hash);
+		strbuf_add(&key->hash, hash->buf, hash->len);
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {
@@ -256,7 +256,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	strbuf_reset(&w->last_key);
-	strbuf_addbuf(&w->last_key, &key);
+	strbuf_add(&w->last_key, key.buf, key.len);
 	if (!w->block_writer) {
 		err = writer_reinit_block_writer(w, reftable_record_type(rec));
 		if (err < 0)
@@ -778,7 +778,8 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 
 	index_record.offset = w->next;
 	strbuf_reset(&index_record.last_key);
-	strbuf_addbuf(&index_record.last_key, &w->block_writer->last_key);
+	strbuf_add(&index_record.last_key, w->block_writer->last_key.buf,
+		   w->block_writer->last_key.len);
 	w->index[w->index_len] = index_record;
 	w->index_len++;
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

