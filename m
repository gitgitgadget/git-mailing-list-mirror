Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B49C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6C2610A0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhJ2Rdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhJ2Rdp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 13:33:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4F5C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:31:17 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so5411338pfz.4
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ESCCIV+gkyKr4ja9Eq5D6Sw1Q0+B0wgbom/oxzBH/rQ=;
        b=S0Z30HhBg1ixGRzVECbg3Y+xjwOxO8JgvkGeNDwBVOAcl5e4UW1VXnQFR6UZdQeWpV
         5UmKGI3FRQZbtaZqcJZeo7IWavouut1+Oij8evTZfQx3jzYWGGMBR5EnMd/STBr8A8op
         tAcfY0tyGMClzWhfy6bcmJAwEWtd9kDhOYRuzy9t7Bo3wkLgCNeLkC2/NmpcbkoLiycF
         T3WVCaxSmw51f9G+8UZixOylXfVibhkksXQxmqi5mB6Mkdxjb0YVtRnm66p4efL/X+I8
         TculeNbgJMYRvr838aLmsfAxFsFSFgaXeuKtA7ujfiDs4qeaJzpifwWTLWukdSXQ+koD
         MVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ESCCIV+gkyKr4ja9Eq5D6Sw1Q0+B0wgbom/oxzBH/rQ=;
        b=0OJ+jF9HUvFM88M4Vv2ca1l9B7bJ1OnwunvESSVNyfhX6kDZsa0pL5iGjyWKx9/eJ2
         w+yqg2ccc5Xz/BYeG7c04UvYgYLMDtIjdr3hBUSa4rLdmcBr9+IEFBV4gfl3Y+ijJ/A4
         BfuCec2boLCaOS5cbDj1ogsrZb4nR7nN7vVM364i9YkvuR7NLrgNC9SWD4ll+edwaU3C
         5YUZ8vQYPdrhbAsYZHRPio6xn6VZ3IdRo6N44jhBvzPcTgoz8lJhNxI+guc+7n7ew+to
         //VDCVcMw7m7mF4SMapwmbBN59KJ9+g0KRptummyh5iHeuye5dTNPKeER8JyQU6NMS6B
         ZlEQ==
X-Gm-Message-State: AOAM530Lue8j5XEKAV8a8IqaMZisgg4pd1oJFMyQwm5kq660ZkyjVUs5
        adIEMABLbKQ8FEpNv9dXirBNO1iVYTgBWhU0g21JxwYe1kbp3aIaLyqxCyBafZpv3wS6vDr4yfu
        8XqleeKSSP88hkYspQLkKZfIVLbrUlzWjfMMgCvCYIOtHeVB1FJeZavB4plGZ2DGqpjqJ2znm5B
        8/
X-Google-Smtp-Source: ABdhPJw1V1jkKMZ7czM0cnau0QgU7HqPEfD1oHRd5nFkHK3hPeKlwVTfwanKUG/nygRisiFVJvZX5CCAfEYurZdaVK1w
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr391893pjh.1.1635528675943; Fri, 29 Oct 2021 10:31:15 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:31:09 -0700
In-Reply-To: <cover.1635527389.git.jonathantanmy@google.com>
Message-Id: <3879e94c822421774001c823635f06235f50bfde.1635527389.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1635527389.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [WIP v2 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
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
2.33.1.1089.g2158813163f-goog

