Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9741DB154
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474227; cv=none; b=BfPqXEsVOjxaZVHTtyH8KcLzgJdjuEd2x7HVLJSsqTcMa0EKZEr5BMsqOfpOsTpIIpROoVEgBcCpYjK3XGAOkCkSJmKAeRcNBLyU9zbKOmg+DTdE+Fo+9DzsXpZ/bqT0yYnZRlMpzaZ7RrepVdTWnK+2mnz6ZtwLzOEb7BAZJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474227; c=relaxed/simple;
	bh=5eAwSwKuJcIUI/pttp/cKpjQK89RoiH7hWQSNT7M7DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejVtW8y3R/iL7hsdeceiRXg2Gm1PTJOf+Al/+x8PNQD4WmRhZpq4bkJ0RS+3wzt7ncWaPjepHiT5GQLq/lt41DIXfspNU2geMrA+PS0iYYaSwgKg4zmoPda3ptdOTrfY+mX7TvEm3HIog/E1WR7sV5WtvZqX7/1/VSEbSEhVZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7Ca8870; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Ca8870"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cb9f6dbe7so3788222a12.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756474223; x=1757079023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL9Oy9RTMH5R5JZolvJnl6N6lfiFFeTvYXbhiS7Z6+Q=;
        b=g7Ca8870WDmptUo23rDpeo6fRiVoMFPapjMaw26rdS3Iwrwq3RSXmUxO+Z0wIrAygt
         qmR4IvOffzieBeuC/eAFj8WeIMVJMc9HT5KFLaaeXHFPx8/4q/7Y0A8yxsDibww7VY6Q
         znHAsWWJt/3dPxluwz8AL2dUajrqufl86+ruHJy3yvBMDDh4rM7fSQ7A+QGFf5JTYoxw
         Zg0TgdqVhhiv3gtIKMSyCxOcAHFv5/+CRneyiGrDAmaq8IMSodlYjcD9yioAgApgzTup
         2/migQWNzu3447dxunGkHaSZk5ko4gBMFdnISxmuPu5aJcdEJ7d/94wlXSDKn7jwwlci
         5S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756474223; x=1757079023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL9Oy9RTMH5R5JZolvJnl6N6lfiFFeTvYXbhiS7Z6+Q=;
        b=EHAsPll/V4cFZ83mnP6Fi10+EF+vEyni3kCwIL2UIC+wYOaGn9tn0GpzWpA4Si3q2p
         UXF+L+T8Cv+3FCKDhp6NvIzQPsxx7Cw2Z503sBwrtwg1UkBOCG4INkqPUg1lNsoVlKIE
         m51QegAoJGNMdxjtEOrEpeSsenDYoCUnbNHj4MHwbrz4001w2MOphJqoYH55vh53t3Fi
         et2eJLwGXc/37PlAYPJqovW3SfGpg2el2qUnbLyzo7oSe2mOqzo4hoc1QFamgEZvON8s
         +xrRB74h4oruYxhJahJf3Ur6vaxVJbRArC/Kfs0MnRNHb0/oO4vGeImpT9/i5v8u4Y3K
         8/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVeCBgwuQYjCVthm4jw1OMsxuOghwazKVJ65sX8XYf4ZGWV9Ir5pYvfR1rcUm7t4/Vj2uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyZf3U9xtVFHHF7tkL3iAcRp/yH1p9Pk9PDKYoNvqZN0pkNK5
	c7S7GKVLMunOHurmCuTwxhVxHL9AvoO1g5JU1dZyX7xYD3lUH+nrUJwVLjipGe5JPw9C3wegb0n
	exZ217Onz7xNvDeBUVN1Ulc9XIQ147Ps=
X-Gm-Gg: ASbGncvEEg5XusXXNsUEzosQ9dgzEj/fUJeP+/2uBqaHN0XZWgimJkvRtenSekfogkG
	Vs+r0IpuyzTaAVcUwOcGTenQaJzVW0SuB77kZoNGuuQxIZ0TqG0jZfQNknf3x8/9GSSk2yvlgge
	jkok6JECgqxdLrZv8PUnmoLSAkh7fzAo/WDqdOgzeopIjfguRYKArgxIRIcXrNmUeeLCsp2r+gI
	5+G6MEsMkxqxP6FE7TYiHCXxdGX1IfrJ3ypI8DthOrltK5Sr0pa
X-Google-Smtp-Source: AGHT+IFeuvNkt3EaiTcOqP7B8IJn93KKY0t9Qw8hD5N7ch8rjdeYqfjrJbdINxwrvxw2xchZJL4NP78K897Vfutizgg=
X-Received: by 2002:a05:6402:440b:b0:61d:b8e:195a with SMTP id
 4fb4d7f45d1cf-61d0b8e1cd1mr1130266a12.1.1756474223083; Fri, 29 Aug 2025
 06:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
 <18A45EC6-2D2C-45A2-8802-0E5060539398@gmail.com> <9f9e49c5-5612-4e6d-89af-839b353506f1@gmail.com>
In-Reply-To: <9f9e49c5-5612-4e6d-89af-839b353506f1@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 29 Aug 2025 09:30:11 -0400
X-Gm-Features: Ac12FXy4FTSG0VdbzhJlrMLipyHEAQrFXxLDr8PxS7Q6w4uxlyUjpFgWKvjj9j0
Message-ID: <CALnO6CCsFuYqo-q8D1g=vR9q22+Cy1MAgk1Ld0cD1wFNjr-eSw@mail.gmail.com>
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>, 
	"J. Dettweiler" <git.vger.kernel.org@dettweb.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 19/08/2025 00:41, Ben Knoble wrote:
> >
> >> Le 18 ao=C3=BBt 2025 =C3=A0 11:14, Phillip Wood <phillip.wood123@gmail=
.com> a =C3=A9crit :
> >>
> >> =EF=BB=BFOn 17/08/2025 17:08, Junio C Hamano wrote:
> >>> Phillip Wood <phillip.wood123@gmail.com> writes:
> >>>> To use it create your stash with "git stash push --keep-index" and t=
hen
> >>>> use the script to pop the unstaged changes rather than using "git st=
ash
> >>>> pop". If the script proves to be useful then perhaps we could add an
> >>>> "--unstaged" option to "git stash pop"
> >>> Hmph, would the behaviour useful enough that it should be always
> >>> enabled, without any new option?  I strongly suspect that those who
> >>> worked on adding "--keep-index" option did not expect the user to be
> >>> mucking with the working tree files while "testing the staged stuff
> >>> by updating the working tree files to match it and nothing else",
> >>> and as long as the end-user stays within that originally designed
> >>> use case, nothing changes for them, no?
> >
> > I can=E2=80=99t particularly comment on the script, but I do think the =
example
>  > in the docs should either just work or be adjusted to work.
>
> I think the example works but may generate conflicts when the stash is
> popped. One can argue that the conflicts are unnecessary because they
> could be avoided by popping the unstaged changes but I don't think the
> example is broken as such.

Thanks, let me try to rephrase: the example makes no mention of
conflicts appearing or having to adjust them. It seems to heavily
imply to me that no such conflicts are expected, though as we
discussed upthread it seems unlikely you _won't_ get conflicts if you
do

               # ... hack hack hack ...
               $ git add --patch foo            # add just first part
to the index
               $ git stash push --keep-index    # save all other
changes to the stash
               $ edit/build/test first part
               $ git commit -m 'First part'     # commit fully tested chang=
e
               $ git stash pop                  # prepare to work on
all other changes
               # ... repeat above five steps until one commit remains ...
               $ edit/build/test remaining parts
               $ git commit foo -m 'Remaining parts'

since we explicitly say "edit[=E2=80=A6] first part," since it seems natura=
l
to me for that to include editing "foo." Perhaps this is where Junio's
suspicion (reproduced below) falls afoul of the language used in the
example?

> I strongly suspect that those who
> worked on adding "--keep-index" option did not expect the user to be
> mucking with the working tree files while "testing the staged stuff
> by updating the working tree files to match it and nothing else",
> and as long as the end-user stays within that originally designed
> use case, nothing changes for them, no?

I suppose my main complaint is nothing about the example makes it
clear that's the intended use case to me? Hence
- we could change the example to mention conflicts and/or use case
(smaller patch, punts on the problem)
- we could change the code to accommodate the example as written
(using ideas from your script; harder but bigger win IMO?)

> >> Yes it probably would make sense if we knew that the stash had been
> >> created with "--keep-index". At the moment I don't think there is
>  >> anywhere to tell from looking at the stash if that's the case but we
>  >> could add a trailer to the commit message when we create the stash to
>  >> record that it was created with "--keep-index" and apply only the
>  >> unstaged changes when we see that trailer.>
> > This seems reasonable; I wonder if there would be any interaction
>  > with the stash import/export features? But perhaps those omitted the
>  > index anyway, I cannot recall.
>
> It exports the stash commits as-is so it should be fine I think

Great!

> Thanks
>
> Phillip

Thank _you_ for taking a look and providing something to work from :)

--=20
D. Ben Knoble
