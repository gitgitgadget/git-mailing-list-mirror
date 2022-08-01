Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87037C19F2B
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiHANzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiHANzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 09:55:11 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF2529C
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 06:55:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b7so7089727qvq.2
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MIBe4IiFcgUfYDFPy/rQwsaxrv9rDsYidFnZ7sxNBbs=;
        b=gNA0KnE0suj5SzVEEqM8ftQRb+VCI5O/70a8ffs0AOr+kOTf15+C7GIm3jnAJsgO/s
         VvxVDDdzYuvl98yKrvxCwOAGe0gyAea6ubB3/o+CQ7paKKizp6KYhRfckB45j37A/hDN
         gT5ZEXzIVJd0azPWJgBgmTIcL5WNyJp3kmx/BfrIQEpN7eRx7Y9rm+X40+xbE1C5cGAe
         p6jdcLXbY83ebIyyD1vOTTUEIBwVZj4JVOw8VqgcOttxoR30iH2qV8s2s7xxoGNd1aTS
         pkhJYf913SIpSgIkmPkYEkIcacPM2KgRLYf1k5NXtw3H6EhRJEZT/HECzElOk1ZNHP5p
         DDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MIBe4IiFcgUfYDFPy/rQwsaxrv9rDsYidFnZ7sxNBbs=;
        b=VKtvKLACLBa5f8lcsc/zKiy8b/gU7Ln6lamgqgm1vjmSP6SVPSTqKLUXHCwyfS8zmk
         OW1757KpXP2OjlR+Xw9CYtJ8Mph47lMFQfUaASlVM2elSBPGf0RnMa4Px9VeeEVU2wGG
         ijnMG8wmGFr7FI1SCrrdpQ11aXwB6YxmNXqh0N1S10viuHe0+KRMNczwVedPynr69qyf
         yu2E88ApCUT/JlzGo2T1tvHclgMcPmlfXHNAm9c7Eh9Bz4NCmt+UjHYf9q12luoWv0Zw
         Yo5Sh4PjyIIZjQS9hytzPhWjspFa3ogSzi1f3IENkXs3SnuWIVjAOuoL9+VlOx3Xi5Kc
         SMVw==
X-Gm-Message-State: ACgBeo19hc9Ucbg6JE+O3OFXEstpLUdjJ2IElb89GEoCER/r8Hx8jBnH
        euNFEPyWP5qE8L3IGcZSy0KL
X-Google-Smtp-Source: AA6agR5vswDfGdzv+R8gIhcRBmCVLajuApeJhQ+9jBZ/Df7G+6bBFFgPCms2hZpDP4LYSJSmUbz4Tw==
X-Received: by 2002:a0c:9022:0:b0:473:5be3:321 with SMTP id o31-20020a0c9022000000b004735be30321mr14250593qvo.79.1659362108647;
        Mon, 01 Aug 2022 06:55:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8ca1:1a2:b034:1f7e? ([2600:1700:e72:80a0:8ca1:1a2:b034:1f7e])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84616000000b0031ea864d3b2sm7192775qtn.30.2022.08.01.06.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:55:08 -0700 (PDT)
Message-ID: <71afa569-7071-466f-11af-3bbf856b4bef@github.com>
Date:   Mon, 1 Aug 2022 09:55:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] remote-curl: add 'get' capability
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
 <220728.86a68ukvg6.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220728.86a68ukvg6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2022 7:00 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 25 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
> 
> Add a:
> 
> 	TEST_PASSES_SANITIZE_LEAK=true

I trust this is important for your series that flags tests
that _could_ pass with this. Thanks.

>> +. ./test-lib.sh
>> +
>> +. "$TEST_DIRECTORY"/lib-httpd.sh
>> +start_httpd
>> +
>> +test_expect_success 'get by URL: 404' '
>> +	url="$HTTPD_URL/none.txt" &&
>> +	cat >input <<-EOF &&
>> +	capabilities
>> +	get $url file1
>> +	EOF
>> +
>> +	test_must_fail git remote-http $url <input 2>err &&
>> +	test_path_is_missing file1 &&
>> +	grep "failed to download file at URL" err &&
>> +	rm file1.temp
> 
> This should presumably be a :
> 
> 	test_when_finished "rm file.temp"

Yes. Thanks.

>> +'
>> +
>> +test_expect_success 'get by URL: 200' '
>> +	echo data >"$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" &&
>> +
>> +	url="$HTTPD_URL/exists.txt" &&
>> +	cat >input <<-EOF &&
>> +	capabilities
>> +	get $url file2
>> +
>> +	EOF
>> +
>> +	GIT_TRACE2_PERF=1 git remote-http $url <input &&
> 
> Is this ad-hoc debugging that snuck into the test? Nothing here needs
> this GIT_TRACE2_PERF...

Good eye. Removed.

Thanks,
-Stolee
