Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D2C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjDUTNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDUTN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF2A10DA
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so21818455e9.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104404; x=1684696404;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPfRS8xz+S8liJ8a8okyP16iGqD5WcF5yfvBfyZgQaA=;
        b=SdYh+ig3Rmq4toidB4PQdsF3TTRXJFbFW9ZfUk5GIENqU0c097PNsbOuFH1zwqwVUL
         qRw7naLbCEj0e8qVrcor9GwW567FZiT3ZEAQA2WxTwmgU2aNO7rarIqOY4Nxa6+qQenJ
         vbdfFTGMk/c8H1e20YMw1PCzswggd8aqqMu7o7jpWPARetqk/kJMOS6UxpuPcPkvVO/G
         M/CEh6wYVD2FO6dtV4aoQcXe+7NZAhtPQ+3uWTwCOi9qtNEzraoa1x8njK/UdxZ9VNdj
         GXsiPro+Lh5ExhC8PQi+l/Qn454dE9Q5OBv16SHQt7HEEdeYr8N64XAGh6mDrdbgSED6
         pp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104404; x=1684696404;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPfRS8xz+S8liJ8a8okyP16iGqD5WcF5yfvBfyZgQaA=;
        b=O6IgEq+f5GwFPKMKcsq0n0CSJIa/kr1U5wYYbs3AFIKiPiBLCXjhgZDp03IHM1DV7o
         z1qAK2dvDV8X570LZiFGznrDBPu9wxbR3nMbe7EnHIooyv+Wgsya75rTKLW9/K/gGMzi
         DDDhTcsSC7NNhxxinGiHhOhfYPseDBRAlVYg9Yq/LIEQUt4A6+6zkC/m/4qyJVqmb1Fb
         i71gMyqnfQTt64xtmIpJNDSXmTwiy6hADseD70w+0WTuEyoI7HOUMwPaKTwGMbrrgSXa
         mgWx9R3n1JF3c86i7e4RXkxhCTP5TkTQxI9qFmcVVTNpP+xVS9NAft6nM6978U+ZmlSy
         YziQ==
X-Gm-Message-State: AAQBX9erm6oG+ibSV+eOTa9OMNt5csyzBBHJfpckHtBTh5KFfDH1t7QY
        DD8Xf6W54yiNggnCwqvP1905GXw+D6w=
X-Google-Smtp-Source: AKy350ZeW84ISgA313TufPa3ddfJWJbn6yoyVcIgmHZSX/bSn6gBtjaC+zK4k7RXVcoK2fba1udxcA==
X-Received: by 2002:a05:600c:259:b0:3f1:8223:6683 with SMTP id 25-20020a05600c025900b003f182236683mr2480272wmj.40.1682104403936;
        Fri, 21 Apr 2023 12:13:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c46ca00b003f1957ace1fsm1571163wmo.13.2023.04.21.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:23 -0700 (PDT)
Message-Id: <cb0218106888f0dc27890ba875dd415e1304a654.1682104398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:10 +0000
Subject: [PATCH 06/14] config: inline git_color_default_config
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

