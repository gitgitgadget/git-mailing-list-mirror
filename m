Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632BC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiA0QgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiA0QgG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:36:06 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA19C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:36:06 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id p203so6840399oih.10
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y4fnQjA9fxj1UBLZAuFbPXqjcgthu+XNjfRadcuZs+0=;
        b=QKOzc8t/J+LKV0K0wtyyb9vgYT4mA7vs2nJINjSnc7QnmeLfmZRCbRsg6zRxOiLg7r
         ujYd+/V513iru4knrmzIZWQ9DLppKeN15E4EmNNQAY6kT/r1gvrDND6T5tkbRr2lP9nZ
         St6abDgGNGiB30dT7cO3JTC5EMhCp5Dnl6CR5bY0z+LiQWxqmSkzXvEWRhzmboFy4LlZ
         FIb7pkIMUppMVT0j7Fv6sQ+F3ZvoIyhOjpLTIv0YGAMy80W4bTL78Eayuz2EZbNvAinD
         R2uL6qZkjvnFAsfalrqPUNeY2V7DkkI38r1yoR8jX7O/BVjTxooWK9MtLm9c40aEoJ3s
         Jjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y4fnQjA9fxj1UBLZAuFbPXqjcgthu+XNjfRadcuZs+0=;
        b=c3UW608OUltaNcPffvqJKnmKZpLLREl8r0/Q6UyFx9IsujORUsTzNJjPyOBXeZT+iF
         zu9BYPsWqGBs9+TvGNkyVbOrMWR43eY7djUtApgwup5i5RelaZ/qUMWrVNquNQyBWOWy
         gAqOtBfwQxmlrtP2u91IN3hYasivof/nG7NjI81Bln+4nFCVaVayzIMkiMWXdAT0oa1N
         NJOZbGkWLZzy0vQ7aKE+FjQvr+CP2zzOwnKpWCkudMqsW/dYPMjKIvoFT+bxsOrrW8jY
         6ls33DtIaXeCauh1le1TzjE4EHz2ojjhp//v3TyKp5pelO8TqBStW10TkRPrOPU2ZXP5
         nJQA==
X-Gm-Message-State: AOAM532bpx1qDYEy7szHKisgTnUNs916WkxiJZDVBOLon3Je22UUSiUL
        reiQ6p44ERT/fLqGYWoxaiI=
X-Google-Smtp-Source: ABdhPJwiwkO7QQwl8geRL+pIZpJT9/QMA04PPxOCbVXEhWB/PAvnwOmOcwPwaH9XHDJH2IPQ7N/QYw==
X-Received: by 2002:a05:6808:21a9:: with SMTP id be41mr4843512oib.321.1643301365598;
        Thu, 27 Jan 2022 08:36:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id a126sm2333107oif.28.2022.01.27.08.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 08:36:04 -0800 (PST)
Message-ID: <771fa224-4319-c827-d28d-51e767b0050e@gmail.com>
Date:   Thu, 27 Jan 2022 11:36:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/9] Sparse index: integrate with 'clean',
 'checkout-index', 'update-index'
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
 <CABPp-BEVM-nhTX+DRf3NN16G-5Wr2KzObCiETqcy+ZYJLR4EWQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEVM-nhTX+DRf3NN16G-5Wr2KzObCiETqcy+ZYJLR4EWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

n 1/12/2022 10:02 PM, Elijah Newren wrote:
> On Tue, Jan 11, 2022 at 10:05 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This series continues the work to integrate commands with the sparse index,
>> adding integrations with 'git clean', 'git checkout-index', and 'git
>> update-index'. These three commands, while useful in their own right, are
>> updated mainly because they're used in 'git stash'. A future series will
>> integrate sparse index with 'stash' directly, but its subcommands must be
>> integrated to avoid the performance cost of each one expanding and
>> collapsing the index.
>>
>> The series is broken up into 4 parts:
>>
>>  * Patches 1-2 are minor fixups to the 'git reset' sparse index integration
>>    in response to discussion [1] that came after the series was ready for
>>    merge to 'next'.
>>  * Patch 3 integrates 'git clean' with the sparse index.
>>  * Patches 4-6 integrate 'git checkout-index' with the sparse index and
>>    introduce a new '--ignore-skip-worktree-bits' option.
>>    * This involves changing the behavior of 'checkout-index' to respect
>>      'skip-worktree' by default (i.e., it won't check out 'skip-worktree'
>>      files). The '--ignore-skip-worktree-bits' option can be specified to
>>      force checkout of 'skip-worktree' files, if desired.
>>  * Patches 7-9 integrate 'git update-index' with the sparse index.
>>    * Note that, although this integrates the sparse index with
>>      '--cacheinfo', sparse directories still cannot be updated using that
>>      option (see the prior discussion [2] for more details on why)
>>
>>
>> Changes since V1
>> ================
>>
>>  * Changed 'checkout-index' to fail by default when given filenames of files
>>    with 'skip-worktree' enabled
>>    * These files can still be forcibly checked-out by using the
>>      '--ignore-skip-worktree-bits' option
>>    * Added/updated corresponding t1092 tests
>>  * Updated t1092 'update-index' tests
>>    * Mentioned where/why 'skip-worktree' files were manually created on-disk
>>      for testing purposes
>>    * Provided explanation as to what '--remove' does, and how it relates to
>>      '--ignore-skip-worktree-entries'; restructured corresponding test
>>    * Fixed typo 'update-indexe' -> 'update-index'
>>    * Removed unused 'edit-contents'
>>    * Changed '--again' test to not use '--remove' to avoid confusion over
>>      how/why it updates 'skip-worktree' entries
>>    * Added "set skip-worktree" step to '--cacheinfo' test to illustrate how
>>      it could be used to add a new outside-of-cone file and remain generally
>>      compliant with a sparse-checkout definition
>>    * Added '--cacheinfo' test to "ensure not expanded"
>>    * Moved t1092 test 'sparse index is not expanded: update-index' to avoid
>>      merge conflict
>>  * Updated p2000 test for 'update-index': added file argument
>>    * Without any file arguments, 'update-index' was effectively a no-op
>>  * Clarified reasoning behind changing/not changing behavior of update-index
>>    in sparse-checkouts
> 
> Nicely done!  You've addressed all my (voluminous) feedback from v1;
> this round looks good to me.
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thank you for that review, Elijah. I took this opportunity to
reread the series as well as the range-diff and I agree that
this version is ready to go.

Thanks,
-Stolee
