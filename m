Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE0C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BC860F51
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhIEIVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIEIVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 04:21:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCCC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 01:20:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m11so4504331ioo.6
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=abnXPyr0eiiq2jmA/SXt9Jn7c0d/Jbih6mcKtBXrCOc=;
        b=ACpX/Yfcfzqemx9OqgB3C3H8gaxkFC8XC6v3mVQklFX/JD9ctJRDr9Qfexku25hgqo
         444JZq37kVfBDja3cP1zPa4zyc9czZiC/77Ep+ifZoYk70ph35pUC+ooDPYo6IGdLKLI
         s2FEF5ISP56z10G6bAyokzje0dAmxpUHBrSTx/Mj4q3L8JWH2Yvn9SCOXWr9YRcyVXpL
         ZeeERVX1dDIodgVmkHggBTNOWHLBFi/kNc5Z1AW9Lshs7zyVMawMg86xziZuDTLzjCwW
         SKeYsRFp+RsgQJZaripT+XBLUi7Frpn3xR9fggFykvcmA1ASQhHEUutE2WxnZezrb2cj
         /mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abnXPyr0eiiq2jmA/SXt9Jn7c0d/Jbih6mcKtBXrCOc=;
        b=e2HT2WibX8WQeEQmXgRvEWVb3wohH6qvrRUWKZ5PyjzxCCqdFG5pxEAY47U2NZFV44
         CuFc9e0JJTvTiB+s+jwp+E70odU7fI28Ql7VDWfspQh+GNgA5xkfsYJze+7TrCYniFzH
         I50rn+6lKBcMsvKfXrHtxeZdLixIIHt0Oj2SFvcqLBvnOR184VEhOfLIOYyeOj6bBdkp
         tKG7rXrOcvryNsIoaWfMFTc//HXvzV7PWqZiM6Pery1oLj6kRr77ZvgSYU6W7/thL29s
         kLYU6UvHTx2YQ341ledBKcb9hcp0fOIlgG/68xDkeCWqBcCx998Dn4YJdJ8XxnRwx/IZ
         XNBQ==
X-Gm-Message-State: AOAM530nk9ALK+lV9//Q9uobI54K1TmveTuV0QNUFr0zojRzAxaEwbds
        2JikdBVrpE1nmr0KJh21vGfIV3uQtXLs4aGq2A4/iYuxmLjH9tA0
X-Google-Smtp-Source: ABdhPJw0a0ry9adrx3kEbNAW2tuGo3K6QBD/ZbT5vSyYg8mGeW6TyrOw/DytioTs/z8jdPg8oBTDAUp4uRedl9FPrl8=
X-Received: by 2002:a05:6638:d85:: with SMTP id l5mr5996269jaj.2.1630830013605;
 Sun, 05 Sep 2021 01:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
In-Reply-To: <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 5 Sep 2021 16:20:02 +0800
Message-ID: <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=888:41=E5=86=99=E9=81=93=EF=BC=9A
>
> The ref-filter code is very keen to collect all of the refs in an array
> before writing any output. This makes things slower than necessary when
> using the default sort order (which is already sorted by refname when we
> call for_each_ref()), and when no filtering options require it.
>
> This commit adds a mildly-ugly interface to detect this case and stream
> directly from filter_refs(). The caller just needs to call the
> "maybe_stream" function. Either way, they can call the usual sort/print
> functions; they'll just be noops if we did stream instead of collecting.
>
> Here are some timings on a fully-packed 500k-ref repo:
>
>   Benchmark #1: ./git.orig for-each-ref --format=3D'%(objectname) %(refna=
me)'
>     Time (mean =C2=B1 =CF=83):     340.2 ms =C2=B1   5.3 ms    [User: 300=
.5 ms, System: 39.6 ms]
>     Range (min =E2=80=A6 max):   332.9 ms =E2=80=A6 347.0 ms    10 runs
>
>   Benchmark #2: ./git.stream for-each-ref --format=3D'%(objectname) %(ref=
name)'
>     Time (mean =C2=B1 =CF=83):     224.0 ms =C2=B1   3.4 ms    [User: 222=
.7 ms, System: 1.3 ms]
>     Range (min =E2=80=A6 max):   218.1 ms =E2=80=A6 228.5 ms    13 runs
>
>   Summary
>     './git.stream for-each-ref --format=3D'%(objectname) %(refname)'' ran
>       1.52 =C2=B1 0.03 times faster than './git.orig for-each-ref --forma=
t=3D'%(objectname) %(refname)''
>
> So we definitely shave off some time, though we're still _much_ slower
> than a simple `wc -l <packed-refs` (which is around 10ms, though of
> course it isn't actually doing as much work).
>
> The point here is to reduce overall effort, though of course the time to
> first output is much improved in the streaming version, too (about 250ms
> versus 4ms).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/for-each-ref.c |  7 ++++++
>  ref-filter.c           | 50 ++++++++++++++++++++++++++++++++++--------
>  ref-filter.h           |  8 +++++++
>  3 files changed, 56 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 89cb6307d4..fe0b92443f 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -70,6 +70,13 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>         if (verify_ref_format(&format))
>                 usage_with_options(for_each_ref_usage, opts);
>
> +       /*
> +        * try streaming, but only without maxcount; in theory the ref-fi=
lter
> +        * code could learn about maxcount, but for now it is our own thi=
ng
> +        */
> +       if (!maxcount)
> +               ref_filter_maybe_stream(&filter, sorting, icase, &format)=
;
> +

Yes, I think this maxcount is easy to support.

>         if (!sorting)
>                 sorting =3D ref_default_sorting();
>         ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase)=
;
> diff --git a/ref-filter.c b/ref-filter.c
> index 93ce2a6ef2..17b78b1d30 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2283,15 +2283,19 @@ static int ref_filter_handler(const char *refname=
, const struct object_id *oid,
>                         return 0;
>         }
>
> -       /*
> -        * We do not open the object yet; sort may only need refname
> -        * to do its job and the resulting list may yet to be pruned
> -        * by maxcount logic.
> -        */
> -       ref =3D ref_array_push(ref_cbdata->array, refname, oid);
> -       ref->commit =3D commit;
> -       ref->flag =3D flag;
> -       ref->kind =3D kind;
> +       if (ref_cbdata->filter->streaming_format) {
> +               pretty_print_ref(refname, oid, ref_cbdata->filter->stream=
ing_format);

So we directly use pretty_print_ref() in streaming mode, OK.

> +       } else {
> +               /*
> +                * We do not open the object yet; sort may only need refn=
ame
> +                * to do its job and the resulting list may yet to be pru=
ned
> +                * by maxcount logic.
> +                */
> +               ref =3D ref_array_push(ref_cbdata->array, refname, oid);
> +               ref->commit =3D commit;
> +               ref->flag =3D flag;
> +               ref->kind =3D kind;
> +       }
>
>         return 0;
>  }

Therefore, in streaming mode, there is no need to push ref to
ref_array, which can
reduce the overhead of malloc(), free(), which makes sense.

But here is a terrible fact: we did not use ref_array_sort() for sorting he=
re.
So in fact, for_each_fullref_in() does the sorting work () for us by
default sort (%(refname)),
This may be due to the file system or some implementation of ref_iterator.
But this limit the application of this optimization when we use other
atoms to sort.

> @@ -2563,6 +2567,34 @@ void ref_array_sort(struct ref_sorting *sorting, s=
truct ref_array *array)
>         QSORT_S(array->items, array->nr, compare_refs, sorting);
>  }
>
> +void ref_filter_maybe_stream(struct ref_filter *filter,
> +                            const struct ref_sorting *sort, int icase,
> +                            struct ref_format *format)
> +{
> +       /* streaming only works with default for_each_ref sort order */
> +       if (sort || icase)
> +               return;
> +

Yes, this really can only be optimized on the default sort.

> +       /* these filters want to see all candidates up front */
> +       if (filter->reachable_from || filter->unreachable_from)
> +               return;
> +

Make Sence.

> +       /*
> +        * the %(symref) placeholder is broken with pretty_print_ref(),
> +        * which our streaming code uses. I suspect this is a sign of bre=
akage
> +        * in other callers like verify_tag(), which should be fixed. But=
 for
> +        * now just disable streaming.
> +        *
> +        * Note that this implies we've parsed the format already with
> +        * verify_ref_format().
> +        */
> +       if (need_symref)
> +               return;
> +

I haven=E2=80=99t taken a closer look at why pretty_print_ref() does not
support %(symref),
we can skip it first.

> +       /* OK to stream */
> +       filter->streaming_format =3D format;
> +}
> +
>  static void append_literal(const char *cp, const char *ep, struct ref_fo=
rmatting_state *state)
>  {
>         struct strbuf *s =3D &state->stack->output;
> diff --git a/ref-filter.h b/ref-filter.h
> index c15dee8d6b..ecea1837a2 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -69,6 +69,9 @@ struct ref_filter {
>                 lines;
>         int abbrev,
>                 verbose;
> +
> +       /* if non-NULL, streaming output during filter_refs() is enabled =
*/
> +       struct ref_format *streaming_format;
>  };
>
>  struct ref_format {
> @@ -135,6 +138,11 @@ char *get_head_description(void);
>  /*  Set up translated strings in the output. */
>  void setup_ref_filter_porcelain_msg(void);
>
> +/* enable streaming during filter_refs() if options allow it */
> +void ref_filter_maybe_stream(struct ref_filter *filter,
> +                            const struct ref_sorting *sort, int icase,
> +                            struct ref_format *format);
> +
>  /*
>   * Print a single ref, outside of any ref-filter. Note that the
>   * name must be a fully qualified refname.
> --
> 2.33.0.618.g5b11852304
>

Unfortunately, this optimization may not be helpful for git cat-file --batc=
h,
see [1], batch_object_write() directly constructs a ref_array_item and call
format_ref_array_item() to grab data, It does not use ref_array. So it also
does not have this malloc() | free() overhead.

[1]: https://lore.kernel.org/git/9c5fddf6885875ccd3ce3f047bb938c77d9bbca2.1=
628842990.git.gitgitgadget@gmail.com/

--
ZheNing Hu
