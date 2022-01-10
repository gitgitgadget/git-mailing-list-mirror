Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4735C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiAJSB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiAJSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:01:57 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B64C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:01:57 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id fq10so15252138qvb.10
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h2EBG/UWICgjUgghPRMCckKkheiMr+mxQALjVZMs8Gw=;
        b=BXDgZ2xeuYmf9CT4aZOTnvtFZrQI9B9+MtLG3jX75/XvxZ8+ymSVyfbpjHMtOODnn9
         H2nkVlDuU52wAJBPl5ga0LLBj/TMXprwfQJPUoix34CqwL/N4bmpS0LURUlDZNuQPPIF
         pHwemdJ6ENdOC6dcLYMsjvw7BJbMhDwTtClUr5Uvj6dM4mwtONleYhOXUFkYKGKq1W3S
         blmTb6+z4gyPXEMTVRa/C1i6wch+CK/bmeDE1T9k8DxLOFEzLZkCATh24nEy53RGVWV0
         dglsPCC0XdEJqW4W8SystZ1WDTj3E2YuTW1xRsV901DTYvmRDlnpynXzeJ+VPQnTYWri
         Zpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h2EBG/UWICgjUgghPRMCckKkheiMr+mxQALjVZMs8Gw=;
        b=3CyWcF2YRJ9tXt8k0lVquR4JnFCM5ysK9rs9nXqjfyFPaA7Lge+A3ie02oTGEJiq9h
         0pEixo9u537X+ef6kwUr4eoX3BVmiE4TXOxKln3vUpEGSviwX8PbJlhFZrll2/9Yvjec
         hoxLyigyvLj0NItXemOyDUkFKRnEMRVoiNZc6z5yj9S981iHQ/38hjMp6Mu+8R676ReE
         h/U2GjoyU5FC4aUkbzgOGkCpa6ee+3rHoyoYk56Eoq4nZOeVt5YPCHICiMLWD+AmBhMi
         sV1hOIkv5wiE5AjW3QtPhE5J/ZLR0RXuct6b8F9Hl/xQHXWVCCZudPhPJxr6Y9m+ZdVp
         Bmvw==
X-Gm-Message-State: AOAM533ffF1SipJl8NM7ZEyEd/fQFpB6KVFyPmHQ4JhwELmNaD2v8PdD
        Je/Bw5RRCzcOGPCCpCnCK+Kp
X-Google-Smtp-Source: ABdhPJynjHlC05ujfQ4+CWahB1D6NUeXOwSriJVgjLP95vuArK4eRbAAFyVZtRUeXIt9zlRo3XFLbA==
X-Received: by 2002:ad4:5def:: with SMTP id jn15mr570125qvb.109.1641837715751;
        Mon, 10 Jan 2022 10:01:55 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id s27sm5566319qtc.0.2022.01.10.10.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:01:55 -0800 (PST)
Message-ID: <bec659b2-8d69-c69c-73e5-a56ae415874b@github.com>
Date:   Mon, 10 Jan 2022 13:01:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 7/9] update-index: add tests for sparse-checkout
 compatibility
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <3b734f89c0f2f473d71a5d3c85faec6d48a0e350.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BHadoOToWb6Kp7rUj03ZzKhzK_aFJymT_zApEw8st2ttA@mail.gmail.com>
 <159a35ba-7ed0-c601-15bd-54dfda460323@github.com>
 <CABPp-BEXYZxThegY9WvudY0B7KJ1HQm--Kwe5zxQOxvzHMHN1A@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BEXYZxThegY9WvudY0B7KJ1HQm--Kwe5zxQOxvzHMHN1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Mon, Jan 10, 2022 at 7:47 AM Victoria Dye <vdye@github.com> wrote:
>>
>> Elijah Newren wrote:
>>> On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> From: Victoria Dye <vdye@github.com>
>>>>
>>>> Introduce tests for a variety of `git update-index` use cases, including
>>>> performance scenarios.
>>>
>>> Makes sense.
>>>
>>>> Tests for `update-index add/remove` are specifically
>>>> focused on how `git stash` uses `git update-index` as a subcommand to
>>>> prepare for sparse index integration with `stash` in a future series.
>>>
>>> This is possibly a tangent, but I'd rather that if we were trying to
>>> fix `git stash`, that we instead would do so by making it stop forking
>>> subprocesses and having it call internal API instead.  See for
>>> example, a4031f6dc0 ("Merge branch 'en/stash-apply-sparse-checkout'
>>> into maint", 2021-02-05) which did this.  The fact that it forks so
>>> many subprocesses is a bug, and comes from the fact that stash is a
>>> partial conversion from shell to C.  I think the subprocess forking is
>>> part of the problem that causes issues for sparse-checkouts, as I
>>> spelled out in patches 2 & 3 of the series I mentioned above.
>>>
>>> However, that doesn't affect this series.
>>>
>>>> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
>>>> Signed-off-by: Victoria Dye <vdye@github.com>
>>>> ---
>>>>  t/perf/p2000-sparse-operations.sh        |   1 +
>>>>  t/t1092-sparse-checkout-compatibility.sh | 125 +++++++++++++++++++++++
>>>>  2 files changed, 126 insertions(+)
>>>>
>>>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>>>> index 54f8602f3c1..7dbed330160 100755
>>>> --- a/t/perf/p2000-sparse-operations.sh
>>>> +++ b/t/perf/p2000-sparse-operations.sh
>>>> @@ -118,5 +118,6 @@ test_perf_on_all git diff --cached
>>>>  test_perf_on_all git blame $SPARSE_CONE/a
>>>>  test_perf_on_all git blame $SPARSE_CONE/f3/a
>>>>  test_perf_on_all git checkout-index -f --all
>>>> +test_perf_on_all git update-index --add --remove
>>>>
>>>>  test_done
>>>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>>>> index 6ecf1f2bf8e..6804ab23a27 100755
>>>> --- a/t/t1092-sparse-checkout-compatibility.sh
>>>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>>>> @@ -630,6 +630,131 @@ test_expect_success 'reset with wildcard pathspec' '
>>>>         test_all_match git ls-files -s -- folder1
>>>>  '
>>>>
>>>> +test_expect_success 'update-index modify outside sparse definition' '
>>>> +       init_repos &&
>>>> +
>>>> +       write_script edit-contents <<-\EOF &&
>>>> +       echo text >>$1
>>>> +       EOF
>>>> +
>>>> +       # Create & modify folder1/a
>>>> +       run_on_sparse mkdir -p folder1 &&
>>>> +       run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
>>>> +       run_on_all ../edit-contents folder1/a &&
>>>
>>> As I've mentioned to Stolee, I'd rather these were explicitly marked
>>> as intentionally setting up an erroneous condition.
>>>
>>> However, that might not matter if my other series gets accepted (the
>>> one I promised to send out yesterday, but then spent all day
>>> responding to emails instead).  Hopefully I'll send it soon.
>>>
>>>> +
>>>> +       # If file has skip-worktree enabled, update-index does not modify the
>>>> +       # index entry
>>>> +       test_sparse_match git update-index folder1/a &&
>>>> +       test_sparse_match git status --porcelain=v2 &&
>>>> +       test_must_be_empty sparse-checkout-out &&
>>>> +
>>>> +       # When skip-worktree is disabled (even on files outside sparse cone), file
>>>> +       # is updated in the index
>>>> +       test_sparse_match git update-index --no-skip-worktree folder1/a &&
>>>> +       test_all_match git status --porcelain=v2 &&
>>>> +       test_all_match git update-index folder1/a &&
>>>> +       test_all_match git status --porcelain=v2
>>>
>>> These make sense.
>>>
>>>> +'
>>>> +
>>>> +test_expect_success 'update-index --add outside sparse definition' '
>>>> +       init_repos &&
>>>> +
>>>> +       write_script edit-contents <<-\EOF &&
>>>> +       echo text >>$1
>>>> +       EOF
>>>> +
>>>> +       # Create folder1, add new file
>>>> +       run_on_sparse mkdir -p folder1 &&
>>>> +       run_on_all ../edit-contents folder1/b &&
>>>> +
>>>> +       # Similar to `git add`, the untracked out-of-cone file is added to the index
>>>> +       # identically across sparse and non-sparse checkouts
>>>> +       test_all_match git update-index --add folder1/b &&
>>>> +       test_all_match git status --porcelain=v2
>>>
>>> The comment is not correct:
>>>
>>
>> It is correct, but for *untracked* out-of-cone files only. Those files don't
>> have a `skip-worktree` bit because they're not in the index in the first
>> place.
> 
>> The comment is intended to highlight the fact that `update-index`
>> (like `git add`, `git status`, etc.) "decides" whether to operate on a file
>> in a sparse-checkout based on `skip-worktree`, *not* the sparse patterns.
> 
> git-update-index may not pay attention to the sparsity patterns for
> untracked files, but `git add` does.  Let me demonstrate.  First, I
> set up a simple repo where the following is true:
> 
> $ git ls-files -t
> H in-cone/foo.c
> S out-of-cone/tracked
> $ git status --porcelain
> ?? out-of-cone/initially-untracked
> 
> Now, let's compare `git add` and `git add --sparse`.  First, without --sparse:
> 
> $ git add out-of-cone/initially-untracked
> The following paths and/or pathspecs matched paths that exist
> outside of your sparse-checkout definition, so will not be
> updated in the index:
> out-of-cone/initially-untracked
> hint: If you intend to update such entries, try one of the following:
> hint: * Use the --sparse option.
> hint: * Disable or modify the sparsity rules.
> hint: Disable this message with "git config advice.updateSparsePath false"
> $ git ls-files -t
> H in-cone/foo.c
> S out-of-cone/tracked
> 
> So, `git add $UNTRACKED` did not add the file.  In contrast:
> 
> $ git add --sparse out-of-cone/initially-untracked
> $ git ls-files -t
> H in-cone/foo.c
> H out-of-cone/initially-untracked
> S out-of-cone/tracked
> 
> So, `git add --sparse $UNTRACKED` did add it.
> 

Sorry about that - when I wrote the first version of this series in the
`microsoft/git` fork, `git add` hadn't been updated to reject out-of-cone
untracked files as it is in [1]. It's my mistake for not double-checking
that it was still the case, apologies for wasting your time on re-explaining
this.

In any case, I'll update the test comment and commit message per your
suggestion:

>>> I might buy that `git update-index` is lower level and should be
>>> considered the same as `git add --sparse`, but the comment should
>>> mention that and try to sell why update-index should be equivalent to
>>> that instead of to `git add`.

I'm leaning only slightly towards the current behavior (and will update the
comment accordingly), but I'm happy to change it if the reasoning isn't as
strong as that of another approach.

[1] 105e8b014b (add: fail when adding an untracked sparse file, 2021-09-24)

>> Seeing as the comparison to `git add` makes things more confusing, I'll
>> rephrase the test comment.
>>
>>> $ git add out-of-cone/file
>>> The following paths and/or pathspecs matched paths that exist
>>> outside of your sparse-checkout definition, so will not be
>>> updated in the index:
>>> out-of-cone/file
>>> hint: If you intend to update such entries, try one of the following:
>>> hint: * Use the --sparse option.
>>> hint: * Disable or modify the sparsity rules.
>>> hint: Disable this message with "git config advice.updateSparsePath false"
>>>
>>> I might buy that `git update-index` is lower level and should be
>>> considered the same as `git add --sparse`, but the comment should
>>> mention that and try to sell why update-index should be equivalent to
>>> that instead of to `git add`.
>>>
>>
>> Tracked, out-of-cone files aren't affected by `--add` (the flag allows
>> `update-index` to add untracked files), and `update-index out-of-cone/tracked`
>> would ignore the file.
> 
> Yes, I believe you're explaining update-index behavior correctly.
> 
>> so I believe the behavior of `update-index` is
>> currently more consistent with `git add` than `git add --sparse`.
> 
> But not quite `git add`'s.  Just to be clear, let's add update-index
> to the above comparison I did between add and add --sparse.  First,
> let's go back to the initial setup point:
> 
> $ git ls-files -t
> H in-cone/foo.c
> S out-of-cone/tracked
> $ git status --porcelain
> ?? out-of-cone/initially-untracked
> 
> Now, let's try update-index:
> 
> $ git update-index --add out-of-cone/initially-untracked
> $ git ls-files -t
> H in-cone/foo.c
> H out-of-cone/initially-untracked
> S out-of-cone/tracked
> 
> So, in other words, `git update-index --add $UNTRACKED` matches the
> behavior of `git add --sparse $UNTRACKED`, not the behavior of `git
> add $UNTRACKED`.
> 
>>>> +'
>>>> +
>>>> +test_expect_success 'update-index --remove outside sparse definition' '
>>>> +       init_repos &&
>>>
>>>> +
>>>> +       # When `--ignore-skip-worktree-entries` is specified, out-of-cone files are
>>>> +       # not removed from the index if they do not exist on disk
>>>> +       test_sparse_match git update-index --remove --ignore-skip-worktree-entries folder1/a &&
>>>> +       test_all_match git status --porcelain=v2 &&
>>>
>>> The file is present despite being marked to be missing, we're ignoring
>>> the intention of the marking, and we ask for it to be removed, so we
>>> don't remove it?
>>>
>>> The levels of negation are _very_ confusing.  It took me a while to
>>> unravel this.  I think the logic is something like this
>>>   * folder1/a is marked as SKIP_WORKTREE, meaning it's not supposed to
>>> be in the worktree.
>>>   * and it's not.
>>>   * We are stating that we're ignoring SKIP_WORKTREE, though, so this
>>> looks like a regular file that has been deleted.
>>> So, what would `git update-index --remove $FILE` do for a normal $FILE
>>> deleted from the working copy?  According to the docs:
>>>
>>>     --remove
>>>            If a specified file is in the index but is missing then it’s
>>>            removed. Default behavior is to ignore removed file.
>>>
>>> So, the docs say it would remove it.  But you don't.
>>>
>>>
>>> After digging around and looking at the testcase below, if I had to
>>> guess what happened, I would say that you figured out what the
>>> SKIP_WORKTREE behavior was, and assumed that was correct, and added a
>>> flag that allowed you to request the opposite behavior.
>>> Unfortunately, I think the pre-existing behavior is buggy.
>>>
>>
>> I understand why you find it buggy, but I am not making baseless assumptions
>> about the correctness (or lack thereof) of the current behavior.
> 
> To be clear, the fact that the behavior was there for a decade would
> typically be basis enough for an assumption (in my opinion), and I
> wouldn't have faulted folks for making it.  I might well have done so
> myself.  My reasoning was just that I was getting confused by the
> negations and trying to understand the testcase, and when I started to
> unravel it, I found what looked like a possible inconsistency.
> 
> Anyway, it's clear here you've actually dug a lot deeper and know the
> history here.  In contrast, I was making assumptions about the history
> (and ones that weren't correct, though I'd argue my assumptions
> weren't baseless)...
> 

Your assumptions were completely valid, I apologize if my response came off
as implying otherwise. I'll try to use the comments on the tests to clarify
their behavior as much as possible, hopefully reducing some confusion around
all the multiple-negative flags & options.

>> This
>> specific "gap" in `update-index --remove` has been discussed in the past [1]
>> and was acknowledged as non-ideal and a candidate for change in the future.
>> At the time, the introduction of `--ignore-skip-worktree-entries` [2] was a
>> "safe" way to ignore `skip-worktree` without changing the default behavior.
>>
>> Personally, I think updating the default behavior of `--remove` (and
>> corresponding deprecation of `--[no-]ignore-skip-worktree-entries`) is
>> probably the right way to go. However, I'd like to avoid including it in
>> this series because it deviates pretty substantially from the goal
>> "integrate with sparse index", and as a result has the potential to
>> overshadow/derail the rest of the series. If you're alright with (slightly)
>> deferring changes to the behavior of `--remove`, I can submit a separate
>> series for it once this one has stabilized.
>>
>> [1] https://lore.kernel.org/git/xmqq36fda3i8.fsf@gitster-ct.c.googlers.com/
>> [2] https://lore.kernel.org/git/163b42dfa21c306dc1dc573c5edfc8bda5c99fd0.1572432578.git.gitgitgadget@gmail.com/
> 
> Oh, wow.
> 
> Yeah, fixing it in a later series seems fine.  However, could you add
> a comment to these testcases that --remove has behavior that violates
> the definition of `SKIP_WORKTREE`, and that we might want to fix that
> in the future but for now you are just testing the pre-existing
> behavior for coverage?
> 

Will do!

> (There is a possibility we can't fix it for some reason when we dig
> in.  In that case, we should update the documentation for `--remove`
> to call out this special case.  But again, that can be for a later
> series.)
> 
>>> Of course, there's lots of negation here.  Did I get something
>>> backwards by chance?
>>>
>>>> +
>>>> +       # When the flag is _not_ specified ...
>>>
>>> In my head I'm translating this as:
>>>
>>> SKIP_WORKTREE = !worktree
>>> --ignore-skip-worktree-entries = !!worktree
>>> "flag is _not_ specified" = !!!worktree ?
>>>
>>> I'm not sure I would do anything to change it, but just pointing out
>>> it can be a little hard for others to come up to speed.
>>>
>>
>> Most of the confusion likely comes from the non-standard behavior of
>> `--remove`, but I think I can distill it into (somewhat) straightforward
>> statements about `update-index`:
>>
>> 1. When using the command *without* either `--ignore-skip-worktree-entries`
>>    OR `--remove`, `skip-worktree` entries provided to the command are
>>    ignored.
>> 2. When using the command *with* `--remove` and *without*
>>    `--ignore-skip-worktree-entries`, `skip-worktree` entries are *not*
>>    ignored, and are removed from the index.
>> 3. When both `--remove` and `--ignore-skip-worktree-entries` are specified,
>>    `skip-worktree` entries are again ignored.
>> 4. `--ignore-skip-worktree-entries` has no effect without `--remove` also
>>    specified
>>
>> The goal of this test, then, is to exercise conditions 2 & 3 and directly
>> show their effect on `skip-worktree` entries.
> 
> Yeah, it makes sense to have good test coverage.  +1.
> 
>>
>>>>             ...     , out-of-cone, not-on-disk files are
>>>> +       # removed from the index
>>>> +       rm full-checkout/folder1/a &&
>>>> +       test_all_match git update-index --remove folder1/a &&
>>>> +       test_all_match git status --porcelain=v2 &&
>>>
>>> Documentation/git-update-index.txt defines SKIP_WORKTREE as follows:
>>>
>>> "Skip-worktree bit can be defined in one (long) sentence: When reading
>>> an entry, if it is marked as skip-worktree, then Git pretends its
>>> working directory version is up to date and read the index version
>>> instead."
>>>
>>> If Git is pretending the file is up-to-date, and `git update-index
>>> --remove $UP_TO_DATE_FILE` is typically a no-op because the --remove
>>> flag doesn't do anything when a file is present in the working copy,
>>> then why is this the expected behavior?
>>>
>>> I know it's the traditional behavior of update-index, but
>>> SKIP_WORKTREE support in Git has traditionally been filled with holes.
>>> So, was this behavior by design (despite contradicting the
>>> documentation), or by accident?
>>>
>>
>> As far as I can tell, it appears to have been intentional in the original
>> `skip-worktree` implementation [3], but given Junio & Johannes' discussion
>> on the `--ignore-skip-worktree-entries` patch [1], the sentiment now would
>> probably lean towards having `--remove` ignore `skip-worktree`.
>>
>> [1] https://lore.kernel.org/git/xmqq36fda3i8.fsf@gitster-ct.c.googlers.com/
>>     (copied from earlier in this message)
>> [3] https://lore.kernel.org/git/1250776033-12395-5-git-send-email-pclouds@gmail.com/
> 
> Allow me to comment on this history...
> 
> I can see sometimes wanting to make a command line option a special
> case that doesn't follow the general documented rules.  Not sure I
> believe it in this specific case, but I can see it as being a
> possibility in general.  But when you're going to make an option not
> follow the otherwise documented behavior, then that option's
> documentation should have a special callout about how it diverges
> and/or why it's a special case.  So, this seems like a double-layered
> problem to me (not only choosing the wrong behavior, but leaving the
> documentation to claim it does something else).  It looks like Dscho
> partially tried to fix it, but I would have preferred that Dscho's
> documentation comment he added to `--ignore-skip-worktree-entries` be
> added to `--remove`; it's odd that folks wanting to learn about
> `--remove` behavior need to read the documentation for
> `--ignore-skip-worktree-entries` (even if they aren't using it) in
> order to understand `--remove`'s behavior.
> 
>>> (To be fair, I think the definition given in the manual for
>>> SKIP_WORKTREE is horrible for other reasons, so I don't like leaning
>>> on it.  But I used different logic above in the
>>> --ignore-skip-worktree-entries case to arrive at the same conclusion
>>> that the --remove behavior of update-index seems to be backwards.
>>> Unless I missed a negation in both cases somewhere?  There are so many
>>> floating around...)
>>>
>>>> +       # NOTE: --force-remove supercedes --ignore-skip-worktree-entries, removing
>>>> +       # a skip-worktree file from the index (and disk) when both are specified
>>>> +       test_all_match git update-index --force-remove --ignore-skip-worktree-entries folder1/a &&
>>>> +       test_all_match git status --porcelain=v2
>>>
>>> Makes sense.
>>>
>>>> +'
>>>> +
>>>> +test_expect_success 'update-index with directories' '
>>>> +       init_repos &&
>>>> +
>>>> +       # update-index will exit silently when provided with a directory name
>>>> +       # containing a trailing slash
>>>> +       test_all_match git update-index deep/ folder1/ &&
>>>> +       grep "Ignoring path deep/" sparse-checkout-err &&
>>>> +       grep "Ignoring path folder1/" sparse-checkout-err &&
>>>
>>> Is this desired behavior or just current behavior?
>>>
>>>> +
>>>> +       # When update-index is given a directory name WITHOUT a trailing slash, it will
>>>> +       # behave in different ways depending on the status of the directory on disk:
>>>> +       # * if it exists, the command exits with an error ("add individual files instead")
>>>> +       # * if it does NOT exist (e.g., in a sparse-checkout), it is assumed to be a
>>>> +       #   file and either triggers an error ("does not exist  and --remove not passed")
>>>> +       #   or is ignored completely (when using --remove)
>>>> +       test_all_match test_must_fail git update-index deep &&
>>>> +       run_on_all test_must_fail git update-indexe folder1 &&
>>>
>>> This one will fail for the wrong reason, though -- `update-indexe` is
>>> not a valid subcommand.  (extra 'e' at the end)
>>>
>>
>> Thanks for catching that! I'll update in my next re-roll.
>>
>>>> +       test_must_fail git -C full-checkout update-index --remove folder1 &&
>>>> +       test_sparse_match git update-index --remove folder1 &&
>>>> +       test_all_match git status --porcelain=v2
>>>
>>> Otherwise these seem reasonable.
>>>
>>>> +'
>>>> +
>>>> +test_expect_success 'update-index --again file outside sparse definition' '
>>>> +       init_repos &&
>>>> +
>>>> +       write_script edit-contents <<-\EOF &&
>>>> +       echo text >>$1
>>>> +       EOF
>>>
>>> Copy and paste and forget to remove?  edit-contents doesn't seem to be
>>> used in this test.
>>>
>>
>> Will remove.
>>
>>>> +
>>>> +       test_all_match git checkout -b test-reupdate &&
>>>> +
>>>> +       # Update HEAD without modifying the index to introduce a difference in
>>>> +       # folder1/a
>>>> +       test_sparse_match git reset --soft update-folder1 &&
>>>> +
>>>> +       # Because folder1/a differs in the index vs HEAD,
>>>> +       # `git update-index --remove --again` will effectively perform
>>>> +       # `git update-index --remove folder1/a` and remove the folder1/a
>>>> +       test_sparse_match git update-index --remove --again &&
>>>> +       test_sparse_match git status --porcelain=v2
>>>
>>> This might need a --ignore-skip-worktree-entries, as per the
>>> discussion above.  Otherwise, this test makes sense.
>>>
>>
>> The `--ignore-skip-worktree-entries` option is explicitly omitted because
>> this test needs `update-index` to modify a `skip-worktree` entry. However,
>> given the debate around what `--remove` should do, I'll update the scenario
>> to not use `--remove` or any variation of it.
>>
>>>> +'
>>>> +
>>>> +test_expect_success 'update-index --cacheinfo' '
>>>> +       init_repos &&
>>>> +
>>>> +       deep_a_oid=$(git -C full-checkout rev-parse update-deep:deep/a) &&
>>>> +       folder2_oid=$(git -C full-checkout rev-parse update-folder2:folder2) &&
>>>> +       folder1_a_oid=$(git -C full-checkout rev-parse update-folder1:folder1/a) &&
>>>> +
>>>> +       test_all_match git update-index --cacheinfo 100644 $deep_a_oid deep/a &&
>>>> +       test_all_match git status --porcelain=v2 &&
>>>> +
>>>> +       # Cannot add sparse directory, even in sparse index case
>>>> +       test_all_match test_must_fail git update-index --add --cacheinfo 040000 $folder2_oid folder2/ &&
>>>> +
>>>> +       # Sparse match only - because folder1/a is outside the sparse checkout
>>>> +       # definition (and thus not on-disk), it will appear "deleted" in
>>>> +       # unstaged changes.
>>>> +       test_all_match git update-index --add --cacheinfo 100644 $folder1_a_oid folder1/a &&
>>>> +       test_sparse_match git status --porcelain=v2
>>>
>>> Makes sense, because the update-index command removes the existing
>>> cache entry and adds a new one without the SKIP_WORKTREE bit.  But it
>>> might be worth mentioning that in the commit message.  Also, you could
>>> follow this up with `git update-index --skip-worktree folder1/a`, and
>>> then do a test_all_match git status --porcelain=v2, to show that when
>>> the SKIP_WORKTREE bit is restored back to the file, then it again does
>>> as expected despite not being on-disk.
>>>
>>
>> I really like this - it helps clarify how `update-index` can be used to
>> correctly add a sparse-checkout entry to the index with plumbing commands.
>> I'll include it in V2.
>>
>>>> +'
>>>> +
>>>>  test_expect_success 'merge, cherry-pick, and rebase' '
>>>>         init_repos &&
>>>>
>>>> --
>>>> gitgitgadget

