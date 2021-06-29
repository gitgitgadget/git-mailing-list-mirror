Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E339C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A4561D97
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhF2IQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2IQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:16:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FBC061574
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 01:13:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n20so30096192edv.8
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o5gx1Ub2uvG5MGGfdu3HlbnCmLgj+jRrOvhKAe/ZTbY=;
        b=IdybAcE9DhX0r3kec7CEvpB9yZ6JJulhi2/UBtqBVfeHWeFA7gkWCv4bEJdl5VGlco
         39tVAZtln3Wu2COthg2Axs8G3QG7cmR60s90m5d3xEQw6mMN6Rs5QJ+y8SIgMhzOoYyQ
         rtlM9Um+7J3twSj8CaZ1ihTwpN6ntPdmfbjPc9y4/0csu1P4HiIbEgCm6dAM+ppEX6sq
         iM0DmHQNW8tHZUuaoL7AqboIw6oV26kMzXN7nKmueOabDSTgbHqkXO2WNys+vgRHVmuG
         cFE6d+mRGTZlkOB/7SeR0E68HTfG6XOqEi0y9iNokZzNbuvD8SflxcI/lra3bDJARx2+
         OQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o5gx1Ub2uvG5MGGfdu3HlbnCmLgj+jRrOvhKAe/ZTbY=;
        b=eJNUEWAAiBUnz9jn3yX4SvQuRItXP009lc9woY+7Tsso79M80CTUIDLAfJkE9Ctyl9
         uvbXHTK5l/YbiBJrWXHNMxr6FYzvzzrPPqIY3u63qqIIkB7xvBVGwpY0LutvMl8p+Gqx
         sCpE3EL9Z9o9PjzAovMOQliX/RHNUeSonrJPQgiDSfPtkevx1bb5QkkSgvQ9GEJtRSWx
         nOdrsEzwYcsWQyDEhXNWlaMfcmIj54qLzaJAp/wLQlpHbiKRC1SwYJvuDQ8rmnrUtJbA
         Ilth+OPJ9u+mMZLPGfomu4bHG0Ul0FQhxt+RWod5aLiWVGwHBUF3N+uX8fNUcJ4zs42V
         /rOA==
X-Gm-Message-State: AOAM5317AXzdK7TIjqwFUR79ANYXoQf6apUH3nzefhyuzLeqjmMbHzZZ
        j+FpuXKspH4vzzna1aaA12c=
X-Google-Smtp-Source: ABdhPJxSMyE+Hl8l9GxVgbiCw8ab+PC8ZcE2GRPKh1pB/hiJisnx+TWPBwvw98xutlz4zo9JWdn2EQ==
X-Received: by 2002:a05:6402:42cc:: with SMTP id i12mr38762535edc.88.1624954425606;
        Tue, 29 Jun 2021 01:13:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ia26sm7903272ejc.73.2021.06.29.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:13:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Tue, 29 Jun 2021 09:39:26 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
        <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
        <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
        <87r1gs1hfx.fsf@evledraar.gmail.com>
        <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
        <871r8r1hwe.fsf@evledraar.gmail.com>
        <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
        <87fsx6xn0b.fsf@evledraar.gmail.com>
        <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
        <xmqqfsx1yyza.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqfsx1yyza.fsf@gitster.g>
Message-ID: <875yxxgkav.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> Yeah, I can see the view that running the test suite as a basic sanity
>> check may have value, if it's backed by more careful testing later (and
>> certainly while I'm developing, I wouldn't hesitate to run a subset of
>> the test suite to see how my work is progressing).
>>
>> My main point was that I don't see much reason to do work to make that
>> kind of continuous "make test" work with simultaneous recompiles and
>> test-runs, if we can encourage people to do it more robustly with a
>> single compile-and-test-run loop. Maybe adding in the extra workdir
>> there makes it too heavy-weight? (Certainly my "ci" script is overkill,
>> but it seems like a loop of "reset to the current branch tip, compile,
>> run" in a worktree would be the minimal thing).
>
> I actually do use such a "runs tests in the background while I am
> not watching", so I am sympathetic to the higher-level goal, but I
> find any execution of the idea that requires "let's reduce the
> window where freshly built 'git' or any other things are not ready
> by forcing 'mv $@+ $@' trick for added atomicity" simply insane and
> not worth supporting.

Do you think upgrading git on your system without having to stop the
world is worth supporting?

Ultimately they're the same problem, and I had some patches in the works
to make "make install" work like that, and wanted to eventually make the
normal compilation use the same helper(s).

Ensuring that tests don't fail either due to re-compilation is also a
nice way to dogfood/smoketest if the installer is keeping that promise.

> Tests are run to find cases where things go wrong, and it is a waste
> of cycles if that background task is not being run in isolation and
> on a stable state.

Sure, at this point it's clear you won't take the patch. Just a note
that this reply addresses 1/2 reasons I wanted this, i.e. not the AIX
FS/behavior portability issue.

>  A separate working tree is so easy to set up these days,[...]

I also test git on e.g. gcc farm boxes where I run out of disk space if
I have a .git, a checkout directory with compiled files, and add a
second checkout directory with compiled files, and on others where a
compile/test cycle takes 30-40 minutes.

If I had to do compilation twice things would slow to a crawl, and no,
I'm not going to try to install ccache or whatever on some
$OBSCURE_PLATFORM/$ANCIENT_OS/$ODD_TOOLCHAIN.

> I do not see a point in complicating the build procedure to avoid
> using it.

I'd really understand your and Jeff's concerns if I was proposing some
really complex workaround, but it's just extending & making consistent
the "mv" dance we already use for 1/2 our rules already.

Even if you don't care about the end result or making git easier to hack
on for people who don't share your setup, I'd think that making those
rules consistent across the board makes things less complex, not more.

Anyway, let's not discussed this forever. We're clearly getting
nowhere. Just for the record I'm quite miffed about the bar for "I don't
care about this area/platform/use-case, but this person actively sending
me patches in the area says it's helpful to send more patches" is so
low.

For comparison we have >1000 lines of CMake duplicating the entire
Makefile now, all just to make things easier on Windows. It doesn't even
work on *nix, so when the CI breaks because I updated the Makefile I
need to push to some Windows box on GitHub and twiddle my thumbs hoping
it'll pass this time around.

Maybe that's all worth it, and I'd be willing to take the Windows devs
at their word that dealing with the make dependency was really *that*
painful. But compare that to carrying a few lines of "mv $@+ $@" to, I
daresay, make the same or larger relative improvement on AIX.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com/
