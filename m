Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E11D20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 14:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbeLJOnM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 09:43:12 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:20501 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJOnL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 09:43:11 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id WMm4gmwGRAGVrWMm4gsoDt; Mon, 10 Dec 2018 14:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1544452989;
        bh=kUnxUUxdaHyjl64Tc2/0RF6FmuNM8UyabgBGYN3qY20=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fPnMnpgUawOKy/hEgp5gIiPz7fCdbOVVcWvDUzcQTwYUy86nXlA7+U17HZhW/phCI
         /sF7DEzkXKoQ8e5wbX36lhp8h+XjQQw7NqFPUHY0fNFtTATPnJTM2pP+HQE9sKTQbk
         wmnfSyxUgggpf1y7QrkPWQ0R464FKphNQvrs1kfI=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=8pif782wAAAA:8 a=cLiMpolXe7I4jS8w5EoA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: A case where diff.colorMoved=plain is more sensible than
 diff.colorMoved=zebra & others
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
References: <87zhtiyd45.fsf@evledraar.gmail.com>
 <b23422fa-8a1d-e508-a008-a2fe27b7b49f@talktalk.net>
 <CAGZ79kZVfMNELXuir+t9U8bSg2PVF=oX8aya-OqmRaP0gHRgFw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <70f4fab1-9352-49ac-f911-da3e5a0ca172@talktalk.net>
Date:   Mon, 10 Dec 2018 14:43:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZVfMNELXuir+t9U8bSg2PVF=oX8aya-OqmRaP0gHRgFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfErbeAIvPMK9+HlMMjIWttVbTHcxNYC6+iTWtA0ufdWMbjwDVrgJ1Wu+2wgCiXa7gCTvJAxwV8uRzV/cANKtyNYqOi5hRamvGKwguO+rihO2uGzb0Plu
 7/xvrmOP/VA6A+tVXnFRCNh71SOltXwjNVvAIBWkscCFkAqs2OewRxHyyQLKYYIw6AlRwRPkSG12yjykkCA6pRScE/lRR9zVk6hvH2dTRxtN1Wj1Kthsi1Rj
 g0DEWVIBOKGIEzQxhXWTVdK730CMCygKtecLfcaq0pY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2018 18:11, Stefan Beller wrote:
> On Thu, Dec 6, 2018 at 6:58 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> 
>>> So is there some "must be at least two consecutive lines" condition for
>>> not-plain, or is something else going on here?
>>
>> To be considered a block has to have 20 alphanumeric characters - see
>> commit f0b8fb6e59 ("diff: define block by number of alphanumeric chars",
>> 2017-08-15). This stops things like random '}' lines being marked as
>> moved on their own.
> 
> This is spot on.
> 
> All but the "plain" mode use the concept of "blocks" of code
> (there is even one mode called "blocks", which adds to the confusion).
> 
>> It might be better to use some kind of frequency
>> information (a bit like python's difflib junk parameter) instead so that
>> (fairly) unique short lines also get marked properly.
> 
> Yes that is what I was initially thinking about. However to have good
> information, you'd need to index a whole lot (the whole repository,
> i.e. all text blobs in existence?) to get an accurate picture of frequency
> information, which I'd prefer to call entropy as I come from a background
> familiar with https://en.wikipedia.org/wiki/Information_theory, I am not
> sure where 'frequency information' comes from -- it sounds like the
> same concept.
> 
> Of course it is too expensive to run an operation O(repository size)
> just for this diff, so maybe we could get away with some smaller
> corpus to build up this information on what is sufficient for coloring.
> 
> When only looking at the given diff, I would imagine that each line
> would not carry a whole lot of information as its characters occur
> rather frequently compared to the rest of the diff.

I was thinking of using lines rather than characters as the unit of 
information (if that's the right phrase). I was hoping that seeing how 
often a given line occurs within the set of files being diffed would be 
good enough to tell is if it is an "interesting" move or not. In the 
mean time I wonder if decreasing the block limit to 10 alphanumeric 
characters would be enough to prevent too much noise in the output 
without suppressing matches that it would be useful to highlight.

Best Wishes

Phillip

> 
> Best,
> Stefan
> 

