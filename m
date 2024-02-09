Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E62E3E0
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463396; cv=none; b=AKhCXMD79qP88OX92UMN9GNEriTVB/9Idh8wxbYlvNykQ6obwtl+dsST5GmSnG2gZg8dhSree8QPDG2Fdp56qQTuNtKVvkTRrT5dQ6SqJrAZGjVN4ovJu2QnF3U1Bp/qcjEImkdZXe2kFimBwlKsUvbUisg6SjKL8iHcrNFM87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463396; c=relaxed/simple;
	bh=S0PPG7m1gP8SH7F84cV37/3nra8W/k0XR0Mj18sDFIM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg08lW3FbGmhbEFqGjwBpxl+YTK4Rj/n5i9sMwlpx3kAPsSpyN0xRw0W09F3wjx3ALwnqmWdG1D66Im4EkP+r4p32CoH/rdz43K7jSN7au4WGpdEkisdWgPG4XDqJt3OJ7dW/JrdrEnun8PjWEfuZf0CGpPinsDN5JjjJrryIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mxe5W/EW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Svzy0iQW; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mxe5W/EW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Svzy0iQW"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 28D981800070
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 02:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463392; x=1707549792; bh=Jxv7UeQdc3
	G9vdz88VrOxb+xkvibwmCGqpx8vX87U90=; b=mxe5W/EWq7XqOxyvipubxCnWuR
	B3QVKUqAOKIZavZUIjcXFZ82crkxnuhu3LTgSiaKs+58oVErFjc/p/NDjioMjhaJ
	fTpwkdQY3EFD3PixDNe1DtGQxLwUObrs3Nd/rARQ7/l6mMO3H+dZTJa1EcAyaxlq
	QOEwS6hQRZpj6gajqXdkIpIt5dqNUkfOIa7opOYNdHFJJbUonRkpBH+hsbfwhP2S
	UeitjjUE22BJGvvjbd6bklqz+QTGmKigBCtg8ex6N3YylOwr7SSeO/JalMR/TSxj
	fxXjxBoUhOKmeMGyhwfPjTNSdQw8G5T4WX/97YSsm4Sqa2xkJou0BNWGnEiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463392; x=1707549792; bh=Jxv7UeQdc3G9vdz88VrOxb+xkvib
	wmCGqpx8vX87U90=; b=Svzy0iQWpdA2S4jxjEQhcFZeK6TvdZAAKhOMSaWy4TPN
	Y8AmvyhthsBI+MyZUGwCFsXrOfYODFGt6a0yz+8HC9pCexFEIkt9nBN+95h+2ld+
	9tL6exOHoyeLQVoPkAZKLlk63PPGvDJyJuBiV5/c/Yhi7wrq1P7Jov7zYHsH0lQr
	+ur1RN+Je3VDlE24XCPTCCfeKGWOUQ1qVQ9D+qb87IdDYFH/HGXyHuB4QRa32gBB
	bY+J+DDfdyt94uEYk9y3leomw1Y0TmlGHjNPSlN4bhpVCQG2QvxIUoAyeBjyZUGJ
	b2YI1b6hdRIAjmIBqj8BFvpHkEO5uuWnp/Bd6SO2xA==
X-ME-Sender: <xms:4NLFZSU-ATtP4b0kfvPyVJXhUdowFCW3Y8Trh_3U-qx_awauQAtsPA>
    <xme:4NLFZenPbuXaNGxV1T37Q4ktJX3VAx85ZWwnvCZglawFNknSQ5JaYW4a9CVpFqdaA
    gmeh8fMBmMFe2KHFA>
X-ME-Received: <xmr:4NLFZWY0Ju8kLW33BS36ZAc95ZWNDSoQjtAVwU0Os7lsKepz_F2PokYz1o0SP03xr_GIyKrNiZp2rAopA11OSUpzE6SfqHtjyw_g5QndNk5iWis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4NLFZZVfQy36yPF2vYenXaeHgCx_FIhIw8IZeyKjQP2T0uysm_aFuA>
    <xmx:4NLFZclUL10Xp-T60_P00asok5lrHvEzP4g-8BLcUPm8bYVCf_78YQ>
    <xmx:4NLFZedLhitq-FujvUI4LkY0DHomrx8mW3yF7omh83wQLPPwfhtV6w>
    <xmx:4NLFZYvo7CRdC_8RETIgBN30jZvf96l2imeiV4CXXsVJcTgQBNvRq3_g-Ng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c0c0bad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:36 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] t: move tests exercising the "files" backend
Message-ID: <2eca90234f60b5f48e444e8be212bd70b9ebf924.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eVrR/h18cgYfgDro"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--eVrR/h18cgYfgDro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We still have a bunch of tests scattered across our test suites that
exercise on-disk files of the "files" backend directly:

  - t1301 exercises permissions of reflog files when the config
    "core.sharedRepository" is set.

  - t1400 exercises whether empty directories in the ref store are
    handled correctly.

  - t3200 exercises what happens when there are symlinks in the ref
    store.

  - t3400 also exercises what happens when ".git/logs" is a symlink.

All of these are inherently low-level tests specific to the "files"
backend. Move them into "t0600-reffiles-backend.sh" to reflect this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0600-reffiles-backend.sh | 91 +++++++++++++++++++++++++++++++++++++
 t/t1301-shared-repo.sh      | 16 -------
 t/t1400-update-ref.sh       | 36 ---------------
 t/t3200-branch.sh           | 29 ------------
 t/t3400-rebase.sh           | 10 ----
 5 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index e6a5f1868f..485481d6b4 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -381,4 +381,95 @@ test_expect_success 'log diagnoses bogus HEAD symref' '
 	test_grep broken stderr
 '
=20
+test_expect_success 'empty directory removal' '
+	git branch d1/d2/r1 HEAD &&
+	git branch d1/r2 HEAD &&
+	test_path_is_file .git/refs/heads/d1/d2/r1 &&
+	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
+	git branch -d d1/d2/r1 &&
+	test_must_fail git show-ref --verify -q refs/heads/d1/d2 &&
+	test_must_fail git show-ref --verify -q logs/refs/heads/d1/d2 &&
+	test_path_is_file .git/refs/heads/d1/r2 &&
+	test_path_is_file .git/logs/refs/heads/d1/r2
+'
+
+test_expect_success 'symref empty directory removal' '
+	git branch e1/e2/r1 HEAD &&
+	git branch e1/r2 HEAD &&
+	git checkout e1/e2/r1 &&
+	test_when_finished "git checkout main" &&
+	test_path_is_file .git/refs/heads/e1/e2/r1 &&
+	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
+	git update-ref -d HEAD &&
+	test_must_fail git show-ref --verify -q refs/heads/e1/e2 &&
+	test_must_fail git show-ref --verify -q logs/refs/heads/e1/e2 &&
+	test_path_is_file .git/refs/heads/e1/r2 &&
+	test_path_is_file .git/logs/refs/heads/e1/r2 &&
+	test_path_is_file .git/logs/HEAD
+'
+
+test_expect_success 'directory not created deleting packed ref' '
+	git branch d1/d2/r1 HEAD &&
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	git update-ref -d refs/heads/d1/d2/r1 &&
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	test_path_is_missing .git/refs/heads/d1
+'
+
+test_expect_success SYMLINKS 'git branch -m u v should fail when the reflo=
g for u is a symlink' '
+	git branch --create-reflog u &&
+	mv .git/logs/refs/heads/u real-u &&
+	ln -s real-u .git/logs/refs/heads/u &&
+	test_must_fail git branch -m u v
+'
+
+test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
+	test_when_finished "rm -rf subdir" &&
+	git init --bare subdir &&
+
+	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
+	ln -s ../.git/refs subdir/refs &&
+	ln -s ../.git/objects subdir/objects &&
+	ln -s ../.git/packed-refs subdir/packed-refs &&
+
+	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
+	git rev-parse --absolute-git-dir >our.dir &&
+	! test_cmp subdir.dir our.dir &&
+
+	git -C subdir log &&
+	git -C subdir branch rename-src &&
+	git rev-parse rename-src >expect &&
+	git -C subdir branch -m rename-src rename-dest &&
+	git rev-parse rename-dest >actual &&
+	test_cmp expect actual &&
+	git branch -D rename-dest
+'
+
+test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a sym=
link' '
+	git checkout main &&
+	mv .git/logs actual_logs &&
+	cmd //c "mklink /D .git\logs ..\actual_logs" &&
+	git rebase -f HEAD^ &&
+	test -L .git/logs &&
+	rm .git/logs &&
+	mv actual_logs .git/logs
+'
+
+test_expect_success POSIXPERM 'git reflog expire honors core.sharedReposit=
ory' '
+	umask 077 &&
+	git config core.sharedRepository group &&
+	git reflog expire --all &&
+	actual=3D"$(ls -l .git/logs/refs/heads/main)" &&
+	case "$actual" in
+	-rw-rw-*)
+		: happy
+		;;
+	*)
+		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
+		false
+		;;
+	esac
+'
+
 test_done
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 8e2c01e760..b1eb5c01b8 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -137,22 +137,6 @@ test_expect_success POSIXPERM 'info/refs respects umas=
k in unshared repo' '
 	test_cmp expect actual
 '
=20
-test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.shar=
edRepository' '
-	umask 077 &&
-	git config core.sharedRepository group &&
-	git reflog expire --all &&
-	actual=3D"$(ls -l .git/logs/refs/heads/main)" &&
-	case "$actual" in
-	-rw-rw-*)
-		: happy
-		;;
-	*)
-		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
-		false
-		;;
-	esac
-'
-
 test_expect_success POSIXPERM 'forced modes' '
 	test_when_finished "rm -rf new" &&
 	mkdir -p templates/hooks &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f18843bf7a..3294b7ce08 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -288,33 +288,6 @@ test_expect_success "set $m (logged by touch)" '
 	test $A =3D $(git show-ref -s --verify $m)
 '
=20
-test_expect_success REFFILES 'empty directory removal' '
-	git branch d1/d2/r1 HEAD &&
-	git branch d1/r2 HEAD &&
-	test_path_is_file .git/refs/heads/d1/d2/r1 &&
-	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
-	git branch -d d1/d2/r1 &&
-	test_must_fail git show-ref --verify -q refs/heads/d1/d2 &&
-	test_must_fail git show-ref --verify -q logs/refs/heads/d1/d2 &&
-	test_path_is_file .git/refs/heads/d1/r2 &&
-	test_path_is_file .git/logs/refs/heads/d1/r2
-'
-
-test_expect_success REFFILES 'symref empty directory removal' '
-	git branch e1/e2/r1 HEAD &&
-	git branch e1/r2 HEAD &&
-	git checkout e1/e2/r1 &&
-	test_when_finished "git checkout main" &&
-	test_path_is_file .git/refs/heads/e1/e2/r1 &&
-	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
-	git update-ref -d HEAD &&
-	test_must_fail git show-ref --verify -q refs/heads/e1/e2 &&
-	test_must_fail git show-ref --verify -q logs/refs/heads/e1/e2 &&
-	test_path_is_file .git/refs/heads/e1/r2 &&
-	test_path_is_file .git/logs/refs/heads/e1/r2 &&
-	test_path_is_file .git/logs/HEAD
-'
-
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial =
Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
@@ -1668,13 +1641,4 @@ test_expect_success PIPE 'transaction flushes status=
 updates' '
 	test_cmp expected actual
 '
=20
-test_expect_success REFFILES 'directory not created deleting packed ref' '
-	git branch d1/d2/r1 HEAD &&
-	git pack-refs --all &&
-	test_path_is_missing .git/refs/heads/d1/d2 &&
-	git update-ref -d refs/heads/d1/d2/r1 &&
-	test_path_is_missing .git/refs/heads/d1/d2 &&
-	test_path_is_missing .git/refs/heads/d1
-'
-
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index de7d3014e4..e36f4d15f2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -836,35 +836,6 @@ test_expect_success 'renaming a symref is not allowed'=
 '
 	test_ref_missing refs/heads/new-topic
 '
=20
-test_expect_success SYMLINKS,REFFILES 'git branch -m u v should fail when =
the reflog for u is a symlink' '
-	git branch --create-reflog u &&
-	mv .git/logs/refs/heads/u real-u &&
-	ln -s real-u .git/logs/refs/heads/u &&
-	test_must_fail git branch -m u v
-'
-
-test_expect_success SYMLINKS,REFFILES 'git branch -m with symlinked .git/r=
efs' '
-	test_when_finished "rm -rf subdir" &&
-	git init --bare subdir &&
-
-	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
-	ln -s ../.git/refs subdir/refs &&
-	ln -s ../.git/objects subdir/objects &&
-	ln -s ../.git/packed-refs subdir/packed-refs &&
-
-	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
-	git rev-parse --absolute-git-dir >our.dir &&
-	! test_cmp subdir.dir our.dir &&
-
-	git -C subdir log &&
-	git -C subdir branch rename-src &&
-	git rev-parse rename-src >expect &&
-	git -C subdir branch -m rename-src rename-dest &&
-	git rev-parse rename-dest >actual &&
-	test_cmp expect actual &&
-	git branch -D rename-dest
-'
-
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 57f1392926..e1c8c5f701 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -424,16 +424,6 @@ test_expect_success 'refuse to switch to branch checke=
d out elsewhere' '
 	test_grep "already used by worktree at" err
 '
=20
-test_expect_success REFFILES,MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs=
 is a symlink' '
-	git checkout main &&
-	mv .git/logs actual_logs &&
-	cmd //c "mklink /D .git\logs ..\actual_logs" &&
-	git rebase -f HEAD^ &&
-	test -L .git/logs &&
-	rm .git/logs &&
-	mv actual_logs .git/logs
-'
-
 test_expect_success 'rebase when inside worktree subdirectory' '
 	git init main-wt &&
 	(
--=20
2.43.GIT


--eVrR/h18cgYfgDro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0t0ACgkQVbJhu7ck
PpTL9xAAlXccbfKKoNU3agDqjfGaldTYHkOeKSazh5RsvAxQZ6Benzk1X6WurNSB
Og6PdEJiBbEiQNNljfOGRjlSn/YxHYXBm7d/eQxd8zTaACnoMj51uZYt8VOf0GaV
amJar97ft/LuMqJ/LPeJrjS3oiX06Jb/7Hx7fGMrn96kGg3xbtH89td5jLHzQ/2/
LOSTl+YawWkaeeLBFtWk54kYXOzKbHYeKHadTOyGxm+CsmVJeYArjB1+7tkwpl5H
Hu5oq9Az1lO/kTuRsOhutx9LTgh3RzPD32iTQ3nicsT8b3AB+aejIFrVJg2RajWQ
EN9uxkje/Tvol1lJE8T6H7IYNSWmgkBYDsLO0mJZWJQeK/a9S64+IzPxunFws9gB
qSUI+Cw5UPHqnd343KyVITcehq/FEPiuZkxZo0BJgoudGQCiL5o7USsFe/1G6Sqo
NW/GfS2/DyM5XGKpJ44c0PGfkp+yhNFYtkALem+M717lNtchzXhG/scloabHoV0K
l2WvKegsoGOWiIGbGQvu5sih+5nV+fEsvARpsG9vzFu/wy1Wi2W/Lxhy0tdlqEf6
EHgRutUE+qO9OiaISrZrUFnEn597mKe812uBV6MftWiCDS6u8l6Knz+Pi3CGvPOa
A8cVxFTWEwmYq6A/lJoCSEdf15UdjojEDklrfB1kST42C1QQATA=
=31My
-----END PGP SIGNATURE-----

--eVrR/h18cgYfgDro--
