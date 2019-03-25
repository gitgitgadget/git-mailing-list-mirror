Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C2520248
	for <e@80x24.org>; Mon, 25 Mar 2019 11:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfCYLCl (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 07:02:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37106 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbfCYLCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 07:02:40 -0400
Received: by mail-io1-f67.google.com with SMTP id x7so7225991ioh.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ALwNxFkMCz/39OY+RyRQ/u9ZVS3W/uSpy7I5W//gRQ=;
        b=vNo9na1wztj+jthx2XS3MqscMcs9GO3UTV1S6eWGf32kdMZj97c3odtbPn1PUcVEPL
         A7FRIVzXZlKodce7K4mp3d/4INgjvxNXl6Jk7YcpgYA0zc+snignoLXcKYrydFAyTlhx
         7TlJ98G1V/qR/9/aBbWaBVSHMnnhk7/qMK2K7YJs6i/toYnyz/7zC0b8JXJ7OMKMtBDc
         5vgRopl2WUNIaiKS+R5D9Uu13DMD3fGO9ngVX1RPpDNvIByXGL1xDt/+kuWW2IDLCS2M
         I24VIX54qlSbjiGIx93dksFI45WYVz1ypDwPQwGt892ov5lXcST2vWbeUDetEDR7Rd34
         rXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ALwNxFkMCz/39OY+RyRQ/u9ZVS3W/uSpy7I5W//gRQ=;
        b=ia+D4ZgTWiOlA+vPycpOVpXFw5OE1ocZWwXBoQMfT9n6OBgb2EiOmTsjYKBS4urWaA
         hD6f+FpAT+yqqb2Xt+53ERFwoYHh9uclEfsKSgZXl0YAg2Zl/NF445QrZzjS7RMTe2H4
         qMgJGU42tTvtp7hKYE84HocHNQhlt0o9Yx8WshvX2y44poK6gCB6VPJM1bV7Hd5ZD3P0
         oRvG5udLigg2FcG5pp6CSeZnnhYnS63k2LWz2jenpMaVBmZfdMXn9q5iic1K0keFq/mn
         j8TBV3xaLBedAbniiN1HbP6KjqOn3Ce0rSy9IVuqJLHh++WZTGaq4xL8aubG/GklLp8F
         mEsg==
X-Gm-Message-State: APjAAAWkLMqygqeo4Qeu6zN1HFK4GvWTA0m7dC4X1aN0s39+5aqwfbrk
        DN/WlMRTYx8lHZPoX1X5Sqp2mpUCbwE2DDlgB0o=
X-Google-Smtp-Source: APXvYqydCXA86QcpX+QUaauaMlkaxgwVY7g+lIgEhpnhAoDA+ykYUEnA2flH5CzQYRDzAVYEk0SVdECg7dfCbiutL+w=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr2819715ior.236.1553511759512;
 Mon, 25 Mar 2019 04:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190325103844.26749-1-szeder.dev@gmail.com> <20190325103844.26749-6-szeder.dev@gmail.com>
In-Reply-To: <20190325103844.26749-6-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 25 Mar 2019 18:02:13 +0700
Message-ID: <CACsJy8AYC24tbDhq6LJ5FgZEcSsOYTuw-G88eXdKzbT6iP3NNw@mail.gmail.com>
Subject: Re: [PATCH 5/5] progress: break too long progress bar lines
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 5:41 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> Some of the recently added progress indicators have quite long titles,
> which might be even longer when translated to some languages, and when
> they are shown while operating on bigger repositories, then the
> progress bar grows longer than the default 80 column terminal width.
>
> When the progress bar exceeds the width of the terminal it gets
> line-wrapped, and after that the CR at the end doesn't return to the
> beginning of the progress bar, but to the first column of its last
> line.  Consequently, the first line of the previously shown progress
> bar is not overwritten by the next, and we end up with a bunch of
> truncated progress bar lines scrolling past:
>
>   $ LANG=3Des_ES.UTF-8 git commit-graph write
>   Encontrando commits para commit graph entre los objetos empaquetados:  =
 2% (1599
>   Encontrando commits para commit graph entre los objetos empaquetados:  =
 3% (1975
>   Encontrando commits para commit graph entre los objetos empaquetados:  =
 4% (2633
>   Encontrando commits para commit graph entre los objetos empaquetados:  =
 5% (3292
>   [...]
>
> Prevent this by breaking progress bars after the title once they
> exceed the width of the terminal, so the counter and optional
> percentage and throughput, i.e. all changing parts, are on the last
> line.  Subsequent updates will from then on only refresh the changing
> parts, but not the title, and it will look like this:
>
>   $ LANG=3Des_ES.UTF-8 ~/src/git/git commit-graph write
>   Encontrando commits para commit graph entre los objetos empaquetados:
>     100% (6584502/6584502), listo.
>   Calculando n=C3=BAmeros de generaci=C3=B3n de commit graph: 100% (82470=
5/824705), listo.
>   Escribiendo commit graph en 4 pasos: 100% (3298820/3298820), listo.
>
> Note that the number of columns in the terminal is cached by
> term_columns(), so this might not kick in when it should when a
> terminal window is resized while the operation is running.
> Furthermore, this change won't help if the terminal is so narrow that
> the counters don't fit on one line, but I would put this in the "If it
> hurts, don't do it" box.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  progress.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index b37a5398c5..36aaeea340 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -8,7 +8,7 @@
>   * published by the Free Software Foundation.
>   */
>
> -#include "git-compat-util.h"
> +#include "cache.h"
>  #include "gettext.h"
>  #include "progress.h"
>  #include "strbuf.h"
> @@ -37,6 +37,8 @@ struct progress {
>         struct throughput *throughput;
>         uint64_t start_ns;
>         struct strbuf counters_sb;
> +       int title_len;
> +       int split;
>  };
>
>  static volatile sig_atomic_t progress_update;
> @@ -119,8 +121,22 @@ static void display(struct progress *progress, uint6=
4_t n, const char *done)
>                 const char *eol =3D done ? done : "\r";
>                 int clear_len =3D counters_sb->len < last_count_len ?
>                                 last_count_len - counters_sb->len : 0;
> -               fprintf(stderr, "%s: %s%-*s", progress->title,
> -                       counters_sb->buf, clear_len, eol);
> +               int cols =3D term_columns();
> +
> +               if (progress->split) {
> +                       fprintf(stderr, "  %s%-*s", counters_sb->buf, cle=
ar_len,
> +                               eol);
> +               } else if (!done &&
> +                          cols < progress->title_len + counters_sb->len =
+ 2) {
> +                       clear_len =3D progress->title_len + 1 < cols ?
> +                                   cols - progress->title_len - 1 : 0;
> +                       fprintf(stderr, "%s:%*s\n  %s%s", progress->title=
,
> +                                       clear_len, "", counters_sb->buf, =
eol);
> +                       progress->split =3D 1;
> +               } else {
> +                       fprintf(stderr, "%s: %s%-*s", progress->title,
> +                               counters_sb->buf, clear_len, eol);
> +               }
>                 fflush(stderr);
>                 progress_update =3D 0;
>         }
> @@ -225,6 +241,8 @@ static struct progress *start_progress_delay(const ch=
ar *title, uint64_t total,
>         progress->throughput =3D NULL;
>         progress->start_ns =3D getnanotime();
>         strbuf_init(&progress->counters_sb, 0);
> +       progress->title_len =3D strlen(title);

I think you need utf8_strwidth() so that the "cols < title_len"
comparison above works for multibyte encoding too.

> +       progress->split =3D 0;
>         set_progress_signal();
>         return progress;
>  }
> --
> 2.21.0.539.g07239c3a71.dirty
>


--=20
Duy
