Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66484EB64D9
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFZSLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZSLe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F80106
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so34660245e9.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803090; x=1690395090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6uTjekOGzBY6GkUhjIqFqzs/7tpvZP4o1KCwXy54HA=;
        b=BoFVXpxB0de1zzU7uhe0T7kme2JaH1E62OVBzSf4LRx4OyXrrhHktgEaxeB8HfsDlQ
         en1g9bjwgkafRwtDdQnwF2o6LM43YEH98M/cbomHIEaLHIofnzn4DIaXIOJ+wpYa3Rwe
         wxDuZnBVo7eHg0lcxMOyMZAUCchGPoiPKG09Bx3kCeCmwYiDEcGaC4+53CfyycNObhek
         2JpBLdySB8o4kSkUkgHqnCuOneowiSsED65/DNE7Qaixo3fiSI/gKDsLEBAoj8a6aZfM
         NgBb0SwaPbqZGWmFYLxyuPu3xfXm8qtg2Vspw+yU5+Qeh5epgqAqxv4UgLPTYAOi4AL4
         6eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803090; x=1690395090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6uTjekOGzBY6GkUhjIqFqzs/7tpvZP4o1KCwXy54HA=;
        b=hGFa7W9DOYNl4Gs8RQdE7IAbxOuIjxHqUUJf/tfnnsbtJlougH84PWRVI4IsTTXv+M
         mjJJ2NaSn8w1hG2/lX0Rls03kYvnFdYGQxW5EW6Hw3pz9HcgKh7WwAAsYWx69L3x246j
         giO3/5geuzs2URzWRMAzKM2rlGVdQzTH2MVg5i1ghIEXu8v6/r8TiIPCWTj8ST+SHiMx
         TFY850XXkk5pZaYrbotlC0qCqYg8fGd6gUbd59LOR6QrhRkwY4cwsI2pv7j7Vt8eAyvR
         wIhY20m8oImHjiw9QqhGsBL9Fl5awbc7ZWdYpoKHMAo6bXx7Xwc0WfpDbsVHhlAu5MlI
         Cakw==
X-Gm-Message-State: AC+VfDyOuCvCj5HYJfkm1SsIeTWaGSjLxs3fllhO0p+oV17b3xplfxiO
        njfKK9PIzPbdGxEccomQrQgoKNnlOO8=
X-Google-Smtp-Source: ACHHUZ5pnRhKg8Bvz/gTCAlsFCY3YAZ/eWmS1hgprPXivbDHFiCEd7yGh/vLPE4suHvpW4ijUwJH/g==
X-Received: by 2002:a7b:c411:0:b0:3fb:52c3:a177 with SMTP id k17-20020a7bc411000000b003fb52c3a177mr507147wmi.4.1687803089829;
        Mon, 26 Jun 2023 11:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bce13000000b003f41bb52834sm11288775wmc.38.2023.06.26.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:29 -0700 (PDT)
Message-Id: <7bfffb454c5d837077fe08087e43abb194efd1f4.1687803085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:12 +0000
Subject: [PATCH v4 01/12] config: inline git_color_default_config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
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
 builtin/add.c         | 5 ++++-
 builtin/branch.c      | 5 ++++-
 builtin/clean.c       | 6 ++++--
 builtin/grep.c        | 5 ++++-
 builtin/show-branch.c | 5 ++++-
 builtin/tag.c         | 6 +++++-
 color.c               | 8 --------
 color.h               | 6 +-----
 8 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 6137e7b4ad7..e01efdfc50d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -365,7 +365,10 @@ static int add_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_color_default_config(var, value, cb);
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
 }
 
 static const char embedded_advice[] = N_(
diff --git a/builtin/branch.c b/builtin/branch.c
index 075e580d224..8337b9e71bb 100644
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

