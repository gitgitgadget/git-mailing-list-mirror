Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E25C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAB723A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 13:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgLRNBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 08:01:55 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:37516 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgLRNBz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 08:01:55 -0500
Received: from client3368.fritz.box (i5C747512.versanet.de [92.116.117.18])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id A39F73C01D9;
        Fri, 18 Dec 2020 14:01:11 +0100 (CET)
Subject: Re: [PATCH v2] git-gui: use gray background for inactive text widgets
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     serg.partizan@gmail.com, git@vger.kernel.org
References: <55348fbb-95bb-1dd2-4e17-4fc622ae7603@haller-berlin.de>
 <20201124212333.80040-1-stefan@haller-berlin.de>
 <20201217214912.ycp7bidcyqwzslxy@yadavpratyush.com>
 <63356203-8af0-64e5-4694-f47d31bcdee6@haller-berlin.de>
 <20201218125025.gj277jwxrblqp45b@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <90975583-17ad-0d53-5919-fe1c8400291c@haller-berlin.de>
Date:   Fri, 18 Dec 2020 14:01:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201218125025.gj277jwxrblqp45b@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.12.20 13:50, Pratyush Yadav wrote:
> On 17/12/20 11:14PM, Stefan Haller wrote:
>> On 17.12.20 22:49, Pratyush Yadav wrote:
>>> Hi,
>>>
>>> On 24/11/20 10:23PM, Stefan Haller wrote>>>> +proc convert_rgb_to_gray {rgb} {
>>>> +	# Simply take the average of red, green and blue. This wouldn't be good
>>>> +	# enough for, say, converting a photo to grayscale, but for this simple
>>>> +	# purpose of approximating the brightness of a color it's good enough.
>>>> +	lassign [winfo rgb . $rgb] r g b
>>>
>>> Is there no simpler way to extract r, g, and b? This is a little cryptic 
>>> to be honest.
>>
>> Actually, I find this pretty elegant, and from what I have seen, it's
>> idiomatic Tcl. A less cryptic way would be (untested):
>>
>>   set components [winfo rgb . $rgb]
>>   set r [lindex $components 0]
>>   set g [lindex $components 1]
>>   set b [lindex $components 2]
>>
>> But I much prefer the one-line version.
> 
> I agree. Using lassign is much neater. But that is not my point. I am 
> talking about the "[winfo rgb . $rgb]". This call generates the list 
> that is then assigned to the 3 variables. This part is a little cryptic. 
> Is there no simpler way to separate out the r, g, and b values?
According to the winfo man page this is the only way to do this;
see [1].

Instead of the lassign, you can also do

  foreach {r g b} [winfo rgb . $rgb] {}

but I don't think that's better.

-Stefan


[1] https://www.tcl.tk/man/tcl8.6/TkCmd/winfo.htm
