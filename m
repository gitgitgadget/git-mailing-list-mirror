Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D052DAFB8
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367449; cv=none; b=ceV8L63A7DTgG6pG/acZmhA4KXUD0Hyb5TceZe0zr9Wwd0I7jOTC3G57zwD3/gHa3q6eTYatdKDb/ZJQMP/kHFJZQ2lVzh1NNdeBqJaN/ReCNTd1DomMcBAuYJvcECzaSsvUtpvXfR8yx9kzlVtNtMo+Z/BB7nDBC8/uHhlGQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367449; c=relaxed/simple;
	bh=i2gprHyVTLPGKmD4QV+HaeY9AAKB1R58uVTBhw7m/vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjFtvU+3+xs4WewC3IJ3vtUXQXclYsOM1lUPi+hauWAh1Y7eCJvYdVE+azsgD7eMH5UTvX/pxn3jA2LOLhA0m35N796rppM414qXxgMTrP8tZyiYBlezWZ5C9RdSjnkrOlE+vjFOBVNlfJcma62WY9N5ettR1ETXouif265YYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvua9IIn; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvua9IIn"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4332381ba9bso11722215ab.1
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367447; x=1764972247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoYc7AzHLU1qHmlKgA5r5p7VuZxD2xiUSTdm/e+tjXA=;
        b=cvua9IInmPzTZPBYyE0wP6hM7PKmJqnoXkUkubLP4cfAiOD5DroyPURn9HxRyVHG28
         XbVdE8nqiYFiNl6Grw8/QSkLIhz24twwkXnHo/KwugL1qpuKn+098HYWxefxFNIt3paD
         cHK385akXQJB01kbolTiSQtlduvycT+QiCWd1+CITvQDrvAUHLKEMiDwE7IjGwKi2Psl
         a5rEiaqmeIa5XUUSB5PjJwPqwu6czUysR1qVHlp/tU1G2mj0pvuXndpfXfEVQjaUny05
         fWNp40oiJPC3MqGUzfrYoeG/x3p5gFUB6HRJqbHq98lKS2tQGZR6fhPd15tmFlGH4aJ3
         6Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367447; x=1764972247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HoYc7AzHLU1qHmlKgA5r5p7VuZxD2xiUSTdm/e+tjXA=;
        b=kVjGKaqLjK9UsSK9HX1IjIqCo9qhd2AUPTOkITiS40uX9RnJyh2ptJSEPw8MdD5lCE
         STWOYsRFiAlHtWT/n/on/EV6JyPM+jdOItfbzWuavw80em/WbiZVaqN5uxcIrZHtMaUs
         wnXOYNS7lW2XGAicJmEql6FB8EAScz2f/F6F2akypTMrtEZeJPMFS1EZ9ZSzzXPvzkmb
         wN2jIqrWAUxO6tmPf6QM2mdWD5jG3RKE5fUDtvQ/hK76xlNpR9XNouW33F/Gz/2ZBs+M
         FmEpBx9SVmxduuR54G3qz0Bh5PzcP44F/yAtdBgCD7gvz6yiXR/zJxT8CGItdys+mEZ4
         iVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWPDcRzFO2v4NmaEPkC24yySq08N0P6yYr7gryeoiDXntoZaKRMReTur5+UtLRAQ6UwSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8hddL7OJ7UwHalBENTJZ+bul7Hc7qKIDyg8go4HgeCITZAeF
	QrL7s27ANBEVEY22E14JTjYCvvtaoP81pWv9l22He+Em2NOpYrIdrb93nPK2rysChgtkEPxjBRC
	3StntC2VMtDeOgDGdK1IKQ7re+gZGzwE=
X-Gm-Gg: ASbGncurp+Y+5zfobrEtARSCYnSVq1ocKgmpc6Shg2Pa30pYUQzlMCyb1rbk8J+fRZX
	gIsSbuJyOfE0S9odoJ31rhNbeObQBG7JtagBA+H6aFVDfllXwMda6Mgxd+5tF6cWua4T4ZtIUia
	zyx7YwxJyxw4oDumP7ETbzx7s86j296dePZ8dUK9mkrOcTypSDXW7uXTkhQv/5M6+zGZk8fV3ej
	Y4XpVffHxHxJivyA6bXLmGTnLxaCGryVjCZecDr8PxpHlJUUUCIQiPE8ppfBB+S3VHZZXYzGTON
	7FVGpEhLql1Vj1Lk97qRIKsj5lvPVBLDjNHjMmg=
X-Google-Smtp-Source: AGHT+IHqJzLzIp6H/3z07szl3ULGfBwwUNilz44N2hi/9/6qlroQJD/dTEKwBn4xGH2jIFbcw/3IMcHXKk1SMqIJzxk=
X-Received: by 2002:a92:cd81:0:b0:433:7310:f5bf with SMTP id
 e9e14a558f8ab-435dd0e8d24mr137137245ab.22.1764367446718; Fri, 28 Nov 2025
 14:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de> <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
 <xmqqcy54mro6.fsf@gitster.g> <fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
 <CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
 <c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com> <xmqq7bvajesl.fsf@gitster.g>
 <CABPp-BF48AF9qoP_pUs1X=sUV-_G5BpsxnG6AEhQYkJkE_TBjA@mail.gmail.com> <xmqqtsydj2zk.fsf@gitster.g>
In-Reply-To: <xmqqtsydj2zk.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Nov 2025 14:03:55 -0800
X-Gm-Features: AWmQ_bmYdcyFbMFH2aiT0wi3ogi8fQqfdHa9gn4XC9vwfNCLPYMjzP0KQ9FH6kY
Message-ID: <CABPp-BHbm12gW_LhtfXRCzOHtE3hod4VMTN=cwe-aesVEqyPCQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
To: Junio C Hamano <gitster@pobox.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, karthik.188@gmail.com, code@khaugsbakk.name, 
	rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 12:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > How does one distinguish the "topic~5" in the range "topic~5
> > topic~3..topic" from
> >   * the topic~5 in "^topic~7 topic~5"
>
> Two answers.
>
> (1) You don't have to.  When you scan cmdline->rev[], you can notice
>     the ^topic-7 form and reject, saying "we accept A..B but not ^A B."

Using revision ranges like ^A B C with --onto (rebasing several
branches at once) was one of the major usecases for git replay.
Because of that, even when I only have one branch, I often use ^A B
over A..B.

It's also called out pretty explicitly in the manual:
```
When calling `git replay`, one does not need to specify a range of
commits to replay using the syntax `A..B`; any range expression will
do:

------------
$ git replay --onto origin/main ^base branch1 branch2 branch3
------------

This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
all commits they have since `base`, playing them on top of
`origin/main`. These three branches may have commits on top of `base`
that they have in common, but that does not need to be the case.
```

Granted, unlike --onto, using --advance (or --revert) with multiple
branches at once doesn't make sense because cherry-picking/reverting
multiple branches into one has an ill-defined ordering problem.  Since
only one branch is allowed, maybe we could make special rules for
--advance and --revert, but it would feel a little weird to have a
revision range not actually be a revision range for some modes of the
command while also having them be an actual revision range for the
other mode.

> (2) Or you design and document the interpretation you implement when
>     you see a negative commit while you scan over cmdline->rev[].
>     Perhaps you may make "^topic-7" to require a positive commit
>     after it and convert "^topic-7 topic5" as if the user gave you a
>     single "topic~7..topic~5".  Or you may do something else.

Part of the point of replay was to "use the same revision ranges that
git log allows".  I agree that having a way to specify "topic~3..topic
plus the commit topic~5" is useful for this command, but it's equally
likely to be useful for `git log`; people have asked for it before.
However, there is currently no way to specify that set of revisions to
`git log`.  Perhaps we should add some flag to revision walking that
allows that kind of alternate rule?

If we do that, then both log and replay would benefit.  We could even
consider making that flag be implied by both --advance and --revert
(but NOT by --onto).  If we do that, we would also need a way to
negate that flag, since someone will probably want a way to
cherry-pick some disconnected branch down to the root commit, meaning
they really would want "topic~5" to be treated as a traditional range
and not as a single commit.

> >   * the "topic1" and "topic2" in "^$OLD_COMMIT --ancestry-path topic1 t=
opic2"
>
> I haven't thought it through, but doesn't ancetry-path imply you are
> really interested in the traditional connected set of commits?  The
> path is a connected subset inside those commits after all, no?

Yes, I believe --ancestry-path makes it clear that a range is wanted.
It's not clear to me that we can always correctly guess
old-style-range vs. new-style-range from the existing command line
arguments alone, particularly given the example above of single commit
vs. commits back to the root.  I think an explicit flag is needed, if
we want to go this route.

(Also, this feels like a fair amount of work, when people can easily
just invoke replay multiple times...)
