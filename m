Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CEFECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 17:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJaRHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJaRHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 13:07:17 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9D12AF0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 10:07:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v1-20020aa78081000000b005636d8a1947so5960399pff.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6C/maCL8zSC+KzPjli+3Q15e2JGdgkdEPQ9Di3oVdY=;
        b=iMRZBab9eoAe9wm0LwEG0Iw8BXipO8vMOJf4qfQRcAy8U8ymAu1pbXYIZbKZ4ZYQgY
         eP10gVSSkgB+lmPFmzRv3SnIMN+C1LV8NzufBNXcjqS1jXP4OYvOd3stUDP6sXh4xMXh
         TsfQPqwaxwWXeO6PuG+bitj6XWXT8zwzO2KhFLZjz6qcbMxiRMApNQL/KoapWajZsnWN
         50yhjcJpsl7sZoc0vu6+n7u+xpa4gGxC+SUQaIsRavPEt1X8AEgQLnvTrbdYepB1WiuX
         T5h/khYTy8DfRIKFNAQdbjSQvHGn+LHZBGHO7gVDV8IOYlare+pDQ0N/NK5HC+yddU8p
         2vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6C/maCL8zSC+KzPjli+3Q15e2JGdgkdEPQ9Di3oVdY=;
        b=cl2de7wTnu6rBZPdgPZELQqyCBX9Lo1yxHT7Y7vNiriBMo32Ahgl7UhF3luAZ1XoAM
         CE7zVNhszw2UFXr+h0BpJlXPA36LAUUcnO48zJ28HvNQfy+eqh9PqCQqN0EwjSAXvLU/
         FZzcVyQ5YvKB2hHSbiwb5pJ9soUBewOnYO0JwJhhFaanGGsi8WwVNFxmFZbeIm8mAqVB
         UzB4fTyhFcB7dA1dnkvQQLRsbg0kUsgLMbJAmQiwymmZ5vJPAHq98lvkaur6Ca+LPF4N
         BNISULd30WC9bkzAaVFmGqWlBE1FM7ONq0Azj+7lqnhdvxubMuy5enxK9myJ8i4ALU0M
         W8VQ==
X-Gm-Message-State: ACrzQf0JJgZGbzNjNeKjGP3qK+YNYTJJof5m+1w0JgLckHb/OwoZmHKl
        sh54+qIX6O6sfJERjQltfxgCJ2WpCxy20g==
X-Google-Smtp-Source: AMsMyM4Xyi6/93617vivDQv8Azfzjikvh/TJCQ0Geh6L7Be9psTXmxkQJwgK3pMY3wuPYF3IWDUKmo6H4ltBPQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:6404:0:b0:46f:a711:c481 with SMTP id
 a4-20020a656404000000b0046fa711c481mr8362937pgv.262.1667236034198; Mon, 31
 Oct 2022 10:07:14 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:07:12 -0700
In-Reply-To: <Y16/AMeVYgERJuj6@nand.local>
Mime-Version: 1.0
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com> <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
 <xmqqmt9fhbjt.fsf@gitster.g> <xmqq7d0jhaw6.fsf@gitster.g> <kl6lbkpvd0de.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y16/AMeVYgERJuj6@nand.local>
Message-ID: <kl6l5yfzdirj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 1/8] clone: teach --detach option
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Oct 28, 2022 at 03:55:25PM -0700, Glen Choo wrote:
>> So a better way forward is to add the new flag, which I imagine might
>> be useful to certain end users.
>
> Disappointing, though I understand why such a new flag was needed. Do we
> really care about whether or not the branch exists so long as we are
> detached from it, though?

Yes.

- With submodule branching, the "main" branch should correspond to the
  gitlink of the superproject's "main" branch. So when we clone, we
  can't _already_ have a "main" branch coming from the submodule's
  remote.
- Without submodule branching, submodules are always in detached HEAD
  (e.g. when updating the worktree recursively) and no submodule
  recursing functions create branches, _except_ "git clone
  --recurse-submodules" (which as we've seen, may create the branch
  corresponding to the submodule's remote). This just looks like an
  oversight IMO, which is why I noted that even without branching, "git
  clone --recurse-submodules" should probably also use "--detach" [1].
- Outside of submodules, I can imagine there's at least one person who's
  performed a clone and then "git branch -D master" (maybe followed by
  "git checkout -b main"), and "git clone --detach" lets them skip the
  branch deletion.

[1] https://lore.kernel.org/git/5a24d7e9255de407e343ce8bd60edb63293505bb.1666988096.git.gitgitgadget@gmail.com

>
> Thanks,
> Taylor
