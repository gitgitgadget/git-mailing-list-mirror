Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DB3C13F5
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408901; cv=none; b=uqSrAWSPZywayc767uxnGR2LFgz2uZ323aLOrlS8zrFBiCM59K1gto7l7KZPR/gkU+dJo4V8rjf1p9h1gforSDVA3qeHccF9Lv0E/qYO2RNYUYWy05WV9ytwwqNMLH+f8Ra8LMBqKG88u3Gpfst6TYSehAm33ZwkX0H7hMrw4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408901; c=relaxed/simple;
	bh=EqaVj+s1JSt4qoUx717kH2+RQpqEyb1AkcuV2GMUHT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEqq88cOIYLSOTTRQslxC8yEV+QycaHLGepJUpMSGrjBozVWPtxaXQr/D0yllJrYbISIevg9tMeQtsDJc6Ys9doD5dOTQxOy0CMcJ+M6deZbOXfGTRKhqIOJZc2PIOgFsHSON2IB5zebuyOA9YsNcODCbpegoeBIlYdOMXstrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZuCoJlVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nydwriFd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZuCoJlVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nydwriFd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 263157A01AA;
	Tue,  7 Jul 2026 03:21:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 03:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408893;
	 x=1783495293; bh=J5nDwCXDpgxYNtdym2ERlGIlXRZA9kn3K2txfCJC890=; b=
	ZuCoJlVLQYa/PZjVbjm6as0MWMePQkVrRuj9B5r59sh6nbaXQ0Y7ZUWuUcJUf/+5
	R9vJkgF6jE8ft1uL8YLK/f/7+vudKw5NMGAe2eXo8w54sFv52RlJuKKAFY//4PQM
	w42XajWsHkNqDBC5uvCEKUA0a93ImfZHi7mJwGbx765Aw4Jzb9noKdFqsE70fWJs
	PN2eMjxRCnM8Cfc/gINQMRIOSOfAUQD9XU5AbqtAhgzjqQ3m8bqmx/Z1ctN+6RAi
	/5SYKxA7HmrmxbZwneynfwD2IvrSI4LIVLmwutJ2FqyPoOBfm55tprt2YfryO+Na
	xyPe+jSGCxvkc9rvq7k9FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408893; x=
	1783495293; bh=J5nDwCXDpgxYNtdym2ERlGIlXRZA9kn3K2txfCJC890=; b=n
	ydwriFdjvKU3gXzXOaW9Syfob1M4yeLz2l4CM04Ueq+qZFmCkHui81B/bTSQzewy
	H12T2Rh3+mwZMDepQ7FeeDF2DEcJ/i1P6sCc4HgQCi80Yf3zjhczAGOXih8NnUWR
	hkPkM6JbZfeoEkdAQlmFykGmE4WCidQo5B9ouMfeaeTf1o+ECoOXqb4hMJ6EePi0
	aya+IJfaL2WLVdggu1+06E6tdMhuJ14F2eBT9zOZUkPIpnJSIkdbE9sVCQGjxRw8
	iyBOunGw83X7YBpml7kKnj7Bw2a3GizDQY9ZLeF7T4QM3BLoKo2PpGgjwwwegWXw
	wzvyhK/pKCPKpN5VUORRA==
X-ME-Sender: <xms:_KhMakheP3aZMdIjtQwV-nw1sd-NYqBhEOAgB3dxXSkQXOfU5Vj6nw>
    <xme:_KhMakfM4VNXhpHmNhBsQbS0Be2fF4ph6CsFazvLVGCOD1HPNE_jw0JdQyoSVBzVx
    xEemnTFmtUhfXTnInP1Rsslh-nDjCdCmltewjg6Wp0Muw06_DoO>
X-ME-Received: <xmr:_KhMapfMnaya-RodzZKTU93fXEjrR0wlGL4nbrmw1lSV9R6VcoitkwVnhOTvnQpUizcP9_bWBKiZ6BsKd3U2Svw4Oq7VEkBNmXX_9Xsgww>
X-ME-Proxy-Cause: dmFkZTGAyfwDroKZieLnOSPugQnCDQn14Mmdt+3EK+/ESXAYfd1wI6Uk7u9qvA9t7LMY/I
    M05ShRmMN32YsM8ymhZ/gvlsp+/MrOY1dlkNg3iz1JLS4Mzu6tjPLsankE3BzkkDsA/4D1
    Rk3uCd7YloGMMrWbesWbGxgUQ4oijeptd8CziEzopMeRsibT0viLIL9afP4G69Uegwis52
    tAglxxzy6NVpHBQFKG9bl/FzZn6Ss67m3skr9mzNYx9FkUnQqH6SOards66DP/Bg2IYXVj
    OsSQ84uUwrmecWzn0xHXoxi4xuqQXdPKjRtawcEW390ufFox8a8XOVBcaILZY1knLHzhab
    wpMgaRFmRCTslveBspHe8CYA8fP4XT+CvfDNR0A2TOdaBMMm8ts6R+7qMEqs4IEfNSute2
    Oj0/GQ2C9ZGQxsjOgWho+OKjZLPz8hTbr/GVqUt0fVy4q/PYsAkX6bHHZzfOkl0uD5y/QJ
    epQ35OujHgUQpO54/yCbmpWwCGZOqVlN2KtczCDeaF1KTr7g1ox5SQ5P0o5C7Zi1srIEvZ
    yefCXyxAcpmkQzqjRwfNlBPgXkDTBW1UpyqNJEytcfV63LGNnKMSWrg3CaBJBskJF5AyFv
    VqNi6f0IdLmjI+oP7VDHOjgQS9ZNrZ1sqr2+X8jkI03mDmZPyfK8XhGIfDzg
X-ME-Proxy: <xmx:_KhMau9J_ro55MYRbQjp1wTcPYl6eqrATNIADYDLuU6_ohG4OjJshw>
    <xmx:_KhMalmwZ-mZeBHLqv-9j7e7BeE2ahFx6aJSWZuN7dRgvjL9ZjDxgw>
    <xmx:_KhMag-NM1TNj5PfHvz3cPndF787XUNmEYHBQ2ipIpMUcNDrlCowUg>
    <xmx:_KhMajmTVaTkun3Cq8MfA7TSnAj4ccug31q1gg59qY92OeNfERveAA>
    <xmx:_ahMakf1B3_DTXMAFpSfmbB9WuELR1GX8n8GudPdGB7THT_sbLtmQVWZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e473cb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:20 +0200
Subject: [PATCH v2 01/13] setup: rename `check_repository_format_gently()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-1-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `check_repository_format_gently()` receives a format as
input. An unknowing reader may thus suspect that this function actually
checks the passed-in format for consistency. While the function indeed
checks the repository format, it actually serves two purposes:

  - It reads the repository's format and populates the passed-in format
    with that information.

  - It then indeed checks whether the format is consistent.

Rename the function to `read_and_verify_repository_format()` to clarify
its functionality. While at it, reorder the parameters so that the
format comes first to better match other functions that pass around the
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/setup.c b/setup.c
index 951ab9eedb..118416e350 100644
--- a/setup.c
+++ b/setup.c
@@ -749,9 +749,9 @@ static int check_repo_format(const char *var, const char *value,
 	return read_worktree_config(var, value, ctx, vdata);
 }
 
-static int check_repository_format_gently(const char *gitdir,
-					  struct repository_format *candidate,
-					  int *nongit_ok)
+static int read_and_verify_repository_format(struct repository_format *format,
+					     const char *gitdir,
+					     int *nongit_ok)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -759,7 +759,7 @@ static int check_repository_format_gently(const char *gitdir,
 
 	has_common = get_common_dir(&sb, gitdir);
 	strbuf_addstr(&sb, "/config");
-	read_repository_format(candidate, sb.buf);
+	read_repository_format(format, sb.buf);
 	strbuf_release(&sb);
 
 	/*
@@ -767,10 +767,10 @@ static int check_repository_format_gently(const char *gitdir,
 	 * we treat a missing config as a silent "ok", even when nongit_ok
 	 * is unset.
 	 */
-	if (candidate->version < 0)
+	if (format->version < 0)
 		return 0;
 
-	if (verify_repository_format(candidate, &err) < 0) {
+	if (verify_repository_format(format, &err) < 0) {
 		if (nongit_ok) {
 			warning("%s", err.buf);
 			strbuf_release(&err);
@@ -780,37 +780,37 @@ static int check_repository_format_gently(const char *gitdir,
 		die("%s", err.buf);
 	}
 
-	string_list_clear(&candidate->unknown_extensions, 0);
-	string_list_clear(&candidate->v1_only_extensions, 0);
+	string_list_clear(&format->unknown_extensions, 0);
+	string_list_clear(&format->v1_only_extensions, 0);
 
-	if (candidate->worktree_config) {
+	if (format->worktree_config) {
 		/*
 		 * pick up core.bare and core.worktree from per-worktree
 		 * config if present
 		 */
 		strbuf_addf(&sb, "%s/config.worktree", gitdir);
-		git_config_from_file(read_worktree_config, sb.buf, candidate);
+		git_config_from_file(read_worktree_config, sb.buf, format);
 		strbuf_release(&sb);
 		has_common = 0;
 	}
 
 	if (startup_info->force_bare_repository) {
-		candidate->is_bare = 1;
-		FREE_AND_NULL(candidate->work_tree);
+		format->is_bare = 1;
+		FREE_AND_NULL(format->work_tree);
 	} else if (has_common) {
 		/*
 		 * When sharing a common dir with another repository (e.g. a
 		 * linked worktree), do not let this repository's config
 		 * dictate bareness; it is inherited from the main worktree.
 		 */
-		candidate->is_bare = -1;
+		format->is_bare = -1;
 
 		/*
 		 * Furthermore, "core.worktree" is supposed to be ignored when
 		 * we have a commondir configured, unless it comes from the
 		 * per-worktree configuration.
 		 */
-		FREE_AND_NULL(candidate->work_tree);
+		FREE_AND_NULL(format->work_tree);
 	}
 
 	return 0;
@@ -1141,7 +1141,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
+	if (read_and_verify_repository_format(repo_fmt, gitdirenv, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -1218,7 +1218,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
+	if (read_and_verify_repository_format(repo_fmt, gitdir, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -1266,7 +1266,7 @@ static const char *setup_bare_git_dir(struct repository *repo,
 {
 	int root_len;
 
-	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
+	if (read_and_verify_repository_format(repo_fmt, ".", nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
@@ -1874,7 +1874,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		struct strbuf err = STRBUF_INIT;
 
 		set_git_dir(repo, ".", 0);
-		check_repository_format_gently(".", &fmt, NULL);
+		read_and_verify_repository_format(&fmt, ".", NULL);
 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 			die("%s", err.buf);
 		startup_info->have_repository = 1;
@@ -2836,7 +2836,7 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);

-- 
2.55.0.141.g00534a21ce.dirty

