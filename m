Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F731F404
	for <e@80x24.org>; Wed, 11 Apr 2018 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeDKR55 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 13:57:57 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44699 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDKR54 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 13:57:56 -0400
Received: by mail-ot0-f195.google.com with SMTP id p33-v6so2972281otp.11
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TOFST5oiYlAtDeAxxbMdQxxAAVgtSF+uGEINNjdLJYw=;
        b=Y71tzG6ahZREjX5PuK4Ubc04j6j52uF857l4ms2R4vLz/qt5m8C9sC/zHTdXV4gX8d
         wkCzBuF8Sd2w3uorLMF6Wcvg/stM9ZwOqJTQVL+ybQLwq1YESborAqGQUVxR8uUkUSbD
         dOnq2RNuFdxKHS4gaAv5yV2BVc48ZJXuGicvorBFQi6xD3APFaMNoc4EQkqRN5/BYhFn
         co3YHl64CXtGXRrH9YwGKMYLZKNfTqgu/Fgys6f/IgfEWal1Vxla3ldBUHGvgKILxKR0
         /Rsov41TUrp4bBjLnDY4UQlTELwqYobkj42twsHg1NvyWUmWeUJJGLPBzOCYQW5Wi6nV
         P24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TOFST5oiYlAtDeAxxbMdQxxAAVgtSF+uGEINNjdLJYw=;
        b=eGr9M3VWC2CI88JaP/xlq3qciEQm/8klMm5FsA3IBEn967OSo/4C5tIq9t2QnjLnbK
         cC240W/ZCJF8nn8QpoL6ec5NJxzSct9lQyWJp6H2PLTDBHAmjci2f59z+itZ5bUJKlHR
         bpFROo8m//1GOky1I7HZ0gp+LH4kHR+GfXwTCmnDJ4ONRStY+7pfUeoC2QM6xUEc28h8
         POIpMJptd3T9wPrwZ+t8wJpvFFfoorYRfqQiB+tI0krPAMgaO3ur5rbJLzT7seSoX6+r
         vFKB7nDnsnxBtQobYRUvQF7AAwRxky93h1+z8Va9q/Oj1Awhi0xo8wqsacp5aW8iSpF+
         T9AQ==
X-Gm-Message-State: ALQs6tCSmwiApDVhEYYHzQ9BS+MoqQPRkZ9h3CcgXsfmp/zTCgB5KcTD
        l1VCoPc/xxv+/tzKkwIZ9dF6+lHrySFnZpuK/fA=
X-Google-Smtp-Source: AIpwx4/CUDKFH3dWYREbyESyZiLsrlb8GrB/OiYhcdAEXIluuIqMrwN5nMmVNTBRfhh7pTidaKO54DS7wYLGCebMXMI=
X-Received: by 2002:a9d:481a:: with SMTP id c26-v6mr3958755otf.393.1523469475981;
 Wed, 11 Apr 2018 10:57:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Wed, 11 Apr 2018 10:57:15 -0700 (PDT)
In-Reply-To: <20180409014226.2647-2-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180409014226.2647-1-haraldnordgren@gmail.com> <20180409014226.2647-2-haraldnordgren@gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Wed, 11 Apr 2018 19:57:15 +0200
Message-ID: <CAHwyqnURebvfW4rGz9RAbe7B9p6ZDy0jUueDFrYE30dmjCtMVA@mail.gmail.com>
Subject: Re: [PATCH v14 2/4] ref-filter: make ref_array_item allocation more consistent
To:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been no new comments for the last few days. I know Jeff
King will be away for the next two weeks, but should we still move
forward with this? The initial reactions to the idea seemed positive.

Best regards
Harald

On Mon, Apr 9, 2018 at 3:42 AM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> From: Jeff King <peff@peff.net>
>
> We have a helper function to allocate ref_array_item
> structs, but it only takes a subset of the possible fields
> in the struct as initializers. We could have it accept an
> argument for _every_ field, but that becomes a pain for the
> fields which some callers don't want to set initially.
>
> Instead, let's be explicit that it takes only the minimum
> required to create the ref, and that callers should then
> fill in the rest themselves.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  ref-filter.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index ade97a848..c1c3cc948 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1824,15 +1824,18 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
>         return NULL;
>  }
>
> -/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
> +/*
> + * Allocate space for a new ref_array_item and copy the name and oid to it.
> + *
> + * Callers can then fill in other struct members at their leisure.
> + */
>  static struct ref_array_item *new_ref_array_item(const char *refname,
> -                                                const struct object_id *oid,
> -                                                int flag)
> +                                                const struct object_id *oid)
>  {
>         struct ref_array_item *ref;
> +
>         FLEX_ALLOC_STR(ref, refname, refname);
>         oidcpy(&ref->objectname, oid);
> -       ref->flag = flag;
>
>         return ref;
>  }
> @@ -1927,12 +1930,13 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>          * to do its job and the resulting list may yet to be pruned
>          * by maxcount logic.
>          */
> -       ref = new_ref_array_item(refname, oid, flag);
> +       ref = new_ref_array_item(refname, oid);
>         ref->commit = commit;
> +       ref->flag = flag;
> +       ref->kind = kind;
>
>         REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
>         ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
> -       ref->kind = kind;
>         return 0;
>  }
>
> @@ -2169,7 +2173,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
>                       const struct ref_format *format)
>  {
>         struct ref_array_item *ref_item;
> -       ref_item = new_ref_array_item(name, oid, 0);
> +       ref_item = new_ref_array_item(name, oid);
>         ref_item->kind = ref_kind_from_refname(name);
>         show_ref_array_item(ref_item, format);
>         free_array_item(ref_item);
> --
> 2.14.3 (Apple Git-98)
>
