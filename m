Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E64C33CB6
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D417321569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbUNLeJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAUPBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:01:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36998 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUPBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 10:01:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so3410502wmf.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tZO+9KVEyHSXn2PFC9ok2sObue9ehSOwTLeyoFJ/NTA=;
        b=jbUNLeJvrtkj1hrBabwP9+M4aWK/JOJWb2w+oK2hQrMIlrUOApGLZtFUTdgkphDuxC
         O2IICrO0WDR77wJBrH814B2QeYB71ccv9PgLU9bkItGVGXNxKCmuu/pJRs0tQdJrqCNK
         dAAYcq1VEQBTvQt0ckUFRG0L3Zxxmx9kjb4lBH4DKlk5+RFNEonJEHgFCIePXrTm321M
         kUYORkxbDBmLTaK2FKtSC7PmbmQTe2+U6BY7xSmM4qYw8ANbeRLd4NaxtEaDfBuTffZY
         6wtqK/nvrQydHGNoVkOIMPR8DVFTUgL3UU65un0ndr7vpyrPo85M11qsYfVyGuhrqKOg
         s10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tZO+9KVEyHSXn2PFC9ok2sObue9ehSOwTLeyoFJ/NTA=;
        b=RLBphmEQKCSLdIKLEhNJ4s5BoXibwbxPJuWN5P4wx08m0CyNvdIMy8hgX3AFwGWwgW
         /d+Q4YZZnukesfdXaQMq15kR/kKCLvJUctKwE+o9hCGUbBN1oWowJsMlSD1P5zkdjgKR
         r7Deftb27EegUzNjqD6gz5AEy3GH5TRT2jqAzWFFGpgPjIQEOcjAAThYeCid6z9Yvl0I
         FqfNjcOj/dZ4GPyvxIHw+YBgPK1kO4U2LqO7GaVowxkdfBylEX4dNZsAFXs4yEuEHFaE
         WLI234fhEHtxb+hfsDrlzV6b+gcmqDZhe3VKVlFIzbAlcw7sT6RbatgmuYmGpqGSU1Md
         PpiA==
X-Gm-Message-State: APjAAAWx4RRjLkglWbB6hnxGDzIBp20xz2rO7XqaNAxKUrztlwxJspyw
        JhQI4C8Ib6q8l397gZbdS60ujPEa
X-Google-Smtp-Source: APXvYqyi6qagpoMlf54woLBEBFnZIERNaBwzn9ndJd8GL+lpTr3jyQgG67POPWALLIqjDZTNYNSvJg==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr4718123wmg.3.1579618879087;
        Tue, 21 Jan 2020 07:01:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm4925285wma.32.2020.01.21.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:01:18 -0800 (PST)
Message-Id: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.git.1579263809.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 15:01:13 +0000
Subject: [PATCH v2 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * revert the addition of a dash in "file1 updated" by correctly using the
   'tag' argument of test_commit
 * improve the commit message for the 3rd patch, as suggested by Eric
 * fix spacing when redirecting into 'expect' and 'actual'
 * harden the tests by echoing expected values into expect, as suggested by
   Stolee (I did that in both tests)
 * remove test_might_fail and use test_expect_code
 * add the 'git log' test suggested by Stolee

v1: This series fixes the behaviour of git checkout/reset/read-tree
--recurse-submodules when they are called in a linked worktree (created by 
git worktree add). 

Although submodules are cloned in $GIT_COMMON_DIR/worktrees/<name>/modules 
upon issuing git submodule update in the linked worktree, any invocation of 
git checkout/reset/read-tree --recurse-submodules that changes the state of
the submodule(s) will incorrectly operate on the repositories of the
submodules in the main worktree, i.e. the ones at $GIT_COMMON_DIR/modules/. 

The fourth patch fixes this behaviour by using get_git_dir() instead of 
git_common_dir() in submodule.c::submodule_move_head and 
submodule.c::submodule_unset_core_worktree to construct the path to the
submodule repository.

The first 3 patches are clean-up patches on t7410-submodule-checkout-to.sh
(renamed to t2405-worktree-submodule.sh) to bring it up to date.

Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams 
bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan 
jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller 
stefanbeller@gmail.com [stefanbeller@gmail.com] Nguyễn Thái Ngọc Duy 
pclouds@gmail.com [pclouds@gmail.com] Eric Sunshine sunshine@sunshineco.com
[sunshine@sunshineco.com] Derrick Stolee stolee@gmail.com [stolee@gmail.com]

Philippe Blain (4):
  t7410: rename to t2405-worktree-submodule.sh
  t2405: use git -C and test_commit -C instead of subshells
  t2405: clarify test descriptions and simplify test
  submodule.c: use get_git_dir() instead of get_git_common_dir()

 submodule.c                      |  6 +--
 t/t2405-worktree-submodule.sh    | 90 ++++++++++++++++++++++++++++++++
 t/t7410-submodule-checkout-to.sh | 77 ---------------------------
 3 files changed, 93 insertions(+), 80 deletions(-)
 create mode 100755 t/t2405-worktree-submodule.sh
 delete mode 100755 t/t7410-submodule-checkout-to.sh


base-commit: b4615e40a8125477e18490d868f7b65954372b43
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-523%2Fphil-blain%2Fcheckout-recurse-in-linked-worktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-523/phil-blain/checkout-recurse-in-linked-worktree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/523

Range-diff vs v1:

 1:  ff33339690 = 1:  1a4eae1ef5 t7410: rename to t2405-worktree-submodule.sh
 2:  5060ce3d64 ! 2:  f06d2c4aa5 t2405: use git -C and test_commit -C instead of subshells
     @@ -41,7 +41,7 @@
      +	git init origin/main &&
      +	git -C origin/main submodule add ../sub &&
      +	git -C origin/main commit -m "add sub" &&
     -+	test_commit -C origin/sub "file1-updated" file1 file1updated &&
     ++	test_commit -C origin/sub "file1 updated" file1 file1updated file1updated &&
       	git -C origin/main/sub pull &&
      -	(
      -		cd origin/main &&
     @@ -53,30 +53,3 @@
       '
       
       test_expect_success 'setup: clone' '
     -@@
     - 
     - test_expect_failure 'can see submodule diffs just after checkout' '
     - 	git -C default_checkout/main diff --submodule master"^!" >out &&
     --	grep "file1 updated" out
     -+	grep "file1-updated" out
     - '
     - 
     - test_expect_success 'checkout main and initialize independent clones' '
     -@@
     - 
     - test_expect_success 'can see submodule diffs after independent cloning' '
     - 	git -C fully_cloned_submodule/main diff --submodule master"^!" >out &&
     --	grep "file1 updated" out
     -+	grep "file1-updated" out
     - '
     - 
     - test_expect_success 'checkout sub manually' '
     -@@
     - 
     - test_expect_success 'can see submodule diffs after manual checkout of linked submodule' '
     - 	git -C linked_submodule/main diff --submodule master"^!" >out &&
     --	grep "file1 updated" out
     -+	grep "file1-updated" out
     - '
     - 
     - test_done
 3:  6e0e664026 ! 3:  10727275a2 t2405: clarify test descriptions and simplify test
     @@ -10,7 +10,13 @@
          descriptions were not updated, keeping 'checkout' instead of using the new
          terminology (linked worktrees).
      
     -    Clarify the tests by using the right terminology. While at it, remove some unnecessary
     +    Also, in the test each worktree is created in
     +    $TRASH_DIRECTORY/<leading-directory>/main, where the name of <leading-directory>
     +    carries some information about what behavior each test verifies. This directory
     +    structure is not mandatory for the tests; the worktrees can live next to one
     +    another in the trash directory.
     +
     +    Clarify the tests by using the right terminology, and remove the unnecessary
          leading directories such that all superproject worktrees are directly next to one
          another in the trash directory.
      
     @@ -44,7 +50,7 @@
      -	git -C default_checkout/main diff --submodule master"^!" >out &&
      +test_expect_failure 'submodule is checked out just after worktree add' '
      +	git -C worktree diff --submodule master"^!" >out &&
     - 	grep "file1-updated" out
     + 	grep "file1 updated" out
       '
       
      -test_expect_success 'checkout main and initialize independent clones' '
     @@ -60,7 +66,7 @@
      -	git -C fully_cloned_submodule/main diff --submodule master"^!" >out &&
      +test_expect_success 'submodule is checked out just after submodule update in linked worktree' '
      +	git -C worktree-submodule-update diff --submodule master"^!" >out &&
     - 	grep "file1-updated" out
     + 	grep "file1 updated" out
       '
       
      -test_expect_success 'checkout sub manually' '
     @@ -76,6 +82,6 @@
      -	git -C linked_submodule/main diff --submodule master"^!" >out &&
      +test_expect_success 'submodule is checked out after manually adding submodule worktree' '
      +	git -C linked_submodule diff --submodule master"^!" >out &&
     - 	grep "file1-updated" out
     + 	grep "file1 updated" out
       '
       
 4:  72cdb2f95d ! 4:  614bccd31b submodule.c: use get_git_dir() instead of get_git_common_dir()
     @@ -24,7 +24,7 @@
          This leads to an incorrect (and confusing!) state in the submodule working tree
          of the main superproject worktree.
      
     -    Additionnally, if switching to a commit where the submodule is not present,
     +    Additionally, if switching to a commit where the submodule is not present,
          submodule_unset_core_worktree will be called and will incorrectly remove
          'core.wortree' from the config file of the submodule in the main superproject worktree,
          $GIT_COMMON_DIR/modules/<name>/config.
     @@ -75,30 +75,41 @@
      +	test_commit -C origin/main first &&
       	git -C origin/main submodule add ../sub &&
       	git -C origin/main commit -m "add sub" &&
     - 	test_commit -C origin/sub "file1-updated" file1 file1updated &&
     + 	test_commit -C origin/sub "file1 updated" file1 file1updated file1updated &&
      @@
     - 	grep "file1-updated" out
     + 	grep "file1 updated" out
       '
       
      +test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules in a linked worktree' '
      +	git -C main worktree add "$base_path/checkout-recurse" --detach  &&
      +	git -C checkout-recurse submodule update --init &&
     -+	cat checkout-recurse/sub/.git > expect-gitfile &&
     -+	git -C main/sub rev-parse HEAD > expect-head-main &&
     ++	echo "gitdir: ../../main/.git/worktrees/checkout-recurse/modules/sub" >expect-gitfile &&
     ++	cat checkout-recurse/sub/.git >actual-gitfile &&
     ++	test_cmp expect-gitfile actual-gitfile &&
     ++	git -C main/sub rev-parse HEAD >expect-head-main &&
      +	git -C checkout-recurse checkout --recurse-submodules HEAD~1 &&
     -+	cat checkout-recurse/sub/.git > actual-gitfile &&
     -+	git -C main/sub rev-parse HEAD > actual-head-main &&
     ++	cat checkout-recurse/sub/.git >actual-gitfile &&
     ++	git -C main/sub rev-parse HEAD >actual-head-main &&
      +	test_cmp expect-gitfile actual-gitfile &&
      +	test_cmp expect-head-main actual-head-main
      +'
      +
      +test_expect_success 'core.worktree is removed in $GIT_DIR/modules/<name>/config, not in $GIT_COMMON_DIR/modules/<name>/config' '
     -+	git -C main/sub config --get core.worktree > expect &&
     ++	echo "../../../sub" >expect-main &&
     ++	git -C main/sub config --get core.worktree >actual-main &&
     ++	test_cmp expect-main actual-main &&
     ++	echo "../../../../../../checkout-recurse/sub" >expect-linked &&
     ++	git -C checkout-recurse/sub config --get core.worktree >actual-linked &&
     ++	test_cmp expect-linked actual-linked &&
      +	git -C checkout-recurse checkout --recurse-submodules first &&
     -+	test_might_fail git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree > linked-config &&
     ++	test_expect_code 1 git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree >linked-config &&
      +	test_must_be_empty linked-config &&
     -+	test_might_fail git -C main/sub config --get core.worktree > actual &&
     -+	test_cmp expect actual
     ++	git -C main/sub config --get core.worktree >actual-main &&
     ++	test_cmp expect-main actual-main
     ++'
     ++
     ++test_expect_success 'unsetting core.worktree does not prevent running commands directly against the submodule repository' '
     ++	git -C main/.git/worktrees/checkout-recurse/modules/sub log
      +'
      +
       test_done

-- 
gitgitgadget
