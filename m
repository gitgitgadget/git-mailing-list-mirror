Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FD6C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DE3206E9
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dokfiv++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMRqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:46:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37260 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMRqE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:46:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so5709222otp.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cfJYL5xzOHQ4xnpgpwuMnuKbseAkRSvRvCd1HJrDB8I=;
        b=Dokfiv++cOTo0tHD5v8pTDuy3CDACWd+sZWrlwF5pQxbCSmCy0CXpUqJwvHZsfnLCL
         JUd5zBWYJgHa4EKjIt/FePc9rI2Osb8JJigGO2PJLqQ3bj7mzApKySeVBfvdFeJsX0BH
         3bnG1UcRVe9R4ojFFdGsCQcRtPGnvqwXRLHKFRZ88uk+olJyav5IqrPs2um89DLSdh1c
         7ikPyM0LiYOxU+6v2oHYhPWxI6yEroQRtZsDKOYykMaULc/JTWkzC1boVQkul/OQsxUa
         bsrXvNj07IVt9jypuEcDgg7p6pWd1ZvxQThEXUDdBTIJu9ERLWJRX07OdCQZZAa/+t3b
         CYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cfJYL5xzOHQ4xnpgpwuMnuKbseAkRSvRvCd1HJrDB8I=;
        b=llFPdbqi4vJcfUQ19Hhg4eqcanAxshJ/6G0DPsxpDiG2RF0MqUqmDAsy2cHzMbs4ql
         5QdHuHk4hn4V7FtFCnKfkBZ0fhffWSr/wur4jaKAe1cpW+LH/9R5h0o5MtOLz8i+oDHt
         fjcRBbDtYwX0AfX3Io8inn5PPxBdsnjFsYZuy5jDH3Vs45rjb9k5elDgt0JkWqwwvKwO
         mUyCeoSEG1C52zNbt8frTivYlcVenK0BF9A7lf+R5bqQWuZEi39c8yvT7szFO+kc8dZj
         gu79Co9q1HVxLGn3Wr8nccB7th8tMtnXNToq9Q5h7zgOYYQ58U2grFwcOhynwAK9am65
         p4TQ==
X-Gm-Message-State: ANhLgQ1OeM8UHbV1JsEsNiFf2aJURvLV3v+ifYhqFjiztTG2IDuX89JI
        f0GIP/eGopZsOeOrfKVWDPZ7cj2B20HE5N6UXwo=
X-Google-Smtp-Source: ADFU+vvWfnZ4Xh0NNLp+uoYxkTeo8rDLF9PurlVPzUxj2JFqJXar0b+KF0mDupXscg3ECwYobfpMLKgWQmo4tccEMBk=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr12266189otl.162.1584121562336;
 Fri, 13 Mar 2020 10:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200312132032.GD3122@szeder.dev> <CABPp-BEa7pvqgH+EytGPp2AO5nBmEgW0+7HnjK-e3MqrBnthnA@mail.gmail.com>
 <CABPp-BGR_eDHJmNOPVQLx8WkL5WLV6J0NtQJ2=AE7CQB2sck5g@mail.gmail.com>
 <20200312200157.GE3122@szeder.dev> <20200313171739.GF3122@szeder.dev>
In-Reply-To: <20200313171739.GF3122@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Mar 2020 10:45:50 -0700
Message-ID: <CABPp-BH-J6UehBgW9K9Q+3sfhAZYMkE3nabdC8hTkidHjiZH8Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 10:17 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Thu, Mar 12, 2020 at 09:01:57PM +0100, SZEDER G=C3=A1bor wrote:
> > > > > I saw this test fail today in one of my custom CI builds:
> > > > >
> > > > >   +git checkout change
> > > > >   Switched to branch 'change'
> > > > >   +test-tool chmtime =3D-1 M
> > > > >   +test-tool chmtime --get M
> > > > >   +GIT_MERGE_VERBOSITY=3D3 git merge change+rename
> > > > >   +test-tool chmtime --get B
> > > > >   +cat old-mtime
> > > > >   +cat new-mtime
> > > > >   +test 1583967731 -lt 1583967731
> > > > >   error: last command exited with $?=3D1
> > > > >   not ok 12 - merge of identical changes in a renamed file
> > > > >
> > > > > The contents of 'out', i.e. the output of the 'git merge' command
> > > > > before the failure is:
> > > > >
> > > > >   Auto-merging B
> > > > >   Merge made by the 'recursive' strategy.
> > > > >    A =3D> B | 0
> > > > >    1 file changed, 0 insertions(+), 0 deletions(-)
> > > > >    rename A =3D> B (100%)
> > > > >
> > > > > This is a rare failure, this is the first time I saw it, and to m=
ake
> > > > > things worse, this one time it happened on big-endian and with al=
l the
> > > > > GIT_TEST_* knobs enabled.
> > > > >
> > > > >   https://travis-ci.org/github/szeder/git-cooking-topics-for-trav=
is-ci/jobs/661294571#L4020
> > > >
> > > > This is very troubling.  The workflow is basically:
> > > >   - Manually set the mtime to a file to something old (I happened t=
o
> > > > pick 1 second before now, but picking something from 1970 would hav=
e
> > > > been fine too).
> > > >   - Run a merge which is known to need to overwrite the file.  Your
> > > > output ("Auto-merging B") suggests that we should have been in such=
 a
> > > > case.
> > > >   - Verify that the file was actually updated as expected.  Since t=
he
> > > > OS is supposed to update the mtime when it writes the file, it shou=
ld
> > > > have set it to something recent, i.e. something *different* than wh=
at
> > > > it had before.
> > > >
> > > > So, now I'm left wondering how the mtime possibly could have been n=
ot
> > > > updated.  Maybe the file wasn't actually written?  (But if so, why
> > > > didn't other people see the failure?  Or your stress runs not see i=
t?)
> > > >  Or maybe it was written but all file contents and metadata were
> > > > delayed in writing to disk such that a subsequent command still see=
s
> > > > the old file??  Or maybe it was written but the mtime update was
> > > > delayed and the test was able to check it in that intermediate
> > > > state???  Or perhaps the mtime check before the merge raced with th=
e
> > > > setting of the mtime backwards and got the mtime before it was
> > > > rewound????
> > > >
> > > > I don't have a plausible scenario under which any of these should b=
e
> > > > possible; I'm at a loss.
> > >
> > > Hmm.  Maybe leap seconds, or clock updates via ntp at an unfortunate
> > > time?
> >
> > I'm now fairly confident that 'git merge' is OK, and suspect that it's
> > an issue with Travis CI's s390x environment (multi-architecture
> > support is an alpha-stage feature).
>
> I could finally reproduce the issue on my own machine, so apparently
> it's not an issue in Travis CI's multi-arch environments.
>
> >   test_expect_success 'test' '
> >       touch file &&
> >       old=3D$(test-tool chmtime --get =3D-1 file) &&
> >       touch file &&
> >       new=3D$(test-tool chmtime --get file) &&
> >       test $old -lt $new
> >   '
>
> I wanted to report the issue to Travis CI, and in order to do so I
> turned the above test case into a script that doesn't at all depend on
> out test framework and 'test-tool' but uses only coreutils commands
> (with a whole lot of GNUisms...):
>
>   cat >timestamp.sh <<-\EOF
>   #!/bin/sh
>
>   set -ex
>
>   i=3D0
>   while true
>   do
>         printf "$i\r"
>         i=3D$((i + 1))
>
>         # set a file's mtime to one second ago
>         now=3D$(date "+%s.%N")
>         one_sec_ago=3D$(date -d "@$((${now%.*} - 1))" "+%Y%m%d%H%M%S")
>         touch -t ${one_sec_ago%??}.${one_sec_ago#????????????} file
>         # save its actual mtime
>         old=3D$(date -r file "+%s.%N")
>         # set its mtime to now
>         touch file
>         # the current the mtime should be different, but sometimes it isn=
't
>         new=3D$(date -r file "+%s.%N")
>         test "${old%.*}" !=3D "${new%.*}"
>   done
>   EOF
>   chmod u+x timestamp.sh
>   ./timestamp.sh 2>out
>   echo
>   tail -n11 out
>
> And this script usually fails after a few hundred iterations on my
> machine:
>
>   308
>   + date +%s.%N
>   + now=3D1584118408.002458987
>   + date -d @1584118407 +%Y%m%d%H%M%S
>   + one_sec_ago=3D20200313175327
>   + touch -t 202003131753.27 file
>   + date -r file +%s.%N
>   + old=3D1584118407.000000000
>   + touch file
>   + date -r file +%s.%N
>   + new=3D1584118407.997464837
>   + test 1584118407 !=3D 1584118407
>
> Note that the mtime update at the end of the iteration results in an
> mtime that is _before_ the current time at the beginning of the
> iteration.  Well, I'm puzzled :)

Interesting...

From https://stackoverflow.com/questions/14392975/timestamp-accuracy-on-ext=
4-sub-millsecond:
'''
date will call the gettimeofday system call which will always return
the most accurate time available based on the cached kernel time,
adjusted by the CPU cycle time if available to give nanosecond
resolution. The timestamps stored in the file system however, are only
based on the cached kernel time. ie The time calculated at the last
timer interrupt.
'''

also, from https://apenwarr.ca/log/20181113 says:

'''
Does mtime get set to >=3D the current time?

No, this depends on clock granularity. For example, gettimeofday() can
return times in microseconds on my system, but ext4 rounds timestamps
down to the previous ~10ms (but not exactly 10ms) increment, with the
surprising result that a newly-created file is almost always created
in the past:

  $ python -c "
  import os, time
  t0 =3D time.time()
  open('testfile', 'w').close()
  print os.stat('testfile').st_mtime - t0
  "

  -0.00234484672546
'''


So, perhaps instead of setting the file mtime relative to the current
clock (and truncated to the nearest integer), we need to set the file
mtime relative to its recorded mtime.

> Yes, setting the old timestamp 2 seconds in the past seems to be
> sufficient, at least I haven't seen it fail in a few 100k repetitions.

Or yeah, we could just use bigger numbers, but given that wall clock
and file-system clock are apparently different, I like the idea of
setting them relative to the mtimes that existed before.  Looks like
`test-tool chmtime` supports that too, so I'll cook up a patch.
