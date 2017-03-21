Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E3E2095D
	for <e@80x24.org>; Tue, 21 Mar 2017 19:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758417AbdCUTVC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:21:02 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36576 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757813AbdCUTT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:19:56 -0400
Received: by mail-io0-f180.google.com with SMTP id l7so54332008ioe.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R1OXAt8jAuXhZ8KKA/sMFIe1zcstMrGvMKYN/COVyBE=;
        b=sV5G0f0w9L/1N0NNFQ7+L/2+dnuyZOtuoEu6FtpUIAaEA3HFqM05yNR1uDjBity/Mh
         uSa60YYnj4PGw9Fq6jaDlStwbbq0U88V4LMEun5VfKkR5tQzYhJEff4IYnRb63jvWbzA
         voWA1F1ZgI2imb4dkTYCEAFBY5xJEEECIEcqkAshmpQ4x1OVYOfVxzKubco7CbMipBkN
         0ftT5lGPba4oElIM9Z9sVSkl+RzdfyNvNiiKsptqsWaGHK6hg6JBQKg38IoN40orDz2R
         wYXukmotLGpzEngb74jd78KXwmqhZJFERPYD4K9Gc3wxuIGfiiWmoQx2k9VOvhe7Zwvl
         Q58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R1OXAt8jAuXhZ8KKA/sMFIe1zcstMrGvMKYN/COVyBE=;
        b=rVEq/txzlEmIv+nO2z8czGV6FLV/PAc20zT8Hg+f8RiXjrOh52PNy8JEP+qi6wpvPI
         7gLpQUmKOEhQaeOUH3T0bgfvBz6BOxHE3CmVJEQJnPp7XrDJSuym22G5vSwwNuaDjaiC
         hEnzJWHy5IN5keihOcku20fFayCsS8WSEslV5wOzFdgT8ESSytiaDH7npvHRaljaEf8K
         nK91y0lr7Mxul8BrxfzlWahniA+3Hu/v2tCkxFlm9ol9X/IZT9Hv/N5V96Fnet4BqSJL
         ve9THturFklTI8kK5NvV2j5PLOWpyCfV+Yv3T7FO5U79GIU/VfnQxXqf+gflxOjCL1iq
         CoMA==
X-Gm-Message-State: AFeK/H0cgFORza3b1KClypo9iHLdCfeXMgzgOvCSrG8n6eO5b3s6cem1ktQULTOgJJk9zCF/VbaHQCxKWrwqrw==
X-Received: by 10.107.200.139 with SMTP id y133mr8224267iof.147.1490123995316;
 Tue, 21 Mar 2017 12:19:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 12:19:34 -0700 (PDT)
In-Reply-To: <20170318223409.13441-1-avarab@gmail.com>
References: <20170318223409.13441-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 20:19:34 +0100
Message-ID: <CACBZZX6g694p9WkiK75+HJCLUPwjpdQhjBrAU713KahAKm53hA@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Dropping Richard Hansen from CC, his E-Mail bounces, changed jobs probably=
...]

On Sat, Mar 18, 2017 at 11:34 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> The new starts_with_case() function is a copy of the existing adjacent
> starts_with(), just with a tolower() in the "else if".
> [...]
> +int starts_with_case(const char *str, const char *prefix)
> +{
> +       for (; ; str++, prefix++)
> +               if (!*prefix)
> +                       return 1;
> +               else if (tolower(*str) !=3D tolower(*prefix))
> +                       return 0;
> +}
> +
>  /*

One thing I'd like feedback on is whether I should be adding this to
strbuf.c. There are >300 uses of starts_with(), but sha1_name.c will
be the only one using this modified starts_with_case() function.
Wouldn't it be better to just add it to sha1_name.c rather than
expanding the strbuf API with something that'll likely be used by
nothing else for a while?
