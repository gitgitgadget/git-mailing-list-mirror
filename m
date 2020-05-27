Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA9FC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07BF2088E
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=newcontext.com header.i=@newcontext.com header.b="L+m50LPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbgE0QZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0QZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:25:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10114C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:25:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id u73so9433789ybi.2
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newcontext.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSYXWmsxj9VbPIKNt5X0vgM7h5hqkiJFDgrVZs09Ww8=;
        b=L+m50LPEqDedyUuS25vIXGU186LqQ++I9GDZF4CMBA1HpvqNMWt3Ozb0TF/nZYR/fM
         BlW9lql97p/CoAln6E836TE4osjmkwVe1TiA9SghLxHOlSYCyA9wy6pQDf5hmbJR6Hpd
         TYqpX+XJDWBAVDnbRHlRsSqQzvZVAyZ15zDLnrWzOZJe9pHxg2sCTu3aCdh9i64B71Yn
         UvJ/xCoU+3CFf9wyxNfVKZKKCi4/QxobljT3Cly+jcwMdpBK16abwLo4aMi/EIP/q0aq
         SABQB0E6akmpsuxND82RArTJMP+72+3skdoatjwPqRxoWFZgZcdM8NNIWn+kisJpT5Fj
         ypTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSYXWmsxj9VbPIKNt5X0vgM7h5hqkiJFDgrVZs09Ww8=;
        b=js2E8y+rdLU4COwYNv5yjPuSwaLvku+RtO42mzulM7ulxJOT6pxoxR1m6yoRHPO3O2
         FhcEiYTJpNoktEFJDlQIwF0HCBZcw2dqFUKsBgPBYGFTmkMmrac/fyREBBpTqV5ITfW/
         n2kny/xhbNg2rfkvQR3QDb4+/HPLbOuo4TUjggWl+BE5fgZSxmtF0M+x0u9z1jg+MMsy
         XJVlettBVw1l80nOb9ArvmHb0SzhUbE/QlQYD5E8vD/rYo0gd2Y+v6wnsDCh4/X7v7aA
         yPIJIp6InbTnp6U1Vh5reKTOWmjeMczEmMBOaOgLd4qrQ4jI1p9rV1Dy43yRUF+ghbhL
         JcEg==
X-Gm-Message-State: AOAM531Dh2W3pN4vc44DJLXBeL86YWLi8prabHcss4bK4+E47Kgv86YG
        2FwxayYOUzb4npmVsxjTqC3F9E4iQteQwJcmZaGdg5t3DCs=
X-Google-Smtp-Source: ABdhPJx+72v4sCIqeRdsnIHvuWhz8ENiiKtpF6UV4RLPbPKntAWIXZyeHJRZWdJfPEQKxB2S+Wq92Wy1iBA4vTIuiho=
X-Received: by 2002:a25:8006:: with SMTP id m6mr10639825ybk.437.1590596711027;
 Wed, 27 May 2020 09:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
 <20200527025048.GC172669@google.com>
In-Reply-To: <20200527025048.GC172669@google.com>
From:   Kevin Buchs <kevin.buchs@newcontext.com>
Date:   Wed, 27 May 2020 11:24:59 -0500
Message-ID: <CAKTRx=29XBtKgt0m1+aCex_YZeiDzk5oBBxuM45NvVHmuqUVNQ@mail.gmail.com>
Subject: Re: rationale behind git not tracking history of branches
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the reply. I will give you my current situation. I am just
taking over a project that many cooks were involved in previously. We
have three persistent branches: dev, staging and master which
correspond directly to three CD environments: dev, staging and prod.
The nominal commit history ought to be that all changes happen in the
dev branch, and that the latest dev is merged into staging and then to
master at appropriate milestones of testing. However, the history of
commit chains clearly show that is not the case. Here is what gitk
shows me: https://1drv.ms/u/s!AgKA2HL-SveIha4Y_5lihkQO7ulfKQ?e=oA9PEi
.
Now, you can see that the nominal practice was not followed. Sure,
there are many commit messages to indicate merges and I could assume
those are correct and possibly reconstruct which branch each commit
might have belonged to. However, you can see there were a series of
changes to multiple commit chains, when there should have just been a
single chain - corresponding to the dev branch. How do I know there
were not changes that should be included in dev that were stranded?
Based on the overall "smell" of this project, I really don't believe I
should trust those commit messages. So, what would make my task a
whole lot easier would be if there were a display of columns
corresponding to the branches and any commits that were in multiple
branches, due to merge fast forwarding, would explicitly show up in
the corresponding columns.

Going forward, I believe I can make my own work much clearer for
others who might pick it up by having some way to sort out branch
history. I will probably use --no-ff to make history clearer. And
maybe notes to actually record to which branch a commit belongs.

I had been studying this Q&A:
https://stackoverflow.com/questions/2706797/finding-what-branch-a-git-commit-came-from
. I have come to realize the only item that is really useful there is
the first comment on the question. It says that the lack of recording
of branch history in git is "by design". I understand the point of
making branches lightweight. though I don't know that recording a
branch would make them much heavier. I wondered if there was another
motivation in the design of git. Knowing that might help me to use the
tool more effectively or adapt it to where I would like it to be.

Kevin Buchs, Senior Engineer, New Context Services
kevin.buchs@newcontext.com  507-251-7463  St. Cloud, MN

Kevin Buchs, Senior Engineer, New Context Services
kevin.buchs@newcontext.com  507-251-7463  St. Cloud, MN


On Tue, May 26, 2020 at 9:50 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Kevin Buchs wrote:
>
> > For many years of using Git, I always struggled to make sense of
> > commit history graphs (git log --graph; gitk). Just recently I
> > discovered that git does not track the history of branches to which
> > commits belonged and the lightbulb turned on. This is proving to be
> > painful in a project I inherited with permanent multiple branches.
> > Now, I am a bit curious as to the rationale behind this intentional
> > decision not to track branch history. Is it entirely a matter of
> > keeping branches lightweight?
> >
> > I am assuming one can backfill for the missing capability by using a
> > commit hook to manually track when a branch head is changed. Perhaps
> > by storing the branch in the commit notes.
>
> I think this comes down to a question of mental model: one thing I
> value when using Git is that each commit does *not* belong to a
> specific branch --- branches describe the shape of history, and
> commits are points in that history.
>
> This becomes particularly relevant when working with multiple
> colleagues, sharing history between different servers: I may have a
> branch I call "linus" that points to the same history that a colleague
> called "master".
>
> That said, I can understand how that may be difficult to get used to
> coming from other version control systems (such as Subversion) in
> which a revision does belong to a branch.
>
> Can you say a little more about what aim you're trying to achieve when
> you want to make this lookup?  For example:
>
> - are you looking to figure out what the commit author was working
>   on when they made the commit?  For that, the commit message is meant
>   to provide context, and a commit hook like you describe can be a
>   good way to enforce that (for example if you want every commit
>   message to contain a bug number for context).
>
> - are you looking to find out *when* a commit became part of a
>   particular published branch?  It's true that Git doesn't provide a
>   good way to do that today.  I have some hope that some best
>   practices like discussed in [1][2] will coalesce for attesting to
>   the history of a branch's state.
>
>   If you always perform merges with --no-ff, then you can find some
>   things out using the --first-parent history.  It is possible to
>   enforce such practices using hooks, but this may be a lot of fuss
>   for little gain, depending on the underlying need.
>
>   I find "git log --ancestry-path" to be very useful for finding out
>   *how* a commit became part of a particular published branch.
>
> - or are you looking for this information for some other purpose?
>
> Returning to your question: one reason that I find Git not recording
> the current branch name to be liberating is that I am not great at
> naming things.  I can use a placeholder name, knowing that I am its
> only audience, without fear of embarrassment.
>
> Thanks and hope that helps,
> Jonathan
>
> [1] https://git.eclipse.org/r/c/51128, describing refs/meta/push-certs
> [2] https://lore.kernel.org/git/22945.15202.337224.529980@chiark.greenend.org.uk/
