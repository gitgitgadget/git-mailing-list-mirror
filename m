Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A0C433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E081864EC9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhBKAzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBKAzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 19:55:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CAC061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 16:54:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z7so2258364plk.7
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 16:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWCtZY6pdTSBe9FzG6yQUtWj1r//7V7pYQo7GlKKkUw=;
        b=qsKGZrGKoiyiB/M1Cov9f+q94WJa8Wj6O2YPLRhfNJvOAfaD7f/M9vL/ud6jt1uLRz
         dbFUR0TmHiUya41J+HArMqRLGuqTKPR+TLo7nYATXCBC0J0TxmcIrqySwQ5maRPcFNNl
         zyC13iEQKgwCobKAUgR6npNhYJ2+2yzmwM1RK8ruoxBL9il+XIx7IYmkxbmrdM5sDWrJ
         rOaAB7MbzUdgi9+NhfvIJjNxVB4LVMrrh026EbY6FJNAx+14U+CgNMt1bQdsew3Nh/jf
         mKJ3C+hnAJq+rCWcxG/82I5mFfWNrQVBBY46svRaPq3KKIRSBQs1xH+zq0bnJdkRjyW+
         9PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWCtZY6pdTSBe9FzG6yQUtWj1r//7V7pYQo7GlKKkUw=;
        b=QpMLKPGF0rOo9oFHbfxgKoQYVGrVn3qgRP0R2fLihU6+o5pi3DzVrNrTsCjGrEX3J3
         wcK9dEBVWUzf9/xbXfJhrVelLn4BQ3jjgjf8eUOXFm0Q1L54M75cRew2h8QbprcEyPvX
         Ec1mWUZ7S0L1iu3pXjLb3Mix706uEd+CHU+7ynJsm48YmAsg+ZVvImjC7n8dsPc+88RR
         r9UB9TePXURDhMdVtKakh8L8PBG057In7bO5WdDFdtmEjVnbQqi91oChnHdHuW+oD2bU
         RbvypBVwm9VMWgEoNVGE7olaXAbtZqRV5p+JdAO+OS7NjwXr3wfqzFWBPQyymw/ERmpW
         ZHxA==
X-Gm-Message-State: AOAM533LAz4lPt3tts1jKcFpWNn93I0IEVLlo5jv9rS0eGYifdnyvScA
        OrUx2V3f2r0+bap07tRSRNneiu1NGGRAJ+mp/aA=
X-Google-Smtp-Source: ABdhPJy/Hd51RJ4WB61kZfJM6smAskOARFd0iMBn3T4P3gQHyZSolL/0ACH4z6D7Jy49QfNp3eVvd+mompVdtG5vpuI=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr1479331pjn.25.1613004866280;
 Wed, 10 Feb 2021 16:54:26 -0800 (PST)
MIME-Version: 1.0
References: <566b38df-307c-f342-b583-3a50a81b5057@crashcourse.ca>
 <YCK6w/VbfUtM68Ad@coredump.intra.peff.net> <87im712mi7.fsf@igel.home>
In-Reply-To: <87im712mi7.fsf@igel.home>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Feb 2021 16:54:15 -0800
Message-ID: <CABPp-BGKvsqQ3Xn_7Xi0GqxKS5qSdN6WyLYUXWWtzwdPqT_zTQ@mail.gmail.com>
Subject: Re: how to most effectively cherry pick by selective patch hunk?
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Jeff King <peff@peff.net>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 11:44 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Feb 09 2021, Jeff King wrote:
>
> > Of course that involves a change to Git, and you were looking for
> > something you could do with existing versions. :) You can emulate it by
> > making the commit's parent equivalent to your current state. I.e.:
> >
> >   git checkout --detach ;# detached HEAD for temporary commit
> >   git cherry-pick $commit ;# maybe deal with conflicts
> >   commit=$(git rev-parse --verify HEAD) ;# remember the temp commit
> >   git checkout - ;# back to your branch
> >   git checkout -p $commit
>
> Alternatively, you could cherry-pick normally, then use
>  git checkout -p HEAD^
> to remove what you don't want.

Or, going into the slightly esoteric, you could define a custom local
merge driver for the particular file you want to ignore and say that
merges of that file always use the original version and ignore changes
made on both sides.

man gitattributes(5), search for "filfre"

Appears to be unchanged since git-2.5.0.

Only ever used them once myself long ago (and not for a real usecase),
because I wanted to understand what they were for.  However, it seems
like they might be useful here.
