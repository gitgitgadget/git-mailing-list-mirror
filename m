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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03488C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC54613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFQRPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhFQRPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:15:43 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667AC06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:34 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q3-20020aa784230000b02902ea311f25e2so1371070pfn.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+xN1Y02X2Xt08NYcKUmv/3ZIjFO1TysBeVC64u2e0t4=;
        b=DWnUO7Uav6J4rBENqv8qDYO900EljIJP3sgRj0V0v6B/me6dI8HIsgAhulbCKIHjId
         czXWO7d2qQYVTzRX4rse8Hkc1GW3mdMJ9hTJ90CaTtTllRWJV8KCmAIl5EIFISZ/lArs
         1DCrSltrScth1xR72go/E1DXUPM1oPtg4hzi7RQeiwtgUlR8sgFNRmINKQrFyPUr1wxm
         NftZ2SBnTJS3ojg5i1Jh7WfnDwrXRwiobYelnR2r8c4axJ4d+j/yNk6fVNNyB5SF43UT
         nKxODJSAzbLHfu7yXTvs1y5RTK+H6XXC+N6S/p08cveEN6BI7Li8zCEMSUNLsTBD7CXo
         cbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+xN1Y02X2Xt08NYcKUmv/3ZIjFO1TysBeVC64u2e0t4=;
        b=g1V1QUZj5AdvpFa+OzQrmafxcZKlqQXNo7A6q2f3nRCw7yvxxXGp68uixw5OpPdEn8
         EV6KAKqxO0AjoWdp7Qocg7R8a6CbaqDZZlo2qcGiLfe2JWzjvrYKDCpt9QvMy5xGSV1i
         otqOKQhuXENvt9yoLOd5/cQqwwqYEGaAzJPcVoTnT3Q3cV+XwZ1V62WkrhZTZfB2VAD2
         Z5eyv7Pm8/162RKauWSuHrdnUVQwUvIADO5lFOzxbTIXHqc9dbclEQai4/jqMzK58MZh
         xXPRTh8/ommG8k9IswYiW6zM2nRJlp7yVNYrU9pJQDweJcrr2o3mTojy4UmKChnA8sxn
         P+8w==
X-Gm-Message-State: AOAM530oMVd+80hH0Bf1wcrPcPHVk38Q9IadyQxSZw8U4ApVi5FgkYov
        t7JhavIC8WVXvk8b8zyh3/v2m8ZVlUV29V06eYdmPjeWLlvdmBwwuFFpVOlBUMDaHE1JtY94BNA
        X6qIHRmSCO1tZ8fD0wmi9sIi01QBfDvtOdZHwX7b+lMc1SMc24avLoSYroNS42DpEachSeX0fUQ
        fi
X-Google-Smtp-Source: ABdhPJyW/BZDsvEZ7FMqejnYqV85bFumhT6hz1YFttAJ28cCf1Clj5kmONRPgFe7d7OHqd3dUABjaMKLPxKV9gXn+w5r
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:1d0e:: with SMTP id
 c14mr5560281pjd.171.1623950013451; Thu, 17 Jun 2021 10:13:33 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:13:23 -0700
In-Reply-To: <cover.1623949899.git.jonathantanmy@google.com>
Message-Id: <8a478b46bffc20e34aed2251e812ec44314106b8.1623949899.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623949899.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 2/5] promisor-remote: support per-repository config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 promisor-remote.c | 98 ++++++++++++++++++++++++++---------------------
 promisor-remote.h | 22 +++++++++--
 repository.c      |  6 +++
 repository.h      |  2 +
 4 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index d24081dc21..1e00e16b0f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -5,6 +5,11 @@
 #include "transport.h"
 #include "strvec.h"
 
+struct promisor_remote_config {
+	struct promisor_remote *promisors;
+	struct promisor_remote **promisors_tail;
+};
+
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
@@ -35,10 +40,8 @@ static int fetch_objects(const char *remote_name,
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
 
@@ -50,18 +53,19 @@ static struct promisor_remote *promisor_remote_new(const char *remote_name)
 
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
@@ -71,7 +75,8 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
 	return NULL;
 }
 
-static void promisor_remote_move_to_tail(struct promisor_remote *r,
+static void promisor_remote_move_to_tail(struct promisor_remote_config *config,
+					 struct promisor_remote *r,
 					 struct promisor_remote *previous)
 {
 	if (r->next == NULL)
@@ -80,14 +85,15 @@ static void promisor_remote_move_to_tail(struct promisor_remote *r,
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
@@ -103,8 +109,8 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 
 		remote_name = xmemdupz(name, namelen);
 
-		if (!promisor_remote_lookup(remote_name, NULL))
-			promisor_remote_new(remote_name);
+		if (!promisor_remote_lookup(config, remote_name, NULL))
+			promisor_remote_new(config, remote_name);
 
 		free(remote_name);
 		return 0;
@@ -113,9 +119,9 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		struct promisor_remote *r;
 		char *remote_name = xmemdupz(name, namelen);
 
-		r = promisor_remote_lookup(remote_name, NULL);
+		r = promisor_remote_lookup(config, remote_name, NULL);
 		if (!r)
-			r = promisor_remote_new(remote_name);
+			r = promisor_remote_new(config, remote_name);
 
 		free(remote_name);
 
@@ -128,59 +134,63 @@ static int promisor_remote_config(const char *var, const char *value, void *data
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
+	repo_config(r, promisor_remote_config, config);
 
-	if (the_repository->repository_format_partial_clone) {
+	if (r->repository_format_partial_clone) {
 		struct promisor_remote *o, *previous;
 
-		o = promisor_remote_lookup(the_repository->repository_format_partial_clone,
+		o = promisor_remote_lookup(config,
+					   r->repository_format_partial_clone,
 					   &previous);
 		if (o)
-			promisor_remote_move_to_tail(o, previous);
+			promisor_remote_move_to_tail(config, o, previous);
 		else
-			promisor_remote_new(the_repository->repository_format_partial_clone);
+			promisor_remote_new(config, r->repository_format_partial_clone);
 	}
 }
 
-static void promisor_remote_clear(void)
+void promisor_remote_clear(struct promisor_remote_config *config)
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
@@ -228,9 +238,11 @@ int promisor_remote_get_direct(struct repository *repo,
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
index 057a4748a0..b2bf44c6fa 100644
--- a/repository.c
+++ b/repository.c
@@ -11,6 +11,7 @@
 #include "lockfile.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
+#include "promisor-remote.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -262,6 +263,11 @@ void repo_clear(struct repository *repo)
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
index 6fb16ed336..3740c93bc0 100644
--- a/repository.h
+++ b/repository.h
@@ -10,6 +10,7 @@ struct lock_file;
 struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
+struct promisor_remote_config;
 
 enum untracked_cache_setting {
 	UNTRACKED_CACHE_UNSET = -1,
@@ -141,6 +142,7 @@ struct repository {
 
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
+	struct promisor_remote_config *promisor_remote_config;
 
 	/* Configurations */
 
-- 
2.32.0.272.g935e593368-goog

