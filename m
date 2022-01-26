Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB51C433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiAZV5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiAZV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:57:32 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:57:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a12-20020a056a001d0c00b004cc283b2e30so417683pfx.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ibolrxbzAwa/nHwXU6rIdf77TaISg+IXHQ4un6GrInA=;
        b=QDHVF0NDrh0XoP/G9j4ohCIqys0GDwzQE8qcfmCOZYwRLwoPoFPeXbc4HE0WEF7+t6
         hIln3QRkxVJwZFWbFzslWWLpNgweFNuCzgXM1Y/kY3WrKdrfbRP8HcrNSWxMEOUJY1fx
         ynt/0xKGwtZYhO/nGNMeaWGex4XBbf1j4r/y0iZIaFiChuC8uQEDjnFaRl8OmdsgeiDc
         cEcUxqyG4blSbgvBql+MW395FLSiD1AhlXCLSnkSog9qFLUv16uSEIiHL75ow9qoy9xI
         Xw5JbP5fOtb1tXjp8J15RZCwoEXomdMc/xYclZKZ2sxbis25w+XV6ysNv4g5XGFDZHbu
         U4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ibolrxbzAwa/nHwXU6rIdf77TaISg+IXHQ4un6GrInA=;
        b=carjlRO+9es+PXAd18gAIGEDNSSMbgH+BGUULohoOL9iAxQtW709Q/B4LriidKc1Tb
         gSElex/Jw54L1R8ybmer8iVe8epiLhnvIlYEz4PWMWEUM2lUp09w7wtLwSAKa4VlIh67
         JZg7kiaVxvO+5mWr15cnIGWWaI6af8uLTi9LgO4IeZFW3t1sQPZkXH9vy3ns7S79NeXf
         JYq3mXTANTbWb2vo0rDNeo5NxS5knbTQ979DN6AaZkFXF2+1WQBJI7CC6/ajRMsVQsqf
         f6rWnRxM8uEQmqbUC/6uvs/LsYw9hSYsgYnenoXZp7C7JGe+rB7ku8JJI96o57Ftx/54
         yL/w==
X-Gm-Message-State: AOAM531+YuHpnzTpNeFTx7etDvn9Gxa2A/QCZGuYjHlt0FERFbgVw1p/
        T3giwtyFD8gEviYG2oXgXAaKeHjfCgfCzw==
X-Google-Smtp-Source: ABdhPJzyfcDhXr6vd2ee1MeqSvUuKzw1E4X8lQExpzM4+jkFB5q7Arx9Bky20rL4j44L0TikO6ReXuTmN2HPSg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7c17:: with SMTP id
 x23mr938906pll.123.1643234251777; Wed, 26 Jan 2022 13:57:31 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:57:29 -0800
In-Reply-To: <2a50d67e-364b-5927-801b-00f38179e904@gmail.com>
Message-Id: <kl6lwnimyxbq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <2a50d67e-364b-5927-801b-00f38179e904@gmail.com>
Subject: Re: git worktree, submodule and force checkout/switch
From:   Glen Choo <chooglen@google.com>
To:     Federico Kircheis <federico.kircheis@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Federico Kircheis <federico.kircheis@gmail.com> writes:

> Hello to everyone,
>
> I would like to report what I believe is a bug, or at least an 
> inconsistent behavior when using submodules and worktrees.
>
>
> Consider following test-case
>
> ----
> # create 2 repositories with one commit
> mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1")
> mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2")
>
> # add submodule, a couple of branches, and a worktree
> cd repo1
> git submodule add ../repo2 && git commit -m "add submodule"
> git switch -c branch1
> git switch -c branch2
> git worktree add ../repo1.w --detach
>
>
> # test switch in the worktree
> cd ../repo1.w
> # git switch works
> git switch --recurse-submodule branch1
> git switch --recurse-submodule master
> #git submodule update # (1)
> cat .git
> cat .gitmodules
> cat repo2/.git # (2)
> git switch --force branch1 # (3)error if no submodule update
> ----
>
>
> Notice that if one forgets to git submodule update (1) before git switch 
> --force branch1, even when using --recurse-submodule, there is no 
> submodule, as repo1.w/repo2/ is empty (2).
>
> It is confusing/unexpected that git switch --force fails and creates a 
> repo1.w/repo2/.git file pointing to the wrong location.
>
>
> As comparison, when cloning a repository and forgetting to do "git 
> submodule update", then "git switch --force branch1" works as expected:
>
>
>
> ----
> # create 2 repositories with one commit
> mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1")
> mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2")
>
> cd repo1
> git submodule add ../repo2 && git commit -m "add submodule"
> git switch -c branch1
> git switch -c branch2
>
> cd ..
> git clone repo1 repo1.c
> cd repo1.c
> git switch branch2
> git switch --force branch1 # works, event without git submodule update
> ----
>
>
>
>
> Notice:
> In both cases "git switch" and "git checkout" behave the same.
> Also the parameter "--recurse-submodule" does not change anything.
>
>
> Best
>
> Federico
>
>
> PS: I'm not subscribed to the mailing list (yet), so please keep me in CC.

Thanks for the report! This is very cosmetically similar to another bug
that Elijah (cc-ed) sent a patch for [1]. However, in my testing, the
test case doesn't even pass in v2.34.0, which doesn't have en/keep-cwd
(which is the branch that introduced the motivation for [1]).

So despite the unfortunate timing, I am inclined to think that this is a
longstanding issue with worktrees and submodules (and not a recent
regression in 2.35). I'm sending this out quickly just to say that it's
not a regression, and I might take a closer look when I have time.

This is the test case I used:

  test_expect_success 'bugreport' '
    # create 2 repositories with one commit
    mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1") &&
    mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2") &&

    # add submodule, a couple of branches, and a worktree
    cd repo1 &&
    git submodule add ../repo2 && git commit -m "add submodule" &&
    git switch -c branch1 &&
    git switch -c branch2 &&
    git worktree add ../repo1.w --detach &&

    # test switch in the worktree
    cd ../repo1.w &&
    # git switch works
    git switch --recurse-submodules branch1 &&
    git switch --recurse-submodules main &&
    cat .git &&
    cat .gitmodules &&
    cat repo2/.git &&
    git switch --force branch1
  '

[1] https://lore.kernel.org/git/pull.1205.git.git.1643161426138.gitgitgadget@gmail.com
