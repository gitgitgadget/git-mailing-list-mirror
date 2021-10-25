Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B6C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505C860E75
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhJYQBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhJYQBo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:01:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254CC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 08:59:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c28so10675605qtv.11
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s/Sg1GoHTXJBlq44WzyO9xy+nZlu5leo9nen/hhuipY=;
        b=VUbsXpe01yzRkzn1WrCIf3OjVjw7DbsHw0uy2q2wWi3AwWlutYdHyw9NsBhp5ssYUD
         czSzzocbPh7TeFS/JOhEet1RGFUNO/8+gji1PK1m0i/sxVXybx0jbD1GReFAVr+pwHmT
         gtum2TmGohg7lyObXzt/QGuZYR4tK+19QYlc9JrjSB+zbd/On/yhnRLq6jrN64G7Mu6R
         smN8mhmS9gHV+B0pPNlIZ/iC2GABApTx8UZvSz121AVUds6q5vRBgkqlMV825WQ/h5cd
         BhsMMqn5U0V0SbqtcdzNEzGw3FWwYFNggVYf3XX8XPGJRTW/Cr9lCHlQi5e+m60yfQQo
         MMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s/Sg1GoHTXJBlq44WzyO9xy+nZlu5leo9nen/hhuipY=;
        b=yRHe3N97kis/IjxUFAkJN6bkJiWBLD3MqWh7KBr0mUfOoRrxshVFsOYIU6VeMwD03I
         YjCOy5lHFAUCSPmLvVVSn6wIXsuU357Uo0VenSoGqyKrdFWzedwrH8kFoi/i1jlxZ7d2
         crWJoopwxR8OkaGh/zkA1LzJKypFtMrFMIuECnr7bK4Lm9FhianuXnG+miBal7LB1Rn7
         bd8C7Ht8h8bOgSooW2U7IZf3eG4l44ZRM8TZS8x9Spasgaa1oSj2mTeExQEjZpC96uDl
         0wymTYe3nN/VcWv35PRJ1krO98uZlChmORDOOjuzTsnO9gRvlRPUUrc48/7rPN3R9iUA
         tZyg==
X-Gm-Message-State: AOAM531ZPwVaNS+aAyWjb7ZixY3yfDX35ftH0aOHdRh+ITmQUSiLYFnS
        NBwoHE1GS1ETPuJw/gLthMLS
X-Google-Smtp-Source: ABdhPJwIxpigJsc77z+5H5Eam9RJOnVidSluxW1fATHwmZu81QssXPMFTPlCGV1kWa2VCo6Wb6sgAg==
X-Received: by 2002:a05:622a:48a:: with SMTP id p10mr18799135qtx.82.1635177560958;
        Mon, 25 Oct 2021 08:59:20 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id m11sm9569672qkp.0.2021.10.25.08.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:59:20 -0700 (PDT)
Message-ID: <16fbc2dc-6fdd-ed0d-ebc6-3b0566142879@github.com>
Date:   Mon, 25 Oct 2021 11:59:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/8] reset: preserve skip-worktree bit in mixed reset
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
 <bd72bd175da52a167c27bfba1310e050d9e33a50.1633984222.git.gitgitgadget@gmail.com>
 <YXI75uFLdk2mnP7g@google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <YXI75uFLdk2mnP7g@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Mon, Oct 11, 2021 at 08:30:16PM +0000, Victoria Dye via GitGitGadget wrote:
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index d3695ce43c4..e441b6601b9 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -25,6 +25,7 @@
>>  #include "cache-tree.h"
>>  #include "submodule.h"
>>  #include "submodule-config.h"
>> +#include "dir.h"
>>  
>>  #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
>>  
>> @@ -141,6 +143,18 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>>  
>>  		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
>>  				      0, 0);
>> +
>> +		/*
>> +		 * If the file 1) corresponds to an existing index entry with
>> +		 * skip-worktree set, or 2) does not exist in the index but is
>> +		 * outside the sparse checkout definition, add a skip-worktree bit
>> +		 * to the new index entry.
>> +		 */
>> +		pos = cache_name_pos(one->path, strlen(one->path));
>> +		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
>> +		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
>> +			ce->ce_flags |= CE_SKIP_WORKTREE;
> 
> To put it another way and check my understanding (because I'm not
> familiar with the sparse-index yet): if the file exists in the index but
> we didn't care about the worktree anyway, then skip it; if the file
> doesn't exist in the index but it also isn't in the sparse-checkout
> cone, then also skip it, because we don't care about the file anyway.
> 
> I was going to ask if we could check ce_skip_worktree() without checking
> pos first, but I suppose a negative pos would make the array deref
> pretty unhappy. Ok.
> 

Exactly! Generally the current skip-worktree flag is the "source of truth"
on whether to add the flag to the new entry, but if the file isn't in the
index pre-reset, the sparse checkout patterns are used to determine if it
should have skip-worktree applied.

>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 886e78715fe..889079f55b8 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -459,26 +459,17 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
>>  	test_all_match git blame deep/deeper2/deepest/a
>>  '
>>  
>> -# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>> -# in this scenario, but it shouldn't.
>> -test_expect_failure 'checkout and reset (mixed)' '
>> +test_expect_success 'checkout and reset (mixed)' '
> 
> Ooh ooh, we can start using these tests :) Always exciting.
> 
>>  	init_repos &&
>>  
>>  	test_all_match git checkout -b reset-test update-deep &&
>>  	test_all_match git reset deepest &&
>> -	test_all_match git reset update-folder1 &&
>> -	test_all_match git reset update-folder2
>> -'
>> -
>> -# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>> -# in this scenario, but it shouldn't.
>> -test_expect_success 'checkout and reset (mixed) [sparse]' '
>> -	init_repos &&
>>  
>> -	test_sparse_match git checkout -b reset-test update-deep &&
>> -	test_sparse_match git reset deepest &&
>> +	# Because skip-worktree is preserved, resetting to update-folder1
>> +	# will show worktree changes for full-checkout that are not present
>> +	# in sparse-checkout or sparse-index.
> 
> This doesn't really have anything to do with your patch. But I'm having
> a very hard time understanding what each branch you're switching between
> and basing on is for; this entire test suite is a little miserly with
> comments. 

The branches used in this test are:

* `base` is the initial branch; all branches in the list here contain one
  commit on top of `base`
* `update-deep` modifies a file inside the sparse checkout cone (`deep/a`) 
* `deepest` modifies a file deep inside the sparse checkout cone
  (`deep/deeper1/deepest/a`)
* `update-folder1` and `update-folder2` each modify a file outside the
  sparse checkout cone (`folder1/a` and `folder2/a`, respectively)

There are other branches used throughout the file, but they deal with more
complicated conflict scenarios not used in this particular test case. 

> I *think* your comment is saying that you're not bothering to
> check test_all_match because you know that the full-checkout tree won't
> match? But I also don't see that being asserted; test_sparse_match looks
> to compare sparse-checkout and sparse-index trees but doesn't say
> anything at all about the full-checkout tree, right?
> 

Your understanding is correct (it's attempting to explain why we're not
using `test_all_match`, unlike earlier assertions in the test). That said,
it probably _should_ assert on the differences from `full-checkout`, namely
that "M	folder1/a" would appear in `full-checkout` but not in
`sparse-checkout`/`sparse-index`. I can add that in my next version.

>>  	test_sparse_match git reset update-folder1 &&
>> -	test_sparse_match git reset update-folder2
>> +	run_on_sparse test_path_is_missing folder1
>>  '
>>  
>>  test_expect_success 'merge, cherry-pick, and rebase' '
>> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
>> index 601b2bf97f0..d05426062ec 100755
>> --- a/t/t7102-reset.sh
>> +++ b/t/t7102-reset.sh
>> @@ -472,6 +472,23 @@ test_expect_success '--mixed refreshes the index' '
>>  	test_cmp expect output
>>  '
>>  
>> +test_expect_success '--mixed preserves skip-worktree' '
>> +	echo 123 >>file2 &&
> 
> file2 is just in the worktree...
> 
>> +	git add file2 &&
> 
> ...and now it's in the index...
> 
>> +	git update-index --skip-worktree file2 &&
> 
> ...and now we're asking Git to ignore worktree changes to file2...
> 
>> +	git reset --mixed HEAD >output &&
> 
> But now I'm a little confused, maybe because of 'git reset' syntax. I'd
> expect this to say "ah yes, the index is different from HEAD, it's got
> this file2 thingie" and still reset the index; I'm surprised that
> --skip-worktree, which sounds like it's saying only "don't consider
> what's going on in the worktree". So I would expect this to still delete
> file2 from the index. But instead I guess it is keeping file2 in the
> index with the "who cares what happened in the wt" marker?
> 

Yes - `git update-index --skip-worktree` sets the skip-worktree flag on the
index entry of the specified file(s) (in this case, `file2`). So, because
`file2` is in the index but ignored in the worktree, the file isn't
identified as "modified" after `git reset --mixed HEAD`. Once the
skip-worktree flag is removed (with `git update-index --no-skip-worktree`),
the reset results in it showing up as "modified".

>> +	test_must_be_empty output &&
>> +
>> +	cat >expect <<-\EOF &&
>> +	Unstaged changes after reset:
>> +	M	file2
>> +	EOF
>> +	git update-index --no-skip-worktree file2 &&
>> +	git add file2 &&
>> +	git reset --mixed HEAD >output &&
>> +	test_cmp expect output
>> +'
>> +
>>  test_expect_success 'resetting specific path that is unmerged' '
>>  	git rm --cached file2 &&
>>  	F1=$(git rev-parse HEAD:file1) &&
>> -- 
>> gitgitgadget
>>

