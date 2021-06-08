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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CBBC4743F
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF76611BD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFHA2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhFHA2O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:28:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A1C061789
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 17:26:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e12-20020a17090a630cb029016de1736f41so6222876pjj.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fs3dS7gGKmtreGGRveiB5U5kmMhmWktwIZKtGKPRLCA=;
        b=SYRPKIFrCZ4UvqgDO8b+w9wz69GwtuPxVQv7rFTrIL8mflIKdMzltes8jrV8P8a6/4
         As0DCmqrV2i0LWwd8pmPmGAn9RXjNDE1D6iOGLTEKAVrZ2fhUATWlbM+jvxp7wkL03Ws
         7tux7NHil9IeAkBtFDCB9XRqJT91lArc8kFGI+WM1tTy2vqLxI/O78JJ4Yw0e/8B6bvY
         Bd/zyzPqKFn6lnW0k9G0PC963az5MUh9OJiJdVGT2sYJHswaVqg3nDWmmPoxG9rOoBIp
         D+bm4niaol2/EdZ2IiyN7IwXa5rnypu7d4MyIpWiXPeEM9E10MWGDTccLvlZUKTJ1Byq
         hWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fs3dS7gGKmtreGGRveiB5U5kmMhmWktwIZKtGKPRLCA=;
        b=i9a/SubFK7Nlzjzmb+23b82EtkVZ22nV032pAS+IBDJCs03GTSo5Kx5nKmoUy1AXrc
         tck7NP2lunc4vQhmikZ6+Y0fb29gjkmip71EGZVsg3692Ka/+XCIOECMAvhLzMJyToo6
         oIlIBLZIkwD3BKSCXuPQTt4pbyqLDxnJTiOCJN15lT77F0TLWMuD5LOcEBjhU4vbPhQ/
         h84nbWXk/gC1mFztV+1y1oMp04U94Vk/BGTUV11WflaEfgKZ6U2E1/K7BNyUIds328T6
         46zYYXLgQuuET5JXlILlfNhXDz2icwTQY8N5sDIEmk6f2m7kcEKiag6sLtqjKFWfSc7b
         pLxg==
X-Gm-Message-State: AOAM533Mj84QmZUzATeOTk6YeDbNIabSy+/Xcxj9dN9+qNHPw8hS0DgQ
        WTZhtK04RQkwS2Py9rqj/ohW2QsTmhEqAT0suMBRMmlXCFW3CNtDTkR8upehAyJwQOIgceF0C2l
        qrJyThdcb+o1OT8HYkD0zPpWo+u5ANjvnbRJRNYoCDmrfu4+E+AhXQPavZIpIp5GP60Tz1uydGi
        AI
X-Google-Smtp-Source: ABdhPJyrOHwLeTzEquAlmjgGEZZGPIeU9Gm1UMV3GC/7pi00w+v7uyHeCFIZC1pPFKyiRLANXfdlyQ5Qkd7weja2z4Tp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:904a:b029:101:af84:4f55 with
 SMTP id w10-20020a170902904ab0290101af844f55mr20539341plz.80.1623111967686;
 Mon, 07 Jun 2021 17:26:07 -0700 (PDT)
Date:   Mon,  7 Jun 2021 17:25:58 -0700
In-Reply-To: <cover.1623111879.git.jonathantanmy@google.com>
Message-Id: <9cbdf60981e66e938b6c57c041c15e85245c734d.1623111879.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623111879.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v2 3/4] run-command: move envvar-resetting function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
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
 run-command.h |  9 +++++++++
 submodule.c   | 14 ++------------
 3 files changed, 21 insertions(+), 12 deletions(-)

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
index d08414a92e..a1d9107f5b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -483,4 +483,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
 			       task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
+/**
+ * Convenience function which adds all GIT_* environment variables to env_array
+ * with the exception of GIT_CONFIG_PARAMETERS. When used as the env_array of a
+ * subprocess, these entries cause the corresponding environment variables to
+ * be unset in the subprocess. See local_repo_env in cache.h for more
+ * information.
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
2.32.0.rc1.229.g3e70b5a671-goog

