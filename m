Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A6140384
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480032; cv=none; b=udIhQVgXNIGIT2r73Vi3kwXKgUDAQtkfuAbT6ICRMc3oFA9+7jq4D29j4Vphgmp5v7+HZysuEV64RKXU20/KpPHSXAPjQcgyK+QfRBSIXVoR+RdviOZ0+Nh8mlssH9DHUUAj/Y7NxHjW6rHLSPpSVj3Ml1abEWuZ5UjQ68c1c78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480032; c=relaxed/simple;
	bh=NwHKU2lxrDx3FEiQUU5hZEs4MenBZ8Il3CZ7hNocAXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thGO/cWepy1dmtunyaZrqoAnuFtUfsHRU7f+OzUoo7YMTZY9Vm5QnnuURRGzxecPp8Mbnr6TOkAwWVZ6MQRFf+XNWfKNan3ycOJUIMqEM9Oi1x1p/v9lzTZ/CySIYJoutmpo4XIu6kVg+MTx+Tp0XdEj1QIxAe5qos1QGHlIi1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JZzvwSwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/6ikUkY; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JZzvwSwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/6ikUkY"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id CB2901800160;
	Tue, 30 Apr 2024 08:27:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480029; x=1714566429; bh=j9ylLgb2r3
	zp9HmjFjVR+UJZR57q03Ow6XuP32hlnhc=; b=JZzvwSwYP2KnafC/dl0cNcPQ8Q
	K3P4/4gLdtJb3RvKjHUGURKUD697be+oQHleA6dQnHXSeohM77+XOeinFS7xNofY
	Dy6mbUW4g6EqiJteDskkQgnfxdi9Kaf57gYwrGEwgGVXjee1tPcKN0rcrgi1zyyG
	LIkfv2YBqbPne9hytEfY0iCoqZwgVugK1i1ZqZwANxVP1m8UWoWkFIu5nqKkdRaw
	3fk/ATKq5w8vaLhdzkkHgbeHyqr7fosUYY2MRsJZRXWaX3VERf/S0cdKZsFQj2Tq
	La9AjV0bSLQjlAxGtbr3RSk3c4DLAfS4CycWqU5E8uB4ZCE4oVmykUbr4RrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480029; x=1714566429; bh=j9ylLgb2r3zp9HmjFjVR+UJZR57q
	03Ow6XuP32hlnhc=; b=U/6ikUkYLtHSX5zXQnhRw/LhFNQ/orV6jxP45toMDBcZ
	kfs0kGvYEFyDK+iz8txobXMa1bYn4Q//Fjyj+9rztKgY6dkL5XsL8mib2RRY5RxS
	kl3KqnMGBihWaudVH9cA55XTPHkYAcOfsqEybCTOG3DYd39YOgQBch2Im78vfaA6
	dLTB3uAeJFkvmyNFn+gO1fVYjB2UZExsvBwsyMQbHnXrZqnMWLs7ChIxo9mObeAP
	+cTZcWvLurZEiT56gmlULwycJbp4jMHwVo0Tl4QOOV5qYCYnXlzPsl4iYHyJimnI
	ULtQZXOZRczzo/50s0bMmkB/iGiY0QGAuHi+vxB86Q==
X-ME-Sender: <xms:neMwZn2P6Q0P0I7E8enNXO9S_r-yzJ9XPVsZBxOYqEzCOLF35DVfqQ>
    <xme:neMwZmGCjrhfIRKDTm6MCTo-IXHD3KSm-k25wjiotG9BIMJ7foFNas89dqwAnxQY4
    ybIrvexHh1Oj0nYWg>
X-ME-Received: <xmr:neMwZn4BneTsHxHnhgbJHz8tRalL9hunQvAR_n-_PTwXB8ZhZ0leEmkW3y2rX7I6hp3QBlepN3yUeXA9-pK-A-s0Kzsu23rBW_lQW58IRM6YQadGYghI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:neMwZs1CPE_UWcy3BZCbDokr921V5TvaZZewS8EU57qN_Z8EbMBOZw>
    <xmx:neMwZqFj7HdtLkZIAr5Pwc4lxdCVXdhP5yQoGfEEYgtlroZVbpYO2Q>
    <xmx:neMwZt-te2jRQAoaVb590TO_OszmGBx3fKtVR5QJZheRx4inLsdsvA>
    <xmx:neMwZnnzELklB3p91u4fhjzHyYpANJNus0oh4B0OAz9-EcGZrWVksg>
    <xmx:neMwZv7Nfes9uwi9vlxdG-LUqSvX4rVRnbKm0vggZCEj2R3vg9xKm_7y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:27:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d604d39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:46 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:27:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/10] refs: refuse to write pseudorefs
Message-ID: <b2029612ddd097d600a5601eb35b3d85786b911f.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3631/4aYHayNBp5U"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--3631/4aYHayNBp5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pseudorefs are not stored in the ref database as by definition, they
carry additional metadata that essentially makes them not a ref. As
such, writing pseudorefs via the ref backend does not make any sense
whatsoever as the ref backend wouldn't know how exactly to store the
data.

Restrict writing pseudorefs via the ref backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c           | 7 +++++++
 t/t5510-fetch.sh | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 50d679b7e7..7c3c7465a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1307,6 +1307,13 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 		return -1;
 	}
=20
+	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
+	    is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return -1;
+	}
+
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 33d34d5ae9..4eb569f4df 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -518,7 +518,7 @@ test_expect_success 'fetch with a non-applying branch.<=
name>.merge' '
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [1]' '
 	one_head=3D$(cd one && git rev-parse HEAD) &&
 	this_head=3D$(git rev-parse HEAD) &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -530,7 +530,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 	one_ref=3D$(cd one && git symbolic-ref HEAD) &&
 	git config branch.main.remote blub &&
 	git config branch.main.merge "$one_ref" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -540,7 +540,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [3]' '
 	git config branch.main.merge "${one_ref}_not" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
--=20
2.45.0


--3631/4aYHayNBp5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw45kACgkQVbJhu7ck
PpTRiA/+M2QfL3RxqLNHfDU8Te+Al7YugUBsgmnwhZU323SVb0qcbWN9dboRkQ8h
6HUjJUJeWUMVJWVQT3QeNTgZ9Fi7ARPW0LioEL3fZAHgZdBj9Xl7xUE5EVpxY16Y
DT12A5LppXWa/06pQ8L0FCOXMX9DH3f/N3AVgnS6SlxeO8yCCvym4M6VEJSe3rZx
7W2fBAEMn2RXwoJYZ8YavQDm3gc5jkKwPa6J1zo332/hMW7vqel4Qz7f5M9GPZQI
xqEvCmo9ZgEhli5ZMklGZ9MsKb7VR2g2FY+Xtsnuenranc6KSD2+bopIkcK3UQDD
R/YVo+xahPREAV0Q/6FmpKG0yRkyY9FShwYSOeX29Q7pdTvp6nPtauAJggKX26Zd
Yo/hUtedPqD337zh0czpJG55muq2V8IGSV6o3aHGW25hWwJvRP+cvYPMUaCLKYoB
JSta2HMumJGsvvx0Q3vtTOvkaNhXSXqJbywriSv5G7tVciCruIDThqW27XhtQyBV
li7i23YrGz96UvpOTQsswmjFc0rV33pgf/wXjb72KIbShcCQkXpoq+DfRMZPlSq4
AzC+3xsQ2BN7hEJCHtK++R0x+hpaVqPdunYEH9sr99Ygk71cAlofEIDqSY6uYNKi
3o2YE3Z4GxCEgB9m6DS823w55sm3hZmMTn2AvludzEUWlsPhmpM=
=SqRe
-----END PGP SIGNATURE-----

--3631/4aYHayNBp5U--
