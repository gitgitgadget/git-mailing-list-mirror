Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F648C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiCQV6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCQV6w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 17:58:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE1B84E
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:57:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e3so5998239pjm.5
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=loNwNSd46S35gWTeZFgEAiXkW+ZO5hyM2RTG7LO6uRc=;
        b=R9BZUBEYgGXvefIhueCSriCe2PkS20+ZzaUK7FRIu59o173peB59vlCpoiYkp0Ficv
         TOn1BsGJjtDhwq9G505Cae87YLatyTpufC19EJoKqTGcHtQz202fwdZXaNFpQMnZvinT
         xpoJw9znTSjPF37avT5z+gXAO82HqajOTItMWdmduj9jvED7OxKz+WH5dcvYhYEQqvzV
         L2MmMdRpSKkdpr9jkaIg4Ao29qWt2XEq8BnbLdRTY3syJXSfQmJPOnUCQkVx7vG6kB8x
         Q7KX7kW35vKJg4939fh2xaTjsMBbc/s+aCbPFxG6BLbIm5enRTUJhmm+j3B+SHy5zION
         dqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=loNwNSd46S35gWTeZFgEAiXkW+ZO5hyM2RTG7LO6uRc=;
        b=X5tGOYiwP39JvjAZ6pZl6PCSW8QgIm9wDfobPv2nCtY0I8D8wbg5BY3IdWjR/i8Jpz
         GMvlTUlU/ZVj7rmLOcgeauE6QSXgUqJfS3sbl4VjN0Uhc6LpX0FoyvH3rEwW1OhAIoiz
         isyGX10L+v/wTVZld97RE23brJL05B5QAJCpmex49zYVldHgcOybzrebRREHbBCzrbhr
         v5VA8I6Gh2q9w4VyK4r05mGgATnmtZvA4/svk4eSFk/dwpaAokMawUAsOZYRY5auIN73
         K+i0Dtrkf3SbJYyJvFo4wjXF+HfYvweQu536O1NfBxR1yrkR3rkYVDGKHSfImV1G5SKi
         TZCw==
X-Gm-Message-State: AOAM5319pqgK8RTNxHOWUhHcJfmJ3tVTBP044KfS2wbmAEpuuiq5mZQV
        mnonMseT/+Kt8ci+5b3vnGCY
X-Google-Smtp-Source: ABdhPJw+izIDgc+b2SWN8PNoy2DPMoZf9/oyVYPvnXyg2kasWDUvm9uLx4nWVFu9x81LkOFI4We07Q==
X-Received: by 2002:a17:903:2303:b0:151:d02f:44c with SMTP id d3-20020a170903230300b00151d02f044cmr6841004plh.139.1647554254091;
        Thu, 17 Mar 2022 14:57:34 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f7b8b3a44csm8086433pfv.29.2022.03.17.14.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:57:33 -0700 (PDT)
Message-ID: <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
Date:   Thu, 17 Mar 2022 14:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
 <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Hi Derrick,
> 
> On Wed, Mar 16, 2022 at 9:34 PM Derrick Stolee <derrickstolee@github.com> wrote:
>> The issue here is that this file is "untracked", not just outside
>> of the sparse-checkout cone.
> 
> Thanks for the succinct explanation, it makes much more sense now :)
> 
>> Instead, what about
>>
>>         git mv folder2/a deep/new
>>
>> since folder2/a is a tracked file, just not in the working tree
>> since it is outside the sparse-checkout cone.
>>
>> (If it fails, then it should fail the same with and without the
>> sparse index, which is what "test_sparse_match" is for.)
> 
> I tested this and it fails as expected with:
> "fatal: bad source, source=folder2/a, destination=deep/new"
> 

Great! This should then probably be turned into a "test_expect_fail" test in
't1092' - that'll make sure we get both the right behavior and right error
message with sparse index after it's enabled.

However, I also get the same result when I add the '--sparse' option. I
would expect the behavior to be "move 'folder2/a' to 'deep/new' and check it
out in the worktree" - this may be a good candidate for improving the
existing integration with sparse *checkout* before enabling sparse *index*
(e.g., like when 'git add' was updated to not add sparse files by default
[1]).

[1] https://lore.kernel.org/git/2c5c834bc9fb42aeaff7befbba477aec727184c0.1632497954.git.gitgitgadget@gmail.com/

>> Thanks,
>> -Stolee
> 
> Thanks for the reply above!
> 
> Other than that, I also have found another issue (probably), with
> 
> $ mkdir folder2
> $ git mv folder2 deep
> 
> After these I do:
> 
> $ git status
> 
> And the output indicates that the index is updated with the following changes:
> 
>         renamed:    folder2/0/0/0 -> deep/folder2/0/0/0
>         renamed:    folder2/0/1 -> deep/folder2/0/1
>         renamed:    folder2/a -> deep/folder2/a
> 
> Nothing fails, which is not what I expected. What I expect is `git mv` will
> fail because it is being told to update a sparse-directory (which as I read the
> blogs and sparse-index.txt is taken as a sparse-directory entry) outside of the
> sparse-checkout cone. Unless `git mv` is supplied with `--sparse`, the command
> will do nothing but fail, no?
> 

I think you're right that this is a bug. This appears to come from the fact
that 'mv' decides whether a directory is sparse only *after* it sees that it
doesn't exist on-disk. 

> What confuses me more is that the `folder2`, which is present in the index but
> not in the working tree (due to sparse-checkout cone), seems to be "unlocked"
> and re-picked up by Git after `mkdir folder2` and move `folder2` into
> the cone area.
> And still, the files under `deep/folder2` are not present in the
> working tree (might
> be relevant to the previous context).
> 
This is a consequence of how sparse-checkout is implemented. The files in
'folder2/' aren't on-disk (and aren't correspondingly shown as "deleted" in
'git status') because the index entries of 'folder2/' files are marked with
the "SKIP_WORKTREE" flag. This flag basically indicates to git "this file
shouldn't be in the worktree (on-disk), but it is part of the repository (in
the index)". In other words, it's what makes a file "sparse", and
sparse-checkout (when you run 'set' or 'add') assigns that flag based on the
user-specified patterns. However, the flag isn't constantly being
re-evaluated - only certain commands change SKIP_WORKTREE, and only because
they do so explicitly (e.g., 'git reset --mixed' [2]) - leading to
situations like what you're seeing, where 'folder2/' files (which have
SKIP_WORKTREE enabled) are moved into the sparse cone, but still have
SKIP_WORKTREE enabled.

So I think there are three potential things to fix here: 

1. When empty folder2/ is on-disk, 'git mv' (without '--sparse') doesn't
   fail with "bad source", even though it should.
2. When you try to move a sparse file with 'git mv --sparse', it still
   fails.
3. SKIP_WORKTREE is not removed from out-of-cone files moved into the sparse
   cone.

On a related note, there is precedent for needing to make fixes like this
before integrating with sparse index. For example: in addition to the
earlier examples in 'add' and 'reset', 'checkout-index' was changed to no
longer checkout SKIP_WORKTREE files by default [3]. It's a somewhat expected
part of this process because sparse-checkout is still "experimental", and
one of our secondary goals with this sparse index work is to improve the
behavior of sparse-checkout in the commands we integrate. All of this
combined will, ideally, make the experience of using sparse-checkout much
nicer for users (both from usability and performance perspectives).

[2] https://lore.kernel.org/git/b221b00b7e06a3b135b9f68ce87cffaa7d782581.1638201164.git.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/601888606d1cf7d7752844dbdbc7fac20d4be8c4.1641924306.git.gitgitgadget@gmail.com/

> I haven't run the gdb to see into the process, I just get somehow confused by
> these discrepancies (seemingly to me). I think I should gdb into it though,
> getting some info here from people can also be really helpful :)
> 

Another tool that may help you here is 'git ls-files --sparse -t'. It lists
the files in the index and their "tags" ('H' is "normal" tracked files, 'S'
is SKIP_WORKTREE, etc. [4]), which can help identify when a file you'd
expect to be SKIP_WORKTREE is not and vice versa.

[4] https://git-scm.com/docs/git-ls-files#Documentation/git-ls-files.txt--t 
