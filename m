Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3949C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D561061245
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhFMQQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 12:16:45 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35609 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhFMQQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 12:16:45 -0400
Received: by mail-oi1-f181.google.com with SMTP id l12so4084738oig.2
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+02fbGD2Gca/hZ3tmeeAI+NcmEWmoFjRG/7kvlFka+4=;
        b=YPVDKByWcA6vhvdgWRQaqvCwYrDWbOaKyVj2PpuAP60syadsiAiAsqiGEyR8dRVnRe
         ItHAcfSZ+1ZvA+ZtO/r71Om7ScLGI0Pvtma7JbcpK21G+8FFgSEKEPIOgYP7B8HSJfLy
         9aFL0bQYE2MUCDGe04Qrn1m+HimRQvNhEwq/9BRW4O2ne9/bhQg69S2QsAuyPY4vsJEL
         pcUBoG4/EXmQf25fvZfmBzQxeQn5x2ylxqGt6LKADL+BAmaFehfSgwppIDEcLP4EJHwM
         wieFZjpq0QqYOAb2e1PiZCB/B2LjA2ujrWiMHugTJir0UgkdacY1b6RzTGwjhpdo2RL9
         ICGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+02fbGD2Gca/hZ3tmeeAI+NcmEWmoFjRG/7kvlFka+4=;
        b=fq9SvoQlom17prvnhO1kH9dNyfC0pS4uvimdKOXM/upWX2zVeY9p2xo7iyQ2cZ7Mxr
         8uAY+fsruzu6PNvOo69xg6evw95wK67n2y4QyTxZpa/7pyQLMEGN9h5YXWciGt2GAfDI
         oj97QH9gODL4C6YbsZCwAoOgHEmTGKPTkBzq/a8JD06M5AzDPsrNKqKlQ1UWn9pGYeTt
         pCRFaVfbmpBFOhJQzxJOi2mby96bwEMRYcxfYrKkAu4s2j5kq8ujRMJgxGhYR9YjNKwL
         6/A0jE6rRrcC5stxfdngU9SNn7Uo+kotb2hHpiOndFSr4inFtU5y8lG4XfUGCPjzCTBk
         8u+A==
X-Gm-Message-State: AOAM532Krb/w74Wi+yqQfvzs88QhvWB0MeODLbj6eRsDKwiYR8XVHTfS
        obEIwX2RGTQohWDPeXnzeAs=
X-Google-Smtp-Source: ABdhPJzxV4nWXZNZlD6Tlhf0aastFk705y1tIG7PXrshg8togBOra8OZArIRkI1H65B5PoJP0KHa2g==
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr5781517oic.48.1623600812284;
        Sun, 13 Jun 2021 09:13:32 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s2sm2481683oom.17.2021.06.13.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 09:13:31 -0700 (PDT)
Date:   Sun, 13 Jun 2021 11:13:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c62eaa7d538_41f4520899@natae.notmuch>
In-Reply-To: <CAPig+cQhve3pTdrm8ZeJ8-YPJj4gWrk=BB9rLqRojXgYJrAi2Q@mail.gmail.com>
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
 <60c588d452750_3d86c2085c@natae.notmuch>
 <CAPig+cQhve3pTdrm8ZeJ8-YPJj4gWrk=BB9rLqRojXgYJrAi2Q@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Sun, Jun 13, 2021 at 12:26 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Eric Sunshine wrote:
> > > For what it's worth, as a person who is far from expert at revision
> > > ranges, I had to read this revised text five or six times and think
> > > about it quite a bit to understand what it is saying,
> >
> > Can you explain why?
> 
> Probably not to a degree which will satisfy you. And I'm not being
> flippant by saying that. I mean only that it is more than a little
> difficult to explain why one thing "clicks" easily in the brain while
> something else doesn't. I can only relate (to some extent) what I
> experienced while reading your revised text.

Yes, but the documentation is not for you, it's for the majority of
users, so it behooves to try to understand the reason to see if it
applies to the population in general.

> > This is the context: commands don't generally take two ranges:
> >
> >  1. Unless otherwise noted, all git commands that operate on a set of
> >     commits work on a single revision range.
> >
> >  2. Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> >     commits, but doing A..F B..E will not retrieve two revision ranges
> >     totalling 8 commits.
> >
> > At this point what isn't clear? Isn't it clear that `A..F B..E` aren't
> > two revision ranges?
> 
> The documentation stating explicitly that `A..F B..E` is not two
> ranges is fine. What was difficult to understand was your explanation
> of _why_ those are not two ranges.

At this point the _why_ has not been explained, merely that these two
things don't result in two ranges.

> >  3. Instead the starting point A gets overridden by B, and the ending
> >     point of E by F, effectively becoming B..F, a single revision range.
> >
> > What isn't clear about that? A gets superseded by B because it's higher
> > in the graph. And if you do `git log D E F` it's clear that doing
> > `git log F` will get you the same thing, isn't it?
> 
> One of the reasons I had to re-read your text so many times was
> because it was difficult to build a mental model of what you were
> saying, and to follow along with all the "this replaces that" and
> "this other thing replaces that other thing". While doing so, I
> repeatedly had to glance back at the original `A..F B..E` to make sure
> the mental model I was building was correct or still made sense.

I wonder why that is the case. A..F is so simple it doesn't have to be
explained, Ruby even expands that obvious range.

  ---A---B---C---D---E---F
     ^                   ^
    from                 to

And B..E:

  ---A---B---C---D---E---F
         ^           ^
        from         to

In Ruby the range can be defined simply as: 'A'..'F'

  ["A", "B", "C", "D", "E", "F"]

Would 1..6 be easier to picture?

> The word "overridden" didn't help because I couldn't tell if, by
> "overridden", you meant that something got replaced by something else
> or if something was merely ignored. (Or maybe those are the same thing
> in this case, but how will a newcomer -- who is trying to learn this
> from scratch -- know which it is?)

If I say Lucy is available from 1 to 6 p.m. and Michael from 2 to 5 p.m.
why would 2 p.m supersede 1 p.m.?

If we are trying to define a starting point, obviously the latest
starting point is the one that wins. No?

> However, an even bigger problem I experienced while reading your
> revised text is that it felt like it was trying to express some rule
> which the reader should internalize ("replace this with that, and
> replace this other thing too")

The text starts with *for example*. Therefore it's not something
general, it's an example.

> Junio's explanation, on the other hand, was simple and to the point,
> and (for whatever reason) clicked easily in my brain, such that I came
> away feeling that I could apply the knowledge immediately to other
> situations.

Junio's explanation is inaccurate because it stated that this:

 Unless otherwise noted, all git commands that operate on a set of
 commits work on a single revision range.

Is the same as this:

 writing two "two-dot range notation" next to each does *not* specify
 two revision ranges for most commands.

But it is not the same.

Can you tell me why?

> On the other hand, after reading your proposed text, I did not feel as
> if I had gained any knowledge, and even had I picked up the rule which
> seems to be in there,

The text never mentioned any rule.

> > > Also, if this explanation is aimed at newcomers, then saying only
> > > "doing A..F will retrieve 5 commits" without actually saying _which_
> > > commits those are is perhaps not so helpful.
> >
> > It doesn't matter which specific commits are retrieved, the only thing
> > that matters is that `X op Y` is not additive.
> 
> The very first question which popped into my head upon reading "Doing
> A..F will retrieve 5 commits" was "which five commits?".

Keep reading.

> So, whatever precision your above statement might have, it is likely
> to be lost on the general newcomer who is simply trying to learn about
> and understand Git revisions.

Or maybe it's something that only applies to you.

Cheers.

-- 
Felipe Contreras
