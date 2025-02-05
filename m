Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B8214A6F
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790076; cv=none; b=ivT//8ae+VsEasPikVHFREMN5t4lG6MA+MUnRj3WmutPE3lK6Vo9eOShWCu8RegUlKQWUAsn6keNy+B/U3ewbLNDTiwRL5v2UxDUM3rMbDBkKwTwBwJi5bHtfJG5ar9vwpEaNA0EDdJ92kdboTB01nTdQcm5gRyUkvkAsJP70mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790076; c=relaxed/simple;
	bh=kyuyRwo41PG7rxuSxEOQ4Bhq5tQNBDRWNO1mXBtcVOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7VJZQdJ5CibRAS+Nq5tRsM57+5TVYHFfIJKtHJf4wL3/NE/DTb4D5fgaDSGb9o+SObLokXf22iYmOiHiHUyiQuRd8UGKwpoQkNsGMPYNKAx1740cSUOW6fk9TxmnZBkZ62ZJIugS1uOt4RkN0SHuAmh2CXlrCJ/B+v3ZxwrbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhGLWpPg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhGLWpPg"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab698eae2d9so49238566b.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790073; x=1739394873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmehUGusLeZYhqCElL6InBKl4WTaQ24aU3ofEHrp1+U=;
        b=fhGLWpPgUusWyWNCQT8amomRBkqpth/fJKR0Z29pnIfZkXezi2tpFN1bmiE48jxu/C
         lHY90c3SU6wMhIh6IH75EAcC/Q18ToEbN02kJRt6FAF0Q6ZFToKxNX0M99Bl5qDhOE28
         2cpvt1P9TbZCIZMmw7o3SCI1KpoBJPi9+od57y/zappIRJxqTnF60PrGsHa8OsFUQpGs
         KbzlOBBO+MPQ8qg5EeO+0S8EABRe9vSA6YVkBt0FkxEQbDYfrvOUD+xHl4xWRrdoB/nP
         XC5/PmZqGB7xuxTWto5r1axtSOa3FSaOtvnPGmpPvq0M6i2sB4OnifMK1GbyGF+g5nTT
         v0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790073; x=1739394873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmehUGusLeZYhqCElL6InBKl4WTaQ24aU3ofEHrp1+U=;
        b=IRDpeDowJyjCZEDPwcl3WZrgx2Q+dZEEz7jw0yIrhyDxo1y49LbrKp7fyYbq3WeFPl
         BHLWyTE5s9fTuh+7vEC2H0+/4K/+zCaTKsAhBwKc5WkigVooF1MmGM8+zDG2lRPq+reE
         WIksQDhQBuQI6KmC+PlNk0IkjNmM+qdbqx4JcQZFrA8RZUdDp5RjI/DWY9lG5TfRRGAh
         mwcVb28wHM88FszW+3U1lSTTR26x2+yABAdc8MNZyzGLqxl/JNi/8OB3hLAxArVX6q0k
         Erm8ORJO/yICN9MFteGUMV0+VfjzTvUcO3shYLML+AterQWYSofTq5jsq5305GEVg0zy
         q0eg==
X-Gm-Message-State: AOJu0YwHSUkHdgYTSWK2NkZc5HPbaBNc6F1sutToTyTdRj3hJ+O6L3KR
	du6QvetozVYSiv3Vx/jVbJbvjtvCxYIB5yL9RimJMAWSJDhWWBvi5HVPJvOeubrm41qKUB5RIfE
	iiD72LMD3Hy6vSr8AzNEjDNVJdEXZIAvb
X-Gm-Gg: ASbGncuFrtblnRXdgfis3Vfrv5MTQxwCPWCHb47zJK2b9eEtyqR+vg6sjTYqkqmhN0O
	B0nOPM4AjjXuRxQngRFp4WpU4PKD9nwIg5QMjVCDzUNgYiQ7y6NQUineZYxnaxWIufkZMyfGstf
	DjmEpDb/ZXuTBCu3QbcST5f4YoJaA=
X-Google-Smtp-Source: AGHT+IH9otJxwYpeg3fegEzqhpRaV+qBzprMK4LPiizgRYNfAayj075nSZMSiJszVICMz3/Vw2mqwMDRn0si2Y7v2CQ=
X-Received: by 2002:a17:907:7711:b0:ab7:5f0e:87e8 with SMTP id
 a640c23a62f3a-ab75f0e898bmr402279066b.3.1738790073095; Wed, 05 Feb 2025
 13:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g>
In-Reply-To: <xmqq34gsp9tr.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 5 Feb 2025 16:14:21 -0500
X-Gm-Features: AWEUYZncaSSjVaVuYUAE83SYowUQcA8eN0lT928kYsIYa0ZJwpsdGB0WlUpHp2c
Message-ID: <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 12:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> >> So, I dunno.
> >
> > Agreed that if pull.ff=3Donly is supposed to override all other options
> > (except those on the command-line), this might be wrong. And `git pull
> > --rebase` works in the scenario I described.
>
> Yeah, I view --ff-only as a safety measure for the user to say "my
> workflow is to make sure I do not have anything locally cooking on
> my branch when integrating with the other side, and stop me if I
> somehow made a mistake".  If rebase or other options override, the
> folks in the rebasing camp, unlike in the merging camp, cannot
> benefit from such safety measure, which worries me.

Is there, then, an existing combination that means roughly to treat
`git pull` with no other options like this:
- if not rebasing, forbid merging and be equivalent to --ff-only
- if rebasing is requested (because of branch.name.rebase or --rebase
or =E2=80=A6?), allow it

In other words, something like a pull.merge=3Dff (or ff-only) meaning to
apply the rules I've attempted to describe, in which case I would
leave pull.ff unset?

I suppose pull.rebase=3Dtrue is close, but is not quite the same for me
(I'd like to be warned when this would imply a non-fast-forward for a
main branch, though the "rebasing" logs might be sufficient)=E2=80=A6
