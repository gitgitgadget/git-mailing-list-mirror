Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17004C77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjE3Sm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjE3SmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8710C
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so4961381f8f.3
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472138; x=1688064138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPfRS8xz+S8liJ8a8okyP16iGqD5WcF5yfvBfyZgQaA=;
        b=sx8rXBS21RMUyunTic4T/MDnedTWDA6bUeA2GKIzVlsIZ++oexrlIi8emOM5bgOtU3
         9Xbe7HVzQNGfNnvb/ujHx/4v9HEH/CJ2rTPALWdCkOaq/OwYJdr+FC1A10+uXNdl3Hgy
         6JxwFMOzb8vBzX/bRLI+uBo7SretmoUelorSPXJVAeNoYk+Fc/1g4adHKOLmXiUMrpDR
         kYuoe3gFh/Ur+L2jGx0CbkVs7cKxyGxyO1W7F2ID/2WL/bMC/ylxoN2JReD1MTG9UeFj
         MkmvDcFdZOkwtz4tmGnvfODvNyBClVPe1Q/uBqsoPPAGV1ZSq12CRy8VQdEcL3nFc9tP
         g3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472138; x=1688064138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPfRS8xz+S8liJ8a8okyP16iGqD5WcF5yfvBfyZgQaA=;
        b=OfqO7p4qxtA1hpMmUcYJqxWAxoOPYdLEGa9QUM8hoFEvNJTk9ZrkDGBtl5L+GCVFgL
         NSmxS2wAwyN0kx+A21q7O2NVP3Ir80jDLWI2omCmtmGv0pOIjewufWEV74St2fMxylvJ
         XMuFHGF4tU6oh9XMfkZdkPPCnc8/19T7Xe4C5JnDKMchqSol6WFgiHk9IMhX5YxQCLCi
         xG0Pg2X8vz3AmkvQVr1sQvPiJresxQcAMrZc9bac5bVLqxMjT6Hq+mOw4bIDqkURc6vh
         xtM7iNn6/R4yHSRPcF8hYiRTp4lapRsmC5kpSVWHJ1MHrNGmPyNYP2kPFB8aeZ6j2TVL
         kRig==
X-Gm-Message-State: AC+VfDxhEQoFvE8Gj4LUMnFIr7EjrnEyMshUx146sd6NugYucYwy/lma
        muW7kd6kEg/uxRFGbaCHWwoG+1uTR9E=
X-Google-Smtp-Source: ACHHUZ5rTU+7T8i++EqwRqAb1VihYEKsWwUu+9YC1ej58q/zcjlpIkwfMO2f09pyDAwTHmse0tlDUQ==
X-Received: by 2002:adf:ec89:0:b0:306:44a9:76a1 with SMTP id z9-20020adfec89000000b0030644a976a1mr2255355wrn.17.1685472138309;
        Tue, 30 May 2023 11:42:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe34b000000b003078cd719ffsm4128932wrj.95.2023.05.30.11.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:18 -0700 (PDT)
Message-Id: <d5edf7e3fddc2eb91a17e7aa215da7e67881a191.1685472133.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:41:59 +0000
Subject: [PATCH v2 01/14] config: inline git_color_default_config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

git_color_default_config() is a shorthand for calling two other config
callbacks. There are no other non-static functions that do this and it
will complicate our refactoring of config_fn_t so inline it instead.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c      | 5 ++++-
 builtin/clean.c       | 6 ++++--
 builtin/grep.c        | 5 ++++-
 builtin/show-branch.c | 5 ++++-
 builtin/tag.c         | 6 +++++-
 color.c               | 8 --------
 color.h               | 6 +-----
 7 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6413a016c57..c6982181fd5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -114,7 +114,10 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_color_default_config(var, value, cb);
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
diff --git a/builtin/clean.c b/builtin/clean.c
index 14c0d555eac..a06df48a269 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -129,8 +129,10 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	/* inspect the color.ui config variable and others */
-	return git_color_default_config(var, value, cb);
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
 }
 
 static const char *clean_get_color(enum color_clean ix)
diff --git a/builtin/grep.c b/builtin/grep.c
index a1b68d90bdb..c880c9538d6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -290,7 +290,10 @@ static int wait_all(void)
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
 	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, NULL) < 0)
+
+	if (git_color_config(var, value, cb) < 0)
+		st = -1;
+	else if (git_default_config(var, value, cb) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 463a8d11c31..82ae2a7e475 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -576,7 +576,10 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_color_default_config(var, value, cb);
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
diff --git a/builtin/tag.c b/builtin/tag.c
index 782bb3aa2ff..7245a4d30e6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -204,7 +204,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
-	return git_color_default_config(var, value, cb);
+
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
 }
 
 static void write_tag_body(int fd, const struct object_id *oid)
diff --git a/color.c b/color.c
index 672dcbb73a6..9bdbffe928d 100644
--- a/color.c
+++ b/color.c
@@ -427,14 +427,6 @@ int git_color_config(const char *var, const char *value, void *cb UNUSED)
 	return 0;
 }
 
-int git_color_default_config(const char *var, const char *value, void *cb)
-{
-	if (git_color_config(var, value, cb) < 0)
-		return -1;
-
-	return git_default_config(var, value, cb);
-}
-
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb)
 {
 	if (*color)
diff --git a/color.h b/color.h
index cfc8f841b23..bb28343be21 100644
--- a/color.h
+++ b/color.h
@@ -88,12 +88,8 @@ extern const int column_colors_ansi_max;
  */
 extern int color_stdout_is_tty;
 
-/*
- * Use the first one if you need only color config; the second is a convenience
- * if you are just going to change to git_default_config, too.
- */
+/* Parse color config. */
 int git_color_config(const char *var, const char *value, void *cb);
-int git_color_default_config(const char *var, const char *value, void *cb);
 
 /*
  * Parse a config option, which can be a boolean or one of
-- 
gitgitgadget

