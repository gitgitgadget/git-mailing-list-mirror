Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B0C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 18:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbiBSSPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 13:15:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiBSSPM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 13:15:12 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB56EF3D
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 10:14:53 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so5077707pfv.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XljllSzzgjPhFQVlLSnxn9QClrr+88alOwOkkFlSVtI=;
        b=DWUDKykvuJCj/t39Dmu7O/kULeAFQ7zgfnx1w6TBoB9aXr8Eoa0WtDvwU5X4bn7sQK
         bRcFmpgkh/foeGQttpwtgCz6QpKhU2UkZ7NDFkdOahMAGdhB+iXP4bpe08KuF5DoahzK
         TAmPWJTSQ6DcJliILvWPESgXIdjBmQkjLjEaKfnbPoGO8eNtB7lUc470owB+qqEgEKIB
         oKRREY0UnrbKYezBGqKnqT0mKJof9bwX0ImcZOPX38n+jZM8llkU/q+9GRPzgGKdxGz6
         VU1Nvehnsiyj15441laIial9r1ILyNlOP/nRfMVECk8aUvU+scC5PQOLbgzzK+ExXByX
         2YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XljllSzzgjPhFQVlLSnxn9QClrr+88alOwOkkFlSVtI=;
        b=FIHMsQ3vwHOTXrYX9eCYdjeuqzvPsRn2OY6oFgXhluTYIZhAi1uTygTeeiu7Xb96md
         lM5vOgR6AtOqXW5RHr+4AM5Ds2PUVqR2oxAh1HKTVvnW265XUArGGag6pmwZ9KQjTH7l
         7IQaYBsl88qzju4dhLx21kv+PaKkF3L1CGUMvWrdxaUgQcOq8ws0uRd85WfCfFw8zslZ
         X1CZKMKc8e4Jbl9ieVdac6TUzzgvgnhqJvK5N0tg33a5CswVJbz4z463UmOsjlfyiWb0
         yS5mPTsCp8wKCs5X4RagsWwIKCp6TQEYbe0Xu5BjnO6WT/T0QFscCLe8Z0RQNcjjGaUK
         q0Bw==
X-Gm-Message-State: AOAM532RNWgauOpsojefXo31mUm5GPHBbKdn93bwrClRINnSM+hiyPS4
        VRI6RvdjIWusFp4v/VP5C3dZOs0WVaQ=
X-Google-Smtp-Source: ABdhPJwkeBh8QRmzMCuMK6cQIiXFe7BBMUE4lB75UAfvIU/vjhBPQbte3l9M4En3eMJijqcJ7r80Dg==
X-Received: by 2002:a63:cc52:0:b0:372:7f35:cf84 with SMTP id q18-20020a63cc52000000b003727f35cf84mr10489320pgi.211.1645294492435;
        Sat, 19 Feb 2022 10:14:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ff0a:b48a:1cb8:3654])
        by smtp.gmail.com with ESMTPSA id y23sm6748247pfa.67.2022.02.19.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:14:51 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:14:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
Message-ID: <YhEzmdhxHC3W8ijE@google.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
 <YhBCsg2DCEd9FXjE@google.com>
 <CABPp-BHU4VYXF8kNvZEwBLu2BYP2Q1c9dYMW_8QfNmvGjB1ZOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHU4VYXF8kNvZEwBLu2BYP2Q1c9dYMW_8QfNmvGjB1ZOA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> And, of course, you're trying to do more than just detect
> inconsistencies -- you want the vfs to fully control the sparsity
> patterns and expand them based on dynamic file accesses by the user.
> That dynamic bit doesn't play well with the non-vfs workaround.
>
>
> Does that sound right?

You captured some of it.  There's a bit more: typically when using
sparse checkout the traditional way, you will not have files in your
working directory that do not match the sparse checkout pattern.  That
way, the disk usage in the working copy is nice and small.  But with a
vfsd like described in [2], having other files in the working
directory does not cost disk usage because the corresponding data even
in compressed (git object) form does not have to be present locally
until the files are accessed.  So a vfsd gives an end user the
illusion that all files are present, whereas git only operates on a
small subset (the working set).

With this change, git would start operating on all the files.

[...]
> Side note: I thought Microsoft's vfs was first named GVFS and then
> based on naming collisions renamed to VFS for Git.  Sounds like you
> have something that is probably a bit different, but which you are
> also calling VFS for Git?

No, sorry for the lack of clarity.  When I say "VFS for Git", I
genuinely mean https://vfsforgit.org/, which was authored by Microsoft
and to my understanding is still used by Microsoft's Windows team and
is available for anyone to use.  (That page currently returns a cert
error because their SSL cert expired 10 days ago.  But hopefully it
conveys the idea, and the content is still there if you go through the
interstitial.)

I agree that it can be kind of confusing to talk about that alongside
VFSes in general, but I didn't choose the name. :)

[...]
> On Fri, Feb 18, 2022 at 5:07 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>>  a. We could guard it with a config option.  It would still be a
>>     regression for VFS for Git users, but they'd be able to use the
>>     config option to restore the expected behavior.
[...]
>>  b. We could distinguish between the vfsd and the "interrupted and
>>     forgot to update SKIP_WORKTREE bits in the index" cases somehow.
>>     This sounds complex.
>>
>>  c. Something else?
>>
>> (b) and (c) aren't sounding obviously good, so (a) seems tempting.
>> What do you think?
>
> Yeah, I'm having a hard time coming up with a way that either the VFS
> could recognize these special Git present-despite-skip-worktree checks
> and treat them differently, or having Git recognize that it is running
> under a special VFS that likes to aggressively and automagically
> expand the sparsity patterns.  So (a) seems tempting to me too.

Thanks.  In a way it feels like giving up (isn't it better when things
automagically Just Work?), but I think it's the right thing to do.

> Got any name suggestions?  core.avoidPresentDespiteSkipWorktreeCheck
> (defaulting to false)?  core.sparsityConsistencyCheck (defaulting to
> true)?
>
> Did your team want to implement that on top of
> en/present-despite-skipped since you can verify if it works for you,
> or did you want me to take a stab at it?  Should be a pretty simple
> change.

Monday is a holiday here; it shouldn't be hard to get a patch out
later this week.  Happy to write one but I also won't be at all offended
if someone else writes it first.

Ideally the config name should describe the intent from the user's
perspective instead of the implementation.  So something like
"sparsecheckout.expectFilesOutsideSparsePattern".

Thanks,
Jonathan

>> [2] see
>> https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
>> for what I mean by "vfsd"
