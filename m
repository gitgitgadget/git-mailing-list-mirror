Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84706C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiLSO7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSO6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:58:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496FCE
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:55:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so6610472wmb.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwbHCFGbR3Ifp3W2ULBvGSej60zbGZmAtySsFVfN80g=;
        b=KbTAPIxdE+Nb7mFZ+SYiqDEolbkj70I23xHGKUSWWnZw0TyOyy4STKeN/+g9te4VNd
         e6Ox3iPFIFecfVW9fE6cdHPxPq5d+ckvg2qddxRxXmavJeXRXjwFpkmHU1hXGAmdsxcn
         UClBX1WSZ5aiTkcS5gbvI8S+mc4Q+2fIwH3jQIaP3zudg6cOPr6VooGdEqmvvYta92PG
         p1XMhiCWse6JrOObOoY5OhEMQ1arqKf3TRjQZajEpQrOonp4WbYNIl2pRJNfurKv8D0y
         /jHcXX++rvmf2naDd4LNIzyi+t3WzkEWxLcfQ+5Tz7u/3HqrrB2EplhLI6ayGjEA8QVC
         l2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwbHCFGbR3Ifp3W2ULBvGSej60zbGZmAtySsFVfN80g=;
        b=wg9TedSmb/prt/yO0EZ8Fewsio9SMCoLrWFd2HqqrgfRbdO3D95V3SoUMIiDU6yzxQ
         Vr/dv31urhF0fNw+JUORD7D6oz24UNtqfmx6Be6kHb0w9/VjD3e0w0m/oHI8m8XvmZoI
         cokkDQ4it0+YjpKCjCrNO5WTNwu9c/dIi67YvgZETvNRKl16xwKCkCHT/U5IKobRCLmA
         7acb2FXL/fPXjNMiToViWSYUbcDR0B7Yx1zzZo7zcjXCQ8f+MYjgA3B9j8L9dHRZrlHA
         l0xh8zZV+WGKVEXi/yqiahRBVRo/oXFMjj97/2pw7d25xH5XxosfJ+99ULGjsmleZcYY
         QAJA==
X-Gm-Message-State: AFqh2krVE9rTHMymI/mgLJk9SNbZYdlAeq9wbLdcoTXm6CXyA6uZShzp
        5pSVO9gX5mOU4L1YEacmq0o=
X-Google-Smtp-Source: AMrXdXvOiNYP08Q6sPrdt9waEo9IlwJZ1CHEFztRmXwrEGuX3/Ft/+E5xA6IYakeQY/fxMk/e9RFYQ==
X-Received: by 2002:a7b:cc85:0:b0:3d3:3c93:af34 with SMTP id p5-20020a7bcc85000000b003d33c93af34mr15472568wma.2.1671461735825;
        Mon, 19 Dec 2022 06:55:35 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003cfa80443a0sm12131618wmb.35.2022.12.19.06.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 06:55:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f67e0281-8a14-669d-0d1c-ed0b1351a64a@dunelm.org.uk>
Date:   Mon, 19 Dec 2022 14:55:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] cmake doc: modernize and cross-platform-ize the docs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
In-Reply-To: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 19/12/2022 10:32, Ævar Arnfjörð Bjarmason wrote:
> Change the cmake docs to use one-command build instructions using
> options that "cmake" supports an ill our supported versions, and in
> 2/2 re-arrange the docs to make it clearer which part of the
> instructions are platform-specific.
> 
> Like the just-submitted [1] this extracted from [2], and the range
> diff below is to [2]. The only change since [2] is a trivial reflow
> change in the commit message.
> 
> There were no outstanding issues or feedback with this part of [2], so
> hopefully this can advance relatively quickly.

I'm afraid my inclination would be to let the people who actually use 
CMake make any changes to the CMake documentation as I think they are 
best placed to know what information is most important.

Best Wishes

Phillip

> 1. https://lore.kernel.org/git/patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com/T/#u
> 2. https://lore.kernel.org/git/cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com/
> 
> Ævar Arnfjörð Bjarmason (2):
>    cmake: use "-S" and "-B" to specify source and build directories
>    cmake: update instructions for portable CMakeLists.txt
> 
>   contrib/buildsystems/CMakeLists.txt | 70 ++++++++++++++++++++---------
>   1 file changed, 50 insertions(+), 20 deletions(-)
> 
> Range-diff:
>   1:  fc190b379cd <  -:  ----------- cmake: don't invoke msgfmt with --statistics
>   2:  1a11aa233a3 !  1:  2411acc9d4c cmake: use "-S" and "-B" to specify source and build directories
>      @@ Commit message
>           cmake: use "-S" and "-B" to specify source and build directories
>       
>           Rather than the multi-line "mkdir/cd/cmake" recipe provide an
>      -    equivalent one-liner using the "-S" and "-B" options, and then suggest building with "make -C <build-dir>".
>      +    equivalent one-liner using the "-S" and "-B" options, and then suggest
>      +    building with "make -C <build-dir>".
>       
>           The rest of these instructions discuss e.g. running tests from our
>           top-level "t/" directory, so it's more helpful to avoid changing the
>   3:  b9ddb5db1d3 =  2:  d6058ed0f22 cmake: update instructions for portable CMakeLists.txt
>   4:  7b7850c00ee <  -:  ----------- cmake: don't copy chainlint.pl to build directory
>   5:  82ecb797915 <  -:  ----------- cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>   6:  1f326944a07 <  -:  ----------- cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>   7:  973c8038f54 <  -:  ----------- cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>   8:  b8448c7a8a6 <  -:  ----------- Makefile + test-lib.sh: don't prefer cmake-built to make-built git
>   9:  5135e40969e <  -:  ----------- test-lib.sh: support a "GIT_TEST_BUILD_DIR"
> 10:  65204463730 <  -:  ----------- cmake: optionally be able to run tests before "ctest"
> 11:  e25992b16f1 <  -:  ----------- cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
> 12:  4905ce5321d <  -:  ----------- cmake: increase test timeout on Windows only
> 13:  6c6b530965d <  -:  ----------- cmake: only look for "sh" in "C:/Program Files" on Windows
> 14:  563f1b9b045 <  -:  ----------- cmake: copy over git-p4.py for t983[56] perforce test
> 15:  917a884eb65 <  -:  ----------- CI: add a "linux-cmake-test" to run cmake & ctest on linux
