Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D130AC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A734F2075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPRVnICA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgH1Psw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgH1Psu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:48:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD500C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:48:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id p65so448499qtd.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Yk0FgtJMA351E2Jl38HcX4flzNOyXj7ls10lZRoEmc4=;
        b=bPRVnICAyKbjTtpPJpDMOXbGyTdIJI3IaZSfsRkoEkup7OwdNp17LIvr9+lgvON9Sp
         gzkfo8c5i+21NHSXsBQrdZh5cwb3YgJkT/w05RPNVShOGd+/3W9p92pxpREcscFccYwQ
         u2wTYeETuNYzIZbzFiiYoPqz3yrxvmfOh2AfCiNJaSW29tGfQULUecdUF7xRh2aPtTFW
         PUP6UngjYfRp45rWrV3SZ3qWR3rKN1IHlkvjgmFW00ynD7/ophYzuZvn6IZlH+//ZpeH
         K/YE8ETZjyDsaXbzG/kwvVdzu5ecA8BmNKZRzQ73UNgWhJYPQdtrerJ0nrdDTKdw+NWh
         d4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yk0FgtJMA351E2Jl38HcX4flzNOyXj7ls10lZRoEmc4=;
        b=I8yIL9/jJGXLU5W30x1pciqCp2rVtfBElbxWW6tcfpQ9nDGBuTZ7FXQ4Uby9xj6Mgo
         5oElikRRhJtuWn9x8jR9T1I/RsmLZYvjUsL02hAF9ZMuTqXb70bi+hOaFRJkYZdLeieN
         moFNKaWznh6YrFiemx4qWjtr36dSGHxC7P0BLU+OwkXg6zu4sP4n7dSVaZz/f/ReFUJr
         lOoC4HspME6GJd5PC1p6SThqWsnAQ04CLba9uYI90TlVE4YOLLiP2I8xZ22nZ1lAz1XH
         BmHCxsGDs1Ak/r7EtYWqUPBe3kch3aal1ey6G2+YntaF/EWIV280RcPmat1l6Y/MRxED
         WCzw==
X-Gm-Message-State: AOAM531iqu4IsAiV0nKwSCmvKtDVjFFayHDzjLJt3Agj0T7vAmzI+gDo
        0b6QcDG2TAWG50I4kbjfQ2y0zWX1fgw5sw==
X-Google-Smtp-Source: ABdhPJx+uGXiX4JrjZ0SI0P4NQm2nB6vq32bVCli2gOIUljBdI1FN6vDfCqbFyMP7L4Iarw54OUgpA==
X-Received: by 2002:aed:2907:: with SMTP id s7mr1973313qtd.321.1598629728702;
        Fri, 28 Aug 2020 08:48:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b1a6:3982:6cb3:22b6? ([2600:1700:e72:80a0:b1a6:3982:6cb3:22b6])
        by smtp.gmail.com with ESMTPSA id k185sm1077990qkc.77.2020.08.28.08.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:48:48 -0700 (PDT)
Subject: ds/maintenance-part-[1-2] (was: What's cooking in git.git (Aug 2020,
 #07; Thu, 27))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9cfbbaec-bf7d-2ed1-6b8b-0fdc8f94d094@gmail.com>
Date:   Fri, 28 Aug 2020 11:48:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2020 5:43 PM, Junio C Hamano wrote:
> * ds/maintenance-part-2 (2020-08-25) 8 commits
>  - maintenance: add incremental-repack auto condition
>  - maintenance: auto-size incremental-repack batch
>  - maintenance: add incremental-repack task
>  - midx: use start_delayed_progress()
>  - midx: enable core.multiPackIndex by default
>  - maintenance: create auto condition for loose-objects
>  - maintenance: add loose-objects task
>  - maintenance: add prefetch task
>  (this branch uses ds/maintenance-part-1.)
> 
>  "git maintenance", an extended big brother of "git gc", continues
>  to evolve.

> * ds/maintenance-part-1 (2020-08-25) 11 commits
>  - maintenance: add trace2 regions for task execution
>  - maintenance: add auto condition for commit-graph task
>  - maintenance: use pointers to check --auto
>  - maintenance: create maintenance.<task>.enabled config
>  - maintenance: take a lock on the objects directory
>  - maintenance: add --task option
>  - maintenance: add commit-graph task
>  - maintenance: initialize task array
>  - maintenance: replace run_auto_gc()
>  - maintenance: add --quiet option
>  - maintenance: create basic maintenance runner
>  (this branch is used by ds/maintenance-part-2.)
> 
>  A "git gc"'s big brother has been introduced to take care of more
>  repository maintenance tasks, not limited to the object database
>  cleaning.
> 
>  Comments?

Thanks for calling out a call for comments here.

I appreciate all of the comments on these series. It has
really improved the feature.

I'm interested to hear who still has this on their list
to review or if there are some remaining unresolved
issues.

I sent my "RFC v3" [1] for the background portion of
maintenance, and hope to send a non-RFC version next week
if there are no more radical shifts in the strategy. Please
take a look if you are interested.

[1] https://lore.kernel.org/git/pull.680.v3.git.1598629517.gitgitgadget@gmail.com/

Thanks,
-Stolee
