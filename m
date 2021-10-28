Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A3C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECCE610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJ1Sdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhJ1Sdm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957E2C061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:15 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a191-20020a621ac8000000b0047c1b9c2a4bso3711729pfa.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w9nd/yTJfBRkjUwg1AqgIGDRGZdH94hqIqwJjWK8730=;
        b=tNbBgysO8rFF3gY5gFp48A2SRUj+ieCTAuRbQtjuwfrf/Ph5YUiBn8QGW+WSmWiy0Q
         yn+KkGzfiCQdkZC9pgdhV/MJl4LsfmlUw8hKXeXt3Mn33gdOWJE+dI6GyMgaow+RtFCa
         1weSmEmwtWF8v1mswyHCzNtxTj/hDaCWHdNfuSfZxlNZT2k48lfO8UqhWmYpkr1IveCI
         S9uKOYLE9z+guDOObAEVfx4keS8M57BUZzS5AsCw8PTdVZdXZOlHLgrSitP5D4gjZEIL
         omc6Slf4xOZsyErDvedgFdHpcTXrfqVtzKV073eJLqbIdvdrgqoNSKSiQp1Urrk7tlVn
         Xnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w9nd/yTJfBRkjUwg1AqgIGDRGZdH94hqIqwJjWK8730=;
        b=xopUb1MLf20iNeeVuTnkPqtftdqY0iy4YoDwoY+9D7xo77Z7lg8PgPzMymF6KrxT1c
         iGRw8JNLtTPhXi/jcjoQgeqcahAYHN7LQWBlbPwn0/JbLW04pKlR/3Ld1JEcQtWSgH4w
         osEK2ELnltNO3LwZiIdN4MUC5bBfthShkEmbxL52EKzI3WDNDT4Q8AmTVITo22TdnzlH
         rQ+HSKrmaphQyUwiM7Tdq8ZIuvxQFTT+7Y9qFwh1V84+U26b2Xs62PWcI9+9amtADEte
         5lLbgceL23ICntWe/De4fgCSKX334BXyG9SgJbyeqaMV1X+lNt5vOeG7k+kDhgcz+hkV
         D5Zg==
X-Gm-Message-State: AOAM533zy2jkElhKQKVotcbXRsp/VqxmEtcu63ZgpI/FIZlNiKEBjgmX
        uoXw84QwBqBrFde2UTZh83Nk6ABKfE1cYK5KWxdnXBRyiZiE8oRHEjZYBfIKkw03KLr1sl8g8de
        9ZWTD0/9kqX3LZob2UMlUcN7EAx5BFe6N/SjKxWuPxVVT97a4iYnPkNl/39fxqBc=
X-Google-Smtp-Source: ABdhPJzFhy010FDpSHEvXG9/TiNS0hpCwY0D0n2BtTnMolO8b8liQbR+1UsUiJ70eej4PpSUSvWZBWxUu+RQiQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1995:b0:47c:1f59:a27a with SMTP
 id d21-20020a056a00199500b0047c1f59a27amr5894131pfl.36.1635445874947; Thu, 28
 Oct 2021 11:31:14 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:30:58 -0700
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211028183101.41013-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 3/6] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without changing external-facing functions, replace
the_repository->remote_state internally by adding a struct remote_state
parameter.

As a result, external-facing functions are still tied to the_repository,
but most static functions no longer reference
the_repository->remote_state. The exceptions are those that are used in
a way that depends on external-facing functions e.g. the callbacks to
remote_get_1().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 159 +++++++++++++++++++++++++------------------------------
 remote.h |   2 +
 2 files changed, 75 insertions(+), 86 deletions(-)

diff --git a/remote.c b/remote.c
index c2bb11242b..48374cc0e2 100644
--- a/remote.c
+++ b/remote.c
@@ -65,19 +65,19 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 	remote->pushurl[remote->pushurl_nr++] = pushurl;
 }
 
-static void add_pushurl_alias(struct remote *remote, const char *url)
+static void add_pushurl_alias(struct remote_state *remote_state,
+			      struct remote *remote, const char *url)
 {
-	const char *pushurl =
-		alias_url(url, &the_repository->remote_state->rewrites_push);
+	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
 	if (pushurl != url)
 		add_pushurl(remote, pushurl);
 }
 
-static void add_url_alias(struct remote *remote, const char *url)
+static void add_url_alias(struct remote_state *remote_state,
+			  struct remote *remote, const char *url)
 {
-	add_url(remote,
-		alias_url(url, &the_repository->remote_state->rewrites));
-	add_pushurl_alias(remote, url);
+	add_url(remote, alias_url(url, &remote_state->rewrites));
+	add_pushurl_alias(remote_state, remote, url);
 }
 
 struct remotes_hash_key {
@@ -102,7 +102,8 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
 		return strcmp(a->name, b->name);
 }
 
-static struct remote *make_remote(const char *name, int len)
+static struct remote *make_remote(struct remote_state *remote_state,
+				  const char *name, int len)
 {
 	struct remote *ret;
 	struct remotes_hash_key lookup;
@@ -115,8 +116,7 @@ static struct remote *make_remote(const char *name, int len)
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
 
-	e = hashmap_get(&the_repository->remote_state->remotes_hash,
-			&lookup_entry, &lookup);
+	e = hashmap_get(&remote_state->remotes_hash, &lookup_entry, &lookup);
 	if (e)
 		return container_of(e, struct remote, ent);
 
@@ -127,15 +127,12 @@ static struct remote *make_remote(const char *name, int len)
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
@@ -169,25 +166,22 @@ static void add_merge(struct branch *branch, const char *name)
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
 
@@ -229,7 +223,8 @@ static const char *skip_spaces(const char *s)
 	return s;
 }
 
-static void read_remotes_file(struct remote *remote)
+static void read_remotes_file(struct remote_state *remote_state,
+			      struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
@@ -244,7 +239,8 @@ static void read_remotes_file(struct remote *remote)
 		strbuf_rtrim(&buf);
 
 		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote, xstrdup(skip_spaces(v)));
+			add_url_alias(remote_state, remote,
+				      xstrdup(skip_spaces(v)));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
@@ -254,7 +250,8 @@ static void read_remotes_file(struct remote *remote)
 	fclose(f);
 }
 
-static void read_branches_file(struct remote *remote)
+static void read_branches_file(struct remote_state *remote_state,
+			       struct remote *remote)
 {
 	char *frag;
 	struct strbuf buf = STRBUF_INIT;
@@ -286,7 +283,7 @@ static void read_branches_file(struct remote *remote)
 	else
 		frag = (char *)git_default_branch_name(0);
 
-	add_url_alias(remote, strbuf_detach(&buf, NULL));
+	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -305,10 +302,12 @@ static int handle_config(const char *key, const char *value, void *cb)
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
@@ -327,16 +326,14 @@ static int handle_config(const char *key, const char *value, void *cb)
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
@@ -346,9 +343,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 
 	/* Handle remote.* variables */
 	if (!name && !strcmp(subkey, "pushdefault"))
-		return git_config_string(
-			&the_repository->remote_state->pushremote_name, key,
-			value);
+		return git_config_string(&remote_state->pushremote_name, key,
+					 value);
 
 	if (!name)
 		return 0;
@@ -358,7 +354,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			name);
 		return 0;
 	}
-	remote = make_remote(name, namelen);
+	remote = make_remote(remote_state, name, namelen);
 	remote->origin = REMOTE_CONFIG;
 	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
 	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
@@ -428,61 +424,51 @@ static int handle_config(const char *key, const char *value, void *cb)
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
+					remote_state, remote_state->remotes[i],
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
@@ -552,7 +538,7 @@ static struct remote *remote_get_1(const char *name,
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config();
+	read_config(the_repository);
 
 	if (name)
 		name_given = 1;
@@ -560,15 +546,15 @@ static struct remote *remote_get_1(const char *name,
 		name = get_default(the_repository->remote_state->current_branch,
 				   &name_given);
 
-	ret = make_remote(name, 0);
+	ret = make_remote(the_repository->remote_state, name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
-			read_remotes_file(ret);
+			read_remotes_file(the_repository->remote_state, ret);
 		if (!valid_remote(ret))
-			read_branches_file(ret);
+			read_branches_file(the_repository->remote_state, ret);
 	}
 	if (name_given && !valid_remote(ret))
-		add_url_alias(ret, name);
+		add_url_alias(the_repository->remote_state, ret, name);
 	if (!valid_remote(ret))
 		return NULL;
 	return ret;
@@ -596,7 +582,7 @@ int remote_is_configured(struct remote *remote, int in_repo)
 int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config();
+	read_config(the_repository);
 	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =
@@ -1709,11 +1695,12 @@ struct branch *branch_get(const char *name)
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
index d21c035f1b..85a730b8ef 100644
--- a/remote.h
+++ b/remote.h
@@ -52,6 +52,8 @@ struct remote_state {
 
 	struct rewrites rewrites;
 	struct rewrites rewrites_push;
+
+	int initialized;
 };
 
 void remote_state_clear(struct remote_state *remote_state);
-- 
2.33.GIT

