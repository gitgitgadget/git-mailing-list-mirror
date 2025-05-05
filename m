Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D11F4161
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435115; cv=none; b=TYTLWPIpdcSuyUbTiAXTU6ZgoAqH4djvVuoEprIJmmjtNTRn0YmTW+GelcEqWxOOHbZzUMfnXWqSWg5kFvGFIceTYGMchFSeR6JuU6EkrlhNLWtSIBEFyh48dQQQjOY1CNoWICBskEspRIusbA72iS5qeSDUkkntaKwEnDH7IOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435115; c=relaxed/simple;
	bh=V9BBXG+IACD0anz+yG3b2Vqmop5ilIYQ64ZghKT5tj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlqPJENljlwltI+uZmhQ9EnDK3yOmb0/qAzXW+2CFebxYN3860YxiiDWwSCY1aG1N+EgZNEXTpBuMSKmGwVmzjvSR/oOPPUPp1/2jMtAGsAwV1OleEgFwHjNVrwcG1xR4he6uvA7UHvGDZNj9Q4mI1ffjU1VKD7JC9CtzN8aqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k6UIZA0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vC29tbg3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k6UIZA0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vC29tbg3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A21B12540259;
	Mon,  5 May 2025 04:51:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 May 2025 04:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435112;
	 x=1746521512; bh=S/iTBBZCqlvNt+PhtoicppRm8ryjtsC6uePgDuwpjPA=; b=
	k6UIZA0OBWBgUD002u/8PgWjqB0aaGaH+9tNEyGc/RIfRsFzFLkUVHF2deWn14E/
	VW0I8m/mYbXs7iEIsv8IFQrSwPrQPjD8y9VStUfdBRtvbOfl7lRkVQBeG4vY6LBh
	6qUSAUlgu45Zxo++/b9zCaxRpZAXfMMuHoHNQG98iPA/atleS1McwpWXuqpldC87
	PThg2bAQlgNnM6W4WO8Pk6C3wdDpq3+/mURBL9n6oj/Jd1bIovACoNhgnHNJz9iG
	o8BsXbvDuVTmZRcv55JqoHv0pZWIHsMfuGM1f/aONM4pLk+/7UUVXQopmrTpbLIu
	32iWiLX2ibHMNNw2FdkVzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435112; x=
	1746521512; bh=S/iTBBZCqlvNt+PhtoicppRm8ryjtsC6uePgDuwpjPA=; b=v
	C29tbg3mKNGd/UkNBWJnVY4vUYrRRveIhG7jSL34lO/n5c5JHd/DQIiieHL0GDxI
	JILh37F1ZWkWyB+PHVpIQ9jkE9KYAKcLl7sGLMSTDiwISbWKzLTjNbYdXpqqF+lq
	jsYhjhWPS+C/w89W9/KVkiBQafcVIjZFxiSM4p0cCMtFzYAbdZcNzT+NRhhTQA3i
	Vcypmfv0tB+U/bavgvst5uBbd1zeJ20aQkDe9sZ7FfPKY957QtEFVY3j5qeGoC+j
	4OSRfi6Uy9xqmmHVsXZOLXRdsuparrPB7DUK14IvLw6ifNy6Rw3wFsTMvxppijZT
	gcrDjNc+yOTSjps6IGIAw==
X-ME-Sender: <xms:KHwYaOh64znqxBuRJ7JpcNpWTIZl9OGJxmgB4DAIM__FtSSaa667QQ>
    <xme:KHwYaPDgHcyGFIbuT5LpRFc_aUUc0b7Jr3KZPBrTU74ZjdBonKjOsl5ZEu122p4gO
    1NlV0YWdxDcQ1NbpQ>
X-ME-Received: <xmr:KHwYaGG-cDU9uSMX-AbaSZb82gC5n5GzZt6BjgOOEHb5N5j-cqR6niHO5PeV2oTlWwaOGksrVNd4YZUgpaGH0w_Y0DbAxz6Xeg2FhOlPldILNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KHwYaHShW_CXDP1Ic0bGB5bS9mVt9SUDEq2ISp8vVkqMNBPt5UPB0A>
    <xmx:KHwYaLy6RVUWBMBU3PL0k_SGtmWhXhbmcAnBKzgn8cssjiYZmaDwag>
    <xmx:KHwYaF4GrKLVYtvuBTLG9Axu12FdhGbCTFF5wX63_B5xJsTcaa0X9Q>
    <xmx:KHwYaIy7PKYGI9q1NVRpyIyUX3gLDN3kE9jw3PjVtTJIyEw4u4YnHg>
    <xmx:KHwYaKvYwQ5t76i8NeWkFJ5wBvINrN0c7UUK-sPovDTlOa8Gbv1-xgQY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c70764f8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:44 +0200
Subject: [PATCH v4 4/7] worktree: expose function to retrieve worktree
 names
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-4-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.49.0.987.g0cc8ee98dc.dirty

