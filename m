Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7531F403
	for <e@80x24.org>; Sat,  9 Jun 2018 18:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeFISKZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 14:10:25 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42510 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeFISKY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 14:10:24 -0400
Received: by mail-ua0-f196.google.com with SMTP id x18-v6so10999626uaj.9
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cXPyAtdtRG0V2oYuTaYrlJLavmzgScGno/Ip1T/Mwho=;
        b=RycUfWCcD3aNCRMnZHYbZ0BSYq3t+oDYO1KRmZkAQH/1uD0hIUyUfAAMSnxlmotK3t
         Zt0Oup78xMjcU6MiwGRx85GtA3E0Mtz9TbLgw5FDUDFz5y6dST8i4xcF3cn6CnI26arH
         sekrW19wCZHuNK6/ch87tMgaVPO5NiqSpDTJZkVfBmLjD4rbKxM9h3peRJrIPT2lTTcJ
         jm0AE+IUlsOwrJsLyFY1lH571hNT9NfhHBHALUHeq1AxPpF0upwCswS6pGzEekODDCWU
         Wu1ON8gjEI6ZR3C3q1Xj+Tjgd5ilr+5mnyl8lS/Y21I61TS9Df82e8oFDqb0DYM1BjY/
         VMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cXPyAtdtRG0V2oYuTaYrlJLavmzgScGno/Ip1T/Mwho=;
        b=UqYYgevTwNpMc9baI7ujZxW9t5uw9eVDieHTiAHVuxODFoLN7k9soOnadJjz9cznbK
         09gyHygj242autwpoSnO/3EF+qoaLJDPR40qzwauC1rFamAWwOqSnkUIipG5qarujSmh
         ruobQYmq/1mlpgBpth17GMV6SHeHQ6iegzOCfJG1PoFyIZzWtrGKe0CVYx9dfzyPbszh
         YywgaNpllc4R2WiITLgyrsopdEbpypUKHOqMIviaDm1kHHkXVg9ishv9Dt+HZXX+FH8i
         4KMWOWWNFNwLk4Di/kSvFoHokQoY2zgHu4yA9vtyWf20UIYFUhqT7iGuhAZwOTAzpAq/
         V72w==
X-Gm-Message-State: APt69E3qSg8iGQatgWB0UDpnMAyEw9+T/t5ecU4tmWH0X69tfl1buExg
        q5FGq7tUEU7i55wXVkqb6x5i6h2y3rlVkSfTpVI=
X-Google-Smtp-Source: ADUXVKLftMQdrCJcLH2OVdqQMxgktreuwgyzjNQYS+z3RvLo1H42oVD27gLrgBNRgDcJD3mC19iyBLe27qHUivc1Ve4=
X-Received: by 2002:ab0:596f:: with SMTP id o44-v6mr7350584uad.29.1528567823935;
 Sat, 09 Jun 2018 11:10:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 11:10:23 -0700 (PDT)
In-Reply-To: <20180606170243.4169-12-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com> <20180606170243.4169-1-pclouds@gmail.com>
 <20180606170243.4169-12-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 11:10:23 -0700
Message-ID: <CABPp-BGn8mz5tPrVk6fX3JKcaSuz4_XQSsSmvEMT_H5i4mF2Lg@mail.gmail.com>
Subject: Re: [PATCH v4 17/23] read-cache.c: remove an implicit dependency on the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 10:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b404ebac7c..4f054d6dbb 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -315,7 +315,7 @@ static int add_cacheinfo(struct merge_options *o,
>         struct cache_entry *ce;
>         int ret;
>
> -       ce =3D make_cache_entry(mode, oid ? oid->hash : null_sha1, path, =
stage, 0);
> +       ce =3D make_index_entry(&the_index, mode, oid ? oid->hash : null_=
sha1, path, stage, 0);
>         if (!ce)
>                 return err(o, _("add_cacheinfo failed for path '%s'; merg=
e aborting."), path);

There's also a refresh_cache_entry() call about ten lines after this;
since you converted all other make_cache_entry() and
refresh_cache_entry() calls in this patch, I'm curious if that one was
left out for a reason or was just an oversight.

There are also a lot of add_cache_entry() calls in this function.  I'm
guessing we should either convert all of those too, or just change
back this particular make_index_entry to make_cache_entry() as it was;
it seems weird to have a mix of explicit the_index and implicit
the_index usages in the same function.  If we convert them all,
perhaps we should consider having merge_options store the index we're
working on?  If you want to punt this until later or leave it for me
while I make all my ongoing merge-recursive changes, that's fine.
Just thought I'd point it out.
