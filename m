Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E00C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjEKWt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjEKWt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 18:49:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A85243
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:49:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f1411e8111so10341463e87.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683845395; x=1686437395;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxwYHBlYBGSyLiYi9w4kgqpVffL6/IO5snQQOT8T3oE=;
        b=nXErGcu4rVMc9UetobnYCKS6Z3I9aA3IjWYQZ/Lxk55Dpom2gfAjfpVDtPL+irCTY2
         oTNu21o1bpkRiFF6crIJOxq9E9c8Ys3kroNXlIjms97c+g1e/v8GcVa+4fMC2njbSMq/
         G8Gyeue5bpGl3FND+Qpaey5JokKuzAoiOT4woMqmnUNNiDC7xvwVOHRRjj/+U88InVRg
         6nLVNLmAFOkLZu0wcvS0KzqhZCgRXgKwL2bH5YjuRGg8AHWgrtt06R7cJYvkMrWicfxi
         ZrmguEOGhUiB2cnxJC5klazHlCUOJ6mLzJaJXxf7MWs4NwrSx6eJ2Vqb40d0+PPtQxeo
         5PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683845395; x=1686437395;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxwYHBlYBGSyLiYi9w4kgqpVffL6/IO5snQQOT8T3oE=;
        b=lMO7IVzj4wT8ur/VPN+yPpvOvxAvOEDK41ljE7Q3nFF6Yy2dVDC70l8BpZUKqqfA9D
         pJzhYpYnHDgitV3cOXQugjwh5tHRt3aBh4/NDgtWXR02s72cx6SuK/TQ71QbSv8Ei8q2
         MFHTLNRkD2o8zPAmAStAKc7E/imfels4lXQtaEUcOWVMNacozGuCsvdA6aws25IM0KWy
         Yj5wdo6d6GdgWVqGKQDTlMBVRNzDLN4s1/7Wl0KlVYGoa+A05xooaCr65a1ZBdRJ7kXH
         f6qSNYMisOC+MtYguiTo0Nea1VfkoicHvWT5BSwbMjMo6bvI000NqRuy0DRxJ9iRBLD4
         wWqQ==
X-Gm-Message-State: AC+VfDxlFqbgve2Cj40RX2H+Tqpv0kqJEaUuWumP8Fxzys/9K2KyXqCt
        HaA1EMHo5fFKaVBzjE+DjaY4Zug00WQOLg==
X-Google-Smtp-Source: ACHHUZ4PU4+p1/wUiey4Y9XqLgnMIB3gHPupuvge8njLTHEt4chuZVJ8bFbqqoYirvWejbKt5dh0hw==
X-Received: by 2002:ac2:4e63:0:b0:4f0:1a32:ca23 with SMTP id y3-20020ac24e63000000b004f01a32ca23mr3159808lfs.40.1683845394971;
        Thu, 11 May 2023 15:49:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651204d000b004d8580b2470sm1259456lfq.225.2023.05.11.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:49:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <645d28e112294_26011a294b2@chronos.notmuch>
        <877cte200m.fsf@osv.gnss.ru>
        <645d3dbf785a5_26069229463@chronos.notmuch>
        <87wn1ezms9.fsf@osv.gnss.ru>
        <645d480be344d_260ff5294c@chronos.notmuch>
        <87mt2azkdp.fsf@osv.gnss.ru>
        <645d572a47e5b_57c4e294dc@chronos.notmuch>
Date:   Fri, 12 May 2023 01:49:53 +0300
In-Reply-To: <645d572a47e5b_57c4e294dc@chronos.notmuch> (Felipe Contreras's
        message of "Thu, 11 May 2023 14:59:22 -0600")
Message-ID: <87fs82zdny.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> 
>> >> > Sergey Organov wrote:
>> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> >> > Sergey Organov wrote:
>> >> >> >
>> >> >> >> I'd rather think about generic interface for setting/clearing
>> >> >> >> (multiple) bits through CI than resorting to such convenience
>> >> >> >> tricks. Once that is in place, one will be able to say "I need these
>> >> >> >> bits only", "I need to turn these bit(s) on", and "I need to turn
>> >> >> >> these bit(s) off" conveniently and universally in any part of Git CI
>> >> >> >> where it's needed.
>> >> >> >
>> >> >> > It's possible to achieve both.
>> >> >> >
>> >> >> > Imagine your ideal explicit interface. In that interface the default
>> >> >> > is no output, so you *have* to specify all the bits, for example:
>> >> >> >
>> >> >> >   git show --patch
>> >> >> 
>> >> >> No, that's not what I meant. There is no point in making "git show" to
>> >> >> have no output by default, please see below.
>> >> >> 
>> >> >> >
>> >> >> > Or:
>> >> >> >
>> >> >> >   git show --raw
>> >> >> >
>> >> >> > In this ideal interface it's clear what the user wants to do, because
>> >> >> > it's explicit.
>> >> >> >
>> >> >> >   git show --patch --raw --no-patch
>> >> >> >
>> >> >> > Agreed?
>> >> >> >
>> >> >> > My proposal achieves your ideal explicit interface, except when no
>> >> >> > format is specified (e.g. `git show`), a default format is chosen for
>> >> >> > the user, but that's *only* if the user hasn't specified any format.
>> >> >> 
>> >> >> My point is that the default format should be selected as if it has been
>> >> >> provided by existing options, rather than by some magic hidden in the
>> >> >> code.
>> >> >
>> >> > But why?
>> >> >
>> >> > I don't see any benefit, only drawbacks.
>> >> >
>> >> >> > If you explicitely specify the output format that you want, then the
>> >> >> > default is irrelevant to you, thus you have your ideal explicit
>> >> >> > interface.
>> >> >> 
>> >> >> That's not what I had in mind, sorry. It'd rather be something like:
>> >> >> 
>> >> >>   --raw: set "raw" bit and clear all the rest
>> >> >>   --+raw set "raw" bit  (== current --raw)
>> >> >>   ---raw clear "raw" bit (== --no-raw)
>> >> >> 
>> >> >> In this model
>> >> >> 
>> >> >>   git show
>> >> >> 
>> >> >> would be just an alias for
>> >> >> 
>> >> >>   git log -n1 --patch --cc
>> >> >> 
>> >> >> and no support for a separate command would be need in the first place.
>> >> >> 
>> >> >>   git show --raw
>> >> >> 
>> >> >> would then produce expected output that makes sense due to the common
>> >> >> option processing rules, not because somebody had implemented some
>> >> >> arbitrary "defaults" for the command.
>> >> >
>> >> > But now you are at the mercy of those "arbitrary defaults".
>> >> 
>> >> No, see below.
>> >> 
>> >> >
>> >> > Let's say those defaults change, and now the default output of `git show` is
>> >> > `--stat`.
>> >> >
>> >> > Now to generate the same output you have to do:
>> >> >
>> >> >   git show --raw
>> >> >
>> >> > in one version of git, and:
>> >> >
>> >> >   git show --no-stat --patch --raw
>> >> >
>> >> > in another.
>> >> 
>> >> No: --raw in my model clears all the flags but --raw, so
>> >> 
>> >>   git show --raw
>> >> 
>> >> will produce exactly the same result: raw output only.
>> >
>> > But that {--,--+,---} notion doesn't exist, and I think it's safe to say it
>> > will never exist. So, could we limit or solution-space to those solutions that
>> > could have the potential to be merged?
>> 
>> I didn't expect it to exist any time soon, just showed a different way
>> of options design.
>> 
>> >
>> > What you suggest could be easily achieved with:
>> >
>> >   git show --silent --raw
>> >
>> > But because no other format is explicitely specified, following my notion of
>> > defaults, that's the same as:
>> 
>> The problem that I tried to fight is this notion of defaults that is
>> somewhat special, so, if I allow for it, the rest of my suggestions
>> becomes pointless,
>
> No, they don't, all you need to do is specify the default explicitely.
>
>> and without the "defaults" with non-trivial behavior[*]
>> 
>>    git show --raw
>> 
>> won't work as expected provided --raw still just sets "raw" bit and
>> doesn't clear all the rest.
>
> It works perfectly fine. There are no bits to clear, because there are no bits
> set.

When I set default value to a variable in C, it does have bits set, and
they are kept unless overwritten, so they are set by default as well.
Exactly the bits that I've set. Here I've proposed the same principle
for handling of options.

What you have in mind is exactly the current behavior and I do know how
it works. My point is that I think it's not needed, as similar or better
convenience could be achieved using more straightforward model.

>
> That's the whole point of defaults: you don't have to use them. If you don't
> like the notion of defaults, then don't use them.

Once again, the defaults in this form seem to be not needed to me. I
already got it that you like them, and it looks like we need to agree to
disagree.

> If you specify *any* format option, then the defaults are ignored and no bits
> are set other than the ones that you explicitly specified.

That's exactly how it works now, and that's exactly what I'm arguing
against. I think there is no need in introduction of this specific
notion of defaults in the first place.

«Entia non sunt multiplicanda praeter necessitatem»

>
>> [*] Defaults with trivial behavior is just initializing of internal
>> variable holding flags with specific value, that is exactly the same as
>> putting corresponding option(s) at the beginning.
>
> Those are not default arguments, those are initial arguments. In many cases
> they behave the same, but not all.

In my model they are both. When you set a bit initially, it's then on by
default.

In your model all initial bits are effectively cleared just before any
bit is changed by option, and this is an additional rule. What I'm
trying to explain is that this additional rule is not needed, as all the
functionality could be achieved without it.

From all the correct solutions of a problem the simplest one is the
best.

Thanks,
-- Sergey Organov
