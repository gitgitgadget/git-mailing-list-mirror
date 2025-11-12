Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2302C0F71
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965472; cv=none; b=EGZGlmaMvjoi9Zov11OrhXu+0I2XqmNENjbLUU4gNRzSMrLCTLbaZJWVO9f6laLnFp5FVyBQnKRuYCJPhAmJSQUwnS8a1NoJyOaremDqpegj2vJ0KCRa9PnHtLF/b5m+Dlw3VUa65Lkc/EZ0CmGxyA9cPDclhvGgddMBFoOjmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965472; c=relaxed/simple;
	bh=wETQjIc6c+Dn7ukm8htvpacIAKyEIWm7w6GNOYU++IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOzo0Hn3TYyax9eQGw5tvFAsmMkSp27D265mnmgFIdnocj13G7zP2ZHWVmKoyNJh8Regj+GHzu/tU0G61xJGEfZQdo/mlEks25ifnIj9kPsagWUn80sv11bdUAITQMqugzaQYuX76GTGFx0pEUO8ZdDe8lhndFaWTpAOaSci/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2k/Ge39; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2k/Ge39"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso133904a12.3
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762965471; x=1763570271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkONx+kJdY/3+tTrGIrXwV02cc2FO29COvlNnA1hmBg=;
        b=G2k/Ge39zXGpy6pa6dGHRiED3ljwPzV4qeA8wDXqMfM68quNAYee20SK1Xi8076yRA
         yU+if88+bWd7JQu4JNGmwwnCT2WKp6p9S0pjT6CzVdRdHxVYRmsOan6xhg39SdiA2uQS
         KjhRkeg7yty5McC5jS+B5/XYevK6csABjoE92Pr+xo9EBYgMjpKZmAc6DyHC+Npo3Ccw
         cU0iTfcO0ycsqwcN92tgZwnSp2AscZBE4LxduDRlE3XlxI10JiaP0zatgGzv+w5HjqnF
         G3PhRhwOqdYdkZ0FIo1BS+dfajJknzTYamowyRL7CYiNHVQeLXCzi0FRRenQOTvw+9AQ
         mKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965471; x=1763570271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkONx+kJdY/3+tTrGIrXwV02cc2FO29COvlNnA1hmBg=;
        b=Fp+glY1AEQq2Y6/qfHb+CzbVJvIpAc6Z5jN67fhyYz6SrQok9NFF6MPd8jRmvpGLhU
         PC+chn554Wz83O8NATYng+8u9k0oZN8Sljt3yPkgLV+VQ0o6BH3JGs4ZngcnDd7ItO8l
         BhgjEvJGo2mM+f4+KXf7pZXul34/ffImAGGjRwCSDbTJ6NOZi/E9YY1R58n6fk8INsBb
         ZZtBMNQKhgIoSqzI64pOVqz4oQn5dTrOh5iDwv22bWjxKagtrB0ubkkZI5ua06KIdwZl
         If7Bjq+wP1aPW0tCFKNSOU26T6shuDQA+OsxUaM0m7i0vbIx6uEqD1YvFO5ng9fjUwz9
         XlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOrDi8bApZwWc4kuaSMlViStWBLotFfYiIpgdi0cYQQtraKFi+9LHK8al98cdeZFhYIOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpeDBSJCYtq0gJF6XKkX/SADNNfNIw3D4IVjF2E8koaDIroVX
	okQ1US0MQztrN+DGTu1tMcmPeooAXoqL4UdQg2CTo9kQFaiZieAfXwWipbKosc5V8E/hUJcuqnU
	CR1kmvC38lUoWC/dh4z3wAX18bhA181o=
X-Gm-Gg: ASbGncvLEWEqZbQ30xYBR9s91h6evFyxynytAu5xCLJWboehrkDS4jhCJsJhyhYURJb
	m6hQpcuX04Fci/1S/OGsJjKAhmjMA6ubKwd8JtaVlLnArO6Ecm/NxKJmituBZi4fAHhrOo+Eo8Q
	gg03vnYHgZNdr8VPP0wqtpLlkSdjwJ3u5qc3Mw06fARateDNoKvvmnfnBCMzdlqmJ7hrx7mEjfh
	jlkP4eyCGI6hH+LuG1M3E2yrsY0Ysqjk3vfIOIWmh34/u8Jazwpp32OtRx3FJddAaN9SaTuDTGH
	PCqVjyHBNIL/
X-Google-Smtp-Source: AGHT+IG9fbOgpT2G6O8NGAw29jknJ9aGa9X8CHIvCYCEhvNSLxdhxY6FPsM9nvLZ16/aJpu1M81ro3QKbXiK4+Yv3ec=
X-Received: by 2002:a17:902:d4c1:b0:28e:9a74:7b58 with SMTP id
 d9443c01a7336-2984ede985amr51133135ad.31.1762965470632; Wed, 12 Nov 2025
 08:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net>
In-Reply-To: <20251111191508.GA1907007@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:37:37 +0800
X-Gm-Features: AWmQ_bmW9_w1l6XY2qCvv_V8GlkTg_VluYKi3rsSitZG1kRE_gv1OABCJtTR6B0
Message-ID: <CAOLTT8S4D5M8uzzx75p_kAr5wsW3JyhVEQg=FW4ww+aYfTnk0g@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> =E4=BA=8E2025=E5=B9=B411=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=89 03:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 11, 2025 at 09:42:38PM +0800, ZheNing Hu wrote:
>
> > > Is a "--committer" option the best solution there, though? I'd think
> > > you'd want to set user.* in the repo-level .git/config (or using a
> > > dir-specific include) would be less error-prone.
> > >
> > > That doesn't help for using two identities for the same repo, but in =
my
> > > experience it is easier to use two separate repositories for that to
> > > match the organization of the work (even if you may sometimes fetch
> > > between them).
> > >
> > > I'm not totally opposed to the new flag, and in general I'd defer to
> > > people who say they find a new feature useful. I'm just having a hard
> > > time imagining a scenario where it's the best option.
> >
> > Sometimes it's because I forgot to configure the repository-level git u=
ser
> > config and started development first. Only when I tried to correct the
> > committer did I feel the pain.
>
> OK, this workflow does make sense to me. Fixing up an earlier mistake is
> inherently a one-off thing, and a command-line option is more ergonomic
> than using the environment variables.
>
> Two small thoughts:
>
>   - I suspect what you'd usually want there is for the committer and the
>     author to match. We have --committer-date-is-author-date for rebase,
>     and conceptually I think something like --committer-is-author would
>     do what you want here. But obviously it's less flexible, and I don't
>     know if it's that much easier to use.
>

Well, to be honest, I don't really like this kind of -A --BaseA option styl=
e.
On the contrary, -A -B is actually simple and easy enough for me
(or more symmetrical). However, it's true that git rebase probably
doesn't have --author and --committer options. Perhaps this is also
a pain point, or maybe something to look into for potential future
contributions.

>   - Because it's easy to make such mistakes, when you override the
>     author (so that it doesn't match the committer), git-commit prints
>     an extra "Author:" line in the output to make that more obvious.
>     Should we do the same with committer when you've overridden it?  We
>     already do print "Committer:" when the ident was guessed from system
>     info, but I wonder if it would make sense to print when it was
>     forced. I dunno. I guess the time you most need the hint is when you
>     meant to use --committer and --author together, but only used
>     --author. But I don't know how Git would infer that case (versus the
>     normal case of you applying someone else's work and crediting them
>     with --author).
>

Ah, you have a point. Perhaps the Commit should also be output,
though it might be trivial (if you hadn't reminded me, I wouldn't have even
noticed that git commit outputs Author when using --author).

> I'm not sure if either is a useful direction, but they seemed
> sufficiently not-dumb for me to at least type them out. ;)
>
> -Peff
