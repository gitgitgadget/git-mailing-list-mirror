Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9724AC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD7E61151
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhECLzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhECLzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 07:55:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17922C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 04:54:56 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i17so4662897qki.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9FpnJYsNoSdNR7IPXWNBniGhw57HbPfagSpMALLE63Y=;
        b=CX5sTscaoOjQ8quTrpSO6mM9pX0CdvO3BuNtJgrluIqmF2HDuX6q0NGQqzrXkmUNSE
         7dBoCmRkxnoJctNHjiC9c73RGtjczDlFb+9kFumKIfa/FKpu+Ee06XhyO8OTIfrj8cQt
         PcjVg/ELXnY2S8hUgt5UxERgnEOu9ktuM5wyoqbshmjF0svZSvw4XOhJ5N5/WCZghQq0
         wDa2NMt4IC8TvE5Z3eR6NIhjYSjC1rl47nNm1MKvhMkRuYPPdRCDa3g1FPVsFwrSGhJo
         5fPmyR1/k/LHCwunlhR5u8NIkTVEfc8OO2dacfkXyROnKN1Jmvl6LbwN/jCixzLUWQng
         WSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FpnJYsNoSdNR7IPXWNBniGhw57HbPfagSpMALLE63Y=;
        b=gYjoFeS5AThfrcUOdkHVNGjLaLDYzOpFp/FIY2HjWXKuuW0oHpMclGOocG1pstLSEY
         F+FqAdSa7lzJ8T5Pgi6VJTQnAfaCyZQzmV8SR9f3OYhGtS/VOXKZwZbiPRGGwJOi/Kn0
         ZNmBNr/krvt3mrm3Mg8P5nhsmFSbMNTR37Au5uR8Yv0Z7f9ndRQEA8E08ij5yCjWaU9E
         NI18aJ+k1fbFoIk0nx/NHWk849BhsFc3EqsJSb4+IIfQnLRBMTG4Dck5CWtnUv6LvGGl
         l9ceY5Hixy5sDE/577RPr6MbXR+sMfwFuv0biUfBJW+WGUn2P2XY4MpbWYmz5D8PSMQ8
         DWrA==
X-Gm-Message-State: AOAM530GWe2xc8ucjuLsMjdYteoZXVTfptAYoIVaT1AxzNyiBYQwPmIg
        VpfBfIeaN93ubn59O3GBcuQ=
X-Google-Smtp-Source: ABdhPJyFB9ryFEKvBUDdXYk2SfPd3XeaLU0nSqUilAo2X7WEfrKXq6OVBET9xBvJmNKrG7bbWj8Pqg==
X-Received: by 2002:a37:b142:: with SMTP id a63mr11812360qkf.253.1620042894941;
        Mon, 03 May 2021 04:54:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e8cc:2a25:fb4:a65b? ([2600:1700:e72:80a0:e8cc:2a25:fb4:a65b])
        by smtp.gmail.com with ESMTPSA id m124sm8334024qkc.70.2021.05.03.04.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 04:54:54 -0700 (PDT)
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
 <YIxRbOh4j9eFxBF3@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <237482e4-8e21-5cd0-010e-09fb4ba8d27e@gmail.com>
Date:   Mon, 3 May 2021 07:54:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIxRbOh4j9eFxBF3@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Forgive my top-reply, but this part of the message is intended to
summarize all replies in the thread.)

Thanks, everyone for the thoughtful comments. I appreciate the multiple
directions recommended in the thread, including making this config be a
tri-state with these states:

1. Keep existing behavior.
2. Warn if Git sees credentials in a URL.
3. Die if Git sees credentials in a URL.

This approach provides a good mechanism for transitioning from the
current state (1) to the die state (3): we can set (2) as default for
a while.

I believe something like this will be necessary to alert users who have
already created repositories with credentials in their .git/config files.

But, there is something better we can do that will be more helpful for
users still using this at "git clone" time, without causing serious
damage to automated scenarios:

On 4/30/2021 2:50 PM, Jeff King wrote:
> On Fri, Apr 30, 2021 at 06:37:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Git allows URLs of the following pattern:
>>
>>   https://username:password@domain/route
>>
>> These URLs are then parsed to pull out the username and password for use
>> when authenticating with the URL. Git is careful to anonymize the URL in
>> status messages with transport_anonymize_url(), but it stores the URL as
>> plaintext in the .git/config file. The password may leak in other ways.
> 
> I'm not really opposed to disallowing this entirely (with an escape
> hatch, as you have here), because it really is an awful practice for a
> lot of reasons. But another option we discussed previously was to allow
> the initial clone, but not store the password, which would result in the
> user being prompted for subsequent fetches:
> 
>   https://lore.kernel.org/git/20190519050724.GA26179@sigill.intra.peff.net/
> 
> I think that third patch there is just too gross. But with the first
> two, if you do have a credential helper configured, then:
> 
>   git clone https://user:pass@example.com/repo.git
> 
> would do what you want: clone with that user/pass, and then store the
> result in the credential helper.

This seems like the best approach, as it presents the highest likelihood
of working as expected in the automated scenarios. I will take a look to
see how I could adapt those patches and maybe make the third one better.

I think a combined approach would be good. We should still warn that this
usage pattern is unsafe, because users might use it in an environment
where their commands are being logged and stored another way.

Is it possible that some Git installations have no credential helper? We
can keep the "git clone" working in that scenario by storing the password
in memory until the process completes, but later "git fetch" commands
will fail.

Thanks,
-Stolee
