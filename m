Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53F1E47BE
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503256; cv=none; b=YS6VwS+5VHKF8bHlBCjFmaJQDiQ7HFPTXq4kOfgXCkupma4LFm3CTZZ/MC4Hdhr5ZtPhaOdAgXA9DCO5PNTLVwRLG+oSONwEawY9cg61qStL86bXC71vYtQZq9eMqAtoC8wA8blgRkU1txiYDZIq8a589nu3Ly0kOgD6Zrv5P5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503256; c=relaxed/simple;
	bh=6GMJSwVmR4ri5qNuRg7HUrpmVg2CW+sgQJ9GkNh97E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcdFUPmubk53khoC7DR5vsXwLxVkPcKEsgMQR0mwu+cEspcnjoa5KLjujHszW5FV7XXiwM8C/DWsZWXKFHaGSV/E0xEsG9A84btznSq5oyzxKAGZNupVYjoylzM+3y2QQ/sTUrRSbA7fuGHJ4fGj2hVjfi48QlRRXB0bYEgxxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NUjY2YlY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kMKoi1yt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NUjY2YlY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kMKoi1yt"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 56802138027C;
	Mon, 21 Oct 2024 05:34:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 21 Oct 2024 05:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729503253;
	 x=1729589653; bh=x5Ska6owkBaQftIhxxOhoIfgocirptjOnh4tOxIqNr0=; b=
	NUjY2YlYMLGgGJ1qz1Vmso2usQJxSu6TdPtynQID9jJI0zXT4/B+sYCgfgGKzd7g
	R0AWNoi/IHNfi50zAaF1x3uFAQdTMS1ytPH15WHfXAkOH3rc/maBLmWnpaSomu+d
	3fRgWOZEmPK4S3wnHydmhTK69CfAeZyIosyRQgfJXxzecpdItwwAvWw/PM7/QtqN
	OxRhsJK+NsjwyKqzCMM+1VC8oqXInJRP4Qdt7OPPkR5Sua/RbyHrEaSwbPcAlK3U
	zy7ZM5lCIKXvrOfgFkDaU8HSshv+5/ER59EYl77AOxpIxapGrazRO7lCCvDg8h0I
	AOBN6spVHjHwaBVQkcURnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729503253; x=
	1729589653; bh=x5Ska6owkBaQftIhxxOhoIfgocirptjOnh4tOxIqNr0=; b=k
	MKoi1ytFq+Dgm6cuCT1wjRgXi087TCV9sPgIB2DwpV3rvoexRDoid09zoOLQvutp
	4C7zAPbAXUk18sq2FhuUFBu56dFfV27p3yWfi4O+bHq/2CCILBJyt2mQKrrg2k56
	sLUUKjVgbqho3ZT+gUm1Izj6kmzKfd99XFmU+zQM7gh8vCGBPbMtwtxDI0enrrEB
	GZE10NHUg4gsBFRpOvOOYaSf8Mg3P7cR9qsrAQVR3bdLPwLfqqQlmvHUzGBXUKME
	AC2GfwbOqg8MCfz/6gZ4qHHHLlyP8Efg79g/mafbMta+hQUYiSQJB2mkmjZujbK2
	GNp5AlNqbVKCAn6WXGrqQ==
X-ME-Sender: <xms:FSAWZ6mSzoS1zNQJl5BYKIPP6EZjFbvycDK2QItx6jZlp5yDuSu2Kg>
    <xme:FSAWZx1kei1p50_Fe9AD3tE1pj6GVNmingm7W6BIOp-ViqT5AsJsbxiZsjBM2eLiK
    3gtTZRvDHwmDr71tA>
X-ME-Received: <xmr:FSAWZ4oGK7vTVhkZXI3eg402suo8dR5wevkw92ecA5mHjgUMVlyh32Ug2aRs8rod8HfhLU1mav5y-uC_m64ypb-HtMnrt5DRoQhgzN5cHSoC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteehffdvtd
    eltedtteeuueekudegteetuddtgeeuueekteehfeeuvedviedttdevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrohhirhhsvgesrgigihhomhdqnhgvthifohhrkhhsrdhorhhg
X-ME-Proxy: <xmx:FSAWZ-kwTVFD7P48N9d9TOE1QgG_vKaFrbdScPNNKxFCYCi1se4KAQ>
    <xmx:FSAWZ43t3li8Gm72iD1fiM3gCr651TLxztkuuREqT4NE0U-xdjLR1A>
    <xmx:FSAWZ1tvOuW8beFnOaQ2BgT2fV2oDQYwYp_uicksgFgwgZ9BnBQtww>
    <xmx:FSAWZ0W9bh6z1AGVnvdyDEZ2zM_ZiXdfp00zvdXG-8ajLqmk-IXFLw>
    <xmx:FSAWZ2A_c4-6MWS6mUwutrPyaw-Qo5cW9tBD9zYpsfC3WHVfrjjekHVb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:34:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7ddfea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:32:43 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:34:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Freya Starshade <saoirse@axiom-networks.org>
Cc: git@vger.kernel.org
Subject: [Resend] Re: Git build failure: v2.47.0 on Solaris 10 SPARC64
Message-ID: <ZxYgDu2vt-qDqmqr@pks.im>
References: <db95aa3f-f270-4939-ba3f-a964d46e2325@axiom-networks.org>
 <ZxYXNTjRYkVaQaOl@pks.im>
 <966457d3-c6f6-4028-bd28-da73a0296679@axiom-networks.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <966457d3-c6f6-4028-bd28-da73a0296679@axiom-networks.org>

[Re-sending as I've noticed that the mailing list was dropped.]

On Mon, Oct 21, 2024 at 02:08:50AM -0700, Freya Starshade wrote:

Please note that we tend to not top-post on this mailing list :)

> On 10/21/2024 01:56, Patrick Steinhardt wrote:
> > On Sun, Oct 20, 2024 at 10:56:11PM -0700, Freya Starshade wrote:
> > > Hi,
> > > 
> > > 
> > > Reporting a build failure on version 2.47.0 of git, grabbed from the
> > > official sources. Our environment is:
> > > 
> > > 
> > > Compiler: gcc (GCC) 9.5.0
> > > 
> > > Linker: GNU ld (GNU Binutils) 2.43
> > > 
> > > Target machine triplet: SPARC64-SUN-SOLARIS2.10
> > > 
> > > Target machine hardware: Sun Blade 150 UltraSPARC IIe workstation
> > > 
> > > Target OS: SunOS 5.10 Generic_150400-59 sparc SUNW,Sun-Blade-100 Solaris Sun
> > > Microsystems SunOS 5.10 Generic_150400-59 PATCH January 2018
> > > 
> > > After running ./configure, which succeeds, running `make all` gives:
> > > 
> > > 
> > > root@iris:/usr/src/depot/progress/git-2.47.0# make all
> > >      CC daemon.o
> > > In file included from daemon.c:3:
> > > git-compat-util.h:1012:13: error: conflicting types for 'inet_ntop'
> > >   1012 | const char *inet_ntop(int af, const void *src, char *dst, size_t
> > > size);
> > >        |             ^~~~~~~~~
> > > In file included from git-compat-util.h:314,
> > >                   from daemon.c:3:
> > > /usr/include/arpa/inet.h:68:20: note: previous declaration of 'inet_ntop'
> > > was here
> > >     68 | extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
> > >        |                    ^~~~~~~~~
> > > make: *** [Makefile:2795: daemon.o] Error 1
> > > root@iris:/usr/src/depot/progress/git-2.47.0#
> > > 
> > > 
> > > Anyone know what's going on here?
> > Could you maybe also send the output of `./configure`? We do have a
> > check in "configure.ac" that tries to find out whether your system has
> > `inet_ntop()` or not. Maybe it is misdetecting the availability of that
> > function on your platform and thus declares the `NO_INET_NTOP` variable,
> > which causes us to pull in compat code.
> > 
> > Out of curiosity, did you try running `make` without first running
> > `./configure`? Many platforms should work alright without having to run
> > autoconf first, but given that your platform is a more on the esoteric
> > side I wouldn't be surprised if things didn't work there.

[snip]
> checking for inet_ntop... no
> checking for inet_ntop in -lresolv... no
> checking for inet_pton... no
> checking for inet_pton in -lresolv... no

So yes, indeed, your `inet_ntop()` isn't detected. Does that function
require any additional libraries on your platform? Searching for this on
the internet quickly brings me to... a [thread] from our own mailing
list. Looks like that patch never landed.

[thread]: https://lore.kernel.org/git/CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com/

Patrick
