Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CDBC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BA6613C8
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhDFLOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhDFLOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 07:14:01 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2FEC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 04:13:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n8so14639652oie.10
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Or8Q8+qW/MR6LPLy5DDGjbG4L1U2nvCG9dFCBOn02pU=;
        b=gKBkRyHtl0TmSbiYJ0blT1frC6+4meAcpKKBmLvyPAgOIpl8S4Zf4sAfFlzPBmF1JX
         osaN8vISygCZf3RNy/0sTHciXULMLKbvM6pU6+1hDeOMYG9qZ2hgV4KY16ewzTbvN12O
         Xa9dKSfXTwJl1irSRruM+lQoZa/cJaJSCte8oSDGH4zB3T6bS9ygb5udunIWfFkwoY1j
         rgziACkr38escsuPHpCIpJMiKRSKflV12Q9EiwqBL2P+Sgi6SC4v5H6aQAWnn/uzc4pb
         hBtmOyvDcN+e0gGlnyLWkMKXXUfH3FrIstfPDYsSGD0+uzha4mdqv8Q0OgQ4P3rqBH1X
         QqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Or8Q8+qW/MR6LPLy5DDGjbG4L1U2nvCG9dFCBOn02pU=;
        b=F4hCWPprQXbL23R1X4oesqh7t5h0j+yOKsWaIhqQRYnsGzxriUHk57UH6WOJ258aAG
         nXFywOvC3hilG9IgO2tPWc0+UiewbcdPMPQf41QTflYiBidmYR+j266F5oHTEUsPswxS
         EE7ce4R4O8UxO0uBYpOc3391S6fA8ltMlgQuoaJn+3R8zRic0+4905lUox3AY24UTYaa
         lHnoxcCWtrqlTGE8vy7CFyInIewKPpxHAhj4HvUGc5pxeqNY9IdeoBJeQfGrtlUE2fOE
         xVe/2D3DD5ErRm3lPNhKUYtZ7FdN3hDayZb4xZwpxUrSmm3S9neianlsvneiolON9upM
         40nQ==
X-Gm-Message-State: AOAM5319nRp6y8JO+Yi3+LTlJaBMm8VLK3eHhSmpB/y1fONVzRhyf7jm
        x2uduQWdyr2Dr+FJ8wnkmNQ=
X-Google-Smtp-Source: ABdhPJwJs3OkR8cf7QrkAb1h1NnyQJIWnGrdgSYlosk+8NdRZN9bt39Y76ii5l5dv0hEWoGMlDFIvg==
X-Received: by 2002:aca:44d6:: with SMTP id r205mr2843243oia.172.1617707632609;
        Tue, 06 Apr 2021 04:13:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id t2sm4008664ool.18.2021.04.06.04.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:13:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] test-tool: test refspec input/output
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Tom Saeger <tom.saeger@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <c8d1de06f84499f2f56b3a06df665630806f94ce.1617627856.git.gitgitgadget@gmail.com>
 <CAPig+cTCeED-Q_64+S5MDVFjCJdnCqYXWNS2ZDWKm4Ehjn=VXw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c3989de-8fe9-b812-edb3-cab1e7227505@gmail.com>
Date:   Tue, 6 Apr 2021 07:13:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTCeED-Q_64+S5MDVFjCJdnCqYXWNS2ZDWKm4Ehjn=VXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 1:52 PM, Eric Sunshine wrote:
> On Mon, Apr 5, 2021 at 9:04 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add a new test-helper, 'test-tool refspec', that currently reads stdin
>> line-by-line and translates the refspecs using the parsing logic of
>> refspec_item_init() and writes them to output.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
>> @@ -0,0 +1,39 @@
>> +int cmd__refspec(int argc, const char **argv)
>> +{
>> +       struct strbuf line = STRBUF_INIT;
>> +       [...]
>> +       return 0;
>> +}
> 
> Leaking `strbuf line` here. Yes, I realize that the function is
> returning and test-tool exiting immediately after this, so not a big
> deal, but it's easy to do this correctly by releasing the strbuf, thus
> setting good precedence for people who might use this as a template
> for new test-tool functions they add in the future.
> 
>> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
>> @@ -93,4 +93,45 @@ test_refspec fetch "refs/heads/${good}"
>> +test_expect_success 'test input/output round trip' '
>> +       cat >input <<-\EOF &&
>> +               +refs/heads/*:refs/remotes/origin/*
>> +               refs/heads/*:refs/remotes/origin/*
>> +               refs/heads/main:refs/remotes/frotz/xyzzy
>> +               :refs/remotes/frotz/deleteme
>> +               ^refs/heads/secrets
>> +               refs/heads/secret:refs/heads/translated
>> +               refs/heads/secret:heads/translated
>> +               refs/heads/secret:remotes/translated
>> +               secret:translated
>> +               refs/heads/*:remotes/xxy/*
>> +               refs/heads*/for-linus:refs/remotes/mine/*
>> +               2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
>> +               HEAD
>> +               @
>> +               :
>> +       EOF
> 
> Over-indented heredoc body. It is customary[1] in this codebase for
> the body and EOF to have the same indentation as the command which
> starts the heredoc.

Good catches. Thanks!
-Stolee
