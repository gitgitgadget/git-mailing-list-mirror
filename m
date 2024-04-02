Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA61598F6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078691; cv=none; b=qqMPdwqcre9cqQItKQzIO/AbbVTug8AYezObqN8V/hutaZ/PB5xiUHEF5Dhurmm7d6ihEVKEvhh9CAVNwC99mhS0FZNxs+QCCu/UAP56HW75ZFo6U4I48SDbUb7/C6pPXLjneWhOXT/VqzF0WPilTVDM9qy9P9eSBZN9QG36zRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078691; c=relaxed/simple;
	bh=Ik9EVdH6CHzjfQ+RFzAdd42aicdlGL4Y/AoCvDb5mtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtLHuZ30cAR5bv7VbAbczXQbXRE4aBu8x5IDhuaA6MXTVgN6bx9WFtgoE/ppgAEO6tLM9tX3l0aQ5SsSmCgCAlyqRfM0fXho1k2xpPWpYfbHcvIYWixdmV5woIlvqJR3lTgoehbuJifW5GnMaN1ynaLaT5I+A8ZJIG3r9ITTB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EGVberKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hmEFCcEE; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EGVberKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hmEFCcEE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 41C3E18000E7;
	Tue,  2 Apr 2024 13:24:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 13:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078688; x=1712165088; bh=4oV6oc+lCT
	6miTZpf6aHB9QXm14QB6FzSYmkAHB+GPc=; b=EGVberKdljSZ8SCd/N+7Ncqqmy
	dmwpVixVVYujrjZVKurHtbuDTLX/Tz1WYrWEKl4xLn7xqBxelUgyX91M8/yXNFig
	NGAzWVBIZr8AMkzG9Dp3uvGX0ZdPVYOE8fpz9OA4WMvrUxOSBwNVCVSXZQy/Xwtx
	PVg6BpJ23wnyvntHmYgUdlZvjA9Z7oVjcDGszeyZaN1Qt3AdJb6XhfOnC/2iD4Iu
	DQsW9C48kNwK8hXlItqGjSb+gO1vkCDNKKYWB9Za3D2FCB3YAhecBw/nEWFWqQyt
	kM/+VHr0CxZhyCovFuAH1+TrMdg9oa5xLR9t9+eH6ghsutSQdD3Z1z+SxyJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078688; x=1712165088; bh=4oV6oc+lCT6miTZpf6aHB9QXm14Q
	B6FzSYmkAHB+GPc=; b=hmEFCcEESMHsFXLFO7gjNTJcP3aQUZ2zLU50SCSajJkf
	SlfXKWyETY8Tmgt5bK6HgkSwwU9nqoakEhhyawlcQ7pGm8Khxwb6yaYDb4cle913
	2/MANIssjhGK4bJH+FVeJtNPV8i5DS2NugTaVr1mMFtCynW/iy6Pn6vdY//oU8ZL
	a+PcwWLhkKq8Ys6MkvaffFoEFvxFp/4BtBzcs/1Gek9Uu6UVzgx5GueupOx7x28x
	ztyZFQvnLLzB3iyn34zGlrKk4IRS6Dyf39IhgJf2rfyrOoib6/sWX2izuDnbSZPI
	cj225OkGkRDGx91B3MR1GL/HjNeaJNoXgoQDq1A3IA==
X-ME-Sender: <xms:YD8MZjojtrOP7Toc4dVqGWQURjrUI92UwUFikzxFA4u3ZUcrHShEGg>
    <xme:YD8MZto3oTWHWYOt_2TUcByXO5SyRJkrrd27TGmQMPi4McJr3Ity6ZFuRpKWDE9yz
    Y8pwlgUGATuDOqqXg>
X-ME-Received: <xmr:YD8MZgP8Ki6ka4n9y93_WfY4EYAD1yOwgZ6Qp9_BLBXmJGIkcojS2cJ_02K94PRxxuCtR_QszrGADIVYpzQPMKWMqW0xRf0NJEBB_ocjbvUuzZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YD8MZm5rX3g5xUSw5DGmPPfGhtzzl9HcgtzYZ6j3KHf-i7iSDXqi_A>
    <xmx:YD8MZi5W0aT5pNJ1LpG7n6QTGP-ZzbBpKhDuh4HNZAyf9ZJArA4P0A>
    <xmx:YD8MZuih3RcMuaa7lGlUQYOV-sBsKoqkPCQfOiPweiOylapngJS1-Q>
    <xmx:YD8MZk7xUS0SZylCnSpKpq7u0Gqaqf05xwWU-H3AilzWiPxA0oYYug>
    <xmx:YD8MZolcUR_KXX9PmVqOhoI08iRjIWqICWf4HEaq8Z307zTXtXYpOtrJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:24:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd077a95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:38 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:24:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/7] reftable/basics: improve `binsearch()` test
Message-ID: <cbc2a107c1c067a0c6891bfeb33f2311f2f072b4.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H5JrtzHp4pYPMNH9"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--H5JrtzHp4pYPMNH9
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


--H5JrtzHp4pYPMNH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP1wACgkQVbJhu7ck
PpTmyg/9EaPByig4vediVuyfFkVN9AcRGQKlYjXI86MRGYP2s2e1n1YGMcsg9y3z
St3b0d5ZEOQEHdkuvirG7devGXJ9tiighG4CWfpf2niglmmgVGQNxFkhnYLaBuNH
aHPrksSNijSoYZpDJ4Ob/I4LNQsbaE/h6ftYGIbYLtE3taX86F+RH3y4nW7HKG72
JKuLKxaRvZx4jsoIU6QAPIqvhco/G4EdGCiazlvrXhcfh3/mqbLMA+S04/nEj3hE
GyqDyzKrD/gmuoIsOm5X3i0Rxk06qcOiFvIWVv0bzSonQOcsJLbfuh83VBIkFUBS
LL85hozLy265Dc4y+XXCH8EyV5+jh50S3gR0Xf+xun6QL0mgnNK6VJGJf7ONYlm2
B1j3psXfnVmuVlADNL+/rlAia4veraE9oMhCzuj/FewXHxQcrTq4RmwKJKBQr4tm
7amUaLpVaVwTOa3P+1KnpWUJjjktO863Lbksm4Nkv+jH4svzroMUCr8hJIY35pyJ
iDSIXC7uu/i8SVmDV0uPjbPSqYdB7PciOJpJgv2WqUqAUEN/8aeYaUPZw4AGyOUz
gLSvMagpvTYlu2bJ9OYx+gCBgCopii6h3GENQ+DAXhAVoedzGSN4xuwLiz97sbxQ
IOnZAV9bK45OHQBEueEO3YtfdXYfBHd9ohWAaAvNoKvB+yg7THY=
=A/N3
-----END PGP SIGNATURE-----

--H5JrtzHp4pYPMNH9--
