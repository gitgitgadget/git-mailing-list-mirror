Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82830C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AF22223D
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V73SA48B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgKPNR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 08:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgKPNR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 08:17:26 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3BBC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:17:26 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d28so16628781qka.11
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vXSYP2NxjrPabAMFHoqAvKZtKN6krXlcc1eCDTvfDWE=;
        b=V73SA48BS7SV9EcbLR07z3XUedo7eavYXSeKW2Rx0cs7Nvz2x5k8SQjomX3onr1myy
         G0b1YA5L++76kxuR8Lh0NVU1K/4kDULpUfIM+4t5rz+P7Os2+e4JMHm3ai7h0aOU7k4j
         n86T2LDelH5vR5L1u/P/IH5dOozSSNCOW/pd8bXmwqHFsgsNnpGf4HPeh3cVrq9pq7oW
         bKMEmyz15rg1usQp+BIjxB9x7YUvyYXCq6KkfKbrZNd4wIvBXUG4jT1wzPD4Pe7OY8wn
         oW1Fzrhxvv9jhewiGNPIG12XFvgNsf40Qe9xxod0vty+FOa7UGlOFY7IWSKCK6GxgDWN
         0KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXSYP2NxjrPabAMFHoqAvKZtKN6krXlcc1eCDTvfDWE=;
        b=haIhmqk2CiJv4M70Z4x/nWXJlVcMBUovukmfsfq+AiJ3zCrvjaH7P24NUCQ+JSb0RS
         h3pZjqw1ZtorvPsnFcT51D4btpWNOQ3JWKzE+3WDNr/WU+3y6WXg3AvUuE8TfriRvRo+
         nqXLqbK89GWqjF7wTSo5WwmiptQ/5BNMFycyY0mg8KGe3N5fSfRSqb2h4XnvCB3OmHyt
         uJxOKDk1Ge5Zal5gX/59w/YHOz1DsTqKHx2BMURvGporTUTxi9FhTnrB149pj4B817wm
         3N+3AahAmLQ+PURA0rDXbwMlaZj6jHHS6awXwbmLllWAMLzqW1HHS2M158+XQWgFMG+w
         bOxA==
X-Gm-Message-State: AOAM531ln4aKA/IuD5Ci1q+ya7by563+ihdHGAVJh6IwccM3OeJpuoVm
        XkbuHWSqTiz5etY2EF1voVs=
X-Google-Smtp-Source: ABdhPJwOchh+WoZwTCn0KPj0rYtggxkfLHL4d97rnXO5XYQFq5Ea4IsFQ6x94qjev9/7/PNRT8Z3GA==
X-Received: by 2002:a37:a4c3:: with SMTP id n186mr1996437qke.495.1605532645839;
        Mon, 16 Nov 2020 05:17:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6dc1:e5c:951b:3570? ([2600:1700:e72:80a0:6dc1:e5c:951b:3570])
        by smtp.gmail.com with UTF8SMTPSA id w81sm12399537qka.124.2020.11.16.05.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 05:17:25 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Maintenance IV: Platform-specific background
 maintenance
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <CAPig+cRPKZGR0XKv4vwtP-xpzYDpB6PL-=Q7weeWtTbDG7o3vQ@mail.gmail.com>
 <X6+iJNYEbpQjHCb0@flurp.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e7f0756-9152-4637-753f-2c3eaa562cdb@gmail.com>
Date:   Mon, 16 Nov 2020 08:17:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <X6+iJNYEbpQjHCb0@flurp.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14/2020 4:23 AM, Eric Sunshine wrote:
> On Fri, Nov 13, 2020 at 03:47:15PM -0500, Eric Sunshine wrote:
>> I forgot to mention a couple things when reviewing the patches
>> individually, so I'll point them out here...
> 
> In v2, you added an `xmllint` check on MacOS after discovering that
> gc.c was generating a malformed .plist file on that platform. That got
> me thinking that it would have been nice to have caught the problem
> earlier, if possible, even without having access to MacOS. Since none
> of the code added to gc.c has a hard platform dependency, it should be
> possible to perform all the tests on any platform rather than
> restricting them to specific platforms via test prerequisites. The
> patch below, which is built atop v3, does just that. It removes the
> conditional compilation directives from gc.c and the prerequisites
> from the test script so that all scheduler-specific code in gc.c is
> tested on all platform.
> 
> The changes made by the patch are intended to be folded into each of
> your patches where appropriate (rather than existing atop your series,
> which, though possible, would be ugly). If you're interested in
> incorporating any of these improvements into v4, you can have my
> "Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>" in addition
> to the Helped-by: you already added.

This approach is fascinating. I will tease it apart to appropriately
incorporate it into my series. Thank you for your sign-off, since
this elevates the patches from "Helped-by" to "Co-authored by".

Thanks,
-Stolee
