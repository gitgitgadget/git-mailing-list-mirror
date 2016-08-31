Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106101F859
	for <e@80x24.org>; Wed, 31 Aug 2016 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759582AbcHaV54 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 17:57:56 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:34836 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbcHaV5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 17:57:55 -0400
Received: by mail-it0-f46.google.com with SMTP id e124so69777812ith.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yx+u1RbZXWeEtSN+gAUZPlHPvJXfBcNabyuQJhn6LgE=;
        b=UjfJwYIBPfn8NKCQyc7Z6GJdWpUjAdV2RG7vVG4iUAq2/Ps/hAo9WgxLIKXLpeL4Je
         vQs6jM3y8O3i1v7pRvdhHRxZzp9n9YyybUUZVImQvW+CXNPW7itQmI5F8G+c4v3n752k
         qMrH5wkjQOTmf2u2ejMJ7TX/WvU3HMIQxzgwVZoNDU87zboDOQqMN+DJ0M11m+roWMf/
         uH3JXzerpPPDPtsMoqQ/uRV3ABjD/+Pc5lZaRwQlVZQ7k950KV9n/2sanVKZsDbsboDq
         ct2yYUivjiCPHPow7yFUkMMu9wks4EOSXsaEe6aOofl3PUxC1rQ7xHCDCSL5pIU+LoMO
         0/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yx+u1RbZXWeEtSN+gAUZPlHPvJXfBcNabyuQJhn6LgE=;
        b=gZXdS7KnYfjBF6aIKkChhiYim+mgZwGHa4WRyjcxAoB2C8dDY7ArgA/VQKJOqoYLC+
         7j2AY33VWJ6+GJ6ReONEvB/EkTscap1MPlStlER8MJdzEj+aFHKzehztuEEbiCZOx1ok
         Z1CU+jPSmf+vexueM+0/kRnDVZpmZsj0pQ02F2jnMnSvjjoD80GhfP7pQTAT07BzVkez
         7VTdyORlXMUx0S4axMOQ80OXU7R3ExvpULjqVXvS4Nwy23L4FkqB3Ki1vl42xK7MnFtg
         pT+Yv1bOr2FktNUbRV7qlua11vLT4KiYdga4Ofh1O9aKVb8dDW/8hoIZhoC6cQ4Bd//J
         s9lw==
X-Gm-Message-State: AE9vXwNUtDE+DsSUVbnz2agTMB35xAVndZXLQh5A0qu+6pqgAeOP8ZyM1zWPfkP+kGjo42fG7RIo9KdB/5+7m6VE
X-Received: by 10.36.123.199 with SMTP id q190mr13717344itc.46.1472680674333;
 Wed, 31 Aug 2016 14:57:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 14:57:53 -0700 (PDT)
In-Reply-To: <20160827184547.4365-4-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-4-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 14:57:53 -0700
Message-ID: <CAGZ79kb0gao2KJFi9X3V2ME+1-xnbuSNhjC14Vnn3oP-1ac35A@mail.gmail.com>
Subject: Re: [PATCH v13 03/14] Move libified code from builtin/apply.c to apply.{c,h}
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
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> As most of the apply code in builtin/apply.c has been libified by a numbe=
r of
> previous commits, it can now be moved to apply.{c,h}, so that more code c=
an
> use it.
>
> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c         | 4731 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  apply.h         |   19 +
>  builtin/apply.c | 4733 +------------------------------------------------=
------

I deduce by roughly the same line count in the .c files, it is just
moving files over.
(On my todo list I have an idea how to make reviewing patches like this eas=
ier.)

>  3 files changed, 4751 insertions(+), 4732 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 2eac3e3..7b96130 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1,5 +1,23 @@
> +/*
> + * apply.c
> + *
> + * Copyright (C) Linus Torvalds, 2005

We're very inconsistent with the intellectual property log.
Sometimes we have that at the top of a file, sometimes we don't
and rather point at the git history to find out who touched the code.
I'd rather use the history instead of having a bunch of copyright lines.
So maybe consider to drop this introductory comment as a
{preparatory, follow up} cleanup?

(This is also a nit that doesn't require a reroll on its own)
