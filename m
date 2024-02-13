Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C986089D
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853162; cv=none; b=IYMLYKNkufd/O+MUjC4VmNzNqj4rGN3N9uZ6I9/4N01EvFh833hY2X3gdG6IEZu7F0fY1aTkumIA4wTpXmDKAIaw8FTtjcqgxg1fPzpFY2Lhp7J0JTbOt1bLC2iiiALsNY2AnF0Iv4zSondG6pogiWreR9Y+PaWno/CkikzD+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853162; c=relaxed/simple;
	bh=qZDPL8nG5NqPbDxPDbFGMnSuhGfCFiFZ9Jx4oeJ65sQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7yJnVfhDwcjfoXuu+928z3O9vOMkRXDaOOzrx7VjJ85AhJoJsWsuXUTgRabiEw2CilZqg1FAGyftGvpWu8ddsOBy5+j+VX2nnaT9bO+JodA8g61NRUHEc/2PMuzAmGz5uZqhdlZmzoBDpKOTLr7Lz4QfsJnI0nmp14gPzEXAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsb+uhJW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsb+uhJW"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffee6fcdc1so76092797b3.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707853160; x=1708457960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z53fo4426KTzkfCxTcF79EstlBplxQoa3DafEmATrv4=;
        b=lsb+uhJW431taFwi3raJwTdB/fvqzZFjHPNyUvS9yKYm1XG4+c1dE1RuAkRyh3FnHO
         juO4UE0crd7nrVyMF9JjnT9SOxtHS/SxmYHLY8+EDifpEhwEa8pwkD3ScC71X8b4YMiR
         GpFnkdf3RMCZNiKVvRq0urgeXo+RjXS8872iq1Al9k2uZS1A+qTduKKcZMMV8qAZ8IFz
         7S9zQZE/k3NaeTeBBeBy2li5ZavyVknM/9NQfFuzPx3DTkNMeCFXWU2xh7NhK9p1w9KF
         RRpSssfXmu/yEoritVn/k0ELhCBjyIBwrQBz8DSOGh9Mr5XJXydvbkKXohTCoeFILz0d
         2ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853160; x=1708457960;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z53fo4426KTzkfCxTcF79EstlBplxQoa3DafEmATrv4=;
        b=FGLm7Tbyy8YHKsCiLGkuIUSDK2O6aYqQUPEkaSb3LWLyPgCxSeC8l/B+cCEHLUFX4B
         /7uGsOieS6ml8WEZ9zzcTdZ4dCFPMAFicgMF/EDOuHuzJX6lPqmK+MuG419AO2bxz0Me
         p/rTdPcOMn1kSIuI1Yqs71G6t7UMVdwKNy2Nv8Z8iaAA4AqtSvlolbOzkFvOqemmoYMv
         58FOThtHxMmHdA/Kle1LxFdpO7pgX3BJy0oyRl6CTHHmydbXpWpQ/9Wc6vRCaSwamVP1
         1fNHKiYi1HAu7ICa0zJ96Yk/1kDxbO6Ih3Rkkz5KZR8aGaxs6j4QMmZuDafeeFYNXmXc
         NYPw==
X-Gm-Message-State: AOJu0YwuKR5lzZfx6pQcpiVRuCjV3jDS7thHDqPyAR9Xc03EgY880IpE
	fiUtCPpY7/PTu36/ekVhlKGdarKFs/VoIKFSSROfqo9RqyGWlD2mF7PSgc2EwECczKHFTW+Leq5
	WEA==
X-Google-Smtp-Source: AGHT+IGvDWoURCnXRx0g9K9HLB7qs8Ce0Z/EBs5Q9d5N0PaZIZPB3hS7ALoMprPRaEv5pV9II34O/Lt97I4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:d951:0:b0:607:80ba:15ad with SMTP id
 b78-20020a0dd951000000b0060780ba15admr58622ywe.9.1707853159963; Tue, 13 Feb
 2024 11:39:19 -0800 (PST)
Date: Tue, 13 Feb 2024 11:39:18 -0800
In-Reply-To: <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
Message-ID: <owlywmr89ms9.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This patch series is the first 10 patches of a larger cleanup/bugfix ser=
ies
>> (henceforth "larger series") I've been working on.
>
> There are now 28 patches in this series.
>
> I took a look at all of them, and I think that this series should be
> split into 4 or more series.

This sounds fine to me. IIRC this means for the 2nd, 3rd+ series I have
to remember to say "this series builds on top of the other topic
branches '...'" in the cover letter. Now that I've written this out I
will hopefully not forget to do this...

Or, I suppose I could just introduce the 1st sub-series, wait for that
to get queued to next, then (re)introduce the 2nd sub-series, etc, in
order. Hmm. I think this will be simpler.

> For example perhaps one series until the "trailer: move
> interpret_trailers() to interpret-trailers.c" patch, then another one
> until "trailer: finish formatting unification". etc.
>
> Also I think it might be possible to avoid some test failures
> introduced by some patches. If it's not possible, I agree with Junio
> that it would be nice if the failing tests were changed to use
> 'test_expect_failure'.

As the breakages are deliberate, I will have to go with using
"test_expect_failure".

> Also it seems to me that many patches towards the end of this series
> should be split.

In hindsight, I fully agree.

Aside: I am delighted with the quality of reviews on this project. It's
not something I am used to, so please bear with me while I try to break
old habits. Thanks.

>> The main goal of this
>> series is to begin the process of "libifying" the trailer API. By "API" =
I
>> mean the interface exposed in trailer.h. The larger series brings a numb=
er
>> of additional cleanups (exposing and fixing some bugs along the way), an=
d
>> builds on top of this series.
>
> [...]
>
>> With the libification-focused goals out of the way, let's turn to this p=
atch
>> series in more detail.
>
> I like the goal of libifying Git the trailer API, and the way you want
> to do it seems reasonable to me.
>
> [...]
>
>> In summary this series breaks up "process_trailers()" into smaller piece=
s,
>> exposing many of the parts relevant to trailer-related processing in
>> trailer.h. This will force us to eventually introduce unit tests for the=
se
>> API functions, but that is a good thing for API stability.
>
> I am a bit sad that this series doesn't introduce unit tests using the
> new test framework in C yet. I understand that this series is mostly a
> big refactoring and maybe it's better to introduce unit tests only
> when the refactoring is finished though.

This was my original goal as well, and still is.

> Anyway I hope the next series will introduce such tests.

I will see which API functions are stable enough, and add tests
accordingly (in a patch series sooner than later).

Probably the "biggest" (?) thing that is coming from the larger series
is the introduction of a complete separation between parsing (without
any modification of the input) and formatting. The parser/formatter is
a large chunk of the trailer implementation, so I would expect unit
tests for those bits to have to wait until those improvements are merged
into "next".

> [...]
>
>> Thanks to the aggressive refactoring in this series, I've been able to
>> identify and fix several bugs in our existing implementation. Those fixe=
s
>> build on top of this series but were not included here, in order to keep
>> this series small. Below is a "shortlog" of those fixes I have locally:
>>
>>  * "trailer: trailer replacement should not change its position" (If we
>>    found a trailer we'd like to replace, preserve its position relative =
to
>>    the other trailers found in the trailer block, instead of always movi=
ng
>>    it to the beginning or end of the entire trailer block.)
>
> I believe there was a reason why it was done this way. I don't
> remember what it was though.

Noted. I'll see what I can find in our commit history.

>>  * "interpret-trailers: preserve trailers coming from the input" (Someti=
mes,
>>    the parsed trailers from the input will be formatted differently
>>    depending on whether we provide --only-trailers or not. Make the trai=
lers
>>    that were not modified and which are coming directly from the input g=
et
>>    formatted the same way, regardless of this flag.)
>
> It could be a feature to be able to normalize trailers in a certain way.

True. But doing such normalization silently is undocumented behavior,
and we should provide explicit flags for this sort of thing. Adding such
flags might be the right thing to do (let's discuss more when this patch
gets proposed). FWIW the behavior I observed is that this normalization
only happens for *some* trailers that have configuration options, not
all trailers in the input. So it's a special kind of (limited)
normalization.

>>  * "interpret-trailers: do not modify the input if NOP" (Refrain from
>>    subtracting or adding a newline around the patch divider "---" if we =
are
>>    not adding new trailers.)
>
> It could be a feature to be able to normalize this too.

OK, but it would again be undocumented behavior.

>>  * "trailer formatter: split up format_trailer() monolith" (Fix a bug in
>>    git-log where we still printed a blank newline even if we didn't want=
 to
>>    format anything.)
>
> I am not sure this is a bug fix either. It could perhaps be a normalizati=
on too.

See my comment above.

>>  * "interpret-trailers: fail if given unrecognized arguments" (E.g., for
>>    "--where", only accept recognized WHERE_* enum values. If we get
>>    something unrecognized, fail with an error instead of silently doing
>>    nothing. Ditto for "--if-exists" and "--if-missing".)
>
> It's possible that there was a reason why it was done this way.
>
> I think you might want to take a look at the discussions on the
> mailing list when "interpret-trailers" was developed. There were a lot
> of discussions over a long time, and there were a lot of requests and
> suggestions about what it should do.

I confess I haven't looked too deeply into the original threads
surrounding the introduction of "interpret-trailers". But all of the
changes which I categorize as bugfixes above have a theme of
undocumented modifications.

While working on this (and the larger) series around trailers, I only
looked into some (not all) of the discussions on the mailing list in
this area. Instead, I deferred to
Documentation/git-interpret-trailers.txt as the official (authoritative)
source of truth. This is partly why I first started out on this project
last year by making improvements to that doc. And, this is why seeing so
many edge cases where we perform such undocumented modifications smelled
more like bugs to me than features.

That being said, I cannot disagree with your position that the so-called
bugfixes I've reported above could be misguided (and should rather be
just updates to missing documentation). Let's not try to decide that
here, but instead later when I get to introduce those changes on the
list, one at a time. Thanks.
