Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B17C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C52611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhETMcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbhETMbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:31:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB794C0363EB
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:32:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x18so7842772pfi.9
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MYdD4rLEz5Y1b0jd9Dvmyi3zn3HEubIKUreGLdv1fWQ=;
        b=ZPBxjZq6sjiBYY+obZ2Jd7IrXy1NsRWyGPW5LlJSCynXyqTfR3gDa8B7DK1AKPWweY
         cgnipobA3Eg1D3eLIygedQWVyJIyCDyy3w/cz7UjpINlUrErqCVNpKD4YZ03fKsAbifd
         kYudUwidJngs2caWqOIhgdGO3LmRVJq6cAV9/L1Hqdm/f0uL7XEs3y7Mbc+W5b0xwwOR
         ilceCpa04bt6sz6OPGuPvJWgkjmFikBS/GJ9lHHJTD4rp3P8aR3UH9P5CmAkIMFM5kWU
         9/C+HxS+uIJP8lOE9zTfZhsnQw8qgWx97y+sziXFcOg28zewyyJuagH9TKtFh4nOOSNt
         lV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYdD4rLEz5Y1b0jd9Dvmyi3zn3HEubIKUreGLdv1fWQ=;
        b=LLKSdnzm5ZNX02Ho4oqTT6BswEVo65EuaSmeME0G2MgOHdNH8dYvi8MX1ksEqQXnGz
         Tb+J6fmQ1BiawmFsj7mv6zpVDizTS4Bz8YncAG2Wv7YDs0ARjtvmU9X9VzYZ8FSKPzWl
         eGMbSGpQO+KhfDPuRi0SMAd6Lc7xYraz2aNESvxKHcyJQ4Kx/24sfigCoak9tBn5EhA5
         4vkxBIkEfom7GYZcTgP2dJq4VHRI++0x4excYq7hsG6vWCXGkf1wRIXd7J4Z2hYD2rmc
         BFpquVH0G1YzOZVB8/R60zi7EtC6AWD6qvygMZVDssjPFJNFA6NTtrR1E5rj86L2nde4
         Ctzw==
X-Gm-Message-State: AOAM5302aP2kCFaa2A6vdypcnGmcIgCgjppYeqiQjoo77bjn/5xZjGdN
        ysKNN2JiX1kqcWVgvpEM7cc=
X-Google-Smtp-Source: ABdhPJyzRM1k9wY4ozN1tEeO1X2A5NHbSX1W2RCwbJ6Eg++D0mVdx+GhY4EbJp8ujbFL55F1PimfVQ==
X-Received: by 2002:a62:bd07:0:b029:2df:2c0a:d5e9 with SMTP id a7-20020a62bd070000b02902df2c0ad5e9mr4004485pff.7.1621510366322;
        Thu, 20 May 2021 04:32:46 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-5.three.co.id. [116.206.28.5])
        by smtp.gmail.com with ESMTPSA id u24sm2000475pga.78.2021.05.20.04.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 04:32:45 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] Documentation/technical: describe remembering
 renames optimization
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
 <4246d0193fed5ff522fb2c442bd779973701c078.1621490982.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ef450bbd-0cbb-a512-d88e-eca6638358aa@gmail.com>
Date:   Thu, 20 May 2021 18:32:42 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <4246d0193fed5ff522fb2c442bd779973701c078.1621490982.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/05/21 13.09, Elijah Newren via GitGitGadget wrote:
> +Outline:
> +
> +  0. Assumptions
> +
> +  1. How rebasing and cherry-picking work
> +
> +  2. Why the renames on MERGE_SIDE1 in any given pick are *always* a
> +     superset of the renames on MERGE_SIDE1 for the next pick.
> +
> +  3. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
> +     a rename on MERGE_SIDE1 for the next pick
> +
> +  4. A detailed description of the the counter-examples to #3.
> +
> +  5. Why the special cases in #4 are still fully reasonable to use to pair
> +     up files for three-way content merging in the merge machinery, and why
> +     they do not affect the correctness of the merge.
> +
> +  6. Interaction with skipping of "irrelevant" renames
> +
> +  7. Additional items that need to be cached
> +
> +  8. How directory rename detection interacts with the above and why this
> +     optimization is still safe even if merge.directoryRenames is set to
> +     "true".
> +
> +

For item 1, 2, 3, 5, 8, it seems that you form question sentences but ended
with dot, instead of question mark (?). Are these question sentences or
descriptive sentences?

> +=== 0. Assumptions ===
> +
> +There are two assumptions that will hold throughout this document:
> +
> +  * The upstream side where commits are transplanted to is treated as the
> +    first parent side when rebase/cherry-pick call the merge machinery
> +
> +  * All merges are fully automatic
> +

Did you mean that "fully automatic" merges are merges that can be done
without conflicts?

-- 
An old man doll... just what I always wanted! - Clara
