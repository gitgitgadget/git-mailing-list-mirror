Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD026A0AD
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591070; cv=none; b=XWvn6JisAIk1Qo0mU56D/l4oy+bD4jiJOuMBr0DNbvKlt/1j2a88vRGKhq8ShDpKfJFhdhQSSEAu3OSC0CZ5jGySSzy5S66GMqeuIlqovmOG0bfT43WXvkGaPcQU6LtO/GT+gSm/79/tkyDpv1xXudHtGaYRCVWCYEb5pvCY6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591070; c=relaxed/simple;
	bh=kpddNoKk8Ff/SQvGqVhx41VWSjI5bhef/46A7EKZNoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKL6hVhcjkGnnSuX3fSkctCIfCFJvlUxaLuT9TrUxa0U4ahHNUubgSh/Ninfi+PSO1UipgYM5KnZ2i7BxDOkgseZ29joD74PyRlZqVMFcQ506lGXLmjxiYpS8WG4aIsfLFQAM4avU1iE4H4T75yZBmFvNusBhPBxk5KFQbLMxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ28ucSJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ28ucSJ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3612c38b902so46794761fa.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758591067; x=1759195867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBRzrnPmUZpMtUtDeFah+d56vmHIIpJxcf8112mmcHI=;
        b=lQ28ucSJX+fXs4kvlvL6vwX+FbAgL+qYUuTXJS1MGmh4NcFi0oufMKCn7bcrpOaMxj
         7wcQdtfkgQWqxc6/0pIuhZgN35UpURNmC/cnJUwpIOyRa8sxkGRTC8VAupeZPuPDer/Q
         j+WWwiPn3A9b7siyNmr6SFuHfSrWwE43BK0+MmfZRPqZ3lNtQRix2Wo728ThxjtQ9/b/
         nGKNXW6UKBwJ5GW9pRWjs0A4kbTQ+1Scb5wZZkqP3z2m4QseGbSWUOCY3a9hc9+3rd4p
         YieSeE0eFuAK+mlh13Ig9HltqBKVxewZ2nB5xs2IsxSPebBL/amO4K3bm5rQdnWnyYKB
         /pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758591067; x=1759195867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBRzrnPmUZpMtUtDeFah+d56vmHIIpJxcf8112mmcHI=;
        b=b83u01sUp8pSZy3XYL91zRtKFQpuBu1lY0ESM/KpwWNsjzLb8+uSlKxaz2uq17xgHS
         diA/BtSSqBy2epcumoi4OTWdkyj2zYMmrC9uR/i74KXr6y2FeAEx5vHsVMe7d3BIUV8L
         0GltDK36PAS3niiMpL+lV2cf0VlmazHWzB70Az3nlLZCwqInxjpimBu4ClCAqoI+D4IX
         Ocd7nRF0eNUIgAJZcGI8hJusaNg/R/+cTWfRQs9JJeYVt9qut6y89RJ6Tx4mvoqB1hMv
         AvyyX/sSKLp0z1oFfzagMDaB3bqfb+lYzQ+yNoIvDpguEr8Tp5TXQ3V0BVynFvzmnutf
         RZUA==
X-Forwarded-Encrypted: i=1; AJvYcCWzq4kTpK8XTrrG5tlH8MACQ7gsbqWiRJmthZ3JuUTwJyxHq2Sd79lmRfImstAfPg/SkTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3i8oAXxrtXpOykqMfz6qQ10w6TEHXFEfxzmgDlZi2gmW/4eCz
	Nc7Aty53cTlNvbJnNkqqtTruH5hEYXGyAIPaf53VA5191A1cAY0P+vBJ7NEtJwQsCThgtnLXW7V
	PzFh1o/4fWzoOqdDlsuzK7US32DVMRiU=
X-Gm-Gg: ASbGncvIJMuM49GzC/y3+UvJIlP8MuIGwU3C5DyWmTg5gXcNRevxwwVP8wI7h6l4eLL
	MwYzW4+B3ewbHGigPO/s0b4JxAm4Bw/U8cYS6/S/fToKFaJ0j7u0ARxAEoN8wMVtv7QeLv3LUD/
	WSTenxEClOVft+3B/MXs5lCkcvYw2XlptEHrUro3f10Ewx4mcogHws+lTLcM/IegnMuIt+17HvB
	O/KkGQe
X-Google-Smtp-Source: AGHT+IEjPU2UdRFNntzHVwGG26bb20LZU6Pem/6cl9nMkb6ANAeA3wUghnrMZ3e4hPwtyJ+rDHbDTPGZCKNJrSkyyXs=
X-Received: by 2002:a05:651c:4094:b0:337:e0e1:d11e with SMTP id
 38308e7fff4ca-36d15d460a3mr924341fa.18.1758591066260; Mon, 22 Sep 2025
 18:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com> <xmqq1pnyru1f.fsf@gitster.g>
 <CAH=ZcbC5Y04D4bGjfH3rZ8GKabDttFez5qb9i8mXVsfE3LF26w@mail.gmail.com> <xmqqecryq8o9.fsf@gitster.g>
In-Reply-To: <xmqqecryq8o9.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 19:30:54 -0600
X-Gm-Features: AS18NWD_Df8v9rwhvaQJj2NZ8M21al-gl8IB5zNn3ftW_PSX0GUEku8SMUcFKI4
Message-ID: <CAH=ZcbAHgCLjpLMzditOg8CW-L1RPohGuQjst=h-rATTSoio3Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> > 'changed' is NEVER EVER!!! assigned anything other than 0 or 1 which
> > strictly makes it a bool. It's easy to mistake that because the
> > functions in xprepare.c that deal with NO, YES, and MAYBE are within a
> > few lines of 'changed'. Please re-read xdl_cleanup_records() and
> > xdl_clean_mmatch() very carefully. I will update my commit message to
> > make this more clear.
>
> OK, then there is a variable with some type that is _not_ bool that
> is used in xprepare.c and the code that deal with MAYBE does
> something like
>
>         u8 current_state =3D MAYBE;
>
>         if (the .changed[line] is NOT valid)
>                 current_state =3D MAYBE;
>         else if (env->xdf.changed[line])
>                 current_state =3D YES;
>         else /* false */
>                 current_state =3D NO;
>
> and then use current_state as a three-way variable, perhaps like
>
>         switch (current_state) {
>         case YES:
>                 do the yes thing;
>                 break;
>         case NO:
>                 do the no thing;
>                 break;
>         case MAYBE:
>                 do the maybe thing;
>                 break;
>         }

I apologize for my previous phrasing. I was not very tactful. Yes, I
think your suggestion is a good idea. I'll incorporate that into my
patches.
