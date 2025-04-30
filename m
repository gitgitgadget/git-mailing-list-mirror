Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F9823C368
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008721; cv=none; b=VzEJie3w6+qoyEXdVCeUaUjqQBaU9iLS6mgX/U4Gi5535CpB/Nl6CZjfw0yUgCPapOxIL7sGVAoUd7wzNZQ1BnsBAwpLTC4Va7aRybxh/i+QlgoZIhvWmeEYBS53gw9FiwKxWwubMpMBB75fURSFyuu2SreZ+BMvizEY7ccKIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008721; c=relaxed/simple;
	bh=8e7rqB8ui5AKoKouYEDP8XFM743EJgfb4dVIRHzd4VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDKTUJPRXb7QoP0abOoLpqiajkWX7MEY3DZVq2/4APqPL6JfpKCf7gdcrlWezPukAx1uMyRZwicR871BtCzK8w+qQKvp0iPvYffZCFmdnxrc5a4DedDfPPZr1VG9pdnOKjItLwthYYIlLR+8BUGGzJBNtpsFzzkJvlwsdd3HXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D1xFw/XK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsyDTZe6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D1xFw/XK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsyDTZe6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB8DF2540206;
	Wed, 30 Apr 2025 06:25:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 30 Apr 2025 06:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008717;
	 x=1746095117; bh=sZXl1m1PF5VF6oaq43Q6xSY58xacRrhinDw+7wGaMQs=; b=
	D1xFw/XKdPylV8jdHsj2bOz3332FIkhr1+hqmFj1RsIL2jp9wJuPm1djvauPuIaU
	yYguIILI+RvQKwNRDK2iscLA4y6vTYVWfnsA+cvGHJgvuuaAWBcj99o7SnRGgggU
	MhQaFNqHgj2oCVhNhz1GtsIdnb0V4QemMNPGYU3DY1Qg3vclcbzbukPZB1h6oqqH
	e0XJYj7xhXyl0nyGV+ScUAT9H/HW5IBFPyUMh2uH5RRYF2EBS0pQgj3lhTwfG7RI
	5+ajEZ6WqR/A2cpuA7xLWTbE9evLum6CjqzBD+WJYWd70QX+t7zH8gvHwTRpObLt
	cZMCKQ3qLJt9RvXAja5kCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008717; x=
	1746095117; bh=sZXl1m1PF5VF6oaq43Q6xSY58xacRrhinDw+7wGaMQs=; b=N
	syDTZe6kqLQkOjY5uDkIS5lLxbomruZz5IhWBhNWlNrJSOBnLScpIEMKRCjHteHL
	7O4WSZCyU3c7Z6dBmEBlt7XXffqust1Y51ow66H58lF+Pxb7r/O6fFvPpHWPRKQs
	6qWjKIZQcWPdYFm8ytoW1HAD5qx0OQlD4mc8sLfU7QygQMBbT7amUF3hBbcCr9+s
	FMBnjuhzMIhdKeLXZrNbiY8vZBDxIENMGHRSo6l8kEy+qafh1oB9+daMEaBtKC0g
	frz1kHIVQFzRO3wJA7SrVmuZ1BECej2+cB6aTmEitmg31xnZQv9OKiB/neevCu9F
	pNeg5tWe3pBM0ZPPUcGsg==
X-ME-Sender: <xms:jfoRaCFg92WqzOjbeRK-PixN8EOvKRIFRZfoARJ1_FiVojrl8e3XJg>
    <xme:jfoRaDWwEy88MZz4oar52IqAFqi-ERPSKQ2itVwiazUL6Vi0gx8ClO7P9UEF9z4Sr
    mhh56K8A7lKyatLTg>
X-ME-Received: <xmr:jfoRaML87RldUShQFGZVOEWPHEGdxa9TBWi1j6TU9pjFY7fTFZyUcJLYd21cmlXOtzRwIKFk1gANTe4VIjHShpwZg6r09oJHTuAXSeKKd7Vs-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jfoRaMFWJl9ZmKD-jB8wq1M_c1TmvHCah63OkHMS9OW8NFfKdzNrFA>
    <xmx:jfoRaIUadIkP_KGbZ319C8lQBV-tK6Ynyxo_c9fbyO1-kwPbcTEwvA>
    <xmx:jfoRaPNkxR-VEs7CRlsOQQl1A_AS7BIvSwbVqSOm8RctUOAafl493Q>
    <xmx:jfoRaP3eXxxRAne7TwL2-1v4bNVlOSA10Wq3pD9dLxRl6f2sHHPNSw>
    <xmx:jfoRaPyPIl_33MO-UdrEjpCFG2N-KmbswXHzyZrzxUqP02nKjt5c_UHd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id decf9d29 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:10 +0200
Subject: [PATCH v2 6/8] rerere: provide function to collect stale entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-6-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

We're about to add another task for git-maintenance(1) that prunes stale
rerere entries via `git rerere gc`. The condition of when to run this
subcommand will be configurable so that the subcommand is only executed
when a certain number of stale rerere entries exists. This requires us
to know about the number of stale rerere entries in the first place,
which is non-trivial to figure out.

Refactor `rerere_gc()` and `prune_one()` so that garbage collection is
split into three phases:

  1. We collect any stale rerere entries and directories that are about
     to become empty.

  2. Prune all stale rerere entries.

  3. Remove all directories that should have become empty in (2).

By splitting out the collection of stale entries we can trivially expose
this function to external callers and thus reuse it in later steps.

This refactoring is not expected to result in a user-visible change in
behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c | 92 ++++++++++++++++++++++++++++++++++++++++++++--------------------
 rerere.h | 14 ++++++++++
 2 files changed, 78 insertions(+), 28 deletions(-)

diff --git a/rerere.c b/rerere.c
index 740e8ad1a0b..eb06e5f8bea 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1202,8 +1202,8 @@ static void unlink_rr_item(struct rerere_id *id)
 	strbuf_release(&buf);
 }
 
-static void prune_one(struct rerere_id *id,
-		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
+static int is_stale(struct rerere_id *id,
+		    timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
 {
 	timestamp_t then;
 	timestamp_t cutoff;
@@ -1214,11 +1214,11 @@ static void prune_one(struct rerere_id *id,
 	else {
 		then = rerere_created_at(id);
 		if (!then)
-			return;
+			return 0;
 		cutoff = cutoff_noresolve;
 	}
-	if (then < cutoff)
-		unlink_rr_item(id);
+
+	return then < cutoff;
 }
 
 /* Does the basename in "path" look plausibly like an rr-cache entry? */
@@ -1229,29 +1229,35 @@ static int is_rr_cache_dirname(const char *path)
 	return !parse_oid_hex(path, &oid, &end) && !*end;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr)
+int rerere_collect_stale_entries(struct repository *r,
+				 struct string_list *prunable_dirs,
+				 struct rerere_id **prunable_entries,
+				 size_t *prunable_entries_nr)
 {
-	struct string_list to_remove = STRING_LIST_INIT_DUP;
-	DIR *dir;
-	struct dirent *e;
-	int i;
 	timestamp_t now = time(NULL);
 	timestamp_t cutoff_noresolve = now - 15 * 86400;
 	timestamp_t cutoff_resolve = now - 60 * 86400;
 	struct strbuf buf = STRBUF_INIT;
+	size_t prunable_entries_alloc;
+	struct dirent *e;
+	DIR *dir = NULL;
+	int ret;
 
-	if (setup_rerere(r, rr, 0) < 0)
-		return;
+	*prunable_entries = NULL;
+	*prunable_entries_nr = 0;
+	prunable_entries_alloc = 0;
 
-	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
+	repo_config_get_expiry_in_days(r, "gc.rerereresolved",
 				       &cutoff_resolve, now);
-	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
+	repo_config_get_expiry_in_days(r, "gc.rerereunresolved",
 				       &cutoff_noresolve, now);
-	git_config(git_default_config, NULL);
-	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
-	if (!dir)
-		die_errno(_("unable to open rr-cache directory"));
-	/* Collect stale conflict IDs ... */
+
+	dir = opendir(repo_git_path_replace(r, &buf, "rr-cache"));
+	if (!dir) {
+		ret = error_errno(_("unable to open rr-cache directory"));
+		goto out;
+	}
+
 	while ((e = readdir_skip_dot_and_dotdot(dir))) {
 		struct rerere_dir *rr_dir;
 		struct rerere_id id;
@@ -1266,23 +1272,53 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 		for (id.variant = 0, id.collection = rr_dir;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
-			prune_one(&id, cutoff_resolve, cutoff_noresolve);
-			if (id.collection->status[id.variant])
+			if (is_stale(&id, cutoff_resolve, cutoff_noresolve)) {
+				ALLOC_GROW(*prunable_entries, *prunable_entries_nr + 1,
+					   prunable_entries_alloc);
+				(*prunable_entries)[(*prunable_entries_nr)++] = id;
+			} else {
 				now_empty = 0;
+			}
 		}
 		if (now_empty)
-			string_list_append(&to_remove, e->d_name);
+			string_list_append(prunable_dirs, e->d_name);
 	}
-	closedir(dir);
 
-	/* ... and then remove the empty directories */
-	for (i = 0; i < to_remove.nr; i++)
-		rmdir(repo_git_path_replace(the_repository, &buf,
-					    "rr-cache/%s", to_remove.items[i].string));
+	ret = 0;
+
+out:
+	strbuf_release(&buf);
+	if (dir)
+		closedir(dir);
+	return ret;
+}
+
+void rerere_gc(struct repository *r, struct string_list *rr)
+{
+	struct string_list prunable_dirs = STRING_LIST_INIT_DUP;
+	struct rerere_id *prunable_entries;
+	struct strbuf buf = STRBUF_INIT;
+	size_t prunable_entries_nr;
+
+	if (setup_rerere(r, rr, 0) < 0)
+		return;
+
+	git_config(git_default_config, NULL);
+
+	if (rerere_collect_stale_entries(r, &prunable_dirs, &prunable_entries,
+					 &prunable_entries_nr) < 0)
+		exit(127);
+
+	for (size_t i = 0; i < prunable_entries_nr; i++)
+		unlink_rr_item(&prunable_entries[i]);
+	for (size_t i = 0; i < prunable_dirs.nr; i++)
+		rmdir(repo_git_path_replace(r, &buf, "rr-cache/%s",
+					    prunable_dirs.items[i].string));
 
-	string_list_clear(&to_remove, 0);
+	string_list_clear(&prunable_dirs, 0);
 	rollback_lock_file(&write_lock);
 	strbuf_release(&buf);
+	free(prunable_entries);
 }
 
 /*
diff --git a/rerere.h b/rerere.h
index d4b5f7c9320..fd5a2388b06 100644
--- a/rerere.h
+++ b/rerere.h
@@ -37,6 +37,20 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
+
+/*
+ * Collect prunable rerere entries that would be garbage collected via
+ * `rerere_gc()`. Whether or not an entry is prunable depends on both
+ * "gc.rerereResolved" and "gc.rerereUnresolved".
+ *
+ * Returns 0 on success, a negative error code in case entries could not be
+ * collected.
+ */
+int rerere_collect_stale_entries(struct repository *r,
+				 struct string_list *prunable_dirs,
+				 struct rerere_id **prunable_entries,
+				 size_t *prunable_entries_nr);
+
 void rerere_gc(struct repository *, struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \

-- 
2.49.0.987.g0cc8ee98dc.dirty

