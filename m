Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF278B78
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707197687; cv=none; b=FTREpd1JmMdDhqIjMIY3J+zHte7jVxrxXw+lObKD7wHwZoMew2l0wvFyrv8I8ZYdyEPsO5QEtfQPVmgk6Yx1JH7l8E+MO5A8JMQzawnC1RgDaV4ELVADkUc+laF8hWaoViSQvIoQlJPJww/f1j7+RDQPhSjzOpkJlTKE2VysDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707197687; c=relaxed/simple;
	bh=5bqDkpdnZgXgYrKO5+h3Ys66pMW0rflvUzo/JYUeV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWkilqLj6EepcGsRgAjkUBl80PIMUxU0N1BJMJzkrwHVHCjo/Ak7pI/yWfwaRrwo/n6HiD9PqkOBAvn/kKkXdvNn8bxpbiLULo3Qhrgi1zEOGB4sSYbyjNRg/NItcJqtDyXF+mBIMu8l7I9QBxudWeGP9VmSoIiInf5rkFBe+cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SrFhq2Hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpCh2Th6; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SrFhq2Hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpCh2Th6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 585B55C0081;
	Tue,  6 Feb 2024 00:34:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 00:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707197684; x=1707284084; bh=kMImrr5Vgw
	Ymv9IhDvW1sC7q5IhBCigeuVfq5sns2X4=; b=SrFhq2HvxzBDWP1PtswIIdIhqA
	CZwUutolJH7RuOPukfH0a0yTmJXk3ib5h3LnAZpNl7tqoPw9j6uu0LonNJPD+32W
	nsi2yKRr6lekpZQFFS1oTx+ZM4qg2V6RHIozabm8zUJMiVmVt1WHgLAt3QK+vqDr
	rcG8zphXcU58MA0NiQbp0j4h/DFMVUz3svLnxLMSQGtN+/n6osJ1FDfZMJfPJouE
	A1XNKz6wFdoYxqoImKXng5jdxqcVRq7cOdyBLqI9rpmSXzA+Vf5bUb0Oh84MAegS
	q45+J0RcRPokIWYThl420cZ3RbFGAabbgmcaqQDTPQ3dpMgLloPWpYyKFx9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707197684; x=1707284084; bh=kMImrr5VgwYmv9IhDvW1sC7q5IhB
	CigeuVfq5sns2X4=; b=wpCh2Th6z67/nRX66T8G30ZKJ7juEG7R68cUYSv9OGc8
	4GCeWY6tAkJvhYWK3xBVrOsnEw6qhCwsnjHQVfKaV0igUzUKGHTDGdiAYzThgzsZ
	P+RE8zI6tV71Kj0L7V1xgLk7hXqsXf+uqL/H77SRfL21/XvjYOT4ziKaysLtsFSM
	b2pwycViIlUhvb4d+VstUvduS5M8Rx/wveisMYd8o7kfolBk/qnoJ+xTaQC/wYay
	m1fTONvmTy/hRXUfV6OqK933K23pyW8SbNJTVBakJEafcwM+WmYx1f0ALsBGRLrO
	5CjvcFF5LqpKqMRnfIq8Gh4c6NuBDwwSs2a7fv1CvA==
X-ME-Sender: <xms:9MTBZeBHZcPm-QvUPVsAl-pIi9SzWfaHVJ6o2cg1u3dRFsRhDNMMVA>
    <xme:9MTBZYj2KPsmFlP3uzCcrYbNi_0ppTjxQQPI70gDHOy4f1oQ2DPjz9rogVM7Ot_N8
    BYUr4ClK_wc_8MLxg>
X-ME-Received: <xmr:9MTBZRmAr-rolfLzLrYO3aSq-zwJdCw9SSoFRMcDVlgeGd3K0FGpjgPF9TBwj5-fvb066Si_PIagQipv8IO51-YOIX4C3xiN6ZZAGolz44FTP7L9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9MTBZcxsv6PejCUmlLsPwFViQm4jW59uAmCCslN55VjLXjtaBJuTdQ>
    <xmx:9MTBZTRflCRT7zvbVF5M9C_qHhcv9VROiT40QUbadLBTTZXz0hd8bg>
    <xmx:9MTBZXbdiz27NNtiC_GKM8D-akywN9bLmFl1bdunujpyFI5TlIDijA>
    <xmx:9MTBZdc7Sv_gLDiZohelfD-EsVYLmy2Qe5XY0At52QHJ_9NfAwf0fA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 00:34:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d309408a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:31:13 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:34:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: moti sd <motisd8@gmail.com>,
	=?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] builtin/stash: report failure to write to index
Message-ID: <cb098cf88cbfcbf7c4872f8887856629b909cb91.1707197653.git.ps@pks.im>
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="psOVEZ4oMQDJEi/k"
Content-Disposition: inline
In-Reply-To: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>


--psOVEZ4oMQDJEi/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-stash(1) command needs to write to the index for many of its
operations. When the index is locked by a concurrent writer it will thus
fail to operate, which is expected. What is not expected though is that
we do not print any error message at all in this case. The user can thus
easily miss the fact that the command didn't do what they expected it to
do and would be left wondering why that is.

Fix this bug and report failures to write to the index. Add tests for
the subcommands which hit the respective code paths.

While at it, unify error messages when writing to the index fails. The
chosen error message is already used in "builtin/stash.c".

Reported-by: moti sd <motisd8@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Range-diff against v1:
1:  f114688eac < -:  ---------- drop dot
2:  b13a5a10ac ! 1:  cb098cf88c builtin/stash: report failure to write to i=
ndex
    @@ Commit message
         Fix this bug and report failures to write to the index. Add tests =
for
         the subcommands which hit the respective code paths.
    =20
    -    Note that the chosen error message ("Cannot write to the index") d=
oes
    -    not match our guidelines as it starts with a capitalized letter. T=
his is
    -    intentional though and matches the style of all the other messages=
 used
    -    in git-stash(1).
    +    While at it, unify error messages when writing to the index fails.=
 The
    +    chosen error message is already used in "builtin/stash.c".
    =20
         Reported-by: moti sd <motisd8@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/stash.c ##
    +@@ builtin/stash.c: static void unstage_changes_unless_new(struct obje=
ct_id *orig_tree)
    + 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
    + 	if (write_locked_index(&the_index, &lock,
    + 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    +-		die(_("Unable to write index."));
    ++		die(_("could not write index"));
    + }
    +=20
    + static int do_apply_stash(const char *prefix, struct stash_info *info,
     @@ builtin/stash.c: static int do_apply_stash(const char *prefix, stru=
ct stash_info *info,
      	repo_read_index_preload(the_repository, NULL, 0);
      	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
      					 NULL, NULL, NULL))
     -		return -1;
    -+		return error(_("Cannot write to the index"));
    ++		return error(_("could not write index"));
     =20
      	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
      				NULL))
    @@ builtin/stash.c: static int do_create_stash(const struct pathspec *p=
s, struct st
      	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
      					 NULL, NULL, NULL) < 0) {
     -		ret =3D -1;
    -+		ret =3D error(_("Cannot write to the index"));
    ++		ret =3D error(_("could not write index"));
      		goto done;
      	}
     =20
    @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps,=
 const char
      	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
      					 NULL, NULL, NULL)) {
     -		ret =3D -1;
    -+		ret =3D error(_("Cannot write to the index"));
    ++		ret =3D error(_("could not write index"));
      		goto done;
      	}
     =20
    @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even =
when we hit
     +		touch .git/index.lock &&
     +
     +		cat >expect <<-EOF &&
    -+		error: Cannot write to the index
    ++		error: could not write index
     +		EOF
     +		test_must_fail git stash create 2>err &&
     +		test_cmp expect err
    @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even =
when we hit
     +		touch .git/index.lock &&
     +
     +		cat >expect <<-EOF &&
    -+		error: Cannot write to the index
    ++		error: could not write index
     +		EOF
     +		test_must_fail git stash push 2>err &&
     +		test_cmp expect err
    @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even =
when we hit
     +		touch .git/index.lock &&
     +
     +		cat >expect <<-EOF &&
    -+		error: Cannot write to the index
    ++		error: could not write index
     +		EOF
     +		test_must_fail git stash apply 2>err &&
     +		test_cmp expect err

 builtin/stash.c  |  8 ++++----
 t/t3903-stash.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 26489b76c0..d65cd20ee6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -520,7 +520,7 @@ static void unstage_changes_unless_new(struct object_id=
 *orig_tree)
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("Unable to write index."));
+		die(_("could not write index"));
 }
=20
 static int do_apply_stash(const char *prefix, struct stash_info *info,
@@ -537,7 +537,7 @@ static int do_apply_stash(const char *prefix, struct st=
ash_info *info,
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL))
-		return -1;
+		return error(_("could not write index"));
=20
 	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
 				NULL))
@@ -1364,7 +1364,7 @@ static int do_create_stash(const struct pathspec *ps,=
 struct strbuf *stash_msg_b
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL) < 0) {
-		ret =3D -1;
+		ret =3D error(_("could not write index"));
 		goto done;
 	}
=20
@@ -1555,7 +1555,7 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
=20
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL)) {
-		ret =3D -1;
+		ret =3D error(_("could not write index"));
 		goto done;
 	}
=20
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3319240515..00db82fb24 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1516,4 +1516,56 @@ test_expect_success 'restore untracked files even wh=
en we hit conflicts' '
 	)
 '
=20
+test_expect_success 'stash create reports a locked index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A A.file &&
+		echo change >A.file &&
+		touch .git/index.lock &&
+
+		cat >expect <<-EOF &&
+		error: could not write index
+		EOF
+		test_must_fail git stash create 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'stash push reports a locked index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A A.file &&
+		echo change >A.file &&
+		touch .git/index.lock &&
+
+		cat >expect <<-EOF &&
+		error: could not write index
+		EOF
+		test_must_fail git stash push 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'stash apply reports a locked index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A A.file &&
+		echo change >A.file &&
+		git stash push &&
+		touch .git/index.lock &&
+
+		cat >expect <<-EOF &&
+		error: could not write index
+		EOF
+		test_must_fail git stash apply 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_done
--=20
2.43.GIT


--psOVEZ4oMQDJEi/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBxPAACgkQVbJhu7ck
PpThuw/+KCX8IWMs38BMLxenFNLWMIFlkFos9cJPds7munKGGcbkBq8J/C5W8qIF
1o2GT1geD+q+kPTAKMial6o53kEsatOvBKN6ZBHoNtAsgh3Kt84zPG//1hWsgXft
kUEFrwbySa83GZOb7/SznjBG+mrjS2LrXUSwCHh7gZEUlkw9rKXo72A+tSIKqAnD
E++RwfjbU7F6g0kkX65hQyocEv4gLEvOpsxx3d8plkKCtZmmTwM22SqQWTvfot6W
9rlTm4VLK5m4FeII/fAqUGSmglP8ntt03LEnb2MC4pFo+BWUS8Q7nMdDJOrgMawD
ywPN1EmxGv9DxLjFVYouoHO4c6ZTjsnoD0HgU1O2Vue3v8VdjnX3z0U97gb2uPqI
tcXT4v/Gpj9Oc0S6X7UnhXNugiileY2goTAGFRe4nxT8ajPrUh6rXjII8oZiS2Js
dWDb6m/rvtJj+iI1FW3n+C+uWvop54UcqozTbS+OBfVTKy0pPgTw6P0zUXeDPHZa
jfXepmATTUmNbtP5WzbGTBsv7M7fMIWHMwW0mOetV30jzQXW+Gx0pwnlw4MsRBjp
+TwD0llCB4N3FbcevoOlL5Iu8fqta9gLi6h8hpXsM8PodIGSwmasvJjDcBtdc4LX
cofXYGOMZdDTaAqxYuRK1lIbwwhMBHwQyvgibcnCJptPvd5xi40=
=V3lr
-----END PGP SIGNATURE-----

--psOVEZ4oMQDJEi/k--
