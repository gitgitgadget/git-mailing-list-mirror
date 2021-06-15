Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC7C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0ABF60FF4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFOQxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFOQxn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:53:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF3C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:51:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nd37so15939380ejc.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sMDlwkcQ6l0Z4iQ3KE1n7mvw0325fZ0VL/m/YgyQeb8=;
        b=gNHkphP/Nmmti5s2+FqEBnZUntxBHV1vWtR43d81u7srGHJzXRfscWjcu2jkElRk5R
         SCOupYai9enF1biHo7kfZ4Qmci1GTQnqiIKVDtDRQIUIERhGk8CXzJdUYi0GDwQ4xSj+
         qcr9nqDl748rRtRgEX+Srvg0AbgtDtNcWc8SHtLsQe/h/mCNavJkR+1YaS22Tqylzcin
         poWLHw/MqaPBhtmjYlDFJKwSP09AQx5RWP7vOdZbm8s8yfuTRNxn35qXeL0sGvyeM8Xm
         tXtk7qLPVMi+l17/qgTWJtIFVeancHHDq8Yesp/WNi2DlzIffbpOUjCVhTVeiJ2AJBNx
         P93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sMDlwkcQ6l0Z4iQ3KE1n7mvw0325fZ0VL/m/YgyQeb8=;
        b=uXJB77pnju2vvejzptNk/Tk8Ed51aXEx7nYJEqNtrbSn+6TNPchUkIRwYBJzXdC+7W
         3FQeviHjlBz+mXbz2FAkzIdENX9GXeCs8erRA3laklHeG8R219fMr6Ag2EuZSymRWs4k
         Ctwo5lzWGVUg2H5lvi+8vdmpENHBMIfHeufKh5KgNgjVvrjc0sM0Dqp+ALwLNX1Abdiw
         4SB8v7ORnlTNP8MtVzgzbHi2sCsxCV89fp+3Roeoxx1QMn8Etz7yuLNHARt3txXUw/dI
         Kh26AOexhFC8Hr8LaC8RtfiBk9MZpyegpy2jEhYYiTZonpKTT+F2COg6az+CLRsFhq/x
         lyYQ==
X-Gm-Message-State: AOAM533921agPU5h8nLBgz2hE9/FMiVA4qns1W5a9bf2xkRuVdyN1dpN
        74VkaDWkRJv6frHHITEdazg=
X-Google-Smtp-Source: ABdhPJwiTmGfMwKogiagTfuTWdUaHg/rTYv1VAOlh3dYCierMyg5vFF4jO+2U9Y0mPWNHSkWDJRjPw==
X-Received: by 2002:a17:906:9715:: with SMTP id k21mr477634ejx.553.1623775895860;
        Tue, 15 Jun 2021 09:51:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r12sm12608589edv.82.2021.06.15.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:51:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Tue, 15 Jun 2021 18:46:17 +0200
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
 <87o8c8z105.fsf@evledraar.gmail.com>
 <34d5febf-508c-52b8-a04b-98298d75bd8d@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <34d5febf-508c-52b8-a04b-98298d75bd8d@web.de>
Message-ID: <877divystm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Ren=C3=A9 Scharfe wrote:

> Am 14.06.21 um 21:08 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Jun 14 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 14.06.21 um 13:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Thu, Jun 10 2021, Ren=C3=A9 Scharfe wrote:
>>>>
>>>>> Am 09.06.21 um 00:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>>>
>>>>>> On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:
>>>>>>
>>>>>>> I wonder (only in a semi-curious way, though) if we can detect
>>>>>>> off-by-one errors by adding an assertion to display_progress() that
>>>>>>> requires the first update to have the value 0, and in stop_progress=
()
>>>>>>> one that requires the previous display_progress() call to have a va=
lue
>>>>>>> equal to the total number of work items.  Not sure it'd be worth the
>>>>>>> hassle..
>>>>>>
>>>>>> That's intentional. We started eating 3 apples, got to one, but now =
our
>>>>>> house is on fire and we're eating no more apples today, even if we
>>>>>> planned to eat 3 when we sat down.
>>>>>>
>>>>>> The progress bar reflects this unexpected but recoverable state:
>>>>>>
>>>>>>     $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
>>>>>>       ./helper/test-tool progress --total=3D3 Apples 2>&1 |
>>>>>>       cat -v | perl -pe 's/\^M\K/\n/g'
>>>>>>     Apples:   0% (0/3)^M
>>>>>>     Apples:  33% (1/3)^M
>>>>>>     Apples:  33% (1/3), done.
>>>>>>
>>>>>> We're at 1/3, but we're done. No more apples.
>>>>>>
>>>>>> This isn't just some hypothetical, e.g. consider neeing to unlink() =
or
>>>>>> remove files/directories one at a time in a directory and getting the
>>>>>> estimated number from st_nlink (yeah yeah, unportable, but it was the
>>>>>> first thing I thought of).
>>>>>>
>>>>>> We might think we're processing 10 entries, but another other proces=
ses
>>>>>> might make our progress bar end at more or less than the 100% we
>>>>>> expected. That's OK, not something we should invoke BUG() about.
>>>>>
>>>>> It doesn't have to be a BUG; a warning would suffice.  And I hope not
>>>>> finishing the expected number of items due to a catastrophic event is
>>>>> rare enough that an additional warning wouldn't cause too much pain.
>>>>
>>>> It's not a catastrophic event, just a run of the mill race condition
>>>> we'll expect if we're dealing with the real world.
>>>>
>>>> E.g. you asked to unlink 1000 files, we do so, we find 10 are unlinked
>>>> already, or the command is asked to recursively unlink all files in a
>>>> directory tree, and new ones have showed up.
>>>>
>>>> In those cases we should just just shrug and move on, no need for a
>>>> warning. We just don't always have perfect information about future
>>>> state at the start of the loop.
>>>
>>> If a planned work item is cancelled then it can still be counted as
>>> done.  Or the total could be adjusted, but that might look awkward.
>>>
>>>>> Loops that *regularly* end early are not a good fit for progress
>>>>> percentages, I think.
>>>>
>>>> Arguably yes, but in these fuzzy cases not providing a "total" means
>>>> showing no progress at all, just a counter. Perhaps we should have some
>>>> other "provide total, and it may be fuzzy" flag. Not providing it might
>>>> run into your proposed BUG(), my point was that the current API
>>>> providing this flexibility is intentional.
>>>
>>> Your patch turns a loop that doesn't immediately report skipped items
>>> into one with contiguous progress updates.  That's a good way to deal
>>> with the imagined restrictions for error detection.  Another would be
>>> to make the warnings optional.
>>
>> I don't see how there's anything wrong with the API use, how it needs a
>> warning etc.
>
> You pointed out that many callsites do:
>
> 	for (i =3D 0; i < large_number; i++) {
> 		display_progress(p, i + 1);
> 		/* work work work */
> 	}
>
> This is an off-by-one error because a finished item is reported before
> work on it starts.  Adding a warning can help find these cases reliably.

I understand that we're respectfully disagreeing and that's what you
think, but I really don't think it helps anyone if we just repeat our
respective points.

I don't think it's off-by-one, but you do.

Yes, I understand that you think that progress bars should absolutely
never ever show 1/5 if the first item is not finished. I disagree and
think that's not intuitive, per my "eating an Apple" example
upthread.

We disagree, and I for one think I understand what you mean, perhaps you
don't understand what I mean, but let's try to move on.

>>>>>> Similarly, the n=3D0 being distinguishable from the first
>>>>>> display_progress() is actually useful in practice. It's something I'=
ve
>>>>>> seen git.git emit (not recently, I patched the relevant code to emit
>>>>>> more granular progress).
>>>>>>
>>>>>> It's useful to know that we're stalling on the setup code before the
>>>>>> for-loop, not on the first item.
>>>>>
>>>>> Hmm, preparations that take a noticeable time might deserve their own
>>>>> progress line.
>>>>
>>>> Sure, and I've split some of those up in the past, but this seems like
>>>> ducking/not addressing the point that the API use we disagree on has
>>>> your preferred use conflating these conditions, but mine does not...
>>>
>>> Subtle.  If preparation takes a long time and each item less than that
>>> then the progress display is likely to jump from "0/n" to "i/n", where
>>> i > 1, and the meaning of "1/n" becomes moot.
>>
>> In practice we're making humongous jumps all over the place, we don't
>> write to the terminal for every item processed, and if we did it would
>> be too fast to be perceptable to the user.
>>
>> So I don't think this is an issue in the first place, as noted upthread
>> in <8735tt4fhx.fsf@evledraar.gmail.com>. Regardless of what we think of
>> the supposed off-by-one issue you seemed to think that it was enough of
>> an issue to justify complexity at the API use level (needing to think
>> about "continue" statements in loops, etc.), but now you think it's
>> moot?
>
> I don't understand your question.  Let me rephrase what I find moot:
>
> You wrote that the first display_progress() call being made with n>0
> would be useful to you to see long-running preparations.  If items are
> processed quicker than one per second, then whatever number the first
> display_progress() call writes to the screen will be overwritten within
> a second.  So the value of the first update shouldn't actually matter
> much for your use case -- unless items takes a long time to process.

I think it would be better if you replied specifically to the comments I
had later about throughput progress bars, i.e.:

    How does the idea that we show "has been done" make sense when you
    combine the progress.c API with the display_throughput(). I.e. output
    like[...]

Anyway, in this case I understood you to mean that you thought the
off-by-one wasn't a big deal in practice most of the time, I don't think
so either for e.g. counting objects in pack files.

I do think it's useful to be consistent though, and for e.g. cases of
downloading 5 files it makes sense to show 1/5 if we are currently in
the process of downloading files 1 out of 5, not 0/5 or whatever.
