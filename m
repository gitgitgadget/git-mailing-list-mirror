Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6C74E05
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026037; cv=none; b=qBb6PNEqIAQAMp5eWlcDmmBbMnz+gga+el35XY1yflyhfr/H8gqbMOh/UREGprQrmXcy8/Y2vPxI/vds/8NHCbXXaOe39xx2WeDwwXjN3H4esxwnw47rdmbX/gTfULwaTXoLi9W/x48ONlgu8DRdA5D2k993pfCGNVLqsewBj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026037; c=relaxed/simple;
	bh=cdmsevrGqEkGhyTmRowF2wmpwGCr7sp9RQF4WWuNGco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4fPD0iyBnnMlHO+Eo0LP2cQHZL4OFJAuPuMueSlxvvNJ68RlQqwohHUr3/qdaw7bdD1wpQVSnJBQ0sEASQsNtWHw9zq73g6L7GomGCvZuvi383ql96MeIzLb9+f6uXt0kxrR/1Z3ujIMVayTBa7b+XMkhsx/FOL7sQFuUsTD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIoM/4ss; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIoM/4ss"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a470c79ef7cso121670366b.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711026034; x=1711630834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCUpRMsczJw7wsKbhARrM/Ed42hz+ZW3SzTsETAeDHE=;
        b=iIoM/4ss1WxvxQ0qr4HkX1vhD8Dchsub6FhqSr6gBNt5TRoSqCnXWKlAny7bzHdLUK
         sXapYvGpQXv7QWlkV4BjF1IJO87a4ODIyRg/Gt025x/WzDBLSzYpxaC9M+TszUzabIUo
         AW0pryiQYxy0lm465JXuXbfnj4DN84Dl4xvFKQ/yHrR4hAa/nWbTzZlwhpqoTPxeJdeg
         g3iHUqeK8IRKt5XxA2PQDBVAM/B390tKOeaagW8BeLzRd28zDJk8RgiM0GAO6i4xUqoR
         oA/5bHKKCI6909iIdHPabAfvG8EuuTi9uz5QQqei97MTDV0kk8+fZAXcq2Qs25768Pc/
         4+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711026034; x=1711630834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCUpRMsczJw7wsKbhARrM/Ed42hz+ZW3SzTsETAeDHE=;
        b=iu2OXqTI33m2eIfFBppiHiqjNpm1EZbRteFIJdKqRyyZFACnAQWHcxOID6jQtbO38b
         GaHJkG1QJSM31JhNkRVCABC3klosy6QWvWdpcm1An5XvGBooa50kSj9yCifeNfhGC6m2
         Se1uo5WMnfrRpnTaepOAs++6YRpuTYwi/gVPePBS2yMen5y4smN3FMExMis/fQ2onkRz
         Pu3geIW761Oe8SazTfXk4+mpsn9tEo2eNMQzKPUm4UVpYsnPXt8IHXcMIjcORRwqTpzV
         oZZ3ngjGUbGn3zmTjioNxNVS59hxn9gFCtkdZWINqd33N8s7SONnAC4Osf/e4UUgMRfL
         uCWg==
X-Gm-Message-State: AOJu0YykQroNJ1SIpikLXFubyjX2cNxBCaem4DhNLpJvOI8xLeOh1zEw
	CtUWm+iw7wIDsU5p18Dt+OgloHiPvctXrmgC/w0pLHCXZYIVvBrtGCVZ/QwTecpPVlC9iIsy2ik
	ByhkxWRtHJFqHLc+YR5TlWYWkOs/RLTOU9tw=
X-Google-Smtp-Source: AGHT+IEgXr8Mle/fHteRz7WgQNcn7qELTpkkiVwLXPFpJbiC+1Y/1MLPc4CGMeI+i3hs9Asen6gJs0KpuI0JPNcWhso=
X-Received: by 2002:a17:906:7f81:b0:a46:3d7d:35c with SMTP id
 f1-20020a1709067f8100b00a463d7d035cmr2285230ejr.30.1711026034152; Thu, 21 Mar
 2024 06:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
 <20240320100232.GB2446185@coredump.intra.peff.net>
In-Reply-To: <20240320100232.GB2446185@coredump.intra.peff.net>
From: Matt Hickford <matt.hickford@gmail.com>
Date: Thu, 21 Mar 2024 13:00:00 +0000
Message-ID: <CAGJzqsmKcmd5+FADnE_T6kHTQXEvBo2=L3MexvQiJqj6OgXHiA@mail.gmail.com>
Subject: Re: Feature request: highlight local worktree in `worktree list`
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 10:02, Jeff King <peff@peff.net> wrote:
>
> On Wed, Mar 20, 2024 at 08:00:00AM +0000, Matt Hickford wrote:
>
> > Hi. `git branch` lists branches. It highlights the current branch with
> > an asterisk and (for me) the colour green. This is handy for quick
> > reading.
> >
> > `git worktree list` lists worktrees. It would be neat to highlight the
> > local worktree.
> >
> > Another idea: `git branch -v` shows the commit subject and
> > ahead/behind counts for each branch, eg. "[ahead 1, behind 1] avoid
> > RegexReplace". It would be neat for `git worktree list -v` (or
> > similar) to show the commit subject and ahead/behind counts.
>
> I'm not sure if this is a dumb idea or not, but: what if git-branch
> learned to display branches associated with worktrees (just like "-r"
> lists remote branches, etc).
>
> Then you'd get the all of the display niceties you want, along with
> other features like sorting, limiting by merge, etc. You can even show
> the worktree paths with a custom format that uses %(worktreepath).
>
> I think the only thing it wouldn't do is show worktrees that are
> detached from any branch at all. I'm not sure if that's important to
> your workflow or not.

I frequently run `git worktree list` to review my work in each tree.
Or to choose an inactive tree for new work. Example output:

E:/product1  ea601b57e (detached HEAD)
E:/product2  b255bd1b6 [json]
E:/product3  0d7623530 [optimise]
E:/product4  7bf8297c7 (detached HEAD)
E:/product5  a8f89cabc (detached HEAD)
E:/product6  89a022651 [xml]

The more information the better -- highlighting the local workspace,
ref names when HEAD is detached:

  E:/product1  ea601b57e (detached HEAD, main)
  E:/product2  b255bd1b6 [json]
  E:/product3  0d7623530 [optimise]
* E:/product4  7bf8297c7 (detached HEAD)
  E:/product5  a8f89cabc (detached HEAD, origin/random)
  E:/product6  89a022651 [xml]

A verbose option with commit subjects and ahead-behind counts:

  E:/product1  ea601b57e (detached HEAD, main)           Articulate splines
  E:/product2  b255bd1b6 [json]                          [ahead 1]
Correct syntax error
  E:/product3  0d7623530 [optimise]                      Optimise algorithm
* E:/product4  7bf8297c7 (detached HEAD)                 Reformat doc
  E:/product5  a8f89cabc (detached HEAD, origin/random)  Seed random generator
  E:/product6  89a022651 [xml]                           Replace with XML
