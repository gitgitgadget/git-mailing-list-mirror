Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70814C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbiCDSeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbiCDSeT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:34:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F3158797
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:33:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so19192677eje.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=p0ODyujQdO0xe6Y/OOjQgmd+nxa9RxhEGHe4q4hNGxs=;
        b=TuHPf6mKAwCw8U+0tAD0rKX8aqjxj6hzJbhNqiel5VRaZlnrvKHBuW6XyOkivDAxSB
         PTnlZBP810RcXpBjaeSw1bi9tZGAsb4YHGsaUcDYTWmePncDYQgs5aPVulfWlLwUj2YI
         KS1jhH3dSsfRiNSYrE7t6tQbaAKEEhbHp1UutB8UJ45MPIfIRUD2mVtPTQn36lBDgqMA
         wJG/Hgiaq3xgd8iiJzYGOedJekF5eRglW56/w/KjIIIcwI+GCWKyrNMZUqtdffq7Mtws
         1denLDwiM97Sgc+TJxPKQnmh+eTGCdyhvykIAHG1pG7juK12fnvejJSK/sLqpee8smA3
         S3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=p0ODyujQdO0xe6Y/OOjQgmd+nxa9RxhEGHe4q4hNGxs=;
        b=YOlL7EgyLbxHOoyMH+f0TXxh8yFbTT0Exglpjunx7XvNcH24Dq0DjG+cOtuSU0f+Y7
         tBBNUaQC5Oa1SEUhiHboj81zl54joUiAE4rkUuoNok97rWlRTd3R1UWjZPI/Akw9tGrM
         gNkKSy3E5Nex9Lz1y/RbeNNrA/Gteqpin1UUpsl7nuaKMMIGCejuD5brS/9hlwLaGwIn
         10aRuGhj0eH6LKuKUPAKRpMd7e0t3Ab9etgCQM1OFWQ0t5gufsS/JE/Y9W9sbQIrctwb
         fGLxjmaqekzUTAzimXIfdIJoVkApHDm/dKtjJOCa8wlhxBCtGhsC+nWbbS+f0gdWt7xV
         a8FA==
X-Gm-Message-State: AOAM532CM9AWcBGWeezIJd8SiyQhq3V8mMkE/spZXbbC+e29HYD+HLsS
        dL6dC8Y8mmFH0EnEIxXAJi+g+hArXLkDpA==
X-Google-Smtp-Source: ABdhPJzLvNbXzqDFY6zE3L/lNU/I/w03n7ykn9hotFJtsk5HQy2Sb81I8KbSdrv9j2IgJNROu6TxHQ==
X-Received: by 2002:a17:907:9485:b0:6da:aa54:a88 with SMTP id dm5-20020a170907948500b006daaa540a88mr17071ejc.427.1646418809526;
        Fri, 04 Mar 2022 10:33:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm2020500ejb.194.2022.03.04.10.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:33:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQCk3-000UI3-S0;
        Fri, 04 Mar 2022 19:33:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/plug-random-leaks (was Re: What's cooking in git.git (Mar
 2022, #01; Thu, 3))
Date:   Fri, 04 Mar 2022 19:33:05 +0100
References: <xmqqv8wu2vag.fsf@gitster.g>
 <5f8740bd-c0b7-a8e1-4d73-b79b40cc02e9@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5f8740bd-c0b7-a8e1-4d73-b79b40cc02e9@github.com>
Message-ID: <220304.861qzhftzc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 04 2022, Derrick Stolee wrote:

> On 3/3/2022 11:31 PM, Junio C Hamano wrote:
>
>> * ab/plug-random-leaks (2022-03-02) 14 commits
>>  - repository.c: free the "path cache" in repo_clear()
>>  - range-diff: plug memory leak in read_patches()
>>  - range-diff: plug memory leak in common invocation
>>  - lockfile API users: simplify and don't leak "path"
>>  - commit-graph: stop fill_oids_from_packs() progress on error and free()
>>  - commit-graph: fix memory leak in misused string_list API
>>  - submodule--helper: fix trivial leak in module_add()
>>  - transport: stop needlessly copying bundle header references
>>  - bundle: call strvec_clear() on allocated strvec
>>  - remote-curl.c: free memory in cmd_main()
>>  - urlmatch.c: add and use a *_release() function
>>  - diff.c: free "buf" in diff_words_flush()
>>  - merge-base: free() allocated "struct commit **" list
>>  - index-pack: fix memory leaks
>> 
>>  Plug random memory leaks.
>> 
>>  Will merge to 'next'.
>>  source: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
>
> This series needs a re-roll before it gets merged. There is
> a correctness issue in this patch:
>
>>  - transport: stop needlessly copying bundle header references

Thanks. I just sent in that re-roll at:
https://lore.kernel.org/git/cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com/
