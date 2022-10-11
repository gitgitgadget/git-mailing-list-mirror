Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D9C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 19:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJKTEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJKTE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 15:04:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408C82D35
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 12:04:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a17so7667080ilq.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8NzaQf/EAkhubz8de6VInm0Qao3bcwMm5qi4XdeJCs=;
        b=B1aBXBz4tkTL/xYimvQG/QudyMrQyW7IyCVmPhJItMA2OqmoOZ51fchF3P6CWvEKzL
         VQH8AnOwD0X8xmCnWOBcAty+TZKdQ60W7vVw7YT1Z6LfLvmrMtyw0ZgmXTOkdWinoVVg
         5fgBRkSA/TszC5zZHbD55BvQUlAeELrRJ3ysVe2ltZsFoBhNWRH9Q90Tja/fbFGzGZQw
         evbYIgjOpAWop+YE2rjSoV/pEPr+j+QMc9GvbPQviJeqOHX1ndeI8cb4yRlEWud+Cms9
         v77eQ816aU0/XHpnRO3BNDSXf8DTFv0hG/uipRyHwDouAaIHkkF0uRUDdg+32Xs0HUzZ
         6Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8NzaQf/EAkhubz8de6VInm0Qao3bcwMm5qi4XdeJCs=;
        b=iLBUEwNfE68i38HvIUaDBuWJt6mc9cZXKttjvwUwX7GIy9l3zbUKISdyN+k9DJDeSo
         do2pyjkqL8lobhRnIFRFFrV+ew8MOVuBIbHBY/GJHaN/oWHWn/EgLFdRIP7hf3PAxvhH
         jr/7dTETxEiwfcOD54tg10TJ3MGwSvja7GqyDavRYGZiPcdro2+WiP71C+gAhu9o5TTo
         W49CLnt+4/31y11cNgpLMfRxjhtXx2LpNfAeFufrkIH9KzZgxkgu5uyr7OpA178fktz4
         Hr5aYVmf9wNjhMbADIw+jclftBJPBQKQOq8Y4Sh9nJ0bGWaLRtMv75XggjKubiNTzlx3
         ClLQ==
X-Gm-Message-State: ACrzQf2K0bEcY5APTN9q/yqPCnsSPilOjgAISkTfkjQze1EzU16QO9Ws
        LUJVe47Iq4uEsRi4KpmJXVr+
X-Google-Smtp-Source: AMsMyM6/xjP3iA6UAax82ruQIpzxtasMm66+VuU7Ob+a6aox5KdXJ2SIYFc2yrk3LgsDou8EqkSzhQ==
X-Received: by 2002:a92:3652:0:b0:2df:4133:787 with SMTP id d18-20020a923652000000b002df41330787mr12976693ilf.39.1665515068228;
        Tue, 11 Oct 2022 12:04:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e093:47bc:eb8e:6fc7? ([2600:1700:e72:80a0:e093:47bc:eb8e:6fc7])
        by smtp.gmail.com with ESMTPSA id o42-20020a02742a000000b0035a9b0050easm5477281jac.18.2022.10.11.12.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:04:27 -0700 (PDT)
Message-ID: <d85704ef-97e8-57aa-9711-01d00b74d36e@github.com>
Date:   Tue, 11 Oct 2022 15:04:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 08/11] bundle: add flags to verify_bundle(), skip walk
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
 <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
 <83f2cd893a4c47c947a93fe99d202d67f540e963.1665417859.git.gitgitgadget@gmail.com>
 <xmqqbkqj4mj7.fsf@gitster.g>
 <08877824-b454-df37-1819-edee34919f95@github.com>
 <xmqqk05734kr.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk05734kr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2022 2:40 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> I've been going over the refs code multiple times today trying to
>> fix this "real" culprit, with no luck. I can share this interesting
>> point:
>>
>>  * The initial loop over the bundles tries to apply each, but the
>>    prerequisite objects are not present so we never reach the revision
>>    walk. A refs/bundle/* ref is added via update_ref().
>>
>>  * The second loop over the bundles tries to apply each, but the only
>>    bundle with its prerequisites present also finds the commits as
>>    reachable (this must be where the loose ref cache is populated).
>>    Then, a refs/bundle/* ref is added via update_ref().
>>
>>  * The third loop over the bundles finds a bundle whose prerequisites
>>    are present, but verify_bundle() rejected it because those commits
>>    were not seen from any ref.
>>
>> Other than identifying that issue, I was unable to track down exactly
>> what is happening here or offer a fix. I had considered inserting
>> more cache frees deep in the refs code, but I wasn't sure what effect
>> that would have across the wider system.
> 
> OK.  That certainly is understandable.
> 
> As a comment in the proposed log message that BUNDLE_SKIP_REACHABLE
> bit is a band aid papering over a problem we punted in this series,
> to guide future developers, I think what you wrote is sufficient.
> We do not want them to think that skipping the check is our
> preferred longer term solution and add their own hack to keep
> skipping the check when they resolve "the real culprit".

I have discovered the real culprit, and my expectation was incorrect
about the loose ref cache. The key issue was that I was looking at
this loop:

	i = req_nr;
	while (i && (commit = get_revision(&revs)))
		if (commit->object.flags & PREREQ_MARK)
			i--;

and noticing that only one commit was being visited. I was not 
seeing the actually-important commit. But it wasn't the revision
walk's fault. The loop was terminating because "i" was reaching
zero!

It turns out that verify_bundles() is not clearing the PREREQ_MARK
flag, so multiple runs would incorrectly hit this short-circuit
and terminate the walk early.

I'll replace this patch with the correct fix soon.

Thanks,
-Stolee
