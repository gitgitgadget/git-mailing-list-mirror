Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E48222560
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462288; cv=none; b=j+8LaJSvXyU/KNUhvLKksc9fmimO/wmYl73uG5/ITNIui/SGkj8qrBslH7xY0Yt8ky82VSYMxjuIZVZ51HLDiD+PGb36m1UN3A7sf7QIdvf0GXABn1MDM+5ZGsEmtL5z2mycjCssLAA768IFzgYKmKQj8nE4HhD3zhtFj8Mp9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462288; c=relaxed/simple;
	bh=woDS12d4YX1dR5PeZf88Y8kjIgpZ209e+YI0vHdwaK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5ugZVAiDWHh4Dm4xEf/VHsct1tDA7uH7HcjffhJxJdQIQSqr29Gynr/zRvXbhZJw7B8W+QGmHChEEipEyqHWcE4cUUvkc+0yu4Qc6atemyXHFG1yt/FmYaVu0Zg2trNDjumAANdoWU3WQyRlxLSOUg6CS+9b2DMH2iPrNdpRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KC/slCPT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OrKBldgZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KC/slCPT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OrKBldgZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 134C02540189;
	Thu, 20 Mar 2025 05:18:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 05:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462285;
	 x=1742548685; bh=4KD5XxZvJePohXgBl+rcudosVRUnD+X5NIp8e2j27IY=; b=
	KC/slCPT2GCHvtneubhS7/ncOdSkJP+2aOkYjjoesziYBe8oEqEL72B+IAf/Wmik
	fpDMFbsW0Y3XH1AkWc/fAgfO6DTtmnaFMPvxfxwB1Ra7RWCXm6pdq1oSNdChdlVo
	hz09YH1ARFliTVhIOG31oNCKV2JC0VFWF9hi0vkjM13GAVidhB8UuCHfPTUIqdgn
	HGPu66PDTOlvCQ9wtr2Bl/Z3QWCInlnwYMWA2w76PZH5jsLr9XmBn1T0tgYCJ/Pc
	RBZhhgj4AupgG1dX6ITtIMGrDKAy3/cDf7F6Enb4waAcIgxF/VuwcWwat6le+7mH
	qkA2wrtawtyGgIcf0+q7NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742462285; x=
	1742548685; bh=4KD5XxZvJePohXgBl+rcudosVRUnD+X5NIp8e2j27IY=; b=O
	rKBldgZ8hpMhOkqmp2Yfd9Idjpf+N0wmCetPZFET/qmJit+xWRDMsNEUNm1Rz4ab
	glgYUd1Gb9vL9KdrMyYdgYzarLmpyZbwgWy7lZwfxONmsensFqTfRmC7Ve4weL1J
	sVgQXPPh01jOxGpUSjDDGk3G6prxIrQmri3N9Fu8klzfKi1d49mcOEV8uNWerZ9Q
	VK9xt402jeNUjvQhJDdlGTsuIUNULPrH6lx5AWrTulLSaf5IbieipEbL11UPBOv8
	W/zg/sXQ62D29FNgycH1wvfbmCl1sL5EA77MeAFrhZq9hoXz6ni3w8wfrf00NwZ6
	5LLGsxMvyecSsMNsqydJw==
X-ME-Sender: <xms:Td3bZ7UXMM63YaR2ipK3yc3xkigGTB9P_-miv9YT-nS8IuvIQaWkwQ>
    <xme:Td3bZznSmBhplerX3lqcHpeKEnzC9lbePVcGRFGWlAggdD-nXl1aGbtr96McOVOus
    -iVOseUFTxlEJ8avA>
X-ME-Received: <xmr:Td3bZ3YQ3ffso9L6psyVn4GYbGjHgurph5FV0GRS8-HVEgL83RKX0S8glUUULjHTVoEaxh_K0Dquvsun95aELpHIUJH-rpOsRXjIm6I74MjMC6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Td3bZ2Vylesp8lee-M8gBXRhbtAkOtQWbBvnz-DHapciW5hCLoJaRw>
    <xmx:Td3bZ1k3yNrU6sCm93xQBB6Ew6nf3Yc2_OJFFopOgFGpe_G-fXoJHg>
    <xmx:Td3bZzcj7L1oxy5m484oVtNYf41LTTyMYieUePm6f4uP5aQpD396QA>
    <xmx:Td3bZ_H5f6DFkzPWLDqr-veXGpbsk9U9mvlExgHRAf7t2H_oVsxPkw>
    <xmx:Td3bZ6x215GwyyqOESjoeSa4jdDUC8A05__8pNxLrJPHQK8OQDGDVo9i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:18:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe9726de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:18:04 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:18:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] pretty: fix parsing of half-valid "%<" and "%>"
 placeholders
Message-ID: <Z9vdS4bxY6spILsc@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <7d6b62006ecaf7db159e8db0c85455ed58027ce6.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d6b62006ecaf7db159e8db0c85455ed58027ce6.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:37AM +0100, Martin Ågren wrote:
> When we parse a padding directive ("%<" or "%>"), we might populate a
> few of the struct's fields before bailing. This can result in such
> half-parsed information being used to actually introduce some
> padding/truncation.
> 
> When parsing a "%<" or "%>", only store the parsed data after parsing
> successfully. The added test would have failed before this commit. It
> also shows how the existing behavior is hardly something someone can
> rely on since the non-consumed modifier ("%<(10,bad)") shows up verbatim
> in the pretty output.

Ideally I'd expect us to die when seeing misformatted placeholders like
this. This is way less confusing to the user as otherwise things _look_
like they work, but we silently do the wrong thing.

That being said, I have no idea whether we can do such a change now
without breaking existing usecases. As you rightfully argue the result
already is wrong, but with my proposal we'd completely refuse to do
anything. Which I'd argue is a good thing in the end.

> We could let the caller use a temporary struct and only copy the data on
> success. Let's instead make our parsing function easy to use correctly
> by letting it only touch the output struct in the success case.

s/success/&ful/

> While setting up a temporary struct for parsing into, we might as well
> initialize it to a well-defined state. It's unnecessary for the current
> implementation since it always writes to all three fields in a
> successful case, but some future-proofing shouldn't hurt.
> 
> Note that the test relies on first using a correct placeholder
> "%<(4,trunc)" where "trunc" (`trunc_right`) lingers in our struct until
> it's then used instead of the invalid "bad". The next commit will teach
> us to clean up any remnants of "%<(4,trunc)" after handling it.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pretty.c                      | 18 ++++++++++++------
>  t/t4205-log-pretty-formats.sh |  6 ++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/pretty.c b/pretty.c
> index e5e8ef24fa..a4fa052f8b 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1121,6 +1121,11 @@ static size_t parse_padding_placeholder(const char *placeholder,
>  	const char *ch = placeholder;
>  	enum flush_type flush_type;
>  	int to_column = 0;
> +	struct padding_args ans = {
> +		.flush_type = no_flush,
> +		.truncate = trunc_none,
> +		.padding = 0,
> +	};
>  
>  	switch (*ch++) {
>  	case '<':

I honestly have no idea what `ans` stands for. You could call it
`result` to signify that it's what we'll ultimately bubble up to the
caller in the successful case.

Patrick
