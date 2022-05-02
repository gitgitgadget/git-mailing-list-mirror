Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B1C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385399AbiEBNtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352494AbiEBNtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 09:49:42 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFBA1A3
        for <git@vger.kernel.org>; Mon,  2 May 2022 06:46:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m6so11849167iob.4
        for <git@vger.kernel.org>; Mon, 02 May 2022 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=5vpLe+1bUyF5c7f7UzPCXXuRQm/69SnZmz+k+BGAUIk=;
        b=NxkYVRXpIWUvH3g8CdXdPzL8m8Dbxw8L9koGXgOTki2pcuFIaRpESQjo71EbSpVjES
         kxgAF4v5Hy/u1cBh0MaGOepf5RvAiUsTKT9c0zPTcDWJGZMe4pzgdSMmUYqgIA5OZlRj
         fIAysFPXJHNasAPYnMGcwl+k+t4K55jMJAQS0x34Xe/nBd0ySv+P0Zyy/CXqVn3/8cn9
         zM6RYzxuV/0xK1Vq5W9T7Hd2xfDJ7cVmdhUZxPJ5vZSgLkLR0YiGYpvcxZZEwcJCnVqo
         +xuxhaDlR2fahy4swzbaBDcCRSoFadHwMwbVbVs5jj6jwvEFKP6CSFlQek8snIJINL4Z
         jY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5vpLe+1bUyF5c7f7UzPCXXuRQm/69SnZmz+k+BGAUIk=;
        b=nMxunA97PeUGdiLBKbgce5QElbQkMo+iy3osKfue4/0jVRYt80IrktltTx+pe/d1os
         6FeOmfI8PcmuV/FwGmmtcvhW2V87GWVQcJcHwuQtFLpAHqCQ2YTA1cLdOqB94uVgHpBb
         6EjiY6j5Nf2SHTvZXTwtMRaG1GBJvte01gt3y5W6WYxfFyckXyHtIXUmla2tsl0FxOLQ
         eFvVowVkfavrs06fDu9ngV3xVJyvbgepXEE/4XiFo3a64ElMzAAaUROrRQZb4K0HVznW
         WhsFJ/o4UQistizApGr5JHkjIfOC9IALCs/3/koKV4Jazi2OQDCUnCAi8pR5S7V7qKAY
         ZMJw==
X-Gm-Message-State: AOAM532g5BU6LgGeqmdjlv5/xfPo46KTyQ4gJ5wvzWRd3C2f71y2LBhZ
        4ez968r+v4xnnDI4FrhwrPeIxTNHJLxd
X-Google-Smtp-Source: ABdhPJyTwm7LzFc9ojG3zjwC5pAchHRbqs2elm0OI+oAMuqI2MguJ/HerMt41twtXBIcoNVZ8AxdSw==
X-Received: by 2002:a5d:89d6:0:b0:657:cc60:6669 with SMTP id a22-20020a5d89d6000000b00657cc606669mr4371223iot.110.1651499172765;
        Mon, 02 May 2022 06:46:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8514:dee2:f0b:81ca? ([2600:1700:e72:80a0:8514:dee2:f0b:81ca])
        by smtp.gmail.com with ESMTPSA id d41-20020a0285ac000000b0032b3a781786sm3070338jai.74.2022.05.02.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:46:12 -0700 (PDT)
Message-ID: <4181f814-6d8e-ff2c-6fc9-a625ac189eae@github.com>
Date:   Mon, 2 May 2022 09:46:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] cocci: drop bogus xstrdup_or_null() rule
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq1qxd6e4x.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq1qxd6e4x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2022 1:00 AM, Junio C Hamano wrote:
> 13092a91 (cocci: refactor common patterns to use xstrdup_or_null(),
> 2016-10-12) introduced a rule to rewrite this conditional call to
> xstrdup(E) and an assignment to variable V:
> 
>     - if (E)
>     -    V = xstrdup(E);
> 
> into an unconditional call to xstrdup_or_null(E) and an assignment
> to variable V:
> 
>     + V = xstrdup_or_null(E);
> 
> which is utterly bogus.  The original code may already have an
> acceptable value in V and the conditional assignment may be to
> improve the value already in V with a copy of a better value E when
> (and only when) E is not NULL.

Yes, this makes sense.
 
> The rewritten construct unconditionally discards the existing value
> of V and replaces it with a copy of E, even when E is NULL, which
> changes the meaning of the program.
> 
> By the way, if it were
> 
> 	-if (E && !V)
> 	-	V = xstrdup(E);
> 	+V = xstrdup_or_null(E);

I think you mean if it were

	-if (E && !V)
	-	V = xstrdup(E);
	+if (!V)
	+	V = xstrdup_or_null(E);

or

	-if (E && !V)
	-	V = xstrdup(E);
	+free(V);
	+V = xstrdup_or_null(E);

But yes, there is no preimage matching this pattern, so it
doesn't matter.

Dropping the rule makes the most sense.

Thanks,
-Stolee
