Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61C4A1A
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798171; cv=none; b=bgD12moWE2N/c0uEMNfNIrH4wNVxypbS5hhSneluu78qSMEwi2BPOFl2WcSSU6hq78EKzxGmfCW4esrvQ96f2ig0NCsC6y44Q0icBCqJQLVFxLXZWF/bZbmPoNSX/ndurQQNAiRc/idXlajf1/07i1Ta2VHV6tGcr0bipzSn+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798171; c=relaxed/simple;
	bh=ZYF7GntWdUQJpFuqRY1mvsRwX88SL9ggZC79vsVajRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjOFiOcJGwt7lsfxitI1ho2GSGOgvUYH/cGzH660BoGZMPM0VyB0PJ2vKwspt8Znd2uXfT+dK/vCWExfR4eqWB8fat37PhLZRIfbsBZTeQHn0bewa92J/hrFn8Z/rnHHo946FoC99oskGL/lqiih6dA+61fWS6XAA3Am2P/iFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=msAFXSzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EO/ZCVI9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="msAFXSzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EO/ZCVI9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82088114026A;
	Wed, 24 Jul 2024 01:16:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 24 Jul 2024 01:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721798165; x=1721884565; bh=o5/Id6rk8+
	wBibYkm/0tM+xgdkY2m7kHUkFRnK8xt+Q=; b=msAFXSzEWMS/KzuB1azS1xFn7P
	PHOTRCejcKtbp4/kMaefYbUdqNMoJj+VP2/ZPK+wnBLJsxOFEMTUMT9CNT1cyO3K
	u7cT4zN6Ry+OjNywJpS/iJAd+FxdVZbEV58ZxYgDOABxiR0pINHeXuMfcNuXg/bb
	w9n20N1a+NELmmtlEF9nYq/xNLVW2wJGXiE5sl2UILfooC12UB1eRf8KuN/McBPQ
	p8srNxVv1m5RVsSqYdhzZiTAmOFuY3kwXCAeO2Xn0k9HZtgmy5Rgr2SWS+KgYqB0
	GqoEd11YRhwwMWfTh/6vYsfkoSjIT0ND5DUZsJ4INEB5fQHJqG1gDWW86aQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721798165; x=1721884565; bh=o5/Id6rk8+wBibYkm/0tM+xgdkY2
	m7kHUkFRnK8xt+Q=; b=EO/ZCVI9sMO3zRV17vZ6KuIdHOoP6aoxIdebEoUgtFuK
	9dTsKzBGw8S+QGGCBECgQmfctZ7lk0dUbItAqd0Ehv4N8V4rfKwWII7Bk+ailF3s
	A3Dozq7MTLeQg8x4S/PgSwn1MstiNiVARTCHFaLM9H4Uz9cxZcKSNDkdEcUWInFZ
	A1rQ1VCSndQQMVd6BY6kxvfyqaTInjAIdpc6ErHEn0kfcQn4jbONXoeW+bYC9yoH
	kWaETaYD4QOsXNmpHflVQ5ovn+e05igQ8T+2LquPh6/lcghF9xINPok22T8RAVWr
	Qg2TgpjPXSBZWtGgblUKrilb0+my6wBsr/0n1FEGOg==
X-ME-Sender: <xms:FY6gZgse8HQ1YMv_HSaLHacpyMebpUIt1o56SPOrCgZVG-poIiYweg>
    <xme:FY6gZtfIVAlTnJ74XfVx0ziSB9KByZlgKQJs_OEhM9wb3VCM-l-D0cW_hsnMT77lE
    iTlrVJWNhHCefZisQ>
X-ME-Received: <xmr:FY6gZrwFH7XrARe156eJFGnRNNMUgS-Vewk6wC8i0E2r3dcBFOvXr0qgnrKp9hBFGnm4k4jJgfzcYcZW_NhltrjljetT3pWIErNnSLHr3Kxc9joX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:FY6gZjPFj5OlIDjFmvbd1LJBmVVr-aLpAj4xSL_4ws7opXxouyIMXw>
    <xmx:FY6gZg-NqkClBtKWLmgT3zdGYt-GseUZxCgISYllLGTvs_E0SGTCqA>
    <xmx:FY6gZrUlFFAxhdJ3h9CSK36VEZy-OqRD7VqSRTlYUb9swbs_dTloEA>
    <xmx:FY6gZpc97l2QbCaP_SBfqFNt00L8jb7TRTLcV8Re_Uk9GMGgvYxKeA>
    <xmx:FY6gZvas1ZntWMVCCTFAhkltaC3XZvmVPyCoS13aRqXQjlgRaYJ_qyV->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 01:16:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dc968b05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 05:14:46 +0000 (UTC)
Date: Wed, 24 Jul 2024 07:16:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: Re* [PATCH] t0613: mark as leak-free
Message-ID: <ZqCOEGfTdOSAL60w@tanuki>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net>
 <Zp4gILfskdpc6RUk@tanuki>
 <20240723210339.GD6779@coredump.intra.peff.net>
 <4b1391d5-89c2-41b1-b1de-e1bd26b9f10e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stuX0h12liloEz9S"
Content-Disposition: inline
In-Reply-To: <4b1391d5-89c2-41b1-b1de-e1bd26b9f10e@gmail.com>


--stuX0h12liloEz9S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 01:07:23AM +0200, Rub=C3=A9n Justo wrote:
> On Tue, Jul 23, 2024 at 05:03:39PM -0400, Jeff King wrote:
> > On Mon, Jul 22, 2024 at 11:02:24AM +0200, Patrick Steinhardt wrote:
> > So I dunno. If we think people are paying attention to CI on their
> > topics, and we think that we are close enough to leak-free that (1b)
> > won't come up a lot, it might make sense. I'm not quite sure we're there
> > yet on the latter, but it's mostly gut feeling (and I know things have
> > gotten a bit better recently, too).
>=20
> I don't know either.  Maybe it seems a bit early still considering the
> numbers we have:=20
>=20
>    $ git grep -l PASSES_SANITIZE_LEAK=3Dtrue t/t[0-9][0-9][0-9][0-9]-*.sh=
 | wc -l
>    678
>    $ git grep -L PASSES_SANITIZE_LEAK=3Dtrue t/t[0-9][0-9][0-9][0-9]-*.sh=
 | wc -l
>    329

These numbers aren't quite right -- you have to filter out most of the
tests that include "lib-git-svn.sh", which reverses the schema and makes
leak checks opt-out (?!). That brings me to the following hacky numbers:

    $ grep -l TEST_PASSES_SANITIZE_LEAK=3Dtrue t[0-9][0-9][0-9][0-9]-*.sh |=
 grep -v svn | wc -l
    678
    $ grep -L TEST_PASSES_SANITIZE_LEAK=3Dtrue t[0-9][0-9][0-9][0-9]-*.sh |=
 grep -v svn | wc -l
    261

I've got two local topic branches pending that reduce the number of
failing tests even further. One is the Perforce series I've sent out
yesterday. And then another random set of leak fixes. Which together
bring us to:

    $ grep -l TEST_PASSES_SANITIZE_LEAK=3Dtrue t[0-9][0-9][0-9][0-9]-*.sh |=
 grep -v svn | wc -l
    749
    $ grep -L TEST_PASSES_SANITIZE_LEAK=3Dtrue t[0-9][0-9][0-9][0-9]-*.sh |=
 grep -v svn | wc -l
    190

So considering that it's currently still rather easy to make progress,
I'd vote for keeping things as-is and wait for another couple of series
to land before switching to opt-out.

Patrick

--stuX0h12liloEz9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagjgoACgkQVbJhu7ck
PpRNuhAAqRoe8PNsK/vO6LdEaUhTzMPt4f4Ll9h8z11+9Gqe0LAwFU3BEBzRghPI
aFG2w/sBhR1I5WMqos7Q5CKkGfYqRMv/tbQ8wMM8GhgKy4UrVQWyIcegahlyqK85
d4z8vXpgikpD90zwbdaDtTRcoZ/Zdqd46sY5SYO3eyaxLOzApJ6IB7eXTaaoT40j
V5pPAaYPXNmqRE4OgHkQ2Xa/0Z6gH9pukwlGmr8bJG2flIM4i9JPyQ9LaHnGnPSn
bvDePuWAUWPTW6gQdr0bUqVcRsCuNIRf9Wd3W3dZqArgz3TyCk/lWGXKtTLzvT/D
ukisIv9l0W2NYg9IpuFtaxHyjwvrG3iOSWDtMDDVvXbGSe6Qsn/x/K0FLej/ll0n
V6koRj4gqzAdBjnBY2TI6+vLycKWXiMfRFPrpDJ5FPd8sbgdmEYndEDdYSRKhw8M
quh7zlhi2nQazdltublze/npYac5wMkT2axP+cYLHGrzoLFCwOs3yKI3NRZ0LEE8
I9TEZQAHDasxVmLJkEvMFiwm8mIfi8Wfn4pC//dlrZtcf5QeQa0M7dQQjUBCLvUJ
TcZs6BYrPf8djjZ7lTNybYuToiuzceawEt6dzU5WMPF7OageamFYQCx0TPLVmxS9
YfDi+0uNUZemTeajxm8oHYrtuCcReaCNq0JCZzLk0F5BNYiqUuM=
=FR3Y
-----END PGP SIGNATURE-----

--stuX0h12liloEz9S--
