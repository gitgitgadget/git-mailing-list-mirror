Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31046C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0589561075
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhFPBsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhFPBsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:48:40 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B137C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 18:46:35 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b9so920782ilr.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rosekunkel-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9JESvSo32N9VaBCOR753syiKNPVL9UwMz53KuOHm6EA=;
        b=yXYH+HmmbjORw8uCmg8sW8KX3CW/m9nERBbgNAp4ByyolPIWXBcIQhUQPXh38QB3pQ
         T0LEk0c3l9AIO4nGwSGWousRzpyFNHl8apHRYLfk2jdRgc73xYR2tunJHUIYQZafRvTQ
         cCjIfj6SKi0tD5yJMrGaYLgaZlCh2k8NyMBTcwpfDtE2JMWygyJNth1MJCslCYgBL6my
         7LdpzRknUj6HVNB+LBKfN4jaA3D6kN64ILuKz1DZDciAUbeVBGmdYg0VjfD7OKUQIUit
         3zlWLH6kPDE0/zkn33/JMaIAtsXnyGi0BfvTJ3Ho3qJb6HwlRfMCpYNHNDbJ5R1NH3+q
         LF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9JESvSo32N9VaBCOR753syiKNPVL9UwMz53KuOHm6EA=;
        b=ohA3xO59uhKIPgwGyhYIxBs0l8t+gaRLEFpWRG05TQKa3gIWhsxMnccYIazaK1c2K/
         Jcsz4EDeP93CiXfGnidp/VopGXJuXpwZY3OqtBq3x9YC6ONirRD8OfWSPjHDqUod1rKw
         VR+wUr7He9RY0uMVooujwomKjvxLj1HWVO6zLaj5G5lGpboYQcOS+C0nRN4qvzghKFav
         YDq7eM6orlHlHMS5+0VP5rR9YWyPnTQjaAXFA30H2uLovXGVYf/pvhc9bjvRIiNk+/+p
         IFOTJPtOmCx3IInjtlEcODZ7FqNJSp2/2DfPMzuatgQ/Pwqcm855Xuo27ZI0q5a3ZmW4
         p4tQ==
X-Gm-Message-State: AOAM532AY28YpS8XYnfoc9S2HDLBv20gasqp1fmP0k8mZRAMvxCW/E0x
        3j5KX1kO2kWXMKeH+JrDru6UL6xkvHOj//SIAWe6S4VnYvc=
X-Google-Smtp-Source: ABdhPJzL4VY5fOVmuJIBByCo16lF/1G71jidlHtqCCED7S9yY0ti0idlgVxdOdDHAL+hZ/tqjWIIa34ueXmAbITYs1s=
X-Received: by 2002:a05:6e02:ed3:: with SMTP id i19mr1778826ilk.107.1623807994485;
 Tue, 15 Jun 2021 18:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net> <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
 <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
 <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net> <CAKjYmsFVfMW4DKz4cA_fNugGim4m+-aJgOW+k0za+T-D8YHc7g@mail.gmail.com>
In-Reply-To: <CAKjYmsFVfMW4DKz4cA_fNugGim4m+-aJgOW+k0za+T-D8YHc7g@mail.gmail.com>
From:   Rose Kunkel <rose@rosekunkel.me>
Date:   Tue, 15 Jun 2021 18:46:23 -0700
Message-ID: <CAKjYmsEjizYapQVy+pzm9mOxS=0EBwEgzqsO1xO-ct-1AdYuZQ@mail.gmail.com>
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually, nevermind that last comment. I misunderstood what `git
submodule init` does. I thought it cloned missing submodules, but
apparently that's done by `git submodule update`, so the behavior does
make sense.

On Tue, Jun 15, 2021 at 6:39 PM Rose Kunkel <rose@rosekunkel.me> wrote:
>
> That sounds reasonable to me.
>
> I do think it's pretty unintuitive that `update = none` means that
> submodules never get initialized, even with an explicit `git submodule
> init` command. If this is intended behavior, it should be better
> documented. If not, fixing that would also fix this bug.
>
> On Tue, Jun 15, 2021 at 6:25 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2021-06-16 at 01:03:40, Rose Kunkel wrote:
> > > Potentially relevant: `git config --global --list` shows
> > > ```
> > > status.showstash=true
> > > status.submodulesummary=true
> > > submodule.recurse=true
> >
> > Thanks for this additional information.  This line is the critical
> > piece.  Now I get this:
> >
> >   $ git reset --hard
> >   fatal: not a git repository: ../../.git/modules/repos/agda
> >   fatal: could not reset submodule index
> >
> > Predictably, "git -c submodules.recurse=true reset --hard" also results
> > in the same thing.
> >
> > The --recurse-submodules option for git reset says this (emphasis mine):
> >
> >   When the working tree is updated, using --recurse-submodules will also
> >   recursively reset the working tree of all *active* submodules
> >   according to the commit recorded in the superproject, also setting the
> >   submodules' HEAD to be detached at that commit.
> >
> > On my system, .git/config has this:
> >
> >   [submodule]
> >           active = .
> >
> > So these submodules are active, but they probably should not be, since
> > we haven't checked anything out (or, for that matter, cloned any data)
> > and it wouldn't make sense to try to operate on them automatically with
> > submodules.recurse or --recurse-submodules.
> >
> > My gut tells me that we should probably mark submodules with update=none
> > set on a clone as inactive.  Of course, this is a tricky area that I'm
> > not super familiar with, so opinions or thoughts are welcome.
> >
> > If folks think this is a good way forward, I'll look into writing a
> > patch, probably tomorrow evening since it's starting to get late here.
> > --
> > brian m. carlson (he/him or they/them)
> > Toronto, Ontario, CA
