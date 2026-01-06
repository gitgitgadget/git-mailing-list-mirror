Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1DC13B
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736949; cv=none; b=BAAZRs1MMD6fIcnjQnQ9BWKne4283Sey/FckpKWGQx3HHQrYYu10nEni9qXkdgMRI39UVi7WcAMYI4pyYRj/cX6mE5vK4nnv6mBY0iL6H0QMdRGQpFoR1InGWy62GVGlCuut+wVNfJ8kyVFGVzdBHrgzBZHKyVdBSpf2N8rrJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736949; c=relaxed/simple;
	bh=0DfK83ekse2ke3l2uHkW2jpuln80rFeNQn3ALka9Ovw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwThpq+MrJUlyC32PGbxVplWIizglJcIgc267SsgDx1+wDarkrAGI/F/cjmtls8lMcTnf8SEXaHHdr0QQQeKqCArc5H0YJZaS6/a5EcAdyqPTMCOGY9HvjTwDOOqn/tD7uSpPwPZ6UMRFIhnT+BwyyEUmeGBAw0+9malFHsRW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNWbEGuj; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNWbEGuj"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-559748bcf99so936896e0c.3
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767736947; x=1768341747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGhJ61H2AlhLCoKTyu/bcxWY5KWgaATC8ZMS7WZrKKo=;
        b=YNWbEGuj/yDTk/Cg/ndkLexHrqRs0mBhwMxbRiRWBhaznA+aTgNiKbtSosg2A1st0H
         2GrRCbr2e/pX34KOmBJ5kwaizjM9OoWxXIRZ9emzb/+7xYRl/eDuhnBXQhECIWat0tZT
         PRyhz/WCOkoFtUxvMbVrPoh/rHGNgQIWdkVcQ+vBMVgR9kl9LfCMUP8hQRTuFiuKPwmD
         PLgXC6TZUk3QhtbU8DyF+wHHr9DcvkK5eqTeIXT24XVfuEQsVd8M9WQPR8FhdPVUFD3k
         rJy4Sa/UJvZOTPg/bfP1qJ25vS7gL5SvZm6m2o7aRmLgGx22wxqJv6rJLwUeobZ60Kb6
         olZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736947; x=1768341747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGhJ61H2AlhLCoKTyu/bcxWY5KWgaATC8ZMS7WZrKKo=;
        b=LFOFQgWL6bDt9uH6ZHfCJHSAsX+VwWj5MgDRltWeUcOV3vaPCyBOHHfnk5VtxPocgj
         AyJSS5zgNtwo5h1bs3/3Qi7HF794cdBIF/a38bq/nNcnvJcs7ocKGsgBwuDXcHWKAAjn
         BMXOdV6Sb4yvNo0In2kEKACU/m9QWfrb4CsS3Z6y0Oz2Cyf5RGqApTaDg+/a6W1n7HXu
         Svn3qHj2VCRG7LHhsz10OVo7XgmrVNBdRPJ5QEYCd4l/MXJI2OMGI2T0S0OTiJxhKUhT
         1/S3DCqrvBoYIQEGJpbMwLISyTy7Cfbt1em988MGK60nzMiaB32Oau0+J994UPXnTTS+
         JNlQ==
X-Gm-Message-State: AOJu0YywazFJ8UoNSwrsS+/JCo0VF9WRdZGARgE47q827bM1nIyIq+IZ
	qIIlFdnO/3jXXIUsrK+djgXfnbwSGI050f8n8vStFB0nxWYJiVon0wmWlww0IFCyDHFDmvthBXO
	qIeUq+J2aHbEp9iQGlVsdyMI/fARbAA8=
X-Gm-Gg: AY/fxX6VB4PKAWrss5AO1C9e3d4R7phvp84UC2uOXaStdEG9a0J+2HCaUfEdCYa4+Ky
	BWrZoWoAMr+X7Wcz7k6g2uI6mEBjurXQu6diJN4vvbUUEHxNGnDQvLbmKwUx2MqEzxpRHcj2DZC
	hyQ5eqMkNIBjL/Y+eFEhhsJRelGgsjeRg4bYvaipTUyzjL9elXeGDxOpfhSGQXgaC/Jm2YovmT1
	/FajCS06W/QzvTWNBRz/572Krd5u0o13hVejuSMudaxrIuKNaY0L1oTyyf7SBcUwIxHPZY=
X-Google-Smtp-Source: AGHT+IEpbzz++2upybrMa2LIIFX7P/dD/IAdeMTQ9ayhjDOrEdEstUMmk7edoEdnf2mQC6jzg58rwH9XjCOhzKcfQ+0=
X-Received: by 2002:a05:6122:4885:b0:559:83be:69c5 with SMTP id
 71dfb90a1353d-56347fe2e8cmr110259e0c.10.1767736946743; Tue, 06 Jan 2026
 14:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local> <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
In-Reply-To: <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 6 Jan 2026 23:02:28 +0100
X-Gm-Features: AQt7F2qUOGBht7UGylRw9xZUJC8S5i6nDmi4JKyjf7TJGPqm1-ER9lBntOP-0-o
Message-ID: <CADYq+fafH-cwc7Ego1fDdNRgSnrOeGzCz_vCqszajVYEx1FV-w@mail.gmail.com>
Subject: Re: [GSoC PATCH v6] add -p: show user's hunk decision when selecting hunks
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:10=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Abraham

Hello Phillip,

>
> On 06/01/2026 12:01, Abraham Samuel Adekunle wrote:
> > When a user is interactively deciding which hunks to use or skip for
> > staging, unstaging, stashing etc, there is no way to know the
> > decision previously chosen for a hunk when navigating through the
> > previous and next hunks using K/J respectively.
> >
> > Improve the UI to explicitly show if a user has previously decided to
> > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > This will improve clarity and aid the navigation process for the
> > user.
>
> I like the idea of telling the user if the hunk is currently selected
> but say "(previous decision: use)" makes the prompt rather long (some of
> the prompts in the tests below are 80 characters long). I wonder if we
> can find a more compact notation. "(currently selected)" is a bit
> shorter and takes us under 80 characters but is still longer than I'd
> like - maybe someone reading this will have a better suggestion.

Thank you for the review
So I previously used selected/deselected. But Junio was not okay with those
choice of words because they did not clearly tell If the user selected
to skip or
or selected to use the hunk.

But how about

Stage this mode change (you chose: use) [y,n,q,a,d%s,?]?
Stage this mode change (you chose: skip) [y,n,q,a,d%s,?]?
Stage this deletion (you chose: use) [y,n,q,a,d%sm,?]?

or
Stage this mode change (choice: use) [y,n,q,a,d%s,?]?
Stage this mode change (choice: skip)[y,n,q,a,d%s,?]?
Stage this deletion (choice: skip)" [y,n,q,a,d%sm,?]?

or
Stage this mode change (use: yes) [y,n,q,a,d%s,?]?
Stage this mode change (use: no) [y,n,q,a,d%s,?]?
Stage this deletion (use: no) [y,n,q,a,d%sm,?]?

Though I feel the last one does not fully tell what is happening
at a glance.
I can wait for more suggestions from other members if these do not
suffice.

>
> > diff --git a/add-patch.c b/add-patch.c
> > index 173a53241e..a383ea7f45 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -42,10 +42,10 @@ static struct patch_mode patch_mode_add =3D {
> >       .apply_args =3D { "--cached", NULL },
> >       .apply_check_args =3D { "--cached", NULL },
> >       .prompt_mode =3D {
> > -             N_("Stage mode change [y,n,q,a,d%s,?]? "),
> > -             N_("Stage deletion [y,n,q,a,d%s,?]? "),
> > -             N_("Stage addition [y,n,q,a,d%s,?]? "),
> > -             N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> > +             N_("Stage mode change%s[y,n,q,a,d%s,?]? "),
> > +             N_("Stage deletion%s[y,n,q,a,d%s,?]? "),
> > +             N_("Stage addition%s[y,n,q,a,d%s,?]? "),
> > +             N_("Stage this hunk%s[y,n,q,a,d%s,?]? ")
>
> I'd find these strings easier to read if we kept the space and just
> passed an empty string when the hunk is undecided.

Okay I understand.
Thank you. I will do that

>
> > @@ -1564,8 +1565,14 @@ static int patch_update_file(struct add_p_state =
*s,
> >                             (uintmax_t)(file_diff->hunk_nr
> >                                               ? file_diff->hunk_nr
> >                                               : 1));
> > +             if (file_diff->hunk_nr && hunk->use !=3D UNDECIDED_HUNK) =
{
>
> Why do we need to check hunk_nr here?

Okay it is actually not necessary to check `hunk_nr` since
`hunk` is set to `file_diff->head` if `file_diff->hunk_nr` is zero
Thank you for the observation.

Abraham.
