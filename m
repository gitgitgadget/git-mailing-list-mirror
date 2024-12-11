Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD12451C0
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898111; cv=none; b=ExZWkqlNZcKmeIKexZ7vGv0ri1DwvYl2QvXUsN9UKxXXH6T7m2lehBXNz5ULc5RZRSJtHx1C4ZsQIdP6Q+8fODE/eR5W7ArPSybeiIcAFdNLFV8OW8NY0doCPYm6C4RF/RyyMCMqcbnc3h1CHLXnFa01eZ+nPqlhf8xho0LC4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898111; c=relaxed/simple;
	bh=JN6jUrhZv9a3BKM56J+lUSe2CN1K1xZLWglYYP4e47A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZw8UzznhfFlWUe7Qd2q0AkM9qsdtaEi8c76qB6ta5aD+Qn82gGok8XfUyqg4lY6N0SZic6s2eS7oNttggVpmHH2NkxAHpfMHIjq5aGiktIIeRhAJ8kHE1Ijf1fhQ4n6zKYPFwzFqHmcW0v0kd4c28MWQLHHVXK+arCh4p08OcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDdpuwOH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDdpuwOH"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3c89a728d3so120007276.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898109; x=1734502909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLSsUckaSw14a0Ji4IZwTgNxuste91W+f1dAP6/uNUM=;
        b=lDdpuwOHpArSOSqPz6suG/GFTcSak1S5IKWANwmdVqQBO1/IMfexNut7A6FRgXuxuO
         esNlTcj2e8n3yrBzbU84DObqOVsWMEnn4QH3J+phe2SD+BUSQsoFg/SRnQx3HxSK2L70
         B4Ox+wWGrh9wMSSanSzDmZ0iT6jycoH0xlihC3IdLD155jKAh21UIIKZGwfo4I2Of89W
         hHUMkVsZ8872kE0DQuvjQiP4Gu58Ji5JQe/vcgMj0aipugO7bG0qJ9Bp8WZ6sLo5MbaD
         9wpmFY6Y4NbZcV1R3gGg08Z+8ydBZXkAZpTZtrHiwgcYYqTkCopPPvLAyDgPnh9vHMau
         H2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898109; x=1734502909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLSsUckaSw14a0Ji4IZwTgNxuste91W+f1dAP6/uNUM=;
        b=c8hSLMjs0eV7AX1ZrB5T76BtoxyHcVnKJdAj7LqqpL17CNa8ltbZ2SmQBDdl5ayO9A
         oKaVn7Ap63FFSsCD/5Iyh5IlTZQsJQ0pW18U0BVxe+oRQZmNugm+xcajd1iFxpm5PJ3X
         27mnrn30ACRVpP7oZggqUxfyHuxkP2lggeij83qb8Toeg1kNCE+Fjv9DhWP5+gkun3nj
         l+ihFv2jhs6tHlwrYfF4AtpcogZqvI07Qmrq1aJCdLa4/g+cwcJZPXtAK2HscTQFT2Tz
         BgGNwybX42pcrvRsYKMnQrzsh/gU4faeQIiWgJsIIApHSxm0w71BXoI7cYXOrm1Hfnr1
         u/EQ==
X-Gm-Message-State: AOJu0YzZLUe0mRCm1UsOGCqgSMb7B0IZCKnhBSCdSdsZJSmb3yKReUOa
	azaYUpfYL+SuvI1w0TX+7WJoQKN82ygK4F0kNiYZ6gJL3vuYbqqdmIDx+DqvjvQfaVHLXHQ+Tgd
	c1XHTr0ZTyxFOdJCZs3M1ZUjK1pg=
X-Gm-Gg: ASbGncs+VWJECfbkY1DqLjNScFRQ8HStZU0PGiSQGD5tGox+nVRduwca65ynnrBeRSz
	HDryD0ubDPHd9LrZ/hDkrRq/vZmABFWnH
X-Google-Smtp-Source: AGHT+IFZW1RR8dFZu+6LyEItFQvH3lHsJBbQaXp84v1/Uo2EIqGuGO5Xm8hrSvOY0fRGArFapDpkzFBmGwnr9t5FFWw=
X-Received: by 2002:a05:6902:2010:b0:e39:8a00:d443 with SMTP id
 3f1490d57ef6-e3c8e7236e1mr857714276.9.1733898108870; Tue, 10 Dec 2024
 22:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209165009.40653-1-royeldar0@gmail.com> <20241210184442.10723-1-royeldar0@gmail.com>
 <20241210184442.10723-7-royeldar0@gmail.com> <xmqq8qsnjcsy.fsf@gitster.g>
In-Reply-To: <xmqq8qsnjcsy.fsf@gitster.g>
From: Roy E <royeldar0@gmail.com>
Date: Wed, 11 Dec 2024 08:21:38 +0200
Message-ID: <CAOfFamn7cxebqr56UPCBU7z+bA85Lws8KSUWBDDah9ORmqLE=w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] git-submodule.sh: improve variables readability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:

> Roy Eldar <royeldar0@gmail.com> writes:
>
> > +             -b* | --branch*)
> > +                     branch="$1"
>
> Once another option like "--branches-only" will be caught by this
> case arm.  Do not omit "=" in the pattern.

Thanks. I noticed that I did so in a couple of other places as well, so
I'll fix that and send a v4 patch series.
