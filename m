Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9095220248
	for <e@80x24.org>; Tue, 19 Mar 2019 18:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCSSDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 14:03:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:12160 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfCSSDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 14:03:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 85D7D3F4013;
        Tue, 19 Mar 2019 14:03:33 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5BF9E3F4012;
        Tue, 19 Mar 2019 14:03:33 -0400 (EDT)
Subject: Re: [PATCH v2 1/1] trace2: NULL is not allowed for va_list
To:     tboegi@web.de, git@vger.kernel.org, jeffhost@microsoft.com,
        mwelinder@gmail.com
References: <20190316104616.27085-1-tboegi@web.de>
 <20190319171347.7677-1-tboegi@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1899eb63-c986-6c18-d09e-9b1584f471d0@jeffhostetler.com>
Date:   Tue, 19 Mar 2019 14:03:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190319171347.7677-1-tboegi@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/19/2019 1:13 PM, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
> 
> Some compilers don't allow NULL to be passed for a va_list,
> and e.g. "gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516"
> errors out like this:
>   trace2/tr2_tgt_event.c:193:18:
>     error: invalid operands to binary &&
>     (have ‘int’ and ‘va_list {aka __va_list}’)
>      if (fmt && *fmt && ap) {
>                         ^^
> I couldn't find any hints that va_list and pointers can be mixed,
> and no hints that they can't either. Morten Welinder comments:
> 
> "C99, Section 7.15, simply says that va_list "is an object type suitable for
> holding information needed by the macros va_start, va_end, and
> va_copy". So clearly not guaranteed to be mixable with pointers...
> 
> The portable solution is to use "va_list" everywhere in the callchain.
> As a consequence, both trace2_region_enter_fl() and trace2_region_leave_fl()
> now take a variable argument list.
> 
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>

Looks good.  Thanks for tracking this down.
Jeff


Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
