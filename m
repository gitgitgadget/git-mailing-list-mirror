Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE118A95E
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540426; cv=none; b=XcHDQbUfxTLRt+ICfczL+aaFhggBweDD773kg/ETR1nS8ZsbF9lSg30/yc2qw/ev6CNM//0pMWJT4a63NzCo7C30LERA0w1GpSze+OxtrLgTjP189fVb31l4Hs1n3lgt+R8uXn/PhaH/BEjMHgAn/aFBDDQ7UeFXXBknE0NHi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540426; c=relaxed/simple;
	bh=+e9advTAN0KMTSvLA2EXjjMkTIuJb4s/Wm0kpWXCN/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX32WKv/PwhpHmfZ6C0v1b19kh93Kr1fD67n46M3c0YG7kbPZHlsSAfviCFQq4zme+lZtVjI4LQQXDZR5rYNk5C/Xm6XfsyPqExnyee4eLGMzwq33K0QmtMYnSOP9Ivq3v6oX7AJuyhJWHNQvSlrEKvSNlyZ6nmFGjL32oQJTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TyWNan8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GB3T7T2u; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TyWNan8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GB3T7T2u"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 39CAD11519D0;
	Tue, 13 Aug 2024 05:13:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540423; x=1723626823; bh=YsbqfhRman
	lck0BU7x5nKUQ/AjDnLazONUeekSz+tMo=; b=TyWNan8h83v8mxuYTt+G9GYH+g
	uqVsWpFW5Qi9eF1+QKGshjskMZfs3o82So66fuB6HEm4mbIqDIGtzBp0KSnjhmB+
	03htSmfK5jtdBao26SNW2j/qtI71k2TpQBZeewV/tGoktjMkgBswzBnu8T07IKDw
	zDb58wfJwAmd+YmHUzS5NaN42DFbWp3VVypwXslYRRtB/Ehp5yDFIqJrGn2F/cl8
	yokl/ki52oNmK+uDOJpfYMtQlinzAKMwcMKjDSePZqfXwVeoi0Vf9a/J2h97YeE0
	7D4xZuDv5t9ZKWINbSTIoqwQW3QXxuhqB8IzCREnalpsLwZ/cSUC6Cx8aiXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540423; x=1723626823; bh=YsbqfhRmanlck0BU7x5nKUQ/AjDn
	LazONUeekSz+tMo=; b=GB3T7T2ugDAa2Fk1k1vEMJQ4qazXInshJG4vY99Rghzf
	XP06KZ2jrjneD36k+Min9vqc7weglKd5cHTYRDl5Kn2viNBGYIVUe5GU943+PJ8c
	iMfcZXy4pOrtxV+NoJMFBDFHZGbNWluFUS7StIvGg7p0Ak86i1nkjM3VmhGMMyf3
	kvDdVs5jqUbgLSfU88T0i35TAXGhasMwDEnVCeDg0Wt4NlWEDo35CjI9oBiGzlGQ
	SgsAPGaQlxTyMeNcVDSPq7Z2k39ldhVpQJZqO3SkAJ1Ipsp5IOCn7GlOksMFCKK5
	YnWmsmRBRdLsbbJzO+j96CWaONh6Jqu9TBDAb66Aeg==
X-ME-Sender: <xms:xyO7ZoHAw2jRXuyKX3YaYxQGDheO3-x0uZh-rfH3C-0ylmdqB1T1fA>
    <xme:xyO7ZhX5Lhe4cFVsuTGivqEeZWSb3vvoEDCXOWJLBkfjkZ8JG5iMhySwzc5nCYCDe
    3c09xKOdoc8rgd9Aw>
X-ME-Received: <xmr:xyO7ZiJEhd-oHivtgcjkDJcqNuPyl18EfbuUMrMXnqAMb6nINJvIl-wDFL1JVxR6Wdi5qtN3lDO-dfxYKp-bMnpVM3L1Z_azDNtGRHRUMlWreA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xyO7ZqH6L3c2aacM4nnXE9noyRi1BlJ1M7CvIgidsKrC3auncs79UA>
    <xmx:xyO7ZuUgSsHnDsQyJCugEDuLQP77o2okC5S1cKc1fNmi9YntLlJwnQ>
    <xmx:xyO7ZtNbIFCZ3jpTp2Xe_0N4SeVDAXO3GX5ZhO5GX4bTX95qltB_Gg>
    <xmx:xyO7Zl08aENUKmPtsLzqMlT4yyaMGm9lth-4uhIQMLbMi5uQLphIBA>
    <xmx:xyO7ZtRIW6XpIMItEWXlZasdyIELyQhAZKEr-0wuTIDKZSmj-0z1ilMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 134c8217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:25 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/20] path: hide functions using `the_repository` by
 default
Message-ID: <1b6651770a7aab0885222ad3425918635648e8ac.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

The path subsystem provides a bunch of legacy functions that compute
paths relative to the "gitdir" and "commondir" directories of the global
`the_repository` variable. Use of those functions is discouraged, and it
is easy to miss the implicit dependency on `the_repository` that calls
to those functions may cause.

With `USE_THE_REPOSITORY_VARIABLE`, we have recently introduced a tool
that allows us to get rid of such functions over time. With this macro,
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
index 2949261193..a3bf25b7de 100644
--- a/path.c
+++ b/path.c
@@ -2,8 +2,6 @@
  * Utilities for paths and pathnames
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
@@ -30,7 +28,7 @@ static int get_st_mode_bits(const char *path, int *mode)
 	return 0;
 }
 
-static struct strbuf *get_pathname(void)
+struct strbuf *get_pathname(void)
 {
 	static struct strbuf pathname_array[4] = {
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
@@ -453,44 +451,6 @@ void strbuf_repo_git_path(struct strbuf *sb,
 	va_end(args);
 }
 
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
-	struct strbuf *pathname = get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
-char *git_pathdup(const char *fmt, ...)
-{
-	struct strbuf path = STRBUF_INIT;
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, &path, fmt, args);
-	va_end(args);
-	return strbuf_detach(&path, NULL);
-}
-
 char *mkpathdup(const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -634,16 +594,6 @@ void repo_common_pathv(const struct repository *repo,
 	strbuf_cleanup_path(sb);
 }
 
-const char *git_common_path(const char *fmt, ...)
-{
-	struct strbuf *pathname = get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	repo_common_pathv(the_repository, pathname, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
 void strbuf_git_common_path(struct strbuf *sb,
 			    const struct repository *repo,
 			    const char *fmt, ...)
diff --git a/path.h b/path.h
index 78e9230de9..e91d19fff6 100644
--- a/path.h
+++ b/path.h
@@ -25,7 +25,7 @@ char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
- * The `git_common_path` family of functions will construct a path into a
+ * The `strbuf_git_common_path` family of functions will construct a path into a
  * repository's common git directory, which is shared by all worktrees.
  */
 
@@ -43,14 +43,7 @@ void repo_common_pathv(const struct repository *repo,
 		       va_list args);
 
 /*
- * Return a statically allocated path into the main repository's
- * (the_repository) common git directory.
- */
-const char *git_common_path(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-
-/*
- * The `git_path` family of functions will construct a path into a repository's
+ * The `repo_git_path` family of functions will construct a path into a repository's
  * git directory.
  *
  * These functions will perform adjustments to the resultant path to account
@@ -87,14 +80,7 @@ void strbuf_repo_git_path(struct strbuf *sb,
 	__attribute__((format (printf, 3, 4)));
 
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
  * worktree instead of current one. When no worktree is given, then the path is
  * computed relative to main worktree of the given repository.
  */
@@ -103,27 +89,6 @@ const char *worktree_git_path(struct repository *r,
 			      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
-/*
- * Return a path into the main repository's (the_repository) git directory.
- */
-char *git_pathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-
-/*
- * Construct a path into the main repository's (the_repository) git directory
- * and place it in the provided buffer `buf`, the contents of the buffer will
- * be overridden.
- */
-char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
-/*
- * Construct a path into the main repository's (the_repository) git directory
- * and append it to the provided buffer `sb`.
- */
-void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
 /*
  * Return a path into the worktree of repository `repo`.
  *
@@ -165,19 +130,10 @@ void report_linked_checkout_garbage(struct repository *r);
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
-			ret = git_pathdup(filename); \
-		return ret; \
-	}
-
 #define REPO_GIT_PATH_FUNC(var, filename) \
 	const char *git_path_##var(struct repository *r) \
 	{ \
@@ -261,4 +217,99 @@ char *xdg_cache_home(const char *filename);
  */
 void safe_create_dir(const char *dir, int share);
 
+/*
+ * Do not use this function. It is only exported to other subsystems until we
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
+	struct strbuf *pathname = get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	repo_common_pathv(the_repository, pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+/*
+ * Construct a path into the main repository's (the_repository) git directory
+ * and place it in the provided buffer `buf`, the contents of the buffer will
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
+ * Construct a path into the main repository's (the_repository) git directory
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
+	struct strbuf *pathname = get_pathname();
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
+			ret = git_pathdup(filename); \
+		return ret; \
+	}
+
+/*
+ * Return a path into the main repository's (the_repository) git directory.
+ */
+__attribute__((format (printf, 1, 2)))
+static inline char *git_pathdup(const char *fmt, ...)
+{
+	struct strbuf path = STRBUF_INIT;
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
-- 
2.46.0.46.g406f326d27.dirty

