Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918DC7618E
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCSG2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCSG2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC8E392
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m35so5573830wms.4
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q76+BiU1OiTfZ+PF+Eb+aLkl4ozdmlZAAEzqWuShUqs=;
        b=ZJKhLSzi6+RXdyhIJFnBbRAFspzgK0LfaMZ6sg+QkLgY3yiOOJ2n41DBvP586OBkm2
         d5UUpvjn8lEeUboUYkSw8b/e7deyy4BBslFcUUxrGugeKYJkDL2n1uvmN8av3y/XVrZo
         Rw/895nBWxE92kSkYfOq2Sq3lyE7YZ4c6/FCxr7ZcOytezOrHFSXa8s22UKzA+0+uFu3
         ezDu6qh7Nx+r6iei5f14yoUYEFM8JToSw57+qu1OxBp61XPkAS0+AAvT+J4+qcEynFbs
         0ND0eNHjvGGfU4DWCKrnXFbF6VGELPseaZrZP8CliqL+9cBJ+VOxVnuzmSkMzcy3IYLv
         MCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q76+BiU1OiTfZ+PF+Eb+aLkl4ozdmlZAAEzqWuShUqs=;
        b=iqLF9oLoUKZ9qr5ASX2jUu0eycABnB8C/v4YJ1cpA7HhnnY/UWCJxCjn9h342v54LE
         TuMJ51UrcGZgsAO8zWUGqXRo5aDjJsLrptu7JqYEbFfkdzOogioBjLyWFlFhRv9eaLKh
         wQsILR20Gdb2fawM6KJw8he51tLsMLbNsraU3kUTd6fS6v5m+hpq5z6mvqtSkTZoDx7K
         av2xv34VyKh78yaznWRFlYvgid9FmhQHjpS7UECooSdoOBwwiIZsW/f0SOLKnOsnTTqk
         yd/XfGKcRhVw/GoBcZIW1VHjTzjBXEX5Jd94o7QHptEB1bjtPMnXOwSpBmYs2Om5I0ct
         mRog==
X-Gm-Message-State: AO0yUKWxJjkY9rsSYNr4q0E2kZxvLzyeq+0+uOx9QSoySsJbhwjJKjix
        OzV+aSCkpxXGpDn7A86ADGPdwKkoxSg=
X-Google-Smtp-Source: AK7set/u6okdu28ef82yMCx6tAZGtO09ExTwni6z71+rl/xCn03Y0HyFbXmrweY70Wkh3R5RxarIOA==
X-Received: by 2002:a05:600c:3d95:b0:3eb:5990:aea4 with SMTP id bi21-20020a05600c3d9500b003eb5990aea4mr6311166wmb.12.1679207292934;
        Sat, 18 Mar 2023 23:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003ed551b139csm6673014wma.36.2023.03.18.23.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:12 -0700 (PDT)
Message-Id: <0f48e561b797a7c8f5ab4ae5c0d4296d7d05ef44.1679207284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:54 +0000
Subject: [PATCH 08/16] path.h: move function declarations for path.c functions
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

