Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89379238171
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008720; cv=none; b=IIgqQtWLW4+QhJtKOzDfHVTanX5GYaKdagt6aJGJzEzlrzY89TspNbFjiBOEqGwU7C41hKwLwhnsHD5aCHHz/Tyu7M960AwyMLPv+Ti1SxMk2sKMXQxwqLl1IhNl0u42YT5i3l+O8M7CewJg/Dey6kN+afGJ66YXIM+5Iwu8itI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008720; c=relaxed/simple;
	bh=V9BBXG+IACD0anz+yG3b2Vqmop5ilIYQ64ZghKT5tj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGmyOaGLfkqMgbEwuENfY8GRtmdvvU8Efa35dwZiqYReNkCWA/MRGnAtw5WtJUjad5zIxgFQrja802gK60Zf0Rdqa1x4JV0rxZMuW5oiWXDg264n2djjWVGaMokiiG8f/WtDYOoqI2Q6x2ajNQ9CawONeLfqZJTElFwZ4Dk0NtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eBdEGqEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOnvf0OQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eBdEGqEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOnvf0OQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A312A1140245;
	Wed, 30 Apr 2025 06:25:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 30 Apr 2025 06:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008716;
	 x=1746095116; bh=S/iTBBZCqlvNt+PhtoicppRm8ryjtsC6uePgDuwpjPA=; b=
	eBdEGqElRsdPsKn/MeCEULAMUug1IVeVADqvxj5/m/Wcx21i+gWu6cTA/Wk2AaRO
	0nOk1b1Zl9je1c4ZxNgw7uEPf2RIf8aeWPedtm8aTIxUBhMSmbAMMJCnh+KnSTZJ
	9A6y2TVmMZ17couFsrCs3J3DC3Itm63hwg6+CpF9WFeppBeizvPxS1Spg0Al0ha/
	uQ3vrj03do/ghmmQN4tDqO2q0cHR9oyZOAIyegVsDDzUSA3bK6V+xycLKXCHSHFk
	T9h8Y0lE2Cb09fQAQjpJiTjbULDpMvJE/z+A08ypS60BMAwGSAGOyWd+TKkYBG4v
	LcyO4iRdLUcMMBAl7liJgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008716; x=
	1746095116; bh=S/iTBBZCqlvNt+PhtoicppRm8ryjtsC6uePgDuwpjPA=; b=j
	Onvf0OQVXOVlKCW7q+gTEmBtOOYA8cWvw+HT/QsGw3YNKqoJuHKXtVyIy94DH9sc
	8NMPoyxpcz+Y17nUhaXQMaCCSewyvBJgDzvPj3vC5MxVFFK6VHvmeCjyjIi29KVC
	GOWoPy1wpu27QcqZJqVBccmdWMtyK1Z4b6gzxrPNGE7DioxQfdxtUMlX3ZFFfTfn
	/GKfTtQkGVp5tnMqV2AsHOfccWPE894VU4GjDxmIZZt71CScAwcaV0nEOxSMg2s2
	FKWD+XFgBmXu6CNV7+P5bDQUAxOX21JaAnmPKaADc34gA3U+lpjnSg+RvMcSW22d
	iIBCG6o90XtLkwyFfrmkw==
X-ME-Sender: <xms:jPoRaJT5H1Vep0ALXd_2ZFN-Bff9cRI4x9PcisoD5q80uZhUFSphDQ>
    <xme:jPoRaCxYPq3kgt3FRcYboFi5po6EMIgtLnNzS5fk4tXnJWn6bPYpD8Z9QUiT-QTOR
    P6o2WunsZOS9luZYw>
X-ME-Received: <xmr:jPoRaO1qsy7juAs3r8j2hg-Z4eRPqGnsRCxK08npbGRng3tILRyGbtMB73jReeRH8gNlU5P8G_vERe6b80tAWWZg8oXMjX7pRJRF7l2AcyNGcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jPoRaBDh1HEXw8rdFpB8nOhf75bBp9uyLSRjItthLQBWqothydrjaQ>
    <xmx:jPoRaCj421Cc2mKN9OuubW-PFmYrnq10zh0M4vZGC4vvWJfGs8uUUA>
    <xmx:jPoRaFo1YwQjT3mgYEoEWoN4zXVG3xxDx6hosBU_6agxZ-SXxTHCYQ>
    <xmx:jPoRaNgkwq1fPZldHJZwvg3r6-KsaeX7ti9gMRT5sssk0Xd3a0lppg>
    <xmx:jPoRaJ9IrPrxFqGkSt2ieRiFO5XV29Wce3mo3XZD9Sf1q9UMisxkQnMN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8ab5765 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:08 +0200
Subject: [PATCH v2 4/8] worktree: expose function to retrieve worktree
 names
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-4-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
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

