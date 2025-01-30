Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAD3E499
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738220774; cv=none; b=WHvg1llaYkAfEox72iqSSrfVIyzU/ym9cjB/N4PGwcvFJauXjsFATlHac2zOo0nR+PlbM2KLODWhzy0jTqy9QAUDqYVx7G4w6VY7A2q29N4zGCPydApXXQcyOW0hETltIahsBgniRrsfIUGlh8+m+s/YO2V4DD2KjejEleRFfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738220774; c=relaxed/simple;
	bh=aESRZeyKekaapWATyEOvjdysi51+wbQV5UogDHeBFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyqCukPZrDqovWG3aqdZ4yEQwCBQej577BNq64GfWxJDR3OPLFLtwsQezxevAfGza/sfabBRhrY9FTop+kJvtv1VNgdWoktm0A26kCkjbqnVeVPy0ob2mTXGpSDadaHx3H0uDDMPGNV3a6Ow56gyZESbDbkLuMbC0O/GigD0qyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nEglzisi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K07gPGOJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nEglzisi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K07gPGOJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E45D2114011B;
	Thu, 30 Jan 2025 02:06:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jan 2025 02:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738220770; x=1738307170; bh=DKEkoZS+e4
	JIXoxWeGJjzZHavJ0cl3gCEmrEF8+3RXk=; b=nEglzisiX54wp8tXIE5pgaP+je
	OEdILxWAKcFl6Nd3hj7NWHuBgQCooRa/4bpamWhzjM8/Q8uGu93TE/1ZbwpkuTKe
	yPIHHGn5zSnCHK/RHL158vrluLFRrtp/+Dx8WkRWtZ/WF38chv9ybFAnZa2N6dHQ
	Q2wwqfP1lB7Pxna4o5l3RCtz3C5nFUPUv56MZxaGwdelzT4osgk67jrn4o8+gDXG
	qCXJt21AZrVvDTbMtIlaESOmt4sjpYbb24cVYwW+bxvgF0RKIP5y80iZmvDBDOdy
	hnYLyJzPltPBKtMOn0zmpQ+I3LzqLChsnf0gdt6YejL+kkgR/gpz0rFOfXmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738220770; x=1738307170; bh=DKEkoZS+e4JIXoxWeGJjzZHavJ0cl3gCEmr
	EF8+3RXk=; b=K07gPGOJUew64YsUEH4KvSEyC6XkyFcev68/Wwoi6nbKZ3CGr4E
	P2eCbutnSwGV13AQodqoM6a3nVh1iQj7Bv3xwK/8JICk/qOBITRwL+7iDGt0+qjH
	cyROyekD8FPILqTSXz2IAXBM2Ogd1QeqC+FxVXZZvMVwYGeMEXvcaQAxCd96MuUn
	LQyimwrzJBMr6RmSskQ/MOELCkJOI4VC8yGYPycatR7LqVp6DHpuWTjD+Nbc8tER
	PdPgQ8w5K1NUQMBCXWVqGn9JzCVw2IjWeyBNwxgOKHVZcQ1U7keXpGRdpzn/ocCM
	zdOKzqgAgthq+AVWTeuqIhRSfhU9pWj3aUg==
X-ME-Sender: <xms:4iSbZ1C5Y0YDhPyNsGeIK9qfQ5XFW500ABu7fev4Yrs-MJoR25BOYA>
    <xme:4iSbZzjjqQ5XgZ9VNjW7FQtNn6RnukGLmg1r-od8Z4C06bm-qxIuDURXKFDchQaXM
    nPWKkuEb-2fhm1lqg>
X-ME-Received: <xmr:4iSbZwlnet-ZynJD9VCANmhWA4mt8Qe-JF1WcDXh3DmsQSYir5zWd6phc3MdXj_Co4gXDxU4XLMc3IdfABqPQrWq7NFr5Rw6QtlCsreibsaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4iSbZ_xg3y7RDVvWdIE8PWU9_MK0faggOsICUATRbTOKlCW-zjelDQ>
    <xmx:4iSbZ6R30tK6yDZxAH_bImDFfGsb3l6JK4nOkU9sWhPL9Tj_g58agw>
    <xmx:4iSbZyblMN-kuKtzBjy1JBZglW0AY1pWiLlWGIxIzoYyyui3K0fD3A>
    <xmx:4iSbZ7RGV5tqNh5G-n6PPzr8mXFEKv7h3dGplqa1u71RXDbDVDQ2Ug>
    <xmx:4iSbZ1dV78hcKKPOxuQXWNikshO6drOxml5hEcg7YfZqcelT3vRPFq2G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 02:06:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e37d4250 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 07:06:07 +0000 (UTC)
Date: Thu, 30 Jan 2025 08:06:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/11] meson: simplify setup of PATH environment variable
Message-ID: <Z5sk2bbyou4Wslgu@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
 <20250129-b4-pks-meson-improvements-v1-8-ab709f0be12c@pks.im>
 <ujdktdisdk56ow3f2uudfgyh4lkya372wennuh7xsurbmylkgx@gh6p3l5hx3nf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ujdktdisdk56ow3f2uudfgyh4lkya372wennuh7xsurbmylkgx@gh6p3l5hx3nf>

On Wed, Jan 29, 2025 at 02:42:07PM -0600, Justin Tobler wrote:
> On 25/01/29 08:12AM, Patrick Steinhardt wrote:
> >  script_environment = environment()
> > -foreach tool : ['cat', 'grep', 'sed']
> > -  program = find_program(tool, dirs: program_path)
> > -  script_environment.prepend('PATH', fs.parent(program.full_path()))
> > +foreach program : [cat, cygpath, diff, git, grep, sed, shell, tar]
> > +  if program.found()
> > +    script_environment.prepend('PATH', fs.parent(program.full_path()))
> > +  endif
> 
> It looks like cygpath, diff, shell, and tar were previously not being
> appended to the path environment. With this change now they are.

You know, I think I've been approaching this from the wrong angle. It's
not like we need to add these tools to PATH in case they have been found
via the usual PATH lookup: Meson knows to remember PATH just fine, so
the scripts would be able to find them anyway.

The actual issue is that we sometimes end up looking up programs via
something else but PATH, namely on Windows, where we may instead look up
programs via the Git for Windows installation. So the proper way to
handle this is to add these system-specific paths to PATH, not every
single binary's parent directory.

Will adapt, thanks for making me rethink.

Patrick
