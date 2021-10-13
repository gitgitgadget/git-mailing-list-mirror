Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F8AC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0038611BD
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhJMTdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbhJMTdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:33:41 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC476C061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:31:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y8-20020a05620a09c800b0045f77ea0f98so2663876qky.23
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aNfoJkya1ebuBDlE+St8DQ4obz6RQybPxTF3J4BMxO8=;
        b=G4T8KhZMuQeHHuTn7t287QG1V2wdg+n/dtzvbgLqUI1gAYOINz/4X8Sa8G1n2/4kjH
         3a/eOMdeiCPKkUVLcZ5TlUfLEaSgkgV9BpZe+01IcE6Jc/ZUK8fqEU7E5W7PVUV/ooIx
         g1sGqPGqgc/NEPpV6rKPKcrkMLIpxBB30xUn/bWDbjfeQzWofOF2+kAl+PxchF0sFH2U
         VAu56gf5US4dD3RtK0FAVksELISDaKweeSL//1r9ibfyirOu7oRBvk0YOnj/j+kQfan5
         tfYiXneyWlu4s6m8nM3CQrVctlPJnka99TzTOrpAMQ5V6QJWCC/ErHFu9Q2+I+47VyFT
         YUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aNfoJkya1ebuBDlE+St8DQ4obz6RQybPxTF3J4BMxO8=;
        b=IxwdrwGnY516iMvgQ6HUwND3OtnKlb/8z17NK4JVb9zNoohYQiDcAB07hiNSc5PdAo
         4VDpdZD4rcTq0ssc+7PirGXSQaMGTm/ZnuVsnCu3EX9AJaI+n9gZrLcfodYc8Y0Ev6d4
         DLROGu90VGI8sN4FckL5XyTxjRLRtM1NFqK74CrHpEWdlTUUIU2fSwj/BLB4LY3+vQRq
         Lzu2v+0nX2SBZ8crcHb+PPkVw+dEubtY2TQod7t4Pq2tnsr8DwuDv6sycIM7EfqDhprw
         2rzsWrh2H8HZ1aUpWN3WRCwXqpgq2ogatsrZ5F9HnDpb0LS1DXp65pQUiFOIxwXk05Hx
         c2uQ==
X-Gm-Message-State: AOAM5332Rz0eW9tGWw4ftyWrQrpw3BsgdldklGAo2eJD0FJzDCNDpQ5j
        fyaQB6mjW38ma/D1r6LkepAzGk4mpKcifl2dK7+W5UFCuoOOFkIiWqB22f6vGU81S/degT0IL/f
        2yKidkD3mtMFvCgh8yvKStiMGSVC7/mOqVszDozfVKFRK7xS5y2ZB33mzG87XOm0=
X-Google-Smtp-Source: ABdhPJyPC0PI6NHT5TdYKxccgOjfSFo+o98IONIcPqhuajh0Iq+ppmZx1jMvcvPxmt9m4sBt6qrsd/PjYcKxBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:ac8:5755:: with SMTP id
 21mr1367633qtx.353.1634153496736; Wed, 13 Oct 2021 12:31:36 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:31:26 -0700
In-Reply-To: <20211013193127.76537-1-chooglen@google.com>
Message-Id: <20211013193127.76537-3-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com> <20211013193127.76537-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 2/3] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In internal-facing functions, replace the_repository->remote_state with
a struct remote_state parameter, but do not change external-facing
functions.

As a result, most static functions no longer reference
the_repository->remote_state. The exceptions are those that are used in
a way that depends on external-facing functions e.g. the callbacks to
remote_get_1().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 165 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 78 insertions(+), 87 deletions(-)

diff --git a/remote.c b/remote.c
index 29c29fcc3b..850ccd8eff 100644
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
@@ -102,14 +102,19 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
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
@@ -118,13 +123,12 @@ static struct remote *make_remote(const char *name, int len)
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
 
@@ -135,15 +139,12 @@ static struct remote *make_remote(const char *name, int len)
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
@@ -177,25 +178,22 @@ static void add_merge(struct branch *branch, const char *name)
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
 
@@ -237,7 +235,8 @@ static const char *skip_spaces(const char *s)
 	return s;
 }
 
-static void read_remotes_file(struct remote *remote)
+static void read_remotes_file(struct remote_state *remote_state,
+			      struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
@@ -252,7 +251,8 @@ static void read_remotes_file(struct remote *remote)
 		strbuf_rtrim(&buf);
 
 		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote, xstrdup(skip_spaces(v)));
+			add_url_alias(remote_state, remote,
+				      xstrdup(skip_spaces(v)));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
@@ -262,7 +262,8 @@ static void read_remotes_file(struct remote *remote)
 	fclose(f);
 }
 
-static void read_branches_file(struct remote *remote)
+static void read_branches_file(struct remote_state *remote_state,
+			       struct remote *remote)
 {
 	char *frag;
 	struct strbuf buf = STRBUF_INIT;
@@ -294,7 +295,7 @@ static void read_branches_file(struct remote *remote)
 	else
 		frag = (char *)git_default_branch_name(0);
 
-	add_url_alias(remote, strbuf_detach(&buf, NULL));
+	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -313,10 +314,12 @@ static int handle_config(const char *key, const char *value, void *cb)
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
@@ -335,16 +338,14 @@ static int handle_config(const char *key, const char *value, void *cb)
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
@@ -354,9 +355,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 
 	/* Handle remote.* variables */
 	if (!name && !strcmp(subkey, "pushdefault"))
-		return git_config_string(
-			&the_repository->remote_state->pushremote_name, key,
-			value);
+		return git_config_string(&remote_state->pushremote_name, key,
+					 value);
 
 	if (!name)
 		return 0;
@@ -366,7 +366,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			name);
 		return 0;
 	}
-	remote = make_remote(name, namelen);
+	remote = make_remote(remote_state, name, namelen);
 	remote->origin = REMOTE_CONFIG;
 	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
 	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
@@ -436,42 +436,32 @@ static int handle_config(const char *key, const char *value, void *cb)
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
+static void read_config(struct remote_state *remote_state)
 {
 	static int loaded;
 	int flag;
@@ -480,17 +470,17 @@ static void read_config(void)
 		return;
 	loaded = 1;
 
-	the_repository->remote_state->current_branch = NULL;
+	remote_state->current_branch = NULL;
 	if (startup_info->have_repository) {
 		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-			the_repository->remote_state->current_branch =
-				make_branch(head_ref, strlen(head_ref));
+			remote_state->current_branch = make_branch(
+				remote_state, head_ref, strlen(head_ref));
 		}
 	}
-	git_config(handle_config, NULL);
-	alias_all_urls();
+	git_config(handle_config, remote_state);
+	alias_all_urls(remote_state);
 }
 
 static int valid_remote_nick(const char *name)
@@ -560,7 +550,7 @@ static struct remote *remote_get_1(const char *name,
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config();
+	read_config(the_repository->remote_state);
 
 	if (name)
 		name_given = 1;
@@ -568,15 +558,15 @@ static struct remote *remote_get_1(const char *name,
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
@@ -604,7 +594,7 @@ int remote_is_configured(struct remote *remote, int in_repo)
 int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config();
+	read_config(the_repository->remote_state);
 	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =
@@ -1717,11 +1707,12 @@ struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
 
-	read_config();
+	read_config(the_repository->remote_state);
 	if (!name || !*name || !strcmp(name, "HEAD"))
 		ret = the_repository->remote_state->current_branch;
 	else
-		ret = make_branch(name, strlen(name));
+		ret = make_branch(the_repository->remote_state, name,
+				  strlen(name));
 	set_merge(ret);
 	return ret;
 }
-- 
2.33.0.882.g93a45727a2-goog

