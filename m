Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31AC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226BE613A9
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhDENIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhDENIz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:08:55 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CC5C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:08:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x2so11583206oiv.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G89VnBw5NsFtl+f1gVd1SYlTr45q7tqcCQwoufxYeGc=;
        b=JllCKy4Hl39qpA6tAFcLcDpw3Kgzt23q5YOparS0ZuJG6z7oyyt9E2Ce6lTPN/IWo4
         7nlZRNaB/JVvlzm9PVn8QfVv682box+I8cTYvHim5TL1Sl7sN0MOEcgsn0+SnWJfxwkM
         X+SHYtOXFMZQoZNJxNOajMn8wQWGw4bWnOJOEQQO8T621D5bergSF/tY/vt6eieAaTZU
         WnUnoIkJjBZgSfc0qKBZIylB3P2+44wSk6UmpY5K4M5i7OANkPhJIMpg+6h8wV9BoYCH
         95GXKWS7d+B0V4W23wcMuca/Ne6cX+xaO/1sgKLeKtMqm9V+32oHAI4AlhPC4t/rn+Jd
         IqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G89VnBw5NsFtl+f1gVd1SYlTr45q7tqcCQwoufxYeGc=;
        b=HAxOF02ZDxVSe5uYu8MXvP0G+jbJxZ74Go8gyGJWFHPoiqHp7Jn+PsdWairuuBS56w
         lU3V5GQ0IWym6tYKSB28LmcWWl1hfdu93ZQQ5bZMtIx9uspdcWHqoL+luK0tC9Oi5uwM
         zfWlRLSLGCTz0imoe4iKQsrUBNLXE7njTL2qur2zBoL2bJpRLGhuv2zWhQtJWeJ25NY2
         WOrXkrgZ4YwILqmQeHwIqYpDtDiD+VS3taLa2c1XpG6kTsfz9dvc3p1B3j4RoJTdcXYe
         8IUDKnUc9nfTEljrn/zdUtBcXK5VWm3f/LPZuCOqqmcJSzREVGYodloBNIUTJSmPpi0V
         B3Sg==
X-Gm-Message-State: AOAM532CZ8l7f/S2T9SIDYHneyZoL73hoWCO+dy6mIaCSyKgTKqmzVQG
        V+w3nEECyoPbrSwL6mfByn4=
X-Google-Smtp-Source: ABdhPJxysMPgyW6FgGgXEWbI/IfyPuOGX4qgz/CWSVtG/soyc7HgyHQC/jY/EQGQT0VuaVYZ/GQDnw==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr17288697oij.77.1617628127915;
        Mon, 05 Apr 2021 06:08:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f9:c820:22ba:fec7? ([2600:1700:e72:80a0:91f9:c820:22ba:fec7])
        by smtp.gmail.com with ESMTPSA id k15sm4030959otj.46.2021.04.05.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 06:08:47 -0700 (PDT)
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
To:     Junio C Hamano <gitster@pobox.com>,
        Chinmoy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chinmoy <chinmoy12c@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
 <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
 <xmqqy2dyy40l.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <be9793f0-f437-8e42-d463-21a48d2ee948@gmail.com>
Date:   Mon, 5 Apr 2021 09:08:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2dyy40l.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2021 2:09 AM, Junio C Hamano wrote:
> "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/sparse-index.c b/sparse-index.c
>> index 95ea17174da3..e4323ffd81db 100644
>> --- a/sparse-index.c
>> +++ b/sparse-index.c
>> @@ -128,12 +128,14 @@ int set_sparse_index_config(struct repository *repo, int enable)
>>  int convert_to_sparse(struct index_state *istate)
>>  {
>>  	int test_env;
>> +	struct repository *r = the_repository;
>> +
>>  	if (istate->split_index || istate->sparse_index ||
>>  	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>>  		return 0;
>>  
>>  	if (!istate->repo)
>> -		istate->repo = the_repository;
>> +		istate->repo = r;
>>  
> 
> I am not quite sure if this is a reasonable conversion.  Surely it
> would not make the compiler barf, but are we sure that the caller of
> convert_to_sparse() wants us to work on the_repository instance and
> no other repository?  As an istate has a .repo member, it seems to
> me that using istate->repo would be a lot saner approach than
> assigning the_repository upfront to r.  It might be even needed, if
> cache_tree_update() wants to take a repository instance, to ensure
> that all callers to this helper sets istate->repo before they call
> it so that the above "if not set yet, use the_repository" code does
> not have to kick in.
> 
>>  	/*
>>  	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
>> @@ -161,7 +163,7 @@ int convert_to_sparse(struct index_state *istate)
>>  		return -1;
>>  	}
>>  
>> -	if (cache_tree_update(istate, 0)) {
>> +	if (cache_tree_update(r, istate, 0)) {
> 
> And this looks like a bad conversion.  It may happen to do the same
> thing, but the flow of the logic up to this point in the function
> was to make sure istate->repo is not empty by filling it if it is
> not yet set, and update the cache tree of that istate.  So, it seems
> more logical if this call were like so, no?
> 
> 	if (cache_tree_update(istate->repo, istate, 0)) {
> 
> In fact, in the world after 1fd9ae51 (repository: add repo reference
> to index_state, 2021-01-23), it is dubious that this topic to teach
> cache_tree_update() to take a repository pointer is sensible.  While
> working on a single repository, we may create multiple in-core index
> instances that represent temporary indices, but each of these in-core
> index instances (i.e. istate) belong to a single repository.
> 
> And in a call to cache_tree_update(R, I, F), if I->repo is *NOT* R,
> that must mean a bug.  Here is what 1fd9ae51 says on this point.
> 
>     repository: add repo reference to index_state
> 
>     It will be helpful to add behavior to index operations that might
>     trigger an object lookup. Since each index belongs to a specific
>     repository, add a 'repo' pointer to struct index_state that allows
>     access to this repository.
> 
>     Add a BUG() statement if the repo already has an index, and the index
>     already has a repo, but somehow the index points to a different repo.
> 
>     This will prevent future changes from needing to pass an additional
>     'struct repository *repo' parameter and instead rely only on the 'struct
>     index_state *istate' parameter.
> 
> Derrick, what's you thought on this?  The patch under discussion
> looks to me a prime example of "future change(s)" needing "to pass
> an additional 'struct repository *repo' parameter".

With your additional comments, I think it is clear that the "fourth
option" I mentioned earlier [1] is the way to go:

  Finally, there is yet a fourth option: use istate->repo instead. In
  1fd9ae51 (repository: add repo reference to index_state), I added a
  'repo' member to struct index_state. This is intended for methods to
  access a repository directly from the index.

[1] https://lore.kernel.org/git/f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com/

So in this sense, we should always use istate->repo, but we might
still need the following guard in some places:

	if (!istate->repo)
		istate->repo = the_repository;

in case there are situations where the index is loaded before
the_repository is loaded. I have hit this in testing, but don't fully
understand the cases where this can happen.

The way it would change this patch is to drop the 'struct repository *r'
pointers and changes to the method signatures. Instead, keep the
methods only taking a 'struct index_state *istate' and use istate->repo
everywhere.

Thanks,
-Stolee
