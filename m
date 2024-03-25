Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3F74BE7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357866; cv=none; b=QnfEpBoOougjf40ghzkuT9lWFY2fNFlRZoRsGge+4FT5p0lDKEy8eFfRJ1+/XeF/dv2CLMmnMKVPgTkjZN+/tCpS8sCtiwUYrL4aLYZyBGRWgDdKg5ig6/iV0ap2OcqXu+GsT0Za+0vjVcvFY9Md4ZtkWjjbz7ZjV49ttbirBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357866; c=relaxed/simple;
	bh=VGQJKh4r4lrEvPIn98jorANDnqVJ/rP7VDGFBSiFU5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbfuq089XkRdjiNfIZNPfDM5Q5CcxSiQs9eLTtbqfaQiWmmhz0Ai5T1MBM1UuB1wX4T01f5Xo8oyjuUPTrWvwRZOvpCvsba+02cvx04Dg7DRM9Wbfg+vVtXjRtM3tisTu6ifktuw7pf80km5McB4INJtNMCORjxIhzLkjybmkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KOXFV0lE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFSjFlI1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KOXFV0lE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFSjFlI1"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D73A8138011A;
	Mon, 25 Mar 2024 05:11:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 05:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357860; x=1711444260; bh=ANJcI7erZi
	Jslpy7TUwf8+Vo8pvddbQ1Xn81UGi/+7g=; b=KOXFV0lE4GHhp19PuXRx9zxCBQ
	SBNAzuvidPRKLJEVJRb14QDp1eIrlYzc9gIz9+7YhZla1G6H6CzEDVfen8KaygNU
	qmc8izHagqhfMqQB1qtIHdF2ZiUypgTTCe6F2NWXbRBDT0rtYjaMJ93/pujY5iB8
	bfjVVhEuzjC0HnMTGYaz09RUzCWpahyRaRfPdCrerHq99moDR+jOWzWmk0nrAwVS
	MjKSnsEPzugNYTrZRUCl2P25icu1P1McZD3UeAIoVI7GxbY8Ohzyr51lVuFpONO+
	shuOV/A/z/BEpFbLYJ8ivT2Q7tZDFTJ2Ls6JQxy1LkGNfrHJgLTiRlLsa//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357860; x=1711444260; bh=ANJcI7erZiJslpy7TUwf8+Vo8pvd
	dbQ1Xn81UGi/+7g=; b=SFSjFlI1agYSKHDqb5XwRHHy5mQ9nBivjMdEghpdRWWE
	ogscgpCqd7tZxjau0f+jA3Y4lcLc24uN5yuiEdhoMGc7xKRhaEEUDN8QrYDy9duv
	sS46MwYgJQw7u0w5zog78vrzI6gg9G6AIXAtTutNwy/fYlNhy9fkDVP5hwSY/fB2
	b944jc32CW2R2b3IMNo10vKNxxNS5T5WXWDHAlVr3iFQL4+4UBlNj7Qm4uoyzdqh
	n+CHd+U9c7B68ORapKMoqB/hGotg2YDWFCT1JtabfdREv8i8LVDyzzDYDn8rgdoh
	p3tmyNYi/uD+FaUHx7IuGInSbzfPi3Ys/tloWu+F8g==
X-ME-Sender: <xms:pD8BZrY_bemPiXoNApQX3rz_bv7DyFyqovkO1uJ9cBye2BhAJ_N0pg>
    <xme:pD8BZqbAf2JFn7-rWsilP376rY9PyUroAzZu-at_sd9yHpACVcNoUN5AH76msbEMX
    WdQEL8ECL5_R4GOmw>
X-ME-Received: <xmr:pD8BZt-C4ju1pwpq3C1tZSpAGjQRjztcDYzwKPEuaAneBU8dAn1ne9vtq_U3dWus3O3PYPgtXio2nguz4HGVvzecARlYXdzGUkixUclMPkJtfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:pD8BZhp_fU1ByqfG9WukXEGJ-7vF8TIG33ovX8LZKbJnx3b-mGHY8g>
    <xmx:pD8BZmo-3LJj9PnTZM4NWut5n1_e8z6WApubo3Ez7yjFHxesGKLzEw>
    <xmx:pD8BZnRreP6xHtDPZDaHRBjuBHjpqHE4jm9IHzvsB0req0Do3keE6w>
    <xmx:pD8BZuqJXaPXZY1LYtga0H-3mTPF116JzackRHbT9BB3uEus82frrw>
    <xmx:pD8BZvmresFF_H8SnMM7yhZ5Gvvyx4xi9-OwDCsjE6e2BkX8Uz2R7A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2149f020 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:50 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 15/15] builtin/gc: pack refs when using `git maintenance
 run --auto`
Message-ID: <ZgE_ofR50OWmFumK@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <71f4800d36bcc77d8f36c5fc7b48eccbb90e6a93.1710706119.git.ps@pks.im>
 <CAOLa=ZRRCLOcXvn=F8eXH5N0kncPhu968_se8tG43VDEjZruwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n0GLITibdbKWWP1K"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRRCLOcXvn=F8eXH5N0kncPhu968_se8tG43VDEjZruwQ@mail.gmail.com>


--n0GLITibdbKWWP1K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 04:59:06PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When running `git maintenance run --auto`, then the various subtasks
> > will only run as needed. Thus, we for example end up only packing loose
> > objects if we hit a certain threshold.
> >
> > Interestingly enough, the "pack-refs" task is actually _never_ executed
> > when the auto-flag is set because it does not have a condition at all.
> > As 41abfe15d9 (maintenance: add pack-refs task, 2021-02-09) mentions:
> >
> >     The 'auto_condition' function pointer is left NULL for now. We could
> >     extend this in the future to have a condition check if pack-refs
> >     should be run during 'git maintenance run --auto'.
> >
>=20
> Ok, this answers my question in the previous email.
>=20
> > It is not quite clear from that quote whether it is actually intended
> > that the task doesn't run at all in this mode. Also, no test was added
> > to verify this behaviour. Ultimately though, it feels quite surprising
> > that `git maintenance run --auto --task=3Dpack-refs` would quietly never
> > do anything at all.
> >
> > In any case, now that we do have the logic in place to let ref backends
> > decide whether or not to repack refs, it does make sense to wire it up
> > accordingly. With the "reftable" backend we will thus now perform
> > auto-compaction, which optimizes the refdb as needed.
> >
> > But for the "files" backend we now unconditionally pack refs as it does
> > not yet know to handle the "auto" flag. Arguably, this can be seen as a
> > bug fix given that previously the task never did anything at all.
> > Eventually though we should amend the "files" backend to use some
> > heuristics for auto compaction, as well.
> >
>=20
> Agreed, thanks for the clear explanation here.

Thanks for your thorough review!

Patrick

--n0GLITibdbKWWP1K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP6AACgkQVbJhu7ck
PpSaog/8CqJyiyAZ3fxRlYlhvHJVD9i9z1Iai1+9I9qAbtFHOaBDMul72jBz7POd
7TxARmowi1UOdAuIpND41CVo5gt4RwPGXmFg6XmYODHNqEs2SQ8f6j49IO9bObtN
DT2HQaCRir2SbjYKITuL75dfrGwCyJaL3qnV72P4IaVgoFsre3mxMo4CUHTVYk2l
hklxrb2xefNuRpEfQbBjezrn5vQ7aqlhozOyh8LL6F5VJGgDvNcATqOkb1SYVBSV
7fWlNeK690nr3Iazj5CkxV68MA3uVfCa28Ki6qcabUvj93bjXxyXFoj+xY9pt5qU
oRKvHQHNb20zLkS1r/ud6BcnJyKqD1X/8gXZMPvIKUmCCOFlQwmjFcyIGKkEjQnk
ONmedmIMjoMoQ68uIKGNIZ53HnOM6cVFdxh1LPM3qpeGA8m0APnVRKKKD685fNsJ
t49Ovw7MIPZ8wzbDAZeCdeu8nofpFHlcPPVq2w3npQLmrtZqhJkS++rJgpGC8dX1
XOngdMr/0bVdoYHjTPQWuWa9DJzu9G6B8iiAlVtClHMkQsvNak+EjJm4YpE8tkdG
cKwa7dAJFHcjd9hHOnzF8GLKNrW4D+m8iLTkr7fHRGtorFzaaFnTHa/yPGruTwQP
I7S0HV63SL1viXAiaDqhOeU/BDTY7oZIm6C+W+ihauEkjXxMS4U=
=ngcy
-----END PGP SIGNATURE-----

--n0GLITibdbKWWP1K--
