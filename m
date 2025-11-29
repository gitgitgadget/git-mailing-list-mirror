Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232617D2
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764374959; cv=none; b=sYxPTSKRavYJV3xza9R4OGVYIk24qgAXbaFruFK9uNe4uALGQLw4fZY60eZdVoOMxJ8T8uys0M2EmCwEDzb9JPFdrINRynyt9dReh1702y994BfjGwobhMdR3jum9SjpnV2GQJYiF1JL1sySTrwX1UZzENuHIv6zttwp2nDuewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764374959; c=relaxed/simple;
	bh=9jd2TGsEY/CiYVQfYcZehtLjcQTbEyl6e+05I9OHW3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EcKle1+8LDPEAMMw/Po3VndJo/BinkulB3G/bkDSlflXIMGaZgILvD4qGXQ0tlQO9gA+p8x9WoM6RhyyYBZP2b3QMw4fSG2zWuBtK2oMS93X0WvftjtSGsGMzdkaSzq0CHukqnZN4lUB54QGwukIqlGCbw7MPKSKDFsUXKC96aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAdHv/kl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAdHv/kl"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bdde8f1814fso1969057a12.2
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764374957; x=1764979757; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyF+ZUeEBl2uRBgD0X5oWqeV3r1LJQzWlem8T6/IU3k=;
        b=FAdHv/kl52QRzyWh7JAAOHxd5Cr2jYHNkjU4ZWKnXP1B/H1gBF7UOLe4rSk8q+oBty
         z18tHyZW3VzdPD38jaTOzwDk1x4ujwOYdM/SsLGOCNqjz5ONOf+7hJjTfJN18AaQtsB5
         nVGeifIDxsHdjeuz75JCtP8PbIwXN4mkzizY3EU5sbiSYhPcb1qCp/BzgHHXtT1K8cTy
         bSRLmidfm3Cs5AJIK/4wnt3JR2S3JrkRRkTRJ+ihyzQ+fcawN4HAO7GAfiQUh2qDKBBf
         D83/4e40N1WlzvQ40M1F/rvRRhZcx+QMOKU2Z+WVeGi4zGUA/TIWy9z8dLXQCY9c9JgS
         LjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764374957; x=1764979757;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uyF+ZUeEBl2uRBgD0X5oWqeV3r1LJQzWlem8T6/IU3k=;
        b=FCMgAXe//1EzR0t8WgVfQ8Ev1ZerRTBBUwXIo/nIHoI7rCnYxmrVomYbctVXxNcFUh
         xPe4mvQ6yolP386IyYHoDQJDg6LmxOAs+TzozdY3D/rKNYDBeN+gjdJYM/wZiqulN4MI
         hW22zMorIveFtQufBXNzH4ddgcvnbo0M3BrK5eLFOEvnmmDfbs2N9qyK8o7YVOm34mHn
         vwFtrqPvYF0pzXt8E6CFw/HmQluRjalPiG70W+80ImcdSL8ue3iTqwOgIRyaGa3V1fql
         Jh1vpvNwCQtfb2TCrdkCRfiL8VvDvg9KMAHLFN1Hwo3wrMNGBMS3mT1pBZCFyXM2amoK
         udCg==
X-Forwarded-Encrypted: i=1; AJvYcCWt35mlrElV8ny424RpxKmq0LaCH+c3hJjyuRSIDZyyZGVqcrN7Yw6DTcHJSqwr8BJxYgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQ5HbOhZ+Sc4FHad7J7t5cmOvPqQIseQhHMowdpBdwkFsz/k/
	dYcPXNIbBl/gwN7PhAPFGN3oEHqJ6K8MST8aV5AvkdSp6+x27tHQeE1pSXPIX3MVvTMhPCoJUeo
	mdifXwrPQKZErLXz4/XKENvfZPmgiqA==
X-Gm-Gg: ASbGnctYdOSSRcPS5hfnT0mjcHU9bc+3zeGH77csKnwXRg8C06i4BQ2C9WbLsmd57bH
	colnIS4QLpb1W7zNMF5xWvpMToYpZhzIJvx53pQ4mQ7/Yp/9L7bkldjmIz/NuJ56J5FjZ0GJBCl
	JaXKMYAF8peXI4jljHc8IaOiC9Yn8R7hOR0bRaQvxRisTv10vlPCEUEFrmQ48iYTbT0SGX9WUDg
	isSvSV51TUIOJ8Lx3AC70hj1GlbknstUJfuq16Aaa8HbPq32YNKvekgo/MVLOhjpWyd1bHa3Zek
	5Y4aHmvf1Z63arsOALEC+6ietg7xbA+y7lEMRPSMu6kGJaf80PLc1y2ZzDnbXYogy7Ozlk9x9Fn
	Ez58bHWjQvMzmqutc0x5mSw4rK3oKagKeT+MoCuVm
X-Google-Smtp-Source: AGHT+IGC0uJqCbXR6at/ZgkV8j9a5pPzEby32BHufNJ5VrGqox8ud3spvHCVUjNR/NZOuNor9F/d/F7Ge9IOi3CRBdU=
X-Received: by 2002:a05:7300:de01:b0:2a4:41c6:24f with SMTP id
 5a478bee46e88-2a7190b3e87mr14644299eec.7.1764374957410; Fri, 28 Nov 2025
 16:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=S_8JufSGCOBjCQJ6R1Lq-GumJXTPzWGv2JCZK2SPw_XuGPA@mail.gmail.com>
 <aSo2n2dhEoZd3nZW@fruit.crustytoothpaste.net>
In-Reply-To: <aSo2n2dhEoZd3nZW@fruit.crustytoothpaste.net>
From: Justin Su <injustsu@gmail.com>
Date: Fri, 28 Nov 2025 19:08:41 -0500
X-Gm-Features: AWmQ_blppEDe0qfg3xAsJ4QKsBDT7Kt4b2C4Fx06bXGTEClWcnCjBZ59LMknoLg
Message-ID: <CAB=S_8JFLYsGe7fs7UjCfFfTJGMqpikZavztU6ZiW4KS21A+MQ@mail.gmail.com>
Subject: Re: SIGSEGV when running git fetch
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Justin Su <injustsu@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 6:56=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I went ahead and looked at the repository you provided in the embedded
> archive and I think it's corrupt.  First, you're missing the `.git/refs`
> directory, so my version of Git (2.51.0.338.gd7d06c2dae8) didn't even
> think it was a valid Git directory.

The attachment was output by `git bugreport --diagnose=3Dall`. According
to the git-diagnose docs, it doesn't include `.git/refs` (which exists
in my local repo).

> I then ran `git fsck` and found a
> wide variety of missing blobs in your repository.

When I run `git fsck`, the output looks fine:

```
Checking object directories: 100% (256/256), done.
Checking objects: 100% (679/679), done.
Verifying commits in commit graph: 100% (132/132), done.
```

On Fri, Nov 28, 2025 at 6:56=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-11-28 at 22:56:19, Justin Su wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? `git fetch`
> >
> > What did you expect to happen? `git fetch` works normally
> >
> > What happened instead?
> >
> > ```
> > $ git fetch
> > Fetching submodule catppuccin/bat
> > Fetching submodule catppuccin/btop
> > Fetching submodule catppuccin/micro
> > Fetching submodule catppuccin/delta
> > fatal: Unable to create
> > '/home/ubuntu/.config/.git/objects/info/commit-graphs/commit-graph-chai=
n.lock':
> > File exists.
> >
> > Another git process seems to be running in this repository, e.g.
> > an editor opened by 'git commit'. Please make sure all processes
> > are terminated then try again. If it still fails, a git process
> > may have crashed in this repository earlier:
> > remove the file manually to continue.
> >
> > $ rm -f .git/objects/info/commit-graphs/commit-graph-chain.lock
> >
> > $ git fetch
> > Fetching submodule catppuccin/bat
> > Fetching submodule catppuccin/delta
> > Fetching submodule catppuccin/btop
> > Fetching submodule catppuccin/micro
> > fish: Job 1, 'git fetch' terminated by signal SIGSEGV (Address boundary=
 error)
> > ```
> >
> > What's different between what you expected and what actually happened?
> > `git fetch` almost always results in a SIGSEGV, however the fetch
> > appears to work
>
> I went ahead and looked at the repository you provided in the embedded
> archive and I think it's corrupt.  First, you're missing the `.git/refs`
> directory, so my version of Git (2.51.0.338.gd7d06c2dae8) didn't even
> think it was a valid Git directory.  I then ran `git fsck` and found a
> wide variety of missing blobs in your repository.
>
> When running `git fetch`, I did not get a segfault, but I did get this
> messsage:
>
> ----
> % git fetch
> error: unable to load config blob object 'd38cf93d707c01ca18ed0233bcebb7a=
a172f0edd'
> fatal: You are attempting to fetch 06c0fdfd73559275c8d0423ddff0d3bcfd7e7f=
3f, which is in the commit graph file but not in the object database.
> This is probably due to repo corruption.
> If you are attempting to repair this repo corruption by refetching the mi=
ssing object, use 'git fetch --refetch' with the missing object.
> ----
>
> `git fetch --refetch` downloaded several objects, but I still have four
> missing blobs afterwards.
>
> So I would recommend running `git fsck` on your repository and see if
> it's corrupt and if you're missing objects.  I agree that Git should not
> segfault, even with corruption, but I don't see it doing that (granted,
> on a Debian unstable amd64 system, not an Ubuntu arm64 system).  We may
> have fixed the bug you're seeing in a newer version, though.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
