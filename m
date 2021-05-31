Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E40C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3710D61263
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhEaPzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhEaPxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:53:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9028C0612AF
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:35:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d25so12162066ioe.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kQwuEmnT6vpMn+e6XGW98US/LbzDd+UDbj1F0TsLV9k=;
        b=uXK3H5aRsdXflpB2gQBxrxqfYSicc46B6esO7itne7NdyzWjsLa8yotdUB9VJYly4L
         pjHyF1CgHCka3spDN/Th6xiJMv8pBubRlFbDzjhja1bvAdgE2BH6S0ffGFUIiakn07Mk
         BboqSd6wArW5iJnNRfPB8XqxXyPnbeYyvsf/n8ogLlpXAxaC3YKQqK7eymrEbOmDBtgc
         +1uqZbWP7EEh6PtltU7wvPuH2j4dpEfBccrN5ziVYRl9Fzt2jd4r2CPZqnKzfjkhWF2t
         DsUI8DtLcQ6uJfDGo7454reX25TMCndbdlmu8Oce2koboalEARRzQSwcUkRZVMr+NM0J
         rHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kQwuEmnT6vpMn+e6XGW98US/LbzDd+UDbj1F0TsLV9k=;
        b=RxQvpRrGLZqhSVPzfBvgnKZ7V9t2eImvcVsPd0sL7oKuyT8Ij3mQKhWwjEWUShsk0C
         Lf3THv+vUU0oVhABk45i9I//HGGb9ub9HEX93TkA9YdPC7yv6bId/WAsHd03CHQ/nQT2
         T6Xq22VoqoBmGdAAGk+t05Kc6ksmIuWEvFTrf6ZMVOct0RbhKAes+yK7EjrbFCI6LWSr
         1wvy4eKdPiy5PYj2EMhTwqT0Eso+zkYWvZIbWx8hDGO3dOrUzuOVYDFK0l0+peP6mpuj
         secfyLaXbm0LA46/l44ZXBOTHcgHlux8Lml18MTLAujIjoBOICVG1vAZNRiKYQbfH0Rk
         2WOA==
X-Gm-Message-State: AOAM5324sm5DJc3tHqZbA8Jr1jmzck/7nB1Qm3De6qR/lUpR3S/XVGar
        OEQD9YXEdeZwXTLaS70BIfaZNE5y/bWB+CDOKF0=
X-Google-Smtp-Source: ABdhPJwZ7t/I+8gKTvnNdS1s6qqYalcxN2WgUTfkCljdcZy6Gsi1RD1sPoB+JKcqszRG7TIrM4hjn51R6fP5YMntDmk=
X-Received: by 2002:a02:9a17:: with SMTP id b23mr1480007jal.10.1622471739617;
 Mon, 31 May 2021 07:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <pull.963.v2.git.1622379718.gitgitgadget@gmail.com> <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
 <xmqqh7ij20l8.fsf@gitster.g>
In-Reply-To: <xmqqh7ij20l8.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 22:35:28 +0800
Message-ID: <CAOLTT8REM7tF6ojdmnsJt7-RE6a8oX4RFXVcL215YnYTx6b62w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=888:44=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Beyond, `--format=3D%(raw)` cannot be used with `--python`, `--shell`,
> > `--tcl`, `--perl` because if our binary raw data is passed to a variabl=
e
> > in the host language, the host languages may cause escape errors.
>
> "may cause escape errors" just says you are not escaping correctly
> in your code (implying that this patch is not good enough and with
> more effort we should be able to fix it to allow binaries), but the
> problem is the host languages may not support binaries
> (specifically, anything with a NUL in it) at all, which is
> fundamentally unfixable, in which case, rejecting is the only
> sensible choice.
>
>     ... because the host language may not support a NUL in the variables
>     of its string type.
>

I agree. But host language not only support NUL but also some Non-ASCII
character and Non-UTF-8 code:

$ git hash-object a.out -w | xargs git update-ref refs/myblobs/aoutblob
$ git for-each-ref --format=3D"name=3D%(raw)" refs/myblobs/aoutblob
--python | python2
  File "<stdin>", line 1
SyntaxError: Non-ASCII character '\x8b' in file <stdin> on line 2, but
no encoding declared;
 see http://python.org/dev/peps/pep-0263/ for details

$ git for-each-ref --format=3D"name=3D%(raw)" refs/myblobs/aoutblob
--python |python3
SyntaxError: Non-UTF-8 code starting with '\x8b' in file <stdin> on
line 2, but no encoding declared;
 see http://python.org/dev/peps/pep-0263/ for details

> > +The raw data in a object is `raw`, For commit and tag objects, `raw` c=
ontain
>
> s/contain/contains/, but more importantly, as we are not introducing
> %(header), I do not see why we want to talk about its details.  For
> commits and tags, just like for trees and blobs, 'raw' is the raw
> data in the object, so beyond "The raw data of a object is %(raw)",
> I do not think there is anything to talk about.
>

Ok, I will delete this part.

> > +     const char *s =3D buf->buf;
> > +     size_t cur_len =3D 0;
> > +
> > +     while ((cur_len !=3D buf->len) && (isspace(*s) || *s =3D=3D '\0')=
) {
> >               s++;
> > +             cur_len++;
>
> Is NUL treated the same as a whitespace letter for the purpose of
> determining if a line is empty?  WHY?
>

Well, there seems to be no correction here. But is it true that memory
like "\0abc" is considered empty?

Thanks.
--
ZheNing Hu
