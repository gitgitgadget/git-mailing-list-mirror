Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B386C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD3622D58
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 07:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgLEHO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 02:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgLEHO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 02:14:27 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C1C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 23:13:46 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so8180780edt.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kueh1EbBuxYQ3NC0kZGlWlBbjOyIsIjCbsxoGGGhso0=;
        b=SrjI61aO/Fs0DurvV8uudbBP8jeOqgkFcVf+pOdS4wiSTRk90/uzgNaDQhU99Ez5yW
         LJWtjywAerrxlBLC1q8+f0gGaK685YIjMQzEvLc5ufkSOYE4L1NzkuujwvUNyqkKIsp3
         4k2GUqX/24Ql6NndIIq5/44trwf+2C1PyKWzQXLBrQNhnv2EQfaMrGS9nV+Ww/rww62W
         vgryBGEGxz9reRMxzeO4777zldlXc7/2kpgz8sfyX+KUtM23lram86LsKJ1A+M+y/Ahz
         NoLwXJltHW487ZpMB34FoNFF9iZ2eClfSaXj7Fb6k6TndMOjvjFCsSRgE6Uhme+vcAot
         47zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kueh1EbBuxYQ3NC0kZGlWlBbjOyIsIjCbsxoGGGhso0=;
        b=fgdF2iXqb2+0fgMyr9ATg04thX2OqXGkJWXdHGPsjH7SXPGN6pllPyRScWDGgjlvZS
         GSaRRhQ4MuHcKYtQdkme9Vl4YKEpoGcgD1ZqJYbAK0lRU4JYyARIngiP+pPWZrMOme7G
         6fO1xgN5fUsQ84Lp/BaFT4/pky9TornKRqqolVKdGNRf010D8TrrA94CD9VVy4HMNwnO
         ATjJ8fKUSl9K6P6FBVvAiEnda+l4uQ0XErkE4n1a+yIUUFEd5Ke4FrIbASlS5+QmxuoD
         hjI1sXAteNApYvDyx1r56429D9pRyaxMQ/dLqostfUOfBaBRctTlnYdlsI0Hk2So54NS
         vc/Q==
X-Gm-Message-State: AOAM531BU+swHDlhsMJC3o4pTtd4gRgnyUCL/I7CvvGuxuC//9ZPaUY5
        Mk7PnEApMiAOz2mkKQRr1ljL28xdoWFtKay4JRM=
X-Google-Smtp-Source: ABdhPJzACp8h99q5m0V5dGP+D6bqz9NZWuumLyBL9/ym3Nhdfg24misoOp+kKy/tjv7U8MFBtMBHo8SYHvh5pGN1je0=
X-Received: by 2002:a50:af65:: with SMTP id g92mr10991155edd.273.1607152425520;
 Fri, 04 Dec 2020 23:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201205013918.18981-6-avarab@gmail.com>
In-Reply-To: <20201205013918.18981-6-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 08:13:34 +0100
Message-ID: <CAP8UFD1q7ab5wyhmxknoM8FC5y_QqrF34HCRiS3=MP8YLCx20A@mail.gmail.com>
Subject: Re: [PATCH 5/5] pretty format %(trailers): add a "key_value_separator"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 2:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> As noted in a previous commit which added "keyonly" it's needlessly

Maybe add a comma after `"keyonly"` and s/"keyonly"/the "keyonly" option/

> hard to use the "log" machinery to produce machine-readable output for
> %(trailers). with the combination of the existing "separator" and this

s/with/With/
s/"separator"/"separator" option/

> new "key_value_separator" this becomes trivial, as seen by the test

s/"key_value_separator"/"key_value_separator" option,/

> being added here.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-form=
ats.txt
> index d080f0d2476..369d243eae9 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -286,6 +286,10 @@ multiple times the last occurance wins.
>     `%(trailers:only,unfold=3Dtrue)` unfolds and shows all trailer lines.
>  ** 'keyonly[=3Dbool]': only show the key part of the trailer.
>  ** 'valueonly[=3Dbool]': only show the value part of the trailer.
> +** 'key_value_separator=3D<SEP>': specify a separator inserted between
> +   trailer lines. When this option is not given each trailer key-value
> +   pair separated by ": ". Otherwise it shares the same semantics as
> +   'separator=3D<SEP>' above.

The above is not very clear to me.

Maybe:

s/between trailer lines/between a key and its associated value/
s/each trailer key-value pair separated by/each key and its associated
value are separated by/
