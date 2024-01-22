Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3748CC5
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938559; cv=none; b=ij1NKvcaNYp9ZV/nTkjlxWE1uHY0cwo3sHMwBnKb2tPpzZaz9dIumy7AwCVAdxYaA48k/Y3H3OQOHQ9xqLmqw/K/AwhA2VbFFTiiQTrAM967juc9IQZsuYMdrY/w0KyfD1sLcK0MF2bBOI2nF6Is7J82SMcr5wAwKzM9aNR51/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938559; c=relaxed/simple;
	bh=yKL0lEnW3nHaXcPuXsVC6Z2LufoFmYAJ0Xi1HVra5wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxujZkqpXVEr1PwGRxFq3VVv/fd115VhaqLGRPfsD7GtZVC5Dfa0eYHzRAG5dp4NxxjODaXiM2LYfWvovLVar1HNT2ow6k0H5ydFzmcHvnigfV/FJCd4Sc0b0HbPuaQkdpbZQc190uvtCLmW1zzXmDKW8Nd5AQsCa/7XjkFy28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wro70sCy; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wro70sCy"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2144c37f3d3so310599fac.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 07:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705938557; x=1706543357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKL0lEnW3nHaXcPuXsVC6Z2LufoFmYAJ0Xi1HVra5wI=;
        b=Wro70sCyzjidVc9Obn7u3OJBwQnnVM5HtR2oDxtiYVv8pjRtAdFq3piTaKV33lecYq
         Cb5/xpNcM16hQg8dPIbNjRnzuMW8oix+/qc/ISWCHc4jFzi11wB+yVnAmxfQgUUWLhNc
         i2A8pc6CGchNyrDkA+RS17mo5oNKavBGInowQ54xCFaIvngkO8P65ZOj1mI8tLm/Qh7X
         0b92wR+r3rzS3/MiuTo6/sI+peLbLjrClqawo7d3xuVNpxXTHcOXkS95Yfey5IoYWg8o
         kDP7ef/p1vONhK7vhDob5Qptyhq66BINoa0raIYB6VZsV9Sp4/Jvz+8jvB4FdYiYobhI
         jP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705938557; x=1706543357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKL0lEnW3nHaXcPuXsVC6Z2LufoFmYAJ0Xi1HVra5wI=;
        b=Y6JE3DR22mxAPwOuQeujVy5Vc3ULc0ICb0vd0ddxEnphGJwRe9QL0R+m5jZtWcYgJg
         Gfd6djxjcPTDSS021r6Uwos3o/+u8fU+UvIrIHUv+D4iyPr4CqUfKAyfRDEmqIpF0qnK
         VKFCiOVe41zVsKiaH3T2MPov2gHkkjWos/MX81hyMM/NKIx2suVjDb69XNdjgN+XrXyh
         kRUd0aXN86Yr7jqlQQDZS+wwQkfPOhFcsVtVNgae2Bum0u5SSw/eB8Yg0rIzOu8lpgm7
         DLEpJ/ah8bYzXqzgIlWjQa9EkbN7xgJay6i4GcooyuOn3PzTlanehnzxRqQcrHeJ1MAo
         kXZw==
X-Gm-Message-State: AOJu0YyE5YK3LozUfB0EfIod6EC4vnhOegI2LINNZNqvpPeHlevWRDcc
	6N5v7dH7aWQ1R08D2TfMnqBPhOmrok0l0JOLLqMntBAMH+gVIvC1LVK3wxllpHGisHEXBJu/UAW
	k13t90SAffY12pqF2hdE3yvGlMY2Uq1hGrNs=
X-Google-Smtp-Source: AGHT+IG24RDarH76fs2CsS7Xh/H+LMdzOluu/bpMaHZqzT1+e0vEIf3Fmc70C4X6mZWcexkNx6q2waGUVX3l1W6sKrE=
X-Received: by 2002:a05:6870:1581:b0:1fb:75b:2b93 with SMTP id
 j1-20020a056870158100b001fb075b2b93mr101758oab.79.1705938557531; Mon, 22 Jan
 2024 07:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-5-karthik.188@gmail.com> <xmqqsf2thwhj.fsf@gitster.g>
In-Reply-To: <xmqqsf2thwhj.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 22 Jan 2024 16:48:51 +0100
Message-ID: <CAOLa=ZTbtqvejpvNVY5MHU=Adx3tWQ=FqVJdRLG1gaxYu4BG7A@mail.gmail.com>
Subject: Re: [PATCH 4/5] refs: introduce `refs_for_each_all_refs()`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 9:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> This looks more like add_pseudoref_entries() given that the general
> direction is to have an "allow" list of pseudo refs (at this point
> after the previous step of the series, is_pseudoref_syntax() is the
> is_pseudoref() function, and uses ends_with("_HEAD") as a mere
> optimization to avoid listing all the possible pseudo refs that
> exists or will be added in the future whose name ends with "_HEAD").
>
> Other than the naming, I think these two steps make sense.

I think overall the naming is correct, I would change the comments in
`is_pseudoref_syntax()`.

Because, apart from pseudorefs, we also want to print HEAD. This is also
why the pattern matches "HEAD" instead of "_HEAD". I'll add some more
comments to clarify this.

So to summarize:
1. `is_pseudoref_syntax()` checks for pseudoref like syntax, this also matc=
hes
HEAD. Will add comments here to clarify that we do not actually check
ref contents.
2. `add_pseudoref_like_entries()` adds pseudorefs and HEAD to the loose ref=
s
cache.
