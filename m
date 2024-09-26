Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF828176AD8
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377206; cv=none; b=uP2592W7CRL5039vMtqzGCyX1UGcn9DtrogAJ5y4CpKPzyo6p7m+8KFtYRZj/L5alj+2dqJ71nl0KRcpwmdGUZSsYh5vzi1ANcDsSbvSmoP5Jj7gXwEsy0bcYt7Kcymlnm6tcCTQfIpdr5fZisNO8Ij6oBGAvbGU4Mg9/pW5n3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377206; c=relaxed/simple;
	bh=IzjYbVUJcdbB03ruB1NLIGXD9+sqTwte8e2xn84O2hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIwgvtzqdKhE/Gt/D+0oUEwyIeE1OR5IeKec3TJteHAjP73er4gpYZJsEL2QyH6r7ihiKMwRImLVaWWaAXSZD8LCnO2QcnRoTbBUHWO8DOUgC3/smL1Gi+mGxW+Itkl18s3z23PULyRisSyXENbGwUlmPED/rk3O/BmdWjrq1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoOzMf2+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoOzMf2+"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e04196b7603so1337995276.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727377204; x=1727982004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSwwsWIGd/aBmR149a89zv8butdGLq8KT2D2+7ZJyoY=;
        b=MoOzMf2++56DvShW77WEWGHz4nmDu0xSGmgcLQfIoyPSPSE9UMStQKDBEFTDyUygDK
         R5gjwXgwxgt4TsPXvVKr7fwvduVHyDC2BDa1dWKnxL25Dk5dyNARuWT/s7RaLS0DgguQ
         mbLxkpI5q65DjDgnKagaM68Hqo4p1ojt7XZxbvEnXvG9IQGkNqSX9VBb96Y6VsNfcDCP
         GT3stE6sg0iyTopM66iP7KiMlYGSRrn0gckyxHEdsh3VsYj448C0pEjGbefO5e8CLSRq
         Uxqgmo5RRcBHQTx4DyMcg/djVNjGWxvm3sHQGy5KhlFUp3GVapTORkRarQZ8hZEv0IbI
         NnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727377204; x=1727982004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSwwsWIGd/aBmR149a89zv8butdGLq8KT2D2+7ZJyoY=;
        b=VdRrjZ+K6io+5rrBD4kGRHxKnB/FVg3adzhgRjeEtWyxDfevwjGBMmtLxEdf4eJJQ/
         CR1qb3H7ecn/tpkh4c09wOJlWEL8dYDR0XEFgLD1HYA4KsZaPr2YpbHOd1/QIvyFRHDa
         eKuYCr6rGMWTY9Cym8b83lYx0l42075CYOgCXgt1V19Rmy8bwxba4t7Dvmo+oF52UTvv
         EKvheqYpFTnyh5bZcGY+1eEmwTeAPxAsuiEEx9gE6GdimSB/dpIsJwwZLsD4WGd/EXpV
         9sa0AbL+DBCfGTKJKuR35afEk3+mC8Z8Y00KuO8QPcW9WyE/1wIsKm4b67KhIlRb65SZ
         rTXA==
X-Forwarded-Encrypted: i=1; AJvYcCWNYPohJ5l9UKQVuR/bqadtDxvEjfz9NoM3nX6pmEQAevSpBcrPgCv5inIVW+GCrREzteQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjU8c0Mom05BVeLOtLOGGYF1KcaP5NVwuTw1Xa3qmMTeh+5psN
	XL3G192zZbnpZwwMZJsKjgrp3g3iIh0D5kyfZ/VPJ+kxKFjTPw3lxll8+LaiYC1+2h55m5RbRNp
	MratjQSzabH76EsB0usEBgvCjFG39YzqI
X-Google-Smtp-Source: AGHT+IEbEBGOHlXUUmM9gWgZrM2S2slJ9AGgIku/cLIfgCzUTnsJ4i7+f2jWVtg4mpHmNR1kmVCUBJzxCjdGKxSsnvU=
X-Received: by 2002:a05:6902:a91:b0:e22:3ae6:fd04 with SMTP id
 3f1490d57ef6-e2604b48967mr474279276.32.1727377203397; Thu, 26 Sep 2024
 12:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <4ce463defa807fb99eef6ce7abcd758fc2065c13.1727185364.git.gitgitgadget@gmail.com>
 <xmqq7cb0ucm0.fsf@gitster.g>
In-Reply-To: <xmqq7cb0ucm0.fsf@gitster.g>
From: John Cai <johncai86@gmail.com>
Date: Thu, 26 Sep 2024 14:59:50 -0400
Message-ID: <CAOCgCU+hv07+FCupr2Ok9LJm6HYT6n6t+ZpifAhwrRnMzOnnWA@mail.gmail.com>
Subject: Re: [PATCH 3/4] apply: remove the_repository global variable
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, Sep 24, 2024 at 2:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: John Cai <johncai86@gmail.com>
> >
> > Remove the_repository global variable in favor of the repository
> > argument that gets passed in through the builtin function.
> >
> > Signed-off-by: John Cai <johncai86@gmail.com>
> > ---
> >  builtin/apply.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/apply.c b/builtin/apply.c
> > index 84f1863d3ac..d0bafbec7e4 100644
> > --- a/builtin/apply.c
> > +++ b/builtin/apply.c
> > @@ -1,4 +1,3 @@
> > -#define USE_THE_REPOSITORY_VARIABLE
> >  #include "builtin.h"
> >  #include "gettext.h"
> >  #include "hash.h"
> > @@ -12,14 +11,14 @@ static const char * const apply_usage[] =3D {
> >  int cmd_apply(int argc,
> >             const char **argv,
> >             const char *prefix,
> > -           struct repository *repo UNUSED)
> > +           struct repository *repo)
> >  {
> >       int force_apply =3D 0;
> >       int options =3D 0;
> >       int ret;
> >       struct apply_state state;
> >
> > -     if (init_apply_state(&state, the_repository, prefix))
> > +     if (init_apply_state(&state, repo, prefix))
> >               exit(128);
>
> Hmph, the reason why we do not segfault with this patch is because
> repo will _always_ be the_repository due to the previous change.
>
> I am not sure if [1/4] is an improvement, though.  We used to be
> able to tell if we were running in a repository, or we were running
> in "nongit" mode, by looking at the NULL-ness of repo (which was
> UNUSED because we weren't taking advantage of that).
>
> With [1/4], it no longer is possible.  From the point of view of API
> to call into builtin implementations, it smells like a regression.

I see your point here. However, I was wondering about this because
we are passing in the_repository through run_builtin() as repo--so wouldn't
this be equivalent to using the_repository and hence the
same API contract can remain that looks at the NULL-ness of repo?

But I could be missing something here.

thanks!
John

>
> A more honest change for this hunk would rather be something like:
>
>         -       if (init_apply_state(&state, the_repository, prefix))
>         +       if (!repo)
>         +               repo =3D the_repository;
>         +       if (init_apply_state(&state, repo, prefix))
>
> without [1/4].  This change does not address "apply still depends on
> having access to the_repository even when it is being used as a better
> GNU patch" issue at all.
>
> So, no, while I earlier said I was happy with [1/4], I no longer am
> enthused by the change.
