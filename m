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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D4C47092
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3359C613B4
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhFAVgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhFAVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:36:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF9C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:34:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c13-20020a17090aa60db029015c73ea2ce5so416293pjq.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c3WZNePQNwKfHaA1HR0g2/5liANeQe1ODCwuHHbODa8=;
        b=hsp7GtMNY1dSQNq3KmEWZlxd+1YftWSpFcVQlgAXIiHWE4wkDz7Jtr3XH8hAI5SjoJ
         dgQPoKgQp4voXvbYpvpcgeBEn0+LXlfEC4IgLhpDtIX7p5TOrdfGTSpk82P7wqrK+rVb
         /moScH5APPYkZaow5yXV9VeAooyxUudU/F+elX3nkICBbilibTst5TXRNeXM1+FhE5vu
         iNCC6Y4E52KKpyMNKURzhej6jxOcuntrYnaryRNVg5RWKustgxaM3rdhceJn1D/laGQ/
         e7pQsB/1dlfoWQp+GrhFJLbWu2dNjuZaEcBEOhNJ3R3VkuI1Sxa8O02XksNo7J5awECF
         GE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c3WZNePQNwKfHaA1HR0g2/5liANeQe1ODCwuHHbODa8=;
        b=JQiEsSEXX7FTo2S8/kSyD6EIMkrB1y6Hr3Igd+WEuC9LdNSM1yAn2P61DWrVKJ1yTx
         aOLHTV/AXySwtMPtmq31tDD0liajbPiG9rga3n55scVBm1MZWcYsuMfJDp6wpwphu30r
         Cui5wQXeoRV5MQCGIbJZt0AHTBI6VcMRErQ81Npi4RFtz3bqPUw3zBDv3mt4GjUOSxJE
         n1Iv/F9P85GDPJxiWzlmziF0pjcQcSjUmODhQutccb9u/894UQd7ZIsZbuo/KbFMHE9E
         E/Th2+N7JKhp4q7N4FregrIQahvQUCn3T8L2tdHMUO2CTzSEu0lmu7WGYUj8xCVj9B+o
         jDJw==
X-Gm-Message-State: AOAM530smG3K2lR6M0SfbfBem/qPL0chMT16HCNIfQ5cEbKidhsTf0eA
        vWugNQVArJhaEYA5gSWPWEbox5yTH0DLJ6emsC5ImN7sDtqdi12/jPSuy4tW/u08xIPHnBrgEGn
        /N2oKXMumWTmVmSODRjBleAMz0j+NfK7CajzcRKo/BMricxvtfVAFJsxuZvl52Ua3nFG51aEJib
        d0
X-Google-Smtp-Source: ABdhPJwGEkfJlJzRxxzlRwn/3SW/N1BqWZiBnJWyI5yscbEcE3JgCwMNm10GmItn9keLu++flfUqKnjmhmysXnEDKF07
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:51c2:0:b029:2e9:e4c5:2a74 with
 SMTP id f185-20020a6251c20000b02902e9e4c52a74mr9117785pfb.51.1622583264993;
 Tue, 01 Jun 2021 14:34:24 -0700 (PDT)
Date:   Tue,  1 Jun 2021 14:34:16 -0700
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Message-Id: <4a7ad9ffeb140c8b613c308280c2c234154ae2ab.1622580781.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
 promisor-remote.c | 10 +++++-----
 promisor-remote.h |  6 ------
 setup.c           | 10 +++++++---
 4 files changed, 12 insertions(+), 15 deletions(-)

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
index da3f2ca261..bfe8eee5f2 100644
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
@@ -99,6 +94,11 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	size_t namelen;
 	const char *subkey;
 
+	if (!strcmp(var, "extensions.partialclone")) {
+		repository_format_partial_clone = xstrdup(value);
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
2.32.0.rc0.204.g9fa02ecfa5-goog

