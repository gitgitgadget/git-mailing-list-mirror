Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A188C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ1VIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1VIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:08:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9224A55F
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:08:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 21so9623740edv.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xNL6YD3ciWYrgPo7p7iHMFxWNVbP+r8wuetqVb7lluQ=;
        b=ez924oA9Jlp4R1VPUpe3icupFoq+LJ229FTB6PNBYuZACwuYx3uh8sm9W81QXSRtcv
         X2VmsHrr/GiuiaBuhZBev+aF0sfKrgrCx3Cgn2qOAubgePZdu80xliMq0t4M6NHE2M6R
         0kWf6+oaQiv4R1zxSw+tbQj1IiVpy6Xh6eDD11d2RV3pOBM944Px/UuF9hdQ73pl/0VC
         QYFrGtX4eX3+1K+aXcIuGErvLaldrmshYKVJKdn99/as5Es+z2juQaqA1ARqLlbm75Eu
         rMHm4aWPEUCwDmFQqCMvyxGBea4JrpMvO/LyfuVK7TPtt7YxPBWyhZYze97XaH3h7m7B
         9yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNL6YD3ciWYrgPo7p7iHMFxWNVbP+r8wuetqVb7lluQ=;
        b=32xbBccXL1cfDe2mYeLin3jFQweVRD2TG2+v92AMmJjcwZP9A9oSScZUhNzVDyh3h/
         T03VkcYEiML732f4e+RnWjgIcMxoszID044rriOv74pELCGfuBzGkZEm3ZKZMD7romAL
         3oPAwWG9xWisBMvL9CXwaxvZUZFnL3jCuuFCEzJuh1ZW1kGD9BbnpWPA7O9NIhEqjpJ6
         R19iWkEluRAJ33x9IPQsDvMKjO/dZCvDNaA4jVX0knh7i2rnyK1M54DhQcbkPKQUU2BJ
         gklcxUEYkuWrr/cQiGPr1RhV1ulmqD7QRbK4cmlPKJvmEczT492e8ymPM7aJ4IpMP8rw
         v30g==
X-Gm-Message-State: ACrzQf1aeda3At1DYAc4Uq7VkI15b1ZEMUUWgqJo89O3D3sM0bBh8nQz
        ZZRB+Gw0Evtj1L5M8zrn/UAkZk2pn1s=
X-Google-Smtp-Source: AMsMyM5U9H0f91lfs1873JGCKHEZcW9lr/8ETlAjXT5KdJtOn/s9+bKZSzwsyRYF8z8a8aYwbC2kOQ==
X-Received: by 2002:a05:6402:11cc:b0:462:76cd:1215 with SMTP id j12-20020a05640211cc00b0046276cd1215mr1296619edw.318.1666991290500;
        Fri, 28 Oct 2022 14:08:10 -0700 (PDT)
Received: from [192.168.178.22] (dslb-002-206-241-107.002.206.pools.vodafone-ip.de. [2.206.241.107])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0078d0981516esm2634151ejb.38.2022.10.28.14.08.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:08:10 -0700 (PDT)
Sender: Simeon Krastnikov <simeonkrastnikov@gmail.com>
Message-ID: <e2164b04-98de-6f19-6c33-6979c1a328ff@gmail.com>
Date:   Fri, 28 Oct 2022 23:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     git@vger.kernel.org
From:   Simeon Krastnikov <skrastnikov@gmail.com>
Subject: Potential bug in --color-words output
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Given an initial file with the contents "not to be", which I then change 
to "to be", the output of 'git diff --color-words', is

   notto be

with the first three letters colored red. To me this seems incorrect as 
it implies, or at least misleadingly suggests, that there was no space 
between "not" and "to" in the original file. (Even though in that case 
the output is actually "nottoto be" with the "notto" in red and "to" in 
green.)

If instead I start with a file with contents "to be", which I then 
change to "not to be", then the output is as expected:

   not to be

(First three letters colored green.)

Am I correct in seeing this as a bug? If so, any tips on what parts of 
diff.c to look at when starting a patch?

Thanks,

Simeon

