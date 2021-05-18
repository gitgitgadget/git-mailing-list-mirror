Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C9FC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE9260240
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbhERS1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbhERS1t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:27:49 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87BC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:26:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o27so10231512qkj.9
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kD1UAbRU9cFyJ0ueZ1HVyAtbYJkxALPYh00/SH6VvcI=;
        b=dd6knu/TaVX/zf6OtRK/myUp+Cy4UvoTgFYfBXBK+nBMMKxr/fkCC1JaTuIoQgw1dN
         W5hot1MnTSk7hQ8cHRnXg15l57M/5BuirXicN1J+8Kfesprt6M7Trjhr4hcYz64hh3ab
         x6hcPEbH7IOdaXv3k1oE/DDyRrjE00i12hONSfvQNbg1mslXozjAE/N889Jq79EUOveX
         ZztIlkKZVtYUadYIfsRsUct/InZadTW3+KEptve2eOXZhqq1lr71ZsLoJNQZ9tBEghrP
         lJRuJXISsJCio7yU4KrL5/zgM3YQHNd5cRJ913cKOHNRSIGn9hXtK6KIn4sZCUcsZ94w
         JAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kD1UAbRU9cFyJ0ueZ1HVyAtbYJkxALPYh00/SH6VvcI=;
        b=j4aBvxLo3cmbhSVoGLYtHh6X/CDBfXIhp7qW3wWgAz6scwZw8tn0EHxJ91cUt0EjjA
         HQLIEILTO68bwbod62usCpbPX/xirNBEmjHEJPt1Wdul0B0a3GyNP0GOIsKNnXCVC8d/
         Se6j3lkOiYI+MO6UeTAQW7GxE+7qaYrx+OW+KGJs983tArzVNVATnzzwl6wwGzxMhMIi
         dgJ6KbZkvzDgZOsXlgStiCL0tiw74tUM7L/8b3JeDmoOkq78Y15iuEB4l6Kav5xBTGGv
         3WtQFORl3p5m/mI7h8EE31Ld6JgjmqBW8rFdmyqmyDqlxAb5tutFAqmk7dMS4GjvlQiY
         cevg==
X-Gm-Message-State: AOAM533yKYYuk1jfCrTGp84Wga+oR35mMRvsLMQPF0//sLW1o2LEhmWU
        fhZUqVo954tWVmI9FLtsWc0=
X-Google-Smtp-Source: ABdhPJwh5OpA8WwbG71BzRUNB71M1766fsKyAkWmwr/us6ksqAllNxStf1PvR6Sofm/AeETbv3+nuA==
X-Received: by 2002:a37:6116:: with SMTP id v22mr6921213qkb.464.1621362390581;
        Tue, 18 May 2021 11:26:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id i11sm13038382qtv.8.2021.05.18.11.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 11:26:30 -0700 (PDT)
Subject: Re: [PATCH v3 11/12] wt-status: expand added sparse directory entries
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <3b42783d4a86473420480b2789d61d8103e6e7d4.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BGww6VPMmp9dDyRJ2vgNCOdj16-LjU3aM3MM1NQ+T-pmg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a96b5081-e913-22a8-45eb-8d5de432dccb@gmail.com>
Date:   Tue, 18 May 2021 14:26:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BGww6VPMmp9dDyRJ2vgNCOdj16-LjU3aM3MM1NQ+T-pmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 10:27 PM, Elijah Newren wrote:
> On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> It is difficult, but possible, to get into a state where we intend to
>> add a directory that is outside of the sparse-checkout definition. Add a
> 
> Then we need to fix that; allowing things to be added outside the
> sparse-checkout definition is a bug[1][2].  That's an invariant I
> believe we should maintain everywhere; things get really confusing to
> users somewhere later down the road if we don't.  Matheus worked to
> fix that with 'git add'; if there are other commands that need fixing
> too, then we should also fix them.
> 
> [1] https://lore.kernel.org/git/CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com/
> [2] https://lore.kernel.org/git/CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com/
> 
>> test to t1092-sparse-checkout-compatibility.sh that demonstrates this
>> using a combination of 'git reset --mixed' and 'git checkout --orphan'.
> 
> I think `git checkout --orphan` should just throw an error if
> sparse-checkout is in use.  Allowing adding paths outside the
> sparse-checkout set causes too much collateral and deferred confusion
> for users.

I've been trying to strike an interesting balance of creating
performance improvements without changing behavior, trying to
defer those behavior changes to an isolated instance. I think
that approach is unavoidable with the 'git add' work that I
pulled out of this series and will return to soon.

However, here I think it would be too much to start throwing
an error in this case. I think that change is a bit too much.

The thing I can try to do, instead of the current approach, is
to not allow sparse directory entries to differ between the
index and HEAD. That will satisfy this case, but also a lot of
other painful cases.

I have no idea how to actually accomplish that, but I'll start
digging.

>> This test failed before because the output of 'git status
>> --porcelain=v2' would not match on the lines for folder1/:
>>
>> * The sparse-checkout repo (with a full index) would output each path
>>   name that is intended to be added.
>>
>> * The sparse-index repo would only output that "folder1/" is staged for
>>   addition.
>>
>> The status should report the full list of files to be added, and so this
>> sparse-directory entry should be expanded to a full list when reaching
>> it inside the wt_status_collect_changes_initial() method. Use
>> read_tree_at() to assist.
> 
> Having a sparse directory entry whose object_id in the index does not
> match HEAD should be an error.

I can get behind this understanding.

>  Have a CE_SKIP_WORKTREE non-directory
> whose object_id in the index does not match HEAD should also be an
> error.

I'm less convinced here. At minimum, I'm not willing to stake
a firm claim and change the behavior around this statement in
the current series.

>  I don't think we should complicate the code to try to handle
> violations of those assumptions.  I do think we should add checks to
> enforce that constraint (or BUG() if it's violated).

A BUG() is likely too strict, because existing Git clients can
get users into this state, and then they upgrade and are suddenly
in a BUG() state. We should perhaps do our best effort to avoid
this case and handle it as appropriately as possible.

> And yeah, that also means 'git sparse-checkout add/set' would need to
> error out if paths are requested to be sparsified despite being
> different from HEAD.

This would be a reasonable thing, assuming the established
behavior is changed.

>> Somehow, this loop over the cache entries was not guarded by
>> ensure_full_index() as intended.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 28 +++++++++++++
>>  wt-status.c                              | 50 ++++++++++++++++++++++++
>>  2 files changed, 78 insertions(+)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 59faf7381093..cd3669d36b53 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -492,4 +492,32 @@ test_expect_success 'sparse-index is not expanded' '
>>         test_region ! index ensure_full_index trace2.txt
>>  '
>>
>> +test_expect_success 'reset mixed and checkout orphan' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout rename-out-to-in &&
>> +       test_all_match git reset --mixed HEAD~1 &&
>> +       test_sparse_match test-tool read-cache --table --expand &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git status --porcelain=v2 &&
>> +
>> +       # At this point, sparse-checkouts behave differently
>> +       # from the full-checkout.
>> +       test_sparse_match git checkout --orphan new-branch &&
>> +       test_sparse_match test-tool read-cache --table --expand &&
>> +       test_sparse_match git status --porcelain=v2 &&
>> +       test_sparse_match git status --porcelain=v2
>> +'
>> +
>> +test_expect_success 'add everything with deep new file' '
>> +       init_repos &&
>> +
>> +       run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
>> +
>> +       run_on_all touch deep/deeper1/x &&
>> +       test_all_match git add . &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git status --porcelain=v2
>> +'>
> This was a really nice catch that you got this particular testcase.
> While I disagree with the fix, I do have to say nice work on the catch
> and the implementation otherwise.

This test exists almost verbatim in the Scalar and VFS For Git
functional tests. I have no idea what context caused it to be
necessary.

I can understand your aversion to the solution I presented here.
Preventing sparse directory entries that differ from the tree at
HEAD for that path should be more robust to future integrations.

Thanks,
-Stolee
