Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E9283FDF
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684496; cv=none; b=YoEn8SvXqJXtNp4D3qbCawk5j8LCtW7c0d2WBw+feAdnZg/p5gRrBMzGOWvODho1J2zANmkWtV+d5PUpmiULsZWwtCYQUsh1NcIOoUxaHR2yHVdyLCGHYxeE5MqeO6+d8TVqiGDo+7LySChN18Exj7G5RI2pDtTheGVk3khE+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684496; c=relaxed/simple;
	bh=W4UNjgjhi4sRtDLvJNOpF24dAIt2q0lqkgvug6xaO5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCDsSQBIJblFm0ACrvUeldg+YgWnt28tmGo1F0VsejYyjuLaGk6UjLUIZkVfKCKPO8IdmzQqv3ZUk1zVdtQFs+7meZWxHoFJ7ORQ6mmc2c0c/fvUDvRYLmNZXB4DpYKCPZYsqu9XgmtJMD27j8NYQ6gHv9fL1DAOHlc6iItsZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPxipnBV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPxipnBV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ec693c618so2800986a12.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757684492; x=1758289292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yUsc6vc1X4SyOLE2nJJLvUaSNlKlzJcWSPBd2gyvzg=;
        b=TPxipnBVeAU+embXvXrY+JOo/xmd4kk9axEJ2yovOwH2HHX2c+Sj3cyhG/WrC6H7ZF
         /IKcP5AjOmqu3WAaHaiMu2+i+hntkVYX5IgvdOK/+yAoOAFTP0RVkCP+yzW68jAJd0ru
         rWLfz838ZclwbFew9fM9uuJq4wNXR5LrJU33gfINUsfh3s9qDp9Mm+LvS+ft2kDM1ubr
         m0pOxNjtOH4hBp29Tv+IgqTKrpd5uWm6ezDyn7Q9cPqClPw/NKtRfZFlGn09ljARh1+b
         gcxMkD52mUuf9Mdep1an1IDm1g+4Pq1jlRI1Cmg+9+FgybJzicqtJyBh/kcn1+f8zCgs
         AwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684492; x=1758289292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yUsc6vc1X4SyOLE2nJJLvUaSNlKlzJcWSPBd2gyvzg=;
        b=Fu1uv71NH4oQ+HzeMDOrjo8ic0Es4hTBF3F+zixIHDVnv4lXvhTxrcEETGRxbYot54
         iYsvaB6aWxDqM2LfP0WJRm5/3Sk3wQhiGcaLtnarQNwmthA28GpoZbXlyL2pt5zcrd4c
         /vDMic80MZ8iJ8nQ3VrdAQcN9lmxWMETJ+x24SQd17IArJN2g/BR5Ulhfi+8ZnovcuvX
         CJfg4xYL1PDbgHLgM1PZS2HD1UvZ6g9EdNXooO4JNlMpyaoj7NvEQ284FQ4nI6PjcLPt
         +xbBICcQUBxxL/5u/XqFixsboiymtkdG1Y45YWpfdMgGDvwsNWGAkxJEiNhWqRjghV7M
         NZ/A==
X-Gm-Message-State: AOJu0YwPI6IBuL3Ix51LKqqSPQQ0QfAoGwacQ0JPlifm2d74x6qybjNj
	TyoNkhuODwlWS1wttWRvHCVyvuvOcPUd38A5FaJrOUuSTKLkLYYgzVqcA/lSIUP2SHOts49znP/
	cxEnWrRptFAVmxC89koXu1nk3Me5xuyk=
X-Gm-Gg: ASbGncvDThGh+IThGUx2UkZYN7EY3EgibTHgQQweqdmGK3o9snhRsBdvqsIqREYtXET
	5SSU8O9SNbPczmWly1opOB3RGZqlGnJlEafxTmqlzjOvsRA3LwG/NhS78nkv+XX5DdQfCQBr6oO
	J9u+I4rF04Rz3te0hZvSkw8ey32qOIOfVwEXwWOaRW924FDrf/5GghnIqJlrhucOQS7xnha3Mzb
	yc5lKwXh8drnv9zd2dV
X-Google-Smtp-Source: AGHT+IGyWRlaW+VQvifOCV+NgePLpy/1p5LaJU83OTnvl6hJuqQgjNsoZK81EVgkAn9/Q6+H5TNXD6F7MVkVePE5WhU=
X-Received: by 2002:a05:6402:1ed5:b0:62a:768c:2223 with SMTP id
 4fb4d7f45d1cf-62ed822c5eamr3173105a12.11.1757684492248; Fri, 12 Sep 2025
 06:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com> <xmqqms72rwx4.fsf@gitster.g>
In-Reply-To: <xmqqms72rwx4.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 15:41:20 +0200
X-Gm-Features: AS18NWAza63yKCaLsWA-qRjANTXPcfRYSrCeqbAi0Fci6HvOMetwlhv5dfJ29tU
Message-ID: <CAP8UFD39y8Xde6CD=dDyYy3MY1NOaZGVuwk4zPcreA5KbKR1dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > +--signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > +     Specify how to handle signed commits.  Behaves in the same way
> > +     as the same option in linkgit:git-fast-export[1], except that
> > +     default is 'verbatim' (instead of 'abort').
>
> I forgot one thing.  Earlier in 1/2 we saw
>
>     The definition of 'enum sign_mode' as well as its parsing code are in
>     "builtin/fast-export.c". This was fine because `git fast-export` was =
the
>     only command with '--signed-tags=3D<mode>' or '--signed-commits=3D<mo=
de>'
>     options.
>
>     In a following commit, we are going to add such options to `git
>     fast-import`, which will be simpler, easier and cleaner if we can reu=
se
>     the 'enum sign_mode' defintion and parsing code.
>
> and I was implicitly expecting that both commits and tags would be
> supported on the import side, but this only deals with the commits?
>
> Is patch [3/2] missing from the archive?

Yeah, the commit message was too optimistic about the features that
were going to be added by the next commit.

In V2, I have changed that paragraph in the commit message to:

   "In a following commit, we are going to add a similar option to `git
   fast-import`, which will be simpler, easier and cleaner if we can reuse
   the 'enum sign_mode' defintion and parsing code."

And in the cover letter I added the following:

"In the future I also plan to add a similar `--signed-tags=3D<mode>` so
that the import of tags can also be controlled. But I prefer to
validate the general design of a single new option first."

I hope it's Ok.

Thanks.
