Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FEC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0560525
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhHaPG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhHaPG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 11:06:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF05DC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:06:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g18so20757642wrc.11
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yCSdpepX0xsaj48AZW5/nWUKOakixMPHxqnnS3C22CM=;
        b=mZ7fxk4g7S0dxk9AhBTOwzIQr7hmQTZcCPcfMevSyZRNA735rJ/a9MxWpHsVbPogbu
         Fxv0KR/yhEHavcRxeYZJM06bkWPrW9ydjXX9q+ub3GbXDrJrC369oQpPjhF/EMNvOfOA
         nQMFpA0o3acuSzU9tlAWtjK2gbjzthUJ6X9L0IzDSZRw1+5M4BAMz5ESTtL7DG/Bibzu
         yzja39WHt2FemzdkxId97TjVRHDN42HlKV4lB7ZsT5eYjpURs+c9xLVWbxEOLs4HrZQl
         Lev0NxSoibCX9kxc0/ODRO8djxKsHDB+ifJ6K8nNds4pdQjZ9pvj9sf6+7a1Ps4Z6KAF
         9BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yCSdpepX0xsaj48AZW5/nWUKOakixMPHxqnnS3C22CM=;
        b=rmnnYNIjao3Kh8WdXkNU442GGr1Xkt4xEBTj0lWqJCGDEPLz7NrO81FF3hPQOh4DuM
         eBGbonq3QDECVkvEYSmyuOzWd2wqgbySfKwPEpM3RkcidCWzSkEtk29usZMJx5UArwTZ
         Jpq386xO+yWwWQTUwbrR6N45ODvUt2QB+x1WZbyl9IMO6wukibfkPvKjWyxGlGcgzxli
         mo2jqdYXspUVKKf3LwtigM70eLiswKijBPrAcp8LyRR2E8RvHDekpyzm+ErmU8UVBvuD
         N9KODchIYTfBjdncPcNhhA317+luSkCzvw9+kHe6qIjaAt/cSaPlI9Jg4M6ghwQzywm8
         sOyA==
X-Gm-Message-State: AOAM531pAVxm5vrkgWMsfgKrDcxOB5+bAo8SBPHFXoMeSkPGmA73sLKv
        pRfbb3l4ScsFxLpGxpdMksioVh9+qBjSxA==
X-Google-Smtp-Source: ABdhPJxIAXBA51Lbbs8kdcH5f5x9HX3+SRAXfBmhaopc5qO93by4hzMyHPEk90qJ16XnXthi97K6Qw==
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr31855937wrg.151.1630422357935;
        Tue, 31 Aug 2021 08:05:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x18sm2988903wmj.36.2021.08.31.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:05:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 15/15] scalar: accept -C and -c options before the
 subcommand
Date:   Tue, 31 Aug 2021 16:52:39 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <6455b18f1b623032b9066c1730dee045fbe7a3f3.1630359290.git.gitgitgadget@gmail.com>
 <871r6axban.fsf@evledraar.gmail.com>
 <8a96c097-2261-7cc3-839c-b388b595f2d1@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <8a96c097-2261-7cc3-839c-b388b595f2d1@gmail.com>
Message-ID: <87mtoxwt63.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Derrick Stolee wrote:

> On 8/31/2021 4:32 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:
>>=20
>>> The `git` executable has these two very useful options:
>>>
>>> -C <directory>:
>>> 	switch to the specified directory before performing any actions
>>>
>>> -c <key>=3D<value>:
>>> 	temporarily configure this setting for the duration of the
>>> 	specified scalar subcommand
>>>
>>> With this commit, we teach the `scalar` executable the same trick.
>>> [...]
>>> +	while (argc > 1 && *argv[1] =3D=3D '-') {
>>> +		if (!strcmp(argv[1], "-C")) {
>>> +			if (argc < 3)
>>> +				die(_("-C requires a <directory>"));
>>> +			if (chdir(argv[2]) < 0)
>>> +				die_errno(_("could not change to '%s'"),
>>> +					  argv[2]);
>>> +			argc -=3D 2;
>>> +			argv +=3D 2;
>>> +		} else if (!strcmp(argv[1], "-c")) {
>>> +			if (argc < 3)
>>> +				die(_("-c requires a <key>=3D<value> argument"));
>>> +			git_config_push_parameter(argv[2]);
>>> +			argc -=3D 2;
>>> +			argv +=3D 2;
>>> +		} else
>>> +			break;
>>> +	}
>>=20
>> This along with my earlier comment about the Makefile copy/pasting makes
>> me wonder if an easier way to integrate this wouldn't be to refactor
>> git.c a bit to have it understand either "git" or "scalar", then instead
>> of "ls-tree" etc. as "git" the subcommands would become "built-ins".
>>=20
>> Which would give us both "[git|scalar] [-c ...] <cmd>" for free, and
>> elimante the need for the inevetable future divergence of wanting -p,
>> -P, --exec-path etc. in both.
>=20=20
> Such a change would likely eliminate the ability to not include Scalar
> when building the Git codebase, which we tried to avoid by keeping it
> within contrib and have it be compiled via an opt-in flag.

I mean to still have it behind a flag, but to handle it similar to how
we handle NO_CURL, EXCLUDED_PROGRAMS and the like, i.e. not requiring
parallel maintenance of copy/pasted Makefile logic in contrib/.

> If we want to talk about integrating Scalar into Git in a deeper way,
> then that is an interesting discussion to have, but it lives at a much
> higher level than Makefile details.

To be clear I'm proposing no change at all in term of what happens when
you run "make install", just commenting on the implementation details of
how we arrange for things to be built and configured before that step.

I realize that this is following some prior art of
e.g. contrib/subtree/Makefile, but IMNSHO that approach is a historical
mistake we should be backing out of. There was some recent discussion of
this here:
https://lore.kernel.org/git/87pmz4ig4o.fsf@evledraar.gmail.com/

E.g. now we have some painful management of the depencency graph between
/Makefile and Documentation/Makefile requiring fixes like 56550ea7180
(Makefile: add missing dependencies of 'config-list.h', 2021-04-08),
adding yet another Makefile into the mix which (to take one example)
depends on doc.dep, which in turn depends on ...; It's all a bunch of
needless complexity we can avoid.

> The questions we are really looking to answer in this RFC are:
>
> 1. Will the Git project accept Scalar into its codebase?
>
> 2. What is the best place for Scalar to live in the Git codebase?
>
> We erred on the side of keeping Scalar as optional as possible. If
> the community is more interested in a deeper integration, then that
> could be an interesting direction.

Indeed, to be clear I realize I'm entirely punting on the real questions
you're interested in. I just gave this an initial cursory skimming for
now, I have not formed an informed opinion on your #1, but just a little
bit of #2.

My initial reaction to #1 without having looked into it deeply is some
combination of "sure, why not?", and that the people/group contributing
major scalability work to git.git should be given the benefit of the
doubt. Maybe we won't keep "scalar" long-term, or change its UI etc.,
all of that can be handled in some carefully worded documentation
somewhere.

Of course all these suggestions I'm making about Makefile arrangement
are rather pointless if there isn't consensus to get past the hurdle of
your #1.

> In my opinion, I think the current tactic is safest. We could always
> decide on a deeper integration later by moving the code around. It
> seems harder to do the reverse.

I think "deeper integration" is the reverse of what you think it is.

I.e. if I'm patching or maintaining part of the Makefile logic to it's
deeper (or perhaps "gnarlier" is the righ word?) integration to need to
duplicate that work in two places, or always take into account that some
not-built-by-default-but-quite-common command's *.txt docs and *.sh
tests live in some unusual place for the purposes of CI, lint, tooling
etc.

In other words, it's a question of how much net complexity is being
added to the (build) system. That complexity doesn't automatically
reduce just because some files live in another directory, sometimes
that's an increase in complexity.

Whereas just conditionally adding it to some list in the top-level
Makefile (or Documentation/Makefile) is relatively maintenance-free, and
to our users / packagers the result should be the same or near enough.
It won't matter to them if building the optional thing is another "make"
command or just a flag to the existing "make" command.
