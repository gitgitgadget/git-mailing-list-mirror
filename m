Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8FDCE7A8B
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 23:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIXXhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 19:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXXhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 19:37:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120BDA
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 16:37:11 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8162698f0dso6401586276.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695598630; x=1696203430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoyuqHu/Ay2i890chxE5slm3kf5GAUFjd7zWSENNdJo=;
        b=QhQQe3Ait004SqJn6+UYzMGaO+eoGs1vnOy7DEFuQ5LKwW8VEFcrKpSVfRN73C4bQf
         QsxvhBlqDTx2e3PvkAJCBCxKcIf0peTQv3xPW7PUp7RzPok5+zq0N1yJB5cETBycvGu0
         VdcWacpodBaCL7dGQv4zJwa6uu94xu/WXu/CnuaVbbNDMKYQK7NwPq3lyqKBOoIg8BU2
         FYduTNB4gA81Lp6hTczmYih2O1VrHtvCrhmpAbg9PQnTqUpCYXSH7+5ihUihFIXBpU5E
         GjeRNruAhASh1ToJYY7knhIHoVxDbEPvFUnPpqmERKvM39/iuqFnhXLR2zHTk2Of+vPJ
         JuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695598630; x=1696203430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoyuqHu/Ay2i890chxE5slm3kf5GAUFjd7zWSENNdJo=;
        b=ppZDuXUE2TGA95j3BysoawPV4PKsw3BfuX15xk9ZI94IttBlB7JoOlHI47x4EGF8ln
         UwrW/m+FPk+o8dsSOc3BdK1nuN5pSJSVw1IB1kCSRvgEM7WSkHXW88Irdd/KjV60DpIO
         uIBZeVAUlWYbZH5makTcytcuUKYxGbqLaJj4dZHbByR4Rs7rRwB53V3Rk6oh7hEDp72K
         W/wsTUtGDBla7vnH2319Jq2YvtCHLlBBT7cgc8LVPan72W7ywpNsPvTOfqc0QdVkxsZG
         xpyiiuDdzX0a3VpXqoXZmANBF4tCdB4DsoROdgqPehEjXAwkstS8qmhZThqZr36BBUG5
         5QpQ==
X-Gm-Message-State: AOJu0Yx4IzK4bA14AMfASwjP0YHzh2ZJ0H452RwcbGE3CmFcHMDVlITr
        CY26HSODWmiFqsKh//bfXOiGBDnBdF9DkkinZgM=
X-Google-Smtp-Source: AGHT+IG6Z0Px2hvb+JwMFlaWLvob/dG6nwcmG+jgHCq8juizeh/M5hzUbzPZWF9AyNLUt6BhMZDlP7gyKED8e11yilI=
X-Received: by 2002:a81:ae64:0:b0:59f:5367:81d3 with SMTP id
 g36-20020a81ae64000000b0059f536781d3mr3457257ywk.11.1695598630672; Sun, 24
 Sep 2023 16:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-4-worldhello.net@gmail.com>
 <f4877c36-ff26-4f81-b5dd-63c929ba30c9@gmail.com>
In-Reply-To: <f4877c36-ff26-4f81-b5dd-63c929ba30c9@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 07:36:59 +0800
Message-ID: <CANYiYbHjk4CX4Uswn4sX-tH3e22uLSHk_4bwjqVO=9MWcfoHnw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] archive: support remote archive from stateless transport
To:     phillip.wood@dunelm.org.uk
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2023 at 9:41=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/09/2023 16:22, Jiang Xin wrote:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Even though we can establish a stateless connection, we still cannot
> > archive the remote repository using a stateless HTTP protocol. Try the
> > following steps to make it work.
> >
> >   1. Add support for "git-upload-archive" service in "http-backend".
> >
> >   2. Use the URL ".../info/refs?service=3Dgit-upload-pack" to detect th=
e
> >      protocol version, instead of use the "git-upload-archive" service.
> >
> >   3. "git-archive" does not expect to see protocol version and
> >      capabilities when connecting to remote-helper, so do not send them
> >      in "remote-curl.c" for the "git-upload-archive" service.
>
> I'm not familiar enough with the server side of git to comment on
> whether this patch is a good idea, but I did notice one C language issue
> below.
>
> >   static struct string_list *get_parameters(void)
> > @@ -639,10 +640,19 @@ static void check_content_type(struct strbuf *hdr=
, const char *accepted_type)
> >
> >   static void service_rpc(struct strbuf *hdr, char *service_name)
> >   {
> > -     const char *argv[] =3D {NULL, "--stateless-rpc", ".", NULL};

For the original implementation, the first NULL is used as a
placeholder, and will be initialized somewhere below.

> In the pre-image argv[0] is initialized to NULL
>
> > +     const char *argv[4];
>
> In the post-image argv is not initialized and the first element is not
> set in the code below.
>
> >       struct rpc_service *svc =3D select_service(hdr, service_name);
> >       struct strbuf buf =3D STRBUF_INIT;
> >
> > +     if (!strcmp(service_name, "git-upload-archive")) {
> > +             argv[1] =3D ".";
> > +             argv[2] =3D NULL;
> > +     } else {
> > +             argv[1] =3D "--stateless-rpc";
> > +             argv[2] =3D ".";
> > +             argv[3] =3D NULL;
> > +     }

It will be initialized in the code further below, see http-backend.c:668.

        argv[0] =3D svc->name;
        run_service(argv, svc->buffer_input);
        strbuf_release(&buf);

Anyway, I will rewrite these code in reroll v3 to follow Eric's suggestion.

> Best Wishes
>
> Phillip
>
