Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E22BC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 21:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhLNVb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 16:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhLNVb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 16:31:58 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F8C06173E
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 13:31:57 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r9-20020a17090a0ac900b001b0fa2ca6a5so118739pje.0
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 13:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BBzycCyw8+bZ9XsYpLcyJwX6ZkeyE8VrVxKM7Y3RzLc=;
        b=eiH8xY0AmicbaBqMjFsmDYMxUOxDzMo+96ycntgO2kgOtmYF+hZZ9lgpqkera0rU8C
         qHV6/mF+GetgtBKBy7P6x2/4r5g+C5CyWfm4sfDQ7hgeA8OIXmiemI+zV9sDbG4ouVNF
         lDsvi3Hli2E6i9aIlm4yH6+icgrj2JybVRJVS1C9HID8oxjUA/XGSNvDNlfpSiH/3lWj
         6vDhLFu10lphpk/qe1pdM3kK8fjWt4qX9J3AcsGfGhro5GIGKjDEfHIFFPG/gqCNNlKq
         H+G96/bpffHlDB6eyelTrK+P254bbUcbanCf+/EHCDFBjsT/8iAOMNit7fMocQ4S9NnE
         Dl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BBzycCyw8+bZ9XsYpLcyJwX6ZkeyE8VrVxKM7Y3RzLc=;
        b=fhW2nv4ZyMkQ2PdVGLM76SCkH+Nwbj6VMJBhRmL76juqsdkPrf6LStY5HcK8at7vye
         1NwkwaJj3sUYjbJCmeJwNrs26U8q/CGP7yOlrgnBCtOXkP8YezJtN6M8oO4eXDfya7VQ
         lCnCJZ9PWlUFCVHf10MGRSlhMxE/J+uOTBeTery+NNs0Yg05lTVgUh8im5orSJg9eokK
         bhQ37GbHwDDKeVzLYNt2M9u63NM+blJjHXCIu0WubDZ7eVATOMldE+kXW5To7OmwWT84
         Sjeu8R9gga8+pGduOk1DOOUoOopTPCQfkZnTnpqJVcu0+quKf1BsvpgrzCCXRJCh/3N/
         OnMw==
X-Gm-Message-State: AOAM532xcTM9x9j/kg3x5yxqC5lVGivIF68pfYgMJRPR4WBjsqlMh04M
        hXrZgE1XLgjf+WuAu3l79Q7CDo+9JNJZZzKeMPrsDy3InQcSPpnkdxPAIEhH2KrCRPK8npjdDD8
        IaZkw7Z8iSjQM3dHlUALDIy8TpTIn+hiV7ostaRHy6gjDHmrAXGrwWZjfBTfQ9AzC/wNkAtTfPC
        Lw
X-Google-Smtp-Source: ABdhPJwYmwkVhDFEZDMj1mGnUmZ9nwDs6FvRwyVgnf3qNTk5k6GxmUJF6NyCdwOtCF/7D9EOLRh7O0gsgZDozozfoyNW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:f70c:: with SMTP id
 x12mr5320499pgh.602.1639517517011; Tue, 14 Dec 2021 13:31:57 -0800 (PST)
Date:   Tue, 14 Dec 2021 13:31:49 -0800
In-Reply-To: <cover.1639509048.git.jonathantanmy@google.com>
Message-Id: <b2dcae03ed3016f96a5368db925fa3736c3d7c58.1639509048.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1639509048.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        gitster@pobox.com
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
2.34.1.173.g76aa8bc2d0-goog

