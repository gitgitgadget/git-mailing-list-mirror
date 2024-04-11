Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA3142642
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826667; cv=none; b=WORn13Ak8p9M7QiqUlSO3PaS7YC6DRp0b9Tx8jdNeSZawSU/yuFG+ifN+M9iNRsfd1H416UeZTs4RIoJ2dcX4wAgPiEkqMtdkGWOSpghSNFUJvtJS+BRtUWG3k+mKtei3bEQanw2wnE6iWFqz8A5wdertSLjoMTsXKRbrm8RUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826667; c=relaxed/simple;
	bh=jPc0YsuC4LLQyf6iVtPQq3oStMVa/OHFaVsiqJpgc7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2mMB0Z5o0Xh5wOWQYD1nUL95e1+m/u2ywvaXbrrW0UrEyv+ANKXvVgpegjAce9ntjxnwR18Idu+85Uy8tTTXlACWKC3jnAYGVHCoO2n45tiK/oYAQJtp5C0psvE5m30FNKfF/TwWFdyORWUKDb1108lEz/TGAi9LyL+ALlN2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kok5oDj6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d395STEm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kok5oDj6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d395STEm"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF4A0114019B;
	Thu, 11 Apr 2024 05:11:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 11 Apr 2024 05:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826664; x=1712913064; bh=AiR2HOz3pZ
	FFeGTEOdOMw01Mclv/3za2GVTmpUX0R0s=; b=Kok5oDj6akU/W3T5u+ZiislexT
	HoFvDlBJOXt0S007ok7KRi5CiGgmj9lzKS8flJ0nDxZAEJ48K8Wg5JEsSfsrjase
	6wulvrvfFV1iVXNTQTeAeHgu3h1LWcF6pXkJzh6Vu67/SjuF3smhojxGptZ5KBm1
	kHoL/cwQJWbJovIcv1g4XvLTPFwyDFtRnq/jdvpOIKksuvyI2Dwt+ClEJ3ul8ydU
	U7cr9hNi+l6U1kiCviZLLpWxiujDdKeBvQMkRvTpDhpAQpvDJjQMDy+U5OKZIZ4R
	CUv3TGnaEz+K2/6dfEX4rvVXibtY2LjpaQoaNJ1h1t097yJRYEUqnQxTTEPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826664; x=1712913064; bh=AiR2HOz3pZFFeGTEOdOMw01Mclv/
	3za2GVTmpUX0R0s=; b=d395STEmZL+zZpCRKhVL7YEKThDlhaspef4hEneyQIO6
	FDYaCGBoFbiOP7F2aZkVIE4bJY8HVdy2Y5YagDTq/Y+mJBwTo+tcGoTFhDTRoyG5
	lt+35Bnjj/ho/4YudfSHjWPQCSDismrW16FLLq2m9yjrI0Z5cwmFO0YH/eWW3NV7
	Rj6RIivBkPbJ0/nWxMwb1LbO5hCY4EqDQrfA/dGLg46JJMkDUMv+MOdFBGIRxSUB
	7rR6G2w05gdEn/OL/0pNFM9nq9tPIANDrEYBgjo4uVN0OXKIdFuaSfc6SBRgd1Co
	OGCdjARP/6FhMpgc5mk5T59X8Z6B8QCufvZO1b7Mkw==
X-ME-Sender: <xms:KKkXZjATSQ-vh2WUb518xpRe93HJua1ZwWD1nzLMak1h-4YO4vFjDA>
    <xme:KKkXZphnkMHQTsHucu12dzK87eefAzs22M472TW5VwLKjCxzeks9TdKEd5YPlyLBY
    hxjPZOJRCBI6ZIZyw>
X-ME-Received: <xmr:KKkXZukDD28cgrmvJYid8zoXjRYUgQuox8xWU-i52DVa4jAsHQWmbrKv_WyU7GOkSwpeK4rONcT_fJuVEZnXoxOGGsNOw66hAg1Dd0prwvgcK3Py>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KKkXZlxsl7QBPuh8tZ-y9jtAXWNAQ33nvQyREvGgscx32W_tBxy7Nw>
    <xmx:KKkXZoSP59jS6p_YHdvSvxkcituZKOn22NxL9K6zNznL6UrM1ygqyQ>
    <xmx:KKkXZoZPH6zAQa1UoyflYQ-bWI-v9JslCsOYRg5WAuCrKqEfT3dwFQ>
    <xmx:KKkXZpTR7GDcKeons5lspd-bktvScGlMXKS_yYGRWAy2qFB0BlJwlg>
    <xmx:KKkXZtQHwykv8698vXUeFXI9yiPrwhrdjZrJyu2K6dqu77Gn0PMpPSvE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:11:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 59e0a155 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:50 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:11:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 11/13] t06xx: always execute backend-specific tests
Message-ID: <7136c8b6c21457515118c5084a715fed92b427e8.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+o1sKsLAFl3JjHLn"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--+o1sKsLAFl3JjHLn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The tests in t06xx exercise specific ref formats. Next to probing some
basic functionality, these tests also exercise other low-level details
specific to the format. Those tests are only executed though in case
`GIT_TEST_DEFAULT_REF_FORMAT` is set to the ref format of the respective
backend-under-test.

Ideally, we would run the full test matrix for ref formats such that our
complete test suite is executed with every supported format on every
supported platform. This is quite an expensive undertaking though, and
thus we only execute e.g. the "reftable" tests on macOS and Linux. As a
result, we basically have no test coverage for the "reftable" format at
all on other platforms like Windows.

Adapt these tests so that they override `GIT_TEST_DEFAULT_REF_FORMAT`,
which means that they'll always execute. This increases test coverage on
platforms that don't run the full test matrix, which at least gives us
some basic test coverage on those platforms for the "reftable" format.

This of course comes at the cost of running those tests multiple times
on platforms where we do run the full test matrix. But arguably, this is
a good thing because it will also cause us to e.g. run those tests with
the address sanitizer and other non-standard parameters.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0600-reffiles-backend.sh   | 8 ++------
 t/t0601-reffiles-pack-refs.sh | 9 +++------
 t/t0610-reftable-basics.sh    | 9 +++------
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 64214340e7..a390cffc80 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -4,16 +4,12 @@ test_description=3D'Test reffiles backend'
=20
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dfiles
+export GIT_TEST_DEFAULT_REF_FORMAT
=20
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
-if ! test_have_prereq REFFILES
-then
-	skip_all=3D'skipping reffiles specific tests'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	git commit --allow-empty -m Initial &&
 	C=3D$(git rev-parse HEAD) &&
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 7d4ab0b91a..60a544b8ee 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -9,18 +9,15 @@ test_description=3D'git pack-refs should not change the b=
ranch semantic
 This test runs git pack-refs and git show-ref and checks that the branch
 semantic is still the same.
 '
+
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dfiles
+export GIT_TEST_DEFAULT_REF_FORMAT
=20
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
-if ! test_have_prereq REFFILES
-then
-	skip_all=3D'skipping reffiles specific tests'
-	test_done
-fi
-
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 931d888bbb..fd0ddb96ae 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -4,17 +4,14 @@
 #
=20
 test_description=3D'reftable basics'
+
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+export GIT_TEST_DEFAULT_REF_FORMAT
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq REFTABLE
-then
-	skip_all=3D'skipping reftable tests; set GIT_TEST_DEFAULT_REF_FORMAT=3Dre=
ftable'
-	test_done
-fi
-
 INVALID_OID=3D$(test_oid 001)
=20
 test_expect_success 'init: creates basic reftable structures' '
--=20
2.44.GIT


--+o1sKsLAFl3JjHLn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqSMACgkQVbJhu7ck
PpRwyA//XT80yRe93356w5DsFn8mxHAo/tUNdbQExq71TyEpzGnhyrifC2XSgqbs
UUsgKk1RYHdXQnOGy+32BglDBgBV7R0G9SEZVPx+PHafUCAL5Fg8UykCs7dflyxw
6m6UUQIz2QlF6LvWcs38Au04sB9n5Y2IQws1mRyvOfygTEIpXHhJ2joPj9FQ6Ct+
CVFL4efCrtNDLbkxkAKMgefYG1LfmAbvXBs0mjKEb2fztUQAeqIVXrkMdD1cc16n
hX3Lc0zDhwLSZ1dLdzMgHxvZMgl/77BbyHhyPqF+S8UB+tuox/IucHll3ShgUeG9
fQNipovbcNkf/lbnnLh6vTNrdKH/gT7ztXS+JhR1BRSNOV+9/Phnv6lWh1wWEa5/
aSMPY7EhCBmYsxwW7rsBCcTTC7Alj5iM446dAx3oNMI8fr2HT78hQ5CozkQlXBlv
GO3ROhwJjHAXcQmsFctyz8Z6zu/8dpsFsS7ikCQ9/V1m1uy9pN8eg0TyLlU6is1U
ZT62sb2pfLTqqVqiT3L7e0UgPOrYXKM8NddnrgsKeq7LSXfy/NNL+npcH4fKGfDX
WLQe0QEnYwDBCxqO1dsDmvqGpURa9Z0BYDvaZwOz3Pk21Mj8T6jA4aw6Y+RnjMIN
uxNhqBdObHIs64yGiEHLnojnUCbAgW58/GIRvP6DJWxR88bMnx0=
=sWaO
-----END PGP SIGNATURE-----

--+o1sKsLAFl3JjHLn--
