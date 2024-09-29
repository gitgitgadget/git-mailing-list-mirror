Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8DF9CF
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599327; cv=none; b=HX0t0AA0EOElphrZhHaYRBqD4rUd7ts8n3VqwOOv3z8ph7xcJyzky6ozS79fwyx50jpd8l0LZMPJcRwQE3EUFCK1ZoX+4UELtTlvOcszdTMUPH697kBSsX3o2qyrAiN8W1lgU+B9/MR8AKiyeip0KZemjMcf3SoVRT096ge9oE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599327; c=relaxed/simple;
	bh=sQF2QtgllmI9+c0enO3zDxEMnCGhZtBpkstY/ICF7KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmnbuKGASVjmGX0ybrmb+cVo2OQyZ4+WWeI7BEl/Unwngtct5E+KNb1vXOZhlZKBhV3uCZyaPtoqMOkAsifXWlTKOZPcyRTlkVNPfNCUGS5Q6TgDe1K3Jyg8OVRRKTXACaXux+H7p5Nr/CcD+rLrNpsSlwOe0r4wMzgNxPZ+bSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2AhX3gB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2AhX3gB"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-537a399e06dso4002305e87.1
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727599323; x=1728204123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQF2QtgllmI9+c0enO3zDxEMnCGhZtBpkstY/ICF7KA=;
        b=L2AhX3gBEqQo5Iznzaanpz8phPZ5tVZEQmJtCnY3phHsJp8eXKErTyqO6Bva15CPFP
         8Mylrje8q4Iu7rJiBf9f9A0zLtXQR704MRgaZiyicfv+3OiuBWR08St4Gw03gVikVqvx
         /sAK/jAGI9ITZxZmD2nl2SemqeTEzkHy94QUPXMzVic01bkDNH8aO8ywTXU4WRE76f/F
         0roObdnydaA23Tp2g+WICG4W1/4PWAA4o+ppmi92StrqiUHupI8wW+d6NLb41zFYRDYC
         eylL/lcPXUQ92Cr5IS4NrdC+Y3YACuotscGsLt3AFgDsyJjGb23HO/hie0UNt2vw6BLw
         9ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727599323; x=1728204123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQF2QtgllmI9+c0enO3zDxEMnCGhZtBpkstY/ICF7KA=;
        b=lTE0rBtfCTPLo7CsUqqAiDrC0kWqdDwiAqipFby+lXC7lsys6eYFgqM46kn2UsHMwX
         RQaVebj8vatEJtQ2RSywy9a3Sn4RFt6BEr0FaJvZGjNtC5h2wAVh7giMlBBPUgjcUctt
         BM1+Rd0Ywm6pQ5ZjpTbqysicY5DVMvgTdc7+UM1MGTHmq/ysi1UfO6088WWQtNTDHY2x
         /d+/A4ZgqpMJooZWbP/FpF2z5qI1F650TOc/mpOE/qDBwSXfHPO3EB38KEOjUVSHuP2Q
         AB3YXHM/THbfpqG6rf/dBmC8/pYCSlhZJyj1+iC6vQQE0/78ObBP+nSsgA6itrhapdL6
         sCgQ==
X-Gm-Message-State: AOJu0Yy6L/tWdN5xNwEJXqU9SvDkROZbfScXxH8066FxGoe76OXCSqOd
	svwZFl80DDcIhiN2NERYSnzvfM7C7HleaWmIGfp9k1xY0sbPg3RmQamyea5y0D3qlHtQiuCtNNG
	3NzkotkTRHDQrS2PIvmEnvjO322Y=
X-Google-Smtp-Source: AGHT+IFEhNMFsRiWtAFMO89qhXjgcgjgpqVaPRURKVp9eRT/394dTDu9Ps7ujYWXr+pRsIbK4UBEjg4kRV5b9iRgy0M=
X-Received: by 2002:ac2:4f12:0:b0:539:8d67:1b0d with SMTP id
 2adb3069b0e04-5398d671c19mr1173578e87.60.1727599322929; Sun, 29 Sep 2024
 01:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
From: Scott Chacon <schacon@gmail.com>
Date: Sun, 29 Sep 2024 10:41:51 +0200
Message-ID: <CAP2yMa+PtRADLB2ZL4U3S8X+87Ddz4UZQNMmtEvV5p9nyoq5SA@mail.gmail.com>
Subject: Re: git-scm.com is now a static website
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 25, 2024 at 12:07=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi all,
>
> almost 400 weeks after Matt Burke started the process with
> https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
> Git's home page away from being a Rails app to being a static website tha=
t
> is hosted on GitHub pages instead, today marks the day when Git's home
> page at https://git-scm.com/ has finally moved. Or actually: yesterday
> (because I took so long writing this email that I ended up sending it
> after midnight).

Big thanks to everyone involved in making this happen. As I'm pretty
sure that nearly everything you've struggled valiantly to replace was
largely my Ruby stuff from a decade ago, I appreciate the effort to
move to something more stable and maintainable.

> There are also new things that have sprung up that are not caused by the
> migration to Hugo/Pagefind, for example some diagrams no longer shown (se=
e
> https://github.com/git/git-scm.com/issues/1862) because the Google Charts
> API entered the Google Graveyard. Any takers?

So, I commented on this issue, but maybe this is a good thing to
discuss at the group level. The images on this page were comparing the
speed of common operations between Git and _Subversion_. Ugh. Who
cares now? I wrote all this stuff in the early days because those
among us old enough to remember the fall of the Berlin Wall were still
using systems like Subversion then and I was trying to sell Git's
virtues. But now _everybody_ uses Git, there is no reason to sell it
anymore, especially versus something like Subversion.

The simple thing would be to solve issues like this by just removing
this specific content, but we could also work on a perhaps more
valuable project to rethink the website content entirely. Why are
people coming to git-scm.com? What information are they looking for?
How could we answer those questions most efficiently?

This is essentially what my first version of git-scm.com was trying to
do when I registered the domain and launched the first version 16
years ago as an alternative to git.or.cz:

https://lore.kernel.org/git/d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@ma=
il.gmail.com/

But as I said, the answers to these questions are very different today
than they were 16 years ago.

The version I helped launch 12 years ago (essentially the exact same
site that exists there today) was trying to do the same thing -
determine what people are coming to the site for and give them that
information as quickly and easily as possible:

https://lore.kernel.org/git/CAP2yMaJy=3D1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQg=
E0PcVA@mail.gmail.com/

I would love to take another crack at this, I'm happy to put some
design resources and further engineering (built off the great work
Johannes has done here) into the project. It would be great to get
some feedback from this group as to what they think would be most
valuable for people today.

For example, I think the book contents and the man-page hosting has
been incredibly valuable. I still use those resources today from
Google searches. I feel like perhaps the Guides section could be
structured and presented better - there is some great documentation
there. I have been talking to Apress on and off about a third edition,
perhaps a revamp of that content is also overdue - the last edition of
that was published in 2014.

I think the entire "About" section should be totally rethought.

Perhaps adding something about different use cases - large files for
game development, etc. There is no mention of LFS or partial cloning
or anything here.

There is no information currently on any forge or hosting options,
which seems silly. I think at the time I was trying to avoid
"advertising" for GitHub, but it would be nice for people to know all
the options for hosting their code, just as we have a client section.
Even more CLI clients and tools, rather than just GUIs - things like
git-absorb, stacked git, etc.

Perhaps more videos - there is so much great content on YouTube we
could link to. Right now it's like Linus's talk, my old Google talk
and 4 Matt McCullough tutorials.

I would love to pull in Git Rev News as a blog on git-scm.com, and/or
link to Taylor's regular posts about what's new in the new versions.
It's such great content and would be nice to have more visible.
Honestly, this whole website would be nice to incorporate:
https://git.github.io/rev_news/

In the end, I'm happy to put some work into this, or perhaps work with
Johannes and Taylor and Matt and whomever else is maintaining the site
now.

Scott
