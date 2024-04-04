Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621294C634
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212148; cv=none; b=R/8dfPUbqIDWjW1tC4YrSi9jxTm88dDSRnPbrK/0Ytb1CSBYvHGDiVIiN87tCijVHdL9z8zc8kqd/OiWECUcw9fNIGHAz7Het3WEujv2squniKSe7d2ABtYZF2//AEAjSuh6PgLTBW5z+2mE6pFpiazv6q9/xvT0fOwsc5ZCqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212148; c=relaxed/simple;
	bh=9en3wynWnsdjzIbW+wLQ0TsUcIpWDa/+YzB8cEawDiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJhcNVWJe2JTlfxtJaLXiV9X35kKWTdQ16QmCGZaJ27WgnrA2R5Bde6CLH72S9WeNF8710Hlf6UAMKutFBk/IpzYUQWV0W0RmuSS8r8PTNd3nJnQwRUL8IaKl+dyqsMJiiisoERlILNj/D4qdGzGSeI1hHr0qj29WqB+Nz4lIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=geJFjaor; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UO9eRI/G; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="geJFjaor";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UO9eRI/G"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C7B513800FB;
	Thu,  4 Apr 2024 02:29:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 02:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712212145; x=1712298545; bh=9en3wynWns
	djzIbW+wLQ0TsUcIpWDa/+YzB8cEawDiQ=; b=geJFjaorTWaVnmyb9CISo2Y2OR
	cGxmzjcQYtFTONv0sFVrnzXCZBOXDnxqVuPH0G9la1+CxxE8L5gWfSpYJpMuIgkw
	dCOT8eZR2Bod+y8VXInArEyp3C0LB0AlAxbLGnCwC120Ub54MzobShTFqw7gFmCi
	S9+jq7tyIWSxteaQu2b1iCYYjjYMPZBWsgZFxqBPf2UCmBn/4q3eHVC6mY3DW7eu
	4yv0mpX0Y3v8XRB3YZCj0KuWzpZKG0FvvST74uAtDrdjWgWrj7TmD8HNqvrp7bbq
	vQuzXuAuItd36TRoR4i0i6oxziET0j/oTIqN035EMGcY3F6jeJ2Wd6sUjSjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712212145; x=1712298545; bh=9en3wynWnsdjzIbW+wLQ0TsUcIpW
	Da/+YzB8cEawDiQ=; b=UO9eRI/Gx4uufQPPGv9jqZfkW1IsYOaG8rM/lxWbIZpj
	GIA4/D0AZCHvU5iOLbdCVEzV78GeUj22yEQJCFPMj24Os7bw+GPm2rdvDE+7aQki
	72rvAg8NYxCaXFMqh1W27IcmPmyh1Ez1aPsYl0OIgTENP/+BPeZQ5aIzM1p7ERS3
	EbdQib78c81MPVgWZVEPH+3laUwDhKrm8mFmllQLi57I+uHtHPEFpZcd1fY1BqEj
	7dCaiCWctGW4OetG42Y3kl+HDUlairRUwGD2mL53xMDuQzaTG+xxD5DN4SU/XsbB
	UOYmE3ZEIn812NYBnWfSPjpuvL0X32PSHuD6b6wajg==
X-ME-Sender: <xms:sUgOZufSO7CtuMQYZYsNg6H82VCuTt0tduGUt9A__ojPe4hQaWKEkw>
    <xme:sUgOZoNy3s-Hml3a-Z8ATvS2HMWofm1y_vthrHWSsl2dYtaPD3MN5H-RTUZ4Xy1yO
    rFI4J440HisccVHow>
X-ME-Received: <xmr:sUgOZvjLvH6SVGrxBISlkJqsL8_SSOfRJxN9EnBeXlFh15-VTSmsd2Yzvqu4NdGAjRtbc0CTMWKGCm6cKliUTS6rAWPBqH8yJcu4KQDB95UW4ntc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:sUgOZr8UJ_PhDUxxiMczPeTkOnHu8YVHy_ZjuX6QSoDAF6PI8ySlrg>
    <xmx:sUgOZqszn6JMvplKM2FYyXEK-iLkRtaJOwbiFXZrt-Pw6Iq1carZfQ>
    <xmx:sUgOZiE-v7IzbE99BkF-gvIdD_9Ni28M7vMVeiZvSyg-5XlL9ZgErw>
    <xmx:sUgOZpOrSEQWrwbclnC2trywTeLzbK5mnPm-Fw_vTpXHzXwuZF5PIA>
    <xmx:sUgOZsWZtZbq6ZXC-wzsxhgU2PhBqZ-chTa107Q88NNR6fxw7kPw6BUT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 02:29:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 99b204fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 06:29:00 +0000 (UTC)
Date: Thu, 4 Apr 2024 08:29:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, git <git@vger.kernel.org>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: reftable & jgit compatibility
Message-ID: <Zg5IrZIg-DOuf5nr@tanuki>
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki>
 <20240403205451.GD1949464@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xsmuIQEqs68VQTue"
Content-Disposition: inline
In-Reply-To: <20240403205451.GD1949464@coredump.intra.peff.net>


--xsmuIQEqs68VQTue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 04:54:51PM -0400, Jeff King wrote:
> On Wed, Apr 03, 2024 at 12:47:15PM +0200, Patrick Steinhardt wrote:
>=20
> > I very much agree, this thought has crossed my mind multiple times while
> > working on the whole reftable saga. Ideally, we would have integration
> > tests that write reftables with one of the implementations and then read
> > them with the respective other implementation. I wouldn't really know
> > where to put those though. CGit is very unlikely to pull in JGit as a
> > test dependency. Does JGit have any tests that already use CGit?
>=20
> We do have some tests that use jgit to check bitmap interoperability.
> But obviously they're optional, and I suspect they are not run very
> often (I do have jgit in my path these days, so I run them, but I assume
> most people don't). It probably wouldn't be too hard to include it in
> one of the CI runs, though. You can grep for the JGIT prereq in t/.

Oh, that's great, I didn't know about that! I will take a look at
updating our CI systems to include JGit...

> We had another test that used jgit to check for some protocol
> interoperability. But it was broken with sha256 and nobody noticed. ;)
> There I replaced it with a hard-coded input. See 13e67aa39b (v0
> protocol: fix sha1/sha256 confusion for capabilities^{}, 2023-04-14) for
> some discussion.

=2E.. also to avoid rotting tests like this.

> I think using actual jgit (versus a hard-coded input) is a good basic
> smoke test: it tells us if the two can interoperate generally. But for
> testing specific inputs like the case in 13e67aa39b, we are depending on
> jgit producing that specific behavior (which in this case, it probably
> wasn't any more). And there we are better off just with a manual test
> vector.

Agreed. I will add some basic interop tests that ensure that JGit and
CGit can read their respective formats. I don't want it to be too fancy
initially, but it's good to have a baseline which we can iterate from in
the future.

Patrick

--xsmuIQEqs68VQTue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOSKwACgkQVbJhu7ck
PpTOLA/9F64/iDxTozBQvkxwAn5Lr9ATUawgwt3WXQaTAsEhIgO+/c4vBlSB2o+D
+F2/aYc9rlxSP6Q7MHTUz4rZSujcF9mhRjZEbr4EBINuUrvwfMMbLW/eKqCuIZQl
NBP9YMD0R/dh0PV2cSpD8fFnN/C3hZKKpaL+9ZJwLh2bbGkkmpAYfe9iSj03sMcd
dgLUCEPuERxbEogs8NdR4OC+/Zz5ZERjj7szL8L8uVtaTx2KtaJkt08fXwF/wW2s
paLN86OJ8zxallc4Y9T9HqjUEc4Y9wziwI7gC//gdLCTIUnYzlauUHa7fBlGwKFo
Gxnxuju+XAlM1ltNcEshPLz4t9m4FRaUyPM989xSExT532nSnF+e8i3W1uIlYfPQ
naVCTBwBctSbOVlIq6XTNg3Q44EJdoAKvKaP1/a7QZ8tzBj+OUrWFUATJb3ZzEkn
KJX00WQUZiaN31tjBrKZGd9dMQ2m0p2DcL2EURmysetKvxt6snA4xe6VjDMhaj9x
Sajg6cAbn3zITZRMsT4gUOYPH3kCBS3lu7iISb2IyuCebTOkYCeT9VmiRG0UCT65
PLLgIA8juftSdOel90Ew1S2ReM/NE2tJrRfJazdNoGwHfKz7ew4vg4+G2/N0obdY
ohycnN8vcWBtLkEuk8PP+Dvh5X4odbuUBT7aUqG0xshh1Jt+mxY=
=89e7
-----END PGP SIGNATURE-----

--xsmuIQEqs68VQTue--
