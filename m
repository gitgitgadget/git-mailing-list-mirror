Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7DA30E824
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492507; cv=none; b=rl2ca59HflRgELXSo5eskM/pAcEyqyfV5YemoVKPU3okVMvCOTyBO+SFdYvr3xnEEZE6Nn3z4xRNaODnUuEq1vBeegD/QqiKgcUBknc2IfgwBDaboHatD3Cu74tylpbtLtJap5WcGW2mrhyKH3H8zUPIIcn73CdJ+jnv25a3Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492507; c=relaxed/simple;
	bh=xiG4cA9gbf2NOsWLpdYVwrQbZMWwqPTjMoJb+gI6tc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAi/qV8a0b+3VjXfKjwG74rkPb+smHprX6qZCdmyjAbPi9alTUH9GiR44/62S+pUSiQOzE5DESB9nurThgyhDSx7DEWjsplKyVOnbKzuiRj59QrDOsvw5LjSyV/Zx3zj6TWchv7nhyZpslE9tFg3yhrv9fPIIQFHl3dcmkoCyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hTuh+Ki5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkTdj8E4; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hTuh+Ki5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkTdj8E4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FCEC1D00238;
	Wed, 10 Sep 2025 04:21:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 04:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757492503;
	 x=1757578903; bh=piXN4QGIKptkpAP/EGQSW8PghGY2+YwtX0QSEyJaRyI=; b=
	hTuh+Ki5Rklj0F3Jjxl5gQlqLqlNSGyBIqVVEKfmRRI/NfLLMZAaAmT+fLjEqpaR
	rU+T8rUdI9ZwdqQoJGnVDrkKHjmpdIShN0OzAPyjIgloahEeX05/xr714CjdV6iB
	F0Reb4CaRKVTFqy6wLXk4pDqcqdYRawkSxzV6/TC8sHpmtzIr4Whj/lxDdDsmf0Q
	0LzEWviHluQHatkJSeXNj6PFGdxpABeq7o2jBV1nct1GnJTgRYVvEqIU5iXyS4IX
	Uq4mILpnkh2AHZWzU6ClgJhyowsMpuVsZhHZ0s/3MTLVgMVdpWtI5E4MfwZPMbi8
	yEUecbcAf09nCFSg6j51gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757492503; x=
	1757578903; bh=piXN4QGIKptkpAP/EGQSW8PghGY2+YwtX0QSEyJaRyI=; b=h
	kTdj8E4gH2pe44rUW4dmdpznoKMOFl2z3Q0VpixFrKOcHsMUG7h4auOVIspn8R6J
	Oi+KHGWDR1EnwlH+MX+tUAz6eh60f06LV69EUsB20WIE0XzuRYoiO/wRIV3QuXmW
	UyloTFpRfKz54wvVe1inPASlrb4ELe2w9aDNXrpj3VeiLNFzHLvYze6HiislSoJW
	IO/VCvN5sOG5esAeGrXjNXEzYMNMmFznG67BqOGAoUzHlatCMt+ZaLf8t0vkW8sV
	usgZnXUzUiNZ21rAz7XMMoF7HNlxGoBXY4JywpKsLEk82sQ8zhYKDk7GFoBtr5da
	fW6O8qbTfe6jon4QkayeA==
X-ME-Sender: <xms:FjXBaAJvaGkk4h20Q-voq60VTCamR9LI1pV6rKTp0XnlS4cgOS6NlQ>
    <xme:FjXBaL-v0XMyNvecQ1zZo0DsNetQbAwGitvM7DRPckxhBOo6hVv0QX22SYjshVmlu
    VakJSKg6XBoXWY6Ng>
X-ME-Received: <xmr:FjXBaHKSqHWBQ2xOuT2_N5cD-TYzB7-pjw1RIGU_b02IDR3O3AEAa4SZlfzU-0TvUXigpLTODiGK_JUi8KYZEMmkwjfSvRNw2I_o_poxpQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteehffdvtdeltedtteeuueekudegteetuddtgeeuueekteehfeeuvedviedttdevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggssedvheeisghithdrohhrgh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshgrmhesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtohhnth
    grtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgr
    nhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:FjXBaKHLm_0dj7f_BARGd5r1MZ64L8FiO1muwZ8Zt2rNJi9q3GiHiQ>
    <xmx:FjXBaLzMXn6YNi50KhGXVdUqXA0O5VLpzkqBukj3zrAfx3Y4glICtQ>
    <xmx:FjXBaD6EgSCme14cP90dllU0AvR8S8P2PxGV1z6VJ2wPPLJ1rZ4-xA>
    <xmx:FjXBaAfSrjcb1YHeqofZcyGFf-hx6pGrENAHH-zbcL2RPz_g2M3DJg>
    <xmx:FzXBaALShHm10wY-VIUuw0giuyDHLIqzmULfasNLZTQlKYhqJpU2Roh3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:21:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f24a4112 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 08:21:39 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:21:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aME1ETcGAbhoO49n@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
 <aLrzqR2Z9jz5CuJu@pks.im>
 <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com>
 <aL57ONmEKTmqFhIZ@pks.im>
 <CABPp-BEW8TYaffOED34bTy98X=CDZeA+r=X+kMR-GRwuqRDfjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEW8TYaffOED34bTy98X=CDZeA+r=X+kMR-GRwuqRDfjg@mail.gmail.com>

On Mon, Sep 08, 2025 at 11:33:45PM -0700, Elijah Newren wrote:
> On Sun, Sep 7, 2025 at 11:44 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Sat, Sep 06, 2025 at 09:31:02PM -0700, Elijah Newren wrote:
> > > On Fri, Sep 5, 2025 at 7:29 AM Patrick Steinhardt <ps@pks.im> wrote:
> [...]
> > > > I have a plan layed out in the BreakingChanges document that mentions
> > > > how I'm proposing to do the transition:
> > > >
> > > >   1. We introduce it with auto-detection for Meson and default-disabled
> > > >      for our Makefile in Git 2.52.
> > > >
> > > >   2. We enable Rust by default in case WITH_BREAKING_CHANGES is enabled
> > > >      in Git 2.53.
> > > >
> > > >   3. We always enable Rust by default in Git 2.54.
> > >
> > > I don't see how steps 1 & 2 help at all.  We now know we want to make
> > > Rust mandatory eventually, and should provide distributors and
> > > platforms as much notice as possible so they are aware.  But what
> > > you've proposed is another libgit-rs or libgit-sys -- an optional
> > > component that no one will know about unless they go looking for it.
> > > I don't see how those two steps provide any incremental help to
> > > anybody over what libgit-rs and libgit-sys have done.  From my point
> > > of view, Rust should be enabled by default in Git 2.52, with a simple
> > > knob provided to let distributors/platforms/users turn it off and
> > > build without it.
> >
> > It helps because it allows us to slowly build out the infrastructure. We
> > don't yet need answers to every question that we currently have if we
> > initially have the Rust infra default-disabled.
> 
> One of the things I find very unfortunate about this series, is we
> have a new contributor who was trying to send in patches, and instead
> of providing feedback, suggesting alternatives, or asking if he'd do
> it differently (which he actually said he was willing to do [1]), it
> sends out a competing patch series to replace his instead.  (And this
> happened shortly after someone else interjected patches because of
> interest in the first area he touched, forcing him to pivot once
> already[2].)  Further, despite him having solved how to get it running
> on all platforms we run in CI with some big help from the
> git-for-windows folks, this series discards all of that.  It lends to
> a feeling that he might be working on important and interesting
> topics, but his changes aren't welcome and it's not worth providing
> feedback for him to modify them to become so.  That's almost certainly
> not your intent, but that is the effect that sending a competing patch
> series likely is going to have.
> 
> [1] https://lore.kernel.org/git/CAH=ZcbBLAKaE733_2_2qbFTYCfwGq37RfF-Z3vaKL1ZR49msAA@mail.gmail.com/
> [2] https://lore.kernel.org/git/xmqqzfbvfxs6.fsf@gitster.g/

First to say: I'm not trying to say that his changes are not welcome
here. What I'm trying to do with my patch series is to reconcile the
different camps that we have in our project and to find a way forward so
that Ezekiels work eventually becomes unblocked.

And regarding the Windows changes: yes, I haven't picked those yet. I
wanted to first get to a minimum working proposal so that we can focus
the discussion more on the roadmap, which I think is the more important
discussion compared to the technical discussion.

As I mentioned, I do plan to implement Windows support as a next step
once we have agreed on the initial baseline.

Patrick
