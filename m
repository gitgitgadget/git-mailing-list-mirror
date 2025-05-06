Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250E4A1D
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746516063; cv=none; b=QP2kzZ+3G4Qx06a2dOiLiFhiaVlnEspVuxp8nXV1tGzK9StHwJiwduuQ4vyZYXPmlGh4ZcEQGZxfsMrPHrDNj/v+Q1SKySJU8aQH7G+fK+3wq76p/dTc6GIXkTyqpcEKfgjRANMFcQToJjy3Pa7uWL4YSPqzE+nOH5VRh6M0GIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746516063; c=relaxed/simple;
	bh=yEqpZsTTyGQPUONh3SFpxowetfn48S1HbUs33h77o+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGLzyENGJEama47qDttvN6crUngn+gNp7V21Iy4+METk9HGWX1aeFmixBqUdW7F5btYfoL0GIma2dpTjqnpUcgVxws0+FrpoQPwoclaSAozWQvRA3W020BKDTrYFn406myyEY1JyZ4mGxGLFPf70Z8khKxsNJdC74sWlg+sj/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff/ElwA2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff/ElwA2"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so6555713e87.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746516060; x=1747120860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KThepZP551gK8cSQ+seSb4qJfRqKpa4vpwvp3/PWIbE=;
        b=Ff/ElwA2sn1w+pmqDPDfPiYqfujWel2GtQbIXwNnPnTEO/18Seicf8G9hbtiQqRzit
         cOeTfSbTFpBVjDnSpDD20tcJU0b5h/wuLS2eQ8Qf947WhibLfMWWjFn30h0na1YlPNPr
         GQztt34cN2TGefyrbM5C83mslaTj+YH7OO9zsF0/iuDMykZ2l/GWpXHb6KLHpiCSpR3O
         /nBiqRfthoDUA4BfXRJLCCtSaEkAkoBp18FexmVvvuvr1jHp7a3us04pOUnpkDtA8pn0
         vZ54vNzhqNhVHPXo7V4fuM55aRSAYeuQ7LyZ1CguO6atQ8NQU9Qg12yUbqffD+xfDHST
         aKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746516060; x=1747120860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KThepZP551gK8cSQ+seSb4qJfRqKpa4vpwvp3/PWIbE=;
        b=ehXtm+r8XfbrYJo+sxlhfGyVraTRjoa3vpcMj05FzvW7fJ0OqdVch00oNUcqqMREIR
         x1PcRU38hET0apJtgxyApHAfZ+ZBqFGCQIszpgxmxbpVAB9Y87h5FsSyF18ZA8qWSlg9
         ZIEUOt049+TGM7TBNJbCT2+iry3WH0HKCX4zyVDoB/nDX+ZFJvOjYQfCudkgNnQ/SLWI
         Myt4q8mQEAGMKffXAGYk/VnWMbDAYpXAJwoKlZlf+h0SDu59247Dsc5Ut+GSqYY7hOxX
         vTQ/QoSoLVy+qFNKFk34MQ1HeXkN2mX/mXr9jaYPpX0Yi26reVg8zolXwbf8Sw2XQLl2
         Gvqw==
X-Forwarded-Encrypted: i=1; AJvYcCUwf0sfzsoa9L7OXZDKad5d9qnpXiQgSLgKQZL4X2/uEteARpm3PTVQylyCL7WkE/AgogA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BcfCR0dqj0gv0V8SduA6Wil+k02uD/IzdhrSKqK8T+em6faL
	ITioZko29oE+G59BAEVtCth3Lpn+r3WZVoF4eGXioAchyeZ2kqbWrnskAdEXBzbyXICL43++2+A
	pT0gPGtDBm8QI6Fugdd9dz8hqooI=
X-Gm-Gg: ASbGncsKr6x3kxS1KeoLWpHEpiDdJr7IgJhFHqPXpB+ovEpyRgp1h/x806zjtC3XUn1
	YmEjtt8qBDoXRuiGfpw2f3hck7Kmbp9cBrA8itb0/OI+70K2J7+Kv7oxnmWl/MXGMNHZhfCCODr
	DSvXJPYr4HtLS3oklegvX6nin5pFs=
X-Google-Smtp-Source: AGHT+IGn9cdfzWFzE7xGBoJZEOlyvUDOdjHNHSPfMW447WADoKbhyvgjZ2wOUKasEk0C5OGVCVS1PMGeQFaxRTG2AOY=
X-Received: by 2002:a19:6b14:0:b0:545:60b:f38c with SMTP id
 2adb3069b0e04-54fa4f904d6mr2862984e87.41.1746516059804; Tue, 06 May 2025
 00:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
 <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
In-Reply-To: <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 6 May 2025 08:20:48 +0100
X-Gm-Features: ATxdqUHiLKoFjEP05d4TJCjdx_Q_E_kScUPjerWzPRZRMIXTlq_41i3l9UWKcSU
Message-ID: <CAP9jKjFH_2CmvVAQwfk4KKTjDyMne2Wq9rkVnn+XB0dD5BEOCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Valid points, I don't think I have any objections to anything listed.

Would it be recommended to update to test_grep (and test_config from
previous message) in the same test files whilst I'm at it?

Thanks for the review :)

On Tue, 6 May 2025 at 01:02, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, May 5, 2025 at 5:19=E2=80=AFAM Leon Michalak via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This teaches `add/commit --interactive` a new "context" subcommand, whi=
ch
> > changes the amount of context lines subsequent subcommands like "patch"
> > or "diff" generate in their diffs.
> >
> > Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> > ---
> > diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> > @@ -265,14 +265,15 @@ and type return, like this:
> >  ------------
> >      *** Commands ***
> >        1: status       2: update       3: revert       4: add untracked
> > -      5: patch        6: diff         7: quit         8: help
> > +      5: patch        6: diff         7: context      8: quit
> > +      9: help
> >      What now> 1
>
> I'm not a `git add/commit --interactive' user, but I can imagine that
> inserting "context" at 7 and bumping "quit" and "help" to 8 and 9,
> respectively, is going to play havoc with muscle memory people have
> built up over the years. To make this more friendly for existing
> users, I'd suggest adding this new command at the end of the list
> without changing the existing command numbers.
>
> Also, looking at this list, I can't help but think that "context"
> feels out of place among the other action-oriented commands. Moreover,
> if --interactive mode grows more configuration/setting-like commands
> in the future, do we really want to keep extending this menu for them?
> Specifically, I'm wondering if it would instead make sense to
> introduce a new item "9: settings" which takes the user to a
> "Settings" submenu from which the number of context lines can be set.
>
> > -The main command loop has 6 subcommands (plus help and quit).
> > +The main command loop has 7 subcommands (plus help and quit).
>
> Since you're touching this anyhow, let's fix this maintenance burden
> once and for all by writing more it generically, perhaps like this:
>
>    The main command loop has several subcommands (plus help and quit).
>
> > +context::
> > +
> > +  This lets you change the amount of context lines shown in diffs that
> > +  the 'patch' and 'diff' subcommands generate.
>
> s/amount/number/
>
> > diff --git a/add-interactive.c b/add-interactive.c
> > @@ -1061,6 +1118,8 @@ static int run_help(struct add_i_state *s, const =
struct pathspec *ps UNUSED,
> > +       color_fprintf_ln(stdout, s->help_color, "context       - %s",
> > +                        _("change how many context lines diffs are gen=
erated with"));
>
> Perhaps:
>
>     _("change the number of diff context lines"));
>
> > @@ -1087,6 +1146,16 @@ static void choose_prompt_help(struct add_i_stat=
e *s)
> > +static void choose_prompt_help_context(struct add_i_state *s)
> > +{
> > +       color_fprintf_ln(stdout, s->help_color, "%s",
> > +                        _("Prompt help:"));
> > +       color_fprintf_ln(stdout, s->help_color, "<n>        - %s",
> > +                        _("specify new context lines amount"));
>
> Likewise:
>
>     _("change number of diff context lines"));
>
> > +       color_fprintf_ln(stdout, s->help_color, "           - %s",
> > +                        _("(empty) finish selecting"));
>
> "finish selecting" looks like a copy/paste error from elsewhere in
> this source file. Perhaps you meant something like:
>
>     _("(empty) don't change number of context lines"));
>
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > @@ -1230,4 +1237,23 @@ test_expect_success 'hunk splitting works with d=
iff.suppressBlankEmpty' '
> > +test_expect_success 'change context works' '
> > +       git reset --hard &&
> > +       cat >template <<-\EOF &&
> > +       firstline
> > +       preline
> > +       TARGET
> > +       postline
> > +       lastline
> > +       EOF
> > +       sed "/TARGET/d" >x <template &&
> > +       git update-index --add x &&
> > +       git commit -m initial &&
> > +       sed "s/TARGET/ADDED/" >x <template &&
> > +       test_write_lines p 1 | git add -i >output &&
> > +       grep firstline output &&
> > +       test_write_lines c 0 p 1 | git add -i >output &&
> > +       ! grep firstline output
> > +'
>
> This script does have its share of bare `grep` invocations, but these
> days we prefer `test_grep`, which also appears often in this script,
> so the following would be more appropriate:
>
>     test_grep firstline output &&
>     ...
>     test_grep ! firstline output
>
> Note the placement of "!" when used with `test_grep`.
