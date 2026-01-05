Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5D16EB42
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649939; cv=none; b=tZb7jwqC5jfiG4k8nZmZBK8h2tN3Vqxqv846IULn5VT9SQvJpN2Ouo9rIhXPsKvK6Wb0orS+HJwXo3QUV8VFx+aEkPpYiuqHcKRCA/fm1zDDlr3jpUDm3vxTq7e52ZDYnqdrQOETPznS38tNrnScZICwRCgI3OMMgVZfPAa23G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649939; c=relaxed/simple;
	bh=vQqpODQ0fJu02b+H1FXrb0D24Jhhc7RjwUirnLZY6lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnLwrBhoiK0ljDlHqDSv0Arv9dw1m7ZNhu8sM68uGpao9sn0oAT7N5YA+RzNLmGiJuUfxYUd9ZAROzeJgdUQLRet6Ik0bZ6B0pHkI6XGHW6lRQd+TJ9L+gtQqU9lm8qL/hMn5Vr+2XwxPySGMGCfCZsk4csZ0G1R5Q/tiE9MIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUGuqpdv; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUGuqpdv"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5598b58d816so274611e0c.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649936; x=1768254736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3iwK1r7B504OvWlFoGh0GxCHVcpbR+9MkEsgv7eFVA=;
        b=CUGuqpdvxWHsX2/VQ0696zp9u/LAalAUvcB2amQ3FAKhluOT6SFxXh9c1YHjhOZ10t
         9aiYDWei3UofMO4I5s80sn1TlbFk1Cyk4FyGP7gjpywXpiEk3SC8GGVwBwskO4RyqGwE
         f+rqw7CCJ0ih+pyPmUiHtwQ+ZlMwIPDbFxlkFCxC0I9XspsvtvoR690YceWz4iqy0REu
         ZYku6no2byn8BZPp6Etdf11VB9yorYPqT5UiFdb9893nsMNlEa5UtuS9jRaVYaWAQn9+
         xFV9jGLnS1vHoYOJ0HMdkUu0f7MWWcAM7cxhupjWiGLo5+JWq1IlhVSjdQaxEQCq8LW3
         G2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649936; x=1768254736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3iwK1r7B504OvWlFoGh0GxCHVcpbR+9MkEsgv7eFVA=;
        b=EJ/Fuj2qiSGhP9q8yAZ2rZEfn4uoAEzZbyMNJk5eF0/tAod9W86ol8GustU4piNV5P
         CN8UP+RacZC7D2bo+BQWrwDWkNhAtdHgw+00NmfYGPXOxabk7fXvAAICNGUoDFq2IYgp
         yoNQiPIe/or9A7SPqb54ry6Klaj7lEO+AtgV7vr1kq46V47XeIu6wTTRHWyt5yCOKsKA
         svR+Jp1DLjdaiW1We6j1W61r4XpXKpH0lMc78jTFs4MuV3D1+1+Z+im/fy3tz2iokiRS
         Soko0teBD+46fbT+QJcRvzbspNV0bT7KAa+BV7r6SaVk/YL8WlwSlIMQcGtnkeFtNyaF
         f5fg==
X-Gm-Message-State: AOJu0YwOdEmpPro7j/LqJfkeB2nO3o2fElpUTMjjAkZwj8znAClxIQJn
	OwgBy4CfldsRz1swpqOyF8zq1ON0IY3vWKIYZT6L16mLcoC/pv53lk20935ScDcoKJqCghb5s6T
	IxXgkKc5ybSvO6ekrZ4RURRa+n8bdM24=
X-Gm-Gg: AY/fxX7Vrm41JcGWLyOwTsL5XWzhiU21yXoQGAA3FLYus8/nCQR7MqqB4t/dU5VyVb4
	kD2Xi25F4UJx3NiccptMTPi+LTptG/Pd9CVGjjJlniwBPD6Sexe5OpyXyYVcLtw7aOuh2s+fl0a
	3ye0GpIWss3cILFCKQsHNUy+FidSLmeKBq+A24/Et+t21HvIxQFVlmtZ0OKHqZNvl9Ied2IKqqv
	1Cwz4IN7OZB7WaI/wSb0j8hIN7mrmIxmURYTJXyrjEkSzCEL4lvwCkEjHwgoRUnKgVdMTE=
X-Google-Smtp-Source: AGHT+IG4ekLwMokWQ/VADOFVJ3l1wQJ+vbI/5dr693Q+jbmrpAiM6ur8JLJODUs0ubrUfdR5Wl7Ql17cVqby5+XAfCM=
X-Received: by 2002:a05:6122:6592:b0:55b:305b:4e27 with SMTP id
 71dfb90a1353d-56339571890mr365335e0c.19.1767649936489; Mon, 05 Jan 2026
 13:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local> <aVpI36nPuZAEchuM@Adekunles-MacBook-Air.local>
 <aVwShWyoGBq4BcGR@szeder.dev>
In-Reply-To: <aVwShWyoGBq4BcGR@szeder.dev>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 5 Jan 2026 22:52:18 +0100
X-Gm-Features: AQt7F2rx1Z1Ncqd53_Bj4i4taCDu2hIv35NRHxT8UYr_PeGtkBJYVdUiLZ4wRhQ
Message-ID: <CADYq+fbntOOmcb+7cg_VDt24UzsU0UfBzFPMVxVdtL0sAMrHbg@mail.gmail.com>
Subject: Re: [GSoC PATCH v4] add -p: show user's hunk decision when selecting hunks
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 8:35=E2=80=AFPM SZEDER G=C3=A1bor <szeder.dev@gmail.=
com> wrote:
>
> On Sun, Jan 04, 2026 at 12:02:55PM +0100, Abraham Samuel Adekunle wrote:
> > diff --git a/add-patch.c b/add-patch.c
> > index 173a53241e..bc7a340d21 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
>
> > @@ -1448,6 +1448,7 @@ static int patch_update_file(struct add_p_state *=
s,
> >       ssize_t i, undecided_previous, undecided_next, rendered_hunk_inde=
x =3D -1;
> >       struct hunk *hunk;
> >       char ch;
> > +     const char *hunk_use_decision;
>
> 'hunk_use_decision' is defined here, but is left uninitialized.
>
> >       struct child_process cp =3D CHILD_PROCESS_INIT;
> >       int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
> >       enum prompt_mode_type prompt_mode_type;
> > @@ -1564,8 +1565,17 @@ static int patch_update_file(struct add_p_state =
*s,
> >                             (uintmax_t)(file_diff->hunk_nr
> >                                               ? file_diff->hunk_nr
> >                                               : 1));
> > +             if (file_diff->hunk_nr) {
> > +                     if (hunk->use =3D=3D USE_HUNK)
> > +                             hunk_use_decision =3D _(" (previous decis=
ion: use) ");
> > +                     else if (hunk->use =3D=3D SKIP_HUNK)
> > +                             hunk_use_decision =3D _(" (previous decis=
ion: skip) ");
> > +                     else
> > +                             hunk_use_decision =3D " ";
>
> 'hunk_use_decision' is set here, but only if 'file_diff->hunk_nr' is
> non-zero.
>
> > +`
> > +             }
>
> Nit: unnecessary empty line before the closing brace.
>
> >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
> > -                    s->buf.buf);
> > +                     hunk_use_decision, s->buf.buf);
>
> So 'hunk_use_decision' is used uninitialized here if
> 'file_diff->hunk_nr' is zero.
>

hello SZEDER,
Thank you very much for the review
Yes, you are right, `hunk_use_decision` is left uninitialized if
`file_diff->hunk` is zero
I will fix the patch and send an updated version.

Abraham.
