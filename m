Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7241E9B35
	for <git@vger.kernel.org>; Mon, 19 May 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681727; cv=none; b=Zi6rFOpLqyaPKFpn1mCXYKGFDyOmX00LT15NPqm3m7MGb1ZTVb2rjJRGKaK4YaO+HOw1eGDjVKawo2x3cZUEHRZOX7QtMayXxxmKbgS/U6maXrFhOe7cNEdhLR4jbrjD1og2VmvKGyHc8fcTlkilPPbCkotaKSGNHhYgM4Rt0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681727; c=relaxed/simple;
	bh=J61a3zitKLM/onPGZJbl8/JVuqnZGHxxdTaJoxU6u7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upZMaZdySVOW2hgnqbFhZglR829sKsPbfiYSRoDGSb/WLvWaBSWfzwOCxCAQW/n9ZNeJayhv6PhU1F66a9uFAp0JOH4F8BjHeLu0Ool/q9pjBWEz67mePZEQeiad0BvNsNEoZNfZ1KMCyXBCw0F6o53/F0u1lI8XAkRYGFosXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1QvbAYbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S0EopS3w; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1QvbAYbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0EopS3w"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 69101114016B;
	Mon, 19 May 2025 15:08:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 19 May 2025 15:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747681722; x=1747768122; bh=nKbPwv05/O
	m/xlBI15Kpl14jpUEfhfatEKdzkCAAjP8=; b=1QvbAYbYCwTw1kq+4UpERH3IOx
	jKkBPUiopTilLVQr21+07rnq78QmwIbCseKXkxaBVse9QjBDaSRCcyUL0TZB3uuX
	+3iKE6joqHmbKUZ6b8JEoWt7AMy8isyDtjUELA6TeZCXb1ma8OtS+Yxo+UexCd9F
	AeVPvIUbhf7k6qFEXARJCMZi6+I3xa3HqIVMIgFWSQD663ZKVsxFVK0g0Vo4Ldry
	uhXFde9cK7nkloKBZDIt8K1TEN5HwtRTWLNgjlxoDByLlzDv/4N7fmcnNIA5lWQh
	cAmLQLa4wbfjYZQkUokBmSuWKzGq9AxqPHXoNJvVzIS4J7G43vIEtrKuHDjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747681722; x=1747768122; bh=nKbPwv05/Om/xlBI15Kpl14jpUEfhfatEKd
	zkCAAjP8=; b=S0EopS3wviLp3SOlA3cU2GNdd/09QAjCS8H/N8/PcLiPk6M0nv2
	Sm94VRICLWQ9HIhx01KVyq4KEh3Unt8TKkOOFDxFeLDTsjDrdZ94abFko0UOHelj
	R9ow2CTMntBkpRIG1FtWvKV3M6YGw9taHUWVhqDpmaK4EyYQOZCUNH/ekmXFWgFK
	Oczrs7tFthkMcgsfsBJ9yyWYeHjv4g4PTPOfFkYsMmRf26I9INh7tTIRADEMx2Iw
	4McxGUmSSshjXl4kjjQrmU72z6pVwFuWOxTRYZD8ZqFMtR+DGrPl9Mbta2a0xyax
	Xn++Fz0OiSsEtnm3kh7al/8BL9rNMEGZ2pg==
X-ME-Sender: <xms:uYEraJB_zi0x5_JJgt5GMEfK2K7j2W_Z8BHoORJtJ6pnG0hGqfpsiQ>
    <xme:uYEraHjMPcg4DsM-05uTXRARoCg72ExEwvpPLRjJi3tvdLkLqeEVLqkD0Wj45HPhu
    77C-4tRYAlsmXhEgw>
X-ME-Received: <xmr:uYEraEk3BE5lGmHLjeKAyOlmRx6Yh5hRZnbwW-zo5GzDxBDWMdJU1y4AcCUGUnK939fXLLRSNbDlNISnf7j-Olc9HjLzt7yaPyPX9Xojwcxx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghonhhguggrnhhhqhig
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhord
    horhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uYEraDyMpotPrP02SmOMUe8CyZ6qHCf_PJelBraw03A3EEDYBjHaVQ>
    <xmx:uYEraORhe6MkinkddN6hmAvntfRyKP8LJv4ouQOWLccj6wiyAcBQdQ>
    <xmx:uYEraGYikuwPS07EYirDrqKTZfkg9rvmh3uElXZtK1j-oRnhw-uBWQ>
    <xmx:uYEraPTaxaEpLMFqdmphn5nMvVxQDvEkv7UMU4ZSrU36xVAomJEDyg>
    <xmx:uoEraMDBO_Pg9VpHfzkMh9VWxpnclUGni0oaJuboZSrY0ns2TI-n3CCv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 15:08:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c32a266d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 19:08:37 +0000 (UTC)
Date: Mon, 19 May 2025 21:08:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Subject: Re: [PATCH v4 0/5] miscellaneous build mods (part 2)
Message-ID: <aCuBtP8-NmB0lKo-@pks.im>
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
 <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
 <xmqqo6vomo7y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6vomo7y.fsf@gitster.g>

On Mon, May 19, 2025 at 11:48:01AM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Again, I did a test merge to master@cb96e1697a, next@a128411c76
> > and seen@df1b4f9cf9. The conflict which showed up in v1 against
> > the 'seen' branch now appears in the 'master' branch and has the
> > same resolution as v1.
> 
> Thanks.
> 
> > A range-diff against v3 is given below.
> >
> > [+] https://lore.kernel.org/git/aCrekcz6onTFgEWw@pks.im/
> >
> > Changes in v3:
> >
> > Patch #3 changed as a result of Patrick's review [*]:
> >
> >  - use the '/' magic string operator when setting the
> >    ETC_GIT{CONFIG,ATTRIBUTES} build options.
> >  - add the default values to the 'description' fields
> >    for the 'gitconfig' and 'gitattributes' option
> >    definitions
> >
> > Also, Junio, the range-diff below shows the typo fixup, but
> > you should find that it doesn't show for you this time. ;)
> 
> OK.  And changes in v4 are just that two redundant comments in the
> option definitions are removed, which makes sense looking at the
> discussion from the sidelines.
> 
> Will queue.  Are we done with this series by now?

Yup, the range diff looks as expected, so this is ready to go from my
point of view. Thanks!

Patrick
