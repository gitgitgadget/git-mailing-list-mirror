Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD411FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbdJYEFU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:05:20 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:48060 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdJYEFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:05:19 -0400
Received: by mail-io0-f181.google.com with SMTP id h70so26169677ioi.4
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sMqwJfGkf3PjyZLhR5IL9VRLO1wjNm9eMwA/jfV7iaY=;
        b=b10ZZ1b2ow9+1LjY9vmh2VTqMWjeu0QRU3RO7av0J+BkPwvtzZD9wYimA4GF7UCjst
         euSxY5fUKHT2Sonl1RhwGRycangDTbSPu9J5Ds5PIKBYA1/tOnZlSDelKUbkUqKK1h0e
         Ju5BDQhKN8HGDGLo1DvTObhLEhSG/DRheelRFLtNzgm8ckqtTF1/N7s8cYhjC0NnwCFI
         XqepIDSJ1z3zrf9+cx6qVejVblP0rvTBpyLdzBjp23JPn/GWX3Sf7WUs+znsTtPrQ8to
         n3Lc9dC+yY958pVPqHVdEnc849P5sRxlCr4hjrfR1kNKMAfEaEG1vss8D8tnmtXROCIf
         hiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sMqwJfGkf3PjyZLhR5IL9VRLO1wjNm9eMwA/jfV7iaY=;
        b=pkALxcl6v0xwiat/sHqhHhHaEI+Djsn/8QOrwsznz8NR5yIIkb78ukg+SToB1N1PcV
         zSL5wv3fmK+Sxfw8G69bh9tDgfaY+9rWtdzyr2AViPaxDhaTycPiplVf+BBdQyzvq9YI
         3ZppiPNoFFTjVU5qyjfOeycWqN78RE0vRwhZW+VvEOhSfQeDy6vXW5MqDIWWIBbbzSLq
         z6AfILBu6RMaakDtzGpCjEW7i1dA+EG8GvjBjwVqb5p0XLEejbMWx40+uWCUTx9A9QeH
         hQ/mrcPLDLwgwwwlgm6Dkb9MaU/pryMg5orfkaTZJDE22pVQRBy5Dj2HbAcVjH4hpUtV
         2POw==
X-Gm-Message-State: AMCzsaVluGur312tK0hj20hCU2KySKeEoMVZ0yj2hbOlhgMuyyNWEtGs
        HCNQzVy/qPU5bBrAY9+z963QiIQW1tx/2Lppmm55VA==
X-Google-Smtp-Source: ABhQp+SRqvmRogWMLU4dxNp1Zh5izQ0mCdnYL9qBbpICW5l5SI1/aKQt5YVMvyNG1BIWpDgIHYPIS/2cPU+R4Y61yNE=
X-Received: by 10.107.212.15 with SMTP id l15mr23191864iog.257.1508904318520;
 Tue, 24 Oct 2017 21:05:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.174.66 with HTTP; Tue, 24 Oct 2017 21:05:17 -0700 (PDT)
In-Reply-To: <20171024185332.57261-4-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com> <20171024185332.57261-4-git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 24 Oct 2017 21:05:17 -0700
Message-ID: <CAGf8dg+_AewifMR8wnrQdJKXK0GuwdhMb8QAMrGoVCJzhysiRw@mail.gmail.com>
Subject: Re: [PATCH 03/13] list-objects: filter objects in traverse_commit_list
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:

> +enum list_objects_filter_result {
> +       LOFR_ZERO      = 0,
> +       LOFR_MARK_SEEN = 1<<0,

Probably worth documenting, something like /* Mark this object so that
it is skipped for the rest of the traversal. */

> +       LOFR_SHOW      = 1<<1,

And something like /* Invoke show_object_fn on this object. This
object may be revisited unless LOFR_MARK_SEEN is also set. */

> +};
> +
> +/* See object.h and revision.h */
> +#define FILTER_REVISIT (1<<25)

I think this should be declared closer to its use - in the sparse
filter code or in the file that uses it. Wherever it is, also update
the chart in object.h to indicate that we're using this 25th bit.

> +
> +enum list_objects_filter_type {
> +       LOFT_BEGIN_TREE,
> +       LOFT_END_TREE,
> +       LOFT_BLOB
> +};
> +
> +typedef enum list_objects_filter_result list_objects_filter_result;
> +typedef enum list_objects_filter_type list_objects_filter_type;

I don't think we typedef enums in Git code.

> +
> +typedef list_objects_filter_result (*filter_object_fn)(
> +       list_objects_filter_type filter_type,
> +       struct object *obj,
> +       const char *pathname,
> +       const char *filename,
> +       void *filter_data);
> +
> +void traverse_commit_list_worker(
> +       struct rev_info *,
> +       show_commit_fn, show_object_fn, void *show_data,
> +       filter_object_fn filter, void *filter_data);

I think things would be much clearer if a default filter was declared
(matching the behavior as of this patch when filter == NULL), say:
static inline default_filter(args) { switch(filter_type) { case
LOFT_BEGIN_TREE: return LOFR_MARK_SEEN | LOFR_SHOW; case
LOFT_END_TREE: return LOFT_ZERO; ...

And inline traverse_commit_list() instead of putting it in the .c file.

This would reduce or eliminate the need to document
traverse_commit_list_worker, including what happens if filter is NULL,
and explain how a user would make their own filter_object_fn.

> +
> +#endif /* LIST_OBJECTS_H */
> --
> 2.9.3
>
