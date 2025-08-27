Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33122356B9
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294490; cv=none; b=CTtaUxDbatMvputTVL4TKSd0/51M56zMqNHvCUkM4OdRbn+vsJJ5bBWkJOoQnGXIdyobu2IhUHRBm20ZVave1XxeN7bjOlVUzqgmbv76AOxWB1Z+6fSpulISRwlxp1luDQek0OHPgaGZLfSeCQZnwADx0v1xfiTH4+ydD5CULHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294490; c=relaxed/simple;
	bh=i0wWs/f8JC9bWnUGXTXQ3SXfUswxKpNS+IVTwSHePzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWnr8CJGIZucjqDEG6kOTrQ8Ir+O6YBxhoATtq+CHRMPh0tS0R0K+0gIWPg8fSAgvatpYrTf0imqKkSnXLjBmT6XMSU35Zf7jEQQ+BQn41N/GVHPUBDuoiTXgyq3W3c+iosl/zVTPEgGQxRusHtERhWGlKd23m73WyULTkkiSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f90JP5Ej; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f90JP5Ej"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-246257e49c8so177335ad.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756294487; x=1756899287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4CPRfD5it78as68dGYYUFYQA/ESItdiXehrBLCOi5w=;
        b=f90JP5Ej3VHZcv1iwrKK644+mcEsm9tm0wibLwSu/4wAQche4Dh7gIk8PD73kntlEg
         7Wyf1vF6vz7EO6IIwrFhB9qx08QIK39YsqBVKZlj/WAWykClBGdJLk9vx8+dcz3dIjmX
         MZXmlBfpMaPs9tlfnflJ5lPjLrLdY0nnpP2cBXYJ2bidsHaamzhiM3FxsrzMNWoEgjmz
         Ebv8RTb4YVxN4TIGEg4rc96MoZUBEFeKQJS4BePYMyiDV5luOZE5TDO6ch+KqtgZ3KJD
         nXR76VF+ksmKRKMDTOwgOXtvMGY52CkTS9g4r5Z6NQYeL82VXiXgEUeTGT81JQqQdIW3
         pG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294487; x=1756899287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4CPRfD5it78as68dGYYUFYQA/ESItdiXehrBLCOi5w=;
        b=IffDy+E5e212bEeWyzTl5dVRqQc6pxB5+DTnWvIHtM5RL20GoHKfZZLGLG0UlG63DM
         GzTDtPnZskCQNoP2i8Cna27YtRrOcNh0Kp+2MrXROcBCpGDkEMC7JbyCr7NhwslYN6M1
         API8qbIkun9NtjKHTUpaPYk5ZqeUOzE5RINLQlB3av/sZs+Etf7CurqddKn7Q+VhSTMx
         RiY46OyIHfYlVsNg4jRteA7uJDGEMC7uC54CJpxdlVv+wqsSjaYPzzcJQl7GROXzGzoq
         JMzMjKw2WzeQ5V1ShO/ucGYumrBT//VX88DUg013ZXeKpvtlPabJ0xbTgnN/tFwaDmGM
         PgFA==
X-Forwarded-Encrypted: i=1; AJvYcCWYC1NgpoUaoRbitajRlsA+wRjKA64C2qpaVvzuA0PAKfwfTA5ib3hswRxlAC3LqrVnI/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfNECdzr38w8B9EY767Py41VbBeFmYdHrL53FPaayGJlgIejH
	nrEhcW9cvyondAlmXvjyTdZMiWQo7FESsNdyz5cNQtDr3aGcDBt/HN99tGCMLF0qV7o+qUhT1ZW
	b9E35E5jJQAmETZYp8qJyZ+7jADCU8/EmRUCUUautUZbDlMOE+yjhYs6SCB8=
X-Gm-Gg: ASbGncuqZlEFyQWeaDzN6QOsHe362mWHH3/LLF7/Kj4mNQYZOVpWUcVAiylHr6v1k3S
	3f+LGV5tLkpof4sBR4Sq/ZGD/fF2LJqEVmN/b/BrXZH0iODHB2EDdxZsF2PIzlxFItPFSiB8bUH
	p+VCQpyh2AKAMSRGFDcxm+IQS8MolF1J6y4MTqu4sy8nY6uZXI9fpLuUUxbmNq6QIyoEqyCqG1x
	Nk1jNo8sKkfn2/flk9AfrEDpmgrUik3w/KsXw==
X-Google-Smtp-Source: AGHT+IFUCoaFoimiE+5WttCtYrqbKy2cPhdf97l+JUtPv3ov3MDG0ZnNbLS9cw+scOI9Nx97cW6uqHypchJFBwJv9mM=
X-Received: by 2002:a17:902:dace:b0:240:589e:c8c9 with SMTP id
 d9443c01a7336-2485ba3d846mr8292225ad.10.1756294486572; Wed, 27 Aug 2025
 04:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
 <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com> <c856cecb-ab70-4c43-a952-cf0350c7949b@gmail.com>
In-Reply-To: <c856cecb-ab70-4c43-a952-cf0350c7949b@gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 27 Aug 2025 13:34:31 +0200
X-Gm-Features: Ac12FXwjJSNEAOgsEs_Wf-9rtSc2iYWWN8Tj9vyRnnvc6isndfr8bWceWXKmaD8
Message-ID: <CAJoAoZmEX8_cOGByD1sfRimNxkuY8Dqq9x3XvQ3SuoLD8aO79Q@mail.gmail.com>
Subject: Re: [PATCH v2] doc: document rev-list opts in revert, cherry-pick
To: phillip.wood@dunelm.org.uk
Cc: Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Andrew Jeffrey <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:41=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Emily
>
> On 27/08/2025 08:22, Emily Shaffer via GitGitGadget wrote:
> > From: Emily Shaffer <emilyshaffer@google.com>
> >
> > In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
> > we added a handful of new options to `git revert` and `git cherry-pick`=
,
> > but did not document them except by example to `cherry-pick` only. We
> > have a nice shorthand for adding the rev-list documentation, so let's
> > add it now, to both commands.
>
> I agree that it would be helpful to have a some rev-list options
> included here but this adds a huge amount of text to the man page which
> comes before the documentation for frequently used options like
> "--continue". I'm not sure all of the new text is relevant to
> cherry-pick and revert. For instance do we need to document --bisect,
> -cherry-mark and --boundary here? I'm not sure the History
> Simplification and Commit Formatting sections are relevant either. There
> are already a bunch of ifdefs in rev-list-options.adoc that change
> what's included depending on which command we're documenting, maybe we
> should add some more for the cherry-pick and revert documentation?

I thought too that the rev-list-options.adoc is probably longer than
it needs to be for most of the places where we include it. I wonder if
it's worth breaking that inclusion into smaller, more relevant parts?

Full disclosure, if that's the solution we want to go with, it will
take much longer for me to address it than for someone else to,
although I'm interested.

 - Emily

>
> Thanks
>
> Phillip> Reported-by: Andrew Jeffrey <andrew@aj.id.au>
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >      cherry-pick: document rev-list options
> >
> >      Ach, sorry for the noise, turns out it touched both revert and
> >      cherry-pick, might as well do the docs for both.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2=
042%2Fnasamuffin%2Fcherry-pick-docs-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2042=
/nasamuffin/cherry-pick-docs-v2
> > Pull-Request: https://github.com/git/git/pull/2042
> >
> > Range-diff vs v1:
> >
> >   1:  fa352ccda08 ! 1:  f41cb4e8abc cherry-pick: document rev-list opti=
ons
> >       @@ Metadata
> >        Author: Emily Shaffer <emilyshaffer@google.com>
> >
> >         ## Commit message ##
> >       -    cherry-pick: document rev-list options
> >       +    doc: document rev-list opts in revert, cherry-pick
> >
> >            In f873a273d1 (revert: accept arbitrary rev-list options, 20=
10-06-14),
> >       -    we added a handful of new options to `git cherry-pick`, but =
did not
> >       -    document them except by example. We have a nice shorthand fo=
r adding the
> >       -    rev-list documentation, so let's add it now.
> >       +    we added a handful of new options to `git revert` and `git c=
herry-pick`,
> >       +    but did not document them except by example to `cherry-pick`=
 only. We
> >       +    have a nice shorthand for adding the rev-list documentation,=
 so let's
> >       +    add it now, to both commands.
> >
> >            Reported-by: Andrew Jeffrey <andrew@aj.id.au>
> >            Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> >       @@ Documentation/git-cherry-pick.adoc: fail unless one of `--empt=
y=3Dkeep` or `--allo
> >         SEQUENCER SUBCOMMANDS
> >         ---------------------
> >         include::sequencer.adoc[]
> >       +
> >       + ## Documentation/git-revert.adoc ##
> >       +@@ Documentation/git-revert.adoc: include::rerere-options.adoc[]
> >       +       configuration variable can be used to enable this option =
by
> >       +       default.
> >       +
> >       ++include::rev-list-options.adoc[]
> >       +
> >       + SEQUENCER SUBCOMMANDS
> >       + ---------------------
> >
> >
> >   Documentation/git-cherry-pick.adoc | 2 ++
> >   Documentation/git-revert.adoc      | 1 +
> >   2 files changed, 3 insertions(+)
> >
> > diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-che=
rry-pick.adoc
> > index 42b41923d5f..03848aa9f21 100644
> > --- a/Documentation/git-cherry-pick.adoc
> > +++ b/Documentation/git-cherry-pick.adoc
> > @@ -174,6 +174,8 @@ fail unless one of `--empty=3Dkeep` or `--allow-emp=
ty` are specified.
> >
> >   include::rerere-options.adoc[]
> >
> > +include::rev-list-options.adoc[]
> > +
> >   SEQUENCER SUBCOMMANDS
> >   ---------------------
> >   include::sequencer.adoc[]
> > diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.a=
doc
> > index ffba365e639..28827807473 100644
> > --- a/Documentation/git-revert.adoc
> > +++ b/Documentation/git-revert.adoc
> > @@ -122,6 +122,7 @@ include::rerere-options.adoc[]
> >       configuration variable can be used to enable this option by
> >       default.
> >
> > +include::rev-list-options.adoc[]
> >
> >   SEQUENCER SUBCOMMANDS
> >   ---------------------
> >
> > base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
>
