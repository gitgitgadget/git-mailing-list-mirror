Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA64C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 11:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CFF6115B
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 11:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhDPL3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbhDPL3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 07:29:16 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82316C061756
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 04:28:44 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f15so18575266iob.5
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T3ICsUTPPFMf2/hzZ80wJOFss/akTRxQJzJCE8HJb4A=;
        b=cVtSr+XT67op55LDqW+EaXEBUU5eOVBdu4k6i9CYrfO4BR67mlU9ntNotWhzvdOoG2
         ah0flMpGpnrTwY+o1v7Jx1+zSEAa8FOjg+SqRg3oYyIixTDcbtO045GQyQK4dEb/R/Nb
         pO+pAMsvzSEEa+57l3rzZNGSQsOX+v1bJZfDlejRctm9kk2rginMV4DN457IrU1cIlB1
         nBW56D5aQCqwolRpgzp5Y9k1LjoIp3pZl2c7MTSjNqC9sV6JGMy/gp0h5gzxRS6E3AIX
         ln3lwDEZJs3Gme5zTTsrYkwp9sUpHS+sUy5Eb0And9jkCXv4i+OdY8LjtLeRyPdUmpJi
         1CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T3ICsUTPPFMf2/hzZ80wJOFss/akTRxQJzJCE8HJb4A=;
        b=rwb3/gyUwTGggvSZORROMGFk6ESYYhpJ+tpNwlH56yCyG3AySKJLaXR7jIbOpVxP5L
         avHlafBhcgMdoXPTIvnlJ33N6TzqLx6s5MkX3mLEqgSA3MA8MFh5bfP5znxASMCudCog
         qptkMOLods/xeT2dC0x5xE9oFoqUh4bulDN0BWhCshciT0qjKWAWRRoCbrOHHmo9g1d9
         6MkH7MiOtkNkepiYDthyDibJN3g41kOD5gJgs7VlCjYG0iT6XDUzBKWery88YcTpQ8Z5
         ytW0Jc61KiTcY6ifCbNWcscMuySfkIilsd06uWJix1FKSFwCg3kLlVi7eNem+OLhI/Ed
         B0TQ==
X-Gm-Message-State: AOAM530CjUL3yU/qlNxv8O39pmHWva9Z5oJDlNiPfbbtkHwbX0pz/cIL
        qwkSNEBfDSzBLaGvAJPyCPozrnh8MBzHkKUtdGU=
X-Google-Smtp-Source: ABdhPJwNZwaz7N9u4JUH9SKLh7GSTzg9Wa63p4uiodxeeuMPs/BxKPAsKRQSwLMjZv1NKKE9jYsYULia6pe/BpQ4+pk=
X-Received: by 2002:a02:ccd9:: with SMTP id k25mr3531729jaq.29.1618572523932;
 Fri, 16 Apr 2021 04:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.928.git.1617975348494.gitgitgadget@gmail.com>
In-Reply-To: <pull.928.git.1617975348494.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 16 Apr 2021 19:28:28 +0800
Message-ID: <CAOLTT8Tis5Yjg8UR0c-i0BnqiFQvLXvDgxUQJ-WcP6jjQPu9cQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: get rid of show_ref_array_item
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2021=E5=B9=B4=
4=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:35=E5=86=99=E9=
=81=93=EF=BC=9A
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf.
> But we can reuse the final strbuf for each step ref's output.
> Since `show_ref_array_item()` is not used in many places,
> we can directly delete `show_ref_array_item()` and use the
> same logic code to replace it. In this way, the caller can
> clearly see how the loop work.
>
> The performance for `git for-each-ref` on the Git repository
> itself with performance testing tool `hyperfine` changes from
> 23.7 ms =C2=B1 0.9 ms to 22.2 ms =C2=B1 1.0 ms.
>
> At the same time, we apply this optimization to `git tag -l`
> and `git branch -l`, the `git branch -l` performance upgrade
> from 5.8 ms =C2=B1 0.8 ms to 2.7 ms =C2=B1 0.2 ms and `git tag -l`
> performance upgrade from 5.9 ms =C2=B1 0.4 ms to 5.4 ms =C2=B1 0.4 ms.
> Since the number of tags in git.git is much more than branches,
> so this shows that the optimization will be more obvious in
> those repositories that contain a small number of objects.
>
> This approach is similar to the one used by 79ed0a5
> (cat-file: use a single strbuf for all output, 2018-08-14)
> to speed up the cat-file builtin.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: get rid of show_ref_array_item
>
>     Now git for-each-ref can reuse final buf for all refs output, the
>     performance is slightly improved, This optimization is also applied t=
o
>     git tag -l and git branch -l.
>
>     Thanks.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-928%2Fa=
dlternative%2Fref-filter-reuse-buf-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-928/adlter=
native/ref-filter-reuse-buf-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/928
>
>  builtin/branch.c       |  8 ++++----
>  builtin/for-each-ref.c | 13 +++++++++++--
>  builtin/tag.c          | 13 +++++++++++--
>  ref-filter.c           | 24 +++++++++---------------
>  ref-filter.h           |  2 --
>  5 files changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index bcc00bcf182d..5c797e992aa4 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filter,=
 struct ref_sorting *sortin
>  {
>         int i;
>         struct ref_array array;
> +       struct strbuf out =3D STRBUF_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
>         int maxwidth =3D 0;
>         const char *remote_prefix =3D "";
>         char *to_free =3D NULL;
> @@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filter,=
 struct ref_sorting *sortin
>         ref_array_sort(sorting, &array);
>
>         for (i =3D 0; i < array.nr; i++) {
> -               struct strbuf out =3D STRBUF_INIT;
> -               struct strbuf err =3D STRBUF_INIT;
> +               strbuf_reset(&out);
>                 if (format_ref_array_item(array.items[i], format, &out, &=
err))
>                         die("%s", err.buf);
>                 if (column_active(colopts)) {
> @@ -452,10 +453,9 @@ static void print_ref_list(struct ref_filter *filter=
, struct ref_sorting *sortin
>                         fwrite(out.buf, 1, out.len, stdout);
>                         putchar('\n');
>                 }
> -               strbuf_release(&err);
> -               strbuf_release(&out);
>         }
>
> +       strbuf_release(&out);
>         ref_array_clear(&array);
>         free(to_free);
>  }
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index cb9c81a04606..157cc8623949 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const=
 char *prefix)
>         struct ref_array array;
>         struct ref_filter filter;
>         struct ref_format format =3D REF_FORMAT_INIT;
> +       struct strbuf output =3D STRBUF_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
>
>         struct option opts[] =3D {
>                 OPT_BIT('s', "shell", &format.quote_style,
> @@ -80,8 +82,15 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>
>         if (!maxcount || array.nr < maxcount)
>                 maxcount =3D array.nr;
> -       for (i =3D 0; i < maxcount; i++)
> -               show_ref_array_item(array.items[i], &format);
> +       for (i =3D 0; i < maxcount; i++) {
> +               strbuf_reset(&output);
> +               if (format_ref_array_item(array.items[i], &format, &outpu=
t, &err))
> +                       die("%s", err.buf);
> +               fwrite(output.buf, 1, output.len, stdout);
> +               putchar('\n');
> +       }
> +
> +       strbuf_release(&output);
>         ref_array_clear(&array);
>         return 0;
>  }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index d403417b5625..b172f3861413 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct =
ref_sorting *sorting,
>                      struct ref_format *format)
>  {
>         struct ref_array array;
> +       struct strbuf output =3D STRBUF_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
>         char *to_free =3D NULL;
>         int i;
>
> @@ -63,8 +65,15 @@ static int list_tags(struct ref_filter *filter, struct=
 ref_sorting *sorting,
>         filter_refs(&array, filter, FILTER_REFS_TAGS);
>         ref_array_sort(sorting, &array);
>
> -       for (i =3D 0; i < array.nr; i++)
> -               show_ref_array_item(array.items[i], format);
> +       for (i =3D 0; i < array.nr; i++) {
> +               strbuf_reset(&output);
> +               if (format_ref_array_item(array.items[i], format, &output=
, &err))
> +                       die("%s", err.buf);
> +               fwrite(output.buf, 1, output.len, stdout);
> +               putchar('\n');
> +       }
> +
> +       strbuf_release(&output);
>         ref_array_clear(&array);
>         free(to_free);
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f0bd32f71416..9e38e42fb7ae 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2435,27 +2435,21 @@ int format_ref_array_item(struct ref_array_item *=
info,
>         return 0;
>  }
>
> -void show_ref_array_item(struct ref_array_item *info,
> -                        const struct ref_format *format)
> -{
> -       struct strbuf final_buf =3D STRBUF_INIT;
> -       struct strbuf error_buf =3D STRBUF_INIT;
> -
> -       if (format_ref_array_item(info, format, &final_buf, &error_buf))
> -               die("%s", error_buf.buf);
> -       fwrite(final_buf.buf, 1, final_buf.len, stdout);
> -       strbuf_release(&error_buf);
> -       strbuf_release(&final_buf);
> -       putchar('\n');
> -}
> -
>  void pretty_print_ref(const char *name, const struct object_id *oid,
>                       const struct ref_format *format)
>  {
>         struct ref_array_item *ref_item;
> +       struct strbuf output =3D STRBUF_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
> +
>         ref_item =3D new_ref_array_item(name, oid);
>         ref_item->kind =3D ref_kind_from_refname(name);
> -       show_ref_array_item(ref_item, format);
> +       if (format_ref_array_item(ref_item, format, &output, &err))
> +               die("%s", err.buf);
> +       fwrite(output.buf, 1, output.len, stdout);
> +       putchar('\n');
> +
> +       strbuf_release(&output);
>         free_array_item(ref_item);
>  }
>
> diff --git a/ref-filter.h b/ref-filter.h
> index 19ea4c413409..baf72a718965 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -119,8 +119,6 @@ int format_ref_array_item(struct ref_array_item *info=
,
>                           const struct ref_format *format,
>                           struct strbuf *final_buf,
>                           struct strbuf *error_buf);
> -/*  Print the ref using the given format and quote_style */
> -void show_ref_array_item(struct ref_array_item *info, const struct ref_f=
ormat *format);
>  /*  Parse a single sort specifier and add it to the list */
>  void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *at=
om);
>  /*  Callback function for parsing the sort option */
>
> base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
> --
> gitgitgadget

The patch seems to have fallen into the crack.
Jeff and Junio, willing to help?

Thanks!
--
ZheNing Hu
