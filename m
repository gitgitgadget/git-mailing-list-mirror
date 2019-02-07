Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36DF1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 02:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfBGCcs (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 21:32:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39909 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBGCcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 21:32:48 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so11071050itl.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 18:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pb+WMi2y+SZY+fZ+qz0tnFoFB8EcpSrGc0DjLR2cavg=;
        b=px/zMkHJ5VcnPWLgR2jsA8tzIEUoKmz+iXLvwbPdQr98g68nXZ8zQXB6L580U+ey8f
         wtKcf16AYS9UgOIr2WzlX5CDlcfR7DtHDhw48PkaEUVVcrO6KxswSNEehK1gbY8rV94F
         H5D4RvSK0S4pE+oq7sZF/JEm+gVLPW4LFhBRMIAlN7nT6y2ZrfGZdtx5pqW6PRLgKBrV
         lfo0833VxkkcbpUPuOYLolljtDoyKz/Xn9TrxvyHLI4/3Y6cgK6+FtJwNlgP1rTkoCQD
         EU5+GBV1VG0yu20gwW334bp1PQOxHuCSqZuyV0EjksF9VJkyk3o0VL9pL0jBGED2pEgI
         s7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pb+WMi2y+SZY+fZ+qz0tnFoFB8EcpSrGc0DjLR2cavg=;
        b=SQpSF1a4SMHLrXLbZ3T/tf0ZFKkmXA4pOWqXnoYQCM5vcBn25ASVdNHzp0FTNaabWu
         a3D5G3TKlDbar9wvGOhC3AjCAF04egMC0jMEKe7zSXNCQ1ti6MYvV2kTGdyzWC4oH21r
         9CbF+0x39MhMVeKADTp7eWT0ymz2pxisBhrZFEcbqi0UeumkxYTAfPePf+L4tdDXol47
         21kR+1mobDjPxu2SuWY5uSYuerPttF455B5VXuyNUpw5WlC/PcwNxF42pOPbZKxeHp2k
         xcHefFIxEXeKtnQqN/pcfVZTvSorZ3lHa5PNhdMkFHTKJIUzQtU2cShNXqDJuWO2bnI6
         LQ8A==
X-Gm-Message-State: AHQUAuYrPhAgUtmiUIlbu4gVKS7+YmL0ruxnJ1hqGGIN2Xx9JzKQh4D3
        nWPdoMbzi4eqcEi+KhTjoNLh6P5Zjy6ht845F9g=
X-Google-Smtp-Source: AHgI3IYwoOweyW3VYOFEOgjUP+ts0Qq06WCmDjRsngLMI21p0csZcLfD6iYdaIjBN9CItVsp9wflNLK5kK2VBp6xVMM=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr6197819iol.236.1549506767818;
 Wed, 06 Feb 2019 18:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20190204000650.686175-1-sandals@crustytoothpaste.net> <20190206235937.201663-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190206235937.201663-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Feb 2019 09:32:21 +0700
Message-ID: <CACsJy8Ae0ZZjh8+f+TwbfJ-V9SzrHpDFyfjwScwKJj+kc7FDTQ@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: clear alternate shallow when complete
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 7:00 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> When we write an alternate shallow file in update_shallow, we write it
> into the lock file. The string stored in alternate_shallow_file is
> copied from the lock file path, but it is freed the moment that the lock
> file is closed, since we call strbuf_release to free that path.
>
> This used to work, since we did not invoke git index-pack more than
> once. However, we now do, and starting with bd0b42aed3 (fetch-pack: do
> not take shallow lock unnecessarily - 2019-01-10), we no longer reset
> this value unconditionally; consequently, we reuse the freed memory.
> Ensure we reset the value to NULL to avoid using freed memory. git
> index-pack will read the repository's shallow file, which will have been
> updated with the correct information.

The patch looks good to me.

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  fetch-pack.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 577faa6229..a92621a388 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1272,6 +1272,8 @@ static void receive_shallow_info(struct fetch_pack_args *args,
>                 setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
>                                         NULL);
>                 args->deepen = 1;
> +       } else {
> +               alternate_shallow_file = NULL;
>         }
>  }
>
> @@ -1489,6 +1491,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                         rollback_lock_file(&shallow_lock);
>                 } else
>                         commit_lock_file(&shallow_lock);
> +               alternate_shallow_file = NULL;
>                 return;
>         }
>
> @@ -1512,6 +1515,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                                                 &alternate_shallow_file,
>                                                 &extra);
>                         commit_lock_file(&shallow_lock);
> +                       alternate_shallow_file = NULL;
>                 }
>                 oid_array_clear(&extra);
>                 return;
> @@ -1551,6 +1555,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                 commit_lock_file(&shallow_lock);
>                 oid_array_clear(&extra);
>                 oid_array_clear(&ref);
> +               alternate_shallow_file = NULL;
>                 return;
>         }
>


-- 
Duy
