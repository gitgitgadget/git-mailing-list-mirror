Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01710C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 08:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiBJIv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 03:51:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiBJIv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 03:51:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F4C51
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 00:51:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z20-20020aa791d4000000b004bd024eaf19so3888253pfa.16
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 00:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z8jJ3ONTBDeYMyakjatMsnWOpD43Kievw4WTlQYUKGA=;
        b=VqqWZXeet3zyS7/SMGsGXostTwLBBYuvLKe4HYwhZ3J6To+SUP3vrJtrNY5FGWInQL
         yoTjESmXRvHEuD6tlxfoJ+X9+ZeGkdbqzS7bqlXP5wbrc+m68eWhEoPbukHswx1kdoPd
         ISC+YUp6D61zIvjt473ifflAGETYfETdspE+7YxSzybTj/ZYai3pACq1Zbhexo3Hw7Ai
         CuZxuj0CErQBpMNlojzHpFxVkd7u9YvuLb+wEjSPLxIfdf9BxVBqB37/PETz+WzagBSg
         DW/skHSPXBu07/z+SjMtrk+xICGUaiqf4x/r/gtea+N8VrbQUdFbwhYhoIrE5qsyEovR
         HyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z8jJ3ONTBDeYMyakjatMsnWOpD43Kievw4WTlQYUKGA=;
        b=RXYryR6DhRSd8p+nen1Tq9baiKD7tc6TEl2jPfmgZZfzFIlvuxr3cWZAhnpTgUXDD4
         tKpjpFFcxf33r/C3t41OOzQdLZL33V8qSzWEsEf80pBm7Jksbt+q0aisXD4Xu6l0gDTr
         n6vfZHZjnmwxVJird9kRFr+l3uttMwPaie1rEonfM73f1G2Hq5mdRAalcZdmd2JxHi1w
         14asEEBgOaQ1J2AonkO8Ri/yDZ62uTSoUt19ZYkhCQiMYquaUIeLBmpWwBiqBEQcBV7f
         m8wHMUtoyab1cUL7VT2Ohh2TWs4pDcitcSA3WZQe+RTiFAwCddCd9HaV4oy0UNuDw8zA
         r7Eg==
X-Gm-Message-State: AOAM531JeLxbBVqje27fh242uvtav33omiAyBznTN8kQKYVeadpcXd5Z
        8GlaO8xdrGkrT86GFnOjSaGWWmrE72DLBg==
X-Google-Smtp-Source: ABdhPJxKaL9t+sUdsoVApxtH+7/6VrQIv7xKrkvL5hsYALh15ZFnvrtBeBAVpV/PBLT4suEpUfld7A9n7M9fRw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:1dc9:: with SMTP id
 d192mr5723285pfd.43.1644483118101; Thu, 10 Feb 2022 00:51:58 -0800 (PST)
Date:   Thu, 10 Feb 2022 16:51:45 +0800
In-Reply-To: <xmqqsfsrw67a.fsf@gitster.g>
Message-Id: <kl6lzgmzdrz2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <xmqqsfsrw67a.fsf@gitster.g>
Subject: Re: [PATCH 0/8] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> = Background
>>
>> When fetching submodule commits, "git fetch --recurse-submodules" only
>> considers populated submodules, and not all of the submodules in
>> $GIT_DIR/modules as one might expect. As a result, "git fetch
>> --recurse-submodules" behaves differently based on which commit is
>> checked out.
>
> After getting 'init'ed, which is a sign that the user is interested
> in that submodule, when we happen to check out a superproject commit
> that lack the submodule in question, do we _lose_ the record that it
> was once of interest?  I do not think so.  The cloned copy in
> $GIT_DIR/modules/ would not go away, so we _could_ update it, even
> there is no checkout, when the superproject we currently have may
> not have the submodule.
>
> But I am not sure if that is a problem.  After all, the recursive
> fetch tries to make sure that the superproject commit that is
> checked out is reproduced as recorded by fetching the submodule
> commit recorded in the superproject commit, not a commit that
> happens to be at the tip of random branch in the submodule.
>
> It is OK to allow fetching into submodule that is not currently have
> a checkout, but I think we should view it purely as prefetching.  We
> do not even know, after doing such a fetch in the submodule, we have
> the commit necessary for the _next_ commit in superproject we will
> check out.

Hm, I may be misreading your message, but by "tip of random branch in
the submodule", did you mean "tip of random branch in the
_superproject_"?

If so, prior to this series, recursive fetch already fetches submodule
commits that are recorded by superproject commits other than the one
checked out. submodule.c:calculate_changed_submodule_paths() performs a
rev walk starting from the newly fetched superproject branch tips to
find missing submodule commits that are referenced by superproject
commits. These missing submodule commits are explicitly fetched by the
recursive fetch.

So we already do prefetching, but this series makes the prefetching
smarter by also prefetching in submodules that aren't checked out.

(I think my cover letter could have been clearer; I should have
explicitly called out the fact that we already do prefetching.)

>> This can be a problem, for instance, if the user has a branch with
>> submodules and a branch without:
>>
>>   # the submodules were initialized at some point in history..
>>   git checkout -b branch-with-submodules origin/branch-with-submodules
>>   git submodule update --init
>>
>>   # later down the road..
>>   git checkout --recurse-submodules branch-without-submodules
>>   # no submodules are fetched!
>>   git fetch --recurse-submodules
>>   # if origin/branch-with-submodules has new submodule commits, this
>>   # checkout will fail because we never fetched the submodule
>>   git checkout --recurse-submodules branch-with-submodules
>
> That is expected, and UNLESS we fetched _everything_ offered by the
> remote repository to the submodule in the previous step, there is no
> guarantee that this "recurse-submodules" checkout would succeed.

Yes. With the current prefetching, I don't think we make any guarantee
to the user that all submodule commits will be fetched (even if all of
the subomdules are checked out).

But if I understand the "find changed submodules" rev walk correctly, we
look for changed submodules in the ancestry chains of the branch tips
(but I'm not sure how the rev walk decides to stop). So we might be
_very close_ to fetching all the commits that we think users care about
even though we don't guarantee that all commits will be fetched.

>> This series makes "git fetch" fetch the right submodules regardless of
>> which commit is checked out, as long as the submodule has already been
>> cloned. In particular, "git fetch" learns to:
>>
>> 1. read submodules from the relevant superproject commit instead of
>>    the file system
>> 2. fetch all changed submodules, even if they are not populated
>
> The real question is not "in which submodules we fetch", but "what
> commits we fetch in these submodules".  I do not think there is a
> good answer to the latter.
>
> Of course, we we take this sequence instead:
>
> 	git checkout branch-with-submodules
> 	git fetch --recurse-submodules
> 	git checkout --recurse-submodules branch-with-submodules
> 	
> things should work correctly (I think we both are assuming that the
> other side allows to fetch _any_ object, not just ref), as "fetch"
> knows what superproject commit it is asked to complete, unlike the
> previous example you gave, where it does not have a clue on what
> superproject commit it is preparing submodules for, right?

So, given my prior description of recursive fetch, we actually _do_ know
which superproject commits to prepare for and which submodule commits to
fetch.

> Also, if the strategy is to prefetch in all submodules that were
> 'init'ed, we do not have to read .gitmodules from the superproject
> commit at all, right?  We can just go check .git/modules/ which is
> available locally.  We need to see which submodules are of local
> interest by consulting .git/config and/or .git/modules/ anyway even
> if we read .gitmodules from the superproject commit to learn what
> modules are there.

Hm, good point. Finding submodules of interest in .git/modules or
.git/config sounds like common sense (it's more obvious than trying to
identify all submodules by doing a rev walk at least). 

That said, just looking at what submodules we have doesn't tell us which
submodule commits we need, which is why we have the "find changed
submodules" rev walk. And since we already have the rev walk (which
tells us which superproject commits we care about), it's not that much
effort to fetch non-checked-out submodules.

So I think we'd eventually want to consult .git/modules and .git/config
(we'll have to do this when we start teaching "git fetch" to clone new
submodules, for example) but it's unnecessary for this series.
