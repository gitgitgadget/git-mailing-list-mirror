Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7264AC7EE2D
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjFBOeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjFBOdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BD99
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30af56f5f52so2010527f8f.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716426; x=1688308426;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez7E3kZ2XidK6ZB2iZFWChzgOhaUiNLJNNyv6gQjqO4=;
        b=CgpNlle8S0203HQ1S6oNV7PiZikf7w0YTffe9QrS1alCpX5ARjoVHFVpnz0VgLZ2f2
         nx0QAmf9Ig/6LXpQDNouGUHSR4rdrQIQzntpk2mMuFm+pGWOa3T/On3UtGjUukGsVEHw
         TvaDheBi+2PpjBZ95a/KDEve96kPLRbOsy+ij9to8AUjNpcq4a1p0bLqZD5wfylVm6fF
         +e45vS4XekoPxRlrL2+8KdCdAVQOHQMeTP4VllAKhqTTCth73JZxwbhMii2KhoUC5oFo
         ltwAW+FOsm609gqX47/jdXiWYUBVCTG9xYI05pm6m+/3XRMQ8CqG3XtoONwfYpvijJXj
         lRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716426; x=1688308426;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez7E3kZ2XidK6ZB2iZFWChzgOhaUiNLJNNyv6gQjqO4=;
        b=Nhj44Htl2qSbB5dZ9XOYJY/uDnnbrXZHWmTf9XuF1qjHM7OYNgfoohV0H+xl8jm+QW
         WPyqlegBa2uNm04oqS5Hlgre8q+o5YTFM2lQGOxTmvJbE6sZzFfrPmv+i+pjiaxIISY8
         pLVlTmy1ocEAXFhb5conCVYBJNTOM2a6uOivzsmVIv2mOR3fcFLY8C/CKCw9KiDBGFzp
         ncMGbDGZidVOV+7jR9X3jwZJ9Kkl1Iz572Ai43NEATf/PEUz79RL1t+tddS7PE5HtT7r
         IAV0Fw273OJTPMQ5yqHU9Mv87OSvuNiV+ACKL+bCGMDAn20dXkODaBXON0rVkqgf7Km+
         Ggzw==
X-Gm-Message-State: AC+VfDzwRpvVOnLHBplzm/XkyDt8xaiofPpa0O8xvap+bsGNenBTvfGW
        x6mrMPxn9ocUYbfkkEOG0BXmYFkBBJE=
X-Google-Smtp-Source: ACHHUZ5qf0wBdUvK+FbZDBUy1r9sGs75pGX7Xa6TcG4/xjzU4Sugy451wHDLDMyK8HTMbYDdU7cItA==
X-Received: by 2002:a05:6000:194e:b0:30a:d731:a220 with SMTP id e14-20020a056000194e00b0030ad731a220mr133655wry.41.1685716425886;
        Fri, 02 Jun 2023 07:33:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e35-20020a5d5963000000b00306c5900c10sm1878605wri.9.2023.06.02.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:45 -0700 (PDT)
Message-Id: <a154008619790f7a60f2bba91db7b0fe29e67e1a.1685716420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:39 +0000
Subject: [PATCH 5/6] config: move has_symlinks to global config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 apply.c            | 3 ++-
 builtin/difftool.c | 4 ++--
 cache.h            | 4 ++--
 combine-diff.c     | 2 +-
 config.c           | 5 -----
 entry.c            | 3 ++-
 environment.c      | 1 -
 environment.h      | 1 -
 global-config.c    | 2 ++
 global-config.h    | 1 +
 merge-recursive.c  | 3 ++-
 read-cache.c       | 5 +++--
 12 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/apply.c b/apply.c
index 3636bc14c2d..17092d2bb12 100644
--- a/apply.c
+++ b/apply.c
@@ -4384,7 +4384,8 @@ static int try_create_file(struct apply_state *state, const char *path,
 		return !!mkdir(path, 0777);
 	}
 
-	if (has_symlinks && S_ISLNK(mode))
+	if (get_int_config_global(INT_CONFIG_HAS_SYMLINKS) &&
+	    S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
diff --git a/builtin/difftool.c b/builtin/difftool.c
index f09d24d37f9..f51c9f71d5d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -292,7 +292,7 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 	if (is_null_oid(oid)) {
 		/* The symlink is unknown to Git so read from the filesystem */
 		struct strbuf link = STRBUF_INIT;
-		if (has_symlinks) {
+		if (get_int_config_global(INT_CONFIG_HAS_SYMLINKS)) {
 			if (strbuf_readlink(&link, path, strlen(path)))
 				die(_("could not read symlink %s"), path);
 		} else if (strbuf_read_file(&link, path, 128))
@@ -723,7 +723,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	git_config(difftool_config, NULL);
-	symlinks = has_symlinks;
+	symlinks = get_int_config_global(INT_CONFIG_HAS_SYMLINKS);
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
 			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |
diff --git a/cache.h b/cache.h
index 3e737d12ea8..4d270e114a2 100644
--- a/cache.h
+++ b/cache.h
@@ -161,10 +161,10 @@ static inline unsigned create_ce_flags(unsigned stage)
 static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
 					     unsigned int mode)
 {
-	extern int has_symlinks;
 	int trust_executable_bit;
 
-	if (!has_symlinks && S_ISREG(mode) &&
+	if (!get_int_config_global(INT_CONFIG_HAS_SYMLINKS) &&
+	    S_ISREG(mode) &&
 	    ce && S_ISLNK(ce->ce_mode))
 		return ce->ce_mode;
 
diff --git a/combine-diff.c b/combine-diff.c
index f7e9fb57473..1de0a340b24 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1086,7 +1086,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			/* if symlinks don't work, assume symlink if all parents
 			 * are symlinks
 			 */
-			is_file = has_symlinks;
+			is_file = get_int_config_global(INT_CONFIG_HAS_SYMLINKS);
 			for (i = 0; !is_file && i < num_parent; i++)
 				is_file = !S_ISLNK(elem->parent[i].mode);
 			if (!is_file)
diff --git a/config.c b/config.c
index 6b4051a4eae..e104bc704ae 100644
--- a/config.c
+++ b/config.c
@@ -1568,11 +1568,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			check_stat = 0;
 	}
 
-	if (!strcmp(var, "core.symlinks")) {
-		has_symlinks = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.ignorecase")) {
 		ignore_case = git_config_bool(var, value);
 		return 0;
diff --git a/entry.c b/entry.c
index d89e61fa641..0c33aeb8aa9 100644
--- a/entry.c
+++ b/entry.c
@@ -308,7 +308,8 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 		 * We can't make a real symlink; write out a regular file entry
 		 * with the symlink destination as its contents.
 		 */
-		if (!has_symlinks || to_tempfile)
+		if (!get_int_config_global(INT_CONFIG_HAS_SYMLINKS) ||
+		    to_tempfile)
 			goto write_file_entry;
 
 		ret = symlink(new_blob, path);
diff --git a/environment.c b/environment.c
index f42f79f7f1b..312e006feb0 100644
--- a/environment.c
+++ b/environment.c
@@ -31,7 +31,6 @@
 #include "write-or-die.h"
 
 int check_stat = 1;
-int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
diff --git a/environment.h b/environment.h
index 362681f63e7..fb2cfa9c1aa 100644
--- a/environment.h
+++ b/environment.h
@@ -112,7 +112,6 @@ void set_git_work_tree(const char *tree);
 
 /* Environment bits from configuration mechanism */
 extern int check_stat;
-extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
diff --git a/global-config.c b/global-config.c
index 395d21e0381..526ced5b24c 100644
--- a/global-config.c
+++ b/global-config.c
@@ -7,6 +7,7 @@ static int global_ints[] = {
 	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = 1,
 	[INT_CONFIG_TRUST_CTIME] = 1,
 	[INT_CONFIG_QUOTE_PATH_FULLY] = 1,
+	[INT_CONFIG_HAS_SYMLINKS] = 1,
 };
 
 /* Bitmask for the enum. */
@@ -17,6 +18,7 @@ static const char *global_int_names[] = {
 	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = "core.filemode",
 	[INT_CONFIG_TRUST_CTIME] = "core.trustctime",
 	[INT_CONFIG_QUOTE_PATH_FULLY] = "core.quotepath",
+	[INT_CONFIG_HAS_SYMLINKS] = "core.symlinks",
 };
 
 static int config_available;
diff --git a/global-config.h b/global-config.h
index fbe5fccb1a1..2532f426e2b 100644
--- a/global-config.h
+++ b/global-config.h
@@ -6,6 +6,7 @@ enum int_config_key {
 	INT_CONFIG_TRUST_EXECUTABLE_BIT,
 	INT_CONFIG_TRUST_CTIME,
 	INT_CONFIG_QUOTE_PATH_FULLY,
+	INT_CONFIG_HAS_SYMLINKS,
 };
 
 /**
diff --git a/merge-recursive.c b/merge-recursive.c
index 9875bdb11cb..10fdd14a642 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -983,7 +983,8 @@ static int update_file_flags(struct merge_options *opt,
 			goto free_buf;
 		}
 		if (S_ISREG(contents->mode) ||
-		    (!has_symlinks && S_ISLNK(contents->mode))) {
+		    (!get_int_config_global(INT_CONFIG_HAS_SYMLINKS) &&
+		     S_ISLNK(contents->mode))) {
 			int fd;
 			int mode = (contents->mode & 0100 ? 0777 : 0666);
 
diff --git a/read-cache.c b/read-cache.c
index 9e5a6ba2c76..b80a54133f9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -344,7 +344,8 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 		break;
 	case S_IFLNK:
 		if (!S_ISLNK(st->st_mode) &&
-		    (has_symlinks || !S_ISREG(st->st_mode)))
+		    (get_int_config_global(INT_CONFIG_HAS_SYMLINKS) ||
+		     !S_ISREG(st->st_mode)))
 			changed |= TYPE_CHANGED;
 		break;
 	case S_IFGITLINK:
@@ -809,7 +810,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 
 	if (get_int_config_global(INT_CONFIG_TRUST_EXECUTABLE_BIT) &&
-	    has_symlinks) {
+	    get_int_config_global(INT_CONFIG_HAS_SYMLINKS)) {
 		ce->ce_mode = create_ce_mode(st_mode);
 	} else {
 		/* If there is an existing entry, pick the mode bits and type
-- 
gitgitgadget

