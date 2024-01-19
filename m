Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D37ECE
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629312; cv=none; b=jr04BEu6U6ylNjs2EJWKs09arlUCpoOhkwVJGOcVRIyJ7ixibkv6GjgO17ozVcFsZJ/Bj5AK5zg0JIorCzVkrLkH7vs4qj1dSV6VI3dZjunKmE6e9BBHC/ul7+b7k6RI5AQpSEtDkqGyFmjSmcgc1JnWgAMUwvuWxEOvIEsfVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629312; c=relaxed/simple;
	bh=ud3nlbWvgAIElhK1JCkoUIknU+13GsEVUaVvg+VYxM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c46wpQ5asEu3LSTW09S921E8Yj8TqcLC9N/SFqitdA7nQmtUiaJE799ft6Ch1hsasnJeY95k0f5octPJiXad1fGqCfcf0MDUYKnPkfaTfxFoex1nNMAyi6TtoeK6hT7j52o+b/Uf4G4YyY26e/1uxGmgtWoAAyAODNLkKWl5Li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiASgV05; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiASgV05"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cdf69bb732so3293031fa.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 17:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705629309; x=1706234109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4pb1rK+x4tzcRZ/W4wO3OmCXsLOr8rVhUS38cehA0I=;
        b=iiASgV05+b3setU8oBBVMUbk805SCy0BKTaShGcjqr34TiDWBk/3s7AEaeOAvNdkFD
         IJLnJzUYsYjiinVAgwg9SkEBpdyQlMQOyxLJmEHuEHO7SP3P4+mvk10l5v/fAcETlyVB
         GIs75vRikiGtuuzTy0szWrnNR2sN688gx6AvnseL8rhVry/S0gvrKEb63XLy6q2dbir3
         55ctpb/2Hi9qOk7eUrvSpNJP6CAc7HH4dU4Gg4oxDaeo43H2uQTjoppGkHdiq3x9CBhR
         OUiyubHFQWAtAhF2MDSsL52gG8nGhH0XoemWuIoWdetOuy3Y1t5s0t45nM6L/E5KmcUQ
         RZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629309; x=1706234109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4pb1rK+x4tzcRZ/W4wO3OmCXsLOr8rVhUS38cehA0I=;
        b=rA6jHI9uB1/g3ekKDKKWYArX3ofFLoLsqV8jswsNrw8GUGq/5N+KuwMUGgEHs0RXb+
         JEdOdzfPdi2SsMj39hhx4tLf9Yc9c4Wqnwu7iVeBzM4VF6CGJIfEZtI4KwrE1AQiy9co
         LdbTfNRQxFTJ6l16LjHD5Zaun07qzFRZKTPCluFrN/iFELAZ3wI/ja0I4GKMPZ3QPmkV
         x6PkXZNa1Dn0ZjYogOmfj73H7rLIVtC+Jcc7UUUioyXrg2X56+dkVLSR84LgP1BRAD+x
         g7EEh7qTs9hF406Lu2J/akQ2TZYCi+EEL/hnsY+QeBnaoA0SiADshyOqkVV2hvpPFZVK
         9Osw==
X-Gm-Message-State: AOJu0Yzav9w9trEvo4VxBfb302msAPg/z8bZ8Ex5AkwOqDdonbKZQbre
	qpG+hAvU2MtHwGRhrZoHZAfmT2eSQ/1wSLDkexzIELtIZ4cj+CiYeea4zA3hWgKtp+AoUb1/Dyc
	tqZ946rJbSXbJQxVySORce7+6JGU=
X-Google-Smtp-Source: AGHT+IEH8EZ2ysD498Myfa/6ROUJrA+qWnhIu+KaQQCAjpThu6LUx/NCwZULX7r30De0RPayfG9LorrUEpvQqpf3BWI=
X-Received: by 2002:a2e:bb86:0:b0:2cc:e9be:90c7 with SMTP id
 y6-20020a2ebb86000000b002cce9be90c7mr402997lje.179.1705629308779; Thu, 18 Jan
 2024 17:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
 <xmqqedenearc.fsf@gitster.g> <CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
 <xmqqil3x69dk.fsf@gitster.g>
In-Reply-To: <xmqqil3x69dk.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 17:54:00 -0800
Message-ID: <CABPp-BEaYkAPphh06R1HrfD03WTv5uy-2q-T0ZMZaxo9hfXv-g@mail.gmail.com>
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> I am not very happy with the hardcoded 97.  You are already using
> >> the non-standard 10% threshold.  If the delta detection that
> >> forgets about the last line is so broken as your proposed log
> >> message noted, shouldn't you be able to construct a sample pair of
> >> preimage and postimage for which the broken version gives so low
> >> similarity to be judged not worth treating as a rename, while the
> >> fixed version gives reasonable similarity to be made into a rename,
> >> by the default threshold?  That way, the test only needs to see if
> >> we got a rename (with any similarity) or a delete and an add.
> >
> > Oops, the threshold is entirely unnecessary here; not sure why I
> > didn't remember to take it out (originally used the threshold while
> > testing without the fix to just how low of a similarity git thought
> > these nearly identical files had).
> >
> > Since you don't like the threshold, and since we don't seem to have a
> > summary format that reports on the rename without the percentage, I
> > guess I need to munge the output with sed:
> >
> >       sed -e "s/^R[0-9]* /R /" actual >actual.munged &&
>
> Heh, I was hoping that we should be able to use "diff --name-only".
>
>  $ git mv Makefile Breakfile
>  $ git diff --name-only -M HEAD
>  Breakfile
>  $ git reset --hard
>  $ git rm Makefile
>  $ >Breakfile && git add Breakfile
>  $ git diff --name-only -M HEAD
>  Breakfile
>  Makefile
>  $ git reset --hard

I guess we could, since the only thing in this repository is a file
which is being renamed, and we can then deduce based on the setup that
the change we expected must have happened.

However, I didn't like the deduce bit; since --name-only only lists
one of the two filenames and doesn't provide any hint that the change
involved is a rename, it felt to me like using --name-only would make
the test not really be a rename test.
