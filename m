Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F1C678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 23:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCDXYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 18:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDXYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 18:24:47 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B9D33C
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 15:24:46 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id e12-20020a4ae0cc000000b00525034ca5e9so1030049oot.0
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUFEP+1A0Hsnl2Jbf9hnBQ0QIc9c3KVDe8Z/gDZuD0g=;
        b=gn1NtwFVd/rsthOh4o12B4Lq86ahw8SqI5yjverJG0oZt4zMkj4M6uh5xdPawGDp/6
         SQQWhvtkGuQWDSl25U7D4IubBLCUHoZ8ayAOHafUGwjrV7PzxU8mm0czswWbb3HxdwCH
         8mvoI1pg2Huxi8f2noLQKPCoF3gHEv3muVT3kRPZtMLe4uAUIxV3JTnPKoKyItMEg+wn
         ZUEyP+vFC2m0ZmYwRZLbsI+N6HEN1vD5mL6nY/buCc1/Yr9Y3pdWNxxxC7JZcEUQFVfz
         Pw0W15pe5fE454FKa0Wspq5GQNXAED1BbmZg41z2JG9X/KhfCD8t03Mc6ooMRi0KX7DK
         FZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUFEP+1A0Hsnl2Jbf9hnBQ0QIc9c3KVDe8Z/gDZuD0g=;
        b=H4g5WgC2vGb5JzskQYZcjdatR3h/sa9WFCuOb8wGmJCem1rLoV8ksP7DboMcYhN2ex
         ECd5Yj43Qvs59PV+DwXJp2hkd2VCrzqjfQ0qEPQSCa33HmOZlE977wd5SlR6qO5VTQwI
         c5geBRcIIoDSzWNoPPvxDSMuB4tzOdv4/FykMXw8CuqGu2JkcNLU1M9/K7caPjVkSDU3
         s5sb7LmmGui8fMv3QhsSVWz7UiPg3EFk3jlj1W+9DY39mcoG9zOSJhL2mYPpqzPYs66u
         7gc32zvp8p5p9eWgmPec/mjiSJOmym6FXI5B8Q9i/733Zg1rl2LGt97H4kO8RTNhOM2n
         xbIw==
X-Gm-Message-State: AO0yUKWKKhC/wSK7QUtJhAdR+kVnlnty/7gOAiTEXsvSMI0gbPanWduQ
        5qQowC8wBVPQ6lbHIhnZ9We+yzXLDQSu0S/G0og=
X-Google-Smtp-Source: AK7set++kYeER3XLR4NGR2MsN90aXtDG2t0s4xS134iaZQQTliw3DNhJQk4zNxaY5mplIR7z3PfffTq5np846cQJ8Jo=
X-Received: by 2002:a4a:d5d2:0:b0:525:54b6:dac1 with SMTP id
 a18-20020a4ad5d2000000b0052554b6dac1mr2515093oot.1.1677972285386; Sat, 04 Mar
 2023 15:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-4-alexhenrie24@gmail.com>
 <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk>
In-Reply-To: <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 4 Mar 2023 16:24:03 -0700
Message-ID: <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2023 at 2:37=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:

> On 25/02/2023 18:03, Alex Henrie wrote:

> > +rebase.merges::
> > +     Whether and how to set the `--rebase-merges` option by default. C=
an
> > +     be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting t=
o
> > +     true is equivalent to `--rebase-merges` without an argument, sett=
ing to
> > +     `rebase-cousins` or `no-rebase-cousins` is equivalent to
> > +     `--rebase-merges` with that value as its argument, and setting to=
 false
> > +     is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` =
on the
> > +     command line without an argument overrides a `rebase.merges=3Dfal=
se`
> > +     configuration but does not override other values of `rebase.merge=
`.
>
> I'm still not clear why the commandline doesn't override the config in
> all cases as is our usual practice. After all if the user has set
> rebase.merges then they don't need to pass --rebase-merges unless they
> want to override the config.

Given the current push to turn rebase-merges on by default, it seems
likely that rebase-cousins will also be turned on by default at some
point after that. There will be a warning about the default changing,
and we'll want to let users suppress that warning by setting
rebase.rebaseMerges=3Drebase-cousins. It would then be very confusing if
a --rebase-merges from some old alias continued to mean
--rebase-merges=3Dno-rebase-cousins when the user expects it to start
behaving as though the default has already changed.

I will rephrase the documentation in v6 to make it more clear that the
absence of a specific value on the command line does not clobber a
specific value set in the configuration, as Glen suggested.

> > +test_expect_success '--rebase-merges=3Dno-rebase-cousins overrides reb=
ase.merges=3Drebase-cousins' '
> > +     test_config rebase.merges rebase-cousins &&
> > +     git checkout -b override-config-rebase-cousins main &&
> > +     git rebase --rebase-merges=3Dno-rebase-cousins HEAD^ &&
> > +     test_cmp_graph HEAD^.. <<-\EOF
> > +     *   Merge the topic branch '\''onebranch'\''
> > +     |\
> > +     | * D
> > +     | * G
> > +     o | H
> > +     |/
> > +     o A
> > +     EOF
> > +'
>
> I'm not sure this test adds much value, it is hard to see what kind of
> regression would allow the others to pass but not this one.

I was worried that I or someone else would forget to explicitly set
rebase_cousins to 0 when no-rebase-cousins is given on the command
line, assuming that it is already 0 because that is the default. The
test makes me feel better, but I am happy to remove it if you still
think it's overkill.

> > +test_expect_success '--rebase-merges overrides rebase.merges=3Dfalse' =
'
> > +     test_config rebase.merges false &&
> > +     git checkout -b override-config-merges-false E &&
> > +     before=3D"$(git rev-parse --verify HEAD)" &&
> > +     test_tick &&
> > +     git rebase --rebase-merges C &&
> > +     test_cmp_rev HEAD $before
>
> This test passes if the rebase does nothing, maybe pass --force and
> check the graph?

The rebase is supposed to do nothing here. Checking that the commit
hash is the same is just a quick way to check that the entire graph is
the same. What more would be checked by checking the graph instead of
the hash?

Thanks for the feedback,

-Alex
