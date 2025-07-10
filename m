Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E32749C3
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161368; cv=none; b=iJeIRfyuPte0PB3psMk2CVffeR5GqrcdSXLdxuqc7n4noBJb8ozbYinI5s1rgs07E45u01e1gXqbTbOslwMCWDXwqPgDv7cUcUuf5TJyTnvM2l7V38peI6XAPRRCRDcpDhGXoWRyG+IWLjKrsqrwEZA5Xz3G2VPz2E+spx9g1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161368; c=relaxed/simple;
	bh=0PY6dBFm5zyplZmKniQYCFz9pM+odrwdw3/j2VdfI54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuVtvwZpbOqYgOgFb10qM6VvWlT4Au7Fa3szPtbqzgBVAadHRZIlZ7UiZBOw5SrNIQpeJ2gTxSgxmEUas6BCtMw3/dUonY+ci5VnwpXf5m7AnUKYM6DxkOwzpFlFqb7Y5ZkaMo2C4q2cl+Cnbsy1uKxbqn8RZQSsYg86biwPa8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIRcl1LY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIRcl1LY"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae36e88a5daso213868766b.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161365; x=1752766165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PY6dBFm5zyplZmKniQYCFz9pM+odrwdw3/j2VdfI54=;
        b=KIRcl1LYDEoDlxWC70LaSeLDeCst9Yy/sa4TsoGMSffQmgUVxmNlQAgJxSARrDS86n
         RKqPrHfTKMQvAtRaOn2RZPu/2sp67Lk4b4CR80xFP0lCt72YxnGOmSYMyiYQweV9+28c
         XQNlAyIW5mKkMZSgRUNoZ+lvJ+Ofqh0E0JQvLhCcmG44uQnfTWXT3VdOzBCUWQu0X6CW
         lQevoCaaPjLa4LZ8zzZ6DjnF0Yt2O7D+kL3lR0dA94s0rofPOD3xXTj0RH7/OtbbPj2E
         jNJELf8xD3Jj8+5c+i05t9buhShRvqWK0pqIxdkfYzW99e7YplndMT1uIBxAYRQmkhAk
         Ntlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161365; x=1752766165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PY6dBFm5zyplZmKniQYCFz9pM+odrwdw3/j2VdfI54=;
        b=wwNVFSbMtbCtjkToovbHb4qzuK7xVWoUI1Ow3b5/iUDnsz1SwmVigV0u6pvb9X8IKd
         uyf1kkdGu+Hhu05yHIuCeMxYon7sNix5NPd54fM49FitbqBnzn8PJFduOz6fKrUbUNwx
         RDnfaxw3lDZSpkUtbAGCvwGRguceKs5ca/0wXSLpFaYpQPZgcfQKj7a1f5uQaZq/vnkt
         wngewpt4GqfQKfdkW/DBqRoAk0y39bHVAzyGegD7N0ijB2jpjmLUa3B6Ge/xpFdoXQNx
         JNq2k6d9iQqZp4CQnC/izCj2QZQ/c2UzSr0J5Mv4CnG4wXbC1vTHx/cATWnTCEGrgKBk
         9+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKLEQueTsya0MER7E/TBoZSTxy+oTtmqK0JhTA7qdWqwsgcbVQYJzvDo1YixCruxgFEFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshDLDz6mjGfk+bmmnrxzu4M+IU0dryS/HLvUqFGFWVT+E2GXQ
	N3ANMN9PEofGqvuG0hTt0J+s/xJCGQ9LOr/Vpd+PiXlylxvtuoTyeOCzATGr20gVcEFLvZ/drbz
	RkiWuAoR1jGJ1CFdCeg9rRDbAV5/I5vAOIHCD
X-Gm-Gg: ASbGncvtybla0Vocr7j0+y/8VlXp7oVN5JzJiiXmrLNxSkwNLuTYv7LsnnlcgawPYos
	t9wPn2pT9ln3OAwcy2HDzNCbwMlwe/aM75CdPxeTBV2/vpKMMTkdoV5Mzk3wVUGvp/Ub6pHhOd5
	ilv0iiXIqc5mWkCtOGNtulA1d/swyWEuCSi9Zx/HfvCjZwtg==
X-Google-Smtp-Source: AGHT+IFHYUqs45NGi6lhxmno92hLyUWpBntAHqgXkRgM05nGJ3fiHahlmHyEOvtqOei6OUJsKn6JVNvUW1N0W2p8Ngk=
X-Received: by 2002:a17:907:9623:b0:ae3:d021:9b03 with SMTP id
 a640c23a62f3a-ae6e6e2e269mr317966466b.9.1752161364095; Thu, 10 Jul 2025
 08:29:24 -0700 (PDT)
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
 <xmqqbjpuwsbm.fsf@gitster.g> <CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>
 <aG94-0A6Qz35ekFh@pks.im>
In-Reply-To: <aG94-0A6Qz35ekFh@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 10 Jul 2025 17:29:11 +0200
X-Gm-Features: Ac12FXywRiAICA833tHDOWkMUBYY1-3IQzflyTAQuZO0F2dmH1ffmqAwUHlvUDM
Message-ID: <CAP8UFD2+n3jV4AGWQAD-J9wJ-szuxwOeZybyJvF4eeYvpH0+Fw@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Jul 09, 2025 at 02:19:06AM +0200, Christian Couder wrote:
> > On Tue, Jul 8, 2025 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:

> > > If we need a week to come up with a newer iteration,
> >
> > The issue is that whatever the time we could set as a norm, like "a
> > week" here or 2 or 3 days, or one month, or whatever, we actually
> > don't know what happens in the life of contributors. Maybe some have
> > health issues, maybe some work only a few days per week, maybe some
> > oare working on their free time and don't have much free time, maybe
> > they are asked to work a lot by their company on other internal urgent
> > things, maybe they have to take care of dependent people in their
> > family, etc... So setting any norm here that everyone should try to
> > respect might just not work for some people.
> >
> > For example there was a former Outreachy intern who continued working
> > for about 2 years on their project after the internship was over. She
> > was a young mother so didn't have much time to work on Git and would
> > come back to the mailing list only every few months with new patches
> > and replies to reviewers. What would we have gained exactly by
> > imposing a norm on her?
>
> There are always going to be exceptions, that is of course true.

Ok, so how are we going to manage those exceptions? Are we going to
ask people publicly why they take a long time to reply, and expect
that they are going to tell everyone things that might be quite
personal?

How will they feel if they are asked repeatedly by different
reviewers, in the case some reviewers didn't notice that other
reviewers have already asked?

> But I
> also think that long-time contributors that are employed to work on Git
> are somewhat special and don't (typically) fall into the mentioned
> groups.

They could fall into similar groups. They could have a child they take
care of, they could have health issues (including burnout) or they
could just have a few bad days sometimes. They could also stop being
employed to work on Git and still want to contribute.

Are we going to have a public list of people who are allowed to reply
late, so that every reviewer can check if it's Ok for the contributor
to reply late?

> From my perspective, it's especially this group of people that
> should lead by example and encourage others to behave in a way that is
> good for the overall Git community.

So you think it would be good for the community if people start to
keep count of how fast others reply and annoy them when they don't
reply fast enough? In my opinion, insisting on this is just a bad idea
that could backfire in many ways.

I am not saying that it wouldn't be good if people in general tried to
reply soon to reviewers when they receive feedback. I am saying that
it's not worth the possible costs to insist on this small aspect of
what makes reviewers happy.

> And leading by example in this
> context also means that they should encourage healthy discussions.

Why is it not healthy when contributors reply when they think it's
best for them to reply? It seems to me that, on the contrary, it's not
healthy to put pressure on them to reply when they might not think
it's best for them to reply.

Responding soon is in my opinion a very small part of what makes
discussions healthy. There is also the tone, the thankfulness, the
constructiveness, the technical accuracy of the information shared,
the work that might have been done to try solutions, the willingness
to share knowledge, the effort to try to understand and act on what
others say, and so on.

Reducing the quality or healthiness of discussions to just how fast a
person replies, is just not a good metric. It's like measuring how
productive a person is by counting the lines of code produced.

> That of course doesn't mean that such people should always respond
> within an hour, or even within a day. We all have to context switch, and
> context switches are costly, so it's entirely reasonable to try and
> minimize them. But outside of any special circumstances (vacations,
> health or similar) I think it should be possible to engage in such
> discussions within a small handful of days.

You could also say "it should be possible for most people outside any
special circumstances to 'produce' 20 lines of tested code per working
day". Would that make it worth measuring and annoying people in case
the measure is not up to the norm?

> In any case, there of course is a distinction between people employed to
> work on Git and those that do it in their own free time. The expectation
> that is extended towards people who work on Git is way higher than the
> expectation extended towards people who don't.

What kind of expectation? Do you mean that the resulting code after
review, or even before review, should be way better too? Even when the
person employed might be a junior programmer while there are very
experienced contributors working on Git in their free time? And if for
example someone retires from work and then starts contributing to Git
10 hours per day every day of the year, then should people employed to
work on Git try to match that amount of working hours? If someone
working on Git in their free time has an especially good mastery of
the English language and starts to write awesome commit messages that
are on average 100 lines long, then are we going to expect people
employed to work on Git especially those who are not native speakers
to do as well in this regard?

People are just different in many different ways, and what you might
very well expect trivially from some, might be very difficult for
others.

> > I think it's fair to say that oldtimers are less likely to disappear
> > tomorrow or to not follow up on reviewer feedback. So arguments like
> > "replying fast makes reviewers confident that they have been heard"
> > are just less true for oldtimers than for newcomers.
>
> I think these are two different things. It's probably true that you get
> some privileges by being an old timer. But I think it's more in the
> sense of "You get to tackle bigger things that may not be done in a
> single patch series, and we trust you to not just disappear".
>
> But with that privilege also comes responsibility. It's those old timers
> that newcomers look to, so they need to lead by example.

People often are good in some ways and bad in others. You cannot
expect all old timers to be perfect examples in every way. And that
should be fine.

> > Another argument is that oldtimers are more likely to burn out or have
> > mental health issues related to their Git work than newcomers. Adding
> > a norm that would put pressure on them to work more, or at times they
> > would prefer to do other things, significantly increases the burnout
> > and mental health risks for them.
> >
> > So putting pressure on oldtimers to follow a norm that is less
> > relevant for them but puts them at greater risk is just a bad idea in
> > my opinion.
>
> This is of course something we must avoid. Nobody is being helped in
> case people burn out. There needs to be a middle ground that works for
> everyone.

My opinion is that in cases like this, there is no norm that works for ever=
yone.
