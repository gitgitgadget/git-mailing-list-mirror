Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730ACC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D226141C
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhD3MXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhD3MXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 08:23:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93302C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 05:22:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d124so5575924pfa.13
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w7esWa65SUJHGYFxVG3UIadh5T+j7CIFzMyW1Foj4Rg=;
        b=eb2MlPt8mgtLvAvNF3cSwfIbNrvffP+DhkZE8rvj0KrkCuZ5Rmx4twyRXLTXkn/tpC
         oH0Ww9pmdeQmWw6sq+JNaLmL2cJyQx/1QI7FTddELuqNi9kkFBBWu7hdLdZQICABqhYV
         C8fIvO6/Zw8v8wdAgYDyHrE2QjmXk45YnFxu6LuCeTG9LpVKPltXtvysUkT0DVq9QmL4
         gdAwJGzXAdlTjxFoafL6oAX5NQzto03T1x3xhCtSvOPNQyoKZ6hWZXFBQak2x3p3WXBP
         txrs+Hyh50qbid9RBXv4FtGLlPlzzSjm6eMQaPDGcJXXPCidmCTXUyUegUqgu6E5Zfqk
         lzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7esWa65SUJHGYFxVG3UIadh5T+j7CIFzMyW1Foj4Rg=;
        b=nRb783ssFkjFqJetzQcQ8V0CkQLFUvRvbrXFvTlEw7tnZlY98MP8K0E1TwpN6GZnT3
         Tc8xwSQFs+2JzW45czs/7K/RKsnoY1yN07hzCi5X9jAXO5HLplRIHX2YHWc3oGEtVJ0H
         bpyqQAYKv1uY7S8edaPCwGVVdS9i66RhcuBpRggdrf68G+wCLX3q42uRWA8W0thAJVvp
         3RTOqwZUZEb+KgFn4NmsgJS/HX3xgNNywlYezU1MPc46S2MsMGZaL7yALc7qUBZfioKf
         u1OCPwwbxVU40GJ+FBwyN6ZbNGiJwF+zz6JUIkhOaRH1FTPe0rT0TZoE4DlwgvpW57Dv
         gU2g==
X-Gm-Message-State: AOAM531FJ4LgE8dUrIbihiLANxNYGxCff1xLtI8/0lMWawY69Wz9HQzr
        vwXjJ1qW7Av8Uc46oqPhAKA=
X-Google-Smtp-Source: ABdhPJytPm1ecH2yFqHVf7NjyOoVKHxnBC5VQtqU7Nj2bn9H217iFv5YEqqsvVpaiXfMmv7EEt0fyw==
X-Received: by 2002:a62:754d:0:b029:289:11e7:4103 with SMTP id q74-20020a62754d0000b029028911e74103mr3353782pfc.25.1619785377148;
        Fri, 30 Apr 2021 05:22:57 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id k17sm2061710pfa.68.2021.04.30.05.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 05:22:56 -0700 (PDT)
Subject: Re: [PATCH v3 10/30] subtree: t7900: add a test for the -h flag
To:     Luke Shumaker <lukeshu@lukeshu.com>, git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-11-lukeshu@lukeshu.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <565bbf80-9bdb-699c-ed27-107923e4b94a@gmail.com>
Date:   Fri, 30 Apr 2021 19:22:50 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427211748.2607474-11-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/04/21 04.17, Luke Shumaker wrote:
> It's a dumb test, but it's surprisingly easy to break.

Why did you say that? Very sensitive?

-- 
An old man doll... just what I always wanted! - Clara
