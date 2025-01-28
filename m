Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B61E0B8A
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052904; cv=none; b=S5bHfdF6+LM25uvERuLR/m6qMFrRd77Ag75ePuUWLW6oV9L9fVzOrCp6HoXyk9vXIQbrGqffuZI+W6nD+h8B3JoYmLq/Ysdt2447+rGu/aUlykyLfYXpu/hSDcgwQQ+DOV0TkYhdPbhSTarYpeSt8k0ucUAF/ULcCC4aGfK6w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052904; c=relaxed/simple;
	bh=Xj0t7OUm0FAA2j2ZiRD0dBNHYUM+0vpI1xBwvt+7UYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQLFGXav9IUP5rqZkJ13Ps+PoBUTJZ+cuRDaNyMM+ke/yETqVg6pozTagdtPZ6RMSIpyFfroS28R0x6I1pGOnt5dl0PGQtKfQEMsjJJV8UMv/DVIDoCx9O0tNm1/l+1Spd2GplLbHEDpQOy900O7gyfltqxyFf4+UrQDnmuu2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q8O9Qv/M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsaddVmk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q8O9Qv/M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsaddVmk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EA46D1140149;
	Tue, 28 Jan 2025 03:28:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jan 2025 03:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052901;
	 x=1738139301; bh=Ojg+QT7n1TKpobEbDjVPCkYXS12/+9O7UADZnn1jQ9c=; b=
	q8O9Qv/MIEpTo2T2NwWvC5mYnn3OQAJTXCCUts5f1r3QVkBw1TDFs3MVDCP7TKQx
	5AAo4EVbfIZRhxnOjhrx84ZUijzE6OeKCSTXWNgz3JLVs10VvWfAOwUK2yMH0+sI
	iOTWgsGQKqM1CA+fQ57VziLOupKXV7XM5TgmULMsZHXe+HhO2D8jMvvecTMLy0k0
	QzEpnFq+6LHc67oosukny+YUR0wklQpjWL+uIJDCQ7z6Ikx7M7ov6OMNkzSXOH8C
	OkF+jOV19CJ0uQBo448x/tFLL5oacLVPEc9uU5uDI9liV7VBpOIM7perZdAhRuyx
	gohDfEIAW5dhxRquPna6hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052901; x=
	1738139301; bh=Ojg+QT7n1TKpobEbDjVPCkYXS12/+9O7UADZnn1jQ9c=; b=W
	saddVmkoJ3+LOnzMMgs2lLePZ7FyhIYPj5A21bH8x8i2Pog8JRUARVGlfT4jk+Sm
	azSe/9mNwYTFAHOp4WeFtaEPl0z5KYXbJ0G1W77ETT3WbHNtXwD4W8aoImVFpQv8
	nBpNOImg+y8w9lWRcayR2/GaRqyECaTN5nJ060edIyYv+4mEZUl9zzB2JcZFwGT8
	f0f4himfF0UjhBht65X5No0giYuMWBKqqN1RnUytynQoEl/OxkdLXQbMAfmv7lo+
	hjAbluLw3blXxcwFUkla/07DRb242Va8aA2UNtKQ1BLspbEJT5I9ZS2LYwWLPpgF
	TofDvdpXMu7I9n2XPxp0g==
X-ME-Sender: <xms:JZWYZ9xEmzGYTbsPs-XXWy7tenNM2Xp_WbIam5I93gRzNHP1j-47-Q>
    <xme:JZWYZ9QVwCnF97ymRr9aa8virVXY0oKL2l3LB6_wajrgqUDqYqo202jSxuMQT3tQY
    bhZsxNTknSp8y1L2g>
X-ME-Received: <xmr:JZWYZ3UbNkk3ICygV7wxEi4dqePx8Onp851sI--Pgol5SvjGrmq-YrOZiZzW5YBubvO8IVUDlMqZ7LbMAadwnGSr56_CgRbTb8lvzSHy4hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JZWYZ_g6dNOZutWgumTrSCltX7Rp0sXZCsUEKX-LGxvcE_kIQ37XgQ>
    <xmx:JZWYZ_CvWx7KIXY3KWE6E08XI_fFdA_iBZa-scRSI2NYZf0NcUAtUg>
    <xmx:JZWYZ4IlQh9Kkpw9eRWdT1J0YHW7hUUmZPD7pZk0r06ZRTf8n5DPZQ>
    <xmx:JZWYZ-BVUn9RppOqHWplBiJqFmn8-8BNniIkKXTZQo0tcccbD0JO7Q>
    <xmx:JZWYZ6_ARGv3yzg2L8e3LivzyvcCOV2ST4mT23o4HwzwuC8S7I6J408q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa416bd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:08 +0100
Subject: [PATCH v2 07/20] reftable: stop using `BUG()` in trivial cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-7-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Stop using `BUG()` in the remaining trivial cases that we still have in
the reftable library. Instead of aborting the program, we'll now bubble
up a `REFTABLE_API_ERROR` to indicate misuse of the calling conventions.

Note that in both `reftable_reader_{inc,dec}ref()` we simply stop
calling `BUG()` altogether. The only situation where the counter should
be zero is when the structure has already been free'd anyway, so we
would run into undefined behaviour regardless of whether we try to abort
the program or not.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 3 +--
 reftable/reader.c | 4 ----
 reftable/writer.c | 5 ++---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 86e801ca9f..b2ffb09c16 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -146,8 +146,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 static int indexed_table_ref_iter_seek(void *p UNUSED,
 				       struct reftable_record *want UNUSED)
 {
-	BUG("seeking indexed table is not supported");
-	return -1;
+	return REFTABLE_API_ERROR;
 }
 
 static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
diff --git a/reftable/reader.c b/reftable/reader.c
index de6e6dd932..36a5633ede 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -677,8 +677,6 @@ int reftable_reader_new(struct reftable_reader **out,
 
 void reftable_reader_incref(struct reftable_reader *r)
 {
-	if (!r->refcount)
-		BUG("cannot increment ref counter of dead reader");
 	r->refcount++;
 }
 
@@ -686,8 +684,6 @@ void reftable_reader_decref(struct reftable_reader *r)
 {
 	if (!r)
 		return;
-	if (!r->refcount)
-		BUG("cannot decrement ref counter of dead reader");
 	if (--r->refcount)
 		return;
 	block_source_close(&r->source);
diff --git a/reftable/writer.c b/reftable/writer.c
index 91d6629486..155863ee5f 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -158,7 +158,7 @@ int reftable_writer_new(struct reftable_writer **out,
 		opts = *_opts;
 	options_set_defaults(&opts);
 	if (opts.block_size >= (1 << 24))
-		BUG("configured block size exceeds 16MB");
+		return REFTABLE_API_ERROR;
 
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
@@ -289,8 +289,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	if (block_writer_type(w->block_writer) != reftable_record_type(rec))
-		BUG("record of type %d added to writer of type %d",
-		    reftable_record_type(rec), block_writer_type(w->block_writer));
+		return REFTABLE_API_ERROR;
 
 	/*
 	 * Try to add the record to the writer. If this succeeds then we're

-- 
2.48.1.362.g079036d154.dirty

