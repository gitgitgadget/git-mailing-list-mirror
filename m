Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56C481A3
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797947; cv=none; b=MKZ9/lY7Q+0yhB1sKnqvzS/EiAUqyCrWtMTy6VCkelclcR3hvGFH21AgoNkKT/zi6ccuEacLd3DQb3A/PAuhNMLC/XFd2uSmG9tQSb0lIaas3uc+aYY85XqcrkjEp3GBZPBjWLocGP3C3Of7h68G4er3Gr5Qs994JKgNNUqnIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797947; c=relaxed/simple;
	bh=bBCtBi6Q1QwKRHN0Zl2yOAz4vJ9mlxy45vUfBieLZj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmCm40PvP54ECcgtzqlUIZZvTvldEAYPPqgMu2bDCFdsSkGcmfDmAs0rw+9e6/PT9kjXj/Y5r3ud4GOIycvUcIQ2437i/g5D4dttGkeyf/drEOPbrYzspAs6u9o4zZ6FEqQsZCUxeCS2dHoZtNKyctQpaG4C/Pcuts3HvsrEzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvCZk9bf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvCZk9bf"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso5601795a12.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721797944; x=1722402744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCQCiMhVK8cMD8lfBjr90XdfINLzTmHWblSYdyhOE+s=;
        b=dvCZk9bfVponV2VqnBKfBvWU2caEewUkoNQdnN71ZZhzcSOjEiKluSGqv8p4DSiPWJ
         HA2a2I+UmReUXpjMJdWTjmvdTNBHGVYJplAw29Hcj1X9AwSFg6A7t6o+t18juzGTKsqJ
         fDwFaYVqGx7rPoU0L2xYYzdFw4WIRHG9+MGXy50aGFX5nqVIvUY7gGQ85no58SJUmaPp
         G8GoIR04XnztExkaLAsohYCua/Hf/pt5UwR0i+m6iyLYWvfHR8NVWf+IAz9c1D4VWqK+
         FZxcaD2NM8D2f2uBvd473BwbSQriySwGwReocFmZd9zMzBt6CwMDZR8x0/JkyCyIttZT
         4umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721797944; x=1722402744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCQCiMhVK8cMD8lfBjr90XdfINLzTmHWblSYdyhOE+s=;
        b=lHQiUW+2ZdbBa0bzdoqFnSP2bvsn9XAU1Ts7tgMaX8A3dHgDRcJCK6NqKIomNkrFEE
         uXWb14wqXNigJb4MU7GhSUEqTITjJsGrEenVER5e8cJQ2dtgc7/ROBQwnSc8Eig8KFGe
         AJmP9Yb5p2wyqALWjLqjjeoKW8aSf79IcUq948iiDEMyJTEWjx+L8Umel4W8E4J9eloL
         UKDVnkLylTz/LVKRaWYy+Y+OytX+FSU/VFzE/VquFQKXXd+JScVZp5XGOtLq2BwXOgBa
         y1m7JpQNvQl0UDxLWjHXcXGvX/lDuvMBKg5dBqVWwh7A8+0knPzNdHLpOyoCqTties4c
         x3eg==
X-Gm-Message-State: AOJu0Yw41R6mvyFFoONR02LPoZSWnbrG6usKTPESixbv5D4WLIuYU5Q+
	TE3ci3czE0QirJzoTtPInj2l6Vz8ldQC62cfu25LY7+yH1aIQpx/cT95j2fWzuEkGjII2/WLSmU
	yr431Wy1TTEIqGBHQSm82yv5kPlk=
X-Google-Smtp-Source: AGHT+IHPrV2OiKyEDVGDR0nISZMmtzw3NftzzJxxhRY5lt/aVnMb9F8Zay7oiKWwYTxhtFs02fRtFYvIys9JPPU24Ew=
X-Received: by 2002:a05:6402:35d0:b0:584:8feb:c3a1 with SMTP id
 4fb4d7f45d1cf-5a4784833bbmr9436204a12.1.1721797943959; Tue, 23 Jul 2024
 22:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com> <xmqq5xsw2fyd.fsf@gitster.g>
In-Reply-To: <xmqq5xsw2fyd.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 24 Jul 2024 10:42:13 +0530
Message-ID: <CA+J6zkRKzQGvwhiQdgRqcctDP76y5_v582rRTzEXJyx7=+WRqw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit
 testing framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 22:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > The reftable library comes with self tests, which are exercised
> > as part of the usual end-to-end tests and are designed to
> > observe the end-user visible effects of Git commands. What it
> > exercises, however, is a better match for the unit-testing
> > framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> > 2023-12-09), which is designed to observe how low level
> > implementation details, at the level of sequences of individual
> > function calls, behave.
> >
> > Hence, port reftable/pq_test.c to the unit testing framework and
> > improve upon the ported test. The first two patches in the series
> > are preparatory cleanup, the third patch moves the test to the unit
> > testing framework, and the rest of the patches improve upon the
> > ported test.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> >
> > ---
> > Changes in v5:
> > - Rebase the branch on top of the  latest master branch
>
> If you need to perform this rebase, please say _why_ you are
> rebasing.
>
> "A new rc was tagged so I rebased" is *not* a good reason.
>
> "I wanted to use that new feature that was merged to 'master'
> recently, which was not available when I wrote the previous
> iteration of this series, hence I rebased" is a very good reason.
>
> "Since I wrote the previous iteration, other unit test topics have
> graduated, so there are trivial conflicts in Makefile when merging
> this topic" is usually not a good reason, especially when the same
> conflicts with these other unit test topics are already resolved
> when your previous iteration is merged to 'seen'.
>
> If there isn't a reason worth mentioning why you are rebasing, then
> please do not rebase.  It is distracting.

Oh, okay.

> > - Rename tests according to unit-tests' conventions
> > - remove 'pq_test_main()' from reftable/reftable-test.h
> >
> > CI/PR for v5: https://github.com/gitgitgadget/git/pull/1745
>
> By the way, I still haven't got any answer to a question I asked
> long ago on this series, wrt possibly unifying this pq and another
> pq we already use elsewhere in our codebase.  If we are butchering
> what we borrowed from elsewhere and store in reftable/. directory
> and taking responsibility of maintaining it ourselves, we probably
> should consider larger refactoring and cleaning up, and part of it
> we may end up discarding this pq implementation, making the unit
> testing on it a wasted effort.
>
> Thanks.
>

I did talk about this with Patrick and Christian on a private slack channel
a few weeks ago and here is how that conversation went:

Me: Hey, I wanted to talk about the message from Junio the other day.
It is true that through this project, we are modifying the reftable directory
to a point that it is no longer easily usable by someone from outside. If
that is the direction we want to take, wouldn't it make more sense to get
rid of reftable/pq.{c, h} altogether and use Git's prio-queue instead?

Christian: Yeah, I think the direction the Git project wants to take is to
integrate the reftable code more and more with the Git code. On the other
hand, there are libification projects which are trying to split parts of the
Git code into libraries usable by other projects. But I don't think each of
these libraries should have their own test framework, their own prio-queue
implementation, their own string implementation, etc. So, even if I am not
sure about the end result, I think it would be ok to modify the reftable code
so that it uses the Git's prio queue and maybe other Git data structures.
But I'd like Patrick to confirm, and the list to agree to this. So I'd
rather wait
until Patrick is back from his vacation before doing things like replacing
reftable/pq.{c, h} with Git's prio-queue.

Patrick: Just chiming in real quick: while the reftable library is
currently in a
position where it cannot be used standalone by other projects, I'd very much
like to move into the direction of making it completely standalone again so
that we can adapt e.g. libgit2 to use it. So I rather want to move the other
direction over time and re-establish a proper boundary between reftable
library and the remainder of Git. I don't really think that this needs to impact
the reftable tests though. Git is the upstream of the reftable
library, and I don't
see much of a point why every other project should carry the same tests, too.

---snip---
