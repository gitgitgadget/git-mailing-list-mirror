Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F9DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 06:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiDHGf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 02:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHGf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 02:35:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AB73204A
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 23:33:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n9so7068350plc.4
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z1VlXnXXTtVcCpn10QET3ekWpOK+Amz0SmMHvclNGak=;
        b=mYRXBVlyOwHtba1DgJwfi3B6dwCSS0huGi8mPNj/yxLrqAmASykxhc7xMAnvrHXHkk
         S1d+dGQhusiDnboC2JYz8mBPShdHostFQrBTThYxzThuKnt+atGsnpGvF9vIsoUW61kL
         GLaWIvCvqYmVyQQ7N8EwfOQARw7n947Jw99+tyg03Z0O5Wx+5eailWKJDQ2O41dtkriB
         Nevfh1jClGL4ni5CGx2+vQgKnbCO7GySBRhmdeofPqmioJomGKeKpZ/lFTWkuLROBmU9
         3qY49FYo98R1OeTAo/Eyim0iE46VLi0A/bGcqmRfZHRqYaWRXZbSFxxASo1KrxGPG7Hm
         06Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z1VlXnXXTtVcCpn10QET3ekWpOK+Amz0SmMHvclNGak=;
        b=RiXvJ9ZUpaX8hNVp0vXV8xv8DP3djXLANFLzyYf4dq46A8iaGsVEB9jYjvj5h5rwY/
         Sk2x/B72nOK0EpOtLhtsFI2NA2V0WpENA8+RLxPDGlxnkdE5VntrGSx9XCbk8VZu4+Dx
         iT1HyUNYB2X6bPobRg6Tv+uOHSBBrlL2iG0UBkeT8MbMSMury1ki3WZu38Ff/BTdWU3F
         +bQ9XPsfGiLypCjePC1suknoT1HuJ14Gl4mvGOPiyQb/dwmjN0G71ewmhrh+w0L9WRVW
         SOORaZBke67m/7oeWomziIjVA7JR8MVJJOsGKF4Bw4jG0kknAKSN4P5c2S5SqORNNRv7
         l2bQ==
X-Gm-Message-State: AOAM531tqjekbBWtXDWpNNG9Fja5ctndiWXb7+xyV4uvgin+QPa7EWaS
        PycfFKrsixsEZYKGB/BDu7s=
X-Google-Smtp-Source: ABdhPJy/kdwupFn1gVaMUKrhly4vog7Hbl+oy7MHBIeo8FOIIaMuNXP1vdRmLrh+7BylRPLGG3/vBw==
X-Received: by 2002:a17:90a:fac:b0:1ca:5eb8:f3b2 with SMTP id 41-20020a17090a0fac00b001ca5eb8f3b2mr20327422pjz.37.1649399602577;
        Thu, 07 Apr 2022 23:33:22 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000b4a00b004fd9a6a2a39sm25569523pfo.184.2022.04.07.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 23:33:22 -0700 (PDT)
Message-ID: <e93e9bb1-8bd1-a70f-f671-ca322c14c7a1@gmail.com>
Date:   Fri, 8 Apr 2022 13:33:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] stash: disable literal treatment when passing top
 pathspec
Content-Language: en-US
To:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, joostkremers@fastmail.fm
References: <20220408031228.782547-1-kyle@kyleam.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220408031228.782547-1-kyle@kyleam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/04/22 10.12, Kyle Meyer wrote:
> +test_expect_success 'stash -u works with --literal-pathspecs' '
> +	>untracked &&
> +	git --literal-pathspecs stash -u &&
> +	test_path_is_missing untracked
> +'

Why not "touch untracked" instead?

-- 
An old man doll... just what I always wanted! - Clara
