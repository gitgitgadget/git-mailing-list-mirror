Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37724C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1830061100
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhJ2NqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJ2NqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:46:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628EC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:43:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g17so9051610qtk.8
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=diwTvEzCCtVfQ7NZ3dDjG1ewIReYDMnTXGWf3GSCX54=;
        b=ZYsNvTnMSceiq+5/V+hroBMVvTtiLE0bhTM8m1E21Wprypa7vlKw8czocQ8iswlILK
         Itl8WMyV9pWunm1LRA7wZ0XtCpyk/KYm7+gR7sSDLQ251rrHxE6W9KVLVT99H4sBUgkO
         bt4eQn2oW5W0i9kCU9Yw+ouzQkNcykKullaXBs/nBqLpV55zCWd70a8Y+ZWt3IwWwIPB
         u1l5oFq4CZEFrXfwA/YMGRBM+40V7RxWqAZIWK8YNo3XMjAW9Uit75u4fTvRKjA/+aai
         xPi15bgPBqVEb5IYVJDkZXR6gKv/8Qh6lzmKy4+J3ZyKEeltPYdoGE9pbXZGtV/5L5/+
         3QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=diwTvEzCCtVfQ7NZ3dDjG1ewIReYDMnTXGWf3GSCX54=;
        b=PsRBnMet5jYE1rE7GSFR5E/gbzvaaHYAhJSwsIVjRtTbTmzQJhLMcQrrV1T2nCmqqN
         dsYE4eGJm1sVAXemOxWdvV3004OXkxeWn91GqOYQJelA6C2NJOwfb4228TU9Nc9gk9FR
         pP6DokrfwX8he8vK3vqSec+47UwfdV6VY/pSx8DlUHimCiXQo36IAIPtgpfuxC28Xf2g
         xF9OS3tuW4goPxrzFZFK43/8xjGr4LerE/pKbxGrmt+nwp+3md0vNpar+RL8Nus0BieH
         gAbamHc+SbnvT2yZG4FM/ZRZYWWM0Wl8ugOzFlC6G0nE3XKzIKBLP/fS6EYAYf4W2mX4
         GmUA==
X-Gm-Message-State: AOAM5316wZr7/q9O+SiDYAu5rOGe8/jErK8Nr90TYRXdkKX9IYjyLGUN
        zOJLNbh0cRtb3+QJppJuD0Lx
X-Google-Smtp-Source: ABdhPJxoFB5f+JBI9fHLeFlRMKoeBA8ogZYaL+7CBLpGMtUEAp59feIgwM8fZIGjmDvL8SEdAqr0Dw==
X-Received: by 2002:a05:622a:50b:: with SMTP id l11mr11693964qtx.415.1635515032477;
        Fri, 29 Oct 2021 06:43:52 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id bk13sm3903020qkb.58.2021.10.29.06.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 06:43:52 -0700 (PDT)
Message-ID: <74501e70-7bac-e301-4075-09152f292884@github.com>
Date:   Fri, 29 Oct 2021 09:43:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v3 2/3] sparse-index: add ensure_correct_sparsity function
Content-Language: en-US
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
 <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
 <9d6511db0728e9880a96f3d9e3a025a9ddc5bc9e.1635358812.git.gitgitgadget@gmail.com>
 <bf73e2d2-a2ab-8364-d505-1bd5bba3efd2@gmail.com> <xmqqbl3aupbh.fsf@gitster.g>
 <bc960863-7ff2-d6bf-9710-6803f3784751@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <bc960863-7ff2-d6bf-9710-6803f3784751@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 10/27/2021 5:32 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>>> +int convert_to_sparse(struct index_state *istate, int flags)
>>>> +{
>>>> +	/*
>>>> +	 * If the index is already sparse, empty, or otherwise
>>>> +	 * cannot be converted to sparse, do not convert.
>>>> +	 */
>>>> +	if (istate->sparse_index || !istate->cache_nr ||
>>>> +	    !is_sparse_index_allowed(istate, flags))
>>>> +		return 0;
>>
>> Shouldn't we also at least do this?  Blindly blowing away the entire
>> cache-tree and rebuilding it from scratch may be hiding a latent bug
>> somewhere else, but is never supposed to be needed, and is a huge
>> waste of computational resources.
>>
>> I say "at least" here, because a cache tree that is partially valid
>> should be safely salvageable---at least that was the intention back
>> when I designed the subsystem.
> 
> I think you are right, what you propose below. It certainly seems
> like it would work, and even speed up the conversion from full to
> sparse. I think I erred on the side of extreme caution and used
> a hope that converting to sparse would be rare.
> 
>>  sparse-index.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git c/sparse-index.c w/sparse-index.c
>> index bc3ee358c6..a95c3386f3 100644
>> --- c/sparse-index.c
>> +++ w/sparse-index.c
>> @@ -188,17 +188,19 @@ int convert_to_sparse(struct index_state *istate, int flags)
>>  	if (index_has_unmerged_entries(istate))
>>  		return 0;
>>  
>> -	/* Clear and recompute the cache-tree */
>> -	cache_tree_free(&istate->cache_tree);
>> -	/*
>> -	 * Silently return if there is a problem with the cache tree update,
>> -	 * which might just be due to a conflict state in some entry.
>> -	 *
>> -	 * This might create new tree objects, so be sure to use
>> -	 * WRITE_TREE_MISSING_OK.
>> -	 */
>> -	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>> -		return 0;
>> +	if (!cache_tree_fully_valid(&istate->cache_tree)) {
>> +		/* Clear and recompute the cache-tree */
>> +		cache_tree_free(&istate->cache_tree);
>> +		/*
>> +		 * Silently return if there is a problem with the cache tree update,
>> +		 * which might just be due to a conflict state in some entry.
>> +		 *
>> +		 * This might create new tree objects, so be sure to use
>> +		 * WRITE_TREE_MISSING_OK.
>> +		 */
>> +		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>> +			return 0;
>> +	}
> 
> I think at this point we have enough tests that check the sparse index
> and its different conversion points that the test suite might catch if
> this is a bad idea. Note that this is only a change of behavior if the
> cache-tree is valid, which I expect to be the case most of the time in
> the tests.
> 
> Thanks,
> -Stolee
> 

This change doesn't appear to introduce any test failures or other unwanted
behavior, so I don't see a reason not to include it. I'll add it in a
re-roll - thanks!
