Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A2C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 05:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiC0F3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 01:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiC0F3o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 01:29:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73EFCDC
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 22:28:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k21so19720590lfe.4
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cJXAW9TUhp5sTR2D9dEcLKTBfdSyqfWEGdQQArjaCWs=;
        b=qI/TZbE5rwSyv53BMq3pggjD+Xa/IURKRWRklfIHT0ErgtCJRS0bAF7jeRxnz6CVIP
         RSBLWiO7eN761mDNiv0I2bBTkOkJRUdH4ZcNrBok2RHSDMRosPHsQtxFBDAUYX95ibzG
         SFkoIWq5Cgr0MrlwBxqA+28VTlEKmCT8bgPQeKPXTKERp+UwvqhAvcton/DkqvUtYHig
         M8fxURQeomhYPqzvMHgWzOSDB8Y+QM+OjgiAisIR57K7TEQtsQ3pIzByLuUK719+1so1
         cHK6L4Q+W7P/gh6n5l8VqaGseo8I4lMNuiNEEZszXEffgwD0xeXtGN/K+cLy2DUI1Owf
         A9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cJXAW9TUhp5sTR2D9dEcLKTBfdSyqfWEGdQQArjaCWs=;
        b=BZbVSMbsiJbkTvESNhs2kWEhskxOmyagEO8tMVtwzalBhOtWJLRIcUkAx9t4HwXEXj
         FI86cw0vycLQVMiQW3bFteRsYsJLqf5hvTAu9fQ3K9+OhvY3QnIg3fddo3Uw6hzQisVX
         iJ+BH31h7BJDQbiu571D9omcso3K8QJuA3GdUCcVvMXoqLbnfXw4r4ZvmYoz0pwsqLLe
         D++RqI/s8gb5fSDgL7dGFzCbYgdrgA1QWHloFwpfPXJ3aPJDw0PiaDI+/bs/dEVH5JEJ
         icBNX2JOMVV3rr3co4ywusWyL99ikcAIVgWwTD4aojDvakoEo66jxfiSPB7NYi3fPOO7
         fimw==
X-Gm-Message-State: AOAM532tg/djDlCvYyKeIF1kv6R00AnM22CA1C29EU/pDTAeYjExTHt0
        OGBJD/RPrCdM8WdibpHtXM0NyI3j1bcGE46zj1s=
X-Google-Smtp-Source: ABdhPJwKOEnIvmu0bV4VtlPmwrL31GTzevzQJ8PHyJ+zcXA6BFrkkpwCwg0d6U/uqWaCFwZ98mLal9DTlJpe1WJeOgk=
X-Received: by 2002:a05:6512:3f09:b0:43a:4463:56f9 with SMTP id
 y9-20020a0565123f0900b0043a446356f9mr14219739lfa.533.1648358882693; Sat, 26
 Mar 2022 22:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com> <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
 <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
 <220326.86ils1lfho.gmgdl@evledraar.gmail.com> <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
 <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Sat, 26 Mar 2022 22:27:52 -0700
Message-ID: <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
Subject: Re: do we have too much fsync() configuration in 'next'? (was: [PATCH
 v7] core.fsync: documentation and user-friendly aggregate options)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 26, 2022 at 8:34 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Mar 25 2022, Neeraj Singh wrote:
>
> > On Fri, Mar 25, 2022 at 5:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Fri, Mar 25 2022, Neeraj Singh wrote:
> >>
> >> > On Wed, Mar 23, 2022 at 7:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> >> > <avarab@gmail.com> wrote:
> >> >>
> >> >>
> >> >> On Tue, Mar 15 2022, Neeraj Singh wrote:
> >> >>
> >> >> I know this is probably 80% my fault by egging you on about initial=
ly
> >> >> adding the wildmatch() based thing you didn't go for.
> >> >>
> >> >> But having looked at this with fresh eyes quite deeply I really thi=
nk
> >> >> we're severely over-configuring things here:
> >> >>
> >> >> > +core.fsync::
> >> >> > +     A comma-separated list of components of the repository that
> >> >> > +     should be hardened via the core.fsyncMethod when created or
> >> >> > +     modified.  You can disable hardening of any component by
> >> >> > +     prefixing it with a '-'.  Items that are not hardened may b=
e
> >> >> > +     lost in the event of an unclean system shutdown. Unless you
> >> >> > +     have special requirements, it is recommended that you leave
> >> >> > +     this option empty or pick one of `committed`, `added`,
> >> >> > +     or `all`.
> >> >> > ++
> >> >> > +When this configuration is encountered, the set of components st=
arts with
> >> >> > +the platform default value, disabled components are removed, and=
 additional
> >> >> > +components are added. `none` resets the state so that the platfo=
rm default
> >> >> > +is ignored.
> >> >> > ++
> >> >> > +The empty string resets the fsync configuration to the platform
> >> >> > +default. The default on most platforms is equivalent to
> >> >> > +`core.fsync=3Dcommitted,-loose-object`, which has good performan=
ce,
> >> >> > +but risks losing recent work in the event of an unclean system s=
hutdown.
> >> >> > ++
> >> >> > +* `none` clears the set of fsynced components.
> >> >> > +* `loose-object` hardens objects added to the repo in loose-obje=
ct form.
> >> >> > +* `pack` hardens objects added to the repo in packfile form.
> >> >> > +* `pack-metadata` hardens packfile bitmaps and indexes.
> >> >> > +* `commit-graph` hardens the commit graph file.
> >> >> > +* `index` hardens the index when it is modified.
> >> >> > +* `objects` is an aggregate option that is equivalent to
> >> >> > +  `loose-object,pack`.
> >> >> > +* `derived-metadata` is an aggregate option that is equivalent t=
o
> >> >> > +  `pack-metadata,commit-graph`.
> >> >> > +* `committed` is an aggregate option that is currently equivalen=
t to
> >> >> > +  `objects`. This mode sacrifices some performance to ensure tha=
t work
> >> >> > +  that is committed to the repository with `git commit` or simil=
ar commands
> >> >> > +  is hardened.
> >> >> > +* `added` is an aggregate option that is currently equivalent to
> >> >> > +  `committed,index`. This mode sacrifices additional performance=
 to
> >> >> > +  ensure that the results of commands like `git add` and similar=
 operations
> >> >> > +  are hardened.
> >> >> > +* `all` is an aggregate option that syncs all individual compone=
nts above.
> >> >> > +
> >> >> >  core.fsyncMethod::
> >> >> >       A value indicating the strategy Git will use to harden repo=
sitory data
> >> >> >       using fsync and related primitives.
> >> >>
> >> >> On top of my
> >> >> https://lore.kernel.org/git/RFC-patch-v2-7.7-a5951366c6e-20220323T1=
40753Z-avarab@gmail.com/
> >> >> which makes the tmp-objdir part of your not-in-next-just-seen follo=
w-up
> >> >> series configurable via "fsyncMethod.batch.quarantine" I really thi=
nk we
> >> >> should just go for something like the belwo patch (note that
> >> >> misspelled/mistook "bulk" for "batch" in that linked-t patch, fixed
> >> >> below.
> >> >>
> >> >> I.e. I think we should just do our default fsync() of everything, a=
nd
> >> >> probably SOON make the fsync-ing of loose objects the default. Thos=
e who
> >> >> care about performance will have "batch" (or "writeout-only"), whic=
h we
> >> >> can have OS-specific detections for.
> >> >>
> >> >> But really, all of the rest of this is unduly boxing us into
> >> >> overconfiguration that I think nobody really needs.
> >> >>
> >> >
> >> > We've gone over this a few times already, but just wanted to state i=
t
> >> > again.  The really detailed settings are really there for Git hoster=
s
> >> > like GitLab or GitHub. I'd be happy to remove the per-component
> >> > core.fsync values from the documentation and leave just the ones we
> >> > point the user to.
> >>
> >> I'm prettty sure (but Patrick knows more) that GitLab's plan for this =
is
> >> to keep it at whatever the safest setting is, presumably GitHub's as
> >> well (but I don't know at all on that front).
> >>
> >> >> If someone really needs this level of detail they can LD_PRELOAD
> >> >> something to have fsync intercept fd's and paths, and act appropria=
tely.
> >> >>
> >> >> Worse, as the RFC series I sent
> >> >> (https://lore.kernel.org/git/RFC-cover-v2-0.7-00000000000-20220323T=
140753Z-avarab@gmail.com/)
> >> >> shows we can and should "batch" up fsync() operations across these
> >> >> configuration boundaries, which this level of configuration would s=
eem
> >> >> to preclude.
> >> >>
> >> >> Or, we'd need to explain why "core.fsync=3Dloose-object" won't *act=
ually*
> >> >> call fsync() on a single loose object's fd under "batch" as I had t=
o do
> >> >> on top of this in
> >> >> https://lore.kernel.org/git/RFC-patch-v2-6.7-c20301d7967-20220323T1=
40753Z-avarab@gmail.com/
> >> >>
> >> >
> >> > 99.9% of users don't care and won't look.  The ones who do look deep=
er
> >> > and understand the issues have source code and access to this ML
> >> > discussion to understand why this works this way.
> >>
> >> Exactly, so we can hopefully have a simpler interface.
> >>
> >> >> The same is going to apply for almost all of the rest of these
> >> >> configuration categories.
> >> >>
> >> >> I.e. a natural follow-up to e.g. batching across objects & index as=
 I'm
> >> >> doing in
> >> >> https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T1=
40753Z-avarab@gmail.com/
> >> >> is to do likewise for all the PACK-related stuff before we rename i=
t
> >> >> in-place. Or even have "git gc" issue only a single fsync() for all=
 of
> >> >> PACKs, their metadata files, commit-graph etc., and then rename() t=
hings
> >> >> in-place as appropriate afterwards.
> >> >>
> >> >> diff --git a/Documentation/config/core.txt b/Documentation/config/c=
ore.txt
> >> >> index 365a12dc7ae..536238e209b 100644
> >> >> --- a/Documentation/config/core.txt
> >> >> +++ b/Documentation/config/core.txt
> >> >> @@ -548,49 +548,35 @@ core.whitespace::
> >> >>    errors. The default tab width is 8. Allowed values are 1 to 63.
> >> >>
> >> >>  core.fsync::
> >> >> -       A comma-separated list of components of the repository that
> >> >> -       should be hardened via the core.fsyncMethod when created or
> >> >> -       modified.  You can disable hardening of any component by
> >> >> -       prefixing it with a '-'.  Items that are not hardened may b=
e
> >> >> -       lost in the event of an unclean system shutdown. Unless you
> >> >> -       have special requirements, it is recommended that you leave
> >> >> -       this option empty or pick one of `committed`, `added`,
> >> >> -       or `all`.
> >> >> -+
> >> >> -When this configuration is encountered, the set of components star=
ts with
> >> >> -the platform default value, disabled components are removed, and a=
dditional
> >> >> -components are added. `none` resets the state so that the platform=
 default
> >> >> -is ignored.
> >> >> -+
> >> >> -The empty string resets the fsync configuration to the platform
> >> >> -default. The default on most platforms is equivalent to
> >> >> -`core.fsync=3Dcommitted,-loose-object`, which has good performance=
,
> >> >> -but risks losing recent work in the event of an unclean system shu=
tdown.
> >> >> -+
> >> >> -* `none` clears the set of fsynced components.
> >> >> -* `loose-object` hardens objects added to the repo in loose-object=
 form.
> >> >> -* `pack` hardens objects added to the repo in packfile form.
> >> >> -* `pack-metadata` hardens packfile bitmaps and indexes.
> >> >> -* `commit-graph` hardens the commit graph file.
> >> >> -* `index` hardens the index when it is modified.
> >> >> -* `objects` is an aggregate option that is equivalent to
> >> >> -  `loose-object,pack`.
> >> >> -* `derived-metadata` is an aggregate option that is equivalent to
> >> >> -  `pack-metadata,commit-graph`.
> >> >> -* `committed` is an aggregate option that is currently equivalent =
to
> >> >> -  `objects`. This mode sacrifices some performance to ensure that =
work
> >> >> -  that is committed to the repository with `git commit` or similar=
 commands
> >> >> -  is hardened.
> >> >> -* `added` is an aggregate option that is currently equivalent to
> >> >> -  `committed,index`. This mode sacrifices additional performance t=
o
> >> >> -  ensure that the results of commands like `git add` and similar o=
perations
> >> >> -  are hardened.
> >> >> -* `all` is an aggregate option that syncs all individual component=
s above.
> >> >> +       A boolen defaulting to `true`. To ensure data integrity git
> >> >> +       will fsync() its objects, index and refu updates etc. This =
can
> >> >> +       be set to `false` to disable `fsync()`-ing.
> >> >> ++
> >> >> +Only set this to `false` if you know what you're doing, and are
> >> >> +prepared to deal with data corruption. Valid use-cases include
> >> >> +throwaway uses of repositories on ramdisks, one-off mass-imports
> >> >> +followed by calling `sync(1)` etc.
> >> >> ++
> >> >> +Note that the syncing of loose objects is currently excluded from
> >> >> +`core.fsync=3Dtrue`. To turn on all fsync-ing you'll need
> >> >> +`core.fsync=3Dtrue` and `core.fsyncObjectFiles=3Dtrue`, but see
> >> >> +`core.fsyncMethod=3Dbatch` below for a much faster alternative tha=
t's
> >> >> +just as safe on various modern OS's.
> >> >> ++
> >> >> +The default is in flux and may change in the future, in particular=
 the
> >> >> +equivalent of the already-deprecated `core.fsyncObjectFiles` setti=
ng
> >> >> +might soon default to `true`, and `core.fsyncMethod`'s default of
> >> >> +`fsync` might default to a setting deemed to be safe on the local =
OS,
> >> >> +suc has `batch` or `writeout-only`
> >> >>
> >> >>  core.fsyncMethod::
> >> >>         A value indicating the strategy Git will use to harden repo=
sitory data
> >> >>         using fsync and related primitives.
> >> >>  +
> >> >> +Defaults to `fsync`, but as discussed for `core.fsync` above might
> >> >> +change to use one of the values below taking advantage of
> >> >> +platform-specific "faster `fsync()`".
> >> >> ++
> >> >>  * `fsync` uses the fsync() system call or platform equivalents.
> >> >>  * `writeout-only` issues pagecache writeback requests, but dependi=
ng on the
> >> >>    filesystem and storage hardware, data added to the repository ma=
y not be
> >> >> @@ -680,8 +666,8 @@ backed up by any standard (e.g. POSIX), but wor=
ked in practice on some
> >> >>  Linux setups.
> >> >>  +
> >> >>  Nowadays you should almost certainly want to use
> >> >> -`core.fsync=3Dloose-object` instead in combination with
> >> >> -`core.fsyncMethod=3Dbulk`, and possibly with
> >> >> +`core.fsync=3Dtrue` instead in combination with
> >> >> +`core.fsyncMethod=3Dbatch`, and possibly with
> >> >>  `fsyncMethod.batch.quarantine=3Dtrue`, see above. On modern OS's (=
Linux,
> >> >>  OSX, Windows) that gives you most of the performance benefit of
> >> >>  `core.fsyncObjectFiles=3Dfalse` with all of the safety of the old
> >> >
> >> > I'm at the point where I don't want to endlessly revisit this discus=
sion.
> >>
> >> Sorry, my intention isn't to frustrate you, but I do think it's
> >> important to get this right.
> >>
> >> Particularly since this is now in "next", and we're getting closer to =
a
> >> release. We can either talk about this now and decide on something, or
> >> it'll be in a release, and then publicly documented promises will be
> >> harder to back out of.
> >>
> >> I think your suggestion of just hiding the relevant documentation woul=
d
> >> be a good band-aid solution to that.
> >>
> >> But I also think that given how I was altering this in my RFC series
> >> that the premise of how this could be structured has been called into
> >> question in a way that we didn't (or I don't recall) us having discuss=
ed
> >> before.
> >>
> >> I.e. that we can say "sync loose, but not index", or "sync index, but
> >> not loose" with this config schema. When with "bulk" we it really isn'=
t
> >> any more expensive to do both if one is true (even cheaper, actually).
> >>
> >
> > I want to make a comment about the Index here.  Syncing the index is
> > strictly required for the "added" level of consistency, so that we
> > don't lose stuff that leaves the work tree but is staged.  But my
> > Windows enlistment has an index that's 266MB, which would be painful
> > to sync even with all the optimizations.  Maybe with split-index, this
> > wouldn't be so bad, but I just wanted to call out that some advanced
> > users may really care about the configurability.
>
> So for that use-case you'd like to fsync the loose objects (if any), but
> not the index? So the FS will "flush" up to the index, and then queue
> the index for later syncing to platter?
>
>
> But even in that case don't the settings need to be tied to one another,
> because in the method=3Dbulk sync=3Dindex && sync=3D!loose case wouldn't =
we be
> syncing "loose" in any case?
>
> > As Git's various database implementations improve, the fsync stuff
> > will hopefully be more optimal and self-tuning.  But as that happens,
> > Git could just start ignoring settings that lose meaning without tying
> > anyones hands.
>
> Yeah that would alleviate most of my concerns here, but the docs aren't
> saying anything like that. Since you added them & they just landed, do
> you mind doing a small follow-up where we e.g. say that these new
> settings are "EXPERIMENTAL" or whatever, and subject to drastic change?

The doc is already pretty prescriptive.  It has this line at the end
of the first  paragraph:
"Unless you
have special requirements, it is recommended that you leave
this option empty or pick one of `committed`, `added`,
or `all`."

Those values are already designed to change as Git changes.
