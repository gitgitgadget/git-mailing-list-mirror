Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60034C79
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729659620; cv=none; b=X+3hbQUkPsuv1URSiP3SyGfFvLux9Vx3OEwOif7lS7AW8ePgviPpNTSK01UqwWHBNpc7t1T/5Lh7Q9y9he6FE9TThvo9V+OxmDrBw4Dp3lsgdhSmM88k6xqmjXUezBKcxGJbTXWRUCseJTraJM2tgEVG61JqU8ncZQi4qkKPE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729659620; c=relaxed/simple;
	bh=t3wtVarcYxdmDwkjGO26cdEJhxjWJctdXi7b3rQSGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t59JgpkZHeiTpx2b906TJCHyelNASzj3zPwRse1/lOjZX4gpgVTLCsBqxm1gZYpUza8jnjBWQJA+kxxSoxjl2T10er78t2ugJDzXfrYFc/bILf+RngNa2GSNqx/6Ic8famGccEvCPfteClQLB1wqBHImOg0vCrOK/vGL0kCyOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KKmx2XQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFHcreoF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KKmx2XQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFHcreoF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC091114018F;
	Wed, 23 Oct 2024 01:00:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 23 Oct 2024 01:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729659615; x=1729746015; bh=HU+hSIBJcZ
	Dp+/kGFviQbWzTmo0q+V27ACgVcucTtuQ=; b=KKmx2XQEL/ZngAIZyeJ5FIuH6M
	Cl/DS5hjMY/k485CslZ2EOtVHvuAKyVa5AbFSYGlSfj+hLauyQdpD4bJQl7avyPh
	N3zXLI/gB3t05Clejg4gwJxCOrF3UkPPtSNj9wFr8oeqhvvEP55AvwHtI3F9DC4W
	Xn/wWqLlnv+OyUV7Lq9wSA3SJ2Jf8uzJ4uI1c73ftsVJ/jCFq4J7Nej+/SShRbUP
	N88B7A/3PpynAXyHX+9o7XsOCuwCnYNalUwrqVKbdV9OrsdjpD4Q5jLtAaYoKQb2
	DDQ5z2R+91pBjroNvkRITRw66eh4KF7nH5z2IKRNGjXtJSrFd3LU1/yGGsrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729659615; x=1729746015; bh=HU+hSIBJcZDp+/kGFviQbWzTmo0q
	+V27ACgVcucTtuQ=; b=lFHcreoFubKwYc8CWzRsNCryLQzAfr3Y4EcnV1msR7uT
	3MV8hDdaGPWCUbJQvRTdR43xrzL64xLp+gbLLQU+kZN76kkfM5OoDUqzeEl39WfF
	2bJXrD0W4pyOSV44+6iZUTh2UjxWGARYWzjH4eiS5f/j9feILahYE9qdK5tpDieu
	gV/8mctcRQlkNh/6EjJucjYMEiw/Q/SEuU77EM9TbLmRgGAirYdWobLLyrRGTVH2
	XK1/GmLOS8ssY3jIW+zbdcT1njErhKq2ulsJKnEhnQDx7Es3m38SFXC8+dhO5ETn
	q/Cwj1b63uRpKipji9m7AUuHg7FgVjcV9Jsdee6RWw==
X-ME-Sender: <xms:3oIYZ0e3-0u2sSsLYEkWBLtYgUfiCA_yvtDLMGxLizYHddzUY-Pk_w>
    <xme:3oIYZ2PvQFA2DGYLOS7n2w9mekh6ai8uJPyF2g4nKDsRMSFp5mOSoV1HQRgZLAf-x
    AGBvt3AyPpcrJ5NIw>
X-ME-Received: <xmr:3oIYZ1g3XQPcSCW_vGti5ff72S8FEe_uN4UQ3SvFGcshL-36LGcLQvC4H3OZbYtz2RkdKv6uNusns6E10jOXaT6WvscmDEXI0l56ZQJRqb7p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeiiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:3oIYZ58MbcgZt0PB3fP6zv-Rdo4KObOoWX7buRg_hnTJ1Yhxusdn1Q>
    <xmx:3oIYZwv-nBBQOr-BLZomG2QVv-dR2N7PGiBNMFXRu8H9sOP6Fzpo_A>
    <xmx:3oIYZwGpIFzKNdDbdrDqphHLWutTUkoNQefOTteC8pQJ39e8uCggcA>
    <xmx:3oIYZ_NsSK9HrpcfHQGa1-o2lsX3eGFKyUipSopQ70KB1Y_u0C8Qbw>
    <xmx:34IYZ6ULgHt-9w6iYOQWH-hiqkLgW-zFbCj1K7RSZhOBU5bB55ycho8W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 01:00:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00cb4741 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 04:58:39 +0000 (UTC)
Date: Wed, 23 Oct 2024 07:00:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
Message-ID: <ZxiC06eY4mMh1Xun@pks.im>
References: <20241019163439.274656-1-kuforiji98@gmail.com>
 <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
 <ZxZDFyKxTn_D7c3o@pks.im>
 <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>
 <ZxaySpwA7jg7c1aw@nand.local>
 <CAGedMtea3_65wuOc1c548TC1x=ThirB1gC8p6kTomwWf_VzDng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtea3_65wuOc1c548TC1x=ThirB1gC8p6kTomwWf_VzDng@mail.gmail.com>

On Tue, Oct 22, 2024 at 06:11:17PM +0100, Seyi Chamber wrote:
> On Mon, 21 Oct 2024 at 20:58, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 06:17:06PM +0100, Seyi Chamber wrote:
> > > Yay!
> > >
> > > Thank you for the feedback @Patrick Steinhardt @Kristoffer Haugsbakk
> >
> > Thanks, all. Let's start merging this one down.
> >
> > Thanks,
> > Taylor
> 
> Thanks, Taylor!
> 
> I've also discovered that the test script t9101-git-svn-props.sh also
> requires the same update done in this patch.
> Is this test script currently being worked on? @Patrick Steinhardt

Not that I'd know of. I typically double check via lore by searching for
the relevant subsystem [1]. This only surfaces your mail and the Meson
patch series, so at least nobody else has communicated intent to work on
it.

Patrick

[1]: https://lore.kernel.org/git/?q=t9101
