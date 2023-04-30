Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3016CC77B7E
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 02:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjD3CjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 22:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD3CjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 22:39:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041119BF
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 19:39:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so6641155e9.1
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682822354; x=1685414354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBQzv4umSq3oosxLt4uPfk4whz4OCtR5XU7jIRCQXpA=;
        b=cw7uWElQQ2Ys/9iAkmpVLrcWlP0HGoASUWzjP0c5GDcxzWdneLFxTu8BbhiJZWYyX8
         005aVL/ZIfX6sWax4ABYhmYJGIBDc3lq1Qen7NC801nreHvwJWnNzoLtr2YbnVzazTzK
         wlAX7UbxMN48UQNdsa3mHMdgSFH7EzFUl+1qvO3dYwJYyPhFu+OKB8i5j1LHPxMw06Qi
         nrfDDIk9zSWeIimoMbks6wKDaMZXVzom67D1p6eM5iadmap0sS0FUXpctCzPqkG3yb9W
         DkB//dr7UkqhT2VLLxvgjJRdu2OP9fmTlRAV5YGzfIha0K9cQ0t/Vmjv/YSwqXu2x7Nn
         wO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682822354; x=1685414354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBQzv4umSq3oosxLt4uPfk4whz4OCtR5XU7jIRCQXpA=;
        b=PAD2Lh3+AJjor36H0IigYdDEG1zfDIv6u526FAK7B2g1oEnFUC2ldRcWmcuHYq2htO
         lY6td8Lw95IePjmj6H+gnMqC1UTUxt5LwXU42W/K6z0fk91SBHCMvs3G8c+I8Vg8p/qa
         Gib/L8rRQfENBe1c3tm4OdAkLptnnqJxJ9h9PsZAWhfaSXjou9+wrUbYMezKj1wORIX0
         Dmu5R/7dJ1Jg6XRtPsPW1FsiB00yJyR2ophTsZP8CtRu5BcWkHQS+Wwca3LcVIALwvd4
         EWj/ovwozzmat+LoZl6nr0BA2352zHdIMbHQeq10O0o/RvtgOWQyX5oc4b/JhfcFeccD
         Z6oA==
X-Gm-Message-State: AC+VfDwV3zA1frUufjx7WeXKtsLefRTsEws9k1459VfgnTNpIHBwKptm
        OEVNwe37SRZVY+hw/IEfPfi6rsQE7Nw=
X-Google-Smtp-Source: ACHHUZ6Z2Nscpax7Oqrq4xdO/nRmrCR2FG+249SqbUVhWcUiHlfRmhtynIlzK1X5nYipnC+GKZ56+A==
X-Received: by 2002:a1c:6a05:0:b0:3f2:5be3:cd67 with SMTP id f5-20020a1c6a05000000b003f25be3cd67mr6841819wmc.18.1682822353836;
        Sat, 29 Apr 2023 19:39:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003f1978bbcd6sm31772187wmo.3.2023.04.29.19.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 19:39:13 -0700 (PDT)
Message-Id: <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>
In-Reply-To: <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
References: <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Apr 2023 02:39:12 +0000
Subject: [PATCH v4] attr: teach "--attr-source=<tree>" global option to "git"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Earlier, 47cfc9bd (attr: add flag `--source` to work with tree-ish,
2023-01-14) taught "git check-attr" the "--source=<tree>" option to
allow it to read attribute files from a tree-ish, but did so only
for the command.  Just like "check-attr" users wanted a way to use
attributes from a tree-ish and not from the working tree files,
users of other commands (like "git diff") would benefit from the
same.

Undo most of the UI change the commit made, while keeping the
internal logic to read attributes from a given tree-ish. Expose the
internal logic via a new "--attr-source=<tree>" command line option
given to "git", so that it can be used with any git command that
runs as part of the main git process.

Additionally, add an environment variable GIT_ATTR_SOURCE that is set
when --attr-source is passed in, so that subprocesses use the same value
for the attributes source tree.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
    attr: teach "--attr-source=" global option to "git"
    
    [1] aimed to allow gitattributes to be read from bare repositories when
    running git-diff(1). Through discussion, a more general solution emerged
    (represented by this patch), which allows the attribute machinery to
    read attributes from a source passed in through a git flag.
    
    Changes since v3:
    
     * fixed documentation link
     * simplified error message handling when --attr-source or
       GIT_ATTR_SOURCE is bad
    
    Changes since v2:
    
     * allow --attr-source= and --attr-source
     * fixes to commit message
     * fix error message to distinguish between --attr-source and
       GIT_ATTR_SOURCE
    
     1. https://lore.kernel.org/git/pull.1459.git.git.1678758818.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1470%2Fjohn-cai%2Fjc%2Fattr-source-git-flag-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1470/john-cai/jc/attr-source-git-flag-v4
Pull-Request: https://github.com/git/git/pull/1470

Range-diff vs v3:

 1:  ff8d3a0e780 ! 1:  e41f931b0ad attr: teach "--attr-source=<tree>" global option to "git"
     @@ Documentation/git.txt: If you just want to run git as if it was started in `<pat
       
      +--attr-source=<tree-ish>::
      +	Read gitattributes from <tree-ish> instead of the worktree. See
     -+	linkgit:gitrevisions[7].
     ++	linkgit:gitattributes[5]. This is equivalent to setting the
     ++	`GIT_ATTR_SOURCE` environment variable.
      +
       GIT COMMANDS
       ------------
     @@ attr.c: static void collect_some_attrs(struct index_state *istate,
      +	default_attr_source_tree_object_name = xstrdup(tree_object_name);
      +}
      +
     -+
      +static void compute_default_attr_source(struct object_id *attr_source)
      +{
     -+	int from_env = 0;
     -+
     -+	if (!default_attr_source_tree_object_name) {
     ++	if (!default_attr_source_tree_object_name)
      +		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE);
     -+		from_env = 1;
     -+	}
      +
      +	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
      +		return;
      +
     -+	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source)) {
     -+		if (from_env)
     -+			die(_("bad --attr-source object"));
     -+		else
     -+			die(_("bad GIT_ATTR_SOURCE"));
     -+	}
     ++	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
     ++		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
      +}
      +
      +static struct object_id *default_attr_source(void)


 Documentation/git.txt     |  5 +++++
 archive.c                 |  2 +-
 attr.c                    | 37 +++++++++++++++++++++++++++++++++++--
 attr.h                    | 13 +++++++++----
 builtin/check-attr.c      | 17 ++++++++---------
 builtin/pack-objects.c    |  2 +-
 convert.c                 |  2 +-
 environment.h             |  1 +
 git.c                     | 16 ++++++++++++++++
 ll-merge.c                |  4 ++--
 pathspec.c                |  2 +-
 t/lib-diff-alternative.sh | 31 ++++++++++++++++++++++++++-----
 t/t0003-attributes.sh     | 11 ++++++++++-
 t/t4018-diff-funcname.sh  | 19 +++++++++++++++++++
 userdiff.c                |  2 +-
 ws.c                      |  2 +-
 16 files changed, 137 insertions(+), 29 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74973d3cc40..b8f4f604707 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -212,6 +212,11 @@ If you just want to run git as if it was started in `<path>` then use
 	nohelpers (exclude helper commands), alias and config
 	(retrieve command list from config variable completion.commands)
 
+--attr-source=<tree-ish>::
+	Read gitattributes from <tree-ish> instead of the worktree. See
+	linkgit:gitattributes[5]. This is equivalent to setting the
+	`GIT_ATTR_SOURCE` environment variable.
+
 GIT COMMANDS
 ------------
 
diff --git a/archive.c b/archive.c
index 8570cf37ff7..e809514fe70 100644
--- a/archive.c
+++ b/archive.c
@@ -128,7 +128,7 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	return check;
 }
 
diff --git a/attr.c b/attr.c
index 2d8aeb8b58c..27a1d5b9a92 100644
--- a/attr.c
+++ b/attr.c
@@ -20,6 +20,7 @@
 #include "object-store.h"
 #include "setup.h"
 #include "thread-utils.h"
+#include "object-name.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -1169,11 +1170,42 @@ static void collect_some_attrs(struct index_state *istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
+static const char *default_attr_source_tree_object_name;
+
+void set_git_attr_source(const char *tree_object_name)
+{
+	default_attr_source_tree_object_name = xstrdup(tree_object_name);
+}
+
+static void compute_default_attr_source(struct object_id *attr_source)
+{
+	if (!default_attr_source_tree_object_name)
+		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE);
+
+	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
+		return;
+
+	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
+		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+}
+
+static struct object_id *default_attr_source(void)
+{
+	static struct object_id attr_source;
+
+	if (is_null_oid(&attr_source))
+		compute_default_attr_source(&attr_source);
+	if (is_null_oid(&attr_source))
+		return NULL;
+	return &attr_source;
+}
+
 void git_check_attr(struct index_state *istate,
-		    const struct object_id *tree_oid, const char *path,
+		    const char *path,
 		    struct attr_check *check)
 {
 	int i;
+	const struct object_id *tree_oid = default_attr_source();
 
 	collect_some_attrs(istate, tree_oid, path, check);
 
@@ -1186,10 +1218,11 @@ void git_check_attr(struct index_state *istate,
 	}
 }
 
-void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
+void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check)
 {
 	int i;
+	const struct object_id *tree_oid = default_attr_source();
 
 	attr_check_reset(check);
 	collect_some_attrs(istate, tree_oid, path, check);
diff --git a/attr.h b/attr.h
index 9884ea2bc60..676bd17ce27 100644
--- a/attr.h
+++ b/attr.h
@@ -45,7 +45,7 @@
  * const char *path;
  *
  * setup_check();
- * git_check_attr(&the_index, tree_oid, path, check);
+ * git_check_attr(&the_index, path, check);
  * ------------
  *
  * - Act on `.value` member of the result, left in `check->items[]`:
@@ -120,7 +120,6 @@
 #define ATTR_MAX_FILE_SIZE (100 * 1024 * 1024)
 
 struct index_state;
-struct object_id;
 
 /**
  * An attribute is an opaque object that is identified by its name. Pass the
@@ -135,6 +134,12 @@ struct git_attr;
 struct all_attrs_item;
 struct attr_stack;
 
+/*
+ * The textual object name for the tree-ish used by git_check_attr()
+ * to read attributes from (instead of from the working tree).
+ */
+void set_git_attr_source(const char *);
+
 /*
  * Given a string, return the gitattribute object that
  * corresponds to it.
@@ -203,14 +208,14 @@ void attr_check_free(struct attr_check *check);
 const char *git_attr_name(const struct git_attr *);
 
 void git_check_attr(struct index_state *istate,
-		    const struct object_id *tree_oid, const char *path,
+		    const char *path,
 		    struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
+void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 037bf1aaa2a..748f3578b2a 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -63,7 +63,7 @@ static void output_attr(struct attr_check *check, const char *file)
 }
 
 static void check_attr(const char *prefix, struct attr_check *check,
-		       const struct object_id *tree_oid, int collect_all,
+		       int collect_all,
 		       const char *file)
 
 {
@@ -71,9 +71,9 @@ static void check_attr(const char *prefix, struct attr_check *check,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(&the_index, tree_oid, full_path, check);
+		git_all_attrs(&the_index, full_path, check);
 	} else {
-		git_check_attr(&the_index, tree_oid, full_path, check);
+		git_check_attr(&the_index, full_path, check);
 	}
 	output_attr(check, file);
 
@@ -81,7 +81,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
 }
 
 static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
-				   const struct object_id *tree_oid, int collect_all)
+				   int collect_all)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -95,7 +95,7 @@ static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, check, tree_oid, collect_all, buf.buf);
+		check_attr(prefix, check, collect_all, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -111,7 +111,6 @@ static NORETURN void error_with_usage(const char *msg)
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct attr_check *check;
-	struct object_id *tree_oid = NULL;
 	struct object_id initialized_oid;
 	int cnt, i, doubledash, filei;
 
@@ -187,14 +186,14 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (source) {
 		if (repo_get_oid_tree(the_repository, source, &initialized_oid))
 			die("%s: not a valid tree-ish source", source);
-		tree_oid = &initialized_oid;
+		set_git_attr_source(source);
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, check, tree_oid, all_attrs);
+		check_attr_stdin_paths(prefix, check, all_attrs);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, check, tree_oid, all_attrs, argv[i]);
+			check_attr(prefix, check, all_attrs, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5b466839ba..9cfc8801f9b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1331,7 +1331,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	git_check_attr(the_repository->index, NULL, path, check);
+	git_check_attr(the_repository->index, path, check);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
 	return 0;
diff --git a/convert.c b/convert.c
index 5a2ea5308d6..e65938bb1a8 100644
--- a/convert.c
+++ b/convert.c
@@ -1314,7 +1314,7 @@ void convert_attrs(struct index_state *istate,
 		git_config(read_convert_config, NULL);
 	}
 
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	ccheck = check->items;
 	ca->crlf_action = git_path_check_crlf(ccheck + 4);
 	if (ca->crlf_action == CRLF_UNDEFINED)
diff --git a/environment.h b/environment.h
index a63f0c6a24f..758927a689c 100644
--- a/environment.h
+++ b/environment.h
@@ -55,6 +55,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
+#define GIT_ATTR_SOURCE "GIT_ATTR_SOURCE"
 
 /*
  * Environment variable used in handshaking the wire protocol.
diff --git a/git.c b/git.c
index 45899be8265..106c4ab639a 100644
--- a/git.c
+++ b/git.c
@@ -9,6 +9,7 @@
 #include "alias.h"
 #include "replace-object.h"
 #include "setup.h"
+#include "attr.h"
 #include "shallow.h"
 #include "trace.h"
 #include "trace2.h"
@@ -314,6 +315,21 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			} else {
 				exit(list_cmds(cmd));
 			}
+		} else if (!strcmp(cmd, "--attr-source")) {
+			if (*argc < 2) {
+				fprintf(stderr, _("no prefix given for --attr-source\n" ));
+				usage(git_usage_string);
+			}
+			setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (skip_prefix(cmd, "--attr-source=", &cmd)) {
+			set_git_attr_source(cmd);
+			setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/ll-merge.c b/ll-merge.c
index 28bc94c45d6..6580970a670 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -393,7 +393,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 		normalize_file(theirs, path, istate);
 	}
 
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
 		marker_size = atoi(check->items[1].value);
@@ -421,7 +421,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	if (check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
diff --git a/pathspec.c b/pathspec.c
index 6972d515f0c..09103a137ef 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -734,7 +734,7 @@ int match_pathspec_attrs(struct index_state *istate,
 	if (name[namelen])
 		name = to_free = xmemdupz(name, namelen);
 
-	git_check_attr(istate, NULL, name, item->attr_check);
+	git_check_attr(istate, name, item->attr_check);
 
 	free(to_free);
 
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index a8f5d3274a5..c4dc2d46dc1 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -112,15 +112,36 @@ EOF
 
 	STRATEGY=$1
 
-	test_expect_success "$STRATEGY diff from attributes" '
+	test_expect_success "setup attributes files for tests with $STRATEGY" '
+		git checkout -b master &&
 		echo "file* diff=driver" >.gitattributes &&
-		git config diff.driver.algorithm "$STRATEGY" &&
-		test_must_fail git diff --no-index file1 file2 > output &&
-		cat expect &&
-		cat output &&
+		git add file1 file2 .gitattributes &&
+		git commit -m "adding files" &&
+		git checkout -b branchA &&
+		echo "file* diff=driverA" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -m "adding driverA as diff driver" &&
+		git checkout master &&
+		git clone --bare --no-local . bare.git
+	'
+
+	test_expect_success "$STRATEGY diff from attributes" '
+		test_must_fail git -c diff.driver.algorithm=$STRATEGY diff --no-index file1 file2 > output &&
 		test_cmp expect output
 	'
 
+	test_expect_success "diff from attributes with bare repo with source" '
+		git -C bare.git --attr-source=branchA -c diff.driver.algorithm=myers \
+			-c diff.driverA.algorithm=$STRATEGY \
+			diff HEAD:file1 HEAD:file2 >output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "diff from attributes with bare repo with invalid source" '
+		test_must_fail git -C bare.git --attr-source=invalid-branch diff \
+			HEAD:file1 HEAD:file2
+	'
+
 	test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
 		echo "file* diff=driver" >.gitattributes &&
 		git config diff.driver.algorithm "$STRATEGY" &&
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 89b306cb114..26e082f05b4 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -30,8 +30,17 @@ attr_check_quote () {
 attr_check_source () {
 	path="$1" expect="$2" source="$3" git_opts="$4" &&
 
-	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
 	echo "$path: test: $expect" >expect &&
+
+	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err &&
+
+	git $git_opts --attr-source="$source" check-attr test -- "$path" >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+
+	GIT_ATTR_SOURCE="$source" git $git_opts check-attr test -- "$path" >actual 2>err &&
 	test_cmp expect actual &&
 	test_must_be_empty err
 }
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 42a2b9a13b7..c8d555771d5 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -63,6 +63,25 @@ do
 		test_i18ngrep ! fatal msg &&
 		test_i18ngrep ! error msg
 	'
+
+	test_expect_success "builtin $p pattern compiles on bare repo with --attr-source" '
+		test_when_finished "rm -rf bare.git" &&
+		git checkout -B master &&
+		git add . &&
+		echo "*.java diff=notexist" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -am "changing gitattributes" &&
+		git checkout -B branchA &&
+		echo "*.java diff=$p" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -am "changing gitattributes" &&
+		git clone --bare --no-local . bare.git &&
+		git -C bare.git symbolic-ref HEAD refs/heads/master &&
+		test_expect_code 1 git -C bare.git --attr-source=branchA \
+			diff --exit-code HEAD:A.java HEAD:B.java 2>msg &&
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
+	'
 done
 
 test_expect_success 'last regexp must not be negated' '
diff --git a/userdiff.c b/userdiff.c
index eaec6ebb5e9..664c7c14025 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -444,7 +444,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 
 	if (ATTR_TRUE(check->items[0].value))
 		return &driver_true;
diff --git a/ws.c b/ws.c
index da3d0e28cbb..903bfcd53e4 100644
--- a/ws.c
+++ b/ws.c
@@ -79,7 +79,7 @@ unsigned whitespace_rule(struct index_state *istate, const char *pathname)
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	git_check_attr(istate, NULL, pathname, attr_whitespace_rule);
+	git_check_attr(istate, pathname, attr_whitespace_rule);
 	value = attr_whitespace_rule->items[0].value;
 	if (ATTR_TRUE(value)) {
 		/* true (whitespace) */

base-commit: f85cd430b12b0d3e4f1a30ef3239a1b73d5f6331
-- 
gitgitgadget
