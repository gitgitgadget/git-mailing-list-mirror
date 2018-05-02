Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02A521847
	for <e@80x24.org>; Wed,  2 May 2018 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEBDkH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 23:40:07 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36839 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeEBDkG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 23:40:06 -0400
Received: by mail-wr0-f176.google.com with SMTP id f2-v6so587707wrm.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 20:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7LVuJTQIRU/AujNEz7pqeJIM4n2rrfrnC7v7yIF2tWw=;
        b=VowTF9FRvfoA9AjqQurG76OIUzNSjf8l4ZwnO5ocQno9ZiamVUqLf71GaNabOBKXl/
         a1B2d3hqdtPALySjQmRG9yjnbGy2SYriPEvFpx9LzlBo53LeLTHXP9D69dp9AXxv9DeB
         CMtSse+3cwCEgZV+KIBOIbHUd63pV3vOC2EVIwUdMg8kLJJLgUt/40s4BXl5sqVWShhf
         x24qZKLwWF45tRoERiei7dy+vPpXlvP4JZtBQYi/cn8P+8sbV6ko+WHKFsFzMYwq842d
         lOxvP8ai8vhkPwlT1FA82NysDihBY+2g8sh2I8VhQ70X/6YTtY07zBpngv3l8yPRpy8l
         GpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7LVuJTQIRU/AujNEz7pqeJIM4n2rrfrnC7v7yIF2tWw=;
        b=hicTQaS+YK84vQ4pexkJ79UFhxArGCZS3VPwxvllIRbz9NzbLqxZzhKRa/c5T0iRHh
         YKkoYv4dZ836IjBOhV+iAbYWq9F1c3+TZQLiwPh0L1cLXiVlselCzbnaj47C5eqVcowX
         IZ7P87Zg2AeWwIC15J6GdDFkAwZyxieq3ZMeXp9M6gUfeTSgzjRJfy3y8i6b/v3ALgOZ
         c4jjKKpgQQecBKmBDf3PhrzMv5q91arOc2gzN7BqZA87+nll+6t4zRJ36CFzlBYpIM2J
         2vVwCbqGOZFu10cGwSXNHBCq2OrRAjCmWqv3AtNL/MV8CDL1iwETgt/5c/hsp4wPA7wc
         pm5Q==
X-Gm-Message-State: ALQs6tBaRWMNQTJ0DTjXwgfpM4GdCEuSM4vfCnwNLBAFws38gh5AwcIA
        ysUyzg8jUS+rnC/jKATygx4=
X-Google-Smtp-Source: AB8JxZrQ9TUsp4Lmdbj4cJnE+RUm1fOhStI5qmrRq1j+B8k2WfNankSAg8HbZZOz9hC9zWfSiCutiA==
X-Received: by 2002:adf:b979:: with SMTP id b54-v6mr14310175wrg.265.1525232404479;
        Tue, 01 May 2018 20:40:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n79sm17768002wmi.20.2018.05.01.20.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 20:40:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with BUG()
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
        <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
        <CACsJy8A7K6-W=H_08JcJgtziz3aQ4B1WgOcsoMSMuSvEQDW8=A@mail.gmail.com>
Date:   Wed, 02 May 2018 12:40:03 +0900
In-Reply-To: <CACsJy8A7K6-W=H_08JcJgtziz3aQ4B1WgOcsoMSMuSvEQDW8=A@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 1 May 2018 13:26:14 +0200")
Message-ID: <xmqqvac6wwrw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Apr 30, 2018 at 12:17 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> t1406 specifically verifies that certain code paths fail with a BUG: ...
>> message.
>>
>> In the upcoming commit, we will convert that message to be generated via
>> BUG() instead of die("BUG: ..."), which implies SIGABRT instead of a
>> regular exit code.
>
> On the other hand, SIGABRT on linux creates core dumps. And on some
> setup (like mine) core dumps may be redirected to some central place
> via /proc/sys/kernel/core_pattern. I think systemd does it too but I
> didn't check.
>
> This moving to SIGABRT when we know it _will_ happen when running the
> test suite will accumulate core dumps over time and not cleaned up by
> the test suite. Maybe keeping die("BUG: here is a good compromise.

I do not think it is.  At regular runtime, we _do_ want Git to dump
core if it triggers BUG() condition, whose point is to mark
conditions that should never happen.

As discussed in this thread, tests that use t/helper/ executables
that try to trickle BUG() codepath to ensure that these "should
never happen" conditions are caught do need to deal with it.  If
dumping core is undesirable, tweaking BUG() implementation so that
it becomes die("BUG: ...") *ONLY* when the caller knows what it is
doing (e.g. running t/helper/ commands) is probably a good idea.
Perhaps GIT_TEST_OPTS can gain one feature "--bug-no-abort" and set
an environment variable so that implementation of BUG() can notice,
or something.

When we are testing normal parts of Git outside t/helper/, we never
want to hit BUG().  Aborting and dumping core when that happens is
an desirable outcome.  From that point of view, the idea in 1/6 of
this patch series to annotate test_must_fail and say "we know this
one is going to hit BUG()" is a sound one.  The implementation in
1/6 to treat SIGABRT as an acceptable failure needs to be replaced
to instead use the above mechanism you would use to tell BUG() not
to abort but die with message to arrange that to happen before
running the git command (most likely something from t/helper/) under
test_must_fail ok=sigabrt; and then those who regularly break their
Git being tested (read: us devs) and hit BUG() could instead set the
environment variable (i.e. internal implementation detail) manually
in their environment to turn these BUG()s into die("BUG:...)s while
testing their early mistakes if they do not want core (of course,
you could just do "ulimit -c", and that may be simpler solution of
your "testing Git contaminates central core depot" issue).






