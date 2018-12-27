Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E1F211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeL0P41 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32996 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeL0P40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so12969305lfc.0
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoNspx1SVuQq/CMHLtJnq85EztydcnPT5Zt8xd+1QvE=;
        b=ONrVmn/DmV93siU8qwK2S+nGMDJLUW8iAff67E87mMcOyMOjyVdfq5nev3OhzojcdW
         Ax/W74BedivrrZOBiP+vUV4NqSQ4DURCOBDWcNSRbPZZ2RPBi+Y+3UtXltq9FTMLvBJl
         NQtekz351GenQ6IV/imrhZgYgJ8LcJj6NbK9HLPndGLPwozbu3xzgJqP9DqpMxbD5Iqz
         ZKh8EVGQSG8TjN/jFokALDL0YfKdsWQLHZIYEksq3mSaMAdw1V1eFUYSXvO4q3ylscd7
         sLMy4EvJuRlSFNYRswl22XLnNmQ/0WJnbuzCWeSoXuK2B5E+5sLxzKkOFK86HAfW4Jee
         /URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoNspx1SVuQq/CMHLtJnq85EztydcnPT5Zt8xd+1QvE=;
        b=Rylovl17z2dF9lnf2dHOld9nOZIXj6JiLjgB130deaMzZugDZ01M0abpS4CCcdmmRN
         YZ9MglP8p1eabCE4j+c15wvOpw4XYOLMZXx9vquchzQTD5u1ltBSLsI75bWZRJ3cNoHD
         L2jWO99y3XjaYI1iLuE9Pc72IUwi0cJzQkG/873CDv5HioH56RbfIyEXv3BZsw9tis9s
         lCjqHoxbJ+C5zC1JgmAp8g8RlRdiVbW0yxXVF4dXurslxWAEFacQqSYVQ4xE9fG42fcQ
         n0dlfAIX9ecvmj1wy29UFKIXOO1oPw5LSy2kY2/7CGDFtF+f03jxt1/l1Yg5JueBSq6O
         PkKA==
X-Gm-Message-State: AA+aEWZc3Lxq5bmxArNDbRsP/Pc4vzhP5it08rv+CfserRZljlQWV/iM
        bxPvVPWu9ZDf5NaMESQbQZv3p0MF
X-Google-Smtp-Source: AFSGD/UrvCYNg8V0422qFN8zaqRJ/ts1Sw3jjigJv4uOX/YDrNC4gMdRwIM2Ei1DGNmTBbBa313gqA==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr11878055lff.141.1545926184447;
        Thu, 27 Dec 2018 07:56:24 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:23 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/6] config.c: add repo_config_set_worktree_gently()
Date:   Thu, 27 Dec 2018 16:56:08 +0100
Message-Id: <20181227155611.10585-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227155611.10585-1-pclouds@gmail.com>
References: <20181227155611.10585-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is C equivalent of "git config --set --worktree". In other words,
it will

- write to $GIT_DIR/config in single-worktree setup

- write to $GIT_COMMON_DIR/worktrees/<x>/config.worktree or
  $GIT_COMMON_DIR/config.worktree (for main worktree)
  if extensions.worktreeConfig is enabled

- return error in multiple-worktree setup if extensions.worktreeConfig
  is not enabled.

While at there, also add repo_config_set*() for writing to
$GIT_COMMON_DIR/config.

Note, since git_config_set_multivar_in_file_gently() only invalidates
the config set of the_repository, anybody who uses these functions on
submodules must do additional invalidation if needed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 config.h |  3 +++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 79fbe65da8..151d28664e 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
+#include "worktree.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -2137,6 +2138,39 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+int repo_config_set_gently(struct repository *r,
+			   const char *key, const char *value)
+{
+	char *path = repo_git_path(r, "config");
+	int ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
+	free(path);
+	return ret;
+}
+
+void repo_config_set(struct repository *r, const char *key, const char *value)
+{
+	if (!repo_config_set_gently(r, key, value))
+		return;
+	if (value)
+		die(_("could not set '%s' to '%s'"), key, value);
+	else
+		die(_("could not unset '%s'"), key);
+}
+
+int repo_config_set_worktree_gently(struct repository *r,
+				    const char *key, const char *value)
+{
+	char *path;
+	int ret;
+
+	path = get_worktree_config(r);
+	if (!path)
+		return CONFIG_INVALID_FILE;
+	ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
+	free(path);
+	return ret;
+}
+
 /* Functions used historically to read configuration from 'the_repository' */
 void git_config(config_fn_t fn, void *data)
 {
@@ -2912,7 +2946,12 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 	ret = 0;
 
-	/* Invalidate the config cache */
+	/*
+	 * Invalidate the config cache
+	 *
+	 * NEEDSWORK: invalidate _all_ existing config caches, not
+	 * just one from the_repository
+	 */
 	git_config_clear();
 
 out_free:
diff --git a/config.h b/config.h
index ee5d3fa7b4..62204dc252 100644
--- a/config.h
+++ b/config.h
@@ -103,6 +103,9 @@ extern int git_config_color(char *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
+extern int repo_config_set_gently(struct repository *, const char *, const char *);
+extern void repo_config_set(struct repository *, const char *, const char *);
+extern int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
 extern void git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_key_is_valid(const char *key);
-- 
2.20.0.482.g66447595a7

