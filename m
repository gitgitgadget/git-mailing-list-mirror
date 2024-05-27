Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE70FBEF
	for <git@vger.kernel.org>; Mon, 27 May 2024 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716786744; cv=none; b=XThZItURE+/fFHDgkQQDYAEmqsiJ4RaHkxXcMmeSv+Hwhfktcwm3n0Dsrf1twuDuOjdVUn7T4bCKbAKJnX6VhmPD7ehRNi0DiTiP/XZORlgvs4e3JMrSTtY0nOYIycBT0lLKAP5plisU5avp0hkoPo7oWbwTiouRXDbWRr4+UTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716786744; c=relaxed/simple;
	bh=1bzmwyEeke6YfxypFFKx/nT6HtT+pms3QY3BM+GPvdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyMfahb5uUu6XdVA0Ap9ceoq00HfiiGgvSRx0NxU4JKdg3Vh9gV20d6uMtVn+w9UHwQcQ2J79m06yhcngdBvYrod5GADzu9eFDMYd+QMI62SmIbfjHyZSe/ov87lm+Fmiqu3o4h0dzfBf1c8S0+mJxFXc7XlbIPnD30BFYJ1Wsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RYh14lwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUoeWtt2; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RYh14lwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUoeWtt2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6B3251800090;
	Mon, 27 May 2024 01:12:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 27 May 2024 01:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716786740; x=1716873140; bh=XTMcJbtf7/
	gfjO2MFkBWP8G6daHXH9uw/me2z3ZnM7k=; b=RYh14lwKr3K+R1C6a0tSFSja4M
	dl46KKCxkjz58x8tUasq8W4KoD4/Z2ZbFgYoD+CC4N/pOD0Dl7vtKWW3KiR2vCQE
	82JuooFoBN3PjfuhmJOU/frHNvHvnPb21kRR0d4RlUEG2SmJdpXcqy3EGaXgt6SF
	T32AhQGgWJPr5xH+W9KNhlz3vpVW74hLRexVxOOa+drUIidatN4VXXk0+dHTbNTP
	L6XdfWneI6IdqjFDIjBE+aGhx1tHiRCcm7kkgH95i+noi3G8PxqC2/KWPeUN8wXW
	7rPAjpyjKetOaakfb0voFmWooSc58WrYE+u/NaxSkutT1I64WlRRaDrz7IKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716786740; x=1716873140; bh=XTMcJbtf7/gfjO2MFkBWP8G6daHX
	H9uw/me2z3ZnM7k=; b=UUoeWtt2uYUyVAi0/p8h7EJOtBkj9GsD3Xl722QxHi7Q
	mR6/9WVo6+7fPOwFIfqT7zgssO7waN/7G3Hdcwrgx8t9D9vH6rXn17fdsPGx7Vut
	s7K6Y8iYSRhuYRTNnfOrVLg++Yp5sDPsCdHt5xcVNP6f5l7DPvwHX1qB22Nekdbd
	H461nJ6eMYVmyR6h1IIrMzjTNjbO+KvErUbn5wlH2STHMTbdns/Ijug0qdWopf+c
	FejoZR1qT/8Ze7plQrSiRXp2U0BH96AtrGKtYucazhGXO5UK/rhebe+AIN6+/SUC
	/PftPFCt0+DNJOMNkjQx9TCSj85CQwikL50DJ9nIxQ==
X-ME-Sender: <xms:MxZUZkKxotQkswi6Fw1cNwgMXdfZEOsdGeJuGKPjuYHn_qTeedMN5w>
    <xme:MxZUZkLhVKFcTRxxNGxtGoGQyLq_h5c8LUkuGHBBF-eGPAx6HHKYhN0Zyf9Dn4jr7
    m6sMv37g34KeP1eGg>
X-ME-Received: <xmr:MxZUZkuNvc-c-f1gJEhE3XPbomOqpAaQoAq5SYUKstyGHJbb3B24Htwxc022kKANr5RI7o9SPwWBcWwxSYiCZUYRzO79diOEwz-ZTvDscbtZ3-hFwTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjeefueeuteeihfffieegieeuhfetgfeugfejleffleehvdefjeejheeufeffieet
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MxZUZhb3rVDE9dw9iSGYGYxJEsvNm8LIlsYckBQsflVXH-LuyNNPEA>
    <xmx:MxZUZra8m74mlrXDA8rFYzqmwHE17aayBs4UeNa33E0Uvj-4Ar11ag>
    <xmx:MxZUZtB5iWCUxKFQ0mmxtJPDXbSe_nqwoR3x7O50qqsMBC6UmbLWMg>
    <xmx:MxZUZhZPV7zLC8-exJC6kJspg2I8Bnz6UUYDwuGQg_IL4egBW1Ig-w>
    <xmx:NBZUZgPrBgBtaeghHXqamTXyRftwI320lEOdqCXvhH1eFSGOik7dbory>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 01:12:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6cc64143 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 05:12:06 +0000 (UTC)
Date: Mon, 27 May 2024 07:12:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philip <philip.c.peterson@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <ZlQWLeLFrkZszciM@tanuki>
References: <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
 <Zj8blb0QqC2zdOAC@framework>
 <ZkX9w6etjDVAh-ln@tanuki>
 <20240517081132.GA1517321@coredump.intra.peff.net>
 <ZkcUcPhrTrbSbZO8@tanuki>
 <Zkc_zJGjwg0fZkRG@tanuki>
 <CAJ6X7_VSswj6pw2gyfEp=Hmx237MJEJA4bW+QkKNs88iRf=Hwg@mail.gmail.com>
 <xmqqr0doe5sp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0CllFS4BcqAUsZba"
Content-Disposition: inline
In-Reply-To: <xmqqr0doe5sp.fsf@gitster.g>


--0CllFS4BcqAUsZba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 12:23:18PM -0700, Junio C Hamano wrote:
> Philip <philip.c.peterson@gmail.com> writes:
>=20
> > Part of the problem seems to be that the Github actions runner has a bug
> > on OSX: https://github.com/actions/runner/issues/884
> >
> > Based on investigating this for a while by setting up a self-hosted act=
ions
> > runner, it seems to have to do with a broken pipe triggering incomplete
> > output capture / termination detection by either Github Action Runner (
> > see issue thread) or maybe even Dotnet Core's
> > System.Diagnostics.Process functionality.
>=20
> Thanks for digging into this.

Indeed, thanks for digging.

In any case, whatever it is, it cannot be exclusively due to a bug with
GitHub given that we see the same issue happening with GitLab CI.

> > As for the actual failing test, t9211, what I got on my machine was a
> > failure during clone: `unknown repository extension found: refstorage`.
> > In the trash directory, the .git/config did specify that extension.
> > Perhaps some interference coming from
> > t9500-gitweb-standalone-no-errors.sh, since it invokes:
> >
> >> git config extensions.refstorage "$refstorage"
>=20
> Puzzled.  We run t9211 in "t/trash directory.t9211-whatever/"
> directory with its own repository, so that what t9500 does in its
> own playpen, "t/trash directory.t9500-gitweb-standalone-no-errors/"
> directory would not interfere with it to begin with.  How would that
> setting seep through to an unrelated test run next door?  It's not
> like they share TCP port number or anything like that?

This error looks somewhat weird to me. Why should anything part of Git
not recognize the refstorage extension? It almost feels as if there were
different versions of Git being used.

I'm quite positive by now that the error is somewhere in the fsmonitor.
I was double checking whether there is an issue with reuse of some of
its sockets across test suites. But given that the tests have different
HOMEs and that they have different repository paths, I couldn't really
find anything that might be reused across invocations of scalar(1) or
the git-fsmonitor--daemon(1).

Patrtick

--0CllFS4BcqAUsZba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUFigACgkQVbJhu7ck
PpTNMA/9EZkDGWmJmyeJUihooAr+Q09TpjriM9UudY1VBimsBN1Ndb4KoLj8UNMb
KlX8MCpjyx7cdt9CZjETg34U+MsWlZCmubK5L0T1pUBu2y7c5QdsKIr9HB/X+Gvp
7DeDOEUy1LuCfV0ihzYZD/y8GFUk+ojyuCAj29sncvAGaNIeZ3JBB0J44aPrn6mW
ipqHC3gawmid8yKspIXXTotJvqmQHhjcqrPK4Z/QTjBkxZpQlefV4VxfR8FUo9Ce
3WqIs8CmX8gRZEbipoDpzGSW7A+yqzgTwpj0UPCI8rm+xZ7BtE8L7QtbKLseaHyf
b2K27REuucNYFNK0lsZah2YwL/tRTRVxZjGF20LYX3rhzj9R1XSuz0iyeEqR8f5h
46wyAEouWuqCSc2SGkCCffBGdAZF64HxkHEI1ZKhxuTwzasnZAISPJ4ADAyGZflD
cwmqlQyUSVAfYmOi0G9Sc64+bGh+5Cg+NqBf2LKb6+4U6x4cK6IuaBb3DHzRngR4
xS0ECh3cc9Kv/ntax7tsBWyEvhuU6g4v4lIEX4752ilklF0hEn6hIoAu1YHrwaM5
5vEI+UCc0cdKcPskF55cecGhzxK+VHw9rSY8WyQVLds5RXokaxaLk44w951apVmS
QTE4HW7NJ+GI3XNayJYngSSMQsXSNEZJJnpcWQx5jKXpHPsd0nE=
=4NN3
-----END PGP SIGNATURE-----

--0CllFS4BcqAUsZba--
