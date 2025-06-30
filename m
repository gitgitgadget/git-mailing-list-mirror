Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335962701CA
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304903; cv=none; b=bAZRUzJWz/gVSshOb0HwLVcD6VTDDMS1/mQGlnz5ZF3EIOhhMT9VMPA2WmURPUPpGkCKyjj30o99DuJotMO7RMnGp4HqK+R2kJBAbI/8b+DCNiAafJsBNIHvWN6taQEoFzlq4YL/0UKKaqRk3+Q0vvYc7SIS/6f5e/yLmJWKLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304903; c=relaxed/simple;
	bh=8OKkmXuruKrqvArR9mpvphyEcaNytQWsSnoGa88Eyjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esM85259N5ll4/uXYrY/3q0CxO/91TtO7zCgtDCGsz2ikC1iCzNuL8Ly/nC36W029/Pkne2YiLacAaxo04PO7Asnnsdmy0kkE7xM3vJEA5yQ46rfyICJqwXymLsbDR0skyqYwVZ7PVy6IDVuSzEPJTtX4WNx/iLAmOG1cfTH0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGGwSngx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGGwSngx"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b170c99aa49so3869761a12.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304901; x=1751909701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OKkmXuruKrqvArR9mpvphyEcaNytQWsSnoGa88Eyjo=;
        b=HGGwSngxX+eqVY619OYtAGA04u/R2jPnEnL6X5i5v5GXOrk/UtbciKhItsHV3QZv+U
         T3adWM+Gmgtb3o/m8cQz6Nf5uqCxzYPpaB09Vu6JG/hsislskdry+K4ooFEAbb6zAsnX
         jEEQHW6ZLBR88vInnzrv/KFBZfPHIxlVDtIz5iYJ66OKsUr039RasYQKe1oZybyxJKr4
         NLPzbTHbABUaU6i78wM+Qf6j0N5I7yL/3GEoQ0x3QXOlAN0sQkq8uv8C1eyWoV1nwgRM
         mHselhRhlQI+L4ZNAceRfMvbR8AoGKNcNFBm6UOjyWeZEdc/DXrt1QoV8bmJTYdXZ8T2
         nzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304901; x=1751909701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OKkmXuruKrqvArR9mpvphyEcaNytQWsSnoGa88Eyjo=;
        b=cyFb9Y2Tl5V8A/kM+pLl4ssqXfu/Y7vBr9824jVyHr0u67POBvMErzfAMT+H+LxSdt
         kbqfVKNMs+chwIsrRmX5biCI1MgSKu85QT8Nk+apGI9z5PCLqwtam04GJ1aCAkjag8iu
         qDH1b7r/FVyQlmkBWfSIkIohCbxhAQKEuAy9DPtIXwuBbry6G3/2SV6lqhemv5NZ9nA5
         g8GHNhGLbZuLCvnlVcgYCPLmLsovRkXHs/PoV7Ol53JdWGW7I1tnvRCJCtq1qa2umHuq
         UguKOEiXCh6YZ3e2XIDwrsHPZZ0tes5Sd42aitBz8GKUq4TKT/Ckh0VbNXN35P4H+eAJ
         MfUg==
X-Forwarded-Encrypted: i=1; AJvYcCUVOo7n/93RDdrS27E3fgS3BZXwOQM1Yxd7kDbVrq8o8bHwsfvZxWU8r/2Gd7lUbLMEoSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmYGrLvKhuVk4CpmwI34a3j1sIMfIV4U3zy1pZznjx35OYspo
	6mlVjSgGhJsKRJgq8pr/5wNn1r6pIKgqgIlxzVCtz9/pQ4KdoSXfzRcp3PR7e/NaoaKJlMMQY1O
	FZxexorPKog/Pxd81NE49RIuuL4GOkAM=
X-Gm-Gg: ASbGncvEDA36Pqr9KM/Ox1r2uLAP1r+Daw95VBaDwTu4MAYgJZflZ+G6SjP1hfsb+GB
	mn0/yi+6G2FJpJUfDrhHIzGzDTK5VCFZ+XoLUjRgMu3R7Jg8K3cZkJqmiDBGoyKy58HFD5TVTGF
	Mun8g9e2gp4KzxLls5HGORCvxjgJe3R0tybZ/wshE4bXIq7e9h6o6KYONb8CEJC+amEDlAozEdA
	ckHZA==
X-Google-Smtp-Source: AGHT+IG+2g68XJVJtW/NJeaXXq3YhBDmyBGZ2rLx7swY/FHJ5S7yPdXuDaK8eUCsXfPz0IQC++7Q2OB6L8CzNY/CTYk=
X-Received: by 2002:a17:90b:1dcf:b0:313:f6fa:5bca with SMTP id
 98e67ed59e1d1-318c92e0844mr18465060a91.22.1751304901323; Mon, 30 Jun 2025
 10:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com> <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
 <xmqqms9t8cfd.fsf@gitster.g> <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
 <CAE7as+aUcd65vPwwRh_C89vQbMjKQh0Y6LF7WDq1Whyj6iYfLg@mail.gmail.com> <d25bf6c5-e56c-48d4-95b6-c714ee14ab78@gmail.com>
In-Reply-To: <d25bf6c5-e56c-48d4-95b6-c714ee14ab78@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 30 Jun 2025 23:04:50 +0530
X-Gm-Features: Ac12FXziyNvnBsiS5wuZcZItlC94Ois-RC1_kcEp412kJaJ86EqqGZzeacedhZU
Message-ID: <CAE7as+Zaixy460a07G935JXt03XQftf7y8YixrPoOw8akNW=1A@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, git@vger.kernel.org, 
	shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:29=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ayush
>
> On 28/06/2025 15:33, Ayush Chandekar wrote:
> >
> > So, my GSoC project is refactoring in order to reduce the global state
> > in Git. I was trying to remove the global variables related to comment
> > characters. What I tried is to create one single function which
> > returns the comment string, and we could then pass a strbuf in case of
> > core.commentString=3Dauto. You can check my attempts on my fork here [2=
]
> > (check repo_get_comment_line_str() in config.c), and also mentioned
> > this in my blog [3]. I thought I had it figured out, but turns out I
> > failed one test where core.commentString=3Dauto. It was that moment I
> > realised that I would need to remember the comment character or the
> > strbuf in functions. Just wanted to share this in case anything
> > strikes you when looking at the approach.
>
> Thanks for that context. I'm not sure about having a single function
> that handles both cases. There is only one caller that cares about
> "auto" and the support for that has so many corner cases that don't work
> I'm putting a patch together to deprecate it and remove it when Git 3.0
> is released.
>
> Looking at your code it seems to break the "last one wins" between
> core.commentChar and core.commentString. Also deferring the parsing
> until the comment character is used changes the behavior of things like
> "git -c core.commentchar=3D$'\n' commit -p". Instead of erroring out
> straight away it will let the user carefully select what they want to
> commit and then die which is not very user friendly.
>

Thanks for taking a look! I was experimenting with this to see if I
could simplify the logic, but I didn't realize upfront how many corner
cases it would run into.

> Keeping the current parsing logic and storing the result in struct
> repository might be a better approach though we should think about how
> commands that run without a repository will be able to access the system
> and user config settings.
>

Yeah, I will follow that approach as I did with other patch series.

> Thanks
>
> Phillip
>

Thanks a lot!

Ayush:)
