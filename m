Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3010F2
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073142; cv=none; b=kyeOpV7tAY92naFD8g8DemwheFw77oJt3XPELV7QbVRqZncGFdH+L6Z0+09mwlZXqxvjZfdCK6j7cPcJqqA8AVyZvNNpK5CO9ZiiTfwT94t0jG+rdCtpidCxpP37/KNyyA9BQlHYZUgPMv26xxHH+/cJD+TVVHi3xCo2DMPuTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073142; c=relaxed/simple;
	bh=AbvoQRbkPk9H5ABO30AWTpF7AMEFDJXPhw1lt/lUaGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVOz5eiHm9pPr4C1tsOKFLfCGYJDuoEN4WvZoUvbXom0NREbzcjxhbv832hKargAeZ6PVrHJwYuEE/dYaYWVWcQ79YypNqMTNR6gudhSUDCLeS4fyGmXpwiVlhoF/Zm79SixAYzVEabIbsbNdz5LTbDdfKiwA3rMGA4z7Gfvk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JVTnLKO/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSJah7JK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JVTnLKO/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSJah7JK"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C94151380138;
	Thu, 21 Mar 2024 22:05:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 22:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711073139; x=1711159539; bh=2t0q71DUKm
	chVkeoacB6Iti/Wkzs/bTdZJ+WcPNoKGo=; b=JVTnLKO/QeEwho+j6TIGJbNkw4
	ezUKu9xj1Sjk+8D/9BT9qC9NkU+Sj2L+pMenQ3qpWsR14+qGV5AZrIMK59op95vr
	VbTT1whDg5EQ3Aa8EyqnUNnnDM3B04jI/Cnp4++2vp/LoAJRzdzMoujchZ+ZNheE
	E3VGufYcrDkT3PkVCsvGp+QLV0nMkXtmOTeetoIsS6UxjWFtTWG6sgbfeGzpcaXr
	K8efSGSxopev0juS4EVADiRcHByawH2Gm2LudGBPupBsP77IfA7VISSsWdPPYgQs
	5KuRH0hdjUM/zC53uTmJL5g9pQqM8Q3cn9/cmv031MiVMXT3zmWYA8bZCbCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711073139; x=1711159539; bh=2t0q71DUKmchVkeoacB6Iti/Wkzs
	/bTdZJ+WcPNoKGo=; b=aSJah7JKKd51/Pe+KO661S1Knnz9szM+O47aWitwuI5k
	vbHKjH9U2n2zPmqycHb0BoM0huNRSoCMlk8zHKmxcZu2/SycHCtS9IOdj+b6fIqu
	uA5ZiNBP0eFkwucUEdDFCJSh5S0qKNHpxOugDflGdvwjQvOC1CWmQMHkD3AGIweU
	j9Yv1fhQJqGCIuI9bhRa9EpJeVUvdSZmLdYhfFs6z6xcYoY2uBx9s5ZkIMJbst4D
	iDtVsED+2rpXIsv0jPU/JsCowXJPvFoo6eRNfiLTk78fPmKvrPOckR6Vls6IPnTa
	U4eI11OfNsL9rIXv2NrraHS9skp2KxRFo+6I+xarUQ==
X-ME-Sender: <xms:c-f8ZYNFmb---0wJAyzNCugRlTD2ShPmzFiXsHeHrlUYnSS7i9vGBw>
    <xme:c-f8Ze9mcD-RwLA9fQ_gPzZS6SUV_5ShUzexyqCyScyhmzJwbGauip-BYhkFTxNR7
    -YmWCBMT2u5dCrnpg>
X-ME-Received: <xmr:c-f8ZfTlCh26WMWG0Sz-R7PpuxMBcPK8OoGL5JdFRRHfUuD-DH6ZP9vgmWtqp6i56EjhSwg06DC8xRek9L4wvEKFizKfbgqFmNE93hL0q-JBZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:c-f8ZQuNEAKrTk75RxBVpWfUscJ8eTuhQdZtXeQhX6WPb-lXRuyrRg>
    <xmx:c-f8ZQe0K4wk4DMm5H_bgOPQN--u03w68wQk34LKsHkt444yfA71dA>
    <xmx:c-f8ZU2NtHvDoLMxh2WzNGMkL6cxwnYCVd4Ukneq7w4JybVRj3pHTg>
    <xmx:c-f8ZU_pbF7c0wvSNzF_Gk9zxYBx1nQ4byOZtAc_q4pV5AZYgSlOJg>
    <xmx:c-f8Zf6yTu8mSyRs1kA_gdj68BTCvOf9XJPl__M0gYUF2JcDwu5-Sg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:05:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1cfc0f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:05:33 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:05:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] t/README: document how to loop around test cases
Message-ID: <ZfzncGTNVwR8BrhR@tanuki>
References: <cover.1711028473.git.ps@pks.im>
 <326fb7965036fccc1c23ad02f200251f6388e6dd.1711028473.git.ps@pks.im>
 <xmqqzfur8q5z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zEchHsXw5pkg+bPl"
Content-Disposition: inline
In-Reply-To: <xmqqzfur8q5z.fsf@gitster.g>


--zEchHsXw5pkg+bPl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:12:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In some cases it makes sense to loop around test cases so that we can
> > execute the same test with slightly different arguments. There are some
> > gotchas around quoting here though that are easy to miss and that may
> > lead to easy-to-miss errors and portability issues.
> >
> > Document the proper way to do this in "t/README".
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/README | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/t/README b/t/README
> > index 36463d0742..d56401a254 100644
> > --- a/t/README
> > +++ b/t/README
> > @@ -721,6 +721,25 @@ The "do's:"
> >     Note that we still &&-chain the loop to propagate failures from
> >     earlier commands.
> > =20
> > + - Repeat tests with slightly different arguments in a loop.
> > +
> > +   In some cases it may make sense to re-run the same set of tests with
> > +   different options or commands to ensure that the command behaves
> > +   despite the different parameters. This can be achieved by looping
> > +   around a specific parameter:
> > +
> > +	for arg in '' "--foo"
> > +	do
> > +		test_expect_success "test command ${arg:-without arguments}" '
> > +			command $arg
> > +		'
> > +	done
> > +
> > +  Note that while the test title uses double quotes ("), the test body
> > +  should continue to use single quotes ('). The loop variable will be
> > +  accessible regardless of the single quotes as the test body is passed
> > +  to `eval`.
>=20
> We also want to say that they are not equivalent, don't we?
>=20
>         for var in '' a 'b"c'
>         do
>                 test_expect_success "with dq <$var>" "
>                         echo \"$var\"
>                 "
>         done
>=20
> breaks, but if we use
>=20
>                 test_expect_success "with sq <$var>" '
>                         echo "$var"
>                 '
>=20
> in the loop, it works as expected.

Hum, good point. How about the below diff? Will reroll the patch series
if that looks good to you.

--- a/t/README
+++ b/t/README
@@ -736,7 +736,8 @@ The "do's:"
        done

   Note that while the test title uses double quotes ("), the test body
-  should continue to use single quotes ('). The loop variable will be
+  should continue to use single quotes (') to avoid breakage in case the
+  values contain e.g. quoting characters. The loop variable will be
   accessible regardless of the single quotes as the test body is passed
   to `eval`.

Patrick

--zEchHsXw5pkg+bPl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8528ACgkQVbJhu7ck
PpSa5g//cKifWhz9RQYsUUBVHoEemMz/NTpnQlb1dCucxV3m6mZcLVrAItjwbScK
csTOTWWpXg2ChIjXp9K5S0sG8OxI1fFpQUMAfOtAbb6eeouPj4TW83OEpzXZzkEW
NoA3sui4q2IpWIL3xhlSdQDxpQlRpewi6YgOMiv6dMr2xMYUQvtlhvQ3QfzLFLzi
dEhNrDvW7y+UpSPk+hMSKLYhD0P39tGJsGNMAdDMlqtoqPSLBAp4TSkVVwwMpyCu
geRTlOMw9zDeLrcaDB9E5K6kAiEJqJS8AsLW0NfwXXVQtMIVKydPtWfxC+SQcw19
2DO+iwjf4jo3uZdIBu4xPt2oz9MKYLQH/K1zeJdWz2d2eGoTfBG5acPCnXoCmEdk
C+5QSISHUR17zVBUw4JoKfL4vSpPPk75nigN0FjaNi+VroGJ2XvJjEJ2qAilp3tv
hLgBvQM3IuC+lu6NCDYbIqdknh0gZz9DcEO7uohDgMBKtta7jL4/1ST1WVtaDoQe
kdGxRPN6pX8L1kFjLIAYp6xDzHOdm8itbCDtUU15JppoviA0woe7/5Ovb1Bh+ec/
6T99N0QeokZZfZEBs0m5myRg0ZA2jGedR/9QAbR+PFcR9Kj2kmRpPnr/F4cT0X53
2kBVdxZ0NJTNF+ZMrTFdmodSkSXOEpSEBLpPYU/fI7hpBaKa/7k=
=b0Z3
-----END PGP SIGNATURE-----

--zEchHsXw5pkg+bPl--
