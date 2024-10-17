Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A811D0496
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199829; cv=none; b=jrVSyyF0AJ4iMYMYQzsimKCWfrTIkwOyVxOCsMqnrgmmTvmdLD4WjYp9HlIas1VkbgoIfh5REqYLQCfgBcmMlDycYJex15476DNilWG3MFiwoIJETAJrWaPVuqeNpphtvFQAG3zJncm+5CDPdRtbK5SvCSN0KuUaiU5lIMRlSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199829; c=relaxed/simple;
	bh=Cjz3qJ+1bvgQ4Z1yhyDt2VGH5WD6xp92A8cHsPXrNhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImnzJIV1U6NV9gRF7Yt0FrTvv2QEt8phl/9MUo4m0OC4XBtRJUN93B3aYlbSzTVWr8JnYhz02I/YVwVtwGsAR0eQr9h4iz1SYMCpEU5pWlSGI3Vmr9clzeDP2qbOu5+NLJOcvbfPt2rBY7OePPHttWxolgXMMOgAJWa3RDFZdUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHYiqQuN; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHYiqQuN"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3a380fd55so5597375ab.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729199823; x=1729804623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IekU0Rz+Q4LEYsVbwfmUj3mreI6HYxU5riYkcT0hOM=;
        b=fHYiqQuNOQmnWcWR2jT6385mwrHNHeitOPZt0MYlaTZ5zDGx8RhfGTtnd1VBbnd+xE
         kulrCvewP8M4caUjBMr8z4r3+0EzzZjtC22Wc1yMN5RC+5L8dcF6x2JMYEvGOV7my+SX
         DUABcpxlwqDWXcIYrIf2rxdkxzDKbQrddJRznKP+uOyUAxFgo4BLaKp5Dy2CyEAtZnkV
         fHaGTJhiDatIY86kjIENuZdoxJagRGFOpeqXpinfCIp0ZY/plHIMIzlFdA2Mu1yqb0li
         +ocA8kBrlqbHK5lXxub80xSZdgJwdY0nw73cS4V34+x5DUxos8HON0JvpQNVp4wFucmk
         r+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199823; x=1729804623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IekU0Rz+Q4LEYsVbwfmUj3mreI6HYxU5riYkcT0hOM=;
        b=VCwamuQGPC7xnW20npl+K2LSP/qAtN6kuMeTCdM9n5czEpHvZASOpg2BYBngvVaE54
         pCR7hFVbe/axVR58+ezOF6tvErTcBIoWSK0c00B47T/z1Fswarr/4i2nXI03+e8DrdiV
         q+umyJYui1EV0lemdSAPaRTsCZ0Np7jqTp5khMWaH/NpMe3LACRCFFx1MbQwpwx9Aq7O
         PZYeSQq3T5uBqs5D+oTMHfTUGel5Tss9LNBQXJMeJLZlMPKnn1q2D3WmyygJOLnMu/dS
         9Dw0k9Ai5sEVUx0b26jSzK3rduFkGUn+v6EvcfMbWtyVTF5s3WIhWJYghXCPNO3wX2uk
         GKxw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ghyh6nkHQBYwL2P2i5+jllDPJE9AA38jFLKATAggSul4ZzwXspbUdduS8KgU46b9Dwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJ2Zjt/bGn9XZoEXOz8jxYOVfn+dtq3Kt3LoI46eGley+vyi7
	GWflM/LjZ289aIiyjlMW+vKD4c8d1+8nJgCNucUyZsiFxQfhj6YMulPPiEQzOYhvl0Xrp74EosY
	x4xSnW71yBD/pIMwWKNRNvjvoems=
X-Google-Smtp-Source: AGHT+IFp0EGAsh44WIENpbD2o2guburZGmXLBuaqGIx57cRYBieHlxRJG0RvuFGTiSJOfx+DI+kVwj1zLpoXcEZ5ofM=
X-Received: by 2002:a05:6e02:18c7:b0:3a3:9792:e9f5 with SMTP id
 e9e14a558f8ab-3a3f4050105mr2221575ab.5.1729199823105; Thu, 17 Oct 2024
 14:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local> <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
 <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
 <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com>
 <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com> <ZxAjz28QLwWlDVg1@nand.local>
In-Reply-To: <ZxAjz28QLwWlDVg1@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 17 Oct 2024 14:16:51 -0700
Message-ID: <CABPp-BG6kYvx_EDRUfTUtcPrpnDT=FyAMDVXrQVyVJF5Rdj_tw@mail.gmail.com>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Taylor Blau <me@ttaylorr.com>
Cc: phillip.wood@dunelm.org.uk, Eric Sunshine <sunshine@sunshineco.com>, 
	David Moberg <kaddkaka@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:36=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Oct 16, 2024 at 10:15:49AM +0100, Phillip Wood wrote:
> > On 15/10/2024 21:01, Eric Sunshine wrote:
> > > On Tue, Oct 15, 2024 at 2:55=E2=80=AFPM David Moberg <kaddkaka@gmail.=
com> wrote:
> > > > Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshin=
eco.com>:
> > > > > This looks like unintentional behavior; probably a bug. It seems =
to be
> > > > > triggered by `git rebase -i` setting GIT_DIR. Here's an even simp=
ler
> > > > > reproduction recipe:
> > > > >
> > > > >      % git init foo
> > > > >      % cd foo
> > > > >      % mkdir dir
> > > > >      % echo foo >dir/file
> > > > >      % git add dir/file
> > > > >      % git commit -m foo
> > > > >      % git worktree add ../bar
> > > > >      % cd ../bar
> > > > >      % git -C dir rev-parse --show-toplevel
> > > > >      /.../bar
> > > > >      % GIT_DIR=3D../../foo/.git/worktrees/bar \
> > > > >          git -C dir rev-parse --show-toplevel
> > > > >      /.../bar/dir
> > > > >
> > > > > The `git rev-parse --show-toplevel` invocation with GIT_DIR set i=
s
> > > > > incorrectly returning `/.../bar/dir` rather than `/.../bar`.
> > > >
> > > > Thanks, that is indeed a much smaller example and it seems to exhib=
it
> > > > the same issue. Can we figure out how to fix it?
> > >
> > > Someone is going to have to dig into the code, but my Git time is ver=
y
> > > limited right now, so perhaps someone else can do the digging.
> >
> > I'm about to go off the list until the 29th so I wont be working on it =
soon
> > either but I think the problem is that git sets $GIT_DIR when it is run=
 from
> > a linked worktree. I've reproduced the commit message from ff5b7913f0a
> > (sequencer, stash: fix running from worktree subdir, 2022-01-26) below =
which
> > I think explains the problem we're seeing here. Unfortunately the appro=
ach
> > of setting $GIT_WORK_TREE used in that commit won't work for exec comma=
nds
> > as they may be run in a different worktree. Naively I feel that if
> > setup_git_directory() has found ".git" then any git subprocesses run in=
 the
> > worktree should also be able to find ".git" and so it should not be set=
ting
> > $GIT_DIR but there maybe there is some subtlety I'm missing
>
> Let's see if that commit's author Elijah (CC'd) has any other thoughts.
>
> Thanks,
> Taylor

My commit merely pointed out that long before that commit came along,
if GIT_DIR is set but GIT_WORK_TREE is not, then the working tree is
assumed to be ".".  As such, a command like the above where
`--show-toplevel` is run with just GIT_DIR set (to anything) will
merely expand "." and show you that path.

If you are going to be having subprocesses that depend upon the git
directory and the git working tree, I think there are two options:
  * Set GIT_WORK_TREE in addition to GIT_DIR (as my patch does in certain c=
ases)
  * Stop setting GIT_DIR if you're not going to set GIT_WORK_TREE

The second point is a bit harder since setup.c automatically sets
GIT_DIR for you in various cases, so if you want to go that route it
really means you'd have to actively unset GIT_DIR in those cases.
But, you'd have to be careful since you only want to unset it when
setup_discovered_git_dir() sets it for you, not when the user who
invoked your command had manually set GIT_DIR.  So, there is a little
bit of a pickle here...
