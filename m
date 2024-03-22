Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFA3FE46
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110160; cv=none; b=lzXsUevG52PCK/hsHsvr7hJZwmV7qdVTCcqySy9XjX6QFFjCHInr7VaQuIp6idOok2IvrkBGCbTNaO3Mv9Z+IUqdRrtrxe3/AXoebrYdVjkS0nVO6ouPclR7RShQCJJAnY7v5XDTaxAxp7my8MNWU0if/1+0AliAutUAfi1wszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110160; c=relaxed/simple;
	bh=BaNYT5MLIxYYcMXMcDWu0jfzBN1e9ky2CY/eKLGjm1A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxJGx8UD+XRMSCKzdbenl0eI/8pnwJsX2HZQyOzcbmSxpJYuMVlBgA9takKM7wKaWgNO3+2GbKhZWVla97vuJT9eN1QkDcW9MNdXpjwzg8uDv9qoIqAkWL9jSKZcrcUc5F+SpRHtJutsodqivkpvx/kYE6MyEJIxKtV+bX6aRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c947KVMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uLNuOVmu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c947KVMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLNuOVmu"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6599513800F8
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 08:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110157; x=1711196557; bh=Kigp1rEQ+J
	AaQBkBHmAEpbNjaREoSvpq2xWlq4hEuUs=; b=c947KVMsJStRuQesPBEiOD8x8a
	UsFL+4aIBGHvTuCCqP2kTBUX4RlbD78X882j3daSq0FDpBAquuHttLaO2KRS/Z+q
	O49/qisGFeUqpHZjBzqJbODU4Fekuj/s7/rZMT3Dp505Dwd/lMnS3qwq2lLQiLw5
	+z+i0evHlLKbUpxY1sOXE0imMQ9nRvG8GjmsxWR181lKrOm2gAunFNV/n0EAghD1
	c+aeIP1H/lm4qhp7U7raIB1OmsQMIsWa5R/xukjHxn+c4YBYI991p8sAnoAZsXeT
	fGkn2DoIEQKU/dnTHnhzTPtI5sM93yx1dHGAGadCWrPsiptNAYYcjpZYsGmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110157; x=1711196557; bh=Kigp1rEQ+JAaQBkBHmAEpbNjaREo
	Svpq2xWlq4hEuUs=; b=uLNuOVmufiuFpyM8Iob4w35GYMHps/MWCLSVAswmxMot
	wAngOupBeFSzbJIzb4B6M5e7/bgPaIcDIYqkWuFXHeJdkzrNLdf1ACsRep5AS0D9
	mY8cmzRWvIBmPtl5SCGIyBn6iClHXMNkBAEqwydK3dzHto3SMXeVD9Ks7V6HogNr
	8rH0In5d8UaESgfyZDDZy4WGUg4Jd7WjX6s0AqxZYM9UXA05rioAn8UC4ICPbOLp
	Z28rnnjz2g9KgBHckYmIsPiHowtDKHMPN2sUkk2CHE95n+agddrQiknFxOgLnm17
	Z/sSqGPkcgm007c2Yi7RkDsEsuoThgYyMhAjus6sGA==
X-ME-Sender: <xms:DXj9ZVH6vlSZfi0Tzn5iyY0VNO6KZigcg5GVe00jOdIjIXxU9RTxCw>
    <xme:DXj9ZaV21_I8A4FhpdVY-PwAEElafaOMFsYs5MWu0yIVy8dEtYyn97EbBB51q7hbw
    KrbHO-yj2wFJvN9Xg>
X-ME-Received: <xmr:DXj9ZXIa0mfex6tH1bTPNYijNgh5NtHv19DwA027b-yeTVg2pclP4xSw-rOWG4fwe_RUxpPOer9Lwkldeej1QRqmRlfMJ4K1f33I3Y0hJ-2wvx1_ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:DXj9ZbEaM3oqXDjL4G0xfOGjaqj5kZZJMeo2mitLmJflEyOkZZX1Bg>
    <xmx:DXj9ZbUnLUeAPqpQOM_r04_jIREYj6DdX2Ii2zxMivSlbHwPHmMoTQ>
    <xmx:DXj9ZWMiqfHjICB-W2UEzhK092to9lMMjqhRVOsKEMSZw_AzbHDuCA>
    <xmx:DXj9Za0nytnyEjNu_BZy-hop-Q5HIHnyS-uSZXvBpHFBl3NU55dHjQ>
    <xmx:DXj9ZYiWbx3HSc82rhQ9vaoUWSb4g4LYTEMPq-pR-1L774seXj2CVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 021578d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:31 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] reftable/basics: improve `binsearch()` test
Message-ID: <7955f7983a6d8ef81a572f108b11c7afa93e34fd.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OkIuNxZKGKzK6TOB"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--OkIuNxZKGKzK6TOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `binsearch()` test is somewhat weird in that it doesn't explicitly
spell out its expectations. Instead it does so in a rather ad-hoc way
with some hard-to-understand computations.

Refactor the test to spell out the needle as well as expected index for
all testcases. This refactoring highlights that the `binsearch_func()`
is written somewhat weirdly to find the first integer smaller than the
needle, not smaller or equal to it. Adjust the function accordingly.

While at it, rename the callback function to better convey its meaning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics_test.c | 55 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index dc1c87c5df..85c4d1621c 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -12,40 +12,47 @@ license that can be found in the LICENSE file or at
 #include "test_framework.h"
 #include "reftable-tests.h"
=20
-struct binsearch_args {
-	int key;
-	int *arr;
+struct integer_needle_lesseq {
+	int needle;
+	int *haystack;
 };
=20
-static int binsearch_func(size_t i, void *void_args)
+static int integer_needle_lesseq(size_t i, void *_args)
 {
-	struct binsearch_args *args =3D void_args;
-
-	return args->key < args->arr[i];
+	struct integer_needle_lesseq *args =3D _args;
+	return args->needle <=3D args->haystack[i];
 }
=20
 static void test_binsearch(void)
 {
-	int arr[] =3D { 2, 4, 6, 8, 10 };
-	size_t sz =3D ARRAY_SIZE(arr);
-	struct binsearch_args args =3D {
-		.arr =3D arr,
+	int haystack[] =3D { 2, 4, 6, 8, 10 };
+	struct {
+		int needle;
+		size_t expected_idx;
+	} testcases[] =3D {
+		{-9000, 0},
+		{-1, 0},
+		{0, 0},
+		{2, 0},
+		{3, 1},
+		{4, 1},
+		{7, 3},
+		{9, 4},
+		{10, 4},
+		{11, 5},
+		{9000, 5},
 	};
+	size_t i =3D 0;
=20
-	int i =3D 0;
-	for (i =3D 1; i < 11; i++) {
-		size_t res;
-
-		args.key =3D i;
-		res =3D binsearch(sz, &binsearch_func, &args);
+	for (i =3D 0; i < ARRAY_SIZE(testcases); i++) {
+		struct integer_needle_lesseq args =3D {
+			.haystack =3D haystack,
+			.needle =3D testcases[i].needle,
+		};
+		size_t idx;
=20
-		if (res < sz) {
-			EXPECT(args.key < arr[res]);
-			if (res > 0)
-				EXPECT(args.key >=3D arr[res - 1]);
-		} else {
-			EXPECT(args.key =3D=3D 10 || args.key =3D=3D 11);
-		}
+		idx =3D binsearch(ARRAY_SIZE(haystack), &integer_needle_lesseq, &args);
+		EXPECT(idx =3D=3D testcases[i].expected_idx);
 	}
 }
=20
--=20
2.44.0


--OkIuNxZKGKzK6TOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eAoACgkQVbJhu7ck
PpR0Tw/3ZF1bJvUmzjxr6theZ534QjjwQNwam79U878WjM/wUlGwvS82kQZ3GICl
vgwe4ltclucHxRkxW2EQXcbpe0HQMLyRrQyCCsSXimp4IGeU5XpJphVR7MXa9Kzt
JE3cOvjDZGjWEhHuEGCZnBMYu/P42+3r050EfQ96n/j2Wb5VftgoHoj0sEEhmDpA
lWwUnbiLrdtl2HTyaGd2zuQ9XfO/v+D5iuAJ1nuDOkWCmGaa7tSU3xAibth4Y8LO
xMYtZtnaRzdYdPO6DhJj2+lofu2M0csvOmk7yJUy2vTJT23V8eJPJzsIzZD5g0GS
dnXrYyLln7XgVIPT5qZeVRokAZ8UDGicUki8g5cj2osKtYSmfFUo8D3HtR6oZOJb
fA429bvcJjLHqu++8JXs1hGWCa2RbbzatMPP+/jTTHWzS7WR0a2qSsoXfpSwE/Fp
gf5haujg73+cSD/rmEbP1LSSOtlv5WD22jBf5Uzm6qr8T6ahwDjkoLbLH95znX1Z
kGUoZEuS7Jt7TiC2A0ewY3QOIj4QR7XoF1nacnBhFI77FHkP9KFTm5r3fiiqOXl/
Fj0Wk7TdYuv1kXSjPTmCmlg+82abTggk33d0UDTJ9Lc2VVet9mwQDvKcCp7kXsLl
albrZWZbsRET2H8S4x3oFNAk4k4d6rl+vwOZMOP5fOcZzNP+vQ==
=NETA
-----END PGP SIGNATURE-----

--OkIuNxZKGKzK6TOB--
