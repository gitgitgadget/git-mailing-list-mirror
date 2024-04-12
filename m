Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD88BF6
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897094; cv=none; b=D9qtF+Qa98Br7DBcvCQjMc5yMd03VCXfSjWR/x5kMo+mwgPAke+r3YSMQ/6EyJgDhMMgzl3rsLCOzwLLVxHiMX9ScIIAXu0BDdVRz6LQAnD4S+qwlE/InGJxaWM4pjen/REkxGqsSp6c0C0RkFeOQa/5lDflbg6QHAIVRi7dKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897094; c=relaxed/simple;
	bh=3wNQEReFgUIepwnKDlnWeKLFTte43BohAN2ahrZeeuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpBynikkF29x/a/6YHCHd23QmNeHM3XuvZ5j07Zli9naYoY2UNgCFfg2ACMCvwuDL66UGXgEOgIBzezknXt8Dit4XkiWO20mJvX8atRs6LDKHy7N2/t3MzgsV7KVkxWlQ6DpbXm9/ZnCYulM6d9iOK68XW/bMyZo7UClvABX3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ilKpcVCz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=humV5ACd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ilKpcVCz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="humV5ACd"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3AFD71380306;
	Fri, 12 Apr 2024 00:44:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 12 Apr 2024 00:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897092; x=1712983492; bh=iLKJTMTZJ8
	ImPIoF+619W3Fj3dH11HgVvneJcS/KolI=; b=ilKpcVCzSVJ0J1MQ3UqLRXqVvs
	LxtYfKtgHWnIPLqwk2Coz19YpYikrB5osX0HxZX2VuQ5gkg/JySOb0HPDQKzEvfy
	agwmqbQj3KOcQlegFezOYZCHXqwn42gL/RIuA0qxFb/MauN2/SFKX0U2X3UhB8n9
	/T2ot/hi+b0+Ayy2wgpU5YJsFS6Xb2MMvz3Xi+nSGKLD8k7w/s9ag2n6f9V8/3/q
	Io+cMXy3VZ4Z+g+R897wwaOHtiqR4PHeBs/PMYf2dopzb9/vVzCgBpNslbIsDzT0
	lsJbDqpRA+mU1F22MBgj0k9tFPNt93NVtoFYGb2lBH+8ZqNSsq/bcM/e9dHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897092; x=1712983492; bh=iLKJTMTZJ8ImPIoF+619W3Fj3dH1
	1HgVvneJcS/KolI=; b=humV5ACd9/F3x0jFbe8JBpCre6WFumDSgma8Ij2hX8kb
	B0WbTQyJaHvD5sgLIUegXdBneuqi53Q7st/Mvn9RfgyO1G+vFrGZKxuXTcAeoLSS
	GfDLzm9arUbIpkeudpha++tDoTokqn4Woj5OEUUoxdNMhVl4B30/YgNfZ67ToAZu
	mrWP9YS0SrM11/hg6Ha+kqDk+aXDExZ/TvWoZPMo5ajFEJZCxaGaBbfjQI8bVXlQ
	uhPTTZMGk/1Fk7nXCZP1B2uuuBqnpqRTXeN+h20uST/0urd1KnsuFktOv/k5XGjP
	KDV++v07tU7vnbtc88HGLsuFX5xjUQii4kBOpMb3uw==
X-ME-Sender: <xms:Q7wYZohLlFNcyOFBvWasmErfeo37_Yt9oBzJhzhGGS-08z4uVDhCNA>
    <xme:Q7wYZhB1Vqt-jmBSR7U6mb4_3N4El2UDJ77Yn2RJ9bmEGeDzVb7DT-HT6PbZ8MOdu
    oDFmPugF5veS-q-0Q>
X-ME-Received: <xmr:Q7wYZgGQHGOq6legnKxkjUj3lllopo0nYKuiTsOLHzeppVo4UIYpyWOac_iHxPcI4KTJiOk1_Xzuz49ZTYes1MXWAAo5sSgq3eG1J2X1k5gSvISUB5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:RLwYZpSiWcCQF2JmKa3hN7AX4njlMyqXBlwPHdWcK31Su_pz4cZiGg>
    <xmx:RLwYZlz17uJzV5GmeOwga_75ySYr7m11xRm17ty6vTWrCWVvSdUjKw>
    <xmx:RLwYZn685cm47BHZyuLuzpHYJCoDE8SteDfFdOYOAfEnrf5qD1nxhw>
    <xmx:RLwYZiwH8Ni_yhOxUAIFDi3AuBdBEAPcBameNhixex7NHKVXiOWAoA>
    <xmx:RLwYZkxjhyuF3O7BALvYnwhdes4V3bvXKboYZbznAe1R6T3lPcNMUyzo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6b23b115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:37 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 11/13] t06xx: always execute backend-specific tests
Message-ID: <acf0c285506fe7ba275b08cdaf6b2245ec66b565.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0O7kxxkXFJulYFU0"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--0O7kxxkXFJulYFU0
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


--0O7kxxkXFJulYFU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvD8ACgkQVbJhu7ck
PpTY+A//dW4gN9LJlgT+kSJVWqmnlN3aNp4Is5VlUS/fkFNDF6dY9eBB/Pgupe97
q/Mcf4TqQIPgYY0fJ7j+HtchM4wcT1Hy5zFPVRguArlGd98VVt28QLMtU4Kb9f3k
4Ka2GldG1OS4tJ4d7KNYgYtAf7bfmbomYwZ9i41z8munEUJo3hdM1oWZz/N0wkS+
I+ZbJCCV23uBrkfYev4Xe5t8gM6cOqiFVbm2IdnL7DWoICN2sOVmnGDwEwPGKQkH
bfxZW1s7MJBUxDCVPQo3zqqrTNtxQS0A49qcl8ZRulcQYkcuXoCGaN2JBvxKZxFK
iKYbQUHnjyCcyKfnSQ2hDziz9lC3Fd5OTwqNhBALmiLYH15nrZRy4Jx6vpIOCpEu
TEq0NB6agyxjHtYKVyDni36k/GNhYn2MIcGz9d0CR86rbaXRDjnESL1kqZoOp5Py
fZJ2cIiQnp98qpVQn6vf6iCtnq93hECqKfJZPuL3HMVnTMf2UxNfYajrQxqvmcHJ
gCzbIRjrQbDuz4oXZKjm6XRHpe3MUxwjRFfIcDqlRA5n+7PWGWhUZ29C8O0VeQ/4
TyzfrlUy5OTnMeWctsUna9bzXNJ/LWHtsS6IJpOEKS1G3eSTz2xgdRzhLexV3E2y
2wh6esUg/iN0sKhS6Fn9oCcBpVyGsOqHYOA+K6ygbWgcEYHczOY=
=ACEf
-----END PGP SIGNATURE-----

--0O7kxxkXFJulYFU0--
