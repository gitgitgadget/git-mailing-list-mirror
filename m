Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55755C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiCIS5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiCIS47 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:56:59 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51E0574BF
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:56:00 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t18so2709576qtw.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 10:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QOBWLFjPwrosIPGvgS/fC36ZnNrSazI+5Kn0FXute0w=;
        b=KGSD8mpvNjt+RbhKbO25Mfvn/2KrXOCkhUdBrQGSqrpPuZb72DgVdppABx9+JKyeKs
         LTiNg4NujccsVTm47n2Ygc9Mjs6S8cX0AUw3wiOXa/bHR+XLldZwqlk5FtIZv/A6Cc/Q
         PrFS/iH5s7mx34Yvk9/RAoQi2zq2SNayTY7TskEIxqe5RMHRzDS5FuAk82eaVOyz8mUZ
         FmXy1vIOSkqb0XCuv7xvNQ7hnJEv8+CJKR1nfpe8Yg9xFb2Y3LOK81ee5uDoRX1Wgitu
         HdjbwvtSluKyhEqu+WtL+HTiGQgTN5Rf0op2rwmECtdbRmUrcyfHlKNEg2uxxJ4tUs/U
         8cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QOBWLFjPwrosIPGvgS/fC36ZnNrSazI+5Kn0FXute0w=;
        b=AqbUB4tUT/01TdPnOBQduoFVAxwqnyzjefc9Bu0m6PQGMdJYq5/0/cJ9L7xUhxgEUt
         baahBHxWhdJngOcrzqRmJ8VCK25I1Bz7hya3hDiEEGI2ZciJSH15nACQB7EvJ09plP5g
         73tO+upHucteIDh9hWyEHUjY0/OOp6QKPsrPis5VjlNQ1pBxOdJC2T9Yhzag/HTknkxR
         jhOUIeoxWlvfLI7uZFjJCDbl6AFcZSYTxSLuJaCRVzolwysb24aUUPkXKd0dknj0NNeg
         iGV8FvlZm9jTm9ojma3Syj3BDZMPY9KjrL25YwRxIKKFHqsp+PPsdV2trJ8deDC1HtdJ
         eLXw==
X-Gm-Message-State: AOAM533FzKy5g/kR+ZBsP6RzJB2J4OG5Kb97JjG/YwDcee3nzumGxnCv
        llTGqKjzPfL3pBDl+Db1e7qhLZG1oTz3
X-Google-Smtp-Source: ABdhPJzH8tt1xL57pGmNW+lHE/wK+33K3dKjWSiPD1sgkHGHYkvzvfgqBGSYgM4k1Ihu6trMIbDIOA==
X-Received: by 2002:ac8:7e8c:0:b0:2de:8a3:cbce with SMTP id w12-20020ac87e8c000000b002de08a3cbcemr956464qtj.11.1646852159969;
        Wed, 09 Mar 2022 10:55:59 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a079300b0067d1537f35bsm1283200qka.83.2022.03.09.10.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:55:59 -0800 (PST)
Message-ID: <858ccf36-3515-eeb6-2ad8-4a141d38d0c6@github.com>
Date:   Wed, 9 Mar 2022 13:55:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 09/13] bundle: parse filter capability
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
 <faf7a38b0e595e6fdb89b62563dcff855466c796.1646841704.git.gitgitgadget@gmail.com>
 <xmqqwnh3klyv.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwnh3klyv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 1:41 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
>> index 72ab8139052..ac4c4352aae 100644
>> --- a/Documentation/git-bundle.txt
>> +++ b/Documentation/git-bundle.txt
>> @@ -75,8 +75,11 @@ verify <file>::
>>  	cleanly to the current repository.  This includes checks on the
>>  	bundle format itself as well as checking that the prerequisite
>>  	commits exist and are fully linked in the current repository.
>> -	'git bundle' prints a list of missing commits, if any, and exits
>> -	with a non-zero status.
>> +	Information about additional capabilities, such as "object filter",
>> +	is printed. See "Capabilities" in link:technical/bundle-format.html
>> +	for more information. Finally, 'git bundle' prints a list of
>> +	missing commits, if any. The exit code is zero for success, but
>> +	will be nonzero if the bundle file is invalid.
> 
> Hmph.  I wasn't expecting this change (not objecting, but mostly am
> surprised) relative to the previous round where the filter was
> mentioned only when we issue an error message.  I was expecting to
> see something like "list-filters <file>", which is analog to the
> "list-heads <file>", to help those who want to programatically build
> around the "git bundle" command output.  Or "--list-capabilities" to
> accomodate the current, this, and future capabilities.  We already
> have the object-format thing before this series.  Do we have an
> interface to expose that out of a given bundle file?
 
The object format does _not_ appear to be output by 'git bundle verify'.
I just ran t6020 under GIT_TEST_DEFAULT_HASH=sha256 and see the
capability being written, but not output by verify:


The bundle contains these 10 refs:
d519553fbcf280df4448d588c25a51872f2d8dec95ba65a8a1bd3c64a5eec664 refs/heads/main
265b1effb3fdb80e04f7ea64e717f5677ddf57d00145dce7c508ba1f5ddb9081 refs/heads/release
611ac8182ea26d7aad227873b70f584593af1aa584bbdd37b36055e71be6ccd7 refs/heads/topic/1
4251af01ec70cdca692a3d15d78ccb9a6ca92ef344bd2dbc3bac20081347ae9b refs/heads/topic/2
611ac8182ea26d7aad227873b70f584593af1aa584bbdd37b36055e71be6ccd7 refs/pull/1/head
ec7e40a591df46923b25fd44bd86a2a80927f343d141f55ddf295c5d2d57959e refs/pull/2/head
754e9363bbfce179d35ccc48ae3a3c81db95a489cc632fafe5c10b25aed29d74 refs/tags/v1
a96c78650835f2041c49dce964bb759add14cfc4d35af3b7ee2b22289f9ba817 refs/tags/v2
398a930e72d21ea455c982227cca3c8fb5feb88c31f1d42226a3e6c42ff8db8f refs/tags/v3
d519553fbcf280df4448d588c25a51872f2d8dec95ba65a8a1bd3c64a5eec664 HEAD
The bundle uses this filter: blob:none
The bundle records a complete history.
partial.bdl is okay


This output does not seem to be designed for machine parsing, so
this extension of "The bundle uses this filter:" shouldn't be
problematic. A similar addition for object-format should be
possible as a follow-up.

Further, it seems you are asking for something that just reads
the header and supplies valuable data from the header such as
the refs and the capabilities. Perhaps 'git bundle header <file>'?

(We already have 'git bundle list-heads', so maybe we should
leave the refs out of 'git bundle header' output?)

I can add both as follow-ups to my existing list of things.

Thanks,
-Stolee
