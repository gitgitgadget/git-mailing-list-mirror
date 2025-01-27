Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907E1FF609
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983063; cv=none; b=KLhHvAafsJ0MGftB+U9VVf9lzK1Fl9pcArMsttpfDF2097TZxppsg54jC/ZJrzbZQWi4YZjDiGHVPrRKPLkwzq6J2XHClvGSikB9Cd1NQwf4o0pwLMyr/ajuD8MCKXAFmKtRv66weDB1UGYUhzoeed21nsSmN4eAV7SEaQRRJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983063; c=relaxed/simple;
	bh=Xj0t7OUm0FAA2j2ZiRD0dBNHYUM+0vpI1xBwvt+7UYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtS2wwPyEF8stV0teypSBcAsR049ZRMpaqqNMGK8tomImJrZopmx6tqLGC4Jh3aAzrOMDvHYQ1WHR4G8Vcn8BVwuaF/qp3xvFpOLHcJJKjpbfjFmS2kkEV4n0rqy37XkfqjU1V+x3JLPeEjMBkK0wlX3DM2AKg5FzsUhrxgfq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lGJArUMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t5czppvk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lGJArUMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t5czppvk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DDD51140236;
	Mon, 27 Jan 2025 08:04:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 08:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983061;
	 x=1738069461; bh=Ojg+QT7n1TKpobEbDjVPCkYXS12/+9O7UADZnn1jQ9c=; b=
	lGJArUMnna/ibaCy0Hbj4fiH1cZYOYP6Tl55LfnmWYRI8o/a89WmVZIUKl7GsAM0
	7ytGGxBSlk5YjDCOsua3bVF/jGQ7B6tcby8K1VOGc+G3AwJjRBeyc9lYn1REOgkH
	hux+XuyzUfEjCBK1OcYW2VbsQBS+qs+ikYGGDRPIa538dYPgRV2Z3lZSmj74N6uD
	rjoyn51GavUQPM9hPiyjZPxkYP/1/eMBMdjb/9xxCWJSCOibb0Xei1pQLRroyPcE
	VcDvyQw2JA0tg8FrqhNHTmeiICGApFDjA0s6ctsk8jssGlo4eeUMG14R7LYboGXE
	UGXJSV+Q897sqhXtyb6KdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983061; x=
	1738069461; bh=Ojg+QT7n1TKpobEbDjVPCkYXS12/+9O7UADZnn1jQ9c=; b=t
	5czppvk9uKJu3LNp8YipiKtMd0aF4tT02g2cBd2fSIg+LVmm+YtkPiqsJC5xG1Dv
	ZMgSmC0Rixraj2/QBsfZJ2s9h7JA3b4uC2ASUHlSHIB26fseOMkfuByNRJ21hI9g
	GElJh0IFihGLV7qRggOZKAQJ1ZZYo4c4q9I6LLhp28yuW8dVuLCflV2OKzy42m3G
	f+pJSHFMxLnm7AxC2RJsQKoF9OD1BhHj69DGnVfPm2PTvVxeVNh3b5f+r7WljJUV
	uVpu74D/ZEZVjlwoGcxXoDjGO/6200gqmxaNmEB7OktTtcQXzP/qBfX1Zd0hnIqN
	aSgK04dqycMbx6YNH1HTQ==
X-ME-Sender: <xms:VYSXZ1F3GBNPGqYB5xPFRuPSO-1qNlcXZZejh1_ZJ0HjrWE2JIlZhQ>
    <xme:VYSXZ6WvP6ElZiqcCE_Cw193aER-KBBYGAC5JGJ_3tX0qYTm1LJerv1CD0P391GzL
    U-sUm46ezl8g8uPIg>
X-ME-Received: <xmr:VYSXZ3JfaNmDGgUAIpFWxs4Xb77OgNdaWzbLGr11TCodDuaC1pb1vrxwLjAi6aB-VdkH5aoHJ9NQQ1BCF61LeXn4T3ZZ-O7eQH5rAGaGNVlJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:VYSXZ7F7LHUUwv0rHbQIC_hWGWZAdVmlqE3QlYjSq5LWgNY5Cm_4RA>
    <xmx:VYSXZ7V0gZy-sCgOeRTAOtBfEj0ldV6FHBxgYOUWx3kaXsyUvj_vJA>
    <xmx:VYSXZ2Pru_9DEBKfBJ2EDfDQnlFe5RjWtzZ2ZN_ioqN1ZQesFY3nsw>
    <xmx:VYSXZ628XwSzwynGL17xyZwroBNfZOh517QpaHb7NDVgOOEy082TAA>
    <xmx:VYSXZ4iDIJrqE_TZpULzfllj2PmiApkf5n99CH1hILhqwVoK9iBC0iti>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id abe4c613 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:15 +0100
Subject: [PATCH 07/19] reftable: stop using `BUG()` in trivial cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-7-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
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

