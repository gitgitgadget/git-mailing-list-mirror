Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A9C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F200A61241
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhKKRTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhKKRTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:19:42 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44DC06127A
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:53 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 70-20020a630149000000b002da385ceffaso3534872pgb.17
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NHukMEJVN2oOImWPW0vWDSRf6V+uFOgiBM1w4tAJU3A=;
        b=ANMGxf8tUvZ47oKY0Su0rhAtepWlbH6Ep/0RMBAioyyd+eEsJA5hQVZZCcM5f7TKM3
         BK/C3YD6jO4xitiSB+AFLff4so9MHWPzGsoVIiQc2AxlM8BIWjG6Hxls3wFb20KgWMhf
         ysulWxinhMhzwpnCWaY0LVhGHv0ljmcWyXE5/TuJwlccgrVh/si2k7d0ETkmB3MGUl70
         IW1PVhyODnV4Zmow/Y12yPmU9VaW/gK+X9NHHaOIEBIDnEC2isdjh9noCfxKGL/xfhq2
         4kaMquWlUJDtRnaNzURD2hPlc6rBP2AZhDPcBBE0hbS5A7TnBCBSACqLqsq8D/IUfkY7
         FS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NHukMEJVN2oOImWPW0vWDSRf6V+uFOgiBM1w4tAJU3A=;
        b=vOf562gD1QmkJBqapPWD4JVbQQVMGS7n7L/g0tz82kTx5FWYpY1hxZExd+6ED3vKJL
         ZFqWGNUjwvPvWwRqUTTmoUwTOwmJ7rGyECiXG1u9PqSdPP4xfh4wCarNzoJ5hm3qP8ML
         a5P3QL/9y4RQThqcVGDZrhm4Xj65KQiMvPVkpGiIR1XupJ2/fYH/41yCXDUIAunAanbS
         +2SUOOrdhm1SxGoU8WJKNwmoCxNLBw3jv4YwDtPZXziUDEhhJm4C0psqQ0L1H0ROGumJ
         tgSeNNamjyCDGA47gr5VgAyZbW7cUr+qMAWxweboRCdXK/y9K8JBxmgW4imoScSf+x4h
         TX2Q==
X-Gm-Message-State: AOAM530JBPushRT6mvr2Duq0X6lebgzKP5r6FLk2WDie4ZVd8rAZK71g
        o6U479q4G4mmsDAgSHv4+hXEv3dgwCco1VkNomDsGxjD4QXuDdRuCfnqg73yboWrgiFj8zIBwBk
        gkzPBuaCjDM51Que/E71tns+NYNzMGH6I8L7hf4wQslfIttQoZOUsgQ+C6E1UlZk=
X-Google-Smtp-Source: ABdhPJxCaPBN9+s+G00+OZCK63Nu4RccfGY2ZnmCgWich0ddBgsAWoYv+bi5qXLBNykiwLyNZyVCcCJBLxwTdw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2405:b0:3e1:9f65:9703 with SMTP
 id z5-20020a056a00240500b003e19f659703mr8124490pfh.6.1636651012646; Thu, 11
 Nov 2021 09:16:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:16:42 -0800
In-Reply-To: <20211111171643.13805-1-chooglen@google.com>
Message-Id: <20211111171643.13805-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211111171643.13805-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 2/3] config: introduce repo_config_set* functions
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have git_config_set() that sets a config value for the_repository's
config file, and repo_config_get* that reads config values from a struct
repository. Thus, it seems reasonable to have to have
repo_git_config_set() that can set values for a config file of a struct
repository.

Implement repo_config_set() and repo_config_set_gently(), which
take struct repository. However, unlike other instances where struct
repository is added to a repo_* function, this patch does not change the
implementations of git_config_set() or git_config_set_gently(); those
functions use the_repository much deeper in their call chain through
git_pathdup(). Mark this inconsistency as NEEDSWORK.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 24 ++++++++++++++++++++++++
 config.h | 11 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/config.c b/config.c
index cd51efe99a..8dd00b8a13 100644
--- a/config.c
+++ b/config.c
@@ -2869,6 +2869,30 @@ void git_config_set_in_file(const char *config_filename,
 	git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
 }
 
+/*
+ * Sets a config value in a repository.
+ */
+int repo_config_set_gently(struct repository *r, const char *key,
+			   const char *value)
+{
+	int ret;
+	char *path;
+
+	path = repo_git_path(r, "config");
+	ret = git_config_set_in_file_gently(path, key, value);
+	free(path);
+	return ret;
+}
+
+void repo_config_set(struct repository *r, const char *key, const char *value)
+{
+	char *path;
+
+	path = repo_git_path(r, "config");
+	git_config_set_in_file(path, key, value);
+	free(path);
+}
+
 int git_config_set_gently(const char *key, const char *value)
 {
 	return git_config_set_multivar_gently(key, value, NULL, 0);
diff --git a/config.h b/config.h
index 69d733824a..4a6919b984 100644
--- a/config.h
+++ b/config.h
@@ -253,6 +253,17 @@ void git_config_set_in_file(const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
 
+/*
+ * Write config values to a repo's config file.
+ *
+ * NEEDSWORK: These are non-the_repository equivalents of
+ * git_config_set*, but have a completely separate implementation. In
+ * the ideal case, we git_config_set* should just use the repo_*
+ * equivalents, just like most other repo_* functions.
+ */
+int repo_config_set_gently(struct repository *, const char *, const char *);
+void repo_config_set(struct repository *, const char *, const char *);
+
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
-- 
2.33.GIT

