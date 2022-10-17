Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FFC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 09:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiJQJuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQJuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 05:50:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B21928D
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 02:49:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l22so15209638edj.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoyHvjtoZ++NqR5Qdn2RSnISuYfEbYcQl9kKybbP1mA=;
        b=QxsjveH+VpWuOeknzZM4HqNxCEn+EokX3AiR8REdM+y7ckSU3nAtuOn2qBacNI+4AY
         A3DvZPJiJ4YrbPjOvuZujqe8hCJtqnCk0onxAaAWbnZLbgm1OdfmkGT0b6lWexU1l5Rf
         lneWqgJ84TJBPMsDz+O8QuTvRYE0zDqd6iNPqn3a3jRHu47J0UQzP3moUFSZJX2QqdyO
         yPHkEULP18oC71SsrYcXjiXe3UGEJo+4UfhYyWB9LepXeaqkL+XWerwo5EaEECU6kCyP
         ZKA7vtshZAvkJgfwHVe/dJhjPPM0B0AfIdVX4QiX3hvVUz/USyJGUvtIJO5sVo3xPZrZ
         epFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoyHvjtoZ++NqR5Qdn2RSnISuYfEbYcQl9kKybbP1mA=;
        b=xSjHfVzCB82H4ukhGX++alcWM+mP7pRIzHzld7YVj7bsGQRvn3GG1bHczCjgvf26Tr
         TYBgfrUXt0+1d4d7FYV2YquhgRIH60vBmJ+giZx9WzUgOGeMgFRVQQsXnd3cbs4TlMin
         V2SrJDXyAhYGJo+NZVmIG8us4dEAPnljmA8MLSkrvo6nVShspZmQWgak6+nW6sdFhgsc
         pcpSf/vPzg8Dw0hgErwdopAbahtPFdCYMqS++1h3e228SMVEE+cVZcPHPFGRqKtQAJes
         K+3lZmqHrXbpS411rKBpT6wLnbB3tMAmrAdfzw4uD2vebQvLrFeCUpMGaydL+SEz398T
         DLxw==
X-Gm-Message-State: ACrzQf34RnsKXbMx/WcmRUSmW8gHLx/DL3FdFZbAH43rbiCaMp1zG4mi
        6jcbPHq3+euy+aumz4Zt998=
X-Google-Smtp-Source: AMsMyM4fQjscMdlxeYNQcO6liZHby5uyd1ajoN+X10sQoiPI5aUGHiYDwOGEzooLjDf0ROnMrIhaIQ==
X-Received: by 2002:a05:6402:3492:b0:45d:c00:ea8e with SMTP id v18-20020a056402349200b0045d0c00ea8emr9415192edc.150.1666000158898;
        Mon, 17 Oct 2022 02:49:18 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b00731582babcasm5816595ejh.71.2022.10.17.02.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 02:49:18 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7b9d2a05-de2e-d0e0-6554-a592fa2349d4@dunelm.org.uk>
Date:   Mon, 17 Oct 2022 10:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/8] rebase: rename merge_base to branch_base
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
 <221013.86bkqfleh5.gmgdl@evledraar.gmail.com>
In-Reply-To: <221013.86bkqfleh5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/2022 20:16, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> merge_base is not a very descriptive name, the variable always holds
>> the merge-base of 'branch' and 'onto' which is commit at the base of
>> the branch being rebased so rename it to branch_base.
> 
> To me "branch" means or has heavier implications of "named branch" than
> just a merge base, and this command is perfectly happy to work on
> commits disconnected from any named branch.
> > But more to the point, the rebase docs for --onto discuss a "merge
> base", so you'd read those, and then encounter this code talking about a
> "branch base", and wonder what the difference was...

Aren't the docs saying the merge base is the base of the commits (i.e. 
branch) being rebased? I don't think merge_base is a particularly 
helpful name as it doesn't tell us what it is the merge base of and 
branch_base was the best I could come up with. I see what you mean in 
the detached HEAD case, but as the command also works with named 
branches I hope it is fairly obvious what "branch_base" is in the 
detached HEAD case.

Best Wishes

Phillip
