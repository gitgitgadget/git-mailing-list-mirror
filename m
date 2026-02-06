Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEA283FC8
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392376; cv=none; b=d7UqZ6qLkdOcS2vPeL6CAlcOuut/ZvtPicDZs3Jr2XwXb1jYErKIxq22Qh0x1heO5aqTTYt6W9cCeMDst+zVsCZQHwxDQWeYi8JD/+OMjMBu7ibCoj9xNzWg8bplcbifUSGnHpKxmL1fSmQFEuaoZ7lwa0NedYDJKhoM4gXu9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392376; c=relaxed/simple;
	bh=8pk0p09b0tPlH4mJ2bepO/0XLMUKlMH5cqTJ3oHk7bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjQ9b41LuGuKVLPG8bWP0nnaov1SHUXMEybWycGGHMr435ZI9lxuuPugFxP4LjCMZTjOxbHs38towORqoWhMBKUC31OMF0/9TYEv0xuCBcyrDLCybG0XSGD4ABLqmzZr3d6LL/bSkmk9Shqywoh/8xuyxLl1aCYMugjLe/qr2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gSCJwFIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OoUrQl5Z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gSCJwFIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OoUrQl5Z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CA5F31D00082;
	Fri,  6 Feb 2026 10:39:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Feb 2026 10:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770392375; x=1770478775; bh=BUyOP0MwMl
	rQNXUmZHkqHeLgucJGoT3OW9xxnL6Vc6w=; b=gSCJwFIlrt4naelg6zTp5ypTqP
	N1ewwvawScI8XiL3eR5kFgq7I3Hn4h43NcZRg90FMWaD5ReOFunHCsaTwzrG29qv
	ULSP4M5RiNHTW6utaWEVqRqYdCCOpENgjKeXK5uubNcYksHgZ+SaL4oFDQaztaOz
	y9fRH4TZVD80uMCp3sbyah8FE0lXLXTBC/+oxXDF0rxaOxMnoe8OtuQbSJq4pBR7
	6BbL6D66gDYkQnD2l2OTsw8M1CWOadEk7do6YM7WJ7A5O4yjCrFmvwuye2pXDC/I
	8TYxR9lAdqn/n0FLwyeyfDvsbi0yHM6Etb47aYlb042brdPxs3W69vE/eCnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770392375; x=1770478775; bh=BUyOP0MwMlrQNXUmZHkqHeLgucJGoT3OW9x
	xnL6Vc6w=; b=OoUrQl5ZIq3M3DyQroNj+eksgAPu4wTtEC93leMqyuxiC7EI/lB
	lI9hQv82SnP0yeXgsNGPmzEZYGOqnABzxbM3YIZm2i+ndUJv8Jwp/MChU5G1NojU
	0kgW97p2paguLVBh1C9IzR+xzryaiRIVpqL18G+0mU6pKkvP82BcHAGmC2Q7EJbh
	2UvC5vN/29wBF4DGd3KIsJJ6Rqgvf3xNM3KXxbH+fo5UQi6AgRJtkV7oE2hXN60d
	uD0YFH5yNtrmEYbK8+vBsPvRSaVJCgcJ12XTRDmy9RQEoNPMEMpfn6dL3ZDvb+dL
	MAjGn7ZjNeqbokVgiWn8rEwDdIveP6ZNL6g==
X-ME-Sender: <xms:NwuGaX2S48yhgdpKwkNtiZt_E-6BgQFwy4HMuzi1i8Dg_YpoDj-kMg>
    <xme:NwuGadFt7IbVBSJVdXLNo02id3ZkPaLYVyF8SLZq045HBzhJHGVWu0DPH09G9_qm4
    Uw28UDt5gchghPIWRY9ubLE-Tq_0xuWw5FWYWeVXoUGbSRd7QOs4A>
X-ME-Received: <xmr:NwuGac6V6sXr43zFkbqBd61-U3SzU72KJ_QgZGL6pytuSfFxOlpcDgCTLi6H-nltZ9SBYm4n5r7RtxyOh09tbPoc4VDIRADzCPGBprjIX7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeute
    ffudfgheetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:NwuGabvqgJ4sHQOpMeMnoPKAy0-8mVGrUNkqD40ke-dreMcUT8hyuQ>
    <xmx:NwuGaV4pbYvLNfERGZtLQyCzty1pHF6uZ1ZGqWxMnk2RJTmiA7uV0A>
    <xmx:NwuGaeVe42VuW-ZneinoBUWC7sIMvcS0551w-XFSq3kcNG9NlavjJA>
    <xmx:NwuGaf84GEKGqZ9jPLr5M5_vwE7ClOksBfJCJCo9XgWb6Znn5dsrvA>
    <xmx:NwuGaY5HTivwGNiQdKEcCOjGaFJyGmCvzkTAyVHZ4BTVKllXUjviTuhW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 10:39:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7134e1ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 15:39:32 +0000 (UTC)
Date: Fri, 6 Feb 2026 16:39:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
Message-ID: <aYYLLI2Gb7YlBtKt@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
 <20260205093748.GA2177239@coredump.intra.peff.net>
 <aYSFGG7lCg6Sw8vy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYSFGG7lCg6Sw8vy@pks.im>

On Thu, Feb 05, 2026 at 12:55:04PM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 05, 2026 at 04:37:48AM -0500, Jeff King wrote:
> > On Wed, Feb 04, 2026 at 09:38:11AM +0100, Patrick Steinhardt wrote:
> > 
> > > Wire up both gitk and git-gui in Meson as subprojects. These two
> > > programs should be the last missing pieces for feature compatibility
> > > with our Makefile for distributors.
> > > 
> > > Note that Meson expects subprojects to live in the "subprojects/"
> > > directory. Create symlinks to fulfill this requirement.
> > 
> > The GitHub Actions win+Meson job fails for 'jch' with:
> > 
> >   Project name: gitk
> >   Project version: undefined
> >   Program sh found: YES (C:\Program Files\Git\bin\sh.EXE)
> >   Program wish found: YES (C:\Program Files\Git\mingw64\bin\wish.EXE)
> >   Program chmod found: YES (C:\Program Files\Git\usr\bin\chmod.EXE)
> >   Program mv found: YES (C:\Program Files\Git\usr\bin\mv.EXE)
> >   Program sed found: YES (C:\Program Files\Git\usr\bin\sed.EXE)
> >   Program msgfmt found: NO
> > 
> >   subprojects\gitk\meson.build:28:3: ERROR: Program 'msgfmt' not found or not executable
> > 
> > I didn't investigate, but presumably it is related to this topic.
> 
> Oh, indeed. It seems like the logic to handle a missing msgfmt
> executable already exists, but that I forgot to mark the executable as
> optional itself. So we need the below patch to fix this.
> 
> The nice thing is that this verifies that things actually work with the
> symlink on Windows :)
> 
> I've created https://github.com/j6t/gitk/pull/37 to fix the issue,
> thanks!

The fix has been merged upstream. I've created [1] to verify that the CI
now succeeds.

Junio, I'm not really sure how to proceed here, as I cannot send the
subtree merge via mail to the best of my knowledge. Shall I instead send
a new version that just includes the upstream commit, or will you handle
the update?

Thanks!

Patrick

[1]: https://github.com/git/git/pull/2190
