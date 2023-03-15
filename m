Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1572C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjCORyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjCORyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:54:10 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4CC17A
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:54:05 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s12so17077319qtq.11
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678902845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUp4QTfi1M0vw4VjbFTWchDytFFYIATT/Fgt8H2BURk=;
        b=AHkvaSxA/BgPejnmPQPSBIWevoCV0hHuwguKg1z1LBSlTt3mkoIsBnBDHNJJIZxE0v
         EfsDvf+yl6EmfAFQK1Zmj1fxttOR3qV5liRODEhfFAZXGj8w/4L5kOPEEu7Ly+UtxxzY
         Mci7tNICj3HBQ4m24FwgaFeJabrlJRwTGkxbm/cvvrUb93VS5eQoeU3vJWFHpFTcYE3W
         OCErFNHNQqGQFcwH7Jf9e3TFB7B3Qnrtpj4h+vJ8jqNWpebUkQJ1IEIz0IafqWNFNtxf
         HE/oBYmc9qKKWHX1Lb6hVyJ1iDfqlcI/EOaPIna4lCH91QikVyDA/pErkWiiHsNS4gX+
         h5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUp4QTfi1M0vw4VjbFTWchDytFFYIATT/Fgt8H2BURk=;
        b=2R1NRdXMnTrAOJN4WiN505qepuyGdG9aS2zL1j+2Mn45McAznAhdYtGXSEr+SaHmJs
         1DjUO6RcHdyD+5JQnROZ7ExcOsIIR8Qhj8P26VxXJPplmrjQ+XY/67MKo6nOrjYg5Rni
         5h4LZ38Pro6hOTYmnbSZ7yuenXZPkdpTlb/BGBAXDp0Z+NGviKklwizEeMsg0CAra3cb
         VJ83C9RLds8t9mpftnzq00CbU9jqvaPOoMtgUlKs/yZ1L2MCrO1PdmnJ6/ypa0iFVly4
         CSPpj9d+TF6wiDM1spxAOp1cFxLjnCQgb1hP/hMB9sMaIxGv330IVJxsgFGu6sazbPfq
         ROhA==
X-Gm-Message-State: AO0yUKWO8JdFiPjX1jKXAjC9rGiwIGTK+badhrnJN4KZ7o6Q2pE/o5Zt
        EZPUYc6UYvmK66NgTExniu66
X-Google-Smtp-Source: AK7set8x99R5Ny/0Mjx21MEfcL72zvNIUt/FE07CaaWgrN2Q+/Mji/8GThTa3gBYzqFhNEe9a+1tkg==
X-Received: by 2002:ac8:7c53:0:b0:3c0:3b08:2d80 with SMTP id o19-20020ac87c53000000b003c03b082d80mr1123583qtv.63.1678902844798;
        Wed, 15 Mar 2023 10:54:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id u23-20020ac87517000000b003bfb820f17csm4122416qtq.63.2023.03.15.10.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:54:04 -0700 (PDT)
Message-ID: <3e5e654f-f623-0fc8-7f68-11a2aabbf78a@github.com>
Date:   Wed, 15 Mar 2023 13:54:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Join us for Review Club!
To:     Calvin Wan <calvinwan@google.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAFySSZAYmtT8gMTVunn-6RMYzYeDE=CQ5fjSL75xYYROwOhqbw@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAFySSZAYmtT8gMTVunn-6RMYzYeDE=CQ5fjSL75xYYROwOhqbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2023 7:23 PM, Calvin Wan wrote:
> Hi everyone!
> 
> Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
> You can find more info at [1] and on gitcal [2]. We run a session every
> other week, and you can find the full schedule on gitcal.
> 
> This week, we'll be discussing Derek Stolee's new filter for `git
> for-each-ref` [3]. Let me know if you're interested and would
> like to join (off-list is fine), and I'll send you an invite :)

I just submitted a v3 [4], hopefully not _too_ soon before the meeting.

I've arranged to be able to attend, so please send me an invite.

Thanks,
-Stolee

[4] https://lore.kernel.org/git/pull.1489.v3.git.1678902343.gitgitgadget@gmail.com/
