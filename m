Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F51C07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B78C61977
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhGEWzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGEWzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 18:55:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C4C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 15:52:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m1so25362212edq.8
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rAPijcsM6EcwruqBBtjtoYxFB+vdmN8L1jALpdpph/U=;
        b=VH6FFEU4bhu6GUlH3ljL/vERfBioyxpl4gjcEcGs4xZ4FCOw6r9Czg2que0zHCgD15
         diUb22KyaLdbjtFaL4iLotpn+qtQbTepNLua4GsbuTffG39OHY5bH0WsMsAEfENCMaze
         n/RXSeLifI7mOl/ppO/+sAIZ9qlUZsSaqgyQSvf3BiA7HJ5Zps05pLrAYfLciSrr1EHP
         ePvK0edaIuUd5JlHBrwuyqAhov2D0AgX/zVYXF+N4crVdpiKjOrwdGRVM3Lys49kzUR+
         gse237FK0NeFkb3bMEkr1ULO8riRIvDQNAen3flBsHK6yU6YqZoUXVZR8rLCaZUsqQat
         6fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rAPijcsM6EcwruqBBtjtoYxFB+vdmN8L1jALpdpph/U=;
        b=hiWphtdGaw0Q0IHUY6pPvZnxPFbN8Z7BgPLz5FKwuT5lf6rR+W9Tu+ui9PguWRpNzr
         d76DWJyAgBm3VUpvEtAicsb/J20I12/nrH6O7A1Taz4ghaeEovEnUcvAC1UqVNW68nzu
         DinLlwASSK40wZs8yWxHjQ9VUNQduszPfU3nckdld4GeIpicBbmdzCpvASx5QGBZeJLF
         rMe2zJGN2b708wba08/FfMCOyo/Bb2CoMtmKG5422hUquJWLYVyg+L8KwtqN7pS27EIz
         NmzHs4lsjhDeLctBdwHRIlvFkAgYr5AUFeLRxH9ZQUveQJMQ3S45SrbTeGXthPj28Ipv
         MGmg==
X-Gm-Message-State: AOAM531op421ybdHTdZx43ee1omaWnUAwsaWgQLSEyvOyxCSjFCT6Aff
        scA5D1BzOqlOIkkLle0PIm4=
X-Google-Smtp-Source: ABdhPJyu0A3PhfzM9u7gk9WeUAe0fUu0tqsUmmIGPhJ5L2fOppWzd3wuMjD/d4l9b4qYzoIsI1rtlw==
X-Received: by 2002:a50:fc04:: with SMTP id i4mr6457408edr.285.1625525561382;
        Mon, 05 Jul 2021 15:52:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i11sm6052823edu.97.2021.07.05.15.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 15:52:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
Date:   Tue, 06 Jul 2021 00:02:31 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <87fswyc4dz.fsf@evledraar.gmail.com>
 <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
 <87czs1d6uy.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet>
Message-ID: <874kd874qv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Johannes Schindelin wrote:

> On Thu, 1 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Jul 01 2021, Jeff Hostetler wrote:
>>
>> > On 7/1/21 1:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>> > The early Linux version was dropped because inotify does not give
>> > recursive coverage -- only the requested directory.  Using inotify
>> > requires adding a watch to each subdirectory (recursively) in the
>> > worktree.  There's a system limit on the maximum number of watched
>> > directories (defaults to 8K IIRC) and that limit is system-wide.
>> >
>> > Since the whole point was to support large very large repos, using
>> > inotify was a non-starter, so I removed the Linux version from our
>> > patch series.  For example, the first repo I tried it on (outside of
>> > the test suite) had 25K subdirectories.
>> >
>> > I'm told there is a new fanotify API in recent Linux kernels that is a
>> > better fit for what we need, but we haven't had time to investigate it
>> > yet.
>>
>> That default limit is a bit annoying, but I don't see how it's a blocker
>> in any way.
>
> Let me help you to see it.
>
> So let's assume that you start FSMonitor-enabled Git, with the default
> values. What is going to happen if you have any decently-sized worktree?
> You run out of handles. What then? Throw your hands in the air? Stop
> working? Report incorrect results?
>
> Those are real design challenges, and together with the race problems Jeff
> mentioned, they pose a much bigger obstacle than the rebasing you
> mentioned above.

You report an error and tell the user to raise the limit, and cover this
in your install docs. It's what watchman does:

https://github.com/facebook/watchman/blob/master/watchman/error_category.cp=
p#L28-L45
https://facebook.github.io/watchman/docs/install.html#system-specific-prepa=
ration

>> You simply adjust the limit. E.g. I deployed and tested the hook version
>> of inotify (using watchman) in a sizable development environment, and
>> written my own code using the API. This was all before fanotify(7)
>> existed. IIRC I set most of the limits to 2^24 or 2^20. I've used it
>> with really large Git repos, including with David Turner's
>> 2015-04-03-1M-git for testing (`git ls-files | wc -l` on that is around
>> a quarter-million).
>>
>> If you have a humongous repository and don't have root on your own
>> machine you're out of luck. But I think most people who'd use this are
>> either using their own laptop, or e.g. in a corporate setting where
>> administrators would tweak the sysctl limits given the performance
>> advantages (as I did).
>
> This conjecture that most people who'd use this are using their own laptop
> or have a corporate setting where administrators would tweak the sysctl
> limits according to engineers' wishes strikes me as totally made up from
> thin air, nothing else.
>
> In other words, I find it an incredibly unconvincing argument.

It's from a sample size of one experience of deploying this in a BigCorp
setting.

But sure, perhaps things are done differently where you work/have
worked. My experience is that even if you're dealing with some BOFHs and
e.g. are using shared racked development servers it's generally not an
insurmountable task to get some useful software installed, or some
system configuration tweaked.

In this case we're talking about ~40MB of kernel memory for 1 million
dirs IIRC, that coupled with the target audience that benefits most from
this probably being deployments that are *painfully* aware of their "git
status" slowness...

> I prefer not to address the rest of your mail, as I found it not only a
> lengthy tangent (basically trying to talk Jeff into adding Linux support
> in what could have been a much shorter mail), but actively distracting
> from the already long patch series Jeff presented. It is so long, in fact,
> that we had to put in an exemption in GitGitGadget because it is already
> longer than a usually-unreasonable 30 patches. Also, at this point,
> insisting on Linux support (in so many words) is unhelpful.

This part of the tread started because Jeff H. claimed upthread:

    [...]inotify was a non-starter, so I removed the Linux version from
    our patch series

But after I noted that it works just fine, you just need to change some
sysctl limits.

It seems at this point we're debating whether some installations of
Linux have BOFH-y enough administrators that they won't tweak sysctl
limits for you. OK, but given that I've run this thing in a production
setting it's clearly not a "non-starter". I think it could be useful for
a lot of users.

I'll reply with more (and hopefully helpful) specifics to Jeff's mail.

> Let me summarize why I think this is unhelpful: In Git, it is our
> tradition to develop incrementally, for better or worse. Jeff's effort
> brought us to a point where we already have Windows and macOS support,
> i.e. support for the most prevalent development platforms (see e.g.
> https://insights.stackoverflow.com/survey/2020#technology-developers-prim=
ary-operating-systems).
> We already established multiple obstacles for Linux support, therefore
> demanding Linux support to be included Right Now would increase the patch
> series even further, making it even less reviewable, being even less
> incremental, hold up the current known-to-work-well state, force Jeff to
> work on something he probably cannot work on right now, and therefore
> delaying the entire effort even further.

I think we just disagree. I wouldn't call my opinion "unhelpful" any
more than yours.

I don't think Git's ever had anything like a major feature (built in,
config settings, etc. etc.) contributed by a propriterary OS vendor that
works on that vendor's OS, as well as another vendor's propriterary OS,
but not comparable free systems

Is that less incremental and perhaps less practical? Sure. It's not an
entirely practical viewpoint. I work on free software partly for
idealistic reasons. I'd prefer if the project I'm working on doesn't
give users a carrot to pick proprietary systems over free ones.

But ultimately it's not my call, but Junio's.



