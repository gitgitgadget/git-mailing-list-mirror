Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3B268FD5
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173265; cv=none; b=Q8cL3e93/8dilisswWPLG0nLGpZBpYFmvvMdzjt7rcRiPovo2Kh3gTOys3yHLMS70GYa8kH07oyNpO+GgXfxVe60+HlJDwwQLwTNYe0Fp53IQwf1eaZYKE8Wkg1TbYfmEOJ+q8P2o4zrPtjdga6roIBG5/MEr+0mwfy3qOivubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173265; c=relaxed/simple;
	bh=N7dhV4BVSCFyw9jOSCiBXnlK5yAdTSLnTfW5NjO6KXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY5clp0XtSliLN++lt4Cdb89qgYrai55uqrBkKdBB1k8e1LoHWXWBwo3L9+oPadKqRPuRp+QLozqIjmItj48Sg5ykchwzroY/XRb12UgwPwboXmHVTe5H3mgiMl13jyLl/DxKlWm1xgVggDgMJaNkFytD8X5drp8jeQcLjoxEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3kXzfLMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gZ1ZmSs1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3kXzfLMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZ1ZmSs1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 963DB1140085;
	Fri,  2 May 2025 04:07:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 May 2025 04:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746173261; x=1746259661; bh=vGeNj8hfQb
	vGla/cOWFZJK3gb/E2PI0W5qbFQjnVMtU=; b=3kXzfLMFYdYd2D1hM2Va13UFca
	6rVeGRxywWt/FGH+23LU22eWY0Xzu6NV0xAP1pQojqYo8KrUakCnHKE59znfkMDQ
	SVzRCbfYtuO5OCXzBId3gGMrzArerp+T83n2XyeSj8PNMMlqw0Rp/t2c5wVxzGtc
	vSyH4FGfGBwg5cxKT7gi/JdxkjY6NPjf8NscK8pUYa2ZsyysiTSHIP8Zm9RsmBsx
	0ul9rticcWaiqdbKd7xn3LsA4AjQp47WbDRkHgYxCDGwBknwHkDnjbbTuAvg7bD4
	OxQG7JPgXfL4y7zIN4fjBUsRsWdt6RcBmVY+zD6o+KnBlahDKHRGVPrMxYzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746173261; x=1746259661; bh=vGeNj8hfQbvGla/cOWFZJK3gb/E2PI0W5qb
	FQjnVMtU=; b=gZ1ZmSs1IrtsUcn89s63THko2XQ+vh59GwfKxaEXDcSPYFO3HYE
	InjsT4w+BmBr9O6Z5zYA17x1XS7DSraD8a9XO5Ll75qEy8PZameCppgMf86myWo5
	O04gO4MV1E9pR0pd3ZInsXxgEc9L+X+CgCHy56nI9Ksei/NL+44IHVXCV6HhFWel
	0jr5YAjn+mNBIGinoBVkhFNP9qVABTk0V93uNNPLZqYfFxD9bmwlJufXWL4hkoXX
	Se5YoWUL+20ZDGvrYmENIf1TQd6GjWObvjyf8JC6v8m65wjrJc6U7351F0X0KWSC
	vRwsGVbHWcWci/LLqLoJ+DHBpgaqB0QojEg==
X-ME-Sender: <xms:TX0UaM9Jdi0FGCR9xjKmdswPHgI7hiZ4oi-7kh72RzrDXsGOvAOd9w>
    <xme:TX0UaEuDd3b5L461eClXdEE--CH4clZMpVEqsqDyEvw7dBbYsA1O53cNzLdxWW4-q
    hu-JAHca-wv4LKmww>
X-ME-Received: <xmr:TX0UaCChXNvmGunxBk9yWA60zvid8TMu058Lrxand5dyMdR-4APNPrkL4eXZiTIqKcfcZ_shHk27lenFVY3a67pRhFoDphWBC-xuuVIAgBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:TX0UaMfGli11QqkghxAA8NOVmDDXZz4AgAQgcPMi_BWTIyBC7opnbQ>
    <xmx:TX0UaBMxge3gDtTCOV6nCO_X_0-ocWo_2xCmZ8p2CPthMd4GkSo7og>
    <xmx:TX0UaGmTg2qx0YcgvNqqqkWUy18j4ESCQCSwXBxJ2IddIuYHuszZYA>
    <xmx:TX0UaDur3_XSZtud5OipX8RUT4BSNVP6BBwhZxn4pPI2Kp6GmEegbQ>
    <xmx:TX0UaDDr9ryDtrJhKe5B_0fC0nuuS_nFvoEQB8sW5zd1cvUv_Bz2kQJS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:07:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6212637 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:07:39 +0000 (UTC)
Date: Fri, 2 May 2025 10:07:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] builtin/mv: bail out when trying to move child and
 its parent
Message-ID: <aBR9Slq7_F9PRq0W@pks.im>
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
 <20250430-pks-mv-parent-child-conflict-v1-1-11a87c55ffb9@pks.im>
 <xmqqmsbxz3wp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsbxz3wp.fsf@gitster.g>

On Wed, Apr 30, 2025 at 03:21:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > -	test_must_fail git mv a/a.txt a b &&
> > -	git status --porcelain >actual &&
> > -	grep "^A[ ]*a/a.txt$" actual
> > +	cat >expect <<-EOF &&
> > +	fatal: cannot move both ${SQ}a/a.txt${SQ} and its parent directory ${SQ}a${SQ}
> > +	EOF
> > +	test_must_fail git mv a/a.txt a b 2>err &&
> > +	test_cmp expect err
> > +'
> 
> Shouldn't we make sure that after failing "git mv" the paths and the
> index entries stay as expected?
> 
> > +test_expect_success 'moving nested directory and its parent directory at the same time fails' '
> > +	test_when_finished git reset --hard HEAD &&
> > +	git reset --hard HEAD &&
> > +	mkdir -p a/b/c &&
> > +	>a/b/c/file.txt &&
> > +	git add a &&
> > +	mkdir target &&
> > +	cat >expect <<-EOF &&
> > +	fatal: cannot move both ${SQ}a/b/c${SQ} and its parent directory ${SQ}a${SQ}
> > +	EOF
> > +	test_must_fail git mv a/b/c a target 2>err &&
> > +	test_cmp expect err
> >  '
> 
> Ditto.

This might've been a good idea, but I see that the series has already
been merged to `next`. So I'll refrain from improving the tests.

Thanks!

Patrick
