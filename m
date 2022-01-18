Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C47C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347558AbiARRrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347551AbiARRrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:47:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8DC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:47:47 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a4-20020a17090a70c400b001b21d9c8bc8so2013247pjm.7
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4CFwGdIP8OggbEJHR+LV0WQbEtAD8KXrbazgFBfUOBY=;
        b=csLsMQucUmVaD7EzFJ1dn8ZlRUdhZkPUq2oYET621ssUkAZTAhtttwVr08Rk6IXXSS
         9xaY+bD5a8yBozMYUqNXM1shDGYZDOvAkQ8X3hQnoIzHGoMCI622GXsSHyEbciGuZ/Gy
         jDCxaZyVBVgTp0cfcRV3sZaJhkrM97pOTzN/z7FcdDHIM73FJXSZ3ErNOYUZSPlxNseS
         njYAYSiEf4mvhiiCG8RJCn0bed2M0pc1e7nrM7/S7kDUY1hS65h5aGf0b1W5ufiohI/t
         zd/0tuEuaM/0nrSctIxl4CM+LP4BTipGR2RqoDct6KI3/yQJfMUrwKSM0zG72EvfARoM
         J+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4CFwGdIP8OggbEJHR+LV0WQbEtAD8KXrbazgFBfUOBY=;
        b=cGL3kPw92vUNrTWes7HbAbHaKvS6LTlwgp8MSHK4U7JL2OCvoiYZY/QseiTnnSvddQ
         TcqTPyTOLNbnIvOdZWdLUATdgaBCA+c7pU+AMOwiuppcqgjeFC9wCfe0SjhjpznvGznH
         BAqvU4fg3wdZs1be6nOB9jCra5Up0E3RtOcGdSeHZbM6MBur7zwsxYAGQNdXjqYZuGxG
         HzkU/F9SeddY/36SMpioRtFJxhW3BF0NIobLA2JT/jC7FeJUURV2t94T9VDbTqfDa9S7
         3Lb6jOfS9k4Y9YeIOizCJVMRFRN1aLphNy12JOmOGj7Zp6cX4lWmIXxwMJjWYqKvq+QL
         raXQ==
X-Gm-Message-State: AOAM533gKtEwLNc23TnA1WQ3wWHRt1BOMaitVNiw5p5zAbk7Efu3IS9Q
        F2vYW0RiMTi7Pe2Ru2L6Yr/uU4Ea8u/W9ReK6UUg0s7P7dfZcWFLQbuBk3KKryKS8p6QiaskWcu
        hZ1KCaaLXFc6Vq0VO08mDs+/ORDtWViQU9eIbpgVpMPvc7HryBg7UOAoVXMrFEe8mrqqtTKuu8S
        r+
X-Google-Smtp-Source: ABdhPJzG7lAWaVSTG/nV2cTslqs9QlowfIrvXJfKySOZa3wUXVX2vcUbr0gdx2nidvfhRfisYLzjYBBnWLP0OJqwFhBS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:11d0:b0:149:a969:400c with
 SMTP id q16-20020a17090311d000b00149a969400cmr28814072plh.120.1642528066789;
 Tue, 18 Jan 2022 09:47:46 -0800 (PST)
Date:   Tue, 18 Jan 2022 09:47:39 -0800
In-Reply-To: <cover.1642527965.git.jonathantanmy@google.com>
Message-Id: <b2dcae03ed3016f96a5368db925fa3736c3d7c58.1642527965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1642527965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v8 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        newren@gmail.com
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
2.34.1.703.g22d0c6ccf7-goog

