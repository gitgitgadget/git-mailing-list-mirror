Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C613AE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372507; cv=none; b=Fv1NDySpfzKqtLVVcIMj8uOwwhT/b+fty97/+ebOrj7F/QpC66BYuLJGc0UWwSXB4NDJ+6UaIFodU0jBx+BpKcqbkqAbHSzOahlsxxFvROnLiFYxtk5+t+97Qa8BWAs6WN6AWJHN8VbbPkFIQgQR8rEoqgzwNEQKNhKiNXRrNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372507; c=relaxed/simple;
	bh=isQHdSmmrVs6v16y2VBJ+FP37sL/XlZISe81GIsMspI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eil3W9XtI3v0f8op0dxLIeLa/SuPwQ5gSaLVEzpo36F7Vw5EJCIJsBBxhDMwgwPybxZb/OB8XackxPoG44VNdskuLSVhYniKBWw/+t+Ok3RKfLZNKr63GEwcHy5JDyVyZBFRUrcwMZ6C8KgdP7todWFSXYY/HPwcHH2c2IZGgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ctAkrWnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cusA75ss; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ctAkrWnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cusA75ss"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 256BF1380388;
	Mon, 29 Apr 2024 02:35:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 02:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372505; x=1714458905; bh=kokswTQD7E
	Pv7bAe5D3gUUukw1sNp+ecLsFG96KQW3Q=; b=ctAkrWnRu2vCFqcA6a7I8guBRr
	+LpsIXTfsorGc9qzThHPZxENGlidk6OaSUzBfb5Ov9xgbp7VVMlQytZGaUE8hLCr
	H9pxeo78unLASUCFoZXFE4P1vfxEAgAQvSUt0s0bYzuC0fSUPLxEsQ4nfu0W8Sko
	fs8TRV3QWvCTIC/h9pp9Y69i1i2IAXBMPh5JR07E81uJl8KmaZcjkwC8GZp1kCSb
	ZyTDnp+8DDMTlWPN922cKSUGQoy3Sld4BKgXDpIAgEu8CjFxH/2l3OkgXCB8tU84
	7bVCcJxOfFXK1wuZo4Z4RvFvo4SaR92Sz3vtKD81wnwdEGxKJoNabxJtkNlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372505; x=1714458905; bh=kokswTQD7EPv7bAe5D3gUUukw1sN
	p+ecLsFG96KQW3Q=; b=cusA75sskCj4PdNkle2u+JB6ldiOzY+fIg7ka62I2X+E
	VHWG6lbcCYK22+b9NVveEqmsLpwP3ZVJPtG7lZx7lQtC1TJmDIyMSb2sxM3/ovRX
	5OCb+FCKWfAc+qQaT9IsBdGInlzLeNuZu9f/YHUPRnIzYMaq+3gY0PQI7h/D5kSc
	PddpeaaF8kJkGsSILupA+2g8TqF2xJLd/XicTB8cGFI2frY826Dekq9CWVlL6wr5
	Z9VtvTTlTjNuVOnJeEpC+FOsBsjdFW5DP7iK+BD6EWC33LyefhLKI5kTCtb0+dJb
	oLGhZRU5i1wEECwKxE5LXcBFvOrNB9XYvmA/4OPnlg==
X-ME-Sender: <xms:mD8vZoIzfe3BgA-_y2TNXkQiA1Np3QSFjLq-7jr0ur90eyusdFvEbA>
    <xme:mD8vZoLWYxo7OxzX1ytURekis4GIdvs4-_U6trvBMZIqNbN2qw0dadqXQ1-1sBwCQ
    uJtljcxMY9Ag3iqjg>
X-ME-Received: <xmr:mD8vZot5c2J7yTteJKBLDX9pipYpkeQlUKRXBzX1IK6vex963TBs1jNl4coidHvbY-qSQjD-a5b7DjuZjWMFZGumfX07qh0OPk-QpnlQKMWNFUsG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mD8vZlYOZYU2vMjkJtgoFBoRlXg3Gfw4tiXPesb0oTSTEE27A2XXMw>
    <xmx:mD8vZvYidJ5kcYRjgZPgcaH7n-VAQly3qqHZuQLOS4inZA7Bhy31Lg>
    <xmx:mD8vZhCDit5vr2J3byD_iRRofiADIU9MLR5aelH8H33mi_e2W80CCA>
    <xmx:mD8vZla_F1gFAPA1bWO_1KfxwvoHWaOHzM1Sr7Wrf4K_-96mIX_9PA>
    <xmx:mT8vZuWiRYHU5TtY-j4mfwyUPmTEdX8FExEjaBouI31dqTPMtQ0Clcbt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:35:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 46807731 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:45 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:35:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 11/13] builtin/shortlog: don't set up revisions without
 repo
Message-ID: <509c79d1d33a69367726549fcf87f932f83db864.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TyZZlefcpI/LdO3L"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--TyZZlefcpI/LdO3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is possible to run git-shortlog(1) outside of a repository by passing
it output from git-log(1) via standard input. Obviously, as there is no
repository in that context, it is thus unsupported to pass any revisions
as arguments.

Regardless of that we still end up calling `setup_revisions()`. While
that works alright, it is somewhat strange. Furthermore, this is about
to cause problems when we unset the default object hash.

Refactor the code to only call `setup_revisions()` when we have a
repository. This is safe to do as we already verify that there are no
arguments when running outside of a repository anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3c7cd2d6ef..d4daf31e22 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -435,7 +435,7 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
 		usage_with_options(shortlog_usage, options);
 	}
=20
-	if (setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
+	if (!nongit && setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
 		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
 	}
--=20
2.45.0-rc1


--TyZZlefcpI/LdO3L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP5UACgkQVbJhu7ck
PpQupA//SXqb2ZHlsmH5C0uEJSZYIo1Szf3++IdWFO0x2RQmJT9Bgp/foP4z8ntb
PbXYrVhVzU8GCoJnjwSftiIqRKMG7uL80sbjFu5pSqavKj4jZaCEdo4emjpkM5m/
SErqymLeIHdGfQ1zsa5+0bpqvTTQfOmWZ5DwKvJ/7Z0czlFiBREV/DaeC0VBYtMo
XVvpeTYHxUsiIe2BbacKapGTtfc+aW0cDEQ325h5TCHX9ZL2B2+1mYFCC60E/7E5
hdfkJ917541r69IyH25xTKvzjyliUzPKHuPgH4k7mi4nKP7VD0Q7NB9qwclC3D8X
vfwYfcbMm3b3sGhPMczzRBeBVH39KLpxD4eEm2P5UhcZR+rjX6wbbm5gy55vSu+y
XQ8cEHo3I7d9lKFSXHCvGDTNk9K9/T3OEeRBW7UtoCbtLX7QopuqTEs4Y3OkugIN
Grgw4FZ08ft11R3j9HOAofLrTralBMrRAcXQskm+L9iJdp1ie5aBE7PW0xrtBieO
2HXv4K0miG309sz0hv8BmWJ7hr/ovwvibiyh4FzZMiqEkb6dz0MhjPGn1H6hgFim
AsOPPweG0NJ+5y41Zr62urO1Kp+syo2pc0DUCflDb0uAVTTDq6W6puP4j6owoxvf
Zn2tbh/v9knFR5EckRdwrQz0VDlUagkPYOClduaSvz+xXLdXUh4=
=4OXi
-----END PGP SIGNATURE-----

--TyZZlefcpI/LdO3L--
