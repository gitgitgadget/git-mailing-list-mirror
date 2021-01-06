Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18437C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2DE22227
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbhAFTlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbhAFTlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 14:41:17 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D7C061575
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:40:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 9so4707560oiq.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHtDTiHkAtwfzAbyiaVuwM3bc9vt7jnmLg4taFgjvUw=;
        b=UuFhHRyQcGBkrh07OEmQzZXlL3rdJtQq0s7NdQGSH9kZjbI2n/8/2kXv6X6YYG+sCC
         /qGTtXlKsh22TD3wRV6JC7An1/OBMTuTFddxpmGDvV14ngANVHq2iFvgZgEW9IyQ9BIp
         M925cOQguVGF4a7NNEH5APmu5oX1liNnptu2Mj4JFRq+CUVILLLQdGl/BMgcETvF2ZqM
         hCR9dHyCML4xQcPxa7jTjNhTjmStkm3wftbJdy4rS1tOVHoCeVGA6czMBH5YHtGpGwnS
         5XWh3ehqGod38BLbb+f9/UxbHBds9IMcyCJZi8XNiOxn3LSkyeW61eifs9npQWm+a8cx
         Rs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHtDTiHkAtwfzAbyiaVuwM3bc9vt7jnmLg4taFgjvUw=;
        b=Fyiqhzm5r2fvFW0RJgLWadyfZa4RmhLbfrsCj1ykpE4hpyrtwN4BpPJDOUdVvP6YND
         o5JIuU8abwIdVSnlh3qJE+4nvlwYNGITE9+Pkly1VIiLmFjlIL7Z/rpcuhq4Wr6fjJA5
         BKBPAo8JYXktTf/1/eLzS+Sx/phv28Ar97UvwPfUSV8++cxKfHgwLNSxSbBHQ298/lfE
         48Lb7if/ZVL4s0izW0ibRgZdkzfuXG0sH+ePjU6mGs9yjVXLxaGteMGn5UCJvVllz03e
         UOhFruGnBLhn7BggtihT+4Goqu8XOwAVMO2rfO8ycSgrEWXnoFRjKYRT0c17TxRO7Aaw
         /9WQ==
X-Gm-Message-State: AOAM532lNxfyha8sI2P7FS6CJ+QTuQUWp+btvrS1Qtc8PbYMO48XecWz
        JhEWUVjAbg3NuWqDEH+6CH7xDsjmkYRI2e2LfMM8Dovs
X-Google-Smtp-Source: ABdhPJyjq32NQx174VJLgJf7CIgMY3QbxQsr5KuAcK5D3m5I5ogZbZW6wpRAP0mUs7QmX42Qt5YK2dRZmfClKKCfS4w=
X-Received: by 2002:a54:4185:: with SMTP id 5mr4273267oiy.31.1609962036763;
 Wed, 06 Jan 2021 11:40:36 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
In-Reply-To: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jan 2021 11:40:25 -0800
Message-ID: <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 8:21 AM Stefan Monnier <monnier@iro.umontreal.ca> wrote:
>
> I use worktrees extensively (and rarely use `git checkout`).
>
> When I need to create a new orphan branch with a new matching worktree
> (or submodule), I find it is quite cumbersome.  I basically have
> to do something like:
>
>     git worktree add -b dummy foo
>     cd foo

>     git checkout --orphan newbranch
>     git rm -rf .

Sidenote:

Yeah, checkout --orphan is broken.  You should use switch --orphan,
which doesn't require the extra 'git rm -rf .' step.  That bit is
definitely cumbersome.

>     git branch -D dummy
>
> I wish I could just do something like:
>
>     git worktree add --orphan foo newbranch

I think you mean
    git worktree add --orphan newbranch foo
    cd foo

Because (a) the option to --orphan is the name of the new branch, and
(b) you need the cd to be equivalent to the first sequence of
commands.

Out of curiosity, why are you frequently creating orphan branches?
Such an option would drop the number of commands you need to run from
four down to two, but I'm surprised this would come up enough to
matter enough to do much more than create a personal git alias for it.
