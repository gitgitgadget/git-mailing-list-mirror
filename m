Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49753C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D487610C8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhEaDZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 23:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 23:25:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D3C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:24:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so1126515pjq.3
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gtoqJUPXgxcvhLDJSFxKiJ8ZAv69ayH85T/2SM4+Yf8=;
        b=FaDywba7hJthb1MYh3VCu9gTA/0seFj8My6lg2AWIq63yIeIiwyQZFWkoMitdJ3h1q
         VXIPdw7laFNPjJnkAPku91vIVUoko6goXgfSWrYACuCC7Gmvm+/+c0JEPNSLrL0aITda
         Lbpo0xWs/+CB0jjxBAsN1m3idtYE6R6g+w6kaMq9j32iNsLAyois/9974e1C46qjvaub
         YviIrvskIzUVvOtzVb39eb3Y5DFN8sXH3Yt4ATjap8p2GB+xS6OAH5kgpNfrBNDZJQpV
         /N7snx/7uY0ic9dMfZBdwbuZqh0hPdUwr7ymhLVrS2VjeJYMps/67gDcIlz4i6MhC7LY
         Xv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtoqJUPXgxcvhLDJSFxKiJ8ZAv69ayH85T/2SM4+Yf8=;
        b=Lq8NFOPm76HF3FiWwVMO4af7ysDhWtnRfdQ1e4N3hH60pUQjuoB5gAd2+twaEesqpC
         vRLG0bK4w9CECVIna15Df2puJKYw38spnOAtyHNALe2bisiT6WcaYUkPpvzibjQhoN13
         be6daITkPJCrTBex5noo3xes219c601W7yGMZDtLr8IG+P4vDxVm+cYrUYf3yhTFCvZF
         i6CkSH7CNUOlS03TdU98lUvw92izqyUPNqg6mJHGsytzks46QhKH3rrtn/c0AoWEHWiC
         ktcRuqixonkLXvMBtHO3wW7xbdD9jieS4/uuz6V/lQUdRTeVcBibdAN/QD4MZo8RkknV
         BFfQ==
X-Gm-Message-State: AOAM532Xe32OPqCcJZ7yQFL29gkVXy4Lp1HcHN6wl4lVp/4WbnjqoiO5
        1UsTKhgte1OCgMkgF4xXSu2vUqzClG4wjA==
X-Google-Smtp-Source: ABdhPJxRTGPklEGDmvMQK+RxH/oGWM8NE5pjIuexqXYIxToPrp0zR8vLer6Xzis7fS4eM8aFr+Ge6g==
X-Received: by 2002:a17:90a:ab8c:: with SMTP id n12mr16517668pjq.201.1622431455059;
        Sun, 30 May 2021 20:24:15 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id f5sm9368924pjp.37.2021.05.30.20.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 20:24:14 -0700 (PDT)
Subject: Re: [BUG] gitk error - can't read "arcnos()": no such element in
 array
To:     Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
References: <CAFOYHZBAg7pkise8bir7Z3qApw9mJB8Z99p6z71-_T6=7rFV7w@mail.gmail.com>
 <CAFOYHZAfQivHvs5=hGt-A1CbtwW-iJSwC1iFk7FY3wnNcVNVrQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <aa18c448-9a74-0837-a2bb-008aab31f0e4@gmail.com>
Date:   Mon, 31 May 2021 10:24:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAFOYHZAfQivHvs5=hGt-A1CbtwW-iJSwC1iFk7FY3wnNcVNVrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/21 10.11, Chris Packham wrote:
> This seems to have fallen on the floor (so I pick memorial weekend in
> the US to give it a ping).
> 
> I have tried building gitk from source (git://ozlabs.org/~paulus/gitk)
> and still see the same problem. Still haven't reproduced it on
> anything other than my one repository.
> 

So this issue is repo-specific, right?

Is your problematic repo public? If so, we can test against that.

-- 
An old man doll... just what I always wanted! - Clara
