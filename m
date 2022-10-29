Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19358FA3743
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJ2IHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJ2IHb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 04:07:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C175FD1
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 01:07:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt23so17946598ejc.7
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKWC2L6Sny8zK8Kw0srEQugPZfIvVxQ/T0LRi3TMATo=;
        b=Y+/Y2lrHfB+yHFaGYkr9wmer+YHQYxN2Sy1RIjfGoXDQ7TKoyHGI2PMDquHWuA3WuL
         IVk90GNwHkRLASJVmrSgmQiYX3WCnNl8LoQhjzHKZV8I9eWonOmJf706OIRTfPZiB9bV
         4YhAi0ZkZmB3RYW0RnoUubNvyBc7JOCiDg8uZHvk6DD1WbM9bfXnTgVOrK6mxu9I+AAo
         ZAKZjOxUTlPbFDHgo3MeRZkb6mPqfJKATI95yP8I6zeO3DET+85A/IJvIY8s+BRt6GfA
         BIgrGG8BsZUhNK6hd7UQRAaT0cMeJhrxzuDap8EKhFCF48IiOez671Mv4MDFgSQleNac
         60cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKWC2L6Sny8zK8Kw0srEQugPZfIvVxQ/T0LRi3TMATo=;
        b=M2JlwC/t+yP/2bmMN0lkByPenI/D3v1ANAUYJgYjnJC9eEAC04QkJkkzhqDTmx2+ni
         pQKdrvQrccnJzSwOXzaMGSiLt7wueT/wJMig3mrXgSq8LjU1wXd1jvZRcwuW7X4eA3ks
         r+6MHsEZY89ZxwNrycFb6eADsXiFiVT4dpwFp7U4aFuJiNNmEbx6CfuIkIvmIGgMrrPB
         2o7UxwJtDctohqyIeq9UOwimO6+gtCZNDMZi5L9MJUmL7tMpko+e2Js0ZbXJ9AkWpn00
         NJK+g1Yo7f1fPUdE/FC39TYMQs3NThV8CoDRDGmBby69WMwFTsbPDv7jdzsk/YF7QeXV
         B8+g==
X-Gm-Message-State: ACrzQf0iIcjj3megMJeQ8W/YW8/nul7qXrARpCB22OfjVaIpva7vn/Uc
        BVv63h2VozukplL6DBCEylxh9EeUiRxcGq6B+18=
X-Google-Smtp-Source: AMsMyM7QJ9OKPg3oTHP/dzvoEbN23EfGb2mTX11AKtohaaUJR/POAIP2fHRg6OR2yjP0u6E8OHgsoyKnjWc7BC+hL3g=
X-Received: by 2002:a17:907:724d:b0:78d:acf4:4c57 with SMTP id
 ds13-20020a170907724d00b0078dacf44c57mr2943726ejc.516.1667030848865; Sat, 29
 Oct 2022 01:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
 <d0a6eea93b58f5a267352690adde00a5b0f3f089.1666970645.git.gitgitgadget@gmail.com>
 <xmqq4jvniw7q.fsf@gitster.g>
In-Reply-To: <xmqq4jvniw7q.fsf@gitster.g>
From:   Simon Gerber <gesimu@gmail.com>
Date:   Sat, 29 Oct 2022 10:07:17 +0200
Message-ID: <CAAyHH32vj14Q9B+diFqGBc4db-C-raxp1F+WZEWdhx66_N+MXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests: add test case for autocorrect in work tree for
 bare clone
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Gerber via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 28 Oct 2022 at 21:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  t/t9005-help-autocorrect-worktree.sh | 29 ++++++++++++++++++++++++++++
>
> Don't we have existing test script for auto-correction?  Is it
> sensible to waste a new fail for this single test?  I doubt it.
>
> Perhaps appending after 9003 a new test instead?

I'll move the test to 9003. I was considering doing so in the
beginning, but was hesitant to add an only vaguely related test in
9003 which has the description "help.autocorrect finding a match".

>
> > diff --git a/t/t9005-help-autocorrect-worktree.sh b/t/t9005-help-autocorrect-worktree.sh
> > new file mode 100755
> > index 00000000000..4fecc8a8e01
> > --- /dev/null
> > +++ b/t/t9005-help-autocorrect-worktree.sh
> > @@ -0,0 +1,29 @@
> > +#!/bin/sh
> > +
> > +test_description='test autocorrect in work tree based on bare repository'
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup non-bare' '
> > +     echo one >file &&
> > +     git add file &&
> > +     git commit -m one &&
> > +     echo two >file &&
> > +     git commit -a -m two
> > +'
>
> Wouldn't "test_commit" be simpler to use than rolling our own here?
> If we piggy-back on set-up in an existing test script, there
> probably is already a history the single test to attempt running
> 'git staut' can use.  After all, that test does not care an iota
> what is in the history.
>
> > +
> > +test_expect_success 'setup bare' '
> > +     git clone --bare . bare.git &&
> > +     cd bare.git
>
> Do not chdir around in a test script, especially in separate steps.
>
> > +'
> > +
> > +test_expect_success 'setup worktree from bare' '
> > +     git worktree add ../bare-wt &&
> > +     cd ../bare-wt
> > +'
>
> Ditto.
>
> Either do it in a subshell in a single step, or
>
>         (
>                 git clone --bare . bare.git &&
>                 cd bare.git &&
>                 git worktree add ../worktree &&
>                 cd ../worktree &&
>                 git -c help.autocorrect=immediate staut
>         )
>
> use "git -C <over-there>" form, e.g.
>
>         git clone --bare . bare.git &&
>         git -C bare.git worktree add ../worktree &&
>         git -C worktree -c help.autocorrect=immediate staut
>

Thanks for taking the time to point out how I'm supposed to use the
test framework, I was pretty lost trying to write my test and ended up
copying some bits from 7103.

> > +test_expect_success 'autocorrect works in work tree created from bare repo' '
>
> When patch 1/2 is applied without 2/2, this test_expect_success will
> not be satisfied, breaking future bisection.
>
> For a small change like this, have the code change *and* test that
> verifies the new behaviour in a single step.  That way
>
>  * you do not break bisection.
>
>  * if somebody wants to cherry-pick the fix to an older maintenance
>    tracks, they can do so by picking a single unit, fix and
>    verification combined together.
>
>  * acceptance or review can be done by checking the end-result and
>    then tentatively reverting only the code change with something
>    like
>
>         $ git show -- ':!t/' | git apply -R
>
>    and see the test that expects success actually fails without the fix.

That makes sense. I'll resubmit this as a single patch.
