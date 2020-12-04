Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF739C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 03:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD122517
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 03:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgLDDeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDDeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 22:34:05 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473CC061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 19:33:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f18so4972021ljg.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZ0Xzo9MwkkXqI3ClBxfyXqo/5JJcxFDALdIfbxePpc=;
        b=dCwKhHMzlOvtiCIw0C/XKvy7ot7L1WL1EKWcWfool4B8y/fwj0HE0hZelT2aJrpRvA
         luki+0/wmROLKlNEL/B8/zVjJFkcbbCowas5oWIXhSdK1iXpRU/dg2HX0I5IaCwXtUTx
         CMArPdDHbi/08Rg5ZYEAO61Q1s1C6xKaG1UkE0zFSiW5jw+nTYA+ad6dy3xYzUTsk6J9
         gir/TeqYzXjaaNfSrIoJZ3IqS53UA2z3tv5m5bhPVD/24x+u1FfNC29NOInlVxbDwIoB
         ocW6x4MrVAMhXX9OZpxo56F8TI+qNunMqUhV4E3HxjpBhuk+a6LWxPRAyDaigj/rCULI
         c58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZ0Xzo9MwkkXqI3ClBxfyXqo/5JJcxFDALdIfbxePpc=;
        b=rsl1VQNvLFAEuuwfunf/x9Z46zmleQe17XHgATsmYUzrqG9plMjfvrpNIKS30UJwL4
         PKzilB+B2CEFOfNtPMzRASDaeDD4kpp8zz2ABot8cFMadU44cJHcc3ru1XAtgVMhFH5D
         NhXTxhWIZk+bxQy+lhUbWDu+jHEE1muc+sCByLFEfXGziicj3EQ37OyoW3nRKqQvDgke
         5f/AhppxWnUILRFL54NEGRBDochXL4sRZxb12Q9Xi18WyWeO/i2ESZQ54fD22+zSXUKM
         3ty8q6/hQwL0fvnuHXwnWY8kZdJboc3p4J7KBv+zRqR0xW/AU10eCHTyK3DmE90PBcS3
         pXuw==
X-Gm-Message-State: AOAM533LUEfXLo2WCtt9gxyCQ4AD6j2+V0+dKQL+bH6K1cNM1KUmqazj
        QBH5zKvfbJxyWb8ytUwufYmQUwTm8/taTtOM2Nk=
X-Google-Smtp-Source: ABdhPJzhDKWHSpi1+cv+0tavhhbh+z1AhveEty1f5unzqhfCpSAVf5/7hNj4uI6t1FhZpG8VmM1HHtio7kukMFU5f2A=
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr2587974ljr.159.1607052797398;
 Thu, 03 Dec 2020 19:33:17 -0800 (PST)
MIME-Version: 1.0
References: <I55UpoMB_QMpFuqJEp1cHW7oN8AJy-b5iveBe2kZLslum_LOctwR5IdXUJhzZETg7bZDtm4beN38Nz6kvpJKDf0luxBMFxfpoFCYWkwaae4=@protonmail.com>
 <X8mjLHvNCYimATw7@google.com> <CAN05THQGqV4hP218hb3QXjJhQbbBCDRHgf=PAty=Ydd78a679A@mail.gmail.com>
In-Reply-To: <CAN05THQGqV4hP218hb3QXjJhQbbBCDRHgf=PAty=Ydd78a679A@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Fri, 4 Dec 2020 13:33:06 +1000
Message-ID: <CAN05THQRexhfme7YvQuh2Rfjj025yh8HkZ6DBZYAMPz_+o6d=Q@mail.gmail.com>
Subject: Re: [Wireshark-dev] [Outreachy] Internship blog 2020
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Joey Salazar <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a followup to clarify,

Take [1] and [2] as good suggestions, then look at other dissectors
and mimic them.
We are pretty flexible and forgiving when it comes to style and as
long as you mostly match what
other dissectors look like no one will object.

On Fri, Dec 4, 2020 at 1:28 PM ronnie sahlberg <ronniesahlberg@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 12:47 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Hi Joey,
> >
> > Joey Salazar wrote:
> >
> > > Very happy to be joining for this winter's internship! A short blog
> > > entry on the beginning of this journey here: https://jsal.home.blog/
> > >
> > > A new entry every 2 weeks, check it out!
> > >
> > > Thank you Outreachy, Git, and Wireshark for the opportunity, happy
> > > to be working together!
> >
> > Welcome!  I'm looking forward to working together (starting with an
> > initial wireshark patch to get the lay of the land, then fleshing out
> > the plan for the project, then executing on it in earnest).
> >
> > A question for wireshark developers: are there preferences for what a
> > high quality dissector looks like?  [1] talks about portability and
> > robustness but doesn't address other aspects of convention such as how
> > long functions should be (like [2] does).  Is there a rule of thumb
> > like "when in doubt, do things the way <such-and-such dissector>
> > does?"
>
> Only speaking for myself. This one is tricky.
> Most dissectors I think follows [1] and [2] pretty closely, with the
> exception that I don;t think
> there is any concern about lengths of a function. For a lot of
> protocols you may end up with
> switch statements with hundreds of cases and then that is just how it
> is. Or similar.
>
> Now, this is not uniform across all dissectors. Wireshark has grown
> organically over more than two decades
> and styles and preferences, which at the end of the day are dictated
> by the developers, change.
>
> So do not be surprised to find some dissectors that are very different
> in style. In some cases it might
> just be that the dissector is very old and also for an obscure
> protocol that almost no one cares about.
> Sometimes it is that simple.
>
> I would see [1] and [2] as good guidelines but not absolute law. Then
> also when in doubt look at how are things done
> in popular protocols where there are many developers involved and
> where the dissector is well maintained.
> For example  packet-smb2.c  is pretty modern and has a fair amount of
> crunch to keep up with the evolving standard.
>
> Modern and popular(i.e. people care about them) dissectors also are
> much more likely to contain useful examples of more advanced features
> such as
> * ExpertInfo,
> * Preferences,
> * Reassembly,
> * lots of Generated items (things that are not part of the packet
> itself but still useful to show when wireshark deducts it),
> * state tracking such as keeping track on Request and Response
> matching and response times.
> etc etc etc.
>
> This makes the dissectors more daunting to look at since there are so
> many different concepts there ontop of just "show what the bits and
> bytes mean" but at the same time they show these extra things that we
> usually have in a good/popular/mature dissector.
>
>
> But at the end of the day, for every protocol, what makes a good
> dissector is what an experienced engineer would need to do his/her
> job.
> I think that means that it takes a lot of subject-matter-expert
> knowledge to know what is useful and what is not and here you probably
> have as good or probably better input on what the dissection features should be.
>
> Hypothetical example: say if wireshark had a feature where it would
> reassemble objects and store them under their hash somewhere
> and it allowed you to right-click on a sha1 in the dissection pane and
> then "export object as file". Would that be useful?
> You would know if it would be useful for git developers and engineers.
> I have no idea.
>
> ronnie
>
> >
> > Excited,
> > Jonathan
> >
> > [1] https://gitlab.com/wireshark/wireshark/-/raw/master/doc/README.developer
> > [2] https://www.kernel.org/doc/html/v5.9/process/coding-style.html
> > ___________________________________________________________________________
> > Sent via:    Wireshark-dev mailing list <wireshark-dev@wireshark.org>
> > Archives:    https://www.wireshark.org/lists/wireshark-dev
> > Unsubscribe: https://www.wireshark.org/mailman/options/wireshark-dev
> >              mailto:wireshark-dev-request@wireshark.org?subject=unsubscribe
