Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06513156CA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958278; cv=none; b=TLNeTyx08WYURxlRp1Xich1eVwV+6q2EZhrz7egMI22HExnKFM/XY2810gX/jP2Vh9IHDtKoQh2biiIcmVnL6ErwaJJBXvNzxbmS4bDSBX7pE9RJ69sGMWEAIRy4XTLAU+pQJeU7sVBsLlu56Iufva0o4PSj9sEwD6RSU8s0onY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958278; c=relaxed/simple;
	bh=QZ7CW+thelRHctN41zZfU1CaTzlKJGxKM5AxYKpg27A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffAh7ZnzgKY17c5zRt4OjWPq/EPlogio3AKZBa3xT9MfRwuCDBecOr3LmxYUvxERjHUpC0KwNjQnR820zIr53AK2iayUAnBFE22gUTGi6luaFCW/uQyXMKAl8tRA0uMy2XWbBSGSyC38CRY2u4AzkexotPDdQPMYTjkkUXfES9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ra5LNgwk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSVPW+kg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ra5LNgwk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSVPW+kg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 36D19EC008C;
	Fri,  9 Jan 2026 06:31:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 09 Jan 2026 06:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767958276;
	 x=1768044676; bh=wnnhq8arEbtz2WsL6753unMAaL7Bx/3I38MWM+n1R0I=; b=
	Ra5LNgwkJJgBEgVADSVo7QCc93aCBx2pxLFfCDqqQJMxJTl1XfWmlg2WUKCjI9xZ
	aNPCkgMPB0uv60peAf52N1SBVXvBCew2gNe91DOKNOmAAEBnzBR4VHsehmHs+jaL
	pxDl0Z/a7gjF2fNi721THyKNlD25X+9WwajsMu/iqYayGDedBNGYuXEb08byJI5m
	D2YDLy3wVsWtAm82XnJV+H5AAto5vOQpIHj+/5iIctUPh5m0htI1Sf7CN5b0KV55
	0KXQDyEZjf2hdewTSA71ISLTVRMjqXAp9eTwDE9pb/USUdXB5tMZDXgzUGlii/qB
	OqVyl4TS8WRX4GfG/uOIPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767958276; x=
	1768044676; bh=wnnhq8arEbtz2WsL6753unMAaL7Bx/3I38MWM+n1R0I=; b=i
	SVPW+kgPymEZbSJ2DPWucIdLauP5hutBsyUE9VEFr9bhklGnZQ6BJ5MJd+NCY82x
	FKfVaskPGXeTUmLEeYmDfiIdDkN2ohtDiCSup9bHl0S9L0Lf2OgDmbiYpKYjB44/
	sciVmcVsuiao/Wf6C78VoKOebV4IWbwqwiwZw4vn6Yc+Gikg3iIelYfleMdm19md
	59C/cHqyHn136QVulL5Nz/nQgaedxCx9G9CUu2fBAU08hryt+8PG6wmC1iCvOKtb
	Thx+8NmWV0eXVj+o9Pt+KrwN37Um2Xt2KD5PuxEUq8vMbvmwAt/2n+qsLSbwYEJd
	QiPhhmxvFhfTjBeCgJbzw==
X-ME-Sender: <xms:A-dgae_mpLcdGSlCRG2LUGKyFZQ2uAYtIZ78K4YKqv8p13tfF33-EQ>
    <xme:A-dgaWIF1zAB3qwZ57Ef4KiRZNdGdFONNYo0Ta_BmSPFYKurdg5YPkKhlXKsZsKLk
    ufb7rT5nqORyTFUL9DTCz_HS-eI3tdrTcd64FePRpGRRTbvE_Z8-w>
X-ME-Received: <xmr:A-dgaRZfOSGXvJDGy7meu19VYGCmD4vh2jbqVkp_gDEU5YkKui-pHtO2GrDZL8m0erRsrPCLQzW_QwC6wkq9gKdWIw3xJ_tyjWCqYy98Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtth
    hopegtmhhlihhsthhssehsvghnthdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:A-dgaQLE7VWj3rpLEMd9lwTi5lLLNH5dm-MXJjYhT4mtm6P2C3RnLA>
    <xmx:A-dgaXC8jwwcZMEVUOLvwFqsnJLBiyZGz40ceAiHo_olbCwLSNUCOA>
    <xmx:A-dgadpcUV7phWx2ic7tjDA5XUpIMf47Fmhzbj8KMDtTvOEeYMynmw>
    <xmx:A-dgaahu21T61SpaNJ0aiNcXMbX-NGTItJJTpgXrgr4CSVOYw-D6sw>
    <xmx:BOdgafb50iN0IVGKyvwNnr8_7f5VEgZv_wA3MIK0BXFCjHfSs31WhSdn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 06:31:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c49a95c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 11:31:13 +0000 (UTC)
Date: Fri, 9 Jan 2026 12:31:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: correctmost <cmlists@sent.com>
Cc: git@vger.kernel.org, Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: [Bug] hook: -Wanalyzer-deref-before-check warning in
 run_hooks_opt
Message-ID: <aWDm_n2YgjvaRmpV@pks.im>
References: <72d123b8-b75e-4b1d-8506-95eb9ad350da@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72d123b8-b75e-4b1d-8506-95eb9ad350da@app.fastmail.com>

On Thu, Jan 08, 2026 at 08:24:01PM -0500, correctmost wrote:
> Hi,
> 
> GCC 15.2.1 warns about a potential NULL pointer dereference in
> run_hooks_opt on the master branch:
> 
> ---
> 
> ../hook.c: In function ‘run_hooks_opt’:
> ../hook.c:167:12: error: check of ‘options’ for NULL after already dereferencing it [-Werror=analyzer-deref-before-check]
>   167 |         if (!options)
>       |            ^
> 
> [...snip...]
> 
>     │  156 |                 .ungroup = options->ungroup,
>     │      |                            ~~~~~~~~~~~~~~~~
>     │      |                                   |
>     │      |                                   (7) pointer ‘options’ is dereferenced here
>     │......
>     │  167 |         if (!options)
>     │      |            ~                           
>     │      |            |
>     │      |            (8)   pointer ‘options’ is checked for NULL here but it was already dereferenced at (7)
>     │
> 
> ---
> 
> This does seem like a real bug, though I'm not sure how likely it is
> to occur.  It looks like the warning was introduced in merge commit
> f406b89552 ("Use hook API to replace ad-hoc invocation of hook scripts
> with the run_command() API.").
> 
> I noticed the warning while compiling commit d529f3a19736 on Arch
> Linux.

It's not a real bug. If you take a look at the the `if (!options)`
check, you'll see:

	if (!options)
		BUG("a struct run_hooks_opt must be provided to run_hooks");

So we'd abort immediatly with an error message in case the pointer was
`NULL`. Which clarifies that this is a case that shouldn't ever happen
in the first place.

That being said, it's of course a bit careless to dereference the
pointer before we have the opportunity to call `BUG()`. I see two ways
to fix this:

  - We can either move all derefs of `options` after the call to
    `BUG()`.

  - Or we can drop the call to `BUG()` altogether.

Out of those two I think I slightly lean towards the latter, mostly
because the resulting code structure is simpler. And we'd reliably
segfault anyway if we dereference the pointer, even though we would not
get a clean error message. Not sure whether that really is worth the
hassle though.

Cc'ing Adrian, the author of this.

Thanks!

Patrick
