Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9EBC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B172A61879
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGFQFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:05:13 -0400
Received: from mout.web.de ([212.227.17.12]:37295 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhGFQFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 12:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625587352;
        bh=8vTeuoaSKWOyml6GEw3TeKD/shKUHP3tP3cWlIr7zhs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R3REgtpQT7BUApFfKdU9dZPBnuxC4BSj/kNEBTZLCJdx9Er/LpzkleSs0qvb0BerA
         SPM9pbqnv05Br/MUZtuh0dlUrXDEmm0Y+sks7PFiNWnTdmQVt7jU0gOSqL6tkTpjWe
         Cj6udflj0T94ZfVnHo6WBYKyFPb1+MoR8/ete8Co=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MUncu-1lflZc2l7U-00YAAm; Tue, 06 Jul 2021 18:02:32 +0200
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
 <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
 <874kdkxot4.fsf@evledraar.gmail.com>
 <ca3eba46-7c83-51fd-2d65-c55309ac7182@web.de>
 <87y2ak5noa.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0a03bae6-53cf-98e5-635a-6f61583f5dd1@web.de>
Date:   Tue, 6 Jul 2021 18:02:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87y2ak5noa.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9KOEtv8y0g9Yd37DeE/KH7nZ1TDRx38YIiJI36cj+ONVbwd3WXN
 UrgwhlHxdmKwHj/nn+idwaxVDvGzIwrlBSweDkvgKRsFBvUxIxWs+ZwZsLfygQfM8VGvyWW
 yy9hUlJwwnjzrhhtOW8E8Uymltyiq7rpZMwnOaZ7exaq12fJvQOJ77hK0TyJRVojWiJLy6m
 I9TKsxwQWjW1LEEpAQcTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QMnWInj/lgs=:xQdj0I9FP8qol78RapmT3u
 lAQi5G9A6j4A7xFqwL9XSbPJL3MwZahke4ZzAsGL4SCeT3nfcAwmGXEL/IbxJDwq1Q4FOQVp8
 pj4PfuorWPdernyuN1hSNAI53oVAatDFAjzkBDrwL1z1s13cX8vIMjcmP/FNJ5WlFQ5ITAJRK
 iktjm67LQwE9OHN95kmRbD40A5L6HeY+lRYIblruwCsUaDXfY1OENAoq4sTkpC1Hk8dzjbAa/
 Mw9NFANgjXnc6W2TbgLeaXw+DzD2B69WiCisDIZNh/4TQi35TbVT09bvTMFNaJZMiAIOJ4MsB
 kOc8gtjXgyg1CEGz8LgB6H+TjLu5ERE/5bG4sMO07t87FodhYXwI8y7P2YSL57e5TENr5Uf4u
 q6A/Xs+R9oC3VJoAe+URaapyMiutCcvlbdUyFESAUno09nrNV8ZHeuRnXMq+Tqm65ejNw37kG
 k6x+qmI0yRxE4muoDebumBz0PenN9XceZ7QdWt9983JGj4t/KeFo5ugLFiFQBI09aLJaCp/MI
 XL4fFlxm1naP2DHchGiq0Yyn3oRSP6WiW5ESOY0u5q8YFg6SIJWnq9pyeWalwSQ7YnD4NN3DY
 ImbiRMaPUXPwQXdLkQombgjdcQCng6pmzhAAJF4TEPKiSYSD9HiMGOP3n5UxOGpg/nfPnf0S7
 sCkdgwIK6ouhFMyjNVFKjFFZ3gbrmVRNo3tpE6t2fhPH9PvuzPWRGA8bBHKkcwaWqFJ79AgSc
 lR5KC0/VxqBk0tIGZMbD/Qg8PPn+y1s1ltcVi4L4UAfJ0UZdpiCEZbtstxgXQSu54I74WgmRg
 qr7oPuysSok9kU9ho3YCSHJpdv/o7lwQtFRk7BAg5g45TV87I053qx/y6HAKZGYzyXM1T1diS
 QinZO7/WCALWfnHjM4X9IX9HSEzVJTqWr6mXMs/xSON5EA+M0ZFpBh//z7AMFztfK/zjKm7WH
 IM2o/oRMMPibQz5TrE3I20huCQ04E0Ax8skAdeqR8A5A8WWfhPg+gzXbCQMp9hqbYjrjQ3w8g
 NscItBX4dJNmgYRNQxmQWguOXSx2ZvZcSP/9k/QT7wuQE5JE/tBPmzeO62OG1ucd9LxjMASKJ
 mG09HlCR7h4TTwjrRbg+IQVZlpptTkDKUiw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.07.21 um 01:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Jul 04 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 26.06.21 um 23:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Sat, Jun 26 2021, Ren=C3=A9 Scharfe wrote:
>>>
>>>> Am 26.06.21 um 16:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> The only one I know of is "Enumerating objects", which notably stalls =
at
>>> the start, and which I'm proposing changing the output of in:
>>> https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-a=
varab@gmail.com/
>>
>> That's annoying, but the first number I see there has five or six digit=
s,
>> so it's not an example of the issue mentioned above for me.
>
> Because it stalls and shows nothing, but with my patch it'll show
> something while stalling, FWIW on linux.git from a cold cache it took
> 5-10s before showing anything.
>
>> Your patch shows ", stalled." while pack-objects starts up.  I'm not su=
re
>> this helps.  Perhaps there are cases when it gets stuck, but it's hard =
to
>> determine by the clock alone.  When I run gc, it just needs a few secon=
ds
>> to prepare something and then starts visibly counting objects.  A more
>> fine-grained report of the preparation steps would help, but seeing
>> "stalled" would just scare me.
>
> Fair enough, I have other patches to have it show a spinner. Again, API
> v.s. UI. The idea is that we show something before we start the loop.

A spinner would be nicer, but I would be more interested to see what it is
actually spending all that time on.  A separate progress line might be
justified here.

>>> Also, because for these cases that you're focusing on where we count u=
p
>>> to exactly 100% and we therefore expect N calls to display_progress()
>>> (igroning the rare but allowed duplicate calls with the same number,
>>> which most callers don't use). We could just have a convenience API of=
:
>>>
>>>     start_progress()
>>>     for i in (0..X-1):
>>>         progress_update() /* passing "i" not needed, we increment inte=
rnally */
>>>         work()
>>>     stop_progress()
>>>
>>> Then we could even make showing 0/N or 1/N the first time configuable,
>>> but we could only do both if we use the API as I'm suggesting, not as
>>> you want to use it.
>>
>> A function that increments the progress number relatively can be used
>> with both models.  It's more useful for the count-iterations model,
>> though, as in the count-work model you can piggy-back on the loop
>> counter check:
>>
>> 	for (i =3D 0; display_progress(p, i), i < X; i++)
>> 		work();
>
> Aside from this whole progress API discussion I find sticking stuff like
> that in the for-loop body to be less readable.
>
> But no, that can't be used with both models, because it conflates the 0
> of the 1st iteration with 0 of doing prep work. I.e.:
>
>     p =3D start_progress();
>     display_progress(p, 0);
>     prep_work();
>     for (i =3D 0; i < 100; i++)
>         display_progress(p, i + 1);
>
> Which is implicitly how that "stalled" patch views the world, i.e. our
> count is -1 is at start_progress() (that's already the case in
> progress.c).
>
> If you set it to 0 you're not working on the 1st item yet, but
> explicitly doing setup.
>
> Then at n=3D1 you're starting work on the 1st item.

A distinct preparation phase feels like an extension to the progress
API.  A symmetric cleanup phase at the end may make sense as well then.

I assume that preparations would be done between the start_progress call
and the first display_progress (no matter what number it reports).  And
cleanup would be done between the last display_progress call and the
stop_progress call.

In the count-iterations model this might report the time taken fro the
first or last item as preparation or cleanup depending on the placement
of the display_progress call.  That shouldn't be much of a problem,
though, as the value of one work item is zero in that model.

> FWIW the "complicated" here was referring to dealing with break/continue=
.
>
> Yes I'll grant you that there's cases where the uglyness/oddity of that
> for-loop trick is going to be better than dealing with that, but there's
> also while loops doing progress, callbacks etc.

while loops can easily be converted to for loops, of course.

Callbacks are a different matter.  I think we should use them less in
general (they force different operations to use the same set of
parameters, which is worked around with context structs).  A function
to increment progress would help them because then they wouldn't need
to keep track of the item/iteration count themselves in a context
variable.

However, in some cases display_progress calls are rate-limited, e.g.
midx_display_sparse_progress does that for performance reasons.  I
wonder why, and whether this is a problem that needs to be addressed
for all callers.  We don't want the progress API to delay the actual
progress significantly!  Currently display_progress avoids updating
the progress counter; an increment function would need to write an
updated value at each call.

> Picking an API pattern that works with all of that makes sense, since
> the UI can render the count one way or the other.

Right.

>>> If we do run into those cases and want to convert them to show some
>>> intra-item progress we'd need to first migrate them over to suggested
>>> way of using the API if we picked yours first, with my suggested use w=
e
>>> only need to add new API calls (display_throughput(), and similar futu=
re
>>> calls/implicit display).
>>
>> I don't see why.  The intra-item progress numbers need to be reported i=
n
>> any case if they are to be shown somehow.  If the model is clear then w=
e
>> can show unambiguous output.
>
> Because you want to show:
>
>     Files 1/3 (33%) Bytes 17kB/9GB (0%)
>
> Not:
>
>     Files 0/3 (33%) Bytes 17kB/9GB (0%)
>
> You're downloading the 1st file, not the 0th file, so the code is a
> for-loop (or equivalent) with a display_progress(p, i + 1) for that
> file, not display_progress(p, i).
>
> This is the main reason I prefer the API and UI of reporting "what item
> am I on?" v.s. "how many items are done?", because it's easy to add
> intra-item state to the former.

Both look confusing.  If I'd care enough about one of the files or each
of them that I'd like to know their individual progress then I'd
certainly would want to see their names instead of some random number.

And as you write above: The display part can easily add or subtract one
to convert the number between models.

> Sure, anyway, let's assume all those numbers are magically known and
> constant. The point was that as noted above you're downloading the 1st
> file, not the 0th file, and want to show throughput/ETA etc. for that
> file.

OK, but still some kind of indication would have to be given that the
Bytes relate to a particular File instead of being the total for this
activity.  Perhaps like this, but it's a bit cluttered:

   File 1 (Bytes 17kB/9GB, 0% done) of 3 (0% done in total)

Ren=C3=A9
