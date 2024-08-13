Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955E18A6C0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540422; cv=none; b=Fnh+S2egaJE94Z21nuJNotQHxh9SAvrIocljMnWkXtKqwWk2XLsJo1calQYhmau5LxrMPyf+sOZuCsbDlkH/RNcmrqR5fO9MHCBCf2A5bvofT9+pT9Y0wFtgPi6dPUteqUYU/sKhC7LA5rdU1WB/MdfsFmzzGgG0wEPo6Ym0KP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540422; c=relaxed/simple;
	bh=M+ZKxNr5ofnKSWwEJNiSXjol015LbiXpd5HI46Ws0QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrnHdT8sL8jKQTErNh4GXQ4f30QEtgWuVK5xc4z4oXLA4PoCskJjv2cFUvVfDV/jgNhqoP5kcppIjAnkOm7vTO+5FPkXDdg3QfbAsszLFhnnTIEHFif523iwFEv9NW6EcNhgTKTBArA7kHw6XYVY+tuOCB+Tj4+F0mqG0VRg90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NSA/1+Q9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBjRrPHW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NSA/1+Q9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBjRrPHW"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 157BF1151A82;
	Tue, 13 Aug 2024 05:13:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 05:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540420; x=1723626820; bh=JA5jc1lzBj
	vq3S5BD5yvn+9eWYGwMjNkNfCW6b3mI+4=; b=NSA/1+Q920OHuBcpYZEEJqHN9l
	bLNDfiFC/xBhFGNmmyh/QHARgoTIelkypAmZNsbrb5AhPO84Nn6t2tzJr7JVQVUk
	/FZjgAs0K8yduz7r1eBMYRdvLGnNgT57seXjOhpFL3Ag5sdIxjGWbqDHrjturQCA
	VEP40WvTdWF6v5doG6HlQy1jOFil1tE7j+A88BDG2F9LzvPPCbOumiPU5KsUr3+N
	e4lesBtpDEUKhvc52Y6CVLXnNne3Ee3FAAHlxrfu1QEikJS41n6RpkBIY0hWT9uT
	4Vtc815nu5erUhoCAzDKvlQc/w0XXzC19m+MNfVws+2xxsqN4lH8F/3yLGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540420; x=1723626820; bh=JA5jc1lzBjvq3S5BD5yvn+9eWYGw
	MjNkNfCW6b3mI+4=; b=tBjRrPHWdg9zqTT09ARbKOHhR/8ZBN7vp+WsqYu4yWsv
	nFlD474cnoK333UzAo1ZkTsmdAsECCH2Q5c4uP1Xpd0jp8GPClma87tYNFJyaYVo
	yzNfD6lTk6qmLeQk9i32Xi09cTcFylKqyClopFP4JstITB7VVg7nkUCRMlvuwb6w
	2gbQWc3/COv9RTE0GpnEUqdER8bkk+CU9LjfIU79AmWQxzvONkcSe5h14+wPaADX
	HLt02fCCJQuuBF8Car+0pe4lnkU8JHDtMnTCM3KH0j23vA1mdGB4DGtIgEVdAap4
	xrV+KT4GfyHacnBjfBXtfl1HyqiXFaYrjfrZSzYM1A==
X-ME-Sender: <xms:wyO7ZqTRItTzW_v9KfF93050eSarVBxghe0mzw90zMibv5Rm0Hdb0A>
    <xme:wyO7Zvy2Ul6RTJly7mNbiDRIYQobBo0VjBlzGRMLpOnDxSq0CUt8iR1pKFqljVldd
    6We0bZ3hm91qHolpA>
X-ME-Received: <xmr:wyO7Zn2pTqnwoDt85E02heCIWVEDWFqkxR5ZOC4RstZynk7f5SZwtlBUQRJ12oh-QzoI13cx75e4woBWKYZD8G5TcqkvwC2lAYxqjTM_TZklVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wyO7ZmDk46xP9rOeAD5uerXlWlQNjLeJzfg_WHwFBESKimPiaAAxNw>
    <xmx:xCO7ZjhB-mDFxWIlMMs26eS3ySvj4QqN5KLdyx98Xnwcbyq10S_4hg>
    <xmx:xCO7ZiqxrFFsS5VhUXda28na4-1W9yF8nsWOl4EhE9BNlRB78QtA2A>
    <xmx:xCO7Zmi8CB8t4-izUkJXbiu5bBawqIx1HQJ1yunnXyAeIWskULLgpA>
    <xmx:xCO7ZgtSBmDWZujfktN4Jmj1UDpcSQw2HwrYJW7YCmfDbTYhUxRGdKeS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c188fe45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:22 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/20] path: stop relying on `the_repository` in
 `worktree_git_path()`
Message-ID: <29302f4b14c29323bd85f25e0585c5383e7303e0.1723540226.git.ps@pks.im>
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

When not provided a worktree, then `worktree_git_path()` will fall back
to returning a path relative to the main repository. In this case, we
implicitly rely on `the_repository` to derive the path. Remove this
dependency by passing a `struct repository` as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c     |  2 +-
 builtin/worktree.c |  4 ++--
 path.c             |  9 +++++++--
 path.h             |  8 +++++---
 revision.c         |  2 +-
 worktree.c         |  2 +-
 wt-status.c        | 14 +++++++-------
 7 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..ad36df9628 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1050,7 +1050,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			 * and may get overwritten by other calls
 			 * while we're examining the index.
 			 */
-			path = xstrdup(worktree_git_path(wt, "index"));
+			path = xstrdup(worktree_git_path(the_repository, wt, "index"));
 			read_index_from(&istate, path, get_worktree_git_dir(wt));
 			fsck_index(&istate, path, wt->is_current);
 			discard_index(&istate);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a4b7f24e1e..eb0a386992 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1146,14 +1146,14 @@ static void validate_no_submodules(const struct worktree *wt)
 	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
-	if (is_directory(worktree_git_path(wt, "modules"))) {
+	if (is_directory(worktree_git_path(the_repository, wt, "modules"))) {
 		/*
 		 * There could be false positives, e.g. the "modules"
 		 * directory exists but is empty. But it's a rare case and
 		 * this simpler check is probably good enough for now.
 		 */
 		found_submodules = 1;
-	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
+	} else if (read_index_from(&istate, worktree_git_path(the_repository, wt, "index"),
 				   get_worktree_git_dir(wt)) > 0) {
 		for (i = 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce = istate.cache[i];
diff --git a/path.c b/path.c
index 97a07fafc7..2949261193 100644
--- a/path.c
+++ b/path.c
@@ -512,12 +512,17 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
 
-const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
+const char *worktree_git_path(struct repository *r,
+			      const struct worktree *wt, const char *fmt, ...)
 {
 	struct strbuf *pathname = get_pathname();
 	va_list args;
+
+	if (wt && wt->repo != r)
+		BUG("worktree not connected to expected repository");
+
 	va_start(args, fmt);
-	repo_git_pathv(the_repository, wt, pathname, fmt, args);
+	repo_git_pathv(r, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
diff --git a/path.h b/path.h
index 9a4a4a8fb3..78e9230de9 100644
--- a/path.h
+++ b/path.h
@@ -95,11 +95,13 @@ const char *git_path(const char *fmt, ...)
 
 /*
  * Similar to git_path() but can produce paths for a specified
- * worktree instead of current one
+ * worktree instead of current one. When no worktree is given, then the path is
+ * computed relative to main worktree of the given repository.
  */
-const char *worktree_git_path(const struct worktree *wt,
+const char *worktree_git_path(struct repository *r,
+			      const struct worktree *wt,
 			      const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+	__attribute__((format (printf, 3, 4)));
 
 /*
  * Return a path into the main repository's (the_repository) git directory.
diff --git a/revision.c b/revision.c
index 1c0192f522..0b92a13af5 100644
--- a/revision.c
+++ b/revision.c
@@ -1872,7 +1872,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 			continue; /* current index already taken care of */
 
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
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+		strbuf_addstr(&path, worktree_git_path(the_repository, wt, "locked"));
 		if (file_exists(path.buf)) {
 			struct strbuf lock_reason = STRBUF_INIT;
 			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
diff --git a/wt-status.c b/wt-status.c
index b778eef989..b477239039 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1618,7 +1618,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
 	struct object_id oid;
 	const char *branch_name;
 
-	if (strbuf_read_file(&sb, worktree_git_path(wt, "%s", path), 0) <= 0)
+	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
 		goto got_nothing;
 
 	while (sb.len && sb.buf[sb.len - 1] == '\n')
@@ -1716,18 +1716,18 @@ int wt_status_check_rebase(const struct worktree *wt,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(wt, "rebase-apply"), &st)) {
-		if (!stat(worktree_git_path(wt, "rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
-			if (!stat(worktree_git_path(wt, "rebase-apply/patch"), &st) && !st.st_size)
+			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
 				state->am_empty_patch = 1;
 		} else {
 			state->rebase_in_progress = 1;
 			state->branch = get_branch(wt, "rebase-apply/head-name");
 			state->onto = get_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
@@ -1743,7 +1743,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(wt, "BISECT_START");
 		return 1;
-- 
2.46.0.46.g406f326d27.dirty

