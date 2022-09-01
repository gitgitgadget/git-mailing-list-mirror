Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA5ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiIATSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIATSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 15:18:24 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50A974BAB
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 12:18:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 62so15453011iov.5
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=all2eyHfpAvQn2zTW1ICJkUIa+P5ZvoguSIqH1AmshA=;
        b=NAIaGL0V2+rg3Qs4e4B+HGw+qzmihSmmKldcKfES0EgU7i7PFrUUXL+XCgpFvHnLq6
         p0/zQ6cNuU7Riisu89QXI07r/5aYzuhHXKmOBTDZSRIP5pgImlqthtU4Nv59PZ+p6IpK
         wVzj1Cbqcv7J2n8Z9No1rWwU0RSa/oWF+yPQMKEGbbK7z9TyRh76eDdZBHX9eDejEkn3
         eneBedNsw4jZcbRWtUXjsU1mTJ+YQP2Kx14fnstZspmJejgjjdXyyoE4KsG+5bWRel9Q
         QIEoppjCTvlsCI/2ak79QPD0W7LdIqeVjkTbEmh+jdePojHC03bS1MOcIKIU5xJxM4hb
         cWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=all2eyHfpAvQn2zTW1ICJkUIa+P5ZvoguSIqH1AmshA=;
        b=nXfWa1VX5q0fUJL33qhfehlKWQc9pbjI9h2z2g/TAzVKm9z6jWgGHqSj0d9JabtMdB
         nXxHodRa8DrsIezZ7sp4MjOiu+sUY2WhVwSv3hR+Gx+DwtY9e7lgBP+KKCtNocBHnqDG
         FeS6eWrpcaw4a+MS0RVkfvg7XQO4fcAMwkR2JOiK6FnIBc82ZPRzCFZJLhb5urOZU000
         fjmAsNs1MGfIuyNOv8sHVm2rmbYzyhHrCCM72ZXkExjJRI1PTXbgZZEatYXyp1rnbgQ0
         S3J4WQkScAxYKQiyhh/jMXgunrSq4E5bfPEi724nRxegFoBsVCb7GveDX2f/QAFdLbFE
         4Z1g==
X-Gm-Message-State: ACgBeo0dz+jRrEHprg8+JbKOtLJCDU1oey1mv2IbB2eNAVGCriQIeA6M
        dAH9frtImvSXO0AGQl3UJ57J
X-Google-Smtp-Source: AA6agR4QJYqrAgSNyZ8ofaYQ9A8wIVNWAExpM5hj1Q4m3kmDh824tqhz1EVOXLH8jhohq9swjCBwew==
X-Received: by 2002:a05:6638:4811:b0:349:d619:a9d9 with SMTP id cp17-20020a056638481100b00349d619a9d9mr18259113jab.240.1662059903259;
        Thu, 01 Sep 2022 12:18:23 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m15-20020a5d968f000000b0068998da3851sm9172138ion.52.2022.09.01.12.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 12:18:22 -0700 (PDT)
Message-ID: <8b9e8c2d-7a64-2d66-83a8-2a7daff9a81c@github.com>
Date:   Thu, 1 Sep 2022 15:18:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] commit-graph: let commit graph respect commit graft
Content-Language: en-US
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
 <19fd72c34dcd1332df638d76b0b028e9d9da3d41.1662025272.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <19fd72c34dcd1332df638d76b0b028e9d9da3d41.1662025272.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 5:41 AM, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> In repo_parse_commit_internal(), if we want to use
> commit graph, it will call parse_commit_in_graph() to
> parse commit's content from commit graph, otherwise
> call repo_read_object_file() to parse commit's content
> from commit object.
> 
> repo_read_object_file() will respect commit graft,
> which can correctly amend commit's parents. But
> parse_commit_in_graph() not. Inconsistencies here may
> result in incorrect processing of shallow clone.
> 
> So let parse_commit_in_graph() respect commit graft as
> repo_read_object_file() does, which can solve this problem.

If grafts or replace-objects exist, then the commit-graph
is disabled and this code will never be called. I would
expect a test case demonstrating the change in behavior
here, but that is impossible.

The commit-graph parsing should not be bogged down with
this logic.

Thanks,
-Stolee

