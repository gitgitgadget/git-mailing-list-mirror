Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4F520401
	for <e@80x24.org>; Fri, 16 Jun 2017 05:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdFPFjK (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 01:39:10 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33619 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdFPFjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 01:39:09 -0400
Received: by mail-pg0-f47.google.com with SMTP id f185so16358126pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n59XJ3zvF8YnQw77VqqBm7hWradJmFs+yGzNJ0QdtY8=;
        b=Bp4ziSryXIlIgsWF/tT8lXUN67BChuROoslZVUQs26Y+X0IRzRq5Dvn/OWfaE5o1T8
         uesGXxQwHuWeluaXGL+vHP/DgTyd9Nl7dHCYt67j/yZkk6DfztHM4eEWS5Wa2MMdyZ8o
         lCiUa1t3ZNk3GHCouapVg2XKUq3IPCpvaUN5szSyclEkmvM4WoqJl/zNUXYcewEu4g9v
         t8WgUQfA7l383mx1OFlCFkGO1pQtzOBtF9RJiGs62eFcdFuWiEM2JsqTd4DVFUD0+xox
         iNptp2T2LU+84LtLsgkHSN3F/DSlVe2YMiScz26xIEp6KLuZiLFqyI5F6V0dT7JSxqYX
         44gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n59XJ3zvF8YnQw77VqqBm7hWradJmFs+yGzNJ0QdtY8=;
        b=r+2p3XjdMzSiUgg8H2BB/G1DWW5qOAfg7Dt6B3aFJEkrSemzCKgh5+pEuMsZwxY4ol
         b9nOZrY7BmGQwrJslO9IbHLogGc3roD7fLai/eCpRSN5YPx+SetudYXDiqmx/X1oEAjQ
         kHrLMvLP20fFyblG5JhfLpxZcgvyx/cN7R3PKKXQVV/KMEm4jA5hBkrfzKnQsUxK/iAQ
         ZRJ99ZU69JWcCO9gRFnJp/cyQiDdn7Mz6saTr5fgSAg2wtvecCxtd+9SEIrIgT4zYgUi
         jjTCtFKcLOCN98RDe3BrCVhoUA4B/e92RPPzhS73zCP3n0/qcp71/ZqyzrWoOSvLGscM
         +z4w==
X-Gm-Message-State: AKS2vOyYupPBpFfjzDht7F9tWPprHA4TScLtqZ9AFYMkPWulB/U9YwDB
        u4TmOsZIxxUIJ3ZdgHniYBkmmqo/N9L4
X-Received: by 10.98.68.156 with SMTP id m28mr8989943pfi.48.1497591548631;
 Thu, 15 Jun 2017 22:39:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Thu, 15 Jun 2017 22:39:08 -0700 (PDT)
In-Reply-To: <eea8f3d25e9d3d3a0b63604338f10cfa658bbb43.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <eea8f3d25e9d3d3a0b63604338f10cfa658bbb43.1497534157.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Jun 2017 22:39:08 -0700
Message-ID: <CAGZ79ka3u_otP6M+oRBb4dQdMQx6kFHaXihLsBpM23gqzwqOGw@mail.gmail.com>
Subject: Re: [PATCH 04/28] packed_ref_store: move `packed_refs_lock` member here
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Move the `packed_refs_lock` member from `files_ref_store` to
> `packed_ref_store`, and rename it to `lock` since it's now more
> obvious what it is locking.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c4b8e2f63b..de8293493f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -62,6 +62,12 @@ struct packed_ref_store {
>          * it might still be current; otherwise, NULL.
>          */
>         struct packed_ref_cache *cache;
> +
> +       /*
> +        * Lock used for the "packed-refs" file. Note that this (and
> +        * thus the enclosing `packed_ref_store`) must not be freed.
> +        */
> +       struct lock_file lock;
>  };
>
>  static struct packed_ref_store *packed_ref_store_create(
> @@ -87,12 +93,6 @@ struct files_ref_store {
>
>         struct ref_cache *loose;
>
> -       /*
> -        * Lock used for the "packed-refs" file. Note that this (and
> -        * thus the enclosing `files_ref_store`) must not be freed.
> -        */
> -       struct lock_file packed_refs_lock;
> -
>         struct packed_ref_store *packed_ref_store;
>  };
>
> @@ -125,7 +125,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
>         if (refs->packed_ref_store->cache) {
>                 struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
>
> -               if (is_lock_file_locked(&refs->packed_refs_lock))
> +               if (is_lock_file_locked(&refs->packed_ref_store->lock))

I sort of stumble over the name due to singular/plural/genetive issues:
The store contains multiple of "packed ref"(s) or the store is specialized in
packed ref(s). On the other hand in English you seem to reference the
specialisation of a store in singular: It's a "gun store" (not "guns store")
or "furniture store" or "fresh fish store" (though that could be
plural as well).

It just sounded odd to me. (though think of it as a minor nit)
