Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B6C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF4061378
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhE1W15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 18:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhE1W1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 18:27:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4939C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:26:15 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z3so5728414oib.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DWQEDiej8jiChvu8GqcsHPg5joTAeDv53mhTsUZoivg=;
        b=FCCRh1JqKfaePbS+L/HkgKDlianu67thh497jPJ8AcvU1o7isomoApoVMXcLg3pO4l
         9eWGJ1XASdr+PCAJ80vY1Wl7oi7TGN/4vuCq9zQw9+YYr6XX3Nbp8ZGOn6GiWBnKQjWZ
         Ez14Do+8bH95Ilt4jS2Lb9F7x5Gjn48GhDqFCAOsVfP8ugwXsietONapDWOl+k7zncNB
         cvGm2KxnmwzYyW+N8adOUWdagCF3j/uAravxlDBYICWLi96kLRT9ueZ8SMTatYkvhWfQ
         GtVDBuQvcKyYdUcBKglxuPj1ueISeB5NDtBj3+Ew4d4b5XM9JtXQ4xGJWdTQJ4Kg+vMo
         GD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DWQEDiej8jiChvu8GqcsHPg5joTAeDv53mhTsUZoivg=;
        b=DYjVAgNQEh69gu2Rgtrl8yJZIHMdhs5sgf57YGImASqIGHEY5x8XeefDahgIHmbAvz
         GVLi2p7iOre5KdKu5QMV0cWM27rfyexR38cB9OM0MeGxHtLZGH9tbHWAxx18fooDkisg
         1RpsC/+13G8Lb/9E+dbJqOKLFNGRxOyQ33/zWFtk/Z5JEvfq4Yxtk5zFG0I1Qq5FL744
         mcYhR5c6EK7M82Aq0nbjAhE0rbx6nuA9k6pt2IuwkOTzZ5FVI/ZnJTQzARqH1CXpYx9O
         23G/w14JBbNju9BoDBWZcRta9b7Th6u/OGMk+D+Fjh+3o1T5C6gfElLmPTUIEVikBUdo
         4tww==
X-Gm-Message-State: AOAM533xZ4zQ/mFOdH8hLZFSgVWU/XhQmiEpxEf/SpbD+39a7vZHUGuE
        Ql1tDvYsfzTcDKZNMJhj+EgZxWtP8ijAOKaRXs1AnN4DJ+w=
X-Google-Smtp-Source: ABdhPJxeoY3ZWImlEur/RJS1oQPf2votCcX0rbLjAisr2KhOgwjExzBPx2k211mB3IGtYKjj6TRyYjwG9A6YxlvOnW4=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr7595810oiw.31.1622240775132;
 Fri, 28 May 2021 15:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
 <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de> <CABPp-BEVME5Gx=F4HWHBb_0wn6XJF==DzVLo2i1xj63BB+_jtw@mail.gmail.com>
 <20210528214024.vw4huojcklrm6d27@pengutronix.de>
In-Reply-To: <20210528214024.vw4huojcklrm6d27@pengutronix.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 15:26:04 -0700
Message-ID: <CABPp-BG=nro4ydA9hAdq0A+AGX27_qCsy0sgrqfBLcGfFaQo8A@mail.gmail.com>
Subject: Re: time needed to rebase shortend by using --onto?
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Uwe,

On Fri, May 28, 2021 at 2:40 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Elijah,
>
> On Thu, May 27, 2021 at 04:08:32PM -0700, Elijah Newren wrote:
> > On Thu, May 27, 2021 at 2:59 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Wed, May 26, 2021 at 07:38:08AM -0700, Elijah Newren wrote:
> > > > On Wed, May 26, 2021 at 3:13 AM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
...
> > Note: In your original report you had rename detection and it clearly
> > took a significant amount of time...
>
> FTR: My impression is that the repo I used for the first report is slow
> in general. Also git log sometimes takes a considerable time to start
> emitting output.
>
...
>
> I learned a few things since my last mail, here comes an updated test
> again on the machine and repo used for the initial report:
>
>         ukl@dude.ptx:~/gsrc/linux$ wgit version
>         git version 2.32.0.rc1
>
>         ukl@dude.ptx:~/gsrc/linux$ cat rebasecheck
>         #!/bin/bash
>
>         set -e
>
>         # do it once to heat the caches and ensure all objects are availa=
ble already to have the next cycles identical.
>         wgit checkout 0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
>         wgit rebase v5.10
>
>         wgit checkout 0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
>         echo "rebase v5.10"
>         time wgit rebase v5.10
>
>         wgit checkout 0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
>         echo "rebase --onto v5.10 v5.4"
>         time wgit rebase --onto v5.10 v5.4
>
> I do the rebase now once before the timing for the reasons described in
> the comment. The second identical command is quite a bit quicker. Also
> now that the commands are scripted they are done in a smaller time frame
> (which matters as the machine is used heavily among my colleagues and
> me). I run the script a few times in a row, after all colleagues are in
> their week-end:
>
>         ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
>         ...
>         rebase v5.10
>         ...
>         real    1m13.579s
>         user    1m2.919s
>         sys     0m6.220s
>         ...
>         rebase --onto v5.10 v5.4
>         ...
>         real    1m2.852s
>         user    0m53.780s
>         sys     0m6.225s
>
>         ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
>         ...
>         rebase v5.10
>         ...
>         real    1m10.816s
>         user    1m3.344s
>         sys     0m6.991s
>         ...
>         rebase --onto v5.10 v5.4
>         ...
>         real    0m59.695s
>         user    0m53.510s
>         sys     0m5.579s
>
>         ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
>         ...
>         rebase v5.10
>         ...
>         real    1m9.688s
>         user    1m3.346s
>         sys     0m6.105s
>         ...
>         rebase --onto v5.10 v5.4
>         ...
>         real    0m59.981s
>         user    0m52.931s
>         sys     0m6.282s
>
> So it's not a factor 2 any more, but still reproducibly quicker when
> --onto is used.

Yep, so that looks like the results I was getting.  Adding
--reapply-cherry-picks should remove most of that time difference as I
stated in my previous email.

> > However, the 7-8 second difference (and the likely large differences
> > between 5.4 and 5.10) do suggest that Junio's hunch that fork-point
> > behavior being at play could be an issue in these two commands.

I don't think --no-fork-point will matter here since you are detaching
HEAD before running rebase.  fork-point is all about looking up the
reflog of the current branch to find better matches.
--reapply-cherry-picks should help you out and erase most of this 7-8
second difference.

> > > > running again with either command would give you something closer t=
o
> > > > the lower time both times.  Is that the case?  (Also, what's the
> > > > output of "git count-objects -v"?)
> > >
> > > After the above commands I have:
> > >
> > >         count: 3203
> > >         size: 17664
> > >         in-pack: 4763753
> > >         packs: 11
> > >         size-pack: 1273957
> > >         prune-packable: 19
> > >         garbage: 0
> > >         size-garbage: 0
> >
> > So, not freshly packed, but not in need of an automatic gc either.
> >
> > >         alternate: /home/uwe/var/gitstore/linux.git/objects
> >
> > You've got an alternate?  How well packed is it?  (What does "git
> > count-objects -v" in that other repo show?)
> >
...
>
> In the alternate I have:
>
>         ukl@dude.ptx:/ptx/src/git/linux.git/objects$ wgit count-objects -=
v
>         warning: garbage found: /ptx/work/user/git/linux.git/objects/pack=
/tmp_pack_X9gHnq
>         count: 5035

This is really close to the threshold of needing repacking, but still okay.

>         size: 40720
>         in-pack: 87083076
>         packs: 1108

1108 packs!?!?  This will make all kinds of operations slow.  This
explains your comment about operations with your original repo being
slow in general, and why you feel you need to do a warmup run first to
get a reasonable timing.  50 is the limit where repacking is deemed
necessary; you're 2116% beyond that point.  I've only seen repos with
pack counts near this level a couple times and they are excruciatingly
painful to deal with.

However, be careful not to use "git gc" or "git prune" in this repo,
since it's used as an alternate (doing so could corrupt the repos that
depend on this one).  Just use "git repack" with the appropriate flags
instead.

>         size-pack: 51109693

51G.  Wow.  A fresh clone of linux is waaay smaller than that.  3 G, I
think?  I would have thought lots of your packs were small, but this
suggests you probably have lots of duplicate objects in these packs.

>         prune-packable: 3050
>         garbage: 1
>         size-garbage: 1112612

And 1 G of garbage that could just be deleted.

> I rerun the script with -sort added:
>
>         ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
>         ...
>         rebase v5.10
>         ...
>         real    0m25.047s
>         user    0m17.652s
>         sys     0m5.802s
>         ...
>         rebase --onto v5.10 v5.4
>         ...
>         real    0m12.471s
>         user    0m7.854s
>         sys     0m4.413s
>
>         ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
>         ...
>         rebase v5.10
>         ...
>         real    0m22.180s
>         user    0m17.219s
>         sys     0m4.701s
>         ...
>         rebase --onto v5.10 v5.4
>         ...
>         real    0m12.341s
>         user    0m7.308s
>         sys     0m4.632s
>
> So -sort is quite a bit quicker, but the ~10s overhead when not using
> --onto is visible there, too.

Yeah, try adding --reapply-cherry-picks; I think that flag should
shrink most of the difference.

> When looking at the timing of the output, the 10s time difference occur
> before "Rebasing (1/4)" is emitted.
>
>         wgit rebase -sort --onto v5.10 v5.10
>
> behaves like
>
>         wgit rebase -sort v5.10
>
> and if I only rebase the first two patches (instead of four) it still
> takes nearly the same time. Another test I did was:
>
>         time wgit rebase -sort --onto v5.10 v5.7
>
>         real    0m17.712s
>         user    0m11.570s
>         sys     0m5.396s
>
> So there seems to be something before the actual rebase is done that
> takes longer when HEAD..$base contains more objects.
> Given that
>
>         ukl@dude.ptx:~/gsrc/linux$ time wgit log --oneline --cherry v5.10=
...0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
>         + 0091ecb84cfd (ptx/ukl/rebase-timing) nvmem: core: skip child no=
des not matching binding
>         + 38af1d38c542 spidev: add "hxxxxxxx,xxxxxx" compatible
>         + a7edcfb6a968 regmap: fix memory leak in regmap_debugfs_init()
>         + b1d90bc89408 pci: add quirk for txxxxx FPGA watchdog
>
>         real    0m10.783s
>         user    0m10.346s
>         sys     0m0.436s
>
> I guess this range is searched for commits that have the same patch id
> as the patches to rebase?

Yep, and --reapply-cherry-picks removes this cherry-searching.  Try it
and see how it affects your results.  I don't think it'll entirely
eliminate the differences for you (it didn't for me), because there
appears to be some other weird overhead -- part of it from
can_fast_forward() and more that I didn't track down further.  I do
think that the --reapply-cherry-picks will remove most of the
differences for you, though.

> FTR: In the above repo I have:
>
>         ukl@dude.ptx:~/gsrc/linux$ wgit config merge.renameLimit
>         10000

Yep, so my choice of 9999 to try to reproduce your behavior was a
pretty good pick, eh?  :-)


Hope that helps,
Elijah
