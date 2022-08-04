Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B3C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiHDWc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHDWc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 18:32:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EBB33421
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 15:32:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so1343863edd.9
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=dlV26dHszscC+rSiayam83gtO2W1LICsftQdqIxkCFo=;
        b=qPoQ/pCxOsSBocx3dyYkgVpt7FTc/GMcDR7UZ53Mx+BUXAPZeQGpZBXsDICf/ZUoYY
         +mhapmBT521L1lQQJdn10pPY+mtxOoGRtkca31DPVdOBgY1X39aU6/EMZjY79qKsohOC
         NvrG7drMJK7AXT4RYa5FswAFTIXcpFmHj0Zen6lpouHrG/rGe6XjZc9cDHlMogxx/IqJ
         K1SaLO2dg4qkrrSRQRTvt63IQlTUxKlEf647V2htPc+jr/e3rtl8g1UO7jROT/59tyzh
         UkZd6nOSA/kVSGO9cZAAicSJraUgSFiVy40Gi/5nMquyAncCai1zCNnqxK+ty41hHPOY
         wW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=dlV26dHszscC+rSiayam83gtO2W1LICsftQdqIxkCFo=;
        b=MFE5pd5GtwMWM6LU9dHdd5eE+dbi25iy/XFpTscFCd8hd1niPkQkLXOic7UcfbgcA5
         WJkklMEb2x9MEkiPq1FthF8wjXqgWuFEO05GMWUttxiQVIEuE+Iig8prZAakPpTBmLbh
         nUCZOy82uvThWJWVK8yQovO38MU2695tKSGp6IvYabuU/xxtfi339vTLEL9+xmL/FmQ9
         Ah2T1xG+ZMghZCDgZ9u1fuSziYBvZFKdGOnln0QKh8HK8SSfP8XztrTs4o2j0ZmuBqWC
         gX4m8WgpVb3F5m0HwkjiaZZGc9zBitQ7rI+njnaD0D74TflImRYBRi2W8FiLFJlcmiBP
         SrFg==
X-Gm-Message-State: ACgBeo2nZxWU3yUUWQ/A/DgY/iDLf+hqzLbMRs3DOSab+rurFTAZkSBG
        yN0rb6uSwgz3I3yt8GHLFKm0JaqAelqBNnOkB8I=
X-Google-Smtp-Source: AA6agR5fSubSn/8cENq+CwUMK9SLXB361Su9hzwy+1xplgfex77X1phJyqr9Xn8Qd/uo+vjc/nqgeildvt04H19dGSo=
X-Received: by 2002:a05:6402:3485:b0:43d:7fe0:74d1 with SMTP id
 v5-20020a056402348500b0043d7fe074d1mr4023695edc.413.1659652375985; Thu, 04
 Aug 2022 15:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com>
 <YtCMklbIoTAN/WRs@coredump.intra.peff.net> <ecb6fa27-b918-4234-8e44-13c2a3e76e07@gmail.com>
 <87d46db2-8e09-e5a7-b6bb-e94bf05df305@github.com> <220804.86tu6rso6n.gmgdl@evledraar.gmail.com>
In-Reply-To: <220804.86tu6rso6n.gmgdl@evledraar.gmail.com>
From:   Emily Noneman <emily.noneman@gmail.com>
Date:   Thu, 4 Aug 2022 18:32:44 -0400
Message-ID: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
Subject: Re: Bugreport: pack-objects died of signal 11
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Paul Horn <git@knutwalker.engineer>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have an updated backtrace with optimizations turned off:
Thread 2 received signal SIGSEGV, Segmentation fault.
0x000000010016f770 in git_config_check_init (repo=3D0x0) at config.c:2538
2538 if (repo->config && repo->config->hash_initialized)
(gdb) bt
#0  0x000000010016f770 in git_config_check_init (repo=3D0x0) at config.c:25=
38
#1  0x000000010016f94d in repo_config_get_string (repo=3D0x0,
key=3D0x10036e541 "status.showuntrackedfiles", dest=3D0x7ff7bfefc6d0) at
config.c:2574
#2  0x00000001001b4dbf in new_untracked_cache_flags
(istate=3D0x7ff7bfefc858) at dir.c:2781
#3  0x00000001001b0027 in new_untracked_cache (istate=3D0x7ff7bfefc858,
flags=3D-1) at dir.c:2797
#4  0x00000001001aff6c in add_untracked_cache (istate=3D0x7ff7bfefc858)
at dir.c:2806
#5  0x0000000100276126 in tweak_untracked_cache
(istate=3D0x7ff7bfefc858) at read-cache.c:1996
#6  0x000000010027352e in post_read_index_from (istate=3D0x7ff7bfefc858)
at read-cache.c:2028
#7  0x0000000100273228 in read_index_from (istate=3D0x7ff7bfefc858,
path=3D0x600002c0ac00
"/Users/emily.noneman/workspace/webdev/.NetLedger_LocalBranchData.git/index=
",
    gitdir=3D0x600002c04080
"/Users/emily.noneman/workspace/webdev/.NetLedger_LocalBranchData.git")
at read-cache.c:2457
#8  0x00000001002a98c1 in add_index_objects_to_pending
(revs=3D0x7ff7bfefcfe8, flags=3D0) at revision.c:1783
#9  0x00000001002adb4b in handle_revision_pseudo_opt
(revs=3D0x7ff7bfefcfe8, argv=3D0x600003704020, flags=3D0x7ff7bfefcaf8) at
revision.c:2717
#10 0x00000001002acd2c in setup_revisions (argc=3D6,
argv=3D0x600003704000, revs=3D0x7ff7bfefcfe8, opt=3D0x7ff7bfefcb78) at
revision.c:2806
#11 0x00000001000a747e in get_object_list (revs=3D0x7ff7bfefcfe8, ac=3D6,
av=3D0x600003704000) at builtin/pack-objects.c:3993
#12 0x00000001000a5f30 in cmd_pack_objects (argc=3D0,
argv=3D0x7ff7bfeff968, prefix=3D0x0) at builtin/pack-objects.c:4472
#13 0x0000000100002a03 in run_builtin (p=3D0x1003d0fb8 <commands+1992>,
argc=3D11, argv=3D0x7ff7bfeff968) at git.c:466
#14 0x0000000100001528 in handle_builtin (argc=3D11,
argv=3D0x7ff7bfeff968) at git.c:720
#15 0x0000000100002406 in run_argv (argcp=3D0x7ff7bfeff7dc,
argv=3D0x7ff7bfeff7d0) at git.c:787
#16 0x00000001000012f9 in cmd_main (argc=3D11, argv=3D0x7ff7bfeff968) at gi=
t.c:920
#17 0x00000001001155c6 in main (argc=3D12, argv=3D0x7ff7bfeff960) at
common-main.c:56

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, your patch fixed the issue for me! =
Thank you!


On Thu, Aug 4, 2022 at 5:18 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Thu, Aug 04 2022, Derrick Stolee wrote:
>
> > On 8/4/2022 2:21 PM, Emily Noneman wrote:
> >> The stack trace:
> >> Thread 2 received signal SIGSEGV, Segmentation fault.
> >> git_config_check_init (repo=3D0x0) at config.c:2538
> >> 2538        if (repo->config && repo->config->hash_initialized)
> >> (gdb) bt
> >> #0  git_config_check_init (repo=3D0x0) at config.c:2538
> >> #1  0x00000001001197a8 in repo_config_get_string (repo=3D0x0, key=3D0x=
1002a3c49 "status.showuntrackedfiles", dest=3D0x0, dest@entry=3D0x7ff7bfefc=
1f0) at config.c:2574
> >> #2  0x000000010014a85b in new_untracked_cache_flags (istate=3D0x0) at =
dir.c:2781
> >> #3  new_untracked_cache (istate=3D0x0, flags=3D-1) at dir.c:2797
> >> #4  0x00000001001d68f1 in tweak_untracked_cache (istate=3D0x7ff7bfefc7=
e0) at read-cache.c:1996
> >
> > Here is where things are confusing:
> >
> > * tweak_untracked_cache() takes an 'istate' that is non-NULL here.
> >
> > * The next spot in the stack is new_untracked_cache() with a NULL 'ista=
te'.
> >
> > The only way these are connected is by a missing stack frame (probably
> > optimized out) calling add_untracked_cache(). Still, it should be
> > passing 'istate' throughout this process.
> >
> > The repo_config_get_string() call must also be coming from
> > new_untracked_cache_flags() which is again a missing stack frame,
> > but is called from new_untracked_cache(). Strangely, it's using
> > a NULL 'repo' here which should have come from 'istate->repo', so
> > we should have had a segfault earlier.
> >
> > Sorry for the drive-by commentary without any solution. This is
> > just genuinely puzzling to me.
>
> I think this segfault might be fixed by this patch of mine, which I
> wrote for something unrelated back in April (but it was never sent to
> the list).
>
>         https://github.com/avar/git/commit/d83bfa866ba
>
> Emily and/or Paul: Are you able to test the patch to see if it would
> work, diff here: https://github.com/avar/git/commit/d83bfa866ba.patch
>
> It's exactly on the codepath in this stacktrace,
> i.e. add_index_objects_to_pending() in revision.c will do before/after:
>
>         - struct index_state istate =3D { NULL };
>         + struct index_state istate =3D { .repo =3D revs->repo };
>
> Then when we're all the way down in new_untracked_cache_flags() we do:
>
>         struct repository *repo =3D istate->repo;
>
> Which then calls (indirectly) git_config_check_init(), and we segfault
> not because istate is NULL, but because the "repo" it's carrying is
> NULL.
>
> But maybe I'm wrong, I haven't been able to reproduce this.
>
> The reason I wrote that patch (as can be seen if you peek at the WIP
> branch it's at) is because I ran into a similar dependency between
> the_index and the_repo & an istate variable being passed around with
> fsmonitor-settings.c.
