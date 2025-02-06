Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907A226166
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828699; cv=none; b=CnX5YbcM9PD3FGTrpPktwl189VbI73TkFJUjq8M6F8+ztTUOBQcBgvsyDbxztU/9MEOZa1dtkWeU3SOLLPixe2MNWbCZvbet8nb74cfCei4JN94H3RF94FOAJbef0XbjLUdR23nCZdRNVmqlvxlte/YjDr0zkuiDNWWitfHZAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828699; c=relaxed/simple;
	bh=nXT86/vnyyOWX3CUd25wYr1N6Cs6vWY+VdOBOPrpFnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfCCi1T0ssESJjgktJdks/Mt/CZBKsuZhdhiEudh42drcdLJtVWnHcnKKpMXCZq3EiBw+nj5b6DY2j3pJoamfcW7IEKz9vo/wJDTSeLBT8LcJzCt6PgT/2++yfzW4Hh6GJiZ3AoN5FDVCFiB5MLyk6bXGd/8csAQ5wcMWzvLCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qxq7Lqp1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJ7Ei/dP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qxq7Lqp1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJ7Ei/dP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EEF31380209
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Feb 2025 02:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828696;
	 x=1738915096; bh=P4o+WYOxICNVhiOo2r0qufs3RgQVc2PSfN18VIIX3yI=; b=
	qxq7Lqp1CmLlFLUgcin8gjq0bOlWrSfpDH5a4ygJEVrex7a7exnzHZAfeDQhPUkt
	ul2blYjX8+0hwY/KkLodAHIAHxlTCCxx1+/tuTXpIn20G30eQ63ScLEu62F/TVHS
	FGo0WGQpKU6jcELu1dEv1ZaN9OebSHiCedgwl2YnyJcsGrdMjxYO//NMk3jb+N49
	j5yAL+LfdtLfWM1SNViCUbBFlvKaL+0i/3Edg0S0N1dY3riqo4BM2detJsOESx1C
	xNBT7xnRFsJyucmgpOeFCuqidZ18nqBI0I8GmvqGkHYvzxWWot8YvviiWKLg82Kn
	iQLQN4p7EJN36ONS2zK/yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828696; x=
	1738915096; bh=P4o+WYOxICNVhiOo2r0qufs3RgQVc2PSfN18VIIX3yI=; b=m
	J7Ei/dPIHD75DW/Zu5it65ZxMih3HBOr4soVm1GaImjvHxQLixr080YPJE6aywii
	ZOEpTwSD4US4RZFBFRYC8JkPklb5iMAeTq5d5sw7LpoOvCMC80QChnpmwns0iGLB
	TUSGn5vK9uL2lkXCqgUhJ05C/mWgR4JhDiY4tEUgh17YE/rbCHJjmij6vc15xk8o
	6vswP3y8SQ+1/n/e9lTW+x9zKg+xyDXN6tRXHvxgtfxyNnEP4VcCYAkaCeG0ly7k
	5FAqt+gQEvBs9mPLwNrilKKwc5knNLlemBSuI9nDXvLGvthWs9z4xcE0duykfVVj
	OFKiA8k42Sktptxc6m1lA==
X-ME-Sender: <xms:mGukZ-_W0mGaJrsNeTeIv9Vg8lnVPkxCVw1vuvddnGhpgTU1Gf7lWg>
    <xme:mGukZ-tZKsIm73du8EhvZh6she6rItlAoiz3zncF5iYiYLn2OWTRSQuMeDanymstO
    dqnMoxX055myvoyiA>
X-ME-Received: <xmr:mGukZ0DD1V4TZc69g0Zaq1etdf_WGP4B74A7E67m-8MDDyHEXzJ3ygEeCGm5ycwBSv2651zfwRRNbhTz3dMb9IEo2Cj_KcwrziW_4pKECGOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhi
    dqqdetfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthej
    redtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhsse
    hpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgfduleeutdegteffgefhgeekjeehtdel
    feefgefgfeelfedugfetffegleeuvdevnecuffhomhgrihhnpeifrghrnhgrmhgsihhguh
    houhhsrhgvfhhsrdhinhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mGukZ2cOUzJdtjZXXVNByKUonxxRmzwDcgYOkXf1o4iGXMuN69ztcQ>
    <xmx:mGukZzNwheF-IY4eIenVSPbJRxhk8addEN5VeKbTZjWbaMpaMUf6dw>
    <xmx:mGukZwk0iRIrMj2O5kTIUKdcjHsLF30mzHauQx11kSHAqldVLHldlA>
    <xmx:mGukZ1vPFGLvNzHtRDHgyGQIQVua809zb1KDiA42d2W34Sg6cTZy0g>
    <xmx:mGukZ53f4DsMLSWjTjtP8HmCElAKnA9dgOdicdZfihiMgI55XwDaznRK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66778919 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:10 +0100
Subject: [PATCH 14/16] environment: move access to "core.hooksPath" into
 repo settings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-14-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c        | 5 -----
 environment.c   | 1 -
 environment.h   | 1 -
 path.c          | 7 ++++---
 repo-settings.c | 8 ++++++++
 repo-settings.h | 4 ++++
 6 files changed, 16 insertions(+), 10 deletions(-)

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
index ddfc901661..e81ebd3b5c 100644
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

