Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9271FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdDFUm0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:42:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:56175 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbdDFUmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:42:25 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9772F8465D;
        Thu,  6 Apr 2017 16:42:23 -0400 (EDT)
Subject: Re: [PATCH v5 3/4] test-strcmp-offset: created test for strcmp_offset
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170405173809.3098-1-git@jeffhostetler.com>
 <20170405173809.3098-4-git@jeffhostetler.com>
 <4da78dff-7caa-b560-8af9-f5a3dfc0bed2@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0b27bff5-53a1-51f3-aeb4-6bd7bcd6fddc@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 16:42:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4da78dff-7caa-b560-8af9-f5a3dfc0bed2@web.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 4:20 PM, René Scharfe wrote:
> Am 05.04.2017 um 19:38 schrieb git@jeffhostetler.com:
>> diff --git a/t/helper/test-strcmp-offset.c
>> b/t/helper/test-strcmp-offset.c
>> new file mode 100644
>> index 0000000..fe01318
>> --- /dev/null
>> +++ b/t/helper/test-strcmp-offset.c
>> @@ -0,0 +1,64 @@
>> +#include "cache.h"
>> +
>> +struct test_data {
>> +    const char *s1;
>> +    const char *s2;
>> +    int first_change;
>> +};
>> +
>> +static struct test_data data[] = {
>> +    { "abc", "abc", 0 },
>> +    { "abc", "def", 0 },
>> +
>> +    { "abc", "abz", 2 },
>> +
>> +    { "abc", "abcdef", 3 },
>> +
>> +    { "abc\xF0zzz", "abc\xFFzzz", 3 },
>> +
>> +    { NULL, NULL, 0 }
>> +};
>> +
>> +int try_pair(const char *sa, const char *sb, int first_change)
>
> This should be static, right?  Found with -Wmissing-prototypes.

right.  thanks.

>
>> +{
>> +    int failed = 0;
>> +    int offset, r_exp, r_tst;
>> +    int r_exp_sign, r_tst_sign;
>> +
>> +    /*
>> +     * Because differnt CRTs behave differently, only rely on signs
>
> s/differnt/different/
>
> René
