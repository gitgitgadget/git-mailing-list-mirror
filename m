Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6142B1F51C
	for <e@80x24.org>; Mon, 28 May 2018 08:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbeE1I1Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 04:27:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbeE1I1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 04:27:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so29888870wmc.4
        for <git@vger.kernel.org>; Mon, 28 May 2018 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=T8Amn3wEvJvBBhMOHzwbJmNPCtS5RbxkUYra9hL5aG8=;
        b=tLzXW12w0GC8YgO2rk3ctq7HqDxpXLLRo8jm5SvoFK+iN3w4HKdVc3m/rOWCZbINc+
         0/PAL/1T8f8E0mFssF1MNmRpuUwvMVEI1g0TPPM7o0XcRxPp9utG4k+yPEzDRlZzo94D
         d8In4xVv/mwmLPS8gCt10+uFD6DTKqVbz6bwzoSBPku+1u9RjqdXqHy4sVrrfCPT140i
         APn5twW+ySxZuwkxmGrIC33kEym24lcW0Bqky3rKtsXs/+DgP/iKakrN80L9XYm2xSCH
         3e69M791tuP5/MtT39nC5F/nFP96IxlhuFG1vvgbJoeKs2XjTHmriqRK2QumflugQCmx
         MNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=T8Amn3wEvJvBBhMOHzwbJmNPCtS5RbxkUYra9hL5aG8=;
        b=YIDFCNbq2rBzrBAjAKiMHM1aLxi/OcVSLMQFLhAkwAwUlZVTBMPFjK1+gUE6GyDY0C
         8DeWriIEnfBmiv1XC13A4YxHaA63az90g85Xq4aL1MUY1WXYx3dyOQUoRyfT2d6uAmPo
         NF31gGCS/NtAIcYmY6FmenJikcJhtcAICVfQ25cw4AOCRARJtN4iZpQjqxjUjHc2/7y6
         OqDl60c13C2tZWPUlZPESUQ8JuQ+IejCaFU2r+6zyqfxYsB70ylrHZRYD4UAqVUCXJqQ
         +7BkLEoiwOdoNPwmjmYw3f40M/BKXnm2L45Dkj/wNo+a95TJpsxSV5R20k2YfnOWE9/H
         yChg==
X-Gm-Message-State: ALKqPwciYLe7tgElFHgIDol6/8QodOBp1Vz/GI8nXN/jlG9CqOxs+PoB
        f63NSX7twYGiTgitnsBJ204=
X-Google-Smtp-Source: ADUXVKITVlLbgQIIiGXiiFeOTXzV5lX1XXOG6MB9bFuxTZDCDegMRRD36YKQiBkxuKZyI7L/YGv3gQ==
X-Received: by 2002:a1c:2d06:: with SMTP id t6-v6mr7073509wmt.155.1527496042279;
        Mon, 28 May 2018 01:27:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm13354838wrp.44.2018.05.28.01.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 01:27:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from `advise()`
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
Date:   Mon, 28 May 2018 17:27:20 +0900
In-Reply-To: <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 25 May 2018 23:00:53
 +0200")
Message-ID: <xmqqmuwkjic7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> I'm open for suggestions on the naming of `prefix_suffix_lines()`...

Is there a verb that means "have/place the thing in between two
other things" or "Bring two things and place them on each side of
the third thing" in a more concise way?  Wrap?  Sandwich?  Enclose?

> +
> +/*
> + * Write the message to the file, prefixing and suffixing
> + * each line with `prefix` resp. `suffix`.
> + */
> +void prefix_suffix_lines(FILE *f, const char *prefix,
> +			 const char *message, const char *suffix);
> +
> ...
> diff --git a/usage.c b/usage.c
> index cdd534c9df..80f9c1d14b 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -6,6 +6,24 @@
>  #include "git-compat-util.h"
>  #include "cache.h"
>  
> +void prefix_suffix_lines(FILE *f,
> +			 const char *prefix,
> +			 const char *message,
> +			 const char *suffix)
> +{
> +	const char *cp, *np;
> +
> +	for (cp = message; *cp; cp = np) {
> +		np = strchrnul(cp, '\n');
> +		fprintf(f, "%s%.*s%s\n",
> +			prefix,
> +			(int)(np - cp), cp,
> +			suffix);
> +		if (*np)
> +			np++;
> +	}
> +}
> +
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];

I guess we can directly use this even in the codepath that
implements die() without having to worry about the helper making any
extra allocation, which is good.


