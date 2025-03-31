Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE391DE4E9
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410493; cv=none; b=u/YxW49sVZCdjmcFFVq1MMZKyCg8RDsdZv/Pwoy6wmsEUk/9ayjUkX3mN2VkfgYOtKedCjHe4PKuw7wZJ8sYr+ngVUAziOOFaAOJob/be8amRqZ4cdlluC5TxjyGsh3oZ+UhTp5DHrUKua9fids4yrGgips0sBj6ifJeIOM/FI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410493; c=relaxed/simple;
	bh=uUhUljyKuKtxaaAgEWiUpwkX5UPfTNLcNXZliQcB2j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/05DZiOeALr5OvzH7P5xC3DRb813zAL71L3a8Uw07TmA6ngcxhKgUT5VwAHc0kFxOTG9N4DKHCquZbfWC4BYiPauTOHOqJ9yPpJ+w2bERaSU315/v+STzW2bBD9LbQsh2Ea2yl3QLua52FH+DOzEXLK7aG5L+vmEE5hS5ohR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A7NU4RHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/09woE9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A7NU4RHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/09woE9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F20B1382E05
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 31 Mar 2025 04:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410491;
	 x=1743496891; bh=oDPEqyeeiwCqI7+5nEih6+51zYFBpw+7U2vFjZqPWQU=; b=
	A7NU4RHaf1Taj7SUtCWKftQvWeJiyN9inDRFl/0bJVxDz+Csn5a5CKtBUEiBnsmp
	/DrDTvWCWMhXbx7Fn5FPC8/bHdLm7BXcND494Ue3nAVrZWgwcxDLiHoz6CEpuukS
	LyrwScK3tfWxf00qAWnC/xk5bm7+htXhLQqpDDz+SOlrulnj45ZN3Hgvn65Dcj3S
	e4XAEYSthNTTTcnw9R6d9+miPFcqG8iTky91kyCYfiZ1S9a24lTVRsRAdH9r5QG0
	EuhuJKbcyTcIOyCKmhYDzuLEwNgPG1TrnBoZt+yD0etDQRRiqKN9xD/s1H+6hkqn
	Q5akOYbpsIeCFTBTHFZhuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410491; x=
	1743496891; bh=oDPEqyeeiwCqI7+5nEih6+51zYFBpw+7U2vFjZqPWQU=; b=Y
	/09woE9E4j1YJulw2omgBQiaKHBJcM1WXug0fGrAy3QI9leat3M84K1SI3d2ERLm
	7L1Fyb8mF6YBM6sDW2FIx4IDNQAIIbgPaRSqnOS1H318d8blktlRkEGwtOo1g2ms
	49+fyTR1Lu1gpT1U7hWEaFeutGTTQhDP54n7PYJYbuSJtg9nj4l3xzPpQmKPVogd
	UYjCLtiSnPxohrP1JqNJTVI6+pacF+5kWpKI1IyiYOXcsC+uuddNZMfUd2Vxu918
	gH7ztdi0bKL3a8Zk3BhhaSF/u7BguDwoSzCH5iNJQQUaPe0UlEsVYFRhu6DxK03X
	Q40Bn9KZ+JmiY9vaeSFGA==
X-ME-Sender: <xms:O1XqZ8mFacjw8Nu5YHVkYo8v-zjWjZS6lnVDK-VNcWUoXPB-gGeGDg>
    <xme:O1XqZ72oYg4ZCkCtsoPly2zgP70l4O8vEcjFGWoZXw3toxVkXn4xMmriUIuWVAf-v
    CvxsybxPMSDX2l_AQ>
X-ME-Received: <xmr:O1XqZ6r-Ny-EqMHUaSRd6PTHgGm0q-3Mh-g1FhYRPbOTwKw_yN9uDif3l4c_qDj3AarU_wFQG2brMRJpoPVfjuQ_ZBFH9xBGB64Qq3LYyYfu18Ix>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O1XqZ4mWP9_SC8pAqUM0JgT7o34-PkqLmDnm77WhbhZzUTWbMtdhPQ>
    <xmx:O1XqZ63y4f_ufVWu_ie-VVnCsNVsduceU-XLSw92xgxZfDaT_fdH8A>
    <xmx:O1XqZ_tdnjE_woUxasmGJDCH2AHBPQfniG2yFQKl8CtsvEYNAE5ZWw>
    <xmx:O1XqZ2UX3yi01cLNuoXGIrkvOlBk7OTQwaRg6eb9FePKPEieoW3Zgg>
    <xmx:O1XqZ_-J1TmhMK_l65vPm40TQelXz5yEzq9Y4el9Zaxhirsvewowkl_f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5c83ce6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:28 +0200
Subject: [PATCH 10/16] reftable/block: store block pointer in the block
 iterator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-10-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The block iterator requires access to a bunch of data from the
underlying `reftable_block` that it is iterating over. This data is
stored by copying over relevant data into a separate set of variables.
This has multiple downsides:

  - We require more storage space than necessary. This is more of a
    theoretical issue as we shouldn't ever have many blocks.

  - We have to perform more bookkeeping, and the variable names are
    inconsistent across the two data structures. This can lead to some
    confusion.

  - The lifetime of the block iterator is tied to the block anyway, but
    we hide that a bit by only storing pointers into the block.

There isn't really any good reason why we rip out parts of the block
instead of storing a pointer to the block itself.

Refactor the code to do so. Despite being simpler, it also allows us to
decouple the lifetime of the block iterator from seeking in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 22 ++++++++--------------
 reftable/block.h |  4 +---
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index d188665388d..576c6caf59b 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -381,13 +381,11 @@ static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
 	return reftable_get_be24(b->block.data + b->restart_off + 3 * idx);
 }
 
-void block_iter_seek_start(struct block_iter *it, const struct reftable_block *b)
+void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block)
 {
-	it->block = b->block.data;
-	it->block_len = b->restart_off;
-	it->hash_size = b->hash_size;
+	it->block = block;
 	reftable_buf_reset(&it->last_key);
-	it->next_off = b->header_off + 4;
+	it->next_off = block->header_off + 4;
 }
 
 struct restart_needle_less_args {
@@ -435,14 +433,14 @@ static int restart_needle_less(size_t idx, void *_args)
 int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 {
 	struct string_view in = {
-		.buf = (unsigned char *) it->block + it->next_off,
-		.len = it->block_len - it->next_off,
+		.buf = (unsigned char *) it->block->block.data + it->next_off,
+		.len = it->block->restart_off - it->next_off,
 	};
 	struct string_view start = in;
 	uint8_t extra = 0;
 	int n = 0;
 
-	if (it->next_off >= it->block_len)
+	if (it->next_off >= it->block->restart_off)
 		return 1;
 
 	n = reftable_decode_key(&it->last_key, &extra, in);
@@ -452,7 +450,7 @@ int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 		return REFTABLE_FORMAT_ERROR;
 
 	string_view_consume(&in, n);
-	n = reftable_record_decode(rec, it->last_key, extra, in, it->hash_size,
+	n = reftable_record_decode(rec, it->last_key, extra, in, it->block->hash_size,
 				   &it->scratch);
 	if (n < 0)
 		return -1;
@@ -467,8 +465,6 @@ void block_iter_reset(struct block_iter *it)
 	reftable_buf_reset(&it->last_key);
 	it->next_off = 0;
 	it->block = NULL;
-	it->block_len = 0;
-	it->hash_size = 0;
 }
 
 void block_iter_close(struct block_iter *it)
@@ -528,9 +524,7 @@ int block_iter_seek_key(struct block_iter *it, const struct reftable_block *bloc
 		it->next_off = block_restart_offset(block, i - 1);
 	else
 		it->next_off = block->header_off + 4;
-	it->block = block->block.data;
-	it->block_len = block->restart_off;
-	it->hash_size = block->hash_size;
+	it->block = block;
 
 	err = reftable_record_init(&rec, reftable_block_type(block));
 	if (err < 0)
diff --git a/reftable/block.h b/reftable/block.h
index 4f7f29028c4..268d5a1e005 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -67,9 +67,7 @@ void block_writer_release(struct block_writer *bw);
 struct block_iter {
 	/* offset within the block of the next entry to read. */
 	uint32_t next_off;
-	const unsigned char *block;
-	size_t block_len;
-	uint32_t hash_size;
+	const struct reftable_block *block;
 
 	/* key for last entry we read. */
 	struct reftable_buf last_key;

-- 
2.49.0.604.gff1f9ca942.dirty

