Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF12DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C5D60724
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhJLW7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:59:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB7AC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:57:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso1136055ybn.2
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S2v4vcdCW8Y+dgw37yAm6UFuH5UTWRWSWIE5hOS6DuQ=;
        b=tHCwK754Jxli8YahlfhlOsNKWvUDE4auoFEGTB8uSr2tUQm4Q3pYm0um9LjRwaCP97
         9r9P9QNH8OGJ+cVaDdCoBbsMHtoduflidYPi8QseDlKRrkpp2qFWzlWhgwWMvh+5exvd
         S8NF+VIBObfpUtoAeNeO1rMH0AoNW6te6XQlsNcfLNY5BOtOs32K7zDF3POCgQzHUdKm
         NFaAKnANTPeRYEaOJZ0F6R6HHZHIQICrHhUjLCXzs8Es7fv33rTCUKXJY6StBnnujYN7
         46QdDpradYgulTulZwWFk7jQiNJi43gObdAUI6vhDmjzUpfNn+1pnNRBRlBjt/DGn2yN
         DuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S2v4vcdCW8Y+dgw37yAm6UFuH5UTWRWSWIE5hOS6DuQ=;
        b=EM/qHqN4rJU41w+qvJ3jpxFJBjyODCFoEMx5dF4J0OmzweFavxeKQY9TQvI+U3gS9I
         go1zxpFraMPHD7msEALwoL3QffGmYiv1NBcV3lqJQ+jyF08uW+C9kY/IsfSyrC3LjDFd
         ZVzT00btW+Eo4j49cJmUyujyHo0LG8Da28Bt4RG3+8PisPqX3/IsHv9/AH0pmwUgi6E+
         Me8qnHQIhP/NZVy7wYC7+oonkBNc8AlqHVxcw1lt1tBnUrhLaZ0lNO3aQJkSc8QrbktM
         OmuO38dDNzZtW6tO8A/sJB4Boe8HiZ5PqgNw12yr43hdWtFd5bgSQE7XQUFvlhG9gblD
         IErA==
X-Gm-Message-State: AOAM532aIQHXzmvoNf7lnD2xIPjqzFIpMhPxKdP/psv+uJ75SqsEBzHx
        uJTQ4znp6iXvhTj7PGIdz6jRF0IZcndsWhKyOHbea56ESKzFsvD6ScCR0NcYMQbe8WKzwp+huuL
        eSK3EkoKzMuEZ4GZNGrpN63ce9smiwQECJDeAX7qkRS685aNOTmzZxC9AaI1qvR/JlS91ifZw9v
        Vh
X-Google-Smtp-Source: ABdhPJzMbm4d/nMxEJwXKuND8CM/u5Nb6wRp8XuIicAOrtf6FOnMqpVDoTKhvI3BTnRDRtDrLK8Dx/SZ3OCBf3PYtRYc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:400d:: with SMTP id
 n13mr30628807yba.284.1634079450775; Tue, 12 Oct 2021 15:57:30 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:57:22 -0700
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index 2edf835262..365d57833b 100644
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
index 147f5e0490..b11b0be09a 100644
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
 
@@ -339,39 +343,6 @@ const char *current_config_origin_type(void);
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
2.33.0.882.g93a45727a2-goog

