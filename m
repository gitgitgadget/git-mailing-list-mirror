Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44521CC51
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188085; cv=none; b=K25mcJJB6pRYzL3y4EhL6SSbF92uad40pCbSh7RwCvkLrKAId8J28flhQgNSmRZ9R8O+WsQimd8rdncXJXg+dbOJB3ZuCKwRVErvi56/HHfXugQBt+LRp+giQWwZ12q/nfqwjMiRChsP9vqwKlT6XhQkoh27GIJPTZZWNHnkp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188085; c=relaxed/simple;
	bh=2qIqMz1NPsb8AuG++Qz+bkfY/8asbeLOaDVDHu+0RjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVEzOQSB/Zu/MeUC/p4rVsqOuvXHoD4Ukti2lG/Ire9ycB6S9dfCEpp7tfWYzkq5lDtHyb0xePNUkJGPR98sW1JwFpnHy56H4XGQV1tT3W/ZPGPLHruoUYlXlGAirvfqqEcvq76pLSgDPELYDCHuBbEMgojkYt+qz1+NzHIhmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KaiRl/KG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEP4s58V; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KaiRl/KG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEP4s58V"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9AE714000C2;
	Mon, 29 Sep 2025 19:21:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Sep 2025 19:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188082; x=1759274482; bh=/uT8ni62df
	mYzXYKJItdfu5+H5F3lGWNvBXZlr8Uzig=; b=KaiRl/KG1/ny9HW4drCKD+iQD9
	9WXQGSUXkihWi5Gl+DwfImsq4H7j7wy2kvBuNEuv/S1RLucH86nDJgubrpE8RZGr
	35IG+GHuwb6LjPuaNQKdUjZ2/HnVCK4DA8qfHv2EUwNZKijR9rOCAXxVL42RMquQ
	cWJvNxZ8qnZ1S1PMu1yx8wSezWLibSK6KUO4HxqVmMvmwyh1q86k97AofF50zPyt
	Gs143dlHgh+5M9eTM8rwWkSNrBw4CeHF1LbwmwonV9/UHJBWNpEvp74HBGJplq3o
	fBGAp/UpEvoxahgFsoOTgPC35A6hR58OZFcDHDPEVUJIEZ0qXOKgMtVJQgAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188082; x=1759274482; bh=/uT8ni62dfmYzXYKJItdfu5+H5F3lGWNvBX
	Zlr8Uzig=; b=kEP4s58VURsQ0Sz12S1WWmj6VJNLloU4Hwo3TsqxJPcpmUSwKX7
	u2Rr7HlFXWAapdyhiPnefKBzYG8udV2CCDBlmEq+6YbFb23M9uEboPFKGwnUT65/
	h09LTeF2hja3sy0uWQcEn/eMqFPlDZsN4JcSFXe+sF2heZPW/OuuhOI66cI6ztgb
	18/8K8p+6ZFshIUOBNV56IrBaYYwL+Cq6KdVftsXr1naWc2gRb3w06wFfDsUETA+
	WwQQSXiBEMOsOpv/EGb4zao9HIh+n7wXDHSIfZ7kq/VXovbQtJ6NCfAnBe+2KpOf
	0j5HWzryc/mlDYIK+LrbWLCiV7z8znraVKg==
X-ME-Sender: <xms:chTbaJnXaj-JyfcauUcwSb1CrANJ4hGbPF9ZxTQWPeMSamIQXkRSKw>
    <xme:chTbaIiDrmSqd4Hs9npV3Qxr0UmrEzcAACQEQGh65z2LErob3OqTEuq05KNxzK5A9
    dDkzTo2W1H9xZ_a51XvBMjpDMCDN1nUhkykBeDYfkUEAaanyP41yw>
X-ME-Received: <xmr:chTbaJeLnSJJQstchPj1ZZ9nEU71Fge01jJjp6GNeECTJ9wfKwgC23ZvN4kweUluoSxvoc9e6ujS2j8tODMqCgVmj5qfxu1K_YrQAOJ9w-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:chTbaAiJn812f1zd36XYAX3oAN-fBD8cAXpP76RBCntyeRJSgxbBaA>
    <xmx:chTbaJxX4IttHPmHOjMUvoEe9bEv1r0E-M3VJ4MHB4Mz72lq8GGs6Q>
    <xmx:chTbaEOUO7hZ-zIamh3eQrrbdiR49CW2pFaHIZZSykjXPcU-5a88vg>
    <xmx:chTbaCXJXs5Izq9Wpf1Hmgdp8HsmDGCa7cfL7O4rrOcaFzP52HNiPg>
    <xmx:chTbaIAZC4sFkjHm3Klm2CILCgYkUFXZUZPXzCyg4-Fqe-VwBQV7Lf8H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c788f7f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:19 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 07/49] builtin/repack.c: avoid "the_hash_algo" in
 `write_oid()`
Message-ID: <aNsUZtGst4MguEXq@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <37a7dea848f9618f7243fd9ff8ed704adfb3cf4e.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a7dea848f9618f7243fd9ff8ed704adfb3cf4e.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:37PM -0400, Taylor Blau wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 094f5a0cc2..7d62959dc2 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -413,6 +419,7 @@ static void repack_promisor_objects(struct repository *repo,
>  				    const struct pack_objects_args *args,
>  				    struct string_list *names)
>  {
> +	struct write_oid_context ctx;
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	FILE *out;
>  	struct strbuf line = STRBUF_INIT;
> @@ -427,7 +434,9 @@ static void repack_promisor_objects(struct repository *repo,
>  	 * {type -> existing pack order} ordering when computing deltas instead
>  	 * of a {type -> size} ordering, which may produce better deltas.
>  	 */
> -	for_each_packed_object(repo, write_oid, &cmd,
> +	ctx.cmd = &cmd;
> +	ctx.algop = repo->hash_algo;
> +	for_each_packed_object(repo, write_oid, &ctx,
>  			       FOR_EACH_OBJECT_PROMISOR_ONLY);

As this one is essentially new code, and we have all of the info
available right at the start of the problem. Do we maybe want to use
designated initializers?

Patrick
