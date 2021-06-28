Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1AC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D6861422
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhF1Htc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1Htb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 03:49:31 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C3C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:47:05 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id v3-20020a4ac9030000b029024c9d0bff49so619100ooq.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68tWMaQPcW4Vy5I8peDaKA9u6lXUM8pq5PlDmE2tLgs=;
        b=b/vucG3hnlLmKjCOeTaWHFkyxoqCTwgF5lnyXT1WJu4URPiT1U0pozB64ODx+pKWoV
         fIvb8E+a4+9DbMKP+0PGzUjDdKeY3E0+0aB/3awMpazL1Ynky0gAFdxf2XlCcShNbt6/
         3ckrCf7B5mXBGCc3OPDxVURzTHnnW9hevpF8ZMd4gk7CZzW7REVfpDrgO9ahzsaLTa5N
         206bg3C5HmNzUw4ZqjU34NUoaK71se7k/64owcyX90GYleq9Kv5/rVwc80xD4S6TEvGi
         s/hZiJ+tber9mMUJLvHcMAjeUryJEVbIQxkZxHbKAx77sU3rEwQ6gMa0MBMj1O4ZaWT+
         99MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68tWMaQPcW4Vy5I8peDaKA9u6lXUM8pq5PlDmE2tLgs=;
        b=Cy/yHpSvI2altLP1plFY0e2/IOaVyTd0Ix7t1uOfN+kNeFUVeTeNUIWaGGHW+etVcR
         D5Na0ANMMoTq1VeDfxiB6xRoD6SJGntyhkf+NYIv4t2Xj8V5eXdhHmc7p5kbTnR/xbDh
         rEyPfimGfc5A2e5LNUzCFytaMRxdkJN76PMVUfxQyPcHb5hW/Br3s7mxLAW9NkX+mwp3
         HJT62v4/Oyj0EJilmyQUYGGFYEe4dkTS3EUbL+xRtBgbeKW8yAUexxqv0l+lq2kuSStv
         /OOMZb5oM76BGz9JB6zTpKYhbrm9hbkVVJ3/BQ+soQH0Rxvj5f/aXKAhV50VVKVb/2vF
         doqQ==
X-Gm-Message-State: AOAM530s3Geg6218bJstQ4/ESc3w8hd9lESoV3EnIvg8LK1ocz5iDrOt
        0pxXEptylvXCsUANOzLBZTQe/rPGjtH2XmRfpck56+g7WmTehQ==
X-Google-Smtp-Source: ABdhPJwoeOSTCnFCxM6OvEKhaSywGKB8Q2X4kB2JF32JO9cwwf9NJ5S3PKh48ZJzNDkEydOXUdBkvZbZBAHGkXLBkdQ=
X-Received: by 2002:a4a:9406:: with SMTP id h6mr18161634ooi.36.1624866424600;
 Mon, 28 Jun 2021 00:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
 <pull.980.v6.git.1624797350.gitgitgadget@gmail.com> <9a1f07329401434b5960ef8ae002f11b1133506a.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <9a1f07329401434b5960ef8ae002f11b1133506a.1624797351.git.gitgitgadget@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 28 Jun 2021 13:16:53 +0530
Message-ID: <CA+CkUQ-gHT=g3KwcBXkp8eBX7wfY_HkT1=hhRiYLap-Av2w5MA@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] [GSOC] cat-file: reuse ref-filter logic
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

On Sun, Jun 27, 2021 at 6:06 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to let cat-file use ref-filter logic, let's do the
> following:
>
> 1. Change the type of member `format` in struct `batch_options`
> to `ref_format`, we will pass it to ref-filter later.
> 2. Let `batch_objects()` add atoms to format, and use
> `verify_ref_format()` to check atoms.
> 3. Use `format_ref_array_item()` in `batch_object_write()` to
> get the formatted data corresponding to the object. If the
> return value of `format_ref_array_item()` is equals to zero,
> use `batch_write()` to print object data; else if the return
> value is less than zero, use `die()` to print the error message
> and exit; else if return value is greater than zero, only print
> the error message, but don't exit.
> 4. Use free_ref_array_item_value() to free ref_array_item's
> value.
>
> Most of the atoms in `for-each-ref --format` are now supported,
> such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> `%(flag)`, `%(HEAD)`, because our objects don't have a refname.

It's not clear why some atoms are rejected?

Are we going to support them in later commits? (or sometime in the future)
OR
We are never going to support them. Because they make no sense to
cat-file? (or whatever the reason)

Whatever is the reason, I think it's a good idea to include it in the
commit message.

-- 
Hariom
