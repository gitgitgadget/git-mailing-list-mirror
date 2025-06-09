Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC213633F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503000; cv=none; b=kZlnIu5uK6L4EOCc2dKTg+P1ZTyYjJfWeu6vQqg9hWL7CnflYS2YpOGsJa3vhMS1akJufP+pLUgDF/K1l6d7OkvgfAAJv4KKeNwF2600+gMG0+Zs0R7HZypNOau+Ta0NwKacGp62V18te0eJUwYL8de3CNajgawoIMkhCDpfQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503000; c=relaxed/simple;
	bh=U5HMLVgmoyO866dZYm0rsu2SXKI5SMVLDI86a2TE8Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyKFHYuwMWa6lJuthay0ZbPtdzEeOVL1azEFvrqHaAMR3PtWlAFfNJLGAXD8ualQ9okpJxgim5Xx5gxupQ0nU7r4Kv16svG8AZUAB2RROcHYwuUk8kySTtVIVqYmygh6Z15EFRNRhL5ndoPfbEF7P1eirqoMB9NImMrMCdFfyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIltcQD8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIltcQD8"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade30256175so601382866b.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749502997; x=1750107797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5HMLVgmoyO866dZYm0rsu2SXKI5SMVLDI86a2TE8Fk=;
        b=LIltcQD8p3H2G5V/cCisWaAwigbCIeNPllDaFpLkxBiMM+xyWEl7fkEnyfsauc9DCM
         j4kW0eFwXvFXIB+sETtMH2ktuPsbkCcVQwHe4CB8Af4nIahEw363gGeo9kdxhq13p075
         l0juN9ayAU0NR5iVzAk7+eoYfU0bORGWcDGSMhkyE/RFcrYfnSshTusylcKzLGaEOsQi
         GWpzlUNuQgG1jquSx+CrP6tRA/hmy5VVCUcsaaBUSEg1VYUHjZ39DtWg9e6dzTIJd8V7
         YpVsGNscbheFpvTnly6Usm59NLPdcd3LYbMb7Lx9EcGggP9kFK0C/yph0u5oDxtAVU6B
         C56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749502997; x=1750107797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5HMLVgmoyO866dZYm0rsu2SXKI5SMVLDI86a2TE8Fk=;
        b=GOsfipH7+reoJuM+MiAu9CAhBfftH1ILOvMO6UlrCTJ8kj1B7ol+VRn8rMLhidJcgS
         Lw9CiMkKgR8ElR3cZNVa8kRI5xq/vRFDx0tg6nEFcGlDlSHZNyXG3zm1oRVFnBJi3xkg
         +ASnsiM8oH+2NNElZIvFXbLxCJ8rbFB/BUr90OnDo+lKShO+VzIV+oPgR7+T6la1PZlP
         rQYrxiL5Z0vIzMTWE1Qud/AeCCnLmPTYpHzPADAJJH7QKbhAeamRUd85rZ00YeYlpT00
         s50Ig39Ak5n4buljlQp2elbfH+xpiY2KgFgzXv+duuKIdNeKTXWTbWqEUWQUOvmkhmOw
         EUag==
X-Forwarded-Encrypted: i=1; AJvYcCXMKu3rvC+1kwjq4O3t3lc91BEVhY9YsfbixKAD6eLwF1AyHm76dSyUljaEUeZR04Vr0t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaRpeYhEdDN3NmCGRpV0cUWeSg9/XqXXvTJyvli6rth+zSoKz
	4V7uUS/jJxIp/jfqEHaL0BEi6fephCJajGHcrbo1aqIJvY2gVtU96Bd0u68hY6w38675+n7N+bf
	x+SWk1RH6iwzbtcpv3+hM6/EVaRClDnY=
X-Gm-Gg: ASbGncsydkxXIVjRclaL7JIegwYHaUB5JzukqnZoVKNNQY68IhwyFkRnw0efIYPUAnO
	i5P0WM3r13sx5z/zbtVAQi9IhgxTaq1DKRULMt+W2lyMqsRCwd1dv4KzWs72exWYtpkKbX1NYiw
	NLXyxIoaUOSdXJz4L2vao7ysbt8w3NaeozOZ1A5YG5CzF35Y22JK4YE+zMbdXjGInLCKr8lvRbC
	hjH
X-Google-Smtp-Source: AGHT+IFr0IC4OJKmZGnZi23e2tIU7swEQ2B05WFa9292/SDP15QxRn7t9r5SukLBhHwd1663KdBGmypbTp33QE2xpLQ=
X-Received: by 2002:a17:906:ee8e:b0:ad5:7732:6759 with SMTP id
 a640c23a62f3a-ade1aa471bcmr1378660566b.53.1749502996311; Mon, 09 Jun 2025
 14:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
 <xmqqcybcrc2u.fsf@gitster.g> <CAE1pOi34+btHyV8GbjpFPcJ+2ixu59ce4eAE=Q7F4JEcuJyXnw@mail.gmail.com>
 <xmqqqzzspt0i.fsf@gitster.g>
In-Reply-To: <xmqqqzzspt0i.fsf@gitster.g>
From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date: Mon, 9 Jun 2025 14:03:02 -0700
X-Gm-Features: AX0GCFvXvWIeiWQQ2j8aWxK0NbApOo4HdUaRU2LITjmG3TZNQntd-gbPeoo5tOk
Message-ID: <CAE1pOi0bFpuGuFSEHDUgv3mcwwwgXAEn8q3QSwF33ucqFWJ_AQ@mail.gmail.com>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Clearly, I have not used everything that "git tag" offers. :-)

So, to clarify, I was thinking (naively?) that Git would check that
the tag as requested is _exactly_ the same as the existing tag. Only
_that_ specific scenario would then not fail.

On Mon, Jun 9, 2025 at 1:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
> > Does it really make sense for that first example to fail, though? "git
> > tag hello v1.9.5" is an idempotent operation, isn't it? The second
> > attempt is a no-op?
> >
> > If "git tag ..." simply does nothing if the tag already exists (as
> > requested) then that would make the OP's issue go away: only the 2nd
> > example would fail.
>
> I do not think I personally mind that direction; when I responded, I
> thought that in the example, 'hello' is initially pointing at
> something entirely different (perhaps v2.0.0), though.
>
> But it may be tricky to do, though.
>
> It is easy for lightweight tags, but you'd have to fail an attempt
> to add an annotated and/or signed tag without -f anyway, so you have
> to be prepared to answer "why does this behave differently with and
> without -a/-s?".
