Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133FEB64DB
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFTToD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFTToB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDA1722
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9b1a117caso23080825e9.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290238; x=1689882238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLGWqGGPXVVm2PVCWPgKPnOlSwIUwy91Hvor7uzugUE=;
        b=cPMLRvtb/vQHFMKtLE8jOkD+JUrBjRh2eYXCLDrwTwJRuoGxFIm8tFcySgygINvFhJ
         W2UD99jw++ph3xQoR1nDTUoMwc2atf2LaJy/k3u8osviT/9Dh6yeNh3UYVWd4+DXGAdu
         +tcC2BfYmOOoU2xJyUgb1+X9uJrSEBMwTRo7El6eufojvSrI5Ya2Pr3LJlnCkMwQtCbF
         u/lRoQ0xrtqvRYzDInMcYEtqDAGj69ZOhjJtdBZsqNmFPsajy2OcAuDV2V9MjxAzbJsR
         1QcW6QHbVJjdoe2zC7QiZvJu+Gi4BVYwKVmvSq1n8eIFIJuITatjYeNiI1YdPfKcCCUD
         AhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290238; x=1689882238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLGWqGGPXVVm2PVCWPgKPnOlSwIUwy91Hvor7uzugUE=;
        b=ewuJWlh40tq8eKqOpwQu3g/iuQh0WUoU7SKoj27cB4CYKJBoOaxYsRl2mLbS4+josR
         k3FPCvCsvvncjOBJQx+2GcCpX/VZfXsTQwupzXs6xsiGKjYdpAGuJGdYba1FdhH4UQ95
         OSV2yg0+zGiKek9WO9Zv6fYDaJxVHPoPDWrKoi33oW3ln2/MioCHhobbd6GXJh2bmRxx
         +pH907tesW1+D4sKvc/zCFJ88A0fr5OBScG+qbb0GcBqkSG7CpBFjyphciVdOSxWrMOP
         LCLAghNww9Dg0exmUiKEoXMA9SEA5KMYOZBOlsqG51xxzt2waXeqJelK2Mifs9jFOo8X
         k5WA==
X-Gm-Message-State: AC+VfDwX9BwvpL2rpCMoScIrSweYvgg+4zI8QXrOZVzgfYCErwOFVJ/3
        hdF2nsqan8wNsxXKCt6kQopxnxHCZmg=
X-Google-Smtp-Source: ACHHUZ724p5zu+MILT3D5mID2NfmmKCrGJmI3rXVrHUhya3V24GVucOwsYrZuiUYwRNQOmSkt/utmg==
X-Received: by 2002:a7b:c050:0:b0:3f8:f45f:5c34 with SMTP id u16-20020a7bc050000000b003f8f45f5c34mr8740791wmc.40.1687290238128;
        Tue, 20 Jun 2023 12:43:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003f7361ca753sm13911225wmq.24.2023.06.20.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:43:57 -0700 (PDT)
Message-Id: <26109b65142d2a325201940262a6c0bf183ec4bd.1687290232.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:40 +0000
Subject: [PATCH v3 01/12] config: inline git_color_default_config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
index e6c2655af68..df99e38847b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -117,7 +117,10 @@ static int git_branch_config(const char *var, const char *value, void *cb)
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
index 78852d28cec..57e7f7cac64 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -130,8 +130,10 @@ static int git_clean_config(const char *var, const char *value, void *cb)
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
index b86c754defb..76cf999d310 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -293,7 +293,10 @@ static int wait_all(void)
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
index 7ef4a642c17..a2461270d4b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -579,7 +579,10 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
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
index 49b64c7a288..1acf5f7a59f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -209,7 +209,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
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
index 83abb11eda0..b24b19566b9 100644
--- a/color.c
+++ b/color.c
@@ -430,14 +430,6 @@ int git_color_config(const char *var, const char *value, void *cb UNUSED)
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

