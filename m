Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43426346E58
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976737; cv=none; b=TvSogeakv8nrPTWifxfZDkUY3ok46SSUSiJuzfJkr24xGFi0PUn9cgn54wgAGGVO3DjYVtvISQ1kwGpKEzWmcVJX9NcYZ+zUcbN/AKqcQBj4CCp8oEWCcrVgju2jJgm+RqQn7VF+vmFjtxntVgOdorXxwea9oRI+EIJlE5kksck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976737; c=relaxed/simple;
	bh=YAzCt5iUahbK3ItIKpfZycglWc4JnPt0Gqb/Kgx9z8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDMAKtXPdLZdq8fZbn8Az/3tZxs7q2GfAkoaiLxKpTQKO/i7IsONKI5BEZsLKgqlgwGPXYimI+o7CCm2aoAHahH5YEAHbEkwFvWPMPLVPgPVeiLzC4avbLCyLNRF3AhXjVar3oJpb5Dyj3NmA1uZJTLsXNwKBbuIGyr5IgKfM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BmT9ChKe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RK8fwvyJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BmT9ChKe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RK8fwvyJ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D6051400104
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:18:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 14 Oct 2026 07:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791976735; x=1792063135; bh=+ZSZR7QLU1
	pat7sQHr/h17nsF6oHqFXTdTMzjBN7Fp4=; b=BmT9ChKeIIajL3V1pau5pDyEH3
	8+QnXojOW2ic5H/7hpWZpYYsLfbtQjEiwy0x0x1P5IgHwgH1Df+XBw3UOeu8elCJ
	3W0NJ4NUByf4CslqdHAK1aL5AIOTU1YqH/SW6Oz4lBjyIbjZaMqol5qrD0+W1Y9o
	6cBa9i+rUI4ilWiSQ/0I1QUl0hYzp+qWEnlbokkrqA1X63+ygV6q43JzlQ97WQD3
	jO06omDZwhgHqTLsCKlYELV41heouwPeTUxSVsftDSOfvnv43RV2AHvSfqymCbmj
	49w2GidCEw/x0Hx+87o4xUwehbKopsd8Bd8Zwr4rsB2B36bt6nWnvI0ySj/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791976735; x=1792063135; bh=+ZSZR7QLU1pat7sQHr/h17nsF6oHqFXTdTM
	zjBN7Fp4=; b=RK8fwvyJjVlSewMwkC/rXMT+x8dgeONyV6ZSPjTy3Cw4JIQuADf
	lsMYydB5RDvmBcH6kajvK4T3u/8z7anykvZmJR/HvoNOUqn9CHEdV297sjx9GvQw
	VXiWTzy8aPrSM6UPDHFmBsZ1TaXCjQaqGOtyioZNY8oW1SC9nYBRhkQiPgtVDhM1
	16fE+P6fIpNfMK3cI02XNo2iHkyz89RtnyWaTAOWT+hFpxnr0h8ed7lQNoOLZi3G
	lQxpJXSpoy0HpIx3n4F7OPAA/Pba8sdTDyagXT7KJgShymMxiH/1Hg/8syGXfWMw
	tA+AukFOebMmK27uLECwUCSwMIVWBi6R3xw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791976735; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fN+E12Jh43/hGX1bIkBd4WMVAUsaoYVW6c0jSeUrmsqnlYN
	nAN+6na8I2xFZhBvRnyx1l/SzQcxwneW/Np4UNPyaCJoXAZqvbcWD5l1+yV262Ap
	o7EEhz27CXR5XIC31LKnBqzQkPLE7v1VSBm8RUnDsYHj0bmAmbHxChlf/Q/SIRbF
	j3EeU9AutCSSuD4KMHSdf8ZTeEOsVEchLgFPliQVtfBIykYuY3bWHypGdfWraaiQ
	NjpCY28bZMkZMg2urtCvGMMlKfgNIr3efD86TROnh/y3fbzq3MEnAbsvmE2JDj2v
	ARmfCqi33j6ztiYH938NtbyJ2qtDq6m2kfurZ8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7LgpyvR4IRHhOA6U0r49GhjZBpRiJvDdGnR7+YbkYZw=:YAzCt5iUahbK3ItIKpfZycglWc4JnPt0Gqb/Kgx9z8A=;
X-ME-Sender: <xms:H2XPai5veJVteBUvnEFRxglv7b4gnZIr7gv7he63pZdi_ObueV5seQ>
    <xme:H2XPaiyRv1UmTMIBqjALPGujPi2P_KVN4IoayzCjc9N9itMU2lljLAQ-Mqy203h8G
    IJ7CFxrDfUzS9WgH8_v1ow29J-ZsREExKqsujl-rrL4DI6fAFNZAE0>
X-ME-Received: <xmr:H2XPapzqoD7Q2_krWzoipdqFYBdWbGka-HiYGqL5jjizfi_q2D3j-w>
X-ME-Proxy-Cause: dmFkZTEQD/YG4LHHgVcspb4gge1wOG+4bnFzUUX1CaLzSyEXs8ioAqoR1DRIcICS497vY/
    rUAZ1xyU/C6E9XOJpInMFfleXWRhnNrdmq2w8EzGz3J47WeUO13VAAUZ84MJ5GqasljmA2
    z1UkYoDtK5cBeURxJUC5+8LLYmwxpL2PfghAKdCnK5MTTeDQ93h27kJYB1uVCcrFLicq0H
    amZEfxt2FLxK7k5HdrZVgMLdetnPJm0I3lVUc9khwtgPSNJtMumE4xw4oStg0X6PtmOaYs
    3TK8QzR1Bck1BYoN5rHQsl/7mgYlhIMPKaaG5SL4Q5L2zt4VAbg4s1QqxddFpaQ8+kiOUV
    TRk1c2RPHNrp4bEsEKo/j+1zG2qfzPefEyzMS6qpWr17uxnNQp4DyjHRvutBF3j3gd0K0A
    acvoEv+Vc/thAqEQlBY0mq727BK+BUBNvbEV+bvRunPuvuVJzBmKZ+3Fp6+33I/vcJ1cb6
    M5/0KYSlvpfAAjlay6dt8Tz7ec7nzuWUGy6wzYd6sU78hHKjWtLPb+5D1cYRy2tCWZT2nG
    D7ybnToO6k0fkdBuLuSWvu9+oYX/hKyP5fBIG09leQpL/OaW02y126BMCkOFysypRBPVLK
    ueW2jhXFygkK2sxdDtPFiNR/vaAZIchfAde8ng0nYVIiZA7Y2MvtwfMqoRSw
X-ME-Proxy: <xmx:H2XPaqw2vVJOU0MT9zKDWkDwQJYqrqGR_aJtlDhYlfqdYDEhvllEWQ>
    <xmx:H2XPajaMVP3vVDiSmgIUqF5YKlxeEDu4720fRQ8Nv5p7wHZvpz3Z8A>
    <xmx:H2XParWQvOwvpzDmTDeb6zxnkuUMI4IT7bf_wdtlssGLgKrkDXZv0g>
    <xmx:H2XPahiDYenJs1xI9kg2RymEkSNWMcA6MXbq6bVWdo-r_pe_lSZwTQ>
    <xmx:H2XPajSJmjI_86yJduuz84IA7uWAnl9d6RbcleS545eS8eR4KtqHqhac>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 07:18:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3f7b0d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 11:18:52 +0000 (UTC)
Date: Wed, 14 Oct 2026 13:18:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 8/8] ci: improve reftable test coverage
Message-ID: <as9lGraxDWjEjhCK@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>
 <20261014092137.GF1341124@coredump.intra.peff.net>
 <as9a5RngDLM8Miue@pks.im>
 <20261014111344.GE1356555@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014111344.GE1356555@coredump.intra.peff.net>

On Wed, Oct 14, 2026 at 07:13:44AM -0400, Jeff King wrote:
> On Wed, Oct 14, 2026 at 12:35:17PM +0200, Patrick Steinhardt wrote:
> 
> > > > Instead, adapt the job to run reftables together with SHA256. which is
> > > > an area that we don't have test coverage for.
> > > 
> > > Hmm. Aren't both sha256 and reftables by default part of the breaking
> > > changes flag? So I think we probably are already getting coverage there.
> > 
> > SHA256 is, but reftables is not. Quoting "t/test-lib.sh":
> > 
> >   GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
> >   GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
> >   export GIT_DEFAULT_HASH
> >   GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
> >   export GIT_DEFAULT_REF_STORAGE_FORMAT
> > 
> > So we will run our tests with the default hash function, but we will
> > run with the "files" backend by default.
> 
> Ah, OK. That feels...weird, since the point of WITH_BREAKING_CHANGES is
> to check the new changes. Maybe reftables aren't breaking enough? :)

Yeah, I agree it's weird.

> I'd say we can punt it to another day, but if we _do_ think it's a bug,
> and we fix it, then that would make this new job pointless. I dunno.
> Maybe there is a good reason we are not pulling the ref format from
> build-options in the same way.

As you mentioned in a preceding message, it's probably just that stuff
has grown organically. We added the job when reftables was not slated as
a breaking change, so we couldn't really pull it from the build-options
at that point in time.

I'd punt on this for now and just leave this as-is, because right now it
increases our test coverage. But if we revisit I agree we should figure
out whether this job is still worth it.

Patrick
