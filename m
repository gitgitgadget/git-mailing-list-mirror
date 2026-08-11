Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A5442FB9
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450568; cv=none; b=phjRRBAF/5gR+kEYr3D0ViEhrDA3KzGqed7vIf9qws3CzPvw2D7//2tXsTYhj0xrX1QQeznQM6Gse1G/mRFEMTZyXcsw/2BVfMeqg/McyBw7NHR188NzESr0yGrn6u+K7ULOL24ETA0lQfMpR3OxAMdlOve6xf167Da1UGsRQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450568; c=relaxed/simple;
	bh=Sj1s9IbSamzxSqGYqKYTmF6G9DAID8msgFwICtVp3tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFXdwVzBZ05w7HNMRtNIVg7OAcH1DS/68krCiaHMjSvx/WwNuBupRYbAcUn9d4aqIw6NHO3a1kgQl9D+lWP7YixxzFhHGNyDjC4+CMF6NfI/7TWIFxgWixxXTy0UFhbxlIJOzoJo/QYjNBwsbeOMne05cxX2+V0iMZZmqY9+Cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G0ksNqvL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/EbFNYo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G0ksNqvL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/EbFNYo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9116140008C;
	Tue, 11 Aug 2026 08:16:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 08:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786450565; x=1786536965; bh=uCrVIWl/y+
	IxCLsf6g8UgLb1D1SFYqgndHqohvvQ/Yg=; b=G0ksNqvLVzICwn/HslbOYstInq
	Ss7dLkYnNdqpa1X0A43ppfhWde00zrcRATUWTL2Y5nUZljMD6OM7B+Yl2bCwc8j4
	RhWP0Pkd8mA4LeHrq7yAgqwxkez7OFifHQi2fjBQ2lDv09K5czhIIr7F2ZnSi6VF
	iR1O4sPrf49PS298ZoAs/VClC7k+VgwMMdFikLwyA5x/Y4Sr8CgQPo/BVceXpilo
	p+T3EpKPpq4ERclU1eTOMjrkgrxM0M3Jaw7eX59b8hdrP2Ny0YCHpWc2KHzPxkTi
	ah6SpRFuJ3sRUeIKZxLYIkAZNHafyygef7u3f9Jb3Ne//YMHORMv9ClHHLdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786450565; x=1786536965; bh=uCrVIWl/y+IxCLsf6g8UgLb1D1SFYqgndHq
	ohvvQ/Yg=; b=Q/EbFNYoHBSRKHLAU+CyDppLruiC7BSPAPc1bx+LjOeMzI80Vby
	QxkXsEf8LYFGkFd/Xf8e9jh0e+IDWK/o/ZagN4HVGlgZUEwdGGkKUn3/jh8h0gIt
	vaVBJr83Rm9Pjzy/VQvOquWnsVYThSd6XO0s2QmtHKwpcn65oa3vMEs9GLMgmnG1
	Z4IAwAi35bM8oNdu56jYUdu/9/RAo6NIML6Clmc9lSZpwvSpTUsguBf3jhk6zwz9
	ECkiHfH/DAISwW359Cic/8ChuXL5Y6dqvm6I4A5Mt+j8BL8SjbDBx0JwgFp8AnnG
	y1Putfw1v2GQXuuxrvc36BAx21Fzw5Z0oOQ==
X-ME-Sender: <xms:hRJ7apOeJm4BPltfmr3SA4BvgkkYX1Ah5BcV9deDOinFQMx_nfPUPQ>
    <xme:hRJ7ag5M-k9KHiaooBMo8DRipl0Lew5MSRqR-dTxMMZMZDbVtcaJING8AR0Mcg08r
    clAO2XYkRhrajwn3ZEvptQH9vZwD3776sYJF-pUZA2elzJuiuBX>
X-ME-Received: <xmr:hRJ7asglT7CgPorqm4vzfuc9wz5EMG2qKx_5W-3E9NZBRGdQf0IiTfuDrhJmiYrHbF2e_Bi1ZnXB1Fmi4amqyEt-P71JKrGatx639Lzz6w>
X-ME-Proxy-Cause: dmFkZTGNZSUG8x6t9D95fk5LSwpnBJRbjlSVjjIhV5agQdPIn+S8RNV8CNlZ2dkMHPbufS
    7kjSc9RigUNZSQh3BgeoFiffXoDMX9adklSFotvS21Bia9troBC0uEGl5criU7i4QT9nmv
    dGOYK8OrkgGZu6mddzx4/EbeEGayg0lzKLyIiUYtYBmsK261pP5d5+gjVp9ggaT0+fOhRF
    zeUl0V6CwLsvL04hRTiQZpnZtPkX7rD7zXypdHdOmu1tSSGED2QDRY0DG1UT3zzpE82uwB
    0cxKbIKl2cnyD3Iq163Owx7KoLC3KXY/5bcXPtFEDv3koVgj0jT6YJNPtPNKJP4PDFALnl
    LpS5wfDFeri/LV9+YX2TU1/HK9i+aKZ0u1B+6p3p+ihLYV76m3VvRFEICIWrd21x+RcURA
    nNFvnCXfCycKWeS4NOWWSwszvBYPSNlNToqDP9MLkUL/UKNF+x8yRBeHzRXUDIkrSIFQrf
    8nPxcc9Vu++pJVISU+PDYfUqUIzomDOqRQ76xeaD6OuQcdCqpNm1z2NyjxNlVFnGMWuLv/
    v1wG0uxBum0l48s9wVWD+2vVJwVwAwuwvzV/tB8xU1geA4TYwcceA6So45N/hMrUWJG/Hu
    IVXOQh2aYzDTKZ85UOVF4JhqEgD0YNVMZN1YskZwBsHSXJo+G1Eo8/wJcBJQ
X-ME-Proxy: <xmx:hRJ7ald8poPc8uxDuUbYUEohzYin25OyDI1cW_wk3jkdd-LkLN4VGQ>
    <xmx:hRJ7akwX1HztCT55mPiu1lLri4DKlOeLO7WTvEbGesVm-0edM6o5dA>
    <xmx:hRJ7ak0aGI1TnN_Rg8Aqx7Ub-MpWHK4tTomYUNXtEtoF9K0AoCKlLg>
    <xmx:hRJ7aqyZhjNrOFqsKxVQeT4d6-iuGXxwd0LfXXyLUw-fmIRigF-JDQ>
    <xmx:hRJ7ahea14d3L0NFZHXohqLsmeO7ww3kUVV1Ou7HNQW0EQ3Q73JDwLbw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 08:16:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04a7aa88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 12:16:01 +0000 (UTC)
Date: Tue, 11 Aug 2026 14:15:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <ansSfYBPm6lZc7jB@pks.im>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
 <al6Yz_QMlyU1GETv@fruit.crustytoothpaste.net>
 <xmqqqzkx9t95.fsf@gitster.g>
 <al6yCTDjBRn2HGq0@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al6yCTDjBRn2HGq0@com-79390>

On Mon, Jul 20, 2026 at 06:40:57PM -0500, Taylor Blau wrote:
> On Mon, Jul 20, 2026 at 03:43:50PM -0700, Junio C Hamano wrote:
> > I do not think we want to do this in a single large change.  If we
> > were to move everything to 'lib/' only to then need to further group
> > them into subdirectories of 'lib/', it would subject us to multiple
> > rounds of disruption.  I suspect it would be far less disruptive if
> > we migrated one subsystem at a time, directly to a new directory
> > immediately below the root level.
> 
> I agree.
> 
> Though it may seem *more* disruptive to do it piecemeal instead of all
> at once, I think it would be preferable to avoid having a single
> subsystem have to move multiple times.
> 
> That said, I am not sure that I completely understand the motivation
> behind such a change to begin with. The second patch in this series
> claims that:
> 
>  - "The Git project is not exactly the easiest project to get started in
>    [...]", because in part:
> 
>  - "[..] finding your way around in our project's tree is not easy.
>    Doing a directory listing in the top-level directory will present you
>    with more than 550 files, which makes it extremely hard for a
>    newcomer to figure out what files they are even supposed to look at."
> 
> I am not sure I understand how moving ~700 some odd files into "lib" makes
> the project easier to navigate. I understand the patch's latter point
> that:

I guess the motivation is still not clear enough then. My maint intent
isn't really to make individual files in "lib/" more discoverable.
Ultimately, I agree with you that they're not really becoming magically
more discoverable themselves, except...

>  - "It is not obvious at all which files are part of "libgit.a" and
>    which files are only linked into our final executables."

... that it's becoming clearer which files are part of libgit.a and
which are not. And that to me is already a benefit by itself.

But what I care about is to make everything else more discoverable. We
have a bunch of files and directories in our toplevel that are relevant
to developers, and especially newcomers will have a hard time to even
discover them when they're looking at 561 files.

> But don't see how this distinction will help newcomers who are likely
> not yet thinking about which files are part of libgit.a and which are
> not.

They're not. But they'll care about there being a README.md,
SECURITY.md, a conde of conduct, a license, installation instructions,
build systems, and the various subdirectories that we have. All of these
files are currently getting completely drowned out by the noise.

> My other thought is that I worry that "lib" might itself be somewhat
> misleading, given that many of the files being moved are not especially
> amenable in the current form to being linked against as external
> libraries.

Fair, but they still result in "libgit.a".

Thanks!

Patrick
