Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470B364AE
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193962; cv=none; b=kKmX34X8ond5O4J79HGIqOK2/khXpQt1hX6+4Xf0Tr8k3ErUEu+Pfn7Nup3jkpxMBjWYCAgsqzm7Sy3EUE1gueO7Ha5OUgLPucD9Wp28nkkk0Hgb+X6J2ewwob56kq8jErUZAE/OiMezfUPZvSqquES1qP/t8BZp4vcXWcBTp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193962; c=relaxed/simple;
	bh=NoeR8Mgws7z3DHaT5lHcvbF+Wl0MpQV5mKEAxWoYx6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRYqFZOHdn3nI1jukdMJmsMjasy8LlkbkaTyoCD/TQ6UAEJ+cWDe7oHggEfs4wYz+ZA3zf7DuXjlUlDakfB/582Uo7Y2BYPl1ahWgqXNE74/NNj5imAxCHfx7k5DrvC4pAiwSXZ6LiBfTy+DYDBAgi6LhsuO84ahdGDJLDnim98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0ALUFlG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0ALUFlG"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso5513909e87.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 18:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733193958; x=1733798758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iZUGyZn4W0T5GmFJLU70gI0hc/XNsuXK6jzNNvAEHY=;
        b=m0ALUFlG4LJMyGnj+OmFJgHxmAHFyMsworBjbX2nwiib5w5a/j18zWG+bfsgonhwCM
         DqPO0XR+ht0xnSFQPuNFKkwl1ktow60OqTaRS48L9ICv/KA4m7MWidUTAxf4NBYaho2x
         SDLulJRcJLxWpAnB1+P/IWsm4q8/BJMQ+/x7V8k/W4rocvO4rzJo17CYvDBa//suTxEq
         J/Y+fcUo4vC25D4rGPabY99uhmpYZRUBjGJ3w1GwbnG/1+Fvt3A9yme2+eI8yOYGNoct
         DUaLa592FotOteAHa0nwwd0YbIO5XEHWcP/BX2xAl+QQyNVPih/WTepoMp8c3IzQ/GHA
         NcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733193958; x=1733798758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iZUGyZn4W0T5GmFJLU70gI0hc/XNsuXK6jzNNvAEHY=;
        b=xPQELFr1uK7osZskcZBrc+4ny6ZkXVaJIuDiqovB7pCGWE+UrnmzeYutOmVZZbNeFw
         0d51fSB5EJL57BmYv3UjGDXOBsF8KF94/dX6f/8H40SmcmYvOzsPovpFpcvX0qa6R/VC
         uOliE+psbDAAhfRtsJX7JMYrYTCVKCsCzVJlvvkjX7v4YNX4VaZEjEg0vSLoqdjXuLDa
         Yj6Q9DNKbCIcSNDAAhVHN48dogCjPwf0DqpOxmLteOtL3bYtzWLrcLrFZX3ExFDy9071
         Ohx4Zchsyz+/l4/6FdLqeYPDZN3Sicphb3FzXyWM/b5Z0yXqn59jjmwiJ7N7uYn4znvU
         dqVA==
X-Forwarded-Encrypted: i=1; AJvYcCX5V7q0yNk8gU5z5IQedP7TYerd/QPAqnC7hUDuyqTSUBp+4aj4rGl/7PxsN+XB92P44CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHd+chllOdtg45jsKGw6r2vAZMhzkDqDZ+H56tsu2XS3w7djJm
	4if3SJH2fFAT4PKWI6IbpbGr1jun9TLYT/11lSxgdNYVLnLcXQ3YYGLLL+3leHgs2ApSfR5gCH6
	4DS6fejB52DOHmBW50QKsIwpJRDku/m4/
X-Gm-Gg: ASbGnctBUCBDO/tvGYtusfcf+NidkhIzYoLXmQW2U7e4O6Oe1xwkgWFIn878Srgk7rZ
	MRZMjuVHcxpqNENVmIiPDpXNUemkV8pep
X-Google-Smtp-Source: AGHT+IFnirLPxWd5i1d7B1PPE9Gsbu7HNfRlHE/8gf8e1aabiUD26IJyAz+1o8RhEM5jtnrC6iPM8R2SYyW6DAIMLDg=
X-Received: by 2002:a05:6512:1154:b0:53d:cf93:8072 with SMTP id
 2adb3069b0e04-53e12a2e4ffmr454984e87.38.1733193957940; Mon, 02 Dec 2024
 18:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFePT4zytyuLB0TgyJ+mbrNvz=Xt1x+gJv4e-2j07YK7Cg1bzw@mail.gmail.com>
 <CAPx1Gve_dCRux9_cF7NTspomS4K=Hp_y74d94S-Hm0amuovUqQ@mail.gmail.com> <xmqqser5h9c6.fsf@gitster.g>
In-Reply-To: <xmqqser5h9c6.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 2 Dec 2024 18:45:46 -0800
Message-ID: <CAPx1GveJYiMAVLmv1A9-K0Ok54cio5aAqFnULZJ3--GGBnu69Q@mail.gmail.com>
Subject: Re: How to revert to a specific commit?
To: Junio C Hamano <gitster@pobox.com>
Cc: tao lv <thebookofunknowable@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> While [Torek's sequence of commands] would _work_ in the  sense
> that you can revert the effect of what the discarded commits
> did, I would not recommend any of the above since it does not
> leave any record of what you discarded.

[alternate method with `git merge -s ours --no-ff` snipped, but note
that it will do this:]

>  - Record the discarded history (i.e. master@{1}) as the side branch
>    of the resulting history.

This is a good point and illustrates the key issue I left out.. I was
describing (and kind of deliberately hammering on, for teaching
purposes) the fact that every commit node in the commit graph
records the _full state of all files_ as of that particular commit.
Hence if the only thing you care about is "state of files", that's
also the only part of a commit that matters.

But commits do one other thing, in addition to the usual housekeeping
work of remembering who made them and when and a log message.
That specific other thing is: each commit remembers a list[1] of
_previous commits_, and stringing this commit up after its
predecessor(s) is what produces "history".

That is, Git does not _store_ history (specifically, history of files).
Instead, it stores the _information needed to discover history
any time you wish to discover it_. The list-of-previous commits
is how this works. Using a merge allows you to store a list of
_two or more_ previous commits. The _first_ entry in this list,
which is often the only entry, is what we think of as "the immediate
previous commit", and following this list-of-first-entries gives you
the history of what happened to each file.

Second (and additional) list entries, if present, help you figure
out _how_ you got this particular version of every file in this
particular commit, in the usual merge cases. In unusual cases
(such as Junio's method here) it can help you figure out what
you deliberately left behind, and the fact that the new commit is
a merge commit -- a commit with two or more parents, instead
of just one -- is a clue that something out of the ordinary
occurred.

[1] I say "list" instead of "set" here because order matters:
the first entry is special. "Set" would also imply de-duplication.
While the list entries don't normally contain any duplicates,
there's nothing in the machinery to prevent them. What (if
anything) such duplicates might mean -- well, that's up to you.

Chris
