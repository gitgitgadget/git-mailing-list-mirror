Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C764D117
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124245; cv=none; b=GqsRy4H0MJQcSokeURunSr0OhyKg6BgScNhDcqE/LBEDSyS25xZiXXyXk9Io5MZuMc94z5t5TtEsGkHmeoP2jz2b/y1Wh0U4hJsgPhCTHM0RwFv+TDNJXo8/y8nXStjBeUCNKj+z6di7q9oD8FGpqRTiNk4PBLwg8bvY/z6QQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124245; c=relaxed/simple;
	bh=u8PO3PqngVNTYIAmfToY1ZVoeewDtfjmRTXmculP1m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0UGwFgMeCr8H4v99a0g9IWrn+sNxCxWUPiQLtzGuEZmLtoIXDSSulsTUF75v0gEAMKaw99BFYzOxTc1CPtIILPd9VAU5p4+WwWrvwM4+qS+/Z830v/xqFnL4JxSuWfk9tuqq5s5SdEeMmqdjAksI7G77XLoDTcVwbFHX6Y+klc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pZ8J+5BC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aYsaqNRF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pZ8J+5BC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYsaqNRF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 631C81380085;
	Wed,  3 Apr 2024 02:04:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Apr 2024 02:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124243; x=1712210643; bh=Q491D6R/Vw
	AKsCegaY+LqJDAQ0XW09YcF44JNgl0HLI=; b=pZ8J+5BCEs02Jzkxujh3hlKvqn
	Cul1PGHlADjKffEM/19MTVhXOf8KkivpNXbLuJO6h3F32LtkndD//y5e2iQN90Qk
	pmSEappy+hTNp6MrWpsm+ld1rz8TLQFKurE4oF5LF+VaTf3SpzDH7lboh0LmBgC6
	IucJE4p8stOaN88RqMZlN9yqm5+sI8ROfBwAILz5a0SiraxcTBN9n1259pmxbFk9
	5ADPqtorB86zAtalmHJNC/p8Uh+jcem6gjZwjRKUDy70bjO3Cx6NuWNBg8ec2eeu
	jmwdVypiCUBH2vVGMyEKJLlyOEm3TSRX1xU4CavrC0k6owTdDTOgvGXU511w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124243; x=1712210643; bh=Q491D6R/VwAKsCegaY+LqJDAQ0XW
	09YcF44JNgl0HLI=; b=aYsaqNRFFoQ4gX49BQKpY/Vb/CyaHml1hfCYVkiQtO2M
	kouXDOeCa+srGvC5D6ulbUcAq3hf1FPPnOU9mJWZjDEO9vHcC7RDAUlLHVBtd1lN
	HESaZJQk4VNc5T2eiAxvuK+LoQxpisYsJ326aHvn4kCeFNJWdqiOpaAP+bV0V0gY
	Bt72jZvA3eZZ1SyLJwRE+bEtwcsnLxPN8nto5i9LbjJbiCuFLS1OHy5NF4GXGTBr
	nFpPSEO1lSfmqyOARaGuq3rjRQS7DEfld7Kr4EPPuXMUZUcNesx0NYZKa8f+logw
	zLc2vmovVC6yA0aMrJfM+ttWyuzU/OuVlx2QzRshFQ==
X-ME-Sender: <xms:U_EMZu5tio9ZcnQSno-ZZtUuUI73NJOT_iWjGlPwyE74xWiB7R9Xsg>
    <xme:U_EMZn6-EoAOhxmDJazFD6Wt6fLxv6U10OJQwrYRNpgq97hbqmBLe6eStOl9zJBXs
    HbPCXay_yKBu0YDQA>
X-ME-Received: <xmr:U_EMZtenqDb5PweXxY24TjUEoq32NOyP3TyblKI-WOxCnH7-1tHCnU40qI46qrp2g916T31DmA4LvccE20WqNN90mlBmWdWjLULOh8O1fpFQdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:U_EMZrIMsj1EUe23jwPrepVJbLYotDvgVFw8ZxWXrqPwThJlTJdctQ>
    <xmx:U_EMZiIYk4gyxF2hW2Wo6L6apUUVWW3Gy5LbUGVNv-C3HSF9TETGhw>
    <xmx:U_EMZsxujopUNoF8PcpdKHGTk77iGWFfT-RPJPKbNyM9DpMcbKIM5g>
    <xmx:U_EMZmIG3nQCh5K4sp11c2oRSqEoVqU2RrDw25ykYoOY9MsVqULptA>
    <xmx:U_EMZu1hUfCo1J7SvruXmE44CbG83HdtZfPZmKxsc1ygsRWqmKRyY9gJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:04:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d04e4b06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:03:53 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:04:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/7] reftable/basics: improve `binsearch()` test
Message-ID: <cbc2a107c1c067a0c6891bfeb33f2311f2f072b4.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SvD7DMS7sSHkemuQ"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--SvD7DMS7sSHkemuQ
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


--SvD7DMS7sSHkemuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8VAACgkQVbJhu7ck
PpSsVQ//ZNM0iwsqX/jMwby3ODurxhAr019PyDqSim/NfEYlOmzyHlBfttrj9L2K
ShXrel4zt46MxRRF5nR1TUeOg0YoqpP1/UHAlQ1i5kjkeVXuwm+2DTo30vrEGQ+6
6jlFCRw46WKLlyPg+73Ld19IFmjL4qBKeRGlRCb3kRUB03mhjcB4CRXcE9UkXk5A
xl3EL7UxnuAj/uFHgikUeNA1ehl84Em1ZLgfRL2RvpCzKsPzTANgI49pHI+0WN1V
gsOCcwXF4YG8nTcYqsp8K+TMWIE/Chy7QA1kaBHzb1A3+TkzAh5lyicOvQYQ18m1
bhghXPYcTXMt0N0OyO6+FXzDSCp0NJzH3iKUll05ur2Gs7hUHalSmSWjnhoczrcF
XL3k+mZIqzYuDirmBdGs4GieHeGzjTKCDed0WSR77P89eVjYt+jJtXQl0BdTMprT
QxY6a8qN4k75KHRvEdV/ffXfWdOOSx1PMCmM/JFnPXn0EGMNM6TT1WtMT8REu9lR
yxziflmGaTUcSrtwPoo6Zxhs7ENLsgwrpVhxS+up8+9N7MrYPMIoyrkLDbLd0W6e
qiqM7o4cotXYmhchzGm0/Lg75lnAc18uhRmfNFHJX51yllBuPjo6RM5hH4hzf8Y8
gyW50/SbED+j3OvS6pW0n311HB15m1QizujoNnbvK+p+y9u9kOI=
=W9gO
-----END PGP SIGNATURE-----

--SvD7DMS7sSHkemuQ--
