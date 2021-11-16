Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B61C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD161546
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhKPDog (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhKPDn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:43:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8DC0431AA
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 16:00:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q15-20020a65624f000000b002e6a7b9f4b8so2635803pgv.15
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8xfzQ53WXiTTyyVuDiDPuif4fMupu6zI7pTXbN6QDyg=;
        b=Kg3lI22tnQTiH/L5lyYUy3ALZM+n1lRouY/8yHROIVkJeyaduXVUMQ3fSDHzkcU5KP
         fFPdmXof7hHS0x25sb/ADU20dCQ3e7+mMpmdHBfANDbbXJ/yDZWcLwOtcx69g3sefBAh
         YAtBMECDdN+r36uEBQxESdXmHL0p22pn9kHjrQckrm42U8FY5eVPtCiUiqy4B4ZJxoJX
         WaUoEOelUSyIn7WlGYZZjQHxtMSZzvH3qfYiVXKoxBcZa29UhvvqjYOCt5LRBNXvhi/Z
         UGmUS97oG7GK1lu7Dr5DRYmImlpF2r6MUrP6VU+AVEEDY++GxVgb1KXF5A/KL3yE0TxO
         ftYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8xfzQ53WXiTTyyVuDiDPuif4fMupu6zI7pTXbN6QDyg=;
        b=hFFiODAKRGkUqxqvIGxtlVjEq41IZHnmNrSk2J4gKoTGNeRHqt1/HqLQGQrNSllEYU
         a2iez58Vr55s1WjXQBjsWuJNrh3h9/tDvTzQuWeljzmy84+CDvkxni7DIPD3SiNdCxHW
         4+e7WpqGP4ZaggH+K56nIhmxlDkN5M8zOKU9W5uDhdfZIIixU/bWQPHXSwPSZ2q1R1zY
         G3Czbv8mx4wFN6dnLFLw3Ji7vVvAZTwCjlxkA3TDRv1AYQeJC7R+WNW/H+D7dIiJ24P0
         nZ7D8TT9LqKtnbB3rK7dikz6wHWU0zsQzC8DYIqRE7Sa1UEXU6qZw1z8/hYZVhiFPuO3
         PSUw==
X-Gm-Message-State: AOAM532ajJmp/a25eCmm0Bm0z7m3akzF4hS2q2SRj0neVIhdYPBO8jeI
        ubCl9ICLKO+qKsVnaGtItI+TQEcx78FzPHiXCfSRCR1YoUKP+IIwHBjVAk4sjsjHXU80lS5VGoY
        039NhGJ+RBZi9bnOuXK01MOl35V0LG5V79gXi6dALRQ3qD75GdihpTFBjN7xVv58s7DbSrzfXKu
        9+
X-Google-Smtp-Source: ABdhPJxn2EB8/8EiWDkB7/IH+DOUxgpgWrfaZ/dJ0PYdmyFPc87Q7l+C7W7beHoiSkwkAgqce5HVH3INoBV8vMy5WvT/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1d82:: with SMTP id
 pf2mr26273541pjb.22.1637020840477; Mon, 15 Nov 2021 16:00:40 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:00:32 -0800
In-Reply-To: <cover.1637020610.git.jonathantanmy@google.com>
Message-Id: <b2dcae03ed3016f96a5368db925fa3736c3d7c58.1637020610.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1637020610.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v3 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, emilyshaffer@google.com,
        peff@peff.net, avarab@gmail.com, gitster@pobox.com
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
2.34.0.rc1.387.gb447b232ab-goog

