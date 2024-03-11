Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF259B63
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199235; cv=none; b=tDceRmZF2+xXD65iLJxwuhHezuwpQ7HB+UoKglvCt6DUDGKwGHMyTa7JMOVjWDj6u6q2Xl8T2zL+iLBtKP2DRSUUcjd9mMomPx2mnwpDMcLw9PiEZS+x0Ny+nkbGAf9jyzOftCW1rfDsN1WC2hMMjU9cfy8MV9jv+xQb4FoWgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199235; c=relaxed/simple;
	bh=sk0bv6hM/HrL97KLDG/tVGBAI9e8vvQWJxi2WJMJK64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3kHUCzDSSbO+PUMW/juqM439EsyjvM+vDcXtfpbUaOpkflVdsnKdzpw63poNal9eU03B2c2UU6Z7TQW7Gpgud8dgMZUax5Yw7ATXT9cEborkOlQBEpqoItNV4HoSGWorGfcmn8MBNi7xJgnO68Qx635QbegM+idZje5vixcSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H2XK0D4V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnIegKpg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H2XK0D4V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnIegKpg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B30C41140112;
	Mon, 11 Mar 2024 19:20:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Mar 2024 19:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199232; x=1710285632; bh=tPUe1XXeGy
	OLvRkQ0iOxVGftEHKbztg4B81C38/6mk8=; b=H2XK0D4VXw0B7xzSGfjvqEyott
	RyrlYovxc2oE+TL6xSAyr2/mzdO1E+okcdapMTC25hiq7sbNFFAa9kR70sPbkGqu
	1s+imR2suhAE00VzCDN3bPgSpX+VhTIxc9a70s7bbX5GyBj/jPGwx0brIrQcKtJ4
	dGlWdL/63lZPElpzryrsq1ANjYL4zsNIqS5Z8Oy5zJbSvH2AeQJB1ahhzW1JXcWw
	FWcxzFTG53jnVD1xG59UrVy0xZjrzqgf4jhLZC1WhkdDPc8M/FM8cnpBCXnjzjnk
	sFH+SZ5JN6HcnosHrdUs5DXEZZ/7bP93RUIRCL5pt3PSEXThwld4CCYA/esw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199232; x=1710285632; bh=tPUe1XXeGyOLvRkQ0iOxVGftEHKb
	ztg4B81C38/6mk8=; b=AnIegKpg/wKsRd7/XpDontkUFbxW1vdupnSVIsBLX2xf
	5RMu5q4OmjRqZ8PpyXUK0rZ74cdzL0tHd4BOU5bcM0qHn+0zjFBz2BTAH3KHOxlD
	+hEd538DjnGU0D70AUFdWP14NyQzkJCsCi89c0LYWh59ikGcXGC306CnUoYdolKU
	Hm26SqHTXeRj12d6oQUY0FN2oHndNGgTKjskQ3V5H2kNKsJ+QBJ4c36zNDnzNM9v
	3k8ZX+wA0xzUuleRlCCD1QPF3wGzpFLJRpUakwtNPkZ5f7BFsGL6+3jZQyov6bfM
	58sFhnQm28xlkHs7O2QirCsdWAW+ZweCaE9vynHYHw==
X-ME-Sender: <xms:wJHvZc6REHU5_xxwBBP0i_McE_bEetpCgBFcOd9l39ZtxDtV7rB4Dg>
    <xme:wJHvZd5E6xCihNWlIEWEmUieeP4HYAq4fGeZupqn24OnxNmNw_SmBzyL0fC4-TN_c
    fQlQydEW4vCCmECRw>
X-ME-Received: <xmr:wJHvZbceFIylWCXtzx4p4HpMvMOaRND2w2bX6WZpEAHuTyf84akOFBvXS-BDjAxaKYAE2HEPnd03s_M6k2GKBwnhVnLBg-W83u8aQ9zLJxNS2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:wJHvZRLqwP9ni1yEB20ctav8N7adP7cCu7FddG8V03bpLAlcT3K3iQ>
    <xmx:wJHvZQKaS9h3HY69LAiYC7QMgHM9_A4URSllRwJiDgP3zVkrxtrY7A>
    <xmx:wJHvZSz7TDvvDq-zUgYIWnSOl-3xSADw4-hZiw3kpAvLXLlSlx2M5w>
    <xmx:wJHvZY8GHtekRS1POYK4FRo5zYVjVwo7iyKvXdxaaIzd8ij8tjN2Cg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:20:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c66cbc26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:15:52 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:20:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/13] builtin/config: pull out function to handle `--null`
Message-ID: <283a199578cfe252204839c55ff83bd23fe2cd9e.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6X9FCUtno+jDY1LQ"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--6X9FCUtno+jDY1LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pull out function to handle the `--null` option, which we are about to
reuse in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 693df32526..ce2d3fecd4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -697,6 +697,14 @@ static void handle_config_location(const char *prefix)
 	}
 }
=20
+static void handle_nul(void) {
+	if (end_nul) {
+		term =3D '\0';
+		delim =3D '\n';
+		key_delim =3D '\n';
+	}
+}
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -758,12 +766,7 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	handle_config_location(prefix);
-
-	if (end_nul) {
-		term =3D '\0';
-		delim =3D '\n';
-		key_delim =3D '\n';
-	}
+	handle_nul();
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
--=20
2.44.0


--6X9FCUtno+jDY1LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkbcACgkQVbJhu7ck
PpRmQw/9HQwFPhaEmeiQSa9thscD+8J7O+Vr1cbhq+ZO9Auwc1QWS8ofx1q7xxMt
9rSLUNMfDwjAp0KQyrZCnej9JdoU329XJ9xbOYhK+M4ijtxmpAaunpDVLoPQG4Lj
Pk7wOufKuCOJRXPcN/mGIoB2wgUyJ7o3yZ50onzM4ghAZYFBuXxy3q+Vu03VV703
aw9XIuSJDAKX7St/lYN6/nwmATjlYcnHVpislTZlthrWQbqJChrK3wHFWM4oxtex
xnhJWMMNDGfPm1t4JnvU2rJIDaks/f0aBSw7KEjIhMPOu2FBMRNvsi7IgNrArmaN
zxwN9pqF1DNgIUgrHnEvuA7VbZ+/U7ywZPoFZFM5nOSFRU1sJO6DpFUf+zHRerzc
b9FCzkCC8TCxSofa2mPgs4S2y+DiA3ieiFZBihTOrdRIgKkwJNE9yWNoU6zoxcfq
7TJK9G6ShPCMymB98axghHFJMK6asDw6d/zj5GoWJgyIS3c6Ccjk/XI7YKKW7/2K
1jFku7hCYO4CqtF3tS6bmpIoldr3dB/naLouq3DOljrHeLesHziL2NJJ2jy7poyn
fR8FLpO+xIY+rT5jqQhF27iy5ErEusq/mIdBXMqn4LAsn366qH/rhXq40H7UxIMP
qJE30noSUUaF163J/g5PokctRAi3yYEyq+oPv36Ozo/BCSZTZl8=
=EJOP
-----END PGP SIGNATURE-----

--6X9FCUtno+jDY1LQ--
