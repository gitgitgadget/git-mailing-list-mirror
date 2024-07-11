Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA026AEC
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723070; cv=none; b=s6HAacH54bsSF+no1exrcXu7sQRbscIRSkURK15PsDEgI1VoCV1qQ2shPNCmX7OqqYDhVVYVB1abGVa58IiLLj+tqq1eMIieX8YGd/CikGMxYrA4NtwmJJCkyuCeC/n+A9fFSeHwYOryZ1FNHC0g9H+SRs+IXIUUGwAI12X+IsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723070; c=relaxed/simple;
	bh=CqGEny5bJ4jktanyxvstBcnIAV34LTIHVMMSIVvb66I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imgalqY45UrCipKpWRwI8NAlJQEMOEUesEjAjrJWcadzAfd6UkQ9CNuMmqclw/9LW/maSajWqNs2JtA1Fq65HuqYaeyWvJxD/URWPy1lOcwLOih6/wL/7NxG+fS73U49Pg3NugwRarPuUEYqj8p3ujsgxwB5xK1PuvWFxtcaSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yevnhqG0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yevnhqG0"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44a8b140a1bso34421cf.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720723068; x=1721327868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqGEny5bJ4jktanyxvstBcnIAV34LTIHVMMSIVvb66I=;
        b=yevnhqG0djdHokFBQ+FqrBy4UZ4mbErqkfgTOvVnAgvN6LO4VD6aFoYeeMLCQbF5sR
         SzwAE8K43qaPVJ5QOXWkkYEJWuxktQ29ZjaKPV4Q0sGkGYOZhi9BWNTlclNhR84TTjLn
         5R+uraWkz/OF0+Df4EGm46Tg1u3WbT/xVznp41dSyLoipmXvmqZaPnfuglnQhlo/z6R8
         nUvmPShstUUimadj6aXVwbxjhAcvbIMVk93zzUwTV6+WUeDw9Ye5eTXeCMXWEmEk/FoN
         MoPAGn5qh/4lK2xsQoTP73JfOKuuxTjEJ6M8s5ouGGzPaSdu9OjlgWj8pPFGQtf3UH04
         8qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720723068; x=1721327868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqGEny5bJ4jktanyxvstBcnIAV34LTIHVMMSIVvb66I=;
        b=lHmXaBWKPgJ6Pn5NBXm4o7vfv2Nyc5ezM078x2cNYW3s99TRqeu8KYE9s2a2WReWQ7
         Z2G6W+afltS2iVeAx3lGumSfIICIjULhuwP+11mZu+C/sxoNyuDxzj/iBzwixtP3ze1m
         Kw4MJwtO8qkFcQaOgmaAho3IiJ4t4PC1OcHz+vtpXV/LgjPmJgznoT7lxAMLpATKFCRI
         2bVeHKWqId6WRTrifo3B5PsH4vgLDC089L2cyTeCWWdpP4ACFi5Fue19LI/G/4w1zzc1
         YfN7t5z/oZvf44S9pAy59oSa5XUCqJvId1aFAT+V9OOlU/NqH1OUnk3khSkBw9BpNPsA
         zYjA==
X-Gm-Message-State: AOJu0YyWvrY7uP1oq4s76iDtMH8d4dISnCHDuKv7izZI6MQER4baogXu
	oJTzE2cJ1SIL4XJGj4PmUMnqd0b9KjlbIqV8RFgJjq4rbBfbvQ/O5luQbE/t9h+rsT6mgJWUXv5
	gLpu1Pk5IEuOlBZ313POxxvlnxOda9lUsltON
X-Google-Smtp-Source: AGHT+IGpgcYMuT+PpajltmXJgpMaPFqZvlRiABjOcWe3/QYISMqf5IDRmdFpQZ6JGfOtkYT3VH4fgW6ynSB2Nx1PwV0=
X-Received: by 2002:a05:622a:1908:b0:447:f44d:d0ed with SMTP id
 d75a77b69052e-44e75be4459mr355651cf.1.1720723067974; Thu, 11 Jul 2024
 11:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com> <CAO_smVjZ7DSPdL+KYCm2mQ=q55XbEH7Vu_jLxkAa5WTcD9rq8A@mail.gmail.com>
In-Reply-To: <CAO_smVjZ7DSPdL+KYCm2mQ=q55XbEH7Vu_jLxkAa5WTcD9rq8A@mail.gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 11 Jul 2024 11:37:35 -0700
Message-ID: <CAJoAoZmo6ey1RAqgtM098LLLrdKODf2OYyV=YqyFH5VXiSB6RQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:11=E2=80=AFPM Kyle Lippincott <spectral@google.c=
om> wrote:
>
> On Tue, Jul 9, 2024 at 3:50=E2=80=AFPM Emily Shaffer <emilyshaffer@google=
.com> wrote:
> > +* If you rely on some configuration or behavior, add a test for it. Yo=
u may
> > +find it easier to add a unit test ensuring the behavior you need than =
to add an
> > +integration test; either one works. Untested behavior is subject to br=
eakage at
> > +any time.
>
> Should we state that we reserve the right to reject these tests if
> they would put what we feel is an excessive burden on the git
> developers? i.e. a requirement to use C89 would be rejected
> (obviously). a requirement to support 16-bit platforms would also be
> rejected. I don't know that we need to list examples for what we'd
> reject, they could be implied that we're likely to accept anything
> else.

brian mentioned something similar in their review, to which I proposed
a minimum requirements field[1]; I think this would work for that too?
Thoughts?

> > +** Clearly label these tests as necessary for platform compatibility. =
Add them
> > +to an isolated compatibility-related test suite, like a new t* file or=
 unit test
> > +suite, so that they're easy to remove when compatibility is no longer =
required.
> > +If the specific compatibility need is gated behind an issue with anoth=
er
> > +project, link to documentation of that issue (like a bug or email thre=
ad) to
> > +make it easier to tell when that compatibility need goes away.
>
> I think that we likely won't have the ability to investigate whether
> it's _truly_ gone away ourselves, and there's no guarantee that the
> person that added these tests will be able to vet it either (maybe
> they've switched jobs, for example).
>
> I think we should take a stance that may be considered hostile, but I
> can't really think of a better one:
> - there needs to be a regular (6 month? 12 month? no longer than 12
> month surely...) reaffirmation by the interested party that this is
> still a requirement for them. This comes in the form of updating a
> date in the codebase, not just a message on the list. If this
> reaffirmation does not happen, we are allowed to assume that this is
> not needed anymore and remove the test that's binding us to supporting
> that.

I like the idea of the date in code, because that's "polled" rather
than "pushed" - when I break the test, I can go look at it, and see a
condition like "Until July 1st, 2024" and say "well it's July 11th, so
I don't care, deleted!" - or, more likely, I can see that date expired
a year and a half ago :)

> We should probably go a step further and intentionally violate
> the test condition, so that any builds done by the interested parties
> break immediately (which should be caught by the other processes
> documented here; if they don't break, then it was correct to remove
> the restriction).

...but this seems harder to keep track of. Where are we remembering
these "due dates" and remembering to break them on purpose? I'm not
sure that there's a good way to enforce this.

> - _most_ of these restrictions should probably have a limited number
> of reaffirmations? I feel like this needs to be handled on a
> case-by-case basis, but I want us to be clear that just because we
> accepted these restrictions in the past doesn't mean we will accept
> them indefinitely.
> - Just because there's a reaffirmation doesn't mean we're guaranteeing
> we won't delete the test before the affirmation "expires". If there's
> an urgent security need to do something, and it can't be done without
> breaking this, we'll choose to break this test. If there's general
> consensus to do something (adopt a new language standard version, for
> example), there's no guarantee we'll wait until all the existing
> affirmations expire.

I honestly like this point more than the previous one. Limiting by a
number, even one that changes, feels less flexible than allowing
ourselves to say "enough of this nonsense, it's the Century of the
Fruitbat, we really want to use <C11 feature> so you can get
maintenance updates instead now".

>
> The thinking here is that this test is imposing a restriction on the
> git developers that we've agreed to take on as a favor: we are going
> to restrict ourselves from doing X _for the time being_ not
> necessarily because it'll break you, but because it's a bad experience
> for the git developers to create a patch series that lands and then
> gets backed out when the breakage on $non_standard_platform is
> detected on seen/next/master.

1: https://lore.kernel.org/git/CAO_smVjZ7DSPdL+KYCm2mQ=3Dq55XbEH7Vu_jLxkAa5=
WTcD9rq8A@mail.gmail.com/T/#m9d7656905be500a97ee6f86b030e94c91a79507a
