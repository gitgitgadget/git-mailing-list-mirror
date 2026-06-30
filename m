Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC274071D9
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820095; cv=none; b=PZAEaBfbU+weNlYcu7sGHkuDk5ZrU3Mxt51sML3hYCftOxiGFGXT7678vFod1Hb/zCzuaATo5AGsaLJVRLi4IzHWRWTrHQf8IH9305Sp1s3hj/xH6ufHzWikae96kKXDFma+anq4kJa0kPFAhDgUDoU278PU/Qj98/XnMqOkRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820095; c=relaxed/simple;
	bh=CLHZ+Wk6MsLO1pvWa3Ce58EFO7Guw28iEkLVBiQC3Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXAj9g1TUru02et6F4iyxW4EhthEn0iFV6KN47y8IpdioQ0bA9To9MItPPT13hCVXmMk0AKWehaD4VJCVvI1Nt9uqa+iUx0/qxBccHTCyLBSWlGKuyxn5E6M4M11c8MmuCaV5TXInf+h069vKVMw8uqNl+aN/UElmetJ+rEM3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q0j0YGiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ey63WWUC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q0j0YGiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ey63WWUC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 086AD7A002F
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Jun 2026 07:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820092;
	 x=1782906492; bh=oQFrpR7e4MV0EDk6gGMj++xbQP9wP310j63hVlN+UzU=; b=
	Q0j0YGiK7ID4yne6V+Bl+XSJ3tmAMyKeNQ8YsTfyGIdcqWvNxWMLjSpxyriugyrd
	qa0H0Zgl9ehluULS/nPMx8MuC5lqKMkRT5BKhxDMNFHpzI0pwmPQPdDsHOPlsLuJ
	M5w7Sz1OEdasrsMmmNJq+nsiVNsh7Rwof9UfLDhkgnRe95OPgf+9z+n+aUgi9j85
	m7E5GEcJ/UE0wF6Ub/sQDcimy2M+P50vjnmIJs9LJXlWQSjlVzCgu87ueYBat6q1
	COMEN70xDao3jSPg5g2VHy+yuI0Wc3upXQq5P3wv8ihjImk4j8IQuIa9wqISKXlE
	MXPVEp0NZF+bN0t9hgbeYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820092; x=
	1782906492; bh=oQFrpR7e4MV0EDk6gGMj++xbQP9wP310j63hVlN+UzU=; b=E
	y63WWUC8BzwM7WPErX8CkV1x7qGlXMLYU9B0P06kCFnTUAkDnCW3AluMpRU2ab7A
	3sCqtIEMUDHk0yiCIrlmGxgZlDC6cN1MHO2TexmTjO6bdx/+5I3KDVieK3uhVHn8
	qc6RjbO366Fg/h0WEx0443txGF+zYOUf2rLg9aGZCU+EVHY2dTJEAX39hghb2SxR
	3HcOK/y7qXfQ3tylxVjWmnOBJQvRCsfUJZAH8cslP+EESxPF6nyGIFRYnDzeRZ9K
	S84GM02jku4LemYyuK0vfJ1UqNRc+qB/pAl2/3xYw2CC6PoPo5RMGXJT9Au3svOX
	7835XGb682iDwg+f6+yNA==
X-ME-Sender: <xms:_KxDapF9yP_HIaeyFcnm_hi6VVMPON9YsRuUqbbd-bI6FHkENy9Juw>
    <xme:_KxDalTReS-poe_yt99VIiONvJIHdfORNrIbW2dbfMgzaep-R33cxdmiDeThFnKh0
    ORHZJ4-1aIt4WRhz7g50EJUn_DUAvwmLok9mag3uBqPefrsT7aK>
X-ME-Received: <xmr:_KxDagwEgvZj_6qtCMwCcZWUizh5XjXUSF2nl5_VTT7LnXeWyKW15G5LZeLKp9pu2yb38ay52AmnxCu_2AfaCA2yDwmGPDEXcYcuOCLsgZB-BA>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2JqpDC
    eNun4nc1Dpp96E5G9aQpm+Rc4NZrurawHm2ENrtLoIfJ5SpI9j/kgDmd3WnovAghbKS8+i
    KmezKbB+GZik0FbWasTlIB6VjXsXKysGuL4OE0fnorXL7AAEZkrQnTHrsqocx2FzMt1iU8
    /St8YaCd0Zkxw/Ii187I/6QmFu4PKes7egV1JKRg1Jr4bHSqBveS7y5O2Uz0PKMhIzGPsE
    NsXkUGuSNtFj/oLNMS2HiQ6YHmzoCWyYIxnXg57HvqEoQGJPJWuvRMtzedH4j3ZW5gOmVV
    YCQf2JNGNzX/8VvJXtQ/1iX1iiDxJm5+46rfJEvh226PgkefEGwBcJVqUqzQ
X-ME-Proxy: <xmx:_KxDakMChFBp1-D8BxaC_h09KX3cCalbp_gfdNbmOgKsMt54UWXX8w>
    <xmx:_KxDavMdJrNbSjE7LepCM1gMrd3jCPd7vu0FC_30oKDqBZvcTUNYHw>
    <xmx:_KxDamT_0Z3_UaA5p9Ygm7eA9VJSSyH4YHw6pK58AvbkFJ1_tkckOQ>
    <xmx:_KxDahCfDBU6RMuGuxAV9G_jTuGgLv-7RUKluLn-BI010Z03XREBZQ>
    <xmx:_KxDanVo2QGu3HCfVHFgJhKNOvJAeNazRjWyH6eqBPneRbRyOGiF_M-b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a20a7cd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:46 +0200
Subject: [PATCH 07/13] setup: move prefix into repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-7-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The repository prefix is currently stored in the startup info. This
feels somewhat awkward though, as it is inherently a property of a given
repository.

Move the prefix into the repository accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repo.c         | 8 ++++----
 builtin/rev-parse.c    | 5 +++--
 builtin/update-index.c | 4 ++--
 object-name.c          | 4 ++--
 repository.c           | 1 +
 repository.h           | 8 ++++++++
 setup.c                | 6 +++---
 setup.h                | 1 -
 trace.c                | 4 ++--
 9 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 042d6de558..84e012f83f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -84,7 +84,7 @@ static int get_path_commondir_absolute(struct repository *repo, struct strbuf *b
 	if (!common_dir)
 		return error(_("unable to get common directory"));
 
-	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	format_path(buf, common_dir, repo->prefix, PATH_FORMAT_CANONICAL);
 	return 0;
 }
 
@@ -95,7 +95,7 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	if (!common_dir)
 		return error(_("unable to get common directory"));
 
-	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	format_path(buf, common_dir, repo->prefix, PATH_FORMAT_RELATIVE);
 	return 0;
 }
 
@@ -106,7 +106,7 @@ static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 	if (!git_dir)
 		return error(_("unable to get git directory"));
 
-	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	format_path(buf, git_dir, repo->prefix, PATH_FORMAT_CANONICAL);
 	return 0;
 }
 
@@ -117,7 +117,7 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	if (!git_dir)
 		return error(_("unable to get git directory"));
 
-	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	format_path(buf, git_dir, repo->prefix, PATH_FORMAT_RELATIVE);
 	return 0;
 }
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 5e04b0e2bd..43693454d5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -255,7 +255,7 @@ static int show_file(const char *arg, int output_prefix)
 	show_default();
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
 		if (output_prefix) {
-			const char *prefix = startup_info->prefix;
+			const char *prefix = the_repository->prefix;
 			char *fname = prefix_filename(prefix, arg);
 			show(fname);
 			free(fname);
@@ -832,7 +832,8 @@ int cmd_rev_parse(int argc,
 				prefix = argv[++i];
 				if (!prefix)
 					die(_("--prefix requires an argument"));
-				startup_info->prefix = prefix;
+				FREE_AND_NULL(the_repository->prefix);
+				the_repository->prefix = xstrdup(prefix);
 				output_prefix = 1;
 				continue;
 			}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3d6646c318..f43d150eb3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -875,7 +875,7 @@ static enum parse_opt_result unresolve_callback(
 	const char *arg, int unset)
 {
 	int *has_errors = opt->value;
-	const char *prefix = startup_info->prefix;
+	const char *prefix = the_repository->prefix;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -896,7 +896,7 @@ static enum parse_opt_result reupdate_callback(
 	const char *arg, int unset)
 {
 	int *has_errors = opt->value;
-	const char *prefix = startup_info->prefix;
+	const char *prefix = the_repository->prefix;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
diff --git a/object-name.c b/object-name.c
index 46159466ac..fc70acc9e0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1708,8 +1708,8 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 		die(_("relative path syntax can't be used outside working tree"));
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
-	return prefix_path(the_repository, startup_info->prefix,
-			   startup_info->prefix ? strlen(startup_info->prefix) : 0,
+	return prefix_path(the_repository, the_repository->prefix,
+			   the_repository->prefix ? strlen(the_repository->prefix) : 0,
 			   rel);
 }
 
diff --git a/repository.c b/repository.c
index 73d80bcffd..2ef0778846 100644
--- a/repository.c
+++ b/repository.c
@@ -376,6 +376,7 @@ void repo_clear(struct repository *repo)
 
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
+	FREE_AND_NULL(repo->prefix);
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
diff --git a/repository.h b/repository.h
index 7d649e32e7..b767307911 100644
--- a/repository.h
+++ b/repository.h
@@ -52,6 +52,14 @@ struct repository {
 	 */
 	char *commondir;
 
+	/*
+	 * The "prefix", a path to the current working directory relative to
+	 * the work tree root, or NULL, if the current working directory is not
+	 * a strict subdirectory of the work tree root. The prefix always ends
+	 * with a '/' character.
+	 */
+	char *prefix;
+
 	/*
 	 * Holds any information related to accessing the raw object content.
 	 */
diff --git a/setup.c b/setup.c
index 0185257b2c..fc88ea2dbd 100644
--- a/setup.c
+++ b/setup.c
@@ -2030,7 +2030,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	 * repository and that the caller expects startup_info to reflect
 	 * this.
 	 *
-	 * Regardless of the state of nongit_ok, startup_info->prefix and
+	 * Regardless of the state of nongit_ok, the_repository->prefix and
 	 * the GIT_PREFIX environment variable must always match. For details
 	 * see Documentation/config/alias.adoc.
 	 */
@@ -2105,10 +2105,10 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	 */
 	if (prefix) {
 		prefix = precompose_string_if_needed(prefix);
-		startup_info->prefix = prefix;
+		repo->prefix = xstrdup(prefix);
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 	} else {
-		startup_info->prefix = NULL;
+		FREE_AND_NULL(repo->prefix);
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
diff --git a/setup.h b/setup.h
index b9fd96bea6..c01a244fe9 100644
--- a/setup.h
+++ b/setup.h
@@ -299,7 +299,6 @@ struct startup_info {
 	bool force_bare_repository;
 
 	int have_repository;
-	const char *prefix;
 	const char *original_cwd;
 };
 extern struct startup_info *startup_info;
diff --git a/trace.c b/trace.c
index 9b99460db8..515b99e7f5 100644
--- a/trace.c
+++ b/trace.c
@@ -299,7 +299,7 @@ static const char *quote_crnl(const char *path)
 
 void trace_repo_setup(struct repository *r)
 {
-	const char *git_work_tree, *prefix = startup_info->prefix;
+	const char *git_work_tree, *prefix = r->prefix;
 	char *cwd;
 
 	if (!trace_want(&trace_setup_key))
@@ -310,7 +310,7 @@ void trace_repo_setup(struct repository *r)
 	if (!(git_work_tree = repo_get_work_tree(r)))
 		git_work_tree = "(null)";
 
-	if (!startup_info->prefix)
+	if (!r->prefix)
 		prefix = "(null)";
 
 	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(repo_get_git_dir(r)));

-- 
2.55.0.795.g602f6c329a.dirty

