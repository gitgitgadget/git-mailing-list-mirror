Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A532C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 23:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhLGX1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 18:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhLGX1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 18:27:30 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BFC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 15:23:59 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so241199pgo.21
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xL0qRtG3jpFuZiCHCBtFkNp8xX0/mWNr3dGigCzW0OU=;
        b=Tj6cxn0LiufX3E5Y3P/0X4lp4eRZFW/UNsFUe3D8Rdh58GZUIo9JP5mGpnqlEgxIlR
         cBEttrIRTiDpP3sw8Bdx0cvKE6zQckznXVGiwFUINtAC5jzetT1xqmxzG3NQxD6bqjEg
         QcWmDZfY3puYUBZ9BU99NRkqIU//aPzdCJrHO+3Pf4SV3+D178kdOkEVq4xou/Kx5dy1
         TRaBJG0aTLJe6P4KdlYsarLrtArX8J/IEUyIkqmCwK8luN7BQ3AHs7Dv8FHLKxaDh2Vn
         M8lQj3toi4ezjX9KMBeyCmzXVJEtF5rdKeQsrW0ZpvIMgh+5PsmUuF6+QkRfBo5h88wd
         /NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xL0qRtG3jpFuZiCHCBtFkNp8xX0/mWNr3dGigCzW0OU=;
        b=06sEQZiFwGYqmbkZB4L+4N/6Hhs42Urn3u51R7rJM0veHeO8lo6EMHm8ObSgINTW8Z
         h/3pDhvUv+2GYtA2FgnAW4qwLOu08iesUVM3n8AlBjiVx5bA66HqBqpPu3uMBq/wrE2B
         HimCds1mg2YwAmm/RPSAyNTcwk5RySBlt9ryjPLGbCL1/t3PKFgrT4N3f9jPycR4Aibp
         RvvenkRGTJvDnZy2G8YafG8Fith8FYPVNdnXxiXKdMZfVyZirZhR0W+XkuM8cpLQorEW
         fo9QTkkZiDoDesfFsosZ3GuhXGy+3LUlpxlrPWl0TRkkm/sZmB/2kEVahGLB01yDPtiR
         vYUw==
X-Gm-Message-State: AOAM531blXsFNn9MOPsQRVf5ewfGF2u2wXEuei0wrkgSOTBm5C2mvUxP
        ejKXu4yxtM9vt4O3/mCoB3R317q9E4C9gbEZCE4BDDJbBIbX4qWKaZPqaPO+Rl+McRovfjMLWHh
        4FSmJ9VM/RPulvh5Q0CMXItzVO+tOYVhK4ezMU+2oU4j+iLyGz09ZKNbbIkAj4JsRfBCVmp39hf
        9f
X-Google-Smtp-Source: ABdhPJxrrCkKVn96Wah293Ddlyp3guMOIjdLTAabqM2tx8nRvM9HgCOf0qiQLtqn8pvFOsCV+6Nov/itg2iuft0l2clq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:5a88:: with SMTP id
 c8mr15649976pgt.70.1638919438517; Tue, 07 Dec 2021 15:23:58 -0800 (PST)
Date:   Tue,  7 Dec 2021 15:23:51 -0800
In-Reply-To: <cover.1638919346.git.jonathantanmy@google.com>
Message-Id: <b2dcae03ed3016f96a5368db925fa3736c3d7c58.1638919346.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1638919346.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v6 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        avarab@gmail.com
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

