Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1A137923
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259290; cv=none; b=istQfEmarN8H6UHsunkhxO/RqUBO79wKEXACG9Vs5TowQCFZ1Wo63nAsHJhxs1hM0M+dDzQ9mWLBgiJUv3Dpi+85pDw+HO1urYVHiw9hSsjQAFc6tdHeFA/8Zkj2+4OWMZSyfOUNoJt8jDAtEqiva50tLPngE5BdBJRVm6XPUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259290; c=relaxed/simple;
	bh=w77GrZX/VM91X80PfhvxmLmSeTdjTLyhH4jM1zWARhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUMjJ1//02s6jVeEDjjPmqEkoA0DIYrDIa0GUJ1+y4qnO1Ykw5qOmvokDFWWwu+MOIrTVRH9pZfiqpwtlclc9zGH2AZHWmHZu9i2baW7z0p4vF6fOoJH3nkaLl7OPrjTy2gnt/9MXuXQuTpqGQhkF0/NsbXouMlacPhga6FoSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=czVkXMaH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2mJeleX; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="czVkXMaH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2mJeleX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 42C1018000AC;
	Thu, 13 Jun 2024 02:14:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 02:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259287; x=1718345687; bh=nOT9G5Wpv6
	Qp7K7yu04+zjgfOZ8HlhWiQ7znLQsnau0=; b=czVkXMaHFw8Y6zgIUYn41eai+B
	W++PkRYX8Qzj9XQU9QmGaOlr5YYam+bTX+gzThosTjKSX8vm4NZf2T50JOg9u8xl
	6aPD+wGPDchA7lKELAxX8cd9AsWWAi4mcSErlOuM12teSKMFSoqAiQBKFZQ7qPy3
	9KP9IRy5EN8f2+9NrLH8d9In3rjveM4pr2brNGZYOk69X8kbu98r351OhR6GauJw
	YnCJXpzFVTuk9uEcAegYlwmPVnG3hu1+1NVv/gjE8zo8tbrF3SkkP3aTPRBbvzfH
	P+yJKncNE4M46Q3/Kl0LWkewJKLzkk9tzkp+uaFFKEPcPRZJVekJ3neoGIzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259287; x=1718345687; bh=nOT9G5Wpv6Qp7K7yu04+zjgfOZ8H
	lhWiQ7znLQsnau0=; b=G2mJeleXLGfYNDQfzH59iNaaAz8iBZaS2gRXexAygd25
	Mig2uWQkUfHTytxUJoLMyNOsImzVwqoE8XyNKLhFB5w0HHLekc/ATt1c5ZoKOm7H
	sBqhQBoXpnZiG91Co5Y31xyM54sSTakl4/GSXdOqep2dz2Ghs2aGOfkKcZdjVA4R
	/Yo19cQ7Vx4lm6ksKHLLDjPUlzK7K5VR/8km/x6dvE0oFGbaQlkMMwPEhjHDL+0R
	z5/Oo0B6zfKKvcG5auh1ZecWUOUWsYYKepsIswzI+i6jcGvy++Mu6wtqKRqy7Dv2
	fnIb+kPKih0B2P1zj10UEaTzIV2G/oGVVWlAAQTNXQ==
X-ME-Sender: <xms:V45qZn1bpojDWxyB7zRjwBtUB0Cdlf7bJicrNDgfAt405wIntFY_-w>
    <xme:V45qZmFeOaoqKY54LQq7cj3hclIXIfxwKIYEbYFLAi0njMNF0XUviZRooLxP7sJbg
    7q8a0t0B3HTYXCcIw>
X-ME-Received: <xmr:V45qZn6tBByTIEcsQHSNXOAAy6FiuDMZJmXsY3sDGGRJBkutNMHUxBVFVwaeVsFmYHcELDIuJvr60oi2qa2KuD6gD_J7HzZc30KrGUo20ZapFx5E5ZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:V45qZs1-6JqIsLTpxZiiQgAd8VrGSGfgLCkxMKvoZYfKLQjJ-fvNZA>
    <xmx:V45qZqHvKb41P5-1mFIwzC0HQf-zh4PIWsnEM4KJny0MqRLZu_ojqg>
    <xmx:V45qZt9JeKzfbkGAG223r7qDFQdFUoYRhL7Z-uNlVtYx-ra8KAUPAg>
    <xmx:V45qZnlfx2-9WH_nvzfTydsTH0-r743NbXX993fTGWiLN8wfTQvWwQ>
    <xmx:V45qZmBsRgXzIQd97LmqUG1xX-NzdqmbVJXgYvn3yLzu2lRGoYgjuSe->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 98761864 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:33 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 17/20] t/helper: use correct object hash in partial-clone
 helper
Message-ID: <74e5489bd077ee60b08fd4631c8113669bbc2b25.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1GcrF6HiV5Z9swUO"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--1GcrF6HiV5Z9swUO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `object_info()` function of the partial-clone helper is responsible
for checking the object ID of a repository other than `the_repository`.
We use `parse_oid_hex()` in this function though, which means that we
still depend on `the_repository->hash_algo`.

Fix this by using the object hash of the function-local repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-partial-clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 910a128614..0ead529167 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -21,7 +21,7 @@ static void object_info(const char *gitdir, const char *o=
id_hex)
=20
 	if (repo_init(&r, gitdir, NULL))
 		die("could not init repo");
-	if (parse_oid_hex(oid_hex, &oid, &p))
+	if (parse_oid_hex_algop(oid_hex, &oid, &p, r.hash_algo))
 		die("could not parse oid");
 	if (oid_object_info_extended(&r, &oid, &oi, 0))
 		die("could not obtain object info");
--=20
2.45.2.457.g8d94cfb545.dirty


--1GcrF6HiV5Z9swUO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjlMACgkQVbJhu7ck
PpT/0w//fujFk/ybV8d/6d/MfaUMrksJXJHnru+TugBUml6NGtXsxajBrPyQ150q
mmHlwNMAtV0ctyZsV/N/ILmYH4HdS9XssYLB9iNmdxggC2xbaKZe/KO7ZhVIMft9
dPxo9bgVXrZ/Ak+SHUL89+Tmfu7kQjZ7WfqRFca+00ehekSNjROPmVqfMvuczu4s
98L12pRf3aEeWoOjVInTJuDopTyXsuZ2bN8KAKHy07BjhjnBaALxtSGtgOYleyaz
/NzyjlaWlcO8W2lRnZ2owZVqSSE0quSPcXqJvbcTx27Pj2H6HdPmxn79WA+qaolz
QFNOoryH04JiHC22v3bj4WxIAjrNvpIujWoY/01CjBm+vsS5EMd6F8invsGCclQu
HL6zEkAEMDRtiwBx0P8GmajDDsK5Be6f8zDzc6H8IpCEZnmjNW7umddDbI+Qz8kO
65zp2mpq0mxnxX1ox7Z+B7kyxto853HFYmWT0QBQPfpGvClrCGqc2vsi8KJ9QDH0
QiE4d/tK+vfJVqoYkjzwMBX+ksD9+Hyns8b3UPNL/VDuvl/Q3wZOAfx4386A6xqR
StEhGA6dMtkFd7lJZHTZecdZogSvfNTkhhCZCDtBqN5fXqi2iBT9qN4CzzWP1PGe
FQ3tVI2oIH17MS1mvtmw1nFf4kzz4rb+1fnGBttnYHnGyp6hzHQ=
=XOo/
-----END PGP SIGNATURE-----

--1GcrF6HiV5Z9swUO--
