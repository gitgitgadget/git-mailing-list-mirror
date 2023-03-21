Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D666C7619A
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCUG0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUG02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4F32E50
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i9so12504525wrp.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q76+BiU1OiTfZ+PF+Eb+aLkl4ozdmlZAAEzqWuShUqs=;
        b=G55W22RCXwsP/BCF6Ic/vkRd4PIFhMVyNspVZmawUvGhPMVmFriheox5sSBZCGQU1k
         i4BDqw2S/9i1Ir1RQpxV4dsvFdhn3CaD4eoUxRIuncLExeUgiOgHcnak5hYqjV5mI/Jy
         CJC1SICgS7BOT0bOd7SAETi4mxxG87ETXZcXD87klDEt2BR94UVVQrp8X4VIqs43OxqI
         yyGvJAsO2dBfEFtTQ2DEGTUwMlGtBN4mIfU0RByoFLUWSigLDWoFqAlDdL8ia2ELQauC
         Jlj9hLq2R+hbMY8LSnORh1Txagh30hKmO/qwXcBy0KBQxL1O104IqL4L94SGxO/t/5ni
         ZdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q76+BiU1OiTfZ+PF+Eb+aLkl4ozdmlZAAEzqWuShUqs=;
        b=kBEexZAe4EnqRtJZzlTYeV45Rle0td5PYf3srzmkuDhHiqk9jy2HQrB/8ukaIXQ802
         DylZ+xH96xmDg3eG15mR1axLNN+HFIuF+FjRn48btzVcLvkh0YGg8kELncvSNh9b61Aq
         xPVd/otM2fY1v7/e90NvjXMqi3qhUzhMRygtPvrZpvk8UwAhRI7ySAn4t17wdI0A/Ish
         RAnUXHJCpRIwA5wQLy1NT8pRqAg9/8AKRFPMSF1dDfwa/pnglYNVB5Aehg+UN7zp3BI6
         Y8geQqis/AxXQ7aNQJIXvkOfn6frNhWmqH6WOl7AkbD1KzfL6HhGOiM3dciGaKZBNjqC
         NlQg==
X-Gm-Message-State: AO0yUKVlhi0a5XFd/VIsQeoCy/c1B4Bl/jPCvMhL5QM9jhIeEh90M40C
        pYGeeo3cawcMfnO3rRMN+DNscOY93Ho=
X-Google-Smtp-Source: AK7set817bl2XMJx+YH9YMxFe4NN3qYz/GABxPcJlHrcmqVtjcCQcaL7WXFxzHByg4OSJIkLo5SGwQ==
X-Received: by 2002:a5d:490c:0:b0:2cc:4e58:f6d0 with SMTP id x12-20020a5d490c000000b002cc4e58f6d0mr1213182wrq.54.1679379984255;
        Mon, 20 Mar 2023 23:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm10509606wrs.44.2023.03.20.23.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:24 -0700 (PDT)
Message-Id: <b0bfbe7f38c99e4371265f0e92fbe38adfc09bd8.1679379972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:26:00 +0000
Subject: [PATCH v2 08/16] path.h: move function declarations for path.c
 functions from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h | 59 ------------------------------------------------------
 path.h  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/cache.h b/cache.h
index 978aa01712b..705c41992bc 100644
--- a/cache.h
+++ b/cache.h
@@ -1105,7 +1105,6 @@ enum sharedrepo {
 	PERM_EVERYBODY      = 0664
 };
 int git_config_perm(const char *var, const char *value);
-int adjust_shared_perm(const char *path);
 
 /*
  * Create the directory containing the named path, using care to be
@@ -1141,54 +1140,6 @@ enum scld_error safe_create_leading_directories_const(const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
 
 int mkdir_in_gitdir(const char *path);
-char *interpolate_path(const char *path, int real_home);
-const char *enter_repo(const char *path, int strict);
-const char *remove_leading_path(const char *in, const char *prefix);
-const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
-int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
-int normalize_path_copy(char *dst, const char *src);
-int longest_ancestor_length(const char *path, struct string_list *prefixes);
-char *strip_path_suffix(const char *path, const char *suffix);
-int daemon_avoid_alias(const char *path);
-
-/*
- * These functions match their is_hfs_dotgit() counterparts; see utf8.h for
- * details.
- */
-int is_ntfs_dotgit(const char *name);
-int is_ntfs_dotgitmodules(const char *name);
-int is_ntfs_dotgitignore(const char *name);
-int is_ntfs_dotgitattributes(const char *name);
-int is_ntfs_dotmailmap(const char *name);
-
-/*
- * Returns true iff "str" could be confused as a command-line option when
- * passed to a sub-program like "ssh". Note that this has nothing to do with
- * shell-quoting, which should be handled separately; we're assuming here that
- * the string makes it verbatim to the sub-program.
- */
-int looks_like_command_line_option(const char *str);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
- * "$HOME/.config/$subdir/$filename". Return NULL upon error.
- */
-char *xdg_config_home_for(const char *subdir, const char *filename);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
- * "$HOME/.config/git/$filename". Return NULL upon error.
- */
-char *xdg_config_home(const char *filename);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, otherwise
- * "$HOME/.cache/git/$filename". Return NULL upon error.
- */
-char *xdg_cache_home(const char *filename);
 
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
@@ -1355,8 +1306,6 @@ int repo_interpret_branch_name(struct repository *r,
 #define interpret_branch_name(str, len, buf, options) \
 	repo_interpret_branch_name(the_repository, str, len, buf, options)
 
-int validate_headref(const char *ref);
-
 int base_name_compare(const char *name1, size_t len1, int mode1,
 		      const char *name2, size_t len2, int mode2);
 int df_name_compare(const char *name1, size_t len1, int mode1,
@@ -1616,14 +1565,6 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
 
-/*
- * Create a directory and (if share is nonzero) adjust its permissions
- * according to the shared_repository setting. Only use this for
- * directories under $GIT_DIR.  Don't use it for working tree
- * directories.
- */
-void safe_create_dir(const char *dir, int share);
-
 /*
  * Should we print an ellipsis after an abbreviated SHA-1 value
  * when doing diff-raw output or indicating a detached HEAD?
diff --git a/path.h b/path.h
index 0a59c85a62e..60e83a49a98 100644
--- a/path.h
+++ b/path.h
@@ -3,6 +3,7 @@
 
 struct repository;
 struct strbuf;
+struct string_list;
 
 /*
  * The result to all functions which return statically allocated memory may be
@@ -179,7 +180,66 @@ const char *git_path_auto_merge(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
 
-
 int ends_with_path_components(const char *path, const char *components);
+int validate_headref(const char *ref);
+
+int adjust_shared_perm(const char *path);
+
+char *interpolate_path(const char *path, int real_home);
+const char *enter_repo(const char *path, int strict);
+const char *remove_leading_path(const char *in, const char *prefix);
+const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
+int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
+int normalize_path_copy(char *dst, const char *src);
+int longest_ancestor_length(const char *path, struct string_list *prefixes);
+char *strip_path_suffix(const char *path, const char *suffix);
+int daemon_avoid_alias(const char *path);
+
+/*
+ * These functions match their is_hfs_dotgit() counterparts; see utf8.h for
+ * details.
+ */
+int is_ntfs_dotgit(const char *name);
+int is_ntfs_dotgitmodules(const char *name);
+int is_ntfs_dotgitignore(const char *name);
+int is_ntfs_dotgitattributes(const char *name);
+int is_ntfs_dotmailmap(const char *name);
+
+/*
+ * Returns true iff "str" could be confused as a command-line option when
+ * passed to a sub-program like "ssh". Note that this has nothing to do with
+ * shell-quoting, which should be handled separately; we're assuming here that
+ * the string makes it verbatim to the sub-program.
+ */
+int looks_like_command_line_option(const char *str);
+
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/$subdir/$filename". Return NULL upon error.
+ */
+char *xdg_config_home_for(const char *subdir, const char *filename);
+
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/git/$filename". Return NULL upon error.
+ */
+char *xdg_config_home(const char *filename);
+
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, otherwise
+ * "$HOME/.cache/git/$filename". Return NULL upon error.
+ */
+char *xdg_cache_home(const char *filename);
+
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting. Only use this for
+ * directories under $GIT_DIR.  Don't use it for working tree
+ * directories.
+ */
+void safe_create_dir(const char *dir, int share);
 
 #endif /* PATH_H */
-- 
gitgitgadget

