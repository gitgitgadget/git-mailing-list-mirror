Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E143FD13B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461650; cv=none; b=I0Y8+mCTFwXGJekrTXTMXX/PvIZHjMSa0o2WLM7sg58S4URcrmKViLmPbmUJ3kehXJAoZAv5rzciW+QC0K/PuZDHlTd2EAq2kJcpEwpQVdN0ylKhbNdMB9ANgkpvs2JAd/OGBwbScXfMG1lS0oQUydj2jDIkoxGzN3jX5lMybrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461650; c=relaxed/simple;
	bh=cHWY8jBpxD9if2b3ZoEKe8ubvB3jKIDhu2xAK1ccA8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9EUnKbXLgJhS9rTfsNb4J2On+kTmmGFxa7ZkzVVYCDiQg9kYMis5KlUdO9X9Ug2t0eT0xt9na31+SKGwXAP47WAKXYPBprD1lB1XTEBHdYt/eCn5gwx26ok3in9WghBsSNF2ITTY+2bIDkivVrmSJbEoDk+bNDgdm4BJ1nQ6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jOcXRHoz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K81BHAnP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jOcXRHoz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K81BHAnP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E68807A013E;
	Mon,  2 Mar 2026 09:27:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 09:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772461647;
	 x=1772548047; bh=t2lS3Sw00WTZS0tNUfbLPl+XourlOJMkjnRGFkgNz70=; b=
	jOcXRHoz79iYx3k3ZMbFDVbelWAgSUU0EvnnQANjQmXGe4chjm5tMoCL+OI+cA6F
	ZlFbvaTemNT8RUSTglb3H173Tx7KUKyFdzDj+z+4MWc/Eb8iUyo4gBylHvwYzsHA
	sph1ORj0RT8vy6buBjZLkaBlj02HjITqMQT4oZGSuubxh6TZUvCRbJd9vsqBqa9t
	7PRwkeVMluy9IQLM6LlqBDq3mP2X6BHspzFaLFGVSCZovE1rIOW8b1JoqFdQ9fLL
	JwTbav8XXhT7bJ6HfBguODjTpGpOfIYWOibv3RcNEjuqJVho1A3vTeQ4Z/TwbDet
	Wv35CFbgyU7/7VdK75pPHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772461647; x=
	1772548047; bh=t2lS3Sw00WTZS0tNUfbLPl+XourlOJMkjnRGFkgNz70=; b=K
	81BHAnPcVOFFcMXkZCOZCfON4UHzxs54uqTuAhi503nlHUAxwhMt6JZdgcJ72Qrn
	R9mRRBKERrSrikJk3G6YcPZR2+7/VCY0j0N+CnoITUMiMiuM9qT/S3hI2oAxEIyh
	fhRs+oGXVUY6suA0pPiaR531H/z3VnZArD/ejYVJvJ1+GhZ8vfg0uMgRHDSTGHaz
	b222YZ1fBpZI13u8zejSqXyJu7C9SQpsR55IHCv+4J3Vci6rPCpkNBVw/1edAGlF
	r7C5pFNb2o3eaEw9m/WD26b9MtIIGkRlwZJimH+sMmSrAtAMNRuJQrMt/mfScfwl
	0CPL1v0X1efupIV23YboA==
X-ME-Sender: <xms:T56laeN1EnkRdHSNxaX5rn8VA1-ahun_SkCuxRlElfx7r4u6s8l9Qw>
    <xme:T56laS_DnYJC_D4qzl39ElSEjS0Plxe3w0dS4vRc6M4cH95ONE3cfsPoXoOvacc2B
    z1eEOG3WY5kChBgz_vCXlu0_UJK4I4Tb0H-rPH4Q8wmhoy4xDBn>
X-ME-Received: <xmr:T56laS5LJUDdxR2DCy6roIUQkTq8JpK1leyKvlWXOkzLuLzBd0VnfiF6UENI_nZ1oO2d-nwuPLY-j-4UR1uZ8lJDAibNLos2oPeNPQYHMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirg
    hnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:T56laZ2frisqGHzVM9V-TYEJ3luZxyGLFh4bcU2YRaDuVXcvjAkCKA>
    <xmx:T56laZCBQ7FIFXsNnvnyTdCww3byFwC1nsWDFB49wXQq1PiJnx8xZQ>
    <xmx:T56lab11fQ6izqedQSY9MiBPp2w08YsAbKnkY6EUXBoiKSbeWcuXCQ>
    <xmx:T56laTuiAy-nT8eNVpa5J5tFmz4byYavsuQdCcI-yEUv-0fREPOFJg>
    <xmx:T56ladjIHdoDSHEMy32bLcJUCwXPglF4OCzEahC3CTpKS411T8VhvnRM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 09:27:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8bd301b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 14:27:24 +0000 (UTC)
Date: Mon, 2 Mar 2026 15:27:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org
Subject: Re: Performance regression in "update" hooks
Message-ID: <aaWeSu-d1FMz_sW8@pks.im>
References: <aaU5lZwEuR4OrxCl@pks.im>
 <87bjh673o0.fsf@gentoo.mail-host-address-is-not-set>
 <874imy7220.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874imy7220.fsf@collabora.com>

On Mon, Mar 02, 2026 at 04:12:39PM +0200, Adrian Ratiu wrote:
> On Mon, 02 Mar 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > On Mon, 02 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> >> Hi,
> >>
> >> Bencher has alerted me that there's been two performance regressions in
> >> git-receive-pack(1) [1] and git-fetch(1) [2].
> >>
> >> The first one is quite easy to reproduce with the benchmarks at [3] and
> >> bisects to fc148b146a (receive-pack: convert update hooks to new API,
> >> 2026-01-28):
> >>
> >>   $ cd receive-refs
> >>   $ ./run --revisions /path/to/your/git/repo \
> >>       fc148b146ad41be71a7852c4867f0773cbfe1ff9~,fc148b146ad41be71a7852c4867f0773cbfe1ff9 \
> >>       --parameter-list refformat reftable \
> >>       --parameter-list refcount 10000
> >>
> >>   Benchmark 1: receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9~)
> >>     Time (mean ± σ):     182.0 ms ±   2.7 ms    [User: 91.5 ms, System: 89.3 ms]
> >>     Range (min … max):   175.8 ms … 185.0 ms    15 runs
> >>
> >>   Benchmark 2: receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9)
> >>     Time (mean ± σ):     484.6 ms ±  27.6 ms    [User: 176.2 ms, System: 376.1 ms]
> >>     Range (min … max):   406.2 ms … 495.1 ms    10 runs
> >>
> >>   Summary
> >>     receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9~) ran
> >>       2.66 ± 0.16 times faster than receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9)
> >>
> >> I've Cc'd Adrian.
> >
> > Hi Patrick,
> >
> > I looked at the commits before and after the many-refs test regression
> > and it appears the regressions started after Junio landed v2 of the
> > config series in next [1], which might cause it.
> >
> > v2 was not ready to land. I sent v3 yesterday addressing all the
> > feedback, didn't even realize v2 landed. :)
> >
> > Does the regression go away if you revert [1] ?
> >
> > I don't have the benchmark setup and it might be easier for you to
> > confirm?

All you need is a normal development infra and hyperfine. The
benchmarking scripts in the repo I linked should then "just work" with
the above invocation.

[snip]
> Actually I think these are two separate issues.
> 
> I will reproduce and look into the regression which bisected to
> c148b146a (receive-pack: convert update hooks to new API,  2026-01-28).

Perfect, thanks!

Patrick
