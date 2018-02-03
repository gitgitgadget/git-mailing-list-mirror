Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2861F404
	for <e@80x24.org>; Sat,  3 Feb 2018 02:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeBCCJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 21:09:35 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35033 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBCCJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 21:09:34 -0500
Received: by mail-qt0-f181.google.com with SMTP id g14so33325908qti.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 18:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPbfYeOaOSIUAv+El+IbhE611+FBPm6OaAGeQpPKFaY=;
        b=G5A88X5U6x3gEz9uGUuYP0sSjPOAgfE1UeN/qP2FQGJM8OBdQ1dvpNuBcvRT4GoDyH
         VHTFd4IgDrItUOHPzOhzJKVTfukBM4gYJVTWi53opJ2cS55LxEDWFsxxl5JolR4llsyP
         zQ4mxcfDFLiQGYyWWEpNnNC/XYrjLyvzwG9xuL/rr9n1qZEsxojgr3s9QSK4adIE/iqd
         VfMZRfP3fBN1My1toofhCwTyocZMEOiA1Rd1qrrQBrcZPttYXFD+1FR210pTih8PmA78
         E9qiOI5Dim7NC/m3JJnKzLC/CPn3Xcha0hu3vHG352wBzOpy/FBck2snaeMkIlbIkzcr
         O2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPbfYeOaOSIUAv+El+IbhE611+FBPm6OaAGeQpPKFaY=;
        b=DWZPwDFFZccotJexuozOjnAawlpWl2nJhp8aCLVaJhm3CmUjywF5ivrrJCEp88uIsG
         iJEYecSN9K/6RMjJfe1ST45vBT4Us1SKiTGRwjvkDAhzob8roGT+9goMgp4s3aCFLArm
         rJrysGRca3ZOAMqjK+MeouHKcklsCA3Q/KtyDgulbYaXMKkUhMPof3gNz8F7SpTgfLsL
         k2A8Zl5xM/bQ9rGWaxPFcM6LzprrLEicALAEN1QENsnxlVHqh7XxeHFGYbc47R6f9qLT
         tBmLjHlLdEZQYHDqKN9st9MDv9/iVGDcloUq2sTP+xdv6JatJjkDZOWnFj9qMw42LquW
         ixow==
X-Gm-Message-State: AKwxytfrFculW0Bhvl3vagS+cPEX45zeXNUNdKUYmRiT8Aeatl/6shhT
        LZrFfN0dMP6R0CQsj7EGdK1baKWf
X-Google-Smtp-Source: AH8x226BUNWCWkIh70uegc+2H4uK+ctTBIhVvmoWkHrPStAuccNL7tMKT/syv0qsNNRYwti9rPYA9A==
X-Received: by 10.200.36.199 with SMTP id t7mr66940365qtt.141.1517623773021;
        Fri, 02 Feb 2018 18:09:33 -0800 (PST)
Received: from [10.0.1.24] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id g12sm2397144qtc.3.2018.02.02.18.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 18:09:32 -0800 (PST)
Subject: Re: [PATCH 0/2] Refactor hash search with fanout table
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <cover.1517609773.git.jonathantanmy@google.com>
 <xmqqtvuzas17.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bfec5a5f-85e1-133b-2820-bdd9c90e4aa8@gmail.com>
Date:   Fri, 2 Feb 2018 21:09:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvuzas17.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/2/2018 6:30 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> After reviewing Derrick's Serialized Git Commit Graph patches [1], I
>> noticed that "[PATCH v2 11/14] commit: integrate commit graph with
>> commit parsing" contains (in bsearch_graph) a repeat of some packfile
>> functionality. Here is a pack that refactors that functionality out.
> 
> Yay.  I had exactly the same reaction to that part of the series.
> 

Thanks for doing this refactor. I'm a fan of reducing code clones, but 
also don't want to break well-worn code paths.

Jonathan: While you are doing this, I'm guessing you could use your new 
method to replace (and maybe speed up) the binary search in 
sha1_name.c:find_abbrev_len_for_pack(). Otherwise, I can take a stab at 
it next week.

Please add
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
