Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73398C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4309D64DE8
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 23:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhCRXpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhCRXpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 19:45:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F0C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 16:45:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so7251718lfa.3
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXiEfvCmj+C4hdbULOXxMB/8+XSRQjsG5bXdgZCzjLA=;
        b=dI5NoFSIbqYdMH9aWcv+JKIMzvmaHYiiVdScGP+up6oAxybOdjx7lobhLFtiuORJKc
         CKuHHTDQJL/xxA517+hyCHmUWB/pkBKwQu0Gjzy7LFTgr/7pUh+Z6721itCkietl+2nS
         n2sUGwQhAWoz5lwYVMPWDus/89ax/T1yPj06iuRwvtBTR2oUk6Tpi4lOBv7khVy8N1DZ
         Dl/3rBmPXoTPG+97EOLwfPULZgt4uuqc8a6pEURSp4f8x/KECVYiJmLTZzJv/AB0UWLc
         4S8W6+hg9jwJW/urTHIFDR3y5t/vLcD+OvvTigS8NUhiXrgjg6b65bCmvyDkhd9SEkH/
         Gr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXiEfvCmj+C4hdbULOXxMB/8+XSRQjsG5bXdgZCzjLA=;
        b=hwe/IQs1TQK86SZuIAG97HreU31LmqPssQF70q2fFwOPzwudHK9kIHP2cFBjAccL8p
         Wn5DDElii5Oz0s5ogkEi6hCfgIUrRWvtjfkTThP0hRYWglD36fdMYzvxFSzTQ/v/tY5V
         f4us5ov9uKuRej75D8pcQSSY+ld09P1FCTltVVbqWIGyfp1fwZtEDhbOyhe6jTKOmgpj
         J+i+rqAAa9u0x5f5knUJm6u3eIb0LZ+KrX+u0fRzbe6t8ifM5ghB+tAoWjQOIBFtCVpO
         LIPX+ZwWER4FVyGhVQ65gvyH2Zxm+nhOoiAba8ObFWsh+CzW74Qqiy2tH3bXxSc9JRJx
         aEwg==
X-Gm-Message-State: AOAM533gCcXgMxzdkCXsngtUXPnNF1CwUi+h3ij0wM3ZBEVTQRjmBlla
        o4kuZMirD7t9SUuKdjLJjr4UZAZQB/7qjgxwVUk=
X-Google-Smtp-Source: ABdhPJwKfoLMb8FF9p+asiign5f3RvTIohQwCrtpv5dKt5r4CTXYAdGMFgkE13mZyIVGMWa3z2cBaWerh44+wNsOKi8=
X-Received: by 2002:ac2:4205:: with SMTP id y5mr6658933lfh.375.1616111112932;
 Thu, 18 Mar 2021 16:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com> <xmqqim5oqen4.fsf@gitster.g>
In-Reply-To: <xmqqim5oqen4.fsf@gitster.g>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Thu, 18 Mar 2021 16:45:01 -0700
Message-ID: <CAMbkP-SNXbpd3OeBP9uqrLj-WnYXWhD89RqQv3SnzQaZ96rO5Q@mail.gmail.com>
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 3:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> So avoid "repository owner configured", when you mean "project
> configured" or "project controlled".
>
> On the other side of the coin is that this document should avoid
> reference to a "repository" in an ambiguous way, as it can refer to
> the central meeting place the project controls, lets developers to
> clone and fetch from, and push into, and it can also refer to the
> copy of that central meeting place individual contributors work in.
>
> In our own documentation, we often refer to the former as "the
> central repository", and the latter as "a clone" (as in "you start
> working in your own clone").
>

Ack, thanks for the correct terminology.

> > +* The `pre-commit` hook event: before committing, a developer may want to lint
> > +their changes to enforce certain code style and quality. If there are style
> > +issues, the developer may want the commit to fail so that they can fix the
> > +issues.
>
> This is irrelevant in the context of this proposal, no?  It is not
> that "the developer may want".
>
> Rather, it is "the project may want the commit to fail so that they
> won't upload commits that violate the house style", no?

Good point

> > +User Goals / Critical User Journeys
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +* As a repository owner / project maintainer,
> > +
> > +    ** I want to prevent leaks / share code widely so I check that developers
> > +    are uploading code to the right place.
>
> I understand "You want to prevent leaks", but not "I want to share
> code widely".  Perhaps you meant s/widely/narrowly/?
>

There are two opposite intentions here and the slash is making it confusing.
Some projects have internal and external central repositories, and they want to
encourage developers to push to the external repositories when possible.

> > +Design Principles
> > +~~~~~~~~~~~~~~~~~
> >
> > +* *Treat hooks as software, not configuration:* We take seriously the
> > +responsibility that comes with causing arbitrary code to run on a user's
> > +machine. Such code needs to come from a reputable source, be automatically
> > +updated, and run with user consent.

> > +Feature Requirements
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +Minimum Feature Set
> > +^^^^^^^^^^^^^^^^^^^
> > +    * Users do not need to run setup scripts to install hooks --- the setup flow
> > +    happens automatically at clone time
>
> This one is probably unacceptable, as it makes it impossible to
> perform unattended cloning.  A better alternative may be to make it
> part of the build procedure.
>
> > +* Automation is able to continue to use clone and other commands
> > +non-interactively
>
> This directly contradicts with the "setup flow happens
> automatically", doesn't it?  The user can pretend to be (or the
> "automation" detection may incorrectly misidentify the users to be)
> an automated client when cloning the project, and would not trigger
> any setup.  A separate setup procedure needs to be there to salvage
> such users anyway.

I don't think there's a contradiction here. Users should always be able to
decline hooks since it's their own machine, so the goal shouldn't be to prevent
uses from declining setup.

That said, most users want to do the right thing so that their patches
get accepted
e.g. adopt the right code styles via linting, so the goal should be to
make it as easy
as possible for them to do that.

In the ideal case: automation detection is great and there are few
false positives :)

If not, we can't break unattended clones, so the default clone
behavior would always have
to be no-hooks-setup... maybe that speaks to `git clone --recommended-setup`?

+1 we'd need a method for a user to trigger a set up if they change
their minds or
need to recover.

> > +* Works across Windows/Linux/macOS
> > +
> > +Fast Follows
> > +^^^^^^^^^^^^
> > +
> > +* When prompted to execute a hook, users can specify always or never, even if
> > +the hook updates
>
> This contradicts the earlier claim to take the responsibility
> seriously, doesn't it?  I think the convenience feature is useful,
> but then we should tone down the claim---we allow users to be loose
> and blindly trust their own project, instead of taking it always
> seriously.
>

I don't think this is contradicting since the user is consenting, but
maybe the principle
can be clearer:

"Execution of code must require user consent, and users should clearly
understand
what they are consenting to." That is, I would imagine for a prompt
for "always" we'd

1) have clear help text saying that hooks from $REMOTE will be
automatically installed
when they change
2) give an FYI if hooks the hooks do change
