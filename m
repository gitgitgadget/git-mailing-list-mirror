Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BAFC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C642564E31
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCQSDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhCQSCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:02:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DC6C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:02:46 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x135so38198870oia.9
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPss2yFVeX/uI3uN9C2W2rtygGqRNwyIWXBhffn6g+g=;
        b=rczZYYco01ddxLgXPXUm00ErX5uTwU0bL52WdkfZX60JXQ/iv8GIIYfyrjVQlPhY5S
         rxtgxHUOn0HIWvvo0WFQuBLv8do87qKBAxdF/OYaRu67GnVb4VcE7nyw7VZXKVS52KtG
         ZGtOetlik7PIHl9W/Y4hBWiyYQdIL+VlTHjY6zIA+jccTzMeL7QJYcbyoZ/BCbIZBnN6
         lAZHiiOuvdqkCk9VaLyVVbHNUJzeqCAyA5MxDN5OqxqaYl9J3gXMmfayzcwHCJAnB9eg
         G6fr7JQEebrBbt8VFTKnq0QQYR27tCjQ0SRbkmEjzRsn9nfLj6CMwlVHxMDEHLWiwR7I
         02Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPss2yFVeX/uI3uN9C2W2rtygGqRNwyIWXBhffn6g+g=;
        b=h/kntlNCNWEjCUJmZi5M/oZkRRX0KWHAapc794IarCJO0DsQiNQlRzdzykNveK7mYP
         9DcaYqRkgxewdBQ3ybT5Md6NUjfHP0SyI08MQsf0tbxvKOQftKQJevJwgcNFQY/TSRBp
         qNreQAPvi43oAHdpWB7affUzGTC6MPuiKmghHEnj4MvF1pagLbB+wTaqGGrOpHRtC/0S
         fDRBYrwVXnp7jds1Vp/GaaVnviuU+lXhwhQEeDPBxTdgijQHqce+7bGN9O/c4BB12vqt
         mcU6QfhHQxL81CGtsvZ4GAvpqD+Q8MS41dR7aN8cQdRNDVAeUpZCJp+2Vtseie4Wqwax
         V4gw==
X-Gm-Message-State: AOAM531SU7DrJcuisnDDIBlSc3s+WpW90KbLmakqcVsqpidz8p/VhgXQ
        0kDAATrsjyB9DebuxdBLYdYCbddy+fxDWf6R
X-Google-Smtp-Source: ABdhPJwhp1sadjwUbxOrjg3fFSLwQD/Tk0IlY9D4P2qak60DHr2xBbuonbPW/Mx3MVPtHxia+q/A1g==
X-Received: by 2002:aca:4188:: with SMTP id o130mr11532oia.53.1616004165305;
        Wed, 17 Mar 2021 11:02:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id d24sm8591831otf.12.2021.03.17.11.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 11:02:44 -0700 (PDT)
Subject: Re: [PATCH v3 02/20] t/perf: add performance test for sparse
 operations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <d2197e895e4d4160fa369e2ba7d82e2e5a7fbc01.1615912983.git.gitgitgadget@gmail.com>
 <87tupadve8.fsf@evledraar.gmail.com>
 <792a1249-166b-56f4-1e7d-0c5d7a1ba0e5@gmail.com>
 <875z1p29wd.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42e0b111-14d2-431c-00cc-d87784b70581@gmail.com>
Date:   Wed, 17 Mar 2021 14:02:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <875z1p29wd.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 9:21 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 17 2021, Derrick Stolee wrote:
> 
>> On 3/17/2021 4:41 AM, Ævar Arnfjörð Bjarmason wrote:
>>> But it seems odd to be doing this at all, the point of the perf
>>> framework is that you can point it at any repo, and some repos you want
>>> to test will have submodules.
>>
>> You're right that it should handle all repos. However, the point of
>> the test is to have many copies of the repo, but most of them are
>> excluded by sparse-directory entries. We don't collapse sparse-directory
>> entries if there is a submodule inside, so the data shape is wrong after
>> making all the copies.
>>
>> So, I disagree with your approach in your suggested diff, and instead
>> offer this one. I've tested this with git.git and another local repo
>> without submodules and checked that everything works as expected.
> 
> What's got me confused here is that there's two uses for the perf
> framework in this context.
> 
> It's to use an empty/git.git as a test repo to demonstrate something,
> but then also that you can run it in your arbitrary repo, and e.g. see
> how much a given feature might benefit you.
> 
> Hence suggesting that maybe test_perf_fresh_repois better here, because
> by using test_perf_default_repo you're creating the expectation that you
> can run the perf test, observe an %X difference, and that'll be
> give-or-take what you'll get for that use case if you enable the feature.
> 
> Except it won't because the repo has submodules, which we deleted for
> the perf test...

I'm also dramatically changing the repository shape to expose index
reads and writes as a bottleneck. The benefit of using other repos
(like git.git or optionally choosing the Linux kernel repo) is to
change how much of the time is spent crawling the populated set.

>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index e527316e66d..5c0d78eeeea 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -10,15 +10,17 @@ SPARSE_CONE=f2/f4/f1
>>  
>>  test_expect_success 'setup repo and indexes' '
>>  	git reset --hard HEAD &&
>> +
>>  	# Remove submodules from the example repo, because our
>> -	# duplication of the entire repo creates an unlikly data shape.
>> -	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
>> -	git rm -f .gitmodules &&
>> -	for module in $(awk "{print \$2}" modules)
>> -	do
>> -		git rm $module || return 1
>> -	done &&
>> -	git commit -m "remove submodules" &&
>> +	# duplication of the entire repo creates an unlikely data shape.
>> +	if (git config --file .gitmodules --get-regexp "submodule.*.path" >modules)
> 
> A subshell isn't needed here.
> 
> FWIW the reason I got this out of ls-files is because you can have
> submodules without .gitmodules entries, rare and broken, but seemed more
> direct to grep the mode bits.

I'd prefer to do something (textually) simpler, expecting the input
repos to have correct data.

>> +	then
>> +		for module in $(awk "{print \$2}" modules)
>> +		do
>> +			git rm $module || return 1
>> +		done &&
> 
> Once we know we have submodules we can just do this without the loop.
> 
>     git rm $(awk "{print \$2}" modules)

Ok. That works for me.
>>> Seems like something like the WIP patch at the end on top would be
>>> better.
>>>
>>>> +	echo bogus >a &&
>>>> +	cp a b &&
>>>> +	git add a b &&
>>>> +	git commit -m "level 0" &&
>>>> +	BLOB=$(git rev-parse HEAD:a) &&
>>>
>>> Isn't the way we're getting this $BLOB equivalent to just 'echo bogus |
>>> git hash-object --stdin -w' why commit it?
>>
>> We are committing it so we can add commits that deepen the copies,
>> but within those copies we have these known file paths.
>>
>>> This whole thing makes me think you just wanted a test_perf_fresh_repo
>>> all along, but I think this would be much more useful if you took the
>>> default repo and multiplied the size in its tree by some multiple.
>>>
>>> E.g. take the files we have in git.git, write a copy at prefix-1/,
>>> prefix-2/ etc.
>>
>> That is essentially what is happening here, but using multiple levels
>> of directories. Using these multiple levels presents extra tree
>> lookups and parsing in the event of expanding a sparse index to a
>> full one.
> 
> *nod*
> 
> Anyway, this thread's a bit of a bikeshed on my part, I was just
> wondering if & what part of the test relied on the existing repo if it
> was mostly setting up its own test data.

Again, the benefit is to depend on the repo shape in some aspects,
while exaggerating the data shape to make the non-populated set
extremely large.

This presents different aspects that are worth examining, such as
git.git is much smaller than linux.git, and that is noticable with
these different performance numbers (taken at the end of this
series):

git.git
Test                                            this tree      
---------------------------------------------------------------
2000.2: git status (full-index-v3)              0.39(0.35+0.08)
2000.3: git status (full-index-v4)              0.39(0.34+0.09)
2000.4: git status (sparse-index-v3)            2.46(2.33+0.16)
2000.5: git status (sparse-index-v4)            2.42(2.31+0.15)
2000.6: git add -A (full-index-v3)              1.35(0.98+0.20)
2000.7: git add -A (full-index-v4)              1.25(0.96+0.18)
2000.8: git add -A (sparse-index-v3)            2.39(2.26+0.17)
2000.9: git add -A (sparse-index-v4)            2.35(2.29+0.11)
2000.10: git add . (full-index-v3)              1.39(1.01+0.19)
2000.11: git add . (full-index-v4)              1.31(1.00+0.19)
2000.12: git add . (sparse-index-v3)            2.41(2.28+0.16)
2000.13: git add . (sparse-index-v4)            2.45(2.32+0.16)
2000.14: git commit -a -m A (full-index-v3)     1.44(1.08+0.21)
2000.15: git commit -a -m A (full-index-v4)     1.31(1.04+0.19)
2000.16: git commit -a -m A (sparse-index-v3)   2.44(2.35+0.16)
2000.17: git commit -a -m A (sparse-index-v4)   2.44(2.36+0.16)

linux.git
Test                                            this tree        
-----------------------------------------------------------------
2000.2: git status (full-index-v3)              7.14(6.06+1.79)  
2000.3: git status (full-index-v4)              7.01(6.16+1.60)  
2000.4: git status (sparse-index-v3)            58.50(56.86+2.34)
2000.5: git status (sparse-index-v4)            57.52(55.80+2.45)
2000.6: git add -A (full-index-v3)              25.52(18.70+3.18)
2000.7: git add -A (full-index-v4)              22.26(17.52+2.72)
2000.8: git add -A (sparse-index-v3)            56.65(55.00+2.35)
2000.9: git add -A (sparse-index-v4)            56.56(54.98+2.29)
2000.10: git add . (full-index-v3)              25.87(19.12+3.15)
2000.11: git add . (full-index-v4)              22.56(17.85+2.71)
2000.12: git add . (sparse-index-v3)            57.01(55.28+2.42)
2000.13: git add . (sparse-index-v4)            56.84(55.38+2.19)
2000.14: git commit -a -m A (full-index-v3)     26.83(20.69+3.24)
2000.15: git commit -a -m A (full-index-v4)     24.04(19.86+2.65)
2000.16: git commit -a -m A (sparse-index-v3)   60.23(58.99+2.44)
2000.17: git commit -a -m A (sparse-index-v4)   60.52(59.09+2.74)

The intention is to make these numbers improve in the future
so that the sparse-index is a better approach.

Thanks,
-Stolee
