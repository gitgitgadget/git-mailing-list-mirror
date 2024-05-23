Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA4149DF6
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467215; cv=none; b=utvgECz5BewBoXYth5qnb3pU1x/PAqTUOwfyKs8vRJgyvMKPtvl9z/iTpi7TCY6/1gX0LNFW0SelA9/c5kpwhwzB3hvd1CmiLuaqGZn2crrDUypKCpIhGKLG13sg7gutcwbGeEw0zL8CmtKyyn2Fi5dDUnfcidxW/vavveFNdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467215; c=relaxed/simple;
	bh=G0qPTDCQhh4IIf3qLY8u2bOmG5BYA3CyW/KxsF2cKYc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1HQvhfed8uKOXPx1vYkUdRv5FOeSC1RkXpFtJWHlzlMzhA1LNxtM2zT6xXFZrwsuFxpAtvh97IJ0kJQ9sbmg1bDzM+asZ46EPPy1GdidgIGXx1mxG2/qb6F6pXbILqbMLGfhH8xxYx0/g1EI5Bal5CkP+DWMehlRDT3jpk81PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AFqajYpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QIUmNEzm; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AFqajYpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QIUmNEzm"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 2359E1C00144
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 May 2024 08:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467212; x=1716553612; bh=BSZ5DlleXx
	scPevg+O/Y/CwJlZOTRg+A9hjZo3+LTcM=; b=AFqajYpriOzqwwJXds6i1RHSjn
	BrDrfFA5LG+Td8qUOVUdnqeONC5KkGHwCXoA8iIOtpDctj2e58RQGhEOtADuBJNR
	F6HCStJFh4246C5xZnbeAUXgsu9WO11Yxkm8zwYf459WUGbq3v3GHiZZSOEQRqzc
	fDg9ZobpiqLtBv2JVcec1oH3ycnOtBaUAiG4yxpkRknQZ2kriRAzpEEnQZmvV857
	iiN+xtgnCFdw6WHBIsZoH+vG8YvC+odM/NU3ZjnHH6hsULcyaOXvho036Yc+nXgv
	TlJGjED0x45LIjMgulNaLvsSJvmfvc7IRoygibQd6bnzbJb4CBK3W61Jvvow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467212; x=1716553612; bh=BSZ5DlleXxscPevg+O/Y/CwJlZOT
	Rg+A9hjZo3+LTcM=; b=QIUmNEzmUh8xCRSkqjjiBemtsAp688qXBNC8We+/g2pT
	zcDglEdLwAhV1ZJLo2qBTNKe5vk6GREJMKE1lkZ9NozRqoR/vHl0Hygay0/YhobC
	4IH29Di80cHW/Fwses5dIZxVFYiCqtufakh7x7DwkA3GyrS8sAaTA8SCyqcEcwiP
	GJ7ousq0NsoPoGAYQyTpE4krMZhQTudzEbrNAT/ckKIS8blYees2C9wVAOQ9pH5q
	Nj0RyxLZ6qa5fxkikRpInXE72pWjryglZWD0XGZjt3Ud5yGScpfSxlQywW9sXOwI
	t6C2kFgS5bKNTCdGXRqESPvvLd27N6KR7q2OlDxNjw==
X-ME-Sender: <xms:DDZPZpwcD7BqWuH6jJP3cVu58s70ML92YJ3jaCHyxwNU1As2yYmMnA>
    <xme:DDZPZpRy6Xn5f1Wu8rkmUG014U-RaQ8JuRnIAFDWXhzXdVc_OEu1n-kSkNmwYtpDb
    AurTk1FlCB2YEY9zA>
X-ME-Received: <xmr:DDZPZjUZJ5UkObkH5qj6eqJXpvzOYA0jtLDqIfF27MgRx7YpLvZ9HrIbymee8IeGRtnci52Zb16EpFoEGPuLuYk6jjiutws5qh1Rgf_wKY_7yzcDVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:DDZPZrjFChqRtQ4cyrLPU5mVm2D-akX9b4_PkqbLsTfHEQF41UGvBw>
    <xmx:DDZPZrBDHdawBZc_c2saHI4taYV93kA0mWJ8onOA4eWP0X213_am0g>
    <xmx:DDZPZkKObPy_9Lj26L0FGqHDAlis3tx-HpvWvuwEnGSObUjZx5MYbA>
    <xmx:DDZPZqBvfdW7OmfvrVdeHuuJA--V1DZ9W8kFKWlbF3dVY7GNvsMIXg>
    <xmx:DDZPZg7QHwPxF5DNBvTwg2_3INftxKqizZA58NjipkloZPtKbROapaMe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 14d85753 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:45 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/20] builtin/mv: fix leaks for submodule gitfile paths
Message-ID: <bba735388d8b0a58e7a935174bd0ba054591b506.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iqm+yyrgiPmF4XQy"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--Iqm+yyrgiPmF4XQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding commit, we have effectively given tracking
memory ownership of submodule gitfile paths. Refactor the code to start
tracking allocated strings in a separate `struct strvec` such that we
can easily plug those leaks. Mark now-passing tests as leak free.

Note that ideally, we wouldn't require two separate data structures to
track those paths. But we do need to store `NULL` pointers for the
gitfile paths such that we can indicate that its corresponding entries
in the other arrays do not have such a path at all. And given that
`struct strvec`s cannot store `NULL` pointers we cannot use them to
store this information.

There is another small gotcha that is easy to miss: you may be wondering
why we don't want to store `SUBMODULE_WITH_GITDIR` in the strvec. This
is because this is a mere sentinel value and not actually a string at
all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c                              | 44 +++++++++++++----------
 t/t4059-diff-submodule-not-initialized.sh |  1 +
 t/t7001-mv.sh                             |  2 ++
 t/t7417-submodule-path-url.sh             |  1 +
 t/t7421-submodule-summary-add.sh          |  1 +
 5 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index e461d29ca1..81ca910de6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -82,21 +82,23 @@ static char *add_slash(const char *path)
=20
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
=20
-static void prepare_move_submodule(const char *src, int first,
-				   const char **submodule_gitfile)
+static const char *submodule_gitfile_path(const char *src, int first)
 {
 	struct strbuf submodule_dotgit =3D STRBUF_INIT;
+	const char *path;
+
 	if (!S_ISGITLINK(the_repository->index->cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok(the_repository->index))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed=
"));
+
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
-	*submodule_gitfile =3D read_gitfile(submodule_dotgit.buf);
-	if (*submodule_gitfile)
-		*submodule_gitfile =3D xstrdup(*submodule_gitfile);
-	else
-		*submodule_gitfile =3D SUBMODULE_WITH_GITDIR;
+
+	path =3D read_gitfile(submodule_dotgit.buf);
 	strbuf_release(&submodule_dotgit);
+	if (path)
+		return path;
+	return SUBMODULE_WITH_GITDIR;
 }
=20
 static int index_range_of_same_dir(const char *src, int length,
@@ -170,7 +172,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	struct strvec sources =3D STRVEC_INIT;
 	struct strvec dest_paths =3D STRVEC_INIT;
 	struct strvec destinations =3D STRVEC_INIT;
-	const char **submodule_gitfile;
+	struct strvec submodule_gitfiles_to_free =3D STRVEC_INIT;
+	const char **submodule_gitfiles;
 	char *dst_w_slash =3D NULL;
 	const char **src_dir =3D NULL;
 	int src_dir_nr =3D 0, src_dir_alloc =3D 0;
@@ -208,7 +211,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 		flags =3D 0;
 	internal_prefix_pathspec(&dest_paths, prefix, argv + argc, 1, flags);
 	dst_w_slash =3D add_slash(dest_paths.v[0]);
-	submodule_gitfile =3D xcalloc(argc, sizeof(char *));
+	submodule_gitfiles =3D xcalloc(argc, sizeof(char *));
=20
 	if (dest_paths.v[0][0] =3D=3D '\0')
 		/* special case: "." was normalized to "" */
@@ -306,8 +309,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 			int first =3D index_name_pos(the_repository->index, src, length), last;
=20
 			if (first >=3D 0) {
-				prepare_move_submodule(src, first,
-						       submodule_gitfile + i);
+				const char *path =3D submodule_gitfile_path(src, first);
+				if (path !=3D SUBMODULE_WITH_GITDIR)
+					path =3D strvec_push(&submodule_gitfiles_to_free, path);
+				submodule_gitfiles[i] =3D path;
 				goto act_on_entry;
 			} else if (index_range_of_same_dir(src, length,
 							   &first, &last) < 1) {
@@ -323,7 +328,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
=20
 			n =3D argc + last - first;
 			REALLOC_ARRAY(modes, n);
-			REALLOC_ARRAY(submodule_gitfile, n);
+			REALLOC_ARRAY(submodule_gitfiles, n);
=20
 			dst_with_slash =3D add_slash(dst);
 			dst_with_slash_len =3D strlen(dst_with_slash);
@@ -338,7 +343,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
=20
 				memset(modes + argc + j, 0, sizeof(enum update_mode));
 				modes[argc + j] |=3D ce_skip_worktree(ce) ? SPARSE : INDEX;
-				submodule_gitfile[argc + j] =3D NULL;
+				submodule_gitfiles[argc + j] =3D NULL;
=20
 				free(prefixed_path);
 			}
@@ -427,8 +432,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			strvec_remove(&sources, i);
 			strvec_remove(&destinations, i);
 			MOVE_ARRAY(modes + i, modes + i + 1, n);
-			MOVE_ARRAY(submodule_gitfile + i,
-				   submodule_gitfile + i + 1, n);
+			MOVE_ARRAY(submodule_gitfiles + i,
+				   submodule_gitfiles + i + 1, n);
 			i--;
 		}
 	}
@@ -462,12 +467,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
 		}
-		if (submodule_gitfile[i]) {
+		if (submodule_gitfiles[i]) {
 			if (!update_path_in_gitmodules(src, dst))
 				gitmodules_modified =3D 1;
-			if (submodule_gitfile[i] !=3D SUBMODULE_WITH_GITDIR)
+			if (submodule_gitfiles[i] !=3D SUBMODULE_WITH_GITDIR)
 				connect_work_tree_and_git_dir(dst,
-							      submodule_gitfile[i],
+							      submodule_gitfiles[i],
 							      1);
 		}
=20
@@ -573,7 +578,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	strvec_clear(&sources);
 	strvec_clear(&dest_paths);
 	strvec_clear(&destinations);
-	free(submodule_gitfile);
+	strvec_clear(&submodule_gitfiles_to_free);
+	free(submodule_gitfiles);
 	free(modes);
 	return ret;
 }
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submo=
dule-not-initialized.sh
index d489230df8..668f526303 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -9,6 +9,7 @@ This test tries to verify that add_submodule_odb works when=
 the submodule was
 initialized previously but the checkout has since been removed.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Tested non-UTF-8 encoding
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 879a6dce60..86258f9f43 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git mv in subdirs'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
=20
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index 5e3051da8b..dbbb3853dc 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -4,6 +4,7 @@ test_description=3D'check handling of .gitmodule path with =
dash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-a=
dd.sh
index ce64d8b137..479c8fdde1 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -10,6 +10,7 @@ while making sure to add submodules using `git submodule =
add` instead of
 `git add` as done in t7401.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.1.216.g4365c6fcf9.dirty


--Iqm+yyrgiPmF4XQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNggACgkQVbJhu7ck
PpTp3w//dghU2jKQ7k0p2E1eLtzKuTAVmlUy8hHnDpN5p+N4XOXdraQieennjPx5
iD1sRIVBIQgC0mCoRn7QyQSiiAQaJeFwNs7pW5GsVCE2apZD/b+Wxu2Jn3e9jfnC
x2He0Nk7GXXTG/sfNfVf94hsE9nI5AuVPuw5P0o9w/LP/iJdMW6hRj9xjzFaZeHf
27jr17IPSY2LC/JvNWfJlzHysOVcrziZ6YsP8I5UTxDy0DkL2HlWofF9CLvw6mdn
poQn4SzXbm91LBpdjeoCisXLXfAIOCiF5gZ2KWMQUIwlr0SNzrkvg2hV/GPuwpLD
pwpPw44qKKt90tt9RQ8Dn8qJehjdrnloi9hJtowds88Ko/liRnLLZEmP0g5IW7UZ
C8TE4mFDmAzGqyg7alErJflHGt+H93U9qm3ksEVCFHw2FSaK2ep/Zvsf19mJa+RR
zY63IOfRW1Gt6bqp4hkBAj7OfaPOzkLd3Jc6+IF4SOI00+BSE93yNon83O5vbPMl
6MY184rz6VnWYV7mTrjeQKjCxy1tcLRhSn29fmRZPFP61txQOlGq5rLsP6cqNSfg
6kBRJJB4V3gG9g4KRyaW8nUs8k/6VLsUoAdFnSTKJiZnW9uH3eGMMtwihbOohPEl
B09UhfbbbQT42aL0wFySpHFn2PHn9kOHLAPdGQCh/qhZVFQEavI=
=qgid
-----END PGP SIGNATURE-----

--Iqm+yyrgiPmF4XQy--
