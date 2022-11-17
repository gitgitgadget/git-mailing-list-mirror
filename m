Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D02C43217
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 04:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiKQE3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 23:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKQE2z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 23:28:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6220F49
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 20:28:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so938148lfv.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 20:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1C6nzya0DHFeA439R2k1K/EAcHfg+nd0WrHolCgBxzY=;
        b=ZZEUPrDauIz+2XE1D9TNavqFIChWcPCURMStSbfv640ybkq76JwIU9O7mGFTr27jjd
         NBW5K0xOvZZsgzIAUSg5rqeq9tFp2+//nPrsRZ1d2M1/MIz/ruUjIjshCCa1NGn/Vw7W
         /jrMe9z08/OeUXXRwy+Im4KK85DOk4rKILZb9s624UfuWY5wJ1EqueAWig/okyTgtbSQ
         eFrwaIUZcgdVndXeAsD2NjwWL6s7L0PGLaIeB22m0oveLvvM38DVysj/VtlRaQWT8Z8+
         L/tWkmTNfSve6bRQuNVS1UAhgWH4QqQMbXjvX0Xt7gzvqauZLdGWUnDBnPusoYgVsBrD
         3AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C6nzya0DHFeA439R2k1K/EAcHfg+nd0WrHolCgBxzY=;
        b=ZUMje3LpDGXmoXZ6kR0YYrfQiUP7ahHio+w57hb6T3ob328jrEjwnUUeStrgNJWciY
         HUdm02B5trCH/jASxfVthn01s3CSesfM+9N3hUI1kiUIGHD07YRwOyBgp2R95KTzqL4S
         9fDvj70/pZTkSktoeugc/p4WlJCF/yBxvrjJHsyWNKETNyDD++4G7CAO+2gltb4E7L+m
         i2Ff/7bZM6mNpIoF91dy93EMd1Wse/MTFMpMGacfOEagYSVMYbW124b7rNt8RFYuMbPI
         aezVvPmuJK8yXW6lot8AaxXUbt+SciKcwZsBXSgR7bulOWCloKUYF3JdVYtXqefSgul6
         dfyA==
X-Gm-Message-State: ANoB5pny3wGOVgnW1HUaY1NCt3VYzJUmcbtKinRE0B/PzsYcfOAvxqR7
        rXN94THGUn36mzEj0Kjg4bKy47TaggJk5AxaDok=
X-Google-Smtp-Source: AA0mqf6SQjE0l0aAkLObS6xk6t4czWDneXcWvonl0zUWifIStne5I7FxqI5u3URgVX9g+3acDGNQKDPlhyJXo658xpU=
X-Received: by 2002:a19:4314:0:b0:4a9:6659:40d5 with SMTP id
 q20-20020a194314000000b004a9665940d5mr359689lfa.516.1668659331856; Wed, 16
 Nov 2022 20:28:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
 <0e156172-0670-2832-78cb-c7dfe2599192@github.com> <CABPp-BFNvUQx7exLgqDvzhgn1s=xSFKbJWdr8qfxLTXEFDQQig@mail.gmail.com>
 <01063560-8f57-4e40-5707-f8d8ecfe6cca@github.com>
In-Reply-To: <01063560-8f57-4e40-5707-f8d8ecfe6cca@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Nov 2022 20:28:00 -0800
Message-ID: <CABPp-BFsvZeC34=VKN9ir+KM0tx4rt0eiGuyKzrD=OAi9sABNw@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 6:45 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 11/14/22 9:47 PM, Elijah Newren wrote:
> > On Sun, Nov 13, 2022 at 4:07 PM Derrick Stolee <derrickstolee@github.com> wrote:
> >>
> >> On 11/11/22 6:28 PM, Elijah Newren wrote:
> >>> On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
[...]
> >>>>  * (Secondary) Allow using a packed ref format for all refs, dropping loose
> >>>>    refs and creating a clear way to snapshot all refs at a given point in
> >>>>    time.
[...]
>
> The reason is in the goal "creating a clear way to snapshot all refs
> at a given point in time". This is a server-side benefit with no
> visible benefit to users, immediately.

Yes, sorry, I just missed it.  I didn't understand it and wrongly
assumed it was continuing to talk about the implementation details
rather than the benefit details.  My bad.

Thanks for patiently correcting me.

> The D/F conflicts and case-sensitive parts that could fall from that
> are not included in my goals. Part of that is because we would need a
> new reflog format to complete that part. Let's take things one step
> at a time and handle reflogs after we have ref update performance
> handled.

Ah, right, I can see how reflog would affect both of those problems
now that you highlight it, but it hadn't occurred to me before.

> >> The biggest benefit on the server side is actually for consistency
> >> checks. Using a stacked packed-refs (especially with a tip file
> >> that describes all of the layers) allows an atomic way to take a
> >> snapshot of the refs and run a checksum operation on their values.
> >> With loose refs, concurrent updates can modify the checksum during
> >> its computation. This is a super niche reason for this, but it's
> >> nice that the performance-only focus also ends up with a design
> >> that satisfies this goal.
> >
> > Ah...so this is the reason for your secondary goal?  Re-reading it
> > looks like you did state this, I just missed it without the longer
> > explanation.
> >
> > Anyway, it might be worth calling out in your cover letter that there
> > are (at least) three benefits to this secondary goal of yours -- the
> > one you list here, plus the two I list above.
>
> I suppose I assumed that the D/F and case conflicts were a "known"
> benefit and a huge motivation of the reftable work.

Yes, and I thought you had just found a simpler solution to those
problems that might not provide all the benefits of reftable (e.g.
performance with huge numbers of refs) but did solve those particular
problems.  I've only looked at reftable from the surface from a
distance, and I was unaware previously that reflog also affected these
two problems (though it seems obvious in hindsight).  And I do
remember you calling out that you weren't changing the reflog format
in your cover letter, but I didn't understand the ramifications of
that statement at the time.

> Instead of trying
> to solve all of the ref problems at once, I wanted to focus on the
> subset that I knew could be solved with a simpler solution, leaving
> the full solution to later steps. It would help to be explicit about
> how this direction helps solve this problem while also being clear
> about how it does not solve it completely.

It certainly would have helped me.  :-)

Thanks for explaining all these details.
