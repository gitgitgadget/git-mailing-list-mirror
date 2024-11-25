Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA680038
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520108; cv=none; b=k8N2N8exQG5u5pazcPJzCTu5GNRtEeY5rZTkVyhVW9YbINle3wpB6KURel4Yn8Xp04JVNEpJSZfYjJnQw/fEfCg7GxR7lsZxeebq1qWKmNB8HszME8l02+MLSwAxg1JxIAQWfsvEZOCBu+ezhYypJQgmaWwyVE0XnC/HFexQ/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520108; c=relaxed/simple;
	bh=N8praC6DTSco53n1rIXmyabaxs5dYO9plv3QXb4yFJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqbnS5E7IfB42LhuCbofqzkSpGXtJA4A3610zUbIhHxJL9+EyuMXtyv7AO97nVZMTXvSMMuCy1DEEUXOVnpHGy96cxQ3UMUAyMEz8k6aG7XSkLKt6caXAlPOfgjBP5LQ9GLlZUCswmVtFCgE2m2ncbNizZEjHwCEZy2FYmDoWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UIx0DxmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z369Ctvu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UIx0DxmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z369Ctvu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F350411400D6;
	Mon, 25 Nov 2024 02:35:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 02:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520105;
	 x=1732606505; bh=auy1TQr+cRDIduCNa8upQL4lv/y3ZA67LljawxP/aAw=; b=
	UIx0DxmT+HXCAL8Awho5XnK7PNoTzbLj3Cfu1qjRGhiXFXRF41P+CCAbBz2clO8R
	nLrI5END7FwPROiiEVBR0z43enBOgtjLfQozvFU6ufkqlnBrBS0WCZxNU09Ajkjt
	S0+Y1jNEu+7aJKZmearRa3LwybzgNNPc6pbJUnxnA38I5+uqAv5U2+SwUsINxiKa
	TB2cfyudLchGu9ApL1LuamBz6HMkMYjl0Ir1gUkqB6X+EgKl+kGXDsDIFCg+Q3F5
	Znj52hCspt21peJj1QmM4FUZlX/A70U0y6DFcHG1TsC5hw2XiE9YkVh9ChnnIu8T
	QEuOv4HeN0OaFlzJTE/JJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520105; x=
	1732606505; bh=auy1TQr+cRDIduCNa8upQL4lv/y3ZA67LljawxP/aAw=; b=z
	369CtvuiAwmXqxsRCaQ5B1RTN0pCnWW7WeYZvxaZCQgp185jlDFtNgFM/sPHkdAu
	6YOb0bY5fQyyWNrf0l4Zin4547OhnXRAX47KmSQ94kqmGFpY8mSx15zuGGR56voP
	0SNcDQ2nuLatEwzG3wg0oszpWtb1qLg5GUbkG8br0s3JyrIopYBs/BdToSKaFQGG
	ihMuaGwl6eXK6Umz1NW3JgY+hffe8/V8GNOZS/6MX77SiaDKqhKh8apw3xBS0yW8
	FzJhoewRu9gANtsZjWWPxKbZZiDZwTTjVU2xdDuDs/qTPICCZ/qEbR/o+1p84BP4
	dV6M+am4UYw/XIO2oWYrQ==
X-ME-Sender: <xms:qShEZxlTd6P8GputpCQyvb-OFn2AESHi6xfnuEEKMXLEz05jZIMS9A>
    <xme:qShEZ83zeF821GZ3lue69GOFbardZr_zdKykzzY7GQ6-eU835uTMu6AhqyVp0qD4G
    qiLWuvqM_e5wJi2Jg>
X-ME-Received: <xmr:qShEZ3pU5s8kJiCsHf3bfk9LM9GDPlUO-1Vf-b1mGWJodNXSB8sFBHa5Ccy4wgLwFPvQf6qDKxH3cniLObB3H41_KKx9NeSgsUmAyIkWFgsCSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuh
    igfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:qShEZxkAU2ayMVUGeFVCeTfAy5XfwIMa1DE1L4TTPzjgp7iFa9f3Cg>
    <xmx:qShEZ_1EvSS1DGZ8x1K5NzGWF5vGYZps5ISHsf5mOONHJaYNaKmegA>
    <xmx:qShEZwtKtDDzrEf-dzzWzBOy-9xT9WcFyRVyOycKrT-fV9D_bC9thg>
    <xmx:qShEZzX6CvaG4M6HU3jeJKfQvA2w6oFsb8lSUuwBxmb4WGLrcfgAEQ>
    <xmx:qShEZ9AUmyJGEW3ZC17xfOn7C_UnVcnqCmVEd04mWzEy2q1i_vu-rfKD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:35:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1da71c38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:34:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:34:43 +0100
Subject: [PATCH 2/2] reftable: rename scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-refs-migration-optimization-followup-v1-2-0e1b4a2af384@pks.im>
References: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
In-Reply-To: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Both `struct block_writer` and `struct reftable_writer` have a `buf`
member that is being reused to optimize the number of allocations.
Rename the variable to `scratch` to clarify its intend and provide a
comment explaining why it exists.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 10 +++++-----
 reftable/block.h  |  3 ++-
 reftable/writer.c | 22 +++++++++++-----------
 reftable/writer.h |  3 ++-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 1aa7e8cd3cbf0980f6bc20262be89e755d0a4b4b..01980784854cc454938bd2278b94047ff62c20d4 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -115,16 +115,16 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	int n = 0;
 	int err;
 
-	err = reftable_record_key(rec, &w->buf);
+	err = reftable_record_key(rec, &w->scratch);
 	if (err < 0)
 		goto done;
 
-	if (!w->buf.len) {
+	if (!w->scratch.len) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
-	n = reftable_encode_key(&is_restart, out, last, w->buf,
+	n = reftable_encode_key(&is_restart, out, last, w->scratch,
 				reftable_record_val_type(rec));
 	if (n < 0) {
 		err = -1;
@@ -140,7 +140,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	string_view_consume(&out, n);
 
 	err = block_writer_register_restart(w, start.len - out.len, is_restart,
-					    &w->buf);
+					    &w->scratch);
 done:
 	return err;
 }
@@ -565,7 +565,7 @@ void block_writer_release(struct block_writer *bw)
 	REFTABLE_FREE_AND_NULL(bw->zstream);
 	REFTABLE_FREE_AND_NULL(bw->restarts);
 	REFTABLE_FREE_AND_NULL(bw->compressed);
-	reftable_buf_release(&bw->buf);
+	reftable_buf_release(&bw->scratch);
 	reftable_buf_release(&bw->last_key);
 	/* the block is not owned. */
 }
diff --git a/reftable/block.h b/reftable/block.h
index d76f00553073c10185e716e71e2f415ce5dcf7e2..0431e8591f41dedfb96eef304ea63ef2e9e5f5dd 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -39,7 +39,8 @@ struct block_writer {
 	uint32_t restart_cap;
 
 	struct reftable_buf last_key;
-	struct reftable_buf buf;
+	/* Scratch buffer used to avoid allocations. */
+	struct reftable_buf scratch;
 	int entries;
 };
 
diff --git a/reftable/writer.c b/reftable/writer.c
index 6501376ce826469556a7dfa3c39258847300ae66..be0fae6cb229411258d40b8865c2fdee88fd5bcd 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -148,7 +148,7 @@ int reftable_writer_new(struct reftable_writer **out,
 
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
-	reftable_buf_init(&wp->buf);
+	reftable_buf_init(&wp->scratch);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	if (!wp->block) {
 		reftable_free(wp);
@@ -181,7 +181,7 @@ static void writer_release(struct reftable_writer *w)
 		w->block_writer = NULL;
 		writer_clear_index(w);
 		reftable_buf_release(&w->last_key);
-		reftable_buf_release(&w->buf);
+		reftable_buf_release(&w->scratch);
 	}
 }
 
@@ -253,17 +253,17 @@ static int writer_add_record(struct reftable_writer *w,
 {
 	int err;
 
-	err = reftable_record_key(rec, &w->buf);
+	err = reftable_record_key(rec, &w->scratch);
 	if (err < 0)
 		goto done;
 
-	if (reftable_buf_cmp(&w->last_key, &w->buf) >= 0) {
+	if (reftable_buf_cmp(&w->last_key, &w->scratch) >= 0) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
 	reftable_buf_reset(&w->last_key);
-	err = reftable_buf_add(&w->last_key, w->buf.buf, w->buf.len);
+	err = reftable_buf_add(&w->last_key, w->scratch.buf, w->scratch.len);
 	if (err < 0)
 		goto done;
 
@@ -339,25 +339,25 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 		goto out;
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
-		reftable_buf_reset(&w->buf);
-		err = reftable_buf_add(&w->buf, (char *)reftable_ref_record_val1(ref),
+		reftable_buf_reset(&w->scratch);
+		err = reftable_buf_add(&w->scratch, (char *)reftable_ref_record_val1(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &w->buf);
+		err = writer_index_hash(w, &w->scratch);
 		if (err < 0)
 			goto out;
 	}
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
-		reftable_buf_reset(&w->buf);
-		err = reftable_buf_add(&w->buf, reftable_ref_record_val2(ref),
+		reftable_buf_reset(&w->scratch);
+		err = reftable_buf_add(&w->scratch, reftable_ref_record_val2(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &w->buf);
+		err = writer_index_hash(w, &w->scratch);
 		if (err < 0)
 			goto out;
 	}
diff --git a/reftable/writer.h b/reftable/writer.h
index 421a897dccd85ad0532860ff1b4f38b2813d438d..1f4788a430c52c5387b5e97f639e84544d0b9ba2 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -20,7 +20,8 @@ struct reftable_writer {
 	void *write_arg;
 	int pending_padding;
 	struct reftable_buf last_key;
-	struct reftable_buf buf;
+	/* Scratch buffer used to avoid allocations. */
+	struct reftable_buf scratch;
 
 	/* offset of next block to write. */
 	uint64_t next;

-- 
2.47.0.274.g962d0b743d.dirty

