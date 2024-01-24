Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383A17980
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085908; cv=none; b=Cd31ZU6F0g8DhjPNNFQifeybmfwKj3pAblNTA3RDg0lw2XR6t6iuq2qCm5aw7EMpgdWWCOigw5mr4QuMdy/rg1ubsK4PVfO42jxP6wRzLuh/bFSBg294Jc2VenUHk9DagdTXuZhTkv49r0jpAVQz7LbD98Yd2TAMh5N651mG2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085908; c=relaxed/simple;
	bh=ohweDIadrdeC8A4WONKjB1zXhehDv3sMegt3ssaRr2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml2mbQMslsIHUvh9azuNAor/+1H+5QhQf+RrygHupy+cJJbn4vpUx/1GDndQR9lSeQsJqZOCflFmREZQ8Ihf0YXhkQjpUV+Y8mh82B4vK/O9HwdSpwpPZsV2etUHSxv92UGQ6Y+iiXm/DbsxDQTupBy0tams2CVmvHaQNav0Q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FmsjtG+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mo9fkwW3; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FmsjtG+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mo9fkwW3"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 8856C32003F4;
	Wed, 24 Jan 2024 03:45:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Jan 2024 03:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085905; x=1706172305; bh=UHVS0YkuHU
	s4WNECQNXM5tAl0lqv6o4o9brkdho+UaM=; b=FmsjtG+ixTgaZ+BOfPxvDUvQb7
	++6FbwNoHp0eZ/ByY809v9mfR2ZXHeoJsAjbpzyEEYxLosUQThUDIjiIn7amjq8+
	J1qpF6vMB8tRgOM8BSfsfzkgdDPMfIbWyBgcWMUaVJZlYJfmS2INAYM41gHOBxe/
	5zQQaaZDsGQLRVqVCvAGvg/DEGZN2MV1y3E4AwOmAeTQuX/pix5Swwo+m4U/LXw6
	mjqAXUP59qkg5Scc5MmO+gzV2rAJW7O09EEfSbA2N1CSimAMfoZtfAW+pZc1sCQp
	KoCXKVgXjkOJ7xn6hTgXgdi2aSo79w+//5bHZ5ZB+z6QZF0KQUtFm2SbcHMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085905; x=1706172305; bh=UHVS0YkuHUs4WNECQNXM5tAl0lqv
	6o4o9brkdho+UaM=; b=mo9fkwW396Euby0FuRzu9kwKEJSxXovNwp4gcLn8Qg1f
	W97eCCBIrH/xwSiKN5oWkBNT8NdHynrT5jWTM0GLQp21M5kEqcbvo95fW4wQglwW
	Yt9PPz9j0JWkQlJKdf35uhvnvoha0b7ONRJUaTIVXOwIssWIK12amFqoEPpmbfiN
	7yxvYnOZJhaeq4AmCekFgJ5wsnwNoF78vlImN4SjKX9dAlgIVGvhvrbndCSFk7de
	7UU+3AGTajKDdhP4PJEgre9ROXwtzEYkCRgH2UnFGFzOAiXB5/9sXjnFwfqfxNeM
	j6Rnj8lWsl2GVEMltYOFlbVl7VusDOXu3SWeSkusxQ==
X-ME-Sender: <xms:EM6wZcE0zkN6GTX3Dq9kVLaKOzPqrDxtS5oEKqiSWLEjJ9uu0ufSag>
    <xme:EM6wZVX4E2oeOaXmiyjhP4F6zKgklqIqS21mfIeZcQQEsCUz8AbFtVc416TGuwARR
    ye1xO08v33Uprg4_A>
X-ME-Received: <xmr:EM6wZWJyWbeYcunPzFYCv1TjelQ0ItU8jOi0-PO6TKa8rtJp3TKzgn238Uksqmi0UuG0tN5mCD1puno_U0iS8Al8HXqVR4hlioTE44IAfP32BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EM6wZeErFSGxpBx6fUwcOCqd6TDQcmZOG0_KUKSniBR2vtc9131dJQ>
    <xmx:EM6wZSWZH-lRYXEK55nfbP-nrgxz9ipd7u0i0ZNmqyRslIpg1vsIyQ>
    <xmx:EM6wZRMPDmtocQO7ysWUXmc0O6FysW7QhfFvtrK1m5QLagEGALn0vQ>
    <xmx:Ec6wZQz0gBI4FY9OtoOja7qI8rzdy3oatgjJ3CNbJ5FYCBMoKcBgbw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46306d50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:41:56 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/6] t: mark "files"-backend specific tests
Message-ID: <cover.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3WvCzArwIz9sf/x"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--d3WvCzArwIz9sf/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that addresses tests whihc
are specific to the "files" backend. Changes compared to v2:

  - Reworded some commit messages to hopefully explain better what is
    going on.

  - Refactored a test "while at it" to not use double quotes for the
    test body.

  - Removed the now-unneeded OID cache for one of our tests.

Thanks all for your comments!

Patrick

Patrick Steinhardt (6):
  t1300: make tests more robust with non-default ref backends
  t1301: mark test for `core.sharedRepository` as reffiles specific
  t1302: make tests more robust with new extensions
  t1419: mark test suite as files-backend specific
  t5526: break test submodule differently
  t: mark tests regarding git-pack-refs(1) to be backend specific

 t/t1300-config.sh             | 78 ++++++++++++++++++++++-------------
 t/t1301-shared-repo.sh        |  2 +-
 t/t1302-repo-version.sh       | 23 +++++++----
 t/t1409-avoid-packing-refs.sh |  6 +++
 t/t1419-exclude-refs.sh       |  6 +++
 t/t3210-pack-refs.sh          |  6 +++
 t/t5526-fetch-submodules.sh   |  2 +-
 7 files changed, 85 insertions(+), 38 deletions(-)

Range-diff against v2:
1:  0552123fa3 ! 1:  a57e57a7c3 t1300: make tests more robust with non-defa=
ult ref backends
    @@ Metadata
      ## Commit message ##
         t1300: make tests more robust with non-default ref backends
    =20
    -    The t1300 test suite exercises the git-config(1) tool. To do so we
    -    overwrite ".git/config" to contain custom contents. While this is =
easy
    -    enough to do, it may create problems when using a non-default repo=
sitory
    -    format because we also overwrite the repository format version as =
well
    -    as any potential extensions. With the upcoming "reftable" ref back=
end
    -    the result is that we may try to access refs via the "files" backe=
nd
    -    even though the repository has been initialized with the "reftable"
    -    backend.
    +    The t1300 test suite exercises the git-config(1) tool. To do so, t=
he
    +    test overwrites ".git/config" to contain custom contents. While th=
is is
    +    easy enough to do, it may create problems when using a non-default
    +    repository format because this causes us to overwrite the reposito=
ry
    +    format version as well as any potential extensions. With the upcom=
ing
    +    "reftable" ref backend the result is that Git would try to access =
refs
    +    via the "files" backend even though the repository has been initia=
lized
    +    with the "reftable" backend, which will cause failures when trying=
 to
    +    access any refs.
    =20
         Refactor tests which access the refdb to be more robust by using t=
heir
         own separate repositories, which allows us to be more careful and =
not
         discard required extensions.
    =20
    +    Note that we also have to touch up how the CUSTOM_CONFIG_FILE gets
    +    accessed. This environment variable contains the relative path to a
    +    custom config file which we're setting up. But because we are now =
using
    +    subrepositories, this relative path will not be found anymore beca=
use
    +    our working directory changes. This issue is addressed by storing =
the
    +    absolute path to the file in CUSTOM_CONFIG_FILE instead.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## t/t1300-config.sh ##
     @@ t/t1300-config.sh: test_expect_success SYMLINKS 'symlink to nonexis=
tent configuration' '
    + 	test_must_fail git config --file=3Dlinktolinktonada --list
      '
     =20
    - test_expect_success 'check split_cmdline return' "
    +-test_expect_success 'check split_cmdline return' "
     -	git config alias.split-cmdline-fix 'echo \"' &&
     -	test_must_fail git split-cmdline-fix &&
     -	echo foo > foo &&
    @@ t/t1300-config.sh: test_expect_success SYMLINKS 'symlink to nonexist=
ent configur
     -	git commit -m 'initial commit' &&
     -	git config branch.main.mergeoptions 'echo \"' &&
     -	test_must_fail git merge main
    -+	test_when_finished 'rm -rf repo' &&
    +-"
    ++test_expect_success 'check split_cmdline return' '
    ++	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
    -+		git config alias.split-cmdline-fix 'echo \"' &&
    ++		git config alias.split-cmdline-fix "echo \"" &&
     +		test_must_fail git split-cmdline-fix &&
     +		echo foo >foo &&
     +		git add foo &&
    -+		git commit -m 'initial commit' &&
    -+		git config branch.main.mergeoptions 'echo \"' &&
    ++		git commit -m "initial commit" &&
    ++		git config branch.main.mergeoptions "echo \"" &&
     +		test_must_fail git merge main
     +	)
    - "
    ++'
     =20
      test_expect_success 'git -c "key=3Dvalue" support' '
    + 	cat >expect <<-\EOF &&
     @@ t/t1300-config.sh: test_expect_success 'git -c works with aliases o=
f builtins' '
      '
     =20
2:  384250fec2 =3D 2:  fd6dd92c23 t1301: mark test for `core.sharedReposito=
ry` as reffiles specific
3:  1284b70fab ! 3:  ec90320ff1 t1302: make tests more robust with new exte=
nsions
    @@ Commit message
    =20
         In t1302 we exercise logic around "core.repositoryFormatVersion" a=
nd
         extensions. These tests are not particularly robust against extens=
ions
    -    like the newly introduced "refStorage" extension.
    +    like the newly introduced "refStorage" extension as we tend to clo=
bber
    +    the repository's config file. We thus overwrite any extensions tha=
t were
    +    set, which may render the repository inaccessible in case it has t=
o be
    +    accessed with a non-default ref storage.
    =20
         Refactor the tests to be more robust:
    =20
           - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
             repository format version. This helps to ensure that we only n=
eed to
             update the prereq in a central place when new extensions are a=
dded.
    +        Furthermore, this allows us to stop seeding the now-unneeded o=
bject
    +        ID cache that was only used to figure out the repository versi=
on.
    =20
           - Use a separate repository to rewrite ".git/config" to test
             combinations of the repository format version and extensions. =
This
    -        ensures that we don't break the main test repository.
    +        ensures that we don't break the main test repository. While we=
 could
    +        rewrite these tests to not overwrite preexisting extensions, it
    +        feels cleaner like this so that we can test extensions standal=
one
    +        without interference from the environment.
    =20
           - Do not rewrite ".git/config" when exercising the "preciousObje=
cts"
             extension.
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## t/t1302-repo-version.sh ##
    +@@ t/t1302-repo-version.sh: TEST_PASSES_SANITIZE_LEAK=3Dtrue
    + . ./test-lib.sh
    +=20
    + test_expect_success 'setup' '
    +-	test_oid_cache <<-\EOF &&
    +-	version sha1:0
    +-	version sha256:1
    +-	EOF
    + 	cat >test.patch <<-\EOF &&
    + 	diff --git a/test.txt b/test.txt
    + 	new file mode 100644
     @@ t/t1302-repo-version.sh: test_expect_success 'setup' '
      '
     =20
4:  c6062b612c =3D 4:  d0d70c3f18 t1419: mark test suite as files-backend s=
pecific
5:  ae08afc459 =3D 5:  066c297189 t5526: break test submodule differently
6:  df648be535 =3D 6:  7b8921817b t: mark tests regarding git-pack-refs(1) =
to be backend specific
--=20
2.43.GIT


--d3WvCzArwIz9sf/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwzgwACgkQVbJhu7ck
PpQzGQ//dYJYiSSx2TftRkzJmYUmNP8G0rC+1iCEZh8GHHXpkm6+u7Uh31OeApSs
vCJaS1r9p+aRB7ntYED+tSokXbbu6PJJxviDwooq6q5JwRSGIQeynaCSNC2/m3VY
RP3/5wWkHsUhSl/nptySOSPvcOlrtsqf+jay/WZOlcKyZoLyAr8AZQUN8zvqicOI
JAOzcBa4O0uwpYlHEICGEMA4okkqUiPLbEsUpYpu4LBLa9+0TxdHEmHJx9nqRECc
W0MUQCCX9fblOsZX331LAp60rSkZqGTJR0zvHlM0wm2yzVPtuDZgnkfkIltK/cNa
Ixz1wcpaJ3JqcZ44kvb7JAlfV3k4yGLKLjDD133R2o1eov4tWo4TrhmDTMMKXpEe
WabeZAcZ4WXsBVRltveCVbWgGJJ7ZIiSWja4fHU+s6mnjSsVt7eznpqy3CTAvBIE
ZwwMw/FQ6bbg6q0SNAVhqKXyRbOpyAbHqgUbKx7kgDCC9NwvJJqTjjssghTua8P5
U63sDK5FDTeijpK2s/RS3E01w8R2zYmAi9MTV9grDkGvmT+qYYdfEtV+FQ2FV2vM
IaH9UfYbUqsQwhk9N0opOx07gonOwCJjOvNul+QqJGXRNkdA75o+YUpvJq9ybpu6
6IrkesUZYrmYCoEt01Xh5daiNB6rDKZ+E2VHhn6hd6XA2ZhsOW0=
=Z1FR
-----END PGP SIGNATURE-----

--d3WvCzArwIz9sf/x--
