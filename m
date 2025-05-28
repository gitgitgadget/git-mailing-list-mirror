Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F621ADA2
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474158; cv=none; b=rRnCdQeT+BnU5mAjFDYHfZ2utisCuo2dutestrRAOvgFASmSf267TGT8BDvu2H9bTreqHYlnqodsX8zWwcb2QxorOEDZpg77R7wii4NLgXofapboFI6ohnrmkU5NHWH8/FEwMgIzDP13R6uLQ3RzskNpdiVKgAEisvaF+Lyqpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474158; c=relaxed/simple;
	bh=cniV6paYlSSENkW0xxgGQcwwFIRcEBp6exj7znK6XY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpYBsd2hCsCSQKSz8CKfJC+ajZWRcdbcLPI2G7KjL/HrRnLQAH8lBl+SmMWfsAn3j+ashXElTkwu8m4lIbyJDGqi8zasYGr1Gq49jsz76zUQFY36W3PHAfYiaWAvnEQRduNcttOeQt9GyagdzyMQycflOaTvuHQyb7021NR+c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfHrjMUz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfHrjMUz"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dc926f21d0so1463715ab.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748474156; x=1749078956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfSjZEtqF4moR8Al3m6EnqV4lz3ph5yUOKl4CDJJSW4=;
        b=lfHrjMUzFLnu0In8ZuuUXCgZPqUbNejXAgDAXUc7eqVJnwfZDM9n//oFK+bdlUXkoD
         Rbp3ILfeBV2XDOF8ZlBcDsohMige/iL8MGCrYwas8QtXRDU8Yv4HIsQw54zZXtHj4fhM
         Ks6+YR82RwJqNsnZJokf8eSQ9Hs45Gs/GiN24BZWSTGkkSa3WnxHCK/s9CMc60KxP7aG
         OJeltX/Q74xFpQ1rHpnGwE9wr0MLP/rflWfAAgxi/hWQz9sKD5UJoym2/akK/CPUgFhZ
         78qkueEaZFaVz5uO180e0ZdVuVuOj8vqWBOYrGdrrASYJqZOnLnUuINRHVHQV35jSUIP
         F7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474156; x=1749078956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfSjZEtqF4moR8Al3m6EnqV4lz3ph5yUOKl4CDJJSW4=;
        b=s7MS2Sso0wUaF4qxdnq0SzBX6+b5i8rxGxWxpSPRMtGJve00iekYypy2/k90OtEvSJ
         U3gC7SVQykNCKMGbmjTjB29vodDup4B+5ktn/v7+kEGlHj8tlXNrIBqXWNmwVleYMoif
         H6Z5kxIlK3X98LpylfKMEmtiZgm9L+OUoHrzjFSHje65oA69TLjdivCaSgbkHAZLn+pS
         QWIhMsRAqFbeLC9GFg26cHy8vE80UuT4aluWWWYliDucSjDe+EgqGHSia8Ikm9mTeuFL
         +lj1YisnrawFmj3tqAStvKyrzNCKJTDLDfYAJI9DhLqnPSYHdpWabF0AYr9m5XctbcxD
         x65Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUb4H9VG7OpV+fk7LKxwz14785ioHSkMPaFsL5WUmmqfIMzYCB7HD7GAV+dZHUT/nqDH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGDrRx24FgY7lxZ0tPr0JwFgYPZJWTksVe4tV57FtT9/hYQHD
	HoF04SoW/VU9dafe6WM35hxD1pmYWv90snZHvi7nHJQajWUwRvowU78ZycDW4ZTIQVr5ed6nCKZ
	exw7rsl6Xy1haPygCR2MzsPcISTEKt8U=
X-Gm-Gg: ASbGncvm3XqNMCe43e0yU+QGpNfJTgxqsMFEp5xVRHph5qy7pRShlkho5JEvI+A+K8H
	qvlKZRVnTOTtoR+ns9xSaZjsKtqzVNOxKeaZS7h/X2ohIFOsmPhmYXeyKx5rmVIjapv0tXGFE0+
	LxaocrZSSOUppIwWIOqk+KD1jpN8d+d3SNj4C0acvTxmVfs2Nrc0z7tpQE7zNEETnuuw==
X-Google-Smtp-Source: AGHT+IHkZgUV3sV2biMg7Z9yji01FTSh3oIOvM0SM/Cs5bFv9YeJeX78JrMKkpwWc4MU2ZQHQJikOO/0hXWxjqirl/s=
X-Received: by 2002:a05:6e02:2193:b0:3dc:8667:3425 with SMTP id
 e9e14a558f8ab-3dc9b70f000mr171806415ab.11.1748474156389; Wed, 28 May 2025
 16:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <xmqqselxtfyf.fsf@gitster.g> <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
 <xmqq1pthtbdg.fsf@gitster.g> <CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
 <xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g> <CABPp-BGe6r-X7NOiBFEvLGZH+GQvLkOYWn+qf3ZzzgT4sGAyOg@mail.gmail.com>
 <xmqq4ix4qtva.fsf@gitster.g>
In-Reply-To: <xmqq4ix4qtva.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 28 May 2025 16:15:45 -0700
X-Gm-Features: AX0GCFt9MbYredgZ4k9ZI1V2eHqwShPhI8HUEhdVOjXipQ3C79uDeXOS8hBT2Cs
Message-ID: <CABPp-BFRhSB0zTY1m+gYOpfvmuTvN5Pu3STawJwx9P-ayJw6bA@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, Luke Shumaker <lukeshu@datawire.io>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Often
> > when we have deprecated or changed an option our process was to first
> > produce an error and update documentation and wait a while, then go
> > and change the default after a sufficiently long time.  Here, we had
> > kind of stopped at just producing the error with no plans to take
> > another step.  If that was the route we took in the past, what makes
> > this considered a breakage and not the other changes we made?
> >
> > (Just curious, I'm not against this change.)
>
> What is wrong is the behaviour change in the original, which luckily
> is not in any released versions (except for 2.50-rc0, which should
> not count, as I think we should do this toning-down before -rc1).
>
> We used to silently ignore and strip commit signatures and that has
> always been the behaviour the existing users have relied upon; we
> started requiring these existing users to either explicitly pass
> --signed-c=3Dstrip or set an environmtne variable.  A new feature
> should be opt-in to make the transition smoother, but the topic did
> not follow that pattern.
>
> I view this last-minute band-aid patch that flips the default back
> to what it used to be as remedying that mistake in the original
> series.

An earlier version of the series did keep the stripping, but you were
the one who objected
(https://lore.kernel.org/git/xmqqfszbcazc.fsf@gitster.g/):

"""
Why deliberate inconsistency?  I am not sure "historically we did a
wrong thing" is a good reason (if we view that silently stripping
was a disservice to the users, aborting would be a bugfix).
"""

and later in the series
(https://lore.kernel.org/git/xmqqim44fyjj.fsf@gitster.g/), you added:

"""
Thanks.  The "filter-repo already gets bug reports from the users"
is a valuable input when deciding if it is reasonable to sell the
behaviour change as a bugfix to our users.
"""

Personally, I kind of think abort makes more sense as the default --
at some point.  So I'm curious if you've just changed your mind
completely from before and are against changing the default at all,
whether you think there's more steps that should be done before we
change the default, or whether this new flag feeling incomplete and
development related to it being slow moving means we should wait off
until we have a better picture of where it'll end up and leave the
defaults alone until we get there.  (I'm kind of leaning towards the
3rd of those, but am curious if I'm misaligned with your vision.)
