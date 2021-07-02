Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B74C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A1E613D8
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhGBWOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhGBWOP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:14:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9921C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 15:11:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb6so1855799ejc.5
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PS1O1n0PQ2mbbyYTfeW/ye1ieOE2Q2B4p3x2QZqvNoQ=;
        b=WJwdJBQ7zryNcr3qrZXb2r72UL6KEWbUlSF2KMtPrqlFtABeICuDi+lezEg/s3iSNz
         kQMJVtCMM5VvqajLvICQ5CqzBA6R0v4rBI01Pg8Wlp7ZCVpi260ihFgqojfL4Rj5Q58W
         01G4c9NtwstfEOj68H14d7WcSSYknYDcpZkC+mkwSGV8TsYv6/78j9btjWq92cdt+s5r
         989iN3jUHwANflgNIv1ACkkjDPBwnwLDmdeQoA9qO++K//H/eTUbowYlMk0Oaz5jJM6k
         sg/uqwzl/+2PGbn8et81C/gYCeZypQyYm2N9Bth9PGQseqkcZFUTPtJp03mtP0FLSAHw
         ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PS1O1n0PQ2mbbyYTfeW/ye1ieOE2Q2B4p3x2QZqvNoQ=;
        b=dK8Ie0QZWzGLfiZRr98xRTS5O8uLKhH9SaXHqjhF03tfUCkYRb9QGhUDvt1HBeUPix
         HU4yTUV4ubHGBV4dmzctppuIMoiXV4ZULQ33EG+HL8BIHDRZMR5FwUIFGi+HN5radxde
         +sXDaPVLLNGT90tp+zjPXgVHM6e9cwq2VzOEnF8jMKGa+dDZkMalscVV5Rlk8kY0B0AO
         nfWMeztObS6ovyqdDMDFdhhIQHm8nTd6EzSZbWdzrs3YvihWDNbVbGsO58s5OkqKwmDp
         5vbdNV024D8liXGQC7JMk5CkOdnUlNHu2c2jUtEMXkiZKBq2iOYOrG9oJ9ow2vO5ATIV
         a73Q==
X-Gm-Message-State: AOAM530LSIT6fXvjB87wVEgVxnDgQG5FAF/K6XE0d/kspG7gMqPqN64H
        Y1qIUdvd8TrNMPtUeIly8obWIBdlthgqiKyKX78=
X-Google-Smtp-Source: ABdhPJzQwWSY2dPH7uLRTQm0/uUNvxJmYE7UDeS4W0Ygq2+kdBEir+KEtCZpteDXimKagcdOI6IN3ZUv73gTkcYr0HM=
X-Received: by 2002:a17:906:26c7:: with SMTP id u7mr1871306ejc.211.1625263900382;
 Fri, 02 Jul 2021 15:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
 <87czs0alhg.fsf@evledraar.gmail.com> <CAPig+cQinUsEZqEDb2_zhi37SdYuBCVEznmFbXPJuFB5cFznKg@mail.gmail.com>
In-Reply-To: <CAPig+cQinUsEZqEDb2_zhi37SdYuBCVEznmFbXPJuFB5cFznKg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 3 Jul 2021 00:11:29 +0200
Message-ID: <CAP8UFD2FjY1mY=GS4ZZHiAxTpsqq7+1ywHfCvdRvJrr8Oo9-qg@mail.gmail.com>
Subject: Re: [PATCH 08/15] [GSOC] ref-filter: add cat_file_mode in struct ref_format
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 2, 2021 at 9:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Aside from the potential maintenance burden of the `atom_type >= ...
> && atom_type <= ...` approach, another problem is that it increases
> cognitive load. The reader has to go reference the enum to fully
> understand the cases to which this code applies. On the other hand,
> the way the patch mentions the enumeration items explicitly, it is
> obvious at-a-glance to which cases the code applies. An additional
> downside of the suggestion is that the range specified by `>=` and
> `<=` may cause some readers to think that there is some sort of
> implicit relationship between the items in the range, which doesn't
> seem to be the case. So, I find the way it's done in the patch
> presently easier to comprehend.

I agree that it's less cognitive load, but maybe it could be improved
using a separate function like:

static int reject_atom(int cat_file_mode, enum atom_type atom_type)
{
    if (!cat_file_mode)
        return atom_type == ATOM_REST;

    /* cat_file_mode */
    switch (atom_type) {
    case ATOM_FLAG:
    case ATOM_HEAD:
    case ATOM_PUSH:
    case ATOM_REFNAME:
    case ATOM_SYMREF:
    case ATOM_UPSTREAM:
    case ATOM_WORKTREEPATH:
        return 1;
    default:
        return 0;
    }
}
