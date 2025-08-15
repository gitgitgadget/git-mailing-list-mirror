Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D2149C7B
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230657; cv=none; b=BAFHDY0OLLWF7RLjF3IhECZtqu3meFgJLeaV7Wpf7cXsgVCejzQ1zTGSPQFFJsU1M4aK0fXSNLqmwsy+AhYaDRr7lmwchRyh7EYNbnVOWDLuYUkBgh7nnLlTynrraW7CT56xODGVfoA1OuqRe6vI82Gp40a4IWyrCA4VelkGvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230657; c=relaxed/simple;
	bh=D8x6/wYw+nj1PNIVrnAMhoLcdS9M57l0WtHmZdLfn/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOBoj+O6Vb8CrM7GmGCZ7eMA5XJ36fnN0K8NTSvJcDpksXpZvs+ko5SIw4/qRR0EewBADharHmSP4zUuY5LYE0lr+3Qhe/3yFGT9huHixIUeZquEh1aWbhp1ZnQmHZ4ekddtVmDPctb28C0GU5Ztf6vYg/W/l7F1uzYeEFMau3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VirPoRjZ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VirPoRjZ"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e571d40088so8740215ab.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755230654; x=1755835454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz2Io2N7ruKmhNoqSuTs3+hFqjluDVsHMRjGsYrT2aA=;
        b=VirPoRjZOGLOl1codNTDq9kdlLWkMEKYYWk1y47BPn+Lwk6f8ef8FwBcD2dGKq6+2C
         8rNLMtycivErhHs24nEcm0h81gqXYDUJ/pKx/ZzBPYZNu3/5E5fZhr2EbewT2Zzdgf/S
         ldM+Ww87OEddIaS0QG+3FNu8bvdgDwzlMq5g4FAMWRcmCNCTnYTT3+U0OQdRRv6WolHt
         /0QMk7WZRergCPAyw4hsRh1BDQDlLlm6GKmsdOhpTcbjFPsIJa4eBi2IFeeyy48baSL1
         BeLsRMdZJ0vBRMt3FimUzzUE+QO+dJjxv8uuuzrrlzN/2F6LReqlfquqKNzRYl8iXLAH
         ZC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755230654; x=1755835454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nz2Io2N7ruKmhNoqSuTs3+hFqjluDVsHMRjGsYrT2aA=;
        b=JQvjR2qMnJMaOfevnO86djd6oJXxD/LVGVRpCmIzAYf3HPLv1adcRzSsNoBLUTDr/E
         eMgXV2IuUQy/fzdbRj0iVjC54SqHUCdHu+5PWiGYNa3lc7oANkPgC6RLRJlcL3U9OUDV
         X7Evj0kQesvYYP/pezB9RBrR4FvxayqIpuYRyUfiK0dIak+NZEHujOXZz02reOvg7ONg
         EPQC00iWrBnmS9L1LtB7k7Rm0EryYvE3Es7yKVt/jDjyuzUKX81QiH3ttEMwOEoYK79u
         X5pSNLQcl9DL9JolSyR0ERIjMT10EMY13j8NFXzjgK4BaX8VVhZ2p3hKP85tdchxUWLk
         RTLA==
X-Forwarded-Encrypted: i=1; AJvYcCWq1hRNzZTNfHHsh1Neey1ZmZX+OUQg9aYKMHPzKfBxjsu0XCQ7sg8+7nD862Qxfrs/ogI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhANzsVp+2kpXYw2VDFld454+cmNfxTXSnGcKx2TZ7Ztv4kc6X
	lKH0Fl8vEamt7IHsd1VHs+t1lokHF04+eCVya4QjVlkb9WtxBjUx4TB0ThCPCOsevnyZZyof1eM
	bqUWXwqdAE8GXilgctLfk+1/MCvR+DnKVQyKb
X-Gm-Gg: ASbGncunCayOKssMp0Fg5MW7Y0zIj6TA+jWo+P6C7zSbHgCfUSwinPk3cm7gch5bITl
	+WJJBreGdu35HXu6QVKQwEAup7oDAnIk2sgf1EndSh2WLxlV44VJTWvLmvrOVR4FEMZMqnLV0y1
	lMKrj8zWSrrNhbSgJK9tA4IMzT92T3kiDYNMw7dSlOn1aBXEz+4zM42kDmimuTKbHQLjSkVHmPi
	tpGMOIhLnfkijZJZd3TFXfxcaqJ9lTUq9z+foE=
X-Google-Smtp-Source: AGHT+IGSU7vLRuVikt2lgLkLqnjVUILkQPt3Iz2tWMp4N6au+ZquQkn7mnOYTBOeaH08Ur7vcY+o8MOY9doac7rJfSo=
X-Received: by 2002:a92:cd89:0:b0:3e5:4ca1:b4ba with SMTP id
 e9e14a558f8ab-3e57e9cb862mr11701015ab.21.1755230654375; Thu, 14 Aug 2025
 21:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
 <xmqq7bz5v0mq.fsf@gitster.g> <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
In-Reply-To: <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 14 Aug 2025 21:04:03 -0700
X-Gm-Features: Ac12FXwj1GIdx05VvakhbE8V1D_l4GMOs1IsJDPfDNW4WBoNV6rJ_Tp4ECLc9Ro
Message-ID: <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
Subject: Re: why can't one alias `git stash`?
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:15=E2=80=AFPM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> Hey.
>
> On Thu, 2025-08-14 at 18:23 -0700, Junio C Hamano wrote:
> > Look for "alias.*" in "git help config".
> >
> >         To avoid
> >       confusion and troubles with script usage, aliases that
> >       hide existing Git commands are ignored.
>
> Can't one add some kind of override for this?

No.  And there won't be one in the future either; see e.g.
https://lore.kernel.org/git/alpine.DEB.1.00.0903070407480.10279@pacific.mpi=
-cbg.de/

> Cause AFAIU, my command
> from below would not hide the other commands, or would it?

The documentation you are responding to didn't talk about "other"
commands, it talked about "existing" commands.  Your alias, meant to
invoke `git stash` with different arguments, would hide the existing
`git stash` command.

It might also be an infinite loop of sorts, since your `git stash`
alias invokes `git stash ...` which is...itself.

And it'd mean that other folks who use git commands in their scripts
now can't rely on any git commands doing what their documentation
claims.

> >       If the alias expansion is prefixed with an exclamation
> >         point, it will be treated as a shell command.
>
> Well I kinda thought that... still wouldn't though if it was detailed
> what exactly happens :-)

Doesn't it detail what happens already?

           If the alias expansion is prefixed with an exclamation
point, it will be treated as a shell command. For example, defining
alias.new =3D !gitk --all --not
           ORIG_HEAD, the invocation git new is equivalent to running
the shell command gitk --all --not ORIG_HEAD. Note that shell commands
will be executed from the
           top-level directory of a repository, which may not
necessarily be the current directory.  GIT_PREFIX is set as returned
by running git rev-parse --show-prefix
           from the original current directory. See git-rev-parse(1).

What is missing from this explanation?
