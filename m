Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C3230BFB
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767561; cv=none; b=c/93L71zvC304ZKUo5NIIWAYr1CODwCSuYbRztDNi+2HNtJ6MeoHdcbjOjktXZqnmBazR/4Sg2mXv9qMmgug1ikE1VB3HPcrXxcPhozlxW8OvMI4xRBn/SrghCB/3KvbTXjc1E6pC24bEm1S9uVxS06DpTRAIF6YhVBWo5vE9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767561; c=relaxed/simple;
	bh=FSYMM9Ml9ufUxGWczuCZL/m3atys67yK4m5US10li4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2KZkOWD6honzvxqLlIWbg/oPykJTXXdh4nW0OWhVjvmpb2a8WLWxf7ewTBNeiK4LBEGdryB5d9D/3OGddNxrggC2ZE06lfhLS9Za3EeMRHtbor/VNenLHCASl4f3ErKF42hr8Hv8bCeanJmMDW0vFV265oiloqm/ARBB7K76Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgKM6P3c; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgKM6P3c"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so67791036d6.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741767558; x=1742372358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvFaMQT0yTtub2gPF4mdAeAT/FcUbvr0qGSqlWanxUU=;
        b=RgKM6P3c61CrTnTqmS/sytwrt1VZbwFYxCm++8tM55zAa0lzSN1OzD/9tRyiI81ZRy
         I5+AAok/J6bQ/yIkz6dWH3t5Tts0jSW02gPnEgXflQjDITjDnyhL1BMzLzOLXmv0jKIT
         K+lOGidzjl/I2s3RGc84qmwmpdTIRtZhochYkyNtJldSsNocKKcTiU5FwWc4bETr0uUP
         Bd8r1IjTZeJaYnwttftVzxlhh5XRt6sZYxh0v9xcmFKz/E13rZWB4iKT26q+YWcuJwyb
         yfKMQ7WzpfA17ptDRgs+VnM91TX1bpNT7PqXYU1O/oTCgfNUhArSEkQHX+3WH45efi5j
         j5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767558; x=1742372358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvFaMQT0yTtub2gPF4mdAeAT/FcUbvr0qGSqlWanxUU=;
        b=iI7pFoheACjLEAsX+QVfcnk2rtYHa4xwgxeVNxYoTQVIZZXAMcue9h1VRl2NR+cebK
         h/bxmo7mz6T1vIfPjd5cyvq4FP+09Pf70NjIP+XCqGPgVe2dvsl3F5TYWzRpWw+2tKZR
         sYY8S4TKtP44oF3TUCdHqmKSGphlHy/8v6+6Jb51mh2NuCShP07wZZBEvstqlHC3WqRB
         Gx47yqzmR1bJ+m01lCe+4Quy5D01v7xOIayILuM8+iav7lvunHrdfnd4iAjZP7qPrxKU
         duwIFUmIX4pj8kDVsHksGpH73WOmwL3IAk48Upuf05a/Bg5IS5yOcot/UmmjbclbRakB
         wiEg==
X-Forwarded-Encrypted: i=1; AJvYcCUS0Fi9Z18CtUCF8GEMEN+ZohggpfRAZjCgMptAR2aVBoouBKiPL6fj95NIxMns/MSsXvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50vlXHPpSAUhDYXAbP146muFj7N2LFrf2yiwHMoH7Du82kCiZ
	8RU5rJEHb5adZZGITdYeuEWvG1lvbWbj8y/4A0G1TYSdsItEBeuWQtCDQzrvmsM7zjPD8yb92a7
	2w00jn6c2q+YB7elrp9BJJaloW58=
X-Gm-Gg: ASbGncuUrk2v7c1t4bDe5omzcwOLuHjKJZOhB62yKRGZj4FrRyxrDNYPG7LvZXnmRor
	jhEqW1QG1TwKi6eTbNSVB9VKyEcxKJIWjrStPAdHCtfmohouyPqUSiGxBjtsD+aHj20ZPPrU3zr
	XQX8ooXAUmen2X8nIcT2mSsr1Zj1xtj9vjABwGMQhnz7RXQwlHC1Mf663HRZI=
X-Google-Smtp-Source: AGHT+IHYzaPLfyjOl9uBZyY85m4y80iS9/tz8BGLa3atE34UjSpOk3AoblW77qk32+QsvarZrWF43HkWgQRkIrQCZbA=
X-Received: by 2002:a05:6214:76c:b0:6e8:fa7a:14ab with SMTP id
 6a1803df08f44-6e9005b6618mr270699876d6.6.1741767558388; Wed, 12 Mar 2025
 01:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
 <CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com>
 <xmqqo6ybb48p.fsf@gitster.g> <CA+rGoLfTJSHQZTvNBgfcMmGjJwqak+wGHh9PRhHfqHSxB2p6-g@mail.gmail.com>
 <CAOLa=ZTVOBNMLHE0Wa=vpYdcy56V+S1QdQM1Rk8XWQye32tL0g@mail.gmail.com>
In-Reply-To: <CAOLa=ZTVOBNMLHE0Wa=vpYdcy56V+S1QdQM1Rk8XWQye32tL0g@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 12 Mar 2025 13:49:07 +0530
X-Gm-Features: AQ5f1Jop8V0tFrqfeF0WXkG7zCu1b8kgHAS7pPVNiIpJ0rRcqv-YZ6PNerzFamE
Message-ID: <CA+rGoLdwGfFD0K+DW-XOJEOx6m-BmOg82T1g_y2u5ieD5vVyWw@mail.gmail.com>
Subject: Re: [GSoC] Microproject: Updating Documentation
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mahendra Dani <danimahendra0904@gmail.com>, git@vger.kernel.org, 
	nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Karthik,

I've looked into the mail and have added a PR to Git [1]
I also sent an email [2] starting a new thread with the patch details.

1 - https://github.com/git/git/pull/1913
2- https://lore.kernel.org/git/20250312081534.75536-1-jayatheerthkulkarni20=
05@gmail.com/T/#u

Looking forward to feedback.

Thank you,
Jay



On Tue, Mar 11, 2025 at 3:15=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Hey Junio and Mahendra, Thanks for your responses, they=E2=80=99ve been=
 super
> > helpful in guiding me as a new contributor!
> >
> > On Sun, Mar 9, 2025 at 2:59=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>
> >> Mahendra Dani <danimahendra0904@gmail.com> writes:
> >>
> >> > I'd suggest trying to submit a microproject listed in [1]. Further,
> >> > please go through the General Microproject Information[2] and
> >> > MyFirstContribution[3].
> >>
> >
> > I've gone through the links posted by Mahendra and read the micro
> > projects list too.
> > I've also explored that we as students can have our own idea as long
> > as it doesn't get too involved.
> > These emails actually cleared up a lot about how microprojects are eval=
uated
> >
> >> All good suggestions, but we also welcome students who try to
> >> scratch their own itch, as long as it is small enough to be suitable
> >> as a microproject material.  And it is fine to ask if doing X
> >> qualifies as a microproject or if it is too involved.
> >>
> >> The primary objective for a micro-project is to get used to the
> >> workflow, i.e. working with the community mainly via this mailing
> >> list, how you explain your changes in your proposed commit log
> >> message, how to work with those who gave you reviews, how your
> >> updated submission should look like, etc., etc.  Given that, it is
> >> rare that anything is too trivial as a microproject material, but
> >> you would not want to choose something too involved, as it would
> >> slow you down in learning the procedure, which is the main focus on
> >> the microproject period.
> >>
> >
> > This really helps set expectations as learning the workflow is my main
> > goal here, so I=E2=80=99ve picked small fixes that I think will help me=
 get
> > familiar with the process.
> >
> >> Another thing I noticed in the original message that is worth
> >> reacting is that you do not need to ask for permission to start
> >> working on anything around here.  "Am I allowed to do X for my
> >> microproject" is not the question you want to ask; rather "I see
> >> document X says A, B, and C, but A is outdated and I think it is
> >> better to phrase it like D.  Would it be a suitable microproject
> >> material?" is something we can work with. Answers may depend on the
> >> nature of A, B, C, and D and would range from "nah, A is fine and D
> >> is not better because ...; don't do it" to "great, yes A may have
> >> been suitable a decade ago, but no longer relevant, and D would be a
> >> great addition", to "Yeah, I agree that A is not great, but D is not
> >> all that better, how about E?", to "Yes that is a great suggestion,
> >> but wouldn't it may be a bit too much as a microproject".
> >>
> >
> > Got it, I=E2=80=99ll focus on being specific about what I see and what =
I=E2=80=99d change.
> > Here=E2=80=99s what I found in "MyFirstContribution.adoc" and "config.h=
" my
> > proposed fixes:
> >
> > 1. Outdated Function Signature in Documentation In the "Adding a New
> > Command" section
> > (https://github.com/git/git/blob/master/Documentation/MyFirstContributi=
on.adoc#adding-a-new-command),
> > the signature for cmd_psuh() is:
> > int cmd_psuh(int argc, const char **argv, const char *prefix);
> > But the current Git codebase (builtin.h) expects:
> > int cmd_psuh(int argc, const char **argv, const char *prefix, struct
> > repository *repo);
> > This mismatch caused compilation errors when I tried following the tuto=
rial.
> > Proposed Fix: Update the signature in the doc to include struct
> > repository *repo.
> >
>
> Yes, this would be nice for users who try to follow the guide.
>
> > 2. Unused Parameters Handling Not Documented The tutorial code doesn=E2=
=80=99t
> > mention that unused parameters (argc, argv, etc.) will trigger
> > compiler warnings. The current Git codebase uses the UNUSED macro
> > (e.g., as seen in cmd_check_ref_format in builtin/check-ref-format.c)
> > to handle this, but the doc skips this detail.
> > Proposed Fix: Add a note in the doc explaining how to use the UNUSED
> > macro for unused arguments, and update the example code snippet to
> > reflect this.
> >
>
> This seems worthwhile too!
>
> > 3. Incorrect Config Function Reference In the "Implementation" section
> > (https://github.com/git/git/blob/master/Documentation/MyFirstContributi=
on.adoc#implementation),
> > it mentions git_config(...), but config.c doesn=E2=80=99t define it.
> > I had to use repo_config(...) instead, which isn=E2=80=99t documented h=
ere.
> > Proposed Fix: Update the doc to use repo_config(...) and explain its us=
age.
> > Additional Note: I can also edit the config files to appropriately
> > correct the git_config() function if needed, but I=E2=80=99d require so=
me
> > guidance as to not mess up other programs while doing this as I
> > believe config.c/config.h is used by a lot of other files too.
>
> I think for new commands and also for new users, it is not worthwhile to
> get into how the `USE_THE_REPOSITORY_VARIABLE` macro works.
>
> So I think it'd be best to modify the documentation to use
> 'repo_config()' as you suggested here.
>
> > 4. Outdated Reference Link The doc points to a GitHub repo
> > (https://github.com/nasamuffin/git/tree/psuh) as a reference
> > implementation,
> > but it=E2=80=99s not updated to the latest Git version, which confused =
me when
> > I tried following it.
> > Proposed Fix: Update the link to a maintained branch or clarify its sta=
tus.
>
> This is a bit hard, since this is linked to an external repository.
> Generally the code referred to in this document doesn't seldom change,
> so I think the easiest way to update this would be to raise a PR to
> Emily's repository with the update, so the link could stay the same.
> CC'd Emily in this email.
>
> I also see some more potential fixes to the documentation, which you
> could also overtake (if you wish too :))
> - Remove git-mentoring@googlegroups.com [1].
> - Rename 'Documentation/git-psuh.txt' -> 'Documentation/git-psuh.adoc'.
>
> [1]: https://public-inbox.org/git/CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB=
+A0LzyCPFugg@mail.gmail.com/
>
> >> To solicit such productive reaction from others, you'd need to be a
> >> bit more specific than "I see flaws and want to improve".
> >>
> >
> > I seek feedback as to if this mail is well specified or do I need to
> > improve in any parameters.
> > I also seek feedback in terms of my understanding with Git workflow
> > and also with my understanding with Git codebase. Any feedback will be
> > great for me.
> >
>
> I think the changes you suggested would be great to have. Looking
> forward to the patche[s].
>
> >> Thanks, and good luck with your microproject selection.
> >
> > Thanks again,
> > Jay
>
> Thanks for fixing documentation, it is very important to keep them
> updated!
>
> Karthik
