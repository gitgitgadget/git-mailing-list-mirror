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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45298C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E64613B4
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhFAVgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhFAVgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:36:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD69C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:34:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g19-20020a63e6130000b029021f61637110so280526pgh.7
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hM0y6xP0gAelDsSPx2n5odMECU4tSgapUPWuMGz8jhI=;
        b=luy+KVGdFmX7vyaOVAZJKhHzMobOL67a3WKXbr5X+xUJCu+o5xWSdgsYFATNfHPQfa
         E9e7pvq5C52WKRC7QLngIRoc16lhClsIA76r5qvzJ1M3RzlkZaE6HMSR8UFZFrdUuUT7
         PBonyJoz0y7M1ce5BTE/AzPrnYzHBeMuT/nf9NjMfvwtCgKuTxzpBC8uGp1GxxwLvLnv
         mnlXh54TkovL/eGOuCi3XZO7XCc51Gv0M6PjJM/5iMm5XGjmnZ8nge6sDXVAw95cKJ1f
         +kvcQIK/gcSAduLkyrJ59MauW1X/LivIv9Q/VkxewJYL4MNQct2IRUEk1531R5WvjBpr
         sPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hM0y6xP0gAelDsSPx2n5odMECU4tSgapUPWuMGz8jhI=;
        b=ZMylM6j1KfEIsRhQ0Ysaige76KSOl8h/1ZJWbBnP284/TtAUt2Bix+ZPW53IZhZqXv
         FcQomsyM/x1WV76qDCnAy+vQvVItMC2gRLcXeWLNJJOc2RGDoga/JLtZUQyTnsZAlN0r
         tsapgfsULt3ClZpjv7Y6vpy/6L0cHDRFmhFk/3noCcYqP26RpvD/ereodXIUUOAhAllq
         lQ+cSIYPbiy6a+bJkS/C66Re1rMX3yWZK5iKAyequLc3i3HkDuIqGQujXX0bU3dPsLbF
         0z/j38QRgzO0tWqpI6jHdvAJ+Iyd/bVkmLzJNSCDEZVmX9rATK5lK+eqrVWuGRVdB2xf
         67sA==
X-Gm-Message-State: AOAM5330I3+e4lEcDsdg/rgYBkpKQ9U3fi5V2kWKUY2XXl7uhhw/iwQ9
        3HtqqWY01JgTQQ8CXonVqK0515y0uRKqDZMb/T1pn3AtPkVr6RW9hA2sEj3zZKJd3QMsXauKLF6
        AcI50fFupRYSz25ZXmin7GFdNVKizKT/j8IitQ5QaYqduLFl+moSGNBo1XtUQX8r+mojDuMNo1S
        Lc
X-Google-Smtp-Source: ABdhPJzHQugN9kyvGy0JtgfIy8MLwXZkCUjuttRhDle2dKjKo31onm2N0V/53FkZTvPB1NujCB/GcnKoB2wOuBtuacnK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:3046:b029:ee:f24a:7517 with
 SMTP id u6-20020a1709033046b02900eef24a7517mr28092984pla.17.1622583267954;
 Tue, 01 Jun 2021 14:34:27 -0700 (PDT)
Date:   Tue,  1 Jun 2021 14:34:18 -0700
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Message-Id: <c5307a9f02f3f0f9b30c87bb3e9f8fa3163f839d.1622580781.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 3/4] run-command: move envvar-resetting function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a function that resets environment variables, used when
invoking a sub-process in a submodule. The lazy-fetching code (used in
partial clones) will need this function in a subsequent commit, so move
it to a more central location.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 run-command.c | 10 ++++++++++
 run-command.h |  7 +++++++
 submodule.c   | 14 ++------------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index be6bc128cd..a6c458119c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1892,3 +1892,13 @@ int run_auto_maintenance(int quiet)
 
 	return run_command(&maint);
 }
+
+void prepare_other_repo_env(struct strvec *env_array)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
+			strvec_push(env_array, *var);
+	}
+}
diff --git a/run-command.h b/run-command.h
index d08414a92e..6f61ec7703 100644
--- a/run-command.h
+++ b/run-command.h
@@ -483,4 +483,11 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
 			       task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
+/**
+ * Convenience function that adds entries to env_array that resets all
+ * repo-specific environment variables except for CONFIG_DATA_ENVIRONMENT. See
+ * local_repo_env in cache.h for more information.
+ */
+void prepare_other_repo_env(struct strvec *env_array);
+
 #endif
diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..a30216db52 100644
--- a/submodule.c
+++ b/submodule.c
@@ -484,26 +484,16 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 	strbuf_release(&sb);
 }
 
-static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
-			strvec_push(out, *var);
-	}
-}
-
 void prepare_submodule_repo_env(struct strvec *out)
 {
-	prepare_submodule_repo_env_no_git_dir(out);
+	prepare_other_repo_env(out);
 	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
 		     DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
 static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
 {
-	prepare_submodule_repo_env_no_git_dir(out);
+	prepare_other_repo_env(out);
 	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
 }
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

