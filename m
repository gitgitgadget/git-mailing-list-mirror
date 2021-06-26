Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B251C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4961C20
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFZUYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 16:24:37 -0400
Received: from mout.web.de ([212.227.15.3]:44329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhFZUYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 16:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624738932;
        bh=kbd1Qx3QEPDHI68oniRLV9vunEP9ZIv9HXNFMf2ZiwQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FzZHIEDS6prffu/Tp5r+g0kBWi6ubTq+6F6s5Q0IBYy+0V6qgvCpUGLWCtTmcWuOv
         xywPefPR6K4ZqS7k+vUZArvb1GEXILDIdqMDEf2MgiQ34Q1pb3DrWZzmiCT/DjiPYN
         KYkHBPQnQOeW5i+ncW+dc+DwjgdM1UGSwuAEr3FA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mr7ek-1lQhbW0mGM-00oZhp; Sat, 26 Jun 2021 22:22:12 +0200
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
 <87h7hr2cx0.fsf@evledraar.gmail.com>
 <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
 <87a6ncy9aq.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
Date:   Sat, 26 Jun 2021 22:22:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87a6ncy9aq.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hg9z56YYiGATsNP8BbcTVqZW/XM84TDf35T0rPgUhqffDljnhoO
 28KGyr2oSwK7AX4YeSw364+FFMixuHhe/sBfrClw/V2J3IKMepAOZ0wGsZfmG+PozAfOHF0
 Sz0yHArYXEULhcf/M6tK0Asdxmzj+e9duI+9VI6DLjXT2mccQcLm+iY387RXLQ60Xy8k8gU
 HZllU2xHkiHatdF6Lj8tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PB826hpaiL0=:X4bGjB7a9uYtHPfx5d7YnZ
 gEIsPVE76lmrGtEzUmAu55B0lo/J3OytfwHO4hvx+g4M3iph/Lpb/yeKjz6novkl+IaGeORiF
 MTFjNdEc2Y7F4TmCbmRHmAOzkojOJnb6i7Zr/rLY0rzsqfogSavj1Vap5K3V4hN1xMR6APu4/
 aKpaobTXQ/S9ZmCx4ga99Vqyx8APF5wOImnHmDJdp0PhPAwOFD/MGzFs7ed5kzQOgiSak/9aY
 Dc/AeIYo350JtO9oeeWWpX1DjkY1ThIE2kxrQZKUGGTr0pA/eZYLBy88kOrW73hCRyU0rM3iQ
 0uGMdFFqytt/0ZTzEsggjADv9Vx61Y0v1rZl6cgBuRwJUE6VfPdO8h/ZJUAwhCERT85WTPgJK
 a6du7hivjNQDuecP2g/M1q6c/L9oQ4jEswA7d+onSasbEqL7pKilJfLKSkYeE2egdEqWCxGWw
 sERW/+jB+Dslm+pnl3nV5bG+Py6N1/cqrwZxftdTZnTiUPiWhOB8DWyRjIMRGKaLvpfTun2ry
 WExVVITpRzaDgcfwHU5qOjexo5h3qLwjPXcr8qneQBjqWkFhyp+36z14THiknvAElFg8VrPKK
 RF+0it5dG27EJccAGwxmp2nX+zmaP4Zcpeb1nYPhWsGfLmKE9hMX6yDRyOhTAe79CIyaOluXm
 dJHtx3YaBRqNc0U1PguKMmKxOPUhUhqe/uJzT3f1OOaH9Q98ux0ksX1TTGf2lJWzjMU9zX3YS
 6hTORQV43Rq7/sub30yU++7e1vlGRr97YVztHzT0ZBHs5fW0gcD7/TPxe/jn0FmV6za4jx8qc
 nsjGbZwSdMurPT5O23V6EBJ4jKA2M29XTkb/EH4mqis43CxtnXaGDbJwI2FNvCUfddWRwjVjf
 LslhBLsu7lN0SHYs6rKnuRgJSq4Nf2F3BsZ2vkbHBDesjWh1LGJgwBBkUauSKuI4vaEDNWjGD
 Q0OVRXUzY0T1MuP2cU9J9xW3WiqjDsBNP7irSRuujK8Esmjvs8irizShN3bm+uhfOTwb9mvgA
 8c7EIGvpnIluTQYhbc7cIpekfV6SccEomfnZ+plJ+ZmQsv8OFb0O63Dvl6MI2nggjZnwN4ueJ
 qA8EFP1GmuSTIUk2+s7dFHGn4ys+LBwzJUe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.06.21 um 16:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jun 26 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 21.06.21 um 22:08 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Mon, Jun 21 2021, Ren=C3=A9 Scharfe wrote:
>>>
>>>> Before an item is done, it should be reported as not done.  After an
>>>> item is done, it should be reported as done.  One loop iteration
>>>> finishes one item.  Thus the number of items to report at the bottom =
of
>>>> the loop is one higher than at the top.  i is the correct number to
>>>> report at the top of a zero-based loop, i+1 at the bottom.
>>
>>> Anyone with more time than sense can go and read over our linked back =
&
>>> forth thread where we're disagreeing on that point :). I think the pat=
tern
>>> in commit-graph.c makes sense, you don't.
>>
>> Thanks for this comment, I think I got it now: Work doesn't count in th=
e
>> commit-graph.c model of measuring progress, literally.  I.e. progress i=
s
>> the same before and after one item of work.
>
> The progress isn't the same, we update the count. Or do you mean in the
> time it takes us to go from the end of the for-loop & jump to the start
> of it and update the count?
>
>> Instead it counts the number of loop iterations.  The model I describe
>> above counts finished work items instead.  The results of the two
>> models differ by at most one despite their inverted axiom regarding
>> the value of work.
>>
>> Phew, that took me a while.
>
> For what it's worth I had some extensive examples in our initial
> thread[1][2] (search for "apple" and "throughput", respectively), that
> you cut out when replying to the relevant E-Mails. I'd think we could
> probably have gotten here earlier :)

Perhaps, but the key point for me was to invert my basic assumption that
a work item has value, and for that I had to realize and state it first
(done above).  A mathematician would have done that in an instant, I
guess ("Invert, always invert").

> I'm a bit confused about this "value of work" comment.

Progress is a counter.  The difference of the counter before and after
a work item is done is one in the count-work model, but zero in the
count-iterations model.

> If you pick up a copy of say a video game like Mario Kart you'll find
> that for a 3-lap race you start at 1/3, and still have an entire lap to
> go when the count is at 3/3.
>
> So it's just a question of whether you report progress on item N or work
> finished on item N, not whether laps in a race have more or less
> value.

These are linked.  If you want to know which lap you are in, the answer
won't change until you start a new lap:

	for (i =3D 0; i < 3; i++) {
		display_progress(p, i + 1);
		drive_one_lap();
		display_progress(p, i + 1);
	}

If you want for know how many laps you finished, the answer will
increase after a lap is done:

	for (i =3D 0; i < 3; i++) {
		display_progress(p, i);
		drive_one_lap();
		display_progress(p, i + 1);
	}

> To reference my earlier E-Mail[1] are you eating the first apple or the
> zeroeth apple? I don't think one is more or less right in the
> mathematical sense, I just think for UX aimed at people counting "laps"
> makes more sense than counting completed items.

The difference between counting iterations and work items vanishes as
their numbers increase.  The most pronounced difference is observed when
there is only a single item of work.  The count-iterations model shows
1/1 from start to finish.  The count-work model shows 0/1 initially and
1/1 after the work is done.

As a user I prefer the second one.  If presented with just a number and
a percentage then I assume 100% means all work is done and would cancel
the program if that status is shown for too long.  With Git I have
learned that only the final ", done" really means done in some cases,
but that's an unnecessary lesson and still surprising to me.

>>> Anyway, aside from that. I think, and I really would be advocating thi=
s
>>> too, even if our respective positions were reversed, that *in this cas=
e*
>>> it makes sense to just take something like SZEDER's patch here
>>> as-is. Because in that file there's some dozen occurrences of that exa=
ct
>>> pattern.
>>
>> The code without the patch either forgets to report the last work item
>> in the count-work-items model or is one short in the count-iterations
>> model, so a fix is needed either way.
>
> It won't be one short, for a loop of 2 items we'll go from:
>
>      0/2
>      1/2
>      1/2, done
>
> To:
>
>      1/2
>      2/2
>      2/2, done
>
> Just like the rest of the uses of the progress API in that file.

Yes, just like I wrote -- the old code is one short compared to the
correct output of the count-iterations method.

For completeness' sake, the correct output of the count-work method
would be:

	0/2
	1/2
	2/2
	2/2, done

> Which is one of the two reasons I prefer this pattern, i.e. this is less
> verbose:
>
>     start_progress()
>     for i in (0..X-1):
>         display_progress(i+1)
>         work()
>     stop_progress()
>
> Than one of these, which AFAICT would be your recommendation:
>
>     # Simplest, but stalls on work()
>     start_progress()
>     for i in (0..X-1):
>         work()
>         display_progress(i+1)
>     stop_progress()
>
>     # More verbose, but doesn't:
>     start_progress()
>     for i in (0..X-1):
>         display_progress(i)
>         work()
>         display_progress(i+1)
>     stop_progress()
>
>     # Ditto:
>     start_progress()
>     display_progress(0)
>     for i in (0..X-1):
>         work()
>         display_progress(i+1)
>     stop_progress()
>
> And of course if your loop continues or whatever you'll need a last
> "display_progress(X)" before the "stop_progress()".

The count-work model needs one more progress update than the
count-iteration model.  We could do all updates in the loop header,
which is evaluated just the right number of times.  But I think that we
rather should choose between the models based on their results.

If each work item finishes within a progress display update period
(half a second) then there won't be any user-visible difference and
both models would do.

> The other is that if you count laps you can have your progress bar
> optionally show progress on that item. E.g. we could if we stall show
> seconds spend that we're hung on that item, or '3/3 ETA 40s". I have a
> patch[3] that takes an initial step towards that, with some more queued
> locally.

A time estimate for the whole operation (until ", done") would be nice.
It can help with the decision to go for a break or to keep staring at
the screen.  I guess we just need to remember when start_progress() was
called and can then estimate the remaining time once the first item is
done.  Stalling items would push the estimate further into the future.

A time estimate per item wouldn't help me much.  I'd have to subtract
to get the number of unfinished items, catch the maximum estimated
duration and multiply those values.  OK, by the time I manage that Git
is probably done -- but I'd rather like to leave arithmetic tasks to
the computer..

Seconds spent for the current item can be shown with both models.  The
progress value is not sufficient to identify the problem case in most
cases.  An ID of some kind (e.g. a file name or hash) would have to be
shown as well for that.  But how would I use that information?

Ren=C3=A9
