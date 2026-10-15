Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F836A370
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056679; cv=none; b=u5Kg7xSxGAFO2boYHc9rRByYD/OVchzZw4Q+7HdccrZ2mMZYTXpAm1rXPV46r0+tlgPEv0BnApD3iCnXzlBnsAuWWgRciplacUqLEmTGWvnTVBTc03trw3Cumd6vovsflNCt49qpo8wr74M9br/Qt+ScrIuHV5lg3BirI2Okut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056679; c=relaxed/simple;
	bh=pGOrbjHNo1uKz2hKidkAy+7PUmuxdV6LSi88TOK/q/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icot9JYVTuIfGPKjXk3oBZpdBBdg8QoV//A+NRoH+X18fmx/xBaGM4OX06u6/WKMsLgzoIsydh6F96k6H/8U7/IF2ia6VEiTgf5WxY5IVm2Pc/tB+W0S9+h2bh13plBZgXZDVmqjcehMDaVS9aweASNFaJd8A5LLQytU2KzEA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VnwDT7Mh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cyX1btA3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VnwDT7Mh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyX1btA3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7A057A0149
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:31:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792056671; x=1792143071; bh=n/4OLMWoFB
	VFAAexIk8SllgIbKQJanIlnue3TN1f2DE=; b=VnwDT7Mh6UzTboC9XMHv/9KpWo
	tD7uqg7/3yw7FRRCMjYb6laRTjOKh7uWExxN7RePTyjbB5TLU/qh7+6yhli25MeU
	uipQ6UIGPg1RansWfEu+ojf0xkEtF1S5NAPvbdUXtqGblEdDDYW8QSMktkhJ7ksP
	hwOt4mGwUTcPvQY+P5nlrfAJu9548QdROnQzhFoi4ebK/FuBZnsHWNMOb79/XF+L
	zmtFqnpCtumhex3jaeQGwln/AOGtbc2fdH8erH0upASjuel0NeTBaZn1Z1umCnQw
	xGr4NKTFVKw0cqHAjuE68dc+bAbJ+hCLlZH3NZtnxi7b26qirAJQiY/RsbJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792056671; x=1792143071; bh=n/4OLMWoFBVFAAexIk8SllgIbKQJanIlnue
	3TN1f2DE=; b=cyX1btA3eXCHxdTFNYlDhZqtEleZPzC5fUBplOiEeoov/fGqw2V
	8JMCmY6uRqlh+hfUW7/+rt3drAHITJgaFAo72sC6d6aMhzAf73q29bQASou0HveJ
	GlGc18fIqBY9YnHw9Wsse5oCizDGGrNvNjnlf9X4KKML82B5at7z6IMEEow22cRj
	ZAqiIiFrDLz9y2M/3Qg/AnfuE0AAcZ0NmIULQr/Imqm1O4Bl6HCxAo4xh/LuxfJb
	47z0px76z3aIOlZeLbd5gVhodOZz7WecICG6/eEEgKieYXlE0cFIx2+LrKzQKUVT
	K+vZrMcnXrJoLzjUBgy7jwKMCetXP6C78ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792056671; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:azdJXrr39fv3EE8lQKTFTruXe5ZVbqJ5FBp6Aza4CJ6NDcM
	W8/s96mceNRG9umrXcHFua1unxXSYSuq0xLf4XOMLtnpHUB4MV9MaPXB/U1lwZU+
	w4BrAtuOUsBmxfP5iMzsPvP45utp8H2oxslJubtK7OxBSEx6ZFsYJwyVlcdF+9J+
	tOEcf6D/nCDl8vXi2DSp6lnCCQk7/2I2PFkBe/CRr5cDu1+mBBy4heLOtE1yk/Gh
	FdebgIfpEGA3i226ocRK23nm/MzT3ZPai0xI1TYOAYbjFZ+wv6AcniivR6kZhNTW
	AhMiGCUcXaE+ctR/HDlCyiYcsEEcgxVvN/yAsBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AcsSGT775PNkHbN+KfbaCG/ja9lX3x2bcodW4yINQjs=:pGOrbjHNo1uKz2hKidkAy+7PUmuxdV6LSi88TOK/q/E=;
X-ME-Sender: <xms:X53QagGk79Pi-xaJW49hP4JqnMmx5UbPRVMAWXjid0t7vnFo6d-W9A>
    <xme:X53QatD7vpAnkjx9J4jv1vEkSUTub_sivn_bsgqXJspJ8fTGrX3JJI9o6sRG995jW
    AukQvf96jxD7tTYUT6BLKzx3rML5PY46IwUDIUPFPkAwmVqCm1_Rko>
X-ME-Received: <xmr:X53Qaj9yEQQ1WWif23Eh76-0d7LX7ij35eO9By0rajSXP8wxgWOE8aXnzXL39WI-qmhKkuw>
X-ME-Proxy-Cause: dmFkZTEv0KufCanDZUAcKXZ9swopVEQPrg9mEbBrd9MbE1Jda4kTv2Xo6rwQZwdxzw2uh2
    a+6JahP0hhwdy2TfLDyPSTKaIqCCFoztP1SSg60tkXZL9Y2fOlBOxO4WKB/J/DS48xX/kb
    QWOPDBXhSl7YX0GERM5JF1GP3sCGGhOVN6V3Kp167QmdVrUW5FsdDgSg1QgvXyg2/PuPeN
    GHH2Q6F0ORfIttfunkmiwjQbaK4Wdc9Hu9ZFHIA6rYCtTM1d043tHE0NzNRHQn0GBbtPu3
    ZBMeBqwrm5CrBiJ7h7XpUPuOjJmaL8K+tgo/AOALJNfJo2DJC6ahnuvNQH+D2mNi0fJyLS
    ypnojOIkCDr9xnNPwDGdNH47Ldz8AhA6L+KIUzoaSYmgBLCU+WeaZ5uHqTm+58uBzMEaCJ
    wHiMRTSKYk2abuAMs8QImu6l+N0aKwDNAXOMze8Y4yzy0YxBOLbhCDwWKZKeAh0qcjHkUo
    JolDtEe0fk5/Y6b4boQU+iWU0KSiziR/OA+46cEquKceElFql3Df0RGYaksLssrNXjCpUD
    1XBVpjr0OsAEKsdwl6jil/elf5vR/8Ulf8WnztXhCTSX1oSn3x7O/9cZe1szz+4ZUhTvvP
    jpS5Bv/raWYL4TJg5zMrPDx8GoahelLYIP/jqQIBszk51SREPhY3t3hKrP+g
X-ME-Proxy: <xmx:X53QapCuE0CuRn-Ibc4SRCcc_V1wpi0Oux1mU11SZfjvO1KaToKYJQ>
    <xmx:X53QaoSCbCozw5GVrfUEkx4kgwTTvfOYJs_wZA7K36drVtkfyMGMHQ>
    <xmx:X53QagtJVuau_AA7IETwv8i7NecXJxcPjS1a6p54vhE_4MWBT2kQRg>
    <xmx:X53Qak1yiYbgwm2D5x5gtCEY6HxrLp5XRUi-fT0N5WmIEUWXY9ITGw>
    <xmx:X53Qam1Qey_HzCbphKuKLK2I4xwJpIFV6FAt7rpdxfNIymEJwTyHGmIG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 05:31:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3851ac22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 09:31:07 +0000 (UTC)
Date: Thu, 15 Oct 2026 11:31:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 3/8] ci: drop unused "linux-clang" logic
Message-ID: <atCdWdE74-4K5aWc@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
 <20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
 <e6550ed3-351c-451e-8740-f9f449e98402@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6550ed3-351c-451e-8740-f9f449e98402@gmail.com>

On Thu, Oct 15, 2026 at 02:06:30PM +0530, Kaartic Sivaraam wrote:
> On 10/15/26 12:27, Patrick Steinhardt wrote:
> > In d88d727143 (ci: drop linux-clang job, 2023-06-01) we have dropped the
> > "linux-clang" job because another job already uses Clang anyway. But we
> > forgot to also drop the logic in "ci/run-build-and-tests.sh", so we now
> > have some unused logic in there.
> > 
> > Drop it.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >   ci/run-build-and-tests.sh | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index bc5058c917..23e87cbbd6 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -37,10 +37,6 @@ linux-TEST-vars)
> >   	export GIT_TEST_CHECKOUT_WORKERS=2
> >   	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
> >   	;;
> > -linux-clang)
> > -	export NO_RUST=UnfortunatelyYes
> > -	export GIT_TEST_DEFAULT_HASH=sha1
> > -	;;
> 
> I know we're removing this only because we lost the job already 3 years ago.
> I just wanted to check a bit more on seeing the job had a NO_RUST flag on.
> 
> On some digging, it seems that 32d5b90590 (Enable Rust by default,
> 2026-04-09) flipped Rust flags of CI jobs and retained NO_RUST only for this
> job and the linux-musl-meson jobs. That means, we've been having the NO_RUST
> flag on a Makefile based job that never existed in the first place which is
> a bit sad. I wonder if we need to fix the intention at least now and slip
> the NO_RUST flag into one of the other Makefile based jobs?
> linux-feature-testbed? Or have a separate job for this?
> 
> Of course, this is not really a problem with this series per se. So, we can
> handle it separately if that's preferred.

Yeah, we probably should fix this. But same as with the other things
that we could do while at it I'd prefer to do those in a subsequent
patch series.

Thanks!

Patrick
