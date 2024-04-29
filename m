Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461661401B
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372493; cv=none; b=WYbb8JZayS9DGmD7d1I/vVjGuRtkzmrNDGWKSNfR8TAdEgmPSpploGTH8jWOnqY0eOHqznEVGhGia4kM3lpjVdZJDiU1fnVLLVUjYVx+MvfgfG8y7HtOFlL3Z6bGxdMqQdta2t4r9sjSOSey2XuXszLxdmmiZU4GMvNi5dF6JW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372493; c=relaxed/simple;
	bh=/U5lZtIjplVReje8Yw+V41yujThh3zKcvDWCffnxYcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn/OV+kF3sxIRz0+RIXONd5BXjc3Zcr6JWhrxUBvdn1g5nPW7x4VMovDiRotnE3DNa2sP2GjCmMrHyLAJDfVQ0SmifhAC57Mp4pbrg3G0QPMSLbQTjUftiR0t6U3yqUZ+MteB+2tdLt6YO8ZqEhcDr4UeiHjv+HSgZgQqyKGjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rYSBcxdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPYQTyKg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rYSBcxdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPYQTyKg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6358B11400DC;
	Mon, 29 Apr 2024 02:34:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 02:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372491; x=1714458891; bh=AfJz6Ucui1
	zezMsh8KlI/jpM0IhFD+fZ9o1eOmKY8I0=; b=rYSBcxdbxsL0p/uAb9uthFb3jT
	YLZQ7JzBfFBLJC1bXtEOW/Qq++imMcUqA/ZV0jKZvjHWAuw5zlhJk1KQqkADp/t8
	l7+QaU/2wWm0ZMs1MO6A/sRgtaVRw3iPut9/B3EPTcZIsGaA0/uY2tGLcpsnI9X0
	LzNAopBn+c8hdEIZ1xfZ1/vgI0BU1bKtBH6ICWC6rbv20GrQEcvNniDITKmQ2Duk
	TbHGysNqw2SBhLKx0LbKtCyh3ImWM6eJ+MSWKxA5IcfObnur6VjsYlM6/ciEgOq1
	aHcPsEdp/3fSArsQJFn+zLyE+KFIDSFClN6LxZfgtRl+kjdgEltvHVMpG3mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372491; x=1714458891; bh=AfJz6Ucui1zezMsh8KlI/jpM0IhF
	D+fZ9o1eOmKY8I0=; b=YPYQTyKgosgc/ZU+IfVERk5tI0E/Cy0GP4OvCfVl0IVd
	TOnOT1V8OaFiAugpM2PUf9qPAun818jNynsV00LDX5eX0jNQ8WzskCg7vEPT6dHE
	l3HEl9lCi5B0yKMLCCacvlA3aAzm788X6t0XnsXjkCPLulqM8iLDhdx9di4UpOSN
	lSCIDAgqcKaB9tpRVRwEn1QG1e63MXBvAc10XLv0sM1c8hOcchgfv0h5oSz7vHqz
	kkI5auh70q4hlUrDiANeTRC8AKPKyGwxdjDu4Xn3JlZWWftyLQIsfrmvVV1y/Rt0
	9HateI/14F32HTiBn33/skSzPDer0K/D4es/iGwH9Q==
X-ME-Sender: <xms:iz8vZnxSSBbe2X2yxqtRrD5KLof5FoA1MmU5HgyXJsH2RsHaKjkTnw>
    <xme:iz8vZvSiLFHdeYpw1jiEju9TlC-V4CrJyzLw5I2bnvx8o8-2zwtIPAt4BGlPcex0I
    fdelocrnrrrvCnVdA>
X-ME-Received: <xmr:iz8vZhXyuHKNbUvQaamoFkw4VXAuhfuxBDEBohOS6Ddj0HeZAGc-hwkCAZJPPn85aPbqoszQYnyUluvfOfR69dp8fybkeKryW2AWBCGGxzIGfcDS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:iz8vZhhdfaj7UcOEkPxVuGTe167s8Hfvkxys4sQEVipa_xd1bTT9DA>
    <xmx:iz8vZpD3Zz21ccX4PoT9X3PHAKXuyNo0jID4InHNC-fi2YkbTk4vig>
    <xmx:iz8vZqJkVickbMwPZEZx7bK6HFSZLfnKz0t6JhPhudJDGek-K-ceEg>
    <xmx:iz8vZoD2JxLUb-g9LjfLTyz3B1mjeQTusSajeV4DmYY2vFp767r5cA>
    <xmx:iz8vZk_VsZ6un8SEhD1_-nAL0vQyXeYvt2pecdulPk0ade1emrh_HHMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f51f8b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:30 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 08/13] builtin/blame: don't access potentially unitialized
 `the_hash_algo`
Message-ID: <2d985abca1c8f99d888816965dc87caf70774a86.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BBwaBQgniwTfNMGB"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--BBwaBQgniwTfNMGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We access `the_hash_algo` in git-blame(1) before we have executed
`parse_options_start()`, which may not be properly set up in case we
have no repository. This is fine for most of the part because all the
call paths that lead to it (git-blame(1), git-annotate(1) as well as
git-pick-axe(1)) specify `RUN_SETUP` and thus require a repository.

There is one exception though, namely when passing `-h` to print the
help. Here we will access `the_hash_algo` even if there is no repo.
This works fine right now because `the_hash_algo` gets sets up to point
to the SHA1 algorithm via `initialize_repository()`. But we're about to
stop doing this, and thus the code would lead to a `NULL` pointer
exception.

Prepare the code for this and only access `the_hash_algo` after we are
sure that there is a proper repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9aa74680a3..e325825936 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -915,7 +915,6 @@ int cmd_blame(int argc, const char **argv, const char *=
prefix)
 	struct range_set ranges;
 	unsigned int range_i;
 	long anchor;
-	const int hexsz =3D the_hash_algo->hexsz;
 	long num_lines =3D 0;
 	const char *str_usage =3D cmd_is_annotate ? annotate_usage : blame_usage;
 	const char **opt_usage =3D cmd_is_annotate ? annotate_opt_usage : blame_o=
pt_usage;
@@ -973,11 +972,11 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 	} else if (show_progress < 0)
 		show_progress =3D isatty(2);
=20
-	if (0 < abbrev && abbrev < hexsz)
+	if (0 < abbrev && abbrev < (int)the_hash_algo->hexsz)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
 	else if (!abbrev)
-		abbrev =3D hexsz;
+		abbrev =3D the_hash_algo->hexsz;
=20
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
--=20
2.45.0-rc1


--BBwaBQgniwTfNMGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP4YACgkQVbJhu7ck
PpQSTg//QYpNLmSoGyMttf5UnXI6+y+8GuINRe2/YL1KPDb8lro+Ma/60jX2r3Eh
UcBcs6Blv3gco9jQwvEne8h49JJPaXiXiPaB/CpZ815R6dAtbA9uXDbMBZAulo5F
AJ7v74y12igDHnmCGkUFxzF7nyFSJ7wF/0bOZ9zUIbTMEBC/Azd2ibxGvg2a1aka
z+3RkLZkSO68gty+cf8Du6cNZ1/3JcztOwCwRerhTA8MbY1mggo47zfCwTrXf8Rs
V66zWDlGzQR4PY9cFkU7F6YXedft+5r5UCZzdA2w8dnGZOUSTcyfNjCqEWnQ7aj9
SfOkVA8qvWNrxkkMGstneXRDmA9VzRxqLf9ITo/2/3g20vnvw58DLxQF1RDsUqbG
CkI9Fwx+wl/AA0ujpjn1z9gSpRAt1Uj+iDlu93wSJuMBgL30hYv7fgpcP7U/z28N
BvwEqAf9PmQe2tARy0RpoEIeqh1D+TbN+ut/jDE7KIGv+IVmo0uK71wJHsWh6Xh3
JWmDsrobHR75zA0TWyEqDBbuOnwHlPb6Iu51Q8tJ0Tytc/7N85k2P9d+wbbMeaUs
pKSlYBmzijGguPV9fhNHAjt4L/r1y+vBNhxJiMboqQF0cWLBVuPw2KWyntp+4I4g
qUjo8GfKscpBm8HqCkBzA3SEz+3CW7W/EVs3Mitn+dn9FkXOJfc=
=3iEc
-----END PGP SIGNATURE-----

--BBwaBQgniwTfNMGB--
