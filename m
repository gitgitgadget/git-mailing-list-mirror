Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94682BE7B8
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897599; cv=none; b=U53wi4d/VMwtrQpehhlR2pJNLStjjkaKyUC3D1SF2nTO9rRtPPhwRqPWO1l4NBw6oHCzRPjl6Rf/ssCQD9D7gJ5KSa5BKfMIRZldOQSC7Y03S+nWlf1xvtaxgSnWq0UHbQ6nJpEpg/golmqmE5yii7uifcEzbEZIGLoqrr5hlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897599; c=relaxed/simple;
	bh=GaNp3iw8VF80FTXH3ovKn3vxm+954BPJweRwwaatm5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQvJThGf10Vmx/FzNlsUv6wVE+qJYthQP3owcNQKNap5htm7RpxCjIaKasXora/ST2RSH203rgDrDLdstJfETntsd6jHEMpy0DTxofBa1os2ZIZyutzO8LNkZqzBneHY8fD7RT1A5BP92F6Ur2R4x34jzS+QPgfSGRN/5VIpcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MBf1WXQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOBlAd/K; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MBf1WXQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOBlAd/K"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D52CE1D006D7;
	Wed,  8 Oct 2025 00:26:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 00:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759897595; x=1759983995; bh=AtXgzZlHiL
	6K7tKUN3DHKnRv2BYkyG1+m8Hz4PeJNL4=; b=MBf1WXQhI+vnqbCVgQRitLmZoP
	hsNzYetG0+cefEcht8zIYgkbq4CK+8L73GeRSlcgttWLKFcFyXOPldPlkC48YFz4
	gLv1KFHzpuAB9LAqFvBOxuvwdU9xErUbmbngRnH4YtkOvTElBpG6NHu0OcRCVwkg
	JdwZsyF6/tzdmcKFlsolPgNB9Imw572nWGhDhwx45gSvxO91llnjRqXyWjpZSU6N
	ZL/E3Buhg6KMoZb77jPmgX7PNkrZne77VFcmVLmtFZCcl+NCoow0atmlxnSbQjdU
	VDFCd99LqM1fyhg8TK8LfuUINhqKD9n5ABn1N/vQLPBQusO2NDEhe7J6LhFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759897595; x=1759983995; bh=AtXgzZlHiL6K7tKUN3DHKnRv2BYkyG1+m8H
	z4PeJNL4=; b=nOBlAd/Kt+QZTloEVEVto4Cd+xI5QCqrbefi64u9j+7zcev9eR2
	Qc0iVFK15B2QIfVMf7k1U+ywdq5Bl0hlta1b8tFziEsCRjFLOIT1c29BQ+wVimik
	WRQrjagQAZk4XPSy3JisEQhV/xEQ3PX7hJvyt+itukFK3F/LsYQOmde8nt1z8RM7
	hxv53Oo6/88N+KiC98kUEsw+vWcFdY1CAt3iB4FK0EmCjAp5HxGpYXdFrSbtQPnu
	TMJA85lfYbH/+blNJwys1Ya5K9n+ueX7MIMITIMECGJv/catfSrC9yZ7v9XxKiGS
	t8imHuM5bbbfbIP5KdxXiTX8zPKrEQujgUg==
X-ME-Sender: <xms:--flaFdnWzrSZQJPVFydeuT5XcYov_Tqde_VwrDjPE7tqqwCDJG3Xw>
    <xme:--flaG5raKVInFDx5w1CXRH0MzBG9SRiZXPfRKTUwCXebPhWef-E7weoXH0JDXduf
    e1apWqRpc8RDmSDy56Y8fQ8oJYOPYEBMKcdmACvCiRcVnyqTq9l>
X-ME-Received: <xmr:--flaIXsJfRI-mWRF1ra2ySSfUw0w_h-a2pCu8aOm_YnsN7eKL1wW7qwj3a1G8JQAjXKrnNU43E1yGT_ShdjTacFONT4Bu8Y2Y9zKEvt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:--flaF6iLksgHRgQiBLqQHcc51mEN02ZjRJ52Ku5KF38NJPkpvMCyA>
    <xmx:--flaDpl2YEacJQn_cgFwyauGT8aG881mqWa0R4GItLoCqwVwT26pw>
    <xmx:--flaIlUKscxZ1TnWzTXbnwNfVGFD_lRxY-gZ_mFLAFK9iQRPKFT7w>
    <xmx:--flaPOKTZ-Ro2LIgoq6stHCzAZLM5S8xCG608qH7MXkpScv7yzR1A>
    <xmx:--flaB7DNT_1BtGqB8B0vA9R2PYTX8ZrihEjNCa6aNAIk5Nu3mmgiilj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 00:26:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5577ba8f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 04:26:33 +0000 (UTC)
Date: Wed, 8 Oct 2025 06:26:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 27/49] builtin/repack.c: rename various pack_geometry
 functions
Message-ID: <aOXn9Vd6t_xOjWpQ@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <dd67366476172eb1b5b0d2bb2a4dfe92b96b83ba.1759097191.git.me@ttaylorr.com>
 <aNsUnfRPi8cYwGkm@pks.im>
 <aOV6SaGhyHYsU3Bu@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOV6SaGhyHYsU3Bu@nand.local>

On Tue, Oct 07, 2025 at 04:38:33PM -0400, Taylor Blau wrote:
> On Tue, Sep 30, 2025 at 01:22:05AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 28, 2025 at 06:08:54PM -0400, Taylor Blau wrote:
> > > diff --git a/builtin/repack.c b/builtin/repack.c
> > > index 18c3df7200..2ce1ae3364 100644
> > > --- a/builtin/repack.c
> > > +++ b/builtin/repack.c
> > > @@ -332,7 +332,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
> > >  	strbuf_release(&buf);
> > >  }
> > >
> > > -static void free_pack_geometry(struct pack_geometry *geometry)
> > > +static void pack_geometry_release(struct pack_geometry *geometry)
> > >  {
> > >  	if (!geometry)
> > >  		return;
> >
> > Okay, this function also gets adjusted for the new naming schema we have
> > around free/release. Good, but it might be worth it to point it out in
> > the commit message.
> 
> I wrote the commit message to be generic to cover "various pack_geometry
> functions". Did you want me to be more specific about which functions
> were renamed?

Not in general, no. But I felt that this method here was somewhat
special because we not only rename to have `pack_geometry_` as prefix,
but also to use the correct verb.

Patrick
