Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A8C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiBTF3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 00:29:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiBTF3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 00:29:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0F46662
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 21:29:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w3so22769399edu.8
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 21:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7rmXhRMI5n7jglKT4x+RKjD/gn/Br5YbAYxcfV/nf0=;
        b=ef3OOte0fiTIU9TCv83lQsZJ3nAZtuNCsNT/OhVW2b9mZ6s6ILug6yZ7JoBo2Zb0Sn
         tGzZevXtCcbt4UFPODeCov8fT0ZeQpz1kw54FwqxqO3kqmKMvYbwchsGxgnxqAqrK30W
         qJ20RE12Zwumv0DookxXp1Pd+44W6UgPp3Br5TYqM4mBPJMJo0esU/X0YqWarL4BLwfe
         4tMi2HY2LFTsLcPg+/tM99ARo6ih1QA+fqGYyMLWYJ/lr9kQBeRWxDObFBOEedDXaYg9
         t/+IioW0oufa6zAd4JCXpyFUAcxNdQOFcLnLKRc/d4e5Cs4Q/Sh2k980vLPt9GISCtYr
         6pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7rmXhRMI5n7jglKT4x+RKjD/gn/Br5YbAYxcfV/nf0=;
        b=d+wrZaUylCbW9VKI/eglclTSR6AviiCdMso4/haFRb7aK9Wqv5A8Fpb2dUawm4202r
         zltlp96WfCmg+f26QOLxeDRokcjI9xEOO+FtMnFUvGzSq9astKFK4DE5xYcvzOMsFwWT
         0inK16x1AM8shcckBm7i3+Mgsg5KqO+6aPvnAPygMvNiiIh4tLEdIbKgSSUxxba9YkIi
         ra0u/v7nWA2FxgC4fkGJICZMqXVlTuvq5NisY2j0Q8ZAGfF9WDyyZKdScb4ClvUe3owR
         m0h213I5trkPsW83Nc8UzDEXcI9brjNvbUGMZOeYxlhzEdtRqwj46jxjB9H9LX+jYzvM
         xOiw==
X-Gm-Message-State: AOAM5301D+HjfLEm3mZ2XVCht6vD3UUH9k81XlkUx9wZede5Mhjglg2R
        vZ4ufafmx0K46cnRRSw4ryDOwLlLlrVcQEtVxsv+F6lwU/pUaQ==
X-Google-Smtp-Source: ABdhPJxOSBEqzegtz5eQyrlIY8LUgz2WEOsvUcf5mXpy4oF2ShJuwXa9ZFi7j3//vQxUPFNt1B5kTJ9HyfFETA2Luzk=
X-Received: by 2002:a05:6402:3553:b0:412:d0aa:e7b0 with SMTP id
 f19-20020a056402355300b00412d0aae7b0mr8850598edd.309.1645334950939; Sat, 19
 Feb 2022 21:29:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
 <YhBCsg2DCEd9FXjE@google.com> <CABPp-BHU4VYXF8kNvZEwBLu2BYP2Q1c9dYMW_8QfNmvGjB1ZOA@mail.gmail.com>
 <YhEzmdhxHC3W8ijE@google.com>
In-Reply-To: <YhEzmdhxHC3W8ijE@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 Feb 2022 21:28:59 -0800
Message-ID: <CABPp-BFEt1zxR6xoZmwmY2dtXkK+ti+g-1DHZCgeP2VpzWqqyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 10:14 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Elijah Newren wrote:
>
> > And, of course, you're trying to do more than just detect
> > inconsistencies -- you want the vfs to fully control the sparsity
> > patterns and expand them based on dynamic file accesses by the user.
> > That dynamic bit doesn't play well with the non-vfs workaround.
> >
> >
> > Does that sound right?
>
> You captured some of it.  There's a bit more: typically when using
> sparse checkout the traditional way, you will not have files in your
> working directory that do not match the sparse checkout pattern.  That
> way, the disk usage in the working copy is nice and small.  But with a
> vfsd like described in [2], having other files in the working
> directory does not cost disk usage because the corresponding data even
> in compressed (git object) form does not have to be present locally
> until the files are accessed.  So a vfsd gives an end user the
> illusion that all files are present, whereas git only operates on a
> small subset (the working set).
>
> With this change, git would start operating on all the files.
>
> [...]
> > Side note: I thought Microsoft's vfs was first named GVFS and then
> > based on naming collisions renamed to VFS for Git.  Sounds like you
> > have something that is probably a bit different, but which you are
> > also calling VFS for Git?
>
> No, sorry for the lack of clarity.  When I say "VFS for Git", I
> genuinely mean https://vfsforgit.org/, which was authored by Microsoft
> and to my understanding is still used by Microsoft's Windows team and
> is available for anyone to use.  (That page currently returns a cert
> error because their SSL cert expired 10 days ago.  But hopefully it
> conveys the idea, and the content is still there if you go through the
> interstitial.)
>
> I agree that it can be kind of confusing to talk about that alongside
> VFSes in general, but I didn't choose the name. :)
>
> [...]
> > On Fri, Feb 18, 2022 at 5:07 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >>  a. We could guard it with a config option.  It would still be a
> >>     regression for VFS for Git users, but they'd be able to use the
> >>     config option to restore the expected behavior.
> [...]
> >>  b. We could distinguish between the vfsd and the "interrupted and
> >>     forgot to update SKIP_WORKTREE bits in the index" cases somehow.
> >>     This sounds complex.
> >>
> >>  c. Something else?
> >>
> >> (b) and (c) aren't sounding obviously good, so (a) seems tempting.
> >> What do you think?
> >
> > Yeah, I'm having a hard time coming up with a way that either the VFS
> > could recognize these special Git present-despite-skip-worktree checks
> > and treat them differently, or having Git recognize that it is running
> > under a special VFS that likes to aggressively and automagically
> > expand the sparsity patterns.  So (a) seems tempting to me too.
>
> Thanks.  In a way it feels like giving up (isn't it better when things
> automagically Just Work?), but I think it's the right thing to do.
>
> > Got any name suggestions?  core.avoidPresentDespiteSkipWorktreeCheck
> > (defaulting to false)?  core.sparsityConsistencyCheck (defaulting to
> > true)?
> >
> > Did your team want to implement that on top of
> > en/present-despite-skipped since you can verify if it works for you,
> > or did you want me to take a stab at it?  Should be a pretty simple
> > change.
>
> Monday is a holiday here; it shouldn't be hard to get a patch out
> later this week.  Happy to write one but I also won't be at all offended
> if someone else writes it first.
>
> Ideally the config name should describe the intent from the user's
> perspective instead of the implementation.  So something like
> "sparsecheckout.expectFilesOutsideSparsePattern".
>
> Thanks,
> Jonathan

I took a stab at it over here:
https://lore.kernel.org/git/pull.1153.git.1645333542011.gitgitgadget@gmail.com/

Let me know if that works for you.
