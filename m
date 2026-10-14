Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E44BF949
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976742; cv=none; b=U+gFRLfndaLqY6/EuNUXicLg7vYnUM0uRV7Om9zR9D2Nz2+0zxY9M9S3ZbJSwlI5aTobAMh/dQcz+3E2DgwL8IqFVBHjWeYo/26QLw5EAJEGaNtyscFXRzCR8E6FrEkK/DLpEBg9AaK4WI24KPX668Gdm+StOaru9RNr1ngdCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976742; c=relaxed/simple;
	bh=c/OXJ1CvC45UXRn6QPz4tC3hCIuk3Cb8DwD80lOb3LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3umOJ7Ay6VISfV8owoHNYqekFWZN6IrUmJZqmqNbm3irxlTVqNZyK7f7+hjSJszwZbIr+Wj5V4ioH5Tv5bkWAqlAECVpMZmmjUd2RZoAOUOeiFc+96+1jepKTv99ALPo28Fknb/9kdD1SssR8Lasw1IoTIUASl9fTB8dEVh+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=epD1sMZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLbozZ5E; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="epD1sMZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLbozZ5E"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B581BEC032F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:19:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 14 Oct 2026 07:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791976740; x=1792063140; bh=3YGD8CLhyH
	lbGhvCczz/DD5ykVhjcaXjzzUBRsBQabc=; b=epD1sMZObIm2iAf6l7rBgw87V2
	Nox8mb2qYVStDo9oeZXhGWgf+Lio3jYVhUJNmpaKeTyFInIEIu0bo7bi7GOZCC4F
	bspWo3kASNpUoPwhN7ChpKzGd5vdUwG8aclDPAptVU5Gx7Vw3ZVtP87GfprrlGjp
	nDqmfBf5c9SBEIF1t9qUGxcaDvx4gze0QMsjGWjtozEjIW4ftoCRh7rILPAt8S3x
	3QuHtwqwB9NzRVDnZF56whFopURtVkDJQiCDmgWo9z/ZDFEskSxMClgQB9cPMCxH
	t5FUd9Mh1x1Vu9ZyfEuXLrrBrNM/bjdtqp+IJFCce0uNlMv5V5TI06FyyoGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791976740; x=1792063140; bh=3YGD8CLhyHlbGhvCczz/DD5ykVhjcaXjzzU
	BRsBQabc=; b=lLbozZ5EiArTohDhYzu+U5YWdOv2B7Fnq91xqERBJBUghmsrkby
	/1GOFDS7qizGm2z3W4HRM448krnpGXTb+uprFcNMoahrm2UOLMaBi4XWxloWHOE3
	Feom+c/uZM86yorAHrEMhzDssqg3YPDhDgCWtQhIAI0i3CaBq7bLc3nqC+iczlgF
	sZH4Zbt7iu/T7VAwzgLpfDsAKmKzcw2B1CNrYGsO9s7Er0VOv47uuucByajBLpVJ
	2Q2zRyhObIsd7LWgBFWRPLA6Qu+vfwnza9owpmr/8aDgfBg5j7wvMMntdv4qCrl+
	A2QkGNxVkg6DsdQIOjGKhXGYro2VvI4QrCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791976740; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Wccv0/iQaMDVOHxV/3B8gw1sor6hat1kB4OGYofDAaR9J4u
	WQb+mO/OIyoX3r5neYmpQYM/SrGQ24IXr1Hq1fh5Ff7S8oiIUaOerVGyhOmGQmTq
	HrBLPhbCk+cfZB9dh+ezrUBQx2r8+LLXkuJ3RaxQdBPxHw0SmiSr402oIhT5OJwF
	v00X734jJ4EIe3C49O0m1aH+pMND3BNZo+MMDqZDhow8jJRw0wTMOiWmYNlvBeuX
	t92r06AtdkpxLN6fHpdQZkgRxV+d5CrB89xkzxWw8kvm69XK1cyV+Uc4Bg0BpwcP
	+tpY6Xo9VRpS2S4QrEia9rLvt91T35JMdgypy9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Dheogt/BQv/7HfIlNB7CFPxkdxe61ugyoNRbeVychCA=:c/OXJ1CvC45UXRn6QPz4tC3hCIuk3Cb8DwD80lOb3LU=;
X-ME-Sender: <xms:JGXPal9_l3IxPiYC4OGiPAF2oMLjZddfzXf5ddx2up_pbny_J-7HNQ>
    <xme:JGXPagl8sc_SS00DrI03ub_W-0uezjq60b7C8oWZCQy4_fgs7V289zbmLiUNeWBdW
    kEHQswXfY530l8FFEx1exRvYFXk5W_Ju50ty-jH_dTe6lIWr6bq5-c>
X-ME-Received: <xmr:JGXParV4YK1wKpdMvs9QVBUpADZeDalPN2gBNJDrbRZRVJ2YXD0-YQ>
X-ME-Proxy-Cause: dmFkZTEGVDpWiEabkUZ5hHuZ4+r1L36xmHM8vlOsVhusXoThnf40p2vOhTDEbx0q98aO8G
    7jbkl+3Q2SEIKTZSDy1hYG2tcAT2mxFqHeeGD6oOvMMrkK8g+hQEikBYUxdDLUHCyTrZDy
    FTQHwhNBZlHKEIs9uUBpCELP7AiqW8YHynaYw2dDOczf+85mGhXICSFe7ejJpw14U+whed
    ALEQ43EXSRCddr37YTsadIF4E3kogT5J+7qgWmeGV8/rjxwqffReNg/4nrHEJ+nNkMVqxg
    jk8olwwfySD+SgKFe45/ITG58C0DNOxnwpPfUtk9Ga8bdw5kjyGZ5NXvf8bFX5xFJq6CrT
    fd1+y2OFfe1ZqF+Wr3MHM+uzocQ2jJHcCuAhYuqgiyAr8yujWLajqycwS2Xlo3GDB543Iw
    X8oAk0m6FS0t8tdfMKd+Y7ZIeAl0ekTzzj3e5aXMRnrABtYdggo+bumltzVKRmmSsPFaFi
    sljgj5m/MOa0kdlA9n2dStS2LZqDkzVX86e3iklvZeDMkqhF0y+jLLSHBYBWrSKDwp3Qoc
    4BeILX8cI1jufic3S1g+miAzlXJWezw1iPmNgR6YVVKpYxaa+UXi93IOs7rnb3+woZ2YqL
    na9zNZjmknOkPqGaZa76pGej9MSjsLV2ILxmHJ2SAokBSjHoZNyam4r5TEyw
X-ME-Proxy: <xmx:JGXPalEtA0Gc8cE5ZDV2FRRF1rHZ8LN4fee0iUzlWZhYeN0zAwNbkg>
    <xmx:JGXPanfO0sIqiofrqk-O9jbkwgpQS-CUwP-7LoQmeSd0An4Xkaks8w>
    <xmx:JGXPamIs8eTCP5XObRzjk-5ZJEiOiDDR5TXjLWSIqtiGuLYN4LzCLw>
    <xmx:JGXPasE5IWVkaBot8RgMh_zQSPGdZk3n3RDJK2K4pH_ZEnI-p5_CTg>
    <xmx:JGXParl3gCmyMROp9z9KSeu_DoWTkz6X0-kxDgbxV-8biAq_NEkFLDJT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 07:18:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64a97587 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 11:18:59 +0000 (UTC)
Date: Wed, 14 Oct 2026 13:18:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 2/8] ci: fix "fedora-breaking-changes-meson" job
Message-ID: <as9lIJK2YzbWOOE8@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-2-04c24e1f480d@pks.im>
 <20261014091037.GB1341124@coredump.intra.peff.net>
 <as9a3E6NeR_sQeYd@pks.im>
 <20261014110716.GC1356555@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014110716.GC1356555@coredump.intra.peff.net>

On Wed, Oct 14, 2026 at 07:07:16AM -0400, Jeff King wrote:
> On Wed, Oct 14, 2026 at 12:35:08PM +0200, Patrick Steinhardt wrote:
> 
> > > Seems obviously correct, but I wonder if just:
> > > 
> > >   *breaking-changes*)
> > > 
> > > would fix this and prevent any issues for possible future jobs. The
> > > downside of a loose pattern is false matches, but it seems like a small
> > > risk given our universe of jobs.
> > 
> > In general I think the way we structure these is somewhat lackluster:
> > 
> >   - I never really understood the split between "ci/lib.sh" and
> >     "ci/run-build-and-tests.sh".
> > 
> >   - There is a bunch of duplication that could be avoided.
> > 
> >   - And your suggestion makes sense, too.
> 
> Yeah, I think there is a combination of organic growth and the fact that
> nobody really cares about ci unless it's failing. It is probably ripe
> for cleanup if somebody cares to spend time on it.
> 
> > I originally carried a patch that merges all of this into "ci/lib.sh",
> > and it also did changes similar to what you propose. We could probably
> > revive that patch, but if so I'd propose to do that as a follow-up.
> 
> I'm OK with doing it later. I noticed some other similar spots in the
> context while reading your patches. E.g., anything with *-sha256* could
> set the default hash, and so on. I expect you might have found them for
> your patch, too. ;)

Yes. sha256, breaking-changes, reftables, meson all fall in the same
category.

Patrick
