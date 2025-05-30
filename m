Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78B2AE6F
	for <git@vger.kernel.org>; Fri, 30 May 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591424; cv=none; b=EFzRAv6YEgfBkjtDTRDQSFkkSv7QsR/MBV7r/SRhOlhS0w3YE+Ls+aY0bJHnXcs9D4AcQssKxAMj0kr9cRvOcdee7XoKDTTVY5Gz/38WS7Y6c+xWGMnP1C0wAzaLe9DqpbhZAzvlnr9VN3kufJDt03Wj0evvH6236a3XjhMw/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591424; c=relaxed/simple;
	bh=XP6b9o1CzbLLvmghFbaRY+RpcgIme3cayC8PeZlRbm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHLgOaFT2QTmsklVVIfv8n4MkUpbPsiFGJvsbOghe7Ouqv+wSTQ+8jhHPW+vG8xnWHuwXbR12sekOlN+4NWTyw5JkXnN+cLFoZ/6VPaaW3MvTACYTMfDcBTj7nf9iJC2H9pEFcl6zG2VEAuwOzqm1zlC+MDQFPlH7wmuDRoHFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=koc9V2Ch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZ6Ne6sX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="koc9V2Ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZ6Ne6sX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E66B13802B4;
	Fri, 30 May 2025 03:50:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 03:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748591420;
	 x=1748677820; bh=IATpRT1EZnEkRl53GF1KGqNn/KMDoAsMLqgwfcPP72k=; b=
	koc9V2ChS83iigVISpz5hSUKDTYC4aChH6bWR+WF+UQMPfDCJG4owrQ1jslBzBuH
	QnTPw4fW8dOsJ10NeS9CmIZJvZ9ElL3xawAM+fRX2yTZhQVtL1eqShtK/U5D3NRR
	ezbtzZmRYVGCNdvcx/mV03Mg6QrVfSdzxleT/7fxCNCJMeChR2CiMSXnTR+PJPsG
	LVzpRRb2dQRsS1wm8eZdMtUMaZVyydlp9gRQbxul6HGKVlXd70JR8ud+8OtkZ9kQ
	F9YpLPs/zZpJ/QtDfh40lpIOGZm4fnwPeSZT15OKcO+I/7VGKtwBUeQpPiCBky4g
	nvz9lGNIJW5UO3IzNucvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748591420; x=
	1748677820; bh=IATpRT1EZnEkRl53GF1KGqNn/KMDoAsMLqgwfcPP72k=; b=o
	Z6Ne6sX6HqtM0VL0dCyYL7+HE90eFoxzstACqlvZXvX4nSvssJHuDUAmFmstFsWm
	c9mE0i00zpMAtAWDZNhdFoP1NAqPPvLM87et01TsUB7NFHzA8IDGcFknUNRMoOof
	VFNvvYMxRgRk0wRMUQDzNcev/Lz1H63d36Rfl/N5M9ITKdRNEABWJN0jKPT/4JsT
	yyk0HYHjzmAX1nAysCPvSWpKe9knRS/FXgYbsd/f5S5fh+6+QEjvLkBaiCf1STPv
	o/68e15YTnTJftVIll8qVbUHZF8WFmG8ojI3O+Tpd/Oq596G3FdsUQwVoHJyI6Xi
	yq7U74pY+VPUXT/E6pZww==
X-ME-Sender: <xms:O2M5aN8_L7NC8BpztwNg5hqPmn_y07i3EK2DAbeMua7GKoQcqQKAww>
    <xme:O2M5aBuoCkouEkVk_Y1FFiVQTil1w_PaHplIsP_nTo_U-yjoQPfBO-9gOJ2yHrV9Q
    3n1TrNzolth2CtQyg>
X-ME-Received: <xmr:O2M5aLAt1nMB0aVfOaob-in1enDZeqTzZt9qI0i3hANdGDRsAWDMwKakwIZ-8OAyumLe6RdOoQaA7Smw6mfkh0oKRB2xXL3FMPE0BUzmzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeegheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgfdvfeeuhffhhfeh
    vdevffegtdevtdekleffhfegffejkeefvdehjedugfeiieeinecuffhomhgrihhnpegrug
    gupghfihhlvgdrfhhoohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:O2M5aBcAYcLxPR-U6iNdOjrLjNVBkpuFIMQNcaFo9ilmHRqEGQlvmA>
    <xmx:O2M5aCN42SyauQJLpludDL_PYH7uDFnVHeTJXkxQVW53kxXgmvpdBQ>
    <xmx:O2M5aDk1shVLWBUY5QhnnjgGdDFhy8xUDohpRWSEpVpLpIMC-ReXpA>
    <xmx:O2M5aMtw20lFMd1Yn19RfjE86BzEC3By2mrjA1OYH9IeHKjiLub5-Q>
    <xmx:PGM5aNi4HrVVkU-LXQDv5dF0k3WvcVf1Am7TKIOtTnQdudqJwG3aErnT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 03:50:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c33e959 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 07:50:16 +0000 (UTC)
Date: Fri, 30 May 2025 09:50:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 1/6] t: fix cases where output breaks TAP format
Message-ID: <aDljM5Ev-JEMBaaG@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
 <20250527-pks-meson-tap-v2-1-ae360f77786e@pks.im>
 <CAPig+cSYhY+LQ5pD+a1O16Rxwo_js45WqfcW8wtC2daYmNyMCQ@mail.gmail.com>
 <aDcx4dXe12tRUyYd@pks.im>
 <CAPig+cR+eham=uSamUFmTuWDhZ6_r3dnMm1z+X25aw2K6maN7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR+eham=uSamUFmTuWDhZ6_r3dnMm1z+X25aw2K6maN7w@mail.gmail.com>

On Wed, May 28, 2025 at 04:14:17PM -0400, Eric Sunshine wrote:
> On Wed, May 28, 2025 at 11:55 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, May 27, 2025 at 03:47:16PM -0400, Eric Sunshine wrote:
> > > On Tue, May 27, 2025 at 10:03 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> > > > @@ -48,7 +48,7 @@ commit_file () {
> > > > -test_create_repo sm1 &&
> > > > +test_create_repo sm1 >/dev/null &&
> > > >  add_file . foo >/dev/null
> > > >
> > > >  head1=$(add_file sm1 foo1 foo2)
> > >
> > > Unlike the case with t1007, in which the entire script needs an
> > > overhaul, it is much easier to fix the problems in this script without
> > > papering over them via ">/dev/null". In particular, it would be
> > > preferable to resolve the issue by wrapping test_expect_success around
> > > the code which currently resides outside of any test. So, for example,
> > > the above could become:
> > >
> > >     test_expect_success 'setup submodule 1' '
> > >         test_create_repo sm1 &&
> > >         add_file . foo &&
> > >         head1=$(add_file sm1 foo1 foo2) &&
> > >         fullhead1=$(cd sm1; git rev-parse --verify HEAD)
> > >     '
> >
> > Yes, it isn't particularly hard. But it does result in a bunch of
> > shuffling that makes the patch way harder to read.
> 
> I'm not sure why such a change would require shuffling code around (or
> perhaps I misunderstand the idea you are trying to convey). Unlike
> t1007 which needs a major overhaul, each block of code which currently
> exists outside of test_expect_success in this script can simply be
> wrapped in test_expect_success (with a distinct "setup whatever"
> title) in situ without shuffling the code around. Yes, such changes
> would be noisy, but it would be very localized noise in each case,
> thus not particularly difficult to review.
> 
> As such, since such a fix is so simple (even if a bit noisy) I'd
> rather see it done properly rather than merely papering over the
> problem. However, I'm just one reviewer; others, including yourself,
> may feel differently.

I was mostly shying away from this because it's hard to argue why I'm
doing these cleanups in one test file, but not in others. And the
reindents to make the diff way noisier. Anyway, I've split up this
commit into multiple now and did some more refactorings to make this a
bit more palatable.

I'll send the revised version to the mailing list later today.

Thanks!

Patrick
