Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56E12B171
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729563; cv=none; b=VWUo+6vg8eDgSv4nGRG9MvThx6e9aGU+2Cn2DAXKWnSlGN0TQiljkQkxRM+EyenWttxxUQ9OqNDzPCbUb/sQUDr6SRHpxxN9XvwT2rEhoxieaKl+g6idPQqi3/lJpAlFUd8Eh1rwTt1QFBBJBBD3rViZ3vb7LzDPfMZPTtXa63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729563; c=relaxed/simple;
	bh=zwfNw0ls1M8QokhDbS/B4SoO9NjaWP2wtNbkdA4a8PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QISZaHs0c7SEg7sJLjGkHfu9uTeY8HK5TTpPFdpmomAxUk4GLOGRL1C3KGOWwTjitypP6jGmBC6MM2dRdHZKtq8HZKiiJr12QUcA6C2pwIKYi8pJVS3oYcIoreHWfSdrJfKU6NQPceDAy7QHqHZORKEUEJb5yG408VWmR/eHY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klOGL3ks; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klOGL3ks"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso2390167a12.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720729559; x=1721334359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwfNw0ls1M8QokhDbS/B4SoO9NjaWP2wtNbkdA4a8PQ=;
        b=klOGL3ksvCfCugKjT0A4di0IizkU7xE/IF+ACSn9f/Y+KNRahwmI5cJAYkYEaBYbpe
         xBHtFB03PnSOrDiwqYXoOY26b5BjX8Q8TgF+DKKCjGrOMr8hm9W1HP7eBNdgukZoNWRo
         djMF3l1XM6wNJeTofPFpEgG9FSo0ch1l4t1WedM6cwkMOL3EdDO9zKO2rjQeVPzPPc7B
         k5buL0BERQFJv8kHZ3Pmabw7rjwdLcEuXnZx9/9/EaUR+u766y6Fgjrs5CBSPIbcCgEA
         3gxH93sZupeCc5Q4nb0X7vX7v5pqyvrXOA6dAifZPeyrBmwChaeY2VKbHmqiJKzzHKko
         nAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720729559; x=1721334359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwfNw0ls1M8QokhDbS/B4SoO9NjaWP2wtNbkdA4a8PQ=;
        b=dz0uZmcgmdkFJmue9uOqSPD/MHajp91GJuF+10p3znUMSbVPTOzP6jKE6STnIibUsE
         xefKFWXxUw7IeixWYc5/dM6ZMcZu2vGTsjvPPXrjc+C1Bill1h/x/xIQS35PWQ7IDmRZ
         iyq5tkfGcqcdM9b7m0SgGsS6QEJmca+RmS/XdsRV2VXxzKjFPcbQIWdPdm4x/WlCNZCB
         qcETA1RpgTF3oB8wy8+edOJK7Gk5ThDQ7/sOTaYJax3Dm+kGuYo6WdEmjr9ByJsaU5j8
         Hj+/H5xv9uBCD0rSj6wCbapu6Q8ZSXE6PE7eJ++97pKiGJmXDl6dCey+6ZWW7JY9yrdV
         /5Eg==
X-Gm-Message-State: AOJu0YzeB/nUi584VHSGWk4Lx4kMcarlI+seYmwBNynQxoF3nAWgeKyd
	sLgHMp5UnKS6+3E9zFT7szBZbGUqgOOUzgf2Z1I7U//Bpj44Q6kPb8sa1i9rg+tXaJYQfXixlvJ
	4SeJ1Tpd6JonDhYSStmujnW9umjLy3MwHzkYjXeCaRy4giZG/EQ==
X-Google-Smtp-Source: AGHT+IHj8zMp4GLNnrYxPGJscaBb3usNMBm4xOquhlKlEf5D16bwD205aFSYL4w4+TbewS6wOYpy8Bxvvlhc1ANgo9s=
X-Received: by 2002:a17:907:9496:b0:a72:7f22:5f9e with SMTP id
 a640c23a62f3a-a780b88062bmr810516666b.57.1720729559079; Thu, 11 Jul 2024
 13:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <CAO_smVjZ7DSPdL+KYCm2mQ=q55XbEH7Vu_jLxkAa5WTcD9rq8A@mail.gmail.com> <CAJoAoZmo6ey1RAqgtM098LLLrdKODf2OYyV=YqyFH5VXiSB6RQ@mail.gmail.com>
In-Reply-To: <CAJoAoZmo6ey1RAqgtM098LLLrdKODf2OYyV=YqyFH5VXiSB6RQ@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 11 Jul 2024 13:25:42 -0700
Message-ID: <CAO_smVjpsVZj29s9dKQNy8Jos8HvxmRcc4S25WmngGb2HQB88w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:37=E2=80=AFAM Emily Shaffer <nasamuffin@google.c=
om> wrote:
>
> On Wed, Jul 10, 2024 at 12:11=E2=80=AFPM Kyle Lippincott <spectral@google=
.com> wrote:
> >
> > On Tue, Jul 9, 2024 at 3:50=E2=80=AFPM Emily Shaffer <emilyshaffer@goog=
le.com> wrote:
> > > +* If you rely on some configuration or behavior, add a test for it. =
You may
> > > +find it easier to add a unit test ensuring the behavior you need tha=
n to add an
> > > +integration test; either one works. Untested behavior is subject to =
breakage at
> > > +any time.
> >
> > Should we state that we reserve the right to reject these tests if
> > they would put what we feel is an excessive burden on the git
> > developers? i.e. a requirement to use C89 would be rejected
> > (obviously). a requirement to support 16-bit platforms would also be
> > rejected. I don't know that we need to list examples for what we'd
> > reject, they could be implied that we're likely to accept anything
> > else.
>
> brian mentioned something similar in their review, to which I proposed
> a minimum requirements field[1]; I think this would work for that too?
> Thoughts?
>
> > > +** Clearly label these tests as necessary for platform compatibility=
. Add them
> > > +to an isolated compatibility-related test suite, like a new t* file =
or unit test
> > > +suite, so that they're easy to remove when compatibility is no longe=
r required.
> > > +If the specific compatibility need is gated behind an issue with ano=
ther
> > > +project, link to documentation of that issue (like a bug or email th=
read) to
> > > +make it easier to tell when that compatibility need goes away.
> >
> > I think that we likely won't have the ability to investigate whether
> > it's _truly_ gone away ourselves, and there's no guarantee that the
> > person that added these tests will be able to vet it either (maybe
> > they've switched jobs, for example).
> >
> > I think we should take a stance that may be considered hostile, but I
> > can't really think of a better one:
> > - there needs to be a regular (6 month? 12 month? no longer than 12
> > month surely...) reaffirmation by the interested party that this is
> > still a requirement for them. This comes in the form of updating a
> > date in the codebase, not just a message on the list. If this
> > reaffirmation does not happen, we are allowed to assume that this is
> > not needed anymore and remove the test that's binding us to supporting
> > that.
>
> I like the idea of the date in code, because that's "polled" rather
> than "pushed" - when I break the test, I can go look at it, and see a
> condition like "Until July 1st, 2024" and say "well it's July 11th, so
> I don't care, deleted!" - or, more likely, I can see that date expired
> a year and a half ago :)
>
> > We should probably go a step further and intentionally violate
> > the test condition, so that any builds done by the interested parties
> > break immediately (which should be caught by the other processes
> > documented here; if they don't break, then it was correct to remove
> > the restriction).
>
> ...but this seems harder to keep track of. Where are we remembering
> these "due dates" and remembering to break them on purpose? I'm not
> sure that there's a good way to enforce this.

Ah, I was unclear - I was saying when we remove the test, we should
intentionally add a use of the thing the test was preventing us from
using. So if there's a test saying "you can't use printf()", when
removing that test, we should add a use of printf in the same series.
I was intentionally being vague about "when" we should remove these
tests, and how long we should consider the newly added printf
provisional (and possibly going to be rolled back), like in our
current test balloons. Just: if you're removing an expired
platform-support-policy test, add something to the codebase (possibly
just another test) that exercises the previously forbidden aspect, if
possible.

This is likely to happen organically: most people aren't going to
notice an expired platform-support-policy test and remove it just
because. They'll trip over it while attempting to work on a feature,
notice it's expired, and remove it as part of the series that makes
use of it. But if someone is trying to be helpful and clean up expired
platform-support-policy tests without having the goal of immediately
using it, they should be encouraged to invert the test so that we
don't have potentially months of time difference between "implicitly
allowed again [since there's no test preventing its use]" and the
actual usage being added.

>
> > - _most_ of these restrictions should probably have a limited number
> > of reaffirmations? I feel like this needs to be handled on a
> > case-by-case basis, but I want us to be clear that just because we
> > accepted these restrictions in the past doesn't mean we will accept
> > them indefinitely.
> > - Just because there's a reaffirmation doesn't mean we're guaranteeing
> > we won't delete the test before the affirmation "expires". If there's
> > an urgent security need to do something, and it can't be done without
> > breaking this, we'll choose to break this test. If there's general
> > consensus to do something (adopt a new language standard version, for
> > example), there's no guarantee we'll wait until all the existing
> > affirmations expire.
>
> I honestly like this point more than the previous one. Limiting by a
> number, even one that changes, feels less flexible than allowing
> ourselves to say "enough of this nonsense, it's the Century of the
> Fruitbat, we really want to use <C11 feature> so you can get
> maintenance updates instead now".

Yeah, that's fair. Let's withdraw my suggestion of a limited number of
reaffirmations. :) That works well if the goal is to have a temporary
restriction while work is actively happening to remove its necessity,
but that's less likely to be the case here. If we can't move to C42
because it's not supported on Linux Distro 2050=E2=84=A2 yet, users of Linu=
x
Distro 2050=E2=84=A2 aren't able to promise eventual support of C42 or
accelerate that happening.

>
> >
> > The thinking here is that this test is imposing a restriction on the
> > git developers that we've agreed to take on as a favor: we are going
> > to restrict ourselves from doing X _for the time being_ not
> > necessarily because it'll break you, but because it's a bad experience
> > for the git developers to create a patch series that lands and then
> > gets backed out when the breakage on $non_standard_platform is
> > detected on seen/next/master.
>
> 1: https://lore.kernel.org/git/CAO_smVjZ7DSPdL+KYCm2mQ=3Dq55XbEH7Vu_jLxkA=
a5WTcD9rq8A@mail.gmail.com/T/#m9d7656905be500a97ee6f86b030e94c91a79507a
