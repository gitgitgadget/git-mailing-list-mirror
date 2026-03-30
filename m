Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD13D5678
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876706; cv=none; b=NW8/oG1hxEvhbro81lO7nvnux50fI1WjNlp3xJP7lr6JUn14VYDxGgEJvgMOyoq1ezC71RkScNjriEpIUwt4ep0Zz4d0n4jrJTJgVU3KFe1Q+IcWKSz7SG8xyr2ljUv5Dx875JMhPSJKR6v19/uB/iTO6eU+NYWHMFRzIr9vPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876706; c=relaxed/simple;
	bh=4CP/FyfWaprbQ1yPeuQ+atFPDbTkerGmcq6Vfpr/BKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIEq3Wnyy7OCQERWgUIPkyhOnqFe5K3fn3YKoZJATp1bBfCDh4G1kpF7vWYjHO0KJNQvr97FCRVNHprk2iyi2I/VmPaJkJ4tub69Kv1tzFXZfoENnyoHo0qpFF64Mf1U13lMdDTCK6PEy4w2Q29wqbZvkCuM0TZPPrE33NvfE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8hYRatq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMUGt1wO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8hYRatq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMUGt1wO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81E747A00B6
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876704;
	 x=1774963104; bh=XbmrBWMxYiL65/TUKtuc6Cmh8gnCq33Y92akYCBw0lI=; b=
	I8hYRatq/2z8xUK9bXrU2ty8S63m/UCytTplb2qOA54uOlw9d32aYoJfmRaPvW/3
	XtISErzR5i0LmS21Kj/QcgrKlhSfANQsRn/Ury65Y5QLmMkuZFnG9IW7Yv39ObKd
	7JTf86J5k4lX/zSj0TU4hYQBdVJSe/2A7Xx4H23ak6vsA6dW8fWga7GN771BHJwL
	f8RBAr+lnkdCRoL1VZTcHuDe+Nsg5WWwGBx4FJJOiOnHHCCcqDWdRBHK3tF0vx8g
	MWDShX1fQkK3p3E9LddyQJ37dUEANnAZZoX3ZFredyZUL+LhdZsvTjuQXBa+tjpe
	4Ii0HkW915PxA0R+0rkRRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876704; x=
	1774963104; bh=XbmrBWMxYiL65/TUKtuc6Cmh8gnCq33Y92akYCBw0lI=; b=E
	MUGt1wOmw3de/VLWYsz58Ox7Sv1ZFuX/zxfgii0mqx8N3G8+7DdBLLjxFwPgMAx9
	yKzygfL5sfqMQRsB5NkdrhMm7QFR2E7o0BAgckNU5OYAJQGvB8AKzdKKsVluNNKA
	DVve8xTiZORWhAO57Oil7Jx+W+7wZ6GcMEgA5MScfJNijkpVzVsyeyiYxh2OULIe
	FUyqJIO6V/duy5jaLVjK31ip5GSAm1tI89sAVcXwC5WXJFTW4kKYalSkQW42wCda
	ogTBmlZV7jutioniXHGvmDGpznz7LpRSIrKbvRLwJM4TQCBSIwiE41ui+KELJt7B
	5w3FLCSlaPOchxjf8YoNA==
X-ME-Sender: <xms:IHjKaWZWQroHWwVZzHHu-ObG8h1QpiMDiV9E5EJ4QucliB4NGqT2Zg>
    <xme:IHjKaQWChqhjUzfnCl8iVhvxtw4dxTLP0-Ul6XLDbDoKoaRfP8ykGU0MlO1tp_uA_
    TimnjascAk9tEGnda-EqG3WXd2FIbgveqZgs1aBt1ne-XK8dIGfu4M>
X-ME-Received: <xmr:IHjKaWlF1EjY85EjJ2GTsqvtP1J2iVJOEZjxtRYlKYmq5tVW3ea0arxRE2o246vzK9bllgTWs47yyRU60mGdF_ofrjrj4pJ6E07h9DN1GlQy2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:IHjKadxk_yv-ewuvt2CHWgkI476k0_oCpl7vJYmw7XCWF8V0JRjlyQ>
    <xmx:IHjKaRiPUJQdrWYooWFTKZxaqT9Ovv3O1HHSG8OWBdWeHuIWrBM5cg>
    <xmx:IHjKaSVqpwIfFX2pHxng8bSxHlYMXCIBw2KInBvdLg_BoQ2vS8PE2g>
    <xmx:IHjKaT15wImpn6IRmV7Wjmo5zQJbctu11ULPt9qwJPiYRnQCy-7qGA>
    <xmx:IHjKaU6jRsDlHcDZvOTTqbh7NoaB8fYBY7xcf1V1O006LC-vSgECUr8J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 322c5229 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:37 +0200
Subject: [PATCH 15/18] setup: stop using `the_repository` in
 `check_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-15-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `check_repository_format()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Furthermore, the function is never used outside "setup.c". Drop its
declaration in "setup.h" and make it static. Note that this requires us
to reorder the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 58 +++++++++++++++++++++++++++++++++-------------------------
 setup.h | 10 ----------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/setup.c b/setup.c
index 6dbd096f20..c32d6e96bb 100644
--- a/setup.c
+++ b/setup.c
@@ -1755,6 +1755,37 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+/*
+ * Check the repository format version in the path found in repo_get_git_dir(the_repository),
+ * and die if it is a version we don't understand. Generally one would
+ * set_git_dir() before calling this, and use it only for "are we in a valid
+ * repo?".
+ *
+ * If successful and fmt is not NULL, fill fmt with data.
+ */
+static void check_repository_format(struct repository *repo, struct repository_format *fmt)
+{
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	if (!fmt)
+		fmt = &repo_fmt;
+	check_repository_format_gently(repo, repo_get_git_dir(repo), fmt, NULL);
+	startup_info->have_repository = 1;
+	repo_set_hash_algo(repo, fmt->hash_algo);
+	repo_set_compat_hash_algo(repo, fmt->compat_hash_algo);
+	repo_set_ref_storage_format(repo,
+				    fmt->ref_storage_format,
+				    fmt->ref_storage_payload);
+	repo->repository_format_worktree_config =
+		fmt->worktree_config;
+	repo->repository_format_submodule_path_cfg =
+		fmt->submodule_path_cfg;
+	repo->repository_format_relative_worktrees =
+		fmt->relative_worktrees;
+	repo->repository_format_partial_clone =
+		xstrdup_or_null(fmt->partial_clone);
+	clear_repository_format(&repo_fmt);
+}
+
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1829,7 +1860,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 
 	if (is_git_directory(".")) {
 		set_git_dir(repo, ".", 0);
-		check_repository_format(NULL);
+		check_repository_format(repo, NULL);
 		return path;
 	}
 
@@ -2104,29 +2135,6 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-void check_repository_format(struct repository_format *fmt)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	if (!fmt)
-		fmt = &repo_fmt;
-	check_repository_format_gently(the_repository, repo_get_git_dir(the_repository), fmt, NULL);
-	startup_info->have_repository = 1;
-	repo_set_hash_algo(the_repository, fmt->hash_algo);
-	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
-	repo_set_ref_storage_format(the_repository,
-				    fmt->ref_storage_format,
-				    fmt->ref_storage_payload);
-	the_repository->repository_format_worktree_config =
-		fmt->worktree_config;
-	the_repository->repository_format_submodule_path_cfg =
-		fmt->submodule_path_cfg;
-	the_repository->repository_format_relative_worktrees =
-		fmt->relative_worktrees;
-	the_repository->repository_format_partial_clone =
-		xstrdup_or_null(fmt->partial_clone);
-	clear_repository_format(&repo_fmt);
-}
-
 /*
  * Returns the "prefix", a path to the current working directory
  * relative to the work tree root, or NULL, if the current working
@@ -2801,7 +2809,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(&repo_fmt);
+	check_repository_format(the_repository, &repo_fmt);
 
 	repository_format_configure(the_repository, &repo_fmt, hash, ref_storage_format);
 
diff --git a/setup.h b/setup.h
index b779661ce7..a820041af0 100644
--- a/setup.h
+++ b/setup.h
@@ -221,16 +221,6 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(the_repository),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-void check_repository_format(struct repository_format *fmt);
-
 const char *get_template_dir(const char *option_template);
 
 #define INIT_DB_QUIET      (1 << 0)

-- 
2.53.0.1185.g05d4b7b318.dirty

