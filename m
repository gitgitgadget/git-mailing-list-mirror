Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A1C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316E061251
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbhKRA4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242051AbhKRA4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:56:52 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCAAC061206
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:51 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so1855988pgo.21
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T+ETImNGszr/UXUnjr823Jp3cUJFSOV67dSZT8WrSAQ=;
        b=Xx638QLIbHBEjoBOrBcpE9N3v5Gs4UOWqp8Pzg7mFzKgOFLe8JPIwKCccVceAfyCRi
         8SA0qBGT3gJKAArh9T9bpse4FkMmsSxHb7kjh95Vg8JIMP421pjfN08lzf3/Oe7cKvmz
         edmIXBn5PNLxmiM+Z79UfaAycHI9tp1rnlp0+yJsQndQGBuQoLDHO7hx+aTnwy29NxKt
         IuvvjYpdrGtEEIph4LXq1PkRO8dIssZkO56ZvYtu6mhh/KtiP74ywtpp6CsEeoOQSExh
         VZ6hRzfwaxtltOZ7AFt1Zw2QYj+sUBRL2XiRx/KZnMfubqUWkICZpyYe25X6FiMotn6e
         TH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T+ETImNGszr/UXUnjr823Jp3cUJFSOV67dSZT8WrSAQ=;
        b=XXC0yuAqJFVKFqy41ciDkwV/gTB8u4PsXE0K/mfBqpVSEvUL29xaoc2rCKrlQfH2ih
         wJSRD/8ATsMqEGGdQ6yoiuoMORpHonpbWVOrKdUvrQ+ESAt4MGADEE8H34+na0ie2S5V
         iZq00mPn1lFY1ZAAGiGC5paCgJEVDNd64bsmoL9/p/zy0zbuzj5jj7lR81yrpwwmPiUm
         DwFd4fxmstqsgGFWhhl68kFUPNywdBAo3DQLpeVEBGUMl6DYmR6xBnBAvF5Lry1RVQ/q
         2kjYAkXCUEwyUpbHXT7IGUvAFtQ2RMIFaek5lVSgVPKtNXIFCb7MIrq9E+7CIWAWdOYn
         X/ig==
X-Gm-Message-State: AOAM530UUwnvQ75QSRELtSzzJvUcAbn7M2C4UnqmkjVOLlbZdqITsAsI
        I9Jhq6MHeqwFrHeYaJAFsjMXWjqzAydZwcfs4q9H+kgWmBjVZPEFPzl0rPnv/UfwulS/vHMtXsQ
        J0N13tRvbeBrpD1YTaYv3T9NhVgJxnSWLEgeu2bcdW/qwvCiVL5AevYcMo3KUB44=
X-Google-Smtp-Source: ABdhPJxkjLq9Dx50SYSrgCivVULyC3y8/wLmvMzyUv5msIzKxlDdRfDu5S++fzacuuvfpWnedYEgBLYlDJ6QjA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:230d:b0:49f:b8ad:ae23 with SMTP
 id h13-20020a056a00230d00b0049fb8adae23mr11205563pfh.80.1637196830557; Wed,
 17 Nov 2021 16:53:50 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:53:25 -0800
In-Reply-To: <20211118005325.64971-1-chooglen@google.com>
Message-Id: <20211118005325.64971-6-chooglen@google.com>
Mime-Version: 1.0
References: <id:20211028183101.41013-1-chooglen@google.com> <20211118005325.64971-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v5 5/5] remote: die if branch is not found in repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we would like external-facing functions to be
able to accept "struct repository" and "struct branch" as a pair. This
is useful for functions like pushremote_for_branch(), which need to take
values from the remote_state and branch, even if branch == NULL.
However, a caller may supply an unrelated repository and branch, which
is not supported behavior.

To prevent misuse, add a die_on_missing_branch() helper function that
dies if a given branch is not from a given repository. Speed up the
existence check by replacing the branches list with a branches_hash
hashmap.

Like read_config(), die_on_missing_branch() is only called from
non-static functions; static functions are less prone to misuse because
they have strong conventions for keeping remote_state and branch in
sync.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 84 +++++++++++++++++++++++++++++++++++++++++++++-----------
 remote.h |  5 ++--
 2 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/remote.c b/remote.c
index 88697e7e6d..c97c626eaa 100644
--- a/remote.c
+++ b/remote.c
@@ -166,25 +166,74 @@ static void add_merge(struct branch *branch, const char *name)
 	branch->merge_name[branch->merge_nr++] = name;
 }
 
+struct branches_hash_key {
+	const char *str;
+	int len;
+};
+
+static int branches_hash_cmp(const void *unused_cmp_data,
+			     const struct hashmap_entry *eptr,
+			     const struct hashmap_entry *entry_or_key,
+			     const void *keydata)
+{
+	const struct branch *a, *b;
+	const struct branches_hash_key *key = keydata;
+
+	a = container_of(eptr, const struct branch, ent);
+	b = container_of(entry_or_key, const struct branch, ent);
+
+	if (key)
+		return strncmp(a->name, key->str, key->len) ||
+		       a->name[key->len];
+	else
+		return strcmp(a->name, b->name);
+}
+
+static struct branch *find_branch(struct remote_state *remote_state,
+				  const char *name, size_t len)
+{
+	struct branches_hash_key lookup;
+	struct hashmap_entry lookup_entry, *e;
+
+	if (!len)
+		len = strlen(name);
+
+	lookup.str = name;
+	lookup.len = len;
+	hashmap_entry_init(&lookup_entry, memhash(name, len));
+
+	e = hashmap_get(&remote_state->branches_hash, &lookup_entry, &lookup);
+	if (e)
+		return container_of(e, struct branch, ent);
+
+	return NULL;
+}
+
+static void die_on_missing_branch(struct repository *repo,
+				  struct branch *branch)
+{
+	/* branch == NULL is always valid because it represents detached HEAD. */
+	if (branch &&
+	    branch != find_branch(repo->remote_state, branch->name, 0))
+		die("branch %s was not found in the repository", branch->name);
+}
+
 static struct branch *make_branch(struct remote_state *remote_state,
 				  const char *name, size_t len)
 {
 	struct branch *ret;
-	int i;
 
-	for (i = 0; i < remote_state->branches_nr; i++) {
-		if (!strncmp(name, remote_state->branches[i]->name, len) &&
-		    !remote_state->branches[i]->name[len])
-			return remote_state->branches[i];
-	}
+	ret = find_branch(remote_state, name, len);
+	if (ret)
+		return ret;
 
-	ALLOC_GROW(remote_state->branches, remote_state->branches_nr + 1,
-		   remote_state->branches_alloc);
 	CALLOC_ARRAY(ret, 1);
-	remote_state->branches[remote_state->branches_nr++] = ret;
 	ret->name = xstrndup(name, len);
 	ret->refname = xstrfmt("refs/heads/%s", ret->name);
 
+	hashmap_entry_init(&ret->ent, memhash(name, len));
+	if (hashmap_put_entry(&remote_state->branches_hash, ret, ent))
+		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
 }
 
@@ -500,6 +549,8 @@ static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 const char *remote_for_branch(struct branch *branch, int *explicit)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	return remotes_remote_for_branch(the_repository->remote_state, branch,
 					 explicit);
 }
@@ -524,6 +575,8 @@ remotes_pushremote_for_branch(struct remote_state *remote_state,
 const char *pushremote_for_branch(struct branch *branch, int *explicit)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	return remotes_pushremote_for_branch(the_repository->remote_state,
 					     branch, explicit);
 }
@@ -534,6 +587,8 @@ static struct remote *remotes_remote_get(struct remote_state *remote_state,
 const char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
@@ -1879,6 +1934,8 @@ static const char *branch_get_push_1(struct remote_state *remote_state,
 const char *branch_get_push(struct branch *branch, struct strbuf *err)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
@@ -2652,6 +2709,7 @@ struct remote_state *remote_state_new(void)
 	memset(r, 0, sizeof(*r));
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
+	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
 	return r;
 }
 
@@ -2667,11 +2725,5 @@ void remote_state_clear(struct remote_state *remote_state)
 	remote_state->remotes_nr = 0;
 
 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
-
-	for (i = 0; i < remote_state->branches_nr; i++) {
-		FREE_AND_NULL(remote_state->branches[i]);
-	}
-	FREE_AND_NULL(remote_state->branches);
-	remote_state->branches_alloc = 0;
-	remote_state->branches_nr = 0;
+	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
 }
diff --git a/remote.h b/remote.h
index 85a730b8ef..4a1209ae2c 100644
--- a/remote.h
+++ b/remote.h
@@ -43,9 +43,7 @@ struct remote_state {
 	int remotes_nr;
 	struct hashmap remotes_hash;
 
-	struct branch **branches;
-	int branches_alloc;
-	int branches_nr;
+	struct hashmap branches_hash;
 
 	struct branch *current_branch;
 	const char *pushremote_name;
@@ -292,6 +290,7 @@ int remote_find_tracking(struct remote *remote, struct refspec_item *refspec);
  * branch_get(name) for "refs/heads/{name}", or with branch_get(NULL) for HEAD.
  */
 struct branch {
+	struct hashmap_entry ent;
 
 	/* The short name of the branch. */
 	const char *name;
-- 
2.33.GIT

