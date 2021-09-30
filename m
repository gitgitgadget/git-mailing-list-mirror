Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88550C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADFD61A08
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbhI3UNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3UNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 16:13:06 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B4DC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 13:11:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r1so6882138qta.12
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DgURFeenVrr0Mcm8IpCF0ylZ7JEa5EZMlzK07lC3moQ=;
        b=W1oUMKCpBPkf7XL9z+6MIaBBk2DLCYqxJwawivF9nQTAZ831nmz5nOHalC847eoMZc
         X/VabIZoOkQaxwgGwtz0JYMXf4SdkNvb8tqXidRfscIDS+Mnbw+/WSdy3gAyBAys9XTa
         wzeh3Tz2Qj5oeJx3GQ3LFPsYi1kV4UpxCGUzvnXBbAHzaW5l5rCOildS21S6W4EZgL4J
         inIVddQ5MN2S3t7j8vXK4U7OOTRP0uav1rYBs31MqKa9CXlBcOf0JzwO1SHmeRFTwomW
         Nuv4u2AE/F4n1j8TyhL/yVlLKe5HHsw/lf3JAHgIC4tuQ2/HyNHG8W10TESilxyeFt2/
         Ggfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DgURFeenVrr0Mcm8IpCF0ylZ7JEa5EZMlzK07lC3moQ=;
        b=HAvweViAdFr6pSfEhxoUpZm68VYjvsAwnfEp8bz5WdXPD5gNldCtrIAwwuxEInZ6ts
         lDMXdK9TshzZxCxmbgTC32uxPKO1fGvTcDmlQScgMR9sWyH6wLhfteCbsZhi/G+lHttk
         x54Btvl3uaiXFyw3/wqqTHntCuzvh1cyxrcNZFH6QJ/Wn7ppIjMBZF1AzOwPL/OASfXw
         UWqmOAb4TMBd9x53+lWE/oeObwWPAoyJg+m/G/bV2ip2CP5WCLT4efQRXrPS9dybD9M6
         4gXFrIwhaHWsblikH7c0zClJ3818QQvbipBtiB490xLM704XPkobFfqS/sImfAI70ZJy
         5/Bg==
X-Gm-Message-State: AOAM532oFTiNqxEX7/ckQviihaOedB6GoQi7L4+rxh13txXbS/MVzpgv
        qirdQL82421w9RwFDPWHZfRl
X-Google-Smtp-Source: ABdhPJwC2C0OU7npjio29j25mS2Xg7eFHimbn/g0jp1Pzd9xJlbAXjfnNJ+SGcwmFB9VZw7ej/rOyQ==
X-Received: by 2002:ac8:6e8f:: with SMTP id c15mr8771599qtv.179.1633032682189;
        Thu, 30 Sep 2021 13:11:22 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id l3sm2160559qtu.47.2021.09.30.13.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 13:11:21 -0700 (PDT)
Message-ID: <6e9843d5-bc04-e69c-9e53-7bf18ca30fc8@github.com>
Date:   Thu, 30 Sep 2021 16:11:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
 <YVYNW13aVADaR+g6@nand.local>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <YVYNW13aVADaR+g6@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Thu, Sep 30, 2021 at 02:50:56PM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> In anticipation of multiple commands being fully integrated with sparse
>> index, update the test for index expand and collapse for non-sparse index
>> integrated commands to use `mv`.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index c5977152661..aed8683e629 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -642,7 +642,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
>>  	init_repos &&
>>
>>  	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>> -		git -C sparse-index -c core.fsmonitor="" reset --hard &&
>> +		git -C sparse-index -c core.fsmonitor="" mv a b &&
> 
> Double-checking my understanding as somebody who is not so familiar with
> t1092: this test is to ensure that commands which don't yet understand
> the sparse index can temporarily expand it in order to do their work?

Exactly - if a command doesn't explicitly enable use of the sparse index by
setting `command_requires_full_index` to 0, the index is expanded if/when it
is first read during the command's execution and collapsed if/when it is
written to disk. This test makes sure that mechanism works as intended.

-Victoria



