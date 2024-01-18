Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1D22613
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573388; cv=none; b=rUdgwp2t3nOVkrf0Y1CBEJPAyivv12LNZqzwtIo59rSkuNKTbt1fkoKrKYlVLRmys2xU7GCv5FMOSKwvHSZJPxHyZbYupjXXXZaWEJvZ5AvShZUfBe1KIVUFw8GdXM+ciHNf96ZKMoG5tpvONfvnHTUxgIZJCXkuLlP5ve2QZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573388; c=relaxed/simple;
	bh=7pHbbzZg7kX0m8nc//BearcYPIaFRhYE7wVpc4vvtqE=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=qp1m/OAL02LtIa66K2LtcLXgTd9E+VDBRBQ1xLQP0QzZL2n+G7W2zys48z/MXE7+uueXVHkOVON6GTHaYHqTSQItadFPYKoR8wj7gwnoT3OCkqrff7ZObMpmAprv3K3k+Kvvwig22Tc30NofmlwDpmN81Yn1uAP4pfKxsFDfw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H6oESb6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/csWmiH; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H6oESb6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/csWmiH"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B76913200BE1;
	Thu, 18 Jan 2024 05:23:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 18 Jan 2024 05:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705573385; x=1705659785; bh=pgWnYFYJkZ
	8tUzjYD0ERLTOraaVhZcWJp0mKKtPgsUU=; b=H6oESb6iSg+t0nh2fHObZmNhuS
	ucCfCJOkGiwv7zK8O2mrUwrICA+RGhsx6xPdYdM06khH6V2wSeVocKo7oQAglZ5r
	jmIl3gRs6h97Ha1Y+XA6JnQgqylbNlvboVso9kFa+JNA/LNz33Y52Q1d0z6VAbku
	5lU0GjYHGtDJgp+hJc3OTxX13CblBnYx42f72I+yjMK7i1J6TbebX9hbQSag34V6
	6cjHjFWET0yf+c4bqt+X+4WLe4YNFFGpQ/pZwZL9qmj8Ta6YMNF/1VPbFWkT05Gr
	c0gIOVKKJDPlOB1Dz8wnIsJJhS+m/a2bzZamh3wfVEi5klAJ4C//Rl2NwGmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705573385; x=1705659785; bh=pgWnYFYJkZ8tUzjYD0ERLTOraaVh
	ZcWJp0mKKtPgsUU=; b=H/csWmiH9dTocSfz59ofDcpuOdTaddlO47J7od54mNYh
	jw4nIJKzz7Vc/aCZhaD9T1NpskV7AsM3jkT8OdolSq7eDuHHT5/rZeupHTSdym6u
	TEhY0jZaDuhKLxIrEIk7gJTTgVHx9DGqAx6iexTZ6omvUf1UYLXfWqpuSsEUx40u
	oyf6gz2COyJYwd2NdxWHt9NrPfyZwZkBQN2lDEw/pRORdvvRShZTn8HCk18NQlMP
	tZBv+RLmwdgxogFsCHPuG8skueJ49kFq29TguECS1cTvygNjtIpc6bd2pmJsVLAH
	gfPcMJhOva4MIeWLnXgmmv+isACwR7bguItzGgsi3Q==
X-ME-Sender: <xms:CfyoZVNEdNfBv-tpwYT7Z_Iynrlj50RbBzWO861Q9mywrC-G5rFQPA>
    <xme:CfyoZX_FXXCbb2uCD2NUOhDp-cfUk0SyO4RqEGUD79aId8dHYTfmKDg1mcoJ5jY7-
    P7qlKb2cjxl0_V6TA>
X-ME-Received: <xmr:CfyoZUSJ0UGvATE9APR3JIGqhzlQPoV-DGwZ8s9TJdgXmSF8EFdm1glzFFjyxRXGfhaSvt5rp1cZFNstsg7VtikqlV1ZYAOZguQYIw_GdUHNOC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CfyoZRv2HQ9paeewuIkg5Cnc4FYWAMtVUsE85THdx0hLsNC2k7KMZg>
    <xmx:CfyoZdfPBeLEHrluNrVIW1nY3VaOnkpmCHUQUTpnMb5nsW8XeXjWaQ>
    <xmx:CfyoZd1ETwJuIZnWKJ9eYS1MxZ-M8c_-G4LRqTfTOvg8bMD2mUBKpA>
    <xmx:CfyoZdGJ9QDflOz6UiNHpuwv6wxZqfoRDCG2v7pyOJ5ikRYlULPC5Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 05:23:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5be2654 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 10:20:08 +0000 (UTC)
Date: Thu, 18 Jan 2024 11:23:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: [PATCH v2 5/5] ci: add macOS jobs to GitLab CI
Message-ID: <c5ed38f0a6378297bde8a63bfe8ff8428cc4c966.1705573336.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
 <cover.1705573336.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZcsW+2GCxD/ASQj+"
Content-Disposition: inline
In-Reply-To: <cover.1705573336.git.ps@pks.im>


--ZcsW+2GCxD/ASQj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a job to GitLab CI which runs tests on macOS, which matches the
equivalent "osx-clang" job that we have for GitHub Workflows. One
significant difference though is that this new job runs on Apple M1
machines and thus uses the "arm64" architecture. As GCC does not yet
support this comparatively new architecture we cannot easily include an
equivalent for the "osx-gcc" job that exists in GitHub Workflows.

Note that one test marked as `test_must_fail` is surprisingly passing:

  t7815-grep-binary.sh                             (Wstat: 0 Tests: 22 Fail=
ed: 0)
    TODO passed:   12

This seems to boil down to an unexpected difference in how regcomp(3P)
works when matching NUL bytes. Cross-checking with the respective GitHub
job shows that this is not an issue unique to the GitLab CI job as it
passes in the same way there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 34 +++++++++++++++++++++++++++++++++-
 ci/lib.sh      |  9 ++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 793243421c..43bfbd8834 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -7,7 +7,7 @@ workflow:
     - if: $CI_COMMIT_TAG
     - if: $CI_COMMIT_REF_PROTECTED =3D=3D "true"
=20
-test:
+test:linux:
   image: $image
   before_script:
     - ./ci/install-docker-dependencies.sh
@@ -52,6 +52,38 @@ test:
       - t/failed-test-artifacts
     when: on_failure
=20
+test:osx:
+  image: $image
+  tags:
+    - saas-macos-medium-m1
+  variables:
+    TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"
+  before_script:
+    # Create a 4GB RAM disk that we use to store test output on. This smal=
l hack
+    # significantly speeds up tests by more than a factor of 2 because the
+    # macOS runners use network-attached storage as disks, which is _reall=
y_
+    # slow with the many small writes that our tests do.
+    - sudo diskutil apfs create $(hdiutil attach -nomount ram://8192000) R=
AMDisk
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/run-build-and-tests.sh
+  after_script:
+    - |
+      if test "$CI_JOB_STATUS" !=3D 'success'
+      then
+        ./ci/print-test-failures.sh
+        mv "$TEST_OUTPUT_DIRECTORY"/failed-test-artifacts t/
+      fi
+  parallel:
+    matrix:
+      - jobname: osx-clang
+        image: macos-13-xcode-14
+        CC: clang
+  artifacts:
+    paths:
+      - t/failed-test-artifacts
+    when: on_failure
+
 static-analysis:
   image: ubuntu:22.04
   variables:
diff --git a/ci/lib.sh b/ci/lib.sh
index f631206a44..d5dd2f2697 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -252,7 +252,14 @@ then
 	CI_COMMIT=3D"$CI_COMMIT_SHA"
 	case "$CI_JOB_IMAGE" in
 	macos-*)
-		CI_OS_NAME=3Dosx;;
+		# GitLab CI has Python installed via multiple package managers,
+		# most notably via asdf and Homebrew. Ensure that our builds
+		# pick up the Homebrew one by prepending it to our PATH as the
+		# asdf one breaks tests.
+		export PATH=3D"$(brew --prefix)/bin:$PATH"
+
+		CI_OS_NAME=3Dosx
+		;;
 	alpine:*|fedora:*|ubuntu:*)
 		CI_OS_NAME=3Dlinux;;
 	*)
--=20
2.43.GIT


--ZcsW+2GCxD/ASQj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo/AUACgkQVbJhu7ck
PpTtpQ//ZOJGyZ5Yd1eP+jdrqo+bwAc4Q/NLKws4sXt+MVtcamBIfHLqyza0vZtR
GMpZHOvjV82mNOS6pIMRfYrT1lZBcv8u4rvq13MFFz23Q64x25WD2Zqz3nM9blDU
MKK7Jr1TU/dp/PyXd/QlNny9uyk0/YU6mKHjh8COQO5klRyY2XY3vo1ELBblHopf
Q6HgUAHqvaQ2JVV74BXJXQKQ4UkGuuAyd3EPR6UJJEq53+d0sCT9R4LrvQUdFflJ
BO/39t1+F5+bf6BTrY+nH0MOOe/RxzpLP83eMO2k7plB6pdCgjmQQOufwWfh2Z7Z
w+65u4x3iEOJsUufWfLiX9LbjKaAuhqp1P37hBowoS38kubbLogFZ90JC5k+3reF
JRfGpJVcAIqOjaItzQCRtUcslgysSV4jnPAnGTCsyMLuOeJ38YnwVzAaAd29tGdQ
sbeDpzh2Rd/coNm6gaWzkvMk0BGlh6rp988l2y+YGBfaHhGwKiWI+x89TbJYRkt4
0wJcuDyZZIcMkJrgYtzGSUx/xaTW/S3KnJYmv1S/eTUSw9OskeA9xDjpXSZCe1vh
dNURh9MSKcMecPlbvu+l2vgylH+uyEMEdzaLFA2hb2CpmqRhykBe6RU9+7YhqRml
z0pfTugtRJNTIdGmOlImOkIJdRxtY6eITH0WS1wl2ZCbtdq2nRk=
=6BBv
-----END PGP SIGNATURE-----

--ZcsW+2GCxD/ASQj+--
