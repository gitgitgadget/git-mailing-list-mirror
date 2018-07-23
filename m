Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FA071F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeGWUk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:40:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42859 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeGWUk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:40:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so1817927wrs.9
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gdO46fa5hal8iSil2TGEQsrKEtorawhPU08VFILs51Y=;
        b=nx2ZfbqnSWnAwdSzsf/IQjd9ijRaoczAbYlQoYidWdOlX/AU9sikOGqD7S4coDHK3R
         pCKY3E5VEPvg6Tk6yvi8uEZJg2s+YmzDwgr608twxz5FR81/Jp0dr2+WcjQNG2DRJg/R
         gjqjR4zeHwcwUQUuVrAhQOPsvCON3nGGT7TN5tMwocNhJH1H3gfx0lDH3emnD9mXfwPV
         V8FL5Zb2l1EwJiPN8bP6TTo2RzWMcbAl962vSmgH/KR5USEbexXBZHBzlKT7295oZV5d
         xwRnwKPvFxmhiTURCNOP5Lvhp/4NtG1hm/kBAeLZEtAo309LTXIH4yQA5wydjh8wPRTR
         NdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gdO46fa5hal8iSil2TGEQsrKEtorawhPU08VFILs51Y=;
        b=RplyVTTuq9VPXt4E59E6lCX86HBz01WvJlNwClxoUvcqHQQxel9qjah2fGpBVHyUXu
         /njTrF7MC5ah3jh8K6veOrcIwISE8SpYLU2pHM7+crfk3hP2fTlerishRpxTCL3Db2mX
         H/1JZO2qiTFbzmz4aoImYLesn7fkhZ6cTmSDeYMsyqUPxToFPHYIGLRhnFo0sblKADYR
         uGVs5s2wTkyHXuVSKsozGyWqbpHT1QfvrO+3DV11QybitdJwV7RF2aoB/SHbVfw0MzNi
         juNxKCfVVE917Fj5J/VUR93EgiGFAWsYcTw0WA3PEnE7ZV4t6zfD6Zy3mxzeLRyFFnLg
         gDzA==
X-Gm-Message-State: AOUpUlGS06+Qd14uwZ2BMr2/KRYmkiq3iXE7h4ID1D0tucqZdeeYIRJi
        T2d8xBOqo4dgjoYSimk0nMA=
X-Google-Smtp-Source: AAOMgpcGj3ZfUhipB54AFOF+iI0jNuH913T7XuQzFUjhMqW48YRAcuP7GReZQbyaTVV64fBb6w5nMw==
X-Received: by 2002:adf:e992:: with SMTP id h18-v6mr1375694wrm.238.1532374665845;
        Mon, 23 Jul 2018 12:37:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w142-v6sm17121518wme.13.2018.07.23.12.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 12:37:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] coccinelle: use $(addsuffix) in 'coccicheck' make target
References: <20180723135100.24288-1-szeder.dev@gmail.com>
        <20180723135100.24288-3-szeder.dev@gmail.com>
Date:   Mon, 23 Jul 2018 12:37:44 -0700
In-Reply-To: <20180723135100.24288-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 23 Jul 2018 15:50:57 +0200")
Message-ID: <xmqqa7qh68vr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The dependencies of the 'coccicheck' make target are listed with the
> help of the $(patsubst) make function, which in this case doesn't do
> any pattern substitution, but only adds the '.patch' suffix.
>
> Use the shorter and more idiomatic $(addsuffix) make function instead.

Makes sense.

>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 27bfc196dd..8f509576e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2683,7 +2683,7 @@ C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
>  	then \
>  		echo '    ' SPATCH result: $@; \
>  	fi
> -coccicheck: $(patsubst %.cocci,%.cocci.patch,$(wildcard contrib/coccinelle/*.cocci))
> +coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
>  
>  .PHONY: coccicheck
