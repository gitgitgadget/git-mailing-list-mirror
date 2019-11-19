Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315C91F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 21:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKSVvk (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 16:51:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33175 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKSVvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 16:51:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so13021763pfb.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 13:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+VM+CQE4/8vxDJcoFs6tDjpyipEqRxW/mS7/Edh5ik=;
        b=EMjZJXnnEd9fW1KaAYTnX4wgaXVdVjZNEEtup3XAVscx7HT8UAwCIBsvJwW3lOzo9b
         OWwUzzvNPRiUsz+NKxojedyGMycc1lr6TZVjERMYCmDGY3GGLp1SuM/j2wOabynyjEHl
         i9vFy5u0JwgnOrhVQJfvYDTR1b8487LP+zU44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+VM+CQE4/8vxDJcoFs6tDjpyipEqRxW/mS7/Edh5ik=;
        b=CU0Yq71Sr1OuGmIqGc2ng+yXWufOgf00Pi4DQ0/OT9tFmLuOLXNu6hpR0lSECsL17q
         OMkfshNKyAtAYdeU7gJsvfJVtRtA5ST1w4xsxYMF0Kn8JaXPmEog+oga39IyUr5PtnFh
         AyK7Bro5ESVMaE8YHZK6KtVaPASc8mvwJKKQ8av3JzHKPSCiS0f7VLa/Odxfc1sppeIc
         5Uc6OOQW2wz1Todtnhy55TVwqgctDf2jwU64L2RLs+ygvJz/b4AEV54o64gNWnP1A2VA
         Y85aa1yc33DlLZ6OtcK9U4KeSNhOhj9ckK8m4w7fs/oWXR13SGQGzE3UelAMdYpiTv3g
         N22w==
X-Gm-Message-State: APjAAAXDDkzVWzS97bLyM+tPRCCJEbyYNx0rmrkfODRQcVsXZQYLfi7a
        56Fhb51FhiptGFa7eINclqeyjyBw6h4=
X-Google-Smtp-Source: APXvYqy7+a3/Ukl8PrKvhFShZ5aSB1V5Hx1gGvYQeA6qdbWqqUy1GBljwmgdmCbVbYie7foEqVonlw==
X-Received: by 2002:a62:174b:: with SMTP id 72mr648254pfx.179.1574200298772;
        Tue, 19 Nov 2019 13:51:38 -0800 (PST)
Received: from erikchen-macbookpro.roam.corp.google.com ([2620:0:1000:2104:407f:1cf7:d833:4184])
        by smtp.gmail.com with ESMTPSA id i71sm25984426pfe.103.2019.11.19.13.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:51:38 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Erik Chen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
 <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
 <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
 <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
 <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com>
From:   Erik Chen <erikchen@chromium.org>
Message-ID: <c2cd57ed-8075-bdd3-67f0-21187580270a@chromium.org>
Date:   Tue, 19 Nov 2019 13:51:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Importing response from 
https://github.com/gitgitgadget/git/pull/451#issuecomment-555077933

> I notice that a v4 was sent that adds more sub-regions without actually
> responding to this request. 

Sorry, did I misunderstand the request? I was trying to implement the 
suggestion:
<Junio's first suggestion>

 > (It is worth also pointing out that you
 > ignored Junio's request you use the cover letter to explain your 
reasoning
 > for changes between versions.)
Sorry, this was not intentional. I'm using GitGitGadget, and it wasn't 
clear to me how to change this. See my comment here:
<https://github.com/gitgitgadget/git/pull/451#issuecomment-555044068>


> 
> There is a real downside to nesting regions like this. Specifically, we
> frequently limit the depth that we report nested regions to avoid
> overwhelming the logs.
> 
> In general, these sub-regions should be avoided when possible and instead
> create regions around important sections, such as the second option Junio
> lists above.

I thought it would be nice to have an encapsulating region for the full 
function, but I can switch to Junio's second option if that's 
preferable. It wasn't clear to me that that was preferred over the first 
option?
