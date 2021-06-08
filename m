Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B17C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F091A61249
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFHGMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:12:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24160C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 23:11:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k22so21000768ioa.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+3XM200YPiDH1xLwVJJQ2JMOZgqrZiy9jtZLd2J2AE=;
        b=i9NcPPESorGYNuUOvSk/yGNleoeFyB+Kdk1b+KcrGNI80FFH/bdzb84DdQtXGVG/BQ
         j/vct7otVgTBrit7iuVHIpBQoB9tLepAr+U7XC7BpcnvUbCG8A5ByJFcdjYcawq5OOai
         my//v+oPOx9LxT4c7cb665QpV0kV0AZfxFlUOPfg41T+r3wArsTZhvM0RfeQzHiqgdpV
         oBKoVtEnISIQS1dqByQ+HOZreuG9bxsWj4r6rUmcw4L4hgrm/qzWtu3BKiJRHzdZyP/l
         QupggTb/YDAtdUR+s4QPwAHt6H28fW9mXVQlYvIeV5Uk7Qz+jeclL3eUYpyyiDU8hlbX
         gNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+3XM200YPiDH1xLwVJJQ2JMOZgqrZiy9jtZLd2J2AE=;
        b=VnRKazgQQ8+An8bwYqquqz8tqoIU53wv0U11nUrO5LOQSFGb9t7ziIiVi6nTcFx03l
         Lzwi14TidxPDAVQUZl6wg1XzrsoUEh6+iwr9FR36lwJK+PV8+txcppJ/9CRa/XQs/G2V
         g7K3Rl5ScsLqVxavabnHIc/T3UeFzIfEAczqPaxRB0adzLO6XMk13WkPVa9wQVkJ3QkN
         XyK4Vieo532M5haFj8erBTJ44qhUMNziC8SA2O+pbwg9rI6WAqqUbRht7lpFd6NKpW1+
         8ZkYUA5IHwTWIKrzAs9Tjw1Uw6/6umrS6dYTUdA/dHpgkwnsEtVkwhDHTU/VdfYFW+fb
         0YUg==
X-Gm-Message-State: AOAM533oB0kpXla6ldu7ziXMMHllei+ADPlhupP9MOcbbRYq5Mw+K/JK
        FV0PsLU7KIxrElFFnl1WjnXBoAnBVukhGArlre5KWN0vJxiNqQ==
X-Google-Smtp-Source: ABdhPJyff8YURs8b8uu5uFn24+vCQR2kpV0ah1RQjpVimhr1J5wxHi4s33DGLfFR5T61YmOtc/LW8TC5rn8v3JKY7Vk=
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr17986400iok.192.1623132659324;
 Mon, 07 Jun 2021 23:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <0efed9435b59098f3ad928acd46c3c7e9f13677d.1622884415.git.gitgitgadget@gmail.com>
 <xmqqa6o1q6zz.fsf@gitster.g>
In-Reply-To: <xmqqa6o1q6zz.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 8 Jun 2021 14:10:48 +0800
Message-ID: <CAOLTT8QPMVueHMFCYP6YJ9_ODsKFxk2gyB1dO5ak=UFX-8Cm-A@mail.gmail.com>
Subject: Re: [PATCH 2/6] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:07=E5=86=99=E9=81=93=EF=BC=9A
>
> This breaks -Wdecl-after-stmt.  A possible fix below.
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 46aec291de..648f9cabff 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2459,13 +2459,13 @@ static int cmp_ref_sorting(struct ref_sorting *s,=
 struct ref_array_item *a, stru
>                                 ? strcasecmp : strcmp;
>                         cmp =3D cmp_fn(va->s, vb->s);
>                 } else {
> -                       int (*cmp_fn)(const void *, const void *, size_t)=
;
> -                       cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> +                       size_t a_size =3D va->s_size =3D=3D ATOM_VALUE_S_=
SIZE_INIT
> +                                       ? strlen(va->s) : va->s_size;
> +                       size_t b_size =3D vb->s_size =3D=3D ATOM_VALUE_S_=
SIZE_INIT
> +                                       ? strlen(vb->s) : vb->s_size;
> +                       int (*cmp_fn)(const void *, const void *, size_t)=
 =3D
> +                               s->sort_flags & REF_SORTING_ICASE
>                                 ? memcasecmp : memcmp;
> -                       size_t a_size =3D va->s_size =3D=3D ATOM_VALUE_S_=
SIZE_INIT ?
> -                                       strlen(va->s) : va->s_size;
> -                       size_t b_size =3D vb->s_size =3D=3D ATOM_VALUE_S_=
SIZE_INIT ?
> -                                       strlen(vb->s) : vb->s_size;
>
>                         cmp =3D cmp_fn(va->s, vb->s, b_size > a_size ?
>                                      a_size : b_size);

You are right.

Thanks.
--
ZheNing Hu
