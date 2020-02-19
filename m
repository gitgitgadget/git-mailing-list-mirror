Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60424C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266624671
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX1mknvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSQA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:00:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45804 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgBSQA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:00:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so24256310oic.12
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpWQrhz73Om6tG0V3sa1AzfgyNpqSXzuCwPu2i56LAE=;
        b=HX1mknvsweL9cVjuLk29AO55XsUzvGdWViZwika4bWbKjMcJzw5lAX/ANnciWpky+k
         ilGfKg1t5lIhDxJ2JhGKQovlHTvhz3BDyzRh6j18nUCLJoaQkbgWaLvVo2z+HvaU/JNb
         cwsXByQPCSg/lUqRhEnh62mTek3tE/seKiwqSVgx3yXJ5A/WJ8+oGnBGdGqwUHYFDkeq
         QyJiyBWZsknqUJn7I2ZT4aCFjXBxt8YKb3ygPZCstv5BdXyrDcjCYPeLXd9QsZ2bGC2C
         6TUdua/RVWghyrXwg4WHIdWtmxNgFB9S7CyLAX+DtbSRS1LWZ1XF9hIQA+jUEXjL1MYa
         uQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpWQrhz73Om6tG0V3sa1AzfgyNpqSXzuCwPu2i56LAE=;
        b=YDz9pVC4vwW3LCc/7uguCuHj1mTQyy9upFtju61UVtLOmkBAKrJqYnP6cIhpS/UNMv
         BMFrfdQCrD3B4xe0ExkWDhHxnTtSM9IvItN+E6eOEdCln52qeHt+SUt3jM+fPE0MzWqU
         sSVqT8ZaMV+F0fOGG6E78kraoL2BHWQVYqbR27PXB0vQEjWyDWpy6S2Cl31QKEsfL5qA
         IZjI8iUzhe2GqonlZ/hI5dTnmKMEEanCzWwyVt8aoQkvzQDgbC+LCR/vpkkgdy8mao4b
         SGuUS1s7FLlTzi8fTsjLyWSWFFGdxfx8YTRGRd0PU+O60hmJSIB3MBn2jRzYNkDVlk0C
         FdAA==
X-Gm-Message-State: APjAAAUTJhchYr2eAXzJUMKgbgV7tm3aqqoUJm+b1Efw4iewjGmk+bxT
        5RASCfahTeXiOFO2qKJhWEniiCwtqasNaMVUqsQ=
X-Google-Smtp-Source: APXvYqxRcopNL4vIHv08Cw4u98aofYd3M3sSnn64b4epwZfHhB8XB3/ItLTJXKPPFg7uwuVCf8juZs0aTIQOgCLMtoc=
X-Received: by 2002:aca:b483:: with SMTP id d125mr5177246oif.167.1582128056119;
 Wed, 19 Feb 2020 08:00:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
 <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
 <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com> <CABPp-BHBv+_HkExM1q6WAZZyMhR=UPNQZDhE8jFSQFNoCtgytg@mail.gmail.com>
 <deae766d-f552-2e30-fb49-e7e187ee984b@gmail.com>
In-Reply-To: <deae766d-f552-2e30-fb49-e7e187ee984b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Feb 2020 08:00:45 -0800
Message-ID: <CABPp-BFij++-6P2ht1EacGXaX4vA_CuBQEfz6M9w9CadXHC8Jw@mail.gmail.com>
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like failure
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, Feb 19, 2020 at 3:01 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 18/02/2020 15:59, Elijah Newren wrote:
> > On Tue, Feb 18, 2020 at 7:05 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> Hi Elijah
> >>
> >> On 17/02/2020 19:12, Elijah Newren wrote:
> >>> I forgot to add some cc's in GitGitGadget before submitting; adding now...
> >>>
> >>> On Mon, Feb 17, 2020 at 9:15 AM Elijah Newren via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >>>>
> >>>> From: Elijah Newren <newren@gmail.com>
> >>>>
> >>>> A user discovered a case where they had a stack of 20 simple commits to
> >>>> rebase, and the rebase would succeed in picking the first commit and
> >>>> then error out with a pair of "Could not execute the todo command" and
> >>>> "Your local changes to the following files would be overwritten by
> >>>> merge" messages.
> >>>>
> >>>> Their steps actually made use of the -i flag, but I switched it over to
> >>>> -m to make it simpler to trigger the bug.  With that flag, it bisects
> >>>> back to commit 68aa495b590d (rebase: implement --merge via the
> >>>> interactive machinery, 2018-12-11), but that's misleading.  If you
> >>>> change the -m flag to --keep-empty, then the problem persists and will
> >>>> bisect back to 356ee4659bb5 (sequencer: try to commit without forking
> >>>> 'git commit', 2017-11-24)
> >>>>
> >>>> After playing with the testcase for a bit, I discovered that added
> >>>> --exec "sleep 1" to the command line makes the rebase succeed, making me
> >>>> suspect there is some kind of discard and reloading of caches that lead
> >>>> us to believe that something is stat dirty, but I didn't succeed in
> >>>> digging any further than that.
>
> I think `--exec true` would be better as it makes it clear that it's not
> a timing issue. I've changed do_recursive_merge() to print the mtime and
> mode of "DS" before and after the merge which gives
>
> HEAD is now at abd8fe3 side1
> Rebasing (1/2) # picking commit1
> DS mtime, mode before merge 1582109854, 120000
> DS mtime, mode after merge 0, 120000
> Rebasing (2/2) # picking commit2
> DS mtime, mode before merge 0, 120000
> error: Your local changes to the following files would be overwritten by
> merge:
>         DS
>
> So it looks like the problem is that when we pick commit1 we don't
> update the index entry for DS properly in merge_trees()
>
> Best Wishes
>
> Phillip

Oh, indeed, so this was my bug.  Thanks for jumping in and
investigating; I probably should have found that lead but I just
didn't.  Anyway, with your extra information I dug around for a bit
and I think I found the fix.  I'll post it soon.
