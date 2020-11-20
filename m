Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33569C2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 17:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AD62078B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 17:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDFbVg/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgKTRHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 12:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgKTRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 12:07:10 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB5C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 09:07:10 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so11197112oie.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 09:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfSiAUNkymjFEOTM9iQCk7eX2tdOB7BwWJaMVA1fi14=;
        b=lDFbVg/9kkEYumlLYljMrmCQJlsPvaIwrLo93MG8ZCOIcD0p07sWbXHkvG4JEyVbom
         zDpdY2wEQyFAILlD9n6PTr3CEHOn4nxITc5m47h9k5j8/tjPJjdpHg6ydXO+IrmDGdl9
         C2r8cwVK+mMCQh5jOHB+JzAdDCsqJ+CzNLZJ7VyrLuNWsTwfto5wIC3xirzL75Kj7EpL
         aML8kWGYQzRhve+72HdIYX2YXguZNLSHcLaUNZHIwL/tbN12l1twpchi8XVE6e9adtEj
         5yTbDKeTZ7ikFRQndhyJLgwOvrahXMaYbvf3wHu/nA2IF4tx87a0K48S+NFPtVZirRoK
         5Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfSiAUNkymjFEOTM9iQCk7eX2tdOB7BwWJaMVA1fi14=;
        b=NyAkNfPrPGBybilcYSlJ0IEOMpHffNi9plO9PX6oKNZBmM0cfto434DE2ZGlifsdKE
         Zk4XjFeiTtflTatswa7dCVwymuDqJUcDcv2Yq2c4VmVqgG6k04li0x6QR6C4cTZsFOcA
         qRZ0J4rsMlLHWvONegrnP3QyXC+MAeUQ94KdQVOA+25bJhCydzP9BbJcVOdXTg0oHLUS
         VmIK6SwmDx34cRK0XJB5TXHCtyz09xtkVTb3hLfo+ipvZWt37dDAUpPHocMzGJvqQUBm
         dety7PYUcVWUvHhNLrWlEXUqy3WjGnB1Ej2zqywC0XjLumrM0D5bctAc4ccS+Y0IHde8
         lnkA==
X-Gm-Message-State: AOAM531oa9KhsWXKHcopla7s8qATmR8fwDr5hLviZ2cuPOa2UXLcfgTA
        TxdMgPT2x/5p1Sve7tbsk4T3BIOPqwWYtKQoFKI=
X-Google-Smtp-Source: ABdhPJyMbLCl73NVd1cxMtPC/3Q4qA/ffeIPl7FtZAq7CCW0s+iuIx7fo0FzPv5zcp9s5DX64+rp2FVEHwPWaiWjFE8=
X-Received: by 2002:a54:480b:: with SMTP id j11mr6864685oij.31.1605892029820;
 Fri, 20 Nov 2020 09:07:09 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <xmqqeekt83fl.fsf@gitster.c.googlers.com> <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
In-Reply-To: <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Nov 2020 09:06:58 -0800
Message-ID: <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Nov 16, 2020 at 9:20 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Nov 16, 2020 at 12:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Matheus Tavares <matheus.bernardino@usp.br> writes:
> >
> > > Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
> > > operation to the paths that match both the command line pathspecs and
> > > the repository's sparsity patterns.
> >
> > > This better matches the expectations
> > > of users with sparse-checkout definitions, while still allowing them
> > > to optionally enable the old behavior with 'sparse.restrictCmds=false'
> > > or the global '--no-restrict-to-sparse-paths' option.
> >
> > Hmph.  Is "rm" the only oddball that ignores the sparse setting?
>
> This might make you much less happy, but in general none of the
> commands pay attention to the setting; I think a line or two in

This isn't quite right; as noted at the just submitted [1], there are
three different classes of ways that existing commands at least
partially pay attention to the setting.

[1] https://lore.kernel.org/git/5143cba7047d25137b3d7f8c7811a875c1931aee.1605891222.git.gitgitgadget@gmail.com/

> merge-recursive.c is the only part of the codebase outside of
> unpack_trees() that pays any attention to it at all.  This was noted
> as a problem in the initial review of the sparse-checkout series at
> [1], and was the biggest factor behind me requesting the following
> being added to the manpage for sparse-checkout[2]:
>
> THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
> COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
> THE FUTURE.

The fact that commands have only somewhat paid attention to this
setting is still a problem, though.  In fact, it was apparently a
known problem as far back as 2009 just from looking at the short list
of TODOs at the end of that file.

> > >  to the paths specified by the sparsity patterns, or to the intersection of
> > >  those paths and any (like `*.c`) that the user might also specify on the
> > >  command line. When false, the affected commands will work on full trees,
> > > -ignoring the sparsity patterns. For now, only git-grep honors this setting.
> > > +ignoring the sparsity patterns. For now, only git-grep and git-rm honor this
> > > +setting.
> >
> > I am not sure if this is a good direction to go---can we make an
> > inventory of all commands that affect working tree files and see
> > which ones need the same treatment before going forward with just
> > "grep" and "rm"?  Documenting the decision on the ones that will not
> > get the same treatment may also be a good idea.  What I am aiming
> > for is to prevent users from having to know in which versions of Git
> > they can rely on the sparsity patterns with what commands, and doing
> > things piecemeal like these two topics would be a road to confusion.
>
> It's not just commands which affect the working tree that need to be
> inventoried and adjusted.  We've made lists of commands in the past:
>
> [3] https://lore.kernel.org/git/CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com/
> [4] https://lore.kernel.org/git/xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com/

So, I think there are a few other commands that need to be modified
the same way rm is here by Matheus, a longer list of commands than
what I previously linked to for other modifications, some warnings and
error messages that need to be cleaned up, and a fair amount of
additional testing needed.  I also think we need to revisit the flag
names for --restrict-to-sparse-paths and
--no-restrict-to-sparse-paths; some feedback I'm getting suggest they
might be more frequently used than I originally suspected and thus we
might want shorter names.  (--sparse and --dense?)  So we probably
want to wait off on both mt/grep-sparse-checkout and
mt/rm-sparse-checkout (sorry Matheus) and maybe my recently submitted
stash changes (though those don't have an exposed
--[no]-restrict-to-sparse-paths flag and are modelled on existing
merge behavior) until we have a bigger plan in place.

But I only dug into it a bit while working on the stash apply bug; I'm
going to dig more (probably just after Thanksgiving) and perhaps make
a Documentation/technical/ file of some sort to propose more plans
here.
