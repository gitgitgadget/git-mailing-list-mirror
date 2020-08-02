Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE07C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D08320759
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPThGW11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgHBPK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHBPK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 11:10:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0CC06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 08:10:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b6so31925577wrs.11
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nxu+3RHoalyYvl5JnEECBWfRLO+PUT8RMZulFWy+PzI=;
        b=NPThGW115gKKLYyNUE7MF2qLW4CGDKvLWEshBmNHwgfaty3EhX+zlzZ5YYvwbMtX1w
         RW0+QS78xtNdqj0iBxX4H/r6d+QuLJZgPHlQCUqAQxAgxO9o9uEczKB80/87IjHG1H4X
         IV3YIs63JsK0ZWSybsTSaKLLSY7bVAL3UGEFRW6s3vJZpWxByrJVYnvKgPoP1rd/EEUB
         cmzbgwY8XwmCyXXpCOigQwaGYLjTILgWV1cs71P4iGaKXy7YStFfeb3mURfD7S2MgllE
         5CRVICQF1g8JQjQSr1Vebn94uMX6BD0narjo3L49TCjDghCgZ8HNWEoMo1XkvWEdo52h
         EFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nxu+3RHoalyYvl5JnEECBWfRLO+PUT8RMZulFWy+PzI=;
        b=p0PQtfFePKVhwNU5FcUnywhBKI+fBJGaiaxrG0Vs8O3WLLIOqsZ8zUY+NKg9wDT4fB
         vVKOgpqr7RzqhWbjCw85cjVtwLPEj01xaGfsW236h5ErMqnpTgUN+CvHr7k4CdLOBMYJ
         20uUDw1U79DaZU0uuWMvUuDmx8kRAvE0hRd8NfwtNEFBTkEyWBbW5ozvhYkucRBwqHWd
         0IgZej8nbahaDOdJwBE/tA4H8gl+i3K8fdBvch59RYZYxUO9lGVRbb+6+s/VP6CYkaxe
         iizcFKXj3QN+lCI0ibOvqoT6wSPpmWYD1v43P6oT3DYgcuOzPuGf+BrHuZJPi/0jg5Ye
         IC2w==
X-Gm-Message-State: AOAM530HLSiyAEfk5zXhkKrpG8VKCHNBo2feTvFPXi6vrOeulkQAPz8I
        jSa6BGQiYsckNLXL/73S9Z768TBF
X-Google-Smtp-Source: ABdhPJxrhUxtDlGJRFCOh/uw7wpR/ZpsrJvrYS7HIt/HXi2Kzd3N7KBRSgROKHRxMR25CPtOCQKrQA==
X-Received: by 2002:a05:6000:4e:: with SMTP id k14mr11130451wrx.303.1596381055214;
        Sun, 02 Aug 2020 08:10:55 -0700 (PDT)
Received: from [192.168.1.240] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id y17sm21599036wrh.63.2020.08.02.08.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 08:10:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: amend param not available to the pre-commit hook
To:     Andrea Wyss <andrea.wyss@gmail.com>, git@vger.kernel.org
References: <30DFCBF3-FEA8-4FF5-94ED-A81AB10B04A3@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f9016e7a-0769-6a55-ab32-6b54674ae2c1@gmail.com>
Date:   Sun, 2 Aug 2020 16:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30DFCBF3-FEA8-4FF5-94ED-A81AB10B04A3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrea

On 02/08/2020 14:22, Andrea Wyss wrote:
> ﻿Issue
> amend param not available to the pre-commit hook
> 
> Problem
> Cannot write a pre-commit hook that stops amending a commit that is present in other branches.
> 
> Steps to Reproduce (git version 2.21.1)
> 1. Code in the pre-commit hook:
>    echo "DEBUG 0='$0' 1='$1'"
> 
> 2. run:
>    git commit --amend
> 
> Current Result
>    DEBUG 0='.git/hooks/pre-commit' 1=''
> 
> Expected Result
>    DEBUG 0='.git/hooks/pre-commit' 1='--amend'

I'm not sure why you expect this, the documentation for the pre-commit 
hook states 'this hook takes no parameters'

That does not mean that it would not be useful to have this information 
available to the pre-commit and possibly prepare-commit-msg hooks but it 
is not a bug. I'm not sure that adding a parameter to the hook is a good 
route as it may break existing hooks that do not expect any parameters, 
maybe we could pass it in the environment.

Best Wishes

Phillip

> Please, let me know if you need other info.
> I'm looking forward for a fix or workaround.
> 
> Thank you,
> Andrea Wyss
> 
