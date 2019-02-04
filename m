Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AD21F453
	for <e@80x24.org>; Mon,  4 Feb 2019 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBDKfG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 05:35:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55829 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfBDKfG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 05:35:06 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so19873803ith.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufBdsd3TVjrlbiMRD3a78JRgdOzWuQProtaZsKlABvY=;
        b=iyRn2h/i+H29UhdR4Q39adRsjgY5MX6DFpGPkdgDG+MFJ/lka/GVbrak+iwfH4f9BO
         AuLVNriQ5pzGs3rbaHCLUmHSChnlYSlkEAV6izfpS2BZCrpo2cq8Evxj3s00GNd/QzMC
         p6DOwvmeWj7gvma0QaxBE/JeolmjOU7STX5llmDjeCWDWkRWl7S304aBLRcWuhitSXrK
         HCo8PcbHWmz09NKaoEmZjcz41w9HmIbvBkCRxYelLPYiV/wSfZPjES1WUVjSR8Evjsy8
         I94eQk0V01c5nqCV6yh9m/58MsuG2lj4xnEmgaB0ZVn1OuXQa2wMSEDf15Fv+PQTweRh
         T/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufBdsd3TVjrlbiMRD3a78JRgdOzWuQProtaZsKlABvY=;
        b=apo0GlramYPAT8bBkTzeBTMMDXf7MdM2caMBmJ2HGISZbaFl8Z13o3O7RFEhuM4EL9
         b+nQx9m/z6MqzD9TqraQ1fIg8BMPYBhwMuDXkSf9jXHa76TP4Mr1yYyk4/zC06ZgLNn3
         iG3Uc65TB+ClhhGAIfvDMBjArYXVY8zNhHLHB/scRrDR2SvFtUeiGv+AFRmNjlORpJTK
         VSn8hI7lt5XctJDHbA5tUmyrt9CssDmYhX8UEr6/NoF3SKN7DaQqBVqnmTV8YCl/P2Fn
         5Y04d3m6c2iSffKcS/68YdJ9IirCIfd8haf5iQUvLunlVu89ikql8IDkwipttdKmZbcE
         mAug==
X-Gm-Message-State: AHQUAuZc4zK6lcY66wRT90LhTYm2uijaiHRHbY2my8R31q2nwNcMLc0Y
        bdx9trmncG+OaqdbEVjQeVMGeZWRppHqDVfTINA=
X-Google-Smtp-Source: AHgI3IbYCHZxeYzuwFZuGSuXd5Jww2GIuyNLNMXlRQo6K6BCd7YQcvkGz3y0XE2zFBLPALf+m2qYwNV2gt2a53UJ2m0=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr25259718ior.282.1549276504907;
 Mon, 04 Feb 2019 02:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20190130085855.GA24387@genre.crustytoothpaste.net> <20190204000650.686175-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190204000650.686175-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Feb 2019 17:34:38 +0700
Message-ID: <CACsJy8CvVPr+OJ04aLGDeAS-o5__x1+3cKQNuq2+qba5gw5W+g@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: clear alternate shallow when complete
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 7:06 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> When we write an alternate shallow file in update_shallow, we write it
> into the lock file. The string stored in alternate_shallow_file is
> copied from the lock file path, but it is freed the moment that the lock
> file is closed, since we call strbuf_release to free that path.
>
> This used to work, since we did not invoke git index-pack more than
> once, but now that we do, we reuse the freed memory. Ensure we reset the
> value to NULL to avoid using freed memory. git index-pack will read the
> repository's shallow file, which will have been updated with the correct
> information.

It may be worth mentioning bd0b42aed3 (fetch-pack: do not take shallow
lock unnecessarily - 2019-01-10). I believe this is the same problem
and a full solution was suggested but not implemented in that commit.

The problem with dangling alternate_shallow_file is also from that
commit. When line_received is false at the end of
receive_shallow_info(), we should clear alternate_shallow_file. I'm
still debating myself whether we should clear alternate_shallow_file
in receive_shallow_info() in addition to your changes (which is good
hygiene anyway) to keep the setup steps of do_fetch_pack() and
do_fetch_pack_v2() aligned.

pack protocol v1 does this clearing alternate_shallow_file (near the
end of do_fetch_pack()) so it will not have the same dangling pointer
problem even if we do two fetches in the same process. But from the
Tan's commit description, I thought v1 probably faces the same "lock
twice not supported". But luckily it's never triggered in practice.
When backfill_tags() is called, if I read it correctly, we either
disable shallow (TRANS_OPT_DEPTH set to zero) or we start a second
process. In either case, the lock will not be acquired twice by the
same process.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  fetch-pack.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 577faa6229..2d76287674 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1489,6 +1489,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                         rollback_lock_file(&shallow_lock);
>                 } else
>                         commit_lock_file(&shallow_lock);
> +               alternate_shallow_file = NULL;
>                 return;
>         }
>
> @@ -1512,6 +1513,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                                                 &alternate_shallow_file,
>                                                 &extra);
>                         commit_lock_file(&shallow_lock);
> +                       alternate_shallow_file = NULL;
>                 }
>                 oid_array_clear(&extra);
>                 return;
> @@ -1551,6 +1553,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                 commit_lock_file(&shallow_lock);
>                 oid_array_clear(&extra);
>                 oid_array_clear(&ref);
> +               alternate_shallow_file = NULL;
>                 return;
>         }
>


-- 
Duy
