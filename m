Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF53355803
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974114; cv=none; b=RlbchVaF82bW1I/dApMWnPbnGQU+xFOTkzOaUtpoRuJmCYq3dM4KY9/ox56NbH0DXU/xcgSxxcFCB6OVpW14OZ3IduclC6tLH00xedj9/rxDlq1oUNtJyefworBf8Cceeq64JrHnsytvX5wSpuPVavJj+8bXI1EPEdV49hQuz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974114; c=relaxed/simple;
	bh=9Y2yk7CIUUUQKIRfJrotaSkVIqbnjF9x0BuMnZmYd0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hATjG/5i3s1gVDHIxaQ/ab5DhjIn2OHH/PTPeMaFmr69Wult6Lz7CrhLsCglSQ4QPf5JitnHMPNSfroxmCzqxPbeIQTinBKMPuayku9g7TXMjxMGVWd8vAwsQRVahlPM15cNbKg2ZE7DBy5xlOwKa2tBJok/PA+kLTdZmDp6xlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eVXGEKg5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vu1siOiN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eVXGEKg5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vu1siOiN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B561D14000F7
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:35:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 06:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791974112; x=1792060512; bh=0ytVEtq7DL
	ngXUfoHAvyWsHm12CJe6Y2LBPC37uSnV4=; b=eVXGEKg5G4Q0E10PGGatDBvJpn
	f2tASGmKFOU/pw1U2F769JGnksBhPqVyXkX/ISd5NDs6ubrJebQVa7i0ygYTw1o8
	WxEqoijKps+jXdmwPMUBYPQPu8HqAWIwLp9J9d3CgJ/Ni5z9BM2BbOn7vsN3GotQ
	bro3F+e/Nd/JxBr/GbYdX34Mafj0H7znKwb2bIn+YpercEE5VZJYB4tPYC4VZP0q
	M5FhzemAml8cu/VQWOE+CORbt6clN28IrZVVwLN3dPC44Qqw6H4xJGmihhEr/IIa
	ExBcOSSEGlQaD3HFPXxSXrm8zZ+HjDQPvwTdlVH1uyLfsXmm7Vg34beFMCTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791974112; x=1792060512; bh=0ytVEtq7DLngXUfoHAvyWsHm12CJe6Y2LBP
	C37uSnV4=; b=vu1siOiNy5JUKcEfzK70nRFtgCoOBtGOuu2/f0kkm/hbol4zKQp
	qDtlDYpgEX9yQJWJawf2V3XczMkh9hIplGDLcV3mxfR2OgNgcclOeEToEb7Pietr
	PDcSbY1vO1zwN3LxlKGMZQc81qQuxr195qpn4LtkIaicmPDZM6kJbMNfKbP7+ZGA
	DwthLbiFvo4XDI66pOG7ItpGFVTrxYKDjEW+lsNnSfnAu/pPHuziaC1W5o0ruNm3
	hWQi6rP3WZkqQQRjtCK4UyuW7PMuN6fS/UmJ5Azw3mx++6OXOiYLhZkEtMpKgI2v
	npJLKnQLrd3GMgmvjrWU+rISsvSPvjfHNGA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791974112; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Skza/2Ob/3p3pqmU5mZx2FxPszfe7cscjcSiFpZD4Lh7maa
	b/bbzAdjlFUuxZOa957FgRmlEQY3KS2NENOWtDfwmJQQ8qW95SwXoFEaqOPgasUs
	1Eub0WVprl2kA7wgGR8yWsF6NYy6wAXJj/KMVir9DTcuqjtC0ealNrKcWCUdf5HQ
	T3izCcGN1DBaIOadhUzC9JI0gxuFGrmODgHT2Fprzbb1t1/Lz+yROz/pSoqD6vqF
	mUhR67cCCgad43YpkRceRcwxSyq9vzfblWHI4tsUwUJ8CdDCytRDCPRSnFrewYfe
	1OXUOb7Yjb53/2MXBsw2MpwdmkWOei2OvjDZAMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yRhOBPRrEI/+I2MxkzggoGokQaLLEf/L7HhSZ64KQ7s=:9Y2yk7CIUUUQKIRfJrotaSkVIqbnjF9x0BuMnZmYd0w=;
X-ME-Sender: <xms:4FrPat1Yiprx_yzK3yVa1TSpjYdfcg7e4UNCeIVboTp90DIvWf-i6Q>
    <xme:4FrPaq9Kp8VYRaDY4ELi7acW2gMnt4lXxMg3AQUnsrkmsA0TC7mBZyLxobPz5xW-a
    fsjkRtkeeSMuKeMLEQPKgtcCbG332tIDt-sQsewBqJvs_PGCyUDHQ>
X-ME-Received: <xmr:4FrPamOZurO-EKIsuEtsAbTW25sglesHoeSk6-igMmI5NTFJvVFnPg>
X-ME-Proxy-Cause: dmFkZTGQg0OIeA9e1/Fove3BjkdilOY6CwrQUtbN1Ssn8KGiHccJ05/D9atcSz1KDC/z2j
    bgsEv2y0SKz30AjfiAdpV4EuTZJ9NalASFnPdxBIBTbJuG0B8iv0kVdbevY1TeYxwA6Zdu
    y6OKPokgZGuBIBktnKXwdpL5Y0cqiWKGVTFQ3ge+TmsR7gYk61c5w2MaDTxtKbyjn+s9Aw
    OAkomPmVpxl/rth5BZOsGQp8mQx1Js6AwyWnT9pF1yKjLaeNizwxBctgX5cUTrIwVw3p75
    KM6HWH14r1Cd29Ybg1zpbx/OLPKQyVbI5IS1PDbMb9Q9q1kToj9QOm4FEicqboM4H1YMOB
    /cjP+C9LG/f4dd+CwpOgGhqYwVZjgyKKcWgQg4YEBtnlF8jvr8wN+JklYl08XO5zhlE5xA
    017nWT9DQWci+vUo2F8Bf47pUOkFEr3o5ho2iDjlfJC7qEmADIqC/jZDUr4CoGRuwu7SkA
    qo3kQQme56WdFgusN3l1TyB0x0/OjTcon0e5wGdsPDyQVUDd1snBEx5lOVmLL2mAHmaUW9
    MXNor+0tnknIJnYBF+/g0wfo526YRrJHTMYwRZbahlqInKQtKQmx0Ws6rJ90XdxhB2/HmT
    jWqRDtv1W2Y0Alh/8m1k0DtV3ODsqBzSB2a8ubxn+TZCsHpI8MKp2mwK52JA
X-ME-Proxy: <xmx:4FrPamdrJ_Pv-CG6WTkGTkYqQjXRQf75EwcCfj07ECNUocmN7GrQNw>
    <xmx:4FrPatUBUXysB77kdds5mKOeNyeQJXYB-ibKoPGcxTIWJdoQQbAIYA>
    <xmx:4FrPamh_eyCxNH8THIoEiye1nuuMay638Fe7EV2UkalxNATsK3l2BQ>
    <xmx:4FrPak_3JcO1Qi7FfS2VvXHzechTw3HyQ-zDqJ4cVJ0JE1pF23rzkQ>
    <xmx:4FrPag_KBe6weq1Benm3rHLN-DlMyIt9rYkHp_IuJw4sEtKwalJUz60n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 06:35:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e084184e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 10:35:10 +0000 (UTC)
Date: Wed, 14 Oct 2026 12:35:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 2/8] ci: fix "fedora-breaking-changes-meson" job
Message-ID: <as9a3E6NeR_sQeYd@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-2-04c24e1f480d@pks.im>
 <20261014091037.GB1341124@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014091037.GB1341124@coredump.intra.peff.net>

On Wed, Oct 14, 2026 at 05:10:37AM -0400, Jeff King wrote:
> On Wed, Oct 14, 2026 at 10:30:28AM +0200, Patrick Steinhardt wrote:
> 
> > The "fedora-breaking-changes-meson" job exercises Git with breaking
> > changes enabled on Fedora with Meson. There's a typo in our CI scripts
> > though, which has the effect that the build does not enable breaking
> > changes by accident.
> >
> > [...]
> >
> >  case "$jobname" in
> > -fedora-breaking-changes-musl|linux-breaking-changes)
> > +fedora-breaking-changes-meson|linux-breaking-changes)
> >  	export WITH_BREAKING_CHANGES=YesPlease
> >  	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
> >  	;;
> 
> Seems obviously correct, but I wonder if just:
> 
>   *breaking-changes*)
> 
> would fix this and prevent any issues for possible future jobs. The
> downside of a loose pattern is false matches, but it seems like a small
> risk given our universe of jobs.

In general I think the way we structure these is somewhat lackluster:

  - I never really understood the split between "ci/lib.sh" and
    "ci/run-build-and-tests.sh".

  - There is a bunch of duplication that could be avoided.

  - And your suggestion makes sense, too.

I originally carried a patch that merges all of this into "ci/lib.sh",
and it also did changes similar to what you propose. We could probably
revive that patch, but if so I'd propose to do that as a follow-up.

Patrick
