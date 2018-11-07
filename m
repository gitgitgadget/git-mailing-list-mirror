Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8561F453
	for <e@80x24.org>; Wed,  7 Nov 2018 17:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbeKHDN3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 22:13:29 -0500
Received: from avasout02.plus.net ([212.159.14.17]:34837 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbeKHDN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 22:13:28 -0500
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id KRq5gpTWbx6b6KRq6gwIjK; Wed, 07 Nov 2018 17:42:02 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=T4GiscCQ c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=SnVoAwUXBb1ntHrAojoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
 <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com>
Date:   Wed, 7 Nov 2018 17:42:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGB/aBo6mTYoGP8D/hOA4/iyh4zCKV0ZnALnUjUh4ztJgXkSVbeQxLYLAQPqsJXbPVVnuu91StzXOoMJ+kvKsexDhupfjpB3bfAIYbZKDTGDYYkHerRf
 FFV92LTbYKlSp+rrkqV79JmY5FLQ6dP8NImhlYp9ylLUB7O9tGN2N+ZMsGcVH11SmL7fA+mfTXaORA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/11/2018 11:19, Johannes Schindelin wrote:
[snip]
>>> Hmm, this doesn't quite fit with the intended use of this
>>> function! ;-) (even on windows!)
>>>
>>> I haven't looked very deeply, but doesn't this affect all
>>> absolute paths in the config read by git_config_pathname(),
>>> along with all 'included config' files?
>>
>> I think so.  I have not thought things through to say if replacing a
>> "full path in the current drive" with system_path() is a sensible
>> thing to do in the first place, but I am getting the impression from
>> review comments that it probably is not.
>>
>>> I am pretty sure that I would not want the absolute paths
>>> in my config file(s) magically 'moved' depending on whether
>>> git has been compiled with 'runtime prefix' support or not!
> 
> The cute thing is: your absolute paths would not be moved because we are
> talking about Windows. Therefore your absolute paths would not start with
> a forward slash.

Ah, sorry, I must have misunderstood a comment in your cover letter:

    The reason is this: something like this (make paths specified e.g. via 
    http.sslCAInfo relative to the runtime prefix) is potentially useful
    also in the non-Windows context, as long as Git was built with the
    runtime prefix feature.

... so I thought you meant to add this code for POSIX systems as well.

My mistake. :(

ATB,
Ramsay Jones


