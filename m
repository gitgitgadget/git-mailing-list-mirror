Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9911B6D0E
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018537; cv=none; b=C+Fa5a7DGuWyj8DIHvZUmtPUjR4etsOGaIrDnNAQsZTJ7jwrLoBzatCfLhiKdd/Fa8FCf/5aiHV6bMsi8x/L6YcbNEjKw2LGh5MJbaL6GgV/X9B7+PvbzrN2Xf309JLq7Xr0NMa6ZWEqUjYVMFoMtAxja5SNd9/qmykNGMGSyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018537; c=relaxed/simple;
	bh=0bx46HEEgntSDBpqhdS+YkYU9PWdUUEuwKAMtuegzsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mec7D9kwXUqbbj8xIVLXvpvKvmzlmcfqZ2y8flidN9LAFlJFSunXcZjwXJ5e48N32a1HMC2V1qRTWoCkaJGS5IZ+bcKYkgYml2cdUVdbgZXB8Z5P3mYz9BHFu/2/txDi7jyEunLJNxovhyFYsereX8kZBwWnO62H+KCa+YoYlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqMcvwQY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqMcvwQY"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso3970261a12.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729018534; x=1729623334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIz4f9fYv4rK0zMNoHhMGAuo4KV/Ie992nLCoRn8WbI=;
        b=GqMcvwQYvI+fJhtJwJudq5Wx8H4KvD7syeVigoFUAJ73ZbS3O+lQsCQEeN8UjLuiDf
         /G+3M6fhIO8+ESjxbNVhf9z6lSyPaBCfAbfJXqTmbHv8rAa8VxZcoeAMDRQdMj1sY0Na
         013+4j1E+eYT9WzVUTlFY0v31yDSobmRoPJf6d5jC709FHzphMW9E0mUtgqrMsm4uGy6
         Uh848ZweLFOzAXECWFWvMG1jru4OoDWDvYf6aeooYd61euLUUGt1Ro8tZbiskNo9OqSU
         49Z0DW9eon8UU93QNKkHqOBwnkD3WsPxS5s6ADrUoZjx3ibiMoZNngyRimZj3U5DplxV
         m20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018534; x=1729623334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIz4f9fYv4rK0zMNoHhMGAuo4KV/Ie992nLCoRn8WbI=;
        b=vRgxd7iUqv1qg9RYEv0CRl87vbEPMx2rlBBOMm5kY9+vUwZXzZ6iqjPMJrbnIYji+S
         HJWc8Bbt0EIIIpFFO5O5nSEtJvKXMWQsQmd/kIxCDIry5/6D/XMgaxW4RzXnFvWN75N6
         /Sh/l1FlFlHlVJG3iLLeUjMws/80R8JbZh88OWMhHEAW/m90/FEA3V1Jb16xAudxzd5z
         /e4Si+a/O/8eDD/iemiIPKNgyhaigWHYiu0tf0muxy1KCZ77IMeN89Pn5jjg0TaKQ6cx
         lVqLbhPGJNFFvrTH1CFgHgaszXTUW8n7lVLBjkaCPLYx4RYAa7j5aQN9QxEj++f61DNe
         iz4g==
X-Forwarded-Encrypted: i=1; AJvYcCWFUxGLE4csEWuTn0v4unZ7LIw0WXDcDPlKgg8YjdlfuIs3eVopj0a3hH2dbDugBFu4jCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2TDWzs59F0X3nU4t2Fn1ac16d+jnmTiMy4GbyPR/9oebmjT5
	U2osEeCFb617L3m2IH7PQz3N9s8PQ2vwZ9X9KVuHlnsZG4KZBRmYBNh2x7OKb9zFsbt2JRnDZHr
	blS/5Vfb/aHrm1MjoyL2BeKvqYWxp5uAt
X-Google-Smtp-Source: AGHT+IHfn3JgBLG4ObXUNOGX0poQDF0TA/pjHwEyQfiODDTHbvWQAEBdP4X5ki2ezY8ru0Cd6mq8Mhf6ywTp2y7v1aI=
X-Received: by 2002:a05:6402:42d4:b0:5c5:c4b9:e68f with SMTP id
 4fb4d7f45d1cf-5c948c8832bmr14427939a12.5.1729018533954; Tue, 15 Oct 2024
 11:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local> <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
In-Reply-To: <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
From: David Moberg <kaddkaka@gmail.com>
Date: Tue, 15 Oct 2024 20:55:22 +0200
Message-ID: <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Taylor Blau <me@ttaylorr.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that is indeed a much smaller example and it seems to exhibit
the same issue. Can we figure out how to fix it?

Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshineco.com>=
:
>
> On Mon, Oct 14, 2024 at 5:19=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wro=
te:
> > On Mon, Oct 14, 2024 at 10:46:45PM +0200, David Moberg wrote:
> > > 1. This command should return the worktree toplevel, not a subdirecto=
ry
> > >   $ git rev-parse --show-toplevel
> > >   /tmp/tmp.DUUAVQCIKe/repo2
> > >
> > > 2. And the git grep command should return the match from dir/Makefile=
,
> > > not Fatal Error
> > >   $ git grep banana
> > >   Makefile:       git grep "banana" -- "$$BANANA"
> >
> > I am not sure if this is expected behavior or not, but it feels
> > unintentional to me. Perhaps I am missing something funky in your
> > example that is causing it to behave this way.
>
> This looks like unintentional behavior; probably a bug. It seems to be
> triggered by `git rebase -i` setting GIT_DIR. Here's an even simpler
> reproduction recipe:
>
>     % git init foo
>     % cd foo
>     % mkdir dir
>     % echo foo >dir/file
>     % git add dir/file
>     % git commit -m foo
>     % git worktree add ../bar
>     % cd ../bar
>     % git -C dir rev-parse --show-toplevel
>     /.../bar
>     % GIT_DIR=3D../../foo/.git/worktrees/bar \
>         git -C dir rev-parse --show-toplevel
>     /.../bar/dir
>
> The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
> incorrectly returning `/.../bar/dir` rather than `/.../bar`.
