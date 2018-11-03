Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626DB1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 14:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeKCXRX (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 19:17:23 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:3472 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeKCXRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 19:17:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42nLM74f37z5tmV;
        Sat,  3 Nov 2018 15:05:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A851A2AAC;
        Sat,  3 Nov 2018 15:05:54 +0100 (CET)
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around
 issues
To:     Carlo Arenas <carenas@gmail.com>
Cc:     shoelzer@gmail.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.64.git.gitgitgadget@gmail.com>
 <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
 <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
 <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
 <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org>
Date:   Sat, 3 Nov 2018 15:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.11.18 um 09:14 schrieb Carlo Arenas:
> On Fri, Nov 2, 2018 at 9:44 AM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> +      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout - elapsed);
> 
> nitpick: cast to DWORD instead of int

No; timeout is of type int; after an explicit type cast we don't want to 
have another implicit conversion.

-- Hannes
