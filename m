Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F31DC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 14:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhKWO5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhKWO5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 09:57:05 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC76C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 06:53:57 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id j7so14645013ilk.13
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 06:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I98xLwA18Pr1i+UQqkWCVURlLDYIcVnzfUSZGDrk7mw=;
        b=Lw0uT5/mKCP8vJ5hfPkqz+oU3enyy2TuH1jGNcwd8ycQeWWqgxfvTM9T9bnriB7MYH
         vP6sE74gOHit8ZKrwQWJ+KNihKiVp2+GJ4eYxmP/gqWy9Kjyzs5iRF88jMInNgTXu63X
         FaP4BMV/J/JVmHR9W+D8EypIedCNIy5YFLK4gbiUky9bhrzenPK+wmbFZmKq+qJSNzxO
         mFDsg0zBbL2qdcSkuoliUl0jIBFemnpXMQ6HGIBxyPzJLB2kIicxAzn5KVuDldjEoHqk
         2Ihwp56QEc/L3jW1suFeVth5Bk9rLcB1H2l6ZBK9PID2M2CW937IxCwZCTg3//A5TqCS
         tP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I98xLwA18Pr1i+UQqkWCVURlLDYIcVnzfUSZGDrk7mw=;
        b=Fgjy/5S+9JYIYXXKQdGJLdfdefFyiwrQbn+lypRzkXXwYRA5xnTiCV3dXYJGSQTsqK
         DGGGVk4GyvLDobs+z+y2K0cy4vUloL4UEL2paavncCYdNbAXUqNVV3pi+/pfNbblwJMk
         RwIkTxmHN1mBq/vAMstWYPUOheSRXJZvNPyHAzsAZTtj1xcpw4Nen6QAIVcXZtM1njSP
         /XM2B42kKmTNSK+2AAmJUx0fz2lPUm6i/B0B4W6jvsZC276In9SgRJTQgcz3fKXiSstA
         5oKNytE39CQBUkLtPLGAQjZNBWXiT6x56J95XfsPl0AwyHxbqwj3eV0A+h2NuYZ4V1V/
         dSQQ==
X-Gm-Message-State: AOAM530DyAbYJzOnfjNDnioOrUU51UKRXqwLab/mzMjvKSc4PhE9mPmL
        kRS8TvOtellzvGmzz+/cOixmXP/MYvs=
X-Google-Smtp-Source: ABdhPJxbMmwocr3CE/0dhcAokuyF+ggoLjTFWePYpxURso2bbn/tcTA5ItHnY7XigvIDU07sI5Hn8g==
X-Received: by 2002:a92:da4c:: with SMTP id p12mr5614300ilq.32.1637679236940;
        Tue, 23 Nov 2021 06:53:56 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id x5sm7809664iov.50.2021.11.23.06.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:53:56 -0800 (PST)
Message-ID: <f86c920b-6b56-27ca-fba5-a54c5c15c765@gmail.com>
Date:   Tue, 23 Nov 2021 06:53:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 3/4] diff: enable and test the sparse index
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <273ee16b74ed4b36ffba5762fa892410317ea02b.1637620958.git.gitgitgadget@gmail.com>
 <CABPp-BEurZH8RaLLB2vvw3aPCWy4Aq1Zs+PkTY9WFboq8OuZ2w@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BEurZH8RaLLB2vvw3aPCWy4Aq1Zs+PkTY9WFboq8OuZ2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/22/21 11:47 PM, Elijah Newren wrote:
> On Mon, Nov 22, 2021 at 2:42 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Enable the sparse index within the 'git diff' command. Its implementation
>> already safely integrates with the sparse index because it shares code
>> with the 'git status' and 'git checkout' commands that were already
>> integrated.  For more details see:
>>
>> d76723e (status: use sparse-index throughout, 2021-07-14)
>> 1ba5f45 (checkout: stop expanding sparse indexes, 2021-06-29)
> 
> I preferred the references in your v3:
> 
> d76723ee53 (status: use sparse-index throughout, 2021-07-14)
> 1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)
> 
> because 7-character abbreviations aren't very future proof;
> 10-character seems better to me.
> 
> (Very micro nit.)
> 
Appreciate the pointer - I'll return to the old formatting for v5.
>>
>> The most interesting thing to do is to add tests that verify that 'git
>> diff' behaves correctly when the sparse index is enabled. These cases are:
>>
>> 1. The index is not expanded for 'diff' and 'diff --staged'
>> 2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
>> checkout, and sparse index repositories in the following partially-staged
>> scenarios (i.e. the index, HEAD, and working directory differ at a given
>> path):
>>      1. Path is within sparse-checkout cone
>>      2. Path is outside sparse-checkout cone
>>      3. A merge conflict exists for paths outside sparse-checkout cone
>>
>> The `p2000` tests demonstrate a ~44% execution time reduction for 'git
>> diff' and a ~86% execution time reduction for 'git diff --staged' using a
>> sparse index:
>>
>> Test                                      before  after
>> -------------------------------------------------------------
>> 2000.30: git diff (full-v3)               0.33    0.34 +3.0%
>> 2000.31: git diff (full-v4)               0.33    0.35 +6.1%
>> 2000.32: git diff (sparse-v3)             0.53    0.31 -41.5%
>> 2000.33: git diff (sparse-v4)             0.54    0.29 -46.3%
>> 2000.34: git diff --cached (full-v3)      0.07    0.07 +0.0%
>> 2000.35: git diff --cached (full-v4)      0.07    0.08 +14.3%
>> 2000.36: git diff --cached (sparse-v3)    0.28    0.04 -85.7%
>> 2000.37: git diff --cached (sparse-v4)    0.23    0.03 -87.0%
>>
>> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   builtin/diff.c                           |  5 +++
>>   t/perf/p2000-sparse-operations.sh        |  2 ++
>>   t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
>>   3 files changed, 53 insertions(+)
>>
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index dd8ce688ba7..fa4683377eb 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -437,6 +437,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>
>>          prefix = setup_git_directory_gently(&nongit);
>>
>> +       if (!nongit) {
>> +               prepare_repo_settings(the_repository);
>> +               the_repository->settings.command_requires_full_index = 0;
>> +       }
>> +
>>          if (!no_index) {
>>                  /*
>>                   * Treat git diff with at least one path outside of the
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index bfd332120c8..5cf94627383 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -113,5 +113,7 @@ test_perf_on_all git checkout -f -
>>   test_perf_on_all git reset
>>   test_perf_on_all git reset --hard
>>   test_perf_on_all git reset -- does-not-exist
>> +test_perf_on_all git diff
>> +test_perf_on_all git diff --cached
>>
>>   test_done
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 44d5e11c762..53524660759 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -832,6 +832,52 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
>>          )
>>   '
>>
>> +test_expect_success 'sparse index is not expanded: diff' '
>> +       init_repos &&
>> +
>> +       write_script edit-contents <<-\EOF &&
>> +       echo text >>$1
>> +       EOF
>> +
>> +       # Add file within cone
>> +       test_sparse_match git sparse-checkout set deep &&
>> +       run_on_all ../edit-contents deep/testfile &&
>> +       test_all_match git add deep/testfile &&
>> +       run_on_all ../edit-contents deep/testfile &&
>> +
>> +       test_all_match git diff &&
>> +       test_all_match git diff --staged &&
>> +       ensure_not_expanded diff &&
>> +       ensure_not_expanded diff --staged &&
>> +
>> +       # Add file outside cone
>> +       test_all_match git reset --hard &&
>> +       run_on_all mkdir newdirectory &&
>> +       run_on_all ../edit-contents newdirectory/testfile &&
>> +       test_sparse_match git sparse-checkout set newdirectory &&
>> +       test_all_match git add newdirectory/testfile &&
>> +       run_on_all ../edit-contents newdirectory/testfile &&
>> +       test_sparse_match git sparse-checkout set &&
>> +
>> +       test_all_match git diff &&
>> +       test_all_match git diff --staged &&
>> +       ensure_not_expanded diff &&
>> +       ensure_not_expanded diff --staged &&
>> +
>> +       # Merge conflict outside cone
>> +       # The sparse checkout will report a warning that is not in the
>> +       # full checkout, so we use `run_on_all` instead of
>> +       # `test_all_match`
>> +       run_on_all git reset --hard &&
>> +       test_all_match git checkout merge-left &&
>> +       test_all_match test_must_fail git merge merge-right &&
>> +
>> +       test_all_match git diff &&
>> +       test_all_match git diff --staged &&
>> +       ensure_not_expanded diff &&
>> +       ensure_not_expanded diff --staged
> 
> You've changed some of the --staged to --cached, but based on Junio's
> comments on the previous round, you probably want to convert the
> others too.
> 
Will do for v5.
>> +'
>> +
>>   # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>>   # in this scenario, but it shouldn't.
>>   test_expect_success 'reset mixed and checkout orphan' '
>> --
>> gitgitgadget
>>
