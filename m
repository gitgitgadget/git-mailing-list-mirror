Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C0B194AF9
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669750; cv=none; b=QlfJ7YqeyZ623CDQnIViDJy+l1m6LsuHNDVSOLKGaBs1MpebTEOMn8icERpB1EAhmNOgkgKf1OpR3u362bwOin5WKBngZo1M/Oh0CuEN1oGFhFVe1DA2hPoFscvRXzlrb9WVnKAvkXcoDUXGYSFI6q+WZcZBkPsllyFk7xd45OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669750; c=relaxed/simple;
	bh=sQO0F575GbTUnY1aiH5KnQP8KZnG+u9blEKLfw/v++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOABghhcoijuu50c6mHWPSBBtLoJfh0m+2PFh6QdNjFewexYJFa1HJVckbrpux6mFX7k+XO2hqfxASaN5Hh0Hsi0G8FtfYm1k7uapYqZCERtqb3LNo4P1OYDcZjg3yr//cWuA6bHS63lV0WeybALBNUCMjh0c7UWsik20cg+1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ewYz1ZHv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auVI63jy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ewYz1ZHv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auVI63jy"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C856B13800ED;
	Thu,  6 Jun 2024 06:29:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669748; x=1717756148; bh=Vue8jjTSHB
	fqrhWxCDozRk7RJ8W6BkVT6Ttv2wqU60U=; b=ewYz1ZHv1xcPvfJvWYlUUSfi8q
	OjorlSHn+ckX8mFyQTNECdSmpFYAHrc1EncfPYdMDr21uWq+XxIlnMopMDCxDQpo
	PQloqQlxD1dozkjsJWwQW9p7l5muzegwAwIRRjITRAeXFb/HqXoDOiwSnkMi3HcM
	TdTMcaNpsUdBSEjxkB2epDct8nclCjVTUN5E0PSLV4xzQZvupBFTjcroa+vX5f1+
	vGOiqnKiEWQ0K7GtBEnXHxv1Cwzfu479ienlzzgaE4YPyHt/hvRmSHcUa7HTVaNT
	Hr52mmz4PANEqPSJjEdllZPp3T/brjxK6alwQjw2vxBbpxfd5WrsfgR02jaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669748; x=1717756148; bh=Vue8jjTSHBfqrhWxCDozRk7RJ8W6
	BkVT6Ttv2wqU60U=; b=auVI63jy3JJQplRXXumkppoShobMPNhi1yHfdyF6fSUK
	YAvSI7Bw786FC5FaSod1FQea3ke8T1CFCgyhecW8mJtxjLkULTNz2TVADKDks/M7
	DdZuFgAF5vNVvAeApOK5DvjVKWhY+QOj3eCwCkA3feS6OZBCPIfPxmR25HLuc2WY
	2Tli0pAsSTX+W4x1w6eehd8ztCxTubmtK8r9R3eKAN8YPZ3Fvpr13HpDaN1T6+Bt
	5hgr63yoQIGZUoEnXQ870UCQIqJxnAey6WTtvCMnslL5bGXzxRjuC9EkyGYGTzcl
	xoD+B4jcfyk5rvq/2uCZDs7DxzpsaEkjEqnLqpRL8w==
X-ME-Sender: <xms:dI9hZsTx8bEh33x04xOJpEkwX0Ax22ahan0gcC6lUlqw5qSu5bXmXA>
    <xme:dI9hZpwk4EPB2tMWtQ82xnI8X5t-gD5IW8KIJV99htHvjSJtF9fBH5BAZmCe8qh0r
    6z3-bDN7KAuUcGGZQ>
X-ME-Received: <xmr:dI9hZp0WhEZEYNtmGB8DT1ZQs7lUMYqwXrnoK4VbHMexHUd0O5MhIOPj_YT1UJTYZC4Qg3E4KB1m-fl3cwgrhtubtUaky0eKflGhKdGaIbUkaMx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dI9hZgAbLvYl9zjOXIsDU4wRfPT6vWlH0F3K7Jri9TddBAFhJU0vHA>
    <xmx:dI9hZlhDJ15yEy4IuETO3csSASMZu2lwbM85hdXCTJTuK30ezaXgOA>
    <xmx:dI9hZspYP0MLNN2_JhW2GHWSf8pDvRpKoiSDZtQT7ZfosEMwG06mag>
    <xmx:dI9hZojbkwSADC1FXbHRWJtqSN7Dc0EOkW3Cqo9R6OWCtvi4rDMoHg>
    <xmx:dI9hZldTAvTXQDEZwe2oH56T8U5smjdt2jX1aQlbMnl9o9D1lGCfaVOt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1129c671 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:36 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 17/27] parse-options: cast long name for OPTION_ALIAS
Message-ID: <3afd012a886d4e33e976b3ef4f02b33d5c02503b.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T1AFfy5SJC/mgEfW"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--T1AFfy5SJC/mgEfW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We assign the long name for OPTION_ALIAS options to a non-constant value
field. We know that the variable will never be written to, but this will
cause warnings once we enable `-Wwrite-strings`.

Cast away the constness to be prepared for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index bd62e20268..ae15342390 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -355,7 +355,7 @@ struct option {
 	.type =3D OPTION_ALIAS, \
 	.short_name =3D (s), \
 	.long_name =3D (l), \
-	.value =3D (source_long_name), \
+	.value =3D (char *)(source_long_name), \
 }
=20
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
--=20
2.45.2.409.g7b0defb391.dirty


--T1AFfy5SJC/mgEfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj3AACgkQVbJhu7ck
PpQp7hAArULwODfKyQGvPTq6v65QInfmqJ8DH9JqY+5Be5s7cJ0+e/ZzsGtvUWIT
MK8/3tfBy2hMe/1FMsMKJfNOpsMO+Lr2vQQAKesEzqQeZZaD7q6CP8f5z4VM1K1B
TLQsu6E0KiNyYI3KKVEmGwvDj/V1tIDFyb7ChdtuRQvgGfNQ/4WP0XCg/z7shxSs
U60ymJldBzz5LOLL61pyI+rxJdCAydBPM8Pm858/nEUA2703ZKLbHgwn/9uTYy4q
3J3LUc85zWl5vSGs2HYJNMipx/sURhq8WKpRTE8hasJia4Yu9oHWjZH2o6DI9EsV
nb12iraptdo8Ygv3B/VZEQlcbrEK0QmhV1jUHCWg9nm5A1g/dPm74settkZTRyxE
Zshpd1sh1ImE3aMfBLlqMWs/QCTRdzOGXdk2hTJYGF9BZBy6CGNqMgvZRvu2FYE9
Ch4/NqZ1TjADFpL7DCRz0fGj4QPE9w/Kzb9AcCbpK+EEkhkAVYpSN4wc47MDKpjL
ewzEHzoA0AENYUbX0j4SMlghp9h1JrMw/WNx6auuZ4mMLX5zJ9b6qjQ8spppegIx
++s7YN9AmjQIwRXgKIa+8M9xaYHf0wJDzPQetOxA4wswknBRr4uahftAYpE8QgOc
dMgFtsJ2dnbTSCJN9p3o18l4FBLixj+2H+UTelxwwSc2gHDXGJI=
=LG77
-----END PGP SIGNATURE-----

--T1AFfy5SJC/mgEfW--
