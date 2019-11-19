Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B625B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 21:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfKSVYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 16:24:54 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:34561 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSVYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 16:24:54 -0500
Received: by mail-pl1-f179.google.com with SMTP id h13so12594377plr.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 13:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=BlPerytCmS+a7dZVlSHBeTc0cLdPZM3+MfFvgS2uv14=;
        b=dPE2er5Pe8FQFbcyNRWPT8LdvkrOP/69kewUqGRMqJI7kUlndSHICsSBImleby8ej2
         wNhE4FcudR/6DL9iAGLOrUpVDUdBixEEgdA85EISghQyjF01qiGqv5MnOVR42c/swdDw
         JNrgAPBZLte8tvr8GMvgwLPadqiTAsjoirNg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BlPerytCmS+a7dZVlSHBeTc0cLdPZM3+MfFvgS2uv14=;
        b=QCn+m0xEXoPV8fl7LffPujlvOXzhOsIV7m/cA3oY4iRlWKy6vOLkmex+OtqhngE0y5
         mVTjBSAVheOBvJR0ebCOsZ1Fdo8QCjh/mutfUBUT1RR23SN4PTAIcnif45OVl/DPA0sl
         noQPEog1pVCUajyc2TOdvavVmZ4RW6yXwCRyJ4T9TX5g15xACc8abqIHbaL//CGjZNgl
         LMlFWUZioRWYIqzsBVZcM6hhYF1dqF7Xd410eXNAWQtFrqpw/xrCKMBFMB6oGYlCjPqc
         nRqmaKmrWCphv4bq/GSIc91KBWEZbQKhtoDnRxEzOPreK9oqQrL/djelL48lF7cHIiJA
         KXgw==
X-Gm-Message-State: APjAAAXG+N9wkAzjbGVRFwqyKNJxyP7EckGv6GtCrnoJdV49iG1TWlI3
        VWyPTdrlYXURb88QPonYLvHcTHFEwTQ=
X-Google-Smtp-Source: APXvYqwvLH29O20IBmhv73haQYOyEswt4MB9hdQ33UYECubC2+E1UFZrYjHKpRIpTvahEq6pBt0qrw==
X-Received: by 2002:a17:90b:4386:: with SMTP id in6mr9191288pjb.33.1574198691972;
        Tue, 19 Nov 2019 13:24:51 -0800 (PST)
Received: from erikchen-macbookpro.roam.corp.google.com ([2620:0:1000:2104:407f:1cf7:d833:4184])
        by smtp.gmail.com with ESMTPSA id v3sm25721056pfn.129.2019.11.19.13.24.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:24:51 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
To:     git@vger.kernel.org
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
 <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
 <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
 <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
 <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com>
 <xmqqsgmkzl1s.fsf@gitster-ct.c.googlers.com>
From:   Erik Chen <erikchen@chromium.org>
Message-ID: <8b6d4bdf-d982-97ad-e475-672e6ea914c2@chromium.org>
Date:   Tue, 19 Nov 2019 13:24:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqsgmkzl1s.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/18/19 5:55 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 11/7/2019 12:32 AM, Junio C Hamano wrote:
>>> So this introduces a single region around the entire function body
>>> of mark_complete_and_common_ref(), within which only one subpart is
>>> also enclosed in a nested region.  Is that because the parts inside
>>> the outer region before and after the inner region are known to
>>> consume negligible time?  IOW I would understand
>>>
>>>          F () {
>>> ...
>>>          }
>>>
>>> or
>>>
>>>          F () {
>>>                          trivial code
>>>                  <region 1 begin>
>>>                          heavy code
>>>                  <region 1 end>
>>>                          trivial code
>>>          }
>>>
>>> but this appears to do
>>> ...
>>> which is somewhat puzzling.
>> I notice that a v4 was sent that adds more sub-regions without actually
>> responding to this request. (It is worth also pointing out that you
>> ignored Junio's request you use the cover letter to explain your reasoning
>> for changes between versions.)
> Thanks for noticing.  I wasn't requesting any change in particular
> (at least not yet), but was inquiring the reasoning behind what was
> done.  From that point of view, the lack of answers was worse than
> yet another patch that does not explain why it was done that other
> way this time around.

Sorry, I've been replying on the GitGitGadget pull request thread:

e.g. https://github.com/gitgitgadget/git/pull/451#issuecomment-555044068


But none of those replies have been making their way to this mailing 
list. I'll attempt to send these replies to the mailing list now.


>
>> There is a real downside to nesting regions like this. Specifically, we
>> frequently limit the depth that we report nested regions to avoid
>> overwhelming the logs.
>>
>> In general, these sub-regions should be avoided when possible and instead
>> create regions around important sections, such as the second option Junio
>> lists above.
> Thanks for a clear direction as the area expert of trace2.
>
>
