Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A022253E4
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828688; cv=none; b=pzXJig0HxU+TQaQ8oOlHT5pdu7QbTMMjwoueRD0py3O9LW+8SIq7k9o8MXS0t1JEXgxVJ6869F3rkmKJydneANi51mXer3zXBIw7LVoxrYM/UUiZBXO/EeyPHocGzYCKem7k6cQllkNp/Tw/2h+YCB3TD6iUMlQqhaxIp1KiyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828688; c=relaxed/simple;
	bh=kxi7pVW9KP2hHuO0PqkHPZao7QAeyri9pIPCD1reWWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEiAxJNAtun2qUEfoeRQqRqguxOtlmaRbIUcR/06RhxXcbNJGu00ym9yEAiHpPK3gzhutICRkrZjzeco3boV1fZA+D2cPUBxoWt4G67k2H6hG/wdpIFHffZmM6rg5aodXFoRG6bJhBAfvlwyhnV7rFAHLlPrtE8kzvCPSsUbm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=prYZ7oXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJCRu/r6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prYZ7oXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJCRu/r6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F2311380209
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 02:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828686;
	 x=1738915086; bh=k3xUzztC6UP1r1QjJ0rtP/zkEA8/NRIbtDynK6ITg7M=; b=
	prYZ7oXpILUZ+GvoWKILrrUCexm/AVrQFVAudROyjefdMYq+2z7LeBEKKUAXY4U/
	UXVTIU8Rcq92vZMZIrkyT2OZ/ok/V8lRUkJ2bYokMSLq5lbqkveKQ2/3DdPTEUaR
	xAl6iZqy47w8W3eKy2K6ZJnlL0MUREqqdBbgAEUAAjvNLUcoOcvuMfUnEZcvivEZ
	Zi3oNxkGJuTion8R5m3q/UltLIH9Q6EH/cctsd23SXO0oZDKK47TQogsKYoy6/uD
	+xI1WJiDpdte5BvQoDjnapaeK2rHcgfaeRYPR+hBofndvXr5zUNCdJtqtQdDVZ3x
	FO1Ffz6N53cVBIckr96dBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828686; x=
	1738915086; bh=k3xUzztC6UP1r1QjJ0rtP/zkEA8/NRIbtDynK6ITg7M=; b=k
	JCRu/r6XeaTsrT8CCeNSI0bLf2fKjmL4v4HUswIoMxlR2B3XNm9MMASgul1UamUZ
	W4ds4I9gVNJgsTBkG7H/zLvm1brMyVXva1U+XZjZxBZtO96CFlt+sAK/R7eIQ8yT
	T24J3DoqV7PnI5vJBFlwQOSAH1skKBv1r0qfAajA3jeJ5EEpg5Ad+aGIooUItKQ9
	5EpeLgxUkEMJb9lSJCsgeMKa9iR3jIpHNkwmSC4WYsZu/X1MUA9saJUQVfEbRbtY
	nKk0Cdk+4xV9H581J4M0k6riJVPBf3yYHbG8tWsrVE/QBKOZDanjb+ukOamXOeHr
	RDwUaL9tAwMissxZXa9rA==
X-ME-Sender: <xms:jmukZ7yMArTlZy6zgFBmZq_Jpfne-6d2hPd6plDKF_UHkpBbOwdNbQ>
    <xme:jmukZzTwzPwLPgcFXfl6PPs2aQDvLxY2Xh_tCY91M27VP-GTvGXVhgMkhxao5WJb-
    iQQ8itlreJrnGJwuQ>
X-ME-Received: <xmr:jmukZ1VWYUIXkWIuoJ-atwfdlAp4C90VVYmkz2bwFS7aF7lBFu7On5BM9z1lyBIZyFmEQA6HrBYEHUNZH47oy_kQv7gCRQzzbFp0VP9TomWa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jmukZ1iMQUhFwxhVUZsXXcaU3bAoSWeDH5MoNcSsatq3GapfCTRAZQ>
    <xmx:jmukZ9CVY5WoR9jEXIEw4h65B-TU0EjUkSml7pSVnqfWeqxCssGrRA>
    <xmx:jmukZ-JFphBS-9uep83cwpKgIP6zJRwdWTw7DZMsoo37JKL_qqNxIA>
    <xmx:jmukZ8BeilRR5fP9aTy4PmSkbT0uQAL2Y4JGMcSDyHkVFJXhqFRf8w>
    <xmx:jmukZ67KrBKeLz-x7FUHD8-ij0J1UtHlY862NzZqxtS4r5O6Bw23X1Ld>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cebcb5ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:57:58 +0100
Subject: [PATCH 02/16] path: refactor `repo_git_path()` family of functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-2-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

As explained in an earlier commit, we're refactoring path-related
functions to provide a consistent interface for computing paths into the
commondir, gitdir and worktree. Refactor the "gitdir" family of
functions accordingly.

Note that the `repo_git_pathv()` function is converted into an internal
implementation detail. It is only used to implement `the_repository`
compatibility shims and will eventually be removed from the public
interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 editor.c    |  6 ++----
 hook.c      |  3 +--
 path.c      | 23 ++++++++++++++++++-----
 path.h      | 34 ++++++++++++----------------------
 submodule.c |  4 ++--
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/editor.c b/editor.c
index 6b9ce81d5f..b79d97b0e7 100644
--- a/editor.c
+++ b/editor.c
@@ -142,10 +142,8 @@ int strbuf_edit_interactively(struct repository *r,
 	struct strbuf sb = STRBUF_INIT;
 	int fd, res = 0;
 
-	if (!is_absolute_path(path)) {
-		strbuf_repo_git_path(&sb, r, "%s", path);
-		path = sb.buf;
-	}
+	if (!is_absolute_path(path))
+		path = repo_git_path_append(r, &sb, "%s", path);
 
 	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
diff --git a/hook.c b/hook.c
index 9ddbdee06d..b3de1048bf 100644
--- a/hook.c
+++ b/hook.c
@@ -16,8 +16,7 @@ const char *find_hook(struct repository *r, const char *name)
 
 	int found_hook;
 
-	strbuf_reset(&path);
-	strbuf_repo_git_path(&path, r, "hooks/%s", name);
+	repo_git_path_replace(r, &path, "hooks/%s", name);
 	found_hook = access(path.buf, X_OK) >= 0;
 #ifdef STRIP_EXTENSION
 	if (!found_hook) {
diff --git a/path.c b/path.c
index 273b649e00..f386a5ff52 100644
--- a/path.c
+++ b/path.c
@@ -417,7 +417,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
 }
 
-void repo_git_pathv(const struct repository *repo,
+void repo_git_pathv(struct repository *repo,
 		    const struct worktree *wt, struct strbuf *buf,
 		    const char *fmt, va_list args)
 {
@@ -432,7 +432,7 @@ void repo_git_pathv(const struct repository *repo,
 	strbuf_cleanup_path(buf);
 }
 
-char *repo_git_path(const struct repository *repo,
+char *repo_git_path(struct repository *repo,
 		    const char *fmt, ...)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -443,14 +443,27 @@ char *repo_git_path(const struct repository *repo,
 	return strbuf_detach(&path, NULL);
 }
 
-void strbuf_repo_git_path(struct strbuf *sb,
-			  const struct repository *repo,
-			  const char *fmt, ...)
+const char *repo_git_path_append(struct repository *repo,
+				 struct strbuf *sb,
+				 const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
 	repo_git_pathv(repo, NULL, sb, fmt, args);
 	va_end(args);
+	return sb->buf;
+}
+
+const char *repo_git_path_replace(struct repository *repo,
+				  struct strbuf *sb,
+				  const char *fmt, ...)
+{
+	va_list args;
+	strbuf_reset(sb);
+	va_start(args, fmt);
+	repo_git_pathv(repo, NULL, sb, fmt, args);
+	va_end(args);
+	return sb->buf;
 }
 
 char *mkpathdup(const char *fmt, ...)
diff --git a/path.h b/path.h
index 3c75495e1a..c1cb3ce3be 100644
--- a/path.h
+++ b/path.h
@@ -52,29 +52,16 @@ const char *repo_common_path_replace(const struct repository *repo,
  * For an exhaustive list of the adjustments made look at `common_list` and
  * `adjust_git_path` in path.c.
  */
-
-/*
- * Return a path into the git directory of repository `repo`.
- */
-char *repo_git_path(const struct repository *repo,
+char *repo_git_path(struct repository *repo,
 		    const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-
-/*
- * Print a path into the git directory of repository `repo` into the provided
- * buffer.
- */
-void repo_git_pathv(const struct repository *repo,
-		    const struct worktree *wt, struct strbuf *buf,
-		    const char *fmt, va_list args);
-
-/*
- * Construct a path into the git directory of repository `repo` and append it
- * to the provided buffer `sb`.
- */
-void strbuf_repo_git_path(struct strbuf *sb,
-			  const struct repository *repo,
-			  const char *fmt, ...)
+const char *repo_git_path_append(struct repository *repo,
+				 struct strbuf *sb,
+				 const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+const char *repo_git_path_replace(struct repository *repo,
+				  struct strbuf *sb,
+				  const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
 /*
@@ -241,11 +228,14 @@ struct strbuf *get_pathname(void);
 #  include "strbuf.h"
 #  include "repository.h"
 
-/* Internal implementation detail that should not be used. */
+/* Internal implementation details that should not be used. */
 void repo_common_pathv(const struct repository *repo,
 		       struct strbuf *buf,
 		       const char *fmt,
 		       va_list args);
+void repo_git_pathv(struct repository *repo,
+		    const struct worktree *wt, struct strbuf *buf,
+		    const char *fmt, va_list args);
 
 /*
  * Return a statically allocated path into the main repository's
diff --git a/submodule.c b/submodule.c
index b361076c5b..211ead54a0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1315,7 +1315,7 @@ static int repo_has_absorbed_submodules(struct repository *r)
 	int ret;
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_repo_git_path(&buf, r, "modules/");
+	repo_git_path_append(r, &buf, "modules/");
 	ret = file_exists(buf.buf) && !is_empty_dir(buf.buf);
 	strbuf_release(&buf);
 	return ret;
@@ -2629,6 +2629,6 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	 * administrators can explicitly set. Nothing has been decided,
 	 * so for now, just append the name at the end of the path.
 	 */
-	strbuf_repo_git_path(buf, r, "modules/");
+	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
 }

-- 
2.48.1.538.gc4cfc42d60.dirty

