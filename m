Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BE01FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbeAHU6V (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:58:21 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:37846 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932259AbeAHU6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:58:20 -0500
Received: by mail-qk0-f181.google.com with SMTP id p13so15924922qke.4
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSU8K+qDz7drbAVu1O1O3Kln0b2JNbcxxKIxzzXSD6w=;
        b=lRKAVws3A3jAR5rhaVeRs/69Mx33eMP8XxKUK0OrPZ7axexB8i98XgqAE32duQSayu
         wKuXfeHvLw6hAzsmftgTe3Cx6qORcDi1YKYc44U1cJpDJYdzWyb95Tz5oQL9t4IO8bN5
         ZUxwzCYKEK1zrhzUFVK5gCwJOxiS3eODe/arTx9Ik81IQ1EME+hKXK3+ybMkSYyEUSIx
         k2MA+xMR0Ao+Ro+TyRQHnvs+VXtDAdK/W5dKKnQO+EFvAtzY7rBpXo6+EcKAL1E0fDNg
         hFxYyoguwWhpX2Noi6cI3wAsjumw/gPTpGi6y/9DAMRaNg4W2EBVO8wCNcX+qxelNd74
         MQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSU8K+qDz7drbAVu1O1O3Kln0b2JNbcxxKIxzzXSD6w=;
        b=n/FBC5MR6X+KuoUnP46p/Zwf4w3/VUTX7i4v306fgKbOHWy0Vmj5I1i94zkdk3almC
         MiI+f0hNaRTx/Y3+CqSUX/WnYuF1j7uzPGyVzEzmcZDy9ZHMH4O9q0sVRGThOwcHfs2P
         mEHvyhxxctACB68xjB80hsBm7lHZE1Ifr3Hom8Eu5HJgfdw+TdX7TatvMu9TNfCClg7c
         WxDSJzEHE2ry3oP1O1/5iT0i6UA0ox3/Ik4+d8yGbfmmBLNtF5NtMbtjapUgQzPlmgK4
         55j/luBTSY12ylfZAtGKJD/cQBy3qqhe3GWTHqdqQ0lkZG/D0AZJAmWq8pas0xLYIms9
         mnXw==
X-Gm-Message-State: AKwxytf7l7XoQks2+uaoj67UvnSxKt+UimsrdfwGqFCcWaVMSbO6/Qar
        N+lMfOAS00BtJgUh6ckLt+AckWci
X-Google-Smtp-Source: ACJfBotkLHs5pYt8wcEVGZNT6dTs5Y0aY2C3hjtvJZIkYJvR+e3/wpBrxl4bewLjC3LiPaUuZ8lagA==
X-Received: by 10.55.59.70 with SMTP id i67mr18071094qka.152.1515445098979;
        Mon, 08 Jan 2018 12:58:18 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w7sm8723262qkg.17.2018.01.08.12.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 12:58:18 -0800 (PST)
Subject: Re: [PATCH 6/6] fsmonitor: Use fsmonitor data in `git diff`
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
References: <20180103030456.8181-1-alexmv@dropbox.com>
 <121828fc14bc6f3096d16005feffb58bf68f070a.1514948078.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <xmqqefn4aqt8.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6f7b31f7-3532-a7b4-5846-d2994dcb8795@gmail.com>
Date:   Mon, 8 Jan 2018 15:58:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqefn4aqt8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/5/2018 5:22 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> diff --git a/diff-lib.c b/diff-lib.c
>>> index 8104603a3..13ff00d81 100644
>>> --- a/diff-lib.c
>>> +++ b/diff-lib.c
>>> @@ -95,6 +95,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>>>   
>>>   	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>>>   
>>> +	if (!(option & DIFF_SKIP_FSMONITOR))
>>> +		refresh_fsmonitor(&the_index);
>>> +
>>>   	if (diff_unmerged_stage < 0)
>>>   		diff_unmerged_stage = 2;
>>
>> I read over this hunk five times, and only now am I able to wrap my head
>> around this: if we do *not* want to skip the fsmonitor data, we refresh
>> the fsmonitor data in the index.
>>
>> That feels a bit like an unneeded double negation. Speaking for myself, I
>> would prefore `DIFF_IGNORE_FSMONITOR` instead, it would feel less like a
>> double negation then. But I am not a native speaker, so I might be wrong.
> 
> I do find the logic a bit convoluted with double negative.
> 

It's great to see more use of the fsmonitor data.  Thanks for doing this!

I agree with the sentiment that the logic as written is confusing.  I'll 
also point out that DIFF_IGNORE_FSMONITOR would be more consistent with 
the similar CE_MATCH_IGNORE_FSMONITOR flag and logic.

I'm also confused why we would not want to use the fsmonitor data in the 
'add' case.  When would you ever need to add a file that had not been 
modified?
