Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B901F405
	for <e@80x24.org>; Thu,  9 Aug 2018 10:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeHIMcw (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 08:32:52 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:41925 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHIMcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 08:32:52 -0400
Received: from [192.168.2.201] ([92.22.29.155])
        by smtp.talktalk.net with SMTP
        id nhs0fl5KJoI6Lnhs0f1n0Y; Thu, 09 Aug 2018 11:08:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533809321;
        bh=lND0IgESKQXZdBppvTAO/HY5Eo9ch3AlHfifLJ8usxM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iJpB2XnnfGS9Obp/VAnXLW9GWlFjCFBQ0a+f6ZX5+RBuKVtva54Dyd1U/6x6ZRbc7
         Sr+V9SvVJPfWkkjj4v8Abx3fJcLXLXb5AQ0DXZQLpXQpmBTRadIsAlEX7aB3Asp9zY
         u5Q5PSiouXcId4YcWNuyNG/kq8lIW1t1YPBr1AxA=
X-Originating-IP: [92.22.29.155]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=yeAZMs3+wWQh+Rh+YWy7CA==:117
 a=yeAZMs3+wWQh+Rh+YWy7CA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=_cZgjSQYg3PRpSYNrWQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net>
 <20180807093452.22524-3-phillip.wood@talktalk.net>
 <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com>
 <753b860e-c922-fd70-9d2d-0581976a6f37@talktalk.net>
 <CAPig+cQdH+Xiunej1E6EnA6btFzZJTPo27cFY_UdaFZF7J7t-w@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <da635ab4-9175-18aa-ffae-91c4ee8229ec@talktalk.net>
Date:   Thu, 9 Aug 2018 11:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cQdH+Xiunej1E6EnA6btFzZJTPo27cFY_UdaFZF7J7t-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHdI19xyISZRkz1x5257UWSQfWjtMcsWrQCNjA2DuObAzz9Sr/jm5+d8nwymQKdpeXMhwPWfU1AglZr1goFU6QbfSTeif02jyizKu6XLClxyZZ/srLEy
 CVFUFW/sd4krc11+QjHb0yL1FWaUCZzWDzkpJMZcMcrSTWbBdq2gNpb9zZ2bleuk4IS3UFnXFjyGGKaUn9/Ih36PoeccjFAiewkTuTymD0FnMM6GKM2eADJZ
 F+Q2PRC+dHeiGJ0/x50McfQW/njHwB6eD99Q98j70Ia2aGZFfDagJanbdW/Q+94JjJhihf5Vtecqn8626clERQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 08/08/18 09:43, Eric Sunshine wrote:
> On Tue, Aug 7, 2018 at 9:54 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> On 07/08/18 11:23, Eric Sunshine wrote:
>>> On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>>> +       if (n > 0 && s[n] != '\'')
>>>> +               return 1;
>>>
>>> To be "technically correct", I think the condition in the 'if'
>>> statement should be ">=". It should never happen in practice that the
>>> entire content of the file is a single character followed by zero or
>>> more newlines, but using the proper condition ">=" would save future
>>> readers of this code a "huh?" moment.
>>
>> I'm not sure it is that simple. If the script consists solely of a
>> single quote then we should return 1, if it is a single character that
>> is not "'" then it should return 0. Currently it returns 0 in both those
>> cases so is technically broken when the script is "'". If it used ">="
>> instead then I think it would return 0 when it should return 1 and vice
>> versa. As you say this shouldn't happen in practice.
> 
> It shouldn't happen in practice, but if a human (power user) edits
> this file, we shouldn't discount the possibility. However, I'm not so
> concerned about quoting_is_broken() returning a meaningful answer in
> this case since we have much bigger problems if we get such a file.
> (Indeed, what answer could quoting_is_broken() return which would be
> useful or meaningful for such a malformed file?)
> 
> What does concern me is that read_env_script() doesn't seem to care
> about such a malformed file; it doesn't do any validation at all.
> Contrast that with read_author_ident() which is pretty strict about
> the content it expects to find in the file. So, it might make sense to
> upgrade read_env_script() to do some sort of validation on each line
> (though that shouldn't be in this patch, and doesn't even need to be
> in this series). For instance, it could check that each line looks
> something like what would be matched by this regex: /[A-Z0-9_]+='.+'/

I think it should just share some code with get_author_ident() that uses
sq_dequote(), that's for another day though.

> (And, no, I'm not saying that regex should be used for validation; I'm
> just using it as an example.)
> 
> As for '>' vs. '>=', it caused more than a slight hiccup when I was
> scanning the code, and I worry that future readers could be similarly
> impacted.

I don't have a strong opinion either way, if Junio wants to fix it up
I'd be happy with that, but I'm not keen on another iteration just for that.

Best Wishes

Phillip


