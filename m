Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051CAC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D047261154
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJSWqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJSWqE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:46:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E10C061746
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n9-20020a63f809000000b0026930ed1b24so12314233pgh.23
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gmxLhRZrORi4D9PP/yfXpBpmU3cLSKRAedRgN9mijcQ=;
        b=Dj9yotDPLOi6FjZ7tRab7Hv7cQGPqspQVl5esznHJ5u6ryIVyW40VRO7O1w8Jh3wag
         sSxEXnxsNA5Mmrd7FOBcm7mE9ShawVjeZWJ2VSTLS0ZL/fCzErd2Llp9USAoK4PS2O8o
         zyf+8WKPsjzFtgjEAfu/XcC0uq4scgPYzeO/uexRXdsIZF+daZy/bgAsD0rChdY5xgMq
         q6WXS9Stj+rqYCQqmZ3C9zgTN9kCh+L2N/MGYy7jIZJke7l7gROKH23X29M8rGvX1C2i
         xusBmr2aS+ZnuWtfugUEZEuRYHBASbMwqiyvCZsL/tYHqhYde5xLoPk0XQD7XAkHSlJm
         DcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gmxLhRZrORi4D9PP/yfXpBpmU3cLSKRAedRgN9mijcQ=;
        b=YH3Z/XkM2/JDOjLAmGgC0SflARi2eRyKPasr5d4X3ezv96YuBJnVn2mDQ/ht5Z4zrX
         iJIzFUYGZgYwvTy6bn+zbqBD76Zq+BCpIT3QfilV1HoD3zTBF2jmAiOVtXnlI6TVzhAS
         v3rT3zG+2Tf0/3/R0THKzw45nUb7uikj0fPNwgKEt3h/VLfDXEaKUbE6dDTuaSyW5KIs
         SyU1Gd2pz4W1aqIau8Rqv831CD+/Zub43SkE6ei+kaqxyrtNUHe2Q5phVbwYgPpWdv1b
         EELSIWuGpwISLIuw+nrbQ0SB1X8AYv0YYTWALOXteCmnICgckhQNDHUM6TtBmI/JIq3y
         0HIQ==
X-Gm-Message-State: AOAM532LeZXT85DdanLH0hxAwNfX8dlDbImzO1Gac9DiewhhR8mkBQz1
        3hT9wFJRHcs68REuSzCikppqsfOrMH6kqRLil2NkRH8GLpEUv+DxV9/gG9EgFhoZJapP0E/DPXU
        or0KI4x1abBT6xKbPg0cgqEmeo2EMzhOmRZbgNkIe5OizzaijvOWHbz73I5hkGC4=
X-Google-Smtp-Source: ABdhPJzf9wDAXoMeEcxZZqwqQffF2/CgUpSIWAE46U8Q/eymIpGDVA3nWy3JWkDQcmcLUiiiDqyYv/PaouFofQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4d0f:: with SMTP id
 mw15mr3019450pjb.207.1634683429988; Tue, 19 Oct 2021 15:43:49 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:43:37 -0700
In-Reply-To: <20211019224339.61881-1-chooglen@google.com>
Message-Id: <20211019224339.61881-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211013193127.76537-1-chooglen@google.com> <20211019224339.61881-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 2/4] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a struct remote_state member to structs that need to
'remember' their remote_state. Without changing external-facing
functions, replace the_repository->remote_state internally by using the
remote_state member where it is applicable i.e. when a function accepts
a struct that depends on the remote_state. If it is not applicable, add
a struct remote_state parameter instead.

As a result, external-facing functions are still tied to the_repository,
but most static functions no longer reference
the_repository->remote_state. The exceptions are those that are used in
a way that depends on external-facing functions e.g. the callbacks to
remote_get_1().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 153 ++++++++++++++++++++++++++-----------------------------
 remote.h |  10 ++++
 2 files changed, 81 insertions(+), 82 deletions(-)

diff --git a/remote.c b/remote.c
index 29c29fcc3b..e3ca44f735 100644
--- a/remote.c
+++ b/remote.c
@@ -68,15 +68,14 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 static void add_pushurl_alias(struct remote *remote, const char *url)
 {
 	const char *pushurl =
-		alias_url(url, &the_repository->remote_state->rewrites_push);
+		alias_url(url, &remote->remote_state->rewrites_push);
 	if (pushurl != url)
 		add_pushurl(remote, pushurl);
 }
 
 static void add_url_alias(struct remote *remote, const char *url)
 {
-	add_url(remote,
-		alias_url(url, &the_repository->remote_state->rewrites));
+	add_url(remote, alias_url(url, &remote->remote_state->rewrites));
 	add_pushurl_alias(remote, url);
 }
 
@@ -102,14 +101,19 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
 		return strcmp(a->name, b->name);
 }
 
-static inline void init_remotes_hash(void)
+/**
+ * NEEDSWORK: Now that the hashmap is in a struct, this should probably
+ * just be moved into remote_state_new().
+ */
+static inline void init_remotes_hash(struct remote_state *remote_state)
 {
-	if (!the_repository->remote_state->remotes_hash.cmpfn)
-		hashmap_init(&the_repository->remote_state->remotes_hash,
-			     remotes_hash_cmp, NULL, 0);
+	if (!remote_state->remotes_hash.cmpfn)
+		hashmap_init(&remote_state->remotes_hash, remotes_hash_cmp,
+			     NULL, 0);
 }
 
-static struct remote *make_remote(const char *name, int len)
+static struct remote *make_remote(struct remote_state *remote_state,
+				  const char *name, int len)
 {
 	struct remote *ret;
 	struct remotes_hash_key lookup;
@@ -118,13 +122,12 @@ static struct remote *make_remote(const char *name, int len)
 	if (!len)
 		len = strlen(name);
 
-	init_remotes_hash();
+	init_remotes_hash(remote_state);
 	lookup.str = name;
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
 
-	e = hashmap_get(&the_repository->remote_state->remotes_hash,
-			&lookup_entry, &lookup);
+	e = hashmap_get(&remote_state->remotes_hash, &lookup_entry, &lookup);
 	if (e)
 		return container_of(e, struct remote, ent);
 
@@ -132,18 +135,16 @@ static struct remote *make_remote(const char *name, int len)
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
+	ret->remote_state = remote_state;
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
-	ALLOC_GROW(the_repository->remote_state->remotes,
-		   the_repository->remote_state->remotes_nr + 1,
-		   the_repository->remote_state->remotes_alloc);
-	the_repository->remote_state
-		->remotes[the_repository->remote_state->remotes_nr++] = ret;
+	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
+		   remote_state->remotes_alloc);
+	remote_state->remotes[remote_state->remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	if (hashmap_put_entry(&the_repository->remote_state->remotes_hash, ret,
-			      ent))
+	if (hashmap_put_entry(&remote_state->remotes_hash, ret, ent))
 		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
 }
@@ -177,27 +178,25 @@ static void add_merge(struct branch *branch, const char *name)
 	branch->merge_name[branch->merge_nr++] = name;
 }
 
-static struct branch *make_branch(const char *name, size_t len)
+static struct branch *make_branch(struct remote_state *remote_state,
+				  const char *name, size_t len)
 {
 	struct branch *ret;
 	int i;
 
-	for (i = 0; i < the_repository->remote_state->branches_nr; i++) {
-		if (!strncmp(name,
-			     the_repository->remote_state->branches[i]->name,
-			     len) &&
-		    !the_repository->remote_state->branches[i]->name[len])
-			return the_repository->remote_state->branches[i];
+	for (i = 0; i < remote_state->branches_nr; i++) {
+		if (!strncmp(name, remote_state->branches[i]->name, len) &&
+		    !remote_state->branches[i]->name[len])
+			return remote_state->branches[i];
 	}
 
-	ALLOC_GROW(the_repository->remote_state->branches,
-		   the_repository->remote_state->branches_nr + 1,
-		   the_repository->remote_state->branches_alloc);
+	ALLOC_GROW(remote_state->branches, remote_state->branches_nr + 1,
+		   remote_state->branches_alloc);
 	CALLOC_ARRAY(ret, 1);
-	the_repository->remote_state
-		->branches[the_repository->remote_state->branches_nr++] = ret;
+	remote_state->branches[remote_state->branches_nr++] = ret;
 	ret->name = xstrndup(name, len);
 	ret->refname = xstrfmt("refs/heads/%s", ret->name);
+	ret->remote_state = remote_state;
 
 	return ret;
 }
@@ -313,10 +312,12 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	struct remote_state *remote_state = cb;
+
 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
 		if (!name)
 			return 0;
-		branch = make_branch(name, namelen);
+		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
 			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, "pushremote")) {
@@ -335,16 +336,14 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!strcmp(subkey, "insteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			rewrite = make_rewrite(
-				&the_repository->remote_state->rewrites, name,
-				namelen);
+			rewrite = make_rewrite(&remote_state->rewrites, name,
+					       namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		} else if (!strcmp(subkey, "pushinsteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			rewrite = make_rewrite(
-				&the_repository->remote_state->rewrites_push,
-				name, namelen);
+			rewrite = make_rewrite(&remote_state->rewrites_push,
+					       name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
@@ -354,9 +353,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 
 	/* Handle remote.* variables */
 	if (!name && !strcmp(subkey, "pushdefault"))
-		return git_config_string(
-			&the_repository->remote_state->pushremote_name, key,
-			value);
+		return git_config_string(&remote_state->pushremote_name, key,
+					 value);
 
 	if (!name)
 		return 0;
@@ -366,7 +364,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			name);
 		return 0;
 	}
-	remote = make_remote(name, namelen);
+	remote = make_remote(remote_state, name, namelen);
 	remote->origin = REMOTE_CONFIG;
 	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
 	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
@@ -436,61 +434,51 @@ static int handle_config(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-static void alias_all_urls(void)
+static void alias_all_urls(struct remote_state *remote_state)
 {
 	int i, j;
-	for (i = 0; i < the_repository->remote_state->remotes_nr; i++) {
+	for (i = 0; i < remote_state->remotes_nr; i++) {
 		int add_pushurl_aliases;
-		if (!the_repository->remote_state->remotes[i])
+		if (!remote_state->remotes[i])
 			continue;
-		for (j = 0;
-		     j < the_repository->remote_state->remotes[i]->pushurl_nr;
-		     j++) {
-			the_repository->remote_state->remotes[i]->pushurl[j] =
-				alias_url(
-					the_repository->remote_state->remotes[i]
-						->pushurl[j],
-					&the_repository->remote_state->rewrites);
+		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
+			remote_state->remotes[i]->pushurl[j] =
+				alias_url(remote_state->remotes[i]->pushurl[j],
+					  &remote_state->rewrites);
 		}
-		add_pushurl_aliases =
-			the_repository->remote_state->remotes[i]->pushurl_nr ==
-			0;
-		for (j = 0;
-		     j < the_repository->remote_state->remotes[i]->url_nr;
-		     j++) {
+		add_pushurl_aliases = remote_state->remotes[i]->pushurl_nr == 0;
+		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
 			if (add_pushurl_aliases)
 				add_pushurl_alias(
-					the_repository->remote_state->remotes[i],
-					the_repository->remote_state->remotes[i]
-						->url[j]);
-			the_repository->remote_state->remotes[i]
-				->url[j] = alias_url(
-				the_repository->remote_state->remotes[i]->url[j],
-				&the_repository->remote_state->rewrites);
+					remote_state->remotes[i],
+					remote_state->remotes[i]->url[j]);
+			remote_state->remotes[i]->url[j] =
+				alias_url(remote_state->remotes[i]->url[j],
+					  &remote_state->rewrites);
 		}
 	}
 }
 
-static void read_config(void)
+static void read_config(struct repository *repo)
 {
-	static int loaded;
 	int flag;
 
-	if (loaded)
+	if (repo->remote_state->initialized)
 		return;
-	loaded = 1;
+	repo->remote_state->initialized = 1;
 
-	the_repository->remote_state->current_branch = NULL;
+	repo->remote_state->current_branch = NULL;
 	if (startup_info->have_repository) {
-		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
+		const char *head_ref = refs_resolve_ref_unsafe(
+			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-			the_repository->remote_state->current_branch =
-				make_branch(head_ref, strlen(head_ref));
+			repo->remote_state->current_branch = make_branch(
+				repo->remote_state, head_ref, strlen(head_ref));
 		}
 	}
-	git_config(handle_config, NULL);
-	alias_all_urls();
+	repo_config(repo, handle_config, repo->remote_state);
+	alias_all_urls(repo->remote_state);
 }
 
 static int valid_remote_nick(const char *name)
@@ -524,10 +512,10 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 			*explicit = 1;
 		return branch->pushremote_name;
 	}
-	if (the_repository->remote_state->pushremote_name) {
+	if (branch->remote_state->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
-		return the_repository->remote_state->pushremote_name;
+		return branch->remote_state->pushremote_name;
 	}
 	return remote_for_branch(branch, explicit);
 }
@@ -560,7 +548,7 @@ static struct remote *remote_get_1(const char *name,
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config();
+	read_config(the_repository);
 
 	if (name)
 		name_given = 1;
@@ -568,7 +556,7 @@ static struct remote *remote_get_1(const char *name,
 		name = get_default(the_repository->remote_state->current_branch,
 				   &name_given);
 
-	ret = make_remote(name, 0);
+	ret = make_remote(the_repository->remote_state, name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
 			read_remotes_file(ret);
@@ -604,7 +592,7 @@ int remote_is_configured(struct remote *remote, int in_repo)
 int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config();
+	read_config(the_repository);
 	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =
@@ -1717,11 +1705,12 @@ struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
 
-	read_config();
+	read_config(the_repository);
 	if (!name || !*name || !strcmp(name, "HEAD"))
 		ret = the_repository->remote_state->current_branch;
 	else
-		ret = make_branch(name, strlen(name));
+		ret = make_branch(the_repository->remote_state, name,
+				  strlen(name));
 	set_merge(ret);
 	return ret;
 }
diff --git a/remote.h b/remote.h
index d21c035f1b..d268a92ebb 100644
--- a/remote.h
+++ b/remote.h
@@ -52,6 +52,8 @@ struct remote_state {
 
 	struct rewrites rewrites;
 	struct rewrites rewrites_push;
+
+	int initialized;
 };
 
 void remote_state_clear(struct remote_state *remote_state);
@@ -110,6 +112,10 @@ struct remote {
 
 	/* The method used for authenticating against `http_proxy`. */
 	char *http_proxy_authmethod;
+
+	/** The remote_state that this remote belongs to. This is only meant to
+	 * be used by remote_* functions. */
+	struct remote_state *remote_state;
 };
 
 /**
@@ -318,6 +324,10 @@ struct branch {
 	int merge_alloc;
 
 	const char *push_tracking_ref;
+
+	/** The remote_state that this branch belongs to. This is only meant to
+	 * be used by branch_* functions. */
+	struct remote_state *remote_state;
 };
 
 struct branch *branch_get(const char *name);
-- 
2.33.GIT

