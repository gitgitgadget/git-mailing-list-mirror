Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C7C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 15:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiLAPG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 10:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiLAPGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 10:06:53 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA937204
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 07:06:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id u10so1500648qvp.4
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 07:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7lGnsZM1wPvTyhtRg7wZge0uJECUoBg6mAvgqpw9Q4=;
        b=c3d+ptQKuqqq5r4WwXdy9j51JVk6idVHNb+lLHGgfEfuLzxE3CnriqBOrnA1dKZon1
         OmPaWIFV9CgbKPtPkl/NYXixk8gF9WuLsGJp8S9tkEqYe/QhND4VFji89hiX6U7uRO+q
         CNKQL7LZZjk49osOplcThOdGD8Bc1zF4XiIyj+MBktNZqvY7PRjX1BfxB7f8hvhr7+Eo
         QYm/XPRFn0L6jUtXal428AtlzbcpCHa9+PmNa+BoEiG/++tlyJN923hmf4MqsRc/HZTY
         EW+Pb1y99PMyJpS9d8coQYzCDnnoBWsU1ZBf3HcF7Ut++T4hrCDjKukclQeWGtKcIhlq
         g11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7lGnsZM1wPvTyhtRg7wZge0uJECUoBg6mAvgqpw9Q4=;
        b=c7L1eJj7rp3nUtjZDHymMuUDm3bBFXLLeNkAdQ3u+fZ/PDe4wUNBEokwAk6vW02CPX
         k4zi6X0GL64CmPBTELfYyCUmH0iSdOsmqRjjTODujyVAevISPI840ZScDmVj9HVIV75J
         B+/U+VFeQrLRW+T5TtH0di6jxnnUWg9qlujV6RENYt0xJt/6iTzBnvjNQBaKt+Nwglbi
         fRCC1BQe9r5/qjmw09FhgED91zO1OQTQOvZ3C2rXEQDisU4jdF4FJTpZ4e4ASZsc1Y4Q
         CP318oqceHF+bASqLWhSxT3S1FDF8qnnYiP99gL8Xn4ivkQMgJ+4RwmnAcK4cGtzklS+
         56kw==
X-Gm-Message-State: ANoB5pmwX8ZOFWtmnlniMPEI4mSYIofauNOu5YrbohfsmS8OdVX9fZ1g
        4RXh5lzepuL0ikKrzdR5vsYJIbJkWb+K
X-Google-Smtp-Source: AA0mqf56dNXxjjra/cjJdqjRC0W4SbaRwavNnKVIgvpzRdUMXGwdeHKcLDMQnCb7qh3bY89UHvdTCA==
X-Received: by 2002:a05:6214:458a:b0:4c7:34b6:ad33 with SMTP id op10-20020a056214458a00b004c734b6ad33mr1617187qvb.38.1669907211581;
        Thu, 01 Dec 2022 07:06:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:125:cd27:62ac:2317? ([2600:1700:e72:80a0:125:cd27:62ac:2317])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a0c4b00b006fc8fc061f7sm3499432qki.129.2022.12.01.07.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:06:51 -0800 (PST)
Message-ID: <81dbae6e-b198-c056-5107-99c88ce77f94@github.com>
Date:   Thu, 1 Dec 2022 10:06:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: ds/bundle-uri-4 (was Re: What's cooking in git.git (Nov 2022,
 #07; Tue, 29))
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfi22j67.fsf@gitster.g>
 <b223202b-0ae2-bdb5-e9d6-21a6321a9e31@github.com>
In-Reply-To: <b223202b-0ae2-bdb5-e9d6-21a6321a9e31@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2022 4:16 PM, Derrick Stolee wrote:
> On 11/29/2022 4:40 AM, Junio C Hamano wrote:
> 
>> * ds/bundle-uri-4 (2022-11-16) 9 commits
>>  - clone: unbundle the advertised bundles
>>  - bundle-uri: download bundles from an advertised list
>>  - bundle-uri: allow relative URLs in bundle lists
>>  - strbuf: introduce strbuf_strip_file_from_path()
>>  - bundle-uri client: add boolean transfer.bundleURI setting
>>  - bundle-uri: serve bundle.* keys from config
>>  - bundle-uri client: add helper for testing server
>>  - bundle-uri client: add minimal NOOP client
>>  - protocol v2: add server-side "bundle-uri" skeleton
>>
>>  Bundle URIs part 4.
>>
>>  Waiting for review.
>>  Seems to break CI.
>>  cf. https://github.com/git/git/actions/runs/3560918726
>>  source: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
> 
> Thanks for pointing this out. I'll be sure to fix the relevant
> failures in linux-TEST-vars [1] before the next version.
> 
> [1] https://github.com/git/git/actions/runs/3560918726/jobs/5981349269#step:4:1854

I have discovered that the problem is due to the test variable
GIT_TEST_PACKED_REFS_VERSION=2, so instead it's probably best
to eject ds/packed-refs-v2 from 'seen' instead of ds/bundle-uri-4.

Thanks,
-Stolee
