Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05453C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13636511D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhCPRCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbhCPRBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 13:01:53 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E265C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:01:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso7226074otq.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WltcCabfx1FHkqRt0HvDWnfvSfa+6EGgUzObgHG4EOE=;
        b=GKI+d65GXLsDW3LJv4uyxJjx6E1JU+g1fQddxbW5eADUlIwpCbis9KiakK9BcHMCGd
         8tNyuCzkiH69qyzl/AUcle4t/MMM+U/7sV8gsH4K6/nsy6HWcK4bg02YldrMiAyFtrEW
         0Ew6Gi3x/APHZd7coasdMWx9pdBbbJmxWUQLYz+KsDOnK3Mq8IjjyeTeCnylxggf9q49
         SYMWGtabpRBwx92vNjPHwSdHKC4DaI/zNcNltwEKQS+fH7HB+nT5noboDFIWcOYIfyti
         efPK8NbuUq3eiJdeWIGewLGwAxZMZVC6BhuEI6ifPm0k+gJuiaqLvzh9j6E6kYFj1XC2
         HMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WltcCabfx1FHkqRt0HvDWnfvSfa+6EGgUzObgHG4EOE=;
        b=U3p+5RnqMq70slKKxiDNdGHFul9f3RbXICbzVhhajH45pbU4RLcc65Ty6OJztalaNn
         as/bd6JtA/Ii7zTLDfsB6Kwb2HtV82fOaGFF2kxIjo4gIf3zCcseVmocRHTbqjFv9yH2
         eA0XEZk1GFACqxyHK1q021RXxUV+3LBShtz1pTiy6m88hOeDd/ofEKg5/vCrmIAcNIoj
         IX0CG7ncBCxqz5SZlh7zSdRGp0cu8Oe9ReONngAbx8oG0fq0C1/U2RUehZPS6U3NF8v5
         WQYjKtGBxtoQYNYOK3IX6n7mZ9+SGEMuCSr5DlLsYF+M4TymYBORmNl16Eazs6Jt17pE
         c/YA==
X-Gm-Message-State: AOAM530xZEhpIktRdAed4YFVQZVHRUcd8/pvCLEY6Gmg5fAwqKhzQ5q7
        nzQs4HTraxZJMFOIYv2ws6M=
X-Google-Smtp-Source: ABdhPJyUhHcBjlu3C68GEiiuVxQq1pb6hopkYBz1lffAYzOFcU19+NaCYm+ej+/f7aqhgQHDtXCizQ==
X-Received: by 2002:a05:6830:558:: with SMTP id l24mr4444423otb.209.1615914111913;
        Tue, 16 Mar 2021 10:01:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id k24sm7400542oic.51.2021.03.16.10.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:01:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] Declare merge-ort ready for general usage
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <44487d2a-f591-7e0f-8532-41397ec805c9@gmail.com>
Date:   Tue, 16 Mar 2021 13:01:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.905.git.1615867503.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 12:05 AM, Elijah Newren via GitGitGadget wrote:
> This tiny series depends on ort-perf-batch-10[1].
> 
> If the ort-remainder topic[2] is merged with this series, then the result is
> a version of merge-ort ready for general usage. Users can select it by (a)
> passing -sort to either git merge or git rebase, or (b) by setting
> pull.twohead=ort [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.

Does the other topic add GIT_TEST_MERGE_ALGORITHM=ort to the CI builds?

Specifically, the Linux builds have a second run with some optional
GIT_TEST_* environment variables. This seems like a nice addition.
 Other than that extra request, this series was easy to review. LGTM.
-Stolee
