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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC82C49EA2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484F8613D6
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFQRPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhFQRPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:15:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0159C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:37 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c15-20020ae9e20f0000b02903aafa8c83e7so1773907qkc.21
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FE4RwdAK1219mLrHfLfE5RXM90DqsMMKszEJR7HPT50=;
        b=mLvpl6smT/GnxEQ4it5hNTeEqGhj1ONFfo5M4FWiweQtTInjq7mcvHBuC3fKdgHOem
         dewJdUMYNV/4yNXe8h133Wc87H9ZCLAu3oc1RP6a36BJoVJ2yzgOl+giueoT2hhwCGXG
         NpJIX8J1puUzxUAmL8roWgEscBTh+HWU2bAQhP61nlHg3h/uVZbBiYnviXL9E9byTD2L
         PVJXg7wA3CSP10qmPSKb9VBngJh64sHsTV6qewpzh/+Jt033AqKUWjknrkzQ+53wVlRg
         fBSU4OFpcrRs2gB/FSbzoP13pdzB/xpRlaounpEFBj/cCPKEickQYD9mr1PvsqJoPWs+
         rhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FE4RwdAK1219mLrHfLfE5RXM90DqsMMKszEJR7HPT50=;
        b=egDg1XfzoUxmrdSfjFI12vaBBrbww5LUMxvrc7zEdWqzCcwLySgVxHr6r/CCj+13FK
         WDOsyPJ38rfUg0o5u7bk5Tm4LtgwlZ9/c8lCJngZmiAeIJYX6I7sHt48rQm8oa2RTS+U
         67pCHW+T0OPTnzytBrVuxWLcv3iPG3x51YpVkzmMCRayK3Eqdsy27yDOUGFfJkOXRbUh
         M/1upYWQ219+QbdmCqSV0EOrp3t0uSilQdcN/laK9gDhT1/zMhr6uf/mcSAtFW1SItrf
         pXG/Y8J/pm1T6kdb4tcaAp+bqW7her8I9UnNQOFKI13/4apyBvJXmi0/BlN68ymvsIOZ
         imbg==
X-Gm-Message-State: AOAM53331d7Ly0bWXAQt4B7R+sKFqgU0EdPtTUhNKoSa619r4225qm56
        YzRlqf4yP1BQNipSomYjafc0oCSTQesbbKu+RGEgZD6ws6qm0p1qcfsPxN4jTvo7KwAEZeFAb3V
        8/U4vVEiO1u/CHXUzP0fcYiMj4QinYElAmh2CaeaqFFxFpw33Hnlu/AQv7uDnhFPI7Wc5mCso4i
        2X
X-Google-Smtp-Source: ABdhPJx7XilBKW842hlniSugLRkX8I7LxY1baBbJAcvV9WUpcIiBjjdd2RObQrwZiVqLo9QYfJgaR3V7HKliOLPamiDm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:ba05:: with SMTP id
 w5mr861304qvf.60.1623950016706; Thu, 17 Jun 2021 10:13:36 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:13:25 -0700
In-Reply-To: <cover.1623949899.git.jonathantanmy@google.com>
Message-Id: <1778cbf878b992c9e00e0d0f54301426467977ab.1623949899.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623949899.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 4/5] run-command: refactor subprocess env preparation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule.c has functionality that prepares the environment for running
a subprocess in a new repo. The lazy-fetching code (used in partial
clones) will need this in a subsequent commit, so move it to a more
central location.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 12 ++++++++++++
 run-command.h | 10 ++++++++++
 submodule.c   | 18 ++----------------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index be6bc128cd..549a94a6a4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1892,3 +1892,15 @@ int run_auto_maintenance(int quiet)
 
 	return run_command(&maint);
 }
+
+void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
+		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
+			strvec_push(env_array, *var);
+	}
+	strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
+}
diff --git a/run-command.h b/run-command.h
index d08414a92e..22132536a9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -483,4 +483,14 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
 			       task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
+/**
+ * Convenience function which prepares env_array for a command to be run in a
+ * new repo. This adds all GIT_* environment variables to env_array with the
+ * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
+ * corresponding environment variables to be unset in the subprocess) and adds
+ * an environment variable pointing to new_git_dir. See local_repo_env in
+ * cache.h for more information.
+ */
+void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
+
 #endif
diff --git a/submodule.c b/submodule.c
index f09031e397..8e611fe1db 100644
--- a/submodule.c
+++ b/submodule.c
@@ -484,28 +484,14 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 	strbuf_release(&sb);
 }
 
-static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
-		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
-			strvec_push(out, *var);
-	}
-}
-
 void prepare_submodule_repo_env(struct strvec *out)
 {
-	prepare_submodule_repo_env_no_git_dir(out);
-	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
-		     DEFAULT_GIT_DIR_ENVIRONMENT);
+	prepare_other_repo_env(out, DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
 static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
 {
-	prepare_submodule_repo_env_no_git_dir(out);
-	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+	prepare_other_repo_env(out, ".");
 }
 
 /*
-- 
2.32.0.272.g935e593368-goog

