Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134891D547
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985762; cv=none; b=PIoqFFnVdc8upFkaKd/V8NDW34Y7G2mIr4iJZ07JDUbzr7U2UjAoPGn5++WS1cz+MVjJYoXY0nsYIKLV3YhQVch92vrMxSUGPPQGK6N1lyqUUqLNbAFg5oGegt6+B/LvuqU3ofqoKtWG21di2M1soRaV5pKiuisK5nLq6royOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985762; c=relaxed/simple;
	bh=/7rmMpnxxJVZKn4aw+x65FWkAcqsJwNR/DQKUdxx5RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERFMLDB1dFga8Gns6gWZ6fjLxi/t6jkOyaT1Z6Z6k0M0jdeUrdHaKtvZrWAPEhZ68gVCpE+D0jK5n6PgoNEx7shSdMza5tMegI8Y1RVAH8vYZ1YTDdGGiCh0BBZrj0c8bnYmIt7T2U5uZHcUjHN68m3wot7rTSPrX6tAqY1/H18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dlQoLb9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M+2rj/wR; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dlQoLb9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+2rj/wR"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A6D7618000B6;
	Mon,  6 May 2024 04:55:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 06 May 2024 04:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985758; x=1715072158; bh=L/bQzLQWq8
	+2yBosFtwCQf5nJCw8B0pTBXnA8okuj+8=; b=dlQoLb9VfbDS5XcqZm8apko6Yh
	iibfxZrHTos5SoilIQGa8EPXt8QwRyWIbRd8xz4RN4wXxSxTD4rdzKXAkGt3UK96
	I2cz2uj6XtGq+l+FPUZfSFeMWCkkkrUgJsF3mNGzvMnc/LH0BccYz2+0+7BgBhtR
	Ky84CxGZOV40r9dtEtWVf0kHo+dIOf2sBgQA8hdeYEiN9tslt5gXlGptna55pCHo
	xIfhmM3TZpJlHckBMveGqPhpLsuLhlBXl9EsvaFTuLtoGrUp5NYQx4uKBLIs3Dkt
	PdKvIfvkTEuv8eUcdNm1X1cbNOEqX3kv0WX1rpqv7ncCLNBJn5HhF9sQXQmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985758; x=1715072158; bh=L/bQzLQWq8+2yBosFtwCQf5nJCw8
	B0pTBXnA8okuj+8=; b=M+2rj/wRFdQryd2kJLwyt5c4/+YoThUA9lNGHYFQc8lu
	JxqPD3yhAm+UK+lzkCVPmIcedz68DONlKgM5UWvTAAQoEKrwpTFU/GzHzvv7w1VG
	yiZyN9NoCj1Gimdq+VrH9y7MzcD1SjWx7cXJHXesYGvJKQm39zvjY3hnH0CdxiDW
	jgdhsmMuYcNRPDaLIDEiZ1TWZLNZeL0fDP7s8wlyz3OggmbaSGFKD4CkR10Ynr8E
	xdJCOMkA2jenI1wjSJapGYtEKgT3IrFkz3aeQGC1VmHEAIC1mh+8rX458h/W7FBb
	pKABo+1gUBuL/7llgNdqPBKirLPrmDtY6fJ5xVFT+Q==
X-ME-Sender: <xms:HZs4ZirVBs8AlGREgreyyw1PZF3OoBpJ_-0Hs2wktBZUFJyatH_1hg>
    <xme:HZs4ZgqbGoBMp3kExkNMCm2ctx8ndlN-VFy1vBzzHZ15ECvNVXRMOhpP4ZqovKFMk
    NGUO7RTd23awXrJ_g>
X-ME-Received: <xmr:HZs4ZnNXNwNbpb6W15b8nReC6FhsblI9fHc3ItnPvAI0rR_Z1U7Nj6DQ2JMuQo9cbVfqPGNqSd9ohMOJwVYAE_hdYz489F2GI-Wr9016soHc1s-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HZs4Zh76CLRSP4FBFEUFO_-qyzHaKigaSdLv6Vp8JQosExt4UdXQMw>
    <xmx:HZs4Zh43dYxbttIeOslXoq962JTqAqEX3MqSuhlizEC7ybuMZapCJw>
    <xmx:HZs4ZhgI_HEK-Wz5sXaPqI6UZvVlX-QvZ9c_FQ0saaf1Kza9KRf6fQ>
    <xmx:HZs4Zr6TUrDixCcFkN5FEtRHKEWKfyKiT4e1DXXelQd4ODwxLDPA_A>
    <xmx:Hps4ZrsChzfmoUbfNgKNzsfBSanAzsv-xcFSZEsMue9mRHpcJA5ugzQk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:55:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8fcceb0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:55:48 +0000 (UTC)
Date: Mon, 6 May 2024 10:55:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 00/14] builtin/config: introduce subcommands
Message-ID: <cover.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhAmxoB6Kpxcbodk"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--lhAmxoB6Kpxcbodk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth and hopefully last version of my patch sthat
introduces subcommands into git-config(1).

The only changes compared to v4 are some fixes to commit messages.
Otherwise I'm not aware of any other feedback that would need to be
addressed.

Patrick

Patrick Steinhardt (14):
  config: clarify memory ownership when preparing comment strings
  builtin/config: move option array around
  builtin/config: move "fixed-value" option to correct group
  builtin/config: use `OPT_CMDMODE()` to specify modes
  builtin/config: pull out function to handle config location
  builtin/config: pull out function to handle `--null`
  builtin/config: introduce "list" subcommand
  builtin/config: introduce "get" subcommand
  builtin/config: introduce "set" subcommand
  builtin/config: introduce "unset" subcommand
  builtin/config: introduce "rename-section" subcommand
  builtin/config: introduce "remove-section" subcommand
  builtin/config: introduce "edit" subcommand
  builtin/config: display subcommand help

 Documentation/git-config.txt | 219 ++++++++-------
 builtin/config.c             | 512 ++++++++++++++++++++++++++++-------
 config.c                     |  16 +-
 config.h                     |   2 +-
 t/t0450/txt-help-mismatches  |   1 -
 t/t1300-config.sh            | 432 +++++++++++++++++------------
 6 files changed, 812 insertions(+), 370 deletions(-)

Range-diff against v4:
 1:  3aa26d5bff !  1:  881d2b5426 config: clarify memory ownership when pre=
paring comment strings
    @@ Commit message
         not like this micro-optimization really matters. Thus, callers are=
 now
         always responsible for freeing the value.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## builtin/config.c ##
     @@ builtin/config.c: static struct config_options config_options;
      static int show_origin;
 2:  8f0804ab48 =3D  2:  66dffaa8f2 builtin/config: move option array around
 3:  ddcd8031d7 !  3:  36abda0e02 builtin/config: move "fixed-value" option=
 to correct group
    @@ Commit message
         builtin/config: move "fixed-value" option to correct group
    =20
         The `--fixed-value` option can be used to alter how the value-patt=
ern
    -    parameter is interpreted for the various submodes of git-config(1)=
=2E But
    -    while it is an option, it is currently listed as part of the submo=
des
    -    group the command, which is wrong.
    +    parameter is interpreted for the various actions of git-config(1).=
 But
    +    while it is an option, it is currently listed as part of the actio=
ns
    +    group, which is wrong.
    =20
         Move the option to the "Other" group, which hosts the various opti=
ons
         known to git-config(1).
 4:  1bc3918840 =3D  4:  34b66f9c87 builtin/config: use `OPT_CMDMODE()` to =
specify modes
 5:  3754812309 =3D  5:  4f90f206e7 builtin/config: pull out function to ha=
ndle config location
 6:  cb1714c493 =3D  6:  df1a6f14e6 builtin/config: pull out function to ha=
ndle `--null`
 7:  b3f3c3ba6a !  7:  1df76a9970 builtin/config: introduce "list" subcomma=
nd
    @@ Commit message
         builtin/config: introduce "list" subcommand
    =20
         While git-config(1) has several modes, those modes are not exposed=
 with
    -    subcommands but instead by specifying e.g. `--unset` or `--list`. =
This
    -    user interface is not really in line with how our more modern comm=
ands
    -    work, where it is a lot more customary to say e.g. `git remote lis=
t`.
    -    Furthermore, to add to the confusion, git-config(1) also allows th=
e user
    -    to request modes implicitly by just specifying the correct number =
of
    -    arguments. Thus, `git config foo.bar` will retrieve the value of
    -    "foo.bar" while `git config foo.bar baz` will set it to "baz".
    +    subcommands but instead by specifying action flags like `--unset` =
or
    +    `--list`. This user interface is not really in line with how our m=
ore
    +    modern commands work, where it is a lot more customary to say e.g.=
 `git
    +    remote list`. Furthermore, to add to the confusion, git-config(1) =
also
    +    allows the user to request modes implicitly by just specifying the
    +    correct number of arguments. Thus, `git config foo.bar` will retri=
eve
    +    the value of "foo.bar" while `git config foo.bar baz` will set it =
to
    +    "baz".
    =20
         Overall, this makes for a confusing interface that could really us=
e a
         makeover. It hurts discoverability of what you can do with git-con=
fig(1)
 8:  0e6da909ac =3D  8:  29676b81e0 builtin/config: introduce "get" subcomm=
and
 9:  8a623a31b9 =3D  9:  94afb5a5b7 builtin/config: introduce "set" subcomm=
and
10:  e25e5b69cd =3D 10:  e525c2326a builtin/config: introduce "unset" subco=
mmand
11:  f24008d356 =3D 11:  a797889890 builtin/config: introduce "rename-secti=
on" subcommand
12:  fc2ddd3201 =3D 12:  8ec214755e builtin/config: introduce "remove-secti=
on" subcommand
13:  4c2d817eff =3D 13:  1893c23afc builtin/config: introduce "edit" subcom=
mand
14:  4c351b12b8 =3D 14:  97a48ab81d builtin/config: display subcommand help

base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
--=20
2.45.0


--lhAmxoB6Kpxcbodk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4mxYACgkQVbJhu7ck
PpSwJA//a3jfqvOyKfSL6W4q+IMv7O9VzPq3Xb7roqfMn/WQ7qfjtXt368dPbRsG
BPgsP2HI/T6LsI8VIEL1JR6otVhr/2Tnwizv6I4x810oz+dY/vCOawFw3OY9RlRa
nPWB2/g2qI8r1JSoFUurnLb5iOD0MJjhqJdKZ8aK4Ezq7d3SvLjvjmkR9lvAOEEf
sIWZqwMcBNsfOkLR3o38uoMJZBQ0IVzUb3rO6/eP4c3OrnT2goXwK4vKuyv1o+Fy
Egty7HDlePxEX6fi07PgYLX6q1zSiVrY8rqYgZwlG3e0luldz4Al8pP91yr5Vryn
uONYUTK99O26pDqTAvVjcr4GwwyLWkxeyRzRIps6S6m51yrQfOIXgczW41KkKQEz
qCa49jP4eA3tNDoVKZsy8BEMXksmwIxnh1dbw4smyzmTbLuw57/2v3dZFOW4U1IE
B5eEtE/if9M1vV0UiiGV8PBKaATIJA1NrLHET+PExIMEwPM2W5O38KGmy9UFBg+R
KOfbQc0ydDCzRgORlfujlbrZ2FhauK6KXW0+G7b+vE8zmgGPePlkDlHJEFJkFCaL
VEaDkj1judyQjqUlL3rhjr7RcjkK7/aQvYTjTgNpc3l3QFEQsdz5iesxJJEI3clX
VvhEnOf9mgKOzydh+yMWHQxTBJGbPFRKhaaWY8sAhbsf7Abcz5g=
=yW+T
-----END PGP SIGNATURE-----

--lhAmxoB6Kpxcbodk--
