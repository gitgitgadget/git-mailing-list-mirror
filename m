Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F665CE7A8B
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 23:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIXXjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 19:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXXjv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 19:39:51 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A354E8
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 16:39:45 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f6e6b7600so12636647b3.3
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695598784; x=1696203584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+pMJUjfsA78LlfxhNPIq1PNpmaP03L1A0s5S7w5PKo=;
        b=XgvnWzN2n1DJwYxqY3f/kYzmPte+YTn8huZG8hZYzViek2XL6xANIKVTIFZdceALWG
         6QAgmW78Irn2FjTNG9us/XQ0D301XRxIKmijmrY2dQcRuLsSOnuBiR81ujmr5W2S0tLg
         B1OP729ANVDoHiXipv84vn94kZF4pOqMgj0Mf4qjM90lCVLxivavwli7Why22O4VtUld
         j4A4vHLNoN48xnHcbquV9lWW/phz0xNdW4Nw4h8AtjFEkCRRQ2mSD+0LrjIt90jooQ+E
         PMyVwu8OqrzLRWgsTF8fPFVklpHdkopEv+ITJdZPd1g00FdcJMlYwoPt/IAbJlgpCqyv
         QYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695598784; x=1696203584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+pMJUjfsA78LlfxhNPIq1PNpmaP03L1A0s5S7w5PKo=;
        b=fz4JYYPtSvIbHy/hzHIRbJyIAP8oD4ICwKi2rVv+ij9++uaMM9AxftpE4VIh0cgypa
         dafGRRvH/gvVTAPERm3n0UsZa0Glx05H7NyoDnqkY3bpJr9Fq5zi68dzdCh+6aZzHZtE
         BLKa3sz0u6e7J9K+ApLs6fGXUCXe5rP9v+2FYEdwP7IdvZYCwflPtoIaZcXV0fN0QVHS
         qrHZpyEPToiq2cVnCqlflkgPp4bYk+f5X80oprIUErXIrZQtjdiRlWuisMkW5aQsl5HD
         VtUyKWRaXRdEit7N/mkHlWRIlbON+D2tHz5BIGsx01/tMugLrlXv3xkd8NHcjoBTTERn
         n3QQ==
X-Gm-Message-State: AOJu0Yz+kX3affwNHQuuCAgi+EK9UXSKHd4qwzM4MQ2OVfnGnIPCMw1h
        gdyw+leU9yD+CJuzHo9H6ZZcLyiWSC/7P7Kmf8o=
X-Google-Smtp-Source: AGHT+IGAetnEFLmJHGxw29ByBWZfHDrkFfzU+d524Bvy5msYxBPQTkQbwccgpBdqVMi8UOU8jS0iQXuanKPeV5wEqx8=
X-Received: by 2002:a0d:f085:0:b0:593:47ff:bd7 with SMTP id
 z127-20020a0df085000000b0059347ff0bd7mr4474491ywe.46.1695598784315; Sun, 24
 Sep 2023 16:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-4-worldhello.net@gmail.com>
 <CAPig+cTRByz10ySknTxPB2yVJf5Snz29LNRq5MtPk2MF3nMziQ@mail.gmail.com>
In-Reply-To: <CAPig+cTRByz10ySknTxPB2yVJf5Snz29LNRq5MtPk2MF3nMziQ@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 07:39:33 +0800
Message-ID: <CANYiYbFkG+CvrNFBkdNewZs7ADROVsjd051SDQsU0zVq8eBhew@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] archive: support remote archive from stateless transport
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2023 at 2:52=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Sat, Sep 23, 2023 at 11:22=E2=80=AFAM Jiang Xin <worldhello.net@gmail.=
com> wrote:
> > Even though we can establish a stateless connection, we still cannot
> > archive the remote repository using a stateless HTTP protocol. Try the
> > following steps to make it work.
> > [...]
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> > diff --git a/http-backend.c b/http-backend.c
> > @@ -639,10 +640,19 @@ static void check_content_type(struct strbuf *hdr=
, const char *accepted_type)
> > -       const char *argv[] =3D {NULL, "--stateless-rpc", ".", NULL};
> > +       const char *argv[4];
> >
> > +       if (!strcmp(service_name, "git-upload-archive")) {
> > +               argv[1] =3D ".";
> > +               argv[2] =3D NULL;
> > +       } else {
> > +               argv[1] =3D "--stateless-rpc";
> > +               argv[2] =3D ".";
> > +               argv[3] =3D NULL;
> > +       }
>
> It may not be worth a reroll, but since you're touching this code
> anyhow, these days we'd use `strvec` for this:
>
>     struct strvec argv =3D STRVEC_INIT;
>     if (strcmp(service_name, "git-upload-archive"))
>         strvec_push(&argv, "--stateless-rpc");
>     strvec_push(&argv, ".");

Good suggestion, I'll queue this up as part of next reroll.

--
Jiang Xin
