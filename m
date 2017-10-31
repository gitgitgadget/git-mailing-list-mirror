Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03268202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 07:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbdJaHNN (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 03:13:13 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52271 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdJaHNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 03:13:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171031071310epoutp03124f70ed638184d0305da630aeda4685~yljejA5NF3071530715epoutp03h;
        Tue, 31 Oct 2017 07:13:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20171031071310epoutp03124f70ed638184d0305da630aeda4685~yljejA5NF3071530715epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1509433990;
        bh=lGNu7FLyVQqjAlFvwsvL9tvXuAxV7JjxhH/1cuLB9/g=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=d3bkuyd4k6GPfbENLRa15jbxqVUYdeSOjqXiJ7ejdiAeeSzuQCQ0hT6pfcE5vrRU9
         tzPbgPQPb+UtUw8uC4d+IaGaqZcSWXaXhjmfqgVwyuzMs+7c3dGx9L8SACltKFYWNN
         prIOUe85EHyKVLPfmvAQJyu+Lxkj5A8Hd1rjPOCQ=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171031071310epcas1p10009ea9f1e6ae52106403222a4d3e2c0~yljeSIyL80049600496epcas1p1z;
        Tue, 31 Oct 2017 07:13:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.D4.04139.68228F95; Tue, 31 Oct 2017 16:13:10 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20171031071310epcas1p4ab5b09a09f4d84aee7736de08c09a6aa~yljd-RkAZ0113601136epcas1p4W;
        Tue, 31 Oct 2017 07:13:10 +0000 (GMT)
X-AuditID: b6c32a39-981ff7000000102b-ed-59f82286eb0c
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id A0.03.04095.68228F95; Tue, 31 Oct
        2017 16:13:10 +0900 (KST)
Received: from [106.109.129.81] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYO00GZZEPOYJ50@mmp2.samsung.com>; Tue, 31 Oct 2017 16:13:09 +0900 (KST)
Subject: Re: [PATCH v4] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <ecb12f21-f26f-6905-1fdc-60d7c282cfe3@samsung.com>
Date:   Tue, 31 Oct 2017 10:13:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <xmqq37603vek.fsf@gitster.mtv.corp.google.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmrm6b0o9Ig12tshZdV7qZLBp6rzBb
        /H3TxWjxo6WH2WLz5nYWizNvGhktjrR/ZnJg93jS3MPisXPWXXaPBZtKPZ717mH0uHhJ2WPx
        Ay+Pz5vkAtijuGxSUnMyy1KL9O0SuDLevL7OXPBBrOJoyyWmBsaNQl2MnBwSAiYSzyf/Yuli
        5OIQEtjBKPHu+j1WCOc7o8TUGxuYYKpun1nNBpHYwCjRsv4aVNV9Romfp06zgFQJC/hIdD5Z
        AmaLCKhJTGw7BDaXWeAto8SULScZQRJsAnoS539NYAex+QW0JC7/mMcMYvMK2EnM/PYSbB2L
        gKrE91/zwAaJCkRIHD+8nBGiRlDix+R7YHFOAWuJdc83g9nMApoSL75MgrLFJY7dv8kIYctL
        bF7zlhnkCAmB52wSrw5tZYb4x0Vi0f2f7BC2sMSr41uAbA4gW1ri0lFbiHC9RGvHEzaI3g5G
        ic+zlkLV20ts6drOBrGAT+Ld1x5WiF5eiY42aKB6SEx4ehAadI4SR9acBysXEnjELjHrccIE
        RvlZSN6ZheSFWUhemIXkhQWMLKsYxVILinPTU4sNC0z1ihNzi0vz0vWS83M3MYKTj5blDsZj
        53wOMQpwMCrx8DrEf48UYk0sK67MPcQowcGsJMIr9BEoxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nFd0/bUIIYH0xJLU7NTUgtQimCwTB6dUA6N21NHvPb5dFgrHauQ3cssve58TeWtvWwtn3ky7
        Oy99D2V4us7e43xy69f3e3dIdp5ijs6ZWVH0QD8uuZ6vp9h18ayG+n/7szZeTj5x8PLsvQ8f
        PLkxtWyR+3HfK847GrdkLKk/F1e4oOHx5zVs/i2ZvXyeC/au/bLw7O6ds3Z+1hO4/9zlWHib
        EktxRqKhFnNRcSIA9bJXXzoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jQd02pR+RBk8vsVt0XelmsmjovcJs
        8fdNF6PFj5YeZovNm9tZLM68aWS0ONL+mcmB3eNJcw+Lx85Zd9k9Fmwq9XjWu4fR4+IlZY/F
        D7w8Pm+SC2CP4rJJSc3JLEst0rdL4Mp48/o6c8EHsYqjLZeYGhg3CnUxcnJICJhI3D6zmq2L
        kYtDSGAdo8TzfY+gnIeMEvem/2ICqRIW8JHofLKEBcQWEVCTmNh2iAWkiFngLaPEvNszGSE6
        nrBLvNk+gw2kik1AT+L8rwnsIDa/gJbE5R/zmEFsXgE7iZnfXoJNZRFQlfj+ax7YVFGBCInn
        ze9ZIWoEJX5MvgcW5xSwllj3fDOQzQG0TV1iypRckDCzgLjEsfs3GSFseYnNa94yT2AUnIWk
        exZCxywkHbOQdCxgZFnFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYLdsOa/XtYLy/
        JP4QowAHoxIP74zE75FCrIllxZW5hxglOJiVRHiFPgKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYAxmve+XahkmqZW+n2+hwdv+/Bmxt9zrmx5zah1i
        Fnu3fI9lxSczaSd9r8uHagyl4h8cNJNxr933VkPWboH4RrGNBobi02WvKD8+U2nGsp6r8WnM
        5Iz7kacnmt2zKP/3bKn4rp493Ttf7lvqzl3FvFJCtJypdUJywj7r6fdaMgIbup/tdgv5qcRS
        nJFoqMVcVJwIABrkttySAgAA
X-CMS-MailID: 20171031071310epcas1p4ab5b09a09f4d84aee7736de08c09a6aa
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
        <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
        <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
        <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
        <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
        <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
        <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
        <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
        <2b507ce0-0d18-d9d6-11ba-6fb0d4f4a473@samsung.com>
        <xmqqd1543xfc.fsf@gitster.mtv.corp.google.com>
        <xmqq37603vek.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

31.10.2017 05:26, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> That holds true for the code before or after this patch equally.  In
>> other words, that sounds like a justification for rejecting this
>> patch (i.e. explanation of why this change is not needed).
>>
>> If we are worried about another thread calling these functions after
>> the time we call getenv() and before the time we pass the result to
>> strtol(), then I do not think this patch gives a better protection
>> against such race, so I do not think that is why you are doing this.
>>
>> So... why do we want to do this change?  I am puzzled.

I think, the main benefits are:
* Code is more readable, no duplicated calls with the same constant string
argument.
* Code is potentially safer, the second getenv() call may return another
pointer value which could be NULL (and yes, this is an arguable point as it
can be done only artificially).

> For the sake of fairness, I would say that the resulting code may be
> easier to follow and has one less instance of a constant string that
> the compiler cannot statically check if we made a typo.  That's the
> only benefit in this patch as far as I can see.
> 
> The original makes a call to see if the result is NULL, and then
> makes the same call, expecting that we get the same result (not just
> that it is not NULL, but it is the same verbosity request the end
> user made via the environment as the one we checked earlier), and I
> can understand that it feels a bit redundant and ugly.

Yes, you absolutely right.
I believe this patch makes code more beautiful :-)

>>> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
>>> Reviewed-by: Stefan Beller <sbeller@google.com>
>>> ---
>>> Added 'reviewed-by' field.
>>>  merge-recursive.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/merge-recursive.c b/merge-recursive.c
>>> index 1494ffdb8..60084e3a0 100644
>>> --- a/merge-recursive.c
>>> +++ b/merge-recursive.c
>>> @@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
>>>  
>>>  void init_merge_options(struct merge_options *o)
>>>  {
>>> +	const char *merge_verbosity;
>>>  	memset(o, 0, sizeof(struct merge_options));
>>>  	o->verbosity = 2;
>>>  	o->buffer_output = 1;
>>> @@ -2171,9 +2172,9 @@ void init_merge_options(struct merge_options *o)
>>>  	o->renormalize = 0;
>>>  	o->detect_rename = 1;
>>>  	merge_recursive_config(o);
>>> -	if (getenv("GIT_MERGE_VERBOSITY"))
>>> -		o->verbosity =
>>> -			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
>>> +	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
>>> +	if (merge_verbosity)
>>> +		o->verbosity = strtol(merge_verbosity, NULL, 10);
>>>  	if (o->verbosity >= 5)
>>>  		o->buffer_output = 0;
>>>  	strbuf_init(&o->obuf, 0);
> 
> 
> 

-- 
Best regards,
Andrey Okoshkin
