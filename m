Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D86C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 18:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiAYSnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiAYSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 13:42:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FABC061749
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 10:42:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s18so21563345wrv.7
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=INwATnL1xRLYdZVmyzbjAkZIOCTDRoDVPXqO0Q4F5YA=;
        b=UiRsWtECrsrqKnEBQz4eesM/Eyd3ZKKH7QculiW6w4zdUNiD7qPLy5VDjEzr56ajMQ
         8pEoSP1r11vdpYaGLhpXZjhIrL/MKLCZVcoAARokqDt/ZJrkODYZoriE213JT4Y3pCTl
         FU1j/xWS2zrgswT3N+K44RYMoDoFWgTpZOdkWV/9eWQxe3YG6cKotee/yyN4mASUBTwH
         z7cdrdhCYixPRnjzfiM4U75kg422SQimNSB7wOvcHtmnnBJmnGE+HDwdG7owIsqF7qEq
         kZLrckWKxZVUl9lHGyVciLRiEuO+dBmSeXGwMS918jed9qAJu/g1QggjqIKN+GzUJAMX
         tnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=INwATnL1xRLYdZVmyzbjAkZIOCTDRoDVPXqO0Q4F5YA=;
        b=Z9mfnxAAuLHre+JlxGcb/SUOM+imCCwCtvefeOmUjve3NAIG0Z5YI686xOhFSAgg13
         /ur7E6/iTWEYpcm589/ZF+ddmu0apLswEP16uCkDPvtwJ2zYteE76dNWzLNgSKnvFukm
         hE9t+WHnhDO8PPvhwXluue+uhVi1lX+rdSgG3DIwgOE+wWpUQD3cC1h78RlyryGyaJww
         jnrX+grErILUqtowCLWcBgqCoz8fkcP+NFHhX2rmDX8dCmpcYx0WoeaVo0FSyFSlKuWc
         RHVX2Bw9jN8e+BYGlFqyM6bdujv8Nqy4QQ7c+V5vP4OKAH4D4GjQZBw9XgSY0rFayfmF
         IpiA==
X-Gm-Message-State: AOAM532kDRx8sf2kCLJQVk5iIXzYH3xoRl8IfPT9jOM5ANbNGf1U8ZlR
        l/96Y5U1nL8mZnO2jJNvctmJjlLoA+CL0g==
X-Google-Smtp-Source: ABdhPJwuxdaGqrOI8SKD08XXL0X1VL1c/bZMT+tw2j8kqR2XEIfPsIFTwsGmCETqwAcxNnYa+x4XSw==
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr6893631wrc.583.1643136138925;
        Tue, 25 Jan 2022 10:42:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm7603945wrs.55.2022.01.25.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:42:18 -0800 (PST)
Message-Id: <110d5e0546c76848d6e942a6c9b69d5146b0e1b3.1643136134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
        <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 18:42:12 +0000
Subject: [PATCH v4 3/5] config: add repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some config settings, such as those for sparse-checkout, are likely
intended to only apply to one worktree at a time. To make this write
easier, add a new config API method, repo_config_set_worktree_gently().

This method will attempt to write to the worktree-specific config, but
will instead write to the common config file if worktree config is not
enabled.  The next change will introduce a consumer of this method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 35 ++++++++++++++++++++++++++++++++---
 config.h |  8 ++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 2bffa8d4a01..1a03ced1a54 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "color.h"
 #include "refs.h"
+#include "worktree.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -2884,6 +2885,20 @@ int git_config_set_gently(const char *key, const char *value)
 	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
+int repo_config_set_worktree_gently(struct repository *r,
+				    const char *key, const char *value)
+{
+	/* Only use worktree-specific config if it is is already enabled. */
+	if (repository_format_worktree_config) {
+		char *file = repo_git_path(r, "config.worktree");
+		int ret = git_config_set_multivar_in_file_gently(
+					file, key, value, NULL, 0);
+		free(file);
+		return ret;
+	}
+	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
+}
+
 void git_config_set(const char *key, const char *value)
 {
 	git_config_set_multivar(key, value, NULL, 0);
@@ -3181,14 +3196,28 @@ void git_config_set_multivar_in_file(const char *config_filename,
 int git_config_set_multivar_gently(const char *key, const char *value,
 				   const char *value_pattern, unsigned flags)
 {
-	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
-						      flags);
+	return repo_config_set_multivar_gently(the_repository, key, value,
+					       value_pattern, flags);
+}
+
+int repo_config_set_multivar_gently(struct repository *r, const char *key,
+				    const char *value,
+				    const char *value_pattern, unsigned flags)
+{
+	char *file = repo_git_path(r, "config");
+	int res = git_config_set_multivar_in_file_gently(file,
+							 key, value,
+							 value_pattern,
+							 flags);
+	free(file);
+	return res;
 }
 
 void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
-	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
+	git_config_set_multivar_in_file(git_path("config"),
+					key, value, value_pattern,
 					flags);
 }
 
diff --git a/config.h b/config.h
index f119de01309..1d98ad269bd 100644
--- a/config.h
+++ b/config.h
@@ -253,6 +253,13 @@ void git_config_set_in_file(const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
 
+/**
+ * Write a config value that should apply to the current worktree. If
+ * extensions.worktreeConfig is enabled, then the write will happen in the
+ * current worktree's config. Otherwise, write to the common config file.
+ */
+int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
+
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
@@ -281,6 +288,7 @@ int git_config_parse_key(const char *, char **, size_t *);
 
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
+int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
 
 /**
-- 
gitgitgadget

