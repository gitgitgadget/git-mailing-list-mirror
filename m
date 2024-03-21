Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D783CD7
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026558; cv=none; b=G8Bl5/6NWTsC2Calv2+mCTBTpoDogBkqOcdmfuIyC6Lp8j/MRtAx7DeyxCNgyHW+4mKN1HakcHQz8Kg5ltKvPw24ILP4S3tN0JlRWwH5R/M4PtyQ+F24vr47+2DkeEjzX20AiTdRK881k8xGgROEMLV4vJT3l7viDJUHjSK79TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026558; c=relaxed/simple;
	bh=LQNIdWYin9oo8d2qWtCmvzs6Nec7hJDgU45OLztKlW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsArsSvlvftrnyBoh+MPlnddGQkzZb0pNU+MvMe1r5sk1YsqrHl9oCuIgup+JKtVsANhZczTuxQZ5tKbqfVG6+EOKlC+rm30CfPmH4C9YN2swJtNuW/ysD39+OkE3xcN3IEkUXKPlYYWoNF2ERhREDWrP6FLrVh/2X0o6mLL/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AGfabZfc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwktBieG; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AGfabZfc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwktBieG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id A80CA18000AA;
	Thu, 21 Mar 2024 09:09:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 09:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711026555; x=1711112955; bh=LQNIdWYin9
	oo8d2qWtCmvzs6Nec7hJDgU45OLztKlW8=; b=AGfabZfc0MhgQJzRAIbD8F4yVZ
	FZbX1FXsm6WQGBtG0Dq9bp+zV5y0uvWcbtmGgl27Fd9THlL/pdOECXUKTdJF3Jpz
	cnb3sYP4IleUlxj6TCNjj+o52+sVR5iy7B0ggP1acgDcgjgXSZa+diR1NII6KnVi
	hJUrPMmOPkquAUT9JBY/ScTibv4+04Yh59TEBCcmBDqZT6sKkPlhlmfs1nzoX2wg
	flG4XqmJdgOsK4MD5lPF0AmcaDY19k8m5imoT0Oszj5x0ko7Gb2y0f7+IJNDPYgc
	l54ZYEpe/bd16a+dRdm7krEmIuo8F+6QdHtwfd/N6GEmuo/MPvi+N311CAKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711026555; x=1711112955; bh=LQNIdWYin9oo8d2qWtCmvzs6Nec7
	hJDgU45OLztKlW8=; b=DwktBieGMEX98bhsu6mdbmcLbdRH5DHk+jJw7c/dMD+J
	FtBUCGbsD+llmdynVIiP+eNza38+W3MqFg7OQO/2jGF6cgKLPKe6HNODO5hWwUqL
	zw04gLQFmGO6c8fMbvjeZigny9bzhocNgG8TslmMyOSWniGDe1fRruik5Q/9v/AW
	5j9Edc6UOvJv4E9C9hi78Yfim5qZOZrXjlvNBAjYpJbsgfhRWE6Qx1TApHbCSBSj
	CdcMmFHPGwk/UTx90+wYdoIto5xz02KQ4yi6hPoP19OdNiLXZ3m0ztAm1xq+YSxs
	P66vZNPCAdA+Zohpscs2EeoJ4d2WDoGZ5bfgw6NMIg==
X-ME-Sender: <xms:ezH8ZfJGGh5jFurQlfuC7bVhcKJ-POQldh0fV5Ma54STA2wCo2w5xg>
    <xme:ezH8ZTK9-_eq8SvBDw9uNh_qPAalG9iizwf7K5f4bEjiD6ddGvclW5gCFcDIM89o2
    okhMqgKUscmtA7Faw>
X-ME-Received: <xmr:ezH8ZXvSon-tGy7JT5la2E-599aR5YyITCuhE_9rU6oC1VghPeUxSbOr7A-VG2YUMXDgtF9yQEWRTW3MeghzAJF1SE9iXUW3s3RrREjSNOLgPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ezH8ZYaMtZk5blpFZi8y8RMUpy7TFPno8feO4QjMtzyoUicGrL21fg>
    <xmx:ezH8ZWb9WIpzU0c0ct_87dQjaNb806bws08z5mBxpwXJfSrTWC5YqQ>
    <xmx:ezH8ZcAkfGpV3yBP0Oyrg_VnAIJyFyqaBEhpQ4asyZnamRvIz6i1RA>
    <xmx:ezH8ZUa3fbMqmkNgaFHLLM1re1KJ32tUg1vZvGu1VSBnThogbpbZtQ>
    <xmx:ezH8ZbNMT2o59rO2J0Fsrnu9FO0ToNaPQ97MjDEXmNrmvtC-al1MjOs4btk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:09:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 385e04b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:09:08 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:09:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: eugenio gigante <giganteeugenio2@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	karthik nayak <karthik.188@gmail.com>, phillip.wood123@gmail.com
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Message-ID: <ZfwxdiF2RPS23zAl@tanuki>
References: <CAFJh0PSRrz=WYvuXgFGER6_E5qshVKSWNxBDgVo6GcCGfFDK8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z/G5Q2Nd69lq0iSF"
Content-Disposition: inline
In-Reply-To: <CAFJh0PSRrz=WYvuXgFGER6_E5qshVKSWNxBDgVo6GcCGfFDK8A@mail.gmail.com>


--Z/G5Q2Nd69lq0iSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:05:41AM +0100, eugenio gigante wrote:
> On Wed, 24 Jan 2024 09:51:52 +0100 Patrick Steinhardt <ps@pks.im> wrote:
>=20
> > We also have consider that there may be alternate implementations of Git
> > that would only know to handle the old layout. Those tools would be
> > broken in case we did such a migration, but they would be broken anyway
> > if the bisect was started via Git and not via the tool.
>=20
> The first implementations that come to my mind are Jgit and libgit2.
> I took a look at these two and apparently there is no support for git-bis=
ect.
> Maybe you are not referring to those.

I'm basically referring to everything that has wider use out there and
that knows to access Git repositories. I don't know about all the
implementations out there and whether they do or don't support
bisections. If they don't then this is great, because it makes it a ton
easier for us to argue why the proposed refactoring is okay to do.

> Also, do we care about several GUIs for git?

Many users do use graphical frontends, so we likely should investigate
how they'd behave, yes.

Patrick

--Z/G5Q2Nd69lq0iSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8MXUACgkQVbJhu7ck
PpTdQw/9EMXPzXhKTLIG2vSP60ePd6P9UEVOlWeunaFcxnzkoDHWD2eEAeEE4Mbx
u53iPSsMv1Ir1/mmHlRM9G6F7ucFWQY54BgwQ16INGE4GvzU90o08SFcl1KEEhii
yP0hDMpMRSwLtZAZmIJo6BwCtPGXUERp42kvnC4w95X/xkzocSK9+9nUEvhzj8UW
QWFdmAmMUNLCyi6KvOYIhIrUTvW7Ee4anl0qK/BaO62x5D8+B/gnsE/biS6vfaMQ
9kxHHaB7svVn09Tl9tXbN/FyJkQkF7GDDNM1e1njIxCLR0nBTQOZBKpag4GHWOBf
gRx/T02rUvSOjogTvD63TiaUr8iKUEFGoG1JoB/d8nNjokf16yeYQrW82hQrO8tX
V4hQn2amgRg1rcCnoRvBKBTYewL0dEJ46BybJPX9iFwX0OGs5vYTAtDo8u9YfeGO
5YVqk2nqOuvTxU5pHT7ruwHXkhX6446qyXdBzuGZKV6eWUumqWEW/E7GxPzHC4KN
FX0Z5jGyz4Lbw+U4+rT/2v9goA+Ru5szyq75tRSmK2rNL57xRkltf+V9iGzub0Vn
PKN/c+fReEIht7pH2sfpdmNF8QBja+2hwYtrPHJvYMnSvIoLjs8eAKDjXRaak1yB
OsDiInPR9K/UxmqaMdpo9hhg49TSnCFsQ35nqNzBaxN0+48lAfc=
=pBtr
-----END PGP SIGNATURE-----

--Z/G5Q2Nd69lq0iSF--
