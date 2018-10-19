Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3201F454
	for <e@80x24.org>; Fri, 19 Oct 2018 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJSUiS (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 16:38:18 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34951 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJSUiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 16:38:18 -0400
Received: by mail-ua1-f65.google.com with SMTP id m18so7370706uaq.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=COdMkW+hKdQP6Ln6keLvq1iCkT7f+lrDrWDAfJFK5wg=;
        b=n6y1/Q25i/RSYV8rNQVbS323HtpokiS4GUw5bDFZg40/kVgaEPGiuofzgFfbnSf0dN
         mh6fK6Q+5Zd8Qu43iUsXWz1LPaeNscvoPS1HVmmeKdKkRhETRmUPQNqQsguY/o3Ln6fP
         5J+ZSgTom6I8mJzSjtOZ+3I3xSlv6fWrls6gRNKOnVYmPlgm+McFG4FVSkODhd96WFDF
         UsFJorXkfaogy9bBkRiLo/RiMkpM7/0faVOyebADvIujD/n4Rewt2AqMm2EhPasEKHct
         yPFOSKgiYGms0jWP5t1H69ii48Sjtz8H7AtbcJbSmuNHESvIAwHcguMpSHsMeycX6W/a
         9CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=COdMkW+hKdQP6Ln6keLvq1iCkT7f+lrDrWDAfJFK5wg=;
        b=d186mYUS7MrcoF9G978fq8csmyfX4OFj1OsL3B4rDF2dnt+aEhmSytOgbMA97MD7Z1
         QSf4lKqfrqhAzqUWN0E3m+RTTTXFbufX0uCHeuAlAintcNw0T/vLEdcffitJCFXES9VK
         MUfoGLfHbFWiXciBL5tIvXrysNBkUYUzbq41R4K3s1Eu8VojfpJ5Wy1gdFENKUwOoAPi
         AU/cTlzw/3liv5REuXDBZmVMspJTOqAzmb+T6IjR1/NRJX/64nbFGWRm4+LnXUTse68B
         WJxFf+jHxschBzTIWP0EKrLt5TpJplXpC9lO3Q0N4/gs0xl0KWw9gGnue5jxLR0BBjNU
         100g==
X-Gm-Message-State: ABuFfohY/Sv9LRRo0UibdobmB2bu1Ur8xTbbCcR4Ml+sFwHVZz78BO4f
        ib/Ybu7wjeyAHH9mvgPOx/Q=
X-Google-Smtp-Source: ACcGV62tpF7Gjeqp6HD5nS7Uq3YD8ZBvJyQAz93FAnvfrhwEwSjB4i42/xSdev/wvetNM7I7KnGsxw==
X-Received: by 2002:ab0:488a:: with SMTP id x10mr15506187uac.19.1539952342330;
        Fri, 19 Oct 2018 05:32:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e0ed:6621:9414:4d4e? ([2001:4898:8010:0:ca23:6621:9414:4d4e])
        by smtp.gmail.com with ESMTPSA id o71sm5041815vkc.29.2018.10.19.05.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:32:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-reach: fix first-parent heuristic
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.51.git.gitgitgadget@gmail.com>
 <53ebceb7f11d1e1ea39ae4ca86850190ae839eff.1539883476.git.gitgitgadget@gmail.com>
 <xmqqd0s61pat.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d8a21999-3080-0989-49ae-995074cf7672@gmail.com>
Date:   Fri, 19 Oct 2018 08:32:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0s61pat.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19/2018 1:24 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> We can also re-run the performance tests from commit 4fbcca4e
>> "commit-reach: make can_all_from_reach... linear".
>>
>> Performance was measured on the Linux repository using
>> 'test-tool reach can_all_from_reach'. The input included rows seeded by
>> tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
>> v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
>> v3 releases and want all major v4 releases." The "large" case included
>> X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
>> tags to the set, which does not greatly increase the number of objects
>> that are considered, but does increase the number of 'from' commits,
>> demonstrating the quadratic nature of the previous code.
> These micro-benchmarks are interesting, but we should also remember
> to describe the impact of the bug being fixed in the larger picture.
> What end-user visible operations are affected?  Computing merge-base?
> Finding if a push fast-forwards?  Something else?

Sorry about that. Here is a description that could be inserted into the 
commit message:

The can_all_from_reach() method synthesizes the logic for one iteration 
of can_all_from_reach_with_flags() which is used by the server during 
fetch negotiation to determine if more haves/wants are needed. The logic 
is also used by is_descendant_of() which is used to check if a 
force-push is required and in 'git branch --contains'.

Thanks,
-Stolee
