Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871D1A4F12
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926216; cv=none; b=dUZkxv3Za6eLxO+6szA9835/bqK8MyMqufT0U2t9BvaITfnMWMw6HmBUKfy8PrIZe16CQqDUwrCd+yKKqGOXP7jgiskVOijz0ySVahqm02FQLCBk9Ue4kiC3w4B2n9WtSHxltStzgc+GyeR4aGY2k+JGlM+0hB9JIGn+oc3bzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926216; c=relaxed/simple;
	bh=895VgF/z7bJRD0f2Uwamze8DHOq3ETO6N/fXXwxgNHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcuP3gIzm4FzMqucKpF31ryJ3Du5d3E/R/gJFZDkPf3XYjMvPwsUF+5Awlzc+xfLShtV6hFy3hQlzyVMfeOKRqDq6CEDYtCmc5YachtjQLBLJbxQt3/f4NXMFhOFevjVbHqsZ9/DjbC8YIm48eizSsaku8AY+WflgZjpAUNkA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QHES0m3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beKakgtI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QHES0m3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beKakgtI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1842713801CD;
	Fri,  7 Feb 2025 06:03:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926214;
	 x=1739012614; bh=YwD63AnhmZ17O/D4+U5b/ORGJA93E+K6p3rBqj6XwIQ=; b=
	QHES0m3QLbaUuUHKyFTKmuPFB9mZQUt3CBqTJKpAK489hHhrPEQ93XESdN/ozvOb
	t5lQzCwvuMStjfdUJpuW6IUg3wfCQ6/KIsBFXZJ325qb1506asYVWefxMOq3MkUa
	vC0UVEVj0J4VAw9JAHIAN7VF1xyZbKY3zIdVvF+H3GnyxL5t4Lqm6nlxyYKgpVga
	KxKMZF2ean6mg3r2GhShgfkj0htPJRvbnMIoL8nJQ6M4rkSo6CW0BcFOqJ/8XCjW
	k72RPRA8zjGPEJ+evhQeh4swoLxn7eUjgmwIc+5U5GjNk3XfBlQDzQP5YYYSfZvb
	NgwcI9sO9NX4tBPPlYgSyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926214; x=
	1739012614; bh=YwD63AnhmZ17O/D4+U5b/ORGJA93E+K6p3rBqj6XwIQ=; b=b
	eKakgtIHXEinVJyg+WoO1fFU9Mb4Tdr6jXoR5XPSJO08GA2etoDL0MB3ySFAXJfU
	Svi9d5tLaUUjpbm6rqOUw27iW/eVEvp4ytGodyRZhz/TmFnODehdrHxwDPg9UTmQ
	psNfQyymC39e6A6jhP0OgXY/rhfQ/nA7bQEMkIr8jBpGvsGMvefQ8gHHpGxekBOF
	1s4EsznNN+/pp/rS0A28awF4G2ao9jlR5neuySMkd2rLCyNyJJaRTY/+zQQbCTBz
	rVZKnmxcr+fHoEJCDj6v9RwSvQSaZMSmBiMziK546RFfmAT28/iQ0MG+u6+jyu3x
	tr5bdsaC/bKI9udOp0D1A==
X-ME-Sender: <xms:heilZ0TWBxMiKmMlwSvaU1LOy-ATBMdiOc9UjDMzvTvTX7s1NMwfIw>
    <xme:heilZxxvfevAi2zdyPS5Qov21REYAB8WQHMWi6memzQCdGG5vgUGjlGhChoB6jQzj
    N6sOayxacQksnCZbg>
X-ME-Received: <xmr:heilZx3Pa6MROSfo31fRWGDbsC8r7onDCALiDshlj4Cu5Q1sNLGlztPHPHk0RlJ2nzO0wrNGIkSFBBxpEW7qHbs3HJCxzCr1Cmy9LyUIGs_P5Ynw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:heilZ4CpmsrYDeIqCM7nM3QjF5AU_vkhjZq2wQPdopCBHlbxUvovpQ>
    <xmx:heilZ9jvZraquLoGO4JtMzNk7V6_aDXoWaZDGtXkr03qOqkza_GrIw>
    <xmx:heilZ0rLVhEuvZIEMQKAeHookOWJCl4fCSCdmyYKHAOuZQkWT62_Qg>
    <xmx:heilZwicbmOmvt-fVNvw1RtG1dX-bjShnOonUqNbvB26JMEV7FYqjw>
    <xmx:huilZyuQzWHmSbL-9woaRfmRDiZXi_04htQpptzbSMpOR9nRyjeUW9PB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f344f3ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:27 +0100
Subject: [PATCH v2 02/16] path: refactor `repo_git_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-2-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
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
 path.c      | 19 ++++++++++++++++---
 path.h      | 32 +++++++++++---------------------
 submodule.c |  4 ++--
 5 files changed, 32 insertions(+), 32 deletions(-)

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
index 273b649e00..779aa94b56 100644
--- a/path.c
+++ b/path.c
@@ -443,14 +443,27 @@ char *repo_git_path(const struct repository *repo,
 	return strbuf_detach(&path, NULL);
 }
 
-void strbuf_repo_git_path(struct strbuf *sb,
-			  const struct repository *repo,
-			  const char *fmt, ...)
+const char *repo_git_path_append(const struct repository *repo,
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
+const char *repo_git_path_replace(const struct repository *repo,
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
index 3c75495e1a..c45311b0a8 100644
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
 char *repo_git_path(const struct repository *repo,
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
+const char *repo_git_path_append(const struct repository *repo,
+				 struct strbuf *sb,
+				 const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+const char *repo_git_path_replace(const struct repository *repo,
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
+void repo_git_pathv(const struct repository *repo,
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

