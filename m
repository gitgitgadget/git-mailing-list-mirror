Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED8521CC56
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280707; cv=none; b=ghnpdiOEaZf/GgvIPdNZkz3t91e/7ViMeepjoIUDv/YHTASS5a/SVAieq/zagDq1UmCreTgwXKamtkHI+c1dUtG405cABmdtNNI/lkgr7axNmsgbcQ6JjCYO/X/AM+ivYQfHwV0UslsHOEJM66StqxR5DDmHOn0GDkpHicwl88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280707; c=relaxed/simple;
	bh=SgeZWT1uCR7GSrj90AWKRRFjudpTt98sTX1zjZE1/vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcPFzr+SldhQDGrWcP/0dn26pCGXEh31pXex18OKvKwWZqTXtZZBlk/n0UePI4XlMl0POiVuCQ+84EMGxwFHnM4aER/zCdvjLP32+XUh9Mm6Nrv9p1CYCuJcHpHnv0LNR0DrFLJhbRA7G7AxW+AY4RHBkEu3HQugJfBJ/BoJOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpEuAhp0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpEuAhp0"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7042e50899so1018296066b.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762280704; x=1762885504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS6OCX1zDH1WGkQagcDFeUyKtwyMxpNZUdL2cZbqWqQ=;
        b=CpEuAhp0WTjERBkyvjx9uR+9rV8Hlp1cs987reFi7bIQwUy8r4txhAFEc/JqaOX8Ab
         fbUSWsHrG1ExA6nwHbA6GuwYbkW3zU7ThiWo47KtNZEylGkBwElqEAF1yHiPSGYncyVF
         bFjysShVlYhOl+BnpF69cLfkpkbiu8cgvJpDH3ybb68GQ8HbIQIb141hSAOUot2YAums
         ilOfdIi6s8VS9NiSBF5ksIXXTSj78xTB8lc4bZVO3/DFBUdzdSeMD3Iz9KpzkepZ+lmd
         +PVjGu0G1pWfE7nwem30aGVz1JGIOGgZFbCjYennQP4KmlU3+RRWm6NI9zIsxU0tNuEg
         4iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762280704; x=1762885504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS6OCX1zDH1WGkQagcDFeUyKtwyMxpNZUdL2cZbqWqQ=;
        b=taHo/DxchbCj8Chztp3nRR+y+dfpx06swcNrwsf2axr6nH2ggmsGfwv0/df54Yjyhz
         Q96OtRGoGsgYgpDW9vqK1HSM2pzaMAr1IR0+zJNj4fYwRR1NtAqe+U3Cc+TLxKQID5Co
         Q3wIa6+aol+cLFErAVgcoEWvNfUgEGibkmw43hibJd9wyceq3qe80PVoYK2HKfqabnGl
         Y+hU8vW6N6sYAagdc6bYGNYW0ZyUWZQ7Rq+aD6uId2xkwgHm1y28oVZMZJ4Mzjxp2Rcx
         XyRV5mE9wr7ZU0F2yOxgq2ghOoWnzy0VXNhS++KsCk4hAiaGUvTBDFIN0irXSeKiCSg3
         WwvA==
X-Forwarded-Encrypted: i=1; AJvYcCWnmlaBmrYgORr0MHqih969XHslRcyanFkGxc2ZeXi1DSCdG1BtGAb9fApaunNAyC1EbtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TKu5Gr4o9vjHaS1rUxoQwTwHHYxP6YeTsQLQrbLwwU47k/Lk
	vM7UPm2741836vDcehVhH+oIl/pTmgokNNMub99P1ZP9E5wzGnYYjvhE4qusJ2U5yualK73UaCK
	3DVmWwBm4KGr9fcRZmmbfONHrgXKYaRo=
X-Gm-Gg: ASbGncuAoVx5ZC7I8KF2LOYeZ3CPcWAkcMkuhDVvsquNYQw6M+j8w/hSknC6mFT7r6D
	G20ggswTj0SHZMhPKLY8C09pKqoISUHBcFRLKXmcnkppZUmRNt3eAWV7KSxUX9W3HGTbVqx1ANn
	kOI57oTR5DhJckzrF/01qyz8jr5Yarv+GDyRQ6Vx/AGJlgmq5LE3LfO5ojAO+sKS1rtJBMiDu/F
	XpKm94KH1HLXrs8y4WXtICmGyQOOf5TfOiQ/8keMBQUXTBew/ApCIMwNo0LYJ/iCYp9vY3nnhjB
	wZLlhgYpBuIz5EdxE8o=
X-Google-Smtp-Source: AGHT+IEpjZ9lGLwHzjAzg84K9o6Uo6rfGAVZDDdASd8tklRImheUwQHNDToc03q2vEetHrQUGztFDQq5ZBphpE8nB8Y=
X-Received: by 2002:a17:907:3e8d:b0:b44:f9fe:913a with SMTP id
 a640c23a62f3a-b726564a973mr9836466b.65.1762280703623; Tue, 04 Nov 2025
 10:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
 <9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
 <ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com> <xmqq1pmdr9qu.fsf@gitster.g> <xmqqwm45puqr.fsf@gitster.g>
In-Reply-To: <xmqqwm45puqr.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 4 Nov 2025 13:24:52 -0500
X-Gm-Features: AWmQ_bnsHl3fdruLikjhZgh4jZtbKuU6amk3Dpwmg0pBiJuBYWD70dyx_6hOS0M
Message-ID: <CALnO6CBgTu4Qtr8xwPCerrpqfAf02SV-bONLOUgq0X70eDThfw@mail.gmail.com>
Subject: Re: [PATCH 1/5] parseopt: fix :(optional) at command line to only
 ignore missing files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >> Hi Ben
> >>
> >> These all look good to me though I agree with Junio's comments on patc=
h
> >> 3. It would be nice to get at least the fist patch merged in time for
> >> 2.52.0.
> >
> > Yup, let me do exactly that ;-)
> >
> > Thanks, both.
>
> Let me have this on top of Ben's 5-patch series.
>
> ----- >8 -----
> Subject: [PATCH] parseopt: remove unreachable code
>
> At this point in the code after running skip_prefix() on the
> variable and receiving the result in the same variable, the contents
> of the variable can never be NULL.  The function either (1) updates
> the variable to point at a later part of the string it originally
> pointed at, or (2) leaves it intact if the string does not have the
> prefix.  (1) will never make the variable NULL, and (2) cannot be
> the source of NULL, because the variable cannot be NULL before
> calling skip_prefix(), which would die immediately by dereferencing
> the NULL pointer in that case.
>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  parse-options.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 27c1e75d53..97a55300e8 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -223,8 +223,6 @@ static enum parse_opt_result do_get_value(struct pars=
e_opt_ctx_t *p,
>                         return 0;
>
>                 is_optional =3D skip_prefix(value, ":(optional)", &value)=
;
> -               if (!value)
> -                       is_optional =3D false;
>                 value =3D fix_filename(p->prefix, value);
>                 if (is_optional && is_missing_file(value)) {
>                         free((char *)value);
> --
> 2.52.0-rc0-28-g4cf919bd7b
>

Ah, that's fine, and I won't send a new version unless we need it. Thanks!

I do wonder about Phillip's comment: perhaps it should have been
`!*value`? But then something else has to be fixed because value is no
longer ":(optional)" which maybe was intended as a literal filename?
IDK.
