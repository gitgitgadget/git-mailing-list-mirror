Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91832023D
	for <e@80x24.org>; Mon, 22 May 2017 20:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757504AbdEVUTD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 16:19:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:46887 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdEVUTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 16:19:02 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wWqkF0Q3Fz5tlG;
        Mon, 22 May 2017 22:19:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id ADF694327;
        Mon, 22 May 2017 22:19:00 +0200 (CEST)
Subject: Re: [PATCH v3] ref-filter: trim end whitespace in subject
To:     Jeff King <peff@peff.net>
Cc:     DOAN Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        animi.vulpis@gmail.com, gitster@pobox.com, git@grubix.eu,
        pclouds@gmail.com, karthik.188@gmail.com
References: <20170522145753.83810-1-congdanhqx@gmail.com>
 <20170522171014.33384-1-congdanhqx@gmail.com>
 <777c63ed-c1e3-8efd-48cd-91ac2a841631@kdbg.org>
 <20170522195334.eoj4u4nxupyl6dho@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f717824b-3527-251b-bc3f-835f12703698@kdbg.org>
Date:   Mon, 22 May 2017 22:19:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170522195334.eoj4u4nxupyl6dho@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.05.2017 um 21:53 schrieb Jeff King:
> On Mon, May 22, 2017 at 09:47:59PM +0200, Johannes Sixt wrote:
> 
>> Am 22.05.2017 um 19:10 schrieb DOAN Tran Cong Danh:
>>> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
>>> index 5778c0afe..fa4441868 100755
>>> --- a/t/t3203-branch-output.sh
>>> +++ b/t/t3203-branch-output.sh
>>> @@ -13,7 +13,8 @@ test_expect_success 'make commits' '
>>>    test_expect_success 'make branches' '
>>>    	git branch branch-one &&
>>> -	git branch branch-two HEAD^
>>> +	git branch branch-two $(printf "%s\r\n" one " " line3_long line4 |

I didn't notice earlier that there is a blank between the dq here.

>>> +	     git commit-tree HEAD:)
>>>    '
>>>    test_expect_success 'make remote branches' '
>>>
>>
>> This updated test shows nothing, I am afraid: If I apply only this change
>> without the rest of the patch, then all test in t3203 still pass. And I do
>> not see how the code change could make any difference at all. What am I
>> missing?

And I didn't look carefully enough at t3203. Some tests do check branch 
-v output.

> 
> It does for me here on Linux; I wonder if the CRs are being eaten by the
> shell expansion.

And I tested on Linux, too, but on the wrong branch. On a branch closer 
to master I see a failure as well. Sorry for the noise.

There are no CRs on the command line, BTW, only on stdin of commit-tree.

-- Hannes
