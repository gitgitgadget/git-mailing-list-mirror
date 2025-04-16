Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A523BCFD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799287; cv=none; b=o/njqyK0pt1nb6ZdtBQhRMqcR517PxBq2/aQ0IF3zTHx0z1M11p9pphcsoNd+cst6+hX67Nf/8FfdwV723D9PzYWzrsc6mU7oubiNNmBNh6uFKrn5FOIa3BPSBFZv/Fs1Lp6mLlU7rn9HDYduqE5ULVTEp3O8JDIEvvaBns76qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799287; c=relaxed/simple;
	bh=r8OaLAppvkd/TdL+TXDx8B6YeFr23GOpNC/JJW3jR6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLQQxW2OCBYHsShFh0m5SEUl2/QtnXhNrkaTdVAbi5Z+S5+/+vSlpuPHqPcR/XS3Fo+URZ1NCQlDhIWOg7RXVBGqDj5s9QOhY+i7tvxV2H1XS0JJ61/QR/Wa8b647nUyxsQgOolWe5zzNCzbMNTeaq27tEDQOuaTyzEhsHNwcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CVuALiUy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRQi4g7/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CVuALiUy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRQi4g7/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03B381140237;
	Wed, 16 Apr 2025 06:28:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 06:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744799283; x=1744885683; bh=1VJDhoyJov
	+wUN3cHF3D1gL9vokSDWdM92LuPXe3FZU=; b=CVuALiUy/Wk8MEVPzR0GR+SUVi
	JM5/Ek3cPUEu0ELfI2TvGctIzxiGeDYxdZ3llcH6kZoNQtG2NA1SqqdnVLBiOIBe
	ch2rP2rbeHO1ysuCVIaoa4OV9X9SEuJisvcw+SNiBW/3r3QCLYVd+mKqPBelMu/E
	8eMmtwL0AJ10L7ud2elui45DSXoOWpwCrJ7CGcY4fD+k7w16H2Ay51kDirAbnvXF
	K3l4gML33sB5/QiUcWpA+g+8MgQ8mEZ7ORFgCEl9uTxiSGIdp0MqrxNlDmk16wqC
	rOHf7AICnofC0tGHsmF4SdE2c1UZK1PcXzrrYRi5uenjy37F2vsojzhelX9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744799283; x=1744885683; bh=1VJDhoyJov+wUN3cHF3D1gL9vokSDWdM92L
	uPXe3FZU=; b=VRQi4g7/G0i7NwcQK6uDKPmPpQxCxoddaNP7wblzKya8Rc4d3c2
	pdJ+zpMQdvQ6/EkI1RL4Hy4EtvdRfDqNAKYhCYJSTB8inePmjXUBOVR0L+h6UoNA
	lRqjjTWvJSWdFDbUeTHuA37M/WeEmpgAj7hgdMyJw5K6sLGWQYOgNZRNtuWRF8O0
	+MXbTMQ4VoPQcBTo6bDJG5FAJNNCw/3MfBOSWKSK7QjNHA1XFMR6tAG5neDKdjI4
	3IAC92asqxP3mZnOx9MR+hBG7yOMyN4PYeeP2kCduzd1ZozxTD+EP4hNCefVFrxN
	beNS9dqL3NrgbLc87Ff1dZNRKrpVk2MSGXA==
X-ME-Sender: <xms:Mob_Z5pgQarCGiZkOsHBiRbnhzGQvwq6HNOolZGSFHWcjmjuqkodYw>
    <xme:Mob_Z7qZjhwRwLTywgzBRsI0Eyg0dI_U2wEyLF0zIR2eiv9-bT-Fe0vvy2aNP-e8B
    FeFGRjX8mV_KiHcgw>
X-ME-Received: <xmr:Mob_Z2PorEEE3JEssw6CzW2wxSTgPAt_vK0Goyl_0eCFIBgvjpsI7y0qIG6-tceNRIDs5jPA-oGPmpjeeVzeCsUx8M3az0nef4dBv3WZQmTYBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvh
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:M4b_Z05Qj6mJ1V2wetpJz_-s_xf7rC4gA1mj1AYNd7sSqGWiimBF4g>
    <xmx:M4b_Z44JV9z5pfTWluxYbcJ3LByQdT4M8Q09Y8A2A4T4DvMgAvAe1w>
    <xmx:M4b_Z8hBc3dw557vwSDY02JFouC25K9XeOygrhZiuLg0SqbukXitcw>
    <xmx:M4b_Z65DKvAXCblyIV7SvY_ctv-MLLRdgF2feFHw583IHO46ebB8tQ>
    <xmx:M4b_Z9DNbvCKu5zCA4Hvjxc1kgayxE7S3EORF4Ka2Vljv1wW-X5QJ2fi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:28:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99e9516f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:27:59 +0000 (UTC)
Date: Wed, 16 Apr 2025 12:27:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] parse-options: introduce `OPTION_UNSIGNED`
Message-ID: <Z_-GKX8uFSNib5rW@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
 <35300426-32cc-4c0e-b0c3-edb2b2ed312f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35300426-32cc-4c0e-b0c3-edb2b2ed312f@gmail.com>

On Tue, Apr 15, 2025 at 04:52:02PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 15/04/2025 13:14, Patrick Steinhardt wrote:
> > We have two generic ways to parse integers in the "parse-options"
> > subsytem:
> > 
> >    - `OPTION_INTEGER` parses a signed integer.
> > 
> >    - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
> >      interprets suffixes like "k" or "g".
> > 
> > Notably missing is a middle ground that parses unsigned integers without
> > interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
> > plug this gap. This option type will be used in subsequent commits.
> 
> I think this is a useful addition. I wonder about the way it handles
> negative values though. For types narrower than uintmax_t "-1" will be
> rejected but large negative values that parse as small positive numbers will
> be accepted. Perhaps we should explicitly reject strings starting with "-"
> as we do in git_parse_ulong() which is used by OPTION_MAGNITUDE.

Wait, does it? Why would `strtoul()` or any of its variants ever accept
a string prefixed with a "-"?

    If the minus sign was part of the input sequence, the numeric value
    calculated from the sequence of digits is negated as if by unary
    minus in the result type, which applies unsigned integer wraparound
    rules.

Oh dear... all these integer conversion functions are really a gift that
keeps on giving. Gross.

> This patch also needs the fix from patch 2 to detect overflows for
> uintmax_t.

Yup, will add.

Patrick
