Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E426981E
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447552; cv=none; b=uVkQMfHii8mFJ7CRR0dlQ5FtguFazl0xu1rxNFCWqMDaLbg7LzFg0fMemtZSEZKKNVP546g0TEE6OyH4e/P5PTC+yCM4heM5SvKyTgYKFWxtxcBDtOAbQ7JJH++hUeB2AtXCpaCx9dOkC84fGhgCc1G8ZXWBCiWHzo+E3LKUpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447552; c=relaxed/simple;
	bh=1djcQRAyAMMgf4+DJoqF8bX3kg0cH/8MhriITa95cZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDbEgyeMCTow1L0MWP8hyXa4Hy78UtZTCYeph8esPlz45ChOmMLrBUL8oGrgHpHcwCMrj6KQwMkPGWgbTMZSgFMm1SOju+80mKk0G6EBloVCsNVc7y91q87Z2LryjIWf4MuH4dzrsbHSjU0pcpWEzhdDWZZxLA0mtjuHzPzbCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIg05DZ+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIg05DZ+"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4135366c152so4584875ab.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757447550; x=1758052350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9VuknTu2lD3OYDGogxfBOC41psGOHwdjHS2LkLnJWw=;
        b=mIg05DZ+hawwCG6ztaDp16tkfe+DmE6v2PcD5FT0qtTUXXhl7ROLRCdh4nrZXoGt3r
         Qm8zaueZB8R9zJMcgoIfXMWaM+X9GB5+7uWGwN+FQn1gq32BoYVLeyEDZd6Vmq97egt2
         VNk2yg+APdflIxBxcxFI/TuQfgoI+Gu+e9A63JdFg5ElSAdxwj2mlmTcAxjCdjkNsFSH
         VyzUkMr000ViaDIxCvWEkRF3OCfFpIj1tED9S2rjyTqAr/FRVhUPdxTED2D2JnqR8R80
         QE0l3l+KnuLzGhihDx6mbVTRobTT3AaAm6DmSadyuhoi2K2V0w4YfRj01ap++Xv8zjzR
         cC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447550; x=1758052350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9VuknTu2lD3OYDGogxfBOC41psGOHwdjHS2LkLnJWw=;
        b=lPpkmQwbFOK99udxMWLNB+6i3gdQtDkbEoSypsAstBd+XoxY/sv04GWXCHaul5E3oZ
         alwow3SKkGZcNeszb0+1jQqlhnqwbwiOClQyK+N/DtQsQ0fKEQq5vNOmxOqujBYAAl6Q
         C96RZcw+vUYXls9vKmRLEM7acakO6jPXrsaXbHC8Qyz27zlbHX+POQ63dJmX+5PLONrz
         eOsM5Mj8r4MpIhbl0ThBtK80l9tilmC/jj5aizlQQ2WMpKpoUdPI2AGLZ+Z2w6TWmh2j
         NJ6EtPiBinAUDqCx+ypc5Pj6IYn7z3ksPolYCKELJHgcO4SKTmN8pYLaBsHHarARDbzl
         CwuA==
X-Forwarded-Encrypted: i=1; AJvYcCXxEKbiMQU1emJRYW6M41kTQ6rLsjA/nd/FHTlhWpmGeOmm2flhgosj5c31/e/Jx2Lhilk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsh5B+ygFErH+P2u+UUEd2lqsLQo+MPHjcJiBzVQtB0iaqT7n1
	co19qDv9VtKs92KJ5pt+DLhdVCGRHKFsW9B67iIi5MFobUMOsGo7m/NlYbprV7gFVmGxsdhv9su
	JmyLet0bsywaDLbr6v3sfOUlgEyxrBow=
X-Gm-Gg: ASbGncsyRM2Twxpr5E4NBBMaIj38fgnkXl/f/G83dX35JjBsTmlX3NA8AbqQmNI7OWF
	HK0z5pLrxqfuULxZnbmN4tDP0Alt38nAbNcFHbkKZEfchpGZM0UTog7SsjjubpGSpw6j/UHVHat
	xWlR7YyY3eggtkAQvSSJGhW3/BdmJ9Evm9mJ1t2UGBQHNharn0VzUPYxARIpcbXtGDbakVda62X
	cSqYO4C1GuvexQ0RJxE
X-Google-Smtp-Source: AGHT+IHB+j9rSkGXgj7ZW/aKMu1UbN3Yzms+CtKRRAsbpvbmqmd0VgLeJCHvf3T956YeK6DGt/M/TC4/yxHh80zbnK0=
X-Received: by 2002:a05:6e02:174c:b0:3f1:e16e:f5fe with SMTP id
 e9e14a558f8ab-3fd965c538amr181921255ab.26.1757447550398; Tue, 09 Sep 2025
 12:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <CABPp-BG6A_mwxQheE5ED5HQj7STVtf1_9NhSmjmzRPB7QkdWyg@mail.gmail.com>
 <CAP8UFD3GU5Xwq7WMihmHtpWc-GjB-guTU6JHG7BdkhxukMihNQ@mail.gmail.com>
 <CABPp-BHWjyRv_f_HKkz10Q_cOZKPvpgf=SEUR1ThmbttkQT+Uw@mail.gmail.com> <xmqq5xdrvand.fsf@gitster.g>
In-Reply-To: <xmqq5xdrvand.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 12:52:17 -0700
X-Gm-Features: Ac12FXyV5F0SryUGZ8YDKHx7KCbh1oeMq4Ksh3ouHqXZgNnL_yF69KAIC7fu4Ko
Message-ID: <CABPp-BEyVSrEkPwsc31g69SZEXNffa64HPNeG-FU+hhQMz_y=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > Seems fair...but why not make --update-refs the default and add an
> >> > option for those that just want the update commands?
> >>
> >> If this patch series had been sent a few months after `git replay` was
> >> introduced, I would have been fine with this series making `git
> >> replay` update the refs by default while adding an option that only
> >> outputs the commands. Unfortunately `git replay` seems to have been
> >> introduced in v2.44.0 (Feb 22, 2024), so more than 18 months ago. So
> >> even if it is marked as experimental, it's perhaps a bit late to make
> >> such a relatively big change in it?
> >
> > I don't think so; we marked it as experimental much more prominently
> > than other commands -- in the .c file, and three separate places in
> > the documentation.
>
> When we are talking about a change that breaks an established
> end-user expectation, it does not matter much if we wrote anything
> in the .c source files.  The end-user facing documentation does.
>
> And as you said, "git replay -h" and "git replay --help" prominently
> show that the experimental nature of the command.

I should have clarified -- the .c change was specifically about making
"git replay -h" show the experimental nature of the command; if it was
just a code comment, I'd agree that it didn't matter, but it was
specifically about making the experimental status known to end users
in the short usage message:

$ git grep -2 EXPERIMENTAL '*.c'
builtin/replay.c-
builtin/replay.c-       const char * const replay_usage[] =3D {
builtin/replay.c:               N_("(EXPERIMENTAL!) git replay "
builtin/replay.c-                  "([--contained] --onto <newbase> |
--advance <branch>) "
builtin/replay.c-                  "<revision-range>..."),
$

> If this new behaviour is a clear improvement for majority of use
> cases, I am perfectly fine with changing the default behaviour so
> that everybody will benefit.  It may still be good to add an option
> to allow the users to ask for the traditional "we'll give you a list
> of updates you can apply as you see fit, but would not update the
> refs ourselves" mode, though.

Yep.
