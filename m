Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42A1FBCB7
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569832; cv=none; b=IKsatwf/mtXbVpcFw8lkazdaUc+cFg3ORazXXsbiGk3zNLNuiQ1bvIW+I3ZVCaGcFLAaFCUjIyICcmfBENwtmex2ekUwwJ0tpF65RTR85H3gQPCWbO6ZAVXNRXh1Eeu9RjRipq1OeXmwlQRZiJu0Kbju0sQ/F6G517dWM4TsPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569832; c=relaxed/simple;
	bh=XhUuYJ1x6lvG7BNK2+SnnrVURRSgBwoe2/SogZmIYN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATcBvr7BPCb2xqf8iMhfsCLJLFljWUbwGYqo0SqVY1eoBXvzW22CclQZhDpHdMjy9s4UnMgePi2v9WQrgGCbSAhH1qd2Q41b/bYPOg+ocmchEky/i5QcFlQv0tqCIVIrosQWOPKVO0Nb0L7hXmbSXT714finAWGCzqLmt74KpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xy4iw7wP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7bc3PlZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xy4iw7wP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7bc3PlZ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9460E138084C;
	Mon,  3 Feb 2025 03:03:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 03:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569829;
	 x=1738656229; bh=fF39P6MHklsEeRUdtUKdpKmwQkdDpGBJNa62H691/NI=; b=
	Xy4iw7wPFUcjYM5A5pso7Ocr9l9TP8MYI1JuK1Z2ztpG0YTh3rf2Uefqt9Lkognj
	zLqEMfaq9og9riI5w6pPiibXerMxAlrCsWZHV6EUqNyuhQwI6Ke0UPp73fCfd5aZ
	F+/pRZrhNT7+GYdk2jBNkS7xdiatjTvVqT4AhIZfNAgWqSALdXrqYqWXIGDPJGIm
	qck+kPr3DXxTWXsWXaUqzQ8y5MM30bgJ2g/ZQ1P7aHvONCdnysLqYeqn3DXzAjNB
	lUzcB48ogN2X8JmRs9/9UGuUyk4zJC9f1/VbZcBy03ah95hPgQBwZUQl/JhXV026
	8ltkkoR//85MAnFzLVWb2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569829; x=
	1738656229; bh=fF39P6MHklsEeRUdtUKdpKmwQkdDpGBJNa62H691/NI=; b=o
	7bc3PlZdwG/bhPuoSJsf7V2Tlsj/Ar81qyzxK88W56+2EIjcElnaDP8dE8R57Z6X
	1zCD5+K3C/pK9LHs6CU5eVqfpzThADQ8BSeTqzbDPB94rP5hBYogOFUBMVuTlxBf
	UUmuUB0xi1L5fo86PDCg4lUCut62U+oxAfIazmrbFDfzC+fIdXxcZGSRCdrX27XE
	GaXF5KDcY+FN7Z0aovzkEHIdBL/eRuxF+BfPyp5rH9QuDDc/liCvuSM6nGE9k+Bg
	IGtkxharyXqpvZMQNBOw209jPiIKiifcVX+89UIYLw6K0yFBhwTZM8jfHllZzweF
	faTZ8VLDBU8UHhxVpW1yw==
X-ME-Sender: <xms:ZXigZ5kxAeYlJCCcSL7JUjXbNuNcjfSg3jYWBaKK6-TsjaX-lazT_w>
    <xme:ZXigZ02wE7DLPdmTj8nrKrlM4qnTbWnKd07Avx2R5_AkPsU7e3agmVlQvj9vQSl0-
    C5kFU1izPuCV7_HzQ>
X-ME-Received: <xmr:ZXigZ_qWI-2r8wlB4hbcBaRpK3yBF5SEIF32wqtQ-iG3Zbk03qzj6iZR_FJrrrfuX9B27V4r0jQ0n92PyTbsXbC5FdN5tukWA8SQsDnR0evSUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:ZXigZ5lQJzGRNfPN4-zbK9l4DeoFomE2mlT3S-WZ4K-R8sv6muw6lA>
    <xmx:ZXigZ32LdneHwDQAycKOyuvUA_rHYmnYTqetL4EezqutiS9THF33UA>
    <xmx:ZXigZ4tO7tx4BJmuQSTyf55NNxwaWiROZz7CvrRGHTiHXHC54TGW0Q>
    <xmx:ZXigZ7XkyZBMpGpwmZfN3tCDWYcBNgmE8iypWi0Aqz9w2jNzBp0elQ>
    <xmx:ZXigZyR1Ld3RVNuIvXDPDFS23tATpMducfOOz0rX8psPqCCQqlMOhxIZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 499baecc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:38 +0100
Subject: [PATCH v3 07/18] reftable: stop using `BUG()` in trivial cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-7-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
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
2.48.1.502.g6dc24dfdaf.dirty

