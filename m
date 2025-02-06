Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93422540A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828347; cv=none; b=nzUyJ4pr63ay7pEHDZhIO4EJEay+rLIfMKNkkhSOUWSPB2pNHrgibUBihCV3DBf83aUBkGgAagJVQAl8eF8bgyW/h7sOKGQK96s+SUIL640uBAU6Igh1wbcyCXRmFiev4HufeE/suJHZKoq+ilNZqoWXEaULupRdty2fKv5GHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828347; c=relaxed/simple;
	bh=kPKuX8zhwCLYorG3555jZ8E4+OmEvwNW9Za2IYdBUhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzeU1dfFJbqwtpH3uwo0fKiDZczSL+DBGY29mbqBZpqNiCVKiw6jg1A9SjjIWCXCsA5ut1m4VOk0+yeuvCTtCZhi41C/aL15HP9QJ1waMWEpslfR9huKxg1fpPAO2GA+lJjIpUi6AnLhKuNGqfDwImJgGeWkobcNf8srqdmZcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxXHIP9E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKt64qgy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxXHIP9E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKt64qgy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA76E138022D;
	Thu,  6 Feb 2025 02:52:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 06 Feb 2025 02:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828344;
	 x=1738914744; bh=mM1aJiXiGx/mftefjDbbDUQyfUe75piBTX7KwSqp554=; b=
	GxXHIP9EhXNxF0n8B6GqUIcUWeQb7FmFkSy23UgOQa9BJbMSUOf24lML6cGqSAkm
	O3hsO31UfWXziSqmMA8jIiras3+BdSiY4Y/WZeESbsLWPdnFAXN9h7K511tzqnLq
	KggHTa0s+2M6oOtnQ229He38xTJ6OdqLo9yVl7tY26BJu1tLuCeRHiiPWR8QezSF
	zUSv3/AXZ4Cgga7ZfDZEMeAz1/xN2Kf00l24CmjhcdcMyAqCT6u4YIjn/zl3laE2
	l9ynC7rj7JUP3NqQQABzUTc/INYibrkxY+i11BCF92m2Kx72pWZ7EoS4/tq52ALx
	jYyWA0xpTiWNcdY8FxPSXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828344; x=
	1738914744; bh=mM1aJiXiGx/mftefjDbbDUQyfUe75piBTX7KwSqp554=; b=l
	Kt64qgyxbyNfs6ndnwjinWGUv6bvKJ55WzIS5AcF+dmWqvU41FtXBr6D08T0RDiy
	JRtIRSIIPFoclgEI095LYBhriexbVHo3WSfCRA6HSgwP8CrtN0MbVa2oBb0IhKi1
	/V6+Nhllc+Qx1hxrPIo2vixpP6sGgidJ6zeLyoEmypF4tp84SKpxv3oIC4O2OMpo
	nW/xNCT3+bJioxjUy/Cp82iocN9d4qgHtzWLCPHbjsXVn6eDX6eC7YQ+ZGX5ptTg
	Bfx0r1Bp0Qd7ecFEDXyMKF0zXBFUoIl1sR0BwP3GerXhIdXJZ6BH8N2KLfKcrwOr
	sq70W7axA3ovhKo6AcfyQ==
X-ME-Sender: <xms:OGqkZ1h9DD1y1KJFYrAqF7wiYOCzs_vnqbtGGcjfMy81Ur23amNaIw>
    <xme:OGqkZ6CKBFyFlHyjz2zVhCdEW7bM9P6BcUqdFz4pMUSyBTTGF4z6tXRwe_Mvy51qk
    -4FqwWkjJl3QfNgSQ>
X-ME-Received: <xmr:OGqkZ1EeW8Uyby59DIqFOfAlaAAzgTzVu5vq7Xf55Dy9y62RAEfPl-8ZaUBGk6y3Mf3XUXaY1LnjNgaoJyWv0hlvN3Og2GHN7PT1dxJXCW6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:OGqkZ6QamFqrxVJCcDU3QjyoV6y3Lz2lXAQVYhBTVoYXzsu4MTv43g>
    <xmx:OGqkZyx0Jj69LwXiqz1lagAxHCs_ap9_nlIv9EREifGL4lZACawCEg>
    <xmx:OGqkZw6bNcQtV-yv3ophKn_6xRxwIYRMxCMgedG12gWpFt4_T7IHPA>
    <xmx:OGqkZ3wqpzvCYIY59J_FTmaglePNZ7mLy4DFJZJUQQ5k4P-Z_luogA>
    <xmx:OGqkZ5rKOZpYvIfEJC31gJSwi6xhAGpjKDfOJvngfDTGG61tnZuEhNLW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2583cae6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:09 +0100
Subject: [PATCH v4 07/18] reftable: stop using `BUG()` in trivial cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-7-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
2.48.1.538.gc4cfc42d60.dirty

