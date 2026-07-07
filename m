Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6737647E
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408921; cv=none; b=h1vKODwcbHxcylptm/oInjx19POyvl1wnxdujb0N9saw9OEG7CmS8oEiFFbAVg6fmxNujPfWi76ebuNiFzgH5XYQ+CfbCXrtLy3eRK6gmB+wjCUj8W+erZWS+jtwY56Cd3fO05bq3850fCcqbAmr6AN7mSlfzm+lfsI8KmL9DxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408921; c=relaxed/simple;
	bh=jSZs+vyQB+ArUta1zOGfggR+JtCZHAx8SubC+6C7pfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thL4OUPLfB0+T/NX1+IupZ2FJkn1WbvH++pGRAnDF+rtwhhwVsbx8yqsCLS9j+O+rA4UqwTFwfnsqEKWaSHdOIu5JxJuZDTKkJDoNMAzJr+BAEQvr4Ei6raOIEjUa515k6E+Dec13/Y0n6TA81DUID/JVweNe+zBRuYL3DdXbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cVcn3jlL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtEVZB2X; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cVcn3jlL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtEVZB2X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A56A47A012C;
	Tue,  7 Jul 2026 03:21:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408908;
	 x=1783495308; bh=HnutYJEO2jY79OuItkFfKI41PMne8aK/XMJHz8lD8Js=; b=
	cVcn3jlL90mspbaMB7Pw3O2zWryTIoYD5nA/YAe7+RWhZJZcTHRc3FcFz2lVxSW2
	NM0sVBD1EIbS9PXxMN/CIfV5v/zzORd4tjSkHA0/TXTkdH5BJL+YXi7RKhUSFSZz
	aujudBSPk0Bj4thW9VLPSsstS/zxHXi90HScRRG0k0doaWXqGvTG3NKPoAZn49dD
	qICFVmSr71hTss7SMyNyCEtmwNVcRx3ARa26J5oTMFaNka4yI4OYEhm5ynz9xgA8
	XE6Pz1BltpxFEdBIlDml/Y69Zxwx2ObxNJGPoaGqOzGCpXZxxoDmncp5c5x4ysXY
	TG/pSnQwWEJYEJb8tSU8ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408908; x=
	1783495308; bh=HnutYJEO2jY79OuItkFfKI41PMne8aK/XMJHz8lD8Js=; b=A
	tEVZB2XzWsY1LZ9tToGzPqvXsCoK2VC85kgsfwLAQZ2o2MAcJZ4RM4GV8yA3iOra
	X7lV93kz5VnXi+Aom/tPmlMsdiWpn+PJQBYQWEvAQhld3geR7u8oC4p+DT1JwSa3
	c6bttf/YCJYZYXMch8aDzCLaHPuvqd440JLcMfUAydkSd+eGzk9WTm5XgditPZ00
	nKKL1x0qYB22kyrg79qrCSj1mXxsRx8aikTpgjl7bWq9I6W/T08Un2Wdn4tEqD6k
	SQQp4rBvrGBQv5KLSTMn3tB8UwRbPRQh5du6FBvX6ckF9UpZ1YqSlluw3fMIWCr6
	Awsv+paUpRUcS3DPziB9Q==
X-ME-Sender: <xms:DKlMaomc-aIEdCIHDtLkL_htU94VE2l4nBD7EhMpnElTnGJTXEOGiw>
    <xme:DKlMavSzCHVl-xuEbJnr7yePAegsP-fmxdANFeB7NYJIYz8I1nlgiB4iEHHgU4Qvg
    0ayUQnVrwCMa8gjNCUN5dR0_yTuyoo7T2v_LFow2z9lrt3QhlXypA>
X-ME-Received: <xmr:DKlMakDfz1c7HWumG6E2DvwWbyXVMMSv91K9KmIdGUs52I-rA_F_4zsApLNkNZxhymBR0yeBKK7qOXJrTRSHqThzN3rycXGw-QMD2POk3g>
X-ME-Proxy-Cause: dmFkZTF9s1z+R9IDFklBRl7h9GjFLDJ03cHkKgKpbIKlsEzraDKIRmHnCjNpIBHFaoa6yB
    8VUMsHz4gLB39bLxUA9y0k9QvCt+TAdxb4jLt3bqM6YVhX8COg1a0oMDaNsxRozyNzKMSh
    WF3bX6QCD2fDFJT7zh5jFCEYktMMg8SyP2bX8T8UEwiRMeS8hDARJim3Uy/lQ2TUVjBXpW
    dHuqY6+bjO4ZMCmiI7lwz4eTCJqG+g7dSGfb69Js90GWGqbIYAiupNiOKizKmPo+RWSIX5
    9dnMRohxlan4Qb+w0ZbrgqtSZzBv9fT1Sv5yBO2K2J1V+p+ZDgj72gUUbncVQN0AW6mQAs
    3JtPLGrBkJwN1pdkB41r08laoW4DgtcKQ9XfLou15G7q924/0JDLJcCv5e0f3iNzEvZ7ST
    xK4aVjf62qCM0yUGT81Syzi90HLizvQpet9NLhWouhCmMaXMU/8oizRIsVBeVmGJV3wVaG
    WuiJTvIzrJOKL2GtDsRhJG6cR6rvot+FlMwitDpthQeU/JwLnelZwanIHTNRpzu2YLCuwy
    SmMDGQKOLaAls4clN7bSFQNO+0OTifZ11CrIPfiCO16FOKH3oPO8ewMHMkn1appIu1GmPP
    j1W5qKjhxxVOZpjg4uUR4H7LGSDvJIEt8vvXgRc//ZNPSZs+nHb5Era/v84Q
X-ME-Proxy: <xmx:DKlMauQR4F1pz9R64Nid7i8zJicq5LG_amfIQPaWLUiChtLQQwLi0Q>
    <xmx:DKlMaqrxC-k_cCSPKDJPFwNcx2ceCk_MjADyJWURz9HCqnfht28sVw>
    <xmx:DKlMaowifjRivxENQIPInX5FLArOqoDCciD770Q9i4QAxD6fyJnwjQ>
    <xmx:DKlManKHoVsHGZBvX0oUOG1chniTN_6RzUxiz3pm9lj7z-Y59tRTdA>
    <xmx:DKlMajRXLxEntJkJIroaqjz40MOHAY5ZmHmmt5jB5NWWPPbw0O5tLB5a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2f6ca41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:26 +0200
Subject: [PATCH v2 07/13] setup: move prefix into repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-7-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index b755693572..6cc9fa2de8 100644
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
2.55.0.141.g00534a21ce.dirty

