Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45461313538
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729509; cv=none; b=f5hAmU6enMnpbfL/h+3aYI2FY4KnGNxe6G1gRG3b8THwoICTaUoLAd6G6vbDU2K+Pd10BM9GHF3Vbyg5fvgtX7EQywecwccw9M8B+VFe2Sc6PNJ/8q+OLWPUEpDFtmubu/lqlRC3sIUyCVnQlgL85ZmrcRd7tenpPuZEcY3wxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729509; c=relaxed/simple;
	bh=alrO0HJAMxmi7QpyRjgd+0FIp8/1bj8oLIyi/3ziUAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuuhD89QCH7lEogZO8LKk9pSY8zQWuEUzsvz2FvdVEdTdlG/XIWB0hNlszExuq/iJCbTgi5ozXnQHPvwB2LpFurrqVRMd+mhHUoPiuntYz68cru1qwDi/ThifE9NSpIZliwiI/215zb7nViNBy4VUaxAm1llmdyQ2YWnpI893ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJSJW+WS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJSJW+WS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3635bd94dadso56574671fa.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729503; x=1759334303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzUsWIlwBEgcj/D5qars76Gmxmh1HQsZXWGqA86oLok=;
        b=PJSJW+WS74ofKp/uhPsX5LChJESegmtEJhTShbi1CxkUZDfmBkWXLmhT3ft25Yy38C
         TLU7R+jYDLLaz9Ssutf3g1OvHysTsMCZN3dHI1AHdAarlLwlOs04dCcose58W5reo8MU
         gQT2JKMkhCVwaT9NS21ObsIlaM0zeJp8PnCGb2wyjWyYr4CRwjasPakGXzo6yNz5w9X+
         6PmhEoOS4ZZeGCaJyXcUVimP/wVCiBaZj0QmQUfxZZMc3VuV07HiUz+qltJy7Vo9v3Wd
         q+oZYVJYn5tlWeksEjKeAZkGv8ckpcWwUSElBHCx93rfRmw7oUBI5eNvKcHtndWWOI9K
         3MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729503; x=1759334303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzUsWIlwBEgcj/D5qars76Gmxmh1HQsZXWGqA86oLok=;
        b=MsFzcesj68P8fxmSJ2DJnlq2/XPzlRgboAP2Tl46liiRJRxyTi8vW26b+sLyTNggX4
         R6Gt3afpaKK3pTuXlJHe5xW6URjs65aVQIHSlLbEEzW1twlN5SSudMUOgswOCdCv2+dg
         xnMLczf9tyykh3lee8v/vqquCMMM4ruva34kIzA3BIA4+0Zw0hmGdqtk+Y/kR7l6xKH5
         noJiCO29WeBnz9/FPYLX7H/psSm29RD32JiESxlg+H57vEEONARh6VTGBvBltlFCUbAM
         dRoPmEbKBOTGaTtZtHJMZYJ00PPXr9/Hpt3d8HB/360QYIuapN7/HDw8l2nFHuy4Ly/u
         gEzA==
X-Forwarded-Encrypted: i=1; AJvYcCVEfYwOpvJSNtm49mkCk1Q7KxwvKpzxab3oEN1PxQaoXNSy20P/iHzownvpmqqKhbiaGXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQZP2wQ8LxKY8L6GtwN4gcBR2qgbB1kqULiR7PKMH4VTqX/rZ
	lHiHsSoaO/RX6UA1VFNCHoEOs5UkSDqZBIoFL9UbvaoD2Y4DZPLqeGvGhfK0/HgqdXdP/2HcBhj
	p6WMhtrSmRUW5PNkm6RUE0LyFh6vbr4c=
X-Gm-Gg: ASbGncuTYXZsoAWo2U3lfHCeSRIXTqny4iL8EDHV/SV3uHl7dFCYeqh34pUopNV7+3X
	pgN1lfLysKc1bWskitqoHNgVG8GkzoIfC7bohu58qRiWxx2UOQstc+EAKg3VY0ZLqCHR8wGP7Hs
	+VIkBG1VB4eV7SjW0jyTD2DLQhLJEnWOYvp8GUp+UtqnbfEkWul0WN01xVx2G13pC16Tva8BsY3
	OG/2ru4
X-Google-Smtp-Source: AGHT+IEQix57qQUTi5f82JGYwG6bbyC9IAe5i+GGpDW94TEBsK2DuKWbatD/hwQMKif6MlKg/8dv4cGXJyTPUIocCL8=
X-Received: by 2002:a2e:ab0f:0:b0:336:de52:5c33 with SMTP id
 38308e7fff4ca-36f7d7c288dmr17351fa.16.1758729502918; Wed, 24 Sep 2025
 08:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
 <0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com> <CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
 <xmqqqzvvn9tq.fsf@gitster.g>
In-Reply-To: <xmqqqzvvn9tq.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 09:58:11 -0600
X-Gm-Features: AS18NWCpbbrETsp5ly9j3CGICwa71F_GhfI_rkd96TwMwypV35z-tbPgpbahtts
Message-ID: <CAH=ZcbAcvoXJYPHE=mcZSqPLuUPxKcSs-vd307X7uXi+aG3evw@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 9:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >>
> >> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> >> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >>
> >> The commit message should explain why this change is being made
> >
> > Reasons to delete local variable aliasing:
> >   * Usage tracking: Tools are better able to follow the usage.
> >   * Refactor churn: Later commits will refactor rchg.
> >   * No additional meaning: The local variables express the same meaning
> >     as the struct field itself.
> >
> > Would that suffice?
>
> In general, I do not view the first one is a good excuse.
>
> When using a separate local variable enhances readability of the
> code (which often is true, with a pointer that points deep into a
> nested structure member) to humans, we shouldn't blindly bend the
> code to cater to less intelligent tools; it needs balancing.
>
> The third one alone is not a good excuse for the same reason.  It
> (and the first one) depends on how much benefit we are gaining from
> having a short-and-sweet local variables that may make the expressions
> and statements they are involved in easier to read.
>
> For this particular change, I would think it is borderline, and
> subjective.  I would be OK with the third point if you rephrase it
> to additionally say that the conditional and the inner loop is easy
> enough to follow without using the local aliases to make the code
> shorter (which of course is the commit author's opinion, but they
> deserve to have and express their opinion as part of the rationale
> for a change).

Ok, I can see that.

I have a question for everyone: Does preparing C code to be translated
into Rust count as a valid reason for changing it? Provided that there
is no violation of the Git style (or very small in some cases).

If my intent was to keep this as C code forever I'd agree, but... My
other reason is that it more closely follows Rust paradigms. Creating
multiple pointers to the same memory in Rust subverts the borrow
checker's ability to keep track of who owns the memory. Since C
doesn't have a concept of borrowing, I decided to delete the aliasing
here, and in many other places. I'm removing as much aliasing from the
code as I can because it makes it easier to translate into idiomatic
Rust later. Using ctags and modern IDE's to follow variable usage is
convenient, but safe Rust refuses to compile in many cases where C
aliasing is common. We could use unsafe Rust to make literal
translations of C to Rust, but then we'd forfeit the reasons and
benefits of why we want to add Rust to Git in the first place.

Translating C to Rust has been difficult because many styles in Git's
C flat out won't compile in Rust. Many places need a little tweaking,
others need major overhauls. In all of my C cleanups I am keeping
idiomatic Rust in mind.
