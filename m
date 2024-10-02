Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D64201277
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866582; cv=none; b=Tp8DThnAipC3AWeCwY/KzKiCOgsN+EX5SJhR8qu0uM1bavhl/Z//TmowwyXcPh+D66v8fuiDHdoscLwIA+2cFT0hVX/nBI4/0yUlU8GVSiG5ySIZ0d2sh+J0mJtf7Ppe70tkYKcU7jE2QNpmjEyd2qvSt7gFY2TwPguq+QoE2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866582; c=relaxed/simple;
	bh=NEAklIhYm1WtSz3yi50MUdbLVYNWlJzAGlMkm7ihaUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtMlP6QwRqBLayFEAHZKwztQPjRmT4wfDbSF2aZvVFi+ZaJIHSCRwpkbTHZDARozDmn7nwXG3RapJIjUaGyZwcoBpmqLltRuKQ677SSyi9a2OlUDjf3C5XM7ZfA8BiPqAkOhESfnd8CRoKODhDfoNMrTOkBx2FpkI/IFtG3jws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MmoSoPo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phOxVfXt; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MmoSoPo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phOxVfXt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6165C1140202;
	Wed,  2 Oct 2024 06:56:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 06:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866580; x=1727952980; bh=63JfMVQ3u9
	Ff0kIv55L90Gu0Ad+ZMvnwThAeQUUIFPE=; b=MmoSoPo0KPoRntZ759wp7I/rrT
	xzKvGxtVL198qiZ8WvNFqdEG8UPzFb1JpTtFIb7Ti4FHIi32x7T18SzXmnc9mduY
	sjfWZ5o4S8zUTdxz+9Q6l6vTNnp++4Yc3h5Z0+PAzhiyK9MlgrbPgel7tiIxootF
	j+0q49N3n831lxojQgvMPKlqiIdtkmd6SmhZd54OF8k8SPgv4gjAWFfSV5TG1UXj
	Nm6Jp0wLKjSaj75A63wJKK96+cW3W48yruLBkEI2rjq151Vk5xJwuvuSSvaqnGl/
	PUJ02Dau+s7HURd2bKGFmteIUaYn6QwEnfEmnvhxGlf8UwzGnrEzXPFI9lcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866580; x=1727952980; bh=63JfMVQ3u9Ff0kIv55L90Gu0Ad+Z
	MvnwThAeQUUIFPE=; b=phOxVfXtNhergNAD5+UOtbuWtd2FUroNBjuz8X5BFosb
	7amU/f0yIaJj8AnWGUmhNOyPbIsTXBOcASQXw6/AtipLw2vVGA8MnTT6tw396/r5
	nLXtkEHJMd5bxsySzV4M25E+MsoLpX8s+QyZ761Ey19ZGIzaGno9gfVTFndpoJtv
	Ic2X665APyCdZZjszlZCqHa1vgWuy8tOqLgbbV5TEP3FMo01RHH3fvda/qzMBhtU
	hHZkHV05sqD2HOa9LCISm7YcalTsFEdd3w8ngITJh2cfwwOwE4O2VnyjC5dryEpT
	wpCVP9T3HII8qSmPTAj3n9iZ6bY4/4Og+6lmVMShig==
X-ME-Sender: <xms:1Cb9ZjUJmmsk8H1QwY6L1uTTJtDKl_fIPcOLgjdcu7pVe_IBXZVSLA>
    <xme:1Cb9Zrmlre9CM8maptVYIxA5a0iPXm3DYKIwR7Py0h70-G69Yc5WABDM2ESjGKV8-
    Lzf01xfNQjXBc368w>
X-ME-Received: <xmr:1Cb9ZvYdwDs3TZzAsRjcMQEgy_xXEVABdnz7T8yFmsTU1DcgGqk7AU4s65M9uNj3lKfD86WCmy9KWgT6UxsbuQoWmdwh--hnZWiFYlkbSgn17JW1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:1Cb9ZuUxY0NLp5wt7oizfMGJkQ5Gi-YRTjUNS7kV6TRKtIMIyEw-1w>
    <xmx:1Cb9ZtnAb6EtX5rj0bDqZHV_oms0VMjZ4d0PGaHv5QizmQGK74DU0Q>
    <xmx:1Cb9ZreuyprMgD05we4D37XFKf69Od9ocs05ERQ6mPMlkdcrQ4bPhw>
    <xmx:1Cb9ZnFfljbiD5qI0W8gPMVu_AdZjPWBoefMbILmJBWduWAFJZesCQ>
    <xmx:1Cb9ZmAL8L3q71JCUWM6-29tIRWqmQp-5gUKj5BIOgzPp_n0waYGvDx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d8261f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:29 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 18/25] reftable/blocksource: handle allocation failures
Message-ID: <c7e54d71d758e92ceafefbb8cd272920616c2453.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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

