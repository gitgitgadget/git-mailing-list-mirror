Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D5C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 22:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094AD61C23
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 22:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFZWKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 18:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhFZWKC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 18:10:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31BC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 15:07:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yy20so13815368ejb.6
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JRmQq+kDyPiNXzLXWoTZWlBsExHE6a4M2taCkTywr6c=;
        b=BOLPwf09ccnjguMgUdvogrH8SIS24gZOfElDYmhg8QwKYxkW2IypFGzgAdZPlfqpcQ
         dzxqo7rYD9H0qXOt0pGXMTxAbBiZca/F1FcN0EJGVxpzvAS4zBByRh9bhgrbd45i1424
         EzZ2ToWDzx0VmKIfIG/uE0k28gC7x8uY/qlQEIKJJ3baaaDmxZqOthaJNYIuK14MEeE0
         PGXO9ngsqVWgyHJrabICsJ9sNcLLc3UzkiXBdoi3ZYNkDL64/EZaWP52N6jO61iVW45B
         2lQes9T1V2ESH5JCw9XbwurjyR6Irza7ZorXRSgzNgr8w4fbH5B6HzYxXhDF1kCYzZKl
         t/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JRmQq+kDyPiNXzLXWoTZWlBsExHE6a4M2taCkTywr6c=;
        b=BdvsHiyDXj2PWI8e3CaTYwB6cuvyX/u8oVwE3emYC0j3gcL+oukV7EVX29smTGt1lW
         efO+Zw7C3a1l0u94EsHchwE8OyyAmB/TjzMINsOkWAqS5YGhVxONd6obGs+sqhSziEKb
         7hIqmOZVn4woEQOkQbcPp+Bvu2RaCWHH7oUdfd4b4aRaSpClDEReFqHtDSgjyKwg+NFj
         QlYwSymrArCG5ewj7U/KGYRqBoo2S9B2pKntSlvn6yls2cvz7orV0V0CABhizV3OjxPU
         XrqMoKroWhOXXx+X4DmQCP580BsjAl2OA2Bd839nvyK6mJ5gdyuSGyEyTRRgpAIvIn1O
         4gJQ==
X-Gm-Message-State: AOAM532fxV6eZ1hoPlnwnT+YM1PT40jxc3Gi2izhHD4atvgQ5Lu8xvbN
        o3lszpX2OoZnhaB6sQwuKJI=
X-Google-Smtp-Source: ABdhPJy53T4s0IZlRS0tjOv9X4344fVzmgJbNk1XzKTxLA4qbX6605C3wbOBNtk2XAz1S1T6KzOZQA==
X-Received: by 2002:a17:906:2892:: with SMTP id o18mr17348486ejd.370.1624745256407;
        Sat, 26 Jun 2021 15:07:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j22sm5016417ejt.11.2021.06.26.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 15:07:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Date:   Sat, 26 Jun 2021 23:38:38 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
 <87h7hr2cx0.fsf@evledraar.gmail.com>
 <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
 <87a6ncy9aq.fsf@evledraar.gmail.com>
 <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
Message-ID: <874kdkxot4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 26 2021, Ren=C3=A9 Scharfe wrote:

> Am 26.06.21 um 16:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> [...]
>> To reference my earlier E-Mail[1] are you eating the first apple or the
>> zeroeth apple? I don't think one is more or less right in the
>> mathematical sense, I just think for UX aimed at people counting "laps"
>> makes more sense than counting completed items.
>
> The difference between counting iterations and work items vanishes as
> their numbers increase.  The most pronounced difference is observed when
> there is only a single item of work.  The count-iterations model shows
> 1/1 from start to finish.  The count-work model shows 0/1 initially and
> 1/1 after the work is done.
>
> As a user I prefer the second one.  If presented with just a number and
> a percentage then I assume 100% means all work is done and would cancel
> the program if that status is shown for too long.  With Git I have
> learned that only the final ", done" really means done in some cases,
> but that's an unnecessary lesson and still surprising to me.

What progress bar of ours goes slow enough that the difference matters
for you in either case?

The only one I know of is "Enumerating objects", which notably stalls at
the start, and which I'm proposing changing the output of in:
https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-avarab=
@gmail.com/

>> [...]
>> Which is one of the two reasons I prefer this pattern, i.e. this is less
>> verbose:
>>
>>     start_progress()
>>     for i in (0..X-1):
>>         display_progress(i+1)
>>         work()
>>     stop_progress()
>>
>> Than one of these, which AFAICT would be your recommendation:
>>
>>     # Simplest, but stalls on work()
>>     start_progress()
>>     for i in (0..X-1):
>>         work()
>>         display_progress(i+1)
>>     stop_progress()
>>
>>     # More verbose, but doesn't:
>>     start_progress()
>>     for i in (0..X-1):
>>         display_progress(i)
>>         work()
>>         display_progress(i+1)
>>     stop_progress()
>>
>>     # Ditto:
>>     start_progress()
>>     display_progress(0)
>>     for i in (0..X-1):
>>         work()
>>         display_progress(i+1)
>>     stop_progress()
>>
>> And of course if your loop continues or whatever you'll need a last
>> "display_progress(X)" before the "stop_progress()".
>
> The count-work model needs one more progress update than the
> count-iteration model.  We could do all updates in the loop header,
> which is evaluated just the right number of times.  But I think that we
> rather should choose between the models based on their results.

I think we should be more biased towards API convenience here than
anything else, because for most of these they'll go so fast that users
won't see the difference. I just also happen to think that the easy way
to do it is also more correct.

Also, because for these cases that you're focusing on where we count up
to exactly 100% and we therefore expect N calls to display_progress()
(igroning the rare but allowed duplicate calls with the same number,
which most callers don't use). We could just have a convenience API of:

    start_progress()
    for i in (0..X-1):
        progress_update() /* passing "i" not needed, we increment internall=
y */
        work()
    stop_progress()

Then we could even make showing 0/N or 1/N the first time configuable,
but we could only do both if we use the API as I'm suggesting, not as
you want to use it.

You also sort of can get me what I want with with what you're
suggesting, but you'd conflate "setup" work with the first item, which
matters e.g. for "Enumerating objects" and my "stalled" patch. It's also
more verbose at the code level, and complex (need to deal with "break",
"continue"), so why would you?

Which I think is the main point of our not so much disagreement but I
think a bit of talking past one another.

I.e. I think you're narrowly focused on what I think of as a display
issue of the current progress bars we show, I'm mainly interested in how
we use the API, and we should pick a way to use it that allows us to do
more with displaying progress better in the future.

> If each work item finishes within a progress display update period
> (half a second) then there won't be any user-visible difference and
> both models would do.

A trivial point, but don't you mean a second? AFAICT for "delayed" we
display after 2 seconds, then update every 1 seconds, it's only if we
have display_throughput() that we do every 0.5s.

>> The other is that if you count laps you can have your progress bar
>> optionally show progress on that item. E.g. we could if we stall show
>> seconds spend that we're hung on that item, or '3/3 ETA 40s". I have a
>> patch[3] that takes an initial step towards that, with some more queued
>> locally.
>
> A time estimate for the whole operation (until ", done") would be nice.
> It can help with the decision to go for a break or to keep staring at
> the screen.  I guess we just need to remember when start_progress() was
> called and can then estimate the remaining time once the first item is
> done.  Stalling items would push the estimate further into the future.
>
> A time estimate per item wouldn't help me much.  I'd have to subtract
> to get the number of unfinished items, catch the maximum estimated
> duration and multiply those values.  OK, by the time I manage that Git
> is probably done -- but I'd rather like to leave arithmetic tasks to
> the computer..
>
> Seconds spent for the current item can be shown with both models.  The
> progress value is not sufficient to identify the problem case in most
> cases.  An ID of some kind (e.g. a file name or hash) would have to be
> shown as well for that.  But how would I use that information?

If we're spending enough time on one item to update progress for it N
times we probably want to show throughput/progress/ETA mainly for that
item, not the work as a whole.

If we do run into those cases and want to convert them to show some
intra-item progress we'd need to first migrate them over to suggested
way of using the API if we picked yours first, with my suggested use we
only need to add new API calls (display_throughput(), and similar future
calls/implicit display).

Consider e.g. using the packfile-uri response to ask the user to
download N number of URLs, just because we grab one at 1MB/s that
probably won't do much to inform our estimate of the next one (which may
be on a different CDN etc.).

The throughput API was intended (and mainly used) for the estimate for
the whole batch, I just wonder if as we use it more widely whether that
use-case won't be the exception.
