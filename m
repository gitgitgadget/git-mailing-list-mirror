Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F58EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 10:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjFXKI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 06:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjFXKIy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 06:08:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D115C6
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 03:08:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f875b267d9so2056730e87.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687601331; x=1690193331;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FI0xr07Xm52DjEg6hMsDSzY06wkxiGa6zrTj3W9adUQ=;
        b=nzhFeiyCWJFd2jdO3cG1FNUTli8N9braA5qQ/HtQqEf4gy4gznjUgpPmeNsL4DXPXs
         LJExwKWzv3wFPguqC6lf4oDfd+saeZ5UwR00Q8kSvYheVolw9+1PXVnAzBJElCgxW6d8
         DFge5MNbSDmMIvSTqZXMdjWVofaHakKBEGPDpXwr6uQd9xNTjkEkzeF2BOyYe2KkNw43
         gsnu6k5HZpMfpAFBfqc2jQQusp6fj1h5eo9fDUs6tOdmKdslUvaDh3Pm1+6iH6EcxceM
         OAa/jjIdgzHuUHP+ryRY7tDqkJM7WMK6JYohYd88TMH8Scb8tceYeZfuXDnlmdav+5Vz
         6NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687601331; x=1690193331;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI0xr07Xm52DjEg6hMsDSzY06wkxiGa6zrTj3W9adUQ=;
        b=cgEENGxiJZLXt5fmsSm9ivW0/vZaN+kI5O+riNBCjz4AzJABrYOGo8z3cME11/WuqD
         jQia8K76LE4ZXQaW3b4tcVYnSalIaBKkzs7VrLbwdE6oYNJTidHEV+svVEq6Q0osx12U
         1FKdoCDIG41Hc2hZqUiI5rWU9RIe72EzrNlonAaj8e3kG7nEsWsO7DPT5c8/O8iccobo
         kpGMnjtbQJ/pJNt5U2FyyzAP+Ps0ZUm7dRJZ6D97G8KGhz9j7U0fEE7d+agU4mEA4Pb5
         4ZiW0FIvE8RWinyhD1Hjqw7bNW9+TnOmfuwdi1si8tKOdOyynXfQJvTiKbtVXwfJKzSE
         riUA==
X-Gm-Message-State: AC+VfDzx5R5JWKd6Fv+c9WWkkPsEV9SUdiIU3kmiLz2UOTtxTtJvRmGX
        xoCf+cBEb8rECfX5yCXeI9SB9KIn00k=
X-Google-Smtp-Source: ACHHUZ7wuFvJACiyFi2Dnx8GpTWqpFY3tG0IOjUqfUC2wuUP1S+sI0OELIMWQn8S537pI/HZYomhng==
X-Received: by 2002:a05:6512:684:b0:4f9:b649:23d2 with SMTP id t4-20020a056512068400b004f9b64923d2mr518708lfe.42.1687601330286;
        Sat, 24 Jun 2023 03:08:50 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id k26-20020a5d525a000000b003078354f774sm1709533wrc.36.2023.06.24.03.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 03:08:49 -0700 (PDT)
Message-ID: <fff79e55-cf35-b5ca-6208-dfa7234be33d@gmail.com>
Date:   Sat, 24 Jun 2023 11:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git apply fails with 'error: git apply: failed to read: No such
 file or directory'
Content-Language: en-US
To:     Premek Vysoky <Premek.Vysoky@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM7PR83MB04183860D4E70F935319E9B9EA23A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <AM7PR83MB04183860D4E70F935319E9B9EA23A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Premek

Thanks for taking the time to report this issue

On 23/06/2023 13:42, Premek Vysoky wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> git clone https://github.com/dotnet/llvm-project
> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da -- ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg'
> mkdir foo
> git -C foo init
> git -C foo apply --cached --ignore-space-change ../llvm.patch
> 
> What did you expect to happen? (Expected behavior)
> Patch should be created and applied to another folder
> 
> What happened instead? (Actual behavior)
> git apply fails with 'error: git apply: failed to read: No such file or directory'
> (and returns 128)

This stems from commit f1c0e3946e (apply: reject patches larger than ~1 
GiB, 2022-10-25). Unfortunately it does not provide a very helpful error 
message. I'll submit a patch later to fix that in the next few days.

Best Wishes

Phillip

> What's different between what you expected and what actually happened?
> There is no error. I tried -v, --reject etc but wasn't able to get any details.
> 
> Anything else you want to add:
> This happens in both Windows and Linux environments.
> 
> I tried analyzing file handlers via procmon.exe and could not see anything. git reads the whole patch and then shuts down. No indication of a file it is trying to open.
> 
> I tried excluding more files from the patch and then I was able to create/apply the patch, like so:
> 
> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da -- ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg' ':(exclude,glob)bolt' ':(exclude,glob)clang/docs' ':(exclude,glob)clang/www' ':(exclude,glob)flang' ':(exclude,glob)libclc' ':(exclude,glob)lldb' ':(exclude,glob)llvm/docs' ':(exclude,glob)mlir' ':(exclude,glob)openmp' ':(exclude,glob)polly' ':(exclude,glob)pstl' ':(exclude,glob)third-party' ':(exclude,glob)**/tests/**'
> 
> But if I do the opposite and create a patch with only the previously excluded files, I'd expect that it breaks. But this works as well!
> 
> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da -- ':(glob)bolt' ':(glob)clang/docs' ':(glob)clang/www' ':(glob)flang' ':(glob)libclc' ':(glob)lldb' ':(glob)llvm/docs' ':(glob)mlir' ':(glob)openmp' ':(glob)polly' ':(glob)pstl' ':(glob)third-party' ':(glob)**/tests/**' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg'
> 
> Only when they are together, git fails. Size of the patch is 1GB but I've had 3GB patches apply successfully before.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.41.0.windows.1
> cpu: x86_64
> built from commit: ff94e79c4724635915dbb3d4ba38f6bb91528260
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 22621
> compiler info: gnuc: 13.1
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
> 
> 
> [Enabled Hooks]
> not run from a git repository - no hooks to show
