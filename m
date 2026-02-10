Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8F2B9B7
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770701671; cv=none; b=YJ9hFwu6ZFhY4vDq2YSk7ic2N9Quv4ack6I3ni3m0fkXE3lOFfnJrqhriSsLwSD2MnIlQ7n6lX/tNvFldDI3B/7csby0syHZCr3ZiJRrKY4riOXeJSBtgcBNFhv8N6MQpOFqk6AZwCvAaaeVmcsYs4igPiCqRSLZnISYocOO0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770701671; c=relaxed/simple;
	bh=xFiINMceWxyCrbpBQVF77niBPczkdPd58m5zstnUY1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSuSCMkHxwCe3SFZLqYCtFNjckRsLaXtNnaC69KFw6v+4yAbJy/Y+7eE5nKZZHUUkoNSg/1L1Jc6sjmaB4QDc2zsDzMCqoURV6HExuayteDokLkjHcl557W/WYAFUx607DQVBF3wYTqpLJfamQ1r6dw08QZwjLoMPcY82b4Uzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jcRUVdsI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rN2PuzAW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jcRUVdsI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rN2PuzAW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F23517A01B9;
	Tue, 10 Feb 2026 00:34:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 10 Feb 2026 00:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770701668; x=1770788068; bh=TDUsSnimaT
	grnmMdN3yMt08L2YJA1oO5+FtNzIm/BEo=; b=jcRUVdsId1VD31bWkgSZOXqP65
	WDoISJ66nkWM/PZ45pVntU/zpNHf/2bZzcLafsvMCKlRvO+3/E72dF4bT1dtcVGG
	+CtlEOtDH9WRTHxP0VfvZgO0oalXDEQQW7I2cNS1MTp3jAuTzd3rIXP4jePADU+L
	AugAEFHW+eaDJXOdd3f2hS0dVuOWwa1Qf9AX+RvpjWOsj1vHQvg1wuLCQyOAcVet
	fH0kkbLuQRQL0PYOpppEdsHzLTP6wDfAXTz1906KsIqyJtM7zmWiOZG51nboNSBD
	70BFyZxIXkgzvwGpcSaEQPTUjfu5+OkTha4NpOPp6HrmvZGlGEbEUs2dMpxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770701668; x=1770788068; bh=TDUsSnimaTgrnmMdN3yMt08L2YJA1oO5+Ft
	NzIm/BEo=; b=rN2PuzAW247YAwMd3f1Buw3oh49lpqPT8HdldcPkDHC2ju/3AFy
	JeUoR0pPzYoaBX1DlZy4iHbYQuPTH5y6YlzNOZsarbYT1ZjAA9Jh3iQXcO7LR1z+
	F/24UFPCRWxvm0r3IzqJ6SD0cAvbSBP1Sh8n6My3GCKzvObjuxtpTrujb4uf4c/X
	BZ50dJDbYzaqSjwMynUEb1LTh7/xzalFaQd2Qsh9p+6kCC6k3UsrkwI5lAA/tdbo
	CcD9gSYiBw2/qhdG2z/MLsgoXL0JmHC6D/nmTzNxzMVgjDTrsLkreriFqM/Y0C6R
	PYseJQ0y1SdmzZr/ngl4QkPE+owOiDsYtvA==
X-ME-Sender: <xms:ZMOKaTLSjjbz5d7dH9CMhtyCLDI0uT3yWoBChzZxM_1Q7PCtDVo4KA>
    <xme:ZMOKadIKVIb0N6KlwX-qUnAcCgl35JKtLHvebSjvmuGTd4_AFy6gyZlotX1RRDRc7
    dtgVz8ii80wVmEKyZbD29aX-F0v_rtL8hSRnZ3eJSjld8HZ3Nd84Q>
X-ME-Received: <xmr:ZMOKaZU9Yv1N30ZkrNrpdcIU4ECgNUAFUC-zJfwywEj_JwKZ86_w3rZnWjSQ6UM11tvsja46D4_VnzTxDIu6ekfJUt-cm0SKWljy4DiqY9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZMOKaXhfXkmw31Yuucc3gqHLPv8oFIRuhpOpQd9fvgwHltiYcSjqog>
    <xmx:ZMOKac_zWgMMTUueyPqFGMgr7J1OwNCN5Iv_aD79dQna3wL3dBMkBA>
    <xmx:ZMOKaZC0MQcZNacdTbYR20yeOWyCOqBJ87mTt8ituWTiTDVyDfwEZA>
    <xmx:ZMOKaRL0t-hcZrhwO7S2caebEWQOcGP6B6bxneoJjN9LE-yNiKlNzw>
    <xmx:ZMOKacZ0_dnTptkqx7hUXC8FfZbjru8WFdUSjBB0N2zbKWewEIEagRgO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 00:34:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e355ef57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 05:34:25 +0000 (UTC)
Date: Tue, 10 Feb 2026 06:34:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: make test slicing consistent across Meson/Make
Message-ID: <aYrDXs9DMfBHi5jk@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
 <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
 <aYojRnqBi8nzZhPD@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYojRnqBi8nzZhPD@denethor>

On Mon, Feb 09, 2026 at 12:19:57PM -0600, Justin Tobler wrote:
> On 26/02/09 05:56PM, Patrick Steinhardt wrote:
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 2b175dc5c6..1b7a16e1f1 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -298,7 +298,7 @@ jobs:
> >          path: build
> >      - name: Test
> >        shell: pwsh
> > -      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> > +      run: ci/run-test-slice-meson.sh build ${{matrix.nr + 1}} 10
> 
> Due to the changes in the prior patch, GitHub CI passing 0 as the slice
> value would cause a failure correct? I wonder if we should combine this
> change with the previous patch. Otherwise this patch looks good.

Note that this is the "-meson.sh" variant, so this is a different
script. I'm mostly just touching up this variant so that it behaves the
same as the non-Meson one.

Meson itself would die though in case it's passed an invalid range.

Patrick
