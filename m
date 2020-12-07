Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7873EC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE0723437
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLGJSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgLGJSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 04:18:39 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECFC0613D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 01:18:02 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so18460936ejj.5
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 01:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eQmRHtiA9GpXwKX6NT20/bjinnVaDDeC8t2MIgZUo/U=;
        b=JmmA9mWuCGvsxW9YFXQvFk5Zt5tGbERIQYuFGGiFfL36oH0GeoWGOFhMMQKOOSbwUT
         azxxZqthjXAOf9cUrzxGTysnyVVjE5y7FrGBBw2etmv7+CrF/Kzexy3t+yRHU+EjJ6fI
         MKtuSJn23sDJz97uQMa8RYrW0NEJYmAD/V29w1/WXEQaXOvepQOq/ICD5pU5QKtoxuzr
         e3YKivviovs8zYF8SROurzPGtGKo8VC2uuqKD3alNwvZRYNO7a2uiGVB5EwGpb4NB6Hp
         D2mT4I0a9B0MLJuHyAmMsSAHVjSO9aXZMy8M8hAe/F6i/VBxtmMnl5yLmlq1tCqH2VYN
         Wrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eQmRHtiA9GpXwKX6NT20/bjinnVaDDeC8t2MIgZUo/U=;
        b=bgMw2T0oESoOcDMbA0jqZbwtTZTX3WdJz6JxoCSKjro45EaAdNYWPz2BTAaVuPSiIF
         2H6qnX3RXdr7PnuPZ0wH/DbbVIGOUKLWDjN+qHrEvL3pvzTlUCA6p2lAPbI4b4LLDmVq
         Bzygxg7wuGPgetVwmVwDPgouxhZsEkzH5oDiIzUVCAp8I4r7sAQDxnVbqmaO4yIuGKrX
         TW16yFULAdUvtNIgmRTFM727jW0adQLKcWW/zjG8bCrh1T1Qiqh3zZIFV5vUnIyrVg7z
         eX7L5aA+XgxygCS9tAPzCzCWtAkUKAZa4alKHpTxbQ3jU8LUaf//oawp++XNX4wsmkf7
         Lpmg==
X-Gm-Message-State: AOAM533Spa4XVZEzDPtzP+6BI4atHWXaXaFu6E5H+z/qmU36SjhHqkMO
        NZYRfRPxf98YV31b29sxTMamtvD3Nzzngnuue24=
X-Google-Smtp-Source: ABdhPJz0qi531uxeFKePK12AYEptrbB2tvq/iezHUUFlkl6kRLruZnHhqXwg6Ys6QIjERLqlKqgwkuvwEk6tdXzvz1Y=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr18279391ejb.551.1607332681249;
 Mon, 07 Dec 2020 01:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20201205013918.18981-1-avarab@gmail.com> <20201206002449.31452-5-avarab@gmail.com>
In-Reply-To: <20201206002449.31452-5-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Dec 2020 10:17:49 +0100
Message-ID: <CAP8UFD3PCwokJegLfVN2naqKh=1vQRrG4drat95jXF=01_p=yw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pretty format %(trailers): add a "keyonly"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 1:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -282,8 +282,8 @@ option is given with no value, it's enabled.
>  ** 'unfold[=3DBOOL]': make it behave as if interpret-trailer's `--unfold=
`
>     option was given. E.g.,
>     `%(trailers:only,unfold=3Dtrue)` unfolds and shows all trailer lines.
> -** 'valueonly[=3DBOOL]': skip over the key part of the trailer line and =
only
> -   show the value part.
> +** 'keyonly[=3DBOOL]': only show the key part of the trailer.

Here also "[=3D<BOOL>]" would be more consistent.

> +** 'valueonly[=3DBOOL]': only show the value part of the trailer.
