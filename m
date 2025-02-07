Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B71DE4CE
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926218; cv=none; b=iJnJZWjyeuz3MjqasEzCKNo4FyHsbF8tnVthTgVgLbsx7L+7WA0vn/1jVoAyHD2OA8hitqhC6u19YNNINqu0fLmzek76Vfijs1GpHcQP8Eg7VHX52c2C65xWqj39GQqETkPr4jnWJ9H59ZaJIcky9hrB6Et+lD/yR5dmC1omkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926218; c=relaxed/simple;
	bh=6sndihyYWJE5uRvDS/Fc39FPdJHURttm8McHQr5tENE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RC4JcQO1wVVCicNEoSsaijihRbKdoRnyD19Y26MQC3eu6nOcQCCV1cH6f+QVlS7Z9FxQyF3BSH8ct+e/CoYyU74yLFhM8YgfBxE3kYwYTS0gvt+L6ORSZEQSV+S5RIr2cDa+uJ8eYTeUkZ8Hf2LjEHzmEdexNMoOKqUHWckh0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq/V2CVZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rulLj2ho; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq/V2CVZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rulLj2ho"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BB61138016D;
	Fri,  7 Feb 2025 06:03:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 06:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926215;
	 x=1739012615; bh=IgH/Z2tIt9leKEDUKpA9CR58kPwcUot6NFtxeQ/5NAU=; b=
	Zq/V2CVZF2MezYinFFKwF2aEAzAKjqXO77wvrawToXRs79Odi7eFcitJ+n2z+TH4
	qkKD8wwUIWjFUPbdJv9dDI6ed6WzzajB/qmJf1zods+YRJAe0dFbgag3VuPNJA3t
	CqLsjFjDaDlzWGcFUvMvgB6NOUDh7mxLjfSFSzOQHLtT1uUa04tLwPxhgnzPdDmw
	KcLYm0GA0qlk0Q17sLArIRPbHmIMuG+viqvzENOuP2w6iFk3zOnRJXMTTuyDURBV
	iA78pD/j5MBosCUDOu7FyBmYM69bNARns5OXwMFYDPvAm2tTW+0buKQoEiqfmA4c
	ZiRilN/8Sl1qlF/AW4oVrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926215; x=
	1739012615; bh=IgH/Z2tIt9leKEDUKpA9CR58kPwcUot6NFtxeQ/5NAU=; b=r
	ulLj2hobqCEsAiiW5oP78sjN/1gQdLVHGUdyIJJYnZBfY03x1I/RZAr6NQRTp3Fh
	aMWfD35FRWd8i42SgHyelWx/Fu5QtDGmFqRa01Bco2+ivoeTyW2ILVrImuLxt5zf
	53BvZCMQ3vmMoWOvGUN9gvFhYRyMh+sjSPecH98LT88BdVnc5IFDgpDp9HLObAIq
	hUn/JawnTVajQtv+I9aZIZWcMj69mbQRQsdiugTdzijyZDPGUB7/kvYFwvvatOJa
	j0hin+GjIFBLnP72/lY/uB4jiQ/iNubnI74wfqX+1bWk4drWQAMtH6Mt3SkZpayo
	XL1sulYUQHJPVeV/0h8Jw==
X-ME-Sender: <xms:h-ilZ3A2FfKtiIvv8e35w_EgCKQdkh4cIqfG7OdlBVQkrtEyRkBfJQ>
    <xme:h-ilZ9jpJrkN9p-DUDtHQAq1u4IM4R48aFXPETeYmyh2-eXxLd8XyDiTHdnWHUnpD
    TbIHmM8oT9j7l173g>
X-ME-Received: <xmr:h-ilZyn5KaZWg8GZVKATdB821xXUpzbXSCRWs1fziRAtPQj_baI1_iE1Ah_EejCHJZ0g_pQ-JrErsXNrVJDxeqPFo12hV78W2CWDnie7ezy4XUJX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:h-ilZ5xYafqOW0caUv-RMUNt65SS5WMBDsMKeTCurRvsaNau2Z1Ezg>
    <xmx:h-ilZ8Sminh1e6tAIzyoMwHQYQamuCRU38DJNdPINRuMQokaCR3xiA>
    <xmx:h-ilZ8a1cxrBm_zKFiZqiQ3RIrfML3WGvWOwKK98XiwCOIGYF1G8Zw>
    <xmx:h-ilZ9TaufEg8xmOL-gAWPrpLZuPYAhA1Vc3JQxCSTnUYKBf6P9hWQ>
    <xmx:h-ilZyfOFmwrPQwA8lSd4U-XmBekhnBm3SmeB2r-YrzIOv2pmxX34IE0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16735452 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:30 +0100
Subject: [PATCH v2 05/16] path: refactor `repo_submodule_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-5-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

As explained in an earlier commit, we're refactoring path-related
functions to provide a consistent interface for computing paths into the
commondir, gitdir and worktree. Refactor the "submodule" family of
functions accordingly.

Note that in contrast to the other `repo_*_path()` families, we have to
pass in the repository as a non-constant pointer. This is because we end
up calling `repo_read_gitmodules()` deep down in the callstack, which
may end up modifying the repository.

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
index a7fa42162e..0d81e9fc32 100644
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
index d3f85f0676..4fe523626c 100644
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

