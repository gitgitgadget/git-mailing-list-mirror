Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD391C6A5
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198551; cv=none; b=nu9F2hQkvTNESfMlmPo0cqH3es3YAMBnCzeRBFrFW5xZF6dRi/G6t+MHaZLx3/ZQdRDMTynFxKcQNJX7H5DmJDdkJMoNrSsrhZxv1nOdnEXpD9xY4PTvOmAxdsOAfUs0RWxQbIou6yj38eFwmIR25c5tsckLRsYFYisGvrrvKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198551; c=relaxed/simple;
	bh=9HcyPSUQxozkGaBg8Je6i75BlsnsTyJFs64Z2haOQok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=av083uh6SCM5tjVBrhoosRuJ7/ZqdS4RHABqaYWSuhQxogC/vVVnvpMuvlGG+sWeZSRsCExA70HwHOZV1C3gHrhJFPp7EvvsLvIGppxekwWXVFmfR9ljyBTN03dyDudwDi4NYhA2Z35dbFmyRaD2hlTg4CqmPQ7f//HDCMKFTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M41TXVAB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M41TXVAB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2906b859560so3051404a91.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706198549; x=1706803349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLsTFvNouVdy9ERxRGmuCPTXKcjEP0sJceejwJSfRxg=;
        b=M41TXVABsI/7k3TfUz9sgyCUFHIUbV/7C8hBNqzoLZjd2oEfqFTxxo9EQIZj82+c59
         1pqj1BH7AuntrSrbGvTlt7h0ywij79YclYTrAL2UF9SFGkx2naXjsyEDUhrooHukvFQf
         wfWJIWHU2L5m77jhxO/BkyOL2fp2r6SSM7bG2sxAMFLUJfFEew2Gtv88va3NT9vphTea
         viIDv9XUNKPPkUSUIAqDZ9FIcP9xbuvZovkjJ4AUx0TU5fHuq/Agmsd+aEzwSGLWc6hg
         8BjvnEyoUXTPyaVpey5YQlKuC9JKt20XKLN1INU0X5JPV+9ee+al1TfBaSvxcXtIWsoB
         xOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198549; x=1706803349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLsTFvNouVdy9ERxRGmuCPTXKcjEP0sJceejwJSfRxg=;
        b=nQ4gwzr2yatxxpmQBOsboCmDcf12oRmS4xg0y9qv3r/EewpGhWmB1GHRxfZNxXrp4U
         XV81HVGXRNtB7GdAj546m+5yUN3A0raPH8KO4uinwQI2t2z2ueksWQKZJ2VSNBQBPpR7
         fUgS5YJhBhoiPpk6SQF/p3nwO8RH0Y8XLCSXkSV4guBfR3F86PmGwIhm7II6RDie7Mdi
         PHsTnFCz2S6eWs3MNbHcDU1ptPeSPvVKZbWkEej++I8J6hfhGLXeSMwXsk4/RSMrZbe7
         ZqFU4nHbgAuvDG5FEwIkzHaJXjLrzWcYEfOOJmqyCBj8VNPgXL2z8wGEhP0aCjT1hnhD
         G+fg==
X-Gm-Message-State: AOJu0YzB9aCvO6MOvGtDm2y03o/QuLZR5bb6nhMnIkcfmw3hMzKwAgvo
	VWVuv9DqP/t2DIFcPlPYrHneD4yA260e8GMNYBgcCH0+9tieM0oP0b+RvWjJKegDsc13zrzIubT
	aFBF97bZRJSqU8use+YqK8LdqJh2Nygq/
X-Google-Smtp-Source: AGHT+IGnT2EPnjIcbM7f5/9ADJcMoN07kC51kbuS2MInWO3BmJs0gzbO9ia7rpqs7fWnSE30BCXld06QX33Wui0TqRU=
X-Received: by 2002:a17:90a:ee96:b0:290:3be1:9c1 with SMTP id
 i22-20020a17090aee9600b002903be109c1mr860440pjz.26.1706198548695; Thu, 25 Jan
 2024 08:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706099090.git.ps@pks.im> <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>
In-Reply-To: <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>
From: Justin Tobler <jltobler@gmail.com>
Date: Thu, 25 Jan 2024 10:02:15 -0600
Message-ID: <CAGAWz+7hQGMbnc8c9iCzyWQgS=wkaEXXbC7-Biqw2i7oc6rneQ@mail.gmail.com>
Subject: Re: [PATCH v2] reftable/stack: adjust permissions of compacted tables
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 289e902146..2e7d1768b7 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -443,15 +443,16 @@ static void test_reftable_stack_add(void)
>         int err =3D 0;
>         struct reftable_write_options cfg =3D {
>                 .exact_log_message =3D 1,
> +               .default_permissions =3D 0660,
>         };
>         struct reftable_stack *st =3D NULL;
>         char *dir =3D get_tmp_dir(__LINE__);
> -
>         struct reftable_ref_record refs[2] =3D { { NULL } };
>         struct reftable_log_record logs[2] =3D { { NULL } };
> +       struct strbuf scratch =3D STRBUF_INIT;

The variable name `scratch` seems rather vague to me as opposed to somethin=
g
like `path`. After a quick search though, `scratch` appears to be a fairly
common name used in similar scenarios. So probably not a big deal, but
something
I thought I'd mention.

> +       struct stat stat_result;
>         int N =3D ARRAY_SIZE(refs);
>
> -
>         err =3D reftable_new_stack(&st, dir, cfg);
>         EXPECT_ERR(err);
>         st->disable_auto_compact =3D 1;
> @@ -509,12 +510,32 @@ static void test_reftable_stack_add(void)
>                 reftable_log_record_release(&dest);
>         }
>
> +#ifndef GIT_WINDOWS_NATIVE
> +       strbuf_addstr(&scratch, dir);
> +       strbuf_addstr(&scratch, "/tables.list");
> +       err =3D stat(scratch.buf, &stat_result);
> +       EXPECT(!err);
> +       EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permission=
s);
> +
> +       strbuf_reset(&scratch);
> +       strbuf_addstr(&scratch, dir);
> +       strbuf_addstr(&scratch, "/");
> +       /* do not try at home; not an external API for reftable. */
> +       strbuf_addstr(&scratch, st->readers[0]->name);
> +       err =3D stat(scratch.buf, &stat_result);
> +       EXPECT(!err);
> +       EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permission=
s);
> +#else
> +       (void) stat_result;
> +#endif

Why do we ignore Windows here? And would it warrant explaining in the commi=
t
message?

-Justin
