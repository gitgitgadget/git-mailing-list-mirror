Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA89DC433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCAE239FD
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbhAUMyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbhAUMyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 07:54:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BFFC061757
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 04:53:27 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id n8so2360165ljg.3
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMMwQ/H5pGYXQQZ7wq7ZSOsvwQ7Y9KrvOYElp2Citp0=;
        b=L0g4JBXIp9TvEwFzZKjtabYSvRb34jFuTJKYwVWS9u8ttLJ4iPkIVZ4p5eY8XB7THj
         76oFJVqXSz1Ke9/DxQ8kiuqmtZxLSd5DiPGxlk8BlVoqJcTGJa3IbVJSSKNmQoGVzns3
         5eGdkFC35pCsAoIE4e4xlXwW/bt6UB7x3LIKHfZUiKu73JH7hCpv+3Tq/ltwlcd0oTNT
         QUTmLMp/fxKIKDnzra3AFN5BakNnYqO4Q735fzCFxmL27a4jtQxuaAchbk0DS3Ldp7YS
         FaaFDjYRuoMHCf474Cn4xH/8H7BpUKOWypTa9ItL63GXAw8ld+xz8trAtD8H/zR1t7j1
         jO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMMwQ/H5pGYXQQZ7wq7ZSOsvwQ7Y9KrvOYElp2Citp0=;
        b=l77iILo7hsikRXWHN7aPKNDK+pd54uvdRJojqCudvvriTpIqrggHge67YADOSLliDz
         gEIss+O1P98V0qSNNyzuWRs25MeNbrRV1m/H2V5kyLgkhD6wczMyHlCFlkCmGbHig7MM
         DkYb5ZmAgFPUA3aiMQNHcKl6eSPEPX98dwVKeOoaGXSkZaTpIzxn2LHl4Iegoa5czn2M
         6FFIa0rZEey3QP2RS4Jt6n1X0mrsdGcGjOvQnvqPbspzikIeNP1SryK3t69M16FZbPmJ
         3m0yXQMWWh199zr+UssQZUPmvMO4e+zRmkmDGMUr/ayP/zIvLh2eHGVDeqqhR9NOfCUW
         KChA==
X-Gm-Message-State: AOAM531LAD/vCWYDGVYLWSEyk7M9dkyiMRwHUXC6xT4Wb7GZIQdt+LMh
        JNpDHjoPL+IGA2cEqsSQpOhAWwBHU+Zj4CzaewM=
X-Google-Smtp-Source: ABdhPJwB0Q0m72ZRoTYwsHS81kPjZ8qZQUgma7lJTORu+Pj9zeFX/vwcfX0LcWgt8QwumsTubDn4tmC23FfNyJsYKPM=
X-Received: by 2002:a2e:9cc3:: with SMTP id g3mr7100031ljj.0.1611233606476;
 Thu, 21 Jan 2021 04:53:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <838922de2e9756c00f4a159b2b8722ae4d28b011.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <838922de2e9756c00f4a159b2b8722ae4d28b011.1611161639.git.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 21 Jan 2021 04:53:15 -0800
Message-ID: <CAPx1GveERs+g6zymyc8AbVudRHz24=N-1WZg+1xj5j1z0prWyg@mail.gmail.com>
Subject: Re: [PATCH 3/9] fsmonitor: de-duplicate BUG()s around dirty bits
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:58 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The index has an fsmonitor_dirty bitmap that records which index entries
> are "dirty" based on the response from the FSMonitor. If this bitmap
> ever grows larger than the index, then there was an error in how it was
> constructed, and it was probably a developer's bug.

Curious: some of the tests were >=, some were > (not >=).  Now
that they're shared in a function they are all ">".

It's pretty clear that for size-based ones, greater-than is the
right test, but for position ones, isn't it still greater-or-equal?  So
perhaps the calls that pass an actual position should add 1...

Chris
