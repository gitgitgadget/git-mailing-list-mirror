Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2227EC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhK2Wgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhK2WgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:36:10 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876CFC08ED69
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:23:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso10240545pjk.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NoERD4dVZ7CXLEZp3FY4c8Q0SBMDrd/FbsDgs/50fjk=;
        b=Orvb3OypLW9G2vLxbP/Pvuste843kWSMI0i98azaVYdv5cVxyfBvCM9JVSqoQsVdkS
         yDulxtXVJTuHaZrn7VoJ3vlMy6bhT/R7EYm8wS3NZRWbh5umt2SeYxDn9/2qAY/oWOOZ
         OgnLT/py+8SP6g41h7peYlqcprSz3+WRCpZuRHDQ/kJ8C3QnBH1HJQn+KCH6WI8mr71W
         B0I/VFzeqJGNdYoOcrychlWptUtjY/MgzPMMvChwyzRV3ijmgQKGLbc8pzqJasItDcGD
         tir8TVMrKqs0Pd3aDqPhY+h/7/yUpzUEJFXGDP0j5iDi9+PnvbSm18W+w83h3aaiDfy2
         l/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NoERD4dVZ7CXLEZp3FY4c8Q0SBMDrd/FbsDgs/50fjk=;
        b=K4PLcjinhshyu1zeB/JY3ntCtkpAhAXbe/QZ7+SvD1TwxJB4N2pBBZRuQU1gz9vawy
         BFl3FqkYP3FFL+/JsIPDpk2JAqzCHQCuNT3DTd2roaWBDHrRr8nce/8W66fjTRuYdlfV
         SFj+wvX004PQ9jFOy8B+tzOlCn3mxR2JKdm/EW8Nur+4Hw5AQRLz+kUPhoWnXw2WW9jd
         YzVPHQUe3MJp6olDn4ImddrTmDjqd+6iMbcCBHhgc/3sKo5wSk50YVTvPjqjMFQBjQU4
         XaYSZ6WatQrA2KD23trpHNw4AKJP7986KzuxaU1gg8wBGHh/XaKep/e/zKO3wfJMuA08
         IT7A==
X-Gm-Message-State: AOAM531B4eaPyG14TmOTdgpoETtRor0sqBq/Hbz2K9x2w3CGYj9D+UUF
        j2ryhnE+4S+RDSYiJw7e4QtXHxXOols+HAQjCQrL2AnmyA8aMyhcS0Dfy7cnwN/zXdnsxn+OBJS
        XfbbmTAgzEqTqozkHwWrW4Yk4dnPyN2QlB7i03/xRUxbeUVk3PH89bC+MQ8IaJBxylzDOHf9132
        zL
X-Google-Smtp-Source: ABdhPJzc+O6MvuepssQ6+ACTHSi+pvPcl+hnhrxA/X7ME2xjydqjPFyEYPh4H9gWdBDsdBrnn1YBrbjQ5k83pzE/kL6d
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4a83:: with SMTP id
 lp3mr440810pjb.34.1638217428023; Mon, 29 Nov 2021 12:23:48 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:23:41 -0800
In-Reply-To: <cover.1638217387.git.jonathantanmy@google.com>
Message-Id: <b2dcae03ed3016f96a5368db925fa3736c3d7c58.1638217387.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1638217387.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not used from outside the file in which it is declared.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 config.c | 12 +++++++++++-
 config.h | 37 ++++---------------------------------
 2 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/config.c b/config.c
index 2dcbe901b6..94ad5ce913 100644
--- a/config.c
+++ b/config.c
@@ -120,6 +120,16 @@ static long config_buf_ftell(struct config_source *conf)
 	return conf->u.buf.pos;
 }
 
+struct config_include_data {
+	int depth;
+	config_fn_t fn;
+	void *data;
+	const struct config_options *opts;
+};
+#define CONFIG_INCLUDE_INIT { 0 }
+
+static int git_config_include(const char *var, const char *value, void *data);
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] = N_(
 "exceeded maximum include depth (%d) while including\n"
@@ -306,7 +316,7 @@ static int include_condition_is_true(const struct config_options *opts,
 	return 0;
 }
 
-int git_config_include(const char *var, const char *value, void *data)
+static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
 	const char *cond, *key;
diff --git a/config.h b/config.h
index f119de0130..48a5e472ca 100644
--- a/config.h
+++ b/config.h
@@ -126,6 +126,8 @@ int git_default_config(const char *, const char *, void *);
 /**
  * Read a specific file in git-config format.
  * This function takes the same callback and data parameters as `git_config`.
+ *
+ * Unlike git_config(), this function does not respect includes.
  */
 int git_config_from_file(config_fn_t fn, const char *, void *);
 
@@ -158,6 +160,8 @@ void read_very_early_config(config_fn_t cb, void *data);
  * will first feed the user-wide one to the callback, and then the
  * repo-specific one; by overwriting, the higher-priority repo-specific
  * value is left at the end).
+ *
+ * Unlike git_config_from_file(), this function respects includes.
  */
 void git_config(config_fn_t fn, void *);
 
@@ -338,39 +342,6 @@ const char *current_config_origin_type(void);
 const char *current_config_name(void);
 int current_config_line(void);
 
-/**
- * Include Directives
- * ------------------
- *
- * By default, the config parser does not respect include directives.
- * However, a caller can use the special `git_config_include` wrapper
- * callback to support them. To do so, you simply wrap your "real" callback
- * function and data pointer in a `struct config_include_data`, and pass
- * the wrapper to the regular config-reading functions. For example:
- *
- * -------------------------------------------
- * int read_file_with_include(const char *file, config_fn_t fn, void *data)
- * {
- * struct config_include_data inc = CONFIG_INCLUDE_INIT;
- * inc.fn = fn;
- * inc.data = data;
- * return git_config_from_file(git_config_include, file, &inc);
- * }
- * -------------------------------------------
- *
- * `git_config` respects includes automatically. The lower-level
- * `git_config_from_file` does not.
- *
- */
-struct config_include_data {
-	int depth;
-	config_fn_t fn;
-	void *data;
-	const struct config_options *opts;
-};
-#define CONFIG_INCLUDE_INIT { 0 }
-int git_config_include(const char *name, const char *value, void *data);
-
 /*
  * Match and parse a config key of the form:
  *
-- 
2.34.0.rc2.393.gf8c9666880-goog

