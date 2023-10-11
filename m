Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13636CDB46B
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 17:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjJKRNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJKRNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 13:13:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333098
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:13:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f8a093so1101865e9.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697044424; x=1697649224; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5gNangf6DdRo0MwYigWyLI5nxiiAHSEQayW4E7KyiA=;
        b=DUJZ0fViXgKCgJQkghDgqfiMRGvXvETcO29UCd2NbiQBFOufcJqykKEeXFFXrbo3jn
         1LkZqDaz4Gx1vShNfdmgST94jkqzOkLw0eaWvbuuKj5zzibztIdCUlc69G9GU2ml4kHo
         E8/vz3kOjuUc51PPjjNMWv1F9fRfj8d0rqvKuC8+pYaCaDcRGIcpEmi8703CyW60I0Gv
         whLILG497A0iIVuX+6wZxsb9WAh4bCXQYEKEzhzRDqJ6xYhy2bCbXyPuULY77PBddM4Z
         g7TevkjyQ0DmGRSHMvU8bQQzps2RGkf5xtQiJsPHVNlXwHX4/6D9dK2V7+U52bhRGTC9
         DL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697044424; x=1697649224;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5gNangf6DdRo0MwYigWyLI5nxiiAHSEQayW4E7KyiA=;
        b=bCKsypN9o5HgmxdTCz2ZsV76mlFCVwWUFxXHntswBiDBZkLAZYYd41bIfJkysQtYJe
         4rEdh6LDxL2NgljxRbPAVfHXA4fm64Ot9Y1YNMfGfVjrh4xzdCoODpxH9pNw2QeXhYr2
         Jg+eqUPmmQ+QJ4tfcPi9kmun+eV70P6sqh/MEaQ3en9/Kb5unwuw73nHRDy8+k60ebRK
         mmE12zNLqTjw4HJj1qOf18/3fTDtcccNPCddGhx1kyG40eLnP2VgIBbcY//0xQNKBDW2
         MdEDs7n1qYa5/5tajx38L0/gl1gPOKNg1E5HNOndoBQHFgq3YTYfDieV7ZF6uyS2cRTV
         ED7w==
X-Gm-Message-State: AOJu0YzyGpw139a/gBGLWkTh3GufD2S3/ZvQe9fZNzWJYiWyDf9qpRaq
        aCTlFHVi2xAoYfXbas9r0q+gVeyc6Zw=
X-Google-Smtp-Source: AGHT+IHd+WU9foGAEHRx4UXL+rkAF5i6sz2y5rp1IjTOj5iVWkjN1Kziv2tntMovDGfjKwbQ9Ui3jQ==
X-Received: by 2002:a1c:740d:0:b0:405:1ba2:4fd1 with SMTP id p13-20020a1c740d000000b004051ba24fd1mr20039239wmc.24.1697044423683;
        Wed, 11 Oct 2023 10:13:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17-20020a1ced11000000b0040588d85b3asm19397672wmh.15.2023.10.11.10.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:13:43 -0700 (PDT)
Message-ID: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
References: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Oct 2023 17:13:40 +0000
Subject: [PATCH v4 0/2] attr: add attr.tree config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
 Documentation/config/attr.txt |  7 +++
 attr.c                        | 19 +++++++-
 attr.h                        |  2 +
 config.c                      | 16 +++++++
 t/t0003-attributes.sh         | 84 +++++++++++++++++++++++++++++++++++
 t/t5001-archive-attr.sh       |  2 +-
 7 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/attr.txt


base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1577%2Fjohn-cai%2Fjc%2Fconfig-attr-invalid-source-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1577/john-cai/jc/config-attr-invalid-source-v4
Pull-Request: https://github.com/git/git/pull/1577

Range-diff vs v3:

 1:  cef206d47c7 ! 1:  eaa27c47810 attr: read attributes from HEAD when bare repo
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
      +test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
      +	test_when_finished rm -rf test bare_with_gitattribute &&
      +	git init test &&
     -+	(
     -+		cd test &&
     -+		test_commit gitattributes .gitattributes "f/path test=val"
     -+	) &&
     ++	test_commit -C test gitattributes .gitattributes "f/path test=val" &&
      +	git clone --bare test bare_with_gitattribute &&
      +	echo "f/path: test: val" >expect &&
      +	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
 2:  dadb822da99 ! 2:  749d8a8082e attr: add attr.tree for setting the treeish to read attributes from
     @@ Documentation/config.txt: other popular tools, and describe them in your documen
      
       ## Documentation/config/attr.txt (new) ##
      @@
     -+attr.tree:
     -+	A <tree-ish> to read gitattributes from instead of the worktree. See
     -+	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a valid tree,
     -+	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE take
     -+	precedence over attr.tree.
     ++attr.tree::
     ++	A reference to a tree in the repository from which to read attributes,
     ++	instead of the `.gitattributes` file in the working tree. In a bare
     ++	repository, this defaults to `HEAD:.gitattributes`. If the value does
     ++	not resolve to a valid tree object, an empty tree is used instead.
     ++	When the `GIT_ATTR_SOURCE` environment variable or `--attr-source`
     ++	command line option are used, this configuration variable has no effect.
      
       ## attr.c ##
      @@
     @@ attr.c: static void compute_default_attr_source(struct object_id *attr_source)
       	if (!default_attr_source_tree_object_name)
       		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
       
     -+	if (!default_attr_source_tree_object_name) {
     ++	if (!default_attr_source_tree_object_name && git_attr_tree) {
      +		default_attr_source_tree_object_name = git_attr_tree;
      +		ignore_bad_attr_tree = 1;
      +	}
     @@ config.c: static int git_default_mailmap_config(const char *var, const char *val
      +	if (!strcmp(var, "attr.tree"))
      +		return git_config_string(&git_attr_tree, var, value);
      +
     -+	/* Add other attribute related config variables here and to
     -+	   Documentation/config/attr.txt. */
     ++	/*
     ++	 * Add other attribute related config variables here and to
     ++	 * Documentation/config/attr.txt.
     ++	 */
      +	return 0;
      +}
      +
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
       
      +bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
      +
     ++test_expect_success '--attr-source is bad' '
     ++	test_when_finished rm -rf empty &&
     ++	git init empty &&
     ++	(
     ++		cd empty &&
     ++		echo "$bad_attr_source_err" >expect_err &&
     ++		test_must_fail git --attr-source=HEAD check-attr test -- f/path 2>err &&
     ++		test_cmp expect_err err
     ++	)
     ++'
     ++
      +test_expect_success 'attr.tree when HEAD is unborn' '
      +	test_when_finished rm -rf empty &&
      +	git init empty &&
      +	(
      +		cd empty &&
     -+		echo $bad_attr_source_err >expect_err &&
      +		echo "f/path: test: unspecified" >expect &&
      +		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
      +		test_must_be_empty err &&
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
      +	git init empty &&
      +	(
      +		cd empty &&
     -+		echo $bad_attr_source_err >expect_err &&
      +		echo "f/path: test: unspecified" >expect &&
      +		git -c attr.tree=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
      +		test_must_be_empty err &&
     @@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults to reading .gitat
       	test_cmp expect actual
       '
       
     -+test_expect_success '--attr-source and GIT_ATTR_SOURCE take precedence over attr.tree' '
     ++test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, then attr.tree' '
      +	test_when_finished rm -rf empty &&
      +	git init empty &&
      +	(
     @@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults to reading .gitat
      +		test_commit "val2" .gitattributes "f/path test=val2" &&
      +		git checkout attr-source &&
      +		echo "f/path: test: val1" >expect &&
     -+		git -c attr.tree=attr-tree --attr-source=attr-source check-attr test -- f/path >actual &&
     ++		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree --attr-source=attr-source \
     ++		check-attr test -- f/path >actual &&
      +		test_cmp expect actual &&
     -+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree check-attr test -- f/path >actual &&
     ++		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree \
     ++		check-attr test -- f/path >actual &&
      +		test_cmp expect actual
      +	)
      +'

-- 
gitgitgadget
