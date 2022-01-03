Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A8DC433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 14:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiACOrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 09:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiACOro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 09:47:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B5BC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 06:47:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o3so12159920wrh.10
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ef2RR/la/JXkj8HnOg+2L5lYsIvGvAbs12/h036BiHo=;
        b=iS3pCEQoWDTpG7MyiiCTW9dj3t/T+JCgocsTv8AbhrHKzogyV4wpoo9ZZgH1v27RAH
         eFpEfiJP69ydorSELbVQ2RcpHa10QX9LnLuvkC0exVZ7ERGd7zU7Yi1+qGd9yK5emYu2
         d4A1Gd0HUBOlQjyDW8mdygFFccyTk7X13hcAGWQCp3TlpIM+A83tYOdjxHRk8vxRMdAh
         B9SMdPvliX2ixLQns5wAROjQfUvirvAFKKeK3R1nIveAtONss0yxinSusQ/tVTRn2nZ6
         Xvi+pyET8vbtU9V/704sqKryVYWNfD4AfDkQNlgwOomKSMmBcfiP6LTLS8jcWvcUK357
         ifHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ef2RR/la/JXkj8HnOg+2L5lYsIvGvAbs12/h036BiHo=;
        b=5iDAaN9EmrHIW0SPPREpgS+uioO12rpWA2HHUy5i53oKaoQ7VfbfyHDYabJYWZ0kHa
         EglkfkTCDJ48ZfTL/QgykAJlSu1dl4KUHxCNYaLvXxuQz5ubJii/BlqAAXxDThoZXmZc
         lu4k6zX7OR7dIepIv08RyusVwI1aV0DbB+E9tnN29dp4mAH2tazp8l8gG85u60fdS5RI
         3vtH/Glp1WPLCCMd5BXzhxJNuDfZ29LZ5CCguW3MYU8C0Dre0v6o8HvOODe1cjxAScb8
         HvHdh+zZWVtLOrL0cm+CusEL7n9BmtWCxxrMzwQjerBF9O9z0em8GjyCjj1/Gi3GzaIC
         zbLw==
X-Gm-Message-State: AOAM531DGyuGDoooeQsZEoxHcx/DGm8kQQhRal7XRGBxtPQFt0Ukve/p
        ilx5OSxszFjO/Q56+L8NZwlx+jz8jzY=
X-Google-Smtp-Source: ABdhPJzwux79/H2+4lAziPG+Ctz3S8eyEUT+Orvvyl3VL8bluwAqGqPrRbjRpdPrJqAsJeywax0olw==
X-Received: by 2002:a5d:660e:: with SMTP id n14mr38876684wru.613.1641221262216;
        Mon, 03 Jan 2022 06:47:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm35232743wrv.95.2022.01.03.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 06:47:41 -0800 (PST)
Message-Id: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 14:47:39 +0000
Subject: [PATCH v3 0/2] name-rev: deprecate --stdin in favor of --annotate-stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a --annotate-stdin that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can be a
confusing and misleading name, the goal is to rename it to --anotate-stdin.

This is the first step in a process of eventually fully deprecating --stdin.
This change also adds a warning to --stdin warning that it will be removed
in the future.

See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for discussion.

changes since v2:

 * updated title and cover letter with --annotate-stdin
 * s/--stdin/--annotate-stdin in tests that call name-rev
 * added a test to ensure correct warning is shown when --stdin is passed

John Cai (2):
  name-rev: deprecate --stdin in favor of --annotate-text
  name-rev.c: use strbuf_getline instead of limited size buffer

 Documentation/git-name-rev.txt       | 29 +++++++++++++++++++++++++++-
 builtin/name-rev.c                   | 27 ++++++++++++++++----------
 t/t3412-rebase-root.sh               |  2 +-
 t/t4202-log.sh                       |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++-------------
 t/t6012-rev-list-simplify.sh         |  2 +-
 t/t6111-rev-list-treesame.sh         |  3 ++-
 t/t6120-describe.sh                  |  9 +++++++--
 8 files changed, 70 insertions(+), 30 deletions(-)


base-commit: c8b2ade48c204690119936ada89cd938c476c5c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v3
Pull-Request: https://github.com/git/git/pull/1171

Range-diff vs v2:

 1:  e8063284b4d ! 1:  55ec2a5fa3e name-rev: deprecate --stdin in favor of --annotate-text
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
       
       		while (!feof(stdin)) {
       			char *p = fgets(buffer, sizeof(buffer), stdin);
     +
     + ## t/t3412-rebase-root.sh ##
     +@@ t/t3412-rebase-root.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + log_with_names () {
     + 	git rev-list --topo-order --parents --pretty="tformat:%s" HEAD |
     +-	git name-rev --stdin --name-only --refs=refs/heads/$1
     ++	git name-rev --annotate-stdin --name-only --refs=refs/heads/$1
     + }
     + 
     + 
     +
     + ## t/t4202-log.sh ##
     +@@ t/t4202-log.sh: EOF
     + 
     + test_expect_success 'log --graph with full output' '
     + 	git log --graph --date-order --pretty=short |
     +-		git name-rev --name-only --stdin |
     ++		git name-rev --name-only --annotate-stdin |
     + 		sed "s/Merge:.*/Merge: A B/;s/ *\$//" >actual &&
     + 	test_cmp expect actual
     + '
     +
     + ## t/t6007-rev-list-cherry-pick-file.sh ##
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--left-right' '
     + 	git rev-list --left-right B...C > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--cherry-pick bar does not come up empty' '
     + 	git rev-list --left-right --cherry-pick B...C -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     + 
     + test_expect_success 'bar does not come up empty' '
     + 	git rev-list --left-right B...C -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--cherry-pick bar does not come up empty (II)' '
     + 	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     + 
     + test_expect_success 'name-rev multiple --refs combine inclusive' '
     + 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/F" --refs="*tags/E" \
     + 		<actual >actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + test_expect_success 'name-rev --refs excludes non-matched patterns' '
     + 	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
     + 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/F" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/F" \
     + 		<actual >actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + test_expect_success 'name-rev --exclude excludes matched patterns' '
     + 	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
     + 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" --exclude="*E" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" --exclude="*E" \
     + 		<actual >actual.named &&
     + 	test_cmp expect actual.named
     + '
     + 
     + test_expect_success 'name-rev --no-refs clears the refs list' '
     + 	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
     +-	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
     + 		<expect >actual &&
     + 	test_cmp expect actual
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--cherry-mark' '
     + 	git rev-list --cherry-mark F...E -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--cherry-mark --left-right' '
     + 	git rev-list --cherry-mark --left-right F...E -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--cherry-pick --right-only' '
     + 	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     + 
     + test_expect_success '--cherry-pick --left-only' '
     + 	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     +@@ t/t6007-rev-list-cherry-pick-file.sh: EOF
     + 
     + test_expect_success '--cherry' '
     + 	git rev-list --cherry F...E -- bar > actual &&
     +-	git name-rev --stdin --name-only --refs="*tags/*" \
     ++	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
     + 		< actual > actual.named &&
     + 	test_cmp expect actual.named
     + '
     +
     + ## t/t6012-rev-list-simplify.sh ##
     +@@ t/t6012-rev-list-simplify.sh: note () {
     + }
     + 
     + unnote () {
     +-	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
     ++	git name-rev --tags --annotate-stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
     + }
     + 
     + #
     +
     + ## t/t6111-rev-list-treesame.sh ##
     +@@ t/t6111-rev-list-treesame.sh: note () {
     + }
     + 
     + unnote () {
     +-	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
     ++	git name-rev --tags --annotate-stdin | \
     ++	sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
     + }
     + 
     + test_expect_success setup '
     +
     + ## t/t6120-describe.sh ##
     +@@ t/t6120-describe.sh: test_expect_success 'name-rev --all' '
     + 	test_cmp expect actual
     + '
     + 
     +-test_expect_success 'name-rev --stdin' '
     ++test_expect_success 'name-rev --annotate-stdin' '
     + 	>expect.unsorted &&
     + 	for rev in $(git rev-list --all)
     + 	do
     +@@ t/t6120-describe.sh: test_expect_success 'name-rev --stdin' '
     + 		echo "$rev ($name)" >>expect.unsorted || return 1
     + 	done &&
     + 	sort <expect.unsorted >expect &&
     +-	git rev-list --all | git name-rev --stdin >actual.unsorted &&
     ++	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &&
     + 	sort <actual.unsorted >actual &&
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'name-rev --stdin deprecated' "
     ++	git rev-list --all | git name-rev --stdin 2>actual &&
     ++	grep -E 'warning: --stdin is deprecated' actual
     ++"
     ++
     + test_expect_success 'describe --contains with the exact tags' '
     + 	echo "A^0" >expect &&
     + 	tag_object=$(git rev-parse refs/tags/A) &&
 2:  4636e27f53e = 2:  e4bd09ccf75 name-rev.c: use strbuf_getline instead of limited size buffer

-- 
gitgitgadget
