Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0863B8D47
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433988; cv=none; b=XJ+/guPoYNYjwZOeVTZJFtOmafAiD6xsdzuKLfKd5qFiXD2GkX9kQx066YldkZD1eIV0dHTUB1tOJ9+IfEXDydoXoqef5Y1omE0fJYEMUyQxE8izTRuW5MYsKMWh07EoX3ID9uYZBPBVjQVS21aqpOr+5lQr6fqzfGSHRafGypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433988; c=relaxed/simple;
	bh=xc83h/1qKGpR1p48XJ2B0suHDjWB3JuhkLYiA+P6UK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDG1bqgOzHiAhJkEADd9gd0O06U58IwcqnEGv7YcWuSKpTfzrUBCjpbx4bidwEqb7kDzhBEP6PcOqNco+XtXSgAAx6wd2iZpy6trSg9HbFxYnvyxlyBzWQyq4ZIUWgimaMQW5gQh1N3lXxaKfbKiqEHjAU8dxstMV20nU1VucPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z3Yd+YeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NtRo/zBx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z3Yd+YeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NtRo/zBx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FECC1D00192;
	Thu, 11 Dec 2025 01:19:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Dec 2025 01:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765433984; x=1765520384; bh=2KlvgwyHJw
	vFWRAgeRac+OMVQ+lqhiLlPATTV+v+aw0=; b=Z3Yd+YeVRC5AFMGpLmvmd2DfLk
	2TRvbe6Cl1pALGWLVqh9VMvwhn9HdD8yg3pXKa33elfmUAdfRKK2GMgkQonKyqPz
	gAFzzBlSfk1mAvUFUyIt2Fn2tW0VfvPUKYIMd77aWK4azfb5ckWAgPrB9vPuyCLe
	2Em1n/An8+jtp8mwo6eZZLgpuRajg1SHfqIYX3jTwfOdOSOkziYlXq33Hw7uOZS1
	pNheRlrkl7Wlcsje4rXrBfCajY5khUPg2GM5OwOq5DYa1dtKokCDU6xC4YQi+eBV
	ZGy45YGG5odd7Y/PlzmUqq12a9GeBQ1eBB60qtWbCIIJz7/SLM8uGliSE3gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765433984; x=1765520384; bh=2KlvgwyHJwvFWRAgeRac+OMVQ+lqhiLlPAT
	TV+v+aw0=; b=NtRo/zBx0fNetgFXSi87EvlCZSAkpIvwq4vT+rvoFYMeUpW459j
	+SIaQ9OsuGG5SX5DCUCUMgppnBjVLLOt0z6xA3LdUMFtvanxq3IP7MFJjx7p60na
	R4SfRJpV3vsThMydGaYVJwd/E+vvzZr5X03HKrQ3BiQ99xt5LRxK0mjTNd+TFtX8
	JmLME26Nu6KM9D46OzYVQN8qXGmlBSxsxL8f1R9P/vYgiXtv3nYatSzUm+f3pGbG
	35+lRUmLhYf3rWLjtlAQ7zXVk0uUiorcWpIp/bJFwVIwVzFfrWyCezo5LKSFa8iP
	pwz5UdqAXJ3sLVTgcrw4+5BBLcSS573HVyg==
X-ME-Sender: <xms:f2I6aXtJDTsaFFJWP9CwP2Vy1fUEcB47LINR-rJtZO6jWtRW26PYog>
    <xme:f2I6af7C4i1f0qd0yP9uXtzB1i3z6zmclLJDlJpPTd1uVyOZEEe4ELV2gpkE5XyIJ
    vetP1vj8ENMRDKdeDAxDuQkrhQjbOMUaKYU5y5bXZzxXTzginFY>
X-ME-Received: <xmr:f2I6aYJCY382ikOs4qCO7gjz9F9pDXIWcDnWVDP90l_jouwraiuAztFjdYQ3d8MBiB-M1yAFum3VIY263hIee1YCxd9z4oBFwNvl5xzOCSyZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:f2I6af6gpl99JD1ylRplOatHre4OIYfq7z_uDXPsiY8BJDkGfS1r9Q>
    <xmx:f2I6abw7IIc3QQXkb7XacUWUke2VNHvRGM5JWuC4d5S5IQt9T0pXUQ>
    <xmx:f2I6aTbYRaJAlsYMd1Nfe70g83IaAd6fpa380CgUh2RFyk0NAU-BDw>
    <xmx:f2I6adScmGtsBysLLZc_dk3WQyYRGIb5qtWwcjUsjSP-DFXNTU7FMw>
    <xmx:gGI6aQrcOsqfgRgbP_oVlFI02NyjSBWn2m030KEHe_DBBt3NFzlZjQF0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 01:19:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfdfde5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 06:19:41 +0000 (UTC)
Date: Thu, 11 Dec 2025 07:19:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] contrib/coccinelle: pass include paths to spatch(1)
Message-ID: <aTpieqFoMmZiSzWS@pks.im>
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
 <20251210-toon-cocci-memzero-v1-2-ae916a79065b@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-toon-cocci-memzero-v1-2-ae916a79065b@iotcl.com>

On Wed, Dec 10, 2025 at 02:13:02PM +0100, Toon Claes wrote:
> In the previous commit a new coccinelle rule is added. But neiter
> `make coccicheck` nor `meson compile coccicheck` did detect a case in
> builtin/last-modified.c.
> 
> This case involves the field `scratch` in `struct last_modified`. This
> field is of type `struct bitmap` and that struct has a member
> `eword_t *words`. Both are defined in `ewah/ewok.h`. Now, while
> builtin/last-modified.c does include that header (with the subdir in the
> #include directive), it seems coccinelle does not process it. So it's
> unaware of the type of `words` in the bitmap, and it doesn't recognize
> the rule from previous commit that uses:
> 
>     type T;
>     T *ptr;
> 
> Fix coccicheck by passing all possible include paths inside the Git
> project so spatch(1) can find the headers and can determine the types.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Makefile                       | 2 +-
>  contrib/coccinelle/meson.build | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 6fc322ff88..46d07b2d52 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -981,7 +981,7 @@ SANITIZE_LEAK =
>  SANITIZE_ADDRESS =
>  
>  # For the 'coccicheck' target
> -SPATCH_INCLUDE_FLAGS = --all-includes
> +SPATCH_INCLUDE_FLAGS = --all-includes $(addprefix -I ,compat ewah refs sha256 trace2 win32 xdiff)

This feels weird to me. We never pass any of these includes to the
compiler, either. So why should Coccinelle require them?

Coming back to your example of `eword_t`, Git knows to always include
"ewah/ewok.h", and that include is relative to the root directory of Git
itself. And as the header doesn't have any includes itself, this cannot
be the root cause, either.

So I'm a bit puzzled why this patch would fix the observed issue.

Patrick
