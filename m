Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576361F597
	for <e@80x24.org>; Sun, 22 Jul 2018 08:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeGVJrV (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 05:47:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33127 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeGVJrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 05:47:20 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so13216537iol.0
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DXNIhU1LC/s6aZ4SWFpDslpjUvHK8/ALRBNQtnXbMQ=;
        b=jdNgHr/U8BESXpl5S46T/mgJiEYFMQQU6IUE3PTx75BqMIM3q+BfEeyAWCTx/HM32V
         E2RybFU+RlD49uuTlC5tMLLaOFXsU117AasMnSLlke2RqH6hNSqyXOJOwZ5VLpn3tkMI
         7yIQAqNY2j4LN7lWEGrg2UWlMUlJj1yYFM5Zrnw1Tldz+4yMKFQqW5HI9jO+3vVCwDkV
         CAeWisXTuQPxBBBXaKLYgXRJWRqwmruVVsCUdljA5xIFjynK7/kbAvz5XvtzAy0jjpmN
         +VeMc4vFl6N6Pn4ETMWlngBtOL4j9Qcy/XOAa5vGVE1bZTmVVEVHnR4qMHRkfEIR8FPw
         Cs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DXNIhU1LC/s6aZ4SWFpDslpjUvHK8/ALRBNQtnXbMQ=;
        b=twfGBdelGoP20IHsDoiZzq/dZVIrtGPq+OX5mgPD1BO6I0t9twILykAOrBJDsBceMI
         fADgu4AIE8AsOyhokolimpOgOYl0PRfVRSnGpfBCKIAiTC2gBLZ+NE7xBGuR5Qdt+zme
         LmxJsqDqe0IxmB6QdhesMM3csK+QV/+AQV3FTmT73k4LZpiSLl+SL4w36rn37YYvLQMT
         CWfiIamPSL5CQ540rbCYQshZ+51lHjrjgSFzZg2u/ldbw4ZBepIIfsymhV/ZDGtPDgB1
         EnP++1GJ50+3GvTdDJKXdwC3GA6xNnO4hio5NtzDu/g6ZTR4DcwF3V6PK/DW+jiTvjod
         emaw==
X-Gm-Message-State: AOUpUlEZYFBjDFjsuSIzBE+xJJpxIE/737J3AQOCiOG5R0Dd7h0Vio32
        mDzri/CMo2mTm9+ZzMb6PGy7khJmYlgghXgtrjw=
X-Google-Smtp-Source: AAOMgpfFg91fTbXHmdbZI9dfB4IAUblrkoiz+xGNvaNRtziNtNxQE+HvP8W1j5OePW5EVwJ4jXtwJep8WL0G92KHFZ4=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr6547380iod.118.1532249482461;
 Sun, 22 Jul 2018 01:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org> <20180722054836.28935-3-chriscool@tuxfamily.org>
In-Reply-To: <20180722054836.28935-3-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 10:50:56 +0200
Message-ID: <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 7:51 AM Christian Couder
<christian.couder@gmail.com> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a32172a43c..f682e92a1a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2542,6 +2542,10 @@ Note that changing the compression level will not automatically recompress
>  all existing objects. You can force recompression by passing the -F option
>  to linkgit:git-repack[1].
>
> +pack.island::
> +       A regular expression configuring a set of delta islands. See
> +       "DELTA ISLANDS" in linkgit:git-pack-objects[1] for details.
> +

That section is not added until 3/5 though.

> diff --git a/delta-islands.c b/delta-islands.c
> new file mode 100644
> index 0000000000..645fe966c5
> --- /dev/null
> +++ b/delta-islands.c
> @@ -0,0 +1,490 @@
> +#include "builtin.h"

A bit weird that builtin.h would be needed...

> +void resolve_tree_islands(int progress, struct packing_data *to_pack)
> +{
> +       struct progress *progress_state = NULL;
> +       struct object_entry **todo;
> +       int nr = 0;
> +       int i;
> +
> +       if (!island_marks)
> +               return;
> +
> +       /*
> +        * We process only trees, as commits and tags have already been handled
> +        * (and passed their marks on to root trees, as well. We must make sure
> +        * to process them in descending tree-depth order so that marks
> +        * propagate down the tree properly, even if a sub-tree is found in
> +        * multiple parent trees.
> +        */
> +       todo = xmalloc(to_pack->nr_objects * sizeof(*todo));
> +       for (i = 0; i < to_pack->nr_objects; i++) {
> +               if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
> +                       todo[nr++] = &to_pack->objects[i];
> +       }
> +       qsort(todo, nr, sizeof(*todo), cmp_tree_depth);
> +
> +       if (progress)
> +               progress_state = start_progress("Propagating island marks", nr);

_() (same comment for other strings too)

> diff --git a/pack-objects.h b/pack-objects.h
> index edf74dabdd..8eecd67991 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -100,6 +100,10 @@ struct object_entry {
>         unsigned type_:TYPE_BITS;
>         unsigned no_try_delta:1;
>         unsigned in_pack_type:TYPE_BITS; /* could be delta */
> +
> +       unsigned int tree_depth; /* should be repositioned for packing? */
> +       unsigned char layer;
> +

This looks very much like an optional feature. To avoid increasing
pack-objects memory usage for common case, please move this to struct
packing_data.

>         unsigned preferred_base:1; /*
>                                     * we do not pack this, but is available
>                                     * to be used as the base object to delta
> --
> 2.18.0.237.gffdb1dbdaa
-- 
Duy
