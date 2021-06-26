Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E7C49EA6
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8256261C35
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFZR3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFZR3d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 13:29:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B2C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:27:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so15593661oiv.1
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LQm5uXPKV7uc4AwbVc6ZWEZV7GOeuQYkfRPdNw1r1g=;
        b=MeLrQlLd+SGWSC7x+0vJrm4rkrZSQeJaytnM8+ccE4b+8OybVUHYVRBA8qbaRJ2YoQ
         IDfyX4YxMSix7oGFHQzgDIP+jtcJyfHf2tER6iCDYQylcoYROfH4CuHyh+4GcQ2H8ETt
         Q1A2LtJey8X8cbc/X4cp52wku/O2Js/1QIM8donk2pqMrHa+nAST7A3AqVVPAW9T+Dd3
         wFlZxW7Am7CEAXUk0O3RU9YSBXZ2Cqj5mturadlOtbNX0D/zjHoxXdWGfYNZ5mea9pBp
         Cn/41gDOHdEUfRx3tarUtYJmt1YC+Nua5q2rFDhWJKAFkDka0KQ2o7BsrwZGPlmxFgEY
         v2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LQm5uXPKV7uc4AwbVc6ZWEZV7GOeuQYkfRPdNw1r1g=;
        b=hkntYkB5bxb+foLYev3wE9QaGU84fzmIjEU3EHFR/ygqOEQKt9lnf/uHkT1dTu/TWy
         9JjCY86vDBnB3UDKoFjHiT0E7yXMkRGLNdbmHQTrehNT3e6zIgqN1blSRW0w6Md6P9dt
         4K+GCLTkpw6dZfRX+IE3K9iDbqbNEov+6/jEDf9emCCjwfCzp1n/qS2NhucEmW69sf1R
         /KA7JGr8A3wIB7pBSOAXXcJc1Achn4vOxD3cD3nXNosBPQ+oUhbdsBoD51eS86UEjgVI
         GB6NVifBMCcggY7NPorw1z2YJzNYmUIZNPEO+QUMa4G473MedRCrohtJqKIsREd5bouj
         ajqQ==
X-Gm-Message-State: AOAM530QBDv89YznfjIjkwV3/M/L5enVIDSQUBveChlmj5IuF6H3gHmp
        l9Qewcpiy5+HAamw4Ek739f3qzLhv+LC0dhpC6k=
X-Google-Smtp-Source: ABdhPJxi4+m3i2G4RP9eYn9jfte03znMQqeVBqUerCs5y8MLrEYX0kWBhc4yXJI0xFMF1W9OGLbTX6POqbk6xd6TkU4=
X-Received: by 2002:aca:4813:: with SMTP id v19mr12385485oia.132.1624728429812;
 Sat, 26 Jun 2021 10:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <pull.980.v5.git.1624636945.gitgitgadget@gmail.com> <370101ba65f0989487360366f8b83144a6641a04.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <370101ba65f0989487360366f8b83144a6641a04.1624636945.git.gitgitgadget@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 26 Jun 2021 22:56:58 +0530
Message-ID: <CA+CkUQ9jWY8KDJxeAk9kDSCGgQLuBuaLEASrGfbA2xnN7nuBBw@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jun 25, 2021 at 9:32 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> +       if (ret < 0) {
> +               die("%s\n", err.buf);
> +       } if (ret) {
> +               /* ret > 0 means when the object corresponding to oid
> +                * cannot be found in format_ref_array_item(), we only print
> +                * the error message.
> +                */
> +               printf("%s\n", err.buf);
> +               fflush(stdout);
> +       } else {
> +               strbuf_addch(scratch, '\n');
> +               batch_write(opt, scratch->buf, scratch->len);
>         }
> +       free_ref_array_item_value(&item);
> +       strbuf_release(&err);
>  }

I think you can get rid of braces in condition `ret < 0`:

```
        if (ret < 0)
                die("%s\n", err->buf);
        if (ret) {
                /* ret > 0 means when the object corresponding to oid
                 * cannot be found in format_ref_array_item(), we only print
                 * the error message.
                 */
                printf("%s\n", err->buf);
                fflush(stdout);
        } else {
                strbuf_addch(scratch, '\n');
                batch_write(opt, scratch->buf, scratch->len);
        }
```

Thanks,
Hariom.
