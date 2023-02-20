Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792EC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 17:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBTRVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBTRVE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 12:21:04 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4D17144
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:21:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q11so2593632plx.5
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2JkvXVpi0Dq/Xt4/LHci37tOKZaq0p9tAEZWsH9VDw=;
        b=lIwrNnvXCWu4V0w+HuEk3y81WcQPaGNAgaX5Z6ggmMQOXomfJ971DC71d36IsnqQ5K
         Z2Q8OV2zClfo/dzPJ9yZ/+rrLw+opBvfmtmPjIsFjU7Kgh0Zwrm2HEwiu3d4pVytv1y0
         cvCYess3nWIcK3iMYizC3DTX81TS3BxPMQ7PvAEkzxzM2dyMJ/Yxm5+4SwxP6OvV5VyW
         vVecGyhWd7M2kBa/o4ZraMSP+9gBNDByj3/W2AC9LmcbnjV6C7JjWhrQs1zFg3pXDASc
         cJKjGOBPqFvhR8XtgA1EIMfvQqOqwTAxanMtRjmYFfu5QZur14US0tz76b5RjxGYoc4u
         PTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2JkvXVpi0Dq/Xt4/LHci37tOKZaq0p9tAEZWsH9VDw=;
        b=krO9Ux7Yo/Q1IAxKk3GFA/o1JJOSobDcCAV7ZwM6QHq/GFFQUrwJ7o7AyQCmfh814O
         rIHMr0h1PZOGOSN4j8scwaLxSpT6odRWDdHuWAs6Ht/ilZrwWp7zIT1UeA1uuxoknifQ
         KdK2whYMOW4K62jxa8MfVBc8wUGF7lPWednUn68C03PBPm4PFIopmv5GB/sx8Eo6s3HL
         LpXJdJ/spp8NgnZZ8/snzb5QGJY5T0PIl9BOLCac4PGspJGY7+E1EuP6p3pHQs2f93PN
         WL5cn5TcNYauSydIJjJTqzlTC337I+HABFdaXRLoZpolF0wSalEFQIMLi6/oR1GJPFMC
         zZSg==
X-Gm-Message-State: AO0yUKU0eLkDXyvNHJOWgozXsIyZo2t2nE4oB9D0zYB0BP8CQ4P3JsQ+
        QtxtjIgejl1g9oK4ocBt5I5B1i2c1+KtkLC9kMU=
X-Google-Smtp-Source: AK7set9DsMCk6dSxAbAvDJQaAVyJL9+MGPL4cCZiXFsFeVsQbUHTCNtV872+bcHqniEZ5RvOPNeQuYdR4F4xnSunsLo=
X-Received: by 2002:a17:90b:3ecd:b0:231:2896:597b with SMTP id
 rm13-20020a17090b3ecd00b002312896597bmr726646pjb.89.1676913662277; Mon, 20
 Feb 2023 09:21:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com> <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com>
In-Reply-To: <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Feb 2023 09:20:47 -0800
Message-ID: <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2023 at 10:01 PM Tao Klerks <tao@klerks.biz> wrote:
>
> On Sat, Feb 18, 2023 at 4:17 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 8:02 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > >
> > > On Thu, Feb 16, 2023 at 5:31 AM Tao Klerks <tao@klerks.biz> wrote:
> > > >
> > > > If there's an appetite for it, I would love to contribute to a
> > > > multi-year adventure to change git's behavior, little by little, until
> > > > the behavior of "rebase=merges" is the default, and the old behavior
> > > > becomes a different option like
> > > > "rebase=copy-merged-commits-to-flatten"
> > >
> > > I know you had a lot to say in your last email, but I'd like to focus
> > > on this point. I would be OK with the proposed patch if it were part
> > > of a larger effort to make --rebase-merges the default behavior of
> > > `git rebase`. That seems like an achievable goal, and I don't think it
> > > would take multiple years, maybe one year at the most. The process
> > > would look something like this:
> > >
> <SNIP>
> > >
> > > Does that sound reasonable? I think I could lend a hand with steps 1-3.
> >
> > One concern I have is that "--rebase-merges" itself has negative user
> > surprises in store.  In particular, "--rebase-merges", despite its
> > name, does not rebase merges.  It uses the existing author & commit
> > message info, but otherwise just discards the existing merge and
> > creates a new one.  Any information it contained about fixing
> > conflicts, or making adjustments to make the two branches work
> > together, is summarily and silently discarded.
> >
> > My personal opinion would be adding such a capability should be step
> > 2.5 in your list, though I suspect that would make Tao unhappy (it's a
> > non-trivial amount of work, unlike the other steps in your list).
>
> I apologize for my ignorance here, but I'm not sure how this "does not
> rebase merges" concern overlaps with the "pull.rebase" context I'm
> most specifically concerned about.
>
> I would have assumed that when merge commits are "dropped", as results
> from the current "pull.rebase=true" option in the pull conflict
> advice, any merge resolution information is *also* dropped - so there
> is no loss to the user here in advising the use of
> "pull.rebase=merges" instead.
>
> Is your concern about the "pull.rebase=merges" advice change, or more
> about the broader "let's encourage users to more explicitly choose
> between traditional merge-dropping rebase and rebase-merges" change
> Alex is advocating for as a precondition to "my" change :) ?

When we teach new folks about git, and get to rebasing, there is a
simple and easy rule to tell users: don't mix merges and rebases.
(There's a minor exception there in that merges with the upstream
branch are fine and rebasing can let you get rid of those otherwise
ugly-and-frequent back-merges that users sometimes make.)

Obviously, your users are ignoring that advice, and feeling pain.  To
be fair, the "RECOVERING FROM UPSTREAM REBASE" section of the rebase
manual isn't that prominent, and perhaps your users didn't have more
seasoned developers sharing this don't-mix-merges-and-rebases advice
with them.  (It seemed to me to be shared pretty widely and commonly,
but perhaps we are relying on education from others too much and
education is never uniform if not coming from the tool itself.)  I
understand you want to make it easier for users to avoid accidentally
getting into this state.  That's a valid concern and desire.  I think
we should improve the situation.

However, on what timetable and at what cost to others?

You're advocating we start advertising an alternate option, one which
has some caveats and gotchas that are not going to be so easy to
explain to users -- neither to new users, nor to folks who have been
using Git for years.  We could just bite the bullet and start
explaining, but these caveats and gotchas are completely incidental to
the implementation, and are in no-wise fundamental to the desired
operation.  I believe that switching to this new option is going to
generate an awful lot of questions and surprises by users.  It seems
to me to be a really sad state of affairs to be recommending an option
with known defects when (IMO) the solution is known.  Can't we fix it
first, then recommend it?

Granted, this is a trade-off.  You have users experiencing real pain.
You want a solution now.  I want to not recommend features with known
implementation shortcomings and known solutions, until those solutions
are implemented, and I know that will take a while.  What to do here
is a judgement call, and I was merely giving my opinion on the call to
make.  Other folks on the list might see things differently than I do.
