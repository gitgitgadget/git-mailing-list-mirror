Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA49C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C19A613DD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhE1Voj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1Voi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:44:38 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B7AC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:43:01 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so1267075oot.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMOcgUpgJnmj2u7ctOJMQFRAskwxg/xjMvliHS+Ua3M=;
        b=OLO6E1IdJKwQqbakeXlGPL21gtva091/zLGsjc1BSsE1LC+n5AcotCJksIg+KcTRXG
         1zsvouTrXjZqUuAmnvziTa1+10xL5bqbT/EBlO9p2MiRuouQ9ZfiQ80PNVhYJ4JiX4qI
         uVxVz4Xqa/3kvltOJMfyqHnF5aOllFhAg3rsGps5W/0t3w/Zy/LN+2wW3lKAl9Yz9gf7
         bQth3yjX5t+VXh+EgdOnu24JkKEwFN0DYchWy4LMeCP0JLfub+Ci+uDTM0NQCLM4JQGu
         BiWGIhiMMVe0MsYnUlk8AtPFrnM8HDta3TcZo6+lMcKsYLAtlmMlOisTxqre/WNqHXgj
         Ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMOcgUpgJnmj2u7ctOJMQFRAskwxg/xjMvliHS+Ua3M=;
        b=h3iakMdkuGPiVVfZuqilRgG6AFKp4YGeOHjip8ub1E/raGdVq/XiQfjZCEu8zRBQyQ
         Z9NtXaADRWJpUtMjXTfmBfWmlO4q4p0IghluzwGpHGraks/bv2yiOSYMVtGUk/tTLMZP
         prKJjPgi5gEHm3enJ7vNMUdkVQWhUonkSL1w3ivI5X8ZE+3p71oIfPZhqSh5FBMyny2b
         JT3R1rDSyCOjD3gK0t9g2cqBtywi0s23YJpbyVtv/AP5bNTuJphK6qE1me+MjsQ1JEVG
         FmhWBm4TRy7iIRgsoonTuB5mo8AZH6so7EWtaaTO4VeCaxtYXFSjkrO+6iCsA+iaNCWi
         Gv5Q==
X-Gm-Message-State: AOAM533r6vHcCjH1xCdVqWqCBs2hm7n1Q6mr9fErXgoahLKJTmDbAZea
        h4JM+ZHqT1QVMadFcrWRb9L9cc32ccV0C+3zX2w=
X-Google-Smtp-Source: ABdhPJzMCO5Hy+uBe/w4vFPbk6X1wVkvNehY1Sa2s8DcgZYQn8IKOs/kQrLoQyKPz7vaxgL3wHXh7RmSCtwxBzZ0jCQ=
X-Received: by 2002:a4a:d30e:: with SMTP id g14mr8556268oos.32.1622238181347;
 Fri, 28 May 2021 14:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <20210528201014.2175179-4-felipe.contreras@gmail.com> <CABPp-BFPXWy0GwZwT0weNs1DKMKFC4ds2tLJWcVQBOKxPMomFQ@mail.gmail.com>
 <60b1604b66329_2a3717208eb@natae.notmuch>
In-Reply-To: <60b1604b66329_2a3717208eb@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 14:42:50 -0700
Message-ID: <CABPp-BG1FoBJ8-swiGHLJRqpE4iQiCNTmCi=8zzyms3bLJAcqQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] push: reorganize setup_push_simple()
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 2:27 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > Simply move the code around.
> >
> > Not quite, you also deleted dead code.  Made the patch a bit harder to
> > read because I was trying to verify you did what the commit message
> > said and it took me longer than it should have to realize that you
> > were also deleting dead code.  Might be worth including that fact in
> > this sentence here.
>
> OK. I thought that was obvious.

It is if you are familiar with the code, or if you still remember that
condition when you get to that point in the review, or if you happen
to look at the right line of code while mulling it over.
Unfortunately, I'm not familiar with this code, didn't happen to
remember the outer if-block when I got to that point in the
comparison, and didn't at first look back to the relevant line to
realize this.  So I started looking elsewhere for why removing that
condition didn't amount to functional changes and started trying to
figure out a testcase that would give different behavior.  I suspect I
would have realized sooner if not for the claim that you "simply moved
code around", so I just flagged it.  Not a big deal, just something
that I think could make it easier for other reviewers.

> Shall I update the commit message to include that fact, or shall I add a
> separate patch to remove the dead code?

I'd just tweak the commit message to mention you are just deleting
dead code and moving code around.

> Either are fine by me.
>
> > > -               if (triangular)
> > > -                       die(_("You are pushing to remote '%s', which is not the upstream of\n"
> > > -                             "your current branch '%s', without telling me what to push\n"
> > > -                             "to update which remote branch."),
> > > -                           remote->name, branch->name);
> >
> > This if-block is safe to delete because we're already in the !triangular case.
> >
> > > -
> > > -               if (1) {
>
> Techically this is removing dead code too.

Yep, true.
