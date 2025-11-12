Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98C33BBB5
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965714; cv=none; b=L9zBtB8Qu4eletW46Mq67Dl67EsM1dhgRXl/QS8t8UgEVF1o9FGrtCHvyZks2fAcePyjtYD5Q7SqnFKkypJR2vrjjap9YLx1OG3+nEMl7s2oBem8q1rXR0Ws3ETTzYEIWY4/qWzenscCxLi5qdu/sbWHd2SOCvZ0QzMqi9NtuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965714; c=relaxed/simple;
	bh=upZ06nSKdmxWD06962s1gCOjmD9IfiJr26EWD2vVXEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jwqtn04Upkfq1dAm0CI24sLIUZv/gSOL0BAZaVPZ7oA/CFaz2CCDMKTryAcVQbKexr8RJXH+B17uSMKjBeKWj0hRFO+s5uHNKEeEalwidBpW4Dgyuf7mm7pponu/9RvElXOWo4+LEpzFP9WYh12YSMRMn7peFmaljSTa9Tyv+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it/KZDu9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it/KZDu9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297f35be2ffso12239765ad.2
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762965712; x=1763570512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twkCPI5g+J0h/U/xN+RdEEgL0vuSI9qG1dJH1QEknUI=;
        b=it/KZDu9Vj8VahAz74zi4VcIO/eU/SLL/1eGoDuRTHcB3LZc9r1pLTFYkhay/HjZZO
         6rVZ+gxT595af9N+Z2enD6dANsMyU64k0MukDDUJ3TInTrH9g+DFmCoo2rODo05oBtYA
         8D8iMqd1h18SDUFiYbRbJ4bIVD47OLMagkczgYLUbptr/t+K24kIvAprYT5cOqsqwcrj
         f4VwzB69upDfZ89XvQu1c5zqWBSuYbPj0qgZt544pfxYn4ItygnSogCAbtq8kGg4KF4T
         gEtVdSCrDSAzHvjUwc1tM89tIWsWrHuT4iAj5n83Vhj7dzyX8Z8LRkRhK+mFvf4DAHBa
         vE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965712; x=1763570512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twkCPI5g+J0h/U/xN+RdEEgL0vuSI9qG1dJH1QEknUI=;
        b=ojXRvg09allprAiDI3ivkNfd6lLPEl2VC844iwbThxIkhawbtB1lwCpfUHuvmWaxbG
         TMzub3lh/LxRVS3/LsQ3v9K3UtQJaNbdTWtAn+gnsVCOoZGsBO72JZ7m2Vuc9zd3UwkJ
         o1+QLeG0cnDkJO+PTrruzzMBfzgb1gMJw/HIeb9r/OMVfpy+H/LLfTp/YOIHpLi3DMbx
         vCo7qeEQ+G6garNGTssFZjCO7lV3lwWttVEc7Bu1whoznQoDdS6iGNQYDgaSjYH9U4Ta
         VyB4Ptn1CsYMA0YVFxDdU8DX8bzBisAz/sKrBV/ayYBkLfoTgYUJnFIBYGZZB29hu3K7
         RtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkEKpMBxJx4wABV2WilYJPuf/cKTqAlPGBVPDPBHM5L1nSWO/1wzgusH1B5X6NowLdH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlN2eka85Zpbidxl+QQLpE+JAu2LqA5si82IcK3+RBMWUqqjlm
	YSatjh6NWOb69a2zmsh519wbPpp+m3g7x8YZ5Rhk8ShgiMwN7SK4TH0A7Hg0If+qUGkccIuKXKd
	RppEgU6NuDgN2Tkn4keGTO2db/2EHsSIctKv0iGob0bMx
X-Gm-Gg: ASbGncvoCTUSzXqrdF+JSGJJ8TcU9FWZLTjIDRbT0eXecGkZlUleskuwKSflySaO7YF
	GZpj7gDGgNT/Fj+yE0LPZw0OQTHzHGlfEfF3G/BZwVuR1Ar8drfiL5was1O+wFK384FNDUM/qPH
	jSk0+hU13QYRxA2coTrz3rgcvHNoWY0ks0+awE0sYgBubwHE20hKRbcZJwApw1ZvUjvMJgxx5v0
	FWY+zl7EwFvmAMDKcmfPVZS7J0WDukso7YWSIEEASTr2deWmGoD7S2zV7JUfbhJEA8nqjfhvyLm
	W0/27Wmf3/JX
X-Google-Smtp-Source: AGHT+IFeB2Pcx6BE1B642kIztUlJYulwx8LSm3huXkFO/ZhlNP0hmeeUOUs+9297lZ+qlhCCrOhx0UHPndOZTbUsEqg=
X-Received: by 2002:a17:902:fc87:b0:293:e5f:85b7 with SMTP id
 d9443c01a7336-2984ed34013mr53484555ad.11.1762965711930; Wed, 12 Nov 2025
 08:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net> <xmqqh5v0wcif.fsf@gitster.g>
In-Reply-To: <xmqqh5v0wcif.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:41:37 +0800
X-Gm-Features: AWmQ_bliSns5G1KhMJBt9-rb9yFjiDG9eHGq_TLVetRdUEqaoSPQDUvLkyF1Ow8
Message-ID: <CAOLTT8TYuiLRADQyZ3k0Mi_uGESiGRdNB0qH=EFJPYknJJKTag@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 04:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Jeff King <peff@peff.net> writes:
>
> >> Sometimes it's because I forgot to configure the repository-level git =
user
> >> config and started development first. Only when I tried to correct the
> >> committer did I feel the pain.
> >
> > OK, this workflow does make sense to me. Fixing up an earlier mistake i=
s
> > inherently a one-off thing, and a command-line option is more ergonomic
> > than using the environment variables.
>
> Not very much, at least to me.  Fixing up an earlier mistake may be
> one-shot thing but it is to correct multiple commits in one go,
> which would be error prone if you do so with "git commit --option".
> Either "fast-export | fast-import" pipe, or "git rebase" (which this
> patch does not give --committer option, but it already knows how to
> honor existing environment variables) would be used for that, no?
>

Ha, perhaps this should be left to git rebase --committer --author
in the future. GIT_AUTHOR_* and GIT_COMMITTER_* are indeed
a bit cumbersome to use.

> > Two small thoughts:
> >
> >   - I suspect what you'd usually want there is for the committer and th=
e
> >     author to match. We have --committer-date-is-author-date for rebase=
,
> >     and conceptually I think something like --committer-is-author would
> >     do what you want here. But obviously it's less flexible, and I don'=
t
> >     know if it's that much easier to use.
>
> I am not sure how the user experience of this would look like.
>
> >   - Because it's easy to make such mistakes, when you override the
> >     author (so that it doesn't match the committer), git-commit prints
> >     an extra "Author:" line in the output to make that more obvious.
> >     Should we do the same with committer when you've overridden it?  We
> >     already do print "Committer:" when the ident was guessed from syste=
m
> >     info, but I wonder if it would make sense to print when it was
> >     forced. I dunno. I guess the time you most need the hint is when yo=
u
> >     meant to use --committer and --author together, but only used
> >     --author. But I don't know how Git would infer that case (versus th=
e
> >     normal case of you applying someone else's work and crediting them
> >     with --author).
>
> Yup, guessing based on what you did _not_ give is always a hard task
> for any tool ;-).
>
> > I'm not sure if either is a useful direction, but they seemed
> > sufficiently not-dumb for me to at least type them out. ;)
> >
> > -Peff
