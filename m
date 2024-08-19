Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6127E0E4
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081987; cv=none; b=eirSNVqXGv6WN1IntY0gLU883BKeUOTuEIbG9r/wvCnp/pbKPNObsDNfQQlNr9KCvUVdo5nnUlBSip5TjdymQkG7mmkdJLoL6Tde4SA63qoyPBvTXtmQXdoneA2BSZ9LQrTwuj5h23RlfdxPVJNYjljxOGl3jwbqVMMYEMebpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081987; c=relaxed/simple;
	bh=zZg84Pq3vFyO6otM3XyedC/wxEFKc58/6LQJeyGrhHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwIf4dpMaEBrlkB/DLztkBLTAbbbxFQ4M3mz2dDnFeVE8U5x2D7wjrDG1hum/jJjZrH1G2TqFe4SaaWc3n8Wxb7EAafvq138zSXyKrAkQQx4bT9w72DffAT9k3oYXLY5VYfbLHf0I/QAQfhP3w0EwwBzV1qyg+xcovqkJjajWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KeIApdma; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQyUQtuo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KeIApdma";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQyUQtuo"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ACAA01151ACD;
	Mon, 19 Aug 2024 11:39:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 19 Aug 2024 11:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724081983; x=1724168383; bh=qcEV6S2ywj
	eZc2wSaO+enL19Q6SnAHCDwYLUAgcg1p4=; b=KeIApdmad/UqrcEIuuGHsPHXyt
	TyWDjk32dvSWucVGS9WYtr8inAm3Zgj1upyCfBvfAX9IdfjXeWbUfLTVrbWzywVJ
	kkFeoKBxUNqKy+jinSlolk1ma8LQ/4jzyFpfSFRWGcXZfIScg37G5Z8hunf7YLSe
	158yNKA3QXIhSAqBpIfJ+AN7HDZmTk66LjPajquvBKlwr/SunT/D15wm9CI8bT9W
	2FxSS+bcWnOF6my58iZ8kb9mOupQiGfYp1UhSxzXCL+2/EeIgFKFaIHhkvrPenfm
	PEhJtSE49aMiuIPfX9bskV/llKhYOCC3tqQrh3+Ubrc7zI5PEv0Dj83j6UEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724081983; x=1724168383; bh=qcEV6S2ywjeZc2wSaO+enL19Q6Sn
	AHCDwYLUAgcg1p4=; b=LQyUQtuos640sxA+Ar4V/VZg3aYBhYOtPc1mNrp7Ya36
	X0sRHYhgXx6dNCO/igNjRZpPSGuTfBGV7lqK52ZiSSrdkAjkd0IyJqOmEL5wkoHd
	ERwoikaUu7GnEQ0PtBirSgdd3hvEzSBE2tm9Nl2z7/3P/OB2NUEE4T9s6tmrQE2s
	inmM06GW/D9VZ9sYpsdsqfZ3KgFel9kwWeWAii7HNBhRDqEWDm93M3GnRof1Etpa
	jlsgCkcbrd8xbRPlqg3C6iOUNVafT08IyQj4+llOIEAdkFMZ0ifMGmSh0zNifjpu
	Q0Vy0S9RAOrkXZRf4KH2Uddvpiohf9GqeYkROFQjdA==
X-ME-Sender: <xms:P2fDZpqKZaXXmgzwxb_FCYabC8DrYAptKfckyOc3eTIeH6hskL0Ldg>
    <xme:P2fDZrp7sECsOUkoimcbDAANH3xT8ufSJg8_50kaXEcrIogp5PBK5gqcqWuzSoPW1
    M8Flf5vEPnrHC1vFw>
X-ME-Received: <xmr:P2fDZmMiJm0SOk-u9-ecFOCA53GT69tOyqH-NteSie1O0oRDiuru9lg57OLO91YqheBlgilrRlJ3IRRDiOnkTcxxXrp1hKbpGmMzPMqY0RcScrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:P2fDZk4CSY4MU1vw8czQbFVbYaCIoWWhsx8Kq2m0wS1LZCpSMXyUEQ>
    <xmx:P2fDZo7TUy1kqVWgWanMSwVthbF07Xwsr3Ogu9p3GpM1yC1It-wEKw>
    <xmx:P2fDZshDkUhsS8BYHMXhN0XubUbr785KjpaWv0ZGYQftgAwQnUnnWw>
    <xmx:P2fDZq4dvcfIaOEO7wjQH6vZRpwBfTQP6iL2RYVgcRF4NtO4fmUjew>
    <xmx:P2fDZoGEhGoeH2xd5FY03Ddw7I2V-ue3tuN1NLb1Oq2EOKtFXJcYxoOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:39:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0dd4b4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:13 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:39:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 01/10] reftable/blocksource: drop malloc block source
Message-ID: <fee3d3523eb867c6b45f4c133fb3b001be1ddd63.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

The reftable blocksource provides a generic interface to read blocks via
different sources, e.g. from disk or from memory. One of the block
sources is the malloc block source, which can in theory read data from
memory. We nowadays also have a strbuf block source though, which
provides essentially the same functionality with better ergonomics.

Adapt the only remaining user of the malloc block source in our tests
to use the strbuf block source, instead, and remove the now-unused
malloc block source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block_test.c  |  3 ++-
 reftable/blocksource.c | 20 --------------------
 reftable/blocksource.h |  2 --
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/reftable/block_test.c b/reftable/block_test.c
index 90aecd5a7c..de8f426a42 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -34,11 +34,12 @@ static void test_block_read_write(void)
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
 	int j = 0;
+	struct strbuf block_data = STRBUF_INIT;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	block.len = block_size;
-	block.source = malloc_block_source();
+	block_source_from_strbuf(&block.source, &block_data);
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
 
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index eeed254ba9..1774853011 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -55,26 +55,6 @@ void block_source_from_strbuf(struct reftable_block_source *bs,
 	bs->arg = buf;
 }
 
-static void malloc_return_block(void *b, struct reftable_block *dest)
-{
-	if (dest->len)
-		memset(dest->data, 0xff, dest->len);
-	reftable_free(dest->data);
-}
-
-static struct reftable_block_source_vtable malloc_vtable = {
-	.return_block = &malloc_return_block,
-};
-
-static struct reftable_block_source malloc_block_source_instance = {
-	.ops = &malloc_vtable,
-};
-
-struct reftable_block_source malloc_block_source(void)
-{
-	return malloc_block_source_instance;
-}
-
 struct file_block_source {
 	uint64_t size;
 	unsigned char *data;
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index 072e2727ad..659a27b406 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -17,6 +17,4 @@ struct reftable_block_source;
 void block_source_from_strbuf(struct reftable_block_source *bs,
 			      struct strbuf *buf);
 
-struct reftable_block_source malloc_block_source(void);
-
 #endif
-- 
2.46.0.164.g477ce5ccd6.dirty

