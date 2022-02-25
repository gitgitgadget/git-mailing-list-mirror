Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B08C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 02:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiBYCxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 21:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 21:53:04 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983C1D0367
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 18:52:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id o30-20020a634e5e000000b00373598b71d4so1933675pgl.21
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 18:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eED1iule3OPCgF9QRCSoTlIiehEDaG5cL58yjAidN+Y=;
        b=pKWZfc8S3owylj0bl8VfMT+IZcYvHmZfyumpElMeZkAXHtONAv5gEYOBnZCNd5OGW+
         eDZJI58I2Bvs1p6pn6/JBsqDI5mfUagNy6DYlfkl/ybxsbw6UhjFdwju3AH2AdYdYuHo
         VxtqeSPjZNyl4mBvcOSmp/8akBj9iDH8kH6tBRg44fPz8aEAfIzQZrxlMe9cWvNuIetz
         sSgDJOPxgtVI7f5T44TugDC8GO0k8Dk0R8ZaeplLwaJgn3B5OT8v6i+ssBWTixL+zoMI
         WYzAiAPnijiKQ4gwN3/30Xa5hslFQQtS0lGY8xvIAOPMeYzI0Er0iEMJF+yKlqugwiK8
         acZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eED1iule3OPCgF9QRCSoTlIiehEDaG5cL58yjAidN+Y=;
        b=ZOZsXspaCSCVE83O4iMls9WI5TLF2FvTFe3+ItCvojtPZoQZIEYtyHVwAu4DzefBLM
         4Sszn/wHquInADeLFky3FBmp+BqK/L1n09dFGTthw1PWC7F5BVZ2b0GSsRw/WpFlcQUg
         b5OURMs68Q+XEpBHkoNFjxt0+oyQ6yu0wL/Vo5AWpsUEsSa7pY7SnQCpWJku+fQcVnvl
         wOe2izPjgMAeYaZrak6TAq4lkZ8QCO6iLPFORXP0Sf4YAq1Xwcx8HHvmu1QX7Gvrm3qh
         Ug08N00yxnGnh8hudPNcLC82va3ybAcUNwnDD/NiaXyRnCoXn3UO8cbPo3HtxbOHDrIo
         bOBA==
X-Gm-Message-State: AOAM532xRwUxC4erMIM4LMtxs3oVJfWFfbWbPQ2nezdwzeOzTR9S20Ot
        LVRYFar4fbnyORdodxjGlm54b1HFLvmNpQ==
X-Google-Smtp-Source: ABdhPJx+desnTZP48wRSgqNvVAmISKGC4f+WdllxkMRMklNbGmC29mOOXdkRqGlgLGoGydye8MSUMKzZuZf+aQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:a78c:b0:1b8:b769:62d0 with SMTP
 id f12-20020a17090aa78c00b001b8b76962d0mr1069127pjq.227.1645757551361; Thu,
 24 Feb 2022 18:52:31 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:52:29 +0800
In-Reply-To: <20220224231420.2878760-1-jonathantanmy@google.com>
Message-Id: <kl6lfso74pzm.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220224231420.2878760-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 03/10] t5526: create superproject commits with test helper
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> +# For each superproject in the test setup, update its submodule, add the
>> +# submodule and create a new commit with the submodule change.
>> +#
>> +# This requires add_submodule_commits() to be called first, otherwise
>> +# the submodules will not have changed and cannot be "git add"-ed.
>> +add_superproject_commits() {
>> +(
>> +	cd submodule &&
>> +	(
>> +		cd subdir/deepsubmodule &&
>> +		git fetch &&
>> +		git checkout -q FETCH_HEAD
>> +	) &&
>> +		git add subdir/deepsubmodule &&
>> +		git commit -m "new deep submodule"
>> +	) &&
>
> The indentation looks off. Also, no need for "-q".

Ah thanks. I think the "-q" is there to suppress the detached HEAD
warning, which is very large.

I'd prefer to keep it unless there are stronger reasons than "it's not
needed for correctness". 

>> @@ -378,19 +387,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
>>  '
>>  
>>  test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
>> -	add_upstream_commit &&
>> -	(
>> -		cd submodule &&
>> -		(
>> -			cd subdir/deepsubmodule &&
>> -			git fetch &&
>> -			git checkout -q FETCH_HEAD
>> -		) &&
>> -		git add subdir/deepsubmodule &&
>> -		git commit -m "new deepsubmodule" &&
>> -		new_head=$(git rev-parse --short HEAD) &&
>> -		check_sub $new_head
>> -	) &&
>> +	add_submodule_commits &&
>>  	(
>>  		cd downstream &&
>>  		git config fetch.recurseSubmodules true &&
>
> Hmm...I'm surprised that this still passes even when code is deleted but
> the replacement is not added. What's happening here, I guess, is that
> we're checking that nothing has happened. The test probably should be
> rewritten but that's outside the scope of this patch set. So for now,
> just add the add_superproject_commits call.

Yeah this test could use some fixing up; I spent a lot of time trying to
understand this one. It could use comments at least.

The suggestion to add the add_superproject_commits call defeats the
purpose of the test though - which is to assert that "on-demand"
recursion only fetches submodule commits if a superproject commit says
the submodule has changed, unlike "yes", which unconditionally fetches
submodule commits.

So we need to consider these cases:

1. no new upstream commits
2. new upstream submodule commits, but not superproject (call
   add_submodule_commits() only)
3. new upstream submodule and superproject commits (call
   add_submodule_commits() and add_superproject_commits())

(1): "on-demand" and "yes" both fetch nothing
(2): "yes" fetches submodule commits but "on-demand" doesn't
(3): "on-demand" and "yes" both fetch submodule and superproject commits

So this test can't call add_superproject_commits(), because we would no
longer be testing scenario (2) - we'd be 'testing' (3) instead (which
doesn't tell us how "on-demand" is different from "yes").

>> @@ -402,10 +399,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
>>  '
>>  
>>  test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
>> -	git add submodule &&
>> -	git commit -m "new submodule" &&
>> -	new_head=$(git rev-parse --short HEAD) &&
>> -	check_super $new_head &&
>> +	add_superproject_commits &&
>>  	(
>>  		cd downstream &&
>>  		git config fetch.recurseSubmodules false &&
>
> add_superproject_commits without add_submodule_commits?

This is a silly holdover from before my rewrite.. These lines:

   -	git add submodule &&
   -	git commit -m "new submodule" &&
   -	new_head=$(git rev-parse --short HEAD) &&

don't make any sense either until you realize that these commits were
set up in the _previous_ test. I should clean this up though, there's no
reason for others to have to struggle with this the way I did.

The easiest approach would be to add the add_submodule_commits() call,
with a comment explaining that it's technically unnecessary work
(because the previous test already calls add_submodule_commits()) but it
makes the test easier to read.
