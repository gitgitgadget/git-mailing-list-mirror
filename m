Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B112837B
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237149; cv=none; b=UstwAk+9OfjRJ9wtaCH65uRhMpJwjDfKriqGesy46MG4d9AZl39ubUdfDS6WDNbIXN7ztPJ8O+dfnQ42JijYpckcYhgIaVQgzI11wN2pxVy3a11KVnLMYvFF7kyZ0RQ1OjJ9Ak2NZgIefsKkA9Nd6S+++i6meaE9oIiBRHnVJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237149; c=relaxed/simple;
	bh=Wz2RU0run5NsYkma2zxfGdwlb9IAdwQxV+4g/8k41c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChgAp81Vxiu0X9ucTuG9TkXWyZX8qouiItMKhJthKloiE8tC1CuhFWuYOJyCCglEg8m9O6JNMUPh/bL5DyjGmGeKh5wSbYDoxiVyovy0y9Nw3D+PDvlmE7K9tbwxm2nG7hcxIsggeqgNUpnr5mMSblRDHar+UhuY3OGdBJaraLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/sS6gal; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVWkzWiF; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/sS6gal";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVWkzWiF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0AC3E5C0091;
	Thu,  4 Apr 2024 09:25:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 09:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237147; x=1712323547; bh=pHHWX2NBDU
	ASfCMZ+iS1GzPCF4tZK2Rd55QVsdoQD0E=; b=S/sS6gal1ehUhqs7LbGlZEtLi7
	ymGrxlHDenUrONdkH/keFyu+XO1HF34uH1tRqVn/SKQ3P1chf9fukiDrNZ1512Ny
	ePSJPzH9wF0CVtxqCysAKhNqsHlP1DpNmHiPUFqNTEgd9LzjSpgl1UICQNZO5Csx
	Cl2DaGeI6YPct9/3SmlipAUcTHGkSCL1aeHgQKyMInVcUOO6DD+XXOgFsMysl5i8
	Gsw47SeRUTIPaClLNe76qGAi+am/qTOPoC1rbPzYqMbAc2uPwRV+Snt72en/69ER
	zYXwgrKVJkeomxs/Zw6qcQcQoqZerMR6cMtOfyNW0xyL++UZpmRFPE+Xnhvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237147; x=1712323547; bh=pHHWX2NBDUASfCMZ+iS1GzPCF4tZ
	K2Rd55QVsdoQD0E=; b=KVWkzWiFF1le+vo3xSCMOZfmRte8pdP2Wj0FmQ0zDS58
	9eFQtCUDqM9JpDiZqF+4zFytG7kOtM9vbZc2sRxjB1mIQfU8NFVAT0UOhGanEYKF
	OyqKNqQ09hkknjWocHEDPmj+CiZpZRrijZuFO/Svt/+g84HzGdxKTLF09mbXoByY
	RCOXsxkVuYdM248kf+WB8mu28tMOlzPwyU0sSVrVpYhJX9lDv+HNJpygp3yMpfyf
	C1dIlcWu6MkLu/6HziTfUmZ1jlH2iuSot0Xpwcy6f0pTx0IhDU45laWCVeTTutGc
	c/JdWu3KelnpEVPbedlKFrExrSZv6jkXz3FAU3STOQ==
X-ME-Sender: <xms:WqoOZpQ8F2Hnx7IWPU3FJ8uQqSxlLpiBnKxm8Cap-A0ApTp9COIDJg>
    <xme:WqoOZizft6-g3VrQNBINOT-kKbhWf5dAUb9Trz00EAFSKoR40KpFRyRCEGfhrxAUz
    0Ld3LKVN5GR4zXvKQ>
X-ME-Received: <xmr:WqoOZu3lu9_ylKwO9auddOWC8hA1-1Kc0kzVBKWK9nA_jC6-SIqD3ZhNtHaHKs4PfU0XYzpsi-Np2R9qeTFgq-BLkMRZRry72zOMPLZeT-paj-yh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WqoOZhBA89Toa148ES4l3nIePOAg3M6iYAaXio3fX-juGOVG4LKRWQ>
    <xmx:WqoOZihrJGIWT6TdPQmQIDR2zYggYGo9Sdk3aVNbZ_yhyf_dFwargA>
    <xmx:WqoOZlosjntwPC347zeXMVv4jj8aPaPcdq8m7o0fnwcwz773wNBzsw>
    <xmx:WqoOZthP97hxoAxbUPX26L8ZF38Qt5yHqPjClVoBj51YG-VRFz-kTg>
    <xmx:WqoOZtXu3HPVtZvh0UJva0pqVT-nRd5IwZfXG1Cpl_01PUKpHu1addbg2Zd8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6b2db93a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:42 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 10/12] t06xx: always execute backend-specific tests
Message-ID: <51c45c879f6c683ab1bbf813ac26e1885e800d93.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ToybVkAwn+15TWdK"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--ToybVkAwn+15TWdK
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
index c309d2bae8..157f79fe52 100755
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
index 686781192e..aa9282007c 100755
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


--ToybVkAwn+15TWdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqlcACgkQVbJhu7ck
PpQ4rg//fNmn/x4fjfWXPdorZn06J3qw+FX+b4vUyHHSv4W1aVsckY6YMYBqzehs
JCsL1z15hkM5QT23X0OAQcaqCCPfh/KjMZezbzohcHDBllGGnK9CvOEboMNUizgd
sXU/Ovqolm8GP0H6g2nLVUilMkw1Z7bsqfmzJanXU5Am/NikV8PeewYuAGtRkG3U
WHsYLFxxg7hf78YvbSMtF3q8neY1OCytbjeyoLyhvJ/pwhxtccpwZjSRxwaQEtXt
Lihj4lPJPaGxzbjS+Tsnsxqd+9ln+1t9cHcfpO1c7mCvyvpNCPMFwIAFrTKg2T7B
zirMIrsPIx0/Ba2CtgjJOsJjHJ9PMIuFskSr3kTnxEokfK8V6aRe9S8od6cw/0l0
KSZStQV4ynYZ4WPfFoH5l1t1KZNnXFgxecK3Xu/4rJIk/jhrmrZQbeHN4k26YZqO
AEgrKyGOCDz92zjxmgwdvQIwDtTHE/9R0ztW37+Do9LPJ3WxTQh7rdwmYY8a7plB
isDnmDYZ/uTUmyZW7dEDXSTqW1SpUGalSokNXu0Bf7rt9vz2us4scVHXfw2UQPtc
5iqlo9sjcUU0Ci0nXA249VPoYmPRPYo+pZdlOdLsHzn53SrXkvjEdowMu2TWWlS/
/3g+n5bYfMK+euwS8XypvIsbtjYYqzx6NKu+qRB8fTwmNwgOYD0=
=6w4E
-----END PGP SIGNATURE-----

--ToybVkAwn+15TWdK--
