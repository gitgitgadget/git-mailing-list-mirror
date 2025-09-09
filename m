Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33502749C8
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408180; cv=none; b=tA+BfZRzOcylEbdi3RBe9EsBkRhdLa1lq8pLyVvWnu3QxjbJsNVUHWXs2R6D6LKjhbkOcY/VWVFBGeL5zzXZj9PlFp+vm+cCnLus+rhwRNMJKFJeeS9KdpK9qagVbQmoF1kycxm2Q9XaiYsWQMEVpByuWhvKK/bwICjjVh0qzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408180; c=relaxed/simple;
	bh=xTSIPmAwej7msHiMbhibrPt+m69yivd8zEpKvn9wk2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jvk0wTvNkBq6qfOaF9yUc4ySxuOO26EwunFWKpqzkga8NEdRhj2R8GOmDn+QRqZPujgOex2kNmXhlrdwxUeI/Tv0uP4hQblrPNATq4+uHO3jyh4kjHCdPH8zdP2R+mxFMb5Jzmc5NT5JW7Av0b3lF1xpo4evumadGH6QQYsBEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6WhKHEk; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6WhKHEk"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso12363625ab.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408177; x=1758012977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox2QLaVENyLxTyZOZpGjOa0QboFY7azWMBXuxsWNPw8=;
        b=C6WhKHEk8VYtSP4GXK6JhdNLh/mELui345BKfWwKDsraCFLjlnv2+wfzXn7CYbOqpz
         CNurQucJtnJfuaHW3Asinym3YcnqU9KhRGvhuGkxWqi3l2yya7Bvy0z2MiGL2RhslH0s
         jaGTxKnY+SpIVXSYSZYwBb4PdeY6GKbBH3MM0V52IivhgVaSiuhMgHX3RRIeXJ/YatxA
         mVLd26NiZqy5UcylxAZ7uN5JneGV+N7Q+0zCAna5dw9lLqJgmV2l8AdWbbX3QvDlVXFK
         5aDBP1+/FeSGQ7zyxXHBWumsdGWYQUbAZTNDOiXR9vu9gzAAexu28t95MpwwDxkAD/1h
         Emjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408177; x=1758012977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox2QLaVENyLxTyZOZpGjOa0QboFY7azWMBXuxsWNPw8=;
        b=iMHcevi+QA9K6JhppFzclX6juMm6fe1bjBAK4MvsPFuoUXTCtCLdwW/zTH00tYOVIY
         DZhwgq5u2swJJD2lDGMiOR1V6PMWDxnpc+8/pNzhC1W7P9FcC+ImUFyn10WtrfSBub37
         Mm4v+kW6oJe8VA7VPGkm1GoheZX/dxx1TMSdG74WLUsvt2RsTwELEugzyuv0M4UCMZtM
         DBtU8ai/cnvEisG/LeDqPkyslpXNQQv8OlDtrWgA15YJChu4LayJsCku6yQxAjl8DF/a
         u5w4q36wN3/dGw2bQSGsU0pIXWDimo4foihKK3CsbkQ5cDCctKKKTnJFQWyMBp9WivDu
         k2YQ==
X-Gm-Message-State: AOJu0YwnINR8geN+/H/stpEuz8aNVupqWEDh+ywi4rllT4FjFMAnm2SB
	v7mq0r7sOEHYKN8lz52r4WBrfDCAgMhKpdDVyJtnDtSIz4Kw5IlrSTKzN1bEWuDvh2PJJKRWgrQ
	1FK6mT+w4JDDvMRGcvRXCuudOyCgL2j8=
X-Gm-Gg: ASbGncvc8F5g4ElL8rowaCt2GT1azf/aAHUIzghiVKZJu4VzuwArLKgeGYhNnUrJufF
	0uQThBbP5xLdkTrG0ncHaQpml2vMP8ikdYYz9wpPjD92ZnGwqx1fbyqNAOte/L0XCuH0APp9OPP
	yn8VQJqAfJ/THwVrwbSVDWMsa02/hIIaLuBRtwx12GUroxTUvmLsNQ8zUahWTmH4FZDC2b4CqPu
	6DKjz/tuMeEpP+kH2LELJWSYcUbvGYkS3vBpXgaYAC7PRP9pg==
X-Google-Smtp-Source: AGHT+IHJKXiDbue/7vsbNTnyancr0iKuKHtv9RBA5qeJCbZfWBo4z60HRhCEq90EYj8SQFZQBwAHsLm1QZRm9FxpEE8=
X-Received: by 2002:a05:6e02:1487:b0:3f6:609d:1855 with SMTP id
 e9e14a558f8ab-3fd8925cb22mr157633965ab.31.1757408176859; Tue, 09 Sep 2025
 01:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <15832ad2715d377ed9b0c9f3de66cc4532cac2ba.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <15832ad2715d377ed9b0c9f3de66cc4532cac2ba.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:56:05 -0700
X-Gm-Features: Ac12FXz6RsZEiq5hrun2WJlWruDkyKH0ACwcK6MGGW53QdoePgpv5OKBDV6BqCk
Message-ID: <CABPp-BHF38TTwzsgJ215GGrz1Za-m1qMX0u4BY7P_UTzOATuaQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] xdiff: delete local variables and initialize/free
 xdfile_t directly
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:48=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> xdl_prepare_ctx() uses local variables and assigns them to the
> corresponding xdfile_t fields if there are no errors. Delete them and
> use the fields of xdfile_t directly.

In particular, those local variables are essentially a hand-rolled
additional implementation of xdl_free_ctx() inlined into
xdl_prepare_ctx().  You're just modifying the code to use the existing
xdl_free_ctx() function so we don't have two ways to free such
variables (especially since one of those two was an ugly inlining).

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 79 +++++++++++++++++++-----------------------------
>  1 file changed, 31 insertions(+), 48 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index a45c5ee208..2ed1785b09 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -134,99 +134,82 @@ static int xdl_classify_record(unsigned int pass, x=
dlclassifier_t *cf, xrecord_t
>  }
>
>
> +static void xdl_free_ctx(xdfile_t *xdf)
> +{
> +

unnecessary blank line here

> +       xdl_free(xdf->rhash);
> +       xdl_free(xdf->rindex);
> +       xdl_free(xdf->rchg - 1);
> +       xdl_free(xdf->ha);
> +       xdl_free(xdf->recs);
> +       xdl_cha_free(&xdf->rcha);
> +}
> +
> +
>  static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, =
xpparam_t const *xpp,
>                            xdlclassifier_t *cf, xdfile_t *xdf) {
> -       unsigned int hbits;
> -       long nrec, hsize, bsize;
> +       long bsize;
>         unsigned long hav;
>         char const *blk, *cur, *top, *prev;
>         xrecord_t *crec;
> -       xrecord_t **recs;
> -       xrecord_t **rhash;
> -       unsigned long *ha;
> -       char *rchg;
> -       long *rindex;
>
> -       ha =3D NULL;
> -       rindex =3D NULL;
> -       rchg =3D NULL;
> -       rhash =3D NULL;
> -       recs =3D NULL;
> +       xdf->ha =3D NULL;
> +       xdf->rindex =3D NULL;
> +       xdf->rchg =3D NULL;
> +       xdf->rhash =3D NULL;
> +       xdf->recs =3D NULL;
>
>         if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < =
0)
>                 goto abort;
> -       if (!XDL_ALLOC_ARRAY(recs, narec))
> +       if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
>                 goto abort;
>
> -       hbits =3D xdl_hashbits((unsigned int) narec);
> -       hsize =3D 1 << hbits;
> -       if (!XDL_CALLOC_ARRAY(rhash, hsize))
> +       xdf->hbits =3D xdl_hashbits((unsigned int) narec);
> +       if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
>                 goto abort;
>
> -       nrec =3D 0;
> +       xdf->nrec =3D 0;
>         if ((cur =3D blk =3D xdl_mmfile_first(mf, &bsize))) {
>                 for (top =3D blk + bsize; cur < top; ) {
>                         prev =3D cur;
>                         hav =3D xdl_hash_record(&cur, top, xpp->flags);
> -                       if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
> +                       if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, nare=
c))
>                                 goto abort;
>                         if (!(crec =3D xdl_cha_alloc(&xdf->rcha)))
>                                 goto abort;
>                         crec->ptr =3D prev;
>                         crec->size =3D (long) (cur - prev);
>                         crec->ha =3D hav;
> -                       recs[nrec++] =3D crec;
> -                       if (xdl_classify_record(pass, cf, rhash, hbits, c=
rec) < 0)
> +                       xdf->recs[xdf->nrec++] =3D crec;
> +                       if (xdl_classify_record(pass, cf, xdf->rhash, xdf=
->hbits, crec) < 0)
>                                 goto abort;
>                 }
>         }
>
> -       if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
> +       if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
>                 goto abort;
>
>         if ((XDF_DIFF_ALG(xpp->flags) !=3D XDF_PATIENCE_DIFF) &&
>             (XDF_DIFF_ALG(xpp->flags) !=3D XDF_HISTOGRAM_DIFF)) {
> -               if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
> +               if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
>                         goto abort;
> -               if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
> +               if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
>                         goto abort;
>         }
>
> -       xdf->nrec =3D nrec;
> -       xdf->recs =3D recs;
> -       xdf->hbits =3D hbits;
> -       xdf->rhash =3D rhash;
> -       xdf->rchg =3D rchg + 1;
> -       xdf->rindex =3D rindex;
> +       xdf->rchg +=3D 1;
>         xdf->nreff =3D 0;
> -       xdf->ha =3D ha;
>         xdf->dstart =3D 0;
> -       xdf->dend =3D nrec - 1;
> +       xdf->dend =3D xdf->nrec - 1;
>
>         return 0;
>
>  abort:
> -       xdl_free(ha);
> -       xdl_free(rindex);
> -       xdl_free(rchg);
> -       xdl_free(rhash);
> -       xdl_free(recs);
> -       xdl_cha_free(&xdf->rcha);
> +       xdl_free_ctx(xdf);
>         return -1;
>  }
>
>
> -static void xdl_free_ctx(xdfile_t *xdf) {
> -
> -       xdl_free(xdf->rhash);
> -       xdl_free(xdf->rindex);
> -       xdl_free(xdf->rchg - 1);
> -       xdl_free(xdf->ha);
> -       xdl_free(xdf->recs);
> -       xdl_cha_free(&xdf->rcha);
> -}
> -
> -
>  void xdl_free_env(xdfenv_t *xe) {
>
>         xdl_free_ctx(&xe->xdf2);
> --
> gitgitgadget

Looks good.
