Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4470EC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245011AbiCJWrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbiCJWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:47:05 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54F618FAF7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:46:03 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id x3so5706920qvd.8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=sym2QzjcitWnOE1fJp1pBMHBo1FbPsVN6U+8Wgx8FBc=;
        b=qzk8BKZYDw54Zt0q7ugsp79Z943zVXspRXUcA+hNnrp8KbrNNzSAkJ5ulz7dGd1p/z
         rkRJ0zTLqAO1gBDyIyYCI7qna8GuA7mjZoZdCL6rOVPxR86XtWxrZlqSF5i0ZDr5p8vU
         z2XOFQH798uUq7J6wpCXyexZBV9CTNZ0DjM4JJv1X9fWugVya3tAeMd6USiY6piwgWQs
         ug7d40ZH2W+A1yERute5X/sxVP6WT4qdB2ABnBQX1syzVvO8eMJom/te/2tRNKlMbDCm
         RzbZV9ACFEc+dV8tlpedwjNpr0JOn2rsgkcKe9L70EhTQ8oJBGPQFN0EYa7rdsnyf95y
         BLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=sym2QzjcitWnOE1fJp1pBMHBo1FbPsVN6U+8Wgx8FBc=;
        b=VyNLuEualrlVWtHN6AAvyUGcvjAXViiSvwcrVYkw05kPeXGOs0N0/YvBH6UCuYA8zh
         N39YTlkp5qeDDTyXxbaHaVuzsfG0uIvACEqYGeH6em1b09gy2eyZitW4xPVU6eyVRYDC
         6wzIw4/nSQkkDny+IwkQjnllbBIBTNIV77Nt17s0l1mmXZ3LBpaxwkybejv9SBa92fEN
         hWrqBjaI90GKV9+5/58+eTO4xpWqEf2TeFO5BS7kRuxB8ld/b0PDjeMu9b3WCcG2abZj
         riFt2r9vH+daLFPJo48IFA9IJK+UKM+H+DX7uAfzaLZ+HPSgXReMFc4qeepFSLXhzaEm
         LJOw==
X-Gm-Message-State: AOAM531Gq8MolNJkZD4NLQbJ5sT4eMrsGLCsyKdIwRNmIR7kv5bjVRqW
        7a0HhPfCLOg9S+S1aD+QnukI3wmCgNg=
X-Google-Smtp-Source: ABdhPJy+LVDIdYl2EbKAfekEmWsAldUATsQp0DGvB4hv2FUWfjQhNsjMbFRRdBb/rjXLzQ7xQoz5dA==
X-Received: by 2002:ad4:5b86:0:b0:43a:5c52:30bf with SMTP id 6-20020ad45b86000000b0043a5c5230bfmr1030586qvp.22.1646952362868;
        Thu, 10 Mar 2022 14:46:02 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a12ac00b0067d4bfffc59sm1845383qki.118.2022.03.10.14.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:46:02 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: Bug with rebase and commit hashes
Date:   Thu, 10 Mar 2022 17:46:02 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <036EAEE4-D957-41F2-8B17-3AD7B2E49611@gmail.com>
In-Reply-To: <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
References: <YiokTm3GxIZQQUow@newk>
 <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10 Mar 2022, at 17:25, John Cai wrote:

> Hi Michael,
>
> I looked into this a little bit. I may not have the full answer, so others may want to chime in.
>
> On 10 Mar 2022, at 11:16, Michael McClimon wrote:
>
>> I have run into a bug with rebase when operating with commit hashes directly
>> (rather than branch names).
>>
>> Say that I have two branches, main and topic. Branch topic consists of a
>> single commit whose parent is main. If I'm on main, and I run
>> 'git rebase main topic', I end up on branch topic, as expected (my prompt here
>> displays the current branch):
>>
>> [~/scratch on main] $ git rebase main topic
>> Successfully rebased and updated refs/heads/topic.
>> [~/scratch on topic] $
>>
>>
>> If I do exactly the same thing, but substitute the commit shas for those
>> branches, git _doesn't_ leave me on branch topic, but instead fast-forwards
>> main to topic. This is very surprising to me!
>>
>> [~/scratch on main] $ git rev-parse main
>> 464adc6a6f8aa0a943dbf886df1eb6497f70f6e6
>> [~/scratch on main] $ git rev-parse topic
>> c3c862105dfbb2f30137a0875e8e5d9dfec334f8
>> [~/scratch on main] $ git rebase $(git rev-parse main) $(git rev-parse topic)
>> Current branch c3c862105dfbb2f30137a0875e8e5d9dfec334f8 is up to date.
>> [~/scratch on main] $ git rev-parse main
>> c3c862105dfbb2f30137a0875e8e5d9dfec334f8
>
> Taking a look at the code in bulitin/rebase.c, it will check whether or not
> <branch> is resolveable as a valid ref. If not, then this code [1] sets the head
> name that will get switched to, to NULL.
>
> Then, when checkout_up_to_date() is called, it calls reset_head() which does not
> switch to the branch since opts->branch is NULL. But (and I haven't looked into
> detail how reset_head() works) it seems like it will still set the current HEAD
> (main) to $(git rev-parse topic).
>
> This diff seems to fix this behavior, but it's untested.
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b29ad2b65e72..bcbac75c705e 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1634,7 +1634,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                                 die(_("no such branch/commit '%s'"),
>                                     branch_name);
>                         oidcpy(&options.orig_head, &commit->object.oid);
> -                       options.head_name = NULL;
> +                       options.head_name = xstrdup(buf.buf);
>                 }
>         } else if (argc == 0) {
>                 /* Do not need to switch branches, we are already on it. */

Well, upon further examination this totally does the wrong thing :) Will look into the
root cause further.

>
>
> 1. https://github.com/git/git/blob/master/builtin/rebase.c#L1637
>
>>
>>
>> Part of the reason this is surprising is that in the case when topic is not a
>> fast-forward from main (i.e., does need to be rebased), git does what I'd
>> expect, and leaves me detached on the newly rebased head.
>>
>> [~/scratch on main] $ git rev-parse main
>> 464adc6a6f8aa0a943dbf886df1eb6497f70f6e6
>> [~/scratch on main] $ git rev-parse topic
>> 8d7d712bad0c32cd87aa814730317178b2e46b93
>> [~/scratch on main] $ git rebase $(git rev-parse main) $(git rev-parse topic)
>> Successfully rebased and updated detached HEAD.
>> [~/scratch at 1477bc43] $ git rev-parse HEAD
>> 1477bc43a3bc7868ba1da8a919a60432bedbd34a
>>
>>
>> I ran into this because I was writing some software to enforce semilinear
>> history (all commits on main are merge commits, and the topic branches are all
>> rebased on main before merge). That workflow is: for every branch,
>> rebase $main_sha $topic_sha, then checkout main and merge --no-ff $topic_sha.
>> Because of this bug, when we got to the merge --no-ff, git didn't do anything
>> at all, because it had already fast-forwarded main! I worked around this in
>> my program by just passing --force-rebase to my rebase invocation, which fixes
>> this particular problem by leaving me in a detached head (as in the last case
>> above).
>>
>> I hit this in production on git 2.30.2 (debian bullseye), but reproduced
>> locally using the latest git main, which is git version 2.35.1.415.gc2162907.
>> In both cases I wiped my user gitconfig, so I'm using only the defaults. (If
>> it helps: with my rebase.autosquash = true, the bad case above does not behave
>> badly and leaves me in detached head as I'd expect.) It's totally possible
>> this isn't _meant_ to work, in which case I think the docs could use an
>> update.
>>
>> Thanks!
>>
>> -- 
>> Michael McClimon
>> michael@mcclimon.org
