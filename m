Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A71EC010
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866541; cv=none; b=nCCur2s+lrGyPliJ8QFHbUhEmJbDFbIyORrJ74wdQnCw2fIAAvC/QTI05ETZSvECjmhSjp+2aCprNm9EKqlF75XHxDHtauSqNeOExRQJSw1ZweAEc8tU4oK3W93Cd1FBQLEGGuBlw4Ui8Vf88lHTxJn0OBnULO+gIQ212pP8ES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866541; c=relaxed/simple;
	bh=DdozzQ67/6CahAwn1lWGRpV7LYsH0IYwH8QW8YJUXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdspvuaYj5amJRUKFcqZXRQzG8f8dArxu5E8D3Jh5paNKni/u2R2JpU8W6u6I+j00a7ZuEC7IrAyrif8z85vrmS8PK5LixN3ZcgpvkbYp6phMJ8GaV5Fr2KpK2uqvG/FDGmewwNeE39Ny8zH5DJ7iHZ7FLwNs79mci0Yaeh6JeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TGMdHXqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hgvP4AKi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGMdHXqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgvP4AKi"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2ACD71380601;
	Wed,  2 Oct 2024 06:55:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 06:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866539; x=1727952939; bh=4wnjwnoBmB
	Fx7OgfS04fXzrxXw2NZlfv92BUkTkLdGI=; b=TGMdHXqeVEq3xDIyX1A/s52+/6
	kkI6JjfrUAyO+RP5mcz4u5cScozZxqZkO90kxckRWtOuSdGTCKWB5/yqlAu1b5NE
	Fa3p3JIQWpPwOZT3866bPv9wZpx1P1ex8kTdmuk7Qqe3qI1T1HzkWxAZFHS9OM63
	j4SwihwgdhdSkvFIOja7F9otCyhOX81vS/eXjGoNM4RlT3bqL44t0SLf2I7EXMiN
	EiVcmmxUy0nrT64GcwzVC9jchjF0acvP7HUkMuaVjD4rbAbojbtLcDSE1PaOJB8U
	2vAnQTxVSlNxiouQHP+KoE1dFijgQXAUK4rB9cQbkZ72NJnjLKzXphqpeHHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866539; x=1727952939; bh=4wnjwnoBmBFx7OgfS04fXzrxXw2N
	Zlfv92BUkTkLdGI=; b=hgvP4AKiX2Cl0Hg2HB/y+XYm1HBo5LTJOBSUb8x7MoBK
	Tyv82EUjZsvWxmh4nO1ic8n/PInAjSDMjlYyJ7esJ77Q4Aww9cA01yW4VcRl8MSX
	vGcvrHNTNg0gsP1a22nl8hGmi7YpHhDPCfmkgC48US1IpXeGcbbyZuINX52z4GFR
	lPCuoJ+N1DPCk3jZj3TDbN3a9EHmFfzDUvUwIefjAQiO64s9kGxNbcY0h/NTpBNo
	pXte6w+dt++C5x17sN/iIh/gFCE2Ed+m2txzqytUrGd6sIGWAQkEsvOrhZ2noqVl
	nK84gofvvFoLmM7EoH1YQcsogbeCcpkTTGQWVBuRfg==
X-ME-Sender: <xms:qib9ZhLLgbVAzeg_RYQ2iXJWr-2HTKna9P1mCPry_DBLstFhkbOWNA>
    <xme:qib9ZtK-Q_0CkuwnG-dZoSRA2PIMo8SXR-ABMH27SMdmnAVPTxQGUSbpjAbHX30PM
    EmtD6UuPK7rR57SwQ>
X-ME-Received: <xmr:qib9ZptDQbAVkOoxAIMkSys_f3bRAq63e6p6G8IcFgyjWI7InI0w8CJG0zuI-NkZg9oJPGCFbvfB-OfpHsdd7sDqvcuKMBL_ZPM-oM85HXpSn1Tf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:qib9ZiZ3TrAhJ7GF5Yj-QAK_mTwcBwy548N8igZ8y-ntWX-af0P4TQ>
    <xmx:qib9ZoajwJcUx_xgCnQcxfnnp2EsiZmZFPTO_3cPfSoc8ktCNSmOIw>
    <xmx:qib9ZmCgXiTo2B1oAAMdHGRWp2EGLK6l4wTpYPv0dbS1jeM16e2dIQ>
    <xmx:qib9ZmYafguXlLk-HE4FBp0TmvUnXgqPn2DO6ucUUkyw2StfpgIdQg>
    <xmx:qyb9ZvVPVk35Xj6II15XXkBKhqxmTas_XMU92b_os8zaYyIsliuej9Xs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5c375ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:48 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 04/25] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <fd9141e985bd83d8374ec339dbdce7a2350aa31d.1727866394.git.ps@pks.im>
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

