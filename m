Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C51B1428
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013814; cv=none; b=LPEKLEhJaQcS3NkxHQ5sgoOZ8zZuIURYOBzXHFbyiK8vsiCFk/omJ2SvI5yb85ceXrspApAuDlBwPhcR6EJnlHH2rrFSX525z4xE/yzjS42aqPvo1MtAYzOvjprIyDWiE9cDSjszrbW8zsyJlbLnbb+Aga16CbF3UNRt2RtJX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013814; c=relaxed/simple;
	bh=6/Bgkaw3uX2Ss4jv7TTwF9FcXlbSDxm6y/wS7SJU+N4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBF2kc6ciVpKHxqTVH+mgTl2jFY0MlV1yWQOx60JcCVl8ofWOcnoSoPQO5/7eI7m8+oyw77ho3+KC7+HETIexT50SZFrLC5t2qjNniDZCf+dvTc9wEzCcPnHg/7ddFoyS189nINY7+HLrj/UUbME3u0sWuoLIjM8DM6p5bJy7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=An34ptuu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJ8RByK0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="An34ptuu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJ8RByK0"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 583A5138FCA2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:56:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 02:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013810; x=1723100210; bh=8XBHBS+mo0
	W076TOuHzeZULu/9gMd3gkQ/LDPEnioW4=; b=An34ptuuX6C1fByNjYNQ/1D/mm
	xBZxsWwWM8OaqlzEKtfXauzcvtKMnsAxk5xPKYI2ro+ree9U5fibrOI6tGMM5E5j
	4KAjQaTeJMslk/jELhtBbOYtsXImBfiQvSoZ1pynXECmjqB5yRTSlWn+hGYgR2/Q
	fKEY75nsf6231Xnwp1TAkHI12IDQjKAOhp0THoT95fmPs6NG/b7GbMox0cYHdAot
	cKcfTEPTL6EHBXQ3/pFXJmDBAG+7Evr6s6PELhduNtiMzsxAXUGUa3LsTjgOvGLz
	TvW3jipBPgziSfzl/Yk0DJxcdHrzCG6hZysqCD3eBs9VX6r4LLy6nBXiTZ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013810; x=1723100210; bh=8XBHBS+mo0W076TOuHzeZULu/9gM
	d3gkQ/LDPEnioW4=; b=SJ8RByK0NeqoD8e+VYSdL1f6Y2VraOkxQQuDKMy0uJ3q
	WxTTqgH61OupbLBv0OpGw+EgN4F3trenM3uvnUrZIrFrm94qMKmtY7hJzTdsoLKI
	tiBXnatZr/AOsJ4tJQJ0Rxl7Oe0sWpNhKpKHDII9A47B/+Mjk3S4cCDsyEmtH2/g
	6hiHTJquYzkpMfBAYMAEGTholJTaIacotTv2qi2Egx3KOqmgJ1WTfz0XuTJxtIdO
	D0/Ftig0g6QTGLCgLj5HxZuNL1IyPyE4L8iNfZCt8q8DUoJKd/+wg4cYipBqUxln
	V4oqfPABBqYwmfGA3h1w6De7CI1UyThADDxjjGXBPw==
X-ME-Sender: <xms:shqzZjkYmICE_e8YEB0bE0K6WHv3qMV9eOaXzAi68gpdXDHbsXyjKw>
    <xme:shqzZm2iB3HYkmW9rzoN9yDk1qsPFU9imO6BCY4YANR6e0V5zATh3EHr4wWFsz8Nv
    y-H9ox7OdgJ-DGRRw>
X-ME-Received: <xmr:shqzZppuCjZZA34Cf7r2JEXHtcp9ZjpjhjChaGwEylxUpbpNbrqv3XpCh5Ow2leEMnyZqwtDb7puOKMMTDLAlZFANEyztLHzhYZjmpbhCt_K6o0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:shqzZrnfqijsNRi8kBu2e5U7crfZQwCOu3njgCAB9FnaGlSOV7mGJg>
    <xmx:shqzZh08kb7wDWZpOXQkbFJoc7bas9QLWLmO0X3cEDvA-dMGk1mQpQ>
    <xmx:shqzZqtCe7F-VFZoEXDhJAHUu3WlHWGpoLsLPMcwAXU5fzpOj7MGRA>
    <xmx:shqzZlWWooGySrofOj9QUETY136ANhZmVhHQAienc34TBmlOExNWfA>
    <xmx:shqzZi_JDrfcAB58F6OOy-MxHwEOyJ4XC1_lRVVvyh6ErrD13cMJMcO->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:56:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b82e511c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:56:45 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:56:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/20] path: expose `do_git_path()` as `repo_git_pathv()`
Message-ID: <7ce3278f649ce70453242e5458d28c5fd54576ba.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjXSi7nkt9hdfFnZ"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--pjXSi7nkt9hdfFnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to move functions of the "path" subsytem that do not use a
`struct repository` into "path.h" as static inlined functions. This will
require us to call `do_git_path()`, which is internal to "path.c".

Expose the function as `repo_git_pathv()` to prepare for the change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 20 ++++++++++----------
 path.h |  8 ++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 19f7684f38..71f1cb4dfb 100644
--- a/path.c
+++ b/path.c
@@ -417,9 +417,9 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 		strbuf_git_common_path(buf, repo, "worktrees/%s", wt->id);
 }
=20
-static void do_git_path(const struct repository *repo,
-			const struct worktree *wt, struct strbuf *buf,
-			const char *fmt, va_list args)
+void repo_git_pathv(const struct repository *repo,
+		    const struct worktree *wt, struct strbuf *buf,
+		    const char *fmt, va_list args)
 {
 	int gitdir_len;
 	strbuf_worktree_gitdir(buf, repo, wt);
@@ -438,7 +438,7 @@ char *repo_git_path(const struct repository *repo,
 	struct strbuf path =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(repo, NULL, &path, fmt, args);
+	repo_git_pathv(repo, NULL, &path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -449,7 +449,7 @@ void strbuf_repo_git_path(struct strbuf *sb,
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(repo, NULL, sb, fmt, args);
+	repo_git_pathv(repo, NULL, sb, fmt, args);
 	va_end(args);
 }
=20
@@ -458,7 +458,7 @@ char *git_path_buf(struct strbuf *buf, const char *fmt,=
 ...)
 	va_list args;
 	strbuf_reset(buf);
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, buf, fmt, args);
+	repo_git_pathv(the_repository, NULL, buf, fmt, args);
 	va_end(args);
 	return buf->buf;
 }
@@ -467,7 +467,7 @@ void strbuf_git_path(struct strbuf *sb, const char *fmt=
, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, sb, fmt, args);
+	repo_git_pathv(the_repository, NULL, sb, fmt, args);
 	va_end(args);
 }
=20
@@ -476,7 +476,7 @@ const char *git_path(const char *fmt, ...)
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, pathname, fmt, args);
+	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
@@ -486,7 +486,7 @@ char *git_pathdup(const char *fmt, ...)
 	struct strbuf path =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, &path, fmt, args);
+	repo_git_pathv(the_repository, NULL, &path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -517,7 +517,7 @@ const char *worktree_git_path(const struct worktree *wt=
, const char *fmt, ...)
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, wt, pathname, fmt, args);
+	repo_git_pathv(the_repository, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
diff --git a/path.h b/path.h
index a6f0b70692..94e7030f0b 100644
--- a/path.h
+++ b/path.h
@@ -66,6 +66,14 @@ char *repo_git_path(const struct repository *repo,
 		    const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
=20
+/*
+ * Print a path into the git directory of repository `repo` into the provi=
ded
+ * buffer.
+ */
+void repo_git_pathv(const struct repository *repo,
+		    const struct worktree *wt, struct strbuf *buf,
+		    const char *fmt, va_list args);
+
 /*
  * Construct a path into the git directory of repository `repo` and append=
 it
  * to the provided buffer `sb`.
--=20
2.46.0.dirty


--pjXSi7nkt9hdfFnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGq4ACgkQVbJhu7ck
PpTRng/6Axs0Jm6pAas8GhAasCXLK7NIA6FI5CpwQY9s9gs96BJ0f87ZINMYj+i2
UJepLJD0N7+N2DudU988O4XYmEVE6G4NaKvAs3nxf2imASog/GbQZZeNoUc/Wewr
DIck0oT8+kx+sYr8ULM1m8ZoI5JZWl0kbllaZmVD0uxCY/3SV5RrWmeMCPPZty2D
4dhTNJjM4XUJIBX6eD98V5w9VCKFv62HTwVEcs5Y2Mc5CxvEJC2BoH5801vuS+Y+
Kz2A38G7mP2EQ8apOVTzAaU1OaGt9cQx4jjQNKbSrZUdE57RthZmn06tGy5RHDoC
Hz5TmA5Z4OK/64VbgATN6tKhaC+EOh+AXZBGdR80DXEsEQGJnkykAeboQkNGmOXs
afUfOAisTLTAK10zVOwBy1IYlpmvW3ShgQVkfM+j6a9yt4EGUMPVXhpZ9H77yYQ8
/eaAKUz756y1YlHqbJb5Bbi/QzNJdZIyWipkpfctepQ9mi/fQwHAFvjMSiHaJlJv
DxuKP4lb/7kc3CmDruzCjpfhC3zNGIS9AAmNbZdxn46oSQVx3ivuA5L+odcVvV+R
u12nO8Nf/XXq6NuTqUeTT72FuYARQWDPegzb9C1J3M7NVevaiVrdTTZblbOfQORR
bWLt3+05byvo1lBKffNphzpDjn0ZkcEdfNkrE+H/ojov7lqp7EI=
=KoDv
-----END PGP SIGNATURE-----

--pjXSi7nkt9hdfFnZ--
