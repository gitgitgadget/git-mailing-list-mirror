Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718924339E
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739085686; cv=none; b=uY0ZDzr8CfdOZs7+OGSMiKFFuihunFD9+ZEUXlutSKjEQMpxmHRgwD9NrdsQwP3Xc2Ddd5PlnIU9GSPDoXhaKHBNFhekIJttrhT3Za1d8IHWxveRXTOL8JzTGbwOFQFBpY+V0PmsI4gAQ/lPbjhqJd9LeK689R7kypjBR+Q0/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739085686; c=relaxed/simple;
	bh=yL+zb8qJotFDKNpKDgbTMj2W1Lxtbq+fxVSWWPgvfFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=o1PW6bp0IoNzAzDfO8F0H8Nt0I0xkEgYWkFuAo2CpmVkSLrqP8HdYnqD99+J3ZHrlebc3XljWFh/1PVik02pZWfNCjzX0fuHDQHjiRfJMkFmv+K3zW73mf4SaSjRR0kRyrveanTnjdZCvSAuQuud7mo1OOKy5s0uHQbA4GBeQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2RkRCGH; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2RkRCGH"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d13e4dd0f2so19246495ab.3
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739085684; x=1739690484; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bgy0zGLiKWO9AMZi6lXT/bpJi3wIhcK8bQz+Lrjye8=;
        b=A2RkRCGHacJ3zjxYMIHiWHEMdbsFjdWIxuc79cQshe/5PiOQYvSncjKiZXjqEoFcUK
         9+0J6fTsdcXLelgTdFk1WsnXmP3LpmmXXRq03WEw45Xt81kqkQP1nXFvmtFc/kvvNTnc
         L0jMoiIu+ZF2VTqWyizWoeim1S3E6YzvkRANk5thJxwjbunM7kqzs8DNjUZG7bEw/7p1
         Gu9GBWiKFLBhnRGK/QGOA/8ZtUMzszRG5C4JGwkzAVxuef89FBfitblIlvTY3vJUM03W
         bI7edGRbTsMBMeyAk427YEYW7vDChQp9fYZchLP/MpkuIfE8x31uTTNjrzQFJh/esOka
         kRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739085684; x=1739690484;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bgy0zGLiKWO9AMZi6lXT/bpJi3wIhcK8bQz+Lrjye8=;
        b=HFCJVJcI+OIchUc5c1152HdtfNqBm7JE1w8gv+nn4abkbvLS0DiWP62+gR/Cs127TS
         cQYcKyDovs4HZr48lFagf09B2Mtthwkn/Q+AyKaF9XnRGgyzzOnlc2SW6zwZZ95IrqtT
         KcuGQMynYkFembjEYpJCPyRsHXd2/ddFC3JPYd6RhmAb7fQ1J6HooLXX/UA3l4fDpp1o
         Q5/T+qTNcf42HgJX3CoyegqbDN7rPD6M/C4NHlZ7AOxyk/+vUlZWnUukwtmD7/BWItHs
         qfzSnfl/Yt4tKkNt6pxvLMUpzbfBZJ6KC4kNAkfJIOldsfSTmfChTzO+h+qpR58yPWf2
         +5EA==
X-Forwarded-Encrypted: i=1; AJvYcCWRIaG94qSXT3ZuRbwxaEA+b29Idr9s20SbtE2G75DShBLWFJla9wLw8wwMCT/M50w3Z9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqh2iiyK8hMkKMq87/DdN7MlrRysQULhJRvdrapcQTkzWVNoV
	E+piwAPTrqbbcoKJwkdnFkY4KvSBXGZDLgCJCN/pi1T3dd7CN6SRGOn+Wpz5nAMxp78fPgRzNgC
	4pGYIQseWVW+4JZStGtVm3V0BGQqUQA==
X-Gm-Gg: ASbGncuNoWdCIjlGOk4p9y5RFvj1nHARpSxHp+KXudXaYwxPkAxFvSVU8WJ2fkDMb59
	vPvOd2VNuI0kxDSgxws6s8WGU5pu283r825YuUewYJIR8LWZgGU5gE8Y91rsSuaU2HVBB/9OYRQ
	==
X-Google-Smtp-Source: AGHT+IGJvHxZHcZKEskbwYPtKwGquF4566PFUCxZ41JKzu6aatHvVzyJmEpqB4FOZhHLfNUUnCsADbXmAutOugh4Kqc=
X-Received: by 2002:a05:6e02:b49:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d13dd0a69amr78193745ab.3.1739085683955; Sat, 08 Feb 2025
 23:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de> <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com> <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
 <20250208232651.GJ30202@raven.inka.de>
In-Reply-To: <20250208232651.GJ30202@raven.inka.de>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Feb 2025 23:21:12 -0800
X-Gm-Features: AWEUYZmrbHL_eQfGzFI4K8-7z3k2tK3BEJatlHFrmgMpxAEYrJXylhwpehd691c
Message-ID: <CABPp-BEzOWVa5zqOMuUSH5xCJ+CUk6sJnLhE5OdnDiNR0U9jfA@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 3:28=E2=80=AFPM Josef Wolf <jw@raven.inka.de> wrote:
>
> Hi Elijah,
>
> On Sat, Feb 08, 2025 at 01:43:05PM -0800, Elijah Newren wrote:
>
> > Ooh, nice catch.  If folks had an appropriate .gitattributes file in
> > place in older versions of history, they probably wouldn't have gotten
> > into the mess.
>
> Well, you can't assume that paople get it right from the very start. An
> important use case of git is fixing errors made in the past, right?
[...]

Sorry if it sounded like that was passing judgement; that was not what
I intended.  I've been in a lot of messes too.  I mean, I wrote
git-filter-repo because of how many things there were to clean up.  I
get it, life is messy.  Hindsight is 20/20.  You can't let perfect be
the enemy of the good.  You can't prioritize "everything", you have to
pick your battles.  Iterative improvement, etc.

> > ahah, so it is passed via environment variable to the subprocess.
>
> I find this to be confusing: the primary call should not need this parame=
ter,
> since it is invoked from HEAD anyway.

No, the primary call I think would need the parameter too; it changes
HEAD immediately when it starts rebasing, and continues changing it
with each commit it rebases; since it's operating on older versions,
by default it'd likely pick the .gitattributes from those older
versions as it goes.

> Everything else gets it via env-vars.
> I'd assume this variable will also be passed to the commands which are in=
voked
> by the -x switch?

Yes, I was surprised Phillip's command with --attr-source on the
outer-level git invocation worked until I discovered that the code
indeed sets the environment variable (which subprocesses, like those
created by the --exec/-x switch, will inherit).  So, yes, the -x
switch stuff seems to inherit that environment variable that the
primary call sets in response to that parameter.
