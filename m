Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB38C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 15:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbhK3PSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244532AbhK3PPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 10:15:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67421C07E5F2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 07:06:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so22890432edd.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 07:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S7mCqdt7wOs048rVW2ynmmeiA26bhPz+e2NM4Ks7VW4=;
        b=myZd2OJPmHixdrI699pCHh08QxCNVnT+rI4QzoCc9+TONLnbMGRHNkRxQT3GcqSuuM
         hkL3ks4WNOBQ/94UHRMqacxoTFUlc0ev09DLp8EYQRL1wcNk7x0eDxqZjAGVGRBYFmhi
         tERrmxYMWlMkT2G9+5y2yMGeG/gWYTRaP9XgEiyjn/GevDqieiAzWNuNGigUhGbjQwNY
         Ruexso8xjk0z/tpjL0NdpyiGSODau809m4XY8nvT/qqM8hg6bTNkEzJTmZPINj3l8dMT
         2x3UtWqegkX4AQa7MmsjZwi/GJjeyVuUzS8fHRW60CIuXJfP9YYu136BGD3asa8rMty6
         e1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S7mCqdt7wOs048rVW2ynmmeiA26bhPz+e2NM4Ks7VW4=;
        b=0FDhLclGA6sQWoivGFadmbu1J0aPfM8+Y9j2vXKEUPfcmQEaXNDe5yCN3HyvYs/E9w
         pseb+WjuZlyjNqCv1xG1t82MrWKjlplhhtnSGXhb55ULaJkp99w9C7imz+63f8r/p1Mu
         rCWhKVk66U1usmZD3C1SXodMKPR19vULAr7Lnir7YKBpidLmPdrrVbOGLkDTFkWowTzA
         jchor0mbiHNKxIu+KJMXD7LX/cAOPC9nMeNvMNZ9F115WyHPdlApwrEKnDUs5+f6EhNp
         kGkjxT6UffTrF4itZrxKmIx4AG3kJYGaFIELRsrBZ/mTaesW0h75P+i+mzD8Seo+Lt89
         pNEw==
X-Gm-Message-State: AOAM5313Gdp3/pZA73qG4XcIycglOv5TShe7HK+bSlgA+Y0cmbIwkZ1s
        RextQcqYHE8M7FguCEJ/WFZ4wlfq2dhyKA==
X-Google-Smtp-Source: ABdhPJxoje1xzM4wBLWnL81ErRg7yw8Rqx0fOc+2Kydv8tGxBOf5POHmTNVCiePwz7HFPbu4KqBzQA==
X-Received: by 2002:a17:906:bc46:: with SMTP id s6mr69351343ejv.467.1638284770895;
        Tue, 30 Nov 2021 07:06:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4sm9753540ejn.25.2021.11.30.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:06:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms4ht-0012P9-Nb;
        Tue, 30 Nov 2021 16:06:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Date:   Tue, 30 Nov 2021 15:59:27 +0100
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
 <20211120150401.254408-4-fs@gigacodes.de>
 <211122.86y25gz9q7.gmgdl@evledraar.gmail.com> <xmqqh7c4i0jh.fsf@gitster.g>
 <20211126095509.weeknmg4p6sx7bdn@fs> <xmqqy25a636c.fsf@gitster.g>
 <20211127124733.ulicqyiudur3s5h4@fs> <xmqqo8634zrz.fsf@gitster.g>
 <20211130143821.7dz5jj2z2x2q2ytn@fs>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211130143821.7dz5jj2z2x2q2ytn@fs>
Message-ID: <211130.86wnkpd6ou.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Fabian Stelzer wrote:

> On 28.11.2021 15:38, Junio C Hamano wrote:
>>Fabian Stelzer <fs@gigacodes.de> writes:
>>
>>>>I was expecting something along the lines of ...
>>>>
>>>># What is written by tests to their FD #1 and #2 are sent to
>>>># different places depending on the test mode (e.g. /dev/null in
>>>># non-verbose mode, piped to tee with --tee option, etc.)  Original
>>>># FD #1 and #2 are saved away to #5 and #7, so that test framework
>>>># can use them to send the output to these low FDs before the
>>>># mode-specific redirection.
>>>>
>>>>... but this only talks about the output side.  The final version
>>>>needs to mention the input side, too.
>>>>
>>>
>>> I like to use the term stdin/err/out since that is what i would grep for
>>> when trying to find out more about the test i/o behaviour.
>>
>>I do not mind phrasing "original FD #1" as "original standard
>>output" at all.  I just wanted to make sure it is clear to readers
>>whose FD #1 and FD #5 we are talking about. In other words, the
>>readers should get a clear understanding of where they are writing
>>to, when the code they write in test_expect_success block outputs to
>>FD #1, and what the code needs to do if it wants to always show
>>something to the original standard output stream.
>
> The current version in my branch is now:
>
> What is written by tests to stdout and stderr is sent so different places
> depending on the test mode (e.g. /dev/null in non-verbose mode, piped to tee
> with --tee option, etc.). We save the original stdin to FD #6 and stdout and
> stderr to #5 and #7, so that the test framework can use them (e.g. for
> printing errors within the test framework) independently of the test mode.
>
> which I think should make this sufficiently clear.
> I'm wondering now though if we should write to #7 instead of #5 in
> BAIL_OUT(). The current use in test-lib/test-lib-functions seems a bit 
> inconsistent.
>
> For example:
> error >&7 "bug in the test script: $*"
> echo >&7 "test_must_fail: only 'git' is allowed: $*"
>
> but:
> echo >&5 "FATAL: Cannot prepare test area"
> echo >&5 "FATAL: Unexpected exit with code $code"
>
> Sometimes these errors result in immediate exit 1, but not always.
>
> I'm not sure if the TAP framework that BAIL_OUT() references expects
> the bail out error on a specific fd.

All TAP must be emitted to stdout. You can test that with e.g.:
    
    $ cat tap.sh
    #!/bin/sh 
    echo "ok 1 one"
    echo "ok 2 two" >&2
    echo "1..1"
    $ prove --exec /bin/sh tap.sh
    tap.sh .. 1/? ok 2 two
    tap.sh .. ok   
    All tests successful.
    Files=1, Tests=1,  0 wallclock secs ( 0.01 usr +  0.00 sys =  0.01 CPU)
    Result: PASS

Note how the "ok 2 two" is emitted to STDERR, and doesn't count towards
the number of tests. If it's changed to:
    
    $ cat tap.sh
    #!/bin/sh
    echo "ok 1 one"
    echo "ok 2 two"
    echo "1..2"
    $ prove --exec /bin/sh tap.sh
    tap.sh .. ok   
    All tests successful.
    Files=1, Tests=2,  0 wallclock secs ( 0.00 usr +  0.01 sys =  0.01 CPU)
    Result: PASS

You can see it runs two tests.

The reason the existing cases are inconsistent are because of various
reasons, probably none good at this point.

Some are just because the error handling pre-dates the TAP support in
the test suite, I think at this point we should just be moving to making
it first-class in terms of TAP support. I.e. it's clearly the most
commonly used test mode (and we use it in CI etc.). So we should emit
all directives on STDOUT.

And some are probably just copy/pasting, or error handling that didn't
consider TAP at the time of writing.

Note that not all of these should be "Bail out!". We should really
reserve that for wanting to stall the entire test run, but e.g. not for
"cannot prep test area", which might only be a permission error with one
trash directory.



