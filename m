Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D6CC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C12D60EB9
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhJZQMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhJZQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 12:12:46 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34AC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 09:10:23 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y14so3130556ilv.10
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TXNgIK3ggQCqQAUji7ZXEbNlP/p1sbAhmNHh15qhD9k=;
        b=GsO/rQUQrDueDW9zTyyaz56C+KsPvlEyJosCQRV+47zLq026I18WqxBocz4ve6FHJc
         RIvdknmzdDHaN9za85egMNsqy5R/xkdr3vJNtd4EZ8y+Ta39jL/BSYqEBJEIoZgOZ8Cw
         lm7oq2KgLf9idtEqWZcH52+JPGJhbmy5RmFUf0c2hAyQWc8zDbo7FO10Gs39UXkX1kHV
         LQPlhowmli/H07r+O4ZmPWGKnaUHxB3X/i35+rikjs42FPL2tsHOYKOj1S0RKPA0erw9
         enJSjHRgKWask9CrfWglL1t806O6Nz3yUet0cq0IeXccw2bh7UfgB74Dc4ObN4kBkiFJ
         nyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TXNgIK3ggQCqQAUji7ZXEbNlP/p1sbAhmNHh15qhD9k=;
        b=OqnFz5nN7rjNf/gIzIEgtLhtO9KO0E2DhjcR8VLKBqE89f4krlnBMf+u5/FagE5Lxz
         5SdZ34Jh79lLF+dVpktJ0H1Q0aeQQIYhpvGJfRmxDJRNpIWpk/eTGda627j2HQ7Rq8sA
         czhl4QEfzM59ri4Ifcn1CXv2Q3cDfsZmOJOf5oEsvgEh80VFYnSVogq8CeMg9EimYfW0
         x2vfQlAptTW7yPaVTSq0c529HXRmuVa9By0tvSjQqELIzvp5fuQxNVqYlFFE4kWd0Hnq
         Frnkxn8metjmPX3tVQeDVBcly5/ZSNx1SxzfLDy4Hoy/58b2mQ9TvODPIIfci+D0gHYs
         B6Fg==
X-Gm-Message-State: AOAM5308OcGlTUr/LKvas2jXWSuVUOiwGIMXi1KP/SXwYj1t5T15gVTP
        5GfebuRfq7B+iwY8rVgggmQ=
X-Google-Smtp-Source: ABdhPJzK5DpQ1x3vxzO2x+k8kAPU//pjwy/Q3RzRwo0tRMuE3PsJ2fWiKgvN0Qm/42jUIDKwz6g1Qg==
X-Received: by 2002:a92:911:: with SMTP id y17mr14962512ilg.218.1635264622313;
        Tue, 26 Oct 2021 09:10:22 -0700 (PDT)
Received: from [192.168.86.115] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id a12sm10147733ilb.66.2021.10.26.09.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:10:21 -0700 (PDT)
Message-ID: <6e2c07e7-c66f-01c0-a64e-2e8b5b7c1f8e@gmail.com>
Date:   Tue, 26 Oct 2021 09:10:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v2 1/2] diff: enable and test the sparse index
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <ac33159d020cc0c0f6fbee36eb74fff773cb8f9f.1634332836.git.gitgitgadget@gmail.com>
 <YXcX5QWFQFIFNXo0@nand.local>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <YXcX5QWFQFIFNXo0@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/21 1:47 PM, Taylor Blau wrote:
> On Fri, Oct 15, 2021 at 09:20:34PM +0000, Lessley Dennington via GitGitGadget wrote:
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Enable the sparse index within the 'git diff' command. Its implementation
>> already safely integrates with the sparse index because it shares code with
>> the 'git status' and 'git checkout' commands that were already integrated.
> 
> Good, it looks like most of the heavy-lifting to make `git diff` work
> with the sparse index was already done elsewhere.
> 
> It may be helpful here to include either one of two things to help
> readers and reviewers understand what's going on:
> 
>    - A summary of what `git status` and/or `git checkout` does to work
>      with the sparse index.
>    - Or the patches which make those commands work with the sparse index
>      so that readers can refer back to them.
> 
> Having either of those would help readers who are unfamiliar with
> builtin/diff.c convince themselves more easily that setting
> 'command_requires_full_index = 0' is all that's needed here.
> 
Great suggestion, thank you!
>> The most interesting thing to do is to add tests that verify that 'git diff'
>> behaves correctly when the sparse index is enabled. These cases are:
>>
>> 1. The index is not expanded for 'diff' and 'diff --staged'
>> 2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
>> checkout, and sparse index repositories in the following partially-staged
>> scenarios (i.e. the index, HEAD, and working directory differ at a given
>> path):
>>      1. Path is within sparse-checkout cone
>>      2. Path is outside sparse-checkout cone
>>      3. A merge conflict exists for paths outside sparse-checkout cone
> 
> Nice, these are all of the test cases that I would expect to demonstrate
> interesting behavior.
> 
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index f19c1b3e2eb..e5d15be9d45 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -386,6 +386,46 @@ test_expect_success 'diff --staged' '
>>   	test_all_match git diff --staged
>>   '
>>
>> +test_expect_success 'diff partially-staged' '
>> +	init_repos &&
>> +
>> +	write_script edit-contents <<-\EOF &&
>> +	echo text >>$1
>> +	EOF
>> +
>> +	# Add file within cone
>> +	test_sparse_match git sparse-checkout set deep &&
>> +	run_on_all ../edit-contents deep/testfile &&
>> +	test_all_match git add deep/testfile &&
>> +	run_on_all ../edit-contents deep/testfile &&
>> +
>> +	test_all_match git diff &&
>> +	test_all_match git diff --staged &&
>> +
>> +	# Add file outside cone
>> +	test_all_match git reset --hard &&
>> +	run_on_all mkdir newdirectory &&
>> +	run_on_all ../edit-contents newdirectory/testfile &&
>> +	test_sparse_match git sparse-checkout set newdirectory &&
>> +	test_all_match git add newdirectory/testfile &&
>> +	run_on_all ../edit-contents newdirectory/testfile &&
>> +	test_sparse_match git sparse-checkout set &&
>> +
>> +	test_all_match git diff &&
>> +	test_all_match git diff --staged &&
>> +
>> +	# Merge conflict outside cone
>> +	# The sparse checkout will report a warning that is not in the
>> +	# full checkout, so we use `run_on_all` instead of
>> +	# `test_all_match`
>> +	run_on_all git reset --hard &&
>> +	test_all_match git checkout merge-left &&
>> +	test_all_match test_must_fail git merge merge-right &&
>> +
>> +	test_all_match git diff &&
>> +	test_all_match git diff --staged
>> +'
>> +
>>   # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
>>   # running this test with 'df-conflict-2' after 'df-conflict-1'.
>>   test_expect_success 'diff with renames and conflicts' '
>> @@ -800,6 +840,11 @@ test_expect_success 'sparse-index is not expanded' '
>>   	# Wildcard identifies only full sparse directories, no index expansion
>>   	ensure_not_expanded reset deepest -- folder\* &&
>>
>> +	echo a test change >>sparse-index/README.md &&
>> +	ensure_not_expanded diff &&
> 
> Thinking aloud here as somebody who is unfamiliar with the sparse-index
> tests. ensure_not_expanded relies on the existence of the "sparse-index"
> repository, and its top-level README.md is outside of the
> sparse-checkout cone.
> 
> That makes sense, and when I create a repository with a file outside of
> the sparse-checkout cone and then run `git diff`, I see no changes as
> expected.
> 
> But isn't the top-level directory always part of the cone? If so, I
> think that what this (and the below test) is demonstrating is that we
> can show changes inside of the cone without expanding the sparse-index.
> 
> Having that test makes absolute sense to me. But I think it might also
> make sense to have a test that creates some directory structure outside
> of the cone, modifies it, and then ensures that both (a) those changes
> aren't visible to `git diff` when the sparse-checkout is active and (b)
> that running `git diff` doesn't cause the sparse-index to be expanded.
> 
README.md is actually within the sparse checkout cone - all files at 
root are included by default. So your understanding is correct - we are 
ensuring that making a change to a file in the cone and running both 
diff and diff --staged once the file is in the index doesn't expand the 
sparse index.

I like your idea of verifying that running diff against files outside 
the sparse checkout cone won't expand the index. I've updated the diff 
tests in v3 (which I will send out shortly) to do so.

> Thanks,
> Taylor
> 
Best,
Lessley
