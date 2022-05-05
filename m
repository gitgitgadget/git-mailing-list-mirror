Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB5C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 23:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387132AbiEFAC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387138AbiEFABt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:01:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0F61284
        for <git@vger.kernel.org>; Thu,  5 May 2022 16:57:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t16so4743002qtr.9
        for <git@vger.kernel.org>; Thu, 05 May 2022 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z6KcHMVkCGUlPkk+KafyOfxrFDl1R/bYRJvBvSVNZEQ=;
        b=S6ShkadIM24i8PEAJV88jtYtfmuMaxgl+ZEafxT+k/NZknu/it+uHIbBIKHDnK4xEK
         L6cQLxpNwTu5im7SPwLiyMrDBn/knqmaLrSHVXUIIDW7SUvI7P/vtVB9vwp4Gz1hDyFw
         zI0kCxBVOPx/QGx2bv+RJLfQbMgtni2JP4JcChUbSRurba9Lk2WwR+bUrPZ0WADjVHq9
         5iVRw+XPm6/qtuMm7BEC7kATP7KGRfckBzx3ZlAyVkkuv4u1tckThdXmAVEbhhcuuSaU
         zq4r73J916nM3eKjQMB1InhqFxMcr/ZQDIA9tS+yttYZcrjBSd26x0q8Mh4KAr3b8nS0
         KpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z6KcHMVkCGUlPkk+KafyOfxrFDl1R/bYRJvBvSVNZEQ=;
        b=V/Hbc+Yk8qdwRewxoXGLZuG1/ovwO9Gc1FtwAwBTdn26Z6hqSJKQ3z5MpVugOPWhXV
         56idld2sYifRDPfpVzIk4aaE06tEWDxRLxtzySS2wGj3HZxiA1iEjmdC8wyYlf4Lli5e
         5fDPJzZN7MfLMvq0yaCvcNHNPwW1DNicIFIK7cudmvpam8FXiiHXQTm2yM5ofObcI0A7
         ZnLHMUTNxB6IRoiEQ0Ty91z3YXtHdRh17cKrGodN/gDF1yywvjmzz43xjkt30JlAkAAw
         3NF0wsZHaieUDewf9wMC531VQiK75P3RiPi+FCTeEJHoU36SHLMGqj/XQs6wSco55eUZ
         BcpQ==
X-Gm-Message-State: AOAM532u5lUo7jKbBIFmerRFkz7gdyJ4IhvLH3DnKuxD4cGJyUxhHaYS
        8AEeEcHdcWY20MHgh2wNuig=
X-Google-Smtp-Source: ABdhPJwHJfa6oQo2YV7gMzhG7WD3FrIekCFRA7HMSusAxAH++WB45uPqhBBIlgyWfQ4jvtFCGBQvTA==
X-Received: by 2002:a05:622a:342:b0:2f3:5c21:1bed with SMTP id r2-20020a05622a034200b002f35c211bedmr561610qtw.123.1651795075124;
        Thu, 05 May 2022 16:57:55 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id m11-20020a05620a214b00b0069fc13ce235sm1533962qkm.102.2022.05.05.16.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 16:57:54 -0700 (PDT)
Subject: Re: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
To:     Huang Zou <huang.zou@schrodinger.com>, git@vger.kernel.org
References: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Glen Choo <chooglen@google.com>
Message-ID: <fc492627-c552-10ec-b30c-820299241278@gmail.com>
Date:   Thu, 5 May 2022 19:57:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Huang,

Le 2022-05-02 à 10:42, Huang Zou a écrit :
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1) Set the following configs:
>  git config submodule.recurse true
>  git config fetch.recurseSubmodules false
> 2) On a repo with submodules, run:
> git pull
> 
> What did you expect to happen? (Expected behavior)
> git pull doesn't recursively fetch submodules
> 
> What happened instead? (Actual behavior)
> Submodules are fetched recursively
> 
> What's different between what you expected and what actually happened?
> Submodules are fetched recursively
> 
> Anything else you want to add:
> git fetch works as intended. The documentation for fetch.recurseSubmodules
> states that "This option controls whether git fetch (and the underlying
> fetch in git pull)" so I would naturally expect git pull to behave the same
> as git fetch

I did not try to reproduce, but I took a look at the code and I think I understand
what happens. 

When 'git pull' invokes 'git fetch', it does so by specifically using the '--recurse-submodules'
flag, see [1]. It sends either 'yes', 'no' or 'on-demand' as value, depending on the value
of the local variable 'recurse_submodules'. This variable is initialized to the config value
of 'submodule.recurse' in 'git_pull_config' [2], called at [3], and then overwritten by the value given
explicitely on the command line [4], parsed at [5].

So when 'git fetch' runs when called by 'git pull', it always receive the 
'--recurse-submodules' flag, and thus any config for fetch.recurseSubmodules is ignored
(since explicit command line flags always have precedence over config values).

So one way to fix this would be to also parse 'fetch.recurseSubmodules' in 'git_pull_config',
and send the correct value to the 'git fetch' invocation... Or simpler, call 'git fetch' with
'--recurse-submodules-default' [9] instead...

[sidenote]
I'm thought for a while that it was maybe not a good idea to change the behaviour
in your specific situation. If you have 'submodule.recurse'
set to true and 'fetch.recurseSubmodules' set to false, and if the code is changed so that indeed
'git pull' does not fetch recursively, then the code will still try to update the submodule working
trees after the end of the operation (merge or rebase), see the end of 'cmd_pull' [6], [7]. This  is
OK, because if there are new submodule commits referenced by the superproject and they were not fetched because the 
fetch was not recursive, then the call to 'git submodule update' in update_submodules/rebase_submodule
should fetch them, so no problem there.
[/sidenote]

The bug also exists in other configurations, i.e. you could have 'submodule.recurse' 
set to 'false' or 'true' and 'fetch.recurseSubmodules' set to 'true' or 'on-demand' and then again
the 'git fetch' invocation would ignore the config value.  

So maybe a good way forward would be to change the flag to '--recurse-submodules-default' 
when invoking 'git fetch', so that the following configurations work as expected:
   - submodule.recurse=false / fetch.recurseSubmodules=true       (should fetch)
   - submodule.recurse=false / fetch.recurseSubmodules=on-demand  (should fetch if needed)
   - submodule.recurse=true  / fetch.recurseSubmodules=on-demand  (should fetch if needed)
   - submodule.recurse=true  / fetch.recurseSubmodules=false      (should not fetch)

I hope that helps.
Cheers,

Philippe.

[1] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L539-L551
[2] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L366-L369
[3] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L996
[4] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L122-L125
[5] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L1002
[6] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L1144-L1155
[7] https://github.com/git/git/blob/f5aaf72f1b5aeb3b77bccabce014ea2590e823e2/builtin/pull.c#L624-L648
[8] https://git-scm.com/docs/git-config#Documentation/git-config.txt-fetchrecurseSubmodules
[9] https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt---recurse-submodules-defaultyeson-demand
