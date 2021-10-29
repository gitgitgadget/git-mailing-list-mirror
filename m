Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBCC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E1660C51
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJ2Neu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhJ2Neu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:34:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45488C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:32:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so16117224wrd.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3z/pK1JIm/X+kqvbfbGCb/OpHME3iD/6q0jpGaXww4Q=;
        b=lnAZJKVOZo8Sp30L1iMhl+q45EdskeFpWlDDdCalA5e2BSkV/JPBv3m6oAYnCCiVXI
         kXbZcroieLoCN17MekhKvbiSbGC/NaEXarVPBM9Qk3u+NgWfyZMGCruweE0rIEEEEdS2
         xjl8No7sm+Wskb99mCjrTVR+H8enTFDCuzJNc3FrZHi6NaaS2QcVYtQumHaKDQ28RJtT
         rJ2Cx7CisYDcUIRF1xJiYT5iP481kMR1vu78JFYgdrCc5g3MvmIYOj9NiUOD4fRnNpMu
         j+hgqlzAG7yKCBbus8Mz9wM98/FJFyXph0ulexHMWxDbgI1nq8ylX7BeJ68VzluuDT9N
         Jmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3z/pK1JIm/X+kqvbfbGCb/OpHME3iD/6q0jpGaXww4Q=;
        b=Ow68QgpakjeNFg6kBFLMfnDe4T8dRyRuOtocCyE+xoSH68tSsbOgZLdjesBc9MsDYv
         zGbql0V9tOtsLKlI5n4jWtNCfNV7e2fyN91SthhQlTU4SElemgxNcykq/ZXdHc+xIU6E
         3bnuYNrcCqeIuEmoMcz46g7pSAV+096G9C58r7tfTAXbV3CUQP5ejiXu2t/YlzIM6VhW
         +fGqoL2b+dHTDsIerPTB40418BZWnGGE8y0F9glEQTpPRWjaP7+U9PEU7agcT6G5A99g
         MlZRoJUNXvHTjEIZOt/4JgGnb3pQ/dXhFMDmc4NbZ6bIeVELnp690XZn61CCUWldBV36
         yRGA==
X-Gm-Message-State: AOAM532zNyxmOevYyAs0TKCWH/dL3xxvjBeVT43yloQmvIEUVNOBAn8R
        tj+suiJ6JnPQBgYmyHFoKWqO+67geY0=
X-Google-Smtp-Source: ABdhPJw7HCfIf44rvrAMgnNjmoAA3VghVEseTZ7fxL5parZqiuQa5vflLpiCbIpouM9bxbEpLGj2/Q==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr1978383wrn.349.1635514339753;
        Fri, 29 Oct 2021 06:32:19 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id i6sm7936864wry.71.2021.10.29.06.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 06:32:19 -0700 (PDT)
Message-ID: <7be2fde3-69b2-1da7-bb94-7c181490f626@gmail.com>
Date:   Fri, 29 Oct 2021 14:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Remove negation from the commit and merge option
 "--no-verify"
Content-Language: en-GB-large
To:     Alex Riesen <alexander.riesen@cetitec.com>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net> <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net> <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g> <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari> <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
 <YXrFaJXbuSuwfhQ7@pflmari>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YXrFaJXbuSuwfhQ7@pflmari>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 28/10/2021 16:44, Alex Riesen wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
> 
> This documents re-enabling of the hooks disabled by an earlier
> "--no-verify" in command-line.
> 
> Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
> ---
> 
> Hi Phillip,
> 
> Phillip Wood, Thu, Oct 28, 2021 15:57:58 +0200:
>> On 28/10/2021 09:04, Alex Riesen wrote:
>>> From: Alex Riesen <raa.lkml@gmail.com>
>>>
>>> This allows re-enabling of the hooks disabled by an earlier "--no-verify"
>>> in command-line and makes the interface more consistent.
>>
>> Thanks for working on this. Since 0f1930c587 ("parse-options: allow
>> positivation of options starting, with no-", 2012-02-25) merge and commit
>> have accepted "--verify" but it is undocumented. The documentation updates
>> and fix to pull in this patch are very welcome, but I'm not sure we need the
>> other changes. I've left a couple of comments below.
>>
>> [As an aside we should probably improve the documentation in parse-options.h
>> if both Peff and Junio did not know how it handles "--no-foo" but that is
>> outside the scope of this patch]
> 
> Interesting feature. It is unfortunate it was so well hidden. You're right, of
> course, and the newly added tests in t7504-commit-msg-hook.sh pass without any
> changes to the "builtin/commit.c".
> 
> Removal of double-negation in the code was an improvement to its readability,
> but I like small patches more.
> 
> Also, the series has no conflicts with 2.33.0 anymore and the "git pull" can
> be applied independently.
> 
>>> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
>>> index a3baea32ae..ba66209274 100644
>>> --- a/Documentation/git-commit.txt
>>> +++ b/Documentation/git-commit.txt
>>> @@ -11,7 +11,7 @@ SYNOPSIS
>>>    'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
>>>    	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
>>>    	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>>> -	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>>> +	   [--allow-empty-message] [--[no-]verify] [-e] [--author=<author>]
>>
>> I think for the synopsis it is fine just to list the most common options.
>> Having --no-verify without the [no-] makes it clear that --verify is the
>> default so is not a commonly used option.
> 
> Yep, makes sense.
> 
>>>    	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>>>    	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>>>    	   [-S[<keyid>]] [--] [<pathspec>...]
>>> @@ -174,7 +174,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>>>    -n::
>>>    --no-verify::
>>> -	This option bypasses the pre-commit and commit-msg hooks.
>>> +	By default, pre-merge and commit-msg hooks are run. When one of these
>>
>> I think saying "the pre-merge and commit-msg hooks" would be clearer as you
>> do below.
>>
>>> +	options is given, these are bypassed.
>>> +	See also linkgit:githooks[5].
>>> +
>>> +--verify::
>>> +	This option re-enables running of the pre-commit and commit-msg hooks
>>> +	after an earlier `-n` or `--no-verify`.
>>>    	See also linkgit:githooks[5].
>>
>> Some of the existing documentation describes the "--no-foo" option with
>> "--foo" (e.g --[no-]signoff) but in other places we list the two options
>> separately (e.g. --[no-]edit), I'd lean towards combining them as you have
>> done for the merge documentation but I don't feel strongly about it.
> 
> How about this instead:
> 
>    -n::
>    --no-verify::
>            By default, pre-commit and commit-msg hooks are run. When one of these
>            options is given, the hooks will be bypassed.
>            See also linkgit:githooks[5].
> 
>    --verify::
>            This option re-enables running of the pre-commit and commit-msg hooks
>            after an earlier `-n` or `--no-verify`.
> 
>>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>>> index 3819fadac1..324ae879d2 100644
>>> --- a/Documentation/git-merge.txt
>>> +++ b/Documentation/git-merge.txt
>>> @@ -10,7 +10,7 @@ SYNOPSIS
>>>    --------
>>>    [verse]
>>>    'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
>>> -	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>>> +	[--[no-]verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>>
>> Again I'm not sure changing the synopsis makes things clearer.
> 
> Removed.
> 
>>>    	[--[no-]allow-unrelated-histories]
>>>    	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
>>>    'git merge' (--continue | --abort | --quit)
>>> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
>>> index 80d4831662..f8016b0f7b 100644
>>> --- a/Documentation/merge-options.txt
>>> +++ b/Documentation/merge-options.txt
>>> @@ -112,8 +112,9 @@ option can be used to override --squash.
>>>    +
>>>    With --squash, --commit is not allowed, and will fail.
>>> ---no-verify::
>>> -	This option bypasses the pre-merge and commit-msg hooks.
>>> +--[no-]verify::
>>> +	By default, pre-merge and commit-msg hooks are run. When `--no-verify`
>>
>> I think "the pre-merge ..." would be better here as well.
> 
> Like this?
> 
>    --[no-]verify::
>            By default, the pre-merge and commit-msg hooks are run.
> 	  When `--no-verify` is given, these are bypassed.
>            See also linkgit:githooks[5].
> 
>>> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
>>> index 31b9c6a2c1..166ff5fb26 100755
>>> --- a/t/t7504-commit-msg-hook.sh
>>> +++ b/t/t7504-commit-msg-hook.sh
>>> @@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
>>>    '
>>> +test_expect_success '-n with failing hook' '
>>> +
>>> +	echo "more" >> file &&
>>> +	git add file &&
>>> +	git commit -n -m "more"
>>> +
>>> +'
>>
>> Is this to check that "-n" works like "--no-verify"?
> 
> Frankly, it was to check that the separate "-n" option works as I supposed it
> would. I never used parse-options before.
> 
>> I think it would be very useful to add another test that checks "--verify"
>> overrides "--no-verify".
> 
> Replaced the test with one which has "-n --verify".
> 
> Thanks!
> 
> 
>   Documentation/git-commit.txt    | 7 ++++++-
>   Documentation/merge-options.txt | 5 +++--
>   t/t7504-commit-msg-hook.sh      | 8 ++++++++
>   3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index a3baea32ae..2268787483 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -174,9 +174,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>   
>   -n::
>   --no-verify::
> -	This option bypasses the pre-commit and commit-msg hooks.
> +	By default, pre-commit and commit-msg hooks are run. When one of these

As I suggested yesterday I think this would be better if it kept the 
"the" from the original text as you do below for the merge documentation 
- s/default, /&the /

> +	options is given, the hooks will be bypassed.
>   	See also linkgit:githooks[5]. >
> +--verify::
> +	This option re-enables running of the pre-commit and commit-msg hooks
> +	after an earlier `-n` or `--no-verify`.
> +
>   --allow-empty::
>   	Usually recording a commit that has the exact same tree as its
>   	sole parent commit is a mistake, and the command prevents you
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 80d4831662..80267008af 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -112,8 +112,9 @@ option can be used to override --squash.
>   +
>   With --squash, --commit is not allowed, and will fail.
>   
> ---no-verify::
> -	This option bypasses the pre-merge and commit-msg hooks.
> +--[no-]verify::
> +	By default, the pre-merge and commit-msg hooks are run.
> +	When `--no-verify` is given, these are bypassed.
>   	See also linkgit:githooks[5].

This text looks good. It would be nice to be consistent when documenting 
"--verify" and "--no-verify" so that documentation for commit and merge 
both have either a separate entry for each option as you have for commit 
or a shared entry as you have here for merge. I'd be tempted to use this 
form in the commit documentation.

>   -s <strategy>::
> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> index 31b9c6a2c1..67fcc19637 100755
> --- a/t/t7504-commit-msg-hook.sh
> +++ b/t/t7504-commit-msg-hook.sh
> @@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
>   
>   '
>   
> +test_expect_success '-n followed by --verify with failing hook' '
> +
> +	echo "even more" >> file &&
> +	git add file &&
> +	test_must_fail git commit -n --verify -m "even more"
> +
> +'

Thanks, having the new test is very helpful.

Best Wishes

Phillip
