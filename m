Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9AEC11F66
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F8160FE6
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhF3Wls (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhF3Wlk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 18:41:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B4CC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 15:39:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x12so5495296eds.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Tu/xnRDYtI0CFAQw2++PYHlTTo4Qs1GYqlBukDcixMc=;
        b=RcAxHuULzkQsnzxY8+CL/Y7LFy+13Qlk38Ezavf4qlQ/C/gi+hwRmFu887d8zCukrm
         Q7yNtWzcMM0dsSjRIIOpoNDjjL/KMLf0AqVkKhBPTKrPgK3qSX7xB7+lJeOic/R4hfXJ
         6gripmpnFEDd35adKytlXSU5PcQQlapR/Jtt5eIR3b5fWcpFANMzvHhkFou+kZRjF1B2
         2XO7ZBEbPkpgnp+3KnbghGWk2ohAb/zOMomfHWHWjfx9Z4z764aHXOA2GXCfTLN1MB9X
         AcnPMFKBMKRer9bKj5DqtQ5s9zAtAbcVq9gHdKlwEuzgz+IQijl3hHuSdygC9c2VrXo7
         d95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Tu/xnRDYtI0CFAQw2++PYHlTTo4Qs1GYqlBukDcixMc=;
        b=DE77nqupiSYCN6rm+ZVBU4+uh2F1CaXd9gqVHMgR38kPFeaZtgXe+EvsaZI2NWlLOz
         3gkZ/vcmKOsfp1bfGg1cYX/LXAsOGokOxgu5m7PVmafbLZcoE8a6n5xjCsrrnYD9tUtS
         uTEj3D0TMgArVZOiOo5vrdKB+21GtJmB5ZUNaN7LneazKmp0OnpfABOVFZGfEIvR7xEa
         OYOHUaqpGMzlH7CdTAQ/LaJsIGZzpz2WZSMnAJebhzNHzFSqF1baTc/tQ+Pzhpo7OXjF
         AfZawuK5lHc2gxgC7qIs7V7MnItaHt2ktGRsSgEMaXFTYS1dN3++BPNDsPrEjDHlZbBY
         JHBQ==
X-Gm-Message-State: AOAM531jk3SJZo3JQjnUQq1LuPgeoEvILZ6akQjmVNRTfKVvq2qWLoby
        QC6XSwVXJuwF+rZA1RxYSqo=
X-Google-Smtp-Source: ABdhPJytAtpiYYslLZlhcDII62kG0BErPbou803ssGefRUxhHb2DLSG0oGu6TqQkMb8ZcYfuAcavdA==
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr50013038edt.121.1625092747585;
        Wed, 30 Jun 2021 15:39:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i18sm13570368edc.7.2021.06.30.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 15:39:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/4] test-tool: split up "read-cache" tool
Date:   Thu, 01 Jul 2021 00:24:37 +0200
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
 <YNzp4WIlZIzqD7PU@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNzp4WIlZIzqD7PU@google.com>
Message-ID: <87pmw3dlkl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Emily Shaffer wrote:

> On Mon, Jun 07, 2021 at 01:58:23PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> When the sparse index topic was being discussed I suggested that the
>> t/helper/read-cache.c tool was getting to the point of doing too many
>> things and should be split up.
>>=20
>> Since that series has landed on master here's that suggestion again in
>> the form of patches on top of master. The 4/4 patch is a "while I was
>> at it" addition of an extra perf test for index refreshing.
>>=20
>> 1. https://lore.kernel.org/git/20210317132814.30175-6-avarab@gmail.com/
>>=20
>
> Since "What's cooking" mentioned this series was starved for review, we
> took a look at it today. Most of my comments are pretty general, so I'll
> reply primarily to the cover letter instead.
>
> The result after this series is that we have three forms of 'test-tool
> read-cache':
>  - one for unit testing, with no iteration (test-tool read-cache)
>  - one for not-so-perfy iteration (test-tool read-cache-again)
>  - one for perfy iteration and refresh_index benching (test-tool
>    read-cache-perf)
>
> Before I read patch 4, I said, "'again' and 'perf' have a lot of code in
> common, but I guess we are trying to reduce the amount of overhead for
> tight-loop performance testing, so OK." But patch 4 adds an alternative
> body for the inside of the loop, which *looks* not very performant
> (although is probably optimized well) by checking an unchanging bool on
> every iteration of the loop.
>
> I tend to think it would be easier to read
> and understand to have two forms of 'test-tool read-cache' - one which
> iterates and one which does not. Maybe the one that iterates should be
> called -perf, maybe it should be called something else, whatever. And
> perhaps it makes sense for the iterating one to look like so (heavily
> pseudocoded, hope you can follow along with the rough sketch):
>
>   enum iteration_mode;
>
>   parse_options();
>   if (should_do_again) {
>     iteration_mode =3D AGAIN;
>   else if (should_do_perf) {
>     iteration_mode =3D PERF;
>   else if (should_do_refresh) {
>     iteration_mode =3D REFRESH;
>   }
>
>   while (passes--)
>     switch (iteration_mode) {
>     case AGAIN:
>       read index;
>       refresh index;
>       index_name_pos;
>       error reporting;
>       write_file;
>       discard_index;
>       break;
>     case PERF:
>       read index;
>       discard index;
>       break;
>     case REFRESH:
>       refresh_index;
>       break;
>     }
>
> This would put all our "loop lots of times for performance benchmarking"
> into one place. We know that the switch statement is very performant,
> especially if we manage to const-ify iteration_mode.  The cases make it
> very clear that the body of the loop is being swapped out depending on
> the arguments, and that entirely different behavior is happening in each
> scenario.
>
> There's also an orthogonal bit of cleanup here by moving to
> parse_options(), which I am excited about in general :) but which I
> think wasn't done very cleanly in this series. In patch 1, the commit
> message makes no mention of the fairly significant refactor happening to
> move 'test-tool read-cache' to parse_options(), and I think the mix of
> cut&paste with refactor makes the patch a little muddy. What about a
> series like so:
>
>  1/3: teach test-tool read-cache to use parse_options()
>  2/3: add test-tool read-cache-(perf|iterating|whatever)
>  3/3: teach test-tool read-cache-perf "--refresh"
>
>
> Thanks, and hopefully this is a welcome necromancy and not an annoying
> one ;)

Thanks.

Yes 1/4 is a bit confsing, but the alternative to converting it to
parse_option while we're at it would be to introduce support for
understanding "print-and-refresh" in one commit, only to remove it in
another. So I aimed for something that would play as well with the diff
rename detection as possible for 1/4. Do you think it's worth it to add
such an back & forth step?

For the rest I think there's been a bit of a misunderstanding (which is
on me in not explaining this well enough), i.e. your:

    I guess we are trying to reduce the amount of overhead for
    tight-loop performance testing

That wasn't really what I was going for at all, but rather (copied from
the 1st commit message):

    I think that having one test tool do so many different things makes it
    harder to read its code. Let's instead split up the "again" and "perf"
    uses for it into their own tools.

This series was extracted out of an RFC-reply of mine to one of
Derrick's recent patches where he was adding more knobs to
test-read-cache.c (and I understand the plan in the near-term is to add
more sparse-specific things to it).

So the goal here was only to split these different use cases all sharing
one function so that they used 3 functions instead.

Your suggestion of the switch/case loop would work, and would be
performant. Optimizing this wasn't a goal at all though, making it more
readable was.

I don't think it matters much if at all how performant the scaffolding
of the test-tool itself is, if it was relatively more expensive we could
just run more loops and we'd eventually get meaningful numbers in the
perf test. The "perf" in the name is just "this is for the perf test"
not "this is the performant version".

I think that for the test tools where we're mostly not aiming for
generalized but helpers narrowly tailored to specific tests it makes
more sense to split early than have tools that take N options, with
functions that use some small subset of those N options for any given
use-case.

There's going to be duplication in the scaffolding
(e.g. parse_options()), but that sort of thing is easy to read, whereas
reasoning about some inner loop and wondering "hrm, did this config call
there impact any of this" takes more time than it should.

Anyway, knowing that's the goal (and performance of the tool itself
wasn't, at all), do you think the end result makes more/less sense than
before?
