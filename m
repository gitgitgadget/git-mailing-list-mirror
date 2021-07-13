Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A75C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7C961026
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhGMQsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:48:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:60286 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGMQsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 12:48:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AAFE53F40B7;
        Tue, 13 Jul 2021 12:45:23 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C10C3F4047;
        Tue, 13 Jul 2021 12:45:23 -0400 (EDT)
Subject: Re: [PATCH v3 23/34] t/helper/test-touch: add helper to touch a
 series of files
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <3cf8f3cd7717dad69262ae884a89c1a6ca0ce5fc.1625150864.git.gitgitgadget@gmail.com>
 <xmqqsg0xreht.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <58eee2a1-3fbd-e03e-2079-0d654f4b7e1f@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 12:45:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg0xreht.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 4:00 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/t/helper/test-touch.c b/t/helper/test-touch.c
>> new file mode 100644
>> index 00000000000..e9b3b754f1f
>> --- /dev/null
>> +++ b/t/helper/test-touch.c
>> @@ -0,0 +1,126 @@
>> +/*
>> + * test-touch.c: variation on /usr/bin/touch to speed up tests
>> + * with a large number of files (primarily on Windows where child
>> + * process are very, very expensive).
>> + */
>> +
>> +#include "test-tool.h"
>> +#include "cache.h"
>> +#include "parse-options.h"
>> +
>> +char *seq_pattern;
>> +int seq_start = 1;
>> +int seq_count = 1;
> 
> With this in, "make sparse" dies like this:
> 
>      SP t/helper/test-touch.c
> t/helper/test-touch.c:11:6: error: symbol 'seq_pattern' was not declared. Should it be static?
> t/helper/test-touch.c:12:5: error: symbol 'seq_start' was not declared. Should it be static?
> t/helper/test-touch.c:13:5: error: symbol 'seq_count' was not declared. Should it be static?
> 

I'll fix.  Thanks!
Jeff
