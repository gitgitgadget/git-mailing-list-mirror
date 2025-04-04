Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4E17A300
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758421; cv=none; b=pP916QOqM6V1lAT9c8Gt/Xt7QuZeRghPaa/9DBaxa7+p6L++W1Nn8BXan4DA1fbR/UhMjp0wfjLWLhkETUe2vXwqFRCUMAL01XjzaqSRDBnguY+SxaGSDG/CX+cG/15YQU+c4K+iuVO8KfjUkhY0Lw3fwqkiq31sbtLw+iH6ePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758421; c=relaxed/simple;
	bh=le2kCbVoGkzUwiuY4/jyiC7Qo8AeWAB9cYvb/bAFv8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJqumbVbOxvZlU5A7i0uKkRBY8Bijj5t7w3MvBs6ThNr/uINalcmAtPY++xfYdngOI3c1MhK3qWRL7n3b/NeGIR/RK0eWgnXDKTsrPqVpnmF5z3/pUIe78adBJv9MsmOEWyo6RK5pIWrMAMOsyVw7e76AZ0edYTeVgEv0aRlHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OIPhZW7g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRk+P3Mh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OIPhZW7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRk+P3Mh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 44CA811400D6;
	Fri,  4 Apr 2025 05:20:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 04 Apr 2025 05:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743758418; x=1743844818; bh=FSBfpndub5
	qNHDLCEQilyw7NxBAGH50jH816877QvDc=; b=OIPhZW7go1HgrMrJrl+5MBDjAC
	rgxDk22sZod69mnlalQHfncgBPz7H/LHgUVmBwoDz/sI72g1MsLuXG4iYQya21SU
	LeZC7N21od/U4jbjYp3rIt7SjhgXh+QsrWDZzijwPppe9V7hY96nFR0GAjEh2qqq
	Cbvuj4U61ksKatzF+tQC2o6OTjQ1yvIvNREBMK21GSFsxpPP3ynkaWeofTAP/Btc
	f3xqmsvtJwatuldO8WisB+C58ePcGPtaz7XDoelfoyQMa38zVhjRdNAVaQM38etc
	7pltdzC/myCyULr5ekj8o5eBjmb7ac6TCwPJuZ0ik6N6w+LPGXzRmGXdgxHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743758418; x=1743844818; bh=FSBfpndub5qNHDLCEQilyw7NxBAGH50jH81
	6877QvDc=; b=PRk+P3MhrSvv6AY7GdF+dEcDyV1gV7a99yKsm3V1AGjQ99xNqli
	TlDrhQeCh4slpA1s3QvofBy3vx+q6bbT+QRT8p5jWdi+fD3SDlii77hHnzDLlXR7
	4Eg43LJhzUMxaGjtzaJ9BQxzeuXskiH82Rn6WrF5xJhyrtZTZ31mS/NrNUr1lJih
	md9JuQPySpmr/0AfLebrIq039HpDFGoIOra5robawwDpOCAzhbtIPrAhkcAigsit
	+btmYA2SHK1McDRjxYWWYq4ztYPRfxXUBP/rIfDFBZI27T71W7lnKoAm0/iYdTnQ
	CIpbM8CX2cNKs+oxUs4KHPLjDoRegHqEOGQ==
X-ME-Sender: <xms:UaTvZ2SEqHraZ70FMl7KG4QgauDZa4VKSVFDxqIS9aY80PZvTtFolg>
    <xme:UaTvZ7xS2Kxu5rMcU-SClI2ms2UVJN61r0YupFoS7DpdDdrciwJWLyDD8io45_yaZ
    dxRklRjeNfl8yM_CA>
X-ME-Received: <xmr:UaTvZz16IDf3oyq4VYh-w7msKnhfNAWktK6Biego-GoIpmY7SyrXQJkjy_bUZB1XRucYtFZBess0JivrjkoGrcMb_SX4O-30Rk4QmnxODVDqsMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledutdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UqTvZyBGxoEsIu0dWmfGXQM63u2A8W96I-50rXU5pgVYKjq6BmKUPQ>
    <xmx:UqTvZ_hfMAYMuvdpRxdqN7mfRCzAEMY1NXAOnin5uttKHeoxP6hq8Q>
    <xmx:UqTvZ-pIWCLTPldpjn4j8_-UarZNmaRunU3RgDqgUF8pmMxkVdNRnw>
    <xmx:UqTvZyjZboeDnYSxZjd8rigO5rrWLxPuJDXF3gU_z1R1EYArzoJlYA>
    <xmx:UqTvZ2arg-YBAJpRS4wF38Hc18FmWtJ_wJJK7KVWMCAx9LjDq4lTbTC6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:20:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50d0541b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:20:16 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:20:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v3 0/2] help: include SHA build options in version info
Message-ID: <Z--kT3fIvz8k7h96@pks.im>
References: <20250401203630.285451-1-jltobler@gmail.com>
 <20250403140529.497876-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403140529.497876-1-jltobler@gmail.com>

On Thu, Apr 03, 2025 at 09:05:27AM -0500, Justin Tobler wrote:
> Greetings,
> 
> Additional information regarding how Git was built can be found via the
> `--build-options` flag for git-version(1). This currently does not
> include information about the SHA-1 and SHA-256 implementations Git is
> built with.
> 
> This short series adds build option info for the SHA-1, SHA-256, and
> non-crypto-SHA-1 (if any) implementations which may be useful for
> diagnostic purposes
> 
> Changes since V2:
> 
>   - Updates to documentation to provide additional context.
> 
>   - Inlined `get_sha_impl()` function.

Thanks, I'm happy with this version.

Patrick
