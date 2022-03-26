Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1EFC433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 15:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiCZPgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiCZPgS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 11:36:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DFB04
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 08:34:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y10so12271873edv.7
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BKnm6w4kXwkhVz/aXqZULRgpEIlTCRRtJ8xk27EniZw=;
        b=pN0Q3LsR+qYWiWsJbG4NrRGGwWdPtz/lr1jLMuXMp/oQbuP6T9ZhipxsDLbXPuV651
         kJ/4QFgPQ6ayj/TRp90pcU5wPq0HpGoLpSAQXgyPtVmElfi1wnbVe8j9LzMX5fCzkEKg
         C8x+sL/7Toz1qNHNJGE7YtETaJsO3sGxP6IRCckXvsFOqiZYkh2a+hgqttzYLm3AuCQC
         EGFqmqsWnM8+IsGtcvi2bhk1QM8nNvRlLZH8l8fwf+ZxEerAGaDcmpx2sOs2rZO1D+h+
         eEu08JkjZGib3OFDz+2biEaVNqFUqsDV34k+94N+g8NR/eqzrcBRXBxOr2BJsJRIBzI7
         +ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BKnm6w4kXwkhVz/aXqZULRgpEIlTCRRtJ8xk27EniZw=;
        b=DBAvJLS0csGkzxxbMi8Bl7KR1/I69RFVNL4KLmV9lyaxurHcRfeXvc+AtpkVo41Xdl
         cmB2N51MS5qXyWYDynUfvveHjwrp9X57/DEPItXq599/Yh4xuA/oAuRiWnJKmvbEFPz0
         BsRPspQJS3makNLiOScORxKRT7PGcYCbTYI/skwxqsslq9/yoFJ1kn2/Mpi0lQotMFA3
         Zj8WBwq5gcoKxAxmHYOmKqDH3zUKEfgVWOae2lBLhRUAaTzeTUAu15Q1XoUta7CtI/rc
         iuezK7Tzgp75FGNS4qEYhK6OU7YIlSAioN2O7NWymSG85sILvrY2SKhifKd3za72HKqO
         7Ktw==
X-Gm-Message-State: AOAM531fH2SpckblGFfFC7tIuEIfKwwlBF3NpFBCQIuVFaPeyrJVv9y4
        0ZEjaHvrlIKaLTUUsD4PlEQ=
X-Google-Smtp-Source: ABdhPJw68Qx/kGwi5D5nJAH2YOW28pWJmH72u1r+EDhtTcj1N1lJBt7cwhcxE3XL35Ov9HF5/Fn8fA==
X-Received: by 2002:a05:6402:187:b0:415:c784:abe0 with SMTP id r7-20020a056402018700b00415c784abe0mr5249667edv.168.1648308878938;
        Sat, 26 Mar 2022 08:34:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm4357815edx.58.2022.03.26.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:34:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nY8R3-002TXm-79;
        Sat, 26 Mar 2022 16:34:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: do we have too much fsync() configuration in 'next'? (was:
 [PATCH v7] core.fsync: documentation and user-friendly aggregate options)
Date:   Sat, 26 Mar 2022 16:31:28 +0100
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com>
 <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
 <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
 <220326.86ils1lfho.gmgdl@evledraar.gmail.com>
 <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
Message-ID: <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Neeraj Singh wrote:

> On Fri, Mar 25, 2022 at 5:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Fri, Mar 25 2022, Neeraj Singh wrote:
>>
>> > On Wed, Mar 23, 2022 at 7:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>
>> >>
>> >> On Tue, Mar 15 2022, Neeraj Singh wrote:
>> >>
>> >> I know this is probably 80% my fault by egging you on about initially
>> >> adding the wildmatch() based thing you didn't go for.
>> >>
>> >> But having looked at this with fresh eyes quite deeply I really think
>> >> we're severely over-configuring things here:
>> >>
>> >> > +core.fsync::
>> >> > +     A comma-separated list of components of the repository that
>> >> > +     should be hardened via the core.fsyncMethod when created or
>> >> > +     modified.  You can disable hardening of any component by
>> >> > +     prefixing it with a '-'.  Items that are not hardened may be
>> >> > +     lost in the event of an unclean system shutdown. Unless you
>> >> > +     have special requirements, it is recommended that you leave
>> >> > +     this option empty or pick one of `committed`, `added`,
>> >> > +     or `all`.
>> >> > ++
>> >> > +When this configuration is encountered, the set of components star=
ts with
>> >> > +the platform default value, disabled components are removed, and a=
dditional
>> >> > +components are added. `none` resets the state so that the platform=
 default
>> >> > +is ignored.
>> >> > ++
>> >> > +The empty string resets the fsync configuration to the platform
>> >> > +default. The default on most platforms is equivalent to
>> >> > +`core.fsync=3Dcommitted,-loose-object`, which has good performance,
>> >> > +but risks losing recent work in the event of an unclean system shu=
tdown.
>> >> > ++
>> >> > +* `none` clears the set of fsynced components.
>> >> > +* `loose-object` hardens objects added to the repo in loose-object=
 form.
>> >> > +* `pack` hardens objects added to the repo in packfile form.
>> >> > +* `pack-metadata` hardens packfile bitmaps and indexes.
>> >> > +* `commit-graph` hardens the commit graph file.
>> >> > +* `index` hardens the index when it is modified.
>> >> > +* `objects` is an aggregate option that is equivalent to
>> >> > +  `loose-object,pack`.
>> >> > +* `derived-metadata` is an aggregate option that is equivalent to
>> >> > +  `pack-metadata,commit-graph`.
>> >> > +* `committed` is an aggregate option that is currently equivalent =
to
>> >> > +  `objects`. This mode sacrifices some performance to ensure that =
work
>> >> > +  that is committed to the repository with `git commit` or similar=
 commands
>> >> > +  is hardened.
>> >> > +* `added` is an aggregate option that is currently equivalent to
>> >> > +  `committed,index`. This mode sacrifices additional performance to
>> >> > +  ensure that the results of commands like `git add` and similar o=
perations
>> >> > +  are hardened.
>> >> > +* `all` is an aggregate option that syncs all individual component=
s above.
>> >> > +
>> >> >  core.fsyncMethod::
>> >> >       A value indicating the strategy Git will use to harden reposi=
tory data
>> >> >       using fsync and related primitives.
>> >>
>> >> On top of my
>> >> https://lore.kernel.org/git/RFC-patch-v2-7.7-a5951366c6e-20220323T140=
753Z-avarab@gmail.com/
>> >> which makes the tmp-objdir part of your not-in-next-just-seen follow-=
up
>> >> series configurable via "fsyncMethod.batch.quarantine" I really think=
 we
>> >> should just go for something like the belwo patch (note that
>> >> misspelled/mistook "bulk" for "batch" in that linked-t patch, fixed
>> >> below.
>> >>
>> >> I.e. I think we should just do our default fsync() of everything, and
>> >> probably SOON make the fsync-ing of loose objects the default. Those =
who
>> >> care about performance will have "batch" (or "writeout-only"), which =
we
>> >> can have OS-specific detections for.
>> >>
>> >> But really, all of the rest of this is unduly boxing us into
>> >> overconfiguration that I think nobody really needs.
>> >>
>> >
>> > We've gone over this a few times already, but just wanted to state it
>> > again.  The really detailed settings are really there for Git hosters
>> > like GitLab or GitHub. I'd be happy to remove the per-component
>> > core.fsync values from the documentation and leave just the ones we
>> > point the user to.
>>
>> I'm prettty sure (but Patrick knows more) that GitLab's plan for this is
>> to keep it at whatever the safest setting is, presumably GitHub's as
>> well (but I don't know at all on that front).
>>
>> >> If someone really needs this level of detail they can LD_PRELOAD
>> >> something to have fsync intercept fd's and paths, and act appropriate=
ly.
>> >>
>> >> Worse, as the RFC series I sent
>> >> (https://lore.kernel.org/git/RFC-cover-v2-0.7-00000000000-20220323T14=
0753Z-avarab@gmail.com/)
>> >> shows we can and should "batch" up fsync() operations across these
>> >> configuration boundaries, which this level of configuration would seem
>> >> to preclude.
>> >>
>> >> Or, we'd need to explain why "core.fsync=3Dloose-object" won't *actua=
lly*
>> >> call fsync() on a single loose object's fd under "batch" as I had to =
do
>> >> on top of this in
>> >> https://lore.kernel.org/git/RFC-patch-v2-6.7-c20301d7967-20220323T140=
753Z-avarab@gmail.com/
>> >>
>> >
>> > 99.9% of users don't care and won't look.  The ones who do look deeper
>> > and understand the issues have source code and access to this ML
>> > discussion to understand why this works this way.
>>
>> Exactly, so we can hopefully have a simpler interface.
>>
>> >> The same is going to apply for almost all of the rest of these
>> >> configuration categories.
>> >>
>> >> I.e. a natural follow-up to e.g. batching across objects & index as I=
'm
>> >> doing in
>> >> https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140=
753Z-avarab@gmail.com/
>> >> is to do likewise for all the PACK-related stuff before we rename it
>> >> in-place. Or even have "git gc" issue only a single fsync() for all of
>> >> PACKs, their metadata files, commit-graph etc., and then rename() thi=
ngs
>> >> in-place as appropriate afterwards.
>> >>
>> >> diff --git a/Documentation/config/core.txt b/Documentation/config/cor=
e.txt
>> >> index 365a12dc7ae..536238e209b 100644
>> >> --- a/Documentation/config/core.txt
>> >> +++ b/Documentation/config/core.txt
>> >> @@ -548,49 +548,35 @@ core.whitespace::
>> >>    errors. The default tab width is 8. Allowed values are 1 to 63.
>> >>
>> >>  core.fsync::
>> >> -       A comma-separated list of components of the repository that
>> >> -       should be hardened via the core.fsyncMethod when created or
>> >> -       modified.  You can disable hardening of any component by
>> >> -       prefixing it with a '-'.  Items that are not hardened may be
>> >> -       lost in the event of an unclean system shutdown. Unless you
>> >> -       have special requirements, it is recommended that you leave
>> >> -       this option empty or pick one of `committed`, `added`,
>> >> -       or `all`.
>> >> -+
>> >> -When this configuration is encountered, the set of components starts=
 with
>> >> -the platform default value, disabled components are removed, and add=
itional
>> >> -components are added. `none` resets the state so that the platform d=
efault
>> >> -is ignored.
>> >> -+
>> >> -The empty string resets the fsync configuration to the platform
>> >> -default. The default on most platforms is equivalent to
>> >> -`core.fsync=3Dcommitted,-loose-object`, which has good performance,
>> >> -but risks losing recent work in the event of an unclean system shutd=
own.
>> >> -+
>> >> -* `none` clears the set of fsynced components.
>> >> -* `loose-object` hardens objects added to the repo in loose-object f=
orm.
>> >> -* `pack` hardens objects added to the repo in packfile form.
>> >> -* `pack-metadata` hardens packfile bitmaps and indexes.
>> >> -* `commit-graph` hardens the commit graph file.
>> >> -* `index` hardens the index when it is modified.
>> >> -* `objects` is an aggregate option that is equivalent to
>> >> -  `loose-object,pack`.
>> >> -* `derived-metadata` is an aggregate option that is equivalent to
>> >> -  `pack-metadata,commit-graph`.
>> >> -* `committed` is an aggregate option that is currently equivalent to
>> >> -  `objects`. This mode sacrifices some performance to ensure that wo=
rk
>> >> -  that is committed to the repository with `git commit` or similar c=
ommands
>> >> -  is hardened.
>> >> -* `added` is an aggregate option that is currently equivalent to
>> >> -  `committed,index`. This mode sacrifices additional performance to
>> >> -  ensure that the results of commands like `git add` and similar ope=
rations
>> >> -  are hardened.
>> >> -* `all` is an aggregate option that syncs all individual components =
above.
>> >> +       A boolen defaulting to `true`. To ensure data integrity git
>> >> +       will fsync() its objects, index and refu updates etc. This can
>> >> +       be set to `false` to disable `fsync()`-ing.
>> >> ++
>> >> +Only set this to `false` if you know what you're doing, and are
>> >> +prepared to deal with data corruption. Valid use-cases include
>> >> +throwaway uses of repositories on ramdisks, one-off mass-imports
>> >> +followed by calling `sync(1)` etc.
>> >> ++
>> >> +Note that the syncing of loose objects is currently excluded from
>> >> +`core.fsync=3Dtrue`. To turn on all fsync-ing you'll need
>> >> +`core.fsync=3Dtrue` and `core.fsyncObjectFiles=3Dtrue`, but see
>> >> +`core.fsyncMethod=3Dbatch` below for a much faster alternative that's
>> >> +just as safe on various modern OS's.
>> >> ++
>> >> +The default is in flux and may change in the future, in particular t=
he
>> >> +equivalent of the already-deprecated `core.fsyncObjectFiles` setting
>> >> +might soon default to `true`, and `core.fsyncMethod`'s default of
>> >> +`fsync` might default to a setting deemed to be safe on the local OS,
>> >> +suc has `batch` or `writeout-only`
>> >>
>> >>  core.fsyncMethod::
>> >>         A value indicating the strategy Git will use to harden reposi=
tory data
>> >>         using fsync and related primitives.
>> >>  +
>> >> +Defaults to `fsync`, but as discussed for `core.fsync` above might
>> >> +change to use one of the values below taking advantage of
>> >> +platform-specific "faster `fsync()`".
>> >> ++
>> >>  * `fsync` uses the fsync() system call or platform equivalents.
>> >>  * `writeout-only` issues pagecache writeback requests, but depending=
 on the
>> >>    filesystem and storage hardware, data added to the repository may =
not be
>> >> @@ -680,8 +666,8 @@ backed up by any standard (e.g. POSIX), but worke=
d in practice on some
>> >>  Linux setups.
>> >>  +
>> >>  Nowadays you should almost certainly want to use
>> >> -`core.fsync=3Dloose-object` instead in combination with
>> >> -`core.fsyncMethod=3Dbulk`, and possibly with
>> >> +`core.fsync=3Dtrue` instead in combination with
>> >> +`core.fsyncMethod=3Dbatch`, and possibly with
>> >>  `fsyncMethod.batch.quarantine=3Dtrue`, see above. On modern OS's (Li=
nux,
>> >>  OSX, Windows) that gives you most of the performance benefit of
>> >>  `core.fsyncObjectFiles=3Dfalse` with all of the safety of the old
>> >
>> > I'm at the point where I don't want to endlessly revisit this discussi=
on.
>>
>> Sorry, my intention isn't to frustrate you, but I do think it's
>> important to get this right.
>>
>> Particularly since this is now in "next", and we're getting closer to a
>> release. We can either talk about this now and decide on something, or
>> it'll be in a release, and then publicly documented promises will be
>> harder to back out of.
>>
>> I think your suggestion of just hiding the relevant documentation would
>> be a good band-aid solution to that.
>>
>> But I also think that given how I was altering this in my RFC series
>> that the premise of how this could be structured has been called into
>> question in a way that we didn't (or I don't recall) us having discussed
>> before.
>>
>> I.e. that we can say "sync loose, but not index", or "sync index, but
>> not loose" with this config schema. When with "bulk" we it really isn't
>> any more expensive to do both if one is true (even cheaper, actually).
>>
>
> I want to make a comment about the Index here.  Syncing the index is
> strictly required for the "added" level of consistency, so that we
> don't lose stuff that leaves the work tree but is staged.  But my
> Windows enlistment has an index that's 266MB, which would be painful
> to sync even with all the optimizations.  Maybe with split-index, this
> wouldn't be so bad, but I just wanted to call out that some advanced
> users may really care about the configurability.

So for that use-case you'd like to fsync the loose objects (if any), but
not the index? So the FS will "flush" up to the index, and then queue
the index for later syncing to platter?


But even in that case don't the settings need to be tied to one another,
because in the method=3Dbulk sync=3Dindex && sync=3D!loose case wouldn't we=
 be
syncing "loose" in any case?

> As Git's various database implementations improve, the fsync stuff
> will hopefully be more optimal and self-tuning.  But as that happens,
> Git could just start ignoring settings that lose meaning without tying
> anyones hands.

Yeah that would alleviate most of my concerns here, but the docs aren't
saying anything like that. Since you added them & they just landed, do
you mind doing a small follow-up where we e.g. say that these new
settings are "EXPERIMENTAL" or whatever, and subject to drastic change?
