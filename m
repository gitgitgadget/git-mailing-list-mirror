Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4174C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 00:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDMAZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 20:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMAZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 20:25:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F196E94
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 17:24:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h12so11991969lfj.8
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345496; x=1683937496;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eFLBTuqALU3obZaCkFtMLs3na+XW7IzEuNLGXGET94=;
        b=Av6m9eYBab2kLB+KEZdj9NyWXrkCaxbQZDKYgkZXXaHqo3l5LgjjDK4tT6LcyN/gzd
         Al+AbxHjjzBNXA2SFweXxoOkqr7OT89uwVADAouSBCasjd9kIDdFThd5sUo0T8pg2lLn
         fbkYRz5Z77Q3ThZpCOjWzU6H/u98YiAX0/rIbWwx04vQaPYJgnjMkBMmxjsZ6nFON1ky
         3CgRTRmBxrHa9W1auQPcNMqL628SPhSbUQrAmuwbHpfb21XgcwRYLln12k9KsVp53W/M
         cd9/PDSlq8sFiFfmRxLHLeLDBoNYU9oH0HsmgCdL65z1gA9ojVK6WyJxlLOx/EG5R9VN
         2HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345496; x=1683937496;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eFLBTuqALU3obZaCkFtMLs3na+XW7IzEuNLGXGET94=;
        b=SUsu0ys4TkZ871RRVPJASy4VQuKg8BjpwAO3/PH26c/NOYa/Hz5wqQpRss1ZDO7n7c
         PgX1sp3qfMOcY6FD1tv31jDP4ghHAWTHcZAiO0yFDoNzWoxK2dXxk+rwZSq3aWKvNHlZ
         kKdthC+kiiYrn3KiOzEu2Fn72OOUenYz5Wv2cldw9cWkwSBl/yqKWF029SJ6gFNanrXF
         MHpgPuVDEFVpH1YlL16ZcGdFGUYWb+T48RBznY6chaHxtFm6O1Rxhysot2z2f+QLQZIi
         A1aKcifJKW2prX72gqRwgkukC23XJz/uUODcbZWvTHn29z1u9COwjlQTmE8AAHkA/kbF
         yWGQ==
X-Gm-Message-State: AAQBX9ehqgrrzxP0t+RMnLuviOe/AJt0DRJ+tzQEOh1+0DqGtM74UzXP
        t/W8Y3VPuw8Ms8oaVnfCKyY=
X-Google-Smtp-Source: AKy350a0BvV4WexAIFa1MBm1vrppFM5stpVSQ7jVgUHsaNldLiV0LtGwCqSaWBidTMTWRxvMuVtSWw==
X-Received: by 2002:ac2:46d6:0:b0:4ec:a9c1:27de with SMTP id p22-20020ac246d6000000b004eca9c127demr199640lfo.18.1681345495688;
        Wed, 12 Apr 2023 17:24:55 -0700 (PDT)
Received: from [10.8.18.63] ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id f2-20020a19ae02000000b004ecb06acbb3sm24381lfc.281.2023.04.12.17.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 17:24:55 -0700 (PDT)
Message-ID: <6d572a02-0e20-1cf6-db6c-7306ac912049@gmail.com>
Date:   Thu, 13 Apr 2023 02:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2023, #03; Tue, 11)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqo7ns69sz.fsf@gitster.g>
Content-Language: en-US
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>
In-Reply-To: <xmqqo7ns69sz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/04/2023 23:59, Junio C Hamano wrote:
> 
> * ar/test-cleanup-unused-file-creation-part2 (2023-04-03) 6 commits
>   - t2019: don't create unused files
>   - t1502: don't create unused files
>   - t1450: don't create unused files
>   - t1300: don't create unused files
>   - t1300: fix config file syntax error descriptions
>   - t0300: don't create unused file
> 
>   Test cleanup.
> 
>   Will merge to 'next'?
>   source: <20230403223338.468025-1-rybak.a.v@gmail.com>

I wanted to wait a bit to hear back from Ævar Arnfjörð Bjarmason and then
to resend a v3 with any necessary fixes and with "Acked-by" trailer from
Øystein Walle for patch 5/6.

https://lore.kernel.org/git/CAFaJEqug4bghEMnEQzGDN10EqM8e8iSf5i12AvOm+NZzDCQKOw@mail.gmail.com/
