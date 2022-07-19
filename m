Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D480C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiGSPJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiGSPJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:09:38 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42E509FC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:09:37 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j1-20020a4ab1c1000000b0043576bcb9b1so2740345ooo.10
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ire77J7nT2QAGmmQfRfLEXWNHh6H7bXQGSdUIYAEuCg=;
        b=RMr45cVNTaGkddLa7AiqJMpfq4ExMGPo9QOlkm6kHk9LLxvUXTaBvmY6LKjxVJs38F
         k6ppJoZLbl++TN2peFdV7Za6kP7i1L6rnhIUJa0Ws0OnXJ2i3wxCtG8Dmq0amDiaFqBP
         3GxWDEbBt6besOLO/9YV52zdX+dx6PHlDNhPcVXLSZRcP/HPCPs7gaoLW6bQKTd04z2r
         Txr/uL+PsiUjnuAZE7/n8QKqIIK5WSH5yEqu1qFhgFLYm4OBGeapclklEBIT5yR24uN0
         JC/Zj/Q6qYgFweO9yeaiuXTs5BLkpt8uOGlvDo53lMQNTeh7Ow9I8y7QjyuE2jaIxI+0
         BVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ire77J7nT2QAGmmQfRfLEXWNHh6H7bXQGSdUIYAEuCg=;
        b=s5xjl6qwWGBk613b4lrXrIc5J/4rIJe/KLk+cFFc7Fg1TTwIZlYplQwyN1iMBWgkp1
         t/ewjrbX89VCE8g3ZTJIz0Fw23ge8ytMe9L5P9VdVwaYyoeUF4gved8wF9pyDrD6hMyK
         p6wZ3UD+QkS3svMQcl7KsnDFtqR89lXMmaf8k0GzaC5IghuKXSXaS1FgcVtMw/tuiiN5
         KrtlpUd7TR/clBh6jH8fHrtz786Ou77iCJoImMEwuRMlV55JOeatYC3eagBMjx3xf6cm
         QDR9tWcaURgzp+uGusoncNqNiE+68yfrCJ8O1ZivIxiKdgLhI1vJBTOq377xQqLA4sQq
         9bBQ==
X-Gm-Message-State: AJIora+MS0WcIbd5w1cFWrZlVyr31yrMHAw4Rpqwn6DgGEU9pSikBlHa
        5C5/qjgmBnDetf0CblbjuqRt
X-Google-Smtp-Source: AGRyM1uyOHSScnS8fsgmFW/74KOcMLGdp7oDA28kaMuwVUYjPlL5zZmYzp8j9YY+3OIQZ1CFEN3C0g==
X-Received: by 2002:a4a:dccc:0:b0:435:9890:a10 with SMTP id h12-20020a4adccc000000b0043598900a10mr4177053oou.63.1658243377033;
        Tue, 19 Jul 2022 08:09:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id q14-20020a05683022ce00b0061c87262540sm4656683otc.65.2022.07.19.08.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:09:36 -0700 (PDT)
Message-ID: <75cc0f43-d9a5-45d3-5e36-dd20acfebf50@github.com>
Date:   Tue, 19 Jul 2022 11:09:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] t/*: avoid "whitelist"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
 <220715.86o7xqzkt3.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220715.86o7xqzkt3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2022 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
>>  GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
>> -SANITIZE=leak will run only those tests that have whitelisted
>> -themselves as passing with no memory leaks. Tests can be whitelisted
>> -by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
>> -"test-lib.sh" itself at the top of the test script. This test mode is
>> -used by the "linux-leaks" CI target.
>> +SANITIZE=leak will run only those tests that have marked themselves as
>> +passing with no memory leaks by setting "TEST_PASSES_SANITIZE_LEAK=true"
>> +before sourcing "test-lib.sh" itself at the top of the test script. This
>> +test mode is used by the "linux-leaks" CI target.
> 
> It's hard to improve your own verbage, but I think in this case my
> original version can be improved still:
> 
> 	GIT_TEST_PASSING_SANITIZE_LEAK=<bool> when compiled with
> 	SANITIZE=leak will, when true, only run those tests that declare
> 	themselves leak-free by setting "TEST_PASSES_SANITIZE_LEAK=true"
> 	before sourcing "test-lib.sh". This test mode is used by the
> 	"linux-leaks" CI target.

Another iteration:

  GIT_TEST_PASSING_SANITIZE_LEAK=<bool> focuses the test suite on finding
  memory leaks. When the variable is true and Git is compiled with
  SANITIZE=leak, only run those tests that declare themselves leak-free by
  setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh".
  This test mode is used by the "linux-leaks" CI target.
 
>> -test_expect_success 'curl redirects respect whitelist' '
>> +test_expect_success 'curl redirects respect allowed protocols' '
> 
> Isn't the real problem here that this is inaccurate with regards to
> "curl", i.e. AFAIK from browsing transport.c the whitelist of protocols
> has nothing to do with curl, we parse that out and apply it before we
> ever get to the specific transport layer.
> 
> So this should just be "http(s) transport respects GIT_ALLOW_PROTOCOL",
> no?

Sounds good.

>> -test_description='test protocol whitelisting with submodules'
>> +test_description='test protocol restrictions with submodules'
> 
> Minor: I think this shows the awkwardness of using a word derived from
> "allow". Before we could use "whitelist" and "whitelisting"
> consistentlry, but now you have "allowed", "allowlist", "restrictions"
> etc.
> 
> I guess you could say "test protocol allowances..." or something? Meh.

Perhaps "filtering" is the best way to describe the higher-level
feature that these lists help to implement.

Thanks,
-Stolee
