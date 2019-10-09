Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4951F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJIBs4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:48:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32875 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfJIBsz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:48:55 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so1461906ior.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5d8r+/nS0E8rytCuBvgbp5+Fk8pE2mUgFlRT6U35i0k=;
        b=oTtYHMksd8msfUcjyGQ6Mu2gb325HH3+HZkwF92Fqa8z4ea87j3+mwhLGyDCIjrtN1
         xXG4PJqyuQ3s4fCriQRQtoE7xTpH3harD6BO8nqzf2d0QKh47Pt9PjbPAWnFBKFQ52oJ
         UsqwbbFAO1GKX5K21DVn8WLUScTWaTZlno5c1UAFBKaqI2XiPM759qNoQiaNqRw8Qgwa
         d3eMtOHDWZxlAUjlEqvypLbFRzPEUOUDMd6iMjnSI07emO5V++kQsfI97+Pp3OTi7FVc
         JR0TjoHKlsRsGKVBbPxM20Q9/bA6bcHw8O+zqXH0ac/pgCQY4zMVVPQgwf5Vle4SQlFa
         QH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5d8r+/nS0E8rytCuBvgbp5+Fk8pE2mUgFlRT6U35i0k=;
        b=Acr+JhS/hvD/UAzArmlmqNfgLcZbU4cvRYGr8cZfH/SwxkAy5LSABv/Jc91WL0woQE
         P/D8P4iBSQpSuUY56aCQjg2LIP9tg9rH6C47IPgYJ5CJrq31EC4yWTvMP6C3HkGABDvv
         L/z1raqYyh70UBEzqUKVl9/t6KDY5d7Nc9TsUoFiP4Bunt3Slfu5XDbQDJU6tqI4FLs8
         RSFDmJftYxin15XLDhlWSTh+4LFJu1rYhR9/eurA75Hc1JMBv5A/vi/NYxlK6rmRGZ2y
         mtfgGh24uUj/2TQUrDpJ2rRd5W1byGLQopAjdsjPN88E2r+BCXnQ7lEPIfxafvGLsSe+
         RpRQ==
X-Gm-Message-State: APjAAAUwmaRR8gQE+dV6eSNRojXf4ycMWYGUH6Hv2pkosLwvF6tJMxEt
        45lttYpng4QX7Z2CNwhep8qSLFhSqav7q11iI6ZDZQ==
X-Google-Smtp-Source: APXvYqxrKAaJ7GwlOxiVGO59NUSnUGWTG9JHx/PNc/0TmzOX4Bf0pWV/173gVSKGEd1n5xqU5LjRc0tMjMqM6g4ttzY=
X-Received: by 2002:a6b:be81:: with SMTP id o123mr1314831iof.86.1570585734808;
 Tue, 08 Oct 2019 18:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com> <20191008184727.14337-2-lucasseikioshiro@gmail.com>
In-Reply-To: <20191008184727.14337-2-lucasseikioshiro@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 8 Oct 2019 22:48:43 -0300
Message-ID: <CAHd-oW7HXzvjxzV=79yRAMHc=msB2rWmWCVEYuB4N1LnOMwDyQ@mail.gmail.com>
Subject: Re: [RFC WIP PATCH 1/3] tag: factor out tag reading from write_tag_body()
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kernel USP <kernel-usp@googlegroups.com>,
        rcdailey.lists@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?B=C3=A1rbara_Fernandes?= <barbara.dcf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 8, 2019 at 3:47 PM Lucas Oshiro <lucasseikioshiro@gmail.com> wr=
ote:
>
> Improve code readability by moving tag reading to a new function called
> get_tag_body, which will be used in the implementation of the git tag
> --amend functionality.

This function is also used in your third patch, to fix git-tag's
--no-edit implementation, right? Maybe you could mention this here,
instead of referencing the --amend feature, as the former is already
present in this series.

> Add warning in write_tag_body() in case the tag body is not successfully
> recovered.
>
> Co-authored-by: B=C3=A1rbara Fernandes <barbara.dcf@gmail.com>
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.dcf@gmail.com>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Helped-by: Matheus Tavares <matheus.bernardino@usp.br>

These tags usually come in chronological order. So I think the
Helped-by should come first as I helped you, then you and B=C3=A1rbara
co-authored the patch and then, lastly, you sent it.

> ---
>  builtin/tag.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index e0a4c25382..e1e3549af9 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -170,26 +170,52 @@ static int git_tag_config(const char *var, const ch=
ar *value, void *cb)
>         return git_color_default_config(var, value, cb);
>  }
>
> -static void write_tag_body(int fd, const struct object_id *oid)
> +/*
> + * Returns the tag body of the given oid or NULL, in case of error. If s=
ize is
> + * not NULL it is assigned the body size in bytes (excluding the '\0').
> + */
> +static char *get_tag_body(const struct object_id *oid, size_t *size)
>  {
> -       unsigned long size;
> +       unsigned long buf_size;
>         enum object_type type;
> -       char *buf, *sp;
> +       char *buf, *sp, *tag_body;
> +       size_t tag_body_size, signature_offset;
>
> -       buf =3D read_object_file(oid, &type, &size);
> +       buf =3D read_object_file(oid, &type, &buf_size);
>         if (!buf)
> -               return;
> +               return NULL;
>         /* skip header */
>         sp =3D strstr(buf, "\n\n");
>
> -       if (!sp || !size || type !=3D OBJ_TAG) {
> +       if (!sp || !buf_size || type !=3D OBJ_TAG) {
>                 free(buf);
> -               return;
> +               return NULL;
>         }
>         sp +=3D 2; /* skip the 2 LFs */
> -       write_or_die(fd, sp, parse_signature(sp, buf + size - sp));
> +       signature_offset =3D parse_signature(sp, buf + buf_size - sp);
> +       sp[signature_offset] =3D '\0';
>
> +       /* detach sp from buf */
> +       tag_body_size =3D strlen(sp) + 1;
> +       tag_body =3D xmalloc(tag_body_size);
> +       xsnprintf(tag_body, tag_body_size, "%s", sp);
>         free(buf);
> +       if (size)
> +               *size =3D tag_body_size - 1; /* exclude '\0' */
> +       return tag_body;
> +}
> +
> +static void write_tag_body(int fd, const struct object_id *oid)
> +{
> +       size_t size;
> +       const char *tag_body =3D get_tag_body(oid, &size);
> +
> +       if (!tag_body) {
> +               warning("failed to get tag body for %s", oid->hash);
> +               return;
> +       }
> +       printf("tag_body: <%s>\n", tag_body);

Hm, is this addition right or perhaps was it added in the patch by mistake?

> +       write_or_die(fd, tag_body, size);
>  }
>
>  static int build_tag_object(struct strbuf *buf, int sign, struct object_=
id *result)
> --
> 2.23.0
>
