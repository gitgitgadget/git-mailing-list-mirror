Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0279211713
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374186; cv=none; b=CNybJ3jttPlh7PJf7QeubSWuNWxsS/S+QzoLhfbeXVaHskj3x8F7sbJKbAQBb/KmIhtX5x+PlAyiozyqCaICIlqdRZDBUPdRjNDVCQobQockc0C7pEyQHRMoHzy/Ti5GSM7LaXw1G5j+HdgSQIUTr9wQIwfFdU7ET8roSWMm45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374186; c=relaxed/simple;
	bh=SWFUdqjIwvk8j3RE5FeHjrOtsOJLGMc6hI9eiubbaPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfZ7K7j2Ooknl+xoJi5RiXpbSlVSdxpEUNplR66jpj0UVupcW0xCXd1WtUDBE9nm0LGA04Bh5qGjKCoQTaRRqB1hNbSAhCh0Vr5rPi29nv2BA0WbuZeMXU+Ug3xb60TBYwx0+/iROr39CnkqTTlXwY+/kn2bnjKWjmWerUsHTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=auT3IdcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kTwQV8us; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="auT3IdcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kTwQV8us"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1050B1140113;
	Mon, 29 Apr 2024 03:03:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 03:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714374183; x=1714460583; bh=gLX10vBazW
	24ENtQDk6GE3obVRAzKt0DUjZwddIgoBY=; b=auT3IdcXvjzFO/CwFPA98gdihP
	Xo5CDR4Mv8cSL1SIq/ounLyQ8w+qjOhCdgGeXpVK6iUGh++v67NwcIHa5YJZ3/mp
	s5jHgegJDRqn5hj3zothP2ZgsST6WsY9NePXY9drz/8fWlQnicFPBNQRdyc9KnkS
	nMFbOedDXkF4kPcJzYIl1SMGltV7nKohcI5zvOvOCis++e7/xuD4Hec4gP0IuNXR
	hH9H1IKMElzRHg+H6EUTOsUiQYlhQRuMakfnuR3LZO6QqKZxqzIfF4v2apJ5qqX+
	SEBVyqFUGxVcRXmsSoxYkI9IkpehZFIy62pIfAXXGw/osQI2/gKntcBZgL9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714374183; x=1714460583; bh=gLX10vBazW24ENtQDk6GE3obVRAz
	Kt0DUjZwddIgoBY=; b=kTwQV8uskZSCuZ0lqo2C2gXhWVgfX5o3x8qLiZ0qg1qz
	QI55PEaQkr15DLuLQLlqLBs8/tdn6Xz9R21z/jqLVHbKxBMrUQKdpJlJjEw5wIku
	lRpvB/AYUs7wTHpxGcFz+AzzkARS8RpQO1DZMztSOeM2nQGhXeg2XBDoFmVqhjJ7
	rDJAP7Vesw1MZKiGGwXR4OJGNHhJWdSrzCfFUURvaaa9RfYjkY3AxxUlttf8muEI
	gScrIZDwINRa33f/vEzu7Q+QloNIBQeFzHKpyE4Q7UmSGTvOHbaFJQ6xm0EvrSbJ
	6ycV66R5WSF9+2nK1eYGiMcAIwQJZynVVuEIxZ/ZPw==
X-ME-Sender: <xms:JkYvZvjX-aa-vPfk1vs1MQk18HcCVhFENlJ7JHhDisZjHYEqjcFhGQ>
    <xme:JkYvZsDg_wB5mRz4qugw_zTwvGnmFyEdVQJuqOUT3gOi1v0cc02_DH0Ohw51R0DpZ
    CM0u93USGCuyXsVFg>
X-ME-Received: <xmr:JkYvZvGJP_kjLKW-MDzlSfVzq17rDqdAFtjkDt8Ypmuk5y1ZyfekpYutjFMWkCrO_VHmtS1rnCSsS-fO_Gtxv5pdSV0NdrS1uWBk_wu-KQrKkwPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JkYvZsStC6OojISfcKQAFZeVeWDtpl8APp8gTomDv4lxnXbzKkJxYA>
    <xmx:JkYvZszYCk8rxa6b2M8uR_xn7bDFMDWlIn2oJuF6yyeqUZksnz1Bdw>
    <xmx:JkYvZi4zXKtSnCGqmV9FmfiAZSurSzCamRlAaYonZmXiWfQKxNAefw>
    <xmx:JkYvZhywQlHnOh-b7Qf4jKFJyVpC3Ic_2ro98baQnIu8ompW__ATbQ>
    <xmx:J0YvZjkr7eCx2WGLRkowwo3gE8XiAWZwvzHS5vRuiYBr04nvyNkZIVl5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 03:03:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 58bf4c2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 07:02:39 +0000 (UTC)
Date: Mon, 29 Apr 2024 09:02:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <Zi9GIN1KrfIEjwRz@tanuki>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com>
 <xmqq1q6rc44n.fsf@gitster.g>
 <20240426211529.GD13703@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQFtVutprJAFaU4L"
Content-Disposition: inline
In-Reply-To: <20240426211529.GD13703@coredump.intra.peff.net>


--EQFtVutprJAFaU4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 05:15:29PM -0400, Jeff King wrote:
> On Fri, Apr 26, 2024 at 12:31:36PM -0700, Junio C Hamano wrote:
>=20
> > This is an unrelated #leftoverbits tangent, but while trying to find
> > out the reason why "[_add]" in the title looked irritating to me, I
> > noticed that builtin/show-ref.c includes <refs/refs-internal.h>.  I
> > do not know what it uses from the "internal" implementation detail,
> > but the API may have to be cleaned up so that a random "client"
> > caller do not have to do so.
>=20
> There are two issues. One is the use of refs_read_raw_ref(), added by
> Patrick's 9080a7f178 (builtin/show-ref: add new mode to check for
> reference existence, 2023-10-31). And it argues there why the regular
> API is unsufficient (mostly because it does not protect errno).
>=20
> But the more interesting one is a call to refname_is_safe(), added
> recently by Phillip's 1dbe401563 (show-ref --verify: accept pseudorefs,
> 2024-02-07). Looking at that commit, the intent was to allow pseudo-refs
> by loosening the conditional that checked "HEAD" to allow "FOO_BAR" but
> not "foobar" outside of "refs/". We enforce the all-caps pseudoref
> syntax in is_refname_safe().
>=20
> The proper API there is I think check_ref_format() with ALLOW_ONELEVEL.
> But you shouldn't need to do that, because the refs code should be
> checking the names itself (using check_ref_format() usually, but falling
> back to refname_is_safe() if the ALLOW_BAD_NAME flag is passed).
>=20
> And I think there _is_ a bug there. The idea of those two functions is
> that check_ref_format() would allow a subset of what refname_is_safe()
> does. We'd fall back to the latter when deleting, but not otherwise
> allow creation or updates.
>=20
> However, it looks like check_ref_format() doesn't enforce the pseudo-ref
> syntax. It will happily resolve this:
>=20
>   git rev-parse HEAD >.git/foo
>   git rev-parse foo
>=20
> and even update it:
>=20
>   git update-ref foo HEAD
>=20
> though curiously we will refuse to delete it:
>=20
>   $ git update-ref -d foo
>   error: refusing to update ref with bad name 'foo'
>=20
> since that sets the ALLOW_BAD_NAME flag!
>=20
> IMHO these should _all_ be forbidden, because we only want to allow the
> more limited pseudoref names everywhere (and never mischievous ones like
> "config" or whatever). And once we are doing that, then show-ref has no
> need to check the format. It can just call read_ref() and it either gets
> an answer or doesn't.
>=20
> I don't know if that is a #leftoverbit though. It perhaps more
> complicated than that.

Yeah, this is something that I've repeatedly stumbled over myself. If I
remember correctly, the plan was to clean up and consolidate all these
different functions we have for checking ref names such that they become
easier to use and hopefully lead to more consistent behaviour.

In any case, I very much agree that git-update-ref(1) should refuse to
write refs with names that are known-bad. There should probably be an
escape hatch though that at least allows you to _delete_ those, or
otherwise there is no way to remove such a ref in the reftable repo.
Well, except for meddling with the binary format, but I doubt that
anybody would really want to do that.

Patrick

--EQFtVutprJAFaU4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvRh8ACgkQVbJhu7ck
PpQnkA//bJ1vz7l8ltFJYV5iNS4FQTkUGjlOD0ER5KFTYzVvwJsd4AK+8kgBPY/w
7k7KjKc451YtJPJlYWVvQLIZ1HKX4t3/OYqNn7KjFBZF+OokH5v2+ZCq5ABuKFEJ
1A664TooCS0Rmx0tTkRDks1OCir25tEV5fR0NcjjjTb+McSQ08aqce54ApKhOGyy
NjCiU0FPojexz4zoTNEJEf3qHqgTxVWUbmh10VLYKYptbtgCUJLumyulRhLN+TZX
Z3qjGwFXPd+EafTi4qPrt7JHNFaHj2hYF6P5hFZRSTk53bNxKNZ/EYPYXv9MpZd4
lpNV0rBymJSF9rZCS7B7zjxpJwO4UQCTjh1wxixDUN+CNL0HoOaJcB+fUXDQkcZN
IJndcRr0mp1Xt2A8jJYoNP+vztsRbma91lcmSs3KkHn/PD3sOqQZ0bauTh4O6htk
1rRHvP30Ln9V6CfurehOK9RTcq9cZ07KhHh853IstrymHbDWLyJhVmEXWzGo7NQR
pG29dM7k3NcJg6VhKR8s+JeaFwXGjlqePH9i5AopeRFBDXpIASsD11maZ92wV1Kb
icB2CPiW9oPUqeU/Ibft5YjHOZIvAzSK17xPE/DJZ2G/eUF48o0LQD71GN1Ajs2P
nP6Gw6pRdTk4ejCEgCQBXAh1xynI9spaxQUti5FcluzMDxYQcIw=
=iCNd
-----END PGP SIGNATURE-----

--EQFtVutprJAFaU4L--
