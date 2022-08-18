Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BFBC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244995AbiHRNTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiHRNTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:19:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BC979F5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:19:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i77so1042314ioa.7
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tI+DYo/jvIY40Hh/wj2cK50A4CgMMJNpT5esFGPQkfY=;
        b=YRt2VbV8B68yZXtz04TrA9IpHsGMEQioNxMwuZHtkWhpvdl1JFVlj/XihierOM7/aX
         s7geLrz2Sse3lDR4P4sKvMudU+6Wq1D0FkadXKjyoBc6yVNzpHIC/ebd7vuuk3YYR5sg
         3MbnJqBUxKtEdRf2Ptnedp7l4hD4fs24vCK56TRkmZzMfiVGUZGWBlFl59CAC2f7pA0C
         2MTE1L0IigCAsdswWTHxbGKJWEtziB16ZbiKRQquyYoqo/tnddPop1uHIPeUYCcmrEOC
         ggGkhwQ8+EgFvk02Nh9NeDGma8u0FdyoUUf5Qh9+CfP4YxudrSwnSjqFChVy3dUdQcOX
         89IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tI+DYo/jvIY40Hh/wj2cK50A4CgMMJNpT5esFGPQkfY=;
        b=jK0USioCEIcp/E1be8j+4tu5gTEqnJFC7X1GRNdoISXl/Kxm6W6EZKTLVOguTlDh+s
         EvmeCcos/0lEC9N+DukGEMFQy2mNvwUnjaa1MBScHhs3JVOrkVtpoc/VsUE3nTXyqDVb
         Zfca6lAAfzogE6YhZUYASxcstAW9ikD0wHUV76FnrTjnrYpTSkwXPuDcQ7ufyMVJDqli
         3pHUTXe+qOgDCx2cmMMLdF7naEtYk3UUMHPO0VLlqTyNh3r/e/Z7JwMYeFIRgvyQdjK5
         AKV3IGqMfPzfqszoWGBSnxIGBCNZiBg0UNfApn3FAzwJ6BN9FxL4TAuCLhJMBIKGsltZ
         yK6w==
X-Gm-Message-State: ACgBeo2QaWtjdrLQxLCFjXDzdjUhpnEuWmcKOtQ432zK7k1doBAuwuia
        I+xbMTm0E9fvoxgdu+C/hjBj
X-Google-Smtp-Source: AA6agR57cguBXvjoNQ9dg3lPBmWnNPIhxLiZtJLdwPz/QEuyrqQb2p/rBSfmnkCHVTN7baTQDPK2XA==
X-Received: by 2002:a6b:3f55:0:b0:688:c6e1:4644 with SMTP id m82-20020a6b3f55000000b00688c6e14644mr1392063ioa.213.1660828758982;
        Thu, 18 Aug 2022 06:19:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6? ([2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d8941000000b006887ff8a069sm840372iot.30.2022.08.18.06.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:19:18 -0700 (PDT)
Message-ID: <d1c1ec96-8062-1eaf-c0c5-466369e7b874@github.com>
Date:   Thu, 18 Aug 2022 09:19:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: What's cooking in git.git (Aug 2022, #06; Wed, 17)
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7d36s31e.fsf@gitster.g>
 <864680d7-69e0-c392-db39-28f15bce3935@github.com>
In-Reply-To: <864680d7-69e0-c392-db39-28f15bce3935@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2022 9:18 AM, Derrick Stolee wrote:

Apologies, all. I sent this reply to the wrong thread.

-Stolee
