Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA9C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiF0N7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiF0N7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 09:59:08 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97125FA
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 06:59:06 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s124so13012021oia.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5p93EZf6stnjnWjPcpPpb0xLPKCFhgh678P2uSeIQms=;
        b=hf0Y+YwNCm4tKB822MiKAew78HLjwV3TJuPIIehBXrAevbG0JVVtJbZaWf4TU+rINm
         9THSzyvuLlsRLqdn+BNoh3Plbu34FspOuQGErO0bveKjJleP32z4ZVC9LI+jyuuD+2b0
         BoIjMhiE4r4rgh/XVnWZScmCmYby5ujHp8EOwNBvzN0L1A5hv0XSyTFw4AFZ+rpmywgl
         bX9ogpWmhm0bQuZfjqas/VlebepkUVvmrZrpr4D1ERPhkv1g+/mo7uZwSr9jTYJWlNDg
         Ai0GgnJy8Mb9FWzZpxdqrMtcrRNLo/Kc3fE4cVkmA44HhYi+x5noiPjM9zYT5MPj8jX3
         RHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5p93EZf6stnjnWjPcpPpb0xLPKCFhgh678P2uSeIQms=;
        b=FV6cz82EXCZvENjp4K4zDtm8z9hduE5K6+J2MC/SsX3O6SlboTXpNUgxqgIImQnzGl
         6I72FNHZ+QsP/w9hLYLu22PoMrT3vgUCCZkogJhYrStp7jQ/Z+UeaFojkkvBjbx4UhcG
         Mpbvx6UWZ5njewJ5VjgWeeSy8z9aOu+z0vY7R1XWl3DHGVKAlzuUa+FsnbQVQw9nP/zQ
         N5oFcRFKZ5J/qKCZuLJ1jMayxil6Pygc5GGFUp4XnY3PzCqbCfdvu4Mo8hjElhs0qPHG
         d7P6t64MG4ihA5kC1D65cxemjBNRdhgScDtTcdhrdu9arkDTaBPTp+xePJYzLjy5lD7p
         DVSA==
X-Gm-Message-State: AJIora+Qa0DpUPvVdxqYiftssXQ4lR+h/IU4AJi3OnvLBJSCVwQH3yJL
        4NAOVtT6SnH4vposRezPXHdoU5MeMc2i
X-Google-Smtp-Source: AGRyM1sBQJFwyqglDS7X6QXcMDGvf/IxZ16xwmmJOLMBiQAZDwJyAcD8KoQbueS59V61sHcb3WbsQg==
X-Received: by 2002:a05:6808:ec3:b0:2ef:3f6a:5a1e with SMTP id q3-20020a0568080ec300b002ef3f6a5a1emr8161357oiv.296.1656338346001;
        Mon, 27 Jun 2022 06:59:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id c4-20020a9d6144000000b0060c0fc441bbsm6375861otk.36.2022.06.27.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:59:05 -0700 (PDT)
Message-ID: <baa7fed8-2309-8f08-92fd-d47831fad702@github.com>
Date:   Mon, 27 Jun 2022 09:59:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 7/7] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-8-shaoxuan.yuan02@gmail.com>
 <17a34570-f823-7908-1ea5-8e7bf8680b23@github.com>
 <a97eea15-00fe-dd33-2e4e-3ea91cb053f5@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a97eea15-00fe-dd33-2e4e-3ea91cb053f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2022 3:57 AM, Shaoxuan Yuan wrote:
> On 6/23/2022 11:14 PM, Derrick Stolee wrote:
>> On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
>>> +/*
>>> + * Check if an out-of-cone directory should be in the index. Imagine this case
>>> + * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
>>> + * and thus the directory is sparsified.
>>> + *
>>> + * Return 0 if such directory exist (i.e. with any of its contained files not
>>> + * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
>>> + * Return 1 otherwise.
>>> + */
>>
>> This description and the implementation seems like it will work
>> even if the path exists as a sparse directory in a sparse index.
>>
>> It would be good to consider testing this kind of move for a
>> directory on the sparse boundary (where it would be a sparse
>> directory in a sparse index) _and_ if it is deeper than the
>> boundary (so the sparse index would expand in the cache_name_pos()
>> method). These tests can be written now for correctness, but later
>> the first case can be updated to use the 'ensure_not_expanded'
>> helper in t1092.
> 
> I'm a bit confused here. Shouldn't we turn on the sparse-index
> feature for 'mv' before adding sparse-index related tests? Since this
> series does not go into sparse-index, I'm not sure how the tests can
> pass. Perhaps we can test about this in the future sparse-index
> integration series, no?

I mean that you are making a change right now that might lead to
different behavior _when you enable the sparse index later_. Since
we are looking at this behavior now, it might be interesting to add
the extra test coverage now while we are thinking about this data
shape.

We can add tests to t1092-sparse-checkout-compatibility.sh even
though the sparse index is expanded on every 'git mv' instance, but
it can help when you eventually update 'git mv' to not expand on a
sparse index.

The bit about ensure_not_expanded can't be added until you integrate
with the sparse index, but it is easier to add that when you already
have tests that check these boundary cases.

Thanks,
-Stolee
