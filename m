Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B5C139
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116473; cv=none; b=MRTYYaYaK7ASM1144h8WgQkz7anqTUfzThYSFVJqEwWvmeY11DDL0uxOl5O7uDaLIjQzbGmXt8X3P0k68kyPOfDs2Hn9aEMYZUyzx3YqYg4D+3NSswmdUHJAl4PZPsz8a12AlIefky2hQIPE70Heozt9GwvLKHwOLDdUa4x3T84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116473; c=relaxed/simple;
	bh=7HxPuUk1KxoFYCLqEBSX82peiP5QmLsJc+D/o1JIlIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0kDFKvsil8tZ81aSyX5DzrGA0yDR5xGITp6NJJsiZ7DLi+31n24teKltmGhUPV3IJC2h+zSQP5FNTIPowMFhGzgTxiHCYZ9ESa6X40ywrGNAwfrpnx51ASXmGujpj7e5326M+DAeMGfTgUnosKfZvffSZUeTB+/iJsKi8uMn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZXHugka/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qY0Ik7aG; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZXHugka/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qY0Ik7aG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7675332000D9;
	Mon,  5 Feb 2024 02:01:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Feb 2024 02:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707116468; x=1707202868; bh=hyO76tkYxw
	z4rwW7d+45DJkwMDbWWfwUomBdGHLHePE=; b=ZXHugka//wICpXpmlU2N27Icsq
	QQklgFEJmRji6fdC13DLh7YEOz6JPvShwC/5lW/0Fq7A8QECL2AVTFeFh9X3bQmY
	xwR4zVOSL77yt3ljihbYsLRxNNbn6Fl+5q/1aW0AS1gztCt4940iRd96JwzXoSYW
	ncGiIyujXBCXVMzQeB0OykUiChXZWRKVRMBskQzqv4VM+PyFSpBAsMiKI2nSWoKh
	nNT5rGnJGtSkkZ+JWzb2aHLJURDraMkroctfVJctc7VhNGcAn/q5k5r1oTHaW8Ii
	MeE4H4W5dqzj3cSroPvWtWd9vokffuJz9rb5TH6+Z7qMSIIt6hrZxkepuhNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707116468; x=1707202868; bh=hyO76tkYxwz4rwW7d+45DJkwMDbW
	WfwUomBdGHLHePE=; b=qY0Ik7aGRbRVicWVi6bWqlGj5MShxZ9WIjKgvUR4xK/g
	yq+DGyNnlTIisghFYrt/uYC+ooCIFIReFmVxPe8BepXLs4z+JTH0wD9a5K7XEuA6
	i+6iqWw7gnV7Z1a/uZjOxFrhTexRMV260Pzau/+hvFhqOETQrq0rbmJfZfXM4HVw
	98phdE1gLFq2zubv0KMzqYI5NPkoYgStvlQBcW0rWEvnmpHlqwrF48laL1bduXtF
	2ftADmbOxJT5B9/jdxV4CwLNaF4ncyQ9fXE7memR/Uuv71/ZGn8vVX/i7tOpCZoU
	Ciwv86rTDxYTZxzeFqI8zl2AN3mvyUfsdvQ9tvHF7Q==
X-ME-Sender: <xms:tIfAZT4r3O4FTJ2rp_b1zStvL7m-zuwfYG_u5AeYekVmzSCi4Urhfg>
    <xme:tIfAZY45tmvE7KMcrdSKlj2k0b5jgZmNiUxfk93e8ffCMGdLB4KQK94wiF0FAW7J5
    ofwQqQcN5_zSBC58w>
X-ME-Received: <xmr:tIfAZadtlL5Ibl6pWUJXrAyYtlk2IVfd_dWu5KUNv0VvEGzPZXqKjdK8zQAuncwpj961nGQ20WbDCpmxIpxb_G2v0ol3Ak2u0WrDhqEPLRKIVaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:tIfAZUImjqy8LpprUu90Qo-JzFM63U8M67IQ35l-pFXpjZT-Ml0wQg>
    <xmx:tIfAZXJaAeyvONGmkg5vTMV-UdpWoulZ55GcxpFZnY8HtJhX07IE0g>
    <xmx:tIfAZdyK1HG1pUhZXG0jsRRl3A92z15ZiSrNNvraPL-DzDHERNn4gg>
    <xmx:tIfAZdj39ijt4Lz0jVIBrO7gg-9r-k4RBlbyQHJeQWYpWYhH7-v_oA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 02:01:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f74d5ae7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Feb 2024 06:57:38 +0000 (UTC)
Date: Mon, 5 Feb 2024 08:01:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: moti sd <motisd8@gmail.com>
Subject: [PATCH] builtin/stash: report failure to write to index
Message-ID: <2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kpTjNt6McI6kAijf"
Content-Disposition: inline
In-Reply-To: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>


--kpTjNt6McI6kAijf
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

Note that the chosen error message ("Cannot write to the index") does
not match our guidelines as it starts with a capitalized letter. This is
intentional though and matches the style of all the other messages used
in git-stash(1).

Reported-by: moti sd <motisd8@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/stash.c  |  6 +++---
 t/t3903-stash.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b2813c614c..9df072b459 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -537,7 +537,7 @@ static int do_apply_stash(const char *prefix, struct st=
ash_info *info,
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL))
-		return -1;
+		return error(_("Cannot write to the index"));
=20
 	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
 				NULL))
@@ -1364,7 +1364,7 @@ static int do_create_stash(const struct pathspec *ps,=
 struct strbuf *stash_msg_b
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL) < 0) {
-		ret =3D -1;
+		ret =3D error(_("Cannot write to the index"));
 		goto done;
 	}
=20
@@ -1555,7 +1555,7 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
=20
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL)) {
-		ret =3D -1;
+		ret =3D error(_("Cannot write to the index"));
 		goto done;
 	}
=20
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3319240515..770881e537 100755
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
+		error: Cannot write to the index
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
+		error: Cannot write to the index
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
+		error: Cannot write to the index
+		EOF
+		test_must_fail git stash apply 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_done
--=20
2.43.GIT


--kpTjNt6McI6kAijf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXAh68ACgkQVbJhu7ck
PpQ17A/9FA9RxG+wvU4C0EynIprYbHquXTgi14bdiqfw1jqzkbnWEm37Kt5xMhb+
BErnJrOzH9o3RGD/q+B5N6oxM6B9imM5aWP2OPvKNE6EipZmvGoCRfNqUOt6h60I
4rbgqesKzL8flhKjh5oVtsLwQt5vFa4LvUWvDJtvGN5Ypmp/R1yKnOTKR1Ndhbk+
78vEImzL5BCn34WW9bgcVshUpi/8j/76XWWFBtOV7hsdUDl0b32FN7JIAYPmbEMT
Q0/4CE3kXTdMrMFVl3e3ydI0919o1t/zo6+vyRzBKZK6JHarlZ3thFHPSlckhQ9u
/lDDr2I89BL82jNh3vPFEpXTr9Od1T0gtR+L5FmyNDPYJqnuwpFePoqdxPOZjfHG
48YIT1WmPh0naizmSiQ+5qzx8bWdF2zDT26tZnWOQc7PTahxGonbjyQV8HjjWkDD
Uutw8Kqf/cWQa2q5F/He/DO0YL0sSl7MYoRYVAq4osE4c9+cXQv4+1KavyOGBgev
Gv3BDNsIpHiw0pTlFHvZICXmkDHoZFdnZuktUXQFY0+YYxuLUQ3T2Qj8YRlsv7ej
KBOsFXDKnIQe8FeeW7KdRAu5Cds4s5Na8mRp+QMTEnTCWa/6Kkqv62iY8S39kJnf
dG31N5L2KbWBlIL4f+usrBPMmqwKSU1XRKyGsm5usjgDD9M1PQk=
=Ztaa
-----END PGP SIGNATURE-----

--kpTjNt6McI6kAijf--
