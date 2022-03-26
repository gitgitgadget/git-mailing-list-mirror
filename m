Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD50FC433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 15:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiCZPq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiCZPq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 11:46:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB2F2BDB
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 08:44:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dr20so20649027ejc.6
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zyjyGKlnWZW+4USPPFkWczuHKz+gv7J+Ujb5u2aSMRI=;
        b=DIPckKJrMkIFZszmsr5D7ru1j2NEfxN7ZAikPbkYe5IG0z8gBH7y8au6F1Yun/j6py
         EF5DjuWxGRYCrrZwte+bXWWF0pCVJBVO8Zy5h1GC6dxunx7Ho9QEcEJBJIqML/qVSbUc
         SB9+b+TjZdQwEYfiivGap505WSQEhH/1Bj0Qm/3dU+MIszyibs8ayT4Pvz814UnR5PRd
         rs45lRHt50EYVgSG9LxdELPRvVPWoAybRjxeAIffJHkhv8iAyfMZ/DypijQSf1AuwbPb
         ohvN7tgu8JZBkKJVEZdnBJI/+g/DnMAjj8b3+wMN+OqBM+edbQSmvCDzBYIvf6OShNZQ
         AYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zyjyGKlnWZW+4USPPFkWczuHKz+gv7J+Ujb5u2aSMRI=;
        b=L5pRLryjDVHiEpeg8OsxgE7qY1Gf8QPFOylQcnOfJs0/rbD8w3LykIXEciWLtdCfHW
         QHO4mQ11Tm57CJCMljySA40uJkJ8wERitUx5THq/wwVVtrb0i1cX3A2UB5YvWgL4k2Zd
         G4itPmqsfzd9NKPyeKOMsdDa4h/68rqBJoXA85keuhOTPFL21gWVaxMu0B7F5sg/7xzY
         PfKhNF1qI/WdvHKf6pGXWMw+UUXu6CU4OpwpVFlW05iXuJ+ZRilA9D12ZW43gqie8TIr
         UVD54prKeLaAUt43bihk7opKdB2l0Prhx7k7g0g6m58W/OpJ/RK0KGlgYhuS3ZwxiUzk
         6VGg==
X-Gm-Message-State: AOAM531ezUygr5uVMfxtrCJLx8usdROaUOpw3wE6jBPsKWv4JNemuaGT
        AhCBqA7hgwOQNhMmHAEPck8TnMqTPFglZA==
X-Google-Smtp-Source: ABdhPJwFnbI2GqR0CEbKTvuPLvOoq2fVa0moKEEjJCgQtbRT/3AL98Q2dweq4hXG1SKrmwsxMBvZ+Q==
X-Received: by 2002:a17:906:3ec7:b0:6d6:e52b:b with SMTP id d7-20020a1709063ec700b006d6e52b000bmr18293935ejj.521.1648309489414;
        Sat, 26 Mar 2022 08:44:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090677d500b006df766974basm3761327ejn.3.2022.03.26.08.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:44:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nY8at-002TtV-L6;
        Sat, 26 Mar 2022 16:44:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 09/11] core.fsyncmethod: tests for batch mode
Date:   Sat, 26 Mar 2022 16:35:15 +0100
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <b5f371e97fee69d87da1dccd3180de0691c15834.1648097906.git.gitgitgadget@gmail.com>
 <220324.86tubnmgwk.gmgdl@evledraar.gmail.com>
 <CANQDOdfM_XyRa3e8Uo72yRdn6cmQxVSahb8J+7b2-cXogOg9pg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CANQDOdfM_XyRa3e8Uo72yRdn6cmQxVSahb8J+7b2-cXogOg9pg@mail.gmail.com>
Message-ID: <220326.86o81sk9ao.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Neeraj Singh wrote:

> On Thu, Mar 24, 2022 at 9:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Thu, Mar 24 2022, Neeraj Singh via GitGitGadget wrote:
>>
>> > From: Neeraj Singh <neerajsi@microsoft.com>
>> >
>> > Add test cases to exercise batch mode for:
>> >  * 'git add'
>> >  * 'git stash'
>> >  * 'git update-index'
>> >  * 'git unpack-objects'
>> >
>> > These tests ensure that the added data winds up in the object database.
>> >
>> > In this change we introduce a new test helper lib-unique-files.sh. The
>> > goal of this library is to create a tree of files that have different
>> > oids from any other files that may have been created in the current te=
st
>> > repo. This helps us avoid missing validation of an object being added
>> > due to it already being in the repo.
>> >
>> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>> > ---
>> >  t/lib-unique-files.sh  | 32 ++++++++++++++++++++++++++++++++
>> >  t/t3700-add.sh         | 28 ++++++++++++++++++++++++++++
>> >  t/t3903-stash.sh       | 20 ++++++++++++++++++++
>> >  t/t5300-pack-object.sh | 41 +++++++++++++++++++++++++++--------------
>> >  4 files changed, 107 insertions(+), 14 deletions(-)
>> >  create mode 100644 t/lib-unique-files.sh
>> >
>> > diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
>> > new file mode 100644
>> > index 00000000000..74efca91dd7
>> > --- /dev/null
>> > +++ b/t/lib-unique-files.sh
>> > @@ -0,0 +1,32 @@
>> > +# Helper to create files with unique contents
>> > +
>> > +# Create multiple files with unique contents within this test run. Ta=
kes the
>> > +# number of directories, the number of files in each directory, and t=
he base
>> > +# directory.
>> > +#
>> > +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3=
 files
>> > +#                                     each in my_dir, all with conten=
ts
>> > +#                                     different from previous invocat=
ions
>> > +#                                     of this command in this run.
>> > +
>> > +test_create_unique_files () {
>> > +     test "$#" -ne 3 && BUG "3 param"
>> > +
>> > +     local dirs=3D"$1" &&
>> > +     local files=3D"$2" &&
>> > +     local basedir=3D"$3" &&
>> > +     local counter=3D0 &&
>> > +     test_tick &&
>> > +     local basedata=3D$basedir$test_tick &&
>> > +     rm -rf "$basedir" &&
>> > +     for i in $(test_seq $dirs)
>> > +     do
>> > +             local dir=3D$basedir/dir$i &&
>> > +             mkdir -p "$dir" &&
>> > +             for j in $(test_seq $files)
>> > +             do
>> > +                     counter=3D$((counter + 1)) &&
>> > +                     echo "$basedata.$counter">"$dir/file$j.txt"
>> > +             done
>> > +     done
>> > +}
>>
>> Having written my own perf tests for this series, I still don't get why
>> this is needed, at all.
>>
>> tl;dr: the below: I think this whole workaround is because you missed
>> that "test_when_finished" exists, and how it excludes perf timings.
>>
>
> I actually noticed test_when_finished, but I didn't think of your
> "setup the next round on cleanup of last" idea.  I was debating at the
> time adding a "test_perf_setup" helper to do the setup work during
> each perf iteration.  How about I do that and just create a new repo
> in each test_perf_setup step?
>
>> I.e. I get that if we ran this N times we'd want to wipe our repo
>> between tests, as for e.g. "git add" you want it to actually add the
>> objects.
>>
>> It's what I do with the "hyperfine" command in
>> https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753=
Z-avarab@gmail.com/
>> with the "-p" option.
>>
>> I.e. hyperfine has a way to say "this is setup, but don't measure the
>> time", which is 1/2 of what you're working around here and in 10/11.
>>
>> But as 10/11 shows you're limited to one run with t/perf because you
>> want to not include those "setup" numbers, and "test_perf" has no easy
>> way to avoid that (but more on that later).
>>
>> Which b.t.w. I'm really skeptical of as an approach here in any case
>> (even if we couldn't exclude it from the numbers).
>>
>> I.e. yes what "hyperfine" does would be preferrable, but in exchange for
>> avoiding that you're comparing samples of 1 runs.
>>
>> Surely we're better off with N run (even if noisy). Given enough of them
>> the difference will shake out, and our estimated +/- will narrow..
>>
>> But aside from that, why isn't this just:
>>
>>         for cfg in true false blah
>>         done
>>                 test_expect_success "setup for $cfg" '
>>                         git init repo-$cfg &&
>>                         for f in $(test_seq 1 100)
>>                         do
>>                                 >repo-$cfg/$f
>>                         done
>>                 '
>>
>>                 test_perf "perf test for $cfg" '
>>                         git -C repo-$cfg
>>                 '
>>         done
>>
>> Which surely is going to be more accurate in the context of our limited
>> t/perf environment because creating unique files is not sufficient at
>> all to ensure that your tests don't interfere with each other.
>>
>> That's because in the first iteration we'll create N objects in
>> .git/objects/aa/* or whatever, which will *still be there* for your
>> second test, which will impact performance.
>>
>> Whereas if you just make N repos you don't need unique files, and you
>> won't be introducing that as a conflating variable.
>>
>> But anyway, reading perf-lib.sh again I haven't tested, but this whole
>> workaround seems truly unnecessary. I.e. in test_run_perf_ we do:
>>
>>         test_run_perf_ () {
>>                 test_cleanup=3D:
>>                 test_export_=3D"test_cleanup"
>>                 export test_cleanup test_export_
>>                 "$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH=
" -c '
>>                         [... code we run and time ...]
>>                 '
>>                 [... later ...]
>>                 test_eval_ "$test_cleanup"
>>         }
>>
>> So can't you just avoid this whole glorious workaround for the low low
>> cost of approximately one shellscript string assignment? :)
>>
>> I.e. if you do:
>>
>>         setup_clean () {
>>                 rm -rf repo
>>         }
>>
>>         setup_first () {
>>                 git init repo &&
>>                 [make a bunch of files or whatever in repo]
>>         }
>>
>>         setup_next () {
>>                 test_when_finished "setup_clean" &&
>>                 setup_first
>>         }
>>
>>         test_expect_success 'setup initial stuff' '
>>                 setup_first
>>         '
>>
>>         test_perf 'my perf test' '
>>                 test_when_finished "setup_next" &&
>>                 [your perf test here]
>>         '
>>
>>         test_expect_success 'cleanup' '
>>                 # Not really needed, but just for completeness, we are
>>                 # about to nuke the trash dir anyway...
>>                 setup_clean
>>         '
>>
>> I haven't tested (and need to run), but i'm pretty sure that does
>> exactly what you want without these workarounds, i.e. you'll get
>> "trampoline setup" without that setup being included in the perf
>> numbers.
>>
>> Is it pretty? No, but it's a lot less complex than this unique file
>> business & workarounds, and will give you just the numbers you want, and
>> most importantly you car run it N times now for better samples.
>>
>> I.e. "what you want" sans a *tiny* bit of noise that we use to just call
>> a function to do:
>>
>>     test_cleanup=3Dsetup_next
>>
>> Which we'll then eval *after* we measure your numbers to setup the next
>> test.
>
> How about I add a new test_perf_setup mechanism to make your idea work
> in a straightforward way?

Sure, that sounds great.

> I still want the test_create_unique_files thing as a way to make
> multiple files easily.  And for the non-perf tests it makes sense to
> have differing contents within a test run.

I think running your perf test on some generated data might still make
sense, but I think given the above that the *method* really doesn't make
any sense.

I.e. pretty much the whole structure of t/perf is to write tests that
can be run on an arbitrary user-provided repo, some of them do make some
content assumptions (or need no repo), but we've tried to have tests
there handle arbitrary repos.

You ended up with that "generated random files" to get around the X-Y
problem of not being able to reset the area without making that part of
the metrics, but as demo'd above we can use test_when_finished for that.

And once that's resolved it would actually be much more handy to be able
to run this on an arbitrary repo, as you can see in my "git hyperfine"
one-liner I grabbed the "t" directory, but we could just make our test
data all files in the dir (or specify a glob via an env var).

I think it still sounds interesting to have a way to make arbitrary test
data, but surely that's then better as e.g.:

	cd t/perf
 	./make-random-repo /tmp/random-repo &&
	GIT_PERF_REPO=3D/tmp/random-repo ./run p<your test>

I.e. once we've resolved the metrics/play area issue needing to run this
on some very specific data is artificial limitation v.s. just being able
to point it at a given repo.
