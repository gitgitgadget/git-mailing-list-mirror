Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4317F20285
	for <e@80x24.org>; Mon, 28 Aug 2017 04:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbdH1ELf (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 00:11:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37920 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdH1ELe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 00:11:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id t3so5404309pgt.5
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h7gPktY3pcaef1A3hak/hmLeHxHakq7MXmJD6YTNRrY=;
        b=ryDdeFLdHdJ/g+UINzy+Wm9MkjGZ1eFztP0csvbyy2+F5SHxEASMPUO8If8POAmdEs
         uDTS3C+ciE1QE3DN8DRU10bYan0TMlJaIv6FhQKj4bDEynDH3YYn8hjFa3WhGKN6e7aV
         3vw3hw03EYr8fdEeZdlzl+ivG77JEcyi+uLwNKW5YcGnTw3Z90kJjLjJThxFFM2IcYsJ
         meKOCXJLc0QtZyb80D7DJON93HqM3mdFKzP/ik8LzekuVm4XZuX0PnUwp8ixKyNXMF5v
         V4R2qp6aeDeTKPtr+4NzyyPEozKv4oJhvL9QyI7zs4N1drMnGtIFxC+MuHUDlYUEMqfS
         WC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h7gPktY3pcaef1A3hak/hmLeHxHakq7MXmJD6YTNRrY=;
        b=a0veMDZxdsP+c/67ZqoXZoawNmm9DTMilF9mvguCBhqIK38pgNU9ki1kR4Q3+5vipp
         D9PgbWt6Fu6oZt/09dHczHxh2aY0bVIHV2oCvd/9A4ShoJP9vZuIH9T15k72PHkEiMBX
         HtwS7WtibI7Af6ESljlVJnu38KsW5yKthPxJLKhP7aWFXteUMZzznaAc34BuELZGT7ev
         lzKrcmK+W5f58q8TXmIgIYCEzLC/v/2eqAphB5vFn2hFuY56ZjvjP32PhTQjE21EyLQp
         vyiXw/b5GkjU1lnWbCxf7dfS389xNQBboAoesmYZdk4/2CD/kEB7njpDn9fCFsyMdvK6
         vcuQ==
X-Gm-Message-State: AHYfb5izv41FU7ySlpsKddyRqiSAQlJ0s5voY6t58AONMEMz5z3IrKTs
        t8l2i5Q0lJI3YRtoFnq8FXVv2IY/mA==
X-Received: by 10.99.114.73 with SMTP id c9mr5999702pgn.267.1503893494269;
 Sun, 27 Aug 2017 21:11:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sun, 27 Aug 2017 21:11:33 -0700 (PDT)
In-Reply-To: <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com> <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com> <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 28 Aug 2017 06:11:33 +0200
Message-ID: <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 August 2017 at 01:23, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 27, 2017 at 10:04:55PM +0200, Lars Schneider wrote:
>
>> I did run all tests under valgrind using "make valgrind" and I found
>> the following files with potential issues:
>>
>> cat valgrind.out | perl -nE 'say /^==.+\((.+)\:.+\)$/' | sort | uniq -c
>> 7102
>>    2 clone.c
>>   33 common-main.c
>>    6 connect.c
>>   64 git.c
>>    4 ls-remote.c
>>  126 run-command.c
>>   12 transport.c
>>    7 worktree.c
>
> I'm not sure where valgrind.out comes from. The individual
> test-results/*.out files may have valgrind output, but I don't think
> they usually contain leak output.
>
> Doing "valgrind ./git-upload-pack . </dev/null >/dev/null" mentions
> leaked memory but not the locations. Adding --leak-check=full shows that
> most of it comes from format_packet().
>
> And applying Martin's patch drops the "definitely lost" category down to
> 0 bytes (there's still 550k in "still reachable", but those are in the
> "exit will free them for us" category).
>
>> No mention of "pkt-line.c". Did you run Git with valgrind on one of
>> your repositories to find it?
>
> I'm curious, too. I don't think the valgrind setup in our test suite is
> great for finding leaks right now.

Sorry for being brief. I've patched t/valgrind/valgrind.sh to say
"--leak-check=yes". Then I run "./t0000 --valgrind", simply because
running the complete suite gives more reports than I could possibly
process.

Then I check the first few leaks, verify that they're "ok" and add
them to a suppressions-list. Lather, rinse, repeat. A couple of very
targeted and well-motivated suppressions in git.git could perhaps be
motivated, but there are many many reported leaks. My suppressions-list
is getting gross.

I started with t0000 and t0001 because I figure, once I have those basic
suppressions in place (or leaks fixed), I can run some other more
interesting tests. Of course, the concept of "this leak is ok" is a bit
subjective. For example, we might do "return !!create_object(...);"
(function name invented on the fly), which is a leak, and unreachable.
But if this is only done once in builtin/foo.c and the object created is
small, then this could be deemed "ok", since in practice this leak will
never bring anyone over the cliff. If clean-ups in such code would not
just be code churn, then I can of course adjust my definition of "ok"
accordingly.

This is not an attempt to find and fix a huge number of leaks, it's more
to have a good reason to go through call-stacks, convince myself I know
what the code wants to do and how it does it.

Looking at only "unreachable" leaks seems like it should be an
improvement for finding the interesting cases. I'll have less time for
Git this week, but can try it out as time permits.

Thanks for your feedback, both of you.

Martin
