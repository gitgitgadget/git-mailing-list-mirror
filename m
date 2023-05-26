Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C614C7EE23
	for <git@archiver.kernel.org>; Fri, 26 May 2023 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjEZPsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbjEZPsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 11:48:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19181F3
        for <git@vger.kernel.org>; Fri, 26 May 2023 08:48:09 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bad041bf313so1509864276.0
        for <git@vger.kernel.org>; Fri, 26 May 2023 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685116088; x=1687708088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNuxT9nbZz1VCFOVBGo4yUFGT2RFNVG0JIp1UEWg0ts=;
        b=gKe4utJBGBGyRg7XsktXn29m06FGx20SaQYulrI0YxYeZ6NFU+e6jRV7sgX0Q4FJdk
         rkxK3s1Rgp20GqrUdu7CNUeE8SUeYEuWhOyMRUIDLHtTCipfdgtEP4TlTttcJAGCd0Me
         Mk11ODbyYc747zicJbJtPtnszgy2wB5Vgc1CEcAUfoaWlAyKYSV1HxxQk3J8sE1mi+5M
         CHBjtP/05X61VSyPqxYG3sKEDdty8eozyTJzEF/JKOaukmOg+8YMH12OOF60g1yPMnH1
         i3+qi5v+2VGMeacVRs25RMT5+OS+rWRw6dbX5hASnqoYCN1Hg+Viz2eQFp99A7uyaRpF
         BRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116088; x=1687708088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNuxT9nbZz1VCFOVBGo4yUFGT2RFNVG0JIp1UEWg0ts=;
        b=Y45lbVQ1zs4544OuiT9LIv6i+xt/zNlRYGxDhvDPB1hyO5eohS59ekv/sIyOpFS11e
         hGsyoB2jtvWmVpnLU+OEVdB+1c2XKpAQ4qkO4fCjHdazcF/WDH220oNjSTe2WSaDw9N8
         Lt6Wb+cj6UC35Yf1oreXVOo0zx8OgPQbXwblvoMVprm4h1NaaFkihS5u3kHc4dADRFsV
         Y9ibLr94dpIni15xqzgfd1zgQ4H5jDzFzQ52JY1ppvQlbye4ItVzhFgHmyqHhEftxbtG
         j1AwTpXRTHRtIJkubgCB/3dG93tly66gcxn/w7F1CSYWAkjuMYIQftX9l/PR05RXKDhl
         6zRw==
X-Gm-Message-State: AC+VfDxz21VEQKu44gZZ43lC5EKfzqGKJLqlRfvMqsijbHUR1m8/al3k
        1uf8R1hCjFEbioj/XM8Se8b1
X-Google-Smtp-Source: ACHHUZ7QT7Y2b6HKskGZsP1KOUs6svFvQj860oSJ7lYtXu7MGJhXXDJ2qwMzfft3V/ntZRFNgdK5Ow==
X-Received: by 2002:a0d:d5d1:0:b0:561:aa98:1a99 with SMTP id x200-20020a0dd5d1000000b00561aa981a99mr2195468ywd.45.1685116088260;
        Fri, 26 May 2023 08:48:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ac38:474f:c310:a7c6? ([2600:1700:e72:80a0:ac38:474f:c310:a7c6])
        by smtp.gmail.com with ESMTPSA id d17-20020a0ddb11000000b005623ae13106sm1247201ywe.100.2023.05.26.08.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 08:48:07 -0700 (PDT)
Message-ID: <3145f4f3-7bd4-8a1b-4943-11b7d22b60c6@github.com>
Date:   Fri, 26 May 2023 11:48:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v2 0/3] Fix behavior of worktree config in submodules
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/25/2023 9:32 PM, Victoria Dye via GitGitGadget wrote:
> About a year ago, discussion on the sparse index integration of 'git grep'
> surfaced larger incompatibilities between sparse-checkout and submodules
> [1]. This series fixes one of the underlying issues to that incompatibility,
> which is that the worktree config of the submodule (where
> 'core.sparseCheckout', 'core.sparseCheckoutCone', and 'index.sparse' are
> set) is not used when operating on the submodule from its super project
> (e.g., in a command with '--recurse-submodules').
> 
> The outcome of this series is that 'extensions.worktreeConfig' and the
> contents of the repository's worktree config are read and applied to (and
> only to) the relevant repo when working in a super project/submodule setup.
> This alone doesn't fix sparse-checkout/submodule interoperability; the
> additional changes needed for that will be submitted in a later series. I'm
> also hoping this will help (or at least not hurt) the work to avoid use of
> global state in config parsing [2].
> 
> 
> Changes since V1
> ================
> 
>  * In 't3007', replaced manual 'git config'/'test_when_finished "git config
>    --unset"' pairs with 'test_config' helper. Updated 'test_config' to
>    handle the '--worktree' option.
>  * Updated commit messages & test comments to better explain the purpose and
>    more subtle functionality details to the new tests
>  * Added a commit to move 'struct repository' out of 'git_config_source',
>    rather than creating a dummy 'config_source' just to hold a repository
>    instance.
>  * Changed the config setting in the new tests from 'feature.experimental'
>    to 'index.sparse' to tie these changes to their intended use case.
>  * "super project" -> "superproject"

Thanks for these updates. I'm happy with this version.

Thanks,
-Stolee
