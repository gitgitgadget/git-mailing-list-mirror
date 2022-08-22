Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDEC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 20:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiHVUKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiHVUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DA53007
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 13:09:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bb16so13534622oib.11
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MXIS+3bcDqvjwR8JrmYiQhGiY1zxHPeCNy2vEXJnRco=;
        b=MqUPWEKX2ZjGmsSD1bnlVCfH0fkfgoyGzdhT4LGzCmn4VCFbs26z/BxlYcf5VFMRW1
         VdfFHq4TrgRD2CIeyb7p8srA0OZ+n/P8I2GyU2BeY37+p1w6ybMh/dW0AyWjApBniWNh
         qdp8owZ84NQx1VT1xluGPT4UFtxLcZ9E3oXc4YFvmtJMVHFvtCuq5Go/tJuKpajvCg7V
         h7dbzc4ITdtAHCDVM/CozAiqJrX23rKgr33dE+kZ2nFONCihvl2gbKiHfb+HFXeqWwzX
         wie+VkJ/bafyz1JQrdmHRANBId1VdQPn3/1P8xogHvn9+jcCHTTwSunfbdqwzZ998NpY
         1B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MXIS+3bcDqvjwR8JrmYiQhGiY1zxHPeCNy2vEXJnRco=;
        b=he4SSpX12wiz2A6zVqLfj1Qjkm4nAzlCsaoytQgfdfQAuMgFdECBZBW6HrU5KLcWeU
         xNfu70vfsxF7cczsof3h2R5J0L/cRYAfAETQKtFgdzMSlcVLFfMv6Ffdx8rRe+6yTams
         lIca1nutXX2IjRcbPh8Rr7skNU5FhTgtd0aylLoLSsHQhNX6EytyhWx4pO5407yfY7r+
         BkNL23QpHCpLdiKB76Ox0wJK4iwCcWYjBHFXY4ozuATXMnnnrtZt0O26tI5h3yrrDqA5
         VmRytp4sVL8Ddi5UI6mvMD/cXeWvcr5IJLs2PLznohG/YPZ8bRZribXFIgxq8DWUK+vV
         9ceQ==
X-Gm-Message-State: ACgBeo2+E27yWyY1OzIXlClCxunkJg1v22+2eSCnW3/802ZidKCKmtpB
        nbXPBhdyEeOhlwUnwdcXh3N0
X-Google-Smtp-Source: AA6agR44JviTLmGkh5XBnmb2PrLrzcKwtlXY3bYtDa2B7VLvsTd0eMMxePR+tdnLrSf3RYrtZT/IrQ==
X-Received: by 2002:aca:eb89:0:b0:344:eadc:7719 with SMTP id j131-20020acaeb89000000b00344eadc7719mr21923oih.292.1661198997294;
        Mon, 22 Aug 2022 13:09:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5550:8912:9500:397a? ([2600:1700:e72:80a0:5550:8912:9500:397a])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d2c07000000b0061c3753c30dsm3103508otb.17.2022.08.22.13.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:09:56 -0700 (PDT)
Message-ID: <39b64f22-702a-80f0-af5d-50bb2dcdddfc@github.com>
Date:   Mon, 22 Aug 2022 16:09:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] t1092: fix buggy sparse "blame" test
Content-Language: en-US
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
 <7b0784056f3cc0c96e9543ae44d0f5a7b0bf85fa.1661192802.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7b0784056f3cc0c96e9543ae44d0f5a7b0bf85fa.1661192802.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 2:26 PM, Eric Sunshine via GitGitGadget wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> This test wants to verify that `git blame` errors out when asked to
> blame a file _not_ in the sparse checkout. However, the very first file
> it asks to blame _is_ present in the checkout, thus `test_must_fail git
> blame $file` gives an unexpected result (the "blame" succeeds). This
> problem went unnoticed because the test invokes `test_must_fail git
> blame $file` in loop but forgets to break out of the loop early upon
> failure, thus the failure gets swallowed.
> 
> Fix the test by having it not ask to blame a file present in the sparse
> checkout, and instead only blame files not present, as intended. While
> at it, also add the missing `|| return 1` which allowed this bug to go
> unnoticed.

Thank you for catching this!

-Stolee
