Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D43C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A1322AAD
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 14:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbhAEOYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbhAEOYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 09:24:25 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD678C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 06:23:44 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id f132so36087604oib.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xZ1Fn2NnZGcCFvNT2oEIi/PJbQJgzEUC9QVQXt8sgMc=;
        b=X1bSGWfXGKJGG/3OGZug7mhqn+7vn9MyZdX5F7In3WtnoUiMFewpqoW6IUOErIQuOa
         SgdYJw3mQJiKZQnPmfIjxKI2lOixQkfIYx5W/QuTtdkuE+wEezdNCQCnmxryhjROzy8R
         DvhvhiUfZJqx1xTpAEpz8kQgTcV06JFoCkbRJAWsqyFI6wJTNIKjRKGEGuUstqr87KKf
         0xb/AepsYUfa94SXR5krmFg/Uqxx3qDgw/b2xcUVc1ggzzA+KGc4ABqzkcL4pO53CCG2
         eCprIBQ9CTXaMS52PUjFrGHkQNNPyMf+CUt9JMqswJw75dcu4SQo8jR3KToYmS5DQMvg
         lGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xZ1Fn2NnZGcCFvNT2oEIi/PJbQJgzEUC9QVQXt8sgMc=;
        b=eLL1+gt6R9kIsIzw0pr0T4U4bdRL4y8/7ovctppPS+XoJeG1QmOTBrlpfQPSxsb6O9
         z6cXOr45KzzRkyl35Txx/a/SkXbHh/N1bwjTlFVAHcTnwwZVBfLpdAQQReKM2F69986B
         JpQCkT6xbzK5ykkPiK+Rt1TNMH4rGe6Lh2LOnRAycLbZbHB0bG0N9cajaVx/qoSeuDre
         XNneOTrmaI18cKD2F7agViDDhfWrNfnzoRAt3WEgufY1yxKw4MQZ4mEGfuyoJi4682JP
         sgCt87EKi2Mwvz0fofCGguySxZZKj7BKdKdzdEN8rvZTljHy8Hn/pvBHbxdZbP7W0TU1
         7M0A==
X-Gm-Message-State: AOAM530I6XMesBzy0S7LDPTYdmxqku7Ys5Sbpb6FC6I391+yKqjhLhDg
        CRXXdfEapezjFP8NP5BpQnA=
X-Google-Smtp-Source: ABdhPJwztS6jxffjAYCpEvr052lt37eRsrxBYpNVsROW2rO5Aqfl9Gj6S3lUs21cL4667W1qA/I9xQ==
X-Received: by 2002:a05:6808:28a:: with SMTP id z10mr2871488oic.174.1609856624023;
        Tue, 05 Jan 2021 06:23:44 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id i16sm14141321otc.61.2021.01.05.06.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 06:23:42 -0800 (PST)
Subject: Re: [PATCH v2 00/10] merge-ort: add more handling of basic conflict
 types
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f6d5428-36ce-3e91-4916-8968ac1b8686@gmail.com>
Date:   Tue, 5 Jan 2021 09:23:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2020 9:34 PM, Elijah Newren via GitGitGadget wrote:
> This series depends on en/merge-ort-2 (it does not depend on en/merge-ort-3
> or en/merge-ort-recursive).
> 
> This series adds handling of additional basic conflict types (directory/file
> conflicts, three-way content merging, very basic submodule divergence
> reconciliation, and different filetypes). This series drops the number of
> test failures under GIT_TEST_MERGE_ALGORITHM=ort by 211 (from 1448 to 1237).
> 
> Further, if en/merge-tests, en/merge-ort-3, en/merge-ort-recursive, and this
> series are all merged down (in any order), then collectively they drop the
> number of test failure under GIT_TEST_MERGE_ALGORITHM=ort from 1448 down to
> 60.

I finished reading the rest of the patches. They are well-organized to
present the merging logic in small chunks.

While this is a very dense series, the proof is in the test cases. I
look forward to testing the ort algorithm in CI builds and start enabling
it in my repositories.

Your patch organization will help if there are bugs that we won't catch
until we can enable this merge algorithm more widely, as we can blame to
these well-crafted patches to assist with debugging.

Thanks,
-Stolee
