Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7082492
	for <git@vger.kernel.org>; Wed, 22 May 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374336; cv=none; b=Y+QSYvL8UtpNFN5J4k+q3ePiths+QYc6l8VetNw2Zts1laUuJKJ/odbnmEVYzUzSlxJ/nKvpIT7aWkh1Fm92Mw9KxeIOWJzMEW8bjcL4n9bF0uT3z0RdyvWYZSuWfEZtZvXLvSu9WJRSBQ2b0VIQoHjm1dGr0tfU/QQ4sW5sI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374336; c=relaxed/simple;
	bh=2501wksn8Z+oRdF/70MV9wKAwG8W6Lyih4MkcxwBj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfbEl/IHNXVQ8iNLyElHpJmy0Hlmc2G4U+hy3TfAx7kSJA9EYyxwnBDjAmZQUHFEQXsyoRtPBBddnqWMJk8lsM959CFBdlDRQg8TO3llCWrtmQM7mMABw9WFuJFnYtsBlsIssGYDP3ZTO6rFrajDdrzrPBFH2yZ+YRfxtaIPtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fffw9+6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUtJ3Wkk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fffw9+6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUtJ3Wkk"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7268C13800E5;
	Wed, 22 May 2024 06:38:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 May 2024 06:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716374332; x=1716460732; bh=ASybUv5Vr1
	JJ3EBkJi9DfkXi0FJSSC+Cbzah/msZ3bk=; b=Fffw9+6drgo6GfW+7P5CDW8EeN
	JMIUui5KfDwKOGATj+BrOggBdHPFvR5CAeGJr575qXxrJfms78qcTgfa/nCBGsBi
	J4edHwGYMncaefH568ovuBJ3T4f3pUtJl6VhIjtQQcZ8anVleCa98Ct3xAfzOpp4
	/KraK50pzIRFkbK2h/xQPxWEbilatfum9E1s16HnH2XS20TkSct6ykzkodmp1lXq
	4GoRPb8IzQGU5PMbABZ3LELCrDwSpc1yyRTrFxv3JtyxuVaYbDOFlhQRS6qUAyuG
	muB4B4UpfgbMdHkb5rTGhF8A1wvUSZ63DjxKexuW9oEiKT17El23t+sg7DYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716374332; x=1716460732; bh=ASybUv5Vr1JJ3EBkJi9DfkXi0FJS
	SC+Cbzah/msZ3bk=; b=lUtJ3WkkbBoJJ5WEoW/GHYQ9rZhFmxIoqqFbv1SYvAAk
	Iy6lIhbJLz2lIaNitgQou+FXMUW0LG21S1PhzX8pztJUXd//u9cAMSC0u0iQ0wcu
	FJnX+KVmbIwy2wZ8xgVdaicXQS3npPR/2600xR29IUZmqHpXEq/cPbmpgOs3jSOP
	o4z01292StAKNr3XxAnqXL60SLY3rs7XtLuqXLGg34ChYzPtCy9/DSuFqNEVNXud
	RaxASrj/u28GEGZOLtIvSf/ylZi28ofaBbt8ddhg2UnltBmCCtDC31NU0gTJ+Dct
	dH3JwXfmU2IGxVl1ejmu9LSi4ftLDdMdsEJ/PJ8uag==
X-ME-Sender: <xms:PMtNZp3xqK4-Ir50nh_L9fTbT-75kRvh5ZQSuyS-fpeRzY76WmgNxA>
    <xme:PMtNZgEKtFGOLqdlns9kBmteiwbMyghaauyyPHc53D2zBanGL5HVHIawnl2rpXL8Q
    Q5tQ1Hu3kHaVdvI9A>
X-ME-Received: <xmr:PMtNZp6A8ZibdNrmeNGTUI3USRNlh8mAI3VynNm7PJCJPh_bdDQbNEVZviFZW2I7x-14SaE1Eq5c99jIypN_0g9aTYpJXMbENGRwimshvXss5Dxf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PMtNZm0j7fKlk55KvwPZOucRd7TVtU65GbMpGtsNPSgTuLnnVF8xRw>
    <xmx:PMtNZsHHi-fQdBA8p7QuBwY3sPrwJgE8JJrrRQVDX4sbG0MkFw1nWg>
    <xmx:PMtNZn8PzjCwDIGx2J19E9qMPebjeZ5ishwK6sBus4ymjxUhPQNh2Q>
    <xmx:PMtNZplEWsepDnNoXRZgvS4l6jJiO8K14FQ01A--8QGhWuO_QVoz9w>
    <xmx:PMtNZgBGM0rsGvbH-o7amkn9MTM4PpKapAI0q73PLai5T7LIhMzD-LtZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 06:38:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8feab4c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 10:38:45 +0000 (UTC)
Date: Wed, 22 May 2024 12:38:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Heghedus Razvan <heghedus.razvan@protonmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] setup: fix bug with "includeIf.onbranch" when initializing
 dir
Message-ID: <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZRMbY0BHTy29Iyql"
Content-Disposition: inline
In-Reply-To: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>


--ZRMbY0BHTy29Iyql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It was reported that git-init(1) can fail when initializing an existing
directory in case the config contains an "includeIf.onbranch:"
condition:

```shell
$ mkdir repo
$ git -c includeIf.onbranch:main.path=3Dnonexistent init repo
BUG: refs.c:2056: reference backend is unknown
```

The same error can also be triggered when re-initializing an already
existing repository.

The bug has been introduced in 173761e21b (setup: start tracking ref
storage format, 2023-12-29), which wired up the ref storage format. The
root cause is in `init_db()`, which tries to read the config before we
have initialized `the_repository` and most importantly its ref storage
format. We eventually end up calling `include_by_branch()` and execute
`refs_resolve_ref_unsafe()`, but because we have not initialized the ref
storage format yet this will trigger the above bug.

Interestingly, `include_by_branch()` has a mechanism that will only
cause us to resolve the ref when `the_repository->gitdir` is set. This
is also the reason why this only happens when we initialize an already
existing directory or repository: `gitdir` is set in those cases, but
not when creating a new directory.

Now there are two ways to address the issue:

  - We can adapt `include_by_branch()` to also make the code conditional
    on whether `the_repository->ref_storage_format` is set.

  - We can shift around code such that we initialize the repository
    format before we read the config.

While the first approach would be safe, it may also cause us to paper
over issues where a ref store should have been set up. In our case for
example, it may be reasonable to expect that re-initializing the repo
will cause the "onbranch:" condition to trigger, but we would not do
that if the ref storage format was not set up yet. This also used to
work before the above commit that introduced this bug.

Rearrange the code such that we set up the repository format before
reading the config. This fixes the bug and ensures that "onbranch:"
conditions can trigger.

Reported-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c         |  21 +++++-----
 t/t0001-init.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 104 insertions(+), 17 deletions(-)

diff --git a/setup.c b/setup.c
index 9247cded6a..8c7bc7bdb1 100644
--- a/setup.c
+++ b/setup.c
@@ -2286,12 +2286,6 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
 	}
 	startup_info->have_repository =3D 1;
=20
-	/* Ensure `core.hidedotfiles` is processed */
-	git_config(platform_core_config, NULL);
-
-	safe_create_dir(git_dir, 0);
-
-
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
@@ -2302,9 +2296,6 @@ int init_db(const char *git_dir, const char *real_git=
_dir,
 	validate_hash_algorithm(&repo_fmt, hash);
 	validate_ref_storage_format(&repo_fmt, ref_storage_format);
=20
-	reinit =3D create_default_files(template_dir, original_git_dir,
-				      &repo_fmt, init_shared_repository);
-
 	/*
 	 * Now that we have set up both the hash algorithm and the ref storage
 	 * format we can update the repository's settings accordingly.
@@ -2312,6 +2303,18 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
 	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
=20
+	/*
+	 * Ensure `core.hidedotfiles` is processed. This must happen after we
+	 * have set up the repository format such that we can evaluate
+	 * includeIf conditions correctly in the case of re-initialization.
+	 */
+	git_config(platform_core_config, NULL);
+
+	safe_create_dir(git_dir, 0);
+
+	reinit =3D create_default_files(template_dir, original_git_dir,
+				      &repo_fmt, init_shared_repository);
+
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
 					  initial_branch, flags & INIT_DB_QUIET);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b131d665db..2239bed198 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -584,14 +584,38 @@ test_expect_success 'init with --ref-format=3Dfiles' '
 	test_cmp expect actual
 '
=20
-test_expect_success 're-init with same format' '
-	test_when_finished "rm -rf refformat" &&
-	git init --ref-format=3Dfiles refformat &&
-	git init --ref-format=3Dfiles refformat &&
-	echo files >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
-	test_cmp expect actual
-'
+for from_format in files reftable
+do
+	for to_format in files reftable
+	do
+		if test "$from_format" =3D "$to_format"
+		then
+			continue
+		fi
+
+		test_expect_success "re-init with same format ($from_format)" '
+			test_when_finished "rm -rf refformat" &&
+			git init --ref-format=3D$from_format refformat &&
+			git init --ref-format=3D$from_format refformat &&
+			echo $from_format >expect &&
+			git -C refformat rev-parse --show-ref-format >actual &&
+			test_cmp expect actual
+		'
+
+		test_expect_success "re-init with different format fails ($from_format -=
> $to_format)" '
+			test_when_finished "rm -rf refformat" &&
+			git init --ref-format=3D$from_format refformat &&
+			cat >expect <<-EOF &&
+			fatal: attempt to reinitialize repository with different reference stor=
age format
+			EOF
+			test_must_fail git init --ref-format=3D$to_format refformat 2>err &&
+			test_cmp expect err &&
+			echo $from_format >expect &&
+			git -C refformat rev-parse --show-ref-format >actual &&
+			test_cmp expect actual
+		'
+	done
+done
=20
 test_expect_success 'init with --ref-format=3Dgarbage' '
 	test_when_finished "rm -rf refformat" &&
@@ -678,4 +702,64 @@ test_expect_success 'branch -m with the initial branch=
' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git -c includeIf.onbranch:main.path=3Dnonexistent init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with includeIf.onbranch condition with existing =
directory' '
+	test_when_finished "rm -rf repo" &&
+	mkdir repo &&
+	git -c includeIf.onbranch:nonexistent.path=3D/does/not/exist init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -c includeIf.onbranch:nonexistent.path=3D/does/not/exist init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -c includeIf.onbranch:nonexistent.path=3D/does/not/exist init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init skips non-matching includeIf.onbranch' '
+	test_when_finished "rm -rf repo config" &&
+	cat >config <<-EOF &&
+	[
+	garbage
+	EOF
+	git init repo &&
+	git -c includeIf.onbranch:nonexistent.path=3D"$(test-tool path-utils abso=
lute_path config)" init repo
+'
+
+test_expect_success 're-init reads matching includeIf.onbranch' '
+	test_when_finished "rm -rf repo config" &&
+	cat >config <<-EOF &&
+	[
+	garbage
+	EOF
+	path=3D"$(test-tool path-utils absolute_path config)" &&
+	git init --initial-branch=3Dbranch repo &&
+	cat >expect <<-EOF &&
+	fatal: bad config line 1 in file $path
+	EOF
+	test_must_fail git -c includeIf.onbranch:branch.path=3D"$path" init repo =
2>err &&
+	test_cmp expect err
+'
+
 test_done
--=20
2.45.1.216.g4365c6fcf9.dirty


--ZRMbY0BHTy29Iyql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNyzUACgkQVbJhu7ck
PpTxlw//eEGCCBjaO8dt2Jhp6KY4tZDUmbPipKkJ1lIRHBj3fjWqteg8kZdVV64H
/Vd/nxAFiLTib83zOnQDDPXibdk/cUzMqoCHA0awK421er+S3gWurvnEmx3MG4Lk
BBN4UToUwM8VOdLgMK/kV/9y7Jn29lv9iB3HYnZlkb57ss0Vqhealm3Yfh40ZLae
AIe5DJA1Q81oIxKh/OYrC66C12sgpwdV90J3tF8TR3H5b7LOGk8MAaJwGBAog4+B
nCK6oSct1eZZvknyWx9UvBfWBjkz6X/8xHXTTs8ZtQsqBQntZnWT9bBSZgyyEiST
JGaCoacvWk8XmW5PcjQni4zwu1fGHYOQ5l/LTLAESZKxd9MYaSr5XAK56jnrduRs
cWUlaRteT3B3+KPYTlIJ0VBrufSP7i0KZGiBIi+BNn0DNFNY5DgneCOgvggV5/dV
QH0azvZsyRjpklSa7w+MW28I2guZ/DPX9NAJKkZJGEF4i1CBDV8NXvz4PHqQgBLQ
Ze3ZHqFN7tQY/R7PDQ8NGeDYcnO0TSFD00nhHjrbQ2gOwvrCFm/7WirFZSNZWmKb
1aUdfuFGQgYA8B//5HtjYenaSNbfiy8djFkmuxMrK1zL9Hcv90QLSwP85XS2O3IS
XMl7M8uMsHs4jsHCZqhMTMMgFcG1W1VXP9SFCC2OX79XAJQoKtY=
=Rgc9
-----END PGP SIGNATURE-----

--ZRMbY0BHTy29Iyql--
