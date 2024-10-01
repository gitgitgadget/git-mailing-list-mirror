Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034C19E7C7
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775765; cv=none; b=cwrz6iSETaQNYgqxQpWH+nj4K0JsQ5ryx4kMcGrf2anWCWE+prdPizWMo4ZLIjWyc92BNgSvX0tRaIUSW5uxIZIAZ/aOxYwy88T3FBUiji/q+Up7ufvflEz9JiFZ9W6+t2Ba/W4Di6MTJnLZ+4fL5T5Uduqw7iBb5zyrUtiaTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775765; c=relaxed/simple;
	bh=NEAklIhYm1WtSz3yi50MUdbLVYNWlJzAGlMkm7ihaUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYCbaAa/wNn3IIm0JbtewUwIuO6+EcFYQin/1HJx9k21TJyJKdc6tCQJ0LQiXfvOpFuIWiZJoJj5gcLA9WEqcvGpWXVZgxtiHqz0QIU5JbvM/k/qCIeeHIJlAnMFTSx9Jr7RY/f0zuC6kx/GXFtwFa1GF4HVewCsxAu5D1VZKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ra1Ns0ml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DvE2fHj/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ra1Ns0ml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DvE2fHj/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BB661141066;
	Tue,  1 Oct 2024 05:42:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 05:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775763; x=1727862163; bh=63JfMVQ3u9
	Ff0kIv55L90Gu0Ad+ZMvnwThAeQUUIFPE=; b=Ra1Ns0mllVBorgkCXUbZmm1eOv
	J5v6RhV8rCZyPBJUrJVVN90iQhxkhe8Pl/YXSyYadnAU1BFT+FT6jhB2zrUwT2bn
	CCtmXpjxcF2Sl9ZDa8ER1d8TcYr9owGMwLZTPeYapbbXkAS3p2Y8k6+8shx7oLxM
	ygXBPgsrckmEv0DkuEJ85hFzy2/8gh3tC3xLwFO868u0c/IGJoWAd3dTi5N3Cvj8
	n77hZNsUSWrnjVbtWpu1GhEqWY3wlvrPHjxvlARI+jLZAG2DfUGpo2lljMrab365
	bi/hbvf9Uox6FwNbwKQExgl+i3FDk/wne0P3M+WctA5ZWBunkQpEiXgpP5ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775763; x=1727862163; bh=63JfMVQ3u9Ff0kIv55L90Gu0Ad+Z
	MvnwThAeQUUIFPE=; b=DvE2fHj/JUo52x1tk6DVnGPEJZgi0d8/VCoCtvb2Aw5l
	Ugr3lt9kcHmoEEsT1+aj6CbdM3P58uOTC9fuJo1wC5wgQVRI57QXker4c+TMHWpo
	cLZxwZ38htNi6jqwZOcNUCz2L6uTFl04YFW7yFNDVS89J8aSadrJZJv9MBYJoAh+
	53NNhjiZhhBpQkQjP8XtdyZOZ8Oc/Q/qAy87fI4TWwQVcRR3REkR2GgmWQvmF77n
	4y9x5tgj8DO+lWRQxt2FQhtNIJW+HmD2O406fm+AqNmESlRAoG3X0RQ9sXPuJ1PA
	E0m4HClOf3KQMfd21e5VEzLQqgNWyoLeNCwDQi0EyA==
X-ME-Sender: <xms:E8T7ZpVqKPTVvUiAoo2nLBla-b1TNScvxdvIpMKq12_ffWrx2Ant0A>
    <xme:E8T7ZplbSQQmilyGXipCaqrKk9faK7efbt69_3ZnJmA8DOs9baV34rICtXorJ99Mj
    616KRoV8Tkjh6PnhQ>
X-ME-Received: <xmr:E8T7ZlbO89FMdkhc9JMpSOPrzNoO4guu-xrb-QhvFMKCivVvRXCpblBViZMyLhtirsILh-HuxhG0leE-8ZoS3C4ZH_DqHk1B5XMRtOnACZRbNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggu
    figrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:E8T7ZsWKW4BYbbcSwIwCk-3pXDMixyS4amt_BnBPcYymhF4xAq_E_Q>
    <xmx:E8T7ZjnYhuXxnEgA-s4VTXtp-ElzjRLNgYRGoQxNuDKQJrmeMX-LQQ>
    <xmx:E8T7ZpfiHySQdU7_JjW3PrbrYRpqdZaGLhA-FirKM3ggX46265WrTA>
    <xmx:E8T7ZtG1-E4-NbKGJzt1BV06he-WnVgygOqXKIYBs9KuBN2GOBbOGQ>
    <xmx:E8T7ZsDNIhIIJXdtvr4VDfKmJm3lzohMv4u-qT3mLNIUAfSIpHtMULWf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ccc1e536 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:54 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 18/25] reftable/blocksource: handle allocation failures
Message-ID: <c7e54d71d758e92ceafefbb8cd272920616c2453.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

Handle allocation failures in the blocksource code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index e93cac9bb6..a2a6a196d5 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -30,6 +30,8 @@ static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
 	struct strbuf *b = v;
 	assert(off + size <= b->len);
 	REFTABLE_CALLOC_ARRAY(dest->data, size);
+	if (!dest->data)
+		return -1;
 	memcpy(dest->data, b->buf + off, size);
 	dest->len = size;
 	return size;
@@ -98,27 +100,40 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 {
 	struct file_block_source *p;
 	struct stat st;
-	int fd;
+	int fd, err;
 
 	fd = open(name, O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return REFTABLE_NOT_EXIST_ERROR;
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	if (fstat(fd, &st) < 0) {
-		close(fd);
-		return REFTABLE_IO_ERROR;
+		err = REFTABLE_IO_ERROR;
+		goto out;
 	}
 
 	REFTABLE_CALLOC_ARRAY(p, 1);
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	p->size = st.st_size;
 	p->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
 	bs->arg = p;
+
+	err = 0;
+
+out:
+	if (fd >= 0)
+		close(fd);
+	if (err < 0)
+		reftable_free(p);
 	return 0;
 }
-- 
2.47.0.rc0.dirty

