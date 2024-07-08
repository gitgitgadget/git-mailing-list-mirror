Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE614659F
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463592; cv=none; b=EfV/gxK2NSNO6tTnvASn2hB6fKjmeBn3Ks1U/bPJK+WYOgH51QqmEN0I4U7x+i1yUHQDOY+1VBiNvS79/3855UIa3XnvGQjWFBCyU6O5PIYtFpTVy0IEBfrE4qLGv1hAHB/8m9YcslOCxnmAc/ksmZgzVCpdRYwMm18d2BrY62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463592; c=relaxed/simple;
	bh=3qSN8BK+K+VVBKtYNuCzVeM0mD2eaQIUxukdJb+yDjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvYagWHelvbnNfb0IRddRwvtY9tbiCpf+sG0N9/x+8scqbWp0jTMtwC9Q5q22Qw8JIRhZDWQmN8sglZNdbV2eHN9OhokMDS8nKTnLUI9HV6kOOGWh+EGEekA08sx8+cm3bjE+BRLw870RJY21PHZTZEZIkgwylijRUoMjMPt5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT4afok+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT4afok+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-63036fa87dbso29019207b3.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720463590; x=1721068390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qSN8BK+K+VVBKtYNuCzVeM0mD2eaQIUxukdJb+yDjk=;
        b=RT4afok+p38UqfTkvK4EhHHSWBj83Gaq8xbvNyC5PCEAgvc86RUr8QwklGq51FSy89
         onYHTRoJpXR46o6wG8+64mi6c8/5LA4P//YR/MY/k6nzCQe2A0B9uA7sj90eiFXDnw5P
         XM4hdHalrf8w3COFULK224E2JAxIQxNZzoMbpwZKZWw3L5Cq+5mIw7Leo+l+jIcB4wmU
         IQHHmcx4atq5hagN1eXq172kQmsCPP7Rh9keO7X6IjOCTdJP5lBgBCif6nqbrx0wuo2S
         rIj86upJ7V9KM+BQ4J7SOv9Y1jdIhq5esTfXVa4oFt44rvD4QCFjFG4LvPTYHu33alaq
         1j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720463590; x=1721068390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qSN8BK+K+VVBKtYNuCzVeM0mD2eaQIUxukdJb+yDjk=;
        b=NuziaCxymSbKa9EWUxfarAhW0djwN8WsJ9hvr0Cv6O1gnXXwgBW6gUkD7NI7U3av6D
         ZHCRkKOAHGhQaimJT+HOZl2zomgrOgXnky7p+NVE/HlpaUv0VyIYtxmmqWTn7XN5ZYVB
         zbNZKsyg3M5zqKfc2V1n9Qz1mfhGRbnf4arQM7I/V9O9JSNV2l+sG+sS9a+4NeRUuiow
         s7NpbTM8tyCKtyZylsovzy83DG1gGQEq12OK03mq5M/9Hwdsgl8NMQmUkjMGUewwwndg
         jbi3HKIxuHGToGbiwyQ/V+uCD3Zqjoe4+L/7F/g9vQKSF/DosfxQbg8B/pMtiL5jP9Gq
         ihbQ==
X-Gm-Message-State: AOJu0Ywm4qLFxnWRwDIUM6SBHMqGMDF/M9mXJxcAoonBQf77Fw2brLD4
	mTHBY7e8Co4/bsg5d/auNisNcqtJYobqzwA5TPDtYZfXCSk8HKHn4Slkg1Q9E9Hfpbk0prDTI3/
	pEC+Dv8p9sbRVOFGv1Vt2c0reAolK7+Gy
X-Google-Smtp-Source: AGHT+IGtgqs0+4wHrnJ53OkcV7ngyUZfSU76Rv6Xq6AmmQG+TbEWAJkky6Hm8hmt3tAneBnJF58oqjCyMRK7EweFD0k=
X-Received: by 2002:a81:ae04:0:b0:627:7592:ced7 with SMTP id
 00721157ae682-659180a2100mr587417b3.10.1720463590435; Mon, 08 Jul 2024
 11:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
 <CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
In-Reply-To: <CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Mon, 8 Jul 2024 13:32:34 -0500
Message-ID: <CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well goodness me, seems I spoke too soon.
I found the that zlib was required (looking for "zlib.h"), so I built
that first and that too wasn't all that cross-compile friendly.
I saw "CHOST" is used, and was surprised that it didn't seem to need
anything to link against from the target sysroot, so that turned out
better than I thought it would.

I then used `configure` prefixed with
the`CFLAGS=3D"--sysroot=3D<pathToSysroot>"`, along with `HOST_CPU=3D<tuple>=
`
for `make`, and it worked out fine.
Before moving it to my device, I just nspawned/chrooted into it and
`git --help` worked. So looks good and easy steps. Of course, it'll
depend on whether or not a git function using zlib also passes (hoping
zlib actually built fine without needing any outside linkage).

I'd still suggest and prefer that git (and zlib) follows what others
have settled on doing to be cross-compile-friendly.

On Mon, Jul 8, 2024 at 11:52=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> A few years ago, I had started adding cross-compilation support to the
> project but never finished the task. I'm pretty sure I still have the
> patches sitting around somewhere. I'll look for them, but I'm not sure
> how much they will help. Aside from the obvious patch adding
> `config.guess` and `config.sub`, I recall creating a patch to fool
> `autoconf` into not demanding that the project also carry the bunch of
> other scripts/tools `autoconf` normally wants (since we don't use
> those tools in our build process).
>
> [*] https://lore.kernel.org/git/20171209094310.GA60808@flurp.local/
