Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630A31F731
	for <e@80x24.org>; Thu,  8 Aug 2019 23:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404428AbfHHXna (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 19:43:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39160 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404001AbfHHXna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 19:43:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so90399901ljh.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJqK+k1ImyQhjXUgtUGOV/TnuxIBx5L9p4kZeGC1RrY=;
        b=MuAX8Hiax4Z/XNcJLeV/MgYHPlusMBJnsTX3PVVg9aLu7Y15f1uSATUWwfj2xaCD6M
         WmtvB3dBmpheOJWLmZfQ+8Jt2qeOAHwcC/oJSs7hy4Ed+NF2bPbt25nqrB49zfLPrH9s
         ZplNWLsYkhAztxUuSb98kN30GEOP+ir4hyV5QCSZyi9LVmOxcZLIdWHUmLXoNu55NvT+
         PF8zawu5jaHNvSj7kmGgbeqqhHTvskxvBVlP9VbPYB5jz5L6KpgCibdanH50sMQ31idR
         uQJ8txkemRGoPWpvl0QuRG4byiQ7+yBdHNpf/nSSK8TyS6fBdRyZSHym3l/UySGQ/ZH7
         GX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJqK+k1ImyQhjXUgtUGOV/TnuxIBx5L9p4kZeGC1RrY=;
        b=HO7GkdTyXEa4/l1kOKE2HL0aVzaK3aQm/yxeVrXJw8jvac7HxXSsDd+BO4ZwfXFKQt
         CgOpnFm3TjMT4/Gw9QSwDgzpXNcG+IGs5G+Q52cAF/pjIFU+AKaUYSa/O+hBeGbOu350
         i70wI4UiPWJMeMQ81YuyN4BrhPWcBufCCx7NhLOE1ODNe6oHKiX7hmv5dKa4jJQKDwud
         bxIJvVCOBNOqGhkdz3j1ENFfxOJeB+9LX6Itt8CJ/Q85Lcd//RID0HGWiSw/pRZJQo7M
         Ej7Fk7GK8FNS5Gw5ef6v/hnc0YNrg2cjmUPm7i0/Z7xaZaaQxFYHuOT7f55sH7yY12zn
         6cpQ==
X-Gm-Message-State: APjAAAUTb/FXpV0wQhIMXmF95/ovDmX5sqtAA27M1Hp8gdEWe3Ud/1Ny
        K/j2MGIBahH5BlvlHmv61TWTMAK6QKeoRnjEB3c=
X-Google-Smtp-Source: APXvYqzndo+sAu/e6q+EaNk7KBn8PI+Zj7UFaepwckzLpMujuc4tvFmQKgPb38wOWJbyQ5XwmgB2vY9dKXWx198dSoM=
X-Received: by 2002:a2e:85da:: with SMTP id h26mr9877401ljj.48.1565307808419;
 Thu, 08 Aug 2019 16:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190808035935.30023-1-phil.hord@gmail.com> <CABPp-BFH++aJinkzg+qsZDRN6R5-E8LPCG_u+udZLW6o0MGBug@mail.gmail.com>
In-Reply-To: <CABPp-BFH++aJinkzg+qsZDRN6R5-E8LPCG_u+udZLW6o0MGBug@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 8 Aug 2019 16:43:16 -0700
Message-ID: <CABURp0p5xbsq+8UsFerMAY8EG-ndXgd19EUsHOgQG-dnDnTAgg@mail.gmail.com>
Subject: Re: [PATCH 1/1] delete multiple tags in a single transaction
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 11:15 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Aug 7, 2019 at 9:11 PM Phil Hord <phil.hord@gmail.com> wrote:
> >
> > From: Phil Hord <phil.hord@gmail.com>
> >
> > 'git tag -d' accepts one or more tag refs to delete, but each deletion
> > is done by calling `delete_ref` on each argv. This is painfully slow
> > when removing from packed refs. Use delete_refs instead so all the
> > removals can be done inside a single transaction with a single write.
>
> Nice, thanks for working on this.
>
> > I have a repo with 24,000 tags, most of which are not useful to any
> > developers. Having this many refs slows down many operations that
> > would otherwise be very fast. Removing these tags when they've been
> > accidentally fetched again takes about 30 minutes using delete_ref.
>
> I also get really slow times on a repo with ~20,000 tags (though order
> ~3 minutes rather than ~30, probably due to having an SSD on this
> machine) -- but ONLY IF the refs are packed first (git pack-refs
> --all).  If the refs are loose, it's relatively quick to delete a
> dozen thousand or so tags (order of a few seconds).  It might be worth
> mentioning in the commit message that this only makes a significant
> difference in the case where the refs are packed.

I'm also using an SSD but I still see about 10 tags per second being
deleted with the current code (and packed-refs).  I see that I'm
CPU-bound, so I guess most of the time is spent searching through
.git/packed-refs.  Probably it will run faster as it progresses. I
guess the 18,000 branches in my repo keep me on the wrong end of O(N).

My VM is on an all-flash storage array, but I can't say much about its
write throughput since it's one VM among many.

Previously I thought I saw a significant speedup between v2.7.4 (on my
development vm) and v2.22.0 (on my laptop). But this week I saw it was
slow again on my laptop.  I looked for the regression but didn't find
anyone touching that code. Then I wrote this patch.

But it should have occurred to me while I was in the code that there
is a different path for unpacked refs which could explain my previous
speeds.  I didn't think I had any unpacked refs, though, since every
time I look in .git/refs for what I want, I find it relatively empty.
I see 'git pack-refs --help' says that new refs should show up loose,
but I can't say that has happened for me.  Maybe a new clone uses
packed-refs for *everything* and only newly fetched things are loose.
Is that it?  I guess since I seldom fetch tags after the first clone,
it makes sense they would all be packed.

> >     git tag -l feature/* | xargs git tag -d
> >
> > Removing the same tags using delete_refs takes less than 5 seconds.
>
> It appears this same bug also affects `git branch -d` when deleting
> lots of branches (or remote tracking branches) and they are all
> packed; could you apply the same fix there?

Will do.

> In constrast, it appears that `git update-ref --stdin` is fast
> regardless of whether the refs are packed, e.g.
>    git tag -l feature/* | sed -e 's%^%delete refs/tags/%' | git
> update-ref --stdin
> finishes quickly (order of a few seconds).

Nice!  That trick is going in my wiki for devs to use on their VMs.
Thanks for that.
