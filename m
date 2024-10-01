Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16119F43D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775722; cv=none; b=TeZ+kmPXbVtvp/DnoDPEoXo+qI8UdLaIkKdcFx8lVkxqL2yaP9QYEGY2Vj5ZPwgLXS1MvGCskwDjymQoz60wvFFwhAbZNf0+Hc45D/OEkqUTPQM+L3AzGMN1vfFK9MIfDpDdWjtDsPVT8+qepaAyIf3hGKcdtCZZQpoEXj7JAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775722; c=relaxed/simple;
	bh=DdozzQ67/6CahAwn1lWGRpV7LYsH0IYwH8QW8YJUXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQgnIFh/4AmbdN1XOxC/oWZnHgELMl3CujzuyEN7D9UVpGIpQsGucQsCfutTLmSK++VrL6PZKLVMX2md8nPTxcxgd8/57/MGVWVSedmIN4jfungxfnlgO2EqhjPgXbRdIgcS4+DaOGCZZWOImbUI9sj6SsMDwLVcVBZA0xtdMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WoQNcOUV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJEp6KHr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WoQNcOUV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJEp6KHr"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D52C2138105C;
	Tue,  1 Oct 2024 05:41:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 05:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775719; x=1727862119; bh=4wnjwnoBmB
	Fx7OgfS04fXzrxXw2NZlfv92BUkTkLdGI=; b=WoQNcOUVRrgapBWlowuFYgYTvt
	GE1nRUbwLPfo7ZL31s6rCFF2cPyjbMKhvmbdzateVfhscCoZTUHGIqkBpZCEqDCU
	CnYBBHoNi0/1WyuNOd0OEvtC0M9v5j1CmfPoqa+rVoepToPZLfbHy89gWLT/yzbx
	5ILDKij/pSOZkPwUkjUfm6v8Aq46U4ztnlCKGFNvQuht8xp86FI4+fvYziXFR4Iu
	sJdwqf9s8Jv46Xv4Hi+pcbAOYT+VGLxqxaJZ1cX99ybqUuu/w2WOeimrdlalnbCH
	Oq+z8V6oszd1FOLQVz9MSo4Q58/tXsfWIQ5Rq9kti/We1SjfO4Bjfg7Rt5EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775719; x=1727862119; bh=4wnjwnoBmBFx7OgfS04fXzrxXw2N
	Zlfv92BUkTkLdGI=; b=VJEp6KHrpR5p5e/+6AXGC4ni7rQqyjQi0BjACL7kpJHx
	7+ByNP0bzi9vyaQrxR9ltm6hwOUGIZXkCezNksD1TRbLgbsm36dfD99P1Bxgg2xn
	zPpG8YHxClP3Nx8BzRDRgl1bJxia20lapzCAehFzxJ7+9TqmAs63DmqwVoxB6GQS
	D4EVr0P3yaUp1QwitaOviEfjLtNN4imydBUhSHJsBDDvp7ig1WPq4dMpTrj3qFf4
	XLRimF1L9VmK/LKBa62z4NZvLzySPeZS0pgYsufamxbRPy6KYyRtRTQgIjUpms9+
	EXDpeaXGKwZY42Gmkz/aLjHVLkbqK9TYWooKhU7btA==
X-ME-Sender: <xms:58P7Zq6g0er2Pprrd7cqkSfTcFTZkim53UmxP-fc-xVqhSqMjP0TgQ>
    <xme:58P7Zj7a-519U4KkcFKtvoErplECDT2BLFBYozEM17DIfIJqxKI-PKmDUBtJlMKmG
    MtW2arLrZkbZR05bQ>
X-ME-Received: <xmr:58P7Zpf413ZgVCQK0nxvu5ylx9SwgSmyGe7k5quOHs1sBjM3UVOw-u-oi3ZqJtlGYg7BQv2jdb2yiw8lxZlK-x3f7upfdm6BkmTUd1GqcsbH7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:58P7ZnLuYwXsLMz7lK6Qr-oS7lIzRuglf2_pb1XsnuL4SGySs-8Q0g>
    <xmx:58P7ZuK2Iv3NGeODN5pruMxfTX_90AOMz_7KBIqd5wj46mt_6RqHTA>
    <xmx:58P7ZoyGVQ13e2EYLa3oDto-7bCoyZJvgCKDKxANUKlTJtSrXEiJ-g>
    <xmx:58P7ZiKj-WcS-xJQcbE8JcZq5uhYFcH7LEgsSAWRlo-Ag0wfVwyPDw>
    <xmx:58P7ZjG0W3qLKomHTyvBEMxBhIXkfDOGaunAdO4WhjpYszDNkU3oV5oQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:41:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5dcad7ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:11 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:41:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 04/25] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <fd9141e985bd83d8374ec339dbdce7a2350aa31d.1727774935.git.ps@pks.im>
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

Handle allocation failures in `reftable_calloc()`.

While at it, remove our use of `st_mult()` that would cause us to die on
an overflow. From the caller's point of view there is not much of a
difference between arguments that are too large to be multiplied and a
request that is too big to handle by the allocator: in both cases the
allocation cannot be fulfilled. And in neither of these cases do we want
the reftable library to die.

While we could use `unsigned_mult_overflows()` to handle the overflow
gracefully, we instead open-code it to further our goal of converting
the reftable codebase to become a standalone library that can be reused
by external projects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 4adc98cf5d..3350bbffa2 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -37,9 +37,16 @@ void reftable_free(void *p)
 
 void *reftable_calloc(size_t nelem, size_t elsize)
 {
-	size_t sz = st_mult(nelem, elsize);
-	void *p = reftable_malloc(sz);
-	memset(p, 0, sz);
+	void *p;
+
+	if (nelem && elsize > SIZE_MAX / nelem)
+		return NULL;
+
+	p = reftable_malloc(nelem * elsize);
+	if (!p)
+		return NULL;
+
+	memset(p, 0, nelem * elsize);
 	return p;
 }
 
-- 
2.47.0.rc0.dirty

