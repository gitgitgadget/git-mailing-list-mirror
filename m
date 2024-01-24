Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F717BA4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086370; cv=none; b=cNcl2MRsEYovqFF6bp0RxVyfy8nKcmZm3LTXIwIPJAw9pgxWeAiZvNddTerbQHAGqvVOnBQtv99u0jM33uHsz24UdFDkgZM8GNYTE53CQnoKssMp8X12m73oxWSBYmfO1hyxQg7+r6lrXM9FB/jCpRAS84kMQIYqxGa4pIAbsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086370; c=relaxed/simple;
	bh=yrxoLmV5ORCbsYPSEfEbOkRmvZT0A6Lq3KDLU1SP1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYyeN1LGta96I9olD+vvFQZebDISWT6n/LqV+alueq2Dl6u51UaCXdO4Qfau5ffbIXl1y7bs97hR5xT7MGaaBKVyhtSu+CjH4APG5WTdFZP54Hdg7AHB8F+f1MI3iUrnbMp+wPmPqhapKf+vV3DscYR+4tj2/RUatm26fUh0Cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d6DIc2ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2i0C61t; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d6DIc2ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2i0C61t"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 112AB3200AF3;
	Wed, 24 Jan 2024 03:52:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 24 Jan 2024 03:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706086367; x=1706172767; bh=pHqaogJBLP
	dy2uP8giqwfb0+Spm+YBUQ5IP/uWRMkM4=; b=d6DIc2gab9vb8US/8XdrWrwK/k
	yo3BWulz2Jj65kQpkOVOu1tTJE6tDyyRl2yUrC2yrenmDECpoMof4Hj94WoAMMuC
	QTrTlsLOEsMyTZCpGBmS1fFtWElB4r+fwhS660RP2lneuxW8oO+mgM1qHN6GK9y1
	y40zpQ4s6ujYW+JMQ8PyipiANqB9P86c80YqQ5jFjk4g3/iLunpVvR6sylpT+rjb
	GPUo/fh43MjOd42O0pDwYKkiMUMB2nM3eNBGl57d6oYFS3WK2jrwP6jjNdbbcHLa
	WHIzXV4GvZXF8SzbGYZnoDNjhWx0ezsbraHO9Fi8+7KkwCg02dOvFcGm5SLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706086367; x=1706172767; bh=pHqaogJBLPdy2uP8giqwfb0+Spm+
	YBUQ5IP/uWRMkM4=; b=g2i0C61tB385okQEqvXa7HvA7Yr9VCf6bA1/ZOCBc18r
	rTG8jVL8cVYKHt6XilYHiPx4sXcvTlK17OCiPq+CQv5amJcUUfnU5y9dEdAuax7R
	2hJNnl2+7MXborn+IKh7OJ54rgpFjW3/FP8l3sQDZCHxEyDHqIyufmZJtc6uU5eA
	pziv8VwuiTmGKb7EPzgnv+4c8PkqVPnDViFyBFXznrm5oZ6JkCe6mHBj+6ApCEk2
	TNTL0t95tjVbqYGunYmoSLQvJRaA2ddEOpQRRmfgGC2RW78c1ptnIdXuQ+nArLur
	WkDFMHp3sMcWkbYKGBPsJcyuavn/SlhTbVSr06xqNA==
X-ME-Sender: <xms:38-wZVKD5qscN732V7ImQny1YKBPK1gdxflIphWUoIq3ul1YlPtavg>
    <xme:38-wZRKyr77CpX21GLlb3j3ch4VIj4Q7P5mhv__R4mi_6ysx0oKRfTuMJuMrmA8jK
    QfKsbzjHFt9MUwHxA>
X-ME-Received: <xmr:38-wZdtVw8Z53T31szUFMHVXdQ-MJTfWRrW1K1z0j1yV_FQUIytHPwpzmB7P6xazRuSAHj0g4GsbID420x6lAb880hVcgogI5cC20fLMRIZQFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:38-wZWa8FXXbUD12ihJxuKRgpEorrwuk7378ukeuWWNwhSeBQcGmZA>
    <xmx:38-wZcaf0L_dbjngM8xseKDN9iEg31TwKjytT4Mj4Ypsswfro2tq3Q>
    <xmx:38-wZaCHzpr2n1Zc5Qrlw86Poo8R0m0FadraRrnFvo-DAoIrMAmWfg>
    <xmx:38-wZbmfiRuL5ifJr65f-VLDaQ8B0N9i0xm0SBBaF7b25uH_narkgw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:52:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0c2dc34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:49:39 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:52:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] t1302: make tests more robust with new extensions
Message-ID: <ZbDP27b_L8G2Dd49@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
 <CAP8UFD0yh4k4p7zcM+ZF90oWWTUMoGVpd3ajWWOV5pk++YKerw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tx3hYipFBeJyuu/g"
Content-Disposition: inline
In-Reply-To: <CAP8UFD0yh4k4p7zcM+ZF90oWWTUMoGVpd3ajWWOV5pk++YKerw@mail.gmail.com>


--Tx3hYipFBeJyuu/g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 05:15:56PM +0100, Christian Couder wrote:
> On Wed, Jan 10, 2024 at 10:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >
> > In t1302 we exercise logic around "core.repositoryFormatVersion" and
> > extensions. These tests are not particularly robust against extensions
> > like the newly introduced "refStorage" extension.
>=20
> Here also it's not very clear what robust means. Some examples of how
> things could fail would perhaps help.
>=20
> > Refactor the tests to be more robust:
> >
> >   - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
> >     repository format version. This helps to ensure that we only need to
> >     update the prereq in a central place when new extensions are added.
> >
> >   - Use a separate repository to rewrite ".git/config" to test
> >     combinations of the repository format version and extensions. This
> >     ensures that we don't break the main test repository.
> >
> >   - Do not rewrite ".git/config" when exercising the "preciousObjects"
> >     extension.
>=20
> It would be nice to talk a bit about the failures that each of the
> above changes could prevent.

They all fail in the same way: we fail to access the repository because
we delete the extension that tells us to use the reftable backend. I'll
add that explanation at the front.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t1302-repo-version.sh | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> > index 179474fa65..7c680c91c4 100755
> > --- a/t/t1302-repo-version.sh
> > +++ b/t/t1302-repo-version.sh
> > @@ -28,7 +28,12 @@ test_expect_success 'setup' '
> >  '
> >
> >  test_expect_success 'gitdir selection on normal repos' '
> > -       test_oid version >expect &&
> > +       if test_have_prereq DEFAULT_REPO_FORMAT
> > +       then
> > +               echo 0
> > +       else
> > +               echo 1
> > +       fi >expect &&
> >         git config core.repositoryformatversion >actual &&
> >         git -C test config core.repositoryformatversion >actual2 &&
> >         test_cmp expect actual &&
> > @@ -79,8 +84,13 @@ mkconfig () {
>=20
> Before that hunk there is:
>=20
> test_expect_success 'setup' '
>     test_oid_cache <<-\EOF &&
>     version sha1:0
>     version sha256:1
>     EOF
>=20
> and it seems to me that the above test_oid_cache call is not needed
> anymore, if `test_oid version` is not used anymore.
>=20
> Otherwise this looks good to me.

Good catch.

Patrick

--Tx3hYipFBeJyuu/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwz9oACgkQVbJhu7ck
PpQ42g/7BO0Vm5zebbQugY9yciB3fAqdVOUjJOLc/RQ8p9zCleaoUyD19OQHrLBl
ZBkHCh3vCF/IWLuIeuqRkt64WHW5Ba6COvow3nxeAoH/iDEB+GfkVjXa3ggRQwmK
zgSUZFenlAEwDi/gr5GMzCYmYWpbHnizbkZ2QZ0xwOgqhAmBnHopraXXWVebeWcT
Id2KVGxw4BURXLD2AMXht1A517HbjdK0XVTQI6WTBfv/tTQhyUffwbVEYl9hMhb6
+XxgdE+zyewBXtySY+x2sL0QHUlaidgk+NzVfzbuIcZ1jLIZ/JefEb/2B7QYaL5n
3UEn5M4hbsmaRh3kcb0hORk7NyHn9wumh1rI66cRr9kWyYjTPgwut27BYwnzK+JL
rm6oBn0blKgYhwHox+zzi7NkttcvXzLHFUj05Yg/kIM624AnupB+hIsM09mcPLU1
6EWV5XyWtdN92ra/QnjqqFwWD+9qSJAzpjpuo/v1CGqpuzFfG+DsQ3pakvmCgNky
tKbGvqhY+DXmGtpg9G2Y1qFpmoUYCOoGLesaCV+wabLiT8iNiHJ9WF5rqST6zpXc
6GNKFtWoX7TbPZBMXNxC1NaIp+gbfEHls02n+h28PQ5055iIb4ZNdjbeJnXr4BIo
BOif0vIM3XIK63jonUps/y+YRYgH1kuadVPL5/qZMVt+a9TF/Yc=
=dW56
-----END PGP SIGNATURE-----

--Tx3hYipFBeJyuu/g--
