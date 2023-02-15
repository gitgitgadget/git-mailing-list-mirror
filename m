Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6596C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 03:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBODmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 22:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBODmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 22:42:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270272ED57
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 19:42:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bi36so26052356lfb.8
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 19:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4FNMaykJd49HJEXccMNal2voT2OqySsDgMFwumrYls=;
        b=l78LxH9ajMJy4V4g17DL9cPsDnKTy9cheJxXrhi4OyFSJsL/bZqi12MEdykTbNCjjM
         LM7JTLHzUPnocRee2gP2cAGj2v60Ya0Xzf9cFMagc1gzL3TuvyRvZXRncjCNSDUv3EOT
         2uLpSqonKzukwjlsCPt0FNltB6x0K3AwitdMpX8uX9v4wlf4MxXWtaglwcJIw6xzOxwv
         HueIdvWdZgPMezw1CmX4dT7jjDNH5fAvOyDJlsb/syv82ybF6/hk+CzOaP0m+EEXLkb4
         CKQQUJ489kIUckCEM6CTER883tMNgRY5rUGtPV8lt2F/U/XdNQu7CCkVhuTmv1j+6rxx
         sFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4FNMaykJd49HJEXccMNal2voT2OqySsDgMFwumrYls=;
        b=xtdse4F/TWZ7o7L6y1ad3wsMg4+kdH3ORKDidm03FJvhlVw+hOzE+49CoiKgUgb8uS
         1c08E2s6QoAs3p47xD0uLZas+C53yhcCqWtzyfXxwRWd7MkK1at9GDrn+Xjwdc2icwmB
         bMsvF3tcL70fZGaR8otXtA97qfWDZ/RPM70fBICIeHbA9/RsjPSkOWD5Fg9vU/Xye0kP
         YG2Ww1h8GTTfsxHuVNVxSjukN+vfhHtR1dHTELIA/5X3huk44eweXcjDUlv4cGKIP2r5
         Wq1Ai3AiI9Pjx6DoaXS/nfv2a0bm29uKNL/uJOJ0BSFZsFrqcwWOLRcCJv+yXEi+J90K
         XOvA==
X-Gm-Message-State: AO0yUKVvSGddSSvcr7KD0V+TmRqj4s4wM7bQHypM3PmmUJ5Y3fqgG4uM
        dGNvGRNyRyRCdiFUq4gdyNZ5ngBb/pXrfcr7wB2JEvtxE63/PA==
X-Google-Smtp-Source: AK7set8HiWbmbEVRecc950nr9YxKvmOvavGtFPD5z5FGzjxgEVc/zbAg0+SSG7UjwpqQXiVdW+RROn8nDl/dMRjzTzw=
X-Received: by 2002:ac2:54b8:0:b0:4d8:50e1:8ba7 with SMTP id
 w24-20020ac254b8000000b004d850e18ba7mr111500lfk.2.1676432519029; Tue, 14 Feb
 2023 19:41:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com> <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <CABPp-BFKQXe-EJOd9z1TrisL64NuV9A132rf9MwV_7w79QQ9YQ@mail.gmail.com> <AF5092D2-A561-4B56-8FB8-25DCFA28F32C@gmail.com>
In-Reply-To: <AF5092D2-A561-4B56-8FB8-25DCFA28F32C@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Feb 2023 19:41:00 -0800
Message-ID: <CABPp-BGmFemkiD1OFrrOdaJt9PjGRp+QHoV_azPqvTtx6CdD9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     John Cai <johncai86@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John!

On Tue, Feb 14, 2023 at 1:16 PM John Cai <johncai86@gmail.com> wrote:
> On 9 Feb 2023, at 3:44, Elijah Newren wrote:
> > On Mon, Feb 6, 2023 at 12:47 PM John Cai <johncai86@gmail.com> wrote:
> >>
[...]
> It seems like the performance penalty was because I was adding calls to p=
arse
> attribute files. Piggy backing off of the attribute parsing in userdiff.h=
 will
> allow us to not incur this performance penalty:
>
> $ hyperfine -r 5 -L a bin-wrappers/git,git '{a} diff v2.0.0 v2.28.0'
> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.072 s =C2=B1  0.289 s    [User: 0.626=
 s, System: 0.081 s]
>   Range (min =E2=80=A6 max):    0.772 s =E2=80=A6  1.537 s    5 runs
>
> Benchmark 2: git diff v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.003 s =C2=B1  0.065 s    [User: 0.684=
 s, System: 0.067 s]
>   Range (min =E2=80=A6 max):    0.914 s =E2=80=A6  1.091 s    5 runs
>
> Summary
>   'git diff v2.0.0 v2.28.0' ran
>     1.07 =C2=B1 0.30 times faster than 'git-bin-wrapper diff v2.0.0 v2.28=
.0'

Yaay!  Much better.  :-)

I'm curious, though, whether you are showing here a 7% slowdown (which
would still be bad), or just that the feature is correctly choosing a
different (but slower) algorithm for some files, or some kind of mix.

What is the performance difference if you have this feature included,
but don't have any directives in .gitattributes selecting a different
diff algorithm for any files?

> > And on a separate note...
> >
> > There's another set of considerations we might need to include here as
> > well that I haven't seen anyone else in this thread talk about:
>
> These are some great questions. I'll do my best to answer them.
> >
> > * When trying to diff files, do we read the .gitattributes file from
> > the current checkout to determine the diff algorithm(s)?  Or the
> > index?  Or the commit we are diffing against?
> > * If we use the current checkout or index, what about bare clones or
> > diffing between two different commits?
> > * If diffing between two different commits, and the .gitattributes has
> > changed between those commits, which .gitattributes file wins?
> > * If diffing between two different commits, and the .gitattributes has
> > NOT changed, BUT a file has been renamed and the old and new names
> > have different rules, which rule wins?
>
> In the next version I plan on using Peff's suggestion of utilizing the ex=
isting
> diff driver scheme [1]. I believe these four questions are addressed if w=
e use
> the existing userdiff.h API, which in turn calls the attr.h API. We check=
 the
> worktree, then fallback to the index.

So...it sounds like we're just ignoring all the special cases listed
above, and living with bugs related to them?  That's not a criticism;
in fact, it might be okay -- after all, that's exactly what the
existing .gitattributes handling does and you are just hooking into
it.

I am a bit concerned, though, that we're increasing the visibility of
the interactions of .gitattributes with respect to these kinds of
cases.  I think external drivers are probably much less used than what
your feature might be, so folks are more likely to stumble into these
cases and complain.  Perhaps those cases are rare enough that we don't
care, but it might be at least worth documenting the issues (both to
manage user expectations and to give people a heads up about the
potential issues.)

(Also, it may be worth mentioning that I tend to focus on unusual
cases for anything that might touch merging; Junio once named one of
my patchsets "en/t6042-insane-merge-rename-testcases".  It's possible
I worry about corner cases more than is justified given their real
world likelihood.)

> By using the userdiff.h API, the behavior will match what users already e=
xpect
> when they for instance set an external driver.

s/already expect/already get/

The bugs also affect external drivers; I just suspect external drivers
aren't used enough that users have complained very loudly (yet?).

> 1. https://lore.kernel.org/git/Y+KQtqNPews3vBS8@coredump.intra.peff.net/
>
> >
> > * If per-file diff algorithms are adopted widely enough, will we be
> > forced to change the merge algorithm to also pay attention to them?
> > If it does, more complicated rename cases occur and we need rules for
> > how to handle those.
> > * If the merge algorithm has to pay attention to .gitattributes for
> > this too, we'll have even more corner cases around what happens if
> > there are merge conflicts in .gitattributes itself (which is already
> > kind of ugly and kludged)
>
> I see this feature as a user-experience type convenience feature, so I do=
n't
> believe there's need for the merge machinery to also pay attention to the=
 diff
> algorithm set through gitattrbutes. We can clarify this in the documentat=
ion.

That would be awesome; *please* do this.  This is my primary concern
with this patchset.

I've spent an awful lot of time dealing with weird corner cases in the
merge machinery, and this appears to open a big can of worms to me.
It'd be a huge relief if we just agreed that the .gitattributes
handling here is only meant for user-facing diffs and will not be
consulted by the merge machinery.

> > Anyway, I know I'm a bit animated and biased in this area, and I
> > apologize if I'm a bit too much so.  Even if I am, hopefully my
> > comments at least provide some useful context.
>
> No problem! thanks for raising these issues.
>
> thanks
> John
