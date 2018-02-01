Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709871F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBAXsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:48:18 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34782 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBAXsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:48:16 -0500
Received: by mail-wr0-f193.google.com with SMTP id z6so189138wrb.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GjfqtrRl1Now2DkKpR26nYqCeqYKB/wlN+uv7EOZh8=;
        b=On1GzUoxNb1YLbQkcanvvgkjfPxhRomM9wQS0eYCwiAxFMuO5PutLbRX0vo4FgHwLo
         1Rl9HZA/1JUgSbep2fW43Yf4D6WMfh4zPwZ+HnZftVFciFXzWMMF81Td3ov/1x0vznl9
         1X8O5CbTIa3rpYuxYVHYymVFdtluNgUNDdzIFZeYiTgfaYVSZGZQ1/VUUI7h7PkRR6az
         fgr3zjaG5G034eKgzRvkDVxLHsDK+M03wm2s7pSbVJCKmP00eDqvxW+6gWgHuBRLpp/2
         UViUPx2ibyMZzye3nDoibCKTMWo55scG7mxRj2YG91nQH7EV8vPC0mhiTnjwe85PBOw7
         jBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GjfqtrRl1Now2DkKpR26nYqCeqYKB/wlN+uv7EOZh8=;
        b=m8UWJt6wpBcFEAQDQdM9mBKnyQ239qSJycdnhvAU466gC75+1NrbCa6PL0Qi8tHQ+8
         wp9g6rNhuY/Mc+t6rXRP4d3sTF9yVYZUNuklGXJe2xDjiDkY8V950Z/2WvF/mTD4/LpB
         OhXXi4yJU9sKFpAgQGcWLo4hUL01c3AV/pQx6LooA/U8iTCwBGAguh2spHU7hi3IPopK
         oDoFutJwTNs6xwrNYyzeTws7ho2h7k8dAIvr3k/0igqp4L/5wyV5uEpe7Hdc2zfw3UR8
         +1k04LaI6bnvnXjMjbB2y+15HUL1qzBKCPcZVaetGGZsORdXYweAEv4IHEc8GGpMF7l6
         VKnQ==
X-Gm-Message-State: AKwxytcAPdB+7W9mK8mwlWSFWvkgF5Jv7tN9iXEyTdvAq2uzZlTIyfcS
        9ttWU1loJXLgL1AwUFAv0co=
X-Google-Smtp-Source: AH8x227h65ooXjS0k7MYLvc6a2naXWGmi8EarXH54nUCEVcGUrwNmX+zTw1WXwpVKTB1FW+8TauKxg==
X-Received: by 10.223.170.142 with SMTP id h14mr3227357wrc.26.1517528895597;
        Thu, 01 Feb 2018 15:48:15 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id 2sm459815wra.58.2018.02.01.15.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 15:48:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
Date:   Fri,  2 Feb 2018 00:48:05 +0100
Message-Id: <20180201234805.7506-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach git-commit-graph to write graph files. Create new test script to verify
> this command succeeds without failure.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 18 +++++++
>  builtin/commit-graph.c             | 30 ++++++++++++
>  t/t5318-commit-graph.sh            | 96 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100755 t/t5318-commit-graph.sh
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index c8ea548dfb..3f3790d9a8 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -5,3 +5,21 @@ NAME
>  ----
>  git-commit-graph - Write and verify Git commit graphs (.graph files)
>  
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git commit-graph' --write <options> [--pack-dir <pack_dir>]
> +

What do these options do and what is the command's output?  IOW, an
'OPTIONS' section would be nice.

> +EXAMPLES
> +--------
> +
> +* Write a commit graph file for the packed commits in your local .git folder.
> ++
> +------------------------------------------------
> +$ git commit-graph --write
> +------------------------------------------------
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> new file mode 100755
> index 0000000000..6bcd1cc264
> --- /dev/null
> +++ b/t/t5318-commit-graph.sh
> @@ -0,0 +1,96 @@
> +#!/bin/sh
> +
> +test_description='commit graph'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup full repo' \
> +    'rm -rf .git &&
> +     mkdir full &&
> +     cd full &&
> +     git init &&
> +     git config core.commitgraph true &&
> +     git config pack.threads 1 &&

Does this pack.threads=1 make a difference?

> +     packdir=".git/objects/pack"'

We tend to put single quotes around tests like this:

  test_expect_success 'setup full repo' '
        do-this &&
        check-that
  '

This is not a mere style nit: those newlines before and after the test
block make the test's output with '--verbose-log' slightly more
readable.

Furthermore, we prefer tabs for indentation.

Finally, 'cd'-ing around such that it affects subsequent tests is
usually frowned upon.  However, in this particular case (going into
one repo, doing a bunch of tests there, then going into another repo,
and doing another bunch of tests) I think it's better than changing
directory in a subshell in every single test.

> +
> +test_expect_success 'write graph with no packs' \
> +    'git commit-graph --write --pack-dir .'
> +
> +test_expect_success 'create commits and repack' \
> +    'for i in $(test_seq 5)
> +     do
> +        echo $i >$i.txt &&
> +        git add $i.txt &&
> +        git commit -m "commit $i" &&
> +        git branch commits/$i
> +     done &&
> +     git repack'
> +
> +test_expect_success 'write graph' \
> +    'graph1=$(git commit-graph --write) &&
> +     test_path_is_file ${packdir}/graph-${graph1}.graph'

Style nit:  those {} around the variable names are unnecessary, but I
see you use them a lot.

> +
> +t_expect_success 'Add more commits' \

This must be test_expect_success.

> +    'git reset --hard commits/3 &&
> +     for i in $(test_seq 6 10)
> +     do
> +        echo $i >$i.txt &&
> +        git add $i.txt &&
> +        git commit -m "commit $i" &&
> +        git branch commits/$i
> +     done &&
> +     git reset --hard commits/3 &&
> +     for i in $(test_seq 11 15)
> +     do
> +        echo $i >$i.txt &&
> +        git add $i.txt &&
> +        git commit -m "commit $i" &&
> +        git branch commits/$i
> +     done &&
> +     git reset --hard commits/7 &&
> +     git merge commits/11 &&
> +     git branch merge/1 &&
> +     git reset --hard commits/8 &&
> +     git merge commits/12 &&
> +     git branch merge/2 &&
> +     git reset --hard commits/5 &&
> +     git merge commits/10 commits/15 &&
> +     git branch merge/3 &&
> +     git repack'
> +
> +# Current graph structure:
> +#
> +#      M3
> +#     / |\_____
> +#    / 10      15
> +#   /   |      |
> +#  /    9 M2   14
> +# |     |/  \  |
> +# |     8 M1 | 13
> +# |     |/ | \_|
> +# 5     7  |   12
> +# |     |   \__|
> +# 4     6      11
> +# |____/______/
> +# 3
> +# |
> +# 2
> +# |
> +# 1
> +
> +test_expect_success 'write graph with merges' \
> +    'graph2=$(git commit-graph --write) &&
> +     test_path_is_file ${packdir}/graph-${graph2}.graph'
> +
> +test_expect_success 'setup bare repo' \
> +    'cd .. &&
> +     git clone --bare full bare &&
> +     cd bare &&
> +     git config core.graph true &&
> +     git config pack.threads 1 &&
> +     baredir="objects/pack"'
> +
> +test_expect_success 'write graph in bare repo' \
> +    'graphbare=$(git commit-graph --write) &&
> +     test_path_is_file ${baredir}/graph-${graphbare}.graph'
> +
> +test_done
> -- 
> 2.16.0.15.g9c3cf44.dirty


