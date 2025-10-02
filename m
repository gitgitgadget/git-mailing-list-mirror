Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A721CC60
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445737; cv=none; b=aiJUSW2a2XcSYbrWTOf5zI/kWkT2R/PSREh4Qs7maWULT1FARDLbSyfRnEfqRlPmt88vXoheXhtJC9sqt00lIh2L94zB0bp5LMftYmP4Ozgh3Hrwcd0eBEVd8Z9pVO+m3w9mYhYrU0Nzy6VpC66wJxgD+/mCiQ6/1o8rpI+Xpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445737; c=relaxed/simple;
	bh=bfboVfNX4yCMrPffs1micyGtSVGItmbIU4GNNYn+uBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A066eX4ID2GXO6xBxeQXoGAtzuLFSA0xCsQowKBykMe6/p5iKUMNvZWkqEa7/Mur7vYSWggEHTfPnD8QNm7AEIRj+3MY2p6XseFWEAVs3v3jVMYPYU6pqoACB7+6I2JI1cvlj8A6M3SZcicFuzGhibRXrCL3bN1c6jUtH7Mz5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlXN06qU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlXN06qU"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42576a07eeeso15992035ab.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445735; x=1760050535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXd4oNhqo+lLFjbLzAp2PmbKhwardJ3n5HEyeU4PYj0=;
        b=TlXN06qUquQuVyWQwplNhpWZVchA7QlGXFQtJidWU2P588j2/uWuNCXPgldqRNllz8
         tQNtuBs6P7WxRb3TDo9Or1ItTDDyoyYjS+r01pnkX8VQOAN++tx7fF1L3kgsi0aqEmfD
         xqjRUNwtvAfmFGjCwiwY11M4P/buYiL4xriRC/V6Qe2QTCzXifHGLkrXpl8LNp6Gqmzi
         moJyk9WlVDAw83ypzuTgD5sDSv7e3vj1VhOaFWbgk5/bZ7Yw8wsuzJxmflNDlZ+0r1Tp
         fRN1aNb4K02Eb+25wyHvUTSWBCyWglrDgqWEiKH2iCmepjwNomPa56IC7eLsXGnbJn8p
         qEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445735; x=1760050535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXd4oNhqo+lLFjbLzAp2PmbKhwardJ3n5HEyeU4PYj0=;
        b=gDzB86xEq2MM3AlOwO3c/sFX7kBer4tzAU1JZeXuryBOwlxat1NsEAPtkm3Gr3M3ma
         9HTKBL8NuXoTCR7CNCn42CCbxOgz6J8pYs1ukTI7ro5qwdQymV3CvyWgJb/nvWT0S4It
         Ptpne7m9giIzxfIkTjBIXcZTmW4jK8r9mF1eNouP3fEth50lIW8R1bfhk4UcvN+XEzcX
         tdLIITRVEXEcy09T/LaHQp4kKsWLLkkZ1NS72z6OmDLQ+mgcLO1Ak8/LAY56Sf8NfXK0
         JvFeN5sgrnOcBxu+UCy/BGpfIg0j+NLigEpv2hKpp1b7+zMIsJGPiMFG4nwAMmMbvTk4
         lf3g==
X-Forwarded-Encrypted: i=1; AJvYcCXmDI9NiFfI5kpQNB+h6eBAQBurzsAVNOZOpMkgN5osunMMml37rsUNahXjyVOUgN3xd9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyel0g+X+068nAdYunP+cUAuulPdMlrIj4okwWwvGZq9Kcug8kV
	pvouAi/gEh+fM8QhJ/YanAU7hUba+k7+OxfnLIHQvL1Ew/WBL5wcrpcKOP5/pvhQg8dNbuJJKoo
	dmaD2drYvoGcMwoB4NyOQ2lFyf+a6Gi4=
X-Gm-Gg: ASbGncsJLMIudPrSrsuPrHd1Po1tYi74J0lo6/zjCebksO6b40PC/yjmOEEPJ6ss0D/
	q8HApGGUe2X6JfvmBgrJz6zKSl0wbgrgZmMWKEdoOPXjML1zYQjwfdib2/X4C5Xjq8nN40MuhZr
	+HEmFHfipy/hOWoLo7e8DkpDUoG7HoV0YjFcVpERy2GiYMhJVVeQYTL9ZaRJBfSAkL8ECbALOqQ
	7bUelYyqDCsWSruO3lP4zF3bBQqTaXRyznJj3K/bJZz
X-Google-Smtp-Source: AGHT+IEdoS43k9r/5HteBfJ/g++5nS8oW/l9+rmBA+LptbeHYfxivnwDa7hFqFKpAw0lP2WhmvsqYQEdUz2OCeE9HjI=
X-Received: by 2002:a05:6e02:3807:b0:42d:8c07:70d2 with SMTP id
 e9e14a558f8ab-42e7ad1ac9amr12557355ab.11.1759445735402; Thu, 02 Oct 2025
 15:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com>
In-Reply-To: <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 2 Oct 2025 15:55:22 -0700
X-Gm-Features: AS18NWA-aUm6CgnMIMxVOtGxYmqlS55N27_lNMjfBd3B6SanIwbOB9vfiVgLNeA
Message-ID: <CABPp-BGcbdygEjndAjXo9utUhTac7JTHscX4iiwk4UZcHonXvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Excellent review, I just have one tangential question for you...

On Tue, Sep 30, 2025 at 1:24=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Sep 27, 2025 at 1:09=E2=80=AFAM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
> >
> > The git replay command currently outputs update commands that must be
> > piped to git update-ref --stdin to actually update references:
> >
> >     git replay --onto main topic1..topic2 | git update-ref --stdin
> >
> > This design has significant limitations for server-side operations. The
> > two-command pipeline creates coordination complexity, provides no atomi=
c
> > transaction guarantees by default, and complicates automation in bare
> > repository environments where git replay is primarily used.
>
> Yeah, right.

I'm unsure if you are expressing disbelief, or agreeing when you use
this phrase.  Most commonly when I see it, I assume the former (see
https://dictionary.cambridge.org/us/dictionary/english/yeah-right and
https://www.merriam-webster.com/dictionary/yeah for example), but I
think you've consistently used this with the opposite connotation.  Am
I correct on that?  (This is a particular phrase where tone of voice
used would be really helpful, which doesn't get included in emails
unfortunately.)
