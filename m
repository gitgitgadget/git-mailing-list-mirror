Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332F230BC8
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566169; cv=none; b=MvcKbzq+GCMP9u14JlfUqX1UOD6XDIZkoyyA8y6zEDM2FH2Kx4dow6bebklLqKnybBa77bwexGNDfTgaWAeZfMraiifGgnkTsdMl2sph/LajJ8zcTn0TkCqxLR1KtlCXcPxqcvRgykTLoFo8wJhGURwyx/RD4HnwcIdw/vpk61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566169; c=relaxed/simple;
	bh=pFM7RD+jcss4rJBJTcHz2260mS1SyG5RHT10iRM5ZfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nocs+KIaI0MOKbLcw2dANaRiK97CEbEMtM1xcie5soh1066l6gH0KLNIfYBtXyr4Lm0gvMcPC33+vIu6UuIYgRsUFNVBKbAr8/3QpolKkP/kND8bEuWjc+nR3gQdlWE8C61cOCkTMnrsR2Bot1OmET11m+VOAwBBL8y84eutW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E3TLZEV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JfxIwLhH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E3TLZEV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JfxIwLhH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 741431140223
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 03:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566167;
	 x=1745652567; bh=edUlHTv+vcN1MLmyB1sdQ8rcKpYfHhfv50DEJh0UCNs=; b=
	E3TLZEV2WPddkAL7ohlxn+oYX6gP2sZ3ZMkgyywwI0AZPics593dBVV0/Z8Xa19b
	jskoDgGgM1SZxvLmVj/KJVbiOZXgaL27uISw+DZCHjx6ARUOANABdXQKIDUmCfJq
	oWca58u0k+tXoy7wyoC0QbanCqOZnhyKy9z0R9Z2UqvI14tA+LflpqfQq8bnArIa
	mJZXdJLPuQCyG2j+/WFwIRNuPnaM55fL41NGOXIU2FhrTMbyvotcx4mznZ9TAwCs
	mIQvqcF1T6XAD28I//fw9dWyPTGIoNjP5PrV4bZ6fDB0XwhvDh54WnzcmjkNZq8r
	WP+ToGnAJAJyb9KH3Lwotw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566167; x=
	1745652567; bh=edUlHTv+vcN1MLmyB1sdQ8rcKpYfHhfv50DEJh0UCNs=; b=J
	fxIwLhHOtJG3g3tYPauG7t44a90J+TqyI3Kl2OtUdB3vXqmeKB4i3d7JOjjrRd/o
	RnJmHPHE05UMwqoOCCvxgmsf9cc++5nPRzCUJNqVE1VXeTDKuqBSsw0njq/4zcbP
	D4JmYSsTiwjF33HDA3mZGvfwrq38iewB2U0Xga91E8XS4x5yyiZ6nBkR4q6dYvEb
	VZC09CpdxVYAbQ0alJ5AlVqFldub8PpyQTT269tvJhSVL5t+K2HGhHJG43EDMrK4
	gEpF+fNedyuP71L63Eyu5HwImtjCFmT2TZ7RQNVx+uuXYg3CpfSnTqD1bxcDST/4
	5J2FXEpILL9xxPl2gg4Tg==
X-ME-Sender: <xms:1zkLaPX9Ftrv7_OD2eyn0lJtNg4vSKq8StoMptk34ypVA6jEkDoaZA>
    <xme:1zkLaHlbxl8xEf0BLybqkRjt5nSOuYkMaoXqTq3xzyd1NxvDDz24paguvubRoaYHX
    ybD1QbpYETCNZLm_A>
X-ME-Received: <xmr:1zkLaLYAkDb5ZBV4I5JLMIM9hbYZlCc0JYk9Ac2Aa8Irl7A18ZGgKTdnZ4mrmNM0NdbQHF89GHBd8wHoB1CMyhRtEhg1TFqYcDBo6YEl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1zkLaKU9n1yEEP9WM-zcxf7eTUCjq6i1mEB_E8uVOZ_yPV3ev0DFAA>
    <xmx:1zkLaJlBj6fQWD3Gnm2VioRScnCnJnbhxEIPvVcWv_BFSr5nfZwgTA>
    <xmx:1zkLaHcA4bSfypS5z-iayTX782JAwFsx0nZnkBx1WMgwEaPkwnkj_g>
    <xmx:1zkLaDGuiTy0LCZ1ZXPZrG2YlmZIZRX38XWBg1uXTNNPpl0disoCtw>
    <xmx:1zkLaKgRw64NPMIWtEFzyeHqDNqlLT4I4OatAt1OEWJzb87lJBWUiuzn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8c5ca38 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:20 +0200
Subject: [PATCH 4/7] worktree: expose function to retrieve worktree names
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-4-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Introduce a function that retrieves worktree names as present in
".git/worktrees". This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c | 25 ++++++++++++-------------
 worktree.c         | 30 ++++++++++++++++++++++++++++++
 worktree.h         |  8 ++++++++
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 87ccd47794c..9b00dbf1265 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -211,27 +211,24 @@ static void prune_dups(struct string_list *l)
 
 static void prune_worktrees(void)
 {
-	struct strbuf reason = STRBUF_INIT;
 	struct strbuf main_path = STRBUF_INIT;
 	struct string_list kept = STRING_LIST_INIT_DUP;
-	char *path;
-	DIR *dir;
-	struct dirent *d;
+	struct strvec worktrees = STRVEC_INIT;
+	struct strbuf reason = STRBUF_INIT;
 
-	path = repo_git_path(the_repository, "worktrees");
-	dir = opendir(path);
-	free(path);
-	if (!dir)
+	if (get_worktree_names(the_repository, &worktrees) < 0 ||
+	    !worktrees.nr)
 		return;
-	while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
+
+	for (size_t i = 0; i < worktrees.nr; i++) {
 		char *path;
+
 		strbuf_reset(&reason);
-		if (should_prune_worktree(d->d_name, &reason, &path, expire))
-			prune_worktree(d->d_name, reason.buf);
+		if (should_prune_worktree(worktrees.v[i], &reason, &path, expire))
+			prune_worktree(worktrees.v[i], reason.buf);
 		else if (path)
-			string_list_append_nodup(&kept, path)->util = xstrdup(d->d_name);
+			string_list_append_nodup(&kept, path)->util = xstrdup(worktrees.v[i]);
 	}
-	closedir(dir);
 
 	strbuf_add_absolute_path(&main_path, repo_get_common_dir(the_repository));
 	/* massage main worktree absolute path to match 'gitdir' content */
@@ -242,6 +239,8 @@ static void prune_worktrees(void)
 
 	if (!show_only)
 		delete_worktrees_dir_if_empty();
+
+	strvec_clear(&worktrees);
 	strbuf_release(&reason);
 }
 
diff --git a/worktree.c b/worktree.c
index c34b9eb74e5..947b7a82209 100644
--- a/worktree.c
+++ b/worktree.c
@@ -988,6 +988,36 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	return rc;
 }
 
+int get_worktree_names(struct repository *repo, struct strvec *out)
+{
+	char *worktrees_dir;
+	struct dirent *d;
+	DIR *dir;
+	int ret;
+
+	worktrees_dir = repo_git_path(repo, "worktrees");
+	dir = opendir(worktrees_dir);
+	if (!dir) {
+		if (errno == ENOENT) {
+			ret = 0;
+			goto out;
+		}
+
+		ret = -1;
+		goto out;
+	}
+
+	while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL)
+		strvec_push(out, d->d_name);
+
+	ret = 0;
+out:
+	if (dir)
+		closedir(dir);
+	free(worktrees_dir);
+	return ret;
+}
+
 static int move_config_setting(const char *key, const char *value,
 			       const char *from_file, const char *to_file)
 {
diff --git a/worktree.h b/worktree.h
index e4bcccdc0ae..59825c37881 100644
--- a/worktree.h
+++ b/worktree.h
@@ -38,6 +38,14 @@ struct worktree **get_worktrees(void);
  */
 struct worktree **get_worktrees_without_reading_head(void);
 
+/*
+ * Retrieve all worktree names. Not all names may correspond to a fully
+ * functional worktree. Returns 0 on success, a negative error code on failure.
+ * Calling the function on a repository that doesn't have any worktrees is not
+ * considered an error.
+ */
+int get_worktree_names(struct repository *repo, struct strvec *out);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */

-- 
2.49.0.901.g37484f566f.dirty

