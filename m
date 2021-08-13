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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA9CC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B586109D
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHMVF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHMVF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:05:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D904C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id h9-20020a17090a470900b001791c0352aaso4957795pjg.2
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HPs/J5doyeqzrGrU67x+aGWKVel1tmn2p10jq9Nu/Wg=;
        b=Y99AWLgEJcjGnDC9symbQxVED7VKD1tyBz15fWgNZ/cDw7ka1iTtULZQ0XtkZ4Dc6/
         01yK8evZdAfy/DUnSm335JKBsR/vyWeXTBjC1w9YBGoZ3e2jyA2CBHD89n3J3JU5BvwA
         cCFSql8jcItOSXVHoLydgcGGvqiqmPsJOrAp/qPfSZ+AAvwTlpa21lGYQYbXCS2n6L9n
         pUUQBb9qSxWXVQInyz/PbwBm9v6VnrDKBcT1pf+HolDxIEl7M1jrnKATco23EMSre/e3
         pjJS1/ru/LDrXEoS/Um8lvu8X4KEN+dmAfvKzyqOAyhPqHKMA6AO0GTPk4vIY/FewCQS
         qLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HPs/J5doyeqzrGrU67x+aGWKVel1tmn2p10jq9Nu/Wg=;
        b=jRgvWIYrA7eVQB75yr+5fgXvxbBGWz7vVttLMNiSG42V000+jFpKvAySclItLXWCVy
         XHFD9ZJGfhxDBDSWkNJlfAVw/WpK+FW4gEGkydq5rBOa+zWzhvBjlX9664n6ypmeTbj7
         bl2wb3JcAF+at4U9hvdftoeP8c8dXAAvv4aSHIBArXnNo9u7IbuBO+cd4DIxhiFTfdQw
         kR+cEsmsITGFQg6LbH61p8uNXWZ92BdW80lIIIammlbaeT9KMtoTz8UtCThcAP2/ILSb
         v7fUZWwMgWAwRd5raHmhI8JRPwOjlKDwRrCglCDZtBwOedmYLMJwuTtNxDn7zgAbowjx
         cCNw==
X-Gm-Message-State: AOAM531A1Yk1kr5uh0kdAj5iYbGipRMwp08uQMDrzHNKzNSmoaRsrba7
        Man6sVbKs+7yAQpLdP5y//kObbEzarEYqpwP+DKqdHhrK0VMrgIw/X9D1+SncktB9TeHlsBnalI
        oG/fHwFHZkQzaV67Ir6Qa1pOuktrS/Tfj6/JAI9ME0lvqLAUZBydnSZTeXIrkwUmjo4rGpvUWgi
        pI
X-Google-Smtp-Source: ABdhPJyu3Lq3Vpgw1ER55vSEHNmD/xiOq+JkjNtzNMt9AHSqYxikmypHUdxcZ4bNFD0AthSK8TcWD5qBx/cZT0dXtU+z
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:ed06:0:b029:32c:a800:ba47 with
 SMTP id u6-20020a62ed060000b029032ca800ba47mr4165564pfh.56.1628888728953;
 Fri, 13 Aug 2021 14:05:28 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:16 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <5994a517e8afc345e8f649b2368756e22b0e9ebe.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 1/8] submodule: lazily add submodule ODBs as alternates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to add submodule ODBs as alternates to the object store of
the_repository only upon the first access of an object not in
the_repository, and not when add_submodule_odb() is called.

This provides a means of gradually migrating from accessing a
submodule's object through alternates to accessing a submodule's object
by explicitly passing its repository object. Any Git command can declare
that it might access submodule objects by calling add_submodule_odb()
(as they do now), but the submodule ODBs themselves will not be added
until needed, so individual commands and/or combinations of arguments
can be migrated one by one.

[The advantage of explicit repository-object passing is code clarity (it
is clear which repository an object read is from), performance (there is
no need to linearly search through all submodule ODBs whenever an object
is accessed from any repository, whether superproject or submodule), and
the possibility of future features like partial clone submodules (which
right now is not possible because if an object is missing, we do not
know which repository to lazy-fetch into).]

This commit also introduces an environment variable that a test may set
to make the actual registration of alternates fatal, in order to
demonstrate that its codepaths do not need this registration.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c |  5 +++++
 submodule.c   | 20 +++++++++++++++++++-
 submodule.h   |  7 +++++++
 t/README      | 10 ++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 3d27dc8dea..621b121bcb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -32,6 +32,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "submodule.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1592,6 +1593,10 @@ static int do_oid_object_info_extended(struct repository *r,
 				break;
 		}
 
+		if (register_all_submodule_odb_as_alternates())
+			/* We added some alternates; retry */
+			continue;
+
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repo_has_promisor_remote(r) &&
 		    !already_retried &&
diff --git a/submodule.c b/submodule.c
index 8e611fe1db..8fde90e906 100644
--- a/submodule.c
+++ b/submodule.c
@@ -165,6 +165,8 @@ void stage_updated_gitmodules(struct index_state *istate)
 		die(_("staging updated .gitmodules failed"));
 }
 
+static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
+
 /* TODO: remove this function, use repo_submodule_init instead. */
 int add_submodule_odb(const char *path)
 {
@@ -178,12 +180,28 @@ int add_submodule_odb(const char *path)
 		ret = -1;
 		goto done;
 	}
-	add_to_alternates_memory(objects_directory.buf);
+	string_list_insert(&added_submodule_odb_paths,
+			   strbuf_detach(&objects_directory, NULL));
 done:
 	strbuf_release(&objects_directory);
 	return ret;
 }
 
+int register_all_submodule_odb_as_alternates(void)
+{
+	int i;
+	int ret = added_submodule_odb_paths.nr;
+
+	for (i = 0; i < added_submodule_odb_paths.nr; i++)
+		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
+	if (ret) {
+		string_list_clear(&added_submodule_odb_paths, 0);
+		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
+			BUG("register_all_submodule_odb_as_alternates() called");
+	}
+	return ret;
+}
+
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
diff --git a/submodule.h b/submodule.h
index 84640c49c1..c252784bc2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -97,7 +97,14 @@ int submodule_uses_gitfile(const char *path);
 #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
 int bad_to_remove_submodule(const char *path, unsigned flags);
 
+/*
+ * Call add_submodule_odb() to add the submodule at the given path to a list.
+ * When register_all_submodule_odb_as_alternates() is called, the object stores
+ * of all submodules in that list will be added as alternates in
+ * the_repository.
+ */
 int add_submodule_odb(const char *path);
+int register_all_submodule_odb_as_alternates(void);
 
 /*
  * Checks if there are submodule changes in a..b. If a is the null OID,
diff --git a/t/README b/t/README
index 9e70122302..8b67b4f00b 100644
--- a/t/README
+++ b/t/README
@@ -448,6 +448,16 @@ GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
 to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
 execution of the parallel-checkout code.
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=<boolean>, when true, makes
+registering submodule ODBs as alternates a fatal action. Support for
+this environment variable can be removed once the migration to
+explicitly providing repositories when accessing submodule objects is
+complete (in which case we might want to replace this with a trace2
+call so that users can make it visible if accessing submodule objects
+without an explicit repository still happens) or needs to be abandoned
+for whatever reason (in which case the migrated codepaths still retain
+their performance benefits).
+
 Naming Tests
 ------------
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

