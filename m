Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3847163A9B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504736; cv=none; b=XwPzoKaZkIC8bwTCFwctBoIXXSge9aJ3OPIRGgTroahfVGkvwVYguy42btMcpr5Z1/We22ZU9B3OSI2NZvoiJfdkL2kIOJc4q8E/Qwc+4dqZNmZ7oFy3seG1VKYIcIpQZUWJVWhahIAgcgD0cCUNK1eKWRUUkcy3PLWO8icEBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504736; c=relaxed/simple;
	bh=dU4BPYWEScvrPPVIoZ4O4D7HpeBl0u5RT+A/FTqAs34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ1rrUs0FqRnHN6sq5QbWFWfKAZu//F7D3wZyR/w9c9hZZKPNP3W52uUzF4hrJ3zX+PaDRyB5bFkCIso+P+YbYjCwtyktDQ6JLiPJl3XzX5ACyZAsM+nMXeiAfWdIJJwm4+fyZK7y6Z1jHYEsgE9TALSemQA10dFfEkeYDNZF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MSh0XB78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTwOcMZ9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MSh0XB78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTwOcMZ9"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 165F6114AB8B;
	Thu,  1 Aug 2024 05:32:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 05:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504734; x=1722591134; bh=t9WQWd0f5l
	qZBN+4v1usE6uAlq2HM7rqJCmD4LBkx7o=; b=MSh0XB78XNWCd5PWnMn2ZuzAny
	wHUViOYkQJIrv246NmFUf0IzS5q9hdqSUTDspgoFbjaJ8sovXb9FUauikybA1dQH
	N/EyQko7vrxwHDfxrJjWXwiV6ZQZJ6NObuV5+xyIvB/QZeDd6BCBP9nSbS2sgV5l
	oAAAl4qg22bQkQGp7YkwJNjLQkbwHiuNqV9RtE3YBN0GOdae/a4Kr1CBZPJq2SX9
	f5eXtlqCUxUtGyyOWfWwjeYz4v14Xe7KlTgf1+2uNBy87/6Pk3cDXJ0ogQvNs+PE
	gD6HTXWSQE+0s1elUjBcyhBIkUAYwvLo0SiwUbE845kJXzz4C4v9NVKMw4sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504734; x=1722591134; bh=t9WQWd0f5lqZBN+4v1usE6uAlq2H
	M7rqJCmD4LBkx7o=; b=cTwOcMZ9k7g0LojvfaQ94O6XIRfV/+BrWWcM6IcMZ2oS
	w2y9XzlbFfVQ03/GoycYj1fBOEegrZacHkBNzxEQXymOKun2+rAYOqtRIt+k8vJ7
	WYKyBnpnBGiYRH656LgHMR2OqgOCybqMyX6PqOQcCs3H5yVZe5zt8OG9kT3dWpEm
	3cHmjBTZ2QrWLRdYISeaRpmNG8jC3xsYtDH4z4Y6Apmd3Kf7rbC+En5DjEVH+som
	f1vRs2RWzo8JKv1ZIjvSXt5O+WWWc2kasDO+NJ9RA0BFUWFurAoUf0wkGo6Jzcsw
	yuP24dftPDA8Gy17BfhM4yIt4s/0KKF9kUAN4rH4rA==
X-ME-Sender: <xms:HVarZtHXl_gJE1iWljO8oa_51Pi7Zy3oAEi-OVUrr5hqwdl38g6VUQ>
    <xme:HVarZiXGLr-OWwmuXwXH7iN6RN1gr0rra3tc_bm0cAL4r_LxDNuAkVCdzzmnmcEXS
    UuPl-3n-qAf9nL-ew>
X-ME-Received: <xmr:HVarZvLzayT7UejOtOP2ScdW6PXSOzCd1j9KGVGGeMtZEsiWqR4t0yThaceOdIYP_-KWNhOUl8v1Jn5V78aqpW3yeH3CaQ06SI5fTaT4_V3nmz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:HVarZjG2HYNMYtjzsVf9NTdsnr4uOyaixNBZXQ2hmkwvN1Gl9mk_bA>
    <xmx:HVarZjVdxjQHoM7GVl0NFaCDA7dKh-dE2VWESDV2oMrrtpfMfLa5ZA>
    <xmx:HVarZuPp9ROl9-54TCcnsrCnF2QyNS_xQip4YGdR-i3LnZQPswe74g>
    <xmx:HVarZi0ZuFnKCg4bACUtJgY_THjCldAJesYAusMjxZRf9Jdkwpa0SQ>
    <xmx:HlarZlLTXiTPbl3d5K07KwEehhGovtC-Ce3JCX38tJlh7Ngod6fF7we7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:32:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 79c6949d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:40 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:32:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 2/3] Makefile: wire up the clar unit testing framework
Message-ID: <ZqtWGrsKLIRneB5b@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
 <cf23d831-9412-408a-8e68-170a8a476808@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BEEbFZ6qYWj2r4hy"
Content-Disposition: inline
In-Reply-To: <cf23d831-9412-408a-8e68-170a8a476808@web.de>


--BEEbFZ6qYWj2r4hy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 06:48:36PM +0200, Ren=C3=A9 Scharfe wrote:
> Am 31.07.24 um 11:04 schrieb Patrick Steinhardt:
> > Wire up the clar unit testing framework by introducing a new
> > "unit-tests" executable. In contrast to the existing framework, this
> > will result in a single executable for all test suites. The ability to
> > pick specific tests to execute is retained via functionality built into
> > the clar itself.
> >
> > Note that we need to be a bit careful about how we need to invalidate
> > our Makefile rules. While we obviously have to regenerate the clar suite
> > when our test suites change, we also have to invalidate it in case any
> > of the test suites gets removed. We do so by using our typical pattern
> > of creating a `GIT-TEST-SUITES` file that gets updated whenever the set
> > of test suites changes, so that we can easily depend on that file.
> >
> > Another specialty is that we generate a "clar-decls.h" file. The test
> > functions are neither static, nor do they have external declarations.
> > This is because they are getting parsed via "generate.py", which then
> > creates the external generations that get populated into an array. These
> > declarations are only seen by the main function though.
> >
> > The consequence is that we will get a bunch of "missing prototypes"
> > errors from our compiler for each of these test functions. To fix those
> > errors, we extract the `extern` declarations from "clar.suite" and put
> > them into a standalone header that then gets included by each of our
> > unit tests. This gets rid of compiler warnings for every function which
> > has been extracted by "generate.py". More importantly though, it does
> > _not_ get rid of warnings in case a function really isn't being used by
> > anything. Thus, it would cause a compiler error if a function name was
> > mistyped and thus not picked up by "generate.py".
> >
>=20
> > +$(UNIT_TEST_DIR)/clar.suite: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_=
TESTS_SUITES)) GIT-TEST-SUITES
> > +	$(QUIET_GEN)$(UNIT_TEST_DIR)/clar/generate.py $(UNIT_TEST_DIR) >/dev/=
null
>=20
> This uses the Python interpreter from the shebang line in generate.py,
> which is python.  On my system I only have python3 and python3.12, but
> not python.  Easily fixed, of course, but a way to configure the
> interpreter name would be nice.
>=20
> This gave me extra motivation to come up with the clunky patch below
> to replace Python with sed and awk.  That and your statement that clar
> doesn't have to be perfect in the other thread. ;)

Neat! I would certainly prefer to not have a dependency on Python, and I
think awk(1) is a good alternative here that we already require anyway.

Also, another benefit of having our own script is that it allows us to
be more flexible with how exactly our tests are structured.

> It reverses the order of dependencies (builds clar-decls.h first), not
> sure if that has downsides.  And the sed pattern is simpler than the
> one in generate.py, just out of laziness.

We could even integrate the generation of clar-decls.h with the AWK
script.

I'll play around a bit with what you have, thanks a lot for working on
it!

Patrick

--BEEbFZ6qYWj2r4hy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVhkACgkQVbJhu7ck
PpSEbQ/5AczEMfLHIK72xgV6ABUgoB8el+3XzXGecPb1Cq3zCj/aMJUdFxL6n+Uk
mXs8+ZkynVTZlrwZppPZXHTpzqXkLUC4RO23AdTH0RbZL9K0L3/Xk6J9yT2r/XYp
ZV2W+hCcUh0ej2CrE/Kr9UHyj1N1RZHf9F6qXRSG3wUAjCninDlXT33VT28/TsvA
Akl9Wy9FB8Vo5LuXhKObU1zvlTxpnW6aU3KYJsKdP1aunxg3CmWZj+7mqlqOgFSS
6pf8w8q5k4PWje9/ICbgXWRo5SEBVTT2yxRww55/nsB9JjJ0GyQjNATSGglGIWmu
v8AoW1ITNJx8+E64BPp7h1jHLJv6zm7BSZ9lIElf0L0R8LNDhqtxKyTQx/5wMn1/
5x5nP18b0LJtwxJeOwsnRQZwfb0mNwMGMgyf4cw1q1utWatANi1UyVcqYAPFyIp2
uJtfW/nGiuTeoKadATFUE4QnlNB7XIUaBCvd9wtyoxLCWn8ZKU306J+dRmlFiyQ4
htvVHfm8OIsnVxjNcvl9j2JVEdv2+Fd0hRBEosbgSt3i4nOWE4Opj6NDb1l+4RJF
WhalFXqgG4WkFAhot+rKV/lJ+6Q1wH+u8LzF/2B15Tallmt3kmWL4WFO7RUY8lFo
1FT78WtJ6HTZz/cXfCvLDVRkKMJBHrYA0ujBiFGwnKde5/TmlFc=
=8kRz
-----END PGP SIGNATURE-----

--BEEbFZ6qYWj2r4hy--
