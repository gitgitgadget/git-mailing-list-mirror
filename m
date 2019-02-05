Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844E41F453
	for <e@80x24.org>; Tue,  5 Feb 2019 20:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfBEUWr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 15:22:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:34932 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBEUWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 15:22:47 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D1FB63F4020;
        Tue,  5 Feb 2019 15:22:45 -0500 (EST)
Received: from [IPv6:2001:4898:6808:13e:8d04:4166:3409:fa6a] (unknown [IPv6:2001:4898:8010:2:7638:4166:3409:fa6a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 99F023F401C;
        Tue,  5 Feb 2019 15:22:45 -0500 (EST)
Subject: Re: [PATCH] trace2: fix hdr-check warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ba0549c5-25f1-efcc-e49a-d7e76be73fe3@ramsayjones.plus.com>
 <00e08dc3-a610-0429-e819-1d29d0ddb81a@jeffhostetler.com>
 <d680fda2-7e54-2200-cd00-97772de45b47@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d91d1d89-5759-2006-7b38-4211db5988af@jeffhostetler.com>
Date:   Tue, 5 Feb 2019 15:22:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d680fda2-7e54-2200-cd00-97772de45b47@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/4/2019 2:44 PM, Ramsay Jones wrote:
> 
> 
> On 30/01/2019 12:29, Jeff Hostetler wrote:
>>
>>
>> On 1/26/2019 4:07 PM, Ramsay Jones wrote:
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>> ---
>>>
>>> Hi Jeff,
>>>
>>> If you need to re-roll your 'jh/trace2' branch, could you please
>>> squash this into the relevant patches (sorry, I didn't look to
>>> see which patches need to be modified).
>>
>> Will do. Thanks.
>>
>> BTW, how do you find these?  I ran both "make sparse" and
>> "make DEVELOPER=1" and it didn't complain about these items.
> 
> Carlo already replied about 'make hdr-check', but you seem to
> have missed squashing half of the original patch, since the
> re-rolled series still causes 'make -k hdr-check >phcout 2>&1'
> to show:
> 
>    $ diff nhcout phcout
>    22a23,34
>    >     HDR trace2/tr2_dst.h
>    >     HDR trace2/tr2_cfg.h
>    >     HDR trace2/tr2_tgt.h
>    >     HDR trace2/tr2_cmd_name.h
>    >     HDR trace2/tr2_sid.h
>    >     HDR trace2/tr2_tls.h
>    > trace2/tr2_tls.h:12:16: error: field ‘thread_name’ has incomplete type
>    >   struct strbuf thread_name;
>    >                 ^~~~~~~~~~~
>    > Makefile:2739: recipe for target 'trace2/tr2_tls.hco' failed
>    > make: *** [trace2/tr2_tls.hco] Error 1
>    >     HDR trace2/tr2_tbuf.h
>    131c143
>    < Makefile:2725: recipe for target 'sha256/gcrypt.hco' failed
>    ---
>    > Makefile:2739: recipe for target 'sha256/gcrypt.hco' failed
>    164a177
>    >     HDR trace2.h
>    $
> 
> So, quoting the last part of the original patch:
> 
> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index 99ea9018ce..bb80e3f8e7 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -1,6 +1,8 @@
>   #ifndef TR2_TLS_H
>   #define TR2_TLS_H
>   
> +#include "strbuf.h"
> +
>   /*
>    * Arbitry limit for thread names for column alignment.
>    */
> 

Yes, it appears I missed one.  I'll add it if I re-roll this.
(I hate to send a whole new version for one line.)

Thanks
Jeff
