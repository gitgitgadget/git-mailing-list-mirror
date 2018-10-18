Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C671F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeJSCRh (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:17:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46109 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeJSCRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:17:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so35344327qtk.13
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fMTF3oTC3i2GSDn8z5iePlCPYRdcMYfy9fwdjVnPoGw=;
        b=CFoaAft4r+ZQvcA/xdroaRaFdFf09LAePPtaTyrzb2agTVdHo20ypZitXkreQComk/
         PBe3efNTwDkdjC7g53EOSWmHJKC6Mw3DIxRttxvdRnFja/471waD2ejmjYQKolFWiM3C
         ES2RAJQEIUXlKwvwZk5CQ2J7Xc8d7DA87DyuFYe5ItTsrYF3M3kZcEKFt0cEDLwsXDB+
         TW+uFdcV5iPhb4lnkwJtWTTtKq93+HTsxWkJbGFIlbSDqrG0n7OX+5pItpTWfhOVS192
         WU7vk0NgfcEl9/0vM2aC06HmBqwl3ZB/mOI9PQ/jzW+9800Fq3nlm6EwtLfVLfqk2yL8
         jOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMTF3oTC3i2GSDn8z5iePlCPYRdcMYfy9fwdjVnPoGw=;
        b=jULMOk7adMi8ICJeBaP+McJpo+v0LWpJ9IAeJCP10yULq8ON2IsKsTKbq4JaPbNh6p
         xCRXuXZRXnX5sglkS2AE+4sggfMeF5NLLtdpQT+RE7Y4XlKykVJUxxQBVef9i+bDek3N
         oxUiCys3L+jZx0k2DPWEE6m3CpCKSeMkkBhiVsiiGaPYmAdr/UDNYij+FgJpfsudmXLr
         Yr6UhEC5KFNBGkrvpbKpgj2RFjERx6xkCYG8REQ7LSF8Peml9A1d4n0cByQDmsLGdQgG
         IB1Ap5v4hZr73UsFX5oZ5oPDNFQQbCx0cBSGpQN+NwbTbDtJGZdyLg8HxunuObXCBswB
         K4oQ==
X-Gm-Message-State: ABuFfogL/G4j9oywUI8G9IZYA/Oj0JgYLfCMxtgBigDUoC49/L0FVJ2W
        5aCmYAWanSP4wMzIwH0oq38=
X-Google-Smtp-Source: ACcGV632qb2KWkW7JYtJuXai6uDhU0I+zYDM7SmhC7EzsE6d3A3HEtbVmiNi6R1pPp7Or0KKJ81W+Q==
X-Received: by 2002:a0c:ae76:: with SMTP id z51-v6mr31629379qvc.108.1539886526808;
        Thu, 18 Oct 2018 11:15:26 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id q21-v6sm17048647qta.77.2018.10.18.11.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:15:25 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset
 when --quiet
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-2-peartben@gmail.com>
 <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
 <20181017182255.GC28326@sigill.intra.peff.net>
 <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
 <20181018063628.GA23537@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5b4d46c2-ac0b-8a44-5e99-b0926ea764d3@gmail.com>
Date:   Thu, 18 Oct 2018 14:15:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018063628.GA23537@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/18/2018 2:36 AM, Jeff King wrote:
> On Thu, Oct 18, 2018 at 12:40:48PM +0900, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> Whereas for the new config variable, you'd probably set it not because
>>> you want it quiet all the time, but because you want to get some time
>>> savings. So there it does make sense to me to explain.
>>>
>>> Other than that, this seems like an obvious and easy win. It does feel a
>>> little hacky (you're really losing something in the output, and ideally
>>> we'd just be able to give that answer quickly), but this may be OK as a
>>> hack in the interim.
>>
>> After "git reset --quiet -- this/area/" with this change, any
>> operation you'd do next that needs to learn if working tree files
>> are different from what is recorded in the index outside that area
>> will have to spend more cycles, because the refresh done by "reset"
>> is now limited to the area.  So if your final goal is "make 'reset'
>> as fast as possible", this is an obvious and easy win.  For other
>> goals, i.e. "make the overall experience of using Git feel faster",
>> it is not so obvious to me, though.

The final goal is to make git faster (especially on larger repos) and 
this proposal accomplishes that.  Let's look at why that is.

By scoping down (or eliminating) what refresh_index() has to lstat() at 
the end of the reset command, clearly the reset command is faster.  Yes, 
the index isn't as "fresh" because not everything was updated but that 
doesn't typically impact the performance of subsequent commands.

On the next command, git still has to lstat() every file because it 
isn't sure what changes could have happened in the file system.  As a 
result, the overall impact is that we have had to lstat() every file one 
fewer times between the two commands.  A net win overall.

In addition, the preload_index() code that does the lstat() command is 
highly optimized across multiple threads (and on Windows takes advantage 
of the fscache).  This means that it can lstat() every file _much_ 
faster than the single threaded loop in refresh_index().  This also 
makes the overall performance of the pair of git commands faster as we 
got rid of the slow lstat() loop and kept the fast one.

Here are some numbers to demonstrate that.  These are hot cache numbers 
as they are easier to generate.  Cold cache numbers make the net perf 
win significantly better as the cost for the reset jumps from 2.43 
seconds to 7.16 seconds.

0.32 git add asdf
0.31 git -c reset.quiet=true reset asdf
1.34 git status
1.97 Total


0.32 git add asdf
2.43 git -c reset.quiet=false reset asdf
1.32 git status
4.07 Total

Note the status command after the reset doesn't really change as it 
still must lstat() every file (the 0.02 difference is well within the 
variability of run to run differences).

FWIW, none of these numbers are using fsmonitor.



There was additional discussion about whether this should be tied to the 
"--quiet" option and how it should be documented.

One option would be to change the default behavior of reset so that it 
doesn't do the refresh_index() call at all.  This speeds up reset by 
default so there are no user discoverability issues but changes the 
default behavior which is an issue.

Another option that was suggested was to add a separate flag that could 
be passed to reset so that the "quiet" and "fast" options don't get 
conflated.  I don't care for that option because the two options (at 
this point and for the foreseeable future) would be identical in 
behavior from the end users perspective.

It was also suggested that there be a single "fast and quiet" option for 
all of git instead of separate options for each command.  I worry about 
that because now we're forcing users to choose between the "fast and 
quiet" version of git and the "slow and noisy" version.  How do we help 
them decide which they want?  That seems difficult to explain so that 
they can make a rational choice and also hard to discover.  I also have 
to wonder who would say "give me the slow and noisy version please." :)

I'd prefer we systematically move towards a model where the default 
values that are chosen for various settings throughout the code are all 
configurable via settings.  All defaults by necessity make certain 
assumptions about user preference, data shape, machine performance, etc 
and if those assumptions don't match the user's environment then the 
hard coded defaults aren't appropriate.  We do our best but its going to 
be hit or miss.

A consistent way to be able to change those defaults would be very 
useful in those circumstances.  To be clear, I'm not proposing we do a 
wholesale update of our preferences model at this point in time - that 
seems like a significant undertaking and I don't want to tie this 
specific optimization to a potential change in how default settings work.


To move this forward, here is what I propose:

1) If the '--quiet' flag is passed, we silently take advantage of the 
fact we can avoid having to do an "extra" lstat() of every file and 
scope the refresh_index() call to those paths that we know have changed.

2) I can remove the note in the documentation of --quiet which I only 
added to facilitate discoverability.

3) I can also edit the documentation for reset.quietDefault (maybe I 
should rename that to "reset.quiet"?) so that it does not discuss the 
potential performance impact.

4) To improve the discoverability of the enhanced performance, I could 
add logic similar to what exists for "status --uno" and if 
refresh_index() takes > x seconds, prompt the user with something like:

"It took %.2f seconds to enumerate unstaged changes after reset. 'reset 
--quiet' may speed it up. Set the config setting reset.quiet to true to 
make this the default."


>>
>> If we somehow know that it is much less important in your setup that
>> the cached stat bits in the index is kept up to date (e.g. perhaps
>> you are more heavily relying on fsmonitor and are happy with it),
>> then I suspect that we could even skip the refreshing altogether and
>> gain more performance, without sacrificing the "overall experience
>> of using Git" at all, which would be even better.
> 
> Yeah, I assumed that Ben was using fsmonitor. I agree if we can just use
> that to make this output faster, that would be the ideal. This is the
> "later the message would get faster to produce" I hinted at in my
> earlier message.
> 
> So I think we are in agreement. It just isn't clear to me how much work
> it would take to get to the "ideal". If it's long enough, then this kind
> of hackery may be useful in the meantime.
> 

I actually started my effort to speed up reset by attempting to 
multi-thread refresh_index().  You can see a work in progress at:

https://github.com/benpeart/git/pull/new/refresh-index-multithread-gvfs

The patch doesn't always work as it is still not thread safe.  When it 
works, it's great but I ran into to many difficulties trying to debug 
the remaining threading issues (even adding print statements would 
change the timing and the repro would disappear).  It will take a lot of 
code review to discover and fix the remaining non-thread safe code paths.

In addition, the optimized code path that takes advantage of fsmonitor, 
uses multiple threads, fscache, etc _already exists_ in preload_index(). 
  Trying to recreate all those optimizations in refresh_index() is (as I 
discovered) a daunting task.

This patch was tiny/trivial in comparison and provided all the 
performance benefits so seems like a much better option at this point in 
time.  For now, I suggest we just use that existing path as it provides 
the benefits without the significant additional work and complexity.

> -Peff
> 
