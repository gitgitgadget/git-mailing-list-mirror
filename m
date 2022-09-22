Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86733C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 15:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiIVPaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiIVP3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 11:29:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614ACDF27
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:29:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1580392wms.5
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=jHRQN2cf+9AT8gFqRMmkop+nX/bI3R/N+mlU6sW/1ok=;
        b=ViSZpWln1ptPSvjOMe6Aps7GFPwb8IERFYNbI8jCrFrSXpOMC4prjsYuzi1d+aPynA
         3KRoLO/9G1joZ3g4Z527pPZogs6qqPxlwBITL9Dimm7ESqvQqz+J4MzW+rJ7xW39xIJG
         8QwexwXbBhbwygfUPTJ29JhE4FUd40pDsL//ox84vmxXA9EUkMtnQ8i3wGiq3Rmnm/Eg
         cJ4Wg9nrusQBqTymiCfREchXpwTRYe8jHkA0x7CyJXVkaq2W/q5z1ShKvS5j2Q79Fg5w
         Un+7H+i2G16WqnjUYguzf8fwlT/59qLenoaE476x5i6dGYqNjXJfTbfpWhT+Sblu3dki
         OwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jHRQN2cf+9AT8gFqRMmkop+nX/bI3R/N+mlU6sW/1ok=;
        b=W8KKZ7DtD0m28mHv+hRXjBNH0A6YRnLdhCgNFO8n8SN0dvmS3HXc/SVMM80/5nUUqS
         6fVqh5SnukgQX0y29acHSPpygpCTQVTi0P+x5tXVsaZ80Ihui9y3EyO4JlpQCcVl9hJt
         mqIM3fx5Lt24BbeWLlupmp9RrIyKVQjJbCDnOTUIIu853XpyPUJBS0m4FCySlH13ofMv
         eWtvVrufVwIQ4w7O937AmULYS4oVOeZI7nwLGD0s57BmGwhx8hcuaAZOchlaiSd4MWAM
         ROmxNufobbxwgZeq2l7IZoKCqNjY2gmBGJ2G6Hom3Bxe5l7ne+oYe6vU1b2ZJOgA8jQ3
         hNgw==
X-Gm-Message-State: ACrzQf3qtPIfZzxuXFV2vFCjkr8Bnqlqhu3ToDpNpN3RJ6rrgVUywt2r
        OeWS+C7WnLQuxexsWXCzeH0=
X-Google-Smtp-Source: AMsMyM4So7dGD0Fz8+7tiYE4cwfuXfxZUEzbiVQKC1uB4f/WW5uz/WlcMmuiIRFIDpE5uvmr+/SXIQ==
X-Received: by 2002:a05:600c:42d4:b0:3b3:3de1:7564 with SMTP id j20-20020a05600c42d400b003b33de17564mr2865844wme.152.1663860585415;
        Thu, 22 Sep 2022 08:29:45 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id q18-20020adff952000000b00228d6edade0sm5387878wrr.46.2022.09.22.08.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:29:45 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <ed506937-44fc-125f-7baa-a187b12414c9@dunelm.org.uk>
Date:   Thu, 22 Sep 2022 16:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci: restrict workflow's github token permissions
Content-Language: en-US
To:     Alex via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Alex <aleksandrosansan@gmail.com>
References: <pull.1337.git.git.1663831649705.gitgitgadget@gmail.com>
In-Reply-To: <pull.1337.git.git.1663831649705.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 22/09/2022 08:27, Alex via GitGitGadget wrote:
> From: sashashura <aleksandrosansan@gmail.com>
> 
> Currently the workflow runs with the following permissions:
> GITHUB_TOKEN Permissions
>    Actions: write
>    Checks: write
>    Contents: write
>    Deployments: write
>    Discussions: write
>    Issues: write
>    Metadata: read
>    Packages: write
>    Pages: write
>    PullRequests: write
>    RepositoryProjects: write
>    SecurityEvents: write
>    Statuses: write

Thanks for working on this. On the face of it restricting the 
permissions sounds like a good idea but unfortunately the commit message 
does not explain the reasoning for the change being made or the 
implications of the change. Some of the notes below the '---' line 
should be rewritten into the commit message to explain the change. I 
would also be helpful to briefly explain why we don't need any of these 
permissions. I'm not familiar with github's permissions model so it's 
hard to judge if this is a sensible change. It is not clear to me what 
all the permissions mean - does write permission control writing to my 
fork when I run a ci job or something else? Our ci scripts do cache some 
state between jobs so we can skip running the tests if the tree is 
unchanged, it's not clear if that is affected by this change.

Best Wishes

Phillip

> Signed-off-by: sashashura <aleksandrosansan@gmail.com>
> ---
>      ci: restrict workflow's github token permissions
>      
>      This PR adds explicit permissions section
>      [https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#permissions]
>      to workflows. This is a security best practice because by default
>      workflows run with extended set of permissions
>      [https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token]
>      (except from on: pull_request from external forks
>      [https://securitylab.github.com/research/github-actions-preventing-pwn-requests/]).
>      By specifying any permission explicitly all others are set to none. By
>      using the principle of least privilege the damage a compromised workflow
>      can do (because of an injection
>      [https://securitylab.github.com/research/github-actions-untrusted-input/]
>      or compromised third party tool or action) is restricted. It is
>      recommended to have most strict permissions on the top level
>      [https://github.com/ossf/scorecard/blob/main/docs/checks.md#token-permissions]
>      and grant write permissions on job level
>      [https://docs.github.com/en/actions/using-jobs/assigning-permissions-to-jobs]
>      case by case.
>      
>      check-whitespace.yml is triggered by pull_request only and receives
>      restricted token already. l10n.yml has permissions on job level already.
>      So I didn't make any changes to them. In both cases it is possible to
>      add explicit global lever permissions just for consistency if you
>      prefer. Let me know.
>      
>      Currently
>      [https://github.com/git/git/actions/runs/3100948073/jobs/5021781329] the
>      workflow runs with the following permissions: GITHUB_TOKEN Permissions
>      Actions: write Checks: write Contents: write Deployments: write
>      Discussions: write Issues: write Metadata: read Packages: write Pages:
>      write PullRequests: write RepositoryProjects: write SecurityEvents:
>      write Statuses: write
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1337%2Fsashashura%2Fpatch-2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1337/sashashura/patch-2-v1
> Pull-Request: https://github.com/git/git/pull/1337
> 
>   .github/workflows/main.yml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 831f4df56c5..3ce9302c589 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -5,8 +5,14 @@ on: [push, pull_request]
>   env:
>     DEVELOPER: 1
>   
> +permissions:
> +  contents: read
> +
>   jobs:
>     ci-config:
> +    permissions:
> +      contents: read
> +      actions: read # for github.actions.getWorkflowRun
>       name: config
>       runs-on: ubuntu-latest
>       outputs:
> 
> base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
