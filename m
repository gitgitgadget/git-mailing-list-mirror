Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23312B7C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985536; cv=none; b=CIDKYkTRBCSKsyqZT6CmWGFd+F7ovh6WanaPvn7176Z8uFDBbhucmpUddpSfPt8ndzdzcNQmP1JP8TDO83h3uF00Q728sYRghHaXc1vNysXFzpzfoy/3sxmnDEPb6bv0NHJlzr/KGRsOsgaOEsDm2XMCwxaRp4lROS72ZrkLG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985536; c=relaxed/simple;
	bh=YBeb+ElxRWsmbp9ih97Nj9+Lh+v51GbUulk2lljw95Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdq0BPp72Dn9R6Q1R0VRzTzNSgCKpnkSH1KPThvl2B5nQpfPgc8VpCaghhemMSLp3wq4jhaiKkzSi/tK5P9DqEZ3qNDHsFcJR7QfE/muYcc37UH9Cy+wMG8uYVZ6heIWv3tErr8vW7hyhXl5gT7iBl1sbb3wD/29PHDRONK+HYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evOzBpwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5xPElDe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evOzBpwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5xPElDe"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A21911140094;
	Thu, 15 Feb 2024 03:25:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 03:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985533; x=1708071933; bh=SSX0G63c+r
	T0SwuTxo+IaQjcbupLo7qcfPwJh6UwOuQ=; b=evOzBpwqRQqO2UGArQ/IkrvSi+
	QZY0SraD0MN+2EmNDFaQbe4O4USCvL8uBwcqcCwyAEzhlFdD1jqBppM/TmLBF/Pd
	qkwvzzYSI31BUI4N605sUvBazGBy6VzpnSBVtUUnwaR5f/20nMZ3ngU2eTVS/PLC
	36Zh4XcD23+ad804sM9elDCbBIU5U440Jwk/poUDaGAREXoZOBUwytUmLk0eCFGO
	jUx8KqcGHBrFPWsqkxOhOHRUYM0iW1QbiUB1CAGx3IOf/upvV9RStoATBCLOF5mh
	pqtEaWcH3ha0zIzfjJnVc7eKpalgy2F04NF65OJBNNn8mDOf9WMdba0+PCQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985533; x=1708071933; bh=SSX0G63c+rT0SwuTxo+IaQjcbupL
	o7qcfPwJh6UwOuQ=; b=H5xPElDelBhK+HjWysdJz+MP2ER8eMFCqG+nyyB6TkRE
	fPxbbj9mVKXlSBPN3/j7389VNedmsd1yadFiY/EK9DRpfTFVK9ZvenzGMCgn52wH
	xmNPaiQlWfceDuJwkq54xvyMAId1k2ist3InTJXTA8opsFu4GEGjCeFichq3sWI1
	WST39gNapdvAglfE9wT87cIUeqDGSzd/Nd7OV5I05a3WJB7K5AI0/6OjoWfVF7cI
	lTt3Npla6oDMk08E6wHVQJLHrWSCgpDVfFXsHICEAbizhqZKUWtf+e3eCk+xdqoU
	qqDok1L0Be05bFPLconLk2G2Zy27PNjYF8ouUk2q4Q==
X-ME-Sender: <xms:fcrNZbzT5tdhmneL-IKTRVYowBwNZmw7AtyST0NPhzkxlXA22078eg>
    <xme:fcrNZTQrydDigxfHYB8T4nnCLJnGCCdNrXbk0q3iv7-TjMu5g-6s5dVVq2LscAFn1
    fiafRPyILq9Pd6HtA>
X-ME-Received: <xmr:fcrNZVV1yIXhWN_rWr0ueVtXxvWPsGrO5bO6fD_lWkXE9TSye1U1q02wABCwq-3N05j5xrpApueyCUImFSknHMwADn4Wg6TgENd1zPCnTtBR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:fcrNZVi_AzWGGVUj8oD3LtC_uElBn6ysv1io_DkcF6v4kJk_ECHLvA>
    <xmx:fcrNZdBM5eH_xd1QwMJa7scgygDRd30ZLmyuKfLIn7r3oIa8ZVkwdg>
    <xmx:fcrNZeIwS-IIaFMxzv0D5v02eAfheBWpBveYhHlBd_kUn1ukyd_xkw>
    <xmx:fcrNZcMQYDOf0RpF635rClDe4r-EifMm6Xp6oRHluRuO_m27LAzCUQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eea0cd96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:21:40 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] t: move tests exercising the "files" backend
Message-ID: <6891cdfdb3a15ab074226a4adca74148ba152fa6.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5CP7hAcHIGtrs4e9"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--5CP7hAcHIGtrs4e9
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
index 78a09abc35..bf37763bd6 100755
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
2.44.0-rc0


--5CP7hAcHIGtrs4e9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNynkACgkQVbJhu7ck
PpSc/Q//fPiP/LwF88JYmPFE+PRoORXGZ1j8x5AMaMkEqrk5pczCH7FrzemArZ33
8hUOG2VpKfDI5n+2/3aqcJ56xkiWhyzBBYmWi6UGSusCwjHTUSrNLEOWiu4R/dPk
nGYZ0412HTD87tNpfPLaOx3mw0vppzHavnNS1M1T95z0ElnqgZdpyR9wxbEcpufH
xWM4Vkf0r3Jg4KH2Y3Sk9cJB8aUTVw2T+pmwCJqcAlx8jav7xU7xALEaULrZNCoY
qWljsjfHZSzUVj0dBoUcrBcOIZzAxsASSvWgzxgMC8hScHzCUmuIA1dTBVJL9pIe
vX6RE/AJNOHhkOeqdtCg2IDAGjZIfOlhvkOoMGzFZHMfEOiMJf2Lvb/r7BneK1+Z
jK31fKmn9BFcZmsZdltbYa9NSxzMZAbrc8IeKJdbdVol+fFUcutmr+QvYFsS6BWk
SG9MCQ0yoP46lx0h94b506VHUTnUbj9o79Kh1raEel9RlKQVdR16ylyiBuTd4128
8KU+x5JM3Q6JLECnK5D2VFRQdFeNcecLeMt1pptkU0bEx1agRMl0xrY5MhFEsQFA
72Wz09uBHzhNwsHxnbJZ/KnUHV99BjyR7F+nLS0enGGhEVyAJQnukVcAGy/V8n1W
XxM7hskiewNtpDEAM7VoQhaFxvSILEp6/TtCZKb+UlalcH3o5RM=
=YJHf
-----END PGP SIGNATURE-----

--5CP7hAcHIGtrs4e9--
