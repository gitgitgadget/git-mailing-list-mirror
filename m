Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD02222D1
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768148994; cv=none; b=qAOgK933CpaZY/G8jZ/m3KlsWJbkP70fPNDN3fFEFfwHiRUbII1Grkqv6J7TO+nuGJw59NjdPDzp4gkPsud4k1rKGfEwwAmWcbNM1KbCz5edVWZ+4AQgT5R+2XO/DD61qFb4ZZxcxaoHCg9pw0T+L2Y7mk4SvNYuNE5WX8aScbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768148994; c=relaxed/simple;
	bh=vvAQ2XGhHH668aSstqebA2DGIzZniHT34/N7icr/YH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY7U22Ecpqb5lzpG+ijIANYRacwu099/ZxoSfnvEgqSlN1/6bSMvRGRgEgwsilptRdgQ3iasWOKM60qmmMup1dRfrVxAfDUY3KiyExsgXYgkrztDvK/BYapoLUtpAv3FOEeFqCBPGQ00uHzyeUSZrwANsBPs9pConVPAYYMhByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZv05cZW; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZv05cZW"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-644715aad1aso5450661d50.0
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768148992; x=1768753792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRo6+7YOq8PuoH/GQR+uljC2bJIZ6g6knbBEom8xGZI=;
        b=MZv05cZWOj5mYTezRepraPl37eQYp3y6ce9lgW0/VAh2j3g0sd/5I7dzenT++Va9SA
         rEwtkZrTRhUitTwNwVdKdSAWL2JbMHemlunGV+2jmRoi8O31Ela9JgFRv2/0sFVjB7nU
         pkzdBxlmiC/vnu3pxAxFlz3hgNWcXJj7aSqBJYk7McbDfsDhWBPYX009LFX0oc6mmo3A
         UNzNpKJEVKMKsMPk9K42y99YEy1Z3HToGywpBt1pG53ukDE7AldllcIl2lMwLsNJXBfw
         RpsIRq+sl2O0wEpJ0kiStBUw2Q1N47s8YdjZG7UBprkN4pJ4pttsUdekPuKiYeBHO+Gw
         fOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768148992; x=1768753792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRo6+7YOq8PuoH/GQR+uljC2bJIZ6g6knbBEom8xGZI=;
        b=HcpfwP7Lv9lJ/AcCkMKAhG5IfFPXYpFwHWZVPCkSwQq1H14dM4zE9EVJCWqtj2BrlX
         HUKKpPn4hY67zlstsTx3xp7FFT8L8VDu55dujR6tX64F1RNmgEjPwFph5+9q5vMGNt0Z
         pX1+5FsA3TxV9aBz7pLjmqk+ejFRw/mz55i8pO1pZlsaKY/s5TqI4VA2vzrNVqY5IXtc
         W/1AYwA7FQ4hv00Wyg/ClzL411IEHtFmKbgwlnYJ1TSx23tk2D99/TmTMlwgnc69sYaV
         yaXrM/MTiQxdYUvzI8S7YTDRrBEh4kGxEv9OvpixgEgSw8PRGpGugurGWtsM4RFtXlr6
         WwqQ==
X-Gm-Message-State: AOJu0YxmTOzo2gmsx+d2Doz4vxyUxOnu7kR/9RZT6EJQBw3CM215Dni9
	+2WrBwAQmVZb7pNc/fngqEWeBcNvSOdJPi98V/PqME6q8zIGKTdKSyrg3ksIGd5U35CwzWgYBHi
	7uhSQ7NIOCQUc9mwzZopuFZMgwIbcJEUm2i6ZQsM=
X-Gm-Gg: AY/fxX4OCcMAj0BjJl8930vm5AXakiOQhd0nRtJqq85KPOzdu+J/xiK6K7XS0aAbxfO
	NQOCOMJ4QkUS/3dRCNe3rCb76j3qj97LezGy479dZhUZNVFYEeJw4FoNE9qWE96Y7oRydU4kLiz
	Ih+66rU2ONuROND+GBiFUScV8IpI1ngMTbBlqU/uZoXmDdhtOTWZBu8YeQa0prBA25pvo3scJbo
	hzF8WfBUw/MKkEQdQe89naA2Ab6KqE2xAuMXrBeFxanTGC0ikficrtZ6PcnaiXfuB5M/IM=
X-Google-Smtp-Source: AGHT+IFqAtCg1Jh6HW6rGFLBw0+9UqP+YAIsxc/JtFHApSUG50zcsbASehNsibh568skEPIZqf3Nx4iAYrVmn53nXws=
X-Received: by 2002:a05:690e:419c:b0:644:5166:3065 with SMTP id
 956f58d0204a3-647166aa31dmr11459945d50.21.1768148991898; Sun, 11 Jan 2026
 08:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWPC39kUFrvt00lY@MAC.fritz.box> <aWPH9gY9VA6vW-gc@MAC.fritz.box>
In-Reply-To: <aWPH9gY9VA6vW-gc@MAC.fritz.box>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sun, 11 Jan 2026 21:59:40 +0530
X-Gm-Features: AZwV_QjrQr1gTIZru15iGaHOclnK1jjkL2lBmpQWCGYcA75cfQOEirPyzGFJJkM
Message-ID: <CALE2CrQ0nrO-=ROk_gDQgnnEJzW2NhQJMy4r_NkgBjtRaUUZMg@mail.gmail.com>
Subject: Re: Difficulties using git rebase. Help, please!
To: Alan Mackenzie <acm@muc.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

What you are seeing is consistent with Git believing that your branch
contains about 2012 commits on
top of origin/linux-6.13.y. That does not mean you personally wrote
2012 commits. It means your branch
is based on a moving remote branch instead of on a fixed base commit.

When you run:
    git rebase --onto master origin/linux-6.13.y HEAD

Git takes everything that is reachable from HEAD but not reachable
from origin/linux-6.13.y and tries to
replay it on top of master. Since origin/linux-6.13.y has moved
forward over time, that set likely includes
a large part of the stable kernel history, not just your own changes.
That explains why you are seeing
conflicts in files you never touched.

This also matches what git status reports:
    Your branch is ahead of 'origin/linux-6.13.y' by 2012 commits.

Those 2012 commits are not yours; they are the commits that
accumulated on the linux-6.13.y branch
since you originally branched from it.

What you usually want is to rebase only the commits you authored. To
do that, you need to find the commit
where your work originally forked from linux-6.13.y, for example:
    base=3D$(git merge-base HEAD origin/linux-6.13.y)
    git rebase --onto master $base

This tells Git to replay only the commits after that fork point, which
should be just your patches.

Regarding previewing what will be rebased, there is not a simple "how
many conflicts" dry run, but git range-diff
is very useful to see what would be moved:
    git range-diff $base..HEAD master

That shows exactly which commits would be replayed and how they would
compare after rebasing.

I hope this clarifies why you saw those conflicts and helps you move forwar=
d.

Best,
Pushkar

On Sun, Jan 11, 2026 at 9:25=E2=80=AFPM Alan Mackenzie <acm@muc.de> wrote:
>
> On Sun, Jan 11, 2026 at 15:33:51 +0000, Alan Mackenzie wrote:
> > Hello, Git.
>
> > Some while ago I made some amendments to the Linux kernel for my own us=
e
> > (at least).  I now want to rebase these changes onto the master branch =
of
> > the Linux Stable repository.
>
> [ .... ]
>
> Sorry, I forgot to mention I'm using git version 2.52.0.
>
> --
> Alan Mackenzie (Nuremberg, Germany).
>
