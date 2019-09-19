Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59CCD1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfISSkK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 14:40:10 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59330 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbfISSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 14:40:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46Z5Hq4517z5tlF;
        Thu, 19 Sep 2019 20:40:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C7A8110A;
        Thu, 19 Sep 2019 20:40:06 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] ls-remote: create '--count' option
To:     =?UTF-8?Q?Kamil_Doma=c5=84ski?= <kamil@domanski.co>
Cc:     git@vger.kernel.org
References: <20190918001134.20776-1-kamil@domanski.co>
 <f643547f-54e0-fe4f-d8e5-95445431faf3@kdbg.org>
 <21455bdb-431e-2842-0618-2f36a18bb60e@domanski.co>
Message-ID: <c839c38e-00ac-a1de-a246-8e92f16cfb4a@kdbg.org>
Date:   Thu, 19 Sep 2019 20:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <21455bdb-431e-2842-0618-2f36a18bb60e@domanski.co>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.09.19 um 23:44 schrieb Kamil Domański:
> On 9/18/19 8:28 AM, Johannes Sixt wrote:
>> Am 18.09.19 um 02:11 schrieb Kamil Domański:
>>>     DESCRIPTION
>>>   -----------
>>> @@ -21,6 +21,11 @@ commit IDs.
>>>     OPTIONS
>>>   -------
>>> +--count=<count>::
>>> +    By default the command shows all refs that match
>>> +    `<pattern>`.  This option makes it stop after showing
>>> +    that many refs.
>> Is the meaning of this option perhaps:
>>
>>      Stops after the specified count of refs have been listed.
>>      If `--sort=<key>` is specified as well, refs are counted
>>      after sorting; otherwise, it is unspecified which subset
>>      of is listed.
> 
> Similarly, I merely copied the description used by 'for-each-ref'. I
> like your version as well, since it clarifies the relation to sorting.
> Should the description for 'for-each-ref' be changed as well then?

I am neutral. If you do it, then it should not happen in the same patch
as this change.

> ... it appears that 'for-each-ref' defaults to sorting
> by 'refname' (through ref_default_sorting() ) if no alternative sorting
> is provided, while 'ls-remote' does no such defaulting. Do you figure it
> would be a good idea to add another patch which would introduce a
> similar default in 'ls-remote'?

I don't think so. I would think that in the case of ls-remote it is
preferable to stream refs to the output as soon as they are received
from the remote. If refs must be sorted, it would have to wait until the
remote has sent all refs before it can do anything.

That said, Junio's question remains open: why is piping though head -n
not good enough?

-- Hannes
