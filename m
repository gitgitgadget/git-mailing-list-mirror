Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6E199FBA
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100443; cv=none; b=vFp+Z1dCDzS9jdk3h1gc4fRvK6KKoToNajzIfnqArFo7JL1uR7oW1IbOIbA8LcVng6dztg/VbtDL30n0VhmkQgNNA+Wci+vbcBcauWeLI8wm3OHNTyXKrqUILXEyGdkeKN2/9pQ4y0SEY6pDOvL9tYCBcKOi5IrWNP7uajiSFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100443; c=relaxed/simple;
	bh=WrIS8H/P+/v14bMgq73HihGTs2zJWg9OMu0fN/5LYEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lz6zFJB7OBjRlPvpMxlmOZELMcjwbFE8VCV9KcX2frULY6efuRPIQyV3cT30Pd+Qvhw3C89gd8rhc2xs4ohggY9TLSCzkxjAfbYLtbtQXvjw0i2BhqSCx1Rf8GOijUGmYs/4Kfl8DYZZc8bZMmZsT7s+ssL7epBEAGlbXeAJCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbSTde1I; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbSTde1I"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso763905466b.3
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100440; x=1762705240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXyiTQEQS+MFE7Jb/5cxZzlB9t+PNhvlt5k7zBq/wn8=;
        b=LbSTde1IbDVJDodREEAaf09TdaEhYUGvoPiW4Hbf506j5L7+PbTunLhyNtvh9MMx19
         J9wcUVQfNEruFHexZ4buO3xZ/ZOGccTIv/7t6VKxyldCqQv/vQFxhClTMWQLg04iUm8y
         lmv+bVbNxU71U6ztNCYvFjH5o4tDtl7zvml2S17YsPeBpXSsTi70+lD43CaeWsLN35Zh
         E876yTaN69smQV4pXzWu2loHcbTaFN8WF9EhM2K4DGaE8XXbcNWgbAbmDPDIFoVQ9sZH
         uxPUCZ+BuE4SdRgcUuRgcNzPrSyGA78Fb/nperxx9eNgu2EwebIe/0Q+pqidblYSgMCy
         +tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100440; x=1762705240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXyiTQEQS+MFE7Jb/5cxZzlB9t+PNhvlt5k7zBq/wn8=;
        b=R3xaAaLAlXKBcAcbaDyEu+OMeXHReRuKnz9bLId3rSNYH5eSkkL6JywbG7j85Ss0DP
         LwFLU9yjPOZA/HyEKqwC4JBLwpigF+YoQK+VP5Eqw5JycIEAlBgdd1ANxBiJgVXO2hSF
         iARm4ozjvytHc776pvBsdGCqyMahZ+dja9xkcOtV41yAU1oR05/0pww8ocSq/ZnCFxGX
         eIHB0a7qEa4uMjeTw1K6yN3W0t3xQ7nlsqC/n3kBC1ybxgFVT07/40JJLxAKWW0O3CV/
         CLHAdkGIQkc2/4mSbcdQTmZxIlwP80infaB+T5vG/u5fwCTtolyvCbMZ3CieFffni9MM
         QH/Q==
X-Gm-Message-State: AOJu0YwSauw2mBm0QHm3/TesPmr1Qg3hSX2RrM3LBnkqmVP8H7NvYzWb
	gA9Hd88jY7JLf7s+B+d3qPykQfElmgCRlrC3dTLiWo/I/dLJwJxV/GGAL0qbzL+M9iOexpC1WCc
	sP3kRjeRSBOM44ECdVjwHqtoM8CuhR8M=
X-Gm-Gg: ASbGncu8SvkIlLCy8ByaoluisVZHIzZ3QLwVFkTRY08LP781oVXbNLPfIY/TVrxT6BX
	WiAwCGxJ0uFcuouG/xGEtJdbplJjOE18oOECuuRkkB05HNo0Q3wvLeWaMbMq2wV+CK14qC+ufzQ
	SCK9PPXbarGYCHmmyKyuyeSgMCtxPiS2GmCmh2lUGYRoX/slBpdbKprrUpWEwLosq2RD34+xO6B
	plQkAAkOaft5aAPo9p9dIFCqVWzNju78L0EXa3OGiqHQuTnm+baiZoPYwSw6FF2U0tn3ICkEgcb
	ROMJ61ylS2xa59GFPlessRV8b1XMiw==
X-Google-Smtp-Source: AGHT+IHH5lBPh5t9RkgIsOKGEMHeD/QcUCT+QJIf/ypZ/ItivNHn5zRRPRIRh6g0VYybccss1CIZDfjt8yHzzfKD34E=
X-Received: by 2002:a17:907:9403:b0:b40:6d68:349a with SMTP id
 a640c23a62f3a-b70704dc16bmr962014166b.39.1762100440129; Sun, 02 Nov 2025
 08:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5f7057c236c9af3152bd531eed2e4ad0ac35e291.1759094936.git.ben.knoble+github@gmail.com>
 <e8755a04-bd44-4ead-ba44-c603bffcc75e@gmail.com>
In-Reply-To: <e8755a04-bd44-4ead-ba44-c603bffcc75e@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sun, 2 Nov 2025 11:20:27 -0500
X-Gm-Features: AWmQ_bm_mmFtJXT4cVZNljrMrtnt9UlIFDFuWJE0UHUTMj7tljCN-G-_PxI3fkg
Message-ID: <CALnO6CC=FFuMmBfJPzunUqDOBMBtmXm3i73y9M9LgRrhxzrs9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] parseopt: values of pathname type can be prefixed
 with :(optional)
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip, apologies for the long delay.

On Tue, Sep 30, 2025 at 11:26=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Ben
>
> On 28/09/2025 22:29, D. Ben Knoble wrote:
> > From: Junio C Hamano <gitster@pobox.com>
> >
> > In the previous step, we introduced an optional filename that can be
> > given to a configuration variable, and nullify the fact that such a
> > configuration setting even existed if the named path is missing or
> > empty.
> >
> > Let's do the same for command line options that name a pathname.
>
> Sounds sensible
>
> > +Magic filename options
>
> I assume we're calling these "magic" to match to pathspec "magic"
> options? I wonder if that is a good idea but I don't have a better
> suggestion.

Yeah, best I could come up with.

> > +~~~~~~~~~~~~~~~~~~~~~~
> > +Options that take a filename allow a prefix `:(optional)`. For example=
:
> > +
> > +----------------------------
> > +git commit -F :(optional)COMMIT_EDITMSG
> > +# if COMMIT_EDITMSG does not exist, equivalent to
>
> This doesn't quite scan for me, maybe s/, /, it is/ ?

Will include in a follow-up series now this has been merged.

> > +git commit
> > +----------------------------
> > +
> > +Like with configuration values, if the named file is missing Git behav=
es as if
>
> I'd drop "with" here

"Like configuration values" seems strange since the subject is
"Git"=E2=80=94other ideas?

> > +the option was not given at all. See "Values" in linkgit:git-config[1]=
.
> > +
>
> > @@ -209,21 +208,31 @@ static enum parse_opt_result do_get_value(struct =
parse_opt_ctx_t *p,
> >       case OPTION_FILENAME:
> >       {
> >               const char *value;
> > -
> > -             FREE_AND_NULL(*(char **)opt->value);
> > -
> > -             err =3D 0;
> > +             int is_optional;
>
> This can be a bool as in the last patch.

Agreed.

> >               if (unset)
> >                       value =3D NULL;
> >               else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
> > -                     value =3D (const char *) opt->defval;
> > -             else
> > -                     err =3D get_arg(p, opt, flags, &value);
> > +                     value =3D (char *)opt->defval;
>
> I'm not sure why we're changing the cast here (or why we need one in the
> first place assuming opt->defval is "void*")

It looks like opt->defval is intpr_t ? At any rate, I'm not sure why
the const was dropped here either. Might be an artifact of carrying an
old patch forward?

A quick pickaxe search says the const qualifier is from df217ed643
(parse-opts: add OPT_FILENAME and transition builtins, 2009-05-23),
unmodified by cf8c4237eb (parse-options: free previous value of
`OPTION_FILENAME`, 2024-09-26). The original patch is from
https://lore.kernel.org/git/20241014204427.1712182-4-gitster@pobox.com/,
I think, so may just be a typo. Will fix.

> > +             else {
> > +                     int err =3D get_arg(p, opt, flags, &value);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             if (!value)
> > +                     return 0;
> >
> > -             if (!err)
> > -                     *(char **)opt->value =3D fix_filename(p->prefix, =
value);
> > -             return err;
> > +             is_optional =3D skip_prefix(value, ":(optional)", &value)=
;
> > +             if (!value)
> > +                     is_optional =3D 0;
>
> I'm struggling to see how value can be NULL here as we return early if
> it NULL before calling skip_prefix()

Doesn't the "skip_prefix" above write into value? So I think if
"value" is exactly the string ":(optional)", then after the call to
skip_prefix it points at the null terminator.

> > +             value =3D fix_filename(p->prefix, value);
> > +             if (is_optional && is_empty_or_missing_file(value)) {
> > +                     free((char *)value);
>
> I think we want to call is_missing_file() here. If the file is missing
> then we do nothing which matches the documentation above - Good.

Agreed! Missed this when editing the patches. Will fix.
