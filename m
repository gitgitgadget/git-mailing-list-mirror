Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A3C433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbiCXSY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCXSY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:24:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA318CCD9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:23:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 5so9519405lfp.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FcDqHtP2mp0IU6sZx6SZUEqpJhZBDDGWAvZQ7pojuEM=;
        b=oxGur0VDoVkl5TzFpnKcmx1IGAbxRJrojE7MTJY+jNU3jG4suRCOluGYpUjhtREyfM
         FORqiqstHRfe8XxauJw9TTbHXTx4+k3MGES+IHyVLtWlptu+qUV2H84eRy1LkOgz6a9G
         pGr4Ca/j+bURhFD9Z0cM/KVKhhPmZoMSEfVPWcvfqBmgME0P4jbtfJQb19cTw47qxvPk
         mAuZxwLs44L3jIkhRfbkECtubyNh9zB6KMnPWZlbdODltaiOSsYVDdCX2xv9rxAFZpkp
         t3yYFRfH84Qoo/k+IAvsSKh5dYQPcyJPxHY1HkNaBCFavwNpZDIapOCgFfGybI0ysWwz
         HasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FcDqHtP2mp0IU6sZx6SZUEqpJhZBDDGWAvZQ7pojuEM=;
        b=zmnnKEvGzmbhW8kbCSo3Zv6MQ9HTFAF6dwa2i8UrJiauJxdNIgJMV0OZ4S5yJlVerE
         1Qi7KkgWNmWyB+pVi6nrbmB8M+/PGruRxdBSAjTqIV74us6sBXRdlp2PWOgUMfCNL/Vd
         M/Dduyk+QItKhYKnTUhM+M7lHX4ioRJyOr49FoE2OLevAcFSfdX3wlJFettRoyXHSDuS
         lctKx2yarPiTi3ljA+sqaNEbBRqO94Dz/Kdk936cu5QAWGHBzvQ7o6Oq9J8Ak0nnC6RC
         NLAuIQqWiHsqut4X1o2doI7dz7eLd8tP3KPDAupe0tVvGqmWdVkIfBoH1IietTkhgJgm
         +SFg==
X-Gm-Message-State: AOAM530de96D7Vj6kiivkL14F6bbW2OQ7J+uZ+pNYWW6FgtX+TnW3TZ2
        TpGPCcucGYcmpOb0XclXCK55My5Z4g5Y+nRbmpUle88u9hU=
X-Google-Smtp-Source: ABdhPJzlJtguprxPslteb17atrPgFMmlJYd8fbBBAin0vL0vrwK9pdUYA3gKstIS6TwHhcHW/dlem5ZUhWhmZAbT66g=
X-Received: by 2002:ac2:5dfa:0:b0:44a:15d4:9e60 with SMTP id
 z26-20020ac25dfa000000b0044a15d49e60mr4754394lfq.241.1648146202186; Thu, 24
 Mar 2022 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com> <b5f371e97fee69d87da1dccd3180de0691c15834.1648097906.git.gitgitgadget@gmail.com>
 <220324.86tubnmgwk.gmgdl@evledraar.gmail.com>
In-Reply-To: <220324.86tubnmgwk.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 24 Mar 2022 11:23:11 -0700
Message-ID: <CANQDOdfM_XyRa3e8Uo72yRdn6cmQxVSahb8J+7b2-cXogOg9pg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] core.fsyncmethod: tests for batch mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 9:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Mar 24 2022, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Add test cases to exercise batch mode for:
> >  * 'git add'
> >  * 'git stash'
> >  * 'git update-index'
> >  * 'git unpack-objects'
> >
> > These tests ensure that the added data winds up in the object database.
> >
> > In this change we introduce a new test helper lib-unique-files.sh. The
> > goal of this library is to create a tree of files that have different
> > oids from any other files that may have been created in the current tes=
t
> > repo. This helps us avoid missing validation of an object being added
> > due to it already being in the repo.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  t/lib-unique-files.sh  | 32 ++++++++++++++++++++++++++++++++
> >  t/t3700-add.sh         | 28 ++++++++++++++++++++++++++++
> >  t/t3903-stash.sh       | 20 ++++++++++++++++++++
> >  t/t5300-pack-object.sh | 41 +++++++++++++++++++++++++++--------------
> >  4 files changed, 107 insertions(+), 14 deletions(-)
> >  create mode 100644 t/lib-unique-files.sh
> >
> > diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
> > new file mode 100644
> > index 00000000000..74efca91dd7
> > --- /dev/null
> > +++ b/t/lib-unique-files.sh
> > @@ -0,0 +1,32 @@
> > +# Helper to create files with unique contents
> > +
> > +# Create multiple files with unique contents within this test run. Tak=
es the
> > +# number of directories, the number of files in each directory, and th=
e base
> > +# directory.
> > +#
> > +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 =
files
> > +#                                     each in my_dir, all with content=
s
> > +#                                     different from previous invocati=
ons
> > +#                                     of this command in this run.
> > +
> > +test_create_unique_files () {
> > +     test "$#" -ne 3 && BUG "3 param"
> > +
> > +     local dirs=3D"$1" &&
> > +     local files=3D"$2" &&
> > +     local basedir=3D"$3" &&
> > +     local counter=3D0 &&
> > +     test_tick &&
> > +     local basedata=3D$basedir$test_tick &&
> > +     rm -rf "$basedir" &&
> > +     for i in $(test_seq $dirs)
> > +     do
> > +             local dir=3D$basedir/dir$i &&
> > +             mkdir -p "$dir" &&
> > +             for j in $(test_seq $files)
> > +             do
> > +                     counter=3D$((counter + 1)) &&
> > +                     echo "$basedata.$counter">"$dir/file$j.txt"
> > +             done
> > +     done
> > +}
>
> Having written my own perf tests for this series, I still don't get why
> this is needed, at all.
>
> tl;dr: the below: I think this whole workaround is because you missed
> that "test_when_finished" exists, and how it excludes perf timings.
>

I actually noticed test_when_finished, but I didn't think of your
"setup the next round on cleanup of last" idea.  I was debating at the
time adding a "test_perf_setup" helper to do the setup work during
each perf iteration.  How about I do that and just create a new repo
in each test_perf_setup step?

> I.e. I get that if we ran this N times we'd want to wipe our repo
> between tests, as for e.g. "git add" you want it to actually add the
> objects.
>
> It's what I do with the "hyperfine" command in
> https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z=
-avarab@gmail.com/
> with the "-p" option.
>
> I.e. hyperfine has a way to say "this is setup, but don't measure the
> time", which is 1/2 of what you're working around here and in 10/11.
>
> But as 10/11 shows you're limited to one run with t/perf because you
> want to not include those "setup" numbers, and "test_perf" has no easy
> way to avoid that (but more on that later).
>
> Which b.t.w. I'm really skeptical of as an approach here in any case
> (even if we couldn't exclude it from the numbers).
>
> I.e. yes what "hyperfine" does would be preferrable, but in exchange for
> avoiding that you're comparing samples of 1 runs.
>
> Surely we're better off with N run (even if noisy). Given enough of them
> the difference will shake out, and our estimated +/- will narrow..
>
> But aside from that, why isn't this just:
>
>         for cfg in true false blah
>         done
>                 test_expect_success "setup for $cfg" '
>                         git init repo-$cfg &&
>                         for f in $(test_seq 1 100)
>                         do
>                                 >repo-$cfg/$f
>                         done
>                 '
>
>                 test_perf "perf test for $cfg" '
>                         git -C repo-$cfg
>                 '
>         done
>
> Which surely is going to be more accurate in the context of our limited
> t/perf environment because creating unique files is not sufficient at
> all to ensure that your tests don't interfere with each other.
>
> That's because in the first iteration we'll create N objects in
> .git/objects/aa/* or whatever, which will *still be there* for your
> second test, which will impact performance.
>
> Whereas if you just make N repos you don't need unique files, and you
> won't be introducing that as a conflating variable.
>
> But anyway, reading perf-lib.sh again I haven't tested, but this whole
> workaround seems truly unnecessary. I.e. in test_run_perf_ we do:
>
>         test_run_perf_ () {
>                 test_cleanup=3D:
>                 test_export_=3D"test_cleanup"
>                 export test_cleanup test_export_
>                 "$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH"=
 -c '
>                         [... code we run and time ...]
>                 '
>                 [... later ...]
>                 test_eval_ "$test_cleanup"
>         }
>
> So can't you just avoid this whole glorious workaround for the low low
> cost of approximately one shellscript string assignment? :)
>
> I.e. if you do:
>
>         setup_clean () {
>                 rm -rf repo
>         }
>
>         setup_first () {
>                 git init repo &&
>                 [make a bunch of files or whatever in repo]
>         }
>
>         setup_next () {
>                 test_when_finished "setup_clean" &&
>                 setup_first
>         }
>
>         test_expect_success 'setup initial stuff' '
>                 setup_first
>         '
>
>         test_perf 'my perf test' '
>                 test_when_finished "setup_next" &&
>                 [your perf test here]
>         '
>
>         test_expect_success 'cleanup' '
>                 # Not really needed, but just for completeness, we are
>                 # about to nuke the trash dir anyway...
>                 setup_clean
>         '
>
> I haven't tested (and need to run), but i'm pretty sure that does
> exactly what you want without these workarounds, i.e. you'll get
> "trampoline setup" without that setup being included in the perf
> numbers.
>
> Is it pretty? No, but it's a lot less complex than this unique file
> business & workarounds, and will give you just the numbers you want, and
> most importantly you car run it N times now for better samples.
>
> I.e. "what you want" sans a *tiny* bit of noise that we use to just call
> a function to do:
>
>     test_cleanup=3Dsetup_next
>
> Which we'll then eval *after* we measure your numbers to setup the next
> test.

How about I add a new test_perf_setup mechanism to make your idea work
in a straightforward way?

I still want the test_create_unique_files thing as a way to make
multiple files easily.  And for the non-perf tests it makes sense to
have differing contents within a test run.

Thanks,
Neeraj
