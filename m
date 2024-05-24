Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EB86251
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568846; cv=none; b=B5F4zsyp5SPReGl5gQ8Kvyo7V7dZMqjsq1Gps6NktB/PJgOlCRD9j+YIr5gs+gWKvqWa1PzI0TMGuIvuHUI3WnxbdG5Cfihg7lupFAsJ5ayWt8cFjghvFWxGHEMV8tgGnMxOpUmWDthTKBX8KkfKI9hzUMcl+/IU9n4pw3cgUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568846; c=relaxed/simple;
	bh=dXGHOwK+xPoNUzLjY6IzksOIEnUXL8Sg2kF1ij2JbPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPLva2q8Mi0TXRYuFgVp44gml5+/pkCI9CwR89idoyh0f6v7Zwe45K3ivklO3kZJcClG7szCnSMwMoNTiW4GBZ9zxn2zl1sSy2+51u2GGNstXbuiSzPD6hinFDaGopXofGiF32uCq4H1XXG2aIjmqNP7aC6fh+GSHb2OGgWVMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CofIKLs9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CofIKLs9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5785199e0d6so1423117a12.2
        for <git@vger.kernel.org>; Fri, 24 May 2024 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568843; x=1717173643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AA5hUz7rz3yvog2jt3CkWiFL1ySdS/kyUJ7DJHe6jk=;
        b=CofIKLs9i5TEP3WyiuGdLL26PYQyo9sw6A4nG4NtRPmWmMiYbCUzGfSMR9PpPOY8Zs
         IPukoaw9M4208NZE138pu9vH+PF1UtNYiGQzdwJZTdZVwS/KyZ4YBeL+xkkz0+v2Yrub
         5YF5T53kM9QBEUG+7u6L10RMQIf7bw4mqeKJne4GMLLoioa2NJ+umJRMDIWdNL0ShnNE
         jkrJUz4OElO5GHUrNKFgeSVGIKVv14DTyodC/k2aKvLfGVRE3ehIrLd7Rh9Pd/tN9Zvn
         uUqxyN8hMJof7zoOeiLLNjyTvevCMD/4/5rhelT7SMFNcDsNaFGdg0JwtqOVIMXODsRc
         KpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568843; x=1717173643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AA5hUz7rz3yvog2jt3CkWiFL1ySdS/kyUJ7DJHe6jk=;
        b=BGTxEkSdHRc9pPuliQxD1a33DG7Ys4/R7VNA8v8E6tqf/eFGLzK8U2/m1gECBVmcDO
         XGbTBWX2XanARCOx3cBHbxLg18BUypWDVKJiqFsmDsdR0XDY1ewF4d7ysb7zIkZN8A5V
         dRKdr/0dh5uRAApHe6Xg1DyL3yeWXecvOILaB4O/MXKVktuw1ow0Vw7f1/49t9sfg71D
         EZkjvjiczS9yCpGAOQI3FUmNP4mU/zPrHaje/njJOKFECmQRsgcjq0rCFu5prpdBJjCU
         p7L+bV3tJ8PbeROYCIicXebj/akLqhE6P/WCfnkN+L3aS3JymZdsw+O/CREuPVUO5e7m
         DHxw==
X-Gm-Message-State: AOJu0YwWu37mAIlVpkN0Y9AgCVL/uUw5XhpvOLvlAqB5ceRcvIe7xsbf
	G8tRTZrgu9R6Qa3cxpjGvaeXNAC7u9E7eb/XPN7TOWIxPKaPtfpqF7w1/AnXKBbDPSZZkzFjmJB
	QYSdI++LlKD1QEPErdko1CycXv7M=
X-Google-Smtp-Source: AGHT+IEFoccWW+smqvLST53M5cBYc7WzJdH5XnAPQ19iZVeCc52EqTKa/v2/q3AUyH0ibL0qPpvIGUCfljYV3UmbbcA=
X-Received: by 2002:a17:906:fb03:b0:a59:c5c2:a31c with SMTP id
 a640c23a62f3a-a62646d3d99mr294279566b.33.1716568842740; Fri, 24 May 2024
 09:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com> <20240515132543.851987-3-christian.couder@gmail.com>
 <xmqqo797xbt9.fsf@gitster.g>
In-Reply-To: <xmqqo797xbt9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 May 2024 18:40:30 +0200
Message-ID: <CAP8UFD17JiXDENmjERgB0TW=-S=byT-jzyCcXVp35SUU2M9Fpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pack-objects: use the missing action API
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> >  static int option_parse_missing_action(const struct option *opt UNUSED=
,
> >                                      const char *arg, int unset)
> >  {
> > +     int res;
> > +
> >       assert(arg);
> >       assert(!unset);
> >
> > +     res =3D parse_missing_action_value(arg);
> > +     if (res < 0 || (res !=3D MA_ERROR &&
> > +                     res !=3D MA_ALLOW_ANY &&
> > +                     res !=3D MA_ALLOW_PROMISOR))
> > +             die(_("invalid value for '%s': '%s'"), "--missing", arg);
>
> What is our expectation for how <missing.h> API would evolve over
> time?  I think it is a given that it will always be a superset of
> the need of rev-list and the need of pack-objects, but if we were
> to add a new value of MA_FOO, do we expect that all of the new ones
> are not handled by pack-objects,  Some but not all?  Or none of the
> new ones are handled by pack-objects?

I don't think the <missing.h> API would evolve much over time. At
least I don't think we have plans to make it evolve. Perhaps other
options similar to MA_PRINT could be added though, maybe MA_TRACE or
MA_LOG. Maybe such a new option could be handled by pack-object, maybe
not. I think for now it's better to be flexible and not guess too
much.

> Regardless of the answer to that question, I think a simple helper
> is warranted here, which will also help the [3/3] which adds exactly
> the same code to upload-pack.c:upload_pack_config(), so that the
> callers can do
>
>         res =3D parse_missing_action_value_for_packing(arg);
>         if (res < 0)
>                 die(_("invalid value for '%s': '%s'"), "--missing", arg);

Ok I implemented this in the v3 I just sent.

> > +     if (res !=3D MA_ERROR)
> >               fetch_if_missing =3D 0;
> > +     arg_missing_action =3D res;
> > +     fn_show_object =3D show_object_fn_from_action(arg_missing_action)=
;
> >
> > -     die(_("invalid value for '%s': '%s'"), "--missing", arg);
> >       return 0;
> >  }
>
> Hmph, wouldn't a small array of show_object_fn suffice, making the
> whole thing more like:
>
>         static show_object_fn const fn[] =3D {
>                 [MA_ERROR] =3D show_object,
>                 [MA_ALLOW_ANY] =3D show_object__ma_allow_any,
>                 [MA_ALLOW_PROMISOR] =3D show_object__ma_allow_promisor,
>         };
>
>         res =3D parse_missing_action_value_for_packing(arg);
>         if (res < 0 || ARRAY_SIZE[fn] <=3D res)
>                 die(_("invalid value for '%s': '%s'"), "--missing", arg);
>         fn_show_object =3D fn[res];
>         return 0;
>
> without the need for show_object_fn_from_action() helper function?

Ok with the small array. I implemented it in v3 too.

Thanks for the suggestions.
