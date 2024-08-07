Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C951B8E9A
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013835; cv=none; b=ezmxC3t2Ggtea642DCc5yZDSb7k8n4y/TEJWrZX+zI4osl1pyVpJtwCXzJY8ObIyBL22GzBE3OGQA7bzAC2jS/UZRo315vy0tlKEUuOAB8Os4yUq6f5kX7eNcn7z1Twi8C3lWb+QIDzDjZ41PZQ4+N0CstLBOyUipjpL0a207Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013835; c=relaxed/simple;
	bh=pfhETFuTZ1uwEMGgQPLym+iJJiUDauwBXUftiow0ecc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI/09etD6uN9sN3elSKcB72REwpuVwgVWLpSwPk+tvKFvoEt7Ldsr5WgrBH2c83MykUy9dQsHT3iNUuFh37td19OooelpCwUD/vt5zPg3s5TGBW/wfr8LDsyWzYX03xqHDYIxVioPykbLlNqAGuH2QjU2rOc/xaEe0xq/Fwq7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lrO984pE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u6HgHG60; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lrO984pE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u6HgHG60"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7D007138FCA2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 02:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013833; x=1723100233; bh=BPgFGO5bHU
	IF4b1oVF3IooHKlS6bY5oqzlFx64vMURU=; b=lrO984pEuxf/xQCsM7zvtTMin8
	ocET8KOHN/EjKRIH/uGwWIUcsQYolkvJWRcVBVqXSlHw44lwTHc1l/e4f2mUyIc/
	oiXNW4kCjuSOJhdST5IunnR39Q/XANB+LmGddOLBgzmrqtsHr+A4ADqkWVyEVvLN
	HU8WmxqeLDDVsjCdAm3MUHgDmU5sEUvAtrgpnSQOK0U3YRhktm+q1AQlU64ZgUK/
	XG3YKmAbChp/SjzDgjPZH9sfiq1X36Ea71AQKiWuD8E1+hdSXfBZx+2DCz3rfXxn
	2gDisVEyX7gQrvqTCBKbs193vHQi9fz6S/l8MTVab1vWE9WeaYvbqQ29hCYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013833; x=1723100233; bh=BPgFGO5bHUIF4b1oVF3IooHKlS6b
	Y5oqzlFx64vMURU=; b=u6HgHG60MYYURTA6W7sxDe7Hwkxe5KMGDSaxIhHWttYG
	9yQ9rmjexiqFZDFmPCbl/yv5aE7jIgHAPYPqkW2+LR8Ub7IVCYMVSVsSKxJoDrux
	91bEQQt9gGgZGLcmagsuVUIf8OL028G3OC++pz0t8nrvP3T6djiNavAKyBSNP4cv
	F0R3COJ2iFAYc+pMUBcgTesyBnDrilE8TQa8K5Jql2uism1fKzBCxDCkVhd9QMGp
	N9ZP8QZxkfGkXtJyUmvtbrhnJen3wOaWjMfh7Cv+eFzcSxSE1ZjSWiROqTYa4OS9
	mRpFKipz9klhec6ezObw+E1doHjpzL2gQfZpuN7U4w==
X-ME-Sender: <xms:yRqzZtN5FlhcRhmoazzR6o76O6KO4MXhWnFboBOZgQbsQ-ryJ4JRkA>
    <xme:yRqzZv-Mf0MeluyOZhCVpOcGcJlbEjRnGV95dPx8PojrFVziZZ7Je63gM0rcb53xa
    nur5mNW74-R0tsyYA>
X-ME-Received: <xmr:yRqzZsR6cGqqwRKlL5rhLTxS_apw4laBHn9qQ-txjmEQViWjQjx_-KqNxqudHQsFKOHBujHyIK5aZ9VO48SBaJGWa2im-QX67B7WiQXXx6ybz4Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:yRqzZpvJw8mKWVg43CyQDNRinC332ex8M2A_0PV0NV7uJoY7F_f12g>
    <xmx:yRqzZlfdpVCvYUOgQsl95UqrUS8VAyTDFcHQMdN1vMjrsuoLLal4CQ>
    <xmx:yRqzZl0EllpUIMG7cCInp_snHabwfA3VYiNd7qceSVGyTs1rg3HRVw>
    <xmx:yRqzZh_7JHjqKh8VRBWY9VzzG8UHxBYURrGhHUgmCq_DjLi73-A1AA>
    <xmx:yRqzZlFNMiBu6LXZVVfHcTcC_bzgJjyLTwpXDoJLWd0Fr6qmIOX3Jpa1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a140e4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:08 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/20] path: stop relying on `the_repository` in
 `worktree_git_path()`
Message-ID: <67405dcd0a121aee971f854dc35ba89bd4f808c4.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o1CGvC+V0vGd2+Ur"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--o1CGvC+V0vGd2+Ur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When not provided a worktree, then `worktree_git_path()` will fall back
to returning a path relative to the main repository. In this case, we
implicitly rely on `the_repository` to derive the path. Remove this
dependency by passing a `struct repository` as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c     |  2 +-
 builtin/worktree.c |  4 ++--
 path.c             |  9 +++++++--
 path.h             |  5 +++--
 revision.c         |  2 +-
 worktree.c         |  2 +-
 wt-status.c        | 14 +++++++-------
 7 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..ad36df9628 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1050,7 +1050,7 @@ int cmd_fsck(int argc, const char **argv, const char =
*prefix)
 			 * and may get overwritten by other calls
 			 * while we're examining the index.
 			 */
-			path =3D xstrdup(worktree_git_path(wt, "index"));
+			path =3D xstrdup(worktree_git_path(the_repository, wt, "index"));
 			read_index_from(&istate, path, get_worktree_git_dir(wt));
 			fsck_index(&istate, path, wt->is_current);
 			discard_index(&istate);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a4b7f24e1e..eb0a386992 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1146,14 +1146,14 @@ static void validate_no_submodules(const struct wor=
ktree *wt)
 	struct strbuf path =3D STRBUF_INIT;
 	int i, found_submodules =3D 0;
=20
-	if (is_directory(worktree_git_path(wt, "modules"))) {
+	if (is_directory(worktree_git_path(the_repository, wt, "modules"))) {
 		/*
 		 * There could be false positives, e.g. the "modules"
 		 * directory exists but is empty. But it's a rare case and
 		 * this simpler check is probably good enough for now.
 		 */
 		found_submodules =3D 1;
-	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
+	} else if (read_index_from(&istate, worktree_git_path(the_repository, wt,=
 "index"),
 				   get_worktree_git_dir(wt)) > 0) {
 		for (i =3D 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce =3D istate.cache[i];
diff --git a/path.c b/path.c
index d6bdb992ba..567eff5253 100644
--- a/path.c
+++ b/path.c
@@ -512,12 +512,17 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
=20
-const char *worktree_git_path(const struct worktree *wt, const char *fmt, =
=2E..)
+const char *worktree_git_path(struct repository *r,
+			      const struct worktree *wt, const char *fmt, ...)
 {
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
+
+	if (wt && wt->repo !=3D r)
+		BUG("worktree not connected to expected repository");
+
 	va_start(args, fmt);
-	repo_git_pathv(the_repository, wt, pathname, fmt, args);
+	repo_git_pathv(r, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
diff --git a/path.h b/path.h
index 3d21b9cd16..6228ca03d7 100644
--- a/path.h
+++ b/path.h
@@ -97,9 +97,10 @@ const char *git_path(const char *fmt, ...)
  * Similar to git_path() but can produce paths for a specified
  * worktree instead of current one
  */
-const char *worktree_git_path(const struct worktree *wt,
+const char *worktree_git_path(struct repository *r,
+			      const struct worktree *wt,
 			      const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+	__attribute__((format (printf, 3, 4)));
=20
 /*
  * Return a path into the main repository's (the_repository) git directory.
diff --git a/revision.c b/revision.c
index 1c0192f522..0b92a13af5 100644
--- a/revision.c
+++ b/revision.c
@@ -1872,7 +1872,7 @@ void add_index_objects_to_pending(struct rev_info *re=
vs, unsigned int flags)
 			continue; /* current index already taken care of */
=20
 		if (read_index_from(&istate,
-				    worktree_git_path(wt, "index"),
+				    worktree_git_path(the_repository, wt, "index"),
 				    get_worktree_git_dir(wt)) > 0)
 			do_add_index_objects_to_pending(revs, &istate, flags);
 		discard_index(&istate);
diff --git a/worktree.c b/worktree.c
index f3c4c8ec54..886c5db691 100644
--- a/worktree.c
+++ b/worktree.c
@@ -252,7 +252,7 @@ const char *worktree_lock_reason(struct worktree *wt)
 	if (!wt->lock_reason_valid) {
 		struct strbuf path =3D STRBUF_INIT;
=20
-		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+		strbuf_addstr(&path, worktree_git_path(the_repository, wt, "locked"));
 		if (file_exists(path.buf)) {
 			struct strbuf lock_reason =3D STRBUF_INIT;
 			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
diff --git a/wt-status.c b/wt-status.c
index b778eef989..b477239039 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1618,7 +1618,7 @@ static char *get_branch(const struct worktree *wt, co=
nst char *path)
 	struct object_id oid;
 	const char *branch_name;
=20
-	if (strbuf_read_file(&sb, worktree_git_path(wt, "%s", path), 0) <=3D 0)
+	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", pat=
h), 0) <=3D 0)
 		goto got_nothing;
=20
 	while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
@@ -1716,18 +1716,18 @@ int wt_status_check_rebase(const struct worktree *w=
t,
 {
 	struct stat st;
=20
-	if (!stat(worktree_git_path(wt, "rebase-apply"), &st)) {
-		if (!stat(worktree_git_path(wt, "rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying")=
, &st)) {
 			state->am_in_progress =3D 1;
-			if (!stat(worktree_git_path(wt, "rebase-apply/patch"), &st) && !st.st_s=
ize)
+			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), =
&st) && !st.st_size)
 				state->am_empty_patch =3D 1;
 		} else {
 			state->rebase_in_progress =3D 1;
 			state->branch =3D get_branch(wt, "rebase-apply/head-name");
 			state->onto =3D get_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &=
st)) {
+		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactiv=
e"), &st))
 			state->rebase_interactive_in_progress =3D 1;
 		else
 			state->rebase_in_progress =3D 1;
@@ -1743,7 +1743,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 {
 	struct stat st;
=20
-	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress =3D 1;
 		state->bisecting_from =3D get_branch(wt, "BISECT_START");
 		return 1;
--=20
2.46.0.dirty


--o1CGvC+V0vGd2+Ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGsUACgkQVbJhu7ck
PpSDJBAAjpfSrHskVMzoTCzbKrh8Ukf61YSz/pa5o5kVby4j1RF6iWvuBCrFYmPc
7ZFmCKy1UXU3AuqXGxdCl5xbK39Ffp2yaFf8ZatTyOloWpetE4A7Bgat8EMrgmGW
XSAtNL/aTycOynm6Z6x4uYgy84LMjvEfG1vm/nXJqRTh50qYcKPR3h8Mr/E6j0Q+
8UZ3tkzW512A7FAkBXFiYsRlxLRRTqX4NHsT5xO0bA7kk0eb6xnIOYdGgIZtjF2Z
G1O/msGINbEcM3qmE0wc0Us8nCBOVm+Yjsd3E7SCA0zFaYSlChLamhOWusElU9bY
cy0f13FpvjSXyD2a37pnrrZVPHi+6bXVHkDAbxXvEHKETKM0SoapHpzFKSewZNmN
ynCNmGKkI25cCekMfAoLk7dsnZdtQwnSdcIi2EwHY+zMZ8KqeOEO4efsw6DPc3p8
3pekREXG7/HuXD7nvXG9YQsehVx0nk25V/D/1H365pKFp7scxv3BhKqLOSFHaE7x
tx3BNjzt1ev0QZ477IFZwu2d9COyaMdJy3PfkcVe+DmtgqBV8sSxLWbDixPhbmf7
L6knKXYpl4EvtBaKSd5s+VhstkPyztUm2lQYpAJG1MhQWYYxC0c8Ar9EpuQKCam2
dNM0T10RWrrJJTLrpE7zDwMEvI/535f7drNnDDbp3GxWR15uwMA=
=K3MK
-----END PGP SIGNATURE-----

--o1CGvC+V0vGd2+Ur--
