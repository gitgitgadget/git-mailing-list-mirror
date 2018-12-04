Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1B0211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 18:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbeLDSLN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 13:11:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLDSLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 13:11:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so16958927wrx.9
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Zfff184sOh4+CDxHn+wAnErjbxUR+CXxBaC9XMgMdy0=;
        b=WxUD6h2aGK+rTl3wizxb+AOFJCxHMxraa+g1PcsUd+OrFNYNUtUUnCtZN7fb0xL4A1
         jiwLacuDamjy5bNyaWkuEQlY4wOZNx7EcrrwGteZ6ugFVRBe3TrRruVDGUELxXMOB+4E
         Waza20yPCPF2So8x0QxAPODyC1DbhqvbAt32HNfXLyonllrUk4AqKQNDKf/42L+4ni9A
         DNgQ1lk9qxne+ShcJmAAX8mbW7V2ne26DAxVQZogHyfP52tpQSiF7L7E/TU+2KCWpUsO
         mmK4pxLtOyhlWHMhtUadLR/2rX2mf99IJ0jksDRA1dKZTKMP+BTNEYHQQzgTaCMAbtNj
         BUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Zfff184sOh4+CDxHn+wAnErjbxUR+CXxBaC9XMgMdy0=;
        b=svBCUEu2j1rRpLgmmcOxUerxtSGlp9dtmeOTuubSarxrklU+dt946lV5bw5xb/3AfK
         DKcopbviow44oiC6KM22MWKBPxSKH3k1tvhZEAqSnBwarZ0tSa98zbUA9nIL6Q77uSnO
         9t9x/laEGg2RfzkovmMDD7ZWWkC7kdqwTVP984m3KHVZv7y39djkcLHxGCD8SL2HodLl
         DOaftP0s2xgLg+laIpEPzgPrUratVFMwyAjzX3piBnDokx0TcJeEp7Q3tu1KJ1w1NkBl
         XwWa5ZIivq8V6yJA1CORq3OXxuVOIcw+/0wKQnhBV50xO+hWyv8QFrzkOOZl91UxZGXq
         4XQQ==
X-Gm-Message-State: AA+aEWYenrKiVz/B+lGh98g31N5TichacOjwX2qa5QgJYfGYBnXAYLKH
        BLc/iKc02WHqgczeGMp7R5U=
X-Google-Smtp-Source: AFSGD/V2Qysb+p781TQUjIDuDsYZR+saiaHKeeTDJjYJxbAn3lmds27ugDU89bm0O7488hzl5hI3Nw==
X-Received: by 2002:adf:c505:: with SMTP id q5mr18687114wrf.84.1543947070824;
        Tue, 04 Dec 2018 10:11:10 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id f192sm11206314wmd.12.2018.12.04.10.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 10:11:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
References: <20181204163457.15717-1-szeder.dev@gmail.com> <20181204163457.15717-4-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181204163457.15717-4-szeder.dev@gmail.com>
Date:   Tue, 04 Dec 2018 19:11:08 +0100
Message-ID: <87muplyxfn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 04 2018, SZEDER Gábor wrote:

> Unfortunately, we have a few flaky tests, whose failures tend to be
> hard to reproduce.  We've found that the best we can do to reproduce
> such a failure is to run the test repeatedly while the machine is
> under load, and wait in the hope that the load creates enough variance
> in the timing of the test's commands that a failure is evenually
> triggered.  I have a command to do that, and I noticed that two other
> contributors have rolled their own scripts to do the same, all
> choosing slightly different approaches.
>
> To help reproduce failures in flaky tests, introduce the '--stress'
> option to run a test script repeatedly in multiple parallel
> invocations until one of them fails, thereby using the test script
> itself to increase the load on the machine.
>
> The number of parallel invocations is determined by, in order of
> precedence: the number specified as '--stress=<N>', or the value of
> the GIT_TEST_STRESS_LOAD environment variable, or twice the number of
> available processors in '/proc/cpuinfo', or 8.
>
> To prevent the several parallel invocations of the same test from
> interfering with each other:
>
>   - Include the parallel job's number in the name of the trash
>     directory and the various output files under 't/test-results/' as
>     a '.stress-<Nr>' suffix.
>
>   - Add the parallel job's number to the port number specified by the
>     user or to the test number, so even tests involving daemons
>     listening on a TCP socket can be stressed.
>
>   - Make '--stress' imply '--verbose-log' and discard the test's
>     standard ouput and error; dumping the output of several parallel
>     tests to the terminal would create a big ugly mess.
>
> 'wait' for all parallel jobs before exiting (either because a failure
> was found or because the user lost patience and aborted the stress
> test), allowing the still running tests to finish.  Otherwise the "OK
> X.Y" progress output from the last iteration would likely arrive after
> the user got back the shell prompt, interfering with typing in the
> next command.  OTOH, this waiting might induce a considerable delay
> between hitting ctrl-C and the test actually exiting; I'm not sure
> this is the right tradeoff.

I think it makes sense to generalize this and split it up into two
features.

It's a frequent annoyance of mine in the test suite that I'm
e.g. running t*.sh with some parallel "prove" in one screen, and then I
run tABCD*.sh manually, and get unlucky because they use the same trash
dir, and both tests go boom.

You can fix that with --root, which is much of what this patch does. My
one-liner for doing --stress has been something like:

    perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh --root=trash-{} -v'

But it would be great if I didn't have to worry about that and could
just run two concurrent:

    ./t0000-basic.sh

So I think we could just set some env variable where instead of having
the predictable trash directory we have a $TRASHDIR.$N as this patch
does, except we pick $N by locking some test-runs/tABCD.Nth file with
flock() during the run.

Then a stress mode like this would just be:

    GIT_TEST_FLOCKED_TRASH_DIRS=1 perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh'

And sure, we could ship a --stress option too, but it wouldn't be
magical in any way, just another "spawn N in a loop" implementation, but
you could also e.g. use GNU parallel to drive it, and without needing to
decide to stress test in advance, since we'd either flock() the trash
dir, or just mktemp(1)-it.
