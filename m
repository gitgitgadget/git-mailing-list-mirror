Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77001A08A6
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677341; cv=none; b=d1FIKIiLjWMdYyQVloWr+5a5VzKjGGUXCS8xcr5HBq95Fa1DeivFtNhA7Mvs4gWTYUAPRgzuALkb7iymeD6du5hyhi+LDVNnS+8X9nDXKiw48Zw0habkZH5uMRmhtuhiLiM1C8yOxxhodgSc8QglVQakcCAcQ48NdUf4S3OCHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677341; c=relaxed/simple;
	bh=CP2ifTWMgu4l7Djzke5J8tIY290xb6jyPeb/0Mqk6Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtaSBrpKN8fe2Z7rBS3AWEfWJS4sN88Napfivm1kGqMGQ1pbIqGb2snvz7FCLMcvaX8gEkMdVaY9hO/AynSN8FdwU6QuR3bCE29fvr67q56lRrjv/QzyCP5rYTsVS0o5xCUASrX2wWRF0YtyrKZ/FL3lzMXu1uMhBECJstaOxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wDYU3cDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgdFL/8O; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wDYU3cDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgdFL/8O"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A141D1380766;
	Wed, 23 Oct 2024 05:55:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 23 Oct 2024 05:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677338; x=1729763738; bh=lSfglfIek2
	rYAgIWYjPrZBpPBeal/5vgkfzMdrl8zXY=; b=wDYU3cDZQsy/mrULIFe86x9C5B
	SWShCHPJZt/8lJwvYt2bTw+2a8iBj+4taWBSj9JgSAyxYZj0C3JNqBc3D7dwtnZV
	t4/rQNmrGKU2To8yffI8tq04qWzhHNXiCh4XVtlJ0YThoxoWGULGu6Lesj8lML18
	jzdJQD9D4dZZlp/ujx8R0eLcPn7UEol5popqxLJiouxPI+kagvoMDFky0WY6BXqw
	jMld+DbGy7MqZvGgGXYKXuzzjGjM3+waB5lmrQCinyV4FI25bU+b9T97WaMkGgsX
	ZLRMykiSHQuehmu5pbwBl1fKCx6UZFQWhSPZ0P9o4Yz9PY3iPNQBUze0VGjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677338; x=1729763738; bh=lSfglfIek2rYAgIWYjPrZBpPBeal
	/5vgkfzMdrl8zXY=; b=SgdFL/8OwfrfY6tR79n/nhVv1dcmgc+q/oa4ULSNGDEF
	RZOKR0kgGxOFcslw5P7gFWgqJx7ti5zixb1TIgwa1tOJ3wgIOSbC1HWmupzyQGfJ
	Ehe7B21zjwcmjtyf81aq3W2OyLcAdE08y9BDJnE46/IT7Z/SgpKX/K6zqvHip9DG
	6e9eX0JkjCKcVt4BoyA4nbPfO0qqef624TDc35rcuBdIDIYCuuMTVw4usTPsCXc8
	pUags2Xclblm06nWPq4MTxYxIl8Et2hrsLNb2JC1wAaJPoBlMIpwDQOy/eZBQsuw
	Lmb9P9IlQ0SfPY3syASXWZ/SC+8uiHWzgAvuDZY7dA==
X-ME-Sender: <xms:GcgYZ3yCGTd-G3zEkAk8aXtRFf0wbbqJkLGy70U_DFnAppX9XZ65cQ>
    <xme:GcgYZ_QSXnupM5_FLoOE8LbP9tw9p4gnbIYWBvsk8N5pEFb-6i4eZhXYsqP20Rdx-
    rgX0CKj0sQAiuBO-w>
X-ME-Received: <xmr:GcgYZxWiZRSIjQPbpPfFibdnmNkFekMorB3LDXEayKlRtgHtlNgqQTMS3Pc-2Pv8ve9fUZWN31DpTIVy2vyYAPMOddl5c2V9VN8VcRC0Z4zh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:GcgYZxhNJOWwlj5DC6LKhR3UtPtBoA3f7-iFiVO6lEHxuH-dWD3exQ>
    <xmx:GcgYZ5AnHEwS-dpbXk3PeFxh7KXsRThaiDI2BvXFsw5YYLpfNyNCrg>
    <xmx:GcgYZ6LULo3k2oYmL2wtQE9mkJgmpB3TH_oCtCoam2BUsIerXVxyeQ>
    <xmx:GcgYZ4Cm7yMAu0xH_xriFxclzW3GYiYfyruW4R1BL-o1R4A59xmScg>
    <xmx:GsgYZ86ybXGo_T_KGyamXaBpor9ctzkDB8YsBh8kUlx270XqhLKlfi2K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:55:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b02185d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:01 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:55:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
Message-ID: <ZxjIC5W4HprJqUxB@pks.im>
References: <20241019163439.274656-1-kuforiji98@gmail.com>
 <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
 <ZxZDFyKxTn_D7c3o@pks.im>
 <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>
 <ZxaySpwA7jg7c1aw@nand.local>
 <CAGedMtea3_65wuOc1c548TC1x=ThirB1gC8p6kTomwWf_VzDng@mail.gmail.com>
 <ZxiC06eY4mMh1Xun@pks.im>
 <CAGedMtdN8qRRALiYdCFso90ExGEm0zirnpLXuva_bc8ehsK+Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtdN8qRRALiYdCFso90ExGEm0zirnpLXuva_bc8ehsK+Xw@mail.gmail.com>

On Wed, Oct 23, 2024 at 08:24:18AM +0100, Seyi Chamber wrote:
> On Wed, 23 Oct 2024 at 06:00, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Oct 22, 2024 at 06:11:17PM +0100, Seyi Chamber wrote:
> > > On Mon, 21 Oct 2024 at 20:58, Taylor Blau <me@ttaylorr.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2024 at 06:17:06PM +0100, Seyi Chamber wrote:
> > > > > Yay!
> > > > >
> > > > > Thank you for the feedback @Patrick Steinhardt @Kristoffer Haugsbakk
> > > >
> > > > Thanks, all. Let's start merging this one down.
> > > >
> > > > Thanks,
> > > > Taylor
> > >
> > > Thanks, Taylor!
> > >
> > > I've also discovered that the test script t9101-git-svn-props.sh also
> > > requires the same update done in this patch.
> > > Is this test script currently being worked on? @Patrick Steinhardt
> >
> > Not that I'd know of. I typically double check via lore by searching for
> > the relevant subsystem [1]. This only surfaces your mail and the Meson
> > patch series, so at least nobody else has communicated intent to work on
> > it.
> >
> > Patrick
> >
> > [1]: https://lore.kernel.org/git/?q=t9101
> 
> Thanks, Patrick.
> 
> In the future, would you prefer I still run it by you before working
> on a test script,
> or should I apply the same strategy you mentioned in your reply?

There's no need to run it by anybody, so please feel free to use the
same strategy.

Patrick
