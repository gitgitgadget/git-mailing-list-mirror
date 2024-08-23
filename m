Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCCE18890D
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422356; cv=none; b=gTeGUa4gTncZ+l04uUpbWwnrHQ1gnsEpyqcS5y3JMM2oTuPuWDFCbGFO0q0qMkjvvK00jmBqdJ5mQ0MtJ/krgA9vbeHW6nFD01IGA4ui6CAFKiP+iwmujKKLKU/KEGVmR2Ca1L5zWggCWyLwUP6Rq/VO+1CWS3kVBR5zHI5T3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422356; c=relaxed/simple;
	bh=0yRNSqd6ZUFg+q54E+wI645F5+3u7qNqXSjEfe3nV8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeeMkmtzqun5xkrr5JKZH3q1d8kLZjNyBD9CDRca/5uswCq/IsNoBoL1X8Ctf+IO8UZkLl50bsTli8EaLcvSIdeFhMBhtD3jOnD9V6zIt/iDl0PrwVhIXp0vpTW4OntQPkcNxt/6yTkqzyrl18hYfChJep1vDrWObMrdF9OwUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B/a6NLXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MIzxQq5o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B/a6NLXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIzxQq5o"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 24957138FFC4;
	Fri, 23 Aug 2024 10:12:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Aug 2024 10:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422352; x=1724508752; bh=o2pS6SKjr2
	fmp194IidRXafb3pzSTJdz4YHx6jmYyxQ=; b=B/a6NLXb0wAbsb/pvYQaqGahn+
	r6zZq7Tj5cyjXKt/onf+DsbQr8L5AyH1pWZDrDcvBEyNPYlqioODWxOqFPwFgY1u
	tGaMXPK2qtSUB55Q7ZCE6oGho3I4ha9cfIFDAEfKbzZOZKBgVDNGqwMv7C+dXyYj
	GnJucSCYfOo+16GzzG7WYMrjXn4T4s02GaEVVrOfRq3TH21bviEmm7F0pahpzFsF
	GcK/4+jhx7/aJQWsLblqgWN1+GC9EHJxfCkcWd3g8WEhUMBpLo3LalTsbHFrmVeY
	Kr8GZWsjfdnkEv+1yKHwW8tTAsBB42GEdTkUtbNzu52VaEOCzHhaMR49uD3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422352; x=1724508752; bh=o2pS6SKjr2fmp194IidRXafb3pzS
	TJdz4YHx6jmYyxQ=; b=MIzxQq5o4xDCemCOuAZf0kEpkOYq9+n3E3ELZHzd/w8q
	/9ed8V0Xauf3wza7rNtISNriMY7jHNLRhY0FkgPu5LiJx8sVqITCCaMmn7jyhF4c
	LubAVT9VO6MJn7ZaGgu+54Ox8wfNHXpC6/SdfrYLIvIuuPz3UATY9pBTdawDN4nZ
	araNJly3BcUXZYi3dGfKzbfczVaSiVnAcxgHzOugX8DPqrjT143sFUlgkJcDMqru
	xZcIKwTNGgvms0ZlJMTM/Z1jB4njufICGj6pa1WMp9TPwudYaDOzp+HCHa7XaNb4
	jVHgX7ftjCyVO9zyqwgA9cwT9auYY3ohrkuERK1zOQ==
X-ME-Sender: <xms:0JjIZnepnVBydSjgshAZgcvGEAdSGYbM2sCoePDvXK42TZGheixwfw>
    <xme:0JjIZtMtDK3iTs5co_hVbpRgeo7PmSv6N-_XWH-oG2ZRBx5K23zB27jlxJVTnJFc2
    JfbBt29xm0Fn6VgnA>
X-ME-Received: <xmr:0JjIZghtP8-OyEiKau4RHEQGyG7_aXYonVo2W3Qd8J1M3CqXq_A1bxz4lKbWWNLk3PchQUsYRMmxn5LyGp1xkqdD2lX1FNAvugBdpBbUTbSrSNvYng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:0JjIZo8IOvJcsAuGF4Dw5YJXZOlP6P2gYtp14pBifbJzGcADPzPhcw>
    <xmx:0JjIZjvjfWhknqNfDz8tvQu8FvFyFaZhbXsBxSjvBB6Kmb2qh2MCrA>
    <xmx:0JjIZnFeC73TxBq62efacl0IGo2wgJhBtAXXtbPs7_XepKW06zLKPw>
    <xmx:0JjIZqNNejW4PB4WYU6cxtzk6XZ_I-grJ7idHC9T7274HKAH66-EDQ>
    <xmx:0JjIZtLNfKX2QzocOAZC7uvyN0_7unvAqAM2M8PFb5-YBSKIlC0ZG4E1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51b8ab95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:11:53 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/10] reftable/blocksource: drop malloc block source
Message-ID: <fee3d3523eb867c6b45f4c133fb3b001be1ddd63.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

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
index 90aecd5a7c6..de8f426a429 100644
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
index eeed254ba9c..1774853011d 100644
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
index 072e2727ad2..659a27b4063 100644
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

