Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54B17BD3
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749959; cv=none; b=ee2LbBTKMnUnMPhnlizfSZsKvdF8LnE09FugvB6LGHj0p867fp8npUOPKesD1IoyXZng1+H4hQ96K60fX970QDse3CueMoyA3HadxFDCp9jE/6KyIon+A/QuxTa2SZWJdL9NmgJqsZFFcJyOrR9qaaYEa5pB1z+FX7l8jOkS31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749959; c=relaxed/simple;
	bh=VsYTmhOjy6iN3DG92bclOUMo64VO4HV0Tmcrb2tGN3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmLX4DLWsV6BHaq4ERRMjfeHOuVHs6ZoOE76wWyxxIBBtpnQ1baAwoFgJsPt+50Ie87Snn9/6xBy5e2SzGqA56zUDFD2a1LIA9vQo8yD6kvrFqYYrgqBIAM7SQaJnkl/VBeUVNtCHwLgXn+zxcpUodMwSqKVMFMi5/BPWbch/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lw0cl/bX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZfAWRNf9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lw0cl/bX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZfAWRNf9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D3339138028D;
	Thu, 24 Oct 2024 02:05:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 02:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729749955; x=1729836355; bh=omC/Mp8+Ek
	aC5+4ShfWrpl1Dy7lZXpIxdNohzL5ezCc=; b=Lw0cl/bXuPBlikKAb7jVVqxD/z
	cBUNYXPMiglQd+tz1jAHf29LLUYeTuOXx8a4vCO8xC8TjBRH3sZ5GbR0FgCoY6Ga
	a811e7LHOM0Z5/D2x3VHaV/gji0a3BJdEV49ilgRJ6eB7ef7Nzc4652WNIR9TOAw
	VqTPhwSAVmr48B1R31FChNv+fh3flRaAaVJn5spwXhqT+EPVN5JQ7NBYXfTj6tdG
	xrj+idqpGKU/sn4Oz0ArXbaqd28q5IXNsmOzInGt9pPLHIxZ/mU+rheWpdgf3ngG
	U9qJ+gipvG12pzyYYN+tc+g8wR1BJy2Nrbd2y5Lk15qWQQoMOr15uSCijfcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729749955; x=1729836355; bh=omC/Mp8+EkaC5+4ShfWrpl1Dy7lZ
	XpIxdNohzL5ezCc=; b=ZfAWRNf9WwFDq70kLsHEDs524yStbWX9YkF5+FpabIRl
	rFy20QkLgziXlNrmkeP1ele858jo6u1Xw0hQE0P0izXAUy7Qc4wtfBYGz1RrqxVb
	0yeaTDcNYPDjiVLaKpfYiWCJXaacZjYez4M0YGBZUGbFsVGzUU5LnEuPs6Rax3QM
	pKkgGaf49YVYr2To3G4s23eYmxBtR0MQ4UeA2N4dnsJYXROWgmAHyhbdpTEow6Em
	+ChxFK10QAAkBiv5c5HcTyN+V7FGUfMr9YKfV3ZvzArcZYhGjxxNSXP7cLSkLkYv
	7+m597dx6T2++MLKDvAd0eCta8peG9IuD4LDF0eYSQ==
X-ME-Sender: <xms:w-MZZ5noZPMXmOLA8B-2FaLE-wh0-kodTJJtBAZaEBmordj0PnFTXg>
    <xme:w-MZZ02b8q1aLyIq0nKaVhDL3XTOt8htmeN4-EsjeRS87oQZLpmNbZpoMM6-zUUUM
    mVxIwXZ_yZVSAkLIQ>
X-ME-Received: <xmr:w-MZZ_qlL_DLcEr5kJ6ghBxwWh0a3wOZjsaRW-YfhzimdNP1dHtiy24GEQky7MwlDr2JWysSs6KEI-lXe7bb0E5MlbG3jXNDQGBoGpViNZgUqJGD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w-MZZ5mzwyYsc1c7V7XySbjrCoHuf3P83p90t50hCNSFYuG7ORsEzA>
    <xmx:w-MZZ32y_s8yphG_OACklBGdxVwSznBSYOEHj3smQouN4G-b1w3daA>
    <xmx:w-MZZ4vp8NWAfC6V5e5PuOOMbgRFiGgo1_BMbFfrAz7sR-1s1HxOpg>
    <xmx:w-MZZ7XjJ9JUMtT1vpiPEJqJHD_TFmnDbg1W8p-cvxQg12-V4yiTmA>
    <xmx:w-MZZyRUrIZLiyFQKYgekqMpkd2hm4qio__deelE8KENsTHkJC2wmPqq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 02:05:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5e98ce9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 06:05:54 +0000 (UTC)
Date: Thu, 24 Oct 2024 08:05:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Update versions of libcurl and Perl
Message-ID: <Zxnjt2QVwVTsYwvW@pks.im>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
 <ZxlZuxllqjAZfAZm@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxlZuxllqjAZfAZm@nand.local>

On Wed, Oct 23, 2024 at 04:16:59PM -0400, Taylor Blau wrote:
> On Wed, Oct 23, 2024 at 12:45:48AM +0000, brian m. carlson wrote:
> > brian m. carlson (12):
> >   git-curl-compat: remove check for curl 7.21.5
> >   git-curl-compat: remove check for curl 7.25.0
> >   git-curl-compat: remove check for curl 7.34.0
> >   git-curl-compat: remove check for curl 7.39.0
> >   git-curl-compat: remove check for curl 7.43.0
> >   git-curl-compat: remove check for curl 7.44.0
> >   git-curl-compat: remove check for curl 7.52.0
> >   git-curl-compat: remove check for curl 7.53.0
> >   git-curl-compat: remove check for curl 7.56.0
> >   INSTALL: document requirement for libcurl 7.61.0
> >   Require Perl 5.26.0
> >   gitweb: make use of s///r
> 
> Thanks, queued.

Note that this still breaks GitLab CI, as we exercise Ubuntu 16.04 there
which doesn't have recent-enough versions of curl. This version has
recently moved into Extended Security Maintenance mode, so the next LTS
release would be Ubuntu 20.04.

So if this gets merged we should add something like the below patch on
top.

Patrick

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4abfbc3e208..64f7ec5a2dd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -28,7 +28,7 @@ test:linux:
   parallel:
     matrix:
       - jobname: linux-old
-        image: ubuntu:16.04
+        image: ubuntu:20.04
         CC: gcc
       - jobname: linux-sha256
         image: ubuntu:latest
