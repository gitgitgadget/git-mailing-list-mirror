Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCF1EFF8D
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408131; cv=none; b=UJrMQxv7UKHaQtQtsE/Ygw5wrQIF+XDEmRnSU9OUpvgv0zOMp2SEB6FH7I1TWBkvGSXAnROn3zZiNrVvgkiZrvgHOdAxUVRgmlgc/PTOAtD2V2YPpFhlTZNY+Oahx5m9JjBRKfehcmzQNMERa7gIHTY6Re/V+ilyAX+InBOpQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408131; c=relaxed/simple;
	bh=/v/ngQzWlRfptm/9NqUExpoKZMbDEqczYs1sry0nf6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLFkuXHEVZCG+TssCmJHaS/A89aqfiyqc5SNZ+jYiSBE8FWoTUOeC6JA/Zg0fgkAy1lF5NaEErmJxZQRaM0urNgYDA8DmW30Z0BfOIpiIjj93v7Ul0Vdlfz2rsCAiTMKRDAv94QZpPwR9ANtTPHWwRi+MrsFe0+MoC0iG++6IsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBEQCu+1; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBEQCu+1"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3feb74a1f4eso14601215ab.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408129; x=1758012929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF7p435t5W7F/kTfYz5Rhv9oFIYrPgFcbC3fMmK5qaU=;
        b=jBEQCu+19arityFsMxoqdd59pFXfrM4TEMPjnha7EXSyvMhkCVhG0DkCQvS0iD2Gea
         LZuIsE+fKgxcwbIbbE3KkrCpgN6orEEeLUlDuvVK3wC0k9ekILqG+BqSIC2Gg1KcCrke
         TObkAeq24mTwxDMhcpa2PVVkSRZv5jQ32fF2NSxPFHC1cbCY+PR6lbrqeh15RpEesR65
         ZJPjMijnK1d4sjZOsBorwo0a9MuHT5FXuXf6gcIb6Bp+Y8pd5wJk+Z5nuYLOpg5QfmMe
         KlZOJgSUE1vwmZ01If8ZACd1pT10WXBTDopp9Hmglo/Wv20CJOohMEjKAwcVpuDsV23o
         546A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408129; x=1758012929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xF7p435t5W7F/kTfYz5Rhv9oFIYrPgFcbC3fMmK5qaU=;
        b=kTyq3Z7DlhPR4LPGRdfzNmDniQmINwMaD+sn0cA+FLM2uf7uVL2b1QflaDw3xgdIrj
         crKdP/DYMeGQwhGVaWSsYNSqFQBpJNabNCyVl4Fywl5xothDiYlSMsuMSXSnvttdOcZa
         yQQi3S8lKuSiV1gVza0MzyxwHUfj8sAWe+bOABtmfZoI84hjr9HDOyfr5CKAflrwy2uJ
         FgYvn/JUlWTv1spju6h995zhWPk8HTUH8Cd4lzHG1iG9DUueu280l6DCdt8nELwDNi47
         /ZuV0RCpOQYE1nrSvXT8GyoEkHSw96qFYRTSPP4gQs3v2/B5EvLRwnlYtO7f0SbDk8v0
         RSnw==
X-Gm-Message-State: AOJu0YwPzGwKjdu6Tr0lT1+eXtEFGZpQ9BFmcsl6ZpkkWIxMjnM+ipPR
	roAR0+On/xwJ9/dwYekZ1D6vHuXGPuAt+k1NEguyqa++b3lwEGMr8P+gldc4BXVzbrGqQoSy+AP
	a9c3AfuCgsAAdGw/pTtW6KCc5b0eC0Eg=
X-Gm-Gg: ASbGnct0IslnOKnRLjfhzsBC0qg1dmIBLj/AuEJN7gqOellTg8RUPpeQaeZmmoC1Icz
	PSIkf0vOqiWZmBc1PTX6Cn9WkCHroXkyuITAW9vuDo2NiqdLh+CMDWJ4hdQsJD0W9Ld+XWhI6u1
	bCwgiquxc24n0di/chi1bUTFIeTwO/QJHcWPGkILS6f42KQqNf56ZMrAnjUmOfjpS3hNRyMEa18
	70AklnvbnDaXzKhOIzbYzbDnb0tccF0QV3xxcLlKx/ZpGFB3g==
X-Google-Smtp-Source: AGHT+IEGaOAzIuQ1hPYyOWrq8026Y7U0UKEq+9KXhEAfbWDgs7UxXcL/WCB5p5Z0wUNiDriJoGg2hLl3K/wiu0dTa8Q=
X-Received: by 2002:a05:6e02:164f:b0:3f3:82da:29f2 with SMTP id
 e9e14a558f8ab-3fd877813e7mr131405805ab.24.1757408129158; Tue, 09 Sep 2025
 01:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <9cf9d09c079060bb03556db270a3100ca62c6ba0.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <9cf9d09c079060bb03556db270a3100ca62c6ba0.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:55:17 -0700
X-Gm-Features: Ac12FXwSTJFGHDJDAzB_KH6XOm37JpR4Zz-fFXLTwzABN-WRmdkveiVDpFiNPp8
Message-ID: <CABPp-BGn7LYJKh3Nvmb_UOCnprSw13NHApwqvC0G92DBYnOuAw@mail.gmail.com>
Subject: Re: [PATCH 01/17] xdiff: delete static forward declarations in xprepare
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:45=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Move xdl_prepare_env() later in the file to avoid the need
> for static forward declarations.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 116 ++++++++++++++++++++---------------------------
>  1 file changed, 50 insertions(+), 66 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index e1d4017b2d..a45c5ee208 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -53,21 +53,6 @@ typedef struct s_xdlclassifier {
>
>
>
> -static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flag=
s);
> -static void xdl_free_classifier(xdlclassifier_t *cf);
> -static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, x=
record_t **rhash,
> -                              unsigned int hbits, xrecord_t *rec);
> -static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, =
xpparam_t const *xpp,
> -                          xdlclassifier_t *cf, xdfile_t *xdf);
> -static void xdl_free_ctx(xdfile_t *xdf);
> -static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
> -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfi=
le_t *xdf2);
> -static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
> -static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile=
_t *xdf2);
> -
> -
> -
> -
>  static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flag=
s) {
>         cf->flags =3D flags;
>
> @@ -242,57 +227,6 @@ static void xdl_free_ctx(xdfile_t *xdf) {
>  }
>
>
> -int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> -                   xdfenv_t *xe) {
> -       long enl1, enl2, sample;
> -       xdlclassifier_t cf;
> -
> -       memset(&cf, 0, sizeof(cf));
> -
> -       /*
> -        * For histogram diff, we can afford a smaller sample size and
> -        * thus a poorer estimate of the number of lines, as the hash
> -        * table (rhash) won't be filled up/grown. The number of lines
> -        * (nrecs) will be updated correctly anyway by
> -        * xdl_prepare_ctx().
> -        */
> -       sample =3D (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_HISTOGRAM_DIFF
> -                 ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
> -
> -       enl1 =3D xdl_guess_lines(mf1, sample) + 1;
> -       enl2 =3D xdl_guess_lines(mf2, sample) + 1;
> -
> -       if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
> -               return -1;
> -
> -       if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
> -
> -               xdl_free_classifier(&cf);
> -               return -1;
> -       }
> -       if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
> -
> -               xdl_free_ctx(&xe->xdf1);
> -               xdl_free_classifier(&cf);
> -               return -1;
> -       }
> -
> -       if ((XDF_DIFF_ALG(xpp->flags) !=3D XDF_PATIENCE_DIFF) &&
> -           (XDF_DIFF_ALG(xpp->flags) !=3D XDF_HISTOGRAM_DIFF) &&
> -           xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
> -
> -               xdl_free_ctx(&xe->xdf2);
> -               xdl_free_ctx(&xe->xdf1);
> -               xdl_free_classifier(&cf);
> -               return -1;
> -       }
> -
> -       xdl_free_classifier(&cf);
> -
> -       return 0;
> -}
> -
> -
>  void xdl_free_env(xdfenv_t *xe) {
>
>         xdl_free_ctx(&xe->xdf2);
> @@ -460,3 +394,53 @@ static int xdl_optimize_ctxs(xdlclassifier_t *cf, xd=
file_t *xdf1, xdfile_t *xdf2
>
>         return 0;
>  }
> +
> +int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> +                   xdfenv_t *xe) {
> +       long enl1, enl2, sample;
> +       xdlclassifier_t cf;
> +
> +       memset(&cf, 0, sizeof(cf));
> +
> +       /*
> +        * For histogram diff, we can afford a smaller sample size and
> +        * thus a poorer estimate of the number of lines, as the hash
> +        * table (rhash) won't be filled up/grown. The number of lines
> +        * (nrecs) will be updated correctly anyway by
> +        * xdl_prepare_ctx().
> +        */
> +       sample =3D (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_HISTOGRAM_DIFF
> +                 ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
> +
> +       enl1 =3D xdl_guess_lines(mf1, sample) + 1;
> +       enl2 =3D xdl_guess_lines(mf2, sample) + 1;
> +
> +       if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
> +               return -1;
> +
> +       if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
> +
> +               xdl_free_classifier(&cf);
> +               return -1;
> +       }
> +       if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
> +
> +               xdl_free_ctx(&xe->xdf1);
> +               xdl_free_classifier(&cf);
> +               return -1;
> +       }
> +
> +       if ((XDF_DIFF_ALG(xpp->flags) !=3D XDF_PATIENCE_DIFF) &&
> +           (XDF_DIFF_ALG(xpp->flags) !=3D XDF_HISTOGRAM_DIFF) &&
> +           xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
> +
> +               xdl_free_ctx(&xe->xdf2);
> +               xdl_free_ctx(&xe->xdf1);
> +               xdl_free_classifier(&cf);
> +               return -1;
> +           }
> +
> +       xdl_free_classifier(&cf);
> +
> +       return 0;
> +}
> --
> gitgitgadget

Viewing this with --color-moved makes it clear that the changes
exactly match what you summarize in the commit message.
