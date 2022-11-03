Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 10:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKCKu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKCKuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 06:50:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC983DE97
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 03:50:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so3052277wma.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFafLsfJhiqEmrU2wiLKOrei2RHL41dPYxH2ZGGrT6E=;
        b=fixZTVwXdaFktO/bZOWx1IYRUuP/dojN65K+yHQLivGwqeSnqz0BoDa72OWnu9ZsLi
         dtUNHGwWEHUPst+kV8U0WAH0d+sUARUNWJQpsxsm5UQINboDgLm7NlQtBvfw9EK5vsTP
         bFLkR0i1iDXeVm8MKt/UI1GfAumCqubtaypxui/4C1bAbePFOgBRiTIEXGeZIpEU7cHY
         0R3BRMxFPvpqlt6Wf0SQnES8XaZEGHjqH3FVZUB6xgilFDJ+OLiTP+C3hTGaX77Gl8cH
         o39W0nYZjRyVt9ShgwTxZ8O3EO6GeeQCM/O+/dpElmp6vTVcIWBjhkCx1uO8s2KJdxzq
         4/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFafLsfJhiqEmrU2wiLKOrei2RHL41dPYxH2ZGGrT6E=;
        b=YUkjlZNJFrwT4v/PCchGUwSH7Hw/OUUXtshRiYif8cjBWCkFIJlJ4HIvbdnn2y0v5f
         oTdTa/GDWnDPvnNPGNWVs7ki4bytcgSuHLRw6N2RGeKLZeBwetC3QpE+e9aVRK+Y7PsX
         8fQgX1FUjH5o2P70uJUA7K7pr8XY+iNIRqQcCI6GePywprCDN6lDN7D5pzJfnmoyuEzB
         iIuT2Awka5t7M7IKRNdgSr6Y4vEo6OjVRt7YIl7uDjQffFoZPQMrWLEhSfvg+8km0anS
         RsbRPylUNW1pN/NXPlAIy0cmB6dvSj79/ajlaPmonYUDF1HDjXrWkzI3IwM6i6+U5oU2
         GDXA==
X-Gm-Message-State: ACrzQf2RuS8WK1A/TldOERLGvVP2uqljoIg2TUpZVqPYgdA9ATEDc2/d
        cS+9VO8VsVBj8WCtT6nckfiasOSnxDI=
X-Google-Smtp-Source: AMsMyM424G8Xsz95bxAwKcRvPRVBx7RoI1ctXIekjJUqm3Z8OoBxtucpDTyYASVOAMHtWZyGsGxk0g==
X-Received: by 2002:a05:600c:310c:b0:3c6:f7c6:c7b6 with SMTP id g12-20020a05600c310c00b003c6f7c6c7b6mr18609798wmo.81.1667472622740;
        Thu, 03 Nov 2022 03:50:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003c701c12a17sm5717804wmq.12.2022.11.03.03.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:50:22 -0700 (PDT)
Message-Id: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
References: <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 10:50:19 +0000
Subject: [PATCH v6 0/2] merge-tree: allow specifying a base commit when --write-tree is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for Elijah's work. I'm very excited that merge-ort is integrated into
the git merge-tree, which means that we can use merge-ort in bare
repositories to optimize merge performance.

In this patch, I introduce a new --merge-base=<commit> option to allow
callers to specify a merge-base for the merge. This may allow users to
implement git cherry-pick and git rebase in bare repositories with git
merge-tree cmd.

Changes since v1:

 * Changed merge_incore_recursive() to merge_incore_nonrecursive() when
   merge-base is specified.
 * Fixed c style problem.
 * Moved commit lookup/die logic out to the parsing logic in
   cmd_merge_tree().
 * use test_commit for test

Changes since v2:

 * commit message
 * Rebased on top of en/merge-tree-sequence.
 * Set opt.ancestor to o->merge_base. Because opt.ancestor is a *char. To
   make it easier to pass parameters, I moved
   lookup_commit_reference_by_name() to real_ merge() again.
 * Added test comment.

Changes since v3:

 * support --merge-base in conjunction with --stdin

Changes since v4:

 * commit message
 * added input format document
 * changed the input format for specifying the merge-base when --stdin is
   passed
 * changed the output when --stdin and --merge-base are used at the same
   time
 * add comment for test

Changes since v5:

 * improved test: remove the test repo after the test; avoid sub-shell.

Kyle Zhao (2):
  merge-tree.c: add --merge-base=<commit> option
  merge-tree.c: allow specifying the merge-base when --stdin is passed

 Documentation/git-merge-tree.txt | 16 ++++++++
 builtin/merge-tree.c             | 65 ++++++++++++++++++++++++++------
 t/t4301-merge-tree-write-tree.sh | 61 ++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 12 deletions(-)


base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v5:

 1:  01df0d1a6a7 ! 1:  1cf1c69b8e8 merge-tree.c: add --merge-base=<commit> option
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--stdin with both a succe
      +
      +test_expect_success 'specify merge-base as parent of branch2' '
      +	# Setup
     -+	git init base-b2-p && (
     -+		cd base-b2-p &&
     -+		test_commit c1 file1 &&
     -+		test_commit c2 file2 &&
     -+		test_commit c3 file3
     -+	) &&
     ++	test_when_finished "rm -rf base-b2-p" &&
     ++	git init base-b2-p &&
     ++	test_commit -C base-b2-p c1 file1 &&
     ++	test_commit -C base-b2-p c2 file2 &&
     ++	test_commit -C base-b2-p c3 file3 &&
     ++
      +	# Testing
     -+	(
     -+		cd base-b2-p &&
     -+		TREE_OID=$(git merge-tree --write-tree --merge-base=c2 c1 c3) &&
     ++	TREE_OID=$(git -C base-b2-p merge-tree --write-tree --merge-base=c2 c1 c3) &&
      +
     -+		q_to_tab <<-EOF >expect &&
     -+		100644 blob $(git rev-parse c1:file1)Qfile1
     -+		100644 blob $(git rev-parse c3:file3)Qfile3
     -+		EOF
     ++	q_to_tab <<-EOF >expect &&
     ++	100644 blob $(git -C base-b2-p rev-parse c1:file1)Qfile1
     ++	100644 blob $(git -C base-b2-p rev-parse c3:file3)Qfile3
     ++	EOF
      +
     -+		git ls-tree $TREE_OID >actual &&
     -+		test_cmp expect actual
     -+	)
     ++	git -C base-b2-p ls-tree $TREE_OID >actual &&
     ++	test_cmp expect actual
      +'
      +
       test_done
 2:  3bdfad03cca ! 2:  40d56544e6e merge-tree.c: allow specifying the merge-base when --stdin is passed
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--stdin with both a succe
       # git merge-tree --write-tree --merge-base=c2 c1 c3
       #   Commit c1: add file1
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'specify merge-base as parent of branch2' '
     - 	)
     + 	test_cmp expect actual
       '
       
      +# Since the earlier tests have verified that individual merge-tree calls
      +# are doing the right thing, this test case is only used to test whether
      +# the input format is available.
      +
     -+test_expect_success '--stdin with both a normal merge and a merge-base specified merge' '
     -+	cd base-b2-p &&
     -+	printf "c1 c3\nc2 -- c1 c3" | git merge-tree --stdin >actual &&
     ++test_expect_success 'check the input format when --stdin is passed' '
     ++	test_when_finished "rm -rf repo" &&
     ++	git init repo &&
     ++	test_commit -C repo c1 &&
     ++	test_commit -C repo c2 &&
     ++	test_commit -C repo c3 &&
     ++	printf "c1 c3\nc2 -- c1 c3\nc2 c3" | git -C repo merge-tree --stdin >actual &&
      +
      +	printf "1\0" >expect &&
     -+	git merge-tree --write-tree -z c1 c3 >>expect &&
     ++	git -C repo merge-tree --write-tree -z c1 c3 >>expect &&
      +	printf "\0" >>expect &&
      +
      +	printf "1\0" >>expect &&
     -+	git merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
     ++	git -C repo merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
      +	printf "\0" >>expect &&
     ++
     ++	printf "1\0" >>expect &&
     ++	git -C repo merge-tree --write-tree -z c2 c3 >>expect &&
     ++	printf "\0" >>expect &&
     ++
      +	test_cmp expect actual
      +'
      +

-- 
gitgitgadget
