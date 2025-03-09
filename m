Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507A19048A
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514366; cv=none; b=bOqP5FDtSA99EWqc14Q3D72XmcE1Pl7cHilW4opluKoVUirKoasMJgvxv7D/wdatJCWYdSxH6bWBodmItW28hhPs/gfIW4oVs7p7aqncAKGvo+A39orfWeCUX5xoUWm/1P30vEoHFklbsO9WiBSW4Cuh1FW9LA4ABVsKhN4875w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514366; c=relaxed/simple;
	bh=sXQfwMWT1EWmRjvFgGWqmpNXvKyYGe8kXgzFAOXy1Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVC2tOyb1rZJ+9YZECkT6dvop8DdYxJTVZBsRxofaWd42Eaajhnb1P4+P67PhdD5JNUhJ5py7ooN8vQXTyvH8ylR91h4w3fi2aDNF0SSgIxazqxo1ccdYt+yhX1q3e15qiGGcry2iQdW039u7fNa4TSTbMCyAiBB8U97BV8wJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abVR0N+l; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abVR0N+l"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476805acddaso3475621cf.1
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 01:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741514363; x=1742119163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mguldxfhdg2vaMIL1qUjI0xEgPgc157LchVQn2wm6Y=;
        b=abVR0N+lzUBRywt47P640DdHDuEBiXwrChp06cs/gOHw/HW4P24piJjHxKYgBBzaGk
         SflDueNmfPABMZJ7l8oanHzOvxddFb4yjNNUsaNjM448M5smyGZF8fiR0Eajrg6ZU1dQ
         ySgP71gHGoLwztqreeH+y0bdV7nO+4WK0SeX0kq4Ht4sm9sAdvvwLJM0wbyibayDCvOY
         3Mvj1PMVS7Q7pqmgB+F9eCKkrukwJO6xhzAD5EL7VWcK/izNvcjMllfTQjmBKCI3m3E8
         1gMo1alwt0MlSrxMSr+9sdlsPK1iKSMMIBQ5RjRwWD7DG2nKndFCXEFrAcTCi3LQaCUb
         Iq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741514363; x=1742119163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mguldxfhdg2vaMIL1qUjI0xEgPgc157LchVQn2wm6Y=;
        b=spOerulwr7tv0hRnzBuMJNRdwjl3dLOiomNdbfMgBocxk0ZVs7ObIN7bGKW2VqRII1
         w8qcWHojJ+xVEoo+bMrqwTfxi3LWlY8jWrb9ESYLnVhmYW2I/0e5WC+RROICGPt3E+M/
         LjABQy8Gn6g/khb4qLvpZWAMwtagLCGyIiWqfMOJRySI8hXDlFdg88ruJF4HFOUeQ1vH
         WV/23fyRLxaA18q61V8sHStTSVYRzMG03mEl24BZnRGeUPxk8r4rP+wwdYFiy4pZNmKY
         /8Got6+tRvCkd6lanyN+49XfXuUH5WpSZR9jRrRAy8MzIQzanXF7TBiwkthHjg0OERqa
         KnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdRPPLLo4gxt3/wIFJfdI2DOMiztyXI+ZWkG4oy2hw4NKaPfzNT120X7FoWlprNLkeqzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bMih0GdsBC8/Rr3p+Ij3UJc6Ty7snZhY70QqU7LYIbBXVAj+
	t98EUrGW4h1c65wJ6hGdPyg4TXUCr4nJJCNdUlrSOMc+1ofb+9lR+R5h0IKjin5JREvCihnCUv6
	quo0WkWYlNvDUkVlSlgNdJSqrqo/wAkFBJuH7bQ==
X-Gm-Gg: ASbGncuqhmLzgolGgC5YQYrwKINteJHuczW5xVKe+tOVn28oqJHzJu1+bO6bFPqoq6U
	9exs6dTC55XKAq7C7Y7MceElfSvTsjpjvApNacH4OB2LjqPXcsl0ik4SEUkc7kDEH+1DzhJHKy5
	75L1jVJmA6VKiF4kRHGTeVLcofAn6kiuvc65+xvnI+lGONVyPXf5pfgvOaDhUMdAIOHrhN0g==
X-Google-Smtp-Source: AGHT+IGqlUba1hlAPbpYMMnk+JiGODdIgkuzjoDZwZvVFjdk0I4YbG8ub2hMIYzlZsBQpyqxkQUSsGLbjF21wJzqDIU=
X-Received: by 2002:a05:622a:41cb:b0:476:6b20:2cea with SMTP id
 d75a77b69052e-4766b20410bmr60831121cf.39.1741514363267; Sun, 09 Mar 2025
 01:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
 <CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com> <xmqqo6ybb48p.fsf@gitster.g>
In-Reply-To: <xmqqo6ybb48p.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 9 Mar 2025 15:29:11 +0530
X-Gm-Features: AQ5f1JpUKVbYPxug-tCTgWvzL6imU1JPX49o3Nygw68MeuBGxI8MWlkMwXYpvxg
Message-ID: <CA+rGoLfTJSHQZTvNBgfcMmGjJwqak+wGHh9PRhHfqHSxB2p6-g@mail.gmail.com>
Subject: Re: [GSoC] Microproject: Updating Documentation
To: Junio C Hamano <gitster@pobox.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Junio and Mahendra, Thanks for your responses, they=E2=80=99ve been sup=
er
helpful in guiding me as a new contributor!

On Sun, Mar 9, 2025 at 2:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Mahendra Dani <danimahendra0904@gmail.com> writes:
>
> > I'd suggest trying to submit a microproject listed in [1]. Further,
> > please go through the General Microproject Information[2] and
> > MyFirstContribution[3].
>

I've gone through the links posted by Mahendra and read the micro
projects list too.
I've also explored that we as students can have our own idea as long
as it doesn't get too involved.
These emails actually cleared up a lot about how microprojects are evaluate=
d

> All good suggestions, but we also welcome students who try to
> scratch their own itch, as long as it is small enough to be suitable
> as a microproject material.  And it is fine to ask if doing X
> qualifies as a microproject or if it is too involved.
>
> The primary objective for a micro-project is to get used to the
> workflow, i.e. working with the community mainly via this mailing
> list, how you explain your changes in your proposed commit log
> message, how to work with those who gave you reviews, how your
> updated submission should look like, etc., etc.  Given that, it is
> rare that anything is too trivial as a microproject material, but
> you would not want to choose something too involved, as it would
> slow you down in learning the procedure, which is the main focus on
> the microproject period.
>

This really helps set expectations as learning the workflow is my main
goal here, so I=E2=80=99ve picked small fixes that I think will help me get
familiar with the process.

> Another thing I noticed in the original message that is worth
> reacting is that you do not need to ask for permission to start
> working on anything around here.  "Am I allowed to do X for my
> microproject" is not the question you want to ask; rather "I see
> document X says A, B, and C, but A is outdated and I think it is
> better to phrase it like D.  Would it be a suitable microproject
> material?" is something we can work with. Answers may depend on the
> nature of A, B, C, and D and would range from "nah, A is fine and D
> is not better because ...; don't do it" to "great, yes A may have
> been suitable a decade ago, but no longer relevant, and D would be a
> great addition", to "Yeah, I agree that A is not great, but D is not
> all that better, how about E?", to "Yes that is a great suggestion,
> but wouldn't it may be a bit too much as a microproject".
>

Got it, I=E2=80=99ll focus on being specific about what I see and what I=E2=
=80=99d change.
Here=E2=80=99s what I found in "MyFirstContribution.adoc" and "config.h" my
proposed fixes:

1. Outdated Function Signature in Documentation In the "Adding a New
Command" section
(https://github.com/git/git/blob/master/Documentation/MyFirstContribution.a=
doc#adding-a-new-command),
the signature for cmd_psuh() is:
int cmd_psuh(int argc, const char **argv, const char *prefix);
But the current Git codebase (builtin.h) expects:
int cmd_psuh(int argc, const char **argv, const char *prefix, struct
repository *repo);
This mismatch caused compilation errors when I tried following the tutorial=
.
Proposed Fix: Update the signature in the doc to include struct
repository *repo.

2. Unused Parameters Handling Not Documented The tutorial code doesn=E2=80=
=99t
mention that unused parameters (argc, argv, etc.) will trigger
compiler warnings. The current Git codebase uses the UNUSED macro
(e.g., as seen in cmd_check_ref_format in builtin/check-ref-format.c)
to handle this, but the doc skips this detail.
Proposed Fix: Add a note in the doc explaining how to use the UNUSED
macro for unused arguments, and update the example code snippet to
reflect this.

3. Incorrect Config Function Reference In the "Implementation" section
(https://github.com/git/git/blob/master/Documentation/MyFirstContribution.a=
doc#implementation),
it mentions git_config(...), but config.c doesn=E2=80=99t define it.
I had to use repo_config(...) instead, which isn=E2=80=99t documented here.
Proposed Fix: Update the doc to use repo_config(...) and explain its usage.
Additional Note: I can also edit the config files to appropriately
correct the git_config() function if needed, but I=E2=80=99d require some
guidance as to not mess up other programs while doing this as I
believe config.c/config.h is used by a lot of other files too.

4. Outdated Reference Link The doc points to a GitHub repo
(https://github.com/nasamuffin/git/tree/psuh) as a reference
implementation,
but it=E2=80=99s not updated to the latest Git version, which confused me w=
hen
I tried following it.
Proposed Fix: Update the link to a maintained branch or clarify its status.


> To solicit such productive reaction from others, you'd need to be a
> bit more specific than "I see flaws and want to improve".
>

I seek feedback as to if this mail is well specified or do I need to
improve in any parameters.
I also seek feedback in terms of my understanding with Git workflow
and also with my understanding with Git codebase. Any feedback will be
great for me.

> Thanks, and good luck with your microproject selection.

Thanks again,
Jay
