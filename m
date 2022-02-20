Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA9CC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 19:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbiBTTmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:42:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBTTmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 14:42:18 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91FC62
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:41:57 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id q4so12540428qki.11
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bU1whMsIjbOM2iVeAFgzjqQFjolFx9GTtizkv9MzrgU=;
        b=d22jZsHG2ls/Qh8ZfeWk3OjLfGsfnXqFzofXcO20FtrqxicO2ECRAQJFd23xGsNK7c
         6CGkJ/Rittn3eGovhvxrm4RWb0i9IBHk7gnhqzNdQC773bc5j7vozLQUcXvsSpcYYY2k
         cSt/9mIjmFt8VCHi4+2rECiXVUYMZqGfQ1XzAezPB2X6oDE+T3fXdI0Uo9nj5vBoAaPp
         oIcDWbf4fNI5VkUtpoDwCRYPjyLWg4uQfJV+09Wtu9QVcVgSEdYw44gXHRC6UFtqiZxF
         LfPNW4F/sC8un+ETHiCLp9lHAlGHCArYj/RooumIlLlUeuZFFCTzPWsYQkuv5itfYhEM
         t5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bU1whMsIjbOM2iVeAFgzjqQFjolFx9GTtizkv9MzrgU=;
        b=uQvrdfKMfaqMj0YSuwG+06tT/PRhC/f0ztoftz5udnSzFgniq99A0jWZW/ib/F7yn1
         O4bIAMFBXuUIWJGrJSwjz54y2s/8pw7pLe4kd3LrgNG8lKtjVxzFdP7halfGA7yQvwav
         hAR7zBtjpE/wwWc+EazBOEtXxm0JeCdBiKuzlvUIwCsv3hRyNJrnT7hR+pSJL/+4miWz
         6i+6aONHUEQS/LU0nAtIghJhUAHxnB8SqA+aN2quC4Ch8slEfbYU6U6RMBDmd9+hVnTq
         PDaeIds9k8u7/X+/HrE6G5vE7zZFxsyi8YOYTdih8byrG5G1vKHrqvdLz+PwUH9o2VBp
         XVew==
X-Gm-Message-State: AOAM530wsc5+QSMHNxm3V4cOUWm77ClbmB8Bh6bWAtY28tIab06mTCck
        WqGDI06Khe2WF5TgeiSrHTaS
X-Google-Smtp-Source: ABdhPJzmf7EnDCn08VP1F6LnQwBGirjJewlFeZnEZisydcbmT8+rxYtWdQBb7ztWH93NvesldzzkZQ==
X-Received: by 2002:a37:5503:0:b0:4e1:2b66:dc53 with SMTP id j3-20020a375503000000b004e12b66dc53mr10201132qkb.706.1645386116373;
        Sun, 20 Feb 2022 11:41:56 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n16sm3377936qkn.115.2022.02.20.11.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 11:41:55 -0800 (PST)
Message-ID: <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com>
Date:   Sun, 20 Feb 2022 14:41:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2022 12:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Typically with sparse checkouts, we expect files outside the sparsity
> patterns to be marked as SKIP_WORKTREE and be missing from the working
> tree.  VFS for Git can be used to turn this expectation on its head:
> all files are considered present in the working copy, though they are
> not vivified until first access access.  With VFS for Git, most of the
> files do not match the sparsity patterns at first, and the VFS layer
> automatically updates the sparsity patterns to add more files whenever
> files are written.
> 
> With this background, this special usecase does not play well with the
> safety check we added in commit 11d46a399d ("repo_read_index: clear
> SKIP_WORKTREE bit from files present in worktree", 2022-01-06).
> Checking SKIP_WORKTREE files to see if they are present in the working
> tree causes them all to be immediately vivified.  Further, the special
> VFS layer, by virtue of automatically updating the sparsity patterns and
> catching all accesses, isn't in need of that safety check either.
> Provide a configuration option, core.expectFilesOutsideSparsePatterns
> so that those with this special usecase can turn off the safety check.

This patch looks like a good solution to the concerns brought up by
Jonathan N. around vfsd. VFS for Git uses the microsoft/git fork with
its own custom config to protect things like this. I imagine that we
will start setting your core_expect_files_outside_sparse_patterns
variable when reading the virtual filesystem info. We might even modify
some of our custom checks to use this variable instead. That would make
them appropriate to send upstream.

Should we update Documentation/config/core.txt describing this config
key? Or is this intended to be an internal detail only for something
like vfsd?

The only concern here really is if we want to be picky about the "VFS
for Git" references instead of "vfsd" references in the commit message.

Thanks,
-Stolee
