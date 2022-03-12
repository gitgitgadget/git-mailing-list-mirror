Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02334C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiCLRNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 12:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCLRNL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 12:13:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345231680AF
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 09:12:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so10840738pjl.4
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wQ+LOfvhRspRp6zDK3yZT0TrdTTEnKkhocC49aDlyoE=;
        b=ABlOXQXRBBL4Bd1ba1WJ8InnZ12YMDM+hK0+9LZwrnfRc/L/Ol0t+zIiuSYTgMRQia
         pohAyyqgBgBh4kjAXF0jsWc+BFo7DxbqMF9wMK9zTQ5NNsnnH29sDYlZ7WZRK91JjcwI
         UTC0Qh3360xvG9S/wruV9K3ik72DqqSFKdqOWJZrEit0IbkGxrMhWYPvGgjEcxr8PxOY
         emaUaWsa7ef8z/xzjz+i3vXNYIFpc2ofGHJ6+9J9ggWSQCyNJl4Te/69T5KAWreeg0cj
         kiwvhaY0p1QiMHHHO2XsL4CRI4sAYs9z233joL4S01frC7/8rKBqIgjYh0cDQdikmmZx
         t+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wQ+LOfvhRspRp6zDK3yZT0TrdTTEnKkhocC49aDlyoE=;
        b=48v0my8Zt2tWiBAxPl56MH/bNIeyZIQ5hRwBtBV77NeGqh4r86eZecPsSmuXBE6mSJ
         D9Q5Y+LhEexK72rSQmtNmBTWR3EVookhjkGdPGxSGzEc31tpB8KBHDnEhgnDFm2VzcIu
         J04cP2tHrRvy7p5cTw1N/m6q6Zol1CKILfHwrgNGLNC35Y53/10OYk8zAr5G07jP5nkT
         uyEi7TnZqpLu9+nPGQlHfAf/5pcpsDwXzhUAXACjTPS+VmEZjrOKDQwmTu7+pVLaZCOi
         7CINZoCYgZsrHkultpuyb2W3uyOdbM27Z4+rTCI9oipxVjFtgaoHJQXEjeigG1xGPZYb
         /baw==
X-Gm-Message-State: AOAM532jJcvdDr1pUBcnJ5srlMyvMEww2xnF+ydLeqABwy+7+ztc7QsG
        ctQosCy9LVjzVp9DVKI3n5/PZ2CYHpAY
X-Google-Smtp-Source: ABdhPJzhksCD4FACu4RjC96aLXjhDeDbBT1TezEl7NxNXCH7jonBKWTunjXp+dOidj8SGaFv3tqFQg==
X-Received: by 2002:a17:902:eb85:b0:153:1405:9c85 with SMTP id q5-20020a170902eb8500b0015314059c85mr15811742plg.118.1647105124643;
        Sat, 12 Mar 2022 09:12:04 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm14572318pfu.62.2022.03.12.09.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 09:12:04 -0800 (PST)
Message-ID: <3a4594d2-e59d-28dd-290f-adb6fd1740a9@github.com>
Date:   Sat, 12 Mar 2022 09:12:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH 0/5] Separate '--skip-refresh' from '--quiet' in 'reset',
 use '--quiet' internally in 'stash'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye via GitGitGadget wrote:
> In the process of working on tests for 'git stash' sparse index integration,
> I found that the '--quiet' option in 'git stash' does not suppress all
> non-error output when used with '--index'. Specifically, this comes from an
> invocation of 'git reset' without the '--quiet' flag in 'reset_head()'. Upon
> enabling that flag, though, I discovered that 1) 'reset' does not refresh
> the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
> index to be refreshed after the reset.
> 
> This series aims to decouple the "suppress logging" and "skip index refresh"
> behaviors in 'git reset --mixed', then allow 'stash' to internally use reset
> with logs suppressed but index refresh enabled. This is accomplished by
> introducing the '--[no-]refresh' option and 'reset.refresh' config setting
> to 'git reset'. Additionally, in the spirit of backward-compatibility,
> '--quiet' and/or 'reset.quiet=true' without any specified "refresh"
> option/config will continue to skip 'refresh_index(...)'.
> 
> There are also some minor updates to the advice that suggests skipping the
> index refresh:
> 
>  * replace recommendation to use "--quiet" with "--no-refresh"
>  * use 'advise()' rather than 'printf()'
>  * rename the advice config setting from 'advice.resetQuiet' to to
>    'advice.resetNoRefresh'
>  * suppress advice if '--quiet' is specified in 'reset'
> 
> Finally, tests are added to 't7102-reset.sh' verifying whether index refresh
> happens when expected and to 't3903-stash.sh' verifying that 'apply --quiet'
> no longer prints extraneous logs.
> 
> [1] https://lore.kernel.org/git/20181023190423.5772-2-peartben@gmail.com/
> 
> Thanks! -Victoria
> 
> Victoria Dye (5):
>   reset: revise index refresh advice
>   reset: introduce --[no-]refresh option to --mixed
>   reset: replace '--quiet' with '--no-refresh' in performance advice
>   reset: suppress '--no-refresh' advice if logging is silenced
>   stash: make internal resets quiet and refresh index
> 
>  Documentation/config/advice.txt |  8 +--
>  Documentation/git-reset.txt     |  9 ++++
>  advice.c                        |  2 +-
>  advice.h                        |  2 +-
>  builtin/reset.c                 | 21 ++++++--
>  builtin/stash.c                 |  5 +-
>  t/t3903-stash.sh                | 12 +++++
>  t/t7102-reset.sh                | 95 ++++++++++++++++++++++++++++++---
>  8 files changed, 134 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1170%2Fvdye%2Fstash%2Fmake-reset-quiet-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1170/vdye/stash/make-reset-quiet-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1170

It looks like I submitted without updating the cover letter title from a
previous iteration (should be "Allow 'reset --quiet' to refresh the index,
use 'reset --quiet' in 'stash' "). I'll update it in the next version along
with any code changes.

Sorry about that!


