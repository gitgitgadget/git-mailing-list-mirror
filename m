Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22497C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 04:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiCaEKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 00:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiCaEJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 00:09:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95768C46
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 20:56:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 5so39235003lfp.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTz0xNe4vJjLm8+Dk4LwozhQ6HNz8ky56QB2ScUJZBM=;
        b=gMDKPiilnu17l9KWsA68ZYuU8FzKcOTLl1WxEPr/GcQ3UJLrr2jpac8H8S5daVj3uE
         DZNC39JyZ1I6+JPmdlOVmsr3HvxHzI4IskprNm8UOL0VAx2CSowvgp1dkztQ4FAKyuQ1
         N1da97cg6wllHixLwzN5B3E2yUT8dEPZNUljKAltzIjr2JdApvYOQ+ig0QiCa1GwbgCZ
         018kiG32Vq8T6iJDh3TN8u6G2weg3r3wjXPdARM4wZtqCdC/BijsOiiEjbOEKCE8vvyS
         H61aEuJrlSjetTk5731hf3JAcfZcdxZkU0md5xMjjfxpBBfWFp9QThcoF7/INWyKhEfJ
         uuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTz0xNe4vJjLm8+Dk4LwozhQ6HNz8ky56QB2ScUJZBM=;
        b=HZIlOlQ1RhqvnAE2DZ5w3lKoWwl+gfpP9Eixy80h1reBRoyF3AOalAd3RxzOx1HqBy
         X0wzUA3qIO/fX922c9BzXQVMbLwl/R6QiuPoWWMUSr6lzOPdn6i2RwqBySdb7t5GERGG
         2ilUpHmhSmhvwQTdP0hJuI/p/R2aMfLZrz4GiSmCfK6EumLk8zqpXT3I0z1BZd4DUWF3
         0XMCkDzwiFUyqZoW9kdi/T3dbBC++8OEIeDHfzT4tO0WmQ65g5Vx1IKpaTNyS2sPQkwd
         fyK+yt2lB44VLEH2s9cusDefVgLGxxdM1TeVZkrN6ZEyDy321e5OOkDcgSr18UFW7Q/0
         3ywg==
X-Gm-Message-State: AOAM5307BDhfn/7/1otAuqnpQMM0aAbuw8eHJPF2pi6rOxx26ueu82cb
        /GT+3uxTTUlwSXQ0r1Xt4c4fC52OvryfmcgK5TU=
X-Google-Smtp-Source: ABdhPJxAMvvzt4n/orUz9x0vObzkakwYoaG2r3AKW5sIWQEi4r9ZPtqngIbqQ6Ud2ETrvB4e9bgjqQ0C2HbTjq5D1w0=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr9511377lfb.592.1648698964537; Wed, 30
 Mar 2022 20:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <1a4aff8c350b5ffe3c7760faa4accc88c83ce11c.1648616734.git.gitgitgadget@gmail.com>
 <xmqqbkxn8g0r.fsf@gitster.g>
In-Reply-To: <xmqqbkxn8g0r.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 20:55:51 -0700
Message-ID: <CANQDOdfoDSzpWbmnyaPyi9PoftbS7P7=8Y+RS_Bm3t0ggXpLEg@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] core.fsyncmethod: tests for batch mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 11:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
> > new file mode 100644
> > index 00000000000..34c01a65256
> > --- /dev/null
> > +++ b/t/lib-unique-files.sh
> > @@ -0,0 +1,34 @@
> > +# Helper to create files with unique contents
> > +
> > +# Create multiple files with unique contents within this test run. Takes the
> > +# number of directories, the number of files in each directory, and the base
> > +# directory.
> > +#
> > +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
> > +#                                     each in my_dir, all with contents
> > +#                                     different from previous invocations
> > +#                                     of this command in this run.
> > +
> > +test_create_unique_files () {
> > +     test "$#" -ne 3 && BUG "3 param"
> > +
> > +     local dirs="$1" &&
> > +     local files="$2" &&
> > +     local basedir="$3" &&
> > +     local counter=0 &&
>
> The cover letter mentioned that in this round, "local var=val" is
> avoided?
>

Whoops.. I guess I wasn't looking widely enough.  I noticed failures
on my Ubuntu system that uses dash.

> I've seen instances of local being "curious", e.g.
>   https://lore.kernel.org/git/20220125092419.cgtfw32nk2niazfk@carbon/
> and the discussion indicates that it may still be relevant.
>
> > +     local i &&
> > +     local j &&
> > +     test_tick &&
> > +     local basedata=$basedir$test_tick &&
> > +     rm -rf "$basedir" &&
> > +     for i in $(test_seq $dirs)
> > +     do
> > +             local dir=$basedir/dir$i &&
>
> This, too.
>
> To summarize the findings from the thread is:
>
>  - very old releases of /bin/dash that predates Git, like 0.3.8,
>    would not correctly handle assignment on "local" at all.  It may
>    not matter to us.
>
>  - semi-old /bin/dash 0.5.10, which is still in use, mishandled
>    'local var=$val', but 'local var="$val"' is an acceptable
>    workaround for the bug.  "git grep" tells us that we use this
>    form in our shell scripts quite a lot, so we may be OK.
>
>  - /bin/dash 0.5.11, which was tagged mid 2020, and newer would glok
>    'local var=$val' just fine even $val has $IFS whitespace in it.
>
> So, I'd say the safe practice we should adopt is to use "local" one
> per variable, assignment to the variable on the same line of "local"
> is OK, but unlike the regular assignment, older dash may mishandle
> the right-hand-side unless it is quoted, i.e.
>
>     local var='string literal'
>     local var="$variable interpolation"
>

Thanks for updating me on the documentation.   I think I'll go back to
one-line assignments with the proper quotations and single variables,
just to keep things short and consistent. I've been looking up
everything as I go with these shell scripts, but there's a lot of
subtlety.  CMD batch files are even uglier, but I've had many years to
learn the common practices there.

I'll ask a question on the perf test patch on a related shell topic.

Thanks,
Neeraj
