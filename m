Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD95C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6EF22CF8
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLDUsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:48:24 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E219C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:47:44 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k2so7604379oic.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6bMjz1kh0kRCGmSDXfwF7aJgfPu1kF0bwPSCuNUOsQ=;
        b=hQ5Rd35pWaE4+XBl1iTYd6/5ZgRv2xVJUa7ddp0Y2GWQDLbAPcuWZ9MtUL2dXLweBJ
         XUdazuk+mmo7wURuTOrqnkpam2NZiwQozOuwE+di9l1qLmLZFAUgZgBGgK0/TJvtaJJa
         nxjTcETCcpH2E4+xg4xkaNlSxzNm/tsYKWlCCCnSBblV2766tTdeVdrezHpeHCReFiLY
         RvgkoJqeseRBn7lro5jfV5Dgy5Sc7UclOv8CvxEIRMhRV6YsAGoY+h+YkROERmjmb0MZ
         N7xjj2nHkU7hUcFxi9swwyHHj42PYc8XAWBKsggMNzC80RPgwPmSxB0ag93dTK4+1Ect
         cJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6bMjz1kh0kRCGmSDXfwF7aJgfPu1kF0bwPSCuNUOsQ=;
        b=f04i+Sd+vrb0Eo24nxqm6KDafQ1tA5aUwrYBvJnG0MjyLAROTLp8MTBZbzrnsvLS0t
         KSa68RyDBcjYZGTAABSgjNpaDJhy+ZALI+5XCdJ+kLypYoihsmR1c/XNuz5gwxGseM97
         zteWVzFQBKvyixsBRdUwnQnB4PfTlgjht4BWdGwbfLEfz4Rnklw1fiQX+17e0A7BNN+H
         tuj+qC2HFNEXM3Uk9qHg1Kv21C/0D0uxKy09FxP3iqAgWkEqqYuORXMuzW5ZhHo5AvSC
         kdWdy8GjrqJDsz9RjszRkFxZwxD9pAFKZuJIx3nVz0BjIyYWajvw7qXAW3iET9WuEvIK
         w7oA==
X-Gm-Message-State: AOAM533+88EQTEo3fJc9W96xwpLtgMKoK2tNl1BeaYt6mKhPXkXKjrIr
        jSznQTOgj0bmcdKSUQBtjs8=
X-Google-Smtp-Source: ABdhPJwVPFTxT32kUpHLbcGPyk8z08bGDOl3msyB55sAUwdsU9fuyFYI4Q2ExtFAf5mVeJYnctxNAQ==
X-Received: by 2002:aca:dd08:: with SMTP id u8mr4403682oig.85.1607114863822;
        Fri, 04 Dec 2020 12:47:43 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b1fe:7f84:31ea:b380? ([2600:1700:e72:80a0:b1fe:7f84:31ea:b380])
        by smtp.gmail.com with UTF8SMTPSA id d32sm868612otb.24.2020.12.04.12.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:47:43 -0800 (PST)
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
 <1103d97b-668f-8ad6-fc62-3fa09067a8bb@gmail.com>
 <X8qfRDsfLYTDL3HV@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <05c616b0-138a-3e30-5a71-4ba9fb26e6ef@gmail.com>
Date:   Fri, 4 Dec 2020 15:47:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8qfRDsfLYTDL3HV@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2020 3:42 PM, Jeff King wrote:
> On Fri, Dec 04, 2020 at 03:06:24PM -0500, Derrick Stolee wrote:
> 
>> On 12/4/2020 1:56 PM, Jeff King wrote:
>>> That turns out not to be a problem, though. The only things we do with
>>> the count are:
>>>
>>>   - check if our count will overflow our data structures. But the limit
>>>     there is 2^31 commits, so it's not likely to happen in practice.
>>
>> You do point out that you are removing this logic, done in this
>> if statement:
>>
>>> -	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
>>> -		error(_("the commit graph format cannot write %d commits"), count_distinct);
>>> -		res = -1;
>>> -		goto cleanup;
>>> -	}
>>
>> What is the harm of keeping this? I know it is very unlikely, but
>> I'd rather fail here than write a commit-graph that gets parsed as
>> garbage.
> 
> I agree it's important to have. But this one is redundant. Look a few
> lines below this hunk, and we have:
> 
> 	copy_oids_to_commits(ctx);
> 
> 	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
> 		error(_("too many commits to write graph"));
> 		res = -1;
> 		goto cleanup;
> 	}


Yep, my fault for not looking further in the context of your patch.

> So before we were counting distinct commits, checking that our count
> fits, and then _ignoring_ that count in order to create the actual list
> of commits, and then checking that the actual list's count fits. We only
> need one of those checks, and the important one is the one from the
> actual list (they _should_ match, but due to the bug, they sometimes
> didn't).
> 
> My "not likely to happen in practice" is not about the quality of the
> check, but rather that being off by one would never matter in practice.
> 
> Does that make more sense?
Makes sense to me. No need to change this patch at all.

Thanks,
-Stolee
