Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E92E8B7F
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760557; cv=none; b=KUTjzpftFknOiHjSpvBJ1LY3NVGSlvEE9nV3/V0C+9WR7wtAnXqop7MCxyunCRW1VOKswMd8kCQZXPX2OdpxkPwihJR2muacJs5yLZMlpLQ33QNEtz1avx2v8dhexB/89u93yy01H/VRwxuredZz1Qe0GPzSTFWx6xlI1CENybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760557; c=relaxed/simple;
	bh=P5u6DEtFL2xJn2avPM/iIr5vgQoRM9FJscKZvCAlvIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqT12UorG6QMJf7TwDsQpG25fwqK5JDI2J0z+/Z6lTQ+xAxpi8S2UbsF5zX8GwqMj62zMR5SDoLh+LY8/PC01qB2ZY1Zo4DnvetqIlaOpQt+eNYEMQZV2l/iMcCZwmrbhVnFF0gUt79/ojVXBBE8sbZh/eRxuq/7jycDpG1zWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MpyLQ5CX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNB/k0u0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MpyLQ5CX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNB/k0u0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D330EC0143;
	Thu, 21 Aug 2025 03:15:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 03:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755760554; x=1755846954; bh=KDMsOzHVMz
	KlKvUJSLR1E33ZWaSuRgcGslmqaiZxhh4=; b=MpyLQ5CXngNeLdLftCUK8BnfMp
	rKxhUhnYBCNqadvLDZDHj0i05gD3BiGQJzFQR7MLguzXCxvl28ePDcvN6bmGZdM4
	lijzgO7hNYIhr6fdFyRLPEttaa7D0X9W9y/3prC7Az9qS5QvmDssA+adaOtFAYR7
	6fj1SUKRUkeDi+7BtptO0K7oavFZfkWcFmfTcMEg0+GlJTygFE+XAWZupNsB1abH
	YULCOMmIalZ6Kf1lCdF1ffuqsc9DT2DSN/7X2yo9/TnkF1Bu3qvEkTYHRlNyWZTB
	TvqJ4/pxJdtw7ZG944ZtnRwVW/y9qRyjGSc7ZTRb2zlFlxvRHQ3TfUhnvDxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755760554; x=1755846954; bh=KDMsOzHVMzKlKvUJSLR1E33ZWaSuRgcGslm
	qaiZxhh4=; b=fNB/k0u0kMP650tgIrNIGNGEqKe0i4CqTVipBLVjATIuKGQ0Tyh
	8dIH4h67MNiALDHcf18o8IY4Ib1wjBH1UW0tIHGhlVBdTqL2mrEuwD2VFpGDfb/N
	jAm+XIsuxTihpUvsVkzR8RfXW2B5jd6TZMPXI4p3El2ChHJ71ZSUYoySloGQRy8w
	5V/h9Mqk/+/qa/OsnI2jtRlPBEMMeQJAQStlTa/srN2biZz3KXCQtbrPq0Dx6FKV
	b27qPFmH9T8oSTNY4t8YS/AU5qtSAFCKahYEx4C0eOW3bniLfAEJ/VSVPvVq30Gv
	KO/3yU+XGJvAMsleQK4XdHypqeLViCRkq+A==
X-ME-Sender: <xms:qcemaEI1FVeBaBo-AXlbVAgJ4JQsFz3g3zxmlLEdkL39ZSGdM2EdKA>
    <xme:qcemaOsGo-TbQFdtmnwludGGFxKe5AadeD4GVyD4moI_aRqu6vnpZ5pwz_6fvnc2T
    M1kW4A7WRBk_5Bo1Q>
X-ME-Received: <xmr:qcemaBQiZdXcjuWD7PZHPNMsTXAXG43sWJJgC0ONMYNNNxs-gNwx4bgsyL4hR21ShZsoFwj2Dm2IHrwHLNFIxuLm1UzAParWDJ-JcF7buA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjohgvrd
    gurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qcemaEOwXigoT-cI_OLyOZSpbxGlCTCmfPZDK2qbKhaUU3JsMJlngw>
    <xmx:qcemaGaMBylO2BL8k46CXc3eTzbIfKwluna8o_WZYNWBWTmh_at41g>
    <xmx:qcemaOx-TaoWORqIDZpJF5LJSaIe2XJPL9EX5MgYVfY0Msqwf4YdCg>
    <xmx:qcemaBL5w-cSWtRvGrypMw92UyEo49tKbGVPNBuV1bwdPmmm_ZTu9g>
    <xmx:qsemaLaIWsZY2AUP7vXLRx2yY5CR94CUyQ062Fl0OJ52Bg80hluy2ePP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:15:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad430075 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:15:51 +0000 (UTC)
Date: Thu, 21 Aug 2025 09:15:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Joe Drew <joe.drew@indexexchange.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <aKbHozlmDIqfgkg4@pks.im>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820213323.GA1667633@coredump.intra.peff.net>

On Wed, Aug 20, 2025 at 05:33:23PM -0400, Jeff King wrote:
> On Wed, Aug 20, 2025 at 08:54:37PM +0000, Joe Drew wrote:
> 
> > The fetch fails, returning status 255, with the below error message:
> > 
> >         remote: Enumerating objects: 18733, done.
> >         remote: Counting objects: 100% (562/562), done.
> >         remote: Compressing objects: 100% (448/448), done.
> >         remote: Total 18733 (delta 399), reused 144 (delta 112), pack-reused 18171
> >         Receiving objects: 100% (18733/18733), 25.32 MiB | 7.93 MiB/s, done.
> >         Resolving deltas: 100% (14608/14608), done.
> >         From <VALID-URL>
> > 
> >         [.... quite a number of branches and tags .....]
> > 
> >         error: cannot lock ref 'refs/heads/ptv-2164': Unable to create '/Users/joe.drew/tmp/./refs/heads/ptv-2164.lock': File exists.
> 
> > 
> >         Another git process seems to be running in this repository, e.g.
> >         an editor opened by 'git commit'. Please make sure all processes
> >         are terminated then try again. If it still fails, a git process
> >         may have crashed in this repository earlier:
> >         remove the file manually to continue.
> > 
> > This file doesn't exist; in fact, no such files exist:
> > 
> >         $ ls refs/heads
> >         $
> > 
> > However, the branch _does_ exist on the remote.
> 
> This is a wild guess, but: are there any case collisions with that
> branch name (e.g., PTV-2164 or something) in the upstream repo?
> 
> If so, and assuming you're on a case-insensitive filesystem, then the
> lock files would collide. You wouldn't see anything after the fact
> because git-fetch itself would create the colliding lockfile, and then
> clean it up after hitting the fatal error.

That's a likely failure mode indeed.

> If that is the case, you can try using the reftables backend in v2.51.0.
> It doesn't use the filesystem for its ref storage or locking. Something
> like:
> 
>   git init --bare --ref-format=reftable

Note that you can also `git clone --ref-format=reftable` directly, so
there's no need to go via git-init(1) first.

> > This error _does not_ happen in the Apple-supplied version of git:
> > `git version 2.39.5 (Apple Git-154)`, but does in 2.51.0, which I
> > installed with homebrew. (If this is a packaging error, I'll happily
> > report to homebrew.)
> 
> That is definitely weird, and not something I'd expect if it's just a
> case collision. Is it possible for you to build Git from source? If so,
> and the problem happens with your build of 2.51.0 but not v2.39.5, it
> would be very enlightening to see the results of "git bisect". We can
> provide more guidance if you need with that process.

Curious indeed. Another relevant part could be the new batched mode that
we have recently introduced in git-fetch(1). Previously we would've
updated refs one by one, and potentially that led to us writing the same
ref multiple times due to case-insensitivity? The result would be quite
broken in that case, but at least the fetch would've finished. Does make
me wonder though what subsequent fetches did, and whether we always tend
to flip-flop the value of such a ref.

But with batched transactions that's not possible anymore, as we would
indeed try to lock the same ref twice. Assuming that this really is the
case, I wonder whether we should detect this case, tell the user that
it's impossible to store all refs on their system, and then continue
regardless while ejecting that specific ref from the transaction.

Patrick
