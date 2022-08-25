Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0072C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 00:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiHYASR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYASQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 20:18:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70586897
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:18:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cr9so14064169qtb.13
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=mxEttB2v6ZK0Vtu5XytDoKtfKOtfkWEYeFxmDPkELCs=;
        b=GOageVLkxwMoty+tAxxfQ4Q2DJ0PeWQeJjVgAISWLtZ4L7FlxYuKgEdQIJC4nM0ExW
         P5a6eIC2vJiBmHwFLgclpdIWulQ1eB57c5KvFni+rGwJ+tz2ts6R4x8VPhAK4L53evWk
         PJlJC+9fNjT65PjyZZwDlkQuF4XsQ+lfNbeKuSA2GsG8e4kXBxLUJEZq5zwupMsTAkNQ
         nf4mEE2A0Kh6F6ywCskOpTPByH0x8DSLM2PZLaChqj7JGFaClaj39WncM6xdkauLdBSl
         HxvrHcONxMWswwdalDz4lJ7sL6/BcKMINVYwRPvEFQ8b1AOQ/OkVXM4Yxj/DPGxXM6dv
         Zctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=mxEttB2v6ZK0Vtu5XytDoKtfKOtfkWEYeFxmDPkELCs=;
        b=uSrI2NI/etqFlxkrK41AvebHtoBndng408wJCmc+zteSi9mTxPsiU1aRmvi89Xl6vh
         X0OGO9QgA2jEP6rUusu82O1NTqaLv09M/vxlH4BIY7KWsMdUxtNSlJRYaRsJA8oknJFk
         vaBTp6QDU3Yx6rRP/S0t0SRxtUqtO8faOYIIdcJPJj2YgmKYjFddWj2dRX0IPriV4iYy
         3Wj+s7KzS9gMBdFk3cgmYvUu4UaUTDAp61jukwHXK2PYxQJzKSLR6GJhDKhdH1wavNFx
         M/pRA3fUkjZO4P69GLzUz/DVJoQ1VLbVAz3BkMFjCYpgFjvMm4nmVWHVp4MVyvF0UZeI
         cHBg==
X-Gm-Message-State: ACgBeo2VwB/CTvtXrzV658iizYBuHtBqXcPtvNFBpwUwJMsrIgkbOvQu
        NUPYSRpYaX//CH6m6eGXBF8=
X-Google-Smtp-Source: AA6agR4x4SXGYB/73FcVqn0yQ12uyIvDVh7y8qDfiHxvqRUk+TN0Mw42CloFCvHjbOTXxtGJT7hR+A==
X-Received: by 2002:ac8:5c12:0:b0:343:6c0e:df90 with SMTP id i18-20020ac85c12000000b003436c0edf90mr1667794qti.4.1661386694509;
        Wed, 24 Aug 2022 17:18:14 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id v42-20020a05622a18aa00b003436103df40sm14599478qtc.8.2022.08.24.17.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:18:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] built-in add -p: support diff-so-fancy better
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
 <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <241d3760-5b7a-fb3e-00dc-bf54bda92c82@gmail.com>
Date:   Wed, 24 Aug 2022 20:18:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-08-24 à 17:21, Johannes Schindelin via GitGitGadget a écrit :
> Philippe Blain reported in
> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
> that there is a problem when running the built-in version of git add -p with
> diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
> The symptom is this:
> 
>     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'
> 
> 
> This patch series addresses that and should fix
> https://github.com/so-fancy/diff-so-fancy/issues/437
> 
> Changes since v1:
> 
>  * Added a commit to ignore dirty submodules just like the Perl version
>    does.
> 
> Johannes Schindelin (4):
>   t3701: redefine what is "bogus" output of a diff filter
>   add -p: gracefully ignore unparseable hunk headers in colored diffs
>   add -p: handle `diff-so-fancy`'s hunk headers better
>   add -p: ignore dirty submodules
> 
>  add-patch.c                | 24 ++++++++++++++----------
>  t/t3701-add-interactive.sh | 24 +++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1336
> 
> Range-diff vs v1:
> 
>  1:  74ab50eeb1c = 1:  74ab50eeb1c t3701: redefine what is "bogus" output of a diff filter
>  2:  b07f85a0359 = 2:  b07f85a0359 add -p: gracefully ignore unparseable hunk headers in colored diffs
>  3:  9dac9f74d2e = 3:  9dac9f74d2e add -p: handle `diff-so-fancy`'s hunk headers better
>  -:  ----------- > 4:  540ce27c38a add -p: ignore dirty submodules
> 

Thanks, 4/4 fixes the mismatched output bug. Just after I sent my last email, 
I asked myself "but why does 'git add -p' presents dirty submodule to the user,
as they can't be staged?" :) 

A small question about 2/4, any reason why you did not use a "Reported-by:" 
trailer ? Not that I care that much, but I think using such a trailer is more
standard, and makes for easier statistics as it's more parseable :)

Thanks again for the quick fixes,

Philippe.
