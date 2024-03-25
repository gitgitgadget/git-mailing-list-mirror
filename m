Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972D18271E
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361433; cv=none; b=pQrKXIE3yh7nSs9Q4NYzS1ANPWw2Qpvn5VsOn1VKtRQh5D9ckJjZk8Zq96itVwaJ1wcWNBVZXEw2nJxVD6U0mLj2+bMDgX8heDlqm945ddLwDY3jmvDzLdy9K14pFVdPSGLoJk5WYSyp4NvsNPVwjacTihp3iICx+CKriZY/VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361433; c=relaxed/simple;
	bh=04IdD2+vUxsw0rIzz+3xS/6oRJXFMODVlEcdrn3sab4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCk0KypG/UF4vvE+HUBoJVpKq0S/AD77XnpThqW1WQiBk1g8hdjrl5X1dyn540oF5NcsiXou13eSj89Nf7osbivSjX3V9GRN4lDjzQjVu+jTefu0lO/EQNO2w3b3vcCD3IEDiTT3KXVfgS+7VWxqCDhoiyZrbM4D09JtB1LkxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnRR7wdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FuGUl4pe; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnRR7wdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuGUl4pe"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C3DC2138011D;
	Mon, 25 Mar 2024 06:10:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 06:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361429; x=1711447829; bh=rIN2bfCyCv
	NBhfXRwOAzBL4GYKgWGDodNTN17fwhL68=; b=MnRR7wddyR650ruunvABX+Udnk
	oQflbFuJFZPRtFqrMhkWiGVS9EWSn/U48I1pzZ3xNzx+jbySpsN71/EVs1FTXtP8
	yfUmJVb7DFn7X8PDAi3vQhUwOG7qgxRMaaiEtxpZqqaITntOFfwa+DBIgVemzPXA
	QpilUaZ3PP02WVCUa/H+iizYKr4Pe1+9GdNcNjA4s+FnMEP696OSpUH2OBMgMP4a
	Y1c+m9z3wprhf3J8DvQXklHVaLvR1LKlXNAJv07Jy60luYuK1y6TYql3rlRdeAA2
	Nz8phqQ/qOE6VySrBg57QAdCWVxe0hOHtH9cTTo3MTIp+JGSE6Ls4JWc/7Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361429; x=1711447829; bh=rIN2bfCyCvNBhfXRwOAzBL4GYKgW
	GDodNTN17fwhL68=; b=FuGUl4perbnSQEh14GoF5vIn1hRwwTekecdUdALHgFA7
	Ugp5Ar9VHEXy+68RomhsfuMN4GIAuzO4GBwCYfHRHtgjEF2dYfn6+B5hySipIOD8
	/4jdIcxQ7vtzXVzk2MTpwFjpJf/tLZAxtqKulm2af+6eLiSCoSuIuCeIS8TEbHgx
	hJmTEo3Q+KN7AHnXtL6KrZhTzsRQJcFtmLbczmRRWSPSaSYRnAUpUIVdJfh0ye5G
	tTEkou+tMcMqFlrSdHUY90/mVlAHfgZTogCN+yW9PXtINJo61nrNYOmHBKhHDiwi
	jt3v15DGbOQV1pHGktUVGfjdM7fXwN/OruH7E+wSOg==
X-ME-Sender: <xms:lU0BZmfjW6FuoeuCVY5_omXml406PUe1tAFcjseyC98zFFGib8_S3Q>
    <xme:lU0BZgN5WH8NY7J4jpeuXvLkB5_qb7Qm8MYrSssC89Mr0C3NoFdoDBnHL22munSdj
    TamYdBmG7c8ofAZTw>
X-ME-Received: <xmr:lU0BZniQiNXuDeVZuNEbyvACZCyMI-NIB5wBYEB0X2DWW3-p71gtgblgK8mTmN-G1wBlV8Qh-vqCb0N3R9LfInThsMJoN-N39VYAg8MQdEhnAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lU0BZj-_dCBdmcepco4BL-zRvGu6sma4f6EFVcGag-8wDh9CEeSzKg>
    <xmx:lU0BZivM3-HyJHfMxoZ2E0mkNePfPffLrYf3Bj83ywD84S8P3w40fw>
    <xmx:lU0BZqEsQ0Cu17oXd-K2gxAlEZtjZ4sAHEJwEeg5hHm7RDHMS9EwJg>
    <xmx:lU0BZhM4vOul_D7GXfGy-lNYCe5K3Ti9J4ObXBXQzAHhaa3WKJ4WtA>
    <xmx:lU0BZmIlTlkG-sTNLerwehC2fN0YeRfpkTTSTKtSaKxEW_Cmqf29cg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd0a9cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:18 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/7] reftable: improvements for the `binsearch()` mechanism
Message-ID: <cover.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gOR+ge+bY+BsfFTd"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--gOR+ge+bY+BsfFTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that refactors the
`binsearch()` mechanism in the reftable library. There's only a single
change compared to v1, namely a renamed struct.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/basics: fix return type of `binsearch()` to be `size_t`
  reftable/basics: improve `binsearch()` test
  reftable/refname: refactor binary search over refnames
  reftable/block: refactor binary search over restart points
  reftable/block: fix error handling when searching restart points
  reftable/record: extract function to decode key lengths
  reftable/block: avoid decoding keys when searching restart points

 reftable/basics.c      |   7 ++-
 reftable/basics.h      |   7 +--
 reftable/basics_test.c |  55 +++++++++++---------
 reftable/block.c       | 114 ++++++++++++++++++++++++++++++-----------
 reftable/record.c      |  34 ++++++++----
 reftable/record.h      |   6 +++
 reftable/refname.c     |  53 +++++++++----------
 7 files changed, 179 insertions(+), 97 deletions(-)

Range-diff against v1:
1:  cd82ac6531 =3D 1:  cd82ac6531 reftable/basics: fix return type of `bins=
earch()` to be `size_t`
2:  7955f7983a ! 2:  a277d4fa6f reftable/basics: improve `binsearch()` test
    @@ reftable/basics_test.c: license that can be found in the LICENSE fil=
e or at
     -struct binsearch_args {
     -	int key;
     -	int *arr;
    -+struct integer_needle_lesseq {
    ++struct integer_needle_lesseq_args {
     +	int needle;
     +	int *haystack;
      };
    @@ reftable/basics_test.c: license that can be found in the LICENSE fil=
e or at
     -	struct binsearch_args *args =3D void_args;
     -
     -	return args->key < args->arr[i];
    -+	struct integer_needle_lesseq *args =3D _args;
    ++	struct integer_needle_lesseq_args *args =3D _args;
     +	return args->needle <=3D args->haystack[i];
      }
     =20
    @@ reftable/basics_test.c: license that can be found in the LICENSE fil=
e or at
     -		args.key =3D i;
     -		res =3D binsearch(sz, &binsearch_func, &args);
     +	for (i =3D 0; i < ARRAY_SIZE(testcases); i++) {
    -+		struct integer_needle_lesseq args =3D {
    ++		struct integer_needle_lesseq_args args =3D {
     +			.haystack =3D haystack,
     +			.needle =3D testcases[i].needle,
     +		};
3:  44386818ce =3D 3:  9ffcf45c32 reftable/refname: refactor binary search =
over refnames
4:  f56275f288 =3D 4:  5e20d93ae0 reftable/block: refactor binary search ov=
er restart points
5:  36b1ef8e5c =3D 5:  5bbeab114f reftable/block: fix error handling when s=
earching restart points
6:  38666de451 =3D 6:  271bacb210 reftable/record: extract function to deco=
de key lengths
7:  f716400686 =3D 7:  e751b3c536 reftable/block: avoid decoding keys when =
searching restart points
--=20
2.44.GIT


--gOR+ge+bY+BsfFTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTZAACgkQVbJhu7ck
PpTDsg/+OX3Ka9qU1M8kEgY6BFXNreLDI9rMMTXF1i9C4tLa6QuO2QgepMXFADKa
0Qs3+8jABaMC4AocSVVkZAUFJTahZnGFEk8dayGj+GPC4WfHH4Qwrs3bv1vjvTCo
Ysk/3Gzu8TG6kiJ/pztTkyi7kzuPBExx1jspl0cE5VHD4/2IElXUUE6o6JUg98in
ccZAMOLF6ZUagTRfAIDVsw1c3UqGBeCCQnad69DwUmcylEcy+vXlEUqUFr+aImaP
iE6OLaM0buKddLItpb9g5GiB9tFSQmgrW8dolUeKubE52evdbkYKf7Pc/gQhr9o5
ovqaL9Vq7wbGDwlLIj2uMpVjub1rew0C+z1qWnUWEHuzi4pyJVjpmB5e3vNCbeem
5cGqDN6xRCefC/sBSQy6jHJWMDaQgSlAKPaktyBpraCGVo0pSpO61+7RVPhsyaCB
e8zNJqXSD70EwWhrxF8DhL93iPxZSrOGkbsOvNBXwkNfR4CcD9mo4ldR0tuITJvi
2rk7VnH5oYsU326WV+1z7Fd6yyAlVdiuUgK9Pc13XOqjhYA3UPHsggmKAjuv8UVk
mCKhqE4v3xIvXs3yMoLGU0M2jhRJI4umYNQ+QOg33fFunPdURmvBTLZbHvi7bGmP
yfoyyYotd1w/M3ecI8vcL5EdhncXqzsbxTVpT0EqFzG7avq2njw=
=dkhz
-----END PGP SIGNATURE-----

--gOR+ge+bY+BsfFTd--
