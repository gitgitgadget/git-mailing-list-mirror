Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68195E7C4EB
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjJDSSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjJDSS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 14:18:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B659E
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 11:18:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-406650da82bso756095e9.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696443503; x=1697048303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR+IiSI/9FpYfEa+R5ixzf05WtIBI5t3QrhGFF/zhPA=;
        b=DvB2X55hd2OzsttppEldgHR+QUxRyH83uY64AUxUZlf3yVijXLcLBLwtPIudGk5ur/
         gAy23v5OwcurigZiQOukWw7flFAHUg5Z3GxlnI/OegehwYEfdOYz9QJNNrcmDS8h1u0Q
         pQvtUBVqOE0bOAIJjOFbtqXeUqKJyw8rNKT+/7a0GDtlxNTKJtIqqdFUEOGrO4P36SsP
         4ZydvZ0CH6TQvFKQBIKKyTAFWUW1IRpUTDo4gYIvFDlQ3G/pd6RXrEklHh3XzqSBWcZj
         F07RNtvYp0Li20zSlb5f0aLVCvGAGuTtpWK/AFCmvXDwNynM9JSwbJqS1AYsOsq0oasO
         p3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443503; x=1697048303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR+IiSI/9FpYfEa+R5ixzf05WtIBI5t3QrhGFF/zhPA=;
        b=HTxFExlanH0kx/FlkHRJww3vT2bRxEOgDi6CQNTDjyB9NKK0sbEpN6I9Oum3HHZMrh
         ULO8KWCtmV69BxafvdUxA+8TjY2qZvjfQYNg7NMAXlWIU74HSpCJpxF2ArPf8acDE87c
         oZmTLsLlWhd2+Ca3YWMJ1pX95Jgmrc/bsipwHP4i29zZMm4XQsP7SfJpeMkNRgIPS/Tc
         GVxGR/tclqMC+/9QsDpNyyd3s/QVUjK77Df8yZE5jatUGfi45FijcxdhbIr223hF5WTy
         BlcfnpQAfX3jYjkhmteS4rk5k4vrlHL/IvpyTbyBDUWtuz/q7O5+FHn7KjINQ3h+IUtU
         mayQ==
X-Gm-Message-State: AOJu0YzqzD3Rc/Cll2Z9JJFP1jPza8TbOkQDS6tnfdml62woT/2B2r6A
        ccW4T7HMZIj3kbG76rsSoqx+bCOWVoo=
X-Google-Smtp-Source: AGHT+IGLUbrLbnWLgJIfllk+RgZLJmHc6aY2ea4BOKyFh7vfoS638dqRfg6WDyTH+Jm2vP4GHJBnSQ==
X-Received: by 2002:a7b:ce98:0:b0:401:bf56:8ba0 with SMTP id q24-20020a7bce98000000b00401bf568ba0mr3281462wmj.28.1696443502865;
        Wed, 04 Oct 2023 11:18:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a7bc38b000000b003fbe4cecc3bsm2118329wmj.16.2023.10.04.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:18:22 -0700 (PDT)
Message-ID: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 18:18:19 +0000
Subject: [PATCH v2 0/2] attr: add attr.tree and attr.allowInvalidSource configs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
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

Instead of modifying the default behavior of --attr-source, create a pair of
configs attr.tree and attr.allowInvalidSource whereby an admin can configure
a ref for all commands to read gitattributes from, and another config that
relaxes the requirement that this treeish resolve to a valid tree.

Changes since v1:

 * Added a commit to add attr.tree config

John Cai (2):
  attr: add attr.tree for setting the treeish to read attributes from
  attr: add attr.allowInvalidSource config to allow invalid revision

 Documentation/config.txt      |  2 ++
 Documentation/config/attr.txt | 12 +++++++++
 attr.c                        | 21 +++++++++++++--
 t/t0003-attributes.sh         | 49 +++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/attr.txt


base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1577%2Fjohn-cai%2Fjc%2Fconfig-attr-invalid-source-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1577/john-cai/jc/config-attr-invalid-source-v2
Pull-Request: https://github.com/git/git/pull/1577

Range-diff vs v1:

 -:  ----------- > 1:  446bce03a96 attr: add attr.tree for setting the treeish to read attributes from
 1:  06b9acf24ca ! 2:  52d9e180352 attr: attr.allowInvalidSource config to allow invalid revision
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    attr: attr.allowInvalidSource config to allow invalid revision
     +    attr: add attr.allowInvalidSource config to allow invalid revision
      
     -    44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
     -    2023-05-06) provided the ability to pass in a treeish as the attr
     -    source. When a revision does not resolve to a valid tree is passed, Git
     -    will die. GitLab keeps bare repositories and always reads attributes
     -    from the default branch, so we pass in HEAD to --attr-source.
     +    The previous commit provided the ability to pass in a treeish as the
     +    attr source via the attr.tree config. The default behavior is that when
     +    a revision does not resolve to a valid tree is passed, Git will die.
      
     -    With empty repositories however, HEAD does not point to a valid treeish,
     -    causing Git to die. This means we would need to check for a valid
     -    treeish each time. To avoid this, let's add a configuration that allows
     -    Git to simply ignore --attr-source if it does not resolve to a valid
     -    tree.
     +    When HEAD is unborn however, it does not point to a valid treeish,
     +    causing Git to die. In the context of serving repositories through bare
     +    repositories, we'd like to be able to set attr.tree to HEAD and allow
     +    cases where HEAD does not resolve to a valid tree to be treated as if
     +    there were no treeish provided.
     +
     +    Add attr.allowInvalidSource that allows this.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     - ## Documentation/config.txt ##
     -@@ Documentation/config.txt: other popular tools, and describe them in your documentation.
     - 
     - include::config/advice.txt[]
     - 
     -+include::config/attr.txt[]
     + ## Documentation/config/attr.txt ##
     +@@ Documentation/config/attr.txt: attr.tree:
     + 	linkgit:gitattributes[5]. This is equivalent to setting the
     + 	`GIT_ATTR_SOURCE` environment variable, or passing in --attr-source to
     + 	the Git command.
      +
     - include::config/core.txt[]
     - 
     - include::config/add.txt[]
     -
     - ## Documentation/config/attr.txt (new) ##
     -@@
      +attr.allowInvalidSource::
     -+	If `--attr-source` cannot resolve to a valid tree object, ignore
     -+	`--attr-source` instead of erroring out, and fall back to looking for
     ++	If `attr.tree` cannot resolve to a valid tree object, ignore
     ++	`attr.tree` instead of erroring out, and fall back to looking for
      +	attributes in the default locations. Useful when passing `HEAD` into
      +	`attr-source` since it allows `HEAD` to point to an unborn branch in
      +	cases like an empty repository.
      
       ## attr.c ##
     -@@ attr.c: static void compute_default_attr_source(struct object_id *attr_source)
     +@@ attr.c: void set_git_attr_source(const char *tree_object_name)
     + 
     + static void compute_default_attr_source(struct object_id *attr_source)
     + {
     ++	int attr_source_from_config = 0;
     ++
     + 	if (!default_attr_source_tree_object_name)
     + 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
     + 
     + 	if (!default_attr_source_tree_object_name) {
     + 		char *attr_tree;
     + 
     +-		if (!git_config_get_string("attr.tree", &attr_tree))
     ++		if (!git_config_get_string("attr.tree", &attr_tree)) {
     ++			attr_source_from_config = 1;
     + 			default_attr_source_tree_object_name = attr_tree;
     ++		}
     + 	}
     + 
       	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
       		return;
       
      -	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
      -		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
     -+
      +	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source)) {
      +		int allow_invalid_attr_source = 0;
      +
      +		git_config_get_bool("attr.allowinvalidsource", &allow_invalid_attr_source);
      +
     -+		if (!allow_invalid_attr_source)
     ++		if (!(allow_invalid_attr_source && attr_source_from_config))
      +			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
      +	}
       }
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
      +	git init empty &&
      +	test_must_fail git -C empty --attr-source=HEAD check-attr test -- f/path 2>err &&
      +	test_cmp expect_err err &&
     -+	git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path >actual 2>err &&
     ++	git -C empty -c attr.tree=HEAD -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
      +	test_must_be_empty err &&
      +	test_cmp expect actual
      +'
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
      +	git init empty &&
      +	test_must_fail git -C empty --attr-source=refs/does/not/exist check-attr test -- f/path 2>err &&
      +	test_cmp expect_err err &&
     -+	git -C empty -c attr.allowInvalidSource=true --attr-source=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
     ++	git -C empty -c attr.tree=refs/does/not/exist -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
      +	test_must_be_empty err &&
      +	test_cmp expect actual
      +'
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
      +	git init empty &&
      +	echo "f/path test=val" >empty/.gitattributes &&
      +	echo "f/path: test: val" >expect &&
     -+	git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path >actual 2>err &&
     ++	git -C empty -c attr.tree=HEAD -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
      +	test_must_be_empty err &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'attr.allowInvalidSource has no effect on --attr-source' '
     ++	test_when_finished rm -rf empty &&
     ++	echo $bad_attr_source_err >expect_err &&
     ++	echo "f/path: test: unspecified" >expect &&
     ++	git init empty &&
     ++	test_must_fail git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path 2>err &&
     ++	test_cmp expect_err err
     ++'
      +
       test_expect_success 'bare repository: with --source' '
       	(

-- 
gitgitgadget
