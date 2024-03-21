Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3658AAF
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023139; cv=none; b=uysiSWV4G34mXUyU6Em3ym1UrkGnWaBgH2k2nytdOj94a1lfZ1d5VCQY0BsFy9HNy/b9TBIHO8cia7hkSXv2Pm9kCRdUhT+7qrAUHr43wQ+WRrIMlxZ9kiiCxV0XeZFUjybIMYibEXBP3II6eOGd6cvCutuDgTwwge5MbHFW81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023139; c=relaxed/simple;
	bh=v0sTrtl3+J3GPW4qNihMU2w8JIvlQbHyS+G96pE9WrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojnvd/xLrbJk565syVb15kQosfMPsfPiwWi1iVWcQ9lmCp3eHzGlqTY3YQp9G0N1Fs1XbViN4wlypjYxIAax5M/kFEKd2J9tbxUaudX1TT6CjDFUYZZqs0cKGRuOlEwgFgt7gsJJI2lGokEREfu0thTLDzFeqctKMsLQeGLp0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KABL93Cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFTMTQ1Z; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KABL93Cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFTMTQ1Z"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 06CCB18000E4;
	Thu, 21 Mar 2024 08:12:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 08:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711023135; x=1711109535; bh=O2Zxg/iemy
	MpMkPedz46J2brqAUY6EF14G8h17a/Ru4=; b=KABL93CvkBBVhTQHh8qdCiPheO
	FFb1xdarq6X9fQoXJj91JRQ/maZ2SiyYENEufL8RS/u5+spCkrPVEytsXQiEMpXM
	w6PNKrYOEqSmnG7OWHMeh5e1th1kNxFvCNiqncfsFR6/NesaCchTS7Z1pzbF/Wq0
	4XcmfPi5eS6ZIHPq/KAC7fjItsNi/+XNAR2eI2OVDcloeTzSze68gkP/1VmHn7of
	nl3583AlNKO7OT9y12jHa072VefyQaEuFgHLddIUbAeTpDqTHGuol/mU6yUENSMS
	Jro9TyN2Lo0TAb6jqT4PlmVoy10BBj00F0bHcs7/4AEnhpzoKUlTaMpMlAPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711023135; x=1711109535; bh=O2Zxg/iemyMpMkPedz46J2brqAUY
	6EF14G8h17a/Ru4=; b=TFTMTQ1Z4h52ZZckbTmxfV4X2W+DTQ6BVqo66N+GgNSI
	eefmOTLjCmLNniU5r12aLuxfXNL+xl1KIs4Na7VDdCoXpng/q7/UgOcHOu5X2g0/
	DeHoyqWsP9xzWezc4N289CAa/dcQsmLgLhnMsEiG1Nq8RaLjpsZPGZ2OoR6sMjV5
	byc5uq32udrluhkp4UStaUPdY3SBe71QuskzUTIY6n0w0e8ep9uL5kY+bmaBbvQR
	FPjqbzUicLHSkr27D2SeAhwWky8qrXHrMI89hjCQbB7sQgZEbuh+5nougdIUoTSO
	rSLTbdbE7alBCc/ftwUlzum87WMCqIsLoFuJIi8g2g==
X-ME-Sender: <xms:HyT8ZWZNCZeIf4JTxulB-Yr5PhGCp4gdTUShD2vwJqn_Sq6W4dK42w>
    <xme:HyT8ZZa0fcBtcmMlURnyzHvZNeQhVjq61cMwo-boSbwXOwCJ_hQyAlftkBY9vYQvi
    sziFB-tTOk3g2zSoA>
X-ME-Received: <xmr:HyT8ZQ8AbWuHrH4Lonhj_mXEZ738MXDtQ3-pyuEo9WVMg-Abve2fRbjO_I2vHQz7LCg_zpCUTm7ubbKKZ8REvdzlsuJ7jXBhFT5-bdXHFssFQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HyT8ZYrsLQAhTDtB8iIvxEhMyLypnTqtz3EQbektsqqpdj60T2mKdA>
    <xmx:HyT8ZRp3jU3gsOp3HEZP8bFH9LUbMAsaUbVqUOpAzpg1xI3JGo1axg>
    <xmx:HyT8ZWSuG_f1Jp9YX5c96gB674e2JOJ6e-ScMYRavgHTIsguirx7jQ>
    <xmx:HyT8ZRqqRAQdHZtP--R8vPwSo70uBRE19rw0xOyQ07izYHfvTn6yEA>
    <xmx:HyT8ZYX8_UFNqQyLid0e9x0Zpz6jMWGTRPxT3uC2tQM24Ueefrb6MEef9q4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:12:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f764558c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:12:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:12:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] microproject: builtin patterns for userdiff
Message-ID: <ZfwkGjdeHDpFAPrM@tanuki>
References: <20240316211618.490683-1-utsavp0213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g/f8/KRQd8YE1bcR"
Content-Disposition: inline
In-Reply-To: <20240316211618.490683-1-utsavp0213@gmail.com>


--g/f8/KRQd8YE1bcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 02:46:18AM +0530, Utsav Parmar wrote:
> Hello,
>=20
> I am Utsav, a Computer Engineering graduate, with 2.5+ years of
> experience in the technical industry.
>=20
> I am writing to express my interest in contributing to the Git project
> as part of the GSoC internship. While I have had some experience
> contributing to open-source projects, Git had felt a bit daunting to
> start. I am happy to use GSoC as a reason to introduce myself to the
> Git community and start contributing via microprojects initially. I am
> aware that I am far late in starting with this but I'd like to use
> this opportunity to learn and contribute more even if my proposal is
> not accepted.
>=20
> I am passionate about TDD and work at an organization that fosters a
> culture for writing tests first and continuously improving tests and
> thus, naturally, the project idea "Move existing tests to a unit
> testing framework" caught my interest. While I have some ideas around
> this, I've been focused on choosing a microproject and implementing it
> lately.

Thanks for your interest in the Git project, and welcome to the
community :)

> I have been working on "Add more builtin patterns for userdiff" for
> Haskell language but a regex for checking the beginning of a function
> definition here is tricky.
>=20
> Haskell has function definitions that look like -=20
> ```haskell
> main =3D do
> 	putStrLn "The addition of the two numbers is:"
> 	print(add 2 5)
> ```
> This is fairly easy to implement and I have been successful is doing so a=
s well with verifying them with tests.
>=20
> However, Haskell also has function definitions that look like -=20
> ```haskell
> zip (x:xs) (y:ys) =3D (x,y) : zip xs ys
> zip  xs     ys    =3D []
> ```
> Notice how the function name is repeated on every line. (and this is perf=
ectly legal in Haskell!)
> I couldn't think of a way around this. Please let me know if you have any=
 ideas on this.

I cannot be of much help with regards to this, and I assume that most
everybody who is frequenting this mailing list is likely not all that
familiar with Haskell, either. But I saw that you've instead moved on to
provide support for TypeScript instead, so that's fine, too.

> I'd like to know if there are any criteria for selecting languages to
> write built-in drivers for the hunk header as I only see a small
> subset of languages already added. Is it left open as a
> good-first-contribution for beginners and so can we add any
> language/s?

I don't really think we have any specific criteria for adding languages
to the userdiff intrastructure. It should probably have more than one
user so that it's actually useful to somebody, but other than that you
are basically to add whatever you think makes sense.

> I am asking this because I noticed a pattern for css and instantly
> thought of it for writing for scss files and would like to understand
> any implications of this before I send a patch.
>=20
> I observed that javascript and typescript have not been added yet
> despite being popular languages. It seems that someone else has
> already been working on javascript, so I'll implement it for
> typescript language.

These seem to be good candidates then :)

> Upon implement this locally, I got confused a bit about `t/t4034/`
> directory. Could you tell me more about it please and especially
> `expect` files here? Are these auto generated? How can I trace these?

I assume you already figured this out by now given that your patch
contains tests in t4034 for TypeScript. Let me know in case things are
still unclear though.

Patrick

--g/f8/KRQd8YE1bcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8JBoACgkQVbJhu7ck
PpQ8Pw/8DSkyGLB6+ORUUhc6HEyCHFjg9vewNqKbbnqvew6YSK3OcA+iqCEJ+j7S
MkXAEtSowXPFkf5fwt40XrCsC/1VxDoj37lzvYMRQzNB01+txUpmatEf4Bq3maJ1
Fvvo2cm3+rkFJSvChECWQ8q7nCD60rbuOhXA3zRz4fLpJJvNL/JQ5ky9UygNu11l
srU3aukCoJvTBZTrrzDHdAgzt+tMkKegMrU+aCim+/Xc1kexBnz5BgWJqrGeq4RG
j1xFpYTZgMmQqe1RYknl9xuSMJlvFLVQIt4dzWwcWyQ7hOcOdtedch8kxazqb3HK
T0muYR4ZbyiCQQdz8IQAZUV5YGTE4a2dtHrXO/wjiiaPYp01zBRHQ8zNs4w1DY6U
RnnkRdkFN9/MRECq/bxSjbQSsDdRW0FYAvmHhTxFdjPFXRiBZIFTw62ZDsIpaGDq
jVJwLJwTjDUVrLyqEz5l8egpAG66FttAm2C4JHZdnuPIawfzB88a40BA7icwGW0z
E4G9SfDUhiH1zBCUHXSqa7UJwnxFKLjV0+ZZ+Gy1ysdUeJcaDDyuieEs/ZdXiZxS
qt/PDxPUTwQbgf7uevGFBHAO9v7To95BgBvrMiBfk/aEGJjDgKMtUaq4BcGgPmIf
Dx8f5Uzm+ybzOIWGLXG8WtJP/04BjMJcu64ucUPaXpQ06dZagJ4=
=2jFJ
-----END PGP SIGNATURE-----

--g/f8/KRQd8YE1bcR--
