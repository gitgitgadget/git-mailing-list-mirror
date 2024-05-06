Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CCA1422A7
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985824; cv=none; b=JpewAGUDg0EtDOvxBfP67JIlrweTqLPiW7Vr9VrysiAeH4YKAnJOjbtWhTkAY0PwL/hj2N37YVG+380e9Y9J2GjM6FMa/3qqayVClCGZ+zDaK+usoy90+BUQfhjCKoeZrYqA6vPTjodS1AYpkMtL7GxMiN/3GpDRsC8OT0QGuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985824; c=relaxed/simple;
	bh=8YV1WOX1PwIJoDkHtFa7J3R2eb5BToXiqs4c0K2Tqfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHRfVtUBE9KnBPNXOYA4+pszTbEKAT1XTvfN1yXa7k7N0oWgtyViH9AtRwk2MJT7LO2RjEdQUnqtmrdYkABcyzm0xZyhwEJPjUggntE9LvwrToOa53OBxOy7HZsisNC0O3EnpeTpEVh9Iz5FesnZbnaeg9DViDYJJVO3tjBBxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aS9X5U9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WcEAUpMv; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aS9X5U9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WcEAUpMv"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7A07618000C6;
	Mon,  6 May 2024 04:57:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 May 2024 04:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985821; x=1715072221; bh=/5d+HXocPQ
	RZnKc3WRy9DN7Viy5bRByg6Vdy87Ax0QA=; b=aS9X5U9lz2RfKyUCmF/TbCoGth
	ue98KZvRgiDW1TidBgBiDKw2aEjqbZcVNmNLWX7S16t959GUuLsGu1D6C7/2DyOM
	axTVQgqdgJyM5W51jiJJ7CXwHQxPyv34YYrl3SjCHCJV/tOW2TdWIjMS2Iy07wbr
	vU6R8ZwJ60uBR61XKQeESSAnhP/ZiaitEzgxllwUTHoPLyX13SqfXSP9fCJ0tVvu
	q/3cFsdOVozD+itThiUAoBpkfXwVnbzCKvgXdQYQ2Z2NarJbRO7bFiQlo6u0+6sL
	Ql7sRU53ZjCWlXU0DSkSErd00jBIjKjzRU23N4Gp9+JbbiYS4J76BAVUY57Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985821; x=1715072221; bh=/5d+HXocPQRZnKc3WRy9DN7Viy5b
	RByg6Vdy87Ax0QA=; b=WcEAUpMvEz63PW7d/jLUy7J8RvjjAaipagOAn+x5LFMp
	tcyhVukGMiKljRTOSACy6CTkGTsTZCBGib2qaqzxqUTpIjRf9eA69E3F2RTLeOWV
	rsLIAsfMmo0nphcXM2WX8se6qw52amIt/BrSNdY1Lxsi8/WtZvjqad0O4D8UuyMA
	vwaoosz1of0yLhyZJKPyTcCZNcewMGbiY/zTAmMjPoulPTiP1sakmagGcZSVmI6Y
	JkdyP0oOEWXNj7VGLE84q5K1Aa+tCMHj0f4HJUI3BdH5uWveo5cUrr2IN3dQh0HY
	JBlJJzFkAj17Bs9z/pMxuxiZxd85lKTbXVS7FidW6g==
X-ME-Sender: <xms:XJs4ZuqkaJjd1AWCYM1-r5qFtg7xk6ZTjyd8Une0MyoJsDt6QO6arw>
    <xme:XJs4ZsqPZiQ5R5FaTAmD1alARuiIpoMsBTu_wxHaiJvlBrnZaXkvqMrtTTnxqL7fR
    -nwZs1jp3MV1VbMYA>
X-ME-Received: <xmr:XJs4ZjMNc1b7ZMuCVA_Ar9iapdDxY2wTyb3InpuNBUN52oFTNOAqAHBdvRUxcCxA2mvMFYI19JmHpcKMTVpRymMZLVOdmbn0tUFzehBD8GlWqzWF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XJs4Zt7cv9Z-DtCh4yp11S1UQMMARyZKw54cMWfRx1fPJbfZ0MVwag>
    <xmx:XJs4Zt5CDC0s3xNELRtZZ4xnl4nimGCZs-SLfS6_bjxy3o_IsqT9CA>
    <xmx:XJs4ZtiI2tuj4ztz7pfgrLEW5D-4aV6aGz0NnddXD5hmAq7bU6S6GQ>
    <xmx:XJs4Zn7lu9wcuM5OytxcgSA8v4XS_5QdxFMxWxLnYDS5TY27wNpPMg>
    <xmx:XZs4ZnuoGyzTBCrKDpHP86axwBNq1iXym8BvGvfApKzcpA4rDblKohyJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 66896b9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:54 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 14/14] builtin/config: display subcommand help
Message-ID: <97a48ab81dba0ab03cc3c1b648555a5fab79ee0a.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zleWH/sTWi7NY4MV"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--zleWH/sTWi7NY4MV
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


--zleWH/sTWi7NY4MV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4m1gACgkQVbJhu7ck
PpQcLg/+MI25yC8Qyhg6r6mJIeMc64r2vpyXNuZ48017psNWNcdBgOFe3Z2fdQAh
WnSDRjIFxVJzxdIHRwnwQJx4yBD+phoxI8A1EVsr9vti02QLlMzX/NKtxffRNFOk
/2qEpp37Xi63aBVRJASVyVccgFcMmN2aiaHGKzCRlqJRm5A82wKN+dmSv2Bw2ZNR
5NIZVJ8EGBKQ6ZYxG42gJvnLHyvH9AUvskQV34RSxJKlBk5YT3Ascldc1zEHr/E2
69dVTupQ0IzU5Z/VPl2eeesm8YRKwvIBHJFxyjVSytCFYoP2p1wCLYSUHx3CqMkJ
3ExIb5Rr6ZSw7ENqge+LGEbOjCiNqw9EBY41mIPYuApYeEUyylk3Uwo37AnJC5EX
aFv61EdOcj617yoUFiG3kOaVCJd0YMNTZHqVHBOhALy92Yb36a0wZqW+gVSh3o7j
24s6GWKoTTbgv6dyGq1TogcnqnDxHS4bIih9JdpNWqGOYDM2sqmvANPnpdR+b6gh
dHr6W7HbZWLbgkGcvlTnLX0q4VHb+c6Np1pZhIFGEl64auIL4XoVtqsXPyCzXTzY
7eODq9J7vH6UIaT8I5LFPuBkq9QnlmWGcdqNG0MSEo3+SqWvVWjOjPUZ7Batwuxw
gj4AKGZd0XQFG2RIRbfm6WDmJ3QvYfDilvLD0NBJnR9HRTpQw8g=
=O4EP
-----END PGP SIGNATURE-----

--zleWH/sTWi7NY4MV--
