Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416532FF653
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302235; cv=none; b=doDKWoSg1RVplyyfkAofwe33ExRf+f2m6CoEeLmeY3xNYfACUNtq6jRdrsuAcNarZQ5Ed9i/YGoqrEcpqdF/m/JLVBrd8tIlhC8sb3b8QtVr4oKjXSlMF/rH+YJfP137q1B7lO0OPkTr9FcWmm/auH6Y8f60Y0QeDsWW4sMvsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302235; c=relaxed/simple;
	bh=DaHyLdYaWkHb+76ORrB20nKsuDBgrlhEvhpiJZTuucM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo3FQYR47zjJNKv78BPiiFKBtP594Ui8Y6gnPPhbkgCoLzhrGXKP4HtJrRHNM8hzcdXBcQdfem5mp/1X34LhDDKGiFAeuMZEf2Vzqla/eX5GlwcOxH3kvu0p4fen7vb2l7fBgJPbLR2S3zwwCFYHll3Y4MQmzdHPOx3M8Mx0v98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz4/1XQX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz4/1XQX"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so4784182a91.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765302233; x=1765907033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6OXO3X9eXS45ex8uO2HiSLWSl4nNTKrOybZ53uOsKA=;
        b=Xz4/1XQXRqWhpOIrSbd+BTACPykUkFvKMi7M0wFn1J1iOeH0W2yPqEQudg3/OGFM6v
         2foQCL32va3bbsESZfNQYwhjeW0VcHAY/A0RV4ZbbRNV9HV8lHFJJ/Hfx1LF3OtOVRKy
         zOTltQCM2zwi/8nMEYHOVJFR7zIrg1k37uodbIIxBydXuT6JHg7nCFsZQYF94vv8GCBZ
         gWs15bdgA3p5zR+oOizheb/KpuJJNnBwqih0ZtNFTRYpPwBOzCqIl8cjAsdwEKMB0zPt
         8l8XdFiE/j8L3SiDk3dc47T9ZNDzOCyZL9Hylwp7/C15XPV1tnzvyNHRjbrlQkcM7Sar
         dOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765302233; x=1765907033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6OXO3X9eXS45ex8uO2HiSLWSl4nNTKrOybZ53uOsKA=;
        b=MY8pn+HemWauoJ41exqJIebGP/JLhqldW13O279LMOc5KdEz5AjVSyJE6qhmTFjnqy
         IScuIOjVbJ3uTy80I7Om4riWwbXb+OgDq1ohRbCG+oroAs/rII1pJ4xKc/ADTSfiVyUX
         EUgbDxHGRrHSWxez415KntXg21GPPDfbj99eqVJwH9GUx8To5krKra1wr9yMuJ8TaxvI
         NJzxdDFw2rnxajIlMNBTf1Lzs9FoLctiavmNrJx5ZHVHFjcR5m5ujam7VqwAF+C4ol5Y
         pCqxmdIhxgIHwq0SA26lMUyCBNRhS1MK9TT4A0M10CaOnP6I66nNCQUYCQZbJZLtpKPr
         J/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhAIGJMsqxJadXUxJxPQnvP6iJMhld6FOw/PXBMz9PWSAdcCm+NSl0KfF81PoBxPmHBhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCZMV2RW0ex5UVFMgh1w5b9umlXUlXAsYOt/MIuqHF3hkETFZ
	R/0uW2nHJwxiF+DiSV11HaJpIWonBznudTcr2OQkhN4iSTBFkG707Ig2NlK+4iUcYxJ2Au+lfue
	P/JezPGQ6MBDcZBixUajsJ7yBlWmKsco=
X-Gm-Gg: AY/fxX4D7bX7q48KQogUfCjnFdPb5SzWZ5kB32yw7mS4OMsZoxf0NPbZt3U2wqkXi1U
	3oJeLQJ2iCpfY+qmBxdicIai5bPmaDtVmHKrOsZNVsVxaGu8m1BaixZCWkPaVbb/9KUpIhAbarH
	bRgX6EmI7mY+hbA78WucO5ulP/KV2FTtVv9LoC9w1//11ht7LzRKVFgdiynTNIfPZLEfHYR0bKx
	O1kemU3RPMpJCoL36FUjFApGaJlP+crjtqxReCsloEh10uV/v4Z/8RhqylUwQeR1OjKzcKS8R4Z
	ld0iDS8M6cn3Ut33jX6E1k3qDiGSkJsh1Ja8
X-Google-Smtp-Source: AGHT+IHwwS6nvwlLeVJHkwZi6RLT++5itBXn4oZ/HFOq3TCVzJcM2DICDJk81PLl270hzF58XTEtP0wH4P/LpKqJPSY=
X-Received: by 2002:a17:90b:2750:b0:349:9dc4:fa35 with SMTP id
 98e67ed59e1d1-349a2622069mr9533205a91.25.1765302233431; Tue, 09 Dec 2025
 09:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
 <aS80z0DxAEBLba-M@pks.im> <CABPp-BFtx7-vLFbVqbHar=UZb1CGX5=ufMA4hrJRkSYuB14_Tw@mail.gmail.com>
 <aTfVfenbwY685fDZ@pks.im>
In-Reply-To: <aTfVfenbwY685fDZ@pks.im>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Tue, 9 Dec 2025 09:43:41 -0800
X-Gm-Features: AQt7F2q2sbXVl-PboxQJGy84NhYETKJ8oLqm5QQVb6HbsCRtjwOEfYwFr50bOTQ
Message-ID: <CANiSa6hxjghKQMhURx8qC2t=+1gEE7p8YaHbWkg3rYOYa=poVg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 11:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Dec 05, 2025 at 12:49:04AM -0800, Elijah Newren wrote:
> > On Tue, Dec 2, 2025 at 10:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > Consequently I'm leaning more into the direction of doing nothing. It=
's
> > > not really clear to me that this is a bug, and we still can introduce=
 a
> > > flag in the future that opts into the behaviour of rewriting relevant
> > > branches. That behaviour certainly can be useful, but I'd claim that
> > > it would be rather surprising to the user if that was the default.
> >
> > Well, as I stated above, this is basically copying what I view as the
> > fundamental design mistake of git-rebase.  The many other points of
> > feedback I had on this series (e.g. extended headers, reusing replay's
> > walking, etc.) are things I could easily negotiate on; this one
> > bothers me much, much more.  To me, it ruins the command and makes me
> > feel it is unsuitable for inclusion in git; this is, after all, the
> > kind of thing that made me decide to write yet another command to
> > workaround such a flaw.  If the series is merged with this behavior,
> > I'm going to be in the awkward position of feeling I need to actively
> > recommend against its usage unless _and until_ we either
> >
> > (a) check that a commit is only part of one branch before proceeding,
> > (b) always require the user to specify with a flag how to handle
> > commits that happen to be part of multiple branches (even when a
> > commit only happens to be part of one branch, in order to allow us to
> > not bother checking whether it's part of more),
> > or
> > (c) rewrite all branches that contain the given commit by default
> > (with an option to only rewrite the current one).
> >
> > That said, obviously the choice of whether the series is merged isn't
> > up to me.  And maybe I'm in the minority, and others don't care about
> > this issue at all.  But it's how I feel about it.
>
> I guess it's a matter of workflows and tastes, and there's never going
> to be the one correct way of doing things. I don't think (b) is a good
> option as it makes things more complex even for the simplest cases. But
> I wouldn't be opposed to a combination of (a) and (b) if we can
> implement (a) efficiently.

FWIW, I agree with Elijah that (c) is the right end state. That's
perhaps not surprising given that that's what jj has been doing for
many years (as many of you know already, I'm one of the jj
maintainers). I think it's very rare that we hear from users that they
want to rewrite a commit and its descendants while leaving some of the
descendants in place. We have a `jj duplicate` command they can use,
but that won't move any bookmarks (branches) over. So if you have
bookmark `foo` with descendant bookmarks `bar` and `baz` and you want
to amend `foo` while moving `bar` over and keeping `baz` in place, the
simplest way is probably to duplicate all the necessary commit
(something like `jj duplicate -r main..bar`) and then manually move
over `foo` and `bar`. That seems like such a rare use case that we
haven't had a reason to make it simpler so far.

Regarding performance of (a), I would think that walking all
branches/tags until you reach the to-be-modified commit (or reach an
older generation) can usually be done quickly enough, but obviously
there are many others on this list who know that better than me :) But
I have also heard that some Git repos have tens (hundreds?) of
thousands of branches. Hopefully those refs are just on some server
where users won't run `git history`.

>
> Do we already have logic like this in git-replay(1)?
>
> Patrick
