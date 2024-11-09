Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6013BC12
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731179394; cv=none; b=CSgAsp6ILC+iMGxYuzdpq7mlZzNFT/axd3mUn4TZybPOb8UsTOCEPTiCooauhfqDMRRAgVZDSZrP7nyzwiKy0x0dFBpm5FdxbXCXt17LVukD5c9gRSlEspHXrBKoSOlNF+3Ssuje9FW0OwMutOfwzgOA3NZ2cjSL3VbKzn+Gvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731179394; c=relaxed/simple;
	bh=5ambCAdjX7kCeIcecg1rGVKldJQueruIpSPEvgWoTts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEAsXsNppMurW/7bTS+BLoS1b+6ADnLtsfYk2qMIgcwZZ1Dwcak34V2mtHhx+jNcFO5uDe6hjn+uKQ9OAMGhWsUClfqSxiHUxPnyp9z3azD+ZuHNFHlHkpJ3MyPtl0VqWHDp93ETfg5TRQ1Dsi10KNJdHpJ36Jo5XYvc0b2IlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpfKwmbq; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpfKwmbq"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-513de426719so1320348e0c.0
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731179392; x=1731784192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP5mUF1sbo94yFEMa6Wpq6Eq9Cj+/YAPbZvHEsez2y4=;
        b=IpfKwmbqwtRL3lhSffQQ8+LSBH/b4TAOQrWzCFA6mj+kEVr1pXsApNGLoRIr0ILkmp
         i3ox4tGC6PnVqkwchFy5XYEM+AX+FsOp87paQh9qpch58p5c3KKfg6ZAiqvhQN0X+nN8
         vXxiwVcY5d+8jnwwjdzdty5yeAjBMZKmto3qb2JaxGP165Whxho/XoHLYYn1Ofal0KhT
         8SZ6dINzuHFFKQ4v1Yl8iYUZfYSYGPa2PdcEKON4vUOQRPNxTtsiA7egP3p9eJSeBtbH
         bow5uZ+C7WQw5Uho90ShtXRKZZAjBPl+P4K49nWW0Be5rw/QHGrdv9GwVb524bh/G+4y
         4nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731179392; x=1731784192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP5mUF1sbo94yFEMa6Wpq6Eq9Cj+/YAPbZvHEsez2y4=;
        b=VUI+tGLVy3gcpK5/ahoERcZ4XeWMGixle8cF3FT1A3SFM8DEMyJRoLM8vQN211cl6E
         wHhyGZ0ug26SRZF9j8/A2H/OSpjcsWxwldcrDVdtBtB9nZUa2IVSisLyJep042EWxxsI
         OqdDn8Xbez6fkafbHuBpzyWnk9Mf7zJKQHGaGcYToz5EpjUSttVTnS09X4PdMcrG+og5
         oGnnW2sfJVYrvNjzy1qWonCsoezaV5rI72Xzkj6q8bc/GMWvJMY99SnWheUCGFNiHYAf
         Fs/fpZgI5Oos2+p7oYM8wWfCgojT5bH+OL0EplLcd8xB8bFE83jx885zsodnRw4un1CO
         68sw==
X-Forwarded-Encrypted: i=1; AJvYcCUHc9R83rDqT9E+X+l1OKNdXuecM0FkdIudchoQ2IWTEmMHPCJqtqCHO1Am4BkYiy8eqic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzOmnt8XyzJceUj+ajlbqlT+jMaI+wJsivm4TLg6ePMm2GDKb
	IUkIiI2r8Cou5cUC3vdqrKiSeqrBKt/LGQcTgMqBmDl03eHHzq9CHZYojiZ9eK/bFzZ9Gi7SKG+
	LGuXVyPKZzJKKeEVaW1KAxqEC+QM9SA2t
X-Google-Smtp-Source: AGHT+IEe+dcubdRJGKwtyf8ANInZcCPNAnxcIvkrFOqWPKguMClmO5m/Kd4nOSeA5ZJVP6q5ecMdIJ3T8M/tN1XhV6g=
X-Received: by 2002:a05:6102:1626:b0:4a4:938e:222c with SMTP id
 ada2fe7eead31-4aae1629fc3mr7063074137.17.1731179391857; Sat, 09 Nov 2024
 11:09:51 -0800 (PST)
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
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
In-Reply-To: <Zy-IYwjb_RO5NW-s@teonanacatl.net>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 9 Nov 2024 14:09:40 -0500
Message-ID: <CAPSxiM9=4be8X=Tjz1BJ_uO-bobi4LR=aR=zcq3XgbL0J6ZMvg@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Todd Zullinger <tmz@pobox.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Christian Couder <christian.couder@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 11:05=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wrot=
e:
>
> Usman Akinyemi wrote:
> > On Sat, Nov 9, 2024 at 9:35=E2=80=AFAM Andreas Schwab <schwab@linux-m68=
k.org> wrote:
> >>
> >> On Nov 09 2024, Christian Couder wrote:
> >>
> >>> Yeah, not sure why it doesn't work while you have it.
> >>
> >> It's probably of the wrong architecture.
> > Hi Andreas,
> > Thanks for responding.
> > It was actually the wrong Architecture. Thank you. Just curious, any
> > reason why the 32bit was present instead of the
> > 64bit ?, I will normally think the operating system should ship 64bit
> > by default.
>
> The 64-bit libc_malloc_debug.so.0 is in /lib64 and was moved
> to the glibc-utils package in Fedora 40, with 2c1b0f0 (Move
> memory tracing libraries to glibc-utils, 2024-05-15)=C2=B9.  The
> commit message notes:
>
>     On x86_64, glibc-utils will now only contain the 64-bit
>     version of these libraries but still need the 32-bit
>     version (in order to support tracing i686 applications).
>     Therefore, on i686 the libraries remain in the main
>     glibc package.
>
> If you're interested in installing the various dependencies
> needed to run the test suite on Fedora, take a look at the
> Fedora git package spec file=C2=B2.
>
> The BuildRequires contain a substantial set of dependencies
> which enable as many of the tests as practical to run when
> building the packages (I believe more tests are run there
> than are run in the git project's CI for most runs,
> actually :).
>
Hi Todd,

Thanks for the explanation,

I really appreciate it.

Usman.
> See also the %check section of the test suite for some tests
> which are skipped and other comments which might be useful.
>
> =C2=B9 https://src.fedoraproject.org/rpms/glibc/c/2c1b0f0
> =C2=B2 https://src.fedoraproject.org/rpms/git/blob/rawhide/f/git.spec
>
> --
> Todd
