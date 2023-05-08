Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86798C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjEHVAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjEHU7w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 16:59:52 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED7422F
        for <git@vger.kernel.org>; Mon,  8 May 2023 13:59:51 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a2cb9788dso74240547b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683579591; x=1686171591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILXbyiW4dKhHbIO6utxYS4KgAmihPwmNPwcc/UjReTs=;
        b=TSKXhKT8yBKiQyNApAf90xk1rhxYjDBwACBPvy4G4MkEHXap9BT1LwQ9WVUMbTDJR8
         HFNkcLPI9MHZajVHvvTyjyGg6pkTeJW/IlcC0UNyKt3q+HUNaL3D4PlcwFDh+JTInHGR
         KMRccVJwsn5TJkQYqVW4rrCQbtZMcs6nnVJJRmltcZIUIJo/J1Ibeq0ZdaOQOUpb3Nuc
         Qt/cVIK2GFdqUfNbgz8jWWRe7iAlpesGdp7Hji5hmzFwfDkyQmo+AZGvmYgVSNHeRqfA
         zC1giF1PpkPSStlDPjqPmoEK3JivVZqpOumGhy5B9Ln+BN4pMFNiKDGrYeEYG6FD+uDf
         PKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579591; x=1686171591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILXbyiW4dKhHbIO6utxYS4KgAmihPwmNPwcc/UjReTs=;
        b=X0iGWGZKl9m0J44VKDbolMH0wNbB3d3p5qimHeke4K5Y5aj2Xbgskj3RzgXiFARiM+
         RUfLlXvafMuLQ9PTgzQKRKRZW/cBuI2tdjby4ElwnIv+cpgj7w1AIB3ujZoZqFqDiU0c
         nh5DK+4zBXICGK+juC/mTbNJiZd94ce1Fbf4zG2ehugGvFPR3Gqy/u9zHgTmjLVPOTuA
         47ytMeZ80h8Xvbur/6Sld+yye+K0/MKKKupTmU3/ASwE/k1di4FkUcK7HRluk0/2y64C
         j8Yt5YGM2bHwFcFqyneUvbwwosQ3yDzHIdbdMtcmrxpHCe+2Qlnn2C76PfmJl8paFvKj
         DJoQ==
X-Gm-Message-State: AC+VfDxYRGkDTmamLp/9Fsbfjzw1286Nj3MltVwsuB2cCzfWEJDfee+j
        9rC4bnp38bROLK9dHdVh5ho/T4tvEPzKgh3lfw==
X-Google-Smtp-Source: ACHHUZ6YinIFiFaicjL5sPGSazGSqTzlKgNb/ZtUB9bn/UXONt+c8oU/cUoPC4HznTyi+3YLrUGmdA==
X-Received: by 2002:a0d:ee41:0:b0:55a:60d1:814b with SMTP id x62-20020a0dee41000000b0055a60d1814bmr11926998ywe.20.1683579590985;
        Mon, 08 May 2023 13:59:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e98b:9e8:a1f6:592b? ([2600:1700:e72:80a0:e98b:9e8:a1f6:592b])
        by smtp.gmail.com with ESMTPSA id b127-20020a0dc085000000b00545f7c7cc8csm2769920ywd.93.2023.05.08.13.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:59:50 -0700 (PDT)
Message-ID: <cfb5fe88-d270-62e3-01f8-ac53049ebb63@github.com>
Date:   Mon, 8 May 2023 16:59:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: What's cooking in git.git (May 2023, #02; Fri, 5)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmt2ibcq2.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmt2ibcq2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2023 7:05 PM, Junio C Hamano wrote:

> * ds/fsck-bitmap (2023-05-02) 2 commits
>  - fsck: use local repository
>  - fsck: verify checksums of all .bitmap files
> 
>  "git fsck" learned to detect bit-flip breakages in the reachability
>  bitmap files.
> 
>  Will merge to 'master'.
>  source: <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>

This has been marked as "Will merge to 'master'" for a few cooking
emails, but as far as I can tell it hasn't even hit 'next'. Is
there a reason for that?

Thanks,
-Stolee
