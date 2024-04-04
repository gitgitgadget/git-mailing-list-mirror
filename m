Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AE55C13
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215216; cv=none; b=DgBFGFgd7trddzEkmMag38kqcq2G/DdYfsmP3JGSLNWMkAn+Cu99zelFAOYvnWEPjZSpRGo2pnI9RwdbW6za6jqs8e66s/pab2F1H0M8zkHwx23YYZn7COteEzK1tXfhbtsaMaVH8Hq+zFoBPWA1NCtkEf9RN1a68j8KxdEWCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215216; c=relaxed/simple;
	bh=yvyWGR56GNGW/5KPDVlmICefAQW9Vt6KYoAYRU6iSy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs33KCOv4mAA0UatG+FKCPBJTp+y1hDwufBcSwxT/Hi1z9NkvnIA3eS8LQgf4dV+CiG3cxT8kOYeWA5+U71GSWw8v93Ze7h+efvnhmchvHo/1NIIQM+L1Qg9nxR/dXF1mjKwtwtzyku4iU8akX+dKGCednxFCTn4EtMzao3OtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hyx26prn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Evi6Cj8a; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hyx26prn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Evi6Cj8a"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A0F91140098;
	Thu,  4 Apr 2024 03:20:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 03:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712215213; x=1712301613; bh=s3b25a6ijl
	XcMtXLTCXXv7ARmuJZPZWAKuYsExGQUpA=; b=hyx26prnojHCJWtn/BhUtYG9Fr
	/vzBeRPYtRMAaJW3CVrpkoye8U69+m5Rb5XW1eW6ZOtVd8khRKZwi5nSnZwKmKil
	7+lDUeCTtnJMthqbzWbMyce5kDFrgPHaCMlQEAz+u880pJmMPRGorp66+/8/jY3s
	IudEg4tf308ZpRlq795S34MZ0KAH0aFDLc4W4dYmchrYwnJ0H5xm7Bu17o/HOTw9
	XihddGvkRgy54xFJiHDPyZAqlZUKY+/C42/H4NallW5uod5iRVQpmWpH3k8nBl6j
	jBo7j04jNqkl8wdOn8afSIwSVH5tQEoXPeUSNFf5L8UplC6+8rAt6QDs6eAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712215213; x=1712301613; bh=s3b25a6ijlXcMtXLTCXXv7ARmuJZ
	PZWAKuYsExGQUpA=; b=Evi6Cj8aA/3buvEEyYrEHlQRWr5TsveAzcCFD7qg6Uno
	iNGkwKp0kg4AkSFqT456fmTxXGKsPBrRS1Wej6qqnAT5R8ub4Bj9iifsCD9zKKSR
	7IWvK7rcKyajT0MtYhx+WjPJGIsnVx+T8FXX61/Cryv6btpEG7oiUpe7g+xjyMnC
	g9sbUmvquDPcUTHta57vwM0vMoSMzC7AQJYT+OD0HOfDhxHKhSH8/xgwod/WcnyD
	6X1sKm85hXdU6CaCGg0CBxpbxO9EHmN+ktTA7FZup8KqsEGLdXoaRiVAag/chx8a
	WbnuVYhkLIFPDuPRciS4qycEPexOJ5hV7vNQJnO7Aw==
X-ME-Sender: <xms:rFQOZm1UUcHAtnVtz9ToeMyN5AhFNP0VWmziR4SwBeYHLUeUxTUxPw>
    <xme:rFQOZpH87AM1JSDdHQhymqpZgB1zxbioy4L_0CpyQY57hPsZ_6OakrevWYS3KfZS1
    IDz_v3orW1sAWRbyw>
X-ME-Received: <xmr:rFQOZu4n3iH1mii5CLggXUjkVQGVRSMZjMf9gb53QWHx6aslVLnub0K0MZsNo-3AgLu6wqMYYTt8Wo_NY6jOWO709yoSHdsONxgqXXvtYzdrIqEh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:rVQOZn1Awns4YGeTs3HWV2_h6QMAaIeGxP6grY4lG7y0CerEcuHLUg>
    <xmx:rVQOZpGHJU2_GUA7pE-_pfDuiH4Mrp0Vl8edC9_eu0auq8Se4jXjBw>
    <xmx:rVQOZg-bWcmhOrB31Na0w3JuJ8T7FOnPU0-OvRJWa7c04Ed-amCLcA>
    <xmx:rVQOZukQ6KKm8P7oWGbkU4XTYaVOHhwp6FY2WRe2aMnKmH4_XqOsgw>
    <xmx:rVQOZthzCaBilesyYFRaJZct2vHAJ1n_RhNMk2mN929opBlsaU4fBBi7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 03:20:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3aabee6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 07:20:07 +0000 (UTC)
Date: Thu, 4 Apr 2024 09:20:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Subject: Re: reftable & jgit compatibility
Message-ID: <Zg5Up_kSvOmQODO3@tanuki>
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki>
 <CAOw_e7Y_MwgrrJzuHk7tzBR9a2kDfTnwCzC-7_rgj8UJPKqp9g@mail.gmail.com>
 <Zg5HXZrL_4BsyzfG@tanuki>
 <CAOw_e7Zzc2uLX0FtkJ3fB+wuNJt5piMmoYVes+ayApe8BEN3+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ZUnLc7JGy7ys2ZV"
Content-Disposition: inline
In-Reply-To: <CAOw_e7Zzc2uLX0FtkJ3fB+wuNJt5piMmoYVes+ayApe8BEN3+g@mail.gmail.com>


--2ZUnLc7JGy7ys2ZV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 08:44:44AM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 8:23=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>=20
> > > I think the easiest way to make this happen is if CGit would ship a
> > > command to dump a raw reftable in a release soonish. Then JGit could
> > > use that command to cross-check that a JGit-written reftable can be
> > > read correctly by the CGit code.  By shipping just the dumper you
> > > avoid having to wait for proper reftable support to land in git.
> >
> > You do realize that "proper reftable support" has already landed, right?
>=20
> I had not realized this, and that's great news!
>=20
> > So you can just use Git to create a reftable-enabled repository, write
> > commits and then use JGit to access the whole repository instead of only
> > checking a single table.
>=20
> For testing, it's probably easier if you can work in terms of
> individual tables (because that is where the complexity lies:
> different blocksizes, restart frequencies, with index, without index,
> with reflog, without reflog etc.), but one can create controlled
> individual tables by creating a whole repo and then compacting it.
> OTOH, this would necessitate exposing all writer options to the git
> CLI, which is maybe a bit much.

Potentially, yeah. But as you say, it's likely quite some complexity to
expose this via the CLI directly. So for now, I'm going to focus on some
basic interoperability tests in Git that act on the repository level. We
can build on that and expand them as required when the need arises.

Different blocksizes is definitely a bit of a sore spot right now. I do
plan to expose write options via Git config options in the future, e.g.
something like "reftable.blockSize" or "reftable.restartCount". But for
all I know the CGit reftable library doesn't yet play nice with block
sizes other than 4k.

I didn't yet want to introduce configs which are specific to reftables
in the first release of Git with the reftable backend, so I pushed this
issue further down. I do plan to work on that in the next release cycle
though.

Patrick

--2ZUnLc7JGy7ys2ZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOVKcACgkQVbJhu7ck
PpQptQ/9Gi3rBto4Ur6Jw/w9O0lv7MC/Jnuv/CQx+kEofK+4LmGPt3eW4ROmi4M2
oH1C/GcUYRdbdNupmPIgT9xxEFBrf0EhULH7sKEEaPrLHVSokTBsDtswxcquJM3L
gvqQbjnJsc5Kt1Hub1Snp8lOM/Sdivqbk9wmwOu6EU1WTojwaNyi0p8WVBC4OB8y
nwf2BVMI79QviHhkLcThWDgWxd05sM0pe5BLRYLhG1W9DGw0/O/7WD9ZBdVij1W5
HoYwxglkdrJHRBBVDaAN2eHHifc2XNEfRTygjC0XAYSmKd0ysazBXqnFIM+BC31b
WEX8PIwONMIkp7qfZNS/XnQ2c2UGl66iE9i1TY0NOEm3nx7TIYmt2jpeW640qwfi
87IE8HWgFNftM8TYygW/+gdecNrtwISBCYpWpqEtvvWdlnoGlRWYmpBJfb1GAY/g
CzSAzGxpy/++YLqsLKCzovA339O1GUcy4PpIigz60+ATuR2+AWMQcAvUMNvbGbIU
dVolEkFaNYq7HdBfZS1d4bhSfRJ2GxGxcRRP+nXjNZVO221ejePq0q8BCK5kUIe5
4WJxdW88s629xoGWfQ0T9EOI7l4CqEzG0/rU+rTkQDnOFN8kFBvFy2l3ZlC9Glgc
JIJ/tgm+vJ/sXp8VaaiSs2vOe7UAlRxwetOwxKpFJ89TJN+5XD4=
=7/zc
-----END PGP SIGNATURE-----

--2ZUnLc7JGy7ys2ZV--
