Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026E3C277C
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559214; cv=none; b=AFiY7zv/599R+G3vCTZ2uEnk76yVNQwdZ6YfdfbP0i6HnHH3+etxmxB2EyvU9isNcRBPZbpMCi84Ap2IsRMhduZIPh/zBRwcDDsJ9+Jgl8NXq2nnIkza7yDnyx4cuPvgatfiVTExqUedYq+73QDPCp26NuN7UO/9gYKbnhKsOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559214; c=relaxed/simple;
	bh=M6ocefZ+IRQoGdXB64v4TwJcAGNKbWe/5DhDI5YCzt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBqv+oqVxNgihS00lAAJ1LFA/ugkAHxF6L4kXjr6JfLj0TcPbnxwdBgcYBYXG2K+YZrD6zwEFX6pUN3i4sSxAvutWot0Ok0neae+jEf4LSSuHkQHBR9ldg/wrc5VoLD7CtT/5qOWeNtNzDDkgMeOZfyFscCYrOCTO8og0H6fC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ul/ocgVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZB++Wn/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ul/ocgVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZB++Wn/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 46CFFEC00AD;
	Thu,  4 Jun 2026 03:46:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 03:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559212;
	 x=1780645612; bh=2in64cUbjGfz8vq4VTVrEoMHRvW6fbfgTHH1NXWTYAU=; b=
	Ul/ocgVsRyE4xWl0mjRLVWd/adZWibDPb2EIcRJffrxLL/fV887y2LDlR9zQN3U9
	j6aNIdTtbfDOP4oG/uBeoISZFzProqJYe5bvTIjUN0Yk+q+ESGU8pajraJX0AhTS
	QIcS71pMHlZvLHKjs2ilpQ+NskOF1UR62l19tXor/9aKb1ylUF4NIEJ1Rm30xmQq
	0NhEmfyzUCFhzo5IS8D6o4ZaUvXHyi8qN5WCPmBgrFsGkgZqb+qhMTj4GgJ02PC1
	LxkvI8JuatVegEKjAV++srrjAk1sWqDS71981vPyB1KZ64WFC/2GwsGfEDq6Wl3p
	RMaMh4mdBJpPmIS678kKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559212; x=
	1780645612; bh=2in64cUbjGfz8vq4VTVrEoMHRvW6fbfgTHH1NXWTYAU=; b=B
	ZB++Wn//wS0Ez/X3eK50eyZ7bMhbutI/tBxCNO3HGJBUaNHlpdze/RQaffAhnKxC
	VKvyBQXQQlPDEcDN63iHHz0GkQDsEEBQni/rAapz4C8Uv1QH2atLyf0pa6VEE73r
	17GDdhTOAZjOjktRJj5x51o9Bo0tAbMzVCsv3IEp537wB62296WVU+p2N/O7aTIf
	/aAbxQY41PDB3wj2I4ZOm1pNWTq6NH9wF59Ud/c+D2rojbhsJRHCjBMtBb6mxIV+
	WzL31ofTvjjCDDWduyVGTxjAHUuwP4m2pzYLEHaZIX0MvShS6t0TbGR09gBb+xv4
	GjRHnz5vouip4N0KK/KnQ==
X-ME-Sender: <xms:bC0havFHRZrlJI_XFddjm24OMZp_6tudNYO0bGnxTK70HDvVOH78XQ>
    <xme:bC0hajXofKGEa9UyR9U3Xm4RLETnhrPrGzFb8BA5_LreCmu7FtBU0l1j11x-cXXQ5
    Es-eo692jve1akKED85PAH3Cs_wlbg4RRtBY_pu8-vZTxriA8iQ>
X-ME-Received: <xmr:bC0hamKKlG9x3N-3qYTYzYetuRMMW6mzaRkeZUg6NtQi2SHiun3U2c9xaq6A-F0w2ju435kds4wb6q3l-awXvQUiwazOrEWuzVGuu3-Jmek>
X-ME-Proxy-Cause: dmFkZTGJdfwkBibmM1hMgBwy3nPAsh3VywSM985xAHj9jS/xYlliOxNIYsnXe07wDadb2H
    MuU05aRBY6ly0cCLrmA4afVI3FIUG3Gv5DiWyBhOOSYXebrnugEbykTF0uJwcnLHnVlQpa
    1NxIXKB5sfgRkeIn58uSAjmRTNG7p1ygmRQVnyEhFj7oc2EnASMywSDLdlW5zkrAGfS/fj
    08egvlL7JbEWkj2wlU51dM6rODxUTxPpKUE4dF3w/w7g75HZMYqUj4u72XlWlQcNUwMgep
    lrzF9/KfIu+e8V/BnbCisf7Qv0jcHMfU9eSM61Jpz3BwjxRgGEUpPaJhM8vg2pQH4IdpOQ
    +HW88HXiGusv+hny7cuTox3QHNVgfSJvO28eMXAiDk48YUPdj2TMSCTMET5wOxbLybv1L8
    WQ9O1En8LmFis3iIJUffGpvuGhkh3Zy+bJ+HyYUvqKtMnoeNGZLRFvkV/b+nBvi80Tx2oO
    9GlumRGBY6bgQ6uxKU2hdXOmXl9Dedz0e0VBVEemJlmhBlSW5eT4c1Ujofp/CQDi+lntGQ
    bKGIPXodBDRbqJJdyvOcRubsgqDBv3wfpdN7vTYw1tIzvh4H6+9bDKZxNmpkDgkqfPDLyN
    Ivj5b4NOS8eZ/eDu4S8wtYvsGE7gunG+vAUEhvHrNEN1/zvp2f6xCbRjmDhA
X-ME-Proxy: <xmx:bC0har8FC15KC8RppWqBlSh4GrBf3toKjX387x1tp-OwhuBkE2HnEw>
    <xmx:bC0hahJCMI2TOxt34Lekdktz8ezyD3x32nbAXN9lIITPOZeD8HfGkA>
    <xmx:bC0haombFkxq7aaR-pUzkrfnvKzpLEu-DFgU2iQxCOaVJsfqPJxIFw>
    <xmx:bC0hatNilG1h__E4uS84uMGJZIhjNhEURIuP4pFKqJr9xyDaVenibw>
    <xmx:bC0hahq_xdEBRo_pQgr7xJBnxteAncj1Hb7yKMa2csnQrBSq8ps-5Wgp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e712c740 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:29 +0200
Subject: [PATCH v3 5/8] setup: stop creating the object database in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-5-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commit we have stopped creating the object database in
`repo_set_gitdir()`. But the logic is still somewhat confusing as we
still end up creating it conditionally in `setup_git_dir()`, which is
called multiple times.

Drop the conditional logic and instead create the object database in all
places where we have discovered and configured a repository.

This leads to even more duplication than we already had in the preceding
commit, but an alert reader may notice that we now (almost) always call
`odb_new()` directly before having called `apply_repository_format()`.
The only exception to this is `setup_git_directory_gently()`, where we
also call the function when _not_ applying the repository format. This
will be fixed in the next commit, and once that's done we can then unify
creation of the object database into `apply_repository_format()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index 3bd3f6c592..0dc9fe4565 100644
--- a/setup.c
+++ b/setup.c
@@ -1035,8 +1035,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 }
 
 static void setup_git_env_internal(struct repository *repo,
-				   const char *git_dir,
-				   bool skip_initializing_odb)
+				   const char *git_dir)
 {
 	char *git_replace_ref_base;
 	const char *shallow_file;
@@ -1053,10 +1052,6 @@ static void setup_git_env_internal(struct repository *repo,
 	repo_set_gitdir(repo, git_dir, &args);
 	strvec_clear(&to_free);
 
-	if (!skip_initializing_odb)
-		repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		disable_replace_refs();
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
@@ -1072,10 +1067,10 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
+static void set_git_dir_1(struct repository *repo, const char *path)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env_internal(repo, path, skip_initializing_odb);
+	setup_git_env_internal(repo, path);
 }
 
 static void update_relative_gitdir(const char *name UNUSED,
@@ -1089,7 +1084,7 @@ static void update_relative_gitdir(const char *name UNUSED,
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
-	set_git_dir_1(repo, path, true);
+	set_git_dir_1(repo, path);
 	free(path);
 }
 
@@ -1102,7 +1097,7 @@ static void set_git_dir(struct repository *repo, const char *path, int make_real
 		path = realpath.buf;
 	}
 
-	set_git_dir_1(repo, path, false);
+	set_git_dir_1(repo, path);
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, update_relative_gitdir, repo);
 
@@ -1879,8 +1874,15 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct strvec to_free = STRVEC_INIT;
+
 		set_git_dir(repo, ".", 0);
+		repo->objects = odb_new(repo,
+					getenv_safe(&to_free, DB_ENVIRONMENT),
+					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
 		check_and_apply_repository_format(repo, NULL);
+
+		strvec_clear(&to_free);
 		return path;
 	}
 
@@ -2032,13 +2034,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
+		struct strvec to_free = STRVEC_INIT;
+
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env_internal(repo, gitdir, false);
+			setup_git_env_internal(repo, gitdir);
 		}
 
+		repo->objects = odb_new(repo,
+					getenv_safe(&to_free, DB_ENVIRONMENT),
+					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
+
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
@@ -2048,6 +2056,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			clear_repository_format(&repo_fmt);
 			strbuf_release(&err);
 		}
+
+		strvec_clear(&to_free);
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -2796,6 +2806,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strvec to_free = STRVEC_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2816,6 +2827,9 @@ int init_db(struct repository *repo,
 	}
 	startup_info->have_repository = 1;
 
+	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
+				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
+
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
@@ -2879,6 +2893,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strvec_clear(&to_free);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.54.0.1064.gd145956f57.dirty

