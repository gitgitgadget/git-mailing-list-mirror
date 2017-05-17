Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF0A2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdEQAza (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:55:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33684 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdEQAz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:55:29 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so6037531oib.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2IwX4zZCK6xBDrFg2qblXA2q/PM68LEsxigKLhCdAEQ=;
        b=dbtNIIsmhp/Tymm9WJvAUbnPrvOSckMSPKUi0jbUuHuqlqalBSBJakmAF+hIR6ou8V
         OeiaSmtKJEU8wZldujraOZr4BHUvr56Pfbw90mz7raHVRioE6qXc4lHT+PI+rXoQIKeO
         rinnP5d36SxU6WsAvW6QCysjziCpIOH35ugvgErLgv6qdLkPuyNqoaLsZ3hB7KFNzJI6
         ayudZEM9xFrf4t/zxLgkV0OCtPaOndX4FcN7rdTY9RNBwapmP5ibi8lBXa1cxWjZl6zh
         plqXuoGN16MqB017JUt6UiVutoHGi2ViDrfs6dDXzRul7Sujiuly0ThVc3FROyBb3Mc5
         /V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2IwX4zZCK6xBDrFg2qblXA2q/PM68LEsxigKLhCdAEQ=;
        b=bfhWk9lK7NvtXcsQzXtZdEAJhZPXwyejmHEV7R3YWkfyOVkyRdcCKms5A2FJi4zMaw
         YPlH6voPcLIeKPktiiqTj9dq5nFBEWWC/SUMSngte5Fckg2tsNg1G2VgkEeX5xyEncmY
         He3HzpMSxs55ZGfNvqJp8IO1tkClLLz4NgC8bkDjvquMo0QMLELkGxtWUtOAyP5LGHhB
         lFcIHkuXmBdfOtpdeMoGsB8c+jDkLinoVRDnOiXahDhOzA0SGXxfbntDL2c+0i9T7Fdq
         2+9zWkfdBJo0bNzdk6d913g+lLsNBcLtotgD6uoNJ9GTCukjIZsAHzMrynw9zRHEVPhK
         80Dg==
X-Gm-Message-State: AODbwcBaiGnd3pIWKHoMVDcPJCswuLHsNmGfaF5whCsV2WlOd8CtKeTZ
        dJw6QV9NRY/IuDXEhe25pkSemnVPNA==
X-Received: by 10.202.114.74 with SMTP id p71mr381542oic.201.1494982528552;
 Tue, 16 May 2017 17:55:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.72.194 with HTTP; Tue, 16 May 2017 17:55:28 -0700 (PDT)
In-Reply-To: <20170517005041.46310-1-manishearth@gmail.com>
References: <20170517002825.GR27400@aiede.svl.corp.google.com> <20170517005041.46310-1-manishearth@gmail.com>
From:   Manish Goregaokar <manish.earth@gmail.com>
Date:   Tue, 16 May 2017 17:55:28 -0700
Message-ID: <CAM2h-yfRc69W8f=inRRjtyBh4EZWJk6W2gCTM=S=ifJn3g8auA@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Manish Goregaokar <manishearth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I *think* I got send-email to work but I can't be certain :) The tabs
seem to be back!

It didn't thread correctly, unsure why.

Sorry about the patch problems,

On Tue, May 16, 2017 at 5:50 PM,  <manish.earth@gmail.com> wrote:
> From: Manish Goregaokar <manishearth@gmail.com>
>
> To ensure that `git prune` does not remove refs checked out
> in other worktrees, we need to include these HEADs in the
> set of roots. This adds the iteration function necessary
> to do this.
>
> Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
> ---
>  refs.c | 16 ++++++++++++++++
>  refs.h |  1 +
>  2 files changed, 17 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 2d71774..27e0b60 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3,6 +3,7 @@
>   */
>
>  #include "cache.h"
> +#include "commit.h"
>  #include "lockfile.h"
>  #include "refs.h"
>  #include "refs/refs-internal.h"
> @@ -1157,6 +1158,21 @@ int head_ref(each_ref_fn fn, void *cb_data)
>         return head_ref_submodule(NULL, fn, cb_data);
>  }
>
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
> +{
> +       int i, flag, retval;
> +       struct object_id oid;
> +       struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
> +       for (i = 0; worktrees[i]; i++) {
> +               struct commit* commit = lookup_commit_reference(worktrees[i]->head_sha1);
> +               oid = commit->object.oid;
> +               if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
> +                       if (retval = fn("HEAD", &oid, flag, cb_data))
> +                               return retval;
> +               }
> +       }
> +}
> +
>  /*
>   * Call fn for each reference in the specified submodule for which the
>   * refname begins with prefix. If trim is non-zero, then trim that
> diff --git a/refs.h b/refs.h
> index 9fbff90..425a853 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -192,6 +192,7 @@ typedef int each_ref_fn(const char *refname,
>   * stop the iteration.
>   */
>  int head_ref(each_ref_fn fn, void *cb_data);
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
>  int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
> --
> 2.10.1
>
