Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A578139CF8
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730276; cv=none; b=SXU/kBKY9+FAF6nV6/hONztmIKp6eSaYfsB32YrR4NgNENc7bS4uLcUilkh261Y0120CVuAqYpkXA22AguER+rF3iZcqjHTb7ePByUO6rEEdzKSxURSwC5pMzlladMFHoPULjTiLJKnwiI+VcRwy0KXnmSygV9fQsYElfO03b7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730276; c=relaxed/simple;
	bh=SqzoeJdQU58pAcwr1wHgf/oIx0BAvewSxbwG7sJYXKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxCcX7u5E/mUpJaUY4zreMHGeNC5n9WrmGRxHAXYZh0ptT68gP08gsCaOlelz0TrNW5RMSCtGY0TzKUes2hnQa2v8xpihEhtZr5+d5OLE898GZR8qvphqbKy6OwDctRpLdL4BM3+a3UKtZOUKidjxX0xqfl/vpEUx3oeM5Muvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ROfego3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xa/vjHch; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ROfego3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xa/vjHch"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 6C49A1C000F1;
	Fri,  3 May 2024 05:57:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 May 2024 05:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730273; x=1714816673; bh=NuTEWGCkC5
	s0dMDGci+/bSPEAZ5zDL5vwbSA58wcZVk=; b=ROfego3+wzSCq6cyDMGqRKRKca
	N8q5sdKRHDEGrNMnavfbNkYZ8B0JTieLT6dTq7XinxxlCQr9uL/5ITMdUygUvQvR
	ebhzl/7WHBFD2hjefekFI0ZnRk6KVzDUlPGss+m1gUTkaLij1ayRqu1YpD7stnNH
	s32Pniw3YlBBDb9rHC7wobmHiT3/zsyYYIRgHI4L6pYFXhucyr7mU6T8vzt/kxit
	nPcRxfwI4UW5krPiUTdWD+nHOkVZvPZqovHmq1WISS9FQw3QycO0+gcSKYT/EAng
	dFqIyiEtJbyir6E/ZFWmaogEroX71pRlLw23JnVcatfhXdz3j9L6tm80AxYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730273; x=1714816673; bh=NuTEWGCkC5s0dMDGci+/bSPEAZ5z
	DL5vwbSA58wcZVk=; b=Xa/vjHchJ7RkEU6Ek0J/AR2GFT8qD7vU5myBNDS2znos
	5jS9SDtFKDj2w+UpxsK5qiYpr/NEtHk1vkuP2n+Yge8D6Jxp+ObpgGSmFZ8Wd8E/
	SOrMETkAR9S17kxiae1xw82O3zRN78vrbnf/wOFgFIgwheCbuDZvcfEC1I7qc2Dy
	0rQaNlM7egsfFZKm3u7xe749zQu28T8TNE9exA1D1MaeW678grrYvsXUiwutxcdR
	+fPAYp53Xow8nNuQSaFARYg1eOGMjs2dK6t+x/MYOqPi9+Z30GDEh4jI8ivsH3yS
	+yQOkELkYnUrH952wuC2M+l6s7JofIWOF7Z9stbUBw==
X-ME-Sender: <xms:ILU0Zqkyga5NbrvmfnIVbAZeK7UYXsUNyAswGKimGsR9fDu56wUnRg>
    <xme:ILU0Zh2ESOoKeyI0A_R9jzX05BlncHmFyBKLmk-aaglRwvpt9DKePScXYH3JRabe6
    lV4oi9bT79WOJ62nQ>
X-ME-Received: <xmr:ILU0Zoqmrs9W39ThpYZx_exf-zo1W3VjMAUluqFcjiOechBvOOVRvnTqYLgoP5qZfDbzcP3Fa3ZMQHuh6C0BfRO6GJCVsLRHnKzy2HZRFLkxtLia>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ILU0ZulQGM-9GjJ4f9n3J-RXxvut0GG-sFRnyWuw2Pnvr66z74z1bg>
    <xmx:ILU0Zo2NG-edK6xDYA-vN-1q1EiKPy0gJ5yrhTsgWQUQOvtUHTAMiQ>
    <xmx:ILU0ZluPymyXQiKkhEqCvWjLFuF5rkGlRWAQo4CIVM032c07EGDY_Q>
    <xmx:ILU0ZkVdjNO7nE290kf6kVBmwn9gsRsxa2FLm1d3tXNbX91gc9u4pg>
    <xmx:IbU0ZiqUNFE6-OGgA-NeNHpaUkJbMy14F4k_noDVVBOdkELjZGLsNklO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 766e6ef9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:57:23 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 14/14] builtin/config: display subcommand help
Message-ID: <4c351b12b825ecea04f1ccf85958dd0e2f718ebf.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tvl9JOf4Tmvone5o"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--tvl9JOf4Tmvone5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Until now, `git config -h` would have printed help for the old-style
syntax. Now that all modes have proper subcommands though it is
preferable to instead display the subcommand help.

Drop the `NO_INTERNAL_HELP` flag to do so. While at it, drop the help
mismatch in t0450 and add the `--get-colorbool` option to the usage such
that git-config(1)'s synopsis and `git config -h` match.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c            | 5 +++--
 t/t0450/txt-help-mismatches | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8f7fa8f31a..80aa9d8a66 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -23,6 +23,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
 	N_("git config edit [<file-option>]"),
+	N_("git config [<file-option>] --get-colorbool <name> [<stdout-is-tty>]"),
 	NULL
 };
=20
@@ -1093,10 +1094,10 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 	 * us when parsing the legacy-style modes that don't use subcommands.
 	 */
 	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE_OPT=
_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
 	if (subcommand) {
 		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
-		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE_OP=
T_KEEP_UNKNOWN_OPT);
+		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
 		return subcommand(argc, argv, prefix);
 	}
=20
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index a0777acd66..28003f18c9 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -10,7 +10,6 @@ checkout
 checkout-index
 clone
 column
-config
 credential
 credential-cache
 credential-store
--=20
2.45.0


--tvl9JOf4Tmvone5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tRsACgkQVbJhu7ck
PpQoJA/+JdJolnanBTRgkGzJt9yJaL2PLPCRliVjZ2P5YFYbQBRu+F+CQMUWrX3+
MDksvXAJJ1ETI7OnRAL1GG3M8VOs2QlckxVMJm+Pb/j1BJabMKCKwHQ6kXZYbNXS
j+68U+ldsRzcCzr2925qMiT9CRrNoZWCBvTuPklzHczRA2pS5NBkY/NgsOss/5zc
SR4AsONi9BpFCoMhzolCpPV3s7+9Rh6zlBw9T0DespmIyHBsc/pCdMbNmPN1ZM5q
aPJnPEd5cTmr7Y/JCFCvKOcvv6IjlIUIcXzhx2/jssRSKjrihP2vYrYDJM15h5Nl
g9NerS7a9zotSxt0XOjVcQWnqnH/xwXpKtmO5Y2ue2zXbg7qnXNX2ww2ejDPO3+I
Mn0e+/fvwY81Uj1uT077prm8SKhQY8+yzUNIxV19jNn91F/jep4XSBtULWH0Y+6f
4kWTKbWkEGGL6SQtxU7FTa1YzTTxyCirnhcVxT5O5+3FF/RS67TnYZXytLdkZxFY
3wlTv6M5GmCLci6FFhzglWWMRtEWu3m7CuIAfcjWgC7slWuHuEGg3Qz3Foz3wkMC
AQ1tXGJhs5doR2ca2KkQ7oMm2h8hH7toT2TqfM/hMJqR6++P0+8kqRtyCnEUGxyI
UzZJg/LE806ecf/zZi06jtKs6Yoq6K8AlgPf3cLmdRzDpA7eE1Q=
=sEYo
-----END PGP SIGNATURE-----

--tvl9JOf4Tmvone5o--
