Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC2522F
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748367; cv=none; b=WfuWTdwWNR2Qa2MEPaXeM0b0eVyjqrk6W8Y2cgdBbtN1AVN2vaXy+r48l6DEbMTr8txoXL6TqWmFsp28QI4V5J8M6KcE80dHd05ULEk+zQ7eziNk+tnfzqBjd6+dTrPGvd3wdqe7iwpjURS6bzj4s+cNlWgnipJe5ywkzL6N6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748367; c=relaxed/simple;
	bh=SAu09yUTp1PZ6XzXa850Cw23lRdy78OQX713/rHNOTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oY5f8qXc9sZzy8L0cP3cLKrKk55wnP3tQElsznZRMVjAS39TJ/QHiQjAhuBW4P2ofAtp487+4brukq79wgZKCWkyZngpXvgGt1RyHVLU6X/CNcVyV1h50eNDrPtJJIp93pdm0n7jI6vOORUnMeSE5tHxRbDeU0YVmKww4zsaj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAW8AezL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAW8AezL"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6bad01539so541008276.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706748365; x=1707353165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8LbNnXR2N5sxCRZTe+nzVaBYp6zMooP7TQ2XTZsG9U=;
        b=hAW8AezL2uTDzv+iP4aREfQVdcxLYj5O4s/id4i47C5c+GXEZ4JJwy8KdZWHAQdqG6
         lhHLKpUDrEDEdzYpIzPj+MEb8ie77E40UgYdpTPXOOOO73MPrtEKIKCcXz06KSP6kAd/
         KvNN6f3HYFN/Oqz7yYexQ06hi3guWKM/elaZCgpr3tv6OwPX8lmezzxAZ7WNNgWshcJ9
         8NvR4FCD3NH/DNzYI3xXxqk0QJeQZbjDWuRoGRo6k6Fp5P9/e6Tv7jSYT0tC4VivMHYr
         H4wtr7txxulmZPteEbiunHRVi9bW0hXFYoOjHMDnNKQAPsrl8/wMQ5UuOqCx9P0BCtyB
         g2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706748365; x=1707353165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8LbNnXR2N5sxCRZTe+nzVaBYp6zMooP7TQ2XTZsG9U=;
        b=Ht3f/EGqrEIEaLb2aSXeXSYWFTbFdn3kXiUAOyQpPkNtQ+TD/T7eovT83+PvtTqnbk
         9uj7iVQVo2Scs3pegsCIHBhHfQWF0XdKfztrywvIZbERWeY5JDi2w0evzlNH0VR9/pJN
         hpOAWIguP0qYeECzZo91sJnGjlHIs+keQ0rowAmMydjUr11SUUEbd/SzL0JoOH5+E5JD
         YSY5sfqGka4cewDoV6SbBsBab0jMOfiiZMo9/k4cMb4C7aE0dbwelQrSU3xGejGQ0lE6
         2lNHP8xkQW8xMZqrf/YLhqhvGNIKJzKztEgVZ8+vzcs9CokKTijRnyR69lwh7NdwByZ0
         G1+g==
X-Gm-Message-State: AOJu0Yyp1ptAOPCwTTyiqDPGG3pP8IYXoRl6ErswViyGAi6Pronro9co
	ubV/cW1d/TZ76nsk6+fme5yLGoV7xKL4l4gw9KE6iZ0Uht68EIm5KQbbdZwLW7Rf7tY+yDKLKvm
	HYA==
X-Google-Smtp-Source: AGHT+IER8i4P3EMJmleLjtMyAYGw8ohhzreoM+CMNia+ZABbqPdfaJF2c9PH3PQIV+V75de50bJXgwae8d8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:168f:b0:dc6:b813:5813 with SMTP id
 bx15-20020a056902168f00b00dc6b8135813mr28059ybb.9.1706748364813; Wed, 31 Jan
 2024 16:46:04 -0800 (PST)
Date: Wed, 31 Jan 2024 16:46:03 -0800
In-Reply-To: <xmqqa5ol409k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
 <xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g>
Message-ID: <owlyv879106s.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +				if (opts->unfold)
>>> +					unfold_value(&val);
>>
>> So, ... how would this affect an invocation of
>>
>>     $ git interpret-trailers --unfold
>>
>> which would have set opts.unfold to true in cmd_interpret_trailers()
>> and eventually called process_trailers() with it, which eventually
>> called print_all(), which conditionally called print_tok_val() but
>> never gave the val to unfold_value()?
>>
>>  ... goes and digs a bit more ...
>>
>> Ahhhh, original process_trailers() did this by calling
>> parse_trailers() that munged the value.  So its print_all()
>> codepath only had to print what has already been munged.
>>
>> But then in this new code, do we unfold only here?  I thought that
>> in the new code you moved around, the caller, whose name is now
>> interpret_trailers(), still calls parse_trailers() and that calls
>> the unfold_value().  So, are we doing redundant work that may merely
>> be unneeded (if we are lucky) or could be harmful (if things, other
>> than the unfold thing I just noticed, that are done both in
>> parse_trailers() and this function are not idempotent)?
>
> I was too confused by the code flow and resorted to tracing what
> happens when "git interpret-trailers --unfold" is run in a way
> similar to how t7513 does in gdb.  Shame shame.

In my larger series I've made the parser and formater much simpler
(removing nesting, calling helper functions, _only parsing once and only
once_, etc) to make both parsing and formatting much easier to
understand. While I am biased as the author of these refactors, I do
think they make the code simpler.

> In any case, the updated code does try to call unfold_value() in
> format_trailers() on "val" that has already been unfolded in
> parse_trailers().

Correct. But this was already the case before this series. IOW the
existing code assumes that this function is idempotent: we call
unfold_value() in parse_trailers() and again in format_trailer_info().

In my tests if I remove the redundant call to unfold_value() in
the new formatter (so that unfolding only happens during
parse_trailers()), all trailer-related tests still pass:

    prove -j47 t{7513,3507,7502,4205,3511,3428,6300}*.sh

FWIW in the larger series we prohibit the parser from making mutations
to the input (unfolding is one such mutation), and allow multiline
(folded) strings to be stored as is in "val", only unfolding the value
if we need to during formatting.

> This may not produce an incorrect result if
> unfold_value() is truly idempotent (I do not know), but even if it
> is correct for its handling of .unfold bit, this episode lowered my
> confidence level on the new code significantly, as I do not know
> what unintended effects [*] all the other new things done in this
> function have, or if none of these unintended effects are
> error-free.

I think dropping the redundant call to unfold_value() would help address
some of your concerns. Of course, all of the existing test cases pass
(with and without the redundant call). As for addressing _all_ (not just
some) concerns, I am not confident I can deliver that as an additional
patch or two to this series because ...

>> It could be that a bit more preparatory refactoring would clarify.
>> I dunno.

... this is basically what I've done in the larger series, because there
are many areas that could be simplified (not to mention addressing some
bugs some bugs are lurking around). Granted, those are more aggressive
refactorings, and are not "preparatory refactoring" at all.

I could just grow this series with another ~22 patches to include those
additional refactors, but I am hesitant about doing so, simply due to
the sheer number of them.

How would you like me to proceed, other than deleting the redundant
unfold_value() call in the next reroll?

For reference, here's a list of those 22 commits that build on this
series as a preview (roughly grouped on themes):

    trailer formatter: deprecate format_trailers()
    trailer formatter: introduce format_trailer_block()
    trailer parser: parse_trailer_v2() for '--trailer <...>' CLI arguments
    trailer parser: parse_trailer_v2() for configuration
    trailer parser: parse_trailer_v2() for trailer blocks
    trailer parser: introduce parse_trailer_v2()
    interpret-trailers: preserve trailers coming from the input
    trailer_block: remove trailer_strings member
    trailer_block: parse trailers in one place
    trailer_block: prepare to remove trailer_strings member
    trailer: make find_same_and_apply_arg() do one thing
    trailer: unify global configuration
    interpret-trailers: print error if given unrecognized arguments
    trailer: make entire iterator struct private
    trailer: rename terms for consistency
    trailer: use create_new_target_for() everywhere
    trailer: capture behavior of addIfDifferentNeighbor
    trailer: EXISTS_REPLACE preserves original position
    trailer: capture replacement behavior for multiple matches
    trailer: split template application into 2 steps
    trailer: free templates in one place
    trailer: template's final value does not depend on in_tok

and "trailer formatter: introduce format_trailer_block()" is the one
that refactors the unified formatter introduced in this patch to have
multiple smaller helper functions.
