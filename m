Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893CF1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 12:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfJUMJA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 08:09:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37866 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUMJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 08:09:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so12336012qkd.4
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zGT/dkdYG67UgNOZhiwXjIjqHZCE5teCs/CFUuC9BBs=;
        b=UaK6jsNvSGjoZPDGStfOZaxTmOohI/JmLjP9VxEFTrbwtd/KYpurdGeKYh9KKZArn6
         ZZmztF8GvbTCYVobBmr/QVzzZ8jZoygr+hS1rVzBxXLdYDssDNDjPqijAizDWDs8g2hB
         MbT0c1x593MDsVFvdiPVvEF67XpjsmDyBV2y+ybgDB/Q29VXR9837l8fpTJZkTh8nP2k
         NGCjhlGppRFNbNnMkY9/FGJmplj4QEW/u5d2MZfkgbS7SnePlIj0Vh0aFdF9jdJ0NymR
         3mjqYV9MsKntIddxtDePUrSKY8zVOt23Njw+hYN2J1Nz7GHqo2kPr6SmZu0Hp2zKWcf/
         Pnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zGT/dkdYG67UgNOZhiwXjIjqHZCE5teCs/CFUuC9BBs=;
        b=bsY0SHpQvIMteiKtfgTvJTVCnmK9AKBg3KtJt19e+VfRvyefkEtaKGKbyD86+oxkDl
         SvxR68Fncwg515Z4mUuYnzE3H2/9J08EFpSSgnCTuLkOxRv0qHRYdXqc2SAAOiai4uj3
         JIIm7EOenpomZngzUGM8e36mX8MHaLz74axc93XHDI33/uwNZ/fHGrEtYKFfKYTVe2F1
         vwm1s1jHw+smKhn98RcOY5c0dXWWmA/ESWWkIlJp6/vkSgCO5zA16SVALHsXo9ljR56b
         wMj1fgiSAfahgvrW+g0g40tqCPtzB3xr4Uwj2zWgpZVfqJ1nugQIbkYj9yyLpFQRe2P8
         ngrQ==
X-Gm-Message-State: APjAAAWcIWLJM/tSuGArX/dlhoZH2Js6QZv3cRjXAH9x1EKu1yFhsnlq
        SevUuvRTfq2uLoQxtPijD4g=
X-Google-Smtp-Source: APXvYqxqkp2s8GcLZduNQ61aPWcpQRj5i5+4ePAIrPDNXcmOK5909KMMC5lEWXNcyuQkoLoBgun4Lw==
X-Received: by 2002:a37:2f42:: with SMTP id v63mr15475874qkh.277.1571659739481;
        Mon, 21 Oct 2019 05:08:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1012:f14b:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id s75sm9546759qke.14.2019.10.21.05.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 05:08:58 -0700 (PDT)
Subject: Re: [PATCH v4 00/17] New sparse-checkout builtin and "cone" mode
To:     Jon Simons <jon@jonsimons.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <1ea216d8-e706-ec4c-a3f3-954e57e0458c@jonsimons.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <529d7656-d9d9-1a52-cea5-132ac8fdd2f7@gmail.com>
Date:   Mon, 21 Oct 2019 08:08:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <1ea216d8-e706-ec4c-a3f3-954e57e0458c@jonsimons.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2019 7:53 PM, Jon Simons wrote:
> On 10/15/19 6:55 AM, Derrick Stolee via GitGitGadget wrote:
>> V4 UPDATE: Rebased on latest master to include ew/hashmap and
>> ds/include-exclude in the base.
> 
> I did a partial review of the v4 patches out of curiosity and I notice
> in sparse-checkout.c there are a couple of unchecked `fopen` call sites
> that could be converted to `xfopen` to die gracefully upon error, and
> one unchecked `fdopen` that can likewise be `xfdopen`.

Thanks! Fixed for v5.

-Stolee
