Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4319F40D
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179817; cv=none; b=Q4pdYG9dgOBbolNgKhXv8UWXN9KswZFf+ptCMhJ5KGSpNmA20c2hZvxhD+G5MRDGIt/mCbvNXi7FOUHAhUjmRHIo6M4fA/IAWDLrJuCSzjpO57pLTfmmQk3D6xiDyivJP3gg3pBBSIm0bnDwP0H5p9FFtagsf5+/3ybkpDz7o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179817; c=relaxed/simple;
	bh=Sp4ZFME+ygEdrVeau9t4WrZZqmNw3HQJ6WL4mBGo6xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEMA9vaPnFTtVvYKDFwihMlm4ECfizsQpWQNS+Go/lfFEuEHRt7aLW+ohisTQPdgnvCCAl6QOhc6d4go3sfLkqGyLvOSGUFtqKLWIp3sisw3r/HECO3q8SzIKAwmCzP0V7BSm5oHqI5IiScL4Tj9adq29hNB3Y3z5YzYJsRmIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dfoYL5Ye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p8ZSMdQA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dfoYL5Ye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8ZSMdQA"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 31CAE1380481;
	Tue, 24 Sep 2024 08:10:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 24 Sep 2024 08:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727179813;
	 x=1727266213; bh=ncoa7B4G9QQEIzJzzsno+JDhDtdaznkUlgfAZmS3W9w=; b=
	dfoYL5YeF67lZRuhawH57x15ITmMNkevbUvlHmKyCuupW3N7v9BDrjQLnn63prHP
	+eJNddkePZNE3eHyQK9VTB5KJE12vhDrKhG/EcmnZaNvvv3oePCr9E3tfymTF733
	UJ+t5pKhvaCrn56mDIt55Y+yMK1yZarkjFVKluRGIA7f5UcFf752A6YwoogFFQ8t
	czr433Ts2DFu6ZcKJss1MHbxiKXc2HqA6nwJXEr4toODVifR1l8As1vBhpY7dUla
	pj8gEc19qHULXMxNYNuMvVfe1eQK4GOs0oeMwUErLD+2KJauAF3B2feVgcjrPjYo
	ANZ0zQt4NkCOU38vMkurUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727179813; x=
	1727266213; bh=ncoa7B4G9QQEIzJzzsno+JDhDtdaznkUlgfAZmS3W9w=; b=p
	8ZSMdQAdp1NDgPBMaiAhwkpHsU68KSoHPRR20CiajZbquCqhBaHixtygpdoZYJNH
	lBqf58bvZvEdTkX0AV8gZKJaK/w5BnptvMpaIFsFtLApxoBoQcD+/O8qfjDLVIX4
	X1kGLy0+0JrxZm9E0yvTgI/cguevuAyYiPTjI6IeUWeLN6NVvSFk259zXIPRK4AG
	tThbwoEX6Wniq36/wMVPOzT+wko3JBLpfPY6rXrUvgeKt7WtNzTEoNMaSLKoGWyx
	PDbmuUGgkZZoEOypL/LlltV1fIm42RM67P3HtTzA6saVChazS3u5XmjvQ6yMcqa4
	mP21mC9I10yHncLyRKN8w==
X-ME-Sender: <xms:JKzyZgg_oHRx2anaRh7exTex5FnCRFTUvF4WObvswF3qIAWWev7rrg>
    <xme:JKzyZpAiMvSSJAzqOLRPuNnGuwp_scUfqemNydpPnVs-0kgeVvoRz7Z7-bCuygyge
    UY957m3h9vj1pXtHg>
X-ME-Received: <xmr:JKzyZoFvhrhvMF0wjyDe0AuE5ogao0eggslBThyizY5NWVpJ60MfvsDlXPBu0Y1tJIwXHa_t_QCNALmTdCkr5RaWUpjXpeyLwYElIBHZMz0VEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtohephhgvnhhrihhkrdhhohhlshhtsehouhhtlhhoohhkrdgtohhmpdhrtghpthht
    ohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:JazyZhTMOkdWD8ieYbCDXhWBFgr-ag4vZEkJ-38gVThwgt_31eLbKQ>
    <xmx:JazyZtygFt48hWG5Pq5ZcxuR-WaTsrCbXD0DXYchtHrUgRQstfre4Q>
    <xmx:JazyZv7B3nfbfPJ_JEtPhHl7iYxmVAw1GFboUgEQM5OeFDYJwldq3A>
    <xmx:JazyZqxe6Lhzy2JtpsPLa8fp0tB-eeuSfUXIyh9_m4MfyDkqjg4XFA>
    <xmx:JazyZsxwqQCHVhURkt1tyBGIl82mWZqTdoVU4zrBjwXPmhzADmaB-U4W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 08:10:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aea7800e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 12:09:35 +0000 (UTC)
Date: Tue, 24 Sep 2024 14:10:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZvKsH1Ct-YwBPA_f@pks.im>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
 <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
 <xmqqy13oa8oe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy13oa8oe.fsf@gitster.g>

On Wed, Sep 18, 2024 at 03:39:13PM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > We seem to get fairly regular bug reports about the configure script,
> > presumably because most contributors are using the Makefile. It would
> > certainly be nice if we could get the CMake support into a state where
> > we could consider dropping the configure script.
> 
> While I would agree that two is better than having to support three
> build procedures, I am not sure how improvement of CMake support
> needs to be a prerequisite for removal of autoconf.

I'm mostly coming from the angle that autoconf is likely used by systems
that are not perfectly supported by our current, static configuration. I
don't want to make the life of such system integrators harder by having
to figure out what kind of arcane functions they have to set manually
now to make things build on their platform again.

I'm not really sure whether distros _do_ actually use autoconf. Checking
a few distros:

  - Arch doesn't.
  - Cygwin uses autoconf.
  - Debian doesn't.
  - FreeBSD uses autoconf.
  - Gentoo doesn't.
  - NixOS uses autoconf.
  - OpenBSD uses autoconf.
  - Ubuntu doesn't.

So basically, we'd be making the life harder of anybody who doesn't
conform to the "standard" way of doing things in Linux, which I think is
not exactly a nice thing to do.

And that's why I think we should have an alternative way to configure
and build Git that can act as a replacement for autoconf, with my vote
going to either CMake or Meson. They are a proper replacement for
autoconf that makes the downstream maintainer's jobs easier while also
bringing additional features to the table that we don't currently have.

Eli makes a couple of good remarks in [1] about things that both CMake
and Meson bring to the table in addition to that, while also mentioning
some of the benefits of Meson over CMake.

I would be okay to make Git work with such a build system myself. The
current CMake build instructions can be used to _build_ Git, but AFAIU
they cannot yet run the Git test suite. Dscho pointed me to a couple of
patches from Ævar that work into this direction, and I'd be happy to
revive them. I'd also be okay with picking Meson over CMake if that is
what people want. But my ultimate goal would then be that we have at
least one CI job build and test against such a build system and give it
the "official blessing" as an alternative way to build Git.

[1]: <0864bd25-d5c4-45ac-a59e-e6f7d24002de@gentoo.org>

Patrick
