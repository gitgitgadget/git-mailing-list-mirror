Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE09C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5653D2065F
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq0Jo0cH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETQk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETQk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 12:40:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC1EC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:40:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a68so2966689otb.10
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8s/UdMUqZAte8A9fJBI23ogt1VhpRMOQ+2rnOOKmv8=;
        b=hq0Jo0cHJtr/G0jaLZ1qbtUvvBjW1WWUPiUjmLRDLrKnugqcsckG8P4iic0OtLISel
         VXHlRVKgkAUQ6WEFMqV/xoM2L3OHIv8wWk9SQ7o2J6JpJD67/QNgdNMXaGnhtMb4VYDf
         Ebm+wLhvTAJ3GKlbjdY9dz9EseD5j62RuhTtQHVCsVmHPrpqeAse1qCSOucYeASL5n/a
         kj8OFWHXjRVjuqmH7MWlrI8TAXpT3OnBZ0MpN7gHI3j/E/MAzNlctgsIQQvSUwrrfh0M
         8UoPoO601f+3WtAQeizYvD8NcPIywc97jYFsMfp26FWr7X3HtGaIpX4P+65bA2s/+Qp7
         QTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8s/UdMUqZAte8A9fJBI23ogt1VhpRMOQ+2rnOOKmv8=;
        b=IaPh14mMu5h8vjHnjOIsyDNCdRB4ZPFCpdNsKewJn9rIhMFb3uKN5/bTc10n7vqaZX
         bTcglKLSQJ9YfSpVHzblJZy2s0PpFL9KYWoHWGGvzuKEF8PdyofK/fMSUDum65A0MM0z
         PFYrAGevj9wihda1MFuUymsbG8W8EQrCn6qAiFVjmTHai7gTBfxhUMRho50m70pvfD/J
         Ayl2Rn4S2G5mvitoJfQyBdRLmBkpoyAhr0m0sk4mPUID2MEzjM3hH/7IryYS8UfLg7ok
         5xNT7QJxjEteGZ8yj5e8pgyMjOTP6u3QwhFdAqasM9nh3cp/Lymy1kV/VXf9bNc7tboA
         a8Nw==
X-Gm-Message-State: AOAM531z9WY7gc+nwLCSvej1g3W7XHjS0J9LqRZqr91szDZWqpmCh3PA
        0j/Ikzl7xuQiCHv3d0RIKmqFLKfIN7piZyIWUsg=
X-Google-Smtp-Source: ABdhPJwY/AII/zw/kcpjnFEIgPBQdBpeIg/NA5ED6V2uglBn+e06rzxmknohyZVK2FdaxO9Abx4t0T4ccoal1d+T2n4=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr3923758ota.345.1589992858305;
 Wed, 20 May 2020 09:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com> <fcf948bda7aebcc5f88c17f5b308b2ce0cc285f5.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <fcf948bda7aebcc5f88c17f5b308b2ce0cc285f5.1588857462.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 09:40:46 -0700
Message-ID: <CABPp-BEkf0TVTt4=adJ9x70j814frL932vxyQCpm74AQiHWwGQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] sparse-checkout: use oidset to prevent repeat blobs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 6:21 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As we parse the in-tree config files that store the sparse.dir values
> used to create an in-tree sparse-checkout definition, we can easily
> avoid parsing the same file multiple times by using an oidset on those
> blobs. We only parse if the oid is new to the oidset.
>
> This is unlikely to have a major performance benefit right now, but will
> be extremely important when we introduce the sparse.inherit options to
> link multiple files in a directed graph. This oidset will prevent
> infinite loops when cycles exist in that digraph, or exponential blowups
> even in the case of a directed acyclic graph.

I'm still not sure if I like the idea of having a mirror dependency
structure separate from (and duplicative of) the build code; I'm still
mulling that over.

It's good that you've protected against infinite loops.

Is there any reason to prefer swallowing infinite loops rather than
warning or flagging as an error?  (I'm not sure, just thinking my
questions out loud.)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  sparse-checkout.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/sparse-checkout.c b/sparse-checkout.c
> index 6c58fda9722..d01f4d7b525 100644
> --- a/sparse-checkout.c
> +++ b/sparse-checkout.c
> @@ -9,6 +9,7 @@
>  #include "string-list.h"
>  #include "unpack-trees.h"
>  #include "object-store.h"
> +#include "oidset.h"
>
>  char *get_sparse_checkout_filename(void)
>  {
> @@ -77,9 +78,12 @@ int load_in_tree_pattern_list(struct repository *r,
>                               struct string_list *sl,
>                               struct pattern_list *pl)
>  {
> +       int result = 0;
>         struct index_state *istate = r->index;
>         struct string_list_item *item;
>         struct strbuf path = STRBUF_INIT;
> +       struct oidset set;
> +       oidset_init(&set, 16);
>
>         pl->use_cone_patterns = 1;
>
> @@ -96,24 +100,34 @@ int load_in_tree_pattern_list(struct repository *r,
>                  * Use -1 return to ensure populate_from_existing_patterns()
>                  * skips the sparse-checkout updates.
>                  */
> -               if (pos < 0)
> -                       return -1;
> +               if (pos < 0) {
> +                       result = -1;
> +                       goto cleanup;
> +               }
>
>                 oid = &istate->cache[pos]->oid;
> +
> +               if (oidset_contains(&set, oid))
> +                       continue;
> +
> +               oidset_insert(&set, oid);
> +
>                 type = oid_object_info(r, oid, NULL);
>
>                 if (type != OBJ_BLOB) {
>                         warning(_("expected a file at '%s'; not updating sparse-checkout"),
>                                 oid_to_hex(oid));
> -                       return 1;
> +                       result = 1;
> +                       goto cleanup;
>                 }
>
>                 load_in_tree_from_blob(pl, oid);
>         }
>
> +cleanup:
>         strbuf_release(&path);
> -
> -       return 0;
> +       oidset_clear(&set);
> +       return result;
>  }
>
>  int populate_sparse_checkout_patterns(struct pattern_list *pl)
> --
> gitgitgadget
>
