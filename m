Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D21F0988
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351922; cv=none; b=AXvPYHsV6ZY9vuYdOyuCZqPIiwgc5Gh5HbBxU0QiBSjoUatFxDFCMqX698I//6VpO81x8/RDd++flcOTsoZbDtCQtqcorF4saGgF3lzoDNsvhLJtrVCZtLl6tlC3F4arY5PSS5VK6M37A6hLEnREy07GYJhMqFn+DDz5lLVPdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351922; c=relaxed/simple;
	bh=ghV9lknWLn5lRnO3nyYbf52jHHLFLxkyA9aa5N9U7Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU6133r8fK/dTiF+Rfrga51soE9XiJoEpt72YoWSV/EP8+l+ejzEgwDSpIjKCZHmiI0H1v+KHuI3w8pzxzAAjbvITEQLd+y5PQuqtMsE1lvTR8BQwnI9PUT32tSNinkg9wKm15JGZIWNMYtHcMgqnZo0CP6G9iSQUJyLy1Lua7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZKSoqER; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZKSoqER"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso461984a12.0
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745351919; x=1745956719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEfCrxURUQSNmNWgZVokcVj4SP0LUKoUTwtXRRKwkLg=;
        b=bZKSoqEReNmX0ngHcOmOMgb3qSIAYnbiXswUwNeZNbwsMwEm5KRZysWgKolCaE6KPf
         DmaCmRi0fmoOJ4UxOaEgbsKXOzThgZ8ULW9pmDysOTUWzUdXXNV8R8oh2BvpfDt1D5hw
         r/0S+5h+VcPHihgCNkbbOg+jLL58Yi9tZsQeyFwSE1ac89GO0A8f8eFh/SOfxmO/F+9B
         WncOzKfIaQ3MH4+TlEy2fpzrDjFk0cHymh1DlFjd9myixDiYufrPakl6pn//Wq+n1+bc
         t2M491diBdMIhwdOytfS+TJ/mXDk6eAMOEXK4rjTwr6K9pPwTWq2r9cx4B53hgw09X8l
         5Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351919; x=1745956719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEfCrxURUQSNmNWgZVokcVj4SP0LUKoUTwtXRRKwkLg=;
        b=Ghz5GBj+eM9hvlYevCHfpRVuYrOHQozUQHW5scdccCkbN+PxoUqaa4Y+Uj5QJiq9QG
         DZFfKmzKd2EBHKPKNdVHVpUMhqnv9DkPVi0w0KiDnrYdLbhvhqlMjUGVP83aj+Osh7H5
         G8SLAw05r5JWVqAep0HkAw+IRhEogSyjAo1K7BLoZFmf/1PyBU2eXXFoRIdaN7ya8DHu
         DGrzG+ESorvwvxjoWcdCYQmrTKoWLIjfB9c8Eq75KWcpCdx61BGfNEJmHOSwydCLeDh3
         3OHNyEoKQaN4Dh+wYhXxh3eOnJ6cPp0+SvzbHt2fnoZbu+vWHH+Hy2nUO/8vokLkMx9I
         8M4g==
X-Gm-Message-State: AOJu0YxOqwah8fNjIA717ukAC+2mx/xbLzw2x5/0LM/RExLZfaUwOHzz
	1r1ksJ0ZwaMnnEnl61yaPbSYjnTBarBJJKJ/55TMQ8vu8giJgWI3BAeLL3eM8Ljp9lrnX1kqPkZ
	xS/GmBP5nY76BmxVIrhdeEca6Cp4=
X-Gm-Gg: ASbGncvuJBky6Fp8UUaNi9BehqTz7gSSJJ28MJppLD7vauTsHqkjMkgFo0PZvrVjraG
	MXQRVmWfdkvlZ7Aj530nw2SalvJUx0LoG3PKmgfwk9A5hUDJWK9wXnyDBqGbZpKTRl1N8SC5nqm
	iEeuSoOAMJcVbpzHygXfRW85o1QruN0pbyQ068lGVRCN7y1W10Uzm780o=
X-Google-Smtp-Source: AGHT+IFWbGXIosRIVHHXn3W9/opZy7VhtJmmuqPuH6bnPLj5q30Fr+giV/JIozIIMvf8ZVd9YfbhFaHtElBKNlc0oxE=
X-Received: by 2002:a05:6402:234f:b0:5e0:6332:9af0 with SMTP id
 4fb4d7f45d1cf-5f6cf46b0f8mr249112a12.14.1745351919245; Tue, 22 Apr 2025
 12:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
In-Reply-To: <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 22 Apr 2025 15:58:28 -0400
X-Gm-Features: ATxdqUEMcTvmVjkiK9qs54EGsZAO_L6nNoGQHWhB4349cAbNutdimtQrZstE03M
Message-ID: <CALnO6CBi-c9U-UskTzjNBH+k8VQybdSshYgs+A3_DRH-iz7zHA@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:14=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> On Wed, Feb 5, 2025 at 12:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> >
> > >> So, I dunno.
> > >
> > > Agreed that if pull.ff=3Donly is supposed to override all other optio=
ns
> > > (except those on the command-line), this might be wrong. And `git pul=
l
> > > --rebase` works in the scenario I described.
> >
> > Yeah, I view --ff-only as a safety measure for the user to say "my
> > workflow is to make sure I do not have anything locally cooking on
> > my branch when integrating with the other side, and stop me if I
> > somehow made a mistake".  If rebase or other options override, the
> > folks in the rebasing camp, unlike in the merging camp, cannot
> > benefit from such safety measure, which worries me.
>
> Is there, then, an existing combination that means roughly to treat
> `git pull` with no other options like this:
> - if not rebasing, forbid merging and be equivalent to --ff-only
> - if rebasing is requested (because of branch.name.rebase or --rebase
> or =E2=80=A6?), allow it
>
> In other words, something like a pull.merge=3Dff (or ff-only) meaning to
> apply the rules I've attempted to describe, in which case I would
> leave pull.ff unset?
>
> I suppose pull.rebase=3Dtrue is close, but is not quite the same for me
> (I'd like to be warned when this would imply a non-fast-forward for a
> main branch, though the "rebasing" logs might be sufficient)=E2=80=A6

FWIW, I found some tests that indicate, to me, that I should use
pull.rebase=3Dtrue (or merges) + branch.<name>.rebase=3Dfalse for the case
I described: https://github.com/git/git/blob/08bdfd453584e489d5a551aecbdcb7=
7584e1b958/t/t5520-pull.sh#L505-L514

So it turns out my itch was already scratched.
