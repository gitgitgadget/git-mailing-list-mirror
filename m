Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53EC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbiHRNT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbiHRNT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:19:27 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F996FDA
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:19:26 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b15so775407ilq.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EBdOgjBhrQ9eO+qZDsaaUkd8zn0ZCLHGN0nhuTWcc2s=;
        b=cFyDhLRpZEaVf5lXXz/WqnBCjV91oyUXcLfnOxAvK9wlu0IfrBPmxr4m8oOLkMkCPv
         lgsEhYdifOV1KocFtsv/2SAgimZwbHtrFHNonYoZoZFCRE0SF8yUasDru23OzziURLJv
         0QSBxM7apHffXtGIr1bxXiKSgJ08ySMM0m84uddDDqweqxLYmd5OTocU6NnIvtmShzAP
         DEwoHFZclzMK18UMUT59HjhlxK1Kw/Za7g7u+rPntQLK0oHa63LMTsX5rf0gDNCYih5y
         M8SFQ0MGdqZ0FxxNKZfzaVMImUfdwJjkG1+BkrFG1k6X8b+8mFZ7GLiUdlxykXYEJxLf
         SlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EBdOgjBhrQ9eO+qZDsaaUkd8zn0ZCLHGN0nhuTWcc2s=;
        b=t/ptlAaVlJsfZNbRfp/lnMjixGU7LcF3iGGz+j1LTf+VMKDEUR0iW/iypwWeHzfCmn
         GNbTJisHVf5mD76CegMR+jpAeM1F4bVnzR0uhGMOIGUIHWbTXlwNv22rIYSBlX00nbVA
         TCikIm3lKEC1TpIGUIJUDNiygkNqoYOAfq0usGvzOyVy5CoVVscf8tuQKA6GqePkYVtn
         m5Qa6T+5Hh6CTgqEONkQlY3LlZZguq/zqjPG2277jBXwYb67OZm9rMwpKT35QlT8ZhjQ
         Vjdujr/SxJ+JBohLUP1FP3BJ9kwzURLUidlpi36Yxt3K1eEN3Nyxwi17MWsWWniGcXDY
         OV6w==
X-Gm-Message-State: ACgBeo2ivk/wrAhZ+Qfo9iw9WJSrf4/AYy5odwgc8IygshvjZfu7jkmB
        dZDdRwyjG35Qcwa0mKADU9SF
X-Google-Smtp-Source: AA6agR42vmYOVb78MYtJh1hUHOWU9OiUeQnt4dTKVs4bsE9aQotUnXtT6bOf2jd3l+fGfQcRhokepw==
X-Received: by 2002:a05:6e02:80a:b0:2e3:4975:bf8a with SMTP id u10-20020a056e02080a00b002e34975bf8amr1300954ilm.316.1660828765443;
        Thu, 18 Aug 2022 06:19:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6? ([2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6])
        by smtp.gmail.com with ESMTPSA id d18-20020a056602185200b00688eee7588asm851380ioi.32.2022.08.18.06.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:19:25 -0700 (PDT)
Message-ID: <82716e5b-3522-68f5-7479-1b39811e0cb2@github.com>
Date:   Thu, 18 Aug 2022 09:19:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/5] scalar: enable built-in FSMonitor on `register`
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
 <f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com>
 <3a238691-c37f-39a1-f4f6-2b8f9b4c4dcb@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3a238691-c37f-39a1-f4f6-2b8f9b4c4dcb@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 7:47 PM, Victoria Dye wrote:

> (warning: long-winded tangent mostly unrelated to FSMonitor)
> 
> In the process of testing FSMonitor behavior, I think found other issues
> with Scalar registration. Specifically, the test I wrote attempted to
> 'scalar register' a bare repo, since bare directories are incompatible with
> FSMonitor. After seeing that FSMonitor was *not* incompatible with the
> repository, I found that Scalar was 1) ignoring the bare repository and, as

This is interesting, that Scalar doesn't recognize a bare repo. There are
definitely some config settings that it recommends that don't make sense
in a bare repo, but it's interesting that it completely ignores it. Good
find.

I'm not sure there is anything to 'fix' except maybe error out when the
discovered Git repository is bare. Add a warning, at minimum.

> a result, 2) identifying my Git clone (way above GIT_CEILING_DIRECTORIES) as
> the "enlistment root". I think 1) might be fine as-is - uniformly ignoring
> bare repos seems like a reasonable choice - but 2) seems like more of a
> problem. 

...

> The current usage of GIT_CEILING_DIRECTORIES relies on the fact that, when
> invoking a normal 'git' command, 'setup_git_directory()' only searches
> upwards from the current working directory to find the repo root; it's a
> clear "yes" or "no" as to whether that search passes a ceiling directory.
> Scalar isn't as clear, since it searches for the repo root both "downwards"
> into '<dir>/src' *and* upwards through the parents of '<dir>'. It's not
> totally clear to me what the "right" behavior for Scalar is, but my current
> thought is to follow the same rules as 'setup_git_directory()', but for the
> *enlistment* root rather than the repository root. It's more restrictive
> than GIT_CEILING_DIRECTORIES on a normal git repo, e.g.:
> 
> 1. 'GIT_CEILING_DIRECTORIES=somedir/enlistment git -C somedir/enlistment/src status' 
>    is valid.
> 2. 'GIT_CEILING_DIRECTORIES=somedir/enlistment scalar register somedir/enlistment/src'
>    is not valid.

This is interesting, that we can't recognize the ceiling as the root.

> but since Scalar works on the entire enlistment (not just the repo inside of
> it), I think it makes sense to prevent it from crossing a ceiling directory
> boundary.

I think the enlistment root was something that was inherited from VFS for
Git, and we can mostly abandon it. The things we need to do are all based
on the Git repository itself, not the parent. The only thing we need to
keep is to allow a user to specify the repo by pointing to the directory
immediately above the 'src' directory.

> 'scalar register somedir/enlistment/test/data' will search:
> 
>   * somedir/enlistment/test/data/src
>   * somedir/enlistment/test/data
>   * somedir/enlistment/test/src
>   * somedir/enlistment/test
>   * somedir/enlistment/src

Instead, we could do the following on a specified <dir>:

 * If <dir>/src exists, find the Git directory by finding the first Git
   repository containing <dir>/src.
 * Otherwise, find the first Git repository containing <dir>.

Is there an easy way to discover a Git repository at a specific directory?
Or, do we do something simpler, like changing directories then calling
setup_git_directory()? I think simplifying the logic that way should
respect GIT_CEILING_DIRECTORIES correctly.

Thanks,
-Stolee
