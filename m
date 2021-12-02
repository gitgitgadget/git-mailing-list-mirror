Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2EAC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359501AbhLBXfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 18:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358920AbhLBXfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 18:35:07 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417F2C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 15:31:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a23-20020a62bd17000000b004a3f6892612so669695pff.22
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 15:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xL0qRtG3jpFuZiCHCBtFkNp8xX0/mWNr3dGigCzW0OU=;
        b=l7tGx4MP5++s6YBVxlR0WS+82IzDEOX3f93XQjO1233HXrcQFPdbZhxTpbKL8E2LUc
         6oM9u+1yA/JuQ/apakMpyvJmZK4weTpYGHenh1ItQ3/t3sTlI8HatPQEg98y1bqnonmd
         LbClAbMGFfftRjo+7BZJPmR5SnUczt+D9SxWkpgvnZOC0Fm79GT28AT+XOOwQRfm97+v
         kUs61n3BpXcAN750n//pnStBfcY/IPXS8fo4KFekEdzVv52FLJN6UtbmVeDXd2vMioTR
         ZviRPybIOpShovZXSPb24b7hGDZhsT48PHKfwlkbfFYKNzpPCMAeF13vNhaEi6VUYj/a
         omRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xL0qRtG3jpFuZiCHCBtFkNp8xX0/mWNr3dGigCzW0OU=;
        b=o6TV0Eyz75xl6b8gUO7HpRMVO+aXoh4ebW8y0Yzh09jZMip7A7gY0RQDopG50BgxJl
         ksxEYepVksX7UTayZgkqDc4knvbaS4G0ECQNgGx8jZYsvTSEyJmXjqEfOLZ6RzuC1z8R
         3/2rntfT3uI/FGsCcJQKuKzcXNGLaJ/GSP0Y30sVbpC1lvu62lQ1ou6UXhJ68Jo5xG7R
         H+/f4+NwzfXTDKL/2PXBe+nDmXjQ8eb3HZMDywnz9+6nso9IbGRpO4+tK1rrhoSd/WcF
         TH2PrRTe3Xc7WUp7hAORaeRMl8qVMSFASR+4O1HoCnOQc95P+FNoDknBeGdBH9rKILbD
         rRuQ==
X-Gm-Message-State: AOAM531dRoql29LMub3NJxPQpqaw51fO9FKWY+0h+n9aV5uGw3PN9a7+
        Zkb1s7VXlccrisMEPf/81QKp/my4GFH2EeukVO/CQwQ2BhL1dP+KzZFqFrwqqiNZO4vK8PNBjkv
        1siginYSkmMehclp94/XDkcds65bu/a6GNjMjCcIOt6zpM9GjfpZu21VvTPNYdddfQa1YgykKx6
        Dt
X-Google-Smtp-Source: ABdhPJxuY7a84LNgxAYdQxIdNInVepcEBhp7dVBoMYlRpOpWqX/kqFlnUo9x9Y/fIBBS9SVojXYS6UMMwow0I43CskQ/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:30cd:b0:141:c6dd:4d03 with
 SMTP id s13-20020a17090330cd00b00141c6dd4d03mr18830001plc.16.1638487903597;
 Thu, 02 Dec 2021 15:31:43 -0800 (PST)
Date:   Thu,  2 Dec 2021 15:31:37 -0800
In-Reply-To: <cover.1638487815.git.jonathantanmy@google.com>
Message-Id: <b2dcae03ed3016f96a5368db925fa3736c3d7c58.1638487815.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1638487815.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v5 1/2] config: make git_config_include() static
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
2.34.1.400.ga245620fadb-goog

