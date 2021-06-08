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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDEC47095
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA6661108
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFHA2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhFHA2O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:28:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA89BC061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 17:26:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e12-20020a17090a630cb029016de1736f41so6222832pjj.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kqbsLcja9Cd7oIiWhK4mgo/i942bpLQQ3Wl2oXojnL4=;
        b=kzTCD2wGQss9iapAxaE2ZIu9aZL+F/L/WctYB50YznUyP41jb+N217856SxEP/pmzN
         j9/8TJAYQELhWW9p/RhpkIesX190QkaUPavRhLeOTAJOOb/VT47VkVIVhnE7GVxUeNbF
         N7V/kK4Xm0AGE3IK0lu38kI69pP0ZVex9iHg6jX/X8+jap2nfW3Z8pPm8Te1rx6m19OI
         le0PqN28kmTE0DsZSXkSrQ4kr8fX/YLePH7BCcARJNRFdQxYQHwAvdPSw5J6m2/V5IjZ
         +CRN4+272WHovtIbSYHm9tOjZlIxUkDqmg0v5V6X8Gl+ygwjqNrlkTEA+4I6KmzPX0Pi
         1s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kqbsLcja9Cd7oIiWhK4mgo/i942bpLQQ3Wl2oXojnL4=;
        b=hZlcXSwSU/Ybp0kmeIPyB5iN3naSORqKRio+WYpzY1MHzVgkqjBDhNntgnidmd6x+6
         oFGsVfDyhWKqGJqW4I777IUVDsNkebFw7LAyhUIT182yvbSCfc03ThSvM84CYkVjyXZH
         W6aNpW+JgOIc4afKPWlJOPxsnZ5wqdDCafgI5T4xnFgvRNG9q3gDY7ZBpI6bhevZuWK3
         AmWDdWdtTnGM58cmkvUVExsGqp76vrkLk5+WCaXgBvTlKwFtr6+0dPPKWn9kPM3+iZg5
         6evH+DS3RavQ64PCqwLezaV97ds7R2QCAOahdaOBZxea66uPdQTBwSQV5RhfC8dm0YoC
         phvA==
X-Gm-Message-State: AOAM530KhNoiQqkcL/PYGPMTY1ByzDqzQB76x7ilBvQbigx+0NZLPY5Z
        PIBUK0u8VIUhTqAw/qaetZq3zqj02pqFbtvpT1cY/+wTKEHkWKfK1oWpFod6fPVBh7JU+tEwD1Y
        gVZf/dqOfAbpG4N9Hj6u7bw/VCGK90svdUJeswDhB4bod4kBVOSTIF5dZ+pdd4P73s94RmamoVC
        pF
X-Google-Smtp-Source: ABdhPJzZ56B08wsdFLmjsoUnEwUmjEPKDfFbBrZj7XezQwqcKW1fbB+wBYCv/wq3WFdkloNvr+W3F6KOUk1+61NGojnC
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8b56:0:b029:2b9:77be:d305 with
 SMTP id i22-20020aa78b560000b02902b977bed305mr19387663pfd.61.1623111966337;
 Mon, 07 Jun 2021 17:26:06 -0700 (PDT)
Date:   Mon,  7 Jun 2021 17:25:57 -0700
In-Reply-To: <cover.1623111879.git.jonathantanmy@google.com>
Message-Id: <c462927ff222501ade111003d9e063bf06d3a0b0.1623111879.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623111879.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v2 2/4] promisor-remote: support per-repository config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
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
 promisor-remote.c | 103 ++++++++++++++++++++++++++--------------------
 promisor-remote.h |  22 ++++++++--
 repository.c      |   6 +++
 repository.h      |   4 ++
 4 files changed, 87 insertions(+), 48 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index c0e5061dfe..e1e1f7e93a 100644
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
@@ -82,14 +86,15 @@ static void promisor_remote_move_to_tail(struct promisor_remote *r,
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
@@ -99,7 +104,7 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		 * NULL value is handled in handle_extension_v0 in setup.c.
 		 */
 		if (value)
-			repository_format_partial_clone = xstrdup(value);
+			config->repository_format_partial_clone = xstrdup(value);
 		return 0;
 	}
 
@@ -114,8 +119,8 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 
 		remote_name = xmemdupz(name, namelen);
 
-		if (!promisor_remote_lookup(remote_name, NULL))
-			promisor_remote_new(remote_name);
+		if (!promisor_remote_lookup(config, remote_name, NULL))
+			promisor_remote_new(config, remote_name);
 
 		free(remote_name);
 		return 0;
@@ -124,9 +129,9 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		struct promisor_remote *r;
 		char *remote_name = xmemdupz(name, namelen);
 
-		r = promisor_remote_lookup(remote_name, NULL);
+		r = promisor_remote_lookup(config, remote_name, NULL);
 		if (!r)
-			r = promisor_remote_new(remote_name);
+			r = promisor_remote_new(config, remote_name);
 
 		free(remote_name);
 
@@ -139,59 +144,65 @@ static int promisor_remote_config(const char *var, const char *value, void *data
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
+void promisor_remote_clear(struct promisor_remote_config *config)
 {
-	while (promisors) {
-		struct promisor_remote *r = promisors;
-		promisors = promisors->next;
+	FREE_AND_NULL(config->repository_format_partial_clone);
+
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
@@ -239,9 +250,11 @@ int promisor_remote_get_direct(struct repository *repo,
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
index 687210ab87..edc45ab0f5 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -17,9 +17,25 @@ struct promisor_remote {
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
+void promisor_remote_clear(struct promisor_remote_config *config);
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
diff --git a/repository.c b/repository.c
index 448cd557d4..dca0a11ab6 100644
--- a/repository.c
+++ b/repository.c
@@ -11,6 +11,7 @@
 #include "lockfile.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
+#include "promisor-remote.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -258,6 +259,11 @@ void repo_clear(struct repository *repo)
 		if (repo->index != &the_index)
 			FREE_AND_NULL(repo->index);
 	}
+
+	if (repo->promisor_remote_config) {
+		promisor_remote_clear(repo->promisor_remote_config);
+		FREE_AND_NULL(repo->promisor_remote_config);
+	}
 }
 
 int repo_read_index(struct repository *repo)
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
2.32.0.rc1.229.g3e70b5a671-goog

