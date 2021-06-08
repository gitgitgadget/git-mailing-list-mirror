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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D133C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13317611BD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFHA2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHA2O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:28:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F76C061787
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 17:26:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n4-20020ad44a240000b029021cbf9668daso14274963qvz.23
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a4w/4CB56ohd8seT4yKr0IRci2/IH9bNaRkYotemsKU=;
        b=Rj4MF1ZK997VSy8nHkby09di/LRg1Lwjx8EJt2ECv08GKnZEih+rZl99Fpj2lv9ov0
         Z3+mSzSoX/FdWVWCs3LOa4xGqHRe21emEeCZ6amptrEljg9gnadT4fbd58oLEIbJ1yZw
         ZywJ4kQilvBAo2pgB/wmEVp+XNH5hHxQXtrLVe1OrZRGfePlgTZYj5XdQvvIwF2G3SKY
         FFd+pb7U7RsU1CSvnd7UYuO3s8j0PvNAbhcsrWn6CymPmpGUYwj3pBJQcs+C4S/tuRXK
         vaelEt3BRxj+VH1U6qhOLltBNVjquWqHCyn8vsnTsmNbqXhD+WED8OvsxZA2ZRWBvpsc
         ZBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a4w/4CB56ohd8seT4yKr0IRci2/IH9bNaRkYotemsKU=;
        b=BkBwclytmF+0gxE3P57ipH53KwbpU5rOpP+57aNDOjqkbegmkoaCrNAtfFkTlz1T5N
         LOL07quaqgba4fy++9ABuWeKpNCndVgCLnw/xRfmFoA3xPZqMcopratAnrEJUc3QSTPG
         ZMefSnWVM5o5vRWga1k4HsDmIksyssCxK+EBWu0azXnVGz+AhN8JvkFTd1L27ZLotnH3
         LDMWqYDUov6kXr0LLtGfwWHZVK4Pt1iLyBEn5fhgqERN4QBN4xTPp4ykEQEaN64QxwZD
         WVqMXcfBlQVW2XyccQWu+QDgQxrq6zGETKGb5Jakcmqh3zZP8EAoXSBUSowshvAqBvhW
         kaeQ==
X-Gm-Message-State: AOAM5318MbxK5fdc31bkvT9h3ZcnGBVPs1yge5HrP1qc5DWc/o3XAwpu
        m7OvIZORINYH4tjFa6bgttUJ3W7sBN0BCEFJMVGrxUKjo2UfmEeziUFSiGeZDRLkaJW+YEYncfz
        JOSyJn1PVW+zZiXk1rT2cyIO+FWwqusFDFIiDmH4SIs9MzrOVSvgifJnwUco74WeAlWg8+lKGaV
        Br
X-Google-Smtp-Source: ABdhPJwVJ1vRXD+nWeTZPo3yJBI4h66lkBz1nSC8fQP6n8/hiz1Ssky7MHsbj5ttT0FoJ731MuoPBJpm6efOGxNAi8G/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:80c1:: with SMTP id
 59mr20971906qvb.31.1623111964626; Mon, 07 Jun 2021 17:26:04 -0700 (PDT)
Date:   Mon,  7 Jun 2021 17:25:56 -0700
In-Reply-To: <cover.1623111879.git.jonathantanmy@google.com>
Message-Id: <07290cba86fda73ee329a47db8e524b32dba25af.1623111879.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623111879.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v2 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the reading of config related to promisor remotes is done in
two places: once in setup.c (which sets the global variable
repository_format_partial_clone, to be read by the code in
promisor-remote.c), and once in promisor-remote.c. This means that care
must be taken to ensure that repository_format_partial_clone is set
before any code in promisor-remote.c accesses it.

To simplify the code, move all such config reading to promisor-remote.c.
By doing this, it will be easier to see when
repository_format_partial_clone is written and, thus, to reason about
the code. This will be especially helpful in a subsequent commit, which
modifies this code.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h           |  1 -
 promisor-remote.c | 14 +++++++++-----
 promisor-remote.h |  6 ------
 setup.c           | 10 +++++++---
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index ba04ff8bd3..dbdcec8601 100644
--- a/cache.h
+++ b/cache.h
@@ -1061,7 +1061,6 @@ extern int repository_format_worktree_config;
 struct repository_format {
 	int version;
 	int precious_objects;
-	char *partial_clone; /* value of extensions.partialclone */
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
diff --git a/promisor-remote.c b/promisor-remote.c
index da3f2ca261..c0e5061dfe 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -7,11 +7,6 @@
 
 static char *repository_format_partial_clone;
 
-void set_repository_format_partial_clone(char *partial_clone)
-{
-	repository_format_partial_clone = xstrdup_or_null(partial_clone);
-}
-
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
@@ -99,6 +94,15 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	size_t namelen;
 	const char *subkey;
 
+	if (!strcmp(var, "extensions.partialclone")) {
+		/*
+		 * NULL value is handled in handle_extension_v0 in setup.c.
+		 */
+		if (value)
+			repository_format_partial_clone = xstrdup(value);
+		return 0;
+	}
+
 	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
 
diff --git a/promisor-remote.h b/promisor-remote.h
index c7a14063c5..687210ab87 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -32,10 +32,4 @@ int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
 			       int oid_nr);
 
-/*
- * This should be used only once from setup.c to set the value we got
- * from the extensions.partialclone config option.
- */
-void set_repository_format_partial_clone(char *partial_clone);
-
 #endif /* PROMISOR_REMOTE_H */
diff --git a/setup.c b/setup.c
index 59e2facd9d..d60b6bc554 100644
--- a/setup.c
+++ b/setup.c
@@ -470,7 +470,13 @@ static enum extension_result handle_extension_v0(const char *var,
 		} else if (!strcmp(ext, "partialclone")) {
 			if (!value)
 				return config_error_nonbool(var);
-			data->partial_clone = xstrdup(value);
+			/*
+			 * This config variable will be read together with the
+			 * other relevant config variables in
+			 * promisor_remote_config() in promisor_remote.c, so we
+			 * do not need to read it here. Just report that this
+			 * extension is known.
+			 */
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
@@ -566,7 +572,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	set_repository_format_partial_clone(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
@@ -650,7 +655,6 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->unknown_extensions, 0);
 	string_list_clear(&format->v1_only_extensions, 0);
 	free(format->work_tree);
-	free(format->partial_clone);
 	init_repository_format(format);
 }
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

