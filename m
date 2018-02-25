Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFA41F404
	for <e@80x24.org>; Sun, 25 Feb 2018 03:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeBYDlT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 22:41:19 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:39740 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeBYDlS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 22:41:18 -0500
Received: by mail-qk0-f170.google.com with SMTP id z197so15398562qkb.6
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 19:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WCTS23istYoDLsKXYF76baUCXok/gE8ty8OMs8ZQARM=;
        b=dRaUn7qDFYboa19IbY/74Yw50sCKhIEb+3winkCmxGiKwC0gqhGf35EYjIG8Bg1c1M
         Tdp9ADvOq6o+w1C4aH9Af2rKP/gyupiZ5wZCwbatA75N/tP82zZAHh35uODP+xizRIvK
         uBW+GyIpCbEpR7FZf4CMVD9KNqsbdsPCCOB09xRfaFKbY7AdETgt9Y9Rlgw723hd0xLY
         kIL7xdrITvW0D1JvmE2INUWUo061IPRhPSIBeyUtitOfcKzom9wtVVcMtEgrdyE/ogjy
         aVfc/quklFpNJgBNr/FOYZU8KwU3eoBAydRDQPhMOwmAshIbfy8oKlgkjkH55o4MasfZ
         70Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WCTS23istYoDLsKXYF76baUCXok/gE8ty8OMs8ZQARM=;
        b=b+bitUM+VYRtO+qrww45TbJ/THScMC7j2wTflyX8CTUKtPvCmRsaIWssr1jAlT/UQh
         gT0S8s689HOiADcQg7HFTNWwetYdAk+GXVgxwDT96wy2QSp6nEsIftCaC1rZl3zigsVD
         S7TYQOginmKYJiHqtQKp7hVVg6LLRzO9Tmdj/ENkRzfFNB9qIC39RrV4Zp/4q8q0Cngz
         e61Tf22kKuunYZVuKLH2T/LmBdyd5VrqmPXiZnCstNai0GVzSWIn+kbIlScZ/avGFu4j
         nehKKKMasgi5nVl05YBLSM5PIpsgKqMF7yo7yQsk6v3fgXEmM8IUFbIqJKObfb7xjLTy
         lTFA==
X-Gm-Message-State: APf1xPBNqTSvnPOwYUHAEF21YoV4MyTzTwxi+yp6esGPsSY/19a/ByzO
        SWcSOOYz+o4TgjWA7kU9bEsOmwJfoAusWhXfgfw=
X-Google-Smtp-Source: AG47ELuE1IFf1pg81mZ0cyGvg1mal9szxYhaXkP9mClNnFU8LBr9AwPOdVm5SEAu9yy5XeZhFjOyRyrZzdvkhEzoUCo=
X-Received: by 10.55.32.2 with SMTP id g2mr1371471qkg.176.1519530077408; Sat,
 24 Feb 2018 19:41:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 24 Feb 2018 19:41:17 -0800 (PST)
In-Reply-To: <20180224162801.98860-4-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-4-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Feb 2018 22:41:17 -0500
X-Google-Sender-Auth: pcJ-jZWmAKBrfamoHd3quESz1lo
Message-ID: <CAPig+cQdoicxSMLRbdCfFGXyXLirbRLVJi2QahCSe1ZesVOKBg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> wrote:
> Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
> or UTF-32LE a BOM must not be used [1]. The function returns true if
> this is the case.
>
> [1] http://unicode.org/faq/utf_bom.html#bom10
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/utf8.c b/utf8.c
> @@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int insz,
> +int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
> +{
> +       return (
> +         (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
> +         (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
> +          has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
> +       ) || (
> +         (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
> +         (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
> +          has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
> +       );
> +}

Is this interpretation correct? When I read [1], I interpret it as
saying that no BOM _of any sort_ should be present when the encoding
is declared as one of UTF-16BE, UTF-16LE, UTF-32BE, or UTF-32LE. This
code, on the other hand, only checks for BOMs corresponding to the
declared size (16 or 32 bits).

I suppose the intention of [1] is to detect a mismatch between the
declared encoding and how the stream is actually encoded. The check
implemented here will fail to detect a mismatch between, say, declared
encoding UTF-16BE and actual encoding UTF-32BE.
