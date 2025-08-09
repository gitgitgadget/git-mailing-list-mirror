Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E628F6E
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750783; cv=none; b=ebTG5L51arFvmaDpqrN6WPEhj+q2K3MAMyJ+buk0+YpMmCnFeUkb2xcnkUw0ivi0ilC2TwL322nBqLZu6d6J5+q0xnpOmjkX873mk1SCghay/HrRDrDaddDNpIB4lSBS/lK2oADA8tE3WMUVeYA8ioz7EF9UQzvXzxsoc6Dxna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750783; c=relaxed/simple;
	bh=Fis44mRfn5STaaESAYWD71lP1DZAmT+qHuv/IMuIoYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTBe1MSfe+I5RKAxnsivJ71chJp1JpCXTP5o4m6nV/7yk2QpOwUgc4T+xq/R2JEnhJ8T6gJqk0qpGQ8zYx48OF1Fd0aCR6zZig7p5W27j4nWpA9AHaOoJF2aNXqAPYzxktkQoLfBd4pv80uRDcwMFjOe8kCdOGiXOVq+GVhDe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeTJD7sZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeTJD7sZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so6981993a12.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2025 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754750780; x=1755355580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9V1rnLkKf3j6dztSNvOW9Ap0M6BXEjL7X+LCEfpcDI=;
        b=TeTJD7sZZVN+/FBlVUG0d5zZ6CvcA4wBeX/G29Vh5zZxws75jCWNZZm2zXQeSg0UVp
         0Gs1LvWXJpGmd3o3uDWGDrh8ARYPyH2t0sxzHvihMbW2cZRypucOWanycgHw0AkilKRC
         A52DPN79sEwIHKb5h12nU61GX8daEOAPMpjEsJ6BlMdCXh7ScbsMTQ8jwF49uIAezqhO
         g6aNCTnpv6EmfbgZi2woT9HFC01UFPmmvVRrmmmWl0atbrzFuQL5Wgxo0OolDLKGTfCe
         49hKDKzzV/QLbMIQQ5RzUKdPQHPUR7AMfU77Vzm69CPhqQvP/KLcZEddfsHNgVBI9/j1
         0blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754750780; x=1755355580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9V1rnLkKf3j6dztSNvOW9Ap0M6BXEjL7X+LCEfpcDI=;
        b=W1oQObO6Ys33w0mJLFPyI6OyQWuIpsLrHhhW2C5Klain1pL1rgtE66FVcyhHFXmrH8
         Ode6N4MWSdRL9AMK+3/1FQnQj7PLKJy/9pAi7kYRmnGUgVGuvbysdlfkJQls+FXSDVIn
         cZ9Z3wjf0WPpplj58h7jXuPfpSleh+efdx5lEeJtG3tGpbOBikKoWGWT04ha0EVbdWXr
         ui6GZbKcmQSzUaBsr6GEe6rIiupwFSb7DUo7cAVApjKdpMWAn2a/JCT72vPfC2xKqGfk
         XSVueyD8xvMYpj02d25TkZdeC0c/wf5nYJZXoMNV7HUo4hsP6HxKDIQIQOe4Gxhi7N5y
         GYig==
X-Forwarded-Encrypted: i=1; AJvYcCXDh3CIlvQSUgTjLSvToB52oEiW2sWs/vynCwEl7NYbg+vygi02m1sm3bKlkDiOHcVLZRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSCw4qkQzzNwcAjDBb+6TAp6zaustQjhDFR+lmFEx6FbueZ6t
	pqPy1FC+5Kqn1o7Fs3efcgESxGUOjHWzuIF2hNOSbDSBmUUq8aE+rSpnvIJC6jfY6gBWavjJG+t
	QbY/WySK94v7l5zoaUVjfv6nFRd0F465QZt7o
X-Gm-Gg: ASbGncuSCRqjewR4GB/kDe8m46oWhKrT9tKh7qj5IlvK4e39KpPXP8O1zmbz1TnbxUj
	KtYf1JdjhNEa7CLpX2UAzqZuTKcXV39MQKm8m2tCIfQvN3s+14xcwy09Osu2E32DJlT8B8leAjs
	p9Md0LOcr8MiTWacNM0Yyw5ulTcwq7Tu9dNwZqEfqxoIiWP7hyXpMLBqaJRKgFaZeCyt1cRn1oG
	sH95OkvSJ2DciHR0Eer3oHHxgjCoFq/oQdu0slRQg==
X-Google-Smtp-Source: AGHT+IEqX0SVqLrsTxYJ2gf1PpW/pobqqHiHFGs5HalfCwHpNEAlSjrCIpZtzWTzH1W2Iw2vXQ4bPzSrWCkxA/5NX04=
X-Received: by 2002:a17:907:d0b:b0:af9:3f99:1422 with SMTP id
 a640c23a62f3a-af9a3c59269mr1121015066b.5.1754750779677; Sat, 09 Aug 2025
 07:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
 <20250808010651.591906-1-usmanakinyemi202@gmail.com> <xmqqldntkgq0.fsf@gitster.g>
In-Reply-To: <xmqqldntkgq0.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 9 Aug 2025 10:46:08 -0400
X-Gm-Features: Ac12FXxPdvodvPdUBQ8QTXA1szUP6RK8yRatEJocHJ6hAYyJcqGTBZU18lAtbQ4
Message-ID: <CALnO6CCRKuSw3FqqPisavafDrVR8H-8UtjjWWsK2oYeN1COLmQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] refactor t1517 to focus on help output outside a repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org, 
	chriscool@tuxfamily.org, christian.couder@gmail.com, me@ttaylorr.com, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > This series refactors t1517-outside-repo.sh to focus on testing
> > `git subcmd -h` outside a Git repository. It does two things:
>
> Thanks, Usman and Ben.  This iteration looks perfect.  Let's mark it
> for 'next'.
>

Excellent! In the recent "cooking" mail it looks like my series was
recreated atop this one, so I won't send another version just to drop
the fixup patch unless there are other comments to address.

--=20
D. Ben Knoble
