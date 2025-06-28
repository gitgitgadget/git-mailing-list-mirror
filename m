Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D81AF0B5
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751121208; cv=none; b=sIZIBRX45qnIg3+K3cFsYIiFPhEzcDQRAFmJ43bOPQcuGzcaGO1KE2wQJO+njmAgz5a3CCWGjuV8bCExYdJlacc3/gG47pmJ4mLnx2YEZgNslYHyBtniil2sS3K0zxhwKjaEE4lTr6Z/ufzf67/o1qsBOInVdyTyqtosxtrAbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751121208; c=relaxed/simple;
	bh=NOeB3BppgkN08Ozg4l3gSCcZaxZoodU/poZkUYkIjM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8O0Oq0jptpr435V98k7rnoRPVr8nAo1deNncIg3ehoxEt0BGA4zfJ8bJ7F++aHNVChQyQGaqw+ePfrlP2kGdI1yxQu82QVxt6ndR88rawsWSge5a+xQARgfxvJ+xcDKx8c33mPR55HYMNu2VAN4Tn6r/mIhBMoQWhUhhmiJkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2DMwNDM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2DMwNDM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235d6de331fso6275285ad.3
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751121204; x=1751726004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oHNVPBQMuENhDJQ/1ksugvVfevO/dmmWreIR35Z3Tg=;
        b=B2DMwNDMsZejwEkHoWBiSbE2C3zXwHzjohuInPHd63YUnHNEFBIhZUVbKhNQ+hqLXZ
         /IHPpmeGGYifQ4yC/hTUQnJbIhCZ9lOgWojg03zzFrTWqKTFx/GV7Q0vGi1E4J4DBRBQ
         /22b3PUt6Q0fTwqa+BLJUZ3UsmKBOA+B8JwBUu7gNaRGtaacGXUJdvT/QBX4rz5DM7G9
         SSak/nSxZu7BVb/Nry0jYDMpcXRvdtAsdg13h2GvNyR1HT7S51ms+dpa9lQ8HU6BE4/g
         9d3Mm80eRVZQTtJL6u2HqlJX3OS5iixUpewo7tnrF2A20o1mIrp95BFK/S43VUcpC6gc
         QCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751121204; x=1751726004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oHNVPBQMuENhDJQ/1ksugvVfevO/dmmWreIR35Z3Tg=;
        b=NAMDUMOG4HY9Qd0kaViBceDqkK6sMAX+61kTYU4poK2646EMF1SGgSGY5w+9mtIeBv
         HwvIVR51YfCrZ0jCcwTv35SVMyYQUobUejQaI6K5hfgUECUALFalXKfSQ18ZS+uAaalG
         UjfiPPsktQtM/cSDyIbPSRLHphvzQWMgCN1/zUSqJWHisKcQZNlX1QGDf3jAcJ2MLfcN
         JE2/xtbntwLmdjA19hUnSH/RBq1uGVS0jiLIs9kKGYWVQMEamq9zWtx2zEjoL8L7Bz34
         io09ClhERRBgJf1N6WGbTp3B8B5Fh56dST1O0zSoq6Ptkb4BtIWQWiKgYe4mL5Xusxga
         2VOg==
X-Forwarded-Encrypted: i=1; AJvYcCVqPzB+iNyuIdgGMx1TeZve16wMRA1YI+YzI4OjlzEq9JJWyBq3NSRVfo7JElG83+6zY2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTqNVTQ8ofRhKXJ7dsrLSciJ3kBuz2UkY8kE9LcJPsFdEGiH6
	o4/jZ26bOXmuzXs0xE8B6cnJxsH75iSj4/zEQc9UQkhYUiZLhxzToMC3DZ42zfyOKZQ3BAjue8P
	NR/aakH6jIQk7ccXKO79sfvQ4/DcGa9kJsOl6OlpU9Q==
X-Gm-Gg: ASbGncvVNAGCTAVDQAe7fIMfpHgGvAqH9py2ydEPxn5Ot42tOGwKlgJXQIz9qO71Jzc
	A8HN9yHDCZ/b8l/Ze0+mh1wV/MGOfCwE0qOidi3OwGfDyIVpqRXSCTH87lnMQpJ0FrDKeg16xZB
	xdbsjZIlrA97guD9J4EYRVMxAFDKvworWSRflBQZrfMezF5J7oLJc+l4Tlb8hnboRDX6QKpRvHF
	SX0lA==
X-Google-Smtp-Source: AGHT+IH4rCJ1jnYZlkAhqM6bgWDOK/mb1bQMh5U8WM6vAfJY8DC8qzj/pM7NT1cK089iwFA7kLGFfcAlcazIF+9yL0o=
X-Received: by 2002:a17:903:240b:b0:234:d778:13fa with SMTP id
 d9443c01a7336-23ac46067a7mr116552115ad.26.1751121203811; Sat, 28 Jun 2025
 07:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com> <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
 <xmqqms9t8cfd.fsf@gitster.g> <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
In-Reply-To: <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 28 Jun 2025 20:03:12 +0530
X-Gm-Features: Ac12FXz7SUJIvIkzS0EY6kBSKLPPkjtFr9fAtz2qz8JMAmG1yUGVtXUZmMwwL-E
Message-ID: <CAE7as+aUcd65vPwwRh_C89vQbMjKQh0Y6LF7WDq1Whyj6iYfLg@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, git@vger.kernel.org, 
	shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 7:08=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 27/06/2025 15:52, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >>> +   size_t cutoff;
> >>> +
> >>> +   /* Ignore comment chars in trailing comments (e.g., Conflicts:) *=
/
> >>> +   cutoff =3D sb->len - ignored_log_message_bytes(sb->buf, sb->len);
> >>
> >> This finds the "Conflicts:" line. I was surprised to see that the
> >> string it looks for is hard coded and not translated, however the
> >> sequencer (also surprisingly) does not translate that message either
> >> so it should work.
> >
> > There is a funny chicken-and-egg problem, though.  It limits the
> > search for "Conflicts" by using wt_status_locate_end() based on the
> > current value of comment_line_str.  When core.commentstring is set
> > to "auto", the code that reads the configuration does not touch the
> > comment_line_str variable, which is initialized to '#'.  So
> >
> >       [core]
> >           commentstring =3D '%'
> >           commentstring =3D auto
> >
> > would have '%' in comment_line_str upon entering this codepath, let
> > wt_status_locate_end() use '%' as the comment string to find the end
> > of the log message, and then looks for "Conflicts:" in the result.
> >
> > Which may or may not be what you want.
>
> Oh, good point - I'd not looked at the config parsing. So we'd create
> conflict comments that look like
>
>      % Conflicts:
>      %    some-file.c
>
> but so long as the commit message did not contain a '#' character [1]
> "git commit" would select '#' as the automatic comment char and our
> conflicts lines would not be treated as a comment.
>
> Should we be resetting comment_line_str to '#' when core.commentString
> is set to "auto"? That wont help if the commit message contains a '#'
> but at least it would be consistently broken.
>
> We could move adjust_comment_line_char() into libgit.a, use that to
> select the comment character used in append_conflicts_hint() and set
> core.commentString to that character when we run "git commit". I think
> doing that would mean that appending conflict comments would always work
> with core.commentString=3Dauto but it is a more complex solution as we
> would need to remember the comment character and then pass it to git
> commit once the user had fixed the conflicts.
>

So, my GSoC project is refactoring in order to reduce the global state
in Git. I was trying to remove the global variables related to comment
characters. What I tried is to create one single function which
returns the comment string, and we could then pass a strbuf in case of
core.commentString=3Dauto. You can check my attempts on my fork here [2]
(check repo_get_comment_line_str() in config.c), and also mentioned
this in my blog [3]. I thought I had it figured out, but turns out I
failed one test where core.commentString=3Dauto. It was that moment I
realised that I would need to remember the comment character or the
strbuf in functions. Just wanted to share this in case anything
strikes you when looking at the approach.

> One final note - although the commit message mentions a change to "git
> rebase" I think this problem already affected cherry-pick, revert and
> merge before that change. In practice I suspect it is only cherry-pick
> where one is likely to see this problem because the template messages
> for the other two commands are unlikely to contain a '#'.
>
> Thanks
>
> Phillip
>
> [1] For some reason adjust_comment_line_char() will not select '#' as
> the comment char if it occurs anywhere in the message but the other
> candidates are selected so long as they are not the first character on
> any line.

Thanks:)

[2] : https://github.com/ayu-ch/git/commits/comment-line-str-4
[3] : https://ayu-ch.github.io/2025/06/09/gsoc-week-1.html
