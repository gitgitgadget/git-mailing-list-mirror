Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B3225768
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828691; cv=none; b=dooUV+vJli7x2Y1CLmlzdBxJDjsWW7e7ThCA8tyScLr9QBuRLxD07wYfeV27DeW+7B+tqf0eyDn3gPLJowHritYtK/Mc6DfktcW0l8THGIc0IRKVffPoBi73rp4s0VVVPvxNxSxzPHySZC/E4MKgcdsiYcLaTz91M8lq82/ANEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828691; c=relaxed/simple;
	bh=Jr/ETwD/d1hDLJVnZgHwN3oVyuDBNZQnLzBnoZVyGuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uraU/133SPDqmepvyK8DOZzK+HAffsRuxAsSiGTt0lWu64Ktqk1e50bh+gDJM2kD0hWph91PDruPd6IZ0bXesvbgSyWNzc0csEOvz5y5Ll2erHYD9zMi9tLPHWeaYdvvZEe6s3qyA3AOFnLFbPJWut1zKWE1H57ggKs8bCAE17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lVUsY+/r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u8NThxtu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lVUsY+/r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u8NThxtu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E720413801FF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Feb 2025 02:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828688;
	 x=1738915088; bh=ydLDb63ITkvy/u6IrVh2AiYb/V0H0gDcPZdjSztK2YE=; b=
	lVUsY+/rs8GDSzlK3bS54DCYgmjRL+mN4G/2/XtahuEEc17eNkI9zrYEhQNdjad/
	oN6c9V2t/05d28EZfF0672etxK2znhd5Cplb7CckIAmCAt2WdCjQpArzrGZo5PI/
	g8ClO3ZwWtt3DyUsBIqVORdkJmXmReOdPzYtn8mH17lnN0cbFAMiK5jxg1iQ5w2Q
	dgi9BFPSYAVRaX+m0rxu9PDprdbsaJBYuLzKL+fi+NTlfqOFiXUHLKn9+La/qK6b
	SzfMq1k4sZzI1JXK6A+aKZOGj/jFt95cqgJtQlqQ+/DsHhoBj0VZCDKy9Trm78vg
	uOe8/u3ztAxuYIdt5Wj4hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828688; x=
	1738915088; bh=ydLDb63ITkvy/u6IrVh2AiYb/V0H0gDcPZdjSztK2YE=; b=u
	8NThxtuo1z2Dy2WAVSYGJqoSSITt9aqjQ99imCbVrOGf6zEXJGPoPep2rzGYo5eL
	KJH3jt4Wii43FUhEb2KOY7/If1yq69tgacA5BaN5fIxilD2Bsu9+AHrYEQtnuu7v
	wffg3Io7k4jgnZTwPK6HrkibHaeYrPzNAPW8H5GDcHLq3nLx5891gZTfJ580ZFkK
	QuY2zeg09R5m4KrXDAtDaqBugS6MhpsF00tAH1u7MCWRwccNiysHnJFhKcUleCQe
	dANAOBtPfSD8mIrJzVIVsUb7frCJZpQy9OLeKNfy4+4kl/EwwD04NLsJxNn9C86G
	uGfzt2K5CBJ8dhfVKekog==
X-ME-Sender: <xms:kGukZwq9QZGfWsPl02k51yhAjbBA4usdM3WHt67VM4LNHwGcl_kbgA>
    <xme:kGukZ2qVAiL9oV3ovwhe0zSDnfp5AlY-xgEBc0kG8VVVqKK_CDpg9_a0yb0-X8tcN
    uOigJyJjEvkcysIhA>
X-ME-Received: <xmr:kGukZ1Myb27YViS-f_xDRMKRWWWzi2ZVBAcz2WeqwSs8MJ5usk_cDXWUcz16PjdvDqhrxfvtSCui-y0fJ-ojLwx7P6EqZhPz2HdHjstMppoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kGukZ35r9o_Lfq9ZkJo6NLZJEu5hk1dPzuYpO6gpd5UHmHM3cdJCyA>
    <xmx:kGukZ_686kjkic2vq8LoJdS3_b9yAlx1aw3e5H63gxhqP4yQCRaSdw>
    <xmx:kGukZ3hIzfBVwq1sQP9ICWQaUqMqAGru0-gUxFdquHvL1UkbY6V1HQ>
    <xmx:kGukZ548wUdnIobneCWAltMeReUQus9amcE8k9XPsz6JbWIrfbXgSw>
    <xmx:kGukZ5QoFIIThKRTxvdxWKl9vqHTjYNM_ff3Y7q790M10I9WQhmy35R_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ea9db48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:01 +0100
Subject: [PATCH 05/16] path: refactor `repo_submodule_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

As explained in an earlier commit, we're refactoring path-related
functions to provide a consistent interface for computing paths into the
commondir, gitdir and worktree. Refactor the "submodule" family of
functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c |  2 +-
 path.c                      | 37 +++++++++++++++++++++++++++++--------
 path.h                      | 30 ++++++++++++++++++------------
 t/helper/test-ref-store.c   |  7 +++----
 worktree.c                  |  3 ++-
 5 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3a64f7e605..c1a8029714 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1826,7 +1826,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 
 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
-	p = git_pathdup_submodule(clone_data_path, "config");
+	p = repo_submodule_path(the_repository, clone_data_path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), clone_data_path);
 
diff --git a/path.c b/path.c
index d918d0409e..d721507be8 100644
--- a/path.c
+++ b/path.c
@@ -560,14 +560,15 @@ const char *repo_worktree_path_replace(const struct repository *repo,
 }
 
 /* Returns 0 on success, negative on failure. */
-static int do_submodule_path(struct strbuf *buf, const char *path,
+static int do_submodule_path(struct repository *repo,
+			     struct strbuf *buf, const char *path,
 			     const char *fmt, va_list args)
 {
 	struct strbuf git_submodule_common_dir = STRBUF_INIT;
 	struct strbuf git_submodule_dir = STRBUF_INIT;
 	int ret;
 
-	ret = submodule_to_gitdir(the_repository, &git_submodule_dir, path);
+	ret = submodule_to_gitdir(repo, &git_submodule_dir, path);
 	if (ret)
 		goto cleanup;
 
@@ -586,13 +587,14 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
 	return ret;
 }
 
-char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+char *repo_submodule_path(struct repository *repo,
+			  const char *path, const char *fmt, ...)
 {
 	int err;
 	va_list args;
 	struct strbuf buf = STRBUF_INIT;
 	va_start(args, fmt);
-	err = do_submodule_path(&buf, path, fmt, args);
+	err = do_submodule_path(repo, &buf, path, fmt, args);
 	va_end(args);
 	if (err) {
 		strbuf_release(&buf);
@@ -601,16 +603,35 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	return strbuf_detach(&buf, NULL);
 }
 
-int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
-			      const char *fmt, ...)
+const char *repo_submodule_path_append(struct repository *repo,
+				       struct strbuf *buf,
+				       const char *path,
+				       const char *fmt, ...)
 {
 	int err;
 	va_list args;
 	va_start(args, fmt);
-	err = do_submodule_path(buf, path, fmt, args);
+	err = do_submodule_path(repo, buf, path, fmt, args);
 	va_end(args);
+	if (err)
+		return NULL;
+	return buf->buf;
+}
 
-	return err;
+const char *repo_submodule_path_replace(struct repository *repo,
+					struct strbuf *buf,
+					const char *path,
+					const char *fmt, ...)
+{
+	int err;
+	va_list args;
+	strbuf_reset(buf);
+	va_start(args, fmt);
+	err = do_submodule_path(repo, buf, path, fmt, args);
+	va_end(args);
+	if (err)
+		return NULL;
+	return buf->buf;
 }
 
 void repo_common_pathv(const struct repository *repo,
diff --git a/path.h b/path.h
index 8761c4c660..63a8f91947 100644
--- a/path.h
+++ b/path.h
@@ -93,20 +93,26 @@ const char *repo_worktree_path_replace(const struct repository *repo,
 	__attribute__((format (printf, 3, 4)));
 
 /*
- * Return a path into a submodule's git directory located at `path`.  `path`
- * must only reference a submodule of the main repository (the_repository).
- */
-char *git_pathdup_submodule(const char *path, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
-/*
- * Construct a path into a submodule's git directory located at `path` and
- * append it to the provided buffer `sb`.  `path` must only reference a
- * submodule of the main repository (the_repository).
+ * The `repo_submodule_path` family of functions will construct a path into a
+ * submodule's git directory located at `path`. `path` must be a submodule path
+ * as found in the index and must be part of the given repository.
+ *
+ * Returns a `NULL` pointer in case the submodule cannot be found.
  */
-int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
-				     const char *fmt, ...)
+char *repo_submodule_path(struct repository *repo,
+			  const char *path,
+			  const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
+const char *repo_submodule_path_append(struct repository *repo,
+				       struct strbuf *sb,
+				       const char *path,
+				       const char *fmt, ...)
+	__attribute__((format (printf, 4, 5)));
+const char *repo_submodule_path_replace(struct repository *repo,
+					struct strbuf *sb,
+					const char *path,
+					const char *fmt, ...)
+	__attribute__((format (printf, 4, 5)));
 
 void report_linked_checkout_garbage(struct repository *r);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 1cc05f043a..e00fce592b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -75,11 +75,10 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
 		struct strbuf sb = STRBUF_INIT;
-		int ret;
 
-		ret = strbuf_git_path_submodule(&sb, gitdir, "objects/");
-		if (ret)
-			die("strbuf_git_path_submodule failed: %d", ret);
+		if (!repo_submodule_path_append(the_repository,
+						&sb, gitdir, "objects/"))
+			die("computing submodule path failed");
 		add_to_alternates_memory(sb.buf);
 		strbuf_release(&sb);
 
diff --git a/worktree.c b/worktree.c
index f8d6e7127f..8f4fc10c44 100644
--- a/worktree.c
+++ b/worktree.c
@@ -487,7 +487,8 @@ int submodule_uses_worktrees(const char *path)
 	int ret = 0;
 	struct repository_format format = REPOSITORY_FORMAT_INIT;
 
-	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
+	submodule_gitdir = repo_submodule_path(the_repository,
+					       path, "%s", "");
 	if (!submodule_gitdir)
 		return 0;
 

-- 
2.48.1.538.gc4cfc42d60.dirty

