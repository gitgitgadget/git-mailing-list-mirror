Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B711FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbcLHS71 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:27 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35715 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbcLHS70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:26 -0500
Received: by mail-pg0-f50.google.com with SMTP id p66so176765899pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXd0TVqb/klP6Jr/gYj/MbDUVCq4kz+hHnuaDSvXMbA=;
        b=i+KRgTNAi4qms42rfpGn5JyvoMoKO2pHBxdz1aZJLdxcFS4VluhuuJiIc3Zh/MRXSo
         rKFmHqH+wxShU+LubrPTkZnIPAnAaDFQnOftWjXKa6r3XmZZd9PUHcmTV+TId4Npm+Zd
         ZpCUZeguQcLw5VxQ3r5ut/BpjtvvnDjBzfl2NLrabuOQEXdxminr23ajwwGUod5iaDt7
         DZyhaFhoFMahAYPq51KqbVtS2jPnUPvLS20Tn9J07VREkx7XywxfOdpQnfhP1qZxNnFD
         n+tdDcfgsgpIDqO6mow+nP1c3RIPkNPPfrT8mv2hRu4X6OMRPl4H79z4JdkzIi1M9M68
         we/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uXd0TVqb/klP6Jr/gYj/MbDUVCq4kz+hHnuaDSvXMbA=;
        b=CZwd1rlMY0CW9wkaEXlZHLo61zajri1odPr2TUAvteTA89FFwYZpObhJ+f/CWVKf6s
         k0/9ge8FN+y2jDIM87boHUXwZy3o98PRhL0/4pa5Qy9h/1fcg7ovNi2sbVEuFmoAIf8T
         +x0kYuv6q8OyZvJO/DQAMPNZne/+X25X6Io51W8GHQ999yR5paIo6s8dkqYmaqFrMp0W
         XPD/Ohq0IlnQ+nb9nBRu8oo+rXllX5nZMMbSJVctP9Ax3hGb1UDMOjZWjDWgJnoYmnCI
         3Mbpu6xBiXWN7uxVsm4fRKlZ9niAo/hjWEtrmeIpZWM+IhgX1LSYWS74onmoNvyNNJ8t
         jCkw==
X-Gm-Message-State: AKaTC03GHam4iI2Jlb7S6u/TsQi4fNIE+nxWJTnkogCM1/yubWRF6THhK1JsuBzngpluAdWS
X-Received: by 10.99.247.69 with SMTP id f5mr136274934pgk.81.1481223565140;
        Thu, 08 Dec 2016 10:59:25 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:24 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 00/16] pathspec cleanup
Date:   Thu,  8 Dec 2016 10:58:54 -0800
Message-Id: <1481223550-65277-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 of this series addresses the comments brought up in v1, most of which were
small cosmetic changes (since this is mostly a cosmetic series to begin with).

Brandon Williams (16):
  mv: remove use of deprecated 'get_pathspec()'
  dir: convert create_simplify to use the pathspec struct interface
  dir: convert fill_directory to use the pathspec struct interface
  ls-tree: convert show_recursive to use the pathspec struct interface
  pathspec: remove the deprecated get_pathspec function
  pathspec: copy and free owned memory
  pathspec: remove unused variable from unsupported_magic
  pathspec: always show mnemonic and name in unsupported_magic
  pathspec: simpler logic to prefix original pathspec elements
  pathspec: factor global magic into its own function
  pathspec: create parse_short_magic function
  pathspec: create parse_long_magic function
  pathspec: create parse_element_magic helper
  pathspec: create strip submodule slash helpers
  pathspec: small readability changes
  pathspec: rename prefix_pathspec to init_pathspec_item

 Documentation/technical/api-setup.txt |   2 -
 builtin/ls-tree.c                     |  16 +-
 builtin/mv.c                          |  50 ++--
 cache.h                               |   1 -
 dir.c                                 |  37 +--
 pathspec.c                            | 468 +++++++++++++++++++---------------
 pathspec.h                            |   5 +-
 7 files changed, 317 insertions(+), 262 deletions(-)

--- interdiff from v1

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e0f4307..d7ebeb4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,8 +173,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
-				  PATHSPEC_EXCLUDE,
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
diff --git a/builtin/mv.c b/builtin/mv.c
index b7cceb6..4e86dc5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -20,13 +20,13 @@ static const char * const builtin_mv_usage[] = {
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
 
-static const char **internal_copy_pathspec(const char *prefix,
-					   const char **pathspec,
-					   int count, unsigned flags)
+static const char **internal_prefix_pathspec(const char *prefix,
+					     const char **pathspec,
+					     int count, unsigned flags)
 {
 	int i;
 	const char **result;
-	struct pathspec ps;
+	int prefixlen = prefix ? strlen(prefix) : 0;
 	ALLOC_ARRAY(result, count + 1);
 
 	/* Create an intermediate copy of the pathspec based on the flags */
@@ -42,25 +42,19 @@ static const char **internal_copy_pathspec(const char *prefix,
 		if (flags & DUP_BASENAME) {
 			result[i] = xstrdup(basename(it));
 			free(it);
-		} else
+		} else {
 			result[i] = it;
+		}
 	}
 	result[count] = NULL;
 
-	parse_pathspec(&ps,
-		       PATHSPEC_ALL_MAGIC &
-		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
-		       PATHSPEC_KEEP_ORDER | PATHSPEC_PREFER_CWD,
-		       prefix, result);
-	assert(count == ps.nr);
-
-	/* Copy the pathspec and free the old intermediate strings */
+	/* Prefix the pathspec and free the old intermediate strings */
 	for (i = 0; i < count; i++) {
+		const char *match = prefix_path(prefix, prefixlen, result[i]);
 		free((char *) result[i]);
-		result[i] = xstrdup(ps.items[i].match);
+		result[i] = match;
 	}
 
-	clear_pathspec(&ps);
 	return result;
 }
 
@@ -148,7 +142,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	source = internal_copy_pathspec(prefix, argv, argc, 0);
+	source = internal_prefix_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
 	/*
 	 * Keep trailing slash, needed to let
@@ -158,16 +152,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	flags = KEEP_TRAILING_SLASH;
 	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
 		flags = 0;
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, flags);
+	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die(_("destination '%s' is not a directory"), dest_path[0]);
diff --git a/dir.c b/dir.c
index 8730a4f..a50b6f0 100644
--- a/dir.c
+++ b/dir.c
@@ -179,18 +179,21 @@ char *common_prefix(const struct pathspec *pathspec)
 
 int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 {
-	size_t len;
+	char *prefix;
+	size_t prefix_len;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len = common_prefix_len(pathspec);
+	prefix = common_prefix(pathspec);
+	prefix_len = prefix ? strlen(prefix) : 0;
 
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->items[0].match : "",
-		       len, pathspec);
-	return len;
+	read_directory(dir, prefix, prefix_len, pathspec);
+
+	free(prefix);
+	return prefix_len;
 }
 
 int within_depth(const char *name, int namelen,
diff --git a/pathspec.c b/pathspec.c
index 66db257..08abdd3 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -89,41 +89,42 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
 
 static inline int get_literal_global(void)
 {
-	static int literal_global = -1;
+	static int literal = -1;
 
-	if (literal_global < 0)
-		literal_global = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT,
-					      0);
-	return literal_global;
+	if (literal < 0)
+		literal = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0);
+
+	return literal;
 }
 
 static inline int get_glob_global(void)
 {
-	static int glob_global = -1;
+	static int glob = -1;
+
+	if (glob < 0)
+		glob = git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
 
-	if (glob_global < 0)
-		glob_global = git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
-	return glob_global;
+	return glob;
 }
 
 static inline int get_noglob_global(void)
 {
-	static int noglob_global = -1;
+	static int noglob = -1;
+
+	if (noglob < 0)
+		noglob = git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, 0);
 
-	if (noglob_global < 0)
-		noglob_global = git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT,
-					     0);
-	return noglob_global;
+	return noglob;
 }
 
 static inline int get_icase_global(void)
 {
-	static int icase_global = -1;
+	static int icase = -1;
 
-	if (icase_global < 0)
-		icase_global = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
+	if (icase < 0)
+		icase = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
 
-	return icase_global;
+	return icase;
 }
 
 static int get_global_magic(int element_magic)
@@ -296,13 +297,11 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 }
 
 /*
- * Take an element of a pathspec and check for magic signatures.
- * Append the result to the prefix. Return the magic bitmap.
+ * Perform the initialization of a pathspec_item based on a pathspec element.
  */
-static unsigned prefix_pathspec(struct pathspec_item *item,
-				unsigned flags,
-				const char *prefix, int prefixlen,
-				const char *elt)
+static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
+			       const char *prefix, int prefixlen,
+			       const char *elt)
 {
 	unsigned magic = 0, element_magic = 0;
 	const char *copyfrom = elt;
@@ -310,7 +309,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	int pathspec_prefix = -1;
 
 	/* PATHSPEC_LITERAL_PATH ignores magic */
-	if (!(flags & PATHSPEC_LITERAL_PATH)) {
+	if (flags & PATHSPEC_LITERAL_PATH) {
+		magic = PATHSPEC_LITERAL;
+	} else {
 		copyfrom = parse_element_magic(&element_magic,
 					       &pathspec_prefix,
 					       elt);
@@ -318,6 +319,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		magic |= get_global_magic(element_magic);
 	}
 
+	item->magic = magic;
+
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
 		die("BUG: 'prefix' magic is supposed to be used at worktree's root");
@@ -390,7 +393,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	/* sanity checks, pathspec matchers assume these are sane */
 	assert(item->nowildcard_len <= item->len &&
 	       item->prefix         <= item->len);
-	return magic;
 }
 
 static int pathspec_item_cmp(const void *a_, const void *b_)
@@ -489,17 +491,12 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i,
-						flags,
-						prefix, prefixlen, entry);
-		if ((flags & PATHSPEC_LITERAL_PATH) &&
-		    !(magic_mask & PATHSPEC_LITERAL))
-			item[i].magic |= PATHSPEC_LITERAL;
+		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
+
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
-			unsupported_magic(entry,
-					  item[i].magic & magic_mask);
+			unsupported_magic(entry, item[i].magic & magic_mask);
 
 		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
 		    has_symlink_leading_path(item[i].match, item[i].len)) {

-- 
2.8.0.rc3.226.g39d4020

