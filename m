Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960E19C556
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913155; cv=none; b=JRak64R7LiEpjsmICryrvqYYmh+niseXalieijHTu3pSsHQFoMNwOutbtT9BfMrA6xkNqc53Ii+RNpmTbHPqFmEjJKNlEQ/A+WF12IzPxeULl0DyU4QdNNXyiZnHtpoSjS6zpO3EzQNTrXQ/WM2e/zyevY/m78nUaGPR9rscR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913155; c=relaxed/simple;
	bh=Yp6i9qLTViyDIbp972KaGTigBA/eVoDeKabxSaVrn8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvVJV3vpaeP0IZIiJ4B+uiqX9YG4TgGCjr+Q07/DRWDr2ixfz8LKUcdMVz6p5z+QHFRnrqJYcBlnQg16hS+MZE2vIZRVLUWEZXVf9X+tTxnMPBA3txD3f6pwixIc8C6Rz1aVsljm98oO7NnMVS9HFlHsf3BWKzO5ToC9su0d3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFjBnuHk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFjBnuHk"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so43359866b.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753913151; x=1754517951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R4/A5N2AHlLcknDPi3ezS4YROAfUrK9X6h83glDJeU=;
        b=EFjBnuHkq7Tl1dfQNCiii6Dus5hLFtSUPUs8PXEx/0XnDcZyqZ8jdrlVtT4wDMH8X7
         SV2SsqKTCpWI8hHlNRDhN3d0mgkD3UxalFmq8bPQH7p3nIYic5QUdTDKIaxVz8ZdY/Ox
         y7Na7o154Xgh0KBQ2/2p+riPQW4371fbdfDnmrdUAzt1z1A2HYR9OWLl6Hd0Gr1YaICE
         OYqPOmyBFnARQKZ0lBBlEbanB32oVPwK9v5/1Z+dH3AxADXUbRimPPeJLffHwHUa64e3
         xxozk93UjrpJ+1VXD/S3WWcdChLNgqif3cCs0rYbqqkR3tG6U/MQrzte/8pQezruBAB2
         Eq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913151; x=1754517951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R4/A5N2AHlLcknDPi3ezS4YROAfUrK9X6h83glDJeU=;
        b=o3fbH6mwEXXc5JWxjxvcvcw+g61GUyvexf9/AY76iLId85cTHsnIUr2+1UWdtEj40I
         S8np1E5KGn3sUARB/Sk1eIwTJVuJyBM5vppyzvo9Rn4XFc1o9CEpMR4lvXjDw81ia45z
         sCLZWQZX7Po0CgT75f3kbEaN6XOigCDIF/GCnkclD2L8IRnStOG3NNDSOWEPIJV6D2mG
         333QqDd1uktKuNjcaV5l9gcqE/R8MUccKSqPoymDzw+4c2BhQiOvFvgcKw5Y6nz5Csku
         mMysOxvvG8+PL0LfGCPswDSCnwvNX6Zj9Ih0166lpAfapLoC0mv5Su8LkwZO2xxIxyp/
         di8w==
X-Gm-Message-State: AOJu0Ywa+8IWtorOXYcoOMh/QMAki47ohPCQcPzIYUFllYdtkMt1vtwD
	j4g1FRLKHYtuOFsVSe+kb6dhia+1nvYPHhZ96fojhXVVji5AWm8ZEVn/uTdXMHIy1k/bcJNCISR
	jmhC3OwfraPpW5c8xZfjh0mWX+F1GRXA=
X-Gm-Gg: ASbGncvUfvvhaTgpoSvP+cyJ9cPHuULWAVvbIHlYEp1RN+6vnLfFAqE+ht/nFl5x5f3
	gREucHsweWmtoTqWKXLVwUTQ4ZfyFpFXKEGvNNSsSeNm9EuLcnEw3L7z4QXT52j8fYUUJxZe/Lr
	/6J7k551VXe4rEqV0GcV504Kal0qxU2PANvphK8qusPkC77Y1WiPmZsnCrFhcF4i40f+cIiKLWh
	KKWBt3O8yrtrlv2YCv/mFHY20nW2A7uuSUJ1HMKIg==
X-Google-Smtp-Source: AGHT+IHCiwByshZtMBJg6n34s2J45GERA2sOuRwXMg8Sd/XNAVbjJupdMd2l5nqLNglm362Jd2YehEi4QT3HoBxH7N0=
X-Received: by 2002:a17:907:d28:b0:ae0:ba0f:85af with SMTP id
 a640c23a62f3a-af8fda42fefmr566207166b.51.1753913150874; Wed, 30 Jul 2025
 15:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-3-ben.knoble+github@gmail.com> <xmqqjz3sxro3.fsf@gitster.g>
In-Reply-To: <xmqqjz3sxro3.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 30 Jul 2025 18:05:39 -0400
X-Gm-Features: Ac12FXxxnyq_ZbLrLb9_-AprASoupGk4ztKDDWMnFVfOsLIfyvWY3YrpLUNKZ-0
Message-ID: <CALnO6CDg5tJXNG2V1qXb_Qds+3tDM6cUgbiDO7i3Fy_wc0=FPw@mail.gmail.com>
Subject: Re: [PATCH 2/4] parse-options: name flags passed to usage_with_options_internal
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Andrzej Hunt <ajrhunt@google.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > When reading or editing calls to usage_with_options_internal, it is
> > difficult to tell what trailing "0, 0", "0, 1", "1, 0" arguments mean
> > (NB there is never a "1, 1" case).
> >
> > Give the flags readable names to improve call-sites.
>
> It is a good idea to explicitly say that this step introduces no
> change in behaviour, and only changes the way how these 0/1 are
> spelled.

Woops; definitely meant for that to be clearer. Will touch up.

>
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> >  parse-options.c | 32 ++++++++++++++++++++++----------
> >  1 file changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/parse-options.c b/parse-options.c
> > index 5224203ffe..c3222cc9bb 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -953,10 +953,21 @@ static void free_preprocessed_options(struct opti=
on *options)
> >       free(options);
> >  }
> >
> > +enum usage_style {
> > +     style_normal =3D 0,
> > +     style_full =3D 1,
> > +};
> > +
> > +enum usage_output {
> > +     to_out =3D 0,
> > +     to_err =3D 1,
> > +};
>
> These are very much internal implementation detail, so I am not sure
> if this churn is a good thing, though.
>
> For example, it ought to be sufficient, for the purpose of improved
> readability, to instead doing this
>
> >  static enum parse_opt_result usage_with_options_internal(struct parse_=
opt_ctx_t *,
> >                                                        const char * con=
st *,
> >                                                        const struct opt=
ion *,
> > -                                                      int, int);
> > +                                                      enum usage_style=
,
> > +                                                      enum usage_outpu=
t);
>
> just do
>
>                 int full_usage,
>                 int usage_to_stderr);
>
> here.  Dropping the parameter names in the function prototype is
> allowed, and we encourage to do so in our codebase but _only_ when
> the meaning of each parameter is obvious from their type.  The first
> 3 parameters we see above are of distinct types and except for the
> second one being the usage string given to the users, they should be
> obvious.  But the last two unnamed integers are not obvious and they
> should have been spelled out---otherwise a developer who is adding
> a new callsite cannot work from the prototype alone and has to go to
> the implementation to figure out what to pass.

Yeah, but that relies on folks reading the prototype, no? I wanted it
to be easier to read at the call sites (_without_ special tooling,
preferably).

I'll snip the rest, though, due to your downthread suggestion to use
#define's instead, which I think gives the result I want without extra
churn in other places.


> > @@ -1088,7 +1099,7 @@ enum parse_opt_result parse_options_step(struct p=
arse_opt_ctx_t *ctx,
> >               }
> >
> >               if (internal_help && !strcmp(arg + 2, "help-all"))
> > -                     return usage_with_options_internal(ctx, usagestr,=
 options, 1, 0);
> > +                     return usage_with_options_internal(ctx, usagestr,=
 options, style_full, to_out);
>
> But this is not an improvement as-is.  Wrap long lines or the result
> is even harder to read.

Ah, indeed: I wasn't sure where to draw the line there.
