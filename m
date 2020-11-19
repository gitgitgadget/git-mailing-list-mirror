Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE6C56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C03E22248
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPk+5Q5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgKSPxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgKSPxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:53:53 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EEAC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:53:51 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so4686143qtp.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKLBPhg4qFb9NxTgHuKZV/+vlNJBthS8Qe24vmQRbVU=;
        b=GPk+5Q5PKrXp8jq+jQw8PMVSNdB3m3ejEmdCu/TaRS4QVIIFUlp93Qe/ZZgG5zDp0S
         Reb/ml05RfbJb93uiqmK3DOuhNc+cUMPVqljJBaAsLiSIxcdonnExUiTZC0HUCUkbf7p
         37HJJ8hraGZkAonwYC3ACBpG2nKdyR7BGkBQedC5bH/nVi9t2wXJ/Y27+chtvs1/jLh0
         4NTduubiHzBgP22qt9XteOPg5ypkqk0+5R4grznR8/CbHyWBQ6b94rssXVWGQwhrjhmX
         oGYJn/9vl9X5UDzFv+0sYWvQ/tFJXKkfNCKN5u6lch9IhSVWHGWYlPDxyBHj25RKLO5c
         Sxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKLBPhg4qFb9NxTgHuKZV/+vlNJBthS8Qe24vmQRbVU=;
        b=PDnG6pH9US/2wWx6wbBL2n3xqPcDoUImpY8dqlPXJlRV1dDran2AzIp0joPtYzvwWG
         rfJABSJ0IdspG3ND8ah0elRK6yFaL4fbcErIycCfpmmRRcqke8V3HW22+6140i3hEFmk
         Q5qnD0gmtmjJgT9REj779NNxbW+eVs5CCNfNH1p6tz/ebhoXduK9JjBrL1brZxw0fCMi
         AlcHXebzihzFjoebNXMnjMUH8DAfmhNOfgpijhJMoOt3ma9AXeKIyo6LWZK9/CIW/Mca
         IvmV7MfS8KegG2Ae9/xvTbFeSsmT/Eq+EAfi3AoheURtjmNPkF9ysP4qYaXx5/speARP
         LtlA==
X-Gm-Message-State: AOAM5310PMKS4jeOncRmI4B68Yu/z+gFWk4XmB1gRzKknpmqDhXcAxzY
        uMJbPtvsIWndjzQyMtuFfn9NNCPLaW2c/A==
X-Google-Smtp-Source: ABdhPJwvTJ5zM7wArM/STT0u6zmzIYhVLZzAKD5WFOvacUbcOpMAXPwBeDgWEo0tjXN5LrLseYi4iQ==
X-Received: by 2002:a05:622a:50:: with SMTP id y16mr11460159qtw.119.1605801229361;
        Thu, 19 Nov 2020 07:53:49 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id f27sm107382qtv.95.2020.11.19.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 07:53:48 -0800 (PST)
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
 <20201116235642.GA15562@google.com> <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
 <20201117010709.GB15562@google.com>
 <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
 <xmqqlfez6alb.fsf@gitster.c.googlers.com>
 <f8b1a1cc-dcda-0e53-4c46-bb5bfff3fdd4@gmail.com>
 <xmqqd00ayttk.fsf@gitster.c.googlers.com>
 <2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com>
Message-ID: <53c2be89-f722-db9a-2e4d-92aa75fe3409@gmail.com>
Date:   Thu, 19 Nov 2020 10:53:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2020 8:25 AM, Derrick Stolee wrote:
> On 11/18/2020 9:16 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> I will get started on this fix as a series on top of part-3.
>>
>> Thanks.  Not just part-4 but Dscho's test update also depends on
>> this, so let's see it corrected soonish.
> 
> I got a decent start yesterday, but I'll put this at the top
> of my pile for today.

v1 available now. [1]

[1] https://lore.kernel.org/git/pull.796.git.1605801143.gitgitgadget@gmail.com/

Thanks,
-Stolee

