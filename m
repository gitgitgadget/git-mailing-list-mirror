Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93B3B2A0
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823706; cv=none; b=o0zuzdqvD6dMZ3lMHPh5SNiJWE8Ni7NVHSUjHDZgy7ktD9ZaC/RtelYyJgck0yvsjZwr7tSwDuUrGutCzbq5pX3duQMQGozf6iIiZOF5j5uSp1JjnyMZ0PPd+2SEpASHqrqKkl1W0ZExQVT46zMV/3YRV0H+Jm/cb/pLGjYp4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823706; c=relaxed/simple;
	bh=MQTX5TfBSUletr510b1cJSrryEHBUosgECPvMX+ecU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Izf88mp4Ifj0s4TDUwqsDtjVvTze9pK2o3jn0iWgqOB80Dcta9xBpcdz2u+AI3+cgZCxa/MPU7w/lhOUscOlXLvrtx/GDdtP9T85xdU6DAPrkpWs7YMETghIubiIRUCUdwZDOWT4utwPlGCS5dhwq+w5RvnGy0VjfacdvEdYU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf6iipPA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf6iipPA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so1744673a12.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823703; x=1759428503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s51EYBeZEl+/adsSETEhrDeZobMr0gq/VJmKXMOx8M=;
        b=Jf6iipPAlP9xDe3reZ5uExXeUvG8rWAE8/aOOZcKzwuaOF5K3PqQl40nYzUm5lFT8S
         O75xPabLNmA2pW2asDfJN+fd7vX3m+tcetvM0vWWcZpkUasvH5WhDGaNELq1TJQ6kSrG
         O6nBQs5pn/R0znjwue5dLmF4EUa+tJpmtXHNo8pFMQf59qVZPDTFkkdx8xLG+PE2yCDz
         nibmRG5mxi5VFi+e+9IfsasuadmU+PcygbALn765HllPiZR2Aj5Qq+j5iGB36LlsyK6U
         w1j7FUY3hDCxqVaWqT5Ym3WqyhR7q0AlxNRWk2daWoi6hBPpWqqGnHL48GsmRQGDeZ1T
         p/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823703; x=1759428503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s51EYBeZEl+/adsSETEhrDeZobMr0gq/VJmKXMOx8M=;
        b=b1bANyeNP+j1RIJZ51ug/TvRHeMHwnOF16eOQSVY0Y/1+zyAgOpkhdIU9ZY/mCs3xQ
         bMMNQV969R5HDcxaR+R7wCidz59Ie7jDHP7gIEHIrOLz3PoqDXPV2tc3g5SU9uMRxqcZ
         U8Lw6bRQlrBGn+KkKZXOcuuOQG0SRyt/GkCt+wM9tL13THIMFezj/RoZW5rpLgvXG49+
         2lJzarpVaAhOkxaV5rnApnKoVpd3wyeKDcObsbdeGdx6+7PWWDAFRU9hq+E8SMdXpWY/
         Uj/v4Z+mdOtso0cFLx8b0py0E7U2C6k/cbo/lVIrDD+z3f2j0tWxSS5zbybBaNYkDgOr
         rGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUArQiYzF6tAFjuq8AQlGDbn8mZyB5FyOfa6jmrGhUL5a7gMCf5h+CTe3jHQPv4MLqY6R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTZiQfjKq275R2Lllb0ZP09XWm2mrcEb1eT8v4vLkjnNeWXb4
	86Dpan92i1Px+zc1i4VTC8vJktcmxW1/luTRxw5tPbbj9AxHdnPQTwy238OAoehkdNySN3ODeuF
	LxqvVOMKI6ENJUrYxOoR6x7QcwaCQj+BIj+HWCxM=
X-Gm-Gg: ASbGncuAREqdpH1dLjIs8IraBr1hZz770Q4Dfj375rMhJs7vbY1K5Hfi74D9Rw4rHCA
	iGpJ/oNyg/o3ewiCdtCkb/I5jLPZW50nich9h5LAmLDbVGFVRvLuGPv5kFZxh7hiPqXtPGdYd3u
	8YCWB3uQu8ilVOcqqRpOaTT30trIkZUIJqtcElDgP+zV0n4PfAzAs+C/QlLPMfRTeQvVdRrbdAY
	+ZDn+pfyjqo4E1ieVdj/LUnge9ZPML20iXeVghNtQ==
X-Google-Smtp-Source: AGHT+IFkO7x+tapOBvPsm1lib7ncB1KcU6pfW3e2KM5E/2aqguS7dA1nd0CVbBabFatfHRJIKzEwb6MCNH84wIU0F3g=
X-Received: by 2002:a17:907:9411:b0:b30:fd31:3c01 with SMTP id
 a640c23a62f3a-b34ba545355mr545468266b.25.1758823702987; Thu, 25 Sep 2025
 11:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNOQhncjwYCwCaZ3@pks.im> <4FEB2B85-FC32-4076-9DA6-F47AAB096CB0@gmail.com>
 <xmqq7bxnn5cj.fsf@gitster.g> <aNTgRGeaPajVz1dv@pks.im>
In-Reply-To: <aNTgRGeaPajVz1dv@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 25 Sep 2025 14:08:11 -0400
X-Gm-Features: AS18NWBdZLtM9hzD6i8BwvZvFfTq6nYOA87FUGUz4lrtrj9cea7O4tQ_tLkivZA
Message-ID: <CALnO6CD0fCF15Vdh7_AtuWiKeXUFbU_kqV=+wAMkmABzchV=Tw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, 
	shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Sep 24, 2025 at 10:11:08AM -0700, Junio C Hamano wrote:
> > Ben Knoble <ben.knoble@gmail.com> writes:
> >
> > >>> Perhaps "show-ref --verify --no-deref" or something that does not
> > >>> dereference but works directly on a symbolic ref?
> > >>
> > >> For now: yes, it's more difficult to discover for sure. But users wi=
ll
> > >> adjust over time as they get more familiar with git-refs(1), and fro=
m
> > >> thereon I think it will become significantly easier to discover that
> > >> subcommand.
> >
> > But unfortunately, that is a tautology, isn't it?  With the same
> > effort to advertise git-refs to make it more familiar to the
> > "users", you can make "show-ref" familiar to the same "users", and
> > problem solved, without a need to do anything to "git-refs"?
>
> I don't quite think so. The problem is that we have so many different
> tools that relate to refs, and you have to remember all of them:
>
>   - `git show-refs --verify` to read a single reference, unless it's a
>     symbolic reference.
>
>   - `git symbolic-ref` to read symbolic refs.
>
>   - `git show-refs --exists` to check a reference for existence.
>
>   - `git show-ref` and `git for-each-ref` to list references.
>
>   - `git pack-refs` to optimize references.
>
>   - `git update-refs` to update references`
>
> I'd claim that this is quite hard to remember. So...

Agreed! To be clear: me asking questions should be taken as support
for this exercise :)

> > > I think this goes to perhaps some of my unasked questions: who is
> > > the target audience? My experience suggest that most
> > > mostly-porcelain users don=E2=80=99t acquire familiarity with scripti=
ng
> > > commands, so it sounds like we=E2=80=99re talking about script-writer=
s
> > > here (and in the commit message).
> > >
> > > But how do we encourage script writers to discover these things? =F0=
=9F=A4=94 Hm.
> >
> > Great question.  I understand what the patch author is trying to
> > achieve (i.e. "consolidate ref-related functionality into git-refs",
> > which is the title of GSoC project [*]), but what are we, as Git
> > project, trying to achive by "consolidating"?  I often cannot shake
> > the feeling that it may a make-work job without a clear answer to
> > that question.  Or perhps xkcd.com/927/?
> >
> > Perhaps the hope is to have a single kitchen sink "git refs" command
> > that does anything related to "refs", so that they only need to
> > learn this single command (and unlearn all the previous experiences
> > they gained) and after that, they do not have to "discover" more
> > things?
>
> ... yes, this is exactly the goal of this exercise. You basically only
> need to know about the entrypoint git-refs(1). Once you know about it,
> you don't have to discover all the other commands, as it is now way
> easier to discover what ref-related functionality you have available.
> You can easily use tab completion (well, once it's wired up), type `git
> refs -h` to learn about evertyhing refs, and we now have a single
> manpage that will tell you everything about ref-related use commands.

Ah, but here's perhaps my question: tab-completion suggests primarily
porcelain users over plumbing users, to me ;)

I admit I blur the line quite a bit myself, being unafraid to string
together plumbing commands at a live shell (or make abominations like
git-greb [1]).

At any rate, the target audience need not be precise now. I hope my
confusion is clear, though :)

[1]: https://benknoble.github.io/blog/2025/09/17/blame/

> You could partially address that problem by providing a gitrefs(5)
> manpage that gives an overview. And maybe that's still something one
> could do, also to paint a bit of a broader picture. But documentation is
> only part of the solution -- with git-refs(1) we get some "natural"
> discoverability.
>
> That's also where the "git refs get" proposal comes from. Sure, you can
> use `git show-refs --verify`, potentially with a `--no-dereference` flag
> if you want to read normal refs. But I would claim that this is almost
> impossible to discover without searching through our manpages.
>
> Patrick

This all makes sense to me.

--=20
D. Ben Knoble
