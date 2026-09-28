Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE48418361
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629358; cv=none; b=F0Xki05bazV2ChLulRikRc6Lyql05KzfG2QH2QN/289AnF+JsmdeiNTRVnJG/LWzH3tVut8OGdtvFrLnM48+xgY3lwZOyS3D5vNs5Lx/4rmmv+W38P77JuXvSejgf3tbdIsO8k8krJ5fKffrhJKm/W12hfq/6n+qwgt3/tM2RXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629358; c=relaxed/simple;
	bh=+7KUXvg3KPZOMqvskMhgt6LFYFpIVdN4KtldLkAXqk0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=W0oynfJ2eQBdgnukF76wbruoLg3DhJOvH5Lcqv99UVoi66P6md4OiLqS+GUiTAT2eIDJuCTnaEdR0CJVo0/lkBdQ1Vi5VpnftvvEkZy9KAueuNpp9LctQ7/SWx3Nh2u7ULJxYpyx1T83yzO1b31OSYdrdiEFKixukiLKLp04Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL2RE9Up; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL2RE9Up"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so969177b3.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629355; x=1791234155; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6gK7N//CLjoYS2+uetlPiujZd8me4o4KbWT6jmkgfU=;
        b=VL2RE9Upa4fBW9erIu1HZlLkuGjTXiFmT5k/RY1wQfJOfx6k4I6a8sAp0H9Of532KK
         HzfCXZ9S0aDScjky6zKLM5DoY02mfN1g5PBl+Xu0Xdww8gzLpCrJOlIVxHFZjERTy2kN
         rCC//YYDhrXVtk7TqwC/1oSofAwHr15pjxfjdNhV/oKys+v83AK+JBv1ZqfZz18b9jIp
         /R0XSNQpOiyp6yIlsz1bEDHRcZ/FlCO8oQHbBmcDnWhe36PN5t4NeU9KUJFB7yWVi7Ar
         TgEuHGQ40+S3lhmKbErwad5wNmPEQzSCSfhYTVaq3IhOjY+0LboFOmB70JZxTAQWQ9Pl
         W5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629355; x=1791234155;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p6gK7N//CLjoYS2+uetlPiujZd8me4o4KbWT6jmkgfU=;
        b=HclWrAp8vpFO/k0ZR3iRgYrqPJSYerQZqF0pWV4iF0D+3u2Miq1Fo7Zm1U01QvJ4Vf
         8oXkh564tpPTbGV5iYkp47JrH/HIWuu5j5hd8tE7gxmMJvJ2yq1pEJvDexh1F3KFejgj
         Ark0iPgoElu4uzLj0AOUuOH2quJ5Dydli79A/V3o+3HV2NqlpJijUfLXnxISMK2w9YM9
         40mQgut6lhfAd7Gu1FA5gX+Gunu3zoNnE8P+Mt0f3XJY996x+rLCPfr1W/4sPEAKT0Sq
         y1tauvXSrYMn4kVXJhL0i6XtbQIXb/nR4pkYjH94WPqTz+c4EPngowyluQA15dHKVNdt
         P+AQ==
X-Gm-Message-State: AFq9FYIeYWWNu8iD/GidI7Ej/ADgVCQw2jhL73/baNKrpg1jl3o8+6ky
	PSB7C1ijoGAxBvyhZ36SO7U1HAZmkhpuYAeBNizjYTRrRN0hU5q58jg4VNH7NEa/
X-Gm-Gg: AYBFou2M1CEhrAxriQhYK1GOnMP1QTufttApEjoss8v9Uy5Z/PTnq4UxvXIADeiDkTn
	CSGAzbNzig0i/bGjMe8pIu++o35WNbUHl3cd7puc6vUiCoQahK6fm8ogTE+gJ4JCdYqEkNTQA5s
	DzQjGXkJaItjuuY0t5PsbEbRcnUXE3ijGqQ/t4BFyr9RZrC1T4DEGhqQjGhl/ur9jLvNRlPkjXV
	Da7GHOZg6PgqzgFnqixHAAJ1P9eqaAfPioTtG/FrCm+ekt/4T9bo2LEIIliHHzrPMaOkBnYiTwI
	FYg2bE127HpPvbBEv9g7Q1SD+fN/l4yTxPdSNHaBc6Fien9HMqAdNgT457LPrNcPGKZW/za81M1
	FO0m8iV/tMAyHUr45mnAMC8hEd/0pBB/4DdtY41rJ2ZkDUdeGERqQYWVly2AkHaJ1HJMDELqnwn
	1+mv+1+eMjbT5QbEu9zbIL0obQE8+HiA/cIoKkOlBjjCpaGnDaIgOkkU15twAbRhZxwhkiJVi01
	FOG/jepTDOeJTJEPckWOJ9LA4Sa9HNSnEEErZ+3T/2DUnEXGZZgLC2RrwDv9hFq2eRDp0KxV9qi
	DgbJsnFn9iQh7RGAZ2coj1UYjUZKSmXm02GTSSE6wM/lqcy2
X-Received: by 2002:a05:690c:4:b0:820:b01:9d6 with SMTP id 00721157ae682-8a64c343281mr52899297b3.11.1790629355494;
        Mon, 28 Sep 2026 14:02:35 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:bd64:154c:955c:5465])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86100b564sm50579867b3.36.2026.09.28.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:02:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] [doc] Use `man git` to teach users how to navigate the docs
Date: Mon, 28 Sep 2026 17:02:24 -0400
Message-Id: <CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Julia Evans <julia@jvns.ca>
In-Reply-To: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 28 sept. 2026 =C3=A0 16:33, Julia Evans via GitGitGadget <gitgitgadget@=
gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Julia Evans <julia@jvns.ca>
>=20
> Many existing users of Git don't know how Git's documentation is
> structured, and a lot of folks have expressed frustration that `man git`
> doesn't make it easy to find out how to get help with using Git.
>=20
> Explain how Git's help system works in `man git`
> (`git push -h` gives a short help, `git push --help` is the full docs),
> since it's a slightly unusual approach.

[snip]

> Mention `git help` instead of `giteveryday` for now, which does a better
> job of giving an overview of everyday commands.

[snip]

>    I thought about mentioning git help push and/or man git-push, but (from=

>    a Mastodon survey I did) git push --help is the one users are most
>    familiar with, it's most similar to how other Unix tools work, and it
>    makes the description really clear and concise (-h for short help,
>    --help for long help).

I appreciate the concision. I think =E2=80=9Cgit help cmd=E2=80=9D is quite a=
 bit more
useful than =E2=80=9Cgit cmd --help=E2=80=9D because the former supports
aliases, HTML formats, and various other documents.
I don=E2=80=99t know how to fit that in with what you already proposed,
though; I doubt that mentioning bare =E2=80=9Cgit help=E2=80=9D will push an=
yone towards
its manual to discover =E2=80=9Cgit help cmd=E2=80=9D, although the bottom o=
f the help
output mentions it as a possibility.=20

[Unrelated]
One thing I think Git is really missing is easy access to the stuff
in =E2=80=9Cgit --html-path=E2=80=9D. I have a custom script for that, but A=
FAICT even
=E2=80=9Cgit help=E2=80=9D in web mode can=E2=80=99t open all of it.=20=
