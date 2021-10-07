Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB5DC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DC261248
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbhJGNhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbhJGNhA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:37:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC8CC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:35:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so7497002otv.4
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=54gSXBajJ0Q5m50lqK56rMl9qe8p7FSs5B2NPtYk8js=;
        b=YDX8Jk5LN+4MiQRgxzleobxArvPquCMYq+OOVUbPEFNEbgwv0hYO+6DDqAWBz3Gn4c
         xNkadY4wSnsxQYTA/Ud3zsJr7Jlxfg3cI+hpT2Au6gMX3q8QM7WUYqcTjzHexluFmnq5
         Z8PcE7mLQ8ijYauI4R+Q+k1UvbsdU6WGxsQeoEnL21nfL9AiIylMMYVePl8ds6NHwLGx
         osYsoYSqmJyM+QClLQQzafNSu4Vs/VNhd5CytNpyT/PQgQ6U0zv+2Wglnfwxt0W9lh6p
         r0mm4ngDqdu1ejN7EZOVy5JWPKZoE4YiXrJnH7RW7sJ8LV7rtjZRDUkbUr9tQ2KfWLI5
         +9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=54gSXBajJ0Q5m50lqK56rMl9qe8p7FSs5B2NPtYk8js=;
        b=GspdqjZ1qbgUT0dn2nw7o6Aw2CRqFlStWKyDY0VtyHDypCool3+hN3IrSFU1WAWjWh
         Q6AroBaE34wyiDyijW8HKhsAoCtIEw970KKDRIIhYe21GAL10qTqzTzXrTp197QiBlt2
         Xo17a6U1Y89F/qpuncv7pRKm7cyzCjMJNPVC0qAlVvYXDEVom35Kob2X1+HymvT8en23
         3TMEs/7nwynVKqsWFtRsUgfyCWOwuomEfeJHqa2exjvEGHIjccdfbiYMiQf6wcUN4vv4
         eAzbSf2tcQwtyeHhYzayCzIdI6EP4iR1soOjJeqoS9Rk3LL0ohbFLEOotDP/mtcv5uiM
         E+hQ==
X-Gm-Message-State: AOAM533nZCdiJqD8LN3UdGJn5Txcqa81zMAOcztL0FrhVf5rgEzQK7q3
        uwBLVuh3Il1mDDgooGtcTf0=
X-Google-Smtp-Source: ABdhPJwD6pEkFy2C0zP3SCupV1SM1cNlDdEnjeiUfMNK20Pj5yMWKdyquaxQGzF0yir7WzdEpPAZIw==
X-Received: by 2002:a9d:7644:: with SMTP id o4mr3630025otl.270.1633613706479;
        Thu, 07 Oct 2021 06:35:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:40be:181f:1763:acf6? ([2600:1700:e72:80a0:40be:181f:1763:acf6])
        by smtp.gmail.com with ESMTPSA id e28sm1420021oth.40.2021.10.07.06.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:35:05 -0700 (PDT)
Message-ID: <a5011892-1dfe-31ab-12fe-d586eb0e9dbd@gmail.com>
Date:   Thu, 7 Oct 2021 09:35:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/2021 5:50 AM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> In a sparse index it is possible for the tree that is being verified
> to be freed while it is being verified. This happens when the index is
> sparse but the cache tree is not and index_name_pos() looks up a path
> from the cache tree that is a descendant of a sparse index entry. That
> triggers a call to ensure_full_index() which frees the cache tree that
> is being verified.  Carrying on trying to verify the tree after this
> results in a use-after-free bug. Instead restart the verification if a
> sparse index is converted to a full index. This bug is triggered by a
> call to reset_head() in "git rebase --apply". Thanks to René Scharfe
> and Derick Stolee for their help analyzing the problem.

nit: s/Derick/Derrick/

Otherwise, this version looks good to me. Thanks for putting the last
bit of polish on it.

I'm taking this patch into our microsoft/git fork as we speak [1].

[1] https://github.com/microsoft/git/pull/439

Thanks,
-Stolee
