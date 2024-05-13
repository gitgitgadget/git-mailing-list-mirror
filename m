Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AC146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595725; cv=none; b=BJoi8itkyY/CVzNDNUXALauUs2Rj+xuDUk4Qf1DMiJ7BoFVYDzLBWiXbYgp3DuL4pN2Ls3G9+36XQzmpJG8ZQdGohRHqZ6DV0eyGeY4agld4P8WZXKH+8Gi+sGLS0aWlHgSiEohMAf/6iAa/IBQ9QE7T7qJDqoGgHkjPCZdc5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595725; c=relaxed/simple;
	bh=k/9KdUE2BRmVR8/pt2+jmX0E4OX6qYXrM86bKCS2a3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY3+Z8DyqAvHILzZJ3JYHPiBMV1nDr7KuKe3P0vImFaVqhE+9/Ev1Oa3G0ViR1mEzi5B8dwdqawXmLrKjwws1Le0EGIriGiKsLQ65Y4ekoJtuKNqKOQKwhcj9hwjjH9QkOcSwlCNwKgqeX5AizJtaQrdGmZihJBnRzEyxgMtgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DnlljjTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1e7PbJB; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DnlljjTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1e7PbJB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 09D9E1800076;
	Mon, 13 May 2024 06:22:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 May 2024 06:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595722; x=1715682122; bh=/0zq9R9/EJ
	ett9kUp9kShmtP1pfSlbrGRXfO5UepYT4=; b=DnlljjTOxsjTCNj7vUjeUKx3Wr
	D9mI9yFM3ZX3ljknDMmo7ptq7vrg0y3IoXgkli2GeKjxCzGnQt79gUOwfFo7qLuz
	fWrWyRozlBaiLh+4O6sGoefejE0ZowHSrLJkKsDcdKFT4ZPdfqAXmZKr3Uas888f
	xRGQxurmOwCOEBXSNnkuTwJhUUqQo56MTadcx2Yt0tUhQf5H6UeU4P6VsU7dLyWd
	MxiB8tIlMNJB85MKXr/1c7tiC/6yMZu8U4sSc/ycKO5Uy2ii6/ypsyri0s2D7zhh
	obBAer239i/+t0zRLHSsDQ19Ti62Kel85COw15+ERZTMMjpT3RgXvUmzWB5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595722; x=1715682122; bh=/0zq9R9/EJett9kUp9kShmtP1pfS
	lbrGRXfO5UepYT4=; b=F1e7PbJBKLWjy7bLJSnF0ra9/FTgvto/a9a8A38htiBw
	aGtYfln1XCcPUKapsY42vO16eH0vA4NXD9q+z86KXkJHXKaMEXxANmw4JvNzuS8D
	5QpPvGSmlPuZl1/au8ncEl9tE6kf56hLXUulFiLi9YQCeFH5fmobTkO3ChRz/OrR
	gXNSbhKuX4qZBiWf/CSKEjmYo1xpveZb9sq11jHpAStmYkmx9XE5StpSpZtHirlU
	mCKcxqc112mWoSZ+kBZTVhAcJ4Y6VtNytj45Jv9Jy9WdpHpUF07Feqb1XckA1PgX
	XRSvqdteWtibeWeQIaYRFZcn7x5SBXjfS48iSba2zA==
X-ME-Sender: <xms:yulBZmStfZlcydOecMONLeD3zRSY4FvhMP5VgZ4IzeMA1gpiSaRQFg>
    <xme:yulBZrzHcBxsoIrXqPH7p_rJ9ixKc-HSkcxrApd2yyKkZr63vYEns5RKwmPLNbBuH
    yA1HSyEPpncbtxRqw>
X-ME-Received: <xmr:yulBZj1LKJDKb4WRKMC8f2d7A-zGAN4ADoJp5P4Sr179tyx1rq9hcIf5yq4tJPZUAdKOFSbVNyq9XPqKBVEPL-nbyqVQnQeWQDoHgSsRuIhIPzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yulBZiBD4BunCk1Ofj5SsT1U6wSpEzSCZ8SxhqkEnonfrpq13RragQ>
    <xmx:yulBZvgYjziLVWPGsGI5jZAm8Nqiyp3UVrSVpiElknb8-F66nGFK_w>
    <xmx:yulBZuoN4zrA5np1PZi5Q-fXDKhXaz01Q9wajTkhwleILfKx5Dn9PA>
    <xmx:yulBZii6gkNpFIG_eDnRdFvGfswbW5Mup_PfzZI3Nv4isX7UQZBfAw>
    <xmx:yulBZvdlMvpLk9v6aWLJco_Y7e_r_t97ls8xQ-baOVP6MUJlIMHsQftQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b867f8f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:21:42 +0000 (UTC)
Date: Mon, 13 May 2024 12:21:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/21] builtin/config: remove global state
Message-ID: <cover.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NWKybpXT3laP/bqx"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--NWKybpXT3laP/bqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that removes global state
=66rom "builtin/config.c". Changes compared to v1:

  - Reinstated a comment in patch 5.

  - Fixed a memory leak in patch 9.

  - A couple of commit message fixes.

The series continues to build on top of ps/config-subcommands.

Thanks!

Patrick

Patrick Steinhardt (21):
  builtin/config: stop printing full usage on misuse
  builtin/config: move legacy mode into its own function
  builtin/config: move subcommand options into `cmd_config()`
  builtin/config: move legacy options into `cmd_config()`
  builtin/config: move actions into `cmd_config_actions()`
  builtin/config: check for writeability after source is set up
  config: make the config source const
  builtin/config: refactor functions to have common exit paths
  builtin/config: move location options into local variables
  builtin/config: move display options into local variables
  builtin/config: move type options into display options
  builtin/config: move default value into display options
  builtin/config: move `respect_includes_opt` into location options
  builtin/config: convert `do_not_match` to a local variable
  builtin/config: convert `value_pattern` to a local variable
  builtin/config: convert `regexp` to a local variable
  builtin/config: convert `key_regexp` to a local variable
  builtin/config: convert `key` to a local variable
  builtin/config: track "fixed value" option via flags only
  builtin/config: convert flags to a local variable
  builtin/config: pass data between callbacks via local variables

 builtin/config.c  | 968 ++++++++++++++++++++++++++--------------------
 config.c          |   4 +-
 config.h          |   2 +-
 t/t1300-config.sh |   9 +-
 4 files changed, 550 insertions(+), 433 deletions(-)

Range-diff against v1:
 1:  0ba7628126 =3D  1:  0ba7628126 builtin/config: stop printing full usag=
e on misuse
 2:  663e1f74f8 =3D  2:  663e1f74f8 builtin/config: move legacy mode into i=
ts own function
 3:  1239c151d0 =3D  3:  1239c151d0 builtin/config: move subcommand options=
 into `cmd_config()`
 4:  82964510c5 =3D  4:  82964510c5 builtin/config: move legacy options int=
o `cmd_config()`
 5:  2e308393ed !  5:  0a6ecae2cc builtin/config: move actions into `cmd_co=
nfig_actions()`
    @@ builtin/config.c: static int cmd_config_actions(int argc, const char=
 **argv, con
      	comment =3D git_config_prepare_comment_string(comment_arg);
     =20
     -	if (actions & PAGING_ACTIONS)
    ++	/*
    ++	 * The following actions may produce more than one line of output and
    ++	 * should therefore be paged.
    ++	 */
     +	if (actions & (ACTION_LIST | ACTION_GET_ALL | ACTION_GET_REGEXP | AC=
TION_GET_URLMATCH))
      		setup_auto_pager("config", 1);
     =20
 6:  edfd7caa39 =3D  6:  7ab99a27c1 builtin/config: check for writeability =
after source is set up
 7:  bfba68aa1e =3D  7:  1460d3a36c config: make the config source const
 8:  6bff0410e9 =3D  8:  018ed0226b builtin/config: refactor functions to h=
ave common exit paths
 9:  a96c122280 !  9:  b5d43b6f85 builtin/config: move location options int=
o local variables
    @@ builtin/config.c: static char *default_user_config(void)
     -		given_config_source.file =3D git_global_config();
     -		if (!given_config_source.file)
     +	if (opts->use_global_config) {
    -+		opts->source.file =3D xstrdup_or_null(git_global_config());
    ++		opts->source.file =3D git_global_config();
     +		if (!opts->source.file)
      			/*
      			 * It is unknown if HOME/.gitconfig exists, so
10:  06c1e08fc4 =3D 10:  d66e14af30 builtin/config: move display options in=
to local variables
11:  9610897662 =3D 11:  63436c3416 builtin/config: move type options into =
display options
12:  eb79462861 =3D 12:  106b8ac8a2 builtin/config: move default value into=
 display options
13:  b9ebfbd667 =3D 13:  8a6b555b58 builtin/config: move `respect_includes_=
opt` into location options
14:  2b40b784fe ! 14:  0dd22bf51a builtin/config: convert `do_not_match` to=
 a local variable
    @@ Commit message
         builtin/config: convert `do_not_match` to a local variable
    =20
         The `do_not_match` variable is used by the `format_config()` callb=
ack as
    -    an indicator whteher or not the passed regular expression is negat=
ed. It
    +    an indicator whether or not the passed regular expression is negat=
ed. It
         is only ever set up by its only caller, `collect_config()` and can=
 thus
         easily be moved into the `collect_config_data` structure.
    =20
15:  71d1b7a51b =3D 15:  b656951f0c builtin/config: convert `value_pattern`=
 to a local variable
16:  c3b340f119 =3D 16:  b56a07bda0 builtin/config: convert `regexp` to a l=
ocal variable
17:  835cc0acfb =3D 17:  323cb05120 builtin/config: convert `key_regexp` to=
 a local variable
18:  2aee7ec5d8 ! 18:  e972e63be8 builtin/config: convert `key` to a local =
variable
    @@ Commit message
         The `key` variable is used by the `get_value()` function for two
         purposes:
    =20
    -      - It is used to store the result of `git_config_parse_key()`, wh=
ich si
    +      - It is used to store the result of `git_config_parse_key()`, wh=
ich is
             then passed on to `collect_config()`.
    =20
           - It is used as a store to convert the provided key to an
             all-lowercase key when `use_key_regexp` is set.
    =20
    -    Both of these cases don't warrant a global variable at all. In the
    -    former case we can pass the key via `struct collect_config_data`. =
And in
    -    the latter case we really only want to have it as a temporary local
    -    variable such that we can free associated memory.
    +    Neither of these cases warrant a global variable at all. In the fo=
rmer
    +    case we can pass the key via `struct collect_config_data`. And in =
the
    +    latter case we really only want to have it as a temporary local va=
riable
    +    such that we can free associated memory.
    =20
         Refactor the code accordingly to reduce our reliance on global sta=
te.
    =20
19:  625216a774 ! 19:  d83c3d085e builtin/config: track "fixed value" optio=
n via flags only
    @@ Commit message
         is not aware that this is tracked via two separate mechanisms.
    =20
         Refactor the code to use the flag exclusively. We already pass it =
to all
    -    the require callsites anyway, except for `collect_config()`.
    +    the required callsites anyway, except for `collect_config()`.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
20:  05254d512b =3D 20:  294bcd96a4 builtin/config: convert flags to a loca=
l variable
21:  3a5f059789 =3D 21:  0496b958e2 builtin/config: pass data between callb=
acks via local variables
--=20
2.45.GIT


--NWKybpXT3laP/bqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6cUACgkQVbJhu7ck
PpSTWQ/+NHw1kUvbCm+/MV/29refdEhrVHN+F+3gNjOuz15ehwIqNgEBnVIQD70o
X2mF+7/PfO3Jq2pTsHmUON5LydRY+qAkHSvasG61oXoGcGr9p29OcNx8OMFRCYyA
7TdR3tN3+mJ9nC6RCdan9Jz53UZaRGxaqEUpA8EW2Pgw4S3DYQfBGUVfABtNm8YE
a8To5w57BxRkeh3zkCcuJCynl2lGhDU/0Rk3eSoKOrL7B347OcSMotArgPDshBIi
HjWI+PASTMKCM8JPGo67NzsdOaBIJmrYffoARUa0KJSTAERzeovH7Q6yN6zIirNc
G4wFBX0eRwI9NeOjPZ/7DgjUP9kDoeeMr9YA3UqyK+l+ReoyxjBJCnNiC5q/oyZB
3y6rO85dVmA3xdioCE09GO+SafUdMFiDtpvGPyrx5wHMmDCEiDebOGyPhlqEo5is
jT4weeAikklG+nhsJaV6PQ0il71UXSb0A4iSMQdrk8Gtv4kfkGp/F3ybfpBFq0VT
4oDeT4o7LsR3Bsb5c01+ycZdvo6oJDd45vRjBjHZ1ULEaySMn1vEhPJKOGBPsBNA
SrEAXJQ8eEX9HhEZLeDvbCmi9JgH8VhLhSpVd826O3et54zXW9Z4b978niBy9n8k
/Qb3ZeglSR1jzmvDXfFM+GBcC4NXZcPK3YyNQIuxNb30v2qBWR0=
=zAUL
-----END PGP SIGNATURE-----

--NWKybpXT3laP/bqx--
