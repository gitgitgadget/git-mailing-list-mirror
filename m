Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B4C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 15:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKIPXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiKIPXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 10:23:10 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE21AD82
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 07:23:09 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1322d768ba7so19978251fac.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 07:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+/xF0iOOR72XHLxvc6XO3PhDUtyiJ+Z68qrotG/bUw=;
        b=T2wsaW6dcRqfUYPIFnoPcvWrK8zrSzhOJF87JJK2Yp1KxcUxK26qebZoS+722ilLKi
         weFnEecqijtGiEN2lKs82WjqfVFmR1aPL3GXwPmmQAf4jus4mOPwTRKgwg43weeMl0nT
         uHp5KXKJi30S7z4xu+w8wOabX3nlWbdVLvD/HUQP3yv0iSLLNpkAj1pUiGUlBlJ+xWBA
         y9LyzA2+yr2TCMQiPTO6S2xv101/UF7TEsdmoyuc92WYCVudNDgT8rEHfiaozYa4IiIt
         TRhcfb9JTuAqKpB1KwEqP+xBUnYgXXoIMXOvO4lrNaTBA6LxFIOyKU2k/PRs8cVNQyXi
         oUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+/xF0iOOR72XHLxvc6XO3PhDUtyiJ+Z68qrotG/bUw=;
        b=kf7phrVeAf1yY+/NIhG5JKBY/eNbXa0mLtKH/fNFa+4AbtSJabEfXDewhOiGA8gd7x
         zPUWjJynvZ/fIl7jL3GQf76lXmh/CQ3H2mRY7KgShxxD5bntSEOtBx0za+Ws4mAGXsyc
         vK50mMWPwX5RT19npMwzPJsZdiRn+gr4OT00Cm8+oRWZSrRMRuBnVHTpoqVnWZoQMXQP
         xL7q9a4bVoZeQiIhPCZhTYIfZSFL70j2Fi5qrhhtirxdhwNzVVMFTZZr2rsl+2yoWf7x
         4OMCbBCtU7YPZ7nkdCJi3Brxi3egeYb5lu44qp/j4iqS9CMwGyHPh3cPoB7kxhHkWRCv
         WUWA==
X-Gm-Message-State: ACrzQf3ZRG0IdYPV/kmfUFVfXHi06FFcG3Hk1TL+2CcdIWcPU4ADrv72
        pZm+CfePwjIF+/vMEzCmnEYULU1eYfPx
X-Google-Smtp-Source: AMsMyM62zFBMu3k7WDpmnsSmI8/mhAuBppp5l6acVKszf+LOEyPFwiZyt7aJH/uMyDhWQJ2/mI9cXA==
X-Received: by 2002:a05:6870:60a0:b0:13c:b7de:ebe8 with SMTP id t32-20020a05687060a000b0013cb7deebe8mr33594817oae.60.1668007388971;
        Wed, 09 Nov 2022 07:23:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9489:2f30:3101:b539? ([2600:1700:e72:80a0:9489:2f30:3101:b539])
        by smtp.gmail.com with ESMTPSA id i25-20020a9d6519000000b0066cc88749f8sm4053694otl.68.2022.11.09.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 07:23:08 -0800 (PST)
Message-ID: <6c1e50e3-cddb-4cc3-f83c-6ec2e2a06a9f@github.com>
Date:   Wed, 9 Nov 2022 10:23:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()'
 is called immediate after
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        jonathantanmy@google.com, Victoria Dye <vdye@github.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/2022 5:44 PM, Victoria Dye via GitGitGadget wrote:
> Following up on a discussion [1] around cache tree refreshes in 'git reset',
> this series updates callers of 'unpack_trees()' to skip its internal
> invocation of 'cache_tree_update()' when 'prime_cache_tree()' is called
> immediately after 'unpack_trees()'. 'cache_tree_update()' can be an
> expensive operation, and it is redundant when 'prime_cache_tree()' clears
> and rebuilds the cache tree from scratch immediately after.
> 
> The first patch adds a test directly comparing the execution time of
> 'prime_cache_tree()' with that of 'cache_tree_update()'. The results show
> that on a fully-valid cache tree, they perform the same, but on a
> fully-invalid cache tree, 'prime_cache_tree()' is multiple times faster
> (although both are so fast that the total execution time of 100 invocations
> is needed to compare the results in the default perf repo).

One thing I found interesting is how you needed 200 iterations to show
a meaningful change in this test script, but in the case of 'git reset'
we can see sizeable improvements even with a single iteration.

Is there something about this test that is artificially speeding up
these iterations? Perhaps the index has up-to-date filesystem information
that allows these methods to avoid filesystem interactions that are
necessary in the 'git reset' case?
 
> The second patch introduces the 'skip_cache_tree_update' option for
> 'unpack_trees()', but does not use it yet.
> 
> The remaining three patches update callers that make the aforementioned
> redundant cache tree updates. The performance impact on these callers ranges
> from "negligible" (in 'rebase') to "substantial" (in 'read-tree') - more
> details can be found in the commit messages of the patch associated with the
> affected code path.

I found these patches well motivated and the code change to be so
unobtrusive that the benefits are well worth the new options.

Thanks,
-Stolee
