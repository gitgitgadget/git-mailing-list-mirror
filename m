Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166F6FB5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826601; cv=none; b=MX+VL/aL3VmpNxlwOIP+xZBCaP3VIfUxxrpbD5q4xITsL/A/ge/r+xxf4gl4q8j8L59XISo4qJ5DL8ISrbcdSIPYr2UL0K18n2ZBa6vHiocl/auktiJ0gBpY7y6JhfN0hpVfNwrW/0VoAzDkLSOt6pbCCmT6cqivXqaOE0oIfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826601; c=relaxed/simple;
	bh=A3I6MDbG9klYW/MSf9vOTe58h1KTLnyaQTL3G8aE+oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiBxGDOgTuldmVsrg3UGleIKLRAgfYg4A+yPILX3Re9yAzTGjqXM+/yba7HFxAuhPkM90alGaftwQag3lIPxyeEW/u0lqjJig1dy9I6bCbwFHqPNhemC5lpP46jzm+indG3dHekPbg0PuuM1pDRgGctoQRFvPAHbSfLlQKuVHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d+WBcaut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T25nGJJ1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d+WBcaut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T25nGJJ1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5E8AA1140174;
	Thu, 11 Apr 2024 05:09:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 05:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826598; x=1712912998; bh=EE17XkUC2l
	FZveNeY1CAPoovF8CYatLDj05oD5mPXD0=; b=d+WBcautiirhoavhlfUoPXw6a9
	4lYHeSwuSrtSeimFBKqhGKXQn5PZx1vTIOcE3R5Dd28Ueb3PvpPx8GTOT7Jz24rH
	Chber416foGxWhuzXlNGO5MBqMWXsdP1swxX755zK1RKEZytJ+8HUNDllcRr9Ybi
	W9IhEzR+uBxppoUyRfKFUtc1aiQ3D79Tq2TEHbNH/x1RFoAh/7Hqf4cIrfYg+nV9
	ERD4qdQg2UVqYdCgucOmPmZjY9dm3c9DCITd56mQEKCGxMvcbNJcSA0s9daS2W4m
	umVf2dQO5Ogy827XdJLdDj/YQ8J3/DZF+HHf+uQGL5ZEXFrg8PRSn/nkrn6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826598; x=1712912998; bh=EE17XkUC2lFZveNeY1CAPoovF8CY
	atLDj05oD5mPXD0=; b=T25nGJJ1ozmTmvTM2p3xH6IVIwfDQpy/OtWS8wymc7l6
	DtK2B4ERdIPFpkdwIsrM+SFHQdVmzLr52ZeiJxZFFDRpdHdQHvzUhWb5D2WbA8zy
	W+IGkq8uHBIrVWkYHCYqaar75x+JpeWrxPSm6k72G9pUzvpR1EPRGX33K/1rV6TS
	0rY97rYbgOWF+r6vD+ICDwRB1jxH0cBHZJK0VSpVEMnje8jH+snjhLaoDNKl6UTg
	jbEjpctMpRV6vwco1O/XFvdJax297BZDGSCIsnzc5rMYH7ZhIQhXjI1XDU4GA37f
	c/jPP3a6eLQ/S0vPGqFF+X/RmiqxkhRe2Ua0AyVhLA==
X-ME-Sender: <xms:5qgXZgYkXaQcitH01mo-S2bU7bmhkE4IO1DWyUlb2CqRyu2yOzxk8g>
    <xme:5qgXZrbWg1uZP6Tie_tZmTIdh2Y0EOUmik2oXFW8H8K41L3RqBY1i-YWs4bdwORXY
    5UAceHez2n33jfMQQ>
X-ME-Received: <xmr:5qgXZq9HMiX_ozW3D1Xp28uzJtpYLeJxe1xQI4nZKIqN0NJKaXa_CqC-Yn-wvEUeBMoEFE0wQnGLrMQMUe_UXuqOOY_MoTIx5yv9aP_czm2a31NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdevledtffevleefffeltdffuedvtedtkeejgeehudekveehleetjeduudegjeei
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhshhdqrd
    gtihdpihhnshhtrghllhdquggvphgvnhguvghntghivghsrdhshhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5qgXZqorBx_-TmIVPJKa4qWcTuJAys-xrEHdo4YRvW6cgYjOrSEb2A>
    <xmx:5qgXZroXRJAI2mQ3Ixhku5PzBlms2yrzc1Id3PM5F_CpbH7P2B7sYg>
    <xmx:5qgXZoTSrUY0IuQ6Qcs86u8ws76XHJDu6hi_ERFcCU0m2bqqfhvgTw>
    <xmx:5qgXZrrLcj-k4zbAgRQVMoNVor1Ai-99MgwfeYh4b9THbDF4ageyUA>
    <xmx:5qgXZnJ6CMFuJks2xvVM3WpI7e8ncrxh6LuXaimPb2y_Wk0L-4WrtIgG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:09:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 58685c52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:09:43 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:09:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <cover.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5399HVjoQ+jLvKH"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--u5399HVjoQ+jLvKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that introduces
compatibility checks for the CGit/JGit refatble implementations.

Changes compared to v2:

    - Adjusted commit subject for the skipping-sudo patch.

    - Broken an overly long line in "install-dependencies.sh".

    - Fixed tests that depend on custom binaries not running on GitLab
      CI due to the unprivileged-user setup.

    - Fixed some typos.

CI jobs for this version:

    - https://gitlab.com/gitlab-org/git/-/pipelines/1248875682
    - https://github.com/git/git/actions/runs/8643984413

Thanks for all the feedback!

Patrick

Patrick Steinhardt (13):
  ci: rename "runs_on_pool" to "distro"
  ci: expose distro name in dockerized GitHub jobs
  ci: skip sudo when we are already root
  ci: drop duplicate package installation for "linux-gcc-default"
  ci: convert "install-dependencies.sh" to use "/bin/sh"
  ci: merge custom PATH directories
  ci: fix setup of custom path for GitLab CI
  ci: merge scripts which install dependencies
  ci: make Perforce binaries executable for all users
  ci: install JGit dependency
  t06xx: always execute backend-specific tests
  t0610: fix non-portable variable assignment
  t0612: add tests to exercise Git/JGit reftable compatibility

 .github/workflows/main.yml             |   8 +-
 .gitlab-ci.yml                         |   6 +-
 ci/install-dependencies.sh             | 101 +++++++++++++------
 ci/install-docker-dependencies.sh      |  46 ---------
 ci/lib.sh                              |  14 +--
 t/t0600-reffiles-backend.sh            |   8 +-
 t/t0601-reffiles-pack-refs.sh          |   9 +-
 t/t0610-reftable-basics.sh             |  15 ++-
 t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
 9 files changed, 229 insertions(+), 110 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

Range-diff against v2:
 1:  89723b6812 =3D  1:  46502bbe22 ci: rename "runs_on_pool" to "distro"
 2:  e60a40bd65 =3D  2:  d076ed9857 ci: expose distro name in dockerized Gi=
tHub jobs
 3:  16603d40fd !  3:  cc0c29052f ci: allow skipping sudo on dockerized jobs
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    ci: allow skipping sudo on dockerized jobs
    +    ci: skip sudo when we are already root
    =20
         Our "install-dependencies.sh" script is executed by non-dockerized=
 jobs
         to install dependencies. These jobs don't run with "root" permissi=
ons,
 4:  b4f6d6d3bf =3D  4:  803f5020e0 ci: drop duplicate package installation=
 for "linux-gcc-default"
 5:  6abc53bf51 !  5:  d2745e9438 ci: convert "install-dependencies.sh" to =
use "/bin/sh"
    @@ ci/install-dependencies.sh: ubuntu-*)
     -		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
     -	popd
     +	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.=
tar.gz"
    -+	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$GI=
T_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
    ++	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
    ++		-C "$GIT_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_V=
ERSION/git-lfs"
     +	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
      	;;
      macos-*)
 6:  d9be4db56f !  6:  61f108d954 ci: merge custom PATH directories
    @@ ci/install-dependencies.sh: ubuntu-*)
     =20
     -	mkdir --parents "$GIT_LFS_PATH"
      	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.=
tar.gz"
    --	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$GI=
T_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
    -+	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CU=
STOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
    + 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
    +-		-C "$GIT_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_V=
ERSION/git-lfs"
    ++		-C "$CUSTOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VE=
RSION/git-lfs"
      	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
      	;;
      macos-*)
 -:  ---------- >  7:  ef61b578da ci: fix setup of custom path for GitLab CI
 7:  4a90c003d1 !  8:  7748f87f8c ci: merge scripts which install dependenc=
ies
    @@ .github/workflows/main.yml: jobs:
            if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
    =20
      ## .gitlab-ci.yml ##
    -@@ .gitlab-ci.yml: workflow:
    - test:linux:
    -   image: $image
    +@@ .gitlab-ci.yml: test:linux:
    +   variables:
    +     CUSTOM_PATH: "/custom"
        before_script:
     -    - ./ci/install-docker-dependencies.sh
     +    - ./ci/install-dependencies.sh
    @@ ci/install-dependencies.sh: then
      	mkdir --parents "$CUSTOM_PATH"
      	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
     @@ ci/install-dependencies.sh: ubuntu-*)
    - 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CU=
STOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
    + 		-C "$CUSTOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VE=
RSION/git-lfs"
      	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
      	;;
     +ubuntu32-*)
 8:  5240046a0f !  9:  f7399382f2 ci: make Perforce binaries executable for=
 all users
    @@ ci/install-dependencies.sh: ubuntu-*)
     +	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
     =20
      	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.=
tar.gz"
    - 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CU=
STOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
    + 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
 9:  29ceb623b9 ! 10:  b835ff8b78 ci: install JGit dependency
    @@ ci/install-dependencies.sh: ubuntu-*)
      		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libd=
bd-sqlite3-perl libcgi-pm-perl \
      		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
     @@ ci/install-dependencies.sh: ubuntu-*)
    - 	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.=
tar.gz"
    - 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CU=
STOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
    + 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
    + 		-C "$CUSTOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VE=
RSION/git-lfs"
      	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
     +
     +	wget --quiet "$JGITWHENCE" --output-document=3D"$CUSTOM_PATH/jgit"
10:  fc3472cdf3 =3D 11:  7136c8b6c2 t06xx: always execute backend-specific =
tests
11:  cedf5929d1 ! 12:  cf4ee9c427 t0610: fix non-portable variable assignme=
nt
    @@ Commit message
    =20
         Such an assignment has been introduced in t0610. The issue wasn't
         detected for a while because this test used to only run when the
    -    GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "refat=
ble".
    +    GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "refta=
ble".
         We have dropped that requirement now though, meaning that it runs
    -    unconditionally, inclluding on jobs which use such older versions =
of
    +    unconditionally, including on jobs which use such older versions of
         Ubuntu.
    =20
         We have worked around such issues in the past, e.g. in ebee5580ca
12:  160b026e69 ! 13:  a9cd20eebc t0612: add tests to exercise Git/JGit ref=
table compatibility
    @@ t/t0612-reftable-jgit-compatibility.sh (new)
     +
     +if ! test_have_prereq JGIT
     +then
    -+	skip_all=3D'skipping reftable JGit tests'
    ++	skip_all=3D'skipping reftable JGit tests; JGit is not present in PAT=
H'
     +	test_done
     +fi
     +
--=20
2.44.GIT


--u5399HVjoQ+jLvKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqN8ACgkQVbJhu7ck
PpTotw/7BKp2z3+U6RDqA0srxhtUAqXgCDHbCO5tsYmqu9brl+yV+CB6tQbT/O0A
ehoyCF79T4fhwmn0xFGleWLrSTJ/crH/zRf/kjWlqsnsXSis+RHi6Nj43/flv/Sf
ZpPLWYt2TMws98UdKR4rl7PZCQIsu0Xb8CCMUfjLpRPwrUraJbt+/xrKiYPQGDPw
1hcwgI1Aejmzp/7OEABpowKWw0GsEkaxcs3mFkwSa1QuBleOYAy56VKvQKgbA+a9
3PfKWSok5CzoYhAouV0kZzA4fwxc2GQMNcAhKTcvqPl3dCxOWjnMWFERyS/fi6RB
pacruvLxOrPqnOlNrhnUbDEDFbFEqN1mfLktE9NSwfw1GSROsdOhxJUe8+mHAa/E
eM1F23Fjv69q7oAUR2oywslrVBDUgqIUio4b8+yJxSyovj7zHcUcXllTT8vpSGaM
qksxFybFBUZCp6NfCRgpnSyNxbafvmO1CDEb25at/bzr8fUBNwAQQC7ZYoHS/abM
qTxvwInp29KEuHYLv5NYC47LCUpQYCQTVTBcG5prmby/Gf1O691qZAAnmJNA/Vbb
OBxGy9sXDmSMuE1kmEI2jScJK+vqOOMkEZhl0QedokeOL6PpfZIY23OqAeSCsDnE
MY/WE3nxk741ojutvA1pRkKBf6JTiNj3lSv8bZXEqUR0fFxXZ+4=
=zOLw
-----END PGP SIGNATURE-----

--u5399HVjoQ+jLvKH--
