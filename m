Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C03C28
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705640775; cv=none; b=UlmxEy5WkNbObHg738RArsUY2WSccneOIWMpH2Zsu7eoKKqO6fzMVozjWFiNUvlgEXOCfY5nkh/l1fzca35Bgse1sDEhGBbC2n8P+gLeRBtBgogwfz4AnS8dxJ06hXjKRu5NHriCVQvYH9mE5GBw8xsO/6FnoGgIQ52lm2MSADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705640775; c=relaxed/simple;
	bh=isCFCAbJ/tuzBE83j5rktMC55NxdrtROsa9w7M+IsX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjwBKb5qYG4JG1C0b6IKceHKqVIjrHYTvZ5OtcmeKmk3TQwW5T34oqkKrai12WBQUg/NIJVMUcL1+C5g1/P4ImXfbO03mfqdzlyfm7UX0zY2Iuzx89HfKSqxQReEwl51lz7SP1ifxi5psfq4ttugzfwQNumJMM8zhPY0IqEu1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCqf1ACR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCqf1ACR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cdebb968feso4795811fa.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 21:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705640772; x=1706245572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmJ1Q2ZsKeEd9v77WvEEsUg0IynbwMAhEeDFpRSZXOQ=;
        b=nCqf1ACRMDbHDie1ewSxUBpAzzivYKphwa+iBgndl9LfzUxSAJqDaK6pTyLsSX7TmV
         wUYYMoBQJHzVlMUEmy3YJ2eXl6XaFZeTQbDFy2i2c6qj1tMU4BgM9e+qyYfFf2Uu5ROq
         h+q0Vx+OxUOTGFyqsuitu29pQGxKV5AkrWZBgXBhdUsgle+hLTj4F+dA7S9jp0gREnY2
         EgFVElieQ+YfnMhgn0PSt6w9Sw4OzmMs5g2UHUDdXrFXmYJUyicsw2KshyrZM4GcOabT
         5vd/BNrLW0CvsyK8WsG5Fdkhkbk9TbNQ5Pi7b1BwjNIp2g2FP+JCeeZ2wwpWm6TZhIej
         1lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705640772; x=1706245572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmJ1Q2ZsKeEd9v77WvEEsUg0IynbwMAhEeDFpRSZXOQ=;
        b=AP9uFng2fq8Xu92TYEaI/6q1Ya6KuRtkwYhzQGE4uEv+Aa/jj8GsrM9nDuGVKNfjKt
         zRIQOT6AWDwbAwSoJgnrIsZaXbmW35DX010zCiDgIQZm/m2k4ENyAgKCku4D56qVLTWq
         Is2MWwM6Kj2xnlIplyR02F6MedEP2yJauiq51sAxXPfeNRHC3goJT3AtlGRi6CtILhDI
         ZDEo1eeKaV+2KKf2hInvzSabpemgouZf9dPSd58uJbvGnB7843BCUHHNB9H0uFyLIBFg
         BUKSvp/ycjjL6buWf+56RrocyyfvliLJRa4X4J9B/v4zutK2KZ/tbop+moa/7AaMN2rA
         /Stw==
X-Gm-Message-State: AOJu0Yy3oj1i0gSs1kjNBKGIdzzNmt+t8XXZcMm1fDdaFOwUiDOJ+qPY
	jcKc5wq0+uFzFTi31Eq3ugScmubZkIzdQEdkoynB1rVnnKWVO7z2pdnn4aZSJlAl2uD8J3Z15rg
	1r9wi/r61vIhwufTQZuweDdDICXqB2+tq
X-Google-Smtp-Source: AGHT+IFrawa+Nre3OqdDYhS0/JrlYiRX6nUooy7i3wJjjB/f2eYjKQu7TlJ5MpW/DMNZFEDk0hQ+XevfIAvT+SeimbM=
X-Received: by 2002:a2e:9dda:0:b0:2cd:ac63:feeb with SMTP id
 x26-20020a2e9dda000000b002cdac63feebmr991892ljj.35.1705640771746; Thu, 18 Jan
 2024 21:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
 <xmqqedenearc.fsf@gitster.g> <CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
 <xmqqil3x69dk.fsf@gitster.g> <CABPp-BEaYkAPphh06R1HrfD03WTv5uy-2q-T0ZMZaxo9hfXv-g@mail.gmail.com>
 <xmqqjzo6m37n.fsf@gitster.g>
In-Reply-To: <xmqqjzo6m37n.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 21:05:47 -0800
Message-ID: <CABPp-BHybPEg_+649fL6QrKjRQcJXxbYMFiQn0KxAgbr2Nz0Gg@mail.gmail.com>
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Heh, I was hoping that we should be able to use "diff --name-only".
> >>
> >>  $ git mv Makefile Breakfile
> >>  $ git diff --name-only -M HEAD
> >>  Breakfile
> >>  $ git reset --hard
> >>  $ git rm Makefile
> >>  $ >Breakfile && git add Breakfile
> >>  $ git diff --name-only -M HEAD
> >>  Breakfile
> >>  Makefile
> >>  $ git reset --hard
> >
> > I guess we could, since the only thing in this repository is a file
> > which is being renamed, and we can then deduce based on the setup that
> > the change we expected must have happened.
> >
> > However, I didn't like the deduce bit; since --name-only only lists
> > one of the two filenames and doesn't provide any hint that the change
> > involved is a rename, it felt to me like using --name-only would make
> > the test not really be a rename test.
>
> Hmph, I am not quite seeing what you are saying.  If the "mv" from
> Makefile to Breakfile in the above example is between preimage and
> postimage that are similar enough, then we will see "one" paths,
> i.e. the file in the "after" side of the diff.  But if the "mv" from
> Makefile to Breakfile involves too large a content change (like,
> say, going from 3800+ lines to an empty file, in the second example
> above), then because such a change from Makefile to Breakfile is too
> dissimilar, we do not judge it as "renamed" and show "two" paths.  I
> do not quite see where we need to "deduce".

You just wrote a very well worded paragraph going through the
reasoning involved to prove that a rename is involved.  You reasoned,
or deduced, the necessary conclusion quite well.  Sure, it might be a
simple deduction given the knowledge of the test setup, but it's still
a deduction.

But perhaps I can put it another way:  You can't just look at the
output of `diff --name-only` and say a rename was involved -- unless
you know the test setup and the previous operations.  In fact, how
about a possibly contrived alternate scenario: What if `git mv $1 $2`
had a bug where, after doing the expected work, it did the equivalent
of running `git checkout HEAD -- $1` at the end of its operation.
Then we'd see:

   $ <tweak Makefile slightly>
   $ git mv Makefile Breakfile
   $ git diff --name-only -M HEAD
   Breakfile

i.e. we get the same output as without the git-mv bug (note that
Makefile will not be listed since it is unmodified), but with the bug
in git-mv there definitely is no rename involved (since there's no
delete to pair with the addition of Breakfile).  As such, we'd still
pass the test despite there being no rename.  Sure, the example is
somewhat contrived, but I'm just saying that the --name-only output
doesn't actually test or prove that a rename occurred.  And since this
test, and all other tests in this particular testfile, are
specifically about renames, the fact that we aren't specifically
testing for something being renamed feels odd to me.

If you still like `diff --name-only` better anyway, that's fine and
I'll switch it.  I'm just stating why it seems suboptimal to me.
