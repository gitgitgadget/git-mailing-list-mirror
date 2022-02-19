Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD63C433FE
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 01:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiBSBHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 20:07:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiBSBHT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 20:07:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499294CD5F
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 17:07:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u12so8404473plf.13
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 17:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCLZm1pe2+1wiFwGFxW05FH6b+fclFdmARa2H6vR4yo=;
        b=IhxFugUdcu7+iku0r4zVxmeKC3hb1zhFz86dN2pUf7EggqchSgPxYPBp3bXkebP+zB
         2UeHlnLumiXynjSWwpq1yNbMM868B5s9i4t9zEWc4jGw1/V2qBsz7aO9d3X4GFphAMIA
         W46ZjlcUzzH3KR4W3PP2vAzWZ0HzFMqG5EtvVtbrUtL1ufgeR6VAKBhLS/neRpuUF16f
         xbIWuTqUn0Fduy+dG+sOVyIWwaLPX2BvKW3//tUkavxXc3BE/rq5k237dU10lL5AF0XF
         P1rsQ77OQ0XQA+aqvBWrg74NWMAmTGykidcfWC4W2T2M2hsRTX3N5RbrR1Vt/FTcPWB8
         fmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yCLZm1pe2+1wiFwGFxW05FH6b+fclFdmARa2H6vR4yo=;
        b=TgEGQQaHxPntgbqk8tfBaVsvkwvJ7RyTNCKSBy2LKYpGRlys+ZsNVASfb2wOeLnSPb
         7OQ+KxDOGhWz7YJIDt+Z7xMz4YgqMU4Igky2rR4TE+29OabOT311PJzPBYuDKdqj77zT
         HmOd476E6I32Y/0rah+sSKCxg+enZ5GOI8IrWh7yUpi6gruFSOz6RFAPaD8F3KxYFLjC
         ZKoy0H3A6FE/BTGXdFqwpn8MnQx1JJ5k8DpSd9sbQLGlDDjJFPyDdhiRUY2xlWz0i8Qd
         87VRmI87Lk7R8P3s2kTCPF/VfNtoD+yJixxLmfhO4b9c7L/UNCHxMbcjsbT4IyQfS9lr
         5tSg==
X-Gm-Message-State: AOAM5320X5Kt6nJ88+qK+JuDP5dtPETlPhy5NlhsHXf96dve4PaZBJPq
        uZLXAJs6XBR6SmA/pdU3umw=
X-Google-Smtp-Source: ABdhPJwNvijy1Zgz15wkqnnQyH5V5FhVF+ErlNDhJgb0sghn7aByz4Pmx2avmwe32l9SzuExGj3RdA==
X-Received: by 2002:a17:902:f785:b0:14f:45c3:6c22 with SMTP id q5-20020a170902f78500b0014f45c36c22mr9702200pln.45.1645232821534;
        Fri, 18 Feb 2022 17:07:01 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ff0a:b48a:1cb8:3654])
        by smtp.gmail.com with ESMTPSA id h16sm4189952pfh.40.2022.02.18.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:07:00 -0800 (PST)
Date:   Fri, 18 Feb 2022 17:06:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
Message-ID: <YhBCsg2DCEd9FXjE@google.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Jonathan Tan, Jose Lopes, and Jeff Hostetler, vfs experts)
Hi Elijah,

Elijah Newren wrote[1]:

> The fix is short (~30 lines), but the description is not.  Sorry.
>
> There is a set of problems caused by files in what I'll refer to as the
> "present-despite-SKIP_WORKTREE" state.  This commit aims to not just fix
> these problems, but remove the entire class as a possibility -- for
> those using sparse checkouts.  But first, we need to understand the
> problems this class presents.  A quick outline:
>
>    * Problems
>      * User facing issues
>      * Problem space complexity
>      * Maintenance and code correctness challenges
>    * SKIP_WORKTREE expectations in Git
>    * Suggested solution
>    * Pros/Cons of suggested solution
>    * Notes on testcase modifications

Thanks for a clear explanation!  This is very helpful.

> === User facing issues ===
>
> There are various ways for users to get files to be present in the
> working copy despite having the SKIP_WORKTREE bit set for that file in
> the index.  This may come from:
>   * various git commands not really supporting the SKIP_WORKTREE bit[1,2]
>   * users grabbing files from elsewhere and writing them to the worktree
>     (perhaps even cached in their editor)
>   * users attempting to "abort" a sparse-checkout operation with a
>     not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
>     working tree is not atomic)[3].
>
> Once users have present-despite-SKIP_WORKTREE files, any modifications
> users make to these files will be ignored, possibly to users' confusion.
[...]
> The suggests a simple solution: present-despite-SKIP_WORKTREE files
> should not exist, for those using sparse-checkouts.

This patch just reached "next", so at $DAYJOB a test for our vfsd[2]
noticed this change.  The trick behind a Git-based virtual filesystem
is typically:

- since we control the filesystem, we can pretend all files are
  already present.  On access, we obtain the file content from the git
  object store.  On write, we update the sparse-checkout pattern so
  that Git knows to start tracking the file.

- by keeping the sparse-checkout pattern narrow, we minimize the time
  commands like "git status" need to spend looking for changes in
  unmodified files.  Controlling the filesystem means we don't need to
  worry about changes to files that don't match that pattern (since
  any modification would also trigger a sparse-checkout pattern
  update).

If I understand the intent behind this change correctly, it's
incompatible with that trick.  How would you recommend handling that?
In the not too far away future, I'd expect something like the "VFS
projection hook" to handle this use case, but in the meantime, I would
expect this change to break VFS for Git performance.  A few options:

 a. We could guard it with a config option.  It would still be a
    regression for VFS for Git users, but they'd be able to use the
    config option to restore the expected behavior.  (Or
    alternatively, such a config option could be disabled by default,
    but I suspect that would defeat the purpose described for the
    patch.)

 b. We could distinguish between the vfsd and the "interrupted and
    forgot to update SKIP_WORKTREE bits in the index" cases somehow.
    This sounds complex.

 c. Something else?

(b) and (c) aren't sounding obviously good, so (a) seems tempting.
What do you think?

Thanks,
Jonathan

[1] https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
[2] see
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
for what I mean by "vfsd"
