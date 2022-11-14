Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B0C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiKNAIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 19:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNAIm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 19:08:42 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134763BF
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 16:08:41 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d7so4163945qkk.3
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 16:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=st0U8FXFjS1SUMK8QwNgsjjhSvtSwmckbQo705pWDlg=;
        b=RC9gE48vTFabNQH37VRMNMaMGL4eAMoNa88eUkpNEUKeUu2S/XA5IdgUQcmU6cYP0/
         ea53GXG9d9bxKyVowOtD32z7jOe3Cml+l+nTp9CypgWN8jAPNHSW6O0jXgor8X5YuG/s
         T21V9zD7rx59yOdGwPZgP7dZCXoP934WTqYpuhZd9p5Fmd9G7AtdtNBubknUacN1IKRL
         DKlybo7cvvEAt6oK3e2YqEpUT4YsaxZfm2Em84uuRjTYpvXTaAdNq2mOSNUPP3VzQkhd
         kB+S7uxM5fNeToO2QiT0PXiuLn7e1Edxv12PdkU6GnTh5XL3n5CeZIJiiGvZe+xN31jt
         xwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=st0U8FXFjS1SUMK8QwNgsjjhSvtSwmckbQo705pWDlg=;
        b=P/PXcgX4qh93dPJjs3wntOWscnyRp+rZqnze3F9PT1agAn8QPgwR2ZOkmPd0tELz70
         W1PjuH/N7yIMBLmyhk+N5ZRmnsD61hLsrCxiK+s4DkIu7kBCFTUqJGKeK0z1WZEGrSLy
         y9GiIneuM2+cbUIC3F3mvOOYSxrsV5cA7CWKPNYZXAypsGfzjdsQckD673PixREqkgLP
         6Qzmkd3hDbhPYFEFzAkg3rAQOVdlPED4rvlsPwOFKJQUoN81FKj9bzS8tBVd5WxE8YiX
         u6b6GQf8w3kXzbcn8BIYkNQ3T0W/33dd4ggT81ClT2ZY2CKm6NSukF6k/jXw2AI5f69g
         bgEQ==
X-Gm-Message-State: ANoB5pmEooDfBh5InawUWqJAFeRWSY2rXpCNl5muQWy1+kOJ9EYor05z
        O2nxH6WWYvyQA/K74H1dWYpM
X-Google-Smtp-Source: AA0mqf4MTfM0AaEQTGUf7/YFxq4InP7mN3TSPwipzYQy38mMS4kAzPWMqxoexldEe2cVp1IMmWaICw==
X-Received: by 2002:a37:508:0:b0:6fa:28c5:e2b with SMTP id 8-20020a370508000000b006fa28c50e2bmr9247564qkf.403.1668384521047;
        Sun, 13 Nov 2022 16:08:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e40a:199b:ce52:de2a? ([2600:1700:e72:80a0:e40a:199b:ce52:de2a])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a29c100b006faeecef56fsm5611079qkp.68.2022.11.13.16.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 16:08:40 -0800 (PST)
Message-ID: <5f6f4311-445e-f738-01ec-e36207eed910@github.com>
Date:   Sun, 13 Nov 2022 19:08:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/5] Skip 'cache_tree_update()' when
 'prime_cache_tree()' is called immediate after
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        jonathantanmy@google.com, szeder.dev@gmail.com,
        Victoria Dye <vdye@github.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
 <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
 <Y224iAeMiazdJspp@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y224iAeMiazdJspp@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/22 9:50 PM, Taylor Blau wrote:
> On Thu, Nov 10, 2022 at 07:06:00PM +0000, Victoria Dye via GitGitGadget wrote:
>> Changes since V2
>> ================
>>
>>  * Cleaned up option handling & provided more informative error messages in
>>    'test-tool cache-tree'. The changes don't affect any behavior in the
>>    added tests & 'test-tool cache-tree' won't be used outside of
>>    development, but the improvements here will help future readers avoid
>>    propagating error-prone implementations.
>>    * Note that the suggestion to change the "unknown subcommand" error to a
>>      'usage()' error was not taken, as it would be somewhat cumbersome to
>>      use a formatted string with it. This is in line with other custom
>>      subcommand parsing in Git, such as in 'fsmonitor--daemon.c'.
> 
> Thanks. The range-diff confirms what you say above. So between that and
> an affirmative review on the last round, I think we are ready to start
> merging this one down.

I agree. This version still LGTM.

Thanks,
-Stolee

