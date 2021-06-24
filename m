Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F2EC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99130613DA
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhFXQ6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXQ6u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 12:58:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1260C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 09:56:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r7so9475987edv.12
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TgfC1hJUpGcoFb+N6UIXH5wu68UhPoq+rdKzy5cPXuM=;
        b=LQYiQVf2vu6dL+pFV27sWu/PsF0k68fMks98GBWTJ80+CDAxreMzawIn0heQYjBwIY
         q6N9JmqlMQHqZ4aKcjDtOfjVg9U1hQgQUkj7fGnwg1dz+1HK0ac12b5xov+wkwhgh6P9
         rc0QnMoXftqxikweBJln86lSEogx89jYjjUbDIUF5KyAwKf2sKOEnE5POEmRvPG8Mwgi
         wuL+WMmzTaLrwIoby6GbwKXszi4Hvyj1H6mLhyP6E1lwrsxr4Ub6b3GhORM8Ps4zYIPm
         bg/uCOzgJm15N7/d4WlzSUWa3rlw/x/MX1oD9g/W+TjLIW0/xaPQR/+5OQQ5DWLOwEsn
         tXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TgfC1hJUpGcoFb+N6UIXH5wu68UhPoq+rdKzy5cPXuM=;
        b=PHXpgDP22VPy4AkSmBQ6wdjT1SQVTGVaOSBWXQTi3ol9ebiVahKW5EDUdLnAL0aCdC
         0Payt0/cx/Q7kFZlL17ZeaLzhzHSJ7iNW3CER6wj4pE+r4i8uvJHnH3rzsIwK7XOJpDM
         00Q9vOnNASgsnjttN+VocbU4socpLKdkxKhG1FeILYPcXkX460jaTeS/9qq8ZVata5PP
         qXumxMz8bK4lpzORVZnC0/8CorHdol6RlYLx/2Su9Ynv5Hv6KvHzPHUZ8VLu0x8Zqyac
         NbnFr47FgekDzIWsVACeanI8cbgZSMsgHy4xhxnSlCWr5Y5XxNvSt0NU3GC5I1KYWgxb
         17zw==
X-Gm-Message-State: AOAM530njGPTP8FL3xJUJ7AqVKar4l0lP02cZsPHIw2vWNlC03YMeW5X
        ywPxly4X1wkomcZxlGz91do=
X-Google-Smtp-Source: ABdhPJx/7+w0DVCYyDJV/ODPXqeBRnzvdbA8Pb2TnMHvgxdk2/j1Ukjf59mqetMvjWl58UXr3Mnmuw==
X-Received: by 2002:a05:6402:1e8c:: with SMTP id f12mr8433618edf.169.1624553789236;
        Thu, 24 Jun 2021 09:56:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i18sm2323882edc.7.2021.06.24.09.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:56:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why the Makefile is so eager to re-build & re-link
Date:   Thu, 24 Jun 2021 17:28:11 +0200
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <YNSh0CskelTwuZq0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNSh0CskelTwuZq0@coredump.intra.peff.net>
Message-ID: <87y2azyzer.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Jeff King wrote:

> On Thu, Jun 24, 2021 at 03:16:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This is probably all stuff that's been on list-before / known by
>> some/all people in the CC list, but in case not: I looked a bit into why
>> we'e so frequently re-linking and re compiling things these days,
>> slowing down e.g. "git rebase --exec=3D'make ...'".
>>=20
>> These are all fixable issues, I haven't worked on them, just some notes
>> in case anyone has better ideas:
>
> From a quick skim I didn't see anything wrong in your analysis or
> suggestions. I do kind of wonder if we are hitting a point of
> diminishing returns here. "make -j16" on my system takes ~175ms for a
> noop, and ~650ms if I have to regenerate version.h (it's something like
> 2s total of CPU, but I have 8 cores).
>
> I know I've probably got a nicer machine than many other folks. But at
> some point correctness and avoiding complexity in the Makefile become a
> win over shaving off a second from compile times. You'd probably find
> lower hanging fruit in the test suite which could shave off tens of
> seconds. :)

It's mainly annoying when e.g. doing a rebase of an N patch series,
those ~700ms v.s. ~200ms add up quickly.

>>  * {command,config}-list.h (and in-flight, my hook-list.h): Every time
>>    you touch a Documentation/git-*.txt we need to re-generate these, and
>>    since their mtime changes we re-compile and re-link all the way up to
>>    libgit and our other tools.
>>=20
>>    I think the best solution here is to make the generate-*.sh
>>    shellscripts faster (just one takes ~300ms of nested shellscripting,
>>    just to grep out the first few lines of every git-*.txt, in e.g. Perl
>>    or a smarter awk script this would be <5ms).
>
> Yeah, I think Eric mentioned he had looked into doing this in perl, but
> we weren't entirely happy with the dependency. Here's another really odd
> thing I noticed:
>
>   $ time sh ./generate-cmdlist.sh command-list.txt >one
>   real	0m1.323s
>   user	0m1.531s
>   sys	0m0.834s
>
>   $ time sh -x ./generate-cmdlist.sh command-list.txt >two
>   [a bunch of trace output]
>   real	0m0.513s
>   user	0m0.754s
>   sys	0m0.168s
>
>   $ cmp one two
>   [no output]
>
> Er, what? Running with "-x" makes it almost 3 times faster to generate
> the same output? I'd have said this is an anomaly, but it's repeatable
> (and swapping the order produces the same output, so it's not some weird
> priming thing). And then to top it all off, redirecting the trace is
> slow again:
>
>   $ time sh -x ./generate-cmdlist.sh command-list.txt >two 2>/dev/null
>   real	0m1.363s
>   user	0m1.538s
>   sys	0m0.902s
>
> A little mini-mystery that I think I may leave unsolved for now.

Sounds interesting if true, I haven't looked into it.

>>    Then we make those FORCE, but most of the time the config or command
>>    summary (or list of hooks) doesn't change, so we don't need to
>>    replace the file.
>
> Yes, possibly we could use the "if it hasn't changed, don't update the
> file" trick to avoid cascading updates.

The problem is also that you can only do it at the lowest level, or
you'll get into a dead-end of something else depending on the FORCE
target continually re-making it, even though the target itself decided
there was nothing to do based on a cmp(1).

>> Perhaps even better would be to piggy-back on the RUNTIME_PREFIX
>> support, and simply drop in generated plain-text files, so in your build
>> checkout the list of hooks, commands etc. would be parsed instead of
>> compiled in. Then we wouldn't need to re-build or re-link anything for
>> the version or this other data.
>
> Yeah, that would work. I worry a bit that the value of something like
> "version.h" is lost with a runtime file, though. The point is to bake it
> into the binary so you can't accidentally get the wrong value (say, from
> running "./git" from the build directory, which looks at the runtime
> file where the binary _would_ be installed, except you haven't run "make
> install" yet).

I think all of those concerns are covered under RUNTIME_PREFIX, it
discovers files relative to git whether you have it installed or not.

I still haven't looked into why I sometimes need --exec-path=3D$PWD in the
build checkout, and sometimes not though...
