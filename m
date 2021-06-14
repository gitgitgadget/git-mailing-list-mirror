Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B1C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9043161057
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhFNTol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhFNTok (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 15:44:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012AC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 12:42:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g18so46063555edq.8
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9Bx+4VCd9XqB2UzPDIQePKv0CAmiPYd7IIO4zCD6LTs=;
        b=osJfl1OiIVSh/RjPe9t+Mfo3LOIm0rkqTHe7x9L9bweFL/0uTN8C996dniyQ+FGn+Y
         qdgSZVPpYdHN7801SsTibqJoad8V5LWh1bdlKcG4TmkZ2GsAjhCdmhOJnTbTAC/+bOvZ
         9N56KNP4ZMDjbx3I6hJDgQiyO5UQ2pyMRyWMzSixOl6PBKyp3sdT0oZvcYfDXCtVeR6y
         5P7a2ompOFs2A+Tn5qW59iliOg/YNJljFpEEiJwcwVQy9SVxZX4E2gwT1L2CbmamJ69D
         30C0VZZbpPVDKPjejJ6ch4so3Il7mByFbnoCCKSX+K2qK6V5V5+TAuRnkYfiJ9JCoK23
         +23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9Bx+4VCd9XqB2UzPDIQePKv0CAmiPYd7IIO4zCD6LTs=;
        b=Ojr+YqiSH10d8ft+DrtTtn4ljnQl6yuL5cH8gK2BD/nY6auSWF/N98ihH/hCHiznKY
         F/JV8c6EFiJFdDtetOSMKIRstzWjbHW91nGsue2vdKQP1frU6Nus7ncqHwkpWnEIg2qL
         Gj9LCtYSCA+gdoqdv7R5tUW/9Y4X8LgCdt0JWO3PxQ6A6HrcErhd7U29mkoQ8xBp1PeR
         YKBQXCfhj6qpwUPEDDFk55dJ8kLdbrs69b0LTrm5kMTC2bIZQwohaRRSDM8K0Me+SHgJ
         Nk8E9gshQ1ES24ne5NjcL+CdiqJYXpV+sliXysAwZG04soewjNPgR2vkC9lM9tYNrsqA
         B7pQ==
X-Gm-Message-State: AOAM531eY4IizwJK7dtw1DWf73zMZIjs+Fgf2LGHfA9qw8WYGqNzY4Gg
        lxwIEjF4JrU7ZeeXYvkkVjM=
X-Google-Smtp-Source: ABdhPJwNj556C+6pqyuO93gJasQmYcxsGb1KJikJ6cA6aPOLYXbZUuVmxNl42BE804gLv9Qgt0h6ww==
X-Received: by 2002:aa7:c7c7:: with SMTP id o7mr19273080eds.231.1623699755468;
        Mon, 14 Jun 2021 12:42:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dh18sm9912233edb.92.2021.06.14.12.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:42:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Mon, 14 Jun 2021 21:08:11 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
 <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
 <87lf7k2bem.fsf@evledraar.gmail.com>
 <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
 <87zgvszo8i.fsf@evledraar.gmail.com>
 <4f251a35-8b5e-30f0-c742-960cb7c30b57@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <4f251a35-8b5e-30f0-c742-960cb7c30b57@web.de>
Message-ID: <87o8c8z105.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 14 2021, Ren=C3=A9 Scharfe wrote:

> Am 14.06.21 um 13:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Thu, Jun 10 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 09.06.21 um 00:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:
>>>>
>>>>> I wonder (only in a semi-curious way, though) if we can detect
>>>>> off-by-one errors by adding an assertion to display_progress() that
>>>>> requires the first update to have the value 0, and in stop_progress()
>>>>> one that requires the previous display_progress() call to have a value
>>>>> equal to the total number of work items.  Not sure it'd be worth the
>>>>> hassle..
>>>>
>>>> That's intentional. We started eating 3 apples, got to one, but now our
>>>> house is on fire and we're eating no more apples today, even if we
>>>> planned to eat 3 when we sat down.
>>>>
>>>> The progress bar reflects this unexpected but recoverable state:
>>>>
>>>>     $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
>>>>       ./helper/test-tool progress --total=3D3 Apples 2>&1 |
>>>>       cat -v | perl -pe 's/\^M\K/\n/g'
>>>>     Apples:   0% (0/3)^M
>>>>     Apples:  33% (1/3)^M
>>>>     Apples:  33% (1/3), done.
>>>>
>>>> We're at 1/3, but we're done. No more apples.
>>>>
>>>> This isn't just some hypothetical, e.g. consider neeing to unlink() or
>>>> remove files/directories one at a time in a directory and getting the
>>>> estimated number from st_nlink (yeah yeah, unportable, but it was the
>>>> first thing I thought of).
>>>>
>>>> We might think we're processing 10 entries, but another other processes
>>>> might make our progress bar end at more or less than the 100% we
>>>> expected. That's OK, not something we should invoke BUG() about.
>>>
>>> It doesn't have to be a BUG; a warning would suffice.  And I hope not
>>> finishing the expected number of items due to a catastrophic event is
>>> rare enough that an additional warning wouldn't cause too much pain.
>>
>> It's not a catastrophic event, just a run of the mill race condition
>> we'll expect if we're dealing with the real world.
>>
>> E.g. you asked to unlink 1000 files, we do so, we find 10 are unlinked
>> already, or the command is asked to recursively unlink all files in a
>> directory tree, and new ones have showed up.
>>
>> In those cases we should just just shrug and move on, no need for a
>> warning. We just don't always have perfect information about future
>> state at the start of the loop.
>
> If a planned work item is cancelled then it can still be counted as
> done.  Or the total could be adjusted, but that might look awkward.
>
>>> Loops that *regularly* end early are not a good fit for progress
>>> percentages, I think.
>>
>> Arguably yes, but in these fuzzy cases not providing a "total" means
>> showing no progress at all, just a counter. Perhaps we should have some
>> other "provide total, and it may be fuzzy" flag. Not providing it might
>> run into your proposed BUG(), my point was that the current API
>> providing this flexibility is intentional.
>
> Your patch turns a loop that doesn't immediately report skipped items
> into one with contiguous progress updates.  That's a good way to deal
> with the imagined restrictions for error detection.  Another would be
> to make the warnings optional.

I don't see how there's anything wrong with the API use, how it needs a
warning etc.

>>>> Similarly, the n=3D0 being distinguishable from the first
>>>> display_progress() is actually useful in practice. It's something I've
>>>> seen git.git emit (not recently, I patched the relevant code to emit
>>>> more granular progress).
>>>>
>>>> It's useful to know that we're stalling on the setup code before the
>>>> for-loop, not on the first item.
>>>
>>> Hmm, preparations that take a noticeable time might deserve their own
>>> progress line.
>>
>> Sure, and I've split some of those up in the past, but this seems like
>> ducking/not addressing the point that the API use we disagree on has
>> your preferred use conflating these conditions, but mine does not...
>
> Subtle.  If preparation takes a long time and each item less than that
> then the progress display is likely to jump from "0/n" to "i/n", where
> i > 1, and the meaning of "1/n" becomes moot.

In practice we're making humongous jumps all over the place, we don't
write to the terminal for every item processed, and if we did it would
be too fast to be perceptable to the user.

So I don't think this is an issue in the first place, as noted upthread
in <8735tt4fhx.fsf@evledraar.gmail.com>. Regardless of what we think of
the supposed off-by-one issue you seemed to think that it was enough of
an issue to justify complexity at the API use level (needing to think
about "continue" statements in loops, etc.), but now you think it's
moot?

> The progress display could show just the title before the first
> display_progress() call to make the distinction clear.  Would it really
> be useful, though?  Perhaps a trace2 region started by the first
> display_progress() call and ended by the last one (n =3D=3D total) would
> be better.

Yes, it should display 0/N if it's stalled. I have some WIP patches to
do that. I misrecalled that we were updating the progress from the
signal handler, but no, we wait for the first display(), but if we just
call display() from the handler with a "stalled" message we'll clearly
show these cases where we're stalling in the preparation.

>>> Anyway, if no guard rails can be built then we have to rely on our math
>>> skills alone.  Off-by-one errors may look silly, but are no joke -- they
>>> are surprisingly easy to make.
>>
>> ...which, regardless of whether one views a progress of "1/5 items" has
>> "finished 1/5" or "working on 1/5", which I think *in general* is an
>> arbitrary choice, I think the progress.c API we have in git.git clearly
>> fits the usage I'm describing better.
>
> How so?  start_progress() specifies a title and the total number of
> items, display_progress() reports some other number that is shown in
> relation to the total, and stop_progress() finishes the progress line.
> This API is not documented and thus its meaning is (strictly speaking)
> left unspecified.

I don't mean that it's clearly documented, I'm making the case that the
API is most sanely used in the way I've laid out. It seems we're
respectfully disagreeing on that, but ...

> It can be used to show a classic "percent-done progress indicator", as
> https://dl.acm.org/doi/10.1145/1165385.317459 calls it.  That's how I
> read a growing percentage shown by a program, and "done" I understand
> as "has been done" (completed), not as "is being done".

...I think that's pretty moot in the first place, but I also think
thinking about progress.c's idea of the world as "has been done" doesn't
make sense when you look at its API holistically.

> Wikipedia sent me to
> https://chrisharrison.net/projects/progressbars/ProgBarHarrison.pdf,
> which has some fun ideas on how to warp the perception of time for
> users staring at a progress bar, but also states typical ones grow
> with the amount of completed work.

How does the idea that we show "has been done" make sense when you
combine the progress.c API with the display_throughput(). I.e. output
like:
=09
	+Working hard:  50% (1/2)<CR>
	+Working hard:  50% (1/2), 1.91 MiB | 195.00 KiB/s<CR>
	+Working hard:  50% (1/2), 2.86 MiB | 146.00 KiB/s<CR>
	+Working hard:  50% (1/2), 3.81 MiB | 130.00 KiB/s<CR>
	+Working hard:  50% (1/2), 3.81 MiB | 97.00 KiB/s, done.

Given something like (I've locally modified this a bit):

	cat >in <<-\EOF &&
	start 2
	throughput 1 10000
	update
	progress 1
	update
	throughput 100000 10000
	update
	throughput 2000000 20000
	update
	throughput 3000000 30000
	update
	throughput 4000000 40000
	update
	stop
	EOF
	test-tool progress <in 2>stderr &&

That's another reason I'm maintaining that reporting progress as "is
being done" is the only sane way to look at it, because if you think it's
"has been done" you preclude the API from being used for cases where you
e.g. want to download 2 files, each file takes 1 minute, and you want to
show progress on the item itself.

Our API mostly just stops before the "progress on the item itself", but
if you think that layer should be "has been done" doesn't that mean that
display_throughput() would have to be entirely redesigned?

After all there's no way to feed a N for item number into it, it
optionally *updates* the progress on an existing item, such a thing
can't exist if we only call display_progress() to report items as being
done.

I do think the actual output we show is pretty crappy for that use-case,
but that output can be changed, but not really if we insist on the
invariant you're maintaining that display_progress() must only be called
if the item is done.

Just like showing a "stalled" message if we get a signal before we show
the 1st item doing that is actually pretty easy, i.e. we could showh 1/2
downloaded files, and then as we get signals show a spinner...
