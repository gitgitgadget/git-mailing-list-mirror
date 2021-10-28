Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9DC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC66610D2
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhJ1Sdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhJ1Sdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:40 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1EAC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:13 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n9-20020a170902968900b0013f23b51142so3228613plp.8
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3KQ2sObVXYjj+dKwSYx0p6BoQGQt7qg8GvzWpJYqYAM=;
        b=Czg1KT6UEeVTvcw6nbD2EUqHTT4mfyHl/Z+spesRNxy+ycRtIbFmtW6rDd0th51lYX
         FES3PVw+oevnKTqH5ay8ZBU7oqRxmGCCRs5x5u5iKDoMlJeoCw/F5OZ3pe6irh45k9VH
         gVdiOE6PidxlPceugKbq+j7HvO+1mDnixZPg0GIld/nfX42y9/CL5yUsGKrBNQkgEtZS
         Ii+JEFgxAesyU16m6DoavA5klrOnnJIdZHIecs11qmmZbXcRvHb3oYhF+PTbu+4kdpBR
         jOO7ocG2RDqmMIbVYGiH42KVzCT2M7k7WqmYOmGCvSSFm8rRLomW/CNHmCj2OTKuEX0L
         pBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3KQ2sObVXYjj+dKwSYx0p6BoQGQt7qg8GvzWpJYqYAM=;
        b=ICuxCCK+GuhhL4iyjdmXHzopgxNVOmQ57KRtoanfLOMM5YUHdtSGPVwKYyew9upoI7
         4wGT7kqvPuRF2gnSMlPnGgGKB+/j69dRvKMnxL8vegTTVsq7+oQFd5kQopaJFURDQ/rr
         lrsZm6pcwlOh7lBiK8tZZV1aLlGavcyWoSWlTGJ4FFrLcCYGz2lVizq1B10Gvjeg+CmN
         Rr8VRYHnMRubUs1BqC73AaFYea3KDqFz7fPZoz0T8nUpxJ2lKJYZM3IM2MjWc+POAPmJ
         ldbJB1B4G7iKXvaGGafu/uTQl5K1jXgIyYwvF13RH7+Jl3I7/iOhM5x+4VUVMVdO0PbU
         Kkvg==
X-Gm-Message-State: AOAM531wwVHgzM9ZtuYivs2XcJkXTSIWl60+BewTLFC7uCWK4AHdq/kJ
        yb4mxlTeRTzWevcUkd2Yu3lwYoQJ4bM3YJfXdodmuHMKSF7d7BIJ4p8snn2JobtC75oUmgNjLZO
        yGIM/0jXtYjoIXRPdYkj0Ha7FoOZkf/7VtrmxTl4fnnUo+Z5IUXp//6jEysmM6Jo=
X-Google-Smtp-Source: ABdhPJynEON2UC1QV4gj4E7aI42l2B9qhK63Dfs7VbuQgKDoCo63ZI6n0UYNDmonf+H1NJgxRLEoFyTrp8Mj9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:a983:b0:141:9407:1fb3 with SMTP
 id bh3-20020a170902a98300b0014194071fb3mr3669544plb.35.1635445873071; Thu, 28
 Oct 2021 11:31:13 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:30:57 -0700
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211028183101.41013-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 2/6] remote: move static variables into per-repository struct
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

remote.c does not work with non-the_repository because it stores its
state as static variables. To support non-the_repository, we can use a
per-repository struct for the remotes subsystem.

Prepare for this change by defining a struct remote_state that holds
the remotes subsystem state and move the static variables of remote.c
into the_repository->remote_state.

This introduces no behavioral or API changes.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c     | 191 +++++++++++++++++++++++++++++++++------------------
 remote.h     |  34 +++++++++
 repository.c |   8 +++
 repository.h |   4 ++
 4 files changed, 170 insertions(+), 67 deletions(-)

diff --git a/remote.c b/remote.c
index f958543d70..c2bb11242b 100644
--- a/remote.c
+++ b/remote.c
@@ -21,33 +21,6 @@ struct counted_string {
 	size_t len;
 	const char *s;
 };
-struct rewrite {
-	const char *base;
-	size_t baselen;
-	struct counted_string *instead_of;
-	int instead_of_nr;
-	int instead_of_alloc;
-};
-struct rewrites {
-	struct rewrite **rewrite;
-	int rewrite_alloc;
-	int rewrite_nr;
-};
-
-static struct remote **remotes;
-static int remotes_alloc;
-static int remotes_nr;
-static struct hashmap remotes_hash;
-
-static struct branch **branches;
-static int branches_alloc;
-static int branches_nr;
-
-static struct branch *current_branch;
-static const char *pushremote_name;
-
-static struct rewrites rewrites;
-static struct rewrites rewrites_push;
 
 static int valid_remote(const struct remote *remote)
 {
@@ -94,14 +67,16 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 
 static void add_pushurl_alias(struct remote *remote, const char *url)
 {
-	const char *pushurl = alias_url(url, &rewrites_push);
+	const char *pushurl =
+		alias_url(url, &the_repository->remote_state->rewrites_push);
 	if (pushurl != url)
 		add_pushurl(remote, pushurl);
 }
 
 static void add_url_alias(struct remote *remote, const char *url)
 {
-	add_url(remote, alias_url(url, &rewrites));
+	add_url(remote,
+		alias_url(url, &the_repository->remote_state->rewrites));
 	add_pushurl_alias(remote, url);
 }
 
@@ -127,12 +102,6 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
 		return strcmp(a->name, b->name);
 }
 
-static inline void init_remotes_hash(void)
-{
-	if (!remotes_hash.cmpfn)
-		hashmap_init(&remotes_hash, remotes_hash_cmp, NULL, 0);
-}
-
 static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret;
@@ -142,12 +111,12 @@ static struct remote *make_remote(const char *name, int len)
 	if (!len)
 		len = strlen(name);
 
-	init_remotes_hash();
 	lookup.str = name;
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
 
-	e = hashmap_get(&remotes_hash, &lookup_entry, &lookup);
+	e = hashmap_get(&the_repository->remote_state->remotes_hash,
+			&lookup_entry, &lookup);
 	if (e)
 		return container_of(e, struct remote, ent);
 
@@ -158,15 +127,41 @@ static struct remote *make_remote(const char *name, int len)
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
-	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
-	remotes[remotes_nr++] = ret;
+	ALLOC_GROW(the_repository->remote_state->remotes,
+		   the_repository->remote_state->remotes_nr + 1,
+		   the_repository->remote_state->remotes_alloc);
+	the_repository->remote_state
+		->remotes[the_repository->remote_state->remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	if (hashmap_put_entry(&remotes_hash, ret, ent))
+	if (hashmap_put_entry(&the_repository->remote_state->remotes_hash, ret,
+			      ent))
 		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
 }
 
+static void remote_clear(struct remote *remote)
+{
+	int i;
+
+	free((char *)remote->name);
+	free((char *)remote->foreign_vcs);
+
+	for (i = 0; i < remote->url_nr; i++) {
+		free((char *)remote->url[i]);
+	}
+	FREE_AND_NULL(remote->pushurl);
+
+	for (i = 0; i < remote->pushurl_nr; i++) {
+		free((char *)remote->pushurl[i]);
+	}
+	FREE_AND_NULL(remote->pushurl);
+	free((char *)remote->receivepack);
+	free((char *)remote->uploadpack);
+	FREE_AND_NULL(remote->http_proxy);
+	FREE_AND_NULL(remote->http_proxy_authmethod);
+}
+
 static void add_merge(struct branch *branch, const char *name)
 {
 	ALLOC_GROW(branch->merge_name, branch->merge_nr + 1,
@@ -179,15 +174,20 @@ static struct branch *make_branch(const char *name, size_t len)
 	struct branch *ret;
 	int i;
 
-	for (i = 0; i < branches_nr; i++) {
-		if (!strncmp(name, branches[i]->name, len) &&
-		    !branches[i]->name[len])
-			return branches[i];
+	for (i = 0; i < the_repository->remote_state->branches_nr; i++) {
+		if (!strncmp(name,
+			     the_repository->remote_state->branches[i]->name,
+			     len) &&
+		    !the_repository->remote_state->branches[i]->name[len])
+			return the_repository->remote_state->branches[i];
 	}
 
-	ALLOC_GROW(branches, branches_nr + 1, branches_alloc);
+	ALLOC_GROW(the_repository->remote_state->branches,
+		   the_repository->remote_state->branches_nr + 1,
+		   the_repository->remote_state->branches_alloc);
 	CALLOC_ARRAY(ret, 1);
-	branches[branches_nr++] = ret;
+	the_repository->remote_state
+		->branches[the_repository->remote_state->branches_nr++] = ret;
 	ret->name = xstrndup(name, len);
 	ret->refname = xstrfmt("refs/heads/%s", ret->name);
 
@@ -327,12 +327,16 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!strcmp(subkey, "insteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			rewrite = make_rewrite(&rewrites, name, namelen);
+			rewrite = make_rewrite(
+				&the_repository->remote_state->rewrites, name,
+				namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		} else if (!strcmp(subkey, "pushinsteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			rewrite = make_rewrite(&rewrites_push, name, namelen);
+			rewrite = make_rewrite(
+				&the_repository->remote_state->rewrites_push,
+				name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
@@ -342,7 +346,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 
 	/* Handle remote.* variables */
 	if (!name && !strcmp(subkey, "pushdefault"))
-		return git_config_string(&pushremote_name, key, value);
+		return git_config_string(
+			&the_repository->remote_state->pushremote_name, key,
+			value);
 
 	if (!name)
 		return 0;
@@ -425,18 +431,34 @@ static int handle_config(const char *key, const char *value, void *cb)
 static void alias_all_urls(void)
 {
 	int i, j;
-	for (i = 0; i < remotes_nr; i++) {
+	for (i = 0; i < the_repository->remote_state->remotes_nr; i++) {
 		int add_pushurl_aliases;
-		if (!remotes[i])
+		if (!the_repository->remote_state->remotes[i])
 			continue;
-		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
-			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
+		for (j = 0;
+		     j < the_repository->remote_state->remotes[i]->pushurl_nr;
+		     j++) {
+			the_repository->remote_state->remotes[i]->pushurl[j] =
+				alias_url(
+					the_repository->remote_state->remotes[i]
+						->pushurl[j],
+					&the_repository->remote_state->rewrites);
 		}
-		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
-		for (j = 0; j < remotes[i]->url_nr; j++) {
+		add_pushurl_aliases =
+			the_repository->remote_state->remotes[i]->pushurl_nr ==
+			0;
+		for (j = 0;
+		     j < the_repository->remote_state->remotes[i]->url_nr;
+		     j++) {
 			if (add_pushurl_aliases)
-				add_pushurl_alias(remotes[i], remotes[i]->url[j]);
-			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
+				add_pushurl_alias(
+					the_repository->remote_state->remotes[i],
+					the_repository->remote_state->remotes[i]
+						->url[j]);
+			the_repository->remote_state->remotes[i]
+				->url[j] = alias_url(
+				the_repository->remote_state->remotes[i]->url[j],
+				&the_repository->remote_state->rewrites);
 		}
 	}
 }
@@ -450,12 +472,13 @@ static void read_config(void)
 		return;
 	loaded = 1;
 
-	current_branch = NULL;
+	the_repository->remote_state->current_branch = NULL;
 	if (startup_info->have_repository) {
 		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-			current_branch = make_branch(head_ref, strlen(head_ref));
+			the_repository->remote_state->current_branch =
+				make_branch(head_ref, strlen(head_ref));
 		}
 	}
 	git_config(handle_config, NULL);
@@ -493,10 +516,10 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 			*explicit = 1;
 		return branch->pushremote_name;
 	}
-	if (pushremote_name) {
+	if (the_repository->remote_state->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
-		return pushremote_name;
+		return the_repository->remote_state->pushremote_name;
 	}
 	return remote_for_branch(branch, explicit);
 }
@@ -534,7 +557,8 @@ static struct remote *remote_get_1(const char *name,
 	if (name)
 		name_given = 1;
 	else
-		name = get_default(current_branch, &name_given);
+		name = get_default(the_repository->remote_state->current_branch,
+				   &name_given);
 
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
@@ -573,11 +597,13 @@ int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
 	read_config();
-	for (i = 0; i < remotes_nr && !result; i++) {
-		struct remote *r = remotes[i];
-		if (!r)
+	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
+	     i++) {
+		struct remote *remote =
+			the_repository->remote_state->remotes[i];
+		if (!remote)
 			continue;
-		result = fn(r, priv);
+		result = fn(remote, priv);
 	}
 	return result;
 }
@@ -1685,7 +1711,7 @@ struct branch *branch_get(const char *name)
 
 	read_config();
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = current_branch;
+		ret = the_repository->remote_state->current_branch;
 	else
 		ret = make_branch(name, strlen(name));
 	set_merge(ret);
@@ -2585,3 +2611,34 @@ void apply_push_cas(struct push_cas_option *cas,
 			check_if_includes_upstream(ref);
 	}
 }
+
+struct remote_state *remote_state_new(void)
+{
+	struct remote_state *r = xmalloc(sizeof(*r));
+
+	memset(r, 0, sizeof(*r));
+
+	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
+	return r;
+}
+
+void remote_state_clear(struct remote_state *remote_state)
+{
+	int i;
+
+	for (i = 0; i < remote_state->remotes_nr; i++) {
+		remote_clear(remote_state->remotes[i]);
+	}
+	FREE_AND_NULL(remote_state->remotes);
+	remote_state->remotes_alloc = 0;
+	remote_state->remotes_nr = 0;
+
+	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
+
+	for (i = 0; i < remote_state->branches_nr; i++) {
+		FREE_AND_NULL(remote_state->branches[i]);
+	}
+	FREE_AND_NULL(remote_state->branches);
+	remote_state->branches_alloc = 0;
+	remote_state->branches_nr = 0;
+}
diff --git a/remote.h b/remote.h
index 5a59198252..d21c035f1b 100644
--- a/remote.h
+++ b/remote.h
@@ -23,6 +23,40 @@ enum {
 	REMOTE_BRANCHES
 };
 
+struct rewrite {
+	const char *base;
+	size_t baselen;
+	struct counted_string *instead_of;
+	int instead_of_nr;
+	int instead_of_alloc;
+};
+
+struct rewrites {
+	struct rewrite **rewrite;
+	int rewrite_alloc;
+	int rewrite_nr;
+};
+
+struct remote_state {
+	struct remote **remotes;
+	int remotes_alloc;
+	int remotes_nr;
+	struct hashmap remotes_hash;
+
+	struct branch **branches;
+	int branches_alloc;
+	int branches_nr;
+
+	struct branch *current_branch;
+	const char *pushremote_name;
+
+	struct rewrites rewrites;
+	struct rewrites rewrites_push;
+};
+
+void remote_state_clear(struct remote_state *remote_state);
+struct remote_state *remote_state_new(void);
+
 struct remote {
 	struct hashmap_entry ent;
 
diff --git a/repository.c b/repository.c
index c5b90ba93e..c7ea706c20 100644
--- a/repository.c
+++ b/repository.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
+#include "remote.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
 #include "promisor-remote.h"
@@ -24,6 +25,7 @@ void initialize_the_repository(void)
 
 	the_repo.index = &the_index;
 	the_repo.objects = raw_object_store_new();
+	the_repo.remote_state = remote_state_new();
 	the_repo.parsed_objects = parsed_object_pool_new();
 
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
@@ -164,6 +166,7 @@ int repo_init(struct repository *repo,
 
 	repo->objects = raw_object_store_new();
 	repo->parsed_objects = parsed_object_pool_new();
+	repo->remote_state = remote_state_new();
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
@@ -270,6 +273,11 @@ void repo_clear(struct repository *repo)
 		promisor_remote_clear(repo->promisor_remote_config);
 		FREE_AND_NULL(repo->promisor_remote_config);
 	}
+
+	if (repo->remote_state) {
+		remote_state_clear(repo->remote_state);
+		FREE_AND_NULL(repo->remote_state);
+	}
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index a057653981..98f9583470 100644
--- a/repository.h
+++ b/repository.h
@@ -11,6 +11,7 @@ struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
 struct promisor_remote_config;
+struct remote_state;
 
 enum untracked_cache_setting {
 	UNTRACKED_CACHE_KEEP,
@@ -127,6 +128,9 @@ struct repository {
 	 */
 	struct index_state *index;
 
+	/* Repository's remotes and associated structures. */
+	struct remote_state *remote_state;
+
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
 
-- 
2.33.GIT

