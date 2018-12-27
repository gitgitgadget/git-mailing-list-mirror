Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06208211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeL0P40 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41076 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeL0P40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so12939233lfj.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yylg1JvDqyyibpABxJekLON5IaqWfcRcRAWlsUaJ3ug=;
        b=fsIOlgRH8vc4YpAobYK2FtIgPOo2z5SCF5PZMYUn4SQYlmrQr1pNCfhBgUP6WQZhLb
         XfcsHK5VurWMBVPJbHjjNnzqxlHJM1bFRlJKHCUcp9yjZYJTp9cOi8L8GNxT+yd94vTd
         lhzn6WdI2HcSbcWIStlJxr0QlsPupVqYCjjMeXWNbqRun/tvQIhOrSi+BwHZHyNLyxFb
         ZJ9p1KLWFYAdLS3xXM2q9HGWEEE8sdocOClGT6E9L5rGDAKyM6lNBuSo/vFwtxd/tvXY
         QswjRZdrePgkFfvfgiGj2XYO2xNskjaZnmu0uN0Tohoopky/uVFgo0qcgHTD8elcMfyg
         iaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yylg1JvDqyyibpABxJekLON5IaqWfcRcRAWlsUaJ3ug=;
        b=RykIg235R4oNfDNndlYlgy6PIMIDirfptAO7N1iQONswJ9SxWkEMBBVaVKn+/imTPa
         1sGm7TbKZIJsnQwTElZW3TmFUn1RuGQuYAaUhgfyTmwYbcXUcO213zrWrALjfKH/9Fne
         XA1NfF07p/mvH7mgmopiM6hPvsw+z0OyP/TDGlbB0+YloN8Pr6Id4TTiloM7L2jCsUJl
         sR97l8hS150Xmg7XohP/OEUm8j3u8YhpGZtwp2dvxIUsW5HiHtNy43d2exRXbvVWMKU0
         EnOphnWy44lRr3jJkNZl8hpDjGqIkadYDmmlqjZtMNvnlfvWSJMXNAimxECBge0jlFUx
         Vf3w==
X-Gm-Message-State: AA+aEWbOL/aveqdL6uHEiUsFldloDU8b6SCT1xXsdydp5Ar7NY4kZR8L
        Tiqj56VrRcgIosj5UqwEo+DHLhLF
X-Google-Smtp-Source: AFSGD/Vnx4m46aX4VEseDLRm8Hcmo7eurJytfgDl1q11+LX9EKeqZtRjZ3tMCnneoFxuHurxqUorpQ==
X-Received: by 2002:a19:982:: with SMTP id 124mr11774246lfj.138.1545926183310;
        Thu, 27 Dec 2018 07:56:23 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:22 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/6] worktree.c: add get_worktree_config()
Date:   Thu, 27 Dec 2018 16:56:07 +0100
Message-Id: <20181227155611.10585-3-pclouds@gmail.com>
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

"git config --worktree" can write to the write file whether
extensions.worktreeConfig is enabled or not. In order to do the same
using config API, we need to determine the right file to write to. Add
this function for that purpose. This is the basis for the coming
repo_config_set_worktree()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c |  9 ++-------
 worktree.c       | 16 ++++++++++++++++
 worktree.h       |  7 +++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 84385ef165..771cfa54bd 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -650,18 +650,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (use_local_config)
 		given_config_source.file = git_pathdup("config");
 	else if (use_worktree_config) {
-		struct worktree **worktrees = get_worktrees(0);
-		if (repository_format_worktree_config)
-			given_config_source.file = git_pathdup("config.worktree");
-		else if (worktrees[0] && worktrees[1])
+		given_config_source.file = get_worktree_config(the_repository);
+		if (!given_config_source.file)
 			die(_("--worktree cannot be used with multiple "
 			      "working trees unless the config\n"
 			      "extension worktreeConfig is enabled. "
 			      "Please read \"CONFIGURATION FILE\"\n"
 			      "section in \"git help worktree\" for details"));
-		else
-			given_config_source.file = git_pathdup("config");
-		free_worktrees(worktrees);
 	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
diff --git a/worktree.c b/worktree.c
index d6a0ee7f73..d335bdf28a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -581,3 +581,19 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 	return ret;
 }
+
+char *get_worktree_config(struct repository *r)
+{
+	struct worktree **worktrees = get_worktrees(0);
+	char *path;
+
+	if (repository_format_worktree_config)
+		path = repo_git_path(r, "config.worktree");
+	else if (worktrees[0] && worktrees[1])
+		path = NULL;
+	else
+		path = repo_git_path(r, "config");
+
+	free_worktrees(worktrees);
+	return path;
+}
diff --git a/worktree.h b/worktree.h
index 9e3b0b7b6f..4c41002d31 100644
--- a/worktree.h
+++ b/worktree.h
@@ -132,4 +132,11 @@ void strbuf_worktree_ref(const struct worktree *wt,
 const char *worktree_ref(const struct worktree *wt,
 			 const char *refname);
 
+/*
+ * Return the path to config file that can contain worktree-specific
+ * config (or NULL in unsupported setups). The caller must free the
+ * return value.
+ */
+char *get_worktree_config(struct repository *r);
+
 #endif
-- 
2.20.0.482.g66447595a7

