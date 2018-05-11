Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E251F406
	for <e@80x24.org>; Fri, 11 May 2018 18:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeEKSXq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:23:46 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:61638 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKSXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:23:45 -0400
Received: from [192.168.2.201] ([92.22.23.119])
        by smtp.talktalk.net with SMTP
        id HChif64UY3fRRHChifVZcS; Fri, 11 May 2018 19:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1526063023;
        bh=y/ZdZqmGh0D1pkYvNi6VtWIDUmM/4ZHyOR6gQQEsmDg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GGrjTrvgfDhrbrCpJ6U/Xxp7dFdLRbFscXco8cku/5hgYCax6mCyh/MSEzJz9+0Xq
         J/Eptpc+s1UX+QR+0ayOuvhEABPboYi8vhoHU4v82eVTGWFA4/4qVW3u2xqm2NkO5b
         CSZsaMM4y5rgOMn+UrbGRuWaafZ+9CUKUjtXUN5Q=
X-Originating-IP: [92.22.23.119]
X-Spam: 0
X-OAuthority: v=2.3 cv=YZWTGTZf c=1 sm=1 tr=0 a=oWXjcmuSLv9+fGSLdn2kqg==:117
 a=oWXjcmuSLv9+fGSLdn2kqg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=uZvujYp8AAAA:8 a=k-0LSMOti-lfaR3_u0EA:9 a=QEXdDO2ut3YA:10 a=YC1BiALGhb4A:10
 a=SLzB8X_8jTLwj6mN0q5r:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Oliver Joseph Ash <oliverjash@gmail.com>, git@vger.kernel.org,
        martin.agren@gmail.com, mqudsi@neosmart.net,
        phillip.wood@dunelm.org.uk
References: <be321106-2f10-e678-8237-449d2dd30fee@talktalk.net>
 <20180510141125.21677-1-oliverjash@gmail.com>
 <e8aedc6b-5b3e-cfb2-be9d-971bfd9adde8@talktalk.net>
 <xmqqzi16hpr4.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9a7d35c7-2889-05e4-f6f3-5706c710d327@talktalk.net>
Date:   Fri, 11 May 2018 19:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi16hpr4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHlYxPZOXaZqmqndh/RMJVqFuRsi/0jlBktcL/BEo4T3TZKN65PUsTFmDPhoYoJQTWcqI96L/LzxWKRVLhFeXKfqAWLCKZRoSIgrtzorex2o3Xkw+y9e
 9EIZEN/pEiG+fdf9HlHR1abb/NZpsIyFZL0dcAis2rH7T88XiUpljsWpPkQX2MT5+tytlDHyqKXrUiJHe50eNtBrJf3sbQmN3XZgQVoqU2mBXcwviEBS0b33
 ao+niMlGrNQ1jI/bKoEro5zDfd/lt0vfgJ6vLeGaHkFumCa2lY/oKpMRQVPZZO7lzud8CDSjKt6qxYgFsSreD6qj/U4puaWN+CRAGV/tPnU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05/18 03:47, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> Yes, I think it probably makes sense to do that. Originally I didn't
>> count empty lines as context lines in case the user accidentally added
>> some empty lines at the end of the hunk but if 'git apply' does then I
>> think 'git add -p' should as well
> 
> I am not sure if "adding to the tail" should be tolerated, but in
> any case, newer GNU diff can show an empty unaffected line as an
> empty line (unlike traditional unified context format in which such
> a line is expressed as a line with a lone SP on it), which is
> allowed as "implementation defined" by POSIX.1 [*1*]. Modern "git
> apply" knows about this.

Thanks for the reference, I hadn't realized the space was optional.

> If "add -p" parses a patch, it should learn to do so, too.

I'm about to go off line for a while, I'll send a fix when I'm back up
and running at next month (unfortunately the reroll of pw/add-p-select
will have to wait until then as well)

Best Wishes

Phillip


> 
> [Reference]
> 
> *1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
> 
>>
>>> Meanwhile, I can easily configure my editor not to do this for `*.diff` files.
>>>
>>> Thanks for your help, Phillip and Martin!
>>
>> Thanks for posting an example so we could test it, it makes it much
>> easier to track the problem down
>>
>> Best Wishes
>>
>> Phillip
>>
>>> Mahmoud, does this also explain your problem as per your original post?
>>>

