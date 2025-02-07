Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9B1E261F
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926227; cv=none; b=osa8PYHaGDQbjKI0VlxTE7xf7aPQ2Hh/sQNhfVgyEOKuAoQVZvDLSIzXkK63/vI4mXU6v7j59KfDui1+2LxzEDd2tg2Yh3ROtdbrrtRO/gFm31t90+Gpujb8hbajsWUwkkjGZpR7zrTt8bqM4G1C38ykkig9W3Rgu4nj/M5/LJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926227; c=relaxed/simple;
	bh=o7ZL/cOym6SoWdjN73Sroae/6Uyag9GaeRT3/KvL0oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIZ0apYrtUP/53GJAvOIp2io6T5A+YNtNW12YG7XDQhtRlzVZl5x2syIr6FOrpXfLShf5LrTeFWZ2IPZ2osQO14604CIOuBsNMbsKwtt7g1mofPTq0aSF/YEPEZ9N0GacVEpGfQb7T0kDwFbIlP49AHLCyVssJ9rPsDQDFO1R8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ybt+TGkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gr2pcmjf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ybt+TGkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gr2pcmjf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AB591380111;
	Fri,  7 Feb 2025 06:03:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 06:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926224;
	 x=1739012624; bh=y96CuWjTevZPiNqjaDTOqA+vn/A/7ouIlg6XDn9PRIs=; b=
	Ybt+TGkpIzqfcKtZE3J9O+YyNf4gEE542gUYXXxcv8QduN2p8F+7JffnxnNvyu3L
	B6FnWWr5Of4MgMrIs9DkhP4xElejDfaL8sEM4+GyPynTJfO6pycDW4NeeqrRDuDO
	m95o6ckkNn1x3VQpBKEllwQ3NgvsGztrNSXfaa/bXzxcZCrYeMzqL7dawfXrefSl
	pOnIIFIkMl6Osd0xT0hAXN3Om8iSGvrCX5s/wttzP8o/Nfy+tayCBR8YhKzbh5Vy
	62UyzZG1j2xsWI0oDLQZ9zS/QqSwJ+gBnmX8hff03yl4Nw9thSAae30l9fDucAVi
	dPpEIv9e89V4S2ROIIVNXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926224; x=
	1739012624; bh=y96CuWjTevZPiNqjaDTOqA+vn/A/7ouIlg6XDn9PRIs=; b=g
	r2pcmjfEuBJKUSlIQxuzDx0LviefgAbGMl1dYbYhPSm4OxRbpRiBDLKQiRtf5sBl
	NVVbiVSEHrDrHY5qK70uZsZpMg+Rf0AxG1bqUiviugYITbGQfUaQLYjGyC47WJCN
	kaCC4VS6Y6XPoRdnzN+VE6oV9lPhHFcB+6hVouvmHiY6pavU90jZ011r6RdAndjd
	t1cCAvc4bt/6g8rKALG7Ij8NkWwwtPp2xtYxj/tBPHAL+THpsGCP/NwiFioiA2eg
	O6STB2cXnyP8c/KYrgUAB6KhcwPvH8dwg4XolPlk/qEBqJM/Ac119nXivityz6nR
	+LTbyDjOrXxJytOJUN0uA==
X-ME-Sender: <xms:kOilZxNfVo3IUzr_FbgcjPs0iUJxTKRS7Y4ZFRngEO0dB6MP7E7Cpg>
    <xme:kOilZz-pqy6XQ1K9WxVlTKAu7HFWOR0QD3-2lUtz_VHU1X12plRJj_3F2pB0HwG4l
    tvSJmUBD9mmKx1HXA>
X-ME-Received: <xmr:kOilZwQCmridNNveHIqLpxV5RGpEf6vjlunW1_l6xOOj-u9BX9322jWh3N_WlGi-L-XSphIJVITw_dwVKpVZF5CdjqLaKDEjfTK7h66ThhzzFgdn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepgfduleeutdegteffgefhgeekjeehtdelfeefgefg
    feelfedugfetffegleeuvdevnecuffhomhgrihhnpeifrghrnhgrmhgsihhguhhouhhsrh
    gvfhhsrdhinhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kOilZ9vf9Y9L7AZF8AxZkDQUT2-8mDjh4o4azkF-3kmr-K5KkNvunQ>
    <xmx:kOilZ5fW9rYqd5tHqVDFr2n_t0in9qAUBrq8_8xGTsyZxWwlNG6sXA>
    <xmx:kOilZ52k__G-gMpzRTwJOuyarr4Hd0sOuh1oFjTGWYWzLgN6EUGMnw>
    <xmx:kOilZ1-2FxGw6BOHxWMkzVoA0dY5t6HMAAckcaeiRd0W5sNMaoZOsg>
    <xmx:kOilZ94giyxw6xgPv36n0Fzbdorid2ODnRFCE4bNhlZByMeAtz4iCpF0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42e196a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:39 +0100
Subject: [PATCH v2 14/16] environment: move access to "core.hooksPath" into
 repo settings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-14-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

The "core.hooksPath" setting is stored in a global variable and
populated via the `git_default_core_config`. This may cause issues in
the case where one is handling multiple different repositories in a
single process with different values for that config key, as we may or
may not see the correct value in that case. Furthermore, global state
blocks our path towards libification.

Refactor the code so that we instead store the value in `struct
repo_settings`. The value is computed as-needed and cached. The result
should be functionally the same as there aren't ever any code paths
where we'd execute hooks outside the context of a repository.

Note that this requires us to change the passed-in repository in the
`repo_git_path()` family of functions to be non-constant, as we call
`adjust_git_path()` there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c        |  5 -----
 environment.c   |  1 -
 environment.h   |  1 -
 path.c          | 15 ++++++++-------
 path.h          |  6 +++---
 repo-settings.c |  8 ++++++++
 repo-settings.h |  4 ++++
 7 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index 50f2d17b39..d932d4b134 100644
--- a/config.c
+++ b/config.c
@@ -1436,11 +1436,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return git_config_pathname(&git_attributes_file, var, value);
 	}
 
-	if (!strcmp(var, "core.hookspath")) {
-		FREE_AND_NULL(git_hooks_path);
-		return git_config_pathname(&git_hooks_path, var, value);
-	}
-
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 8389a27270..39755873ee 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
 char *git_attributes_file;
-char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
diff --git a/environment.h b/environment.h
index 2f43340f0b..66989afbac 100644
--- a/environment.h
+++ b/environment.h
@@ -160,7 +160,6 @@ extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern char *git_attributes_file;
-extern char *git_hooks_path;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
diff --git a/path.c b/path.c
index a42f72800d..e81ebd3b5c 100644
--- a/path.c
+++ b/path.c
@@ -387,10 +387,11 @@ void report_linked_checkout_garbage(struct repository *r)
 	strbuf_release(&sb);
 }
 
-static void adjust_git_path(const struct repository *repo,
+static void adjust_git_path(struct repository *repo,
 			    struct strbuf *buf, int git_dir_len)
 {
 	const char *base = buf->buf + git_dir_len;
+
 	if (is_dir_file(base, "info", "grafts"))
 		strbuf_splice(buf, 0, buf->len,
 			      repo->graft_file, strlen(repo->graft_file));
@@ -399,8 +400,8 @@ static void adjust_git_path(const struct repository *repo,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, repo->objects->odb->path);
-	else if (git_hooks_path && dir_prefix(base, "hooks"))
-		replace_dir(buf, git_dir_len + 5, git_hooks_path);
+	else if (repo_settings_get_hooks_path(repo) && dir_prefix(base, "hooks"))
+		replace_dir(buf, git_dir_len + 5, repo_settings_get_hooks_path(repo));
 	else if (repo->different_commondir)
 		update_common_dir(buf, git_dir_len, repo->commondir);
 }
@@ -417,7 +418,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
 }
 
-static void repo_git_pathv(const struct repository *repo,
+static void repo_git_pathv(struct repository *repo,
 			   const struct worktree *wt, struct strbuf *buf,
 			   const char *fmt, va_list args)
 {
@@ -432,7 +433,7 @@ static void repo_git_pathv(const struct repository *repo,
 	strbuf_cleanup_path(buf);
 }
 
-char *repo_git_path(const struct repository *repo,
+char *repo_git_path(struct repository *repo,
 		    const char *fmt, ...)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -443,7 +444,7 @@ char *repo_git_path(const struct repository *repo,
 	return strbuf_detach(&path, NULL);
 }
 
-const char *repo_git_path_append(const struct repository *repo,
+const char *repo_git_path_append(struct repository *repo,
 				 struct strbuf *sb,
 				 const char *fmt, ...)
 {
@@ -454,7 +455,7 @@ const char *repo_git_path_append(const struct repository *repo,
 	return sb->buf;
 }
 
-const char *repo_git_path_replace(const struct repository *repo,
+const char *repo_git_path_replace(struct repository *repo,
 				  struct strbuf *sb,
 				  const char *fmt, ...)
 {
diff --git a/path.h b/path.h
index f28d5a7ca9..373404dd9d 100644
--- a/path.h
+++ b/path.h
@@ -52,14 +52,14 @@ const char *repo_common_path_replace(const struct repository *repo,
  * For an exhaustive list of the adjustments made look at `common_list` and
  * `adjust_git_path` in path.c.
  */
-char *repo_git_path(const struct repository *repo,
+char *repo_git_path(struct repository *repo,
 		    const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-const char *repo_git_path_append(const struct repository *repo,
+const char *repo_git_path_append(struct repository *repo,
 				 struct strbuf *sb,
 				 const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
-const char *repo_git_path_replace(const struct repository *repo,
+const char *repo_git_path_replace(struct repository *repo,
 				  struct strbuf *sb,
 				  const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
diff --git a/repo-settings.c b/repo-settings.c
index 719cd7c85c..876d527581 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -146,6 +146,7 @@ void repo_settings_clear(struct repository *r)
 {
 	struct repo_settings empty = REPO_SETTINGS_INIT;
 	FREE_AND_NULL(r->settings.fsmonitor);
+	FREE_AND_NULL(r->settings.hooks_path);
 	r->settings = empty;
 }
 
@@ -173,3 +174,10 @@ int repo_settings_get_warn_ambiguous_refs(struct repository *repo)
 			      &repo->settings.warn_ambiguous_refs, 1);
 	return repo->settings.warn_ambiguous_refs;
 }
+
+const char *repo_settings_get_hooks_path(struct repository *repo)
+{
+	if (!repo->settings.hooks_path)
+		repo_config_get_pathname(repo, "core.hookspath", &repo->settings.hooks_path);
+	return repo->settings.hooks_path;
+}
diff --git a/repo-settings.h b/repo-settings.h
index c4f7e3bd8a..0cef970443 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -61,6 +61,8 @@ struct repo_settings {
 	size_t delta_base_cache_limit;
 	size_t packed_git_window_size;
 	size_t packed_git_limit;
+
+	char *hooks_path;
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
@@ -79,5 +81,7 @@ void repo_settings_clear(struct repository *r);
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
 /* Read the value for "core.warnAmbiguousRefs". */
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
+/* Read the value for "core.hooksPath". */
+const char *repo_settings_get_hooks_path(struct repository *repo);
 
 #endif /* REPO_SETTINGS_H */

-- 
2.48.1.538.gc4cfc42d60.dirty

