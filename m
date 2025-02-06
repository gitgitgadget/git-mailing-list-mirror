Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AE2248BB
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828689; cv=none; b=Xi96+iIO2bVK/eLJ/3lRiDKeBjEySRjGC/BG/KubN2MIkMUv0LmqxIM1e4dDt2dJ+bRrUN+GXXh8O0Ske/3a1qqSfpFPhIRysMNpD++EIj1a6Kl1sBYp34uhfvdeeQgSjEysfVIQ3UK9Nk34amHTJX3/7iTYgXJ0462ppTqvo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828689; c=relaxed/simple;
	bh=1Hifq8Ho71/SJLtffD9ClvyrxaBnLnaibmwEMtmxhG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bYzb5QpBL8epIq67USuP7GDjGMwt08V7C3p5R7VKu1MRNyxSD3nv0101TWQtGup26BKvhgP3Mz0+IgnFv0EL6RuqQZuFM89lHJOxSCa/Nk8ihJ7Flx9x7WSrCcdXA2Aw3A6n8J2d4IL7lhupduNPova0Xfk93v1VcW6bDVSCf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bf0AwFbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LUDYClCD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bf0AwFbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LUDYClCD"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440691140191
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 02:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828687;
	 x=1738915087; bh=4vqB3z/SYJe7tb9QhtKERUDQYoid2G5UnOWCb00bptA=; b=
	Bf0AwFbBBp8ZXWJD5b3fvmkomhm90wOlZS1Az43QamB+SqDvTMyqNDQ6cqpVsnCY
	0G0Gcdl8yTn6kHKhfna0FAC806jwPwlvSwLCRP/EgGq0plF1CncfZiBNNzHiI6wv
	8CZisj/wwCFvqLAdixiABZw5WUGEtm6wKnN/EiY8ASPqo8vLyb8aSH5/xcDoKjoq
	faVbl3f7CA2XLFXncfWukMD9h7Z/p0VasMaLNKcq7NTIGDVhSKIAO6fUtgj6SohA
	XRIUN/17rEo+dOCEiQfsEiR41MgTUe0Uc7dEjBHn9apSf4n5VDD9n9Z5OW0fleiT
	nL0eizflLkVQXBGejWDrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828687; x=
	1738915087; bh=4vqB3z/SYJe7tb9QhtKERUDQYoid2G5UnOWCb00bptA=; b=L
	UDYClCDnyA0bWSHi5wIM7HwDt/BSXSkegnjhoGB4oS3UxWnQGlBDFf1RdkhYrcz0
	ESeMUh6F3kQ6dFk1j/AFbbjOSaEkO1XmqyOV2RgQIF3lRllU9oqRhuk/CGHKcQDF
	zexEwVGc3gAcVQs4yT40drm1Q7RvgqWUOCwIzD63LD8Qmgbn2XoTWGr6X0JsEeP1
	SBNSg0r7QJV5ca1eDgiLp/2qgOY1mvzjqUKy1SX5XnWizYB0onR704qyGQhwtOku
	p1t9lMZqfe1sw05/HFaR9r5N2AbpKRX1f7Diwgjj7gKoiTfgTvCvLXcuiATCqPJV
	tguOL/XaGgIlYmmAPobgg==
X-ME-Sender: <xms:j2ukZ_-0iMPbZ5UDLbRYG_eva7SwDCtmmjqSf9cVlp_AFTM9BRtYMQ>
    <xme:j2ukZ7tG3FgXmUMrVKwfLse06ZHy2FLea5cuXjnFfrbaCWAX6JUWO1RUfc0BPtsLH
    zV3jGFuG1NfXYTN2A>
X-ME-Received: <xmr:j2ukZ9B3GhM28hEKXpiLkiuwjCZp6Mi__pCg8bklz4oexThNUCgQnp4dW-M1oYTTha5WCARiRW37dCqW6qXwQNO9DIvlLFkaC1WZ8h7rq7H9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j2ukZ7dPjQJoX-vCESePiOA3wrdTpBkx0B9OUvlTw_f2rYDdfM0RVw>
    <xmx:j2ukZ0MfwXYRHSkFGLbNUkl3zi0DyvN4m8V5MTm7IsrjBdYDJ7-Yag>
    <xmx:j2ukZ9kd-35X_UTVXktTBM_TMevYbVI6w0PXGcMmRoNENEsO82HLSw>
    <xmx:j2ukZ-s8ZtLTnHsW7K7ijRL-E4EYAokcYRdueO50E0fYS0GVHB1Z_g>
    <xmx:j2ukZ-36g2IIxrVpdl_s1fSaW7RztYlvpbpMlSSrT-DP5dhxbLqcXWWU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5221af6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:57:59 +0100
Subject: [PATCH 03/16] path: refactor `repo_worktree_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-3-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

As explained in an earlier commit, we're refactoring path-related
functions to provide a consistent interface for computing paths into the
commondir, gitdir and worktree. Refactor the "worktree" family of
functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c       | 28 ++++++++++++++++++++++------
 path.h       | 20 +++++++++-----------
 repository.c |  4 ++--
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/path.c b/path.c
index f386a5ff52..be75808acc 100644
--- a/path.c
+++ b/path.c
@@ -519,28 +519,44 @@ char *repo_worktree_path(const struct repository *repo, const char *fmt, ...)
 	struct strbuf path = STRBUF_INIT;
 	va_list args;
 
+	va_start(args, fmt);
+	do_worktree_path(repo, &path, fmt, args);
+	va_end(args);
+
+	return strbuf_detach(&path, NULL);
+}
+
+const char *repo_worktree_path_append(const struct repository *repo,
+				      struct strbuf *sb,
+				      const char *fmt, ...)
+{
+	va_list args;
+
 	if (!repo->worktree)
 		return NULL;
 
 	va_start(args, fmt);
-	do_worktree_path(repo, &path, fmt, args);
+	do_worktree_path(repo, sb, fmt, args);
 	va_end(args);
 
-	return strbuf_detach(&path, NULL);
+	return sb->buf;
 }
 
-void strbuf_repo_worktree_path(struct strbuf *sb,
-			       const struct repository *repo,
-			       const char *fmt, ...)
+const char *repo_worktree_path_replace(const struct repository *repo,
+				       struct strbuf *sb,
+				       const char *fmt, ...)
 {
 	va_list args;
 
+	strbuf_reset(sb);
 	if (!repo->worktree)
-		return;
+		return NULL;
 
 	va_start(args, fmt);
 	do_worktree_path(repo, sb, fmt, args);
 	va_end(args);
+
+	return sb->buf;
 }
 
 /* Returns 0 on success, negative on failure. */
diff --git a/path.h b/path.h
index c1cb3ce3be..8761c4c660 100644
--- a/path.h
+++ b/path.h
@@ -75,24 +75,22 @@ const char *worktree_git_path(struct repository *r,
 	__attribute__((format (printf, 3, 4)));
 
 /*
- * Return a path into the worktree of repository `repo`.
+ * The `repo_worktree_path` family of functions will construct a path into a
+ * repository's worktree.
  *
- * If the repository doesn't have a worktree NULL is returned.
+ * Returns a `NULL` pointer in case the repository has no worktree.
  */
 char *repo_worktree_path(const struct repository *repo,
 				const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-
-/*
- * Construct a path into the worktree of repository `repo` and append it
- * to the provided buffer `sb`.
- *
- * If the repository doesn't have a worktree nothing will be appended to `sb`.
- */
-void strbuf_repo_worktree_path(struct strbuf *sb,
-				      const struct repository *repo,
+const char *repo_worktree_path_append(const struct repository *repo,
+				      struct strbuf *sb,
 				      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
+const char *repo_worktree_path_replace(const struct repository *repo,
+				       struct strbuf *sb,
+				       const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
 
 /*
  * Return a path into a submodule's git directory located at `path`.  `path`
diff --git a/repository.c b/repository.c
index 1a6a62bbd0..648cd88474 100644
--- a/repository.c
+++ b/repository.c
@@ -312,8 +312,8 @@ int repo_submodule_init(struct repository *subrepo,
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
-	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
+	repo_worktree_path_append(superproject, &gitdir, "%s/.git", path);
+	repo_worktree_path_append(superproject, &worktree, "%s", path);
 
 	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
 		/*

-- 
2.48.1.538.gc4cfc42d60.dirty

