Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80F182753
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361439; cv=none; b=cX7HGv2eY53vyax9Ha/AWH30JFsTgQ0wK0UKjpzFNAARy9oJEfC8z3MB3+u72orM+ThAmEdXo/Wlvse1dunnbLI6b3ITMkEVeea++UWuzyQJaHJ4nzkxhrQSS11xhdUdTQvg9Hovr54YOkvHXx1dOhHbHi5bqcuwO2qFsW+CzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361439; c=relaxed/simple;
	bh=3Z2tncO8MZIjaNWdL5IOB9gCXiOe9Cqm1WWEggGmbFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaqppZg630MquWl+N9IK3AVZRA6DWB7V/9650lFoeecK/UAZMqHE411Au80e2xiQ29UyZQrTuUSEWIHpZeXx0R6kOVyj+pySqLQGFrVrS/t4F7oaAZDJYsZBQSugjTuQS5aT25uJ9bA7iApCjJsIvaTQxX1DHoFv4Zj9hgBeMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NHEo6R6y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDA5R3gU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NHEo6R6y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDA5R3gU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D70361140102;
	Mon, 25 Mar 2024 06:10:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 06:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361436; x=1711447836; bh=xylaPGu/WE
	AtIRA16yh1dAfZBpymmCVHiwQu7lBW1Zg=; b=NHEo6R6yoyX39GhiWxUGe9JE/a
	1zMNhzagSvlO/SXDAftkqUKo9UFDu8qMbBIC3QAvRnbJwn+qr6hCWBlGYSUWz2Fs
	3bv8oMWVbFZ+lRFB9+gW2dYdiCUDvuu2wKs/M3MICGtLDCll0osbxXG6KSXAr10i
	Mx6nhy6r6Rrv0hNVnzYvnbe617v7WiU4ZjgCp7bVRhiypXjmA/chhAmaGKJdpBGq
	fyxMb/bRtcfw3Svq8mBLs9ty5jnhaxp6iqG3N60EMdjxzcPgSQQKJT2pahiGufoc
	KYhypQPyOXbzDfSauU8vLHPGnh6ZkLM3Qg6zfBjCuzMr7DA4GDXX9kg9p6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361436; x=1711447836; bh=xylaPGu/WEAtIRA16yh1dAfZBpym
	mCVHiwQu7lBW1Zg=; b=CDA5R3gUe3cyJ40ZPblAEr5cCG0tV1H2UjK7mtZQEXTW
	ZgcYouUDaJXxnq0fvqtdUD1ANmykPQVuxbQGN7OvP5eoqY+8dXB1MFBLdJjaTIFv
	zKtsUcDgdf00XrO9OrWJdGJ4RilB/HvjhXPJT3Guq3jr7+1OccYKnfGCI5sZlbNF
	LQVz0ZvvyoHIf3u6KN+mYR3q5kwuS67oKVvDIRyP/cQFgr+w73cnUOHfbz6Q9E4C
	qfavUGTMHnuOSxEOy3NfhYMmctuM65V4YO3HThoJI/N2k0vsyT7BVQ8IOpSJSz+Y
	FOvzBeFR5QyhKaxx7i5ev0hKwt76zCo72eNTjpU3UA==
X-ME-Sender: <xms:nE0BZvli-FvMp9-SuOT_5t6jHRRimtiYbyV17LdMqEcm3IOtWqirfQ>
    <xme:nE0BZi32L8WfTtZYb4TF7M1447YXHplqUdxUJgoOvOeWlRZIco9LXf0iF3AXJaNu_
    dTNGWE6_O7U9k_biA>
X-ME-Received: <xmr:nE0BZlqXdPtSa3QfaFac6qcOZ0Xmwok5Shie_DC6RUZFqDkOq_NQWyAhh0Xl12v8yurAy_GHomgpsQvhx76csCw6mae9vChQW3ycvov9gpvAnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nE0BZnm5eqjipwNKaX0TB9f3A1-XrKL1z2m4vaflPM1EdVJFomk2_A>
    <xmx:nE0BZt1ysyQgdJtru4Z8GgCeakhGSFjjwsoRNYIo63cYs1NM8uZjmQ>
    <xmx:nE0BZmsSPeTs0v5xPiYx3dzOC6f1Fl2gYATMce1zhgO2GWKN8opPOA>
    <xmx:nE0BZhWLzkM9sve-DN0lIh_qne0rGJ_ATP0abqO3WBq4YHZuphZIvw>
    <xmx:nE0BZmw6b17FyB1rLPelEDzLYfOFvphQRlSJ6YWIALf9mYoNmmNPow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82e19d46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:26 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/7] reftable/basics: improve `binsearch()` test
Message-ID: <a277d4fa6fb9e8b2e758176dba3cc979a8895451.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PCl+RDF1Z5uLMWiA"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--PCl+RDF1Z5uLMWiA
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
index dc1c87c5df..997c4d9e01 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -12,40 +12,47 @@ license that can be found in the LICENSE file or at
 #include "test_framework.h"
 #include "reftable-tests.h"
=20
-struct binsearch_args {
-	int key;
-	int *arr;
+struct integer_needle_lesseq_args {
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
+	struct integer_needle_lesseq_args *args =3D _args;
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
+		struct integer_needle_lesseq_args args =3D {
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
2.44.GIT


--PCl+RDF1Z5uLMWiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTZkACgkQVbJhu7ck
PpQ2SQ/7BchJNbK7eFh8gYekAH/h7lkKT/GAFacZ9OyVh0Jt+ae/6tCBJR7sVWrb
jK4zliSOmnxFOXK0vLQhBTZt6zaurQcA6PpieZ4WYYaSsVlB7Iuhr51aEqHXLmW2
/jPlhklbanj1rFAkGv+echep1uiVs6qFbIdVFiDtkcFtd5Fo5ZcOa6fVWQQqnYcE
FxkmSqO11bcQSxnE4OQF8gXK35Ash28tR8Pn/4ERQxRd4aFK/k4tyXzG9uidp/CR
8+rlk1yVsvVw1M2DrKPYGW3r2nLDKH7PJ1PUmYDOMBHhg6qA4IFbsAPUHeqQFZfg
baVYOfF5prxF8sN1SrWpugchnkCjcxrTYERrgwJAn8iRPDgvnb0X7s4OAP4u7VgH
1enmForzN8ViXXDGL+FN4DKfHGYLfnxI6epSxYFrKkh6CeQ1zRMtig/ql5znIHrW
N0ek5tkXKj2bbu5HlhcFTPMvDp5Bfe6FghXNgUhttjZD7oJoxx53SCQrZl7tRV2W
IqOqXy3yMzl9P21xBSk0wYKUkuhiHy4XHT6Tw3+FRAwET2ewiOQsJI6KUM6xHdel
lXL+xgog9eU3jSMpo2xE9eEyc2v2F0LT4JdQSCQ9T4U02Mav6dkH6f5wcgum9Pj6
Au6h/16VDK5jWMC3o0VtfvVprszfojOjJPTl/lM7tuKtvZTvVyg=
=MK+F
-----END PGP SIGNATURE-----

--PCl+RDF1Z5uLMWiA--
