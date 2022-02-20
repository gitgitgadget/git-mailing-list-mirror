Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE90C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 16:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbiBTQ4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 11:56:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBTQ4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 11:56:39 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A1424A8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 08:56:17 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id bm39so2668326qkb.0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6yZjsKQ8yv6IvrQ58Pl30mS6RnrTi/jLz4BijYK1EOc=;
        b=fV6AlP5SB1jm0kcH/x3G6wyt0TgLJWH6mCT+LsSaGqaGVEeH6Y5Sf9xxsHkmsMTXm/
         nU2kIhOv3lqlfTTMXUv8BE/+KvdCVvP4v0s7w5a8ESCrT6jmdVKiCivVt5l5KBeaaLMo
         HD1BwM9UMPJxbU6bOvbvBUFp4JaA0l8Fed40J2Fo5Pu6zRH58ZW5IoxvTd9PAva2zE/u
         0zSmtnsaBbPcdUN7e4bOAc7SVF07jfQB4wpsm4AbDzaO38xUibqdXXXGaiV364eo9K/U
         OTFWKQMjNi4SsQRezoDChRzbGDtDN/Bl0f+93pKIbrtED+OQ5qZxtc6wTUm89Iz0zm0y
         czEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6yZjsKQ8yv6IvrQ58Pl30mS6RnrTi/jLz4BijYK1EOc=;
        b=1YwNolazo/gdDwoImEyssWQMW4psqbIKGsAB4y5hdsVMHazTqGHT0tB2277qLjvr+l
         t2uZPoTWDEwIMzR8+Wv49pNM5eiTJeJ4eCwgtj5klov96bFOFDpubwBEO9UTJL0XZqt2
         XtNj1MWQtW1DVe4H+05Veb2rzZqBQ8wHjeeEDxuWcw1tpwCmJfycMnSuXEYLZVhrms0O
         0qeoXiXNn6rlFeAQTBc2mZ5PuJD9p45j40GY1zGz2bktvDOKrjAOOfy/rmd7EBkScHP5
         3JpA25PNJc1GBtP/NXmh5O8twO+c0hu+Wvf1/Pv3mQ1lJzPxbLweVwMEwalufLKR3j32
         I8OA==
X-Gm-Message-State: AOAM532HzY9EapbRhFlrhwaC8wOCVXTOAgEHlvt5I5waiof8jsRzscJC
        I7Usv6+IpODyrqi1yISljpRT
X-Google-Smtp-Source: ABdhPJzfCKzy+Q4rfbr55mQQ71EhulvyB+ioGRuGey8XNAsUyRZB6jTufSJCe8uIprYQuUKDyTc4/A==
X-Received: by 2002:a37:917:0:b0:62c:e550:bc3e with SMTP id 23-20020a370917000000b0062ce550bc3emr6385738qkj.677.1645376176550;
        Sun, 20 Feb 2022 08:56:16 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l1sm7402945qtp.4.2022.02.20.08.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 08:56:16 -0800 (PST)
Message-ID: <0979ce9b-d7be-9f84-0942-201626b488a4@github.com>
Date:   Sun, 20 Feb 2022 11:56:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
Content-Language: en-US
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
 <YhBCsg2DCEd9FXjE@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YhBCsg2DCEd9FXjE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/18/2022 8:06 PM, Jonathan Nieder wrote:
> (cc-ing Jonathan Tan, Jose Lopes, and Jeff Hostetler, vfs experts)
> Hi Elijah,
> 
> Elijah Newren wrote[1]:
> 
>> The fix is short (~30 lines), but the description is not.  Sorry.
>>
>> There is a set of problems caused by files in what I'll refer to as the
>> "present-despite-SKIP_WORKTREE" state.  This commit aims to not just fix
>> these problems, but remove the entire class as a possibility -- for
>> those using sparse checkouts.  But first, we need to understand the
>> problems this class presents.  A quick outline:
>>
>>    * Problems
>>      * User facing issues
>>      * Problem space complexity
>>      * Maintenance and code correctness challenges
>>    * SKIP_WORKTREE expectations in Git
>>    * Suggested solution
>>    * Pros/Cons of suggested solution
>>    * Notes on testcase modifications
> 
> Thanks for a clear explanation!  This is very helpful.
> 
>> === User facing issues ===
>>
>> There are various ways for users to get files to be present in the
>> working copy despite having the SKIP_WORKTREE bit set for that file in
>> the index.  This may come from:
>>   * various git commands not really supporting the SKIP_WORKTREE bit[1,2]
>>   * users grabbing files from elsewhere and writing them to the worktree
>>     (perhaps even cached in their editor)
>>   * users attempting to "abort" a sparse-checkout operation with a
>>     not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
>>     working tree is not atomic)[3].
>>
>> Once users have present-despite-SKIP_WORKTREE files, any modifications
>> users make to these files will be ignored, possibly to users' confusion.
> [...]
>> The suggests a simple solution: present-despite-SKIP_WORKTREE files
>> should not exist, for those using sparse-checkouts.
> 
> This patch just reached "next", so at $DAYJOB a test for our vfsd[2]
> noticed this change.  The trick behind a Git-based virtual filesystem
> is typically:
> 
> - since we control the filesystem, we can pretend all files are
>   already present.  On access, we obtain the file content from the git
>   object store.  On write, we update the sparse-checkout pattern so
>   that Git knows to start tracking the file.
> 
> - by keeping the sparse-checkout pattern narrow, we minimize the time
>   commands like "git status" need to spend looking for changes in
>   unmodified files.  Controlling the filesystem means we don't need to
>   worry about changes to files that don't match that pattern (since
>   any modification would also trigger a sparse-checkout pattern
>   update).
> 
> If I understand the intent behind this change correctly, it's
> incompatible with that trick.  How would you recommend handling that?
> In the not too far away future, I'd expect something like the "VFS
> projection hook" to handle this use case, but in the meantime, I would
> expect this change to break VFS for Git performance.  A few options:
> 
>  a. We could guard it with a config option.  It would still be a
>     regression for VFS for Git users, but they'd be able to use the
>     config option to restore the expected behavior.  (Or
>     alternatively, such a config option could be disabled by default,
>     but I suspect that would defeat the purpose described for the
>     patch.)
> 
>  b. We could distinguish between the vfsd and the "interrupted and
>     forgot to update SKIP_WORKTREE bits in the index" cases somehow.
>     This sounds complex.
> 
>  c. Something else?
> 
> (b) and (c) aren't sounding obviously good, so (a) seems tempting.
> What do you think?

Just chiming in here to say that we've dealt with these issues in
microsoft/git by special-casing them behind our core_virtualfilesystem
global. A recent example is the changes to 'git add' to prevent
adding a file that is marked as sparse (unless --sparse is specified).
We always allow this when in the virtualized scenario [1].

[1] https://github.com/microsoft/git/blob/2f6531aced2e77a6c1000a923967ae0105383930/builtin/add.c#L50-L54

This seems like something that should be on vfsd to handle, and should
not prevent upstream Git from making changes that benefit its users.

Thanks,
-Stolee
