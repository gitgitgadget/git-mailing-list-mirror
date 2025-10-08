Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373942566E2
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957010; cv=none; b=gMdBliNMhd+ZZ+r5IfUrPFkquQ0Oo7MxxVN44ZkaNrPxljd5cHuyDmvUjk3hQzl8OczNzRaTme+fTa58q9qmNxykEBmFkJg+JV6qz72fjoxDbSVBII+aAQUOAkILW3O4Fd4WMZrsve7SDeidIUIlucpoERes3MQrRMRN4TxqF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957010; c=relaxed/simple;
	bh=xpPBixSi47B1E1l1h0NDqnaeMAizmxNJIO0mPdfyiMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgXWggiD1lLe03+uHiVEWA0aUou5oGhFPwY39zplnO4NrOPWCnt3ertH76eVFbyvuRXiI3NiLO8/6rEslEewllET9jiqqicBeapC8A3vOdJvsYwExpbe04sbwnYgpUGRI9QKMx/Kl1Qo1NjEMIRPfGXGhiE2PrJ+BbzYe8jHr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWeDo1Zm; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWeDo1Zm"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9399ddb3ffeso21350939f.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957007; x=1760561807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbwR+uRwByaUQOKeVUmTv6azLmYywRd/kuuJeYPGiZM=;
        b=OWeDo1Zmg6JO6RVb3UKx8e4nbg50h6AqpQQdMSadYHdyIcXnKUuuYQVYsQ6C0GTD7m
         rdDKAG6gq+Q4Btq/LY2b47bXV07wcXtujwyEMl/uwmHXhmb7E8hjvCWMWp0qBbwVd60V
         /4rC/2ZjAC2jsWJDfQAfKzanXDnnjdNfRELdz9y7YY3szvuOofa83rsDd9LRkeYSCysN
         9vTFioZ6FxbkoEXZ0z0fJR3i7W9vt1fKqC99c5NUG/xP3k58Sa/LHzyKw5reN7/gCzWS
         47xN45zDzLQ0qNsL//Ch1dRR/OeG/GF/cOouTBA47HFmnQMkVefveoMwUtKEjFHNu7nP
         lI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957007; x=1760561807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbwR+uRwByaUQOKeVUmTv6azLmYywRd/kuuJeYPGiZM=;
        b=RKbFkPfRsKOE68+d5OvsMyWqy2IaIHSRp+VZKWeTW8OxZ6QzTDOXizww52kZbOBtg+
         KFjSv23yMwnY8d0A1KCTVM0upN2cdpvQwrTb9/180IiZOdjhNcqDnOpZXlieHVji/Hdt
         hjfpkTGAyUo7qjyyqtZ44k+aYiQurzGfi3RlHo2uAbLZE/AHjvG7DHPoMby1Eld96yRk
         huMKJZ0guMfT85SZevFoxhhZJ1Qcp9V5O//pPcRD2bi5GKc521QhMrFHVxHse5JujetC
         QFRTDnCPqDF8m25szPkzEdXkxK3P1W1NMroOpzmZOtEqCITeJpGEv3URiAdLFux8Wid5
         BOdA==
X-Forwarded-Encrypted: i=1; AJvYcCW5+5UxNNIyUbaH+sz0TQL9cqH1QFVIVu9AG1BSwpVqFiO2Mi4/l+aUu2whsGdbS+EClM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbLg3fw202f/3k23g8ulZvkauq3PHhaaxvhtV7NCJ8cUzHlIZ
	NLzhP75RU4dTjpv+0e/yC0xyMq8PNUkAQnh6dvk1u4LJaGoio1LEZWOxI/Ujm1GQjFQ2s8KTJg0
	ecncNeqpEfA8Hd412y+6VHgiH0lVF8Hk=
X-Gm-Gg: ASbGnctbGQP9OUaKueobYzJKKvEyWCk5BvT2MPhldxzabR6ux0PbM4QS2LF5x1Es1MJ
	xUGO12cP56n5S/G8KhPtBi0ycBIYLYZguD3HD+yXtjMmkZ9jBv5a3jFj/wJWbpbjpqIdaUBVrNs
	FPZjeDOZfQIE9hXEU5wlUhekGiJNKQ8So8IcpZOuT078NWDZJPVg91xd9y15CGuONlWIAxo11xG
	1m/D3SMa3bBds3xutKQfYheLrMJmLjjAtga4baETNeh/7YSwLqUkhc4witwRvB4HWgI1iGNuCc=
X-Google-Smtp-Source: AGHT+IH+GVC4DyCrK7RWdkNnmmLco30lnuULTwkrdGpKAlrcVe4RVM7XieiSd2HQHmLqk9gWv12m/q5cXYY64RBXKvg=
X-Received: by 2002:a05:6e02:3a05:b0:42f:8ee2:1eb8 with SMTP id
 e9e14a558f8ab-42f8ee2204bmr20382765ab.11.1759957007095; Wed, 08 Oct 2025
 13:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
 <61107972-5755-49b9-a126-9442418ddff0@gmail.com> <6d19a0c4-f000-43f5-b2e1-f84f341063a9@app.fastmail.com>
 <38742a2f-5c5b-48f8-a9fd-acea47b7ce71@gmail.com>
In-Reply-To: <38742a2f-5c5b-48f8-a9fd-acea47b7ce71@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 8 Oct 2025 13:56:35 -0700
X-Gm-Features: AS18NWCzbc_liiRUD9mF0SPha7Olou9tpPHFN5usRebVboL8qAPpebscHxChadg
Message-ID: <CABPp-BFHiwTwNmk3DHSQsXocYYbcaQV8TfVs052v9xFE2NYjWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Andrei Rybak <rybak.a.v@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:02=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> On 04/10/25 00:35, Kristoffer Haugsbakk wrote:
> > Good evening Siddharth
> >
[...]
> > I have been using git-rebase(1) for a while with a post-rewrite script.
> > This is used for interactive rebases but also just keeping up with
> > upstream, i.e. a regular rebase.  Then I was idly thinking that
> > git-replay(1) would be faster for the plain rebase case=E2=80=94but it =
doesn=E2=80=99t
> > support that hook directly.  Okay, but I can get around that: I can
> > parse the output, yank the commit OIDs, and run git-rev-list(1) on both
> > of them to get the mapping I want.  But it would be really nice to just
> > declare the correct post-rewrite format and be done, without having to
> > parse anything. :)
>
>
> Ah, that's a concrete use case! You are using post-rewrite hooks with
> rebase and want git replay to support that workflow without needing to
> parse output.
>
> That makes sense for the client-side evolution of the command. Right now
> the focus is server-side where hooks aren't typically needed, but as this
> moves toward replacing interactive rebase, proper hook support (including
> post-rewrite) will be essential.
>
> I think --format with atoms would work well for that - you could get
> exactly the format post-rewrite expects without parsing. For now I'll kee=
p
> the simple update-ref format, but this is good motivation for adding
> --format support when we tackle the client-side features.
>
> Thanks for the concrete example!

Let's be *very* careful before we add any hooks to replay.
pre-rebase, for example, forced the assumption of only one ref being
involved.  The early implementation of rebase as a shell script on top
of other commands forced assumptions that it played with pre-commit,
post-commit, and post-checkout, and forces us today to continue to
check out every intermediate commit to the working copy even when the
rebase could otherwise be done entirely in-memory without touching the
index or working copy.  post-rewrite seems more sane than most other
hooks, but I still want to avoid painting ourselves into a corner, and
hooks are very much about defined and established APIs through which
we communicate to other processes, which means it's exactly the kind
of thing that could paint us into a corner.  We'll probably want that
kind of extensibility eventually, but it's way too early right now.
