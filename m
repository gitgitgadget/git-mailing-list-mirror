Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCAC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C1F64FA6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhCKPQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhCKPPy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:15:54 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35144C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:15:54 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so754683ooa.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Khq0VRVVGhAk4R1uM1M6z4YYYQJjpQFoW0FnJGzGai4=;
        b=vfCY5zLgw4xlaKN+/nDeI5JUt7yTdNUBze07oSen5V5EH/FNwdBk9eNcqwRv5iQ3nz
         7q8apx+wDk9qsGEHUp+fR8Tx4hJYatvrpuP0XuV7GHfGIRMY5hW61dPAm5Zbf3dwd+xU
         7yuPzbtv9lNqKAco83PyNhEh8hmaHmSJ3zimjZ74ipqIK53soslaIa/LkM5K41lSJZfH
         R4nvMKyqV8Nb6pkndSRmINJolR26elQb5uT/WGMwHAx0Lb0nN9ngVpnPBGnU+nK10FAi
         4o7cd85FwQ08p1SjYi++cYGOqJ28iKtZpFBwqXtnVPQcmaOY5dj4sz/7FkL8rF7Fo7c3
         /8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Khq0VRVVGhAk4R1uM1M6z4YYYQJjpQFoW0FnJGzGai4=;
        b=oME5mo2yZMurFqZ1kROFVgrmTIsFxUV+g4rEZnIZxapVjUIYIWukDQUJxxoYU1igtB
         FGpw45pcyUaZcpRfA0Tf1BukLacfwkwG2tzuN7w75zypzE5RQp5EUV1vUGSZGqHeydPC
         2tdcivq1MSej3oiktUy6hpZPiRykdNWTIEJDAjxX5RlOuIkGL+g4jaySSP0iNlIyKAHn
         32UOGeDCOVJA+Jv7nxcMxyYgx96hYw4b+TITfVZK04MdOmxAI21GeHIXA4anR3bhQycc
         xy49pXEq5qIOOKIGkXUzA2d5avZ1vCrxptiPzwEmQ9D0lv8fd0GQL8MRxj3fTR4+G2Oq
         gOtA==
X-Gm-Message-State: AOAM5308lZ22XlqqOnRsZeUJV9Zxdw7V0mF5mq/L1gBV/L3Y9mQkGIYz
        6L6zi411i8Eowe8LbpWUoJc=
X-Google-Smtp-Source: ABdhPJwDQ5Tt3UU7/lpyvWdfmN2J9WnfiyO0WHOQ9V1nQq10+sf0vxCpKvF8SC+BBbFSusXmn8hHbw==
X-Received: by 2002:a05:6820:129:: with SMTP id i9mr6949197ood.80.1615475753449;
        Thu, 11 Mar 2021 07:15:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id z8sm558218oon.10.2021.03.11.07.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 07:15:52 -0800 (PST)
Subject: Re: [PATCH v2 08/10] t: mark several submodule merging tests as fixed
 under merge-ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
 <fcce88c5ac3d317007fd2435f97a9264810e9a22.1615271086.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a69a5fe-8f47-e925-1d20-0e13576fd995@gmail.com>
Date:   Thu, 11 Mar 2021 10:15:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <fcce88c5ac3d317007fd2435f97a9264810e9a22.1615271086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 1:24 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> merge-ort handles submodules (and directory/file conflicts in general)
> differently than merge-recursive does; it basically puts all the special
> handling for different filetypes into one place in the codebase instead
> of needing special handling for different filetypes in many different
> code paths.  This one code path in merge-ort could perhaps use some work
> still (there are still test_expect_failure cases in the testsuite), but
> it passes all the tests that merge-recursive does as well as 12
> additional ones that merge-recursive fails.  Mark those 12 tests as
> test_expect_success under merge-ort.

Nice!
-Stolee

