Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B3C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbiEPStH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiEPStG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:49:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3E3EAAB
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:49:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id fu47so12757295qtb.5
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Th2P/PLO+5HDe9cb4/gQgiXSeTrxLsF2B8QM++l/cTY=;
        b=WuIYl0EEPgbJYMjv9oQ8NHvbRmALkLKrZS7lcpdhxHQgDcob6UHdyzlxixsrxNyJ2K
         REPRnB1QpQJwLmo/25xzIKcY7r0inZunjCEdJm2OWtrLqclz5RRfpLT/PDt4NwLxssS4
         zHSLZksf2MaLTZdlpXX5jNrgqJCpnhLPIE3WwhmheywxO+U/6gASOdAKiD42X5RySKNd
         bml1+gI1ZHlzjG3QVaAeos6N0eYKLIYe1D5BWkDqrKYJOIsXO5NZ0x/hVl4k10ub+Vus
         2Gws02h2NsTCbex+3jFPuYGE/2U5c4cZuhyTbriUiF9bsPOVTupfFcE2AB52H6tbAwMQ
         jegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Th2P/PLO+5HDe9cb4/gQgiXSeTrxLsF2B8QM++l/cTY=;
        b=vtcoF6iscoF7Vg07Diadf4HIx6aAGfY5ZGJp8t3yynv5MzP814aZCHp2OGoHLH1AfO
         5XSJWJKa3M/RUnNFeIT1AYGngqA1RVPzgwbqT2p9BU6LwZoc/lKJuP7lCbaXVgV3jAxR
         fWyaa3MK7tWNAp7HX/nW+FiwuJc5nfg58jOkNMvdch/IuemIa/SWTw3WJIESYpdI7U3a
         Ef9NHaWPujvKKoh+yZw7yXOwC4y7cgFQ3412IxZGlJdCQmOxAAqkeqGGvLTWMvEFnCVb
         Rimdierl3fzUANmu2qJ8YSqNTdMtvGzRdDkSJzbzZ3DguGgwtavbg7IicAbXlckwDWt6
         ky9g==
X-Gm-Message-State: AOAM531+foD/ZbuRdUKNiXM/OrxNyCTHV5/eHyEC4VXiAOaAQpUzB6ea
        XEV1tiHDJUilFLp+rnRtPLSZ7bUe/xH8
X-Google-Smtp-Source: ABdhPJyRHdS8hv/i5YQQOpnPo+d+d1g+pobHaiYWdhBKsAO21asf6Jjf3fDrrmkkmjGJmgFvh02KkA==
X-Received: by 2002:a05:622a:1b86:b0:2f3:cac9:54b3 with SMTP id bp6-20020a05622a1b8600b002f3cac954b3mr16269666qtb.407.1652726944173;
        Mon, 16 May 2022 11:49:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a875:ee72:945f:af93? ([2600:1700:e72:80a0:a875:ee72:945f:af93])
        by smtp.gmail.com with ESMTPSA id d199-20020ae9efd0000000b0069fc13ce223sm5889701qkg.84.2022.05.16.11.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:49:03 -0700 (PDT)
Message-ID: <c01a4ab9-675d-e0df-dfc9-2ec48a2a3ea2@github.com>
Date:   Mon, 16 May 2022 14:49:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] setup.c: learn discovery.bareRepository=cwd
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <62070aab7eb8734f82e3881e25ff0f9cee6bb077.1652485058.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <62070aab7eb8734f82e3881e25ff0f9cee6bb077.1652485058.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
> 
> Add a 'cwd' option to discovery.bareRepository, which allows a bare
> repository to be used if and only if the cwd is the root of a bare
> repository. This covers the common case where a user works with a bare
> repository by cd-ing into the repository's root.

I don't consider this case valuable. In addition to allowing
the most-common use case, it also allows the most-common route
that an attacker would use to try to get a user to run a Git
command in a malicious embedded bare repo. I think we are
better off without it.

Thanks,
-Stolee
