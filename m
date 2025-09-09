Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683C2773D8
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408276; cv=none; b=tvbz+egIxElsvqbNk7ulzXVhWO2PvPvSSTD4bYUdBOa+TvCST4BVVxCAI8GWPI0lRPg9smrTzoHgYU9KWpfBoncf7tJYNyvqnOZLIYxKYGbk91oUHMx+x27+KFkk0fsBEFPIfH9MX/EXNkz1EmFPhDySKVYOHS4xDEaM8pkzzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408276; c=relaxed/simple;
	bh=nQshJXeVFuvc1KFhKTEl0J/kR9VenlSNIILfGO42px0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQqK5IetMb+smvXf3UGVQ5P2G6U/XF/fFC6fYqxRBaYrX3l95TYD4RvPrS8Y3efrvMCIH9Rb1XXiT6MPHv4ehYxVy5l9W/L6tSVpacej7ITVVGVziL2k0YJkWxvM+NSyylpmgVF0asQzITs7++N/+HHYJOsMorcOTw+oHm6TB5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1qzYvD9; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1qzYvD9"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-884328c9473so102795539f.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408273; x=1758013073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gjl/p8LEZU2IVlOgTmIYqw/FDS4FUgi/ZvPOh74OGU=;
        b=O1qzYvD9xpjiL0LtpfHyG17i2dKRPbzZVwhYdV0XyUqBaePQWl6z/oplbOL3LTAkVw
         tcFxtcCSzdYQJv+8uZe7+tq+/yPK2cHvlfzPsX82VVLRlngBUBLIQMp03aD+Inan3+aM
         BW5ZTOQbzts+8qw9NyjZuHDww3EY+9LfZXqcVXSqZtk9hNlEXYs/PgFM1IZkzWI5FF+8
         nrQZsq2efQfwOccfh+L4Y1F079eyG0e6IvZ3Gt4HReH1kqwSDSbqY3VXzawcRDRxKVhT
         ERJqzicDrGduOo9cYY3j7S3afdhYvTNa2hhvBJQsd3MgN3va5ChQeeOSvlPDa13JGSqg
         9Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408273; x=1758013073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Gjl/p8LEZU2IVlOgTmIYqw/FDS4FUgi/ZvPOh74OGU=;
        b=S4T4qRWoOOhYAMOwd1hIq9Fph5DgdjuciXE/5abrxrzZ4cn6n5p0nL+KanQlL8ySmU
         4qQDgpliw69BU7Y7AMo2KQuwdQIaCWLluVZeZuGUyiwoE15mZJ0tn59lYRlamQ2FmFwB
         aDv37OVegTDX+aOB0pKFy+Mgm7DUp40GZL8sKu5nhDxkKx4rZbdg3NUmBgWZQ39IQ2HM
         gaqsQbyxyKiqYMO9tPJpXoR6XhbxXBtHJ4ySczHnRM8XOEiWxYEJJL3ila8X22MvTh4g
         lcvIguBl4AGUZrOe5fvHm0HvCwekxPfOJgr6ilIO3eptKHUc7+JIjarezhs0iNE9VE9V
         GkMA==
X-Gm-Message-State: AOJu0YxIgATyAOU2KH2/BD8muQqjDSEa2OvuGuKmQHwxBUVxWZ79cje3
	GHIwEgTwFp1sEfnjtPVbrKBnRmUVBw2MSYG7E5vgCb7WqgD3vAB+L3jkBS3N5Kvgb8ivYsM4rPy
	LVjDLxXT9r21+LhwdNeFQjxLKMERPf1WPGQ==
X-Gm-Gg: ASbGncsWWYSFuAcjdgUM4qnHjFyfL3jIdP/knpxkV5hTR3aDrtgHvc0ZAjZiigcpaQn
	mvhTjZDXFHuT1M1/CUW+lyOaYw/5Ut4+RVC9S2iu8dUyrc7IbQMqdH/fFmn9oECo3liPM2rasWO
	HPEFQ5bRK+DqprRccPME99BuF9nZ2HYv+vcYOs389PPjbxU8SIHZZ0APQ2GcXi1C+DzT45jOwzo
	ICZ0mDreeS1LgCcnh4AOTK4GsdIAO7V/qCgxGGjMmmPm96POg==
X-Google-Smtp-Source: AGHT+IEAt+KcCBLWMowc1Vc+94FvPXl9K8Piuj7O1doQUMEH+VV90Mq5nZjEJROXCNyOsGf5jrTNL4OTD14cLQr4rUE=
X-Received: by 2002:a6b:da0e:0:b0:886:c49e:283a with SMTP id
 ca18e2360f4ac-88767ec3454mr1906438339f.9.1757408273021; Tue, 09 Sep 2025
 01:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <db3d4e9a89d4b72dfb7e59dd38c6dad31f5c1cf0.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <db3d4e9a89d4b72dfb7e59dd38c6dad31f5c1cf0.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:57:42 -0700
X-Gm-Features: Ac12FXyUShDBo69rzcwHioM-Xz4SwM9edhB0PwpZDVNWthI8GdVyk6gDlj6Nmyo
Message-ID: <CABPp-BGpWoi9naKYMPuL1SXZMb1bAVhAvd8DT5DEfrxHCB5uvw@mail.gmail.com>
Subject: Re: [PATCH 07/17] xdiff: delete fields ha, line, size in xdlclass_t
 in favor of an xrecord_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:46=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 59730989a3..6f1d4b4725 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -32,9 +32,7 @@
>
>  typedef struct s_xdlclass {
>         struct s_xdlclass *next;
> -       unsigned long ha;
> -       char const *line;
> -       long size;
> +       xrecord_t rec;
>         long idx;
>         long len1, len2;
>  } xdlclass_t;
> @@ -93,14 +91,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) =
{
>
>  static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, x=
record_t *rec) {
>         long hi;
> -       char const *line;
>         xdlclass_t *rcrec;
>
> -       line =3D rec->ptr;
>         hi =3D (long) XDL_HASHLONG(rec->ha, cf->hbits);
>         for (rcrec =3D cf->rchash[hi]; rcrec; rcrec =3D rcrec->next)
> -               if (rcrec->ha =3D=3D rec->ha &&
> -                               xdl_recmatch(rcrec->line, rcrec->size,
> +               if (rcrec->rec.ha =3D=3D rec->ha &&
> +                               xdl_recmatch(rcrec->rec.ptr, rcrec->rec.s=
ize,
>                                         rec->ptr, rec->size, cf->flags))
>                         break;
>
> @@ -113,9 +109,9 @@ static int xdl_classify_record(unsigned int pass, xdl=
classifier_t *cf, xrecord_t
>                 if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
>                                 return -1;
>                 cf->rcrecs[rcrec->idx] =3D rcrec;
> -               rcrec->line =3D line;
> -               rcrec->size =3D rec->size;
> -               rcrec->ha =3D rec->ha;
> +               rcrec->rec.ptr =3D rec->ptr;
> +               rcrec->rec.size =3D rec->size;
> +               rcrec->rec.ha =3D rec->ha;
>                 rcrec->len1 =3D rcrec->len2 =3D 0;
>                 rcrec->next =3D cf->rchash[hi];
>                 cf->rchash[hi] =3D rcrec;
> --
> gitgitgadget

I can see the changes match the one-line summary.  And I think the
point is simplification or reducing redundancy or something...but
could a single sentence motivation (stating which of these purposes is
at play) be added to the commit message?
