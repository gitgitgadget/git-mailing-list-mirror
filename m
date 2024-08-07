Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EB1B86DE
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013841; cv=none; b=g+GlxRmSSfI7K0XsLwc1kCR9W9ZRuM9k2uoBbAr+q/yB5Q5c8aWrZOUcOmGwk1BNWI+tR9S6XpDlaBybjycVraWOnq6dDMTkIqQ8wgogvoJrhmSM+zm9bcG9ChLln9aptXn8mpdDA1gEYO9JTh/VY8pligkwWNgtn8crz4Jhq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013841; c=relaxed/simple;
	bh=PkwhfhVqKQxl8s6fp7wuaf2Qxaeihj86BBVeOIvFiEQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/wfzZhQmTx4vnic1jxYzp59uG1/b3DUdev5ac1RfNo+vWwHlGBDfv8lGmVr63QdhZX33YE2AkKPLf/kKNME6m7FlkZRCYoPL9p1lkM5XXVWEj2fnB8nZm/RLgo1o7jOl9NqfMTkVYypBjb+Da5ciTKbgLBXaO9dbk4wJm7YZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JLgbIiFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8kamzZg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JLgbIiFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8kamzZg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 51A091151ADA
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 02:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013838; x=1723100238; bh=x4R5U/LkvS
	i3Ww9kiG8f46geUgMmvfgs6xvtz2iEfbA=; b=JLgbIiFe20IcRvs1bPkHc3JDa1
	dpxNKTVOzZpBFoQ/yFCZgKm+8ouv+NbQjCxVgvgtbxX06sCBSAMv1JmMg0e9Az/e
	JTwtDCiPc7+oEZ154OcfGDumRSyZf9bUMp8hLbDsEVok3ktwvWaRu45XA1Jd3xZl
	oTG4FSzscPy2R4g+dRONOVbiIDYiuJ4s61qc2kygrkOJ1J0KfWupT3oG30QnfCJv
	AL9Zmo00qlTt5q3LoXtWe3mlbUUTBHeEUTJ5npix1TNFl76w5EJQn+t4L1ZTUhRG
	zlHIsfm7siGWhyNG4R7PEsxoF91+UCWyylBu40QUSEImxTUr7cVFVUgbMWjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013838; x=1723100238; bh=x4R5U/LkvSi3Ww9kiG8f46geUgMm
	vfgs6xvtz2iEfbA=; b=O8kamzZgnLyk+4XP7c3dz3A9F3AQKsdh/NhqDwy6t1J0
	iLAWbFgmxwDyWlk0jQz/87EEKv2o0NoWcQp0wUmikNOOqym27XLz2REulD/kVvZE
	wprOX0TpfM5iUglpCw8XN6mVVlLSgl2gsFrdAXAV9hmluCMPSF6FPq2AQg/IbbgR
	gcoS9732HMTLabkPWtLh6ndeyBW82h5cB1Kmbv9YGhxXQ+ZgATSVe6EBdml/6PEj
	ZMtaNMrLZ5P7JkpyYyDj606+IyAIk4ENcw5lE8HtMyHm9y9BaOWLCQasUBfZv2V9
	JuhtnRT07pzVu+Zgxt2/zVW132vNUytlNYbAUQQAaQ==
X-ME-Sender: <xms:zhqzZiC8VYdKRhVsoELG3-E5GZVtqj3WPJPiXXyfq8ighyPZ3JzV_w>
    <xme:zhqzZsj1-xte44fzDqAMRwuXZt-zWsvJOOGxV_DYKUlq5IEwmO7kIjqxUVWjTX_g7
    TPcsXrfV603PBE_aA>
X-ME-Received: <xmr:zhqzZlmu2UTjQPhpjSq4pukcXy3gqMVoO0WKtLOcU_fVpL_QvIsw-O-AAQNOoyhdK36_K6XfNkaOO5kHcpH28Q0rNk5wHP_7BvKDXrmUX24Y97tt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:zhqzZgyeQhATmdkiT5yxLsSEnZMRavs_WUoX_jCjFcWq3xX44A7q6g>
    <xmx:zhqzZnTXrx08dZpNF1OqXGWgIxn42us-sx9TCaTCmQ62u4mHgFUmaw>
    <xmx:zhqzZraQR1deHsZoHMvWmJL1ikPH7Is5qEUXaNdk3_h9DJv2JY8Psg>
    <xmx:zhqzZgSz4SM6r32C6MG5_IBWLeaPIgKuve2bHuJ74HVhPUgLC56oIg>
    <xmx:zhqzZuLe0t-dgqY0p8GEOWunBAKUsSCECm7X4hhiEVh03liBDWZbJbjk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f210615c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:13 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/20] path: hide functions using `the_repository` by default
Message-ID: <b4e973a2804ba09149224a2e18a359717228607e.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KdU+IXrInvv+U9G/"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--KdU+IXrInvv+U9G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The path subsytem provides a bunch of legacy functions that compute
paths relative to the "gitdir" and "commondir" directories of the global
`the_repository` variable. Use of those functions is discouraged, and it
is easy to miss the implicit dependency on `the_repository` that calls
to those functions may cause.

With `USE_THE_REPOSITORY_VARIABLE`, we have recently introduced a tool
that allows us to get rid of such functions over time. With this define,
we can hide away functions that have such implicit dependency such that
other subsystems that want to be free of `the_repository` will not use
them by accident.

Move all path-related functions that use `the_repository` into a block
that gets only conditionally compiled depending on whether or not the
macro has been defined. This also removes all dependencies on that
variable in "path.c", allowing us to remove the definition of said
preprocessor macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c |  52 +-------------------
 path.h | 147 ++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/path.c b/path.c
index 567eff5253..d073ae6449 100644
--- a/path.c
+++ b/path.c
@@ -2,8 +2,6 @@
  * Utilities for paths and pathnames
  */
=20
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
@@ -30,7 +28,7 @@ static int get_st_mode_bits(const char *path, int *mode)
 	return 0;
 }
=20
-static struct strbuf *get_pathname(void)
+struct strbuf *get_pathname(void)
 {
 	static struct strbuf pathname_array[4] =3D {
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
@@ -453,44 +451,6 @@ void strbuf_repo_git_path(struct strbuf *sb,
 	va_end(args);
 }
=20
-char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-{
-	va_list args;
-	strbuf_reset(buf);
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, buf, fmt, args);
-	va_end(args);
-	return buf->buf;
-}
-
-void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-{
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, sb, fmt, args);
-	va_end(args);
-}
-
-const char *git_path(const char *fmt, ...)
-{
-	struct strbuf *pathname =3D get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
-char *git_pathdup(const char *fmt, ...)
-{
-	struct strbuf path =3D STRBUF_INIT;
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, &path, fmt, args);
-	va_end(args);
-	return strbuf_detach(&path, NULL);
-}
-
 char *mkpathdup(const char *fmt, ...)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -634,16 +594,6 @@ void strbuf_git_common_pathv(struct strbuf *sb,
 	strbuf_cleanup_path(sb);
 }
=20
-const char *git_common_path(const char *fmt, ...)
-{
-	struct strbuf *pathname =3D get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
 void strbuf_git_common_path(struct strbuf *sb,
 			    const struct repository *repo,
 			    const char *fmt, ...)
diff --git a/path.h b/path.h
index 6228ca03d7..22fdfc3d3a 100644
--- a/path.h
+++ b/path.h
@@ -25,7 +25,7 @@ char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
=20
 /*
- * The `git_common_path` family of functions will construct a path into a
+ * The `strbuf_git_common_path` family of functions will construct a path =
into a
  * repository's common git directory, which is shared by all worktrees.
  */
=20
@@ -43,14 +43,7 @@ void strbuf_git_common_pathv(struct strbuf *sb,
 			     va_list args);
=20
 /*
- * Return a statically allocated path into the main repository's
- * (the_repository) common git directory.
- */
-const char *git_common_path(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-
-/*
- * The `git_path` family of functions will construct a path into a reposit=
ory's
+ * The `repo_git_path` family of functions will construct a path into a re=
pository's
  * git directory.
  *
  * These functions will perform adjustments to the resultant path to accou=
nt
@@ -87,14 +80,7 @@ void strbuf_repo_git_path(struct strbuf *sb,
 	__attribute__((format (printf, 3, 4)));
=20
 /*
- * Return a statically allocated path into the main repository's
- * (the_repository) git directory.
- */
-const char *git_path(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-
-/*
- * Similar to git_path() but can produce paths for a specified
+ * Similar to repo_git_path() but can produce paths for a specified
  * worktree instead of current one
  */
 const char *worktree_git_path(struct repository *r,
@@ -102,27 +88,6 @@ const char *worktree_git_path(struct repository *r,
 			      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
=20
-/*
- * Return a path into the main repository's (the_repository) git directory.
- */
-char *git_pathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-
-/*
- * Construct a path into the main repository's (the_repository) git direct=
ory
- * and place it in the provided buffer `buf`, the contents of the buffer w=
ill
- * be overridden.
- */
-char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
-/*
- * Construct a path into the main repository's (the_repository) git direct=
ory
- * and append it to the provided buffer `sb`.
- */
-void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
 /*
  * Return a path into the worktree of repository `repo`.
  *
@@ -164,19 +129,10 @@ void report_linked_checkout_garbage(struct repository=
 *r);
 /*
  * You can define a static memoized git path like:
  *
- *    static GIT_PATH_FUNC(git_path_foo, "FOO")
+ *    static REPO_GIT_PATH_FUNC(git_path_foo, "FOO")
  *
  * or use one of the global ones below.
  */
-#define GIT_PATH_FUNC(func, filename) \
-	const char *func(void) \
-	{ \
-		static char *ret; \
-		if (!ret) \
-			ret =3D git_pathdup(filename); \
-		return ret; \
-	}
-
 #define REPO_GIT_PATH_FUNC(var, filename) \
 	const char *git_path_##var(struct repository *r) \
 	{ \
@@ -260,4 +216,99 @@ char *xdg_cache_home(const char *filename);
  */
 void safe_create_dir(const char *dir, int share);
=20
+/*
+ * Do not use this function. It is only exported to other subsystems until=
 we
+ * can get rid of the below block of functions that implicitly rely on
+ * `the_repository`.
+ */
+struct strbuf *get_pathname(void);
+
+# ifdef USE_THE_REPOSITORY_VARIABLE
+#  include "strbuf.h"
+#  include "repository.h"
+
+/*
+ * Return a statically allocated path into the main repository's
+ * (the_repository) common git directory.
+ */
+__attribute__((format (printf, 1, 2)))
+static inline const char *git_common_path(const char *fmt, ...)
+{
+	struct strbuf *pathname =3D get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+/*
+ * Construct a path into the main repository's (the_repository) git direct=
ory
+ * and place it in the provided buffer `buf`, the contents of the buffer w=
ill
+ * be overridden.
+ */
+__attribute__((format (printf, 2, 3)))
+static inline char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+{
+	va_list args;
+	strbuf_reset(buf);
+	va_start(args, fmt);
+	repo_git_pathv(the_repository, NULL, buf, fmt, args);
+	va_end(args);
+	return buf->buf;
+}
+
+/*
+ * Construct a path into the main repository's (the_repository) git direct=
ory
+ * and append it to the provided buffer `sb`.
+ */
+__attribute__((format (printf, 2, 3)))
+static inline void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	repo_git_pathv(the_repository, NULL, sb, fmt, args);
+	va_end(args);
+}
+
+/*
+ * Return a statically allocated path into the main repository's
+ * (the_repository) git directory.
+ */
+__attribute__((format (printf, 1, 2)))
+static inline const char *git_path(const char *fmt, ...)
+{
+	struct strbuf *pathname =3D get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+#define GIT_PATH_FUNC(func, filename) \
+	const char *func(void) \
+	{ \
+		static char *ret; \
+		if (!ret) \
+			ret =3D git_pathdup(filename); \
+		return ret; \
+	}
+
+/*
+ * Return a path into the main repository's (the_repository) git directory.
+ */
+__attribute__((format (printf, 1, 2)))
+static inline char *git_pathdup(const char *fmt, ...)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	va_list args;
+	va_start(args, fmt);
+	repo_git_pathv(the_repository, NULL, &path, fmt, args);
+	va_end(args);
+	return strbuf_detach(&path, NULL);
+}
+
+# endif /* USE_THE_REPOSITORY_VARIABLE */
+
 #endif /* PATH_H */
--=20
2.46.0.dirty


--KdU+IXrInvv+U9G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGsoACgkQVbJhu7ck
PpQwpA//Yx4T2tFOb1sL7YfJtr7q9PJBmxsxYTyRb9OYF30EyoqGTlVtQ5wBYuLe
ix+N/bmOu5nBIXbMi+5aHXnrAnoRtrt3NQDmzmvXoEOMYZDxZ9lN91ljxx929FIG
Uli26EkXq1IFaAyG8LnGSbFfiFYtAA7U/6hag9ou/a3csSKli8hMG/cOkVy5wlpP
zoJ3RPTz9cRl5m77Zl8SavzfQKLBLVcSRwlzcRkBV0McODHwALJyLcp25SnV6JhI
ZZ/KO/Vf26cBEnFHqjW8JXrY5E7TGkWaHBNBFI0bJuFnCZI1qjHznKE0YCZfwgWv
HyO6dTifkOAsUwO32JL6ljD0nn5PqCxk9Q1OyCq3AVtoSqdoadooZ/UBL1FT666b
375L7R5Ah7B93r5Rs9ZtDPnrmtDiA/Z9I2aG2NzDKHyomOCjs709fhplrgH2+kno
7ZaFC1IiK2PCzREQJnFaqdE3jwVxYIxVB8yd137IIGiYi8IwuakLfb6dGYbXa9K/
TmVD4eR0V3mrYjfUNJ7G3LPmsJPuX/Ysj8KxeGslDTkwwxih4NFGnssbdMNzoteN
MckyJKq0glb8+DyCiKKT0+/5DSgW3fVkYYvXPivi0f661fOLQ0nJnjGthRGHqGNP
fdK3uVYotAlr35F8jtmydWlL2b9Ldu8gbD1lp64U4hY680roKXg=
=xheh
-----END PGP SIGNATURE-----

--KdU+IXrInvv+U9G/--
