Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315C20B01
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573369; cv=none; b=i2HL++zFY0FuqgGAQI2nBIyxLD+xzsRraeVucaFaTuBPB1N5VqngDFBS0BFs9BUOJlTzbCKbuYRfgy2kRmm/nxIkAwKLXzQKhIu/HO10nlZToo3e9iXD/tsDYZDFBXi3WFlsX7X14tHKW1alO6/XQxg/v8niULAJMRciKxF8/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573369; c=relaxed/simple;
	bh=r3iYOnXXf454+N9G+JpqjN8o9pV1Gop66/xtHdOvzhU=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=AJ/6OaoqlbI8nEWwIMk5sNqMw52/ZJv+CPylLUAZWsmiKE8Iyy0V8ajtEOAtnWyiCei5a3ORu5ReYdRNHLhInkUM74Go/hqCh25bszaS6w1lvy4v5Os3N1+Zxr/DzOy/HsjYNku/V8VlMsA1ln16Vk3UzhV67OgUO5EZQ5Ewsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ptNqBAk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=addnlZtc; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ptNqBAk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="addnlZtc"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9125F3200A90;
	Thu, 18 Jan 2024 05:22:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 18 Jan 2024 05:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705573366; x=1705659766; bh=QIq8bljEIp
	TPyZgfHje2NtChIcZfoHdrOxWXR2LnX34=; b=ptNqBAk7LPkpk0Dxl92/7OefQc
	zNbpVxvhM2zx46uy9P1nOkLFztC3DnnqX+smtSJcJrRHsMs7IGKH78RbGBhWqbRo
	iCDEuEwJzxM7ACP/THmB8B+htFDBNvcOAInbFYg6GWdVWUre3hN01xayakhpFgkd
	wJT7RPkWkCPKAl4Wq6Jxmo6mdFazIzWnG++j5PuN2+3pI/iSbMijtDDFAkuvDrcm
	Yv8kF0YVqkmjy3Ej/2PmjCAr7DK53D1OxF3eqRAkgI/iacCRpFD+NoW5Y38O7+UI
	vEb8zusDVsyxxVWaGgY1PBDkcEXDOHMSnlWspsFq5R3+yxNWnUwDXWPDvCQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705573366; x=1705659766; bh=QIq8bljEIpTPyZgfHje2NtChIcZf
	oHdrOxWXR2LnX34=; b=addnlZtczrz2YO6gwci37MuXCOGlrklpzvOIK4k6wgvX
	9xBZ93IqGH3cdBCel0D+AKp9bm/i9xexn4Gean0eF3uV6qdjztciTOlTT/TcPldr
	+SCjF4OBVF22Jn2AFp+Qx+b1JKANNZ2Xyl3J5vtPzbYKMzvVY8fK7nmDXKyl9EqL
	WDalBo+IX0Kl+0j/3e2JFVz1rZKepqcbQOtt0vv5n1skRgnSSf8SxrqpK+nRD1vN
	a1FIV4twubWIijzFloeH6h4/oMWMuNk1alJu95Knm/kt8LXv5TcIv8MGdy40Ay49
	ia0pcT5Qdu5qByIRhjrv2U9kWWYkKcSFnjSjDhsTyg==
X-ME-Sender: <xms:9fuoZUuGJ1d5FSzm2FGKOZGNoAiuz9WfgJS_2Wh8koVD4299o0X_KA>
    <xme:9fuoZReslb1DV4vgSHQI6EvLhQe2KXlYXUVnqxTu2fRMjzczAGPS0haQxMHDCrUux
    33CVlnMOMVk6QhOYg>
X-ME-Received: <xmr:9fuoZfxH678nvsWFsiw31HzusIXPbtES0KbcsJ-waAvr5d3lLcIA8uO0kMb3Wl8ipva4it7CSVdsKn1J5in1aDlTPYF-suwVnXAcQcnQaGrpuXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9fuoZXN6DUN4zz1HVcLscPdttRgkNqAx-svXEeGx8cTXTC_h02K9Rw>
    <xmx:9fuoZU85CIG2MBZ5iFu62RErhP6esDVZQtAByLfCQuZ6bARxZun_0g>
    <xmx:9fuoZfX8tysYPz78UaRrl_avcek8UZg2nrzWScVW1JnJLWf4eahwzQ>
    <xmx:9vuoZSlBwD4_10mVmBj19smcMyUmT9ifYv6fCmEmH6FCJ4bVD1UGqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 05:22:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cda49e98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 10:19:48 +0000 (UTC)
Date: Thu, 18 Jan 2024 11:22:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: [PATCH v2 0/5] ci: add support for macOS to GitLab CI
Message-ID: <cover.1705573336.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qQkSqZr9hlmLFlCX"
Content-Disposition: inline
In-Reply-To: <cover.1705318985.git.ps@pks.im>


--qQkSqZr9hlmLFlCX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that adds a macOS job to
GitLab CI. Changes compared to v1:

  - Added a fix for a flaky test in t7527 that caused the pipeline to
    fail in ~50% of all runs.

  - Improved some commit messages.

  - Tests now write test data into a RAMDisk. This speeds up tests and
    fixes some hung pipelines I was seeing.

Thanks for your reviews so far!

Patrick

Patrick Steinhardt (5):
  t7527: decrease likelihood of racing with fsmonitor daemon
  Makefile: detect new Homebrew location for ARM-based Macs
  ci: handle TEST_OUTPUT_DIRECTORY when printing test failures
  ci: make p4 setup on macOS more robust
  ci: add macOS jobs to GitLab CI

 .gitlab-ci.yml               | 34 +++++++++++++++++++++++++++++++++-
 ci/install-dependencies.sh   | 10 ++++------
 ci/lib.sh                    | 12 +++++++++++-
 ci/print-test-failures.sh    |  2 +-
 config.mak.uname             | 13 +++++++++++++
 t/t7527-builtin-fsmonitor.sh |  2 +-
 6 files changed, 63 insertions(+), 10 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  554b1c8546 t7527: decrease likelihood of racing with f=
smonitor daemon
2:  3adb0b7ae8 =3D 2:  32d8bd1d78 Makefile: detect new Homebrew location fo=
r ARM-based Macs
-:  ---------- > 3:  d55da77747 ci: handle TEST_OUTPUT_DIRECTORY when print=
ing test failures
1:  a5d725bea7 ! 4:  1ed6e68650 ci: make p4 setup on macOS more robust
    @@ Commit message
         into a separate directory which we then manually append to our PAT=
H.
         This matches what we do on Linux-based jobs.
    =20
    +    Note that it may seem like we already did append "$HOME/bin" to PA=
TH
    +    because we're actually removing the lines that adapt PATH. But we =
only
    +    ever adapted the PATH variable in "ci/install-dependencies.sh", and
    +    didn't adapt it when running "ci/run-build-and-test.sh". Consequen=
tly,
    +    the required binaries wouldn't be found during the test run unless=
 the
    +    CI platform already had the "$HOME/bin" in PATH right from the sta=
rt.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## ci/install-dependencies.sh ##
3:  d196cfd9d0 ! 5:  c5ed38f0a6 ci: add macOS jobs to GitLab CI
    @@ Metadata
      ## Commit message ##
         ci: add macOS jobs to GitLab CI
    =20
    -    Add two macOS-based jobs to GitLab CI, one for Clang and one for G=
CC.
    -    This matches equivalent jobs we have for GitHub Workflows, except =
that
    -    we use macOS 14 instead of macOS 13.
    +    Add a job to GitLab CI which runs tests on macOS, which matches the
    +    equivalent "osx-clang" job that we have for GitHub Workflows. One
    +    significant difference though is that this new job runs on Apple M1
    +    machines and thus uses the "arm64" architecture. As GCC does not y=
et
    +    support this comparatively new architecture we cannot easily inclu=
de an
    +    equivalent for the "osx-gcc" job that exists in GitHub Workflows.
    =20
         Note that one test marked as `test_must_fail` is surprisingly pass=
ing:
    =20
           t7815-grep-binary.sh                             (Wstat: 0 Tests=
: 22 Failed: 0)
             TODO passed:   12
    =20
    -    This seems to boil down to an unexpected difference in how regcomp=
(1)
    +    This seems to boil down to an unexpected difference in how regcomp=
(3P)
         works when matching NUL bytes. Cross-checking with the respective =
GitHub
    -    job shows though that this is not an issue unique to the GitLab CI=
 job
    -    as it passes in the same way there.
    -
    -    Further note that we do not include the equivalent for the "osx-gc=
c" job
    -    that we use with GitHub Workflows. This is because the runner for =
macOS
    -    on GitLab is running on Apple M1 machines and thus uses the "arm64"
    -    architecture. GCC does not support this platform yet.
    +    job shows that this is not an issue unique to the GitLab CI job as=
 it
    +    passes in the same way there.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ .gitlab-ci.yml: test:
     +  image: $image
     +  tags:
     +    - saas-macos-medium-m1
    ++  variables:
    ++    TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"
     +  before_script:
    ++    # Create a 4GB RAM disk that we use to store test output on. This=
 small hack
    ++    # significantly speeds up tests by more than a factor of 2 becaus=
e the
    ++    # macOS runners use network-attached storage as disks, which is _=
really_
    ++    # slow with the many small writes that our tests do.
    ++    - sudo diskutil apfs create $(hdiutil attach -nomount ram://81920=
00) RAMDisk
     +    - ./ci/install-dependencies.sh
     +  script:
     +    - ./ci/run-build-and-tests.sh
    @@ .gitlab-ci.yml: test:
     +      if test "$CI_JOB_STATUS" !=3D 'success'
     +      then
     +        ./ci/print-test-failures.sh
    ++        mv "$TEST_OUTPUT_DIRECTORY"/failed-test-artifacts t/
     +      fi
     +  parallel:
     +    matrix:

base-commit: cd69c635a1a62b0c8bfdbf221778be8a512ad048
--=20
2.43.GIT


--qQkSqZr9hlmLFlCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo+/AACgkQVbJhu7ck
PpSWnBAAhjIDGQwGdSA6V7mvURmdfygaLueTxOljVjwdNfw8NICM6kYQCX/to2JY
GcBuZZvMW+Nkxaq7Zg/v4PG/y0dNYYin0/2R6RtHC1veQDP2MqRkf9NF0ypjPQns
5SaYA2y9S/4Mlv3+IhtNsV+eDShLGWEDvhBgWz56D+ikfBUV7gry479Ti7x4bw0i
FZ2V+K4qoe/3Emi633RiP01owGcJQc4spKRikciGniOf4IxVtC6pJyx02dEBpqzh
ltaX4FUyOtimFJ4zmDf7R7x4bc6cEQpuxVwn3/240ttOgcpUDW425tjFshE8FAxD
0q9nrFil+KHjcWzBfaN/5d39dZta6ihdL72rzHR6WGp42Au/C8KTjsfxvrAVkTsM
HJgGzpJRKRhqm9P5Z0KaGyBjuK6LxnixclsOFiZf9nZAb8wklp8wYRnQaCGSdDQH
SFVbnzb4KW4u2zue+ROumNWcT7pH21GL7rgIeKXpXnBSH08rbdxaAfcgA3wOLQHt
2RgiFO2zVC3l15MiEWZx65aeN8lpL3Ne2jyXOXiuGL+atZwWIk1TmzIy1Dn4Dr6G
PFeY20KWaFn0JtYCOKyzxWKYLUbW4gXOHgO7Vt10SKkou6/CaS4AdOjiBRu72JMR
nsOkzy0UwLdHvvomkAXhV2Jqpc6Q3sCaFqpZsLRF9A7KlNufTSI=
=P7dz
-----END PGP SIGNATURE-----

--qQkSqZr9hlmLFlCX--
