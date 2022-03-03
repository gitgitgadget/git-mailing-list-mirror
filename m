Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB821C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiCCQlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiCCQlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:41:22 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9C19D604
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:40:36 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EF5043F4836;
        Thu,  3 Mar 2022 11:40:35 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AAC863F4802;
        Thu,  3 Mar 2022 11:40:35 -0500 (EST)
Subject: Re: [PATCH 17/23] fsmonitor--daemon: stub in health thread
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4a77f5b1fdef3af20fbfefccccc5fee194eb3422.1644940774.git.gitgitgadget@gmail.com>
 <4c784936-7b70-3910-6413-0438e86b23c4@github.com>
 <f9249541-bb92-1c61-825f-44a034a17bb8@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <47e413dd-e748-a698-8c69-d24c8137fc1a@jeffhostetler.com>
Date:   Thu, 3 Mar 2022 11:40:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f9249541-bb92-1c61-825f-44a034a17bb8@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 11:15 AM, Derrick Stolee wrote:
> On 2/24/2022 11:04 AM, Derrick Stolee wrote:
>> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Create another thread to watch over the daemon process and
>>> automatically shut it down if necessary.
>>>
>>> This commit creates the basic framework for a "health" thread
>>> to monitor the daemon and/or the file system.  Later commits
>>> will add platform-specific code to do the actual work.
>>
>> ...
>>
>>> diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
>>> new file mode 100644
>>> index 00000000000..b9f709e8548
>>> --- /dev/null
>>> +++ b/compat/fsmonitor/fsm-health-darwin.c
>>> @@ -0,0 +1,24 @@
>>> +#include "cache.h"
>>> +#include "config.h"
>>> +#include "fsmonitor.h"
>>> +#include "fsm-health.h"
>>> +#include "fsmonitor--daemon.h"
>>> +
>>> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
>>> +{
>>> +	return;
>>> +}
>>> +
>>> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
>>> +{
>>> +	return;
>>> +}
>>> +
>>> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
>>> +{
>>> +}
>>
>> The macOS implementation is stubbed, as advertised.
> 
> After looking at the rest of the patch series, it seems that these
> are never filled in. Are some of the win32 health monitors also
> appropriate for macOS? (They would need platform-specific checks,
> probably.)
> 
> Thanks,
> -Stolee
> 
