Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C4C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB360FE3
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhFAVgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhFAVgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:36:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F4C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:34:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r5-20020a2582850000b02905381b1b616eso676618ybk.6
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=upY9tXSnIi50X291giidhXbnGAi6iGOTHrdW8k80k3U=;
        b=P0qB1N/Jrv+3uUsr0kxy/XyEGNDMHoQyGhzIaQTwQUGNwlg4dcLYvA5W5XCVFd40av
         Ffia6/xYdI56ufZJgLy95SjqeK/b+w26K9cXAiJ4sd+09UZKbrcDkduzv4GaBldFsf1x
         wJaPc7iJ0hUgE/NPRfmrPOUduoaxjKOO9uwsy8RXVsLEz5ih8N/ITnTTvZNdi/WtPx5a
         1CFpjA53p0qNpDAnJIYJzghrBmoTwDNELcTx0lu3Xl1TLDkXJUzQwc4/tFG8gsweUhYL
         Vu9S8MlrOizD7omR0ZrinoKCyZxIfIG4Z2h8H0P8xGHyyaOmL1NgfM/ztx5JZOGCDfsf
         KI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=upY9tXSnIi50X291giidhXbnGAi6iGOTHrdW8k80k3U=;
        b=qTqy0xbVJKnQm1UmitVeG6QudWDAKOJ031h9z6X8HBoav9zJ5GRE7UKZOpl+vj4g5i
         75Rccz9lQJLKyJQP32kvNmEMmsqjhvW4Sn0cnT4BhXT4oc5g81zxTFOqV0/DPnElpoUH
         WZjN4HMbP6JavNkvJu4wEUdbLRwg2JXZg956sXl3DlaYrmebirjg0hhFPpTJMq9e7ELO
         zeGvm43qRmosKcMXHaNwmdfj7YCQ4H+YJQnNmBNS8A6NAb647J0rZ5BgoT/QxzRvRa0A
         A8jK2O9f1QKkYKOkC32Yb4J+KiYs0IeQURVbz0Es3CgABXItY0QjnpTT3kYKFL6wuJy5
         mU3g==
X-Gm-Message-State: AOAM533lg/+xQhimOK3uOyKz46pr9Y4AhTJhMf46k/JPkofLXhMSpAu/
        RMfGUji6V8NURNrglrjF8mlS3ej8S24P+RlQB2y4JDLRqDgDMNjsbuFCoou2xz80AmVEeBirgQ6
        91eeZnCpFKdG8ObHKdu9JElygsh4L7EKfgJJeqjr5HCwpLBIvmeu4OCiUr75gb+LbMC13/kR5i1
        WV
X-Google-Smtp-Source: ABdhPJx0G3i0qe2cFn2j2rKFlUepKE02vytXluKOoSCkbVBSv67aeBjnJFrImrKUZGGaSlLtZlt7alu3KvNVJWBGYDP5
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c905:: with SMTP id
 z5mr40856236ybf.461.1622583266537; Tue, 01 Jun 2021 14:34:26 -0700 (PDT)
Date:   Tue,  1 Jun 2021 14:34:17 -0700
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Message-Id: <d8f5fa9b9fab73c2e0923ccf38d5bdb15f7b7a70.1622580781.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 2/4] promisor-remote: support per-repository config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using global variables to store promisor remote information,
store this config in struct repository instead, and add
repository-agnostic non-static functions corresponding to the existing
non-static functions that only work on the_repository.

The actual lazy-fetching of missing objects currently does not work on
repositories other than the_repository, and will still not work after
this commit, so add a BUG message explaining this. A subsequent commit
will remove this limitation.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 promisor-remote.c | 101 +++++++++++++++++++++++++---------------------
 promisor-remote.h |  20 +++++++--
 repository.h      |   4 ++
 3 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index bfe8eee5f2..5819d2cf28 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -5,7 +5,11 @@
 #include "transport.h"
 #include "strvec.h"
 
-static char *repository_format_partial_clone;
+struct promisor_remote_config {
+	char *repository_format_partial_clone;
+	struct promisor_remote *promisors;
+	struct promisor_remote **promisors_tail;
+};
 
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
@@ -37,10 +41,8 @@ static int fetch_objects(const char *remote_name,
 	return finish_command(&child) ? -1 : 0;
 }
 
-static struct promisor_remote *promisors;
-static struct promisor_remote **promisors_tail = &promisors;
-
-static struct promisor_remote *promisor_remote_new(const char *remote_name)
+static struct promisor_remote *promisor_remote_new(struct promisor_remote_config *config,
+						   const char *remote_name)
 {
 	struct promisor_remote *r;
 
@@ -52,18 +54,19 @@ static struct promisor_remote *promisor_remote_new(const char *remote_name)
 
 	FLEX_ALLOC_STR(r, name, remote_name);
 
-	*promisors_tail = r;
-	promisors_tail = &r->next;
+	*config->promisors_tail = r;
+	config->promisors_tail = &r->next;
 
 	return r;
 }
 
-static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
+static struct promisor_remote *promisor_remote_lookup(struct promisor_remote_config *config,
+						      const char *remote_name,
 						      struct promisor_remote **previous)
 {
 	struct promisor_remote *r, *p;
 
-	for (p = NULL, r = promisors; r; p = r, r = r->next)
+	for (p = NULL, r = config->promisors; r; p = r, r = r->next)
 		if (!strcmp(r->name, remote_name)) {
 			if (previous)
 				*previous = p;
@@ -73,7 +76,8 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
 	return NULL;
 }
 
-static void promisor_remote_move_to_tail(struct promisor_remote *r,
+static void promisor_remote_move_to_tail(struct promisor_remote_config *config,
+					 struct promisor_remote *r,
 					 struct promisor_remote *previous)
 {
 	if (r->next == NULL)
@@ -82,20 +86,21 @@ static void promisor_remote_move_to_tail(struct promisor_remote *r,
 	if (previous)
 		previous->next = r->next;
 	else
-		promisors = r->next ? r->next : r;
+		config->promisors = r->next ? r->next : r;
 	r->next = NULL;
-	*promisors_tail = r;
-	promisors_tail = &r->next;
+	*config->promisors_tail = r;
+	config->promisors_tail = &r->next;
 }
 
 static int promisor_remote_config(const char *var, const char *value, void *data)
 {
+	struct promisor_remote_config *config = data;
 	const char *name;
 	size_t namelen;
 	const char *subkey;
 
 	if (!strcmp(var, "extensions.partialclone")) {
-		repository_format_partial_clone = xstrdup(value);
+		config->repository_format_partial_clone = xstrdup(value);
 		return 0;
 	}
 
@@ -110,8 +115,8 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 
 		remote_name = xmemdupz(name, namelen);
 
-		if (!promisor_remote_lookup(remote_name, NULL))
-			promisor_remote_new(remote_name);
+		if (!promisor_remote_lookup(config, remote_name, NULL))
+			promisor_remote_new(config, remote_name);
 
 		free(remote_name);
 		return 0;
@@ -120,9 +125,9 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		struct promisor_remote *r;
 		char *remote_name = xmemdupz(name, namelen);
 
-		r = promisor_remote_lookup(remote_name, NULL);
+		r = promisor_remote_lookup(config, remote_name, NULL);
 		if (!r)
-			r = promisor_remote_new(remote_name);
+			r = promisor_remote_new(config, remote_name);
 
 		free(remote_name);
 
@@ -135,59 +140,63 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	return 0;
 }
 
-static int initialized;
-
-static void promisor_remote_init(void)
+static void promisor_remote_init(struct repository *r)
 {
-	if (initialized)
+	struct promisor_remote_config *config;
+
+	if (r->promisor_remote_config)
 		return;
-	initialized = 1;
+	config = r->promisor_remote_config =
+		xcalloc(sizeof(*r->promisor_remote_config), 1);
+	config->promisors_tail = &config->promisors;
 
-	git_config(promisor_remote_config, NULL);
+	git_config(promisor_remote_config, config);
 
-	if (repository_format_partial_clone) {
+	if (config->repository_format_partial_clone) {
 		struct promisor_remote *o, *previous;
 
-		o = promisor_remote_lookup(repository_format_partial_clone,
+		o = promisor_remote_lookup(config,
+					   config->repository_format_partial_clone,
 					   &previous);
 		if (o)
-			promisor_remote_move_to_tail(o, previous);
+			promisor_remote_move_to_tail(config, o, previous);
 		else
-			promisor_remote_new(repository_format_partial_clone);
+			promisor_remote_new(config, config->repository_format_partial_clone);
 	}
 }
 
-static void promisor_remote_clear(void)
+static void promisor_remote_clear(struct promisor_remote_config *config)
 {
-	while (promisors) {
-		struct promisor_remote *r = promisors;
-		promisors = promisors->next;
+	while (config->promisors) {
+		struct promisor_remote *r = config->promisors;
+		config->promisors = config->promisors->next;
 		free(r);
 	}
 
-	promisors_tail = &promisors;
+	config->promisors_tail = &config->promisors;
 }
 
-void promisor_remote_reinit(void)
+void repo_promisor_remote_reinit(struct repository *r)
 {
-	initialized = 0;
-	promisor_remote_clear();
-	promisor_remote_init();
+	promisor_remote_clear(r->promisor_remote_config);
+	FREE_AND_NULL(r->promisor_remote_config);
+	promisor_remote_init(r);
 }
 
-struct promisor_remote *promisor_remote_find(const char *remote_name)
+struct promisor_remote *repo_promisor_remote_find(struct repository *r,
+						  const char *remote_name)
 {
-	promisor_remote_init();
+	promisor_remote_init(r);
 
 	if (!remote_name)
-		return promisors;
+		return r->promisor_remote_config->promisors;
 
-	return promisor_remote_lookup(remote_name, NULL);
+	return promisor_remote_lookup(r->promisor_remote_config, remote_name, NULL);
 }
 
-int has_promisor_remote(void)
+int repo_has_promisor_remote(struct repository *r)
 {
-	return !!promisor_remote_find(NULL);
+	return !!repo_promisor_remote_find(r, NULL);
 }
 
 static int remove_fetched_oids(struct repository *repo,
@@ -235,9 +244,11 @@ int promisor_remote_get_direct(struct repository *repo,
 	if (oid_nr == 0)
 		return 0;
 
-	promisor_remote_init();
+	promisor_remote_init(repo);
 
-	for (r = promisors; r; r = r->next) {
+	if (repo != the_repository)
+		BUG("only the_repository is supported for now");
+	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
 		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
 			if (remaining_nr == 1)
 				continue;
diff --git a/promisor-remote.h b/promisor-remote.h
index 687210ab87..5390d3e7bf 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -17,9 +17,23 @@ struct promisor_remote {
 	const char name[FLEX_ARRAY];
 };
 
-void promisor_remote_reinit(void);
-struct promisor_remote *promisor_remote_find(const char *remote_name);
-int has_promisor_remote(void);
+void repo_promisor_remote_reinit(struct repository *r);
+static inline void promisor_remote_reinit(void)
+{
+	repo_promisor_remote_reinit(the_repository);
+}
+
+struct promisor_remote *repo_promisor_remote_find(struct repository *r, const char *remote_name);
+static inline struct promisor_remote *promisor_remote_find(const char *remote_name)
+{
+	return repo_promisor_remote_find(the_repository, remote_name);
+}
+
+int repo_has_promisor_remote(struct repository *r);
+static inline int has_promisor_remote(void)
+{
+	return repo_has_promisor_remote(the_repository);
+}
 
 /*
  * Fetches all requested objects from all promisor remotes, trying them one at
diff --git a/repository.h b/repository.h
index a45f7520fd..fc06c154e2 100644
--- a/repository.h
+++ b/repository.h
@@ -10,6 +10,7 @@ struct lock_file;
 struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
+struct promisor_remote_config;
 
 enum untracked_cache_setting {
 	UNTRACKED_CACHE_UNSET = -1,
@@ -139,6 +140,9 @@ struct repository {
 	/* True if commit-graph has been disabled within this process. */
 	int commit_graph_disabled;
 
+	/* Configurations related to promisor remotes. */
+	struct promisor_remote_config *promisor_remote_config;
+
 	/* Configurations */
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

