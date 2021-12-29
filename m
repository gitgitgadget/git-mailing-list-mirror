Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499AC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 17:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhL2Rbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbhL2Rbv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 12:31:51 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2677C061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 09:31:50 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id r6so19769518qvr.13
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m4zu8p8xg3/XoieaasC5eVZn4xnJeyQ2FtuUp2305lQ=;
        b=aUVhu9Bgn7jc0IjeMnadWdUJKWwGliLKMwuXtiNebFADQNQ4mZjFJBv/h21VpBLGxK
         uZ9aA41YnEbDX33g2KMGDSns5yS0TeNdRLDb3A0S1nFUn6yCT25OeDiyJV1OFI1V3bfA
         rEBtyKvojMhAwq4F7tnU1YOmFQ7X/2TjKYp9JQldGw9ls74rUXjFCQKeWKKkJiBSKlE3
         OGMI7wMIOLMPtLiWOecLVFqGzUbiSOjiehTrVXQFVnNmHz4fW4k18oTKc27ItAZblE9a
         ar/ctRTEVsjug2tmiEx5nBjKaXPO2XNQ9O1UZWizeZqlDMDxh1GYkzbyrxDBEp1CqX26
         I+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m4zu8p8xg3/XoieaasC5eVZn4xnJeyQ2FtuUp2305lQ=;
        b=iY84zYavdvs9E814ZFbNaALwjIx5C89g1sEVQk49WK30N+dhI6FHuY44pxxUl7bgy4
         ORba4M8IARxGKv5zIxeNDW4HEtLVr1zDEYu4jzG6oXft/UA99fo9aYpwQtFrmgXpT1r6
         pYQH8qnnAf2QAGI2EAMe4JyyXsH8PjCBlRVi/grjB4msZlGHrdelOpATwIHY+Mvi5bU4
         G0J9l4ZHZw2jWY8eP4v9W8U2sqldCzRfJJxTwm1Ny4r8CqnKKOILgLA3BgHI1//nrFMZ
         5CPBm+xmqxAgNPkw8kmejxIQkgsHa4/nS/O0NU9mPDV1L/aK1f079VIOdeuEw0IYz4BB
         OS8w==
X-Gm-Message-State: AOAM531d7rgxiG3B76xB3LJ+yjvMXXCPUOeQkkXd8rYcTKn5uHL9ZwgL
        Yl3bNvJTPIHCIjcsWTe2p50=
X-Google-Smtp-Source: ABdhPJwfAw7hxZx2Mhq2diwIaZQTZcKAi/LGQVvBqRWWUTd84Vbi5iEONABMxAXAt1nKVLQkF0q4QA==
X-Received: by 2002:a05:6214:e66:: with SMTP id jz6mr24456790qvb.61.1640799109173;
        Wed, 29 Dec 2021 09:31:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:90c2:2049:9567:8f81? ([2600:1700:e72:80a0:90c2:2049:9567:8f81])
        by smtp.gmail.com with ESMTPSA id r13sm19010719qtw.41.2021.12.29.09.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 09:31:48 -0800 (PST)
Message-ID: <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com>
Date:   Wed, 29 Dec 2021 12:31:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2021 1:37 AM, Eric Sunshine wrote:
> On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> When adding a new worktree, it is reasonable to expect that we want to
>> use the current set of sparse-checkout settings for that new worktree.
>> This is particularly important for repositories where the worktree would
>> become too large to be useful. This is even more important when using
>> partial clone as well, since we want to avoid downloading the missing
>> blobs for files that should not be written to the new worktree.
>>
>> The only way to create such a worktree without this intermediate step of
>> expanding the full worktree is to copy the sparse-checkout patterns and
>> config settings during 'git worktree add'. Each worktree has its own
>> sparse-checkout patterns, and the default behavior when the
>> sparse-checkout file is missing is to include all paths at HEAD. Thus,
>> we need to have patterns from somewhere, they might as well be the
>> current worktree's patterns. These are then modified independently in
>> the future.
>>
>> In addition to the sparse-checkout file, copy the worktree config file
>> if worktree config is enabled and the file exists. This will copy over
>> any important settings to ensure the new worktree behaves the same as
>> the current one.
> 
> This is not a proper review. I just happened to very quickly scan my
> eyes over this patch without even having looked at any of the others,
> nor have I read the v3 cover letter closely yet. Nevertheless, while
> skimming this patch, an issue jumped out at me...
> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -336,6 +336,47 @@ static int add_worktree(const char *path, const char *refname,
>> +       /*
>> +        * If we are using worktree config, then copy all currenct config
>> +        * values from the current worktree into the new one, that way the
>> +        * new worktree behaves the same as this one.
>> +        */
> 
> s/currenct/current/
> 
>> +       if (repository_format_worktree_config) {
>> +               char *from_file = git_pathdup("config.worktree");
>> +               char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
>> +                                       realpath.buf, name);
>> +
>> +               if (file_exists(from_file)) {
>> +                       if (safe_create_leading_directories(to_file) ||
>> +                           copy_file(to_file, from_file, 0666))
>> +                               error(_("failed to copy worktree config from '%s' to '%s'"),
>> +                                     from_file, to_file);
>> +               }
> 
> I presume that you lifted this idea from [1] in which I offhandedly
> mentioned that one possible way to implement Elijah's desire to copy
> sparse-checkout configuration when a new worktree is created would be
> to simply copy the existing worktree-specific configuration to the new
> worktree. Unfortunately, a direct implementation of that idea suffers
> the same problem which started this entire thread. Namely:
> 
>     % git clone --bare <url>/bare.git
>     % cd bare.git/
>     % git worktree init-worktree-config
>     % git worktree add -d ../foo
>     Preparing worktree (detached HEAD a0df8ce)
>     HEAD is now at a0df8ce gobbledygook
>     % cd ../foo/
>     % git sparse-checkout init
>     fatal: this operation must be run in a work tree
>     % git config --get --show-origin --show-scope core.bare
>     worktree file:.../bare.git/worktrees/foo/config.worktree true
> 
> The problem is that for a bare repository, after `git worktree
> init-worktree-config`, "bare.git/config.worktree" contains the
> repo-specific `core.bare=true` setting, so copying
> "bare.git/config.worktree" to
> "bare.git/worktrees/<id>/config.worktree" verbatim has undesired
> consequences.

It is certainly unfortunate that this can happen when core.bare or
core.worktree are set in the config.worktree of the bare repo.

The thing we are doing here is trying to create a worktree that exactly
matches the current worktree (even if it is bare or redirected to a
different working directory), but since we don't actually support a
"bare" worktree this does not work.

> The obvious way to work around this problem is to (again) special-case
> `core.bare` and `core.worktree` to remove them when copying the
> worktree-specific configuration. Whether or not that is the best
> solution or even desirable is a different question. (I haven't thought
> it through enough to have an opinion.)

It makes sense to special case these two settings since we want to
allow creating a working worktree from a bare repo, even if it has
worktree config stating that it is bare.

As far as the implementation goes, we could do the copy and then
unset those two values in the new file. That's an easy enough change.
I'll wait for more feedback on the overall ideas (and names of things
like the init-worktree-config subcommand).

Thanks,
-Stolee
