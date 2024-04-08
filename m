Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0782555B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558744; cv=none; b=ZB03FwagUJ5bYg2I/UPTEM+I+2ZGE1aEVhmolzamabfWyAtag0F6E2HnbtmNFuX3zx1z1bEwXFq/HJZTIs0YrZ3wZ1RRKfXkM+hDA2PR3y+cSPvbkVDcImqEq2n0tIsb7o/1jGpZZ2kWYoaSUoxZiRpE0ZG1r5meu17B1E4PivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558744; c=relaxed/simple;
	bh=FYsyCa0d3BBV+UdSjHjNaKxSf++eoHTrlcixP5OnrSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKB/OloTecYY5KB4zB10HzioyM/xjcyNxDNg89TzFNJt2NNPLpmutQI3fjJoqR3RonYa25kuy/R33GNvzfxwXYmxZ+9eaT00L5RBGwTG7+TjPgLgzG7xqiuoq544W78cHp/OgtvCk/XsUtMDrQ9MCvDdgPhiaI1wOqtpdnRk1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dTtWsKDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wqF1xc6Z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dTtWsKDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wqF1xc6Z"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 79CD911400D3;
	Mon,  8 Apr 2024 02:45:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 08 Apr 2024 02:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558741; x=1712645141; bh=9B0pjmOrZt
	rmcfR1RPEgaypsH+m0QiK9bkmkGu1NxaM=; b=dTtWsKDV59VQIfKIspzw8smdQR
	Q+IPm4kJ3MtagmSbDgmwb0MBGKoImNR8Z+RRV1D9UepHWoWgkBAT+n4SDYq5fJhU
	XrVnVZbOaU5u9un8U2q3AOlk2/mj8AaMzGJfBKrVj9mLR+qcspuZkv5yN7kGSxcs
	G3TLii767qyE+JAZ1sPSAOmuYiaKx1qZ1okIiA+3fTU3KO0egJwl3VOESfDYTeJf
	ZCShDPquKBikuLN6qyX5dJ41kvF9y+LQrRAkTlXWX33yCmQfrMOFuqAsuBxaWmtU
	41xZQtF5BUYTDda4M5sxWGFQsgwRCTACZAJnWRGg29mPnR8yxVICzUGJ1uyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558741; x=1712645141; bh=9B0pjmOrZtrmcfR1RPEgaypsH+m0
	QiK9bkmkGu1NxaM=; b=wqF1xc6ZWrY0y4EYQ7CT02DEsNmFeA/ltfPt1F988l/t
	yD+PR2X5qTPOm3PsQHHTlFfxSeFDZk3ulylyl/XqD8A12jcwqbiaTOF8GS/LzwRC
	zd02QRIDK5TvQzXIteHV6yI/zt8ZGKEYN0AsWbKqbuFAAk0jPDMucUIum1CiD3m1
	kuaQSu7HGeda3l0gwrrAHc6QqVCqabvTWPR6c7SIygUGxLpSM0E8VrRpviaSC9e4
	JU606U+pqWnyrk0tyaaZC+03IbiR3ll0lXe/5qOFBCKJe7heopoG2iZ3vHp05uUf
	NsJGRrVnvI3FdaYeLvz328ldBa1L7nUx/R+CNhxBOg==
X-ME-Sender: <xms:lZITZtpwURpg-ILSQlns54TS-oXaZzAWIA1R6G-PLMc7ES3AmzK4ww>
    <xme:lZITZvoE_7y8YZvSbD0K95u835Umj7L7zw9w2MI6V1Ul9Yo1lBam4Wtu8RAn8kWbM
    h7kNvzzXnGPWN5tlg>
X-ME-Received: <xmr:lZITZqMS5vBMyAr1m7vfvzdw-JxtQU8ZUFnbiUcJLetkXustJF8c1_xnnC1ZhhrA72iAS9FCoWowd9E9pv8RXQjRs55gow-9SvOgvatLsUp2ju7Drg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvgfevueffffeghfeuvdegteekgefftefgtefghedutedvvddvueeifeelleff
    feenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhm
X-ME-Proxy: <xmx:lZITZo7N2xN6Ca5jvn7GYq6XOIEA4HQ2_EO2zp3k7ggqILMLjb5gjg>
    <xmx:lZITZs7db842_-f6JerVDWy2x5qf527iwlyr8dyjGYe_tlx20Hl1vw>
    <xmx:lZITZgghtwUKryBllDe4LcKkvUzNOka-NkIPnK8V-MEf56SWN68bQw>
    <xmx:lZITZu7Ro8zDUi7WyOG39C2Y-oQZfnjVSm5xu7Md7537jYUm3hcQ2g>
    <xmx:lZITZmQpvWR8T_2rnMTGxOxOofg3-1oT9Z3SDUpVh0to4yuCXwhjLsXY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:45:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0aaf8179 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:45:32 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:45:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/12] t: exercise Git/JGit reftable compatibility
Message-ID: <cover.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QNHprWYGtxXR8n0J"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--QNHprWYGtxXR8n0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that adds compatibility
tests for reftables to check whether the Git and JGit implementations
are compatible with each other.

Changes compared to v1:

    - Patch 8: Clarified that this has been broken for a rather long
      time, but that it was "silently" broken.

    - Patch 11: adapt the fix for the non-portable "local" variable
      assignment based on the discussion.

    - Patch 12: extend tests to do some basic ref comparisons, which
      should exercise indices more thoroughly.

CI runs for this series:

    - https://github.com/git/git/actions/runs/8595241646/
    - https://gitlab.com/gitlab-org/git/-/pipelines/1243766428

Thanks!

Patrick

Patrick Steinhardt (12):
  ci: rename "runs_on_pool" to "distro"
  ci: expose distro name in dockerized GitHub jobs
  ci: allow skipping sudo on dockerized jobs
  ci: drop duplicate package installation for "linux-gcc-default"
  ci: convert "install-dependencies.sh" to use "/bin/sh"
  ci: merge custom PATH directories
  ci: merge scripts which install dependencies
  ci: make Perforce binaries executable for all users
  ci: install JGit dependency
  t06xx: always execute backend-specific tests
  t0610: fix non-portable variable assignment
  t0612: add tests to exercise Git/JGit reftable compatibility

 .github/workflows/main.yml             |   8 +-
 .gitlab-ci.yml                         |   4 +-
 ci/install-dependencies.sh             | 100 +++++++++++++------
 ci/install-docker-dependencies.sh      |  46 ---------
 ci/lib.sh                              |  14 +--
 t/t0600-reffiles-backend.sh            |   8 +-
 t/t0601-reffiles-pack-refs.sh          |   9 +-
 t/t0610-reftable-basics.sh             |  15 ++-
 t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
 9 files changed, 226 insertions(+), 110 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

Range-diff against v1:
 1:  e618129549 =3D  1:  89723b6812 ci: rename "runs_on_pool" to "distro"
 2:  e3e2b7cd50 =3D  2:  e60a40bd65 ci: expose distro name in dockerized Gi=
tHub jobs
 3:  8abc9ad6a7 =3D  3:  16603d40fd ci: allow skipping sudo on dockerized j=
obs
 4:  7cf2538625 =3D  4:  b4f6d6d3bf ci: drop duplicate package installation=
 for "linux-gcc-default"
 5:  38e64224e2 =3D  5:  6abc53bf51 ci: convert "install-dependencies.sh" t=
o use "/bin/sh"
 6:  196dab460a =3D  6:  d9be4db56f ci: merge custom PATH directories
 7:  668553e18f =3D  7:  4a90c003d1 ci: merge scripts which install depende=
ncies
 8:  22f86f8ccb !  8:  5240046a0f ci: make Perforce binaries executable for=
 all users
    @@ Commit message
    =20
         The Perforce binaries are only made executable for the current use=
r. On
         GitLab CI though we execute tests as a different user than "root",=
 and
    -    thus these binaries may not be executable by that test user.
    +    thus these binaries may not be executable by that test user at all=
=2E This
    +    has gone unnoticed so far because those binaries are optional -- i=
n case
    +    they don't exist we simply skip over tests requiring them.
    =20
         Fix the setup so that we set the executable bits for all users.
    =20
 9:  1deded615e =3D  9:  29ceb623b9 ci: install JGit dependency
10:  51c45c879f =3D 10:  fc3472cdf3 t06xx: always execute backend-specific =
tests
11:  c2c2747ff5 ! 11:  cedf5929d1 t0610: fix non-portable variable assignme=
nt
    @@ Metadata
      ## Commit message ##
         t0610: fix non-portable variable assignment
    =20
    -    In `test_expect_perms()` we assign the output of a command to a va=
riable
    -    declared via `local`. To assert that the command is actually succe=
ssful
    -    we also chain it with `&&`. This construct is seemingly not portab=
le and
    -    may fail with "local: 1: bad variable name".
    +    Older versions of the Dash shell fail to parse `local var=3Dval`
    +    assignments in some cases when `val` is unquoted. Such failures ca=
n be
    +    observed e.g. with Ubuntu 20.04 and older, which has a Dash versio=
n that
    +    still has this bug.
    =20
    -    Split up the variable declaration and assignment to fix this.
    +    Such an assignment has been introduced in t0610. The issue wasn't
    +    detected for a while because this test used to only run when the
    +    GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "refat=
ble".
    +    We have dropped that requirement now though, meaning that it runs
    +    unconditionally, inclluding on jobs which use such older versions =
of
    +    Ubuntu.
    +
    +    We have worked around such issues in the past, e.g. in ebee5580ca
    +    (parallel-checkout: avoid dash local bug in tests, 2021-06-06), by
    +    quoting the `val` side. Apply the same fix to t0610.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## t/t0610-reftable-basics.sh ##
     @@ t/t0610-reftable-basics.sh: test_expect_success 'init: reinitializi=
ng reftable with files backend fails' '
    + '
    +=20
      test_expect_perms () {
    - 	local perms=3D"$1"
    - 	local file=3D"$2"
    +-	local perms=3D"$1"
    +-	local file=3D"$2"
     -	local actual=3D$(ls -l "$file") &&
    -+	local actual
    ++	local perms=3D"$1" &&
    ++	local file=3D"$2" &&
    ++	local actual=3D"$(ls -l "$file")" &&
     =20
    -+	actual=3D$(ls -l "$file") &&
      	case "$actual" in
      	$perms*)
    - 		: happy
12:  db66dd4155 ! 12:  160b026e69 t0612: add tests to exercise Git/JGit ref=
table compatibility
    @@ t/t0612-reftable-jgit-compatibility.sh (new)
     +	test_cmp cgit.actual jgit.actual
     +}
     +
    ++test_same_ref () {
    ++	git rev-parse "$1" >cgit.actual &&
    ++	jgit rev-parse "$1" >jgit.actual &&
    ++	test_cmp cgit.actual jgit.actual
    ++}
    ++
     +test_same_reflog () {
     +	git reflog "$*" >cgit.actual &&
     +	jgit reflog "$*" >jgit-newline.actual &&
    @@ t/t0612-reftable-jgit-compatibility.sh (new)
     +		cd repo &&
     +		test_commit A &&
     +		test_same_refs &&
    ++		test_same_ref HEAD &&
     +		test_same_reflog HEAD
     +	)
     +'
     +
     +test_expect_success 'JGit repository can be read by CGit' '
     +	test_when_finished "rm -rf repo" &&
    -+	# JGit does not provide a way to create a reftable-enabled repositor=
y.
    -+	git init repo &&
    ++	jgit init repo &&
     +	(
     +		cd repo &&
    ++
     +		touch file &&
     +		jgit add file &&
     +		jgit commit -m "initial commit" &&
     +
    ++		# Note that we must convert the ref storage after we have
    ++		# written the default branch. Otherwise JGit will end up with
    ++		# no HEAD at all.
    ++		jgit convert-ref-storage --format=3Dreftable &&
    ++
     +		test_same_refs &&
    ++		test_same_ref HEAD &&
     +		# Interestingly, JGit cannot read its own reflog here. CGit can
     +		# though.
     +		printf "%s HEAD@{0}: commit (initial): initial commit" "$(git rev-p=
arse --short HEAD)" >expect &&
    @@ t/t0612-reftable-jgit-compatibility.sh (new)
     +		test_commit_jgit D &&
     +
     +		test_same_refs &&
    ++		test_same_ref HEAD &&
     +		test_same_reflog HEAD
     +	)
     +'
    @@ t/t0612-reftable-jgit-compatibility.sh (new)
     +		" >input &&
     +		git update-ref --stdin <input &&
     +
    -+		test_same_refs
    ++		test_same_refs &&
    ++		test_same_ref refs/heads/branch-1 &&
    ++		test_same_ref refs/heads/branch-5738 &&
    ++		test_same_ref refs/heads/branch-9999
     +	)
     +'
     +

base-commit: 7774cfed6261ce2900c84e55906da708c711d601
--=20
2.44.GIT


--QNHprWYGtxXR8n0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTko8ACgkQVbJhu7ck
PpQ1mw//UhdVFtYE78H74qYDzeUUGkyZcLvs4/sMscto3kx/+XGGJ6XwVdv9fKBj
hK0hLQQu2k0RFQ8ILjpyyPW6IEUlTtwC5XLe/jE8yO7tEeyUTvaHOt9XTl3ePQsh
nqenA7FfXWderRHYOq4/JZtA3yg5VwmEC8kQ867DaK0iQm9Z1kU6qWFyjcN+wh2X
CEyGBLgkyZx62/LrHEXrg+l6nrOn+CYlAkpSTBGOHXFETgyzwdjMMV2RDm6WPqpM
NPqH3ReLtyW3pMrBXo89NUcI8EOJ8NJKaxfDD6tb7GrZAeenyjgfP9Q3PTrzqqrI
lZR4UpvGcj5pdrUs08eVuLkR7FSFzA4ZQ6sR2AtoRpopRBVGt6JYX09XAx44C5hW
jzqjXoWgi76AWi4JUkIA6CEhRKc/FvY1IgyuCKqgQZ2yl2E/wN1CktwQGlH4m5EN
DHsvgXFsNhtc1TYaCsZJRLvfLkiUD6VfPstYtq4o5cwyuscv86gJHxM7h7p2584J
pYV8lGmdV3G5EfISEvorn4vYGCChRYXmM7kQEldoOahrtfULidJ/GfVHbBlmmsg/
AEDXbxRNsQgrQ263g6XFjKSJoZvheolfgnzAtZKeBP0hx1KiW664eu4IgH9KDfJe
Ep2q04Nojxxx27gAZ6L/8WXZL325fpOfGMSD8HEWQvId8iN1yLw=
=RxVH
-----END PGP SIGNATURE-----

--QNHprWYGtxXR8n0J--
