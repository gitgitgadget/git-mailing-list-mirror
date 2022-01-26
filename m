Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C802CC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 11:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiAZLAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiAZLAM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 06:00:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD8C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:00:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so3996128wme.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HmsqGptPMqxUr5dqc2lAFlkpg5wEIfu3zxan5NNyi6c=;
        b=Ew9VjayQTdk/tdvkgoon406sqz5r9aqXbOj8+KSHkYB7s4fXPo0xBr0ml5sF4M0P20
         YxgsHJou99nFHK6W8nstzGrh9yAPueKHuSB8V33xwmMm9XwfUXxnCICIZL/TXYjmyWqF
         T3akJczrI2mA10meAO1bOokBuKQSLCTzoSM48VF9uPXkrFbJ3e/ELdNYOh7GOsILXv+Y
         mdpFF0BWKlJzCeGizQ97tEIAc3Us3fLm7ZBAoLHb6axy5M0oQrbYTozXapH6N1zJgX+3
         IqsQ8Va9dwLK6KP0oqbV+mEL3Skgpl37fzvAInMa11kpdcs0ywSc2xs4OR4fCKKZjU4B
         4k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HmsqGptPMqxUr5dqc2lAFlkpg5wEIfu3zxan5NNyi6c=;
        b=0mgUWBY8ZiPN2nBKdSnQPyAhV2NzlLeeMI8xjNe36L8ZuC24wstu9aFa83M9OYm/Go
         +Ly38YbdQNYGM8IrA79Ek5BxnHK0KJV9DM6uWu2mwcUUlVBvXWadhDEQUvn9uTRQghvA
         nS7vtyQynt9nfy8aPrtq7t5NrXZG42oBeV8o+Us1+UTnKeqGnYJh8KsaNomMYdE1RLR/
         06BWhi5CZZiQWJCy1LoP4aRjU35FBvwrucJd2EmmwmI4NEgEB5zI5d42nDa3ay8KKK3A
         LftKPtC3VQUX1pFG6KmN2Fp5//ZduKFZk2rnFac1aiel26H0N9xOgIBFCAHlG92ZC5Ue
         /yTg==
X-Gm-Message-State: AOAM531zBItZhsv/Bw98oyIzLS3wFqQX05wjb9Dz0TmzooibA/Y8CF6g
        S7EqEA90iLyUx68G1G2bpP8=
X-Google-Smtp-Source: ABdhPJzRcbhxg4kNfTNgsB7ZP+ttZt3qzl7NN6x2FCMPubq2M7AegleXg3tu+GyWaNBv7TUcYL+scA==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr6883305wmq.24.1643194810604;
        Wed, 26 Jan 2022 03:00:10 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id c10sm19149028wrq.11.2022.01.26.03.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:00:10 -0800 (PST)
Message-ID: <4cdb1e15-31d8-7fa4-b1f3-b43498685e13@gmail.com>
Date:   Wed, 26 Jan 2022 11:00:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, Glen Choo <chooglen@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/01/2022 23:59, Elijah Newren wrote:
> On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Since rebase spawns a `checkout` subprocess, make sure we run that from
>>> the startup_info->original_cwd directory, so that the checkout process
>>> knows to protect that directory.
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>   sequencer.c          | 2 ++
>>>   t/t2501-cwd-empty.sh | 4 ++--
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index ea96837cde3..83f257e7fa4 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>>>
>>>        cmd.git_cmd = 1;
>>>
>>> +     if (startup_info->original_cwd)
>>> +             cmd.dir = startup_info->original_cwd;
>>>        strvec_push(&cmd.args, "checkout");
>>>        strvec_push(&cmd.args, commit);
>>>        strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
>>> diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
>>> index b1182390ba3..52335a8afe9 100755
>>> --- a/t/t2501-cwd-empty.sh
>>> +++ b/t/t2501-cwd-empty.sh
>>> @@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
>>>   '
>>>
>>>   test_expect_success 'rebase does not clean cwd incidentally' '
>>> -     test_incidental_dir_removal failure git rebase reverted
>>> +     test_incidental_dir_removal success git rebase reverted
>>>   '
>>>
>>>   test_expect_success 'rebase fails if cwd needs to be removed' '
>>> -     test_required_dir_removal failure git rebase fd_conflict
>>> +     test_required_dir_removal success git rebase fd_conflict
>>>   '
>>>
>>>   test_expect_success 'revert does not clean cwd incidentally' '
>>> --
>>> gitgitgadget
>>
>> This commit (which is already in master) introduces a bug that breaks
>> rebase when rebasing inside a subdirectory of a worktree. You can see
>> that the below test fails with:
>>
>>    error: The following untracked working tree files would be overwritten by merge:
>>            a/b/c
>>    Please move or remove them before you merge.
> 
> Thanks for the detailed report -- with a full testcase!
> 
>> This only affects subdirectories in worktrees, i.e. rebasing anywhere in
>> the `main-wt` directory is fine, and rebasing from the top of `other-wt`
>> is fine, but `other-wt/any/other/dir` fails.
>>
>> I haven't tracked down the root cause yet, but judging from the commit,
>> I would suppose that the checkout is being spawned in the wrong
>> directory, causing the files to not be cleaned up.
> 
> There's nothing wrong with running checkout from a subdirectory.  It
> is unfortunate that setup.c auto-discovers both the git directory and
> the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
> the case of a non-main worktree; it's not particularly friendly for
> subcommands.  Of course, it's also unfortunate that sequencer still
> forks subprocesses other than those requested by a user with e.g.
> --exec.
> 
> But, anyway, I've got a patch that I'll send as soon as it passes CI
> (https://github.com/git/git/pull/1205).

The patch hasn't come through to me on the mailing list yet, but it 
looks good. I thought we set both GIT_DIR and GIT_WORK_TREE when we were 
in a non-main worktree but obviously we don't. Eric do you happen to 
know if that is intentional?

As an aside I'm going to post an updated version of my series removing 
the call to 'git checkout' from sequencer.c later today but we 
definitely want to have this fix before that series gets merged.

Best Wishes

Phillip

>> ---
>>   t/t3400-rebase.sh | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 23dbd3c82e..8b8b66538b 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -416,4 +416,33 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
>>          mv actual_logs .git/logs
>>   '
>>
>> +test_expect_success 'rebase when inside worktree subdirectory' '
>> +       git init main-wt &&
>> +       (
>> +               cd main-wt &&
>> +               git commit --allow-empty -m "initial" &&
>> +               # create commit with foo/bar/baz
>> +               mkdir -p foo/bar &&
>> +               touch foo/bar/baz &&
>> +               git add foo/bar/baz &&
>> +               git commit -m "add foo/bar/baz" &&
>> +               # create commit with a/b/c
>> +               mkdir -p a/b &&
>> +               touch a/b/c &&
>> +               git add a/b/c &&
>> +               git commit -m "add a/b/c" &&
>> +               # create another branch for our other worktree
>> +               git branch other &&
>> +               git worktree add ../other-wt other &&
>> +               (
>> +                       cd ../other-wt &&
>> +                       mkdir -p random/dir &&
>> +                       (
>> +                               cd random/dir &&
>> +                               git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
>> +                       )
>> +               )
>> +       )
>> +'
>> +
>>   test_done
>> --
>> 2.35.0.rc0.227.g00780c9af4-goog

