Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBA154C04
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669261; cv=none; b=ArOqoLJ2mm38WUs/BeY2iUSbMncgrijyVG8uBaD4oNpY8qOxMp/gQ1vtdWwH2o9DQfgzzQvSVWZloOiGlTmGs1RBhW55Q8EWsoUCcVSvsnF4wWvNa/yqAxW/i3YA03zENK5bU+YRN+NjywRF26jgZm0cgmxT1fi0PSGcATStGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669261; c=relaxed/simple;
	bh=2Br72MKLGRGJV5P7qZu9T4KHTLodT3v3V6wOWp4fIV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjy4Bz8M6ZLgXKpxke16eZDcY1JtCtSB1MCNUpjb24zzCLnNfoANtu6QGos4dZNRsAhftg6TSO3/hedDkZokU7+3XxrRohJe4Qnr64y7yjATceXczg4nG1Csg6DZR8g0WREJOsb1rrYcDHZ9rzbYv9W4Fs25tXluHRDrNGHj2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl1/d8Xf; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl1/d8Xf"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50c9f4efd09so2021943e0c.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669259; x=1730274059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSCwKX0bVdNFKmQn8nP4Gv9TYQ865doMFqL8UMLbbCU=;
        b=Nl1/d8XfzWNGbCS+zs0iJCwf7q2jY3Pjiys9bOW9s06NM3mi4GcvYS4dnzz1h5s8+D
         wF7K3RnleZZh9NS5bSy8vq9U799ZcSjSBclpLiElgIYzr9Usiy9cEMI/6IZ3e0f+9Xnu
         BAJ5zf87nCEn5CNphR8zoEyPXjhyRcp5rvZStnPIkVXeVMc6CYwcBH3gOaiLf6jo8QBV
         dwxFYyG8NiVmEipy0x0Od1pLldQogsk7jmZ3BOqFVieypvyBUV2DTUl5GUnXVHXl1D5b
         gGg2wJuI/EE7pURTw61tiXTAIrtVwUpYyD6IUrHnsQ5Mp/MtrNZkOpIlbbCRpQHM7C+a
         5+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669259; x=1730274059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSCwKX0bVdNFKmQn8nP4Gv9TYQ865doMFqL8UMLbbCU=;
        b=Mgbjepey/q0BbEDDkZlQ34e2nGhI27aYZwRcT1XxonDos+lq5RCzIbl+4RFp9vFqWP
         /3d5USGDFx6Wye92CwNv9nEO3KGI5wW7UiH510AajE5YUjfvuYekZdJmt6z8LSGs8wjb
         CBSpEMEe08dzqRZEJYodEtAjE3gkDolugCV7px96U7Wz7VoNJMuc8fTzKPLibBhkNFc4
         nR4s7mv+xGKV44BnSywV0wWPS6yfw+xRdd9WIhG7QhnWVoBYN1Io54tCh0ym9fiwn2Be
         ulYr/SHaLZAcIGmLu3ka1f7YomTm9g9tEJ7QYNDrzseEkO/XwnuxMmaWgvKXUZQw7XjM
         aylg==
X-Forwarded-Encrypted: i=1; AJvYcCXD4ZSM580A5rEyGXUT9CpCxN+G7wkNTbHjqWAT+AHNxYEqUneA7IMmOulrCNopmoJOeqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+q0OS5gVyd+VthNdDq4gb7iFAtR/C3MVVdG3pvet3IAtQWPpY
	00/mab8sJKro4eNLrTK9K0lxGNZH61A0IP2e8rOrbsmkNQKI5M2R9caCs6+XoHD0AYd3Fp2hW+n
	UfQb8Xl4ES69+qJINIP9+aPJQrXvxOtZ5
X-Google-Smtp-Source: AGHT+IEr0owo3bLxqQVu/q1Iq0Bd4af3DoPUzMCspyThoDtm0PWTFA1JiGkHpomA0xq4kcKw+/o1BJSXOuWoifbDvzo=
X-Received: by 2002:a05:6122:caa:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-50fd0328c38mr2140961e0c.9.1729669258802; Wed, 23 Oct 2024
 00:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
 <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com> <8982dca646db72f903bd4c20416d6118da1c210c.1729634938.git.gitgitgadget@gmail.com>
 <ZxiSIem-Gptk6Omi@pks.im>
In-Reply-To: <ZxiSIem-Gptk6Omi@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 23 Oct 2024 07:40:46 +0000
Message-ID: <CAPSxiM8vTABv-ZPe=qCNu1yFKStqZ-eKyrwdxy1+7YMetQfECw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 6:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 22, 2024 at 10:08:57PM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *c=
tx, struct imap_cmd_cb *cb,
> >               for (; isspace((unsigned char)*p); p++);
> >               fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
> >       } else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg)) ||
> > -                 !(arg =3D next_arg(&s)) || !(*(int *)cb->ctx =3D atoi=
(arg))) {
> > +             if (!(arg =3D next_arg(&s)) || (strtol_i(arg, 10, &ctx->u=
idvalidity) || !ctx->uidvalidity) ||
> > +                     !(arg =3D next_arg(&s)) || (strtol_i(arg, 10, (in=
t *)cb->ctx) || !cb->ctx)) {
> >                       fprintf(stderr, "IMAP error: malformed APPENDUID =
status\n");
> >                       return RESP_BAD;
> >               }
>
> Two last nits from my side, sorry that I didn't spot these earlier:
>
>   - The second line is indented incorrectly. When you have a multi-line
>     condition, subsequent lines should align with the opening brace like
>     this:
>
>         if (something_something ||
>             something_else)
>                 frobnicate();
>
>   - The braces around `(strtol_i() || !ctx->uidvalidity)` are a bit
>     confusing and unnecessary.
Thank you Patrick for bringing my attention to this.
I fixed it now.
Usman
>
> Other than that I'm happy with this series, thanks!
>
> Patrick
