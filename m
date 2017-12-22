Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365E61F406
	for <e@80x24.org>; Fri, 22 Dec 2017 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756415AbdLVSJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 13:09:40 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42684 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755863AbdLVSJj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 13:09:39 -0500
Received: by mail-qk0-f196.google.com with SMTP id d202so11212396qkc.9
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9gtJX9GXEc7vCXRDDMuQJOkFZIbQRfG3I27kRZ6aA+A=;
        b=iHX3rNomndOrdmp5mlvNbIsrgubhD3Emsh6TdlEQP8K9722ntsRn+r5I3OjZEhOOFC
         vtv5HfzQV+bt3JcAy0inaddx9odPfxq3t2gXqwtKyZP/G0eNFPkGU3X61NNbcCbtKzoR
         kZKLBNU+nBZpIOE7uYmjphpyYhaoYWLL0CBbBifQ5iOtu7PwndZ++Kz2kjwya1etNQm/
         WUurDd3snIoNVPXezJyEIffZTFVLYoYT4sM3b60MBmOyIkXACQW2IDIWNMzI8OicgcMX
         D7Hwa05XVaiv/k5bev5lRzrY6j/iGYnom+Ud2KE0+C344kHC17o0cZeZmPhwF7b7Ma1m
         5YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9gtJX9GXEc7vCXRDDMuQJOkFZIbQRfG3I27kRZ6aA+A=;
        b=b5UjplUA7w9Cu1b/edYtSAG92PsGwxqghFQn5DaimX4xHwkZ/UoXe2jRJx6vGx0du7
         EtC2gA/eKaKKxZmiKdRKVNJOPdWnj2xY1j4WLqYQZOX85v6WdjDyRshBLYHDRL4DYdsi
         g9OeJA+DEP+OJ9P5zT6Ni5IvrU0Ri1Rpd4/Lf1FYvOu4hyCExCsbG303cC3eCpXBY5E7
         sdPm3x573SH+AUXlzU3wa0lLAKTEZZR7APFKnVwp7R/lgDOTmdnTTVtdglxWC8/VlJt5
         ErRh7gxynlX74crVGjP8wsfRLQ1Zr4X+wkPFG2VhQ+5yOJjBrIb/ZzofhEFdprS0Azn9
         6q9g==
X-Gm-Message-State: AKGB3mJaVp8zDnQI4fEzgEIeNAZQSX7HbBxayX9HWwQBJADXWNUQPnjv
        fqsNEV9aP7MzvZiDh9fVjjUL/3rnW7RatxGwYUr6YQ==
X-Google-Smtp-Source: ACJfBotPiBJwbEzg0jokIBFtmMSrhsHdoQUvXpbJQR0VRRL3i5myOGVC2yhFX/HWc9lch/9uVjqnoZ+3YLVA9FpwZO4=
X-Received: by 10.55.124.7 with SMTP id x7mr15109063qkc.133.1513966177990;
 Fri, 22 Dec 2017 10:09:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Fri, 22 Dec 2017 10:09:37 -0800 (PST)
In-Reply-To: <d532a23f-cf73-615c-976d-f4fe83309feb@web.de>
References: <d532a23f-cf73-615c-976d-f4fe83309feb@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Dec 2017 10:09:37 -0800
Message-ID: <CAGZ79kb43_nSm-tjv3zOw7OFzByM3WocYboB6QRr=Z7bRue_hA@mail.gmail.com>
Subject: Re: [PATCH] send-pack: use internal argv_array of struct child_process
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 12:14 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Avoid a magic number of NULL placeholder values and a magic index by
> constructing the command line for pack-objects using the embedded
> argv_array of the child_process.  The resulting code is shorter and
> easier to extend.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  send-pack.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index a8cc6b266e..2112d3b27a 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -58,35 +58,25 @@ static int pack_objects(int fd, struct ref *refs, str=
uct oid_array *extra, struc
>          * the revision parameters to it via its stdin and
>          * let its stdout go back to the other end.
>          */
> -       const char *argv[] =3D {
> -               "pack-objects",
> -               "--all-progress-implied",
> -               "--revs",
> -               "--stdout",
> -               NULL,
> -               NULL,
> -               NULL,
> -               NULL,
> -               NULL,
> -               NULL,
> -       };
>         struct child_process po =3D CHILD_PROCESS_INIT;
>         FILE *po_in;
>         int i;
>         int rc;
>
> -       i =3D 4;
> +       argv_array_push(&po.args, "pack-objects");
> +       argv_array_push(&po.args, "--all-progress-implied");
> +       argv_array_push(&po.args, "--revs");
> +       argv_array_push(&po.args, "--stdout");

(useless nit of the day, no need to resend:)
These four statements could be done as pushl(a,b,c, NULL);
but it would not differ in readability, so I guess either is fine.

Thanks,
Stefan

>         if (args->use_thin_pack)
> -               argv[i++] =3D "--thin";
> +               argv_array_push(&po.args, "--thin");
>         if (args->use_ofs_delta)
> -               argv[i++] =3D "--delta-base-offset";
> +               argv_array_push(&po.args, "--delta-base-offset");
>         if (args->quiet || !args->progress)
> -               argv[i++] =3D "-q";
> +               argv_array_push(&po.args, "-q");
>         if (args->progress)
> -               argv[i++] =3D "--progress";
> +               argv_array_push(&po.args, "--progress");
>         if (is_repository_shallow())
> -               argv[i++] =3D "--shallow";
> -       po.argv =3D argv;
> +               argv_array_push(&po.args, "--shallow");
>         po.in =3D -1;
>         po.out =3D args->stateless_rpc ? -1 : fd;
>         po.git_cmd =3D 1;
> --
> 2.15.1
