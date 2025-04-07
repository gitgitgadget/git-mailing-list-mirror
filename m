Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD32550D1
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031795; cv=none; b=UbvDgrJqTfDIj/ns5/oP3zaHatuXKpHJicmx1ySyVWdcwsacn5O/YjAmprawMIIhvKoLtGVnDUPKxSpziWTVleo5oeKxJmtRtByHv5QHgE0aZxshA67qvtPKufGihz3pzyrFZdW4UMrFLl1ZdKyYj2U9n5joAkvKlQKIQ9O8aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031795; c=relaxed/simple;
	bh=hdehLccJ6yPcjUXqOdKxfW98H7Fl3vp7olioXiAMyu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RR7KJG1YRtKAL3KOcGalu5Y1xKlkSwb6ijbHhWTlIhKwl3y1bX+juTry2Ornx/QKcjM8XTBVaJGIp0IR53gt2A/Avppn5XAVYtLkmvAjtIfnv/ZqqSgP2wvDmDKNAcRjxFpyWrUY9CUjXchEzBx9ATTtW5u9hpzVumhZ9vc9PXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KJqvRC90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgfsh4Qt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KJqvRC90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgfsh4Qt"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F7DD1140211;
	Mon,  7 Apr 2025 09:16:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 09:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031792;
	 x=1744118192; bh=/wx0Xz/k2EfS3cATP92HlBX/k5L8YerMY0JUQETcpW0=; b=
	KJqvRC901ff9Ua4IgBl6ibH8USgDSSIoRSEqkaVWIVf8OnbmpwqwfpJtpo6tC8Je
	ocjPZ1tmHLP2UZaIaCSJ5BZR3RT7KpNDs4bBFUHguz8q0S7TN8bYN1LvuFJlrmEp
	LdP1ryKNFGW1KPbdR5ObcfJTqYDDvQjizjnjtFxUWnoGj9W/Sf3J0CLdJOZu35eP
	vu0aq8BA8yYzGbcAvkklKW6r24YrrxO+Y1ibCXspggCxzrspVtA61hM6jy5OTEfc
	YXOzGGU3JwTpczq3/ohG4Ckyz9N9P9dof/ajIcjzV68cuE8teR02QzunUmfo5A3B
	vSSp3KtXepnzjIIwceaykw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031792; x=
	1744118192; bh=/wx0Xz/k2EfS3cATP92HlBX/k5L8YerMY0JUQETcpW0=; b=p
	gfsh4QtLO1GVwIj0I6NttScA7bplL0FbGnjuGpWpWoypL/RdPsU2CjbRivPOn/KV
	P5ovUPXkE5aU1j+SXsIJH/zKWqlMmsJiXxgM+Jw2OiBIGDCLgNSfPDLduSKD0Mc9
	qTOLVsrJ63g/sCYg/dNmUPQ4FaxE2lhG/ZWiA/ha61aVR2Z/Gai1oMgk8KmxsSMw
	1u9iiFyhYr1dJaj3JXwOmmdMxSpmUSodZ6zcnR+x7l+A1MsgRzG2Z21na1NVRfEV
	OYiWG9GVb/HPegC4StMA+19CTjj8vwwG9kJ3TNuWXxW75ujWwq5c6LBMgNG+TYw/
	luvKITDMSQ27h3Dzy21Rw==
X-ME-Sender: <xms:MNDzZ3JuGXzolul-vYCSR9GbChYNuiV_W70lB35ZyGYqtiIMQedpFA>
    <xme:MNDzZ7KOHKWA1Ig_OE_QUiyIyGYFgtr9zRkjStISeVrs-8NDF55-9fi0UZvPIiLUQ
    Hymi4OQQCJtq8kdaQ>
X-ME-Received: <xmr:MNDzZ_sF1dRZtN_4pMaw_Q6sT81eeSQOq5H9dDoIptU-oPuFaKwqT8un53gD_7y0rMX2muuOjNuAol2vL5uWxL2jBnf4cf9JFs_dywFdePq-kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MNDzZwZ6WnS3ATIsfdDO5I9Jfwbs-MKjH2FhQDCjnIkJoKQ9SZMPPg>
    <xmx:MNDzZ-Yc88EyX50aH_UqNFmLKDdDUAtHUjvub0AgQpBNyQ5wfZtSog>
    <xmx:MNDzZ0COaJkIpULJLs4x6FicNUNX33LpncvEeSqVu956gsW_QyuS4g>
    <xmx:MNDzZ8ai71a_X3PPRqnq97Z_neVcu6t6lbRXGJpSFaWdlCV6PyQidg>
    <xmx:MNDzZ3mOGg9iDph1cqiWtHe3iLA7HTTb7C5EzYIT0vRK9xiqe6iy7UBB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e85ac9be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:22 +0200
Subject: [PATCH v2 10/16] reftable/block: store block pointer in the block
 iterator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-10-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
    we hide that a bit by only storing pointers pointing into the block.

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
index 844da397833..a425dd7abf3 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -381,13 +381,11 @@ static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
 	return reftable_get_be24(b->block_data.data + b->restart_off + 3 * idx);
 }
 
-void block_iter_seek_start(struct block_iter *it, const struct reftable_block *b)
+void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block)
 {
-	it->block = b->block_data.data;
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
+		.buf = (unsigned char *) it->block->block_data.data + it->next_off,
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
-	it->block = block->block_data.data;
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

