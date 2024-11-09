Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B013BC12
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731179538; cv=none; b=m/GisMvYGygtMcQsVYqzg7oUPhB8ZrLPZ7W6cAAIrlfv3hn8ms0IJNOtZT1wZsFSqFmBUnggR4LTMEI9LE/CiAnI3/Njmdw6ZQO+V4NpDvImyKXmeytQCQt1YcAJ/V47klpfAEJvkzV/HEFHun9xv0BgzC9/L1+o5on4Ie1Zmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731179538; c=relaxed/simple;
	bh=b7fnowAGkwVTqqKEpcIe8aDSMY0a0zzbEc6vl2kOYVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsKHTliK9RC2ZyX6O65c166x/j1V6EkYCMi7wv1Xinr/JMUiQKHPZBajoKarvnxMs0IoXogtgCPTIgJvdqL/h6Iz2JwHLZXhzO+O4Mg+6nANTJxYEsMoGTxG0RRsdJ2f2merwhmJPskt+FudiCPT0misIY+DV4O9sqZxk9rKmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX7d7l7j; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX7d7l7j"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-512259c860eso1168209e0c.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731179535; x=1731784335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV5zt/j+QBYNtk0Mt9gPqmoBmKPHkvDIVT1YWmrud/M=;
        b=nX7d7l7jNWUOP07AIdJV4hDdMKe6IRITst4kQZ4FpVmM9Pdo6mKL/aGzA7hdMIqOv/
         3jHGmMfq+sodrtz6ZiHoFoM8gbLlhRi/a9CpMSFxwdFB7BBiiYg4o8yucpMUxORP46FE
         Dib6uBWwwTjVw4IJXIOtP/wOApB0bN/tmX5uLQ4FAbkQs2YTfEdamZgIarlwO3Dur2jw
         zv+J3xEsySJ7WQHuWregdr7OIBt6Oux7/1tXDws+U/4ai5g6nTDZEcxiazNJo4VfWe1u
         eH5EAJEzU8VcKb6VLGirW82bcsZYIGe79O1tbGqmerPSulmOIKIZzdq05xdYpDMxfpGq
         WFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731179535; x=1731784335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV5zt/j+QBYNtk0Mt9gPqmoBmKPHkvDIVT1YWmrud/M=;
        b=FAjcC4Ogr1D8QRktUt4OrRNyU9nFqVirNrhcK6WJPnelH7E3fl1MqnSK1Fo6RbqB/X
         4B46Y4qHAQ6XrZ1ZW2dhJ0xUzDKjGB4DR8cukJ2jEuDR/0Ar8EEM03+d+3sd2wd3n+h7
         B+mKd6SZgY+nG7Il6ngQ1oQM9kyxT4WTvHFjLJw9lzpQpq+kYMQoYRBgPSZOSUJj/tyB
         JmFg9lFhpK1B8ZgGoPrdn1lwqKeGg+KoNF08/zryfZeJbyL+FeUAZ9MuxsVHhv2cKIlN
         KhTqvfA/H4uzjDKLMS/ADu3x30lTZZT+0d9dE8KqtNEn0DtdSxsRomNhqlyHgwn/Ad0f
         XQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXHKwn3efWwBsN3kEXjUSX17b4/NVAHqNkMkRli+0LsrRKyaESIxmXAPpuO5pPSCmAo4ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4m4Z0dj19J4peA9Tzjb3oakx2ah8gKiY0HFf9l56xtJ+Z2MY
	Sn8TGSWW73HsqAb6kX/8nIIb3pILwZT1UfmHPuUir8fYazwV9jScZLE/XTVCkzkPo1EZxGke4aR
	vByjcU5g/MB252lbtGzi6I1+sWrk=
X-Google-Smtp-Source: AGHT+IHn0cb/owqetEWFroG/QJnIAfrm/QT18GPvbdL7mCUKUUCbAJfCO4c+nzU8kh7uqtY5sYqnLXTA0R8UK0VLxbU=
X-Received: by 2002:a05:6122:a1a:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-51401b9062cmr6506021e0c.2.1731179535390; Sat, 09 Nov 2024
 11:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home> <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net> <20241109190012.GA588841@coredump.intra.peff.net>
In-Reply-To: <20241109190012.GA588841@coredump.intra.peff.net>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 9 Nov 2024 14:12:04 -0500
Message-ID: <CAPSxiM-9KboQharGmRVZQNs=Wor4-Zw_06ixb-Rs1NGJzEt1yQ@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Jeff King <peff@peff.net>
Cc: Todd Zullinger <tmz@pobox.com>, Elia Pinto <gitter.spiros@gmail.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 2:00=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 09, 2024 at 11:05:55AM -0500, Todd Zullinger wrote:
>
> > The 64-bit libc_malloc_debug.so.0 is in /lib64 and was moved
> > to the glibc-utils package in Fedora 40, with 2c1b0f0 (Move
> > memory tracing libraries to glibc-utils, 2024-05-15)=C2=B9.  The
> > commit message notes:
> >
> >     On x86_64, glibc-utils will now only contain the 64-bit
> >     version of these libraries but still need the 32-bit
> >     version (in order to support tracing i686 applications).
> >     Therefore, on i686 the libraries remain in the main
> >     glibc package.
> >
> > If you're interested in installing the various dependencies
> > needed to run the test suite on Fedora, take a look at the
> > Fedora git package spec file=C2=B2.
>
> Hmm. I wonder if our test scripts could be a little more forgiving here.
>
> The glibc malloc debugging stuff has always been turned on by default
> since a731fa916e (Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
> test suite for detecting heap corruption, 2012-09-14). Back then the
> setup just involved setting some environment variables. If we were on a
> system where it didn't exist, it was no big deal. We'd just run without
> it.
>
> That changed in 131b94a10a (test-lib.sh: Use GLIBC_TUNABLES instead of
> MALLOC_CHECK_ on glibc >=3D 2.34, 2022-03-04). Now that glibc split this
> out into libc_malloc_debug.so, we have to add it to LD_PRELOAD. We only
> do that when we detect glibc, but it sounds like it's possible to have
> glibc but not the malloc debug library. In which case we'll produce
> errors (at the very least it seems like ld.so will complain to stderr,
> which perhaps is the source of the test failures here).
>
> Can we do a better job of detecting that the library is available?
>
> I don't offhand know of a good portable way to ask the system about
> available libraries. But I guess just doing something like:
>
>   err=3D$(LD_PRELOAD=3Dlibc_malloc.so.0 git version 2>&1 >/dev/null)
>   if test -z "$err"
>   then
>         ...seemed to work...
>   fi
>
> would do it? I dunno. Maybe this is not a common enough thing to worry
> about. It just seems bad for us to make life harder for people running
> the tests for an optional thing.
>
>   Side note: The glibc malloc stuff seems a bit more redundant these
>   days, since we run with ASan in CI (which I'd expect to catch a
>   superset of what the malloc debugging would). There is some value in
>   catching things sooner, though (I don't usually do an ASan run on my
>   workstation, and of course some people may not use CI at all).
>
Hi Peff,

This is definitely a good suggestion. I think at atleast we should
have this stated in INSTALL instructions.

What do you think ?

Usman

> -Peff
