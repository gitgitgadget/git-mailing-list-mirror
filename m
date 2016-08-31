Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849761F859
	for <e@80x24.org>; Wed, 31 Aug 2016 22:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761055AbcHaWH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 18:07:56 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36091 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759634AbcHaWHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 18:07:55 -0400
Received: by mail-it0-f54.google.com with SMTP id i184so35219255itf.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ksTs9r/EXHe7cbGR6nxYkqPFI/iIm4EaiVTnIfc8MRo=;
        b=FuA/VAOjfENJeqsJOwqB6WjmupH+4hYHujGm2ExHCp+Yigdw8bGFacLQz1XBY3Ziar
         n6gSxNm+PqVMNv9XMZa22cQZxgsobUYXZMsEvzjwSKkezUn2oIOB5lk+WLOklsRdnoF1
         8AHIdlOUgYwdqcdeBcEqvWzphQopkn2R0WA3lQc12KwF2jJqF13uNP8rZcjZYwb0WL77
         aIWARo4papbU16Bx5/laMvqXRq1fxefoYMNAyg4AJ6mypHcRqSe7tch9kbRiKuaL9kSM
         JQ3z4mX84PguOwxgXvoLyvzl122OQBLHEXBR+LDobuHW709Fvq/Uvp5m7ewc8ma2ZgmY
         wD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ksTs9r/EXHe7cbGR6nxYkqPFI/iIm4EaiVTnIfc8MRo=;
        b=OIT59JQNDbalD69FP3Fx0w7+xoVOPiFoHthKDF8IoWN9OBNWZ8ehhoNFlcane1PNud
         /awCAWKp/vFpCOr/wUdC6F1KrLLTubs6+ASFuLIfBuaBfStOxzgM5WM9/ieXNggRIUBG
         Dh4rwpnFDAPGp5ESHAn8718sti913HVNr/Q64fwMmpAoNt7M0GON3xwH3HGRIm3RzpFq
         aXP8kRVXnxa2473QdODnvSojl92ZHBsbdx+SPO9cADLrVHVcvnD77nZoedaFF2cufgcP
         CSeBmvmiSDsm26W+SSz3AAw7SFMkH8QAzITJyf10UV0zOW3eI+ZsaHXQ4r/4NG+mxoc8
         HRGA==
X-Gm-Message-State: AE9vXwPlJjw4J+WIAQFP9FMNWkJeX9KjjjRvSiMIqSUrJlGOGr0iai0bHfGjeX9K3z2WuthbIbBYS0Z6lZ4Fc50e
X-Received: by 10.36.107.82 with SMTP id v79mr33815262itc.52.1472681274812;
 Wed, 31 Aug 2016 15:07:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 15:07:54 -0700 (PDT)
In-Reply-To: <20160827184547.4365-7-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-7-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 15:07:54 -0700
Message-ID: <CAGZ79kYnp_8iew33KQJK1TB0ROLthHBtvHqf3wVzFkh_JSq5MA@mail.gmail.com>
Subject: Re: [PATCH v13 06/14] apply: make it possible to silently apply
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Printing on stdout, and calls to warning() or error() are not
> taken care of in this patch, as that will be done in following
> patches.

> -               if (state->apply_verbosely)
> +               if (state->apply_verbosity > verbosity_normal)
>                         error(_("while searching for:\n%.*s"),
>                               (int)(old - oldlines), oldlines);

But this is an error(..) ?

Have you considered to replace all these print functions (error, warning,
fprintf, printf, fprintf_ln) with another custom

    int say_when_at_least(verbosity level, const char *fmt,...)

? (I guess that would be more invasive, but the result would be more
consistent.)
