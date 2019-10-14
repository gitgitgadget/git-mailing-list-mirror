Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0E91F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfJNUlx (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:41:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45888 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbfJNUlw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:41:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so27256614qtj.12
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPQZ85ahToQWqbPncU3itCLrZLgNwX7JyJXRfYL10+Y=;
        b=r7fXFiL6IXspIJvo9m2TAQhFM5viRa/DhMPkrrdtMN8w1/BRB0NM8lVET/Dp74HI03
         uLzzObtHF38Ii72a1jknQhC1Q7AuHmmbKI1U0zOKq2egSuUnkfY/pjZ26zlTMR+bW9hM
         ZCFU6i+Oq+EAbRwvFKeeqfcst/eVBFnkQeW8WfqifWxoe4pGOoomHfim78rDAW6oxDV3
         1Vksp3SuQLL/pwDJcehTUe1G3D95b/VRcw/lgwz5gkYJpKhd2gQ9uTdgXrymp9ngRYr7
         TMmIExnzSuzJNGIwIG01FQKx4Y39Nimi8AQlTW9xP2Wcjj4XPIK8/lvgN3RUgIJPOjVt
         houw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPQZ85ahToQWqbPncU3itCLrZLgNwX7JyJXRfYL10+Y=;
        b=BjwDsMCg0bOo/opf8QbRmemSpjikVeHysUU8JcENqLvZyaH4/PBSivLMsojceiSFBg
         muX7g0GLM+ns0oCCmNel9eK/tghytq7m1AI+49lv2bxuhTynu13KdTKCMOze0yfdF2Dl
         eAacq1+HHYAAINQILAJzGxkSB0CRhlMeNjDKgp2DjdduZDD8omo5bpfz7oBKJCmeVwss
         /qt5ibMoWFj3yZgnJtgUjCF+jKjlw+rP5slWkPRBEpm6UzTkHyZcuT14nAi/IiK4Hx0N
         5SvVCHOlrPNPktzZhmPVbf8WpxZkTF+EtEmustOGovivOw5360iWrUjRksbjAgrAkJI0
         9OVw==
X-Gm-Message-State: APjAAAWob1SZ8IQ7OkyfPnwFMmozsBZrfjUZm8n3cy38/R+4F4Psjb3V
        KB65Y+B+Zw0W/KYIEP539MM=
X-Google-Smtp-Source: APXvYqznu0Fd6pmp8YSjuvli/L0CgAyR63HR+BVgB4qjmaE9NwbmJWEqrwnmXaqHI37wy5kylYpXmw==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr23841066qtd.350.1571085710317;
        Mon, 14 Oct 2019 13:41:50 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4807:bd77:fc97:8ac8? ([2001:4898:a800:1010:f93c:bd77:fc97:8ac8])
        by smtp.gmail.com with ESMTPSA id 44sm10357892qtu.45.2019.10.14.13.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:41:49 -0700 (PDT)
Subject: Re: [PATCH v3 16/17] sparse-checkout: write using lockfile
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
 <pull.316.v3.git.gitgitgadget@gmail.com>
 <8927494b8c418e43f5bbd6e1eb108be5a0a263fc.1570478905.git.gitgitgadget@gmail.com>
 <CABPp-BGCNpZWoWk4coNEpA0zS2g0HXi5Kzb+QVusyLRt0fy=zw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c8bcf25-3c32-8151-fa89-84170cb1aff4@gmail.com>
Date:   Mon, 14 Oct 2019 16:41:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGCNpZWoWk4coNEpA0zS2g0HXi5Kzb+QVusyLRt0fy=zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2019 6:59 PM, Elijah Newren wrote:
> On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> If two 'git sparse-checkout set' subcommands are launched at the
>> same time, the behavior can be unexpected as they compete to write
>> the sparse-checkout file and update the working directory.
>>
>> Take a lockfile around the writes to the sparse-checkout file. In
>> addition, acquire this lock around the working directory update
>> to avoid two commands updating the working directory in different
>> ways.
> 
> Wow, there's something I never would have thought to check.  Did you
> have folks run into this, or is this just some defensive programming?
> Either way, I'm impressed.

This is defensive programming thanks to Kevin Willford's careful
review [1].

-Stolee

[1] https://github.com/microsoft/git/pull/204#discussion_r330252848

