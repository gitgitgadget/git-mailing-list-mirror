Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28D5B5CD
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527610; cv=none; b=O5D5nMMZy/8WcfzyXRjs2T3HstgicK3gmmubnlDUc+l5QLD+yQRSQ0si/TMyKoa7qGbJcP1V2bwhkwNrjYeYJiculW8AVj04LvvJm4NTuCaXHbw6eYIhWnJeWqbh71Tfdi9sGpvs7k4xikvX54meqC3NWHZU6BECzDaBh9rOFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527610; c=relaxed/simple;
	bh=i8JsQ3iaOqBbuyUbqeW1TpGNPMsSj7pOZTLK7+6cmQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD50Wk0/Rz3HzoLFhMC048UxzZ1MznOH9qED51PTvq5aCAgnFHNMiGOsuWfkwGIsHe+xBNUbalDmZq/kurI9u1jaV+L6bx+st2FEe4iaDAKFhHX4ZOLXtgjLoVvYFwpaEPsebx1Jb/1BiGkYX8b/CVcaMFTH1nzi/DZQ0KZGGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FFUqOOo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oa2u0Ijq; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FFUqOOo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oa2u0Ijq"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AF76F5C0117;
	Mon, 29 Jan 2024 06:26:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 06:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706527607; x=1706614007; bh=M0MfJyI3f/
	lYq+5Xaz6bqFAIL/7AczcfuSGTiGfAdjw=; b=FFUqOOo3cLBcqb9yhAx5mYhPLx
	8sBmTSYlJMFzseZYyFYDc8jpP2b09fVjfzVo8wxLNGCTVr1eZuAIYcLXEorJp8cT
	L0H7BzJDIe7UZm6ACtG/GYEq2FmUZ8snZ+baf+F3i283ns4blUfSaXHtoF5F53Yb
	HIBtkNSjrK7MeWM00c8GeLVWpIluBFISrEge5+iz45LTgBHfy1SOwpMnmn6gPp9z
	ldBldw1epBDNeJ6HfcCf5fbTwfdfPxa/klFpoi3ZTunEd2vbihnIlq5+DkdLMjVT
	XrIFrnB5REWVvUFmzhQTLER33kPu90tgK3+BzqITkx2PwvuGEsq+q+BjvbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706527607; x=1706614007; bh=M0MfJyI3f/lYq+5Xaz6bqFAIL/7A
	czcfuSGTiGfAdjw=; b=oa2u0Ijq3Hr6haYeEOI6LxgOKQhwakgT6PTpsBJtI0oh
	HRSo/5WdrQEwtoBeYqWiVKcF4/H6ItKvb7JaSv5h81LllkAln3er+zJuQ9eSYJde
	lw8r4XVoCkQPrOVre08WjiRySNJYnzvv1IQ4/lJUFGdMM6Tu6qmb6mtvqmsJ0b5E
	N8CllS86ZS8v6f9Bp+YhXdLJ8GaHfBxtGjiTkUbs0XAmctGJT48sQ5tmzm5dJ0Eo
	4aL92wJWHCL/Xe+EnrEsRJI0xRMfAYl4nEIyYWbXcIjWxJ4QhSgoBkVcw653fkSo
	sl3oDd/n810kRZQJlzUYWzj7Bc7LzntLOiPr9NgtOg==
X-ME-Sender: <xms:d4u3ZWS0upi97g_qV_vYCWQbpwkOZp4-QloJ8AGg86-HfhoN50K_Aw>
    <xme:d4u3ZbzCthG8Ay-Plw-Cy1hXzlTS0z33XsZOPEdE8GC62TVtDanuulSuNNElgZdjR
    IJIRKjorOjdtmw_pw>
X-ME-Received: <xmr:d4u3ZT0qdkJuyay92v9KT1euJyf3PdH9BTcvy-UYo-adQ_XhM-qdcNnT86Q8mZMj2yXqlds1iVQwj7JDjgy8I5FM7tDZsnpD7Sz6xTvi_nj_3a_xOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:d4u3ZSA2YpGOQkoLQeGnWWAwHWf3xkkYtRNSNU8ha0wWgZoI2666og>
    <xmx:d4u3ZfiPNQULvQ-Jer39-JP3XLwxdCMxi2sydH1__A_o-7WOP5amBg>
    <xmx:d4u3Zeq4raA4xCi29kURKTWAg52i-Tqv7xJbaCTbHszQosj12wNJbA>
    <xmx:d4u3ZSuk9YNbv7jk69aH3S7Aqi0LcvIDfz21bn-tGvMpQHHheoFNwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:26:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05fbb53b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:23:28 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:26:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
Message-ID: <ZbeLcrjIYd4d7PaB@tanuki>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031933.GB2433899@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l8+uUTCWi8qnAJKF"
Content-Disposition: inline
In-Reply-To: <20240129031933.GB2433899@coredump.intra.peff.net>


--l8+uUTCWi8qnAJKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 10:19:33PM -0500, Jeff King wrote:
> We decide on the set of unit tests to run by asking make to expand the
> wildcard "t/unit-tests/bin/*". One unfortunate outcome of this is that
> we'll run anything in that directory, even if it is leftover cruft from
> a previous build. This isn't _quite_ as bad as it sounds, since in
> theory the unit test executables are self-contained (so if they passed
> before, they'll pass even though they now have nothing to do with the
> checked out version of Git). But at the very least it's wasteful, and if
> they _do_ fail it can be quite confusing to understand why they are
> being run at all.
>=20
> This wildcarding presumably came from our handling of the regular
> shell-script tests, which match "t[0-9][0-9][0-9][0-9]-*.sh".  But the
> difference there is that those are actual tracked files. So if you
> checkout a different commit, they'll go away. Whereas the contents of
> unit-tests/bin are ignored (so not only do they stick around, but you
> are not even warned of the stale files via "git status").
>=20
> This patch fixes the situation by looking for the actual unit-test
> source files and then massaging those names into the final executable
> names. This has two additional benefits:
>=20
>   1. It will notice if we failed to build one or more unit-tests for
>      some reason (wheras the current code just runs whatever made it to
>      the bin/ directory).
>=20
>   2. The wildcard should avoid other build cruft, like the pdb files we
>      worked around in 0df903d402 (unit-tests: do not mistake `.pdb`
>      files for being executable, 2023-09-25).
>=20
> Our new wildcard does make an assumption that unit tests are build from
> C sources. It would be a bit cleaner if we consulted UNIT_TEST_PROGRAMS
> from the top-level Makefile. But doing so is tricky unless we reorganize
> that Makefile to split the source file lists into include-able subfiles.
> That might be worth doing in general, but in the meantime, the
> assumptions made by the wildcard here seems reasonable.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I of course hit this when moving between "next" and "master" for an
> up-and-coming unit-test file which sometimes failed.
>=20
>  t/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/Makefile b/t/Makefile
> index b7a6fefe28..c5c6e2ef6b 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -42,7 +42,9 @@ TPERF =3D $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-=
*.sh))
>  TINTEROP =3D $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
>  CHAINLINTTESTS =3D $(sort $(patsubst chainlint/%.test,%,$(wildcard chain=
lint/*.test)))
>  CHAINLINT =3D '$(PERL_PATH_SQ)' chainlint.pl
> -UNIT_TESTS =3D $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildc=
ard unit-tests/bin/t-*)))
> +UNIT_TEST_SOURCES =3D $(wildcard unit-tests/t-*.c)
> +UNIT_TEST_PROGRAMS =3D $(patsubst unit-tests/%.c,unit-tests/bin/%,$(UNIT=
_TEST_SOURCES))
> +UNIT_TESTS =3D $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_P=
ROGRAMS)))

Wouldn't we have to honor `$X` on Windows systems so that the unit tests
have the expected ".exe" suffix here?

Other than this question the patch series looks good to me, thanks!

Patrick

--l8+uUTCWi8qnAJKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3i3IACgkQVbJhu7ck
PpTnVg//TP84lWo1hMcIWXhel4q9vPHFlbClCob1KPrxYfpMf1k+1sm0J1QdbfLr
YGQeP9iMbBaO/5y8M1IigOLAhMgpJ656fMT73fxdy1HWDwqiKrVX6esq1TFftn/9
AclvBpoO2L/AJ6SrLrX8r+jAP86dbyOPHAQb5gw1WWRHUR6u9H6s8Tjlcs93qRzb
H8ldPts3iuK3taf7rfin/chqBi9tzZV+xtxpwKgVglGqh16vZJqqe2RD169uRZSe
qGtu5QBvlVmvC56HG/64MtmQbYUfJVtruiA6P2YKe3B+LW/ZSfhEYhSZpjqkm6mG
FOc0uEMKG8oBqPhG31ob6gb7unG8SDw4tENcoMR/cyUyBVIKZtmRWgqH6DrsaMM8
CGcs4icgLklHil9rDUlYUBCT6+WwTU/+rBMzB2prUrX1oBohtbAlUTQE3LEruvuk
V6Svky1BYNgwiFg2Ro/dSSf1ntRlFjAlI/fRWNRtq2eXpdxEdzwMG1YNI0k1JoJ4
Bk91cCgIDfHOgTApkEe7FBjHtec8C8vbIKeeqLn0nRR+wmw94vTquA+QpwT3Q+Ri
JSl1Iqk+jp01M3iDMG7oXLrm8h7m/sKg8x0zcz2d1pGECS1MuDPch4uMaAvTzHfj
Vr2w0BTwPZ9W/mI5Syk4XPwch2DGCgJDQL+T8GUZu4S6KVjIDqo=
=5s25
-----END PGP SIGNATURE-----

--l8+uUTCWi8qnAJKF--
