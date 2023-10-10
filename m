Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5FACD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbjJJTts (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjJJTtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:49:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CF8E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:49:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so5981837f8f.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696967382; x=1697572182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SiPxnwHCvLPyvGNibZH7KztFJzrT/Onx7mvQml7kFY=;
        b=GWP42X9+e1xdHYK2qlxMOIbbTY5GyREyQv/QoCk0TeJU77Zug1vi9zH3pb8ByQfBod
         MSBwBt3u90THuv+QmoBQQp+CJ6G6Ykkr7n37tjN452BAetziC/6fOXuiYsx5NwYVRsX+
         eQ6vSW6AEhXdSVumlgcxNUyjgdnnOnwz9cPBSM2mfDgrct38kmKC7AwBC4O90zQjZ13t
         AV5D/yGlAHnwrNPIhFvNMzlj8Q1G9W5rTRc8CpzAhxLIIbO8bDVUPqlE+gVK7wATMy+L
         A7P+wkVIhadGjDPKoa+nA8fjMks781xsRgLMVNUHZ8Lnq6YEfTuU46g0DfPCcSPtHcc/
         r52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967382; x=1697572182;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SiPxnwHCvLPyvGNibZH7KztFJzrT/Onx7mvQml7kFY=;
        b=ju+CkiqtSLs0V3t4+vi5/KiPfFpWmD3SZqVbJuEtUGYz9XE5Q3P1sqbfJmvNt8oMSZ
         S7C3YTH+Z4l68V3jMUoTxn2bDZ7SBcKxSSTZZN/hSwQsnJ7wJzN9GG1dQT72pe0BgTVf
         BDy5OGe2X2/J9aM4Wb/n9qFCE0ue55f5jIR6yjaqMm3w4tBpnQc8DM0mUlYTcB/b1Sh5
         HZ04MPRIR1yuBKQEHhbUTXRR+oyASPBWDBylAl1+TJGQZoZ4cdy5Jtp2iDhYl6gVj22P
         MgL/TzyTsZGSlEDJO2UAjFEr4/f+tWCD7GwRoA8ZLfPP4i4S/5szL+sxX525HfT4CplH
         HDAg==
X-Gm-Message-State: AOJu0Yw3jeD7CeVQYavvUyBqJtwVfdR8wa8z7klUENQGgP7iSmBaHbFm
        ofyFBa5ncIPbnbabWahAi68/VK/fXyc=
X-Google-Smtp-Source: AGHT+IFCGtrYm0tiYlUZIqFpLnZ/VYvGOPaTxU+KbsczZjgSQJZ2V5gmtml2zTuN+KxD9M5iL+Y6Ew==
X-Received: by 2002:a5d:4586:0:b0:321:5e2f:37e1 with SMTP id p6-20020a5d4586000000b003215e2f37e1mr16814115wrq.19.1696967381780;
        Tue, 10 Oct 2023 12:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600001c900b0032179c4a46dsm13447275wrx.100.2023.10.10.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:49:41 -0700 (PDT)
Message-ID: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
References: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Oct 2023 19:49:38 +0000
Subject: [PATCH v3 0/2] attr: add attr.tree config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

44451a2e5e (attr: teach "--attr-source=" global option to "git", 2023-05-06)
provided the ability to pass in a treeish as the attr source. When a
revision does not resolve to a valid tree is passed, Git will die. At
GitLab, we server repositories as bare repos and would like to always read
attributes from the default branch, so we'd like to pass in HEAD as the
treeish to read gitattributes from on every command. In this context we
would not want Git to die if HEAD is unborn, like in the case of empty
repositories.

Instead of modifying the default behavior of --attr-source, create a new
config attr.tree with which an admin can configure a ref for all commands to
read gitattributes from. Also make the default tree to read from HEAD on
bare repositories.

Changes since v2:

 * relax the restrictions around attr.tree so that if it does not resolve to
   a valid treeish, ignore it.
 * add a commit to default to HEAD in bare repositories

Changes since v1:

 * Added a commit to add attr.tree config

John Cai (2):
  attr: read attributes from HEAD when bare repo
  attr: add attr.tree for setting the treeish to read attributes from

 Documentation/config.txt      |  2 +
 Documentation/config/attr.txt |  5 +++
 attr.c                        | 19 ++++++++-
 attr.h                        |  2 +
 config.c                      | 14 +++++++
 t/t0003-attributes.sh         | 76 +++++++++++++++++++++++++++++++++++
 t/t5001-archive-attr.sh       |  2 +-
 7 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/attr.txt


base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1577%2Fjohn-cai%2Fjc%2Fconfig-attr-invalid-source-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1577/john-cai/jc/config-attr-invalid-source-v3
Pull-Request: https://github.com/git/git/pull/1577

Range-diff vs v2:

 2:  52d9e180352 ! 1:  cef206d47c7 attr: add attr.allowInvalidSource config to allow invalid revision
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    attr: add attr.allowInvalidSource config to allow invalid revision
     +    attr: read attributes from HEAD when bare repo
      
     -    The previous commit provided the ability to pass in a treeish as the
     -    attr source via the attr.tree config. The default behavior is that when
     -    a revision does not resolve to a valid tree is passed, Git will die.
     +    The motivation for 44451a2e5e (attr: teach "--attr-source=<tree>" global
     +    option to "git" , 2023-05-06), was to make it possible to use
     +    gitattributes with bare repositories.
      
     -    When HEAD is unborn however, it does not point to a valid treeish,
     -    causing Git to die. In the context of serving repositories through bare
     -    repositories, we'd like to be able to set attr.tree to HEAD and allow
     -    cases where HEAD does not resolve to a valid tree to be treated as if
     -    there were no treeish provided.
     -
     -    Add attr.allowInvalidSource that allows this.
     +    To make it easier to read gitattributes in bare repositories however,
     +    let's just make HEAD:.gitattributes the default. This is in line with
     +    how mailmap works, 8c473cecfd (mailmap: default mailmap.blob in bare
     +    repositories, 2012-12-13).
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     - ## Documentation/config/attr.txt ##
     -@@ Documentation/config/attr.txt: attr.tree:
     - 	linkgit:gitattributes[5]. This is equivalent to setting the
     - 	`GIT_ATTR_SOURCE` environment variable, or passing in --attr-source to
     - 	the Git command.
     -+
     -+attr.allowInvalidSource::
     -+	If `attr.tree` cannot resolve to a valid tree object, ignore
     -+	`attr.tree` instead of erroring out, and fall back to looking for
     -+	attributes in the default locations. Useful when passing `HEAD` into
     -+	`attr-source` since it allows `HEAD` to point to an unborn branch in
     -+	cases like an empty repository.
     -
       ## attr.c ##
     -@@ attr.c: void set_git_attr_source(const char *tree_object_name)
     +@@ attr.c: static void collect_some_attrs(struct index_state *istate,
     + }
       
     - static void compute_default_attr_source(struct object_id *attr_source)
     + static const char *default_attr_source_tree_object_name;
     ++static int ignore_bad_attr_tree;
     + 
     + void set_git_attr_source(const char *tree_object_name)
       {
     -+	int attr_source_from_config = 0;
     -+
     +@@ attr.c: static void compute_default_attr_source(struct object_id *attr_source)
       	if (!default_attr_source_tree_object_name)
       		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
       
     - 	if (!default_attr_source_tree_object_name) {
     - 		char *attr_tree;
     - 
     --		if (!git_config_get_string("attr.tree", &attr_tree))
     -+		if (!git_config_get_string("attr.tree", &attr_tree)) {
     -+			attr_source_from_config = 1;
     - 			default_attr_source_tree_object_name = attr_tree;
     -+		}
     - 	}
     - 
     ++	if (!default_attr_source_tree_object_name &&
     ++	    startup_info->have_repository &&
     ++	    is_bare_repository()) {
     ++		default_attr_source_tree_object_name = "HEAD";
     ++		ignore_bad_attr_tree = 1;
     ++	}
     ++
       	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
       		return;
       
      -	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
     --		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
     -+	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source)) {
     -+		int allow_invalid_attr_source = 0;
     -+
     -+		git_config_get_bool("attr.allowinvalidsource", &allow_invalid_attr_source);
     -+
     -+		if (!(allow_invalid_attr_source && attr_source_from_config))
     -+			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
     -+	}
     ++	if (repo_get_oid_treeish(the_repository,
     ++				 default_attr_source_tree_object_name,
     ++				 attr_source) && !ignore_bad_attr_tree)
     + 		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
       }
       
     - static struct object_id *default_attr_source(void)
      
       ## t/t0003-attributes.sh ##
      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattribute is ignored' '
       	)
       '
       
     -+bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
      +
     -+test_expect_success 'attr.allowInvalidSource when HEAD is unborn' '
     -+	test_when_finished rm -rf empty &&
     -+	echo $bad_attr_source_err >expect_err &&
     -+	echo "f/path: test: unspecified" >expect &&
     -+	git init empty &&
     -+	test_must_fail git -C empty --attr-source=HEAD check-attr test -- f/path 2>err &&
     -+	test_cmp expect_err err &&
     -+	git -C empty -c attr.tree=HEAD -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'attr.allowInvalidSource when --attr-source points to non-existing ref' '
     -+	test_when_finished rm -rf empty &&
     -+	echo $bad_attr_source_err >expect_err &&
     -+	echo "f/path: test: unspecified" >expect &&
     -+	git init empty &&
     -+	test_must_fail git -C empty --attr-source=refs/does/not/exist check-attr test -- f/path 2>err &&
     -+	test_cmp expect_err err &&
     -+	git -C empty -c attr.tree=refs/does/not/exist -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'bad attr source defaults to reading .gitattributes file' '
     -+	test_when_finished rm -rf empty &&
     -+	git init empty &&
     -+	echo "f/path test=val" >empty/.gitattributes &&
     ++test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
     ++	test_when_finished rm -rf test bare_with_gitattribute &&
     ++	git init test &&
     ++	(
     ++		cd test &&
     ++		test_commit gitattributes .gitattributes "f/path test=val"
     ++	) &&
     ++	git clone --bare test bare_with_gitattribute &&
      +	echo "f/path: test: val" >expect &&
     -+	git -C empty -c attr.tree=HEAD -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
     -+	test_must_be_empty err &&
     ++	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
      +	test_cmp expect actual
      +'
     -+
     -+test_expect_success 'attr.allowInvalidSource has no effect on --attr-source' '
     -+	test_when_finished rm -rf empty &&
     -+	echo $bad_attr_source_err >expect_err &&
     -+	echo "f/path: test: unspecified" >expect &&
     -+	git init empty &&
     -+	test_must_fail git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path 2>err &&
     -+	test_cmp expect_err err
     -+'
      +
       test_expect_success 'bare repository: with --source' '
       	(
       		cd bare.git &&
     +
     + ## t/t5001-archive-attr.sh ##
     +@@ t/t5001-archive-attr.sh: test_expect_success 'git archive with worktree attributes, bare' '
     + '
     + 
     + test_expect_missing	bare-worktree/ignored
     +-test_expect_exists	bare-worktree/ignored-by-tree
     ++test_expect_missing	bare-worktree/ignored-by-tree
     + test_expect_exists	bare-worktree/ignored-by-worktree
     + 
     + test_expect_success 'export-subst' '
 1:  446bce03a96 ! 2:  dadb822da99 attr: add attr.tree for setting the treeish to read attributes from
     @@ Metadata
       ## Commit message ##
          attr: add attr.tree for setting the treeish to read attributes from
      
     -    44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
     +    44451a2 (attr: teach "--attr-source=<tree>" global option to "git",
          2023-05-06) provided the ability to pass in a treeish as the attr
          source. In the context of serving Git repositories as bare repos like we
          do at GitLab however, it would be easier to point --attr-source to HEAD
     @@ Documentation/config/attr.txt (new)
      @@
      +attr.tree:
      +	A <tree-ish> to read gitattributes from instead of the worktree. See
     -+	linkgit:gitattributes[5]. This is equivalent to setting the
     -+	`GIT_ATTR_SOURCE` environment variable, or passing in --attr-source to
     -+	the Git command.
     ++	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a valid tree,
     ++	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE take
     ++	precedence over attr.tree.
      
       ## attr.c ##
     +@@
     + #include "tree-walk.h"
     + #include "object-name.h"
     + 
     ++const char *git_attr_tree;
     ++
     + const char git_attr__true[] = "(builtin)true";
     + const char git_attr__false[] = "\0(builtin)false";
     + static const char git_attr__unknown[] = "(builtin)unknown";
      @@ attr.c: static void compute_default_attr_source(struct object_id *attr_source)
       	if (!default_attr_source_tree_object_name)
       		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
       
      +	if (!default_attr_source_tree_object_name) {
     -+		char *attr_tree;
     -+
     -+		if (!git_config_get_string("attr.tree", &attr_tree))
     -+			default_attr_source_tree_object_name = attr_tree;
     ++		default_attr_source_tree_object_name = git_attr_tree;
     ++		ignore_bad_attr_tree = 1;
      +	}
      +
     - 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
     - 		return;
     + 	if (!default_attr_source_tree_object_name &&
     + 	    startup_info->have_repository &&
     + 	    is_bare_repository()) {
     +
     + ## attr.h ##
     +@@ attr.h: const char *git_attr_global_file(void);
     + /* Return whether the system gitattributes file is enabled and should be used. */
     + int git_attr_system_is_enabled(void);
     + 
     ++extern const char *git_attr_tree;
     ++
     + #endif /* ATTR_H */
     +
     + ## config.c ##
     +@@
     + #include "repository.h"
     + #include "lockfile.h"
     + #include "mailmap.h"
     ++#include "attr.h"
     + #include "exec-cmd.h"
     + #include "strbuf.h"
     + #include "quote.h"
     +@@ config.c: static int git_default_mailmap_config(const char *var, const char *value)
     + 	return 0;
     + }
     + 
     ++static int git_default_attr_config(const char *var, const char *value)
     ++{
     ++	if (!strcmp(var, "attr.tree"))
     ++		return git_config_string(&git_attr_tree, var, value);
     ++
     ++	/* Add other attribute related config variables here and to
     ++	   Documentation/config/attr.txt. */
     ++	return 0;
     ++}
     ++
     + int git_default_config(const char *var, const char *value,
     + 		       const struct config_context *ctx, void *cb)
     + {
     +@@ config.c: int git_default_config(const char *var, const char *value,
     + 	if (starts_with(var, "mailmap."))
     + 		return git_default_mailmap_config(var, value);
     + 
     ++	if (starts_with(var, "attr."))
     ++		return git_default_attr_config(var, value);
     ++
     + 	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
     + 		return git_default_advice_config(var, value);
       
      
       ## t/t0003-attributes.sh ##
     @@ t/t0003-attributes.sh: attr_check_source () {
       	GIT_ATTR_SOURCE="$source" git $git_opts check-attr test -- "$path" >actual 2>err &&
       	test_cmp expect actual &&
       	test_must_be_empty err
     +@@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattribute is ignored' '
     + 	)
     + '
     + 
     ++bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
     ++
     ++test_expect_success 'attr.tree when HEAD is unborn' '
     ++	test_when_finished rm -rf empty &&
     ++	git init empty &&
     ++	(
     ++		cd empty &&
     ++		echo $bad_attr_source_err >expect_err &&
     ++		echo "f/path: test: unspecified" >expect &&
     ++		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
     ++		test_must_be_empty err &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     ++test_expect_success 'attr.tree points to non-existing ref' '
     ++	test_when_finished rm -rf empty &&
     ++	git init empty &&
     ++	(
     ++		cd empty &&
     ++		echo $bad_attr_source_err >expect_err &&
     ++		echo "f/path: test: unspecified" >expect &&
     ++		git -c attr.tree=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
     ++		test_must_be_empty err &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     ++test_expect_success 'bad attr source defaults to reading .gitattributes file' '
     ++	test_when_finished rm -rf empty &&
     ++	git init empty &&
     ++	(
     ++		cd empty &&
     ++		echo "f/path test=val" >.gitattributes &&
     ++		echo "f/path: test: val" >expect &&
     ++		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
     ++		test_must_be_empty err &&
     ++		test_cmp expect actual
     ++	)
     ++'
     + 
     + test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
     + 	test_when_finished rm -rf test bare_with_gitattribute &&
     +@@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success '--attr-source and GIT_ATTR_SOURCE take precedence over attr.tree' '
     ++	test_when_finished rm -rf empty &&
     ++	git init empty &&
     ++	(
     ++		cd empty &&
     ++		git checkout -b attr-source &&
     ++		test_commit "val1" .gitattributes "f/path test=val1" &&
     ++		git checkout -b attr-tree &&
     ++		test_commit "val2" .gitattributes "f/path test=val2" &&
     ++		git checkout attr-source &&
     ++		echo "f/path: test: val1" >expect &&
     ++		git -c attr.tree=attr-tree --attr-source=attr-source check-attr test -- f/path >actual &&
     ++		test_cmp expect actual &&
     ++		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree check-attr test -- f/path >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     + test_expect_success 'bare repository: with --source' '
     + 	(
     + 		cd bare.git &&

-- 
gitgitgadget
