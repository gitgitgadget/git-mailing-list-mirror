Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B95C8CE
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020361; cv=none; b=tyycv+jeZJU1SBZjM7NDsViNyMLm7OIvEHCaKL+d9zQYkQcottbMjZ7BROO3jmRBRXV11mS//+CE0aQvDUcgu9A7Q+xx86leiu/y33H3eiCvCDNnz1WR7Ab75he1J0lK1x5PJRCWr4+yhuIQt+jQp3gKvnR8vRY84MQ+l3CwaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020361; c=relaxed/simple;
	bh=H9CByAL+1ZmTJPlShmvWMGDpzj3P0lLVbZytwWPdIag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNkvQPi/sUJCuNQ7+kMuo1gOo5esfV6oAv7KJNUNruS/o/z2YjCHlllzc7KIEbYNr63PauaNasNLkAjik6sDrGfgJrfNVFoFEaREGARHHbj7DBlhrM9Vh98L3HttmLmsJ5nDTsR1Eeowd4VFdo+HzR2cMEwiTe+Cm94PfFlrJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/R+TZ0S; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/R+TZ0S"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0dad3a179so859102566b.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752020358; x=1752625158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw7Or6wt93OVE5Q222U+GaGneO7XqfMQNe3K9OF+xao=;
        b=b/R+TZ0S0AZn5SUuyfoyA7fxgv5sECZ5fvYboSNqt/8h9ByC88s3x9B3ncE88kgzrR
         GGbY9nLFV5ocO6Cxxv/4hTK7pRR4tQiX7YqYUDSyVi5iyEuy3UA01jBV4/AgGBhCA9w9
         2NbOhF0OmYr4gmU0oMDMw0N0xy1JopGW2MZIQQmz1PHwYkQWjCvCfaz8w6PpSTiU4Djg
         T7hLQnEHhMQMiEz9UCLnfVsZQUoMU7kz7fgUwtjRDUCTBq50iT3wPzHZaQ7IhheRi0Tw
         HRk4I+zrg+5OZ2qMaiS9sAoJtom8cjShzz87rtEibyWD1w36wteuQARQyq8ofHyl+weo
         iF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752020358; x=1752625158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw7Or6wt93OVE5Q222U+GaGneO7XqfMQNe3K9OF+xao=;
        b=TR99iKc65t3DYw15KENqDqK3VlmNcZDGkr8EK3sNju4Pb0pSWS7ZpxMkxE4hcoyVK6
         0xRdVluMw2b/IqV/wf25fuNDsZGznzK05dE9gleddnSVQQV4Lb0isjM0WrPZRIZZrk1a
         1G5gR09QGood6yTLYlXU03pQvMB4oavfPpnuPgyo8xKQP9P6ei+KbF9W3Q8xdpa+VAWT
         +uF1tfqdIodzZxw5hz6wYdPHihrl91guh+bhgYdwgmbgSg0kYXHJvMGjwd/TQVoS97t4
         ohyTgIfaaHv5pJvGoyxCYdpxq2eXITBwYa8SukHp6JnBN5eznka4H3BGztRqeEGnKXmI
         CtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Je27Ep+fSJEevme0VMoYF48+qMMpKRGjsP5E6pg5ECMJjK5Ze+Q5sPcXzVyWfZuymwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOd+WWVEgJ02XAhnQ7b/gj9yipvWdusjAQaSZ/yHBrcZIzVVo
	Zlt0cJDMztibjnddQNlGL9jC0yQZEARtf5WmwDt9nIK76hrb2kqjASNNm1NbgXj3vYD7xnHZyMb
	ZGEBHxkLxFpcmcG+55vbvbZqcxgIrZRNop8KO
X-Gm-Gg: ASbGnctZCHg3rc0PpsNjgClTb+VM1C7RZaAchY1iDSxyKu2Ygk4c3eKkr+qa/XX9R/k
	jUskNFJuvjPVg8AaYJrW3qtBJtTuv4G4EcngKgBjWe55WgUx4aDwlap43HSfseSPl1h1cMNSMN6
	Viy/31OLcAoNfMMX3vGnJ2SqrPkO2K57tGYVORB4BIcyclGt4dPu7PhG9U
X-Google-Smtp-Source: AGHT+IFfMBxTjtegQGCBoQ12ZCHFGl8bn/g18bl/EfhLDuXHrAfoCubGaXZ5JggW9TaJK+WFlsOjyLHCK56Y6/0TJ5E=
X-Received: by 2002:a17:907:7b8e:b0:ade:4121:8d52 with SMTP id
 a640c23a62f3a-ae6cf5a2fdamr57413966b.16.1752020357805; Tue, 08 Jul 2025
 17:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <xmqqbjpv1ucb.fsf@gitster.g>
 <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
 <xmqqwm8jxoj3.fsf@gitster.g> <aGy82TiRFcij5V_9@pks.im> <CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
 <xmqqbjpuwsbm.fsf@gitster.g>
In-Reply-To: <xmqqbjpuwsbm.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 9 Jul 2025 02:19:06 +0200
X-Gm-Features: Ac12FXyy4KkSNu_bhz__5bd9jc3D2wLf41Yvvh3HaGOiEtEeJk_hN9JWCy-7RB4
Message-ID: <CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Also if a contributor comes back with improved patches that try to
> > follow closely what a reviewer suggested, then I think it can (and
> > should) make a reviewer feel like they have really been heard better
> > than just a hollow reply right away followed later by less well
> > thought out patches.
>
> That is kind of "better late than never".  I would expect better
> than that from more senior prominent contributors ;-)
>
> And I totally agree with you that reviews often deserve very well
> reasoned responses, which take time to prepare; a response that
> comes as spinal reflex without much thought is often not very
> useful.
>
> It really depends on the definition of "fast" in "fast response".
>
> If we need a week to come up with a newer iteration,

The issue is that whatever the time we could set as a norm, like "a
week" here or 2 or 3 days, or one month, or whatever, we actually
don't know what happens in the life of contributors. Maybe some have
health issues, maybe some work only a few days per week, maybe some
oare working on their free time and don't have much free time, maybe
they are asked to work a lot by their company on other internal urgent
things, maybe they have to take care of dependent people in their
family, etc... So setting any norm here that everyone should try to
respect might just not work for some people.

For example there was a former Outreachy intern who continued working
for about 2 years on their project after the internship was over. She
was a young mother so didn't have much time to work on Git and would
come back to the mailing list only every few months with new patches
and replies to reviewers. What would we have gained exactly by
imposing a norm on her?

> it would be
> fair to expect that we can say something like "I agree, I'll fix",
> "I am not convinced because ...", "I am skeptical but let me first
> see how it pans out", etc. by day #2 or #3, wouldn't it?  Upon
> recieving a response at the same time or soon after an updated
> iteration was sent, especially when the response is "no, I do not
> think so", what is the reviewer expected to do?  Saying "you may not
> think so but here is another point that may make you reconsider"
> would be too late, so it would actively discourage continued
> discussion.
>
> > It doesn't mean that I think oldtimers should have some kind of
> > privilege, and yeah they should also try to give a good example. But
> > we should allow people to not always behave in a very formatted way.
>
> Old timers learn from experience how other old timers operate ;-)
> and I have learned to ignore the usual signal when anticipating what
> your next iteration may look like (in other words, interim responses
> or lack thereof is usually a good signal for most developers, but
> not for you---you tend to come back with your next iteration without
> much interim interactions).  But other contributors shouldn't be
> forced to. That is what we need some community norm for.
>
> >> On our team's handbook page [1] we have the following couple of bullet
> >> points regarding how to respond to reviews:
> >
> > Yeah, I think they are likely to be good for newcomers.
>
> The handbook here is gitlab's team handbook, and it may not apply to
> open source Git development community, but "this rule applies only
> to newcomers, I am above that rule" is the same thing as saying
> "oldtimers like me should have some kind of privilege".  I do not
> know what to think about this and what you said above.

I think it's fair to say that oldtimers are less likely to disappear
tomorrow or to not follow up on reviewer feedback. So arguments like
"replying fast makes reviewers confident that they have been heard"
are just less true for oldtimers than for newcomers.

Another argument is that oldtimers are more likely to burn out or have
mental health issues related to their Git work than newcomers. Adding
a norm that would put pressure on them to work more, or at times they
would prefer to do other things, significantly increases the burnout
and mental health risks for them.

So putting pressure on oldtimers to follow a norm that is less
relevant for them but puts them at greater risk is just a bad idea in
my opinion.
