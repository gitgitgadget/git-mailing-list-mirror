Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B57E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbjJHQUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbjJHQUD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 12:20:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630ADA4
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 09:20:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31f71b25a99so3761557f8f.2
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696781999; x=1697386799; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0YF2QJCzIRB4JK/taSDMdNC9zMZRuq+hXUA41kxk4Q=;
        b=jxzNeGXVnh/n6999hyDLR4cu6e+6BWcHGWS+lkfNNFzzI0IiuZksF7sHADOaBpWuqz
         gVZ30/6xxtXQo3r5dRdcp9hUDxOyWaS6GRetTOK3sS+bOfLStMlyYPWVjBwlY8aphFge
         rfqSjGAQZX/9Wy+aGr0gQW0jnZqSjkTKd+RhUKO5OFq4dX2VUABHSe3AIPOrHMric1uk
         wfUV4XgVBXR2w0hzjEwj6QvafOm6iMiJe0FVtAjQcWUBhtO47JFgOnW9uxwevIJP7ut0
         2QDyYZcpBoIZ5N4h2SxTpMQU9klucirFJPoJNQYXIT0bISRonOIY7ggBD8mjIjRfalLk
         762Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696781999; x=1697386799;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0YF2QJCzIRB4JK/taSDMdNC9zMZRuq+hXUA41kxk4Q=;
        b=h44mvqOjRsHoKDgkZnQFKOnautsHWVRQNpI0svJGGNVaCM5LhI2u9AkKs9sQXMrkv3
         fEmVT0MpJVfF5aUG0X8ONH+RBWC/3DMCmyj0xwfUl4JxccWJcO1eyxB55uJD5M6E2ejS
         rd6GoyqIERfFpfP/dVj8KXkceTPlIRZVEyJV3PxxFlQ9+uC3GguHAu22p7X5+vEIDHZr
         n5i36inC+zjaEQcQCQ3VQdeHIFeTwkXKrqBeeOKyZGcz1c210INlMquseFvll/wx9a0S
         kKzHgwSBbpCR+CuBypPsVfHGq/Sb6nCSx6yE76L4I895kcYocc1wvrs5VzYdvLVKbUKk
         ULXw==
X-Gm-Message-State: AOJu0Yxihji5MjSQubI2LOyb4eZg3tQEVZIFQo0/M3phdxqnRFZ8K8Oe
        9v1sJ31fWNmVcwvs9Qgn6kSv2QOnWZ0=
X-Google-Smtp-Source: AGHT+IFdiJiJJcpCc3FTd6qFlUFrvMqg9nHunv+s4rhFMA56n3gJf+9Dq42f3voLbZxUERk8QB3cEg==
X-Received: by 2002:adf:e6c5:0:b0:31d:3669:1c55 with SMTP id y5-20020adfe6c5000000b0031d36691c55mr11278677wrm.65.1696781999568;
        Sun, 08 Oct 2023 09:19:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a056000110300b0031c6581d55esm7113220wrw.91.2023.10.08.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 09:19:59 -0700 (PDT)
Message-ID: <pull.1583.v2.git.git.1696781998420.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
References: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 16:19:58 +0000
Subject: [PATCH v2] merge-ort: initialize repo in index state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

initialize_attr_index() does not initialize the repo member of
attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=<tree>"
global option to "git", 2023-05-06), this became a problem because
istate->repo gets passed down the call chain starting in
git_check_attr(). This gets passed all the way down to
replace_refs_enabled(), which segfaults when accessing r->gitdir.

Fix this by initializing the repository in the index state.

Signed-off-by: John Cai <johncai86@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
---
    merge-ort: initialize repo in index state
    
    initialize_attr_index() does not initialize the repo member of
    attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=" global
    option to "git", 2023-05-06), this became a problem because istate->repo
    gets passed down the call chain starting in git_check_attr(). This gets
    passed all the way down to replace_refs_enabled(), which segfaults when
    accessing r->gitdir.
    
    Fix this by initializing the repository in the index state.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1583%2Fjohn-cai%2Fjc%2Fpopulate-repo-when-init-attr-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1583/john-cai/jc/populate-repo-when-init-attr-index-v2
Pull-Request: https://github.com/git/git/pull/1583

Range-diff vs v1:

 1:  80a18252b30 ! 1:  e178236064a merge-ort: initialize repo in index state
     @@ merge-ort.c: static void initialize_attr_index(struct merge_options *opt)
       	struct index_state *attr_index = &opt->priv->attr_index;
       	struct cache_entry *ce;
       
     -+	attr_index->repo = the_repository;
     ++	attr_index->repo = opt->repo;
       	attr_index->initialized = 1;
       
       	if (!opt->renormalize)
     @@ t/t4300-merge-tree.sh: EXPECTED
      +		test_commit initial file1 foo &&
      +		base=$(git rev-parse HEAD) &&
      +		git checkout -b brancha &&
     -+		echo bar>>file1 &&
     ++		echo bar >>file1 &&
      +		git commit -am "adding bar" &&
      +		source=$(git rev-parse HEAD) &&
     -+		echo baz>>file1 &&
     ++		git checkout @{-1} &&
     ++		git checkout -b branchb &&
     ++		echo baz >>file1 &&
      +		git commit -am "adding baz" &&
      +		merge=$(git rev-parse HEAD) &&
     -+		test_must_fail git --attr-source=HEAD merge-tree -z --write-tree \
     -+		--merge-base "$base" --end-of-options "$source" "$merge" >out &&
     -+		grep "Merge conflict in file1" out
     ++		git checkout -b gitattributes &&
     ++		test_commit "gitattributes" .gitattributes "file1 merge=union" &&
     ++		git checkout @{-1} &&
     ++		tree=$(git --attr-source=gitattributes merge-tree --write-tree \
     ++		--merge-base "$base" --end-of-options "$source" "$merge") &&
     ++		echo "foo\nbar\nbaz" >expect &&
     ++		git cat-file -p "$tree:file1" >actual &&
     ++		test_cmp expect actual
      +	)
      +'
      +


 merge-ort.c           |  1 +
 t/t4300-merge-tree.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 7857ce9fbd1..36537256613 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_options *opt)
 	struct index_state *attr_index = &opt->priv->attr_index;
 	struct cache_entry *ce;
 
+	attr_index->repo = opt->repo;
 	attr_index->initialized = 1;
 
 	if (!opt->renormalize)
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 57c4f26e461..2929ce3bf16 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -86,6 +86,33 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_success '3-way merge with --attr-source' '
+	test_when_finished rm -rf 3-way &&
+	git init 3-way &&
+	(
+		cd 3-way &&
+		test_commit initial file1 foo &&
+		base=$(git rev-parse HEAD) &&
+		git checkout -b brancha &&
+		echo bar >>file1 &&
+		git commit -am "adding bar" &&
+		source=$(git rev-parse HEAD) &&
+		git checkout @{-1} &&
+		git checkout -b branchb &&
+		echo baz >>file1 &&
+		git commit -am "adding baz" &&
+		merge=$(git rev-parse HEAD) &&
+		git checkout -b gitattributes &&
+		test_commit "gitattributes" .gitattributes "file1 merge=union" &&
+		git checkout @{-1} &&
+		tree=$(git --attr-source=gitattributes merge-tree --write-tree \
+		--merge-base "$base" --end-of-options "$source" "$merge") &&
+		echo "foo\nbar\nbaz" >expect &&
+		git cat-file -p "$tree:file1" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'file change A, B (same)' '
 	git reset --hard initial &&
 	test_commit "change-a-b-same-A" "initial-file" "AAA" &&

base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
-- 
gitgitgadget
