Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5B2209B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484768; cv=none; b=jvOk2ziTrmZATIqqeyVdciOCZce7wtfhmSXbSTcZXM4xjIswAgzO8Y/GTBkTMS/Qh971iyZXbFcn1OWP/2pOzf8Gozpkj7kSPSxuKSsL8S1PYRPnJqzkdLw6beb/91OQDK6gCNv5VwsdWdcWQmsWRlfs7+lPCscQ3TNc75sLb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484768; c=relaxed/simple;
	bh=I3jKHQVRq/urerM8aIaHC8X083JnV7haIt9a4dmh474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+YRZBpM6MXs+nLlna1d5YIMx6uSoD6kWaebQAyAUmAmB7J7svX2FJaKyjwtIaGHMZYv38MG8FUU48J51UxkUX6MWkTiRvu4XagqnKpdBqpqsN7iWWEcYsmxQQ079QUETCSe0ljYfniDBKXoYzELGF8cmW9y5D3EcY5yvxUR9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X+7sNULP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pq5YEVjL; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X+7sNULP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pq5YEVjL"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id AD92C1C001D7;
	Tue,  4 Jun 2024 03:06:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 03:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717484765; x=1717571165; bh=UljLJqDtP/
	ABywCnYedzQSn6438+D3uQQG9TBTMZ8tM=; b=X+7sNULPT686Gvqi17+wMyAa5s
	/MWDZL3iSBXoVYm5xzxJ+YIwYndWKvjFIm3LwuTctkRgouodPA1yy27NjKzz+Qe9
	RfGy+fRlCVMUbBNC8ga/dSxtfXZTjxhOIeztFlHaB3Uq76FkRaeoCXHgyPTwiCyi
	dUBH/wdiVTGLbhbYzxRL6jJm8XKAZnJ9vPacKZrkdCCuASTqg8zH8Lrik2coOajq
	GLptGfR5eARUFMiAsj9GXAaRrGVGQQJWj8/H2B0yKLbt0O0KysxHTD7+nreTASy1
	0eVqdpD3fvVBxiMLSQ9hbGyFQd+0s8j1rrpn8+7R47JGG5wSQ5mcMhn31HTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717484765; x=1717571165; bh=UljLJqDtP/ABywCnYedzQSn6438+
	D3uQQG9TBTMZ8tM=; b=Pq5YEVjL65xiLUSee83P2M6adP8H7rzw+37HMNLB15TO
	+rfwVs07lbWRVUkOnWoqjK9KcXBxo3gjE21GU/e0FXK/I/0mRuSbjwhiS5z5X8Hu
	KoLbUyjE1/17xszHIvOYKwkR2j/WaJ0YJCfViV0rHivq101PnK3/v4wat65a3rm8
	U5eKDAL7scuTzEoziOrkvoGk5k1CBCBpnZYHSUVa3xhHoxrbG8XL6S9a82Pzim5p
	CDhJGYDK6XwFFXrab4gPFbBf7+0xV6I6f+MndgG3o0AKG6k9loG5ULLFuQTwGyj2
	Ms+WGpXjf5y/kDSNfPJdzbAARwLsC4Zy8ZBqEJnOug==
X-ME-Sender: <xms:3bxeZlRpuxjz63Oryjjz4ZWkgZ9gc33gO-gYbMko5m9rj1HTlwrm1Q>
    <xme:3bxeZuxs0yG8MvV1rP-yP5yndWQ4usqJJyHzBi24R_du8B4uXriA_dN2DgQ9m-8f7
    hi6RcAXGCC7Tjr3SA>
X-ME-Received: <xmr:3bxeZq3A0WPCAfqc7VsM7_RWhROcbzrWW8h3aw4x4TDG7KbHQ_oe4vI0VDQM6q4gNY3FkNBA0jyw5nIyrlmS4vSkTKdTo381tk8U_cm1GEYvKK42>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:3bxeZtDjyd2Lmg6A-au5zEVmc37X-ZhpCHTiFLcD5GQDRUXxZwhQEQ>
    <xmx:3bxeZuijpnHQWoAKfVcBrMGrwd35PuAtEXbi1s3nr-fJtFuyqfY4fg>
    <xmx:3bxeZhrW_OWr2ByMVEwzQeUjCXVv02a7vMKOJ0I5HfwS50MGEelZSw>
    <xmx:3bxeZpgWmHP8v09OWU5eAwbnqi4XKsOTDMziPR2kNu8FGLtOlyh3PQ>
    <xmx:3bxeZnUu1mFZf1bp68EA4uaEwrzHMbPe9wbaq114-1fhDsuReZaj8HRp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:06:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3cc93166 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:05:36 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:06:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 2/4] BreakingChanges: document upcoming change from
 "sha1" to "sha256"
Message-ID: <Zl682Dk6RcFOC2rA@framework>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
 <b36ffcbaa67dcdada630e2d582e75da623512743.1717402497.git.ps@pks.im>
 <xmqqfrtu56fo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BUiib4C87A9ent4n"
Content-Disposition: inline
In-Reply-To: <xmqqfrtu56fo.fsf@gitster.g>


--BUiib4C87A9ent4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 09:36:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Starting with 8e42eb0e9a (doc: sha256 is no longer experimental,
> > 2023-07-31), the "sha256" object format is no longer considered to be
> > experimental. Furthermore, the SHA-1 hash function is actively
> > recommended against by for example NIST and FIPS 140-2, and attacks
> > against it are becoming more practical both due to new weaknesses
> > (SHAppening, SHAttered, Shambles) and due to the ever-increasing
> > computing power. It is only a matter of time before it can be considered
> > to be broken completely.
> >
> > Let's plan for this event by being active instead of waiting for it to
> > happend and announce that the default object format is going to change
> > from "sha1" to "sha256" with Git 3.0.
> >
> > All major Git implementations (libgit2, JGit, go-git) support the
> > "sha256" object format and are thus prepared for this change. The most
> > important missing piece in the puzzle is support in forges. But while
> > GitLab recently gained experimental support for the "sha256" object
> > format though, to the best of my knowledge GitHub doesn't support it
> > yet. Ideally, announcing this upcoming change will encourage forges to
> > start building that support.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/BreakingChanges.txt | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/BreakingChanges.txt b/Documentation/Breaking=
Changes.txt
> > index ddce7cc301..904857a636 100644
> > --- a/Documentation/BreakingChanges.txt
> > +++ b/Documentation/BreakingChanges.txt
> > @@ -61,6 +61,30 @@ be changed to or replaced in case the alternative wa=
s implemented already.
> > =20
> >  =3D=3D=3D Changes
> > =20
> > +* The default hash function for new repositories will be changed from =
"sha1"
> > +  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowada=
ys
> > +  recommended against in FIPS 140-2 and similar certifications. Furthe=
rmore,
> > +  there are practical attacks on SHA-1 that weaken its cryptographic p=
roperties:
> > ++
> > +  ** The SHAppening (2015). The first demonstration of a practical att=
ack
> > +     against SHA-1 with 2^57 operations.
> > +  ** SHAttered (2017). Generation of two valid PDF files with 2^63 ope=
rations.
> > +  ** Birthday-Near-Collision (2019). This attack allows for chosen pre=
fix
> > +     attacks with 2^68 operations.
> > +  ** Shambles (2020). This attack allows for chosen prefix attacks wit=
h 2^63
> > +     operations.
> > ++
> > +While we have protections in place against known attacks, it is expect=
ed
> > +that more attacks against SHA-1 will be found by future research. Pair=
ed
> > +with the ever-growing capability of hardware, it is only a matter of t=
ime
> > +before SHA-1 will be considered broken completely. We want to be prepa=
red
> > +and will thus change the default hash algorithm to "sha256" for newly
> > +initialized repositories.
> > ++
> > +Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
> > +<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
> > +<CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
>=20
> A few things we should probably list are:
>=20
>  - Even if you can locally use SHA-256 in your project and
>    push/fetch the history around, public forges may not be ready.
>=20
>  - The strategy to migrate existing SHA-1 project to SHA-256 without
>    going through a flag day change has been designed but not
>    implemented or deployed.
>=20
>  - This is only about the change of the default; we currently have
>    no plan to drop support for SHA-1 repositories.
>=20
> IMHO, we would want each and every item in this document to mention
> the risk factors that may prevent us from going forward even if we
> wanted to, and the first item above is an example.
>=20
> Thanks.

I agree that explicitly mentioning (1) and (3) is sensible. Is the
second one important though given that this is about the default when
creating _new_ repositories? I don't think interop code is a requirement
to make "sha256" the default, is it?

Patrick

--BUiib4C87A9ent4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZevNcACgkQVbJhu7ck
PpRzRQ/9H/CClVH5Wzz9eBgJiuzKQcD0Kzir3l7PzX3ynV2mthMMaPBmGHINS+7j
cZcZn9ph7saOCi6uN2jnDpc+BDuWhLvbMY7f6I4MZt/95IvbikEvw/X4jBOKTvEb
k+nuu6d1uvzdZPigSZyN3lLMCBH29+mbA7DFHdMfqBB2rWJEouMAwJq6AzBkQdf6
xzKc1HtHAT6QQubP1BDSnl2Z13PeBJHJHWvBw6roTQohwYTHtkgumnf5m8rSWM4O
ocnjucOICauKZ7viiIYe444yjgKfeD1Cmu3OycLUlkB15PJJiL/ZWg8d3FoGs4QS
Jp9H62b9/D1ooIgSKxVaC3ahU6YEUp6FQz8cQvYkx6c6upBgOkmQNhBiyAuRE1XR
l1TxZZGNBoYStjsBwisDtZms7CiC0l+49MLy1Txf8rVPiHfVbooToL972hcVaHbz
xHUX3mAz8k/xK2QQez6bvwCM1n+vdloYQCIuqLq04Wrpyi0adpmrgvKdeu1tB+c3
brvy4ZNEXGKVZNxs3DkpatXghoISlsKF8Dui3a4Bja6RORegH9L3EFmbiNDjxU1b
TaIH1sIVDQUVSY3In7DLXG08bmrPU1DSMIOGTslDaRrKqC6lVQgLX6T/w3t2TDjw
vfFIB1uIzb3mBL9D2+gzIVY+SirGpjiq2lYwADwSUvA0jRQURuk=
=NAax
-----END PGP SIGNATURE-----

--BUiib4C87A9ent4n--
