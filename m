Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02C22AE6D
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175457; cv=none; b=omCHWW3VkAC3Isy49+l9EUMgGXd8m5Vz9EiTdd9Sq82WVAM/BezuwtVohGqL7M3P+CjhltBr2H8lFrDThdSaYH+7pXXYcvAFw59qk9EfeQtV3vdSGKl/9bqKPhhrcTRIFkt0aD5+zRwtEPO7k5l34uQ1MTXic18ahkBei0GR4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175457; c=relaxed/simple;
	bh=V9BBXG+IACD0anz+yG3b2Vqmop5ilIYQ64ZghKT5tj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tw6mM+yUaqrHASm9o731AxPgG+CKGhDADnXn0BTD6McYGNPLvf33nG0GdlTFX8h6io4iXL+7NrH/QqrBg11qKpmR/SntCKeveIFmVE017fjEQ2rr3ikIGkT/8uE9hIDi89DEPUPV+CqEb0kVk1wJWWCRApnnFWoeQdhzIWG4bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqLkePFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCC3rc0v; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqLkePFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCC3rc0v"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81E9F11401EC;
	Fri,  2 May 2025 04:44:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 04:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175453;
	 x=1746261853; bh=S/iTBBZCqlvNt+PhtoicppRm8ryjtsC6uePgDuwpjPA=; b=
	IqLkePFk4X8q85E+leLDQ0kqHc0Suyt8LEHvDwpQ/ifGGF5zAFiIunHWKoDZF6H7
	r+XkUpAF1jY7JAvmDnBYmDab5Tt+iqPwH+5iFs4pYr7rda1QSNAKg3IW2MF8TM7l
	azVMW3KPjUTTEdJWEszlKJrpAtcjFKbHlZEAb50uGuSx1ljYg5GZbT4gB38uRo7i
	KBIAuqAaPS2QsELF67Mm3jAUDD4qkK8SExEHpU1TDn+D/HRVARxs6d5tD6EIdAgr
	oM9YMuiFw8lUYLULkIoHgORTqAkqn8uNI3/QW/Uu+nWMlN+qwtVy3RybeWILr6qk
	QncA/QSjpS6nzkFeOnLwog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175453; x=
	1746261853; bh=S/iTBBZCqlvNt+PhtoicppRm8ryjtsC6uePgDuwpjPA=; b=m
	CC3rc0vSqbIYcaseXs9h0yOwkf0XHKVaSvg3vfw9Gc5ONR+A3+v0vCpZ7F9HRdYd
	MnV+AXml6xLycAFVbLJsG8wF5Px1iVltln7BAV+6FoYEVh76xPyJnajPpwB/ismv
	khCPnvVqpUsFwoIu/cvdxSnf8Q2lsiAhcfCdfIi6RgZJhFQ8l1RzU4JoPtqC3cfI
	AgUjF889cF9IoDoN8aFBpOQJKfQZGGPpFm7tmE/j99plrFaQkeDJs1WJnxayHSvu
	wAji+wL0osN8nUel5A4JFkhpjjDk4oKxPCXqYBTK+SxpGM2fGV/q9vECye4FlD5Q
	iUBgzc9r0nO7g9UwDuPIQ==
X-ME-Sender: <xms:3YUUaGJxgQpHZQ81aWtTTLgLb5nuP39E-SboNMCvdY1RWfpNHQD0hw>
    <xme:3YUUaOJuSY8-ukzl0YWpfjrNeOdVVITnS8d_RXUekUkZCR1cBpMgm7NuLdc3bcJBl
    xQIuFNW7zci6C-OdA>
X-ME-Received: <xmr:3YUUaGuamyc4A6oJRhrsfbZQHUaGbMcC2UpyWrMUO5CHi2hD67WAhuP2dIBYiVnDnGE5am3T7xAam-VpAGU3UNqjvou-TjOSMQnnuez5Apg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3YUUaLZNhBNqGAyRIbWoNtbRqulzl8uOm0DQJOJ-V0lWGe0eVfMBEw>
    <xmx:3YUUaNZeMuHka1NcH_kGBDDeMyk6Gw6-FgQ8AXp83VoXFjjgxRqujA>
    <xmx:3YUUaHBB1aVPuUMhn0CIGGlxfRPxEpBQifqIMl8LoRnIJyGdsjGjQA>
    <xmx:3YUUaDYOdRo2hkmDoIKJsbRe6v_e_gb3dTQu7cWeFCHrkMf4Rqh3Tw>
    <xmx:3YUUaB2JfT0DENPMYiz0_gdJTaKv6qmF5pBFXqcXbUGgG_EPX4Bt_j-I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d25f93ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:44:01 +0200
Subject: [PATCH v3 4/7] worktree: expose function to retrieve worktree
 names
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-4-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
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

