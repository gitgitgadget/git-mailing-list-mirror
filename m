Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A941FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756467AbcLSUyW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:54:22 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:37169 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756424AbcLSUyS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:54:18 -0500
Received: by mail-it0-f44.google.com with SMTP id y23so93935978itc.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 12:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0HMlMuy8+5HEXWaLn3oJRNt3d/1lXmjljnjd8UcfJn4=;
        b=BrU0m1f0ZmMilpqNqxvjlmldG7e1QduFjmDeQWuCztiLeYubKRoq7gBvjx8BaYGSsr
         xVzEH7g1VPQfQ2pIk0lCi08eB7Ak3yUdp/uVmJO8gM1cvDr38sIWcMwdRKFCSP+I2r5I
         PYey/rGBKosIDva4PUdodGnOatr1bjMV6ww8CQxlprys/og4U2el3YPfIfAIe2e5Pzxt
         fpUFizCCmNGysQxtk1qg91I5chnTATJ9xVi16TDjvcgy8eQffNyhr57dW5Zru3lkLDoL
         N8drE5V/3dMFr3zsrR+5a8UcPzGE0uTUAw2KS0Z4ziRPvbbf/LjohTdP96/spbeaZ9h5
         OYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0HMlMuy8+5HEXWaLn3oJRNt3d/1lXmjljnjd8UcfJn4=;
        b=f+vT02XBMb5Oa3ospBDA59NFbl5BspLTAN8KMAIq5+xBYuV+tU5LKjS+lHlDb/dYqz
         N9bLJEoN8AVhvHI/c17ADBWPDCYoDo/rsFQLQh3HG12H6EDr5xuq3OSOgAYDVjwdIFpN
         Sn6GB4ZcHQ8jheJu+cIXG01gdz9BGlZnsGcHn9WouTuBgKXCSphnwKfvx40iQC2khfB5
         pfaOL6OZ3ShZpEgNdl4lIeQTHm73XjrE0mwIim7CdOfOLvCRZURsVF9N7n/j7Rv7QcHz
         6AmyTccXbu0veuqGMqL7MqS7lJVE2KIP6D4o5/9moJrhcK5F3uYK6Na17VvRJVddX18H
         4SAg==
X-Gm-Message-State: AIkVDXIliQi1lfvggL2b6PA6+ueilCX3hp676XmMJ8XdXGFd/mOM9I5fiEZpSbT71TOF2b70
X-Received: by 10.36.44.10 with SMTP id i10mr6279129iti.27.1482180857644;
        Mon, 19 Dec 2016 12:54:17 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:2c8a:32a7:daa8:556d])
        by smtp.gmail.com with ESMTPSA id f75sm1415442ita.13.2016.12.19.12.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 12:54:16 -0800 (PST)
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
To:     "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
 <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
 <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <d5690ac7-ff62-99b9-7e7e-929bd7f0433b@google.com>
Date:   Mon, 19 Dec 2016 12:54:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2016 12:38 PM, Kyle J. McKay wrote:
> On Dec 19, 2016, at 12:03, Jeff King wrote:
>
>> On Sat, Dec 17, 2016 at 11:54:18AM -0800, Kyle J. McKay wrote:
>>
>>> Since 6b4b013f18 (mailinfo: handle in-body header continuations,
>>> 2016-09-20, v2.11.0) mailinfo.c has contained new code with an
>>> assert of the form:
>>>
>>>     assert(call_a_function(...))

Thanks for spotting this - I'm not sure how I missed that.

>> This is obviously an improvement, but it makes me wonder if we should be
>> doing:
>>
>>  if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data))
>>     die("BUG: some explanation of why this can never happen");
>>
>> which perhaps documents the intended assumptions more clearly. A comment
>> regarding the side effects might also be helpful.
>
> I wondered exactly the same thing myself.  I was hoping Jonathan would
> pipe in here with some analysis about whether this is:
>
>   a) a super paranoid, just-in-case, can't really ever fail because by
> the time we get to this code we've already effectively validated
> everything that could cause check_header to return false in this case
>
> -or-
>
>   b) Yeah, it could fail in the real world and it should "die" (and
> probably have a test added that triggers such death)
>
> -or-
>
>   c) Actually, if check_header does return false we can keep going
> without problem
>
> -or-
>
>   d) Actually, if check_header does return false we can keep going by
> making a minor change that should be in the patch
>
> I assume that since Jonathan added the code he will just know the answer
> as to which one it is and I won't have to rely on the results of my
> imaginary analysis.  ;)

The answer is "a". The only time that mi->inbody_header_accum is 
appended to is in check_inbody_header, and appending onto a blank 
mi->inbody_header_accum always happens when is_inbody_header is true 
(which guarantees a prefix that causes check_header to always return true).

Peff's suggestion sounds reasonable to me, maybe with an error message 
like "BUG: inbody_header_accum, if not empty, must always contain a 
valid in-body header".
