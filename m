Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE3C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751216139B
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhDFV5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhDFV5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 17:57:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D53C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 14:56:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba6so10816950edb.1
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Md9vBtTFAjaiwgDsvOjzjJkq6evr1B2WIkwyGNmksfI=;
        b=KA6DVizjuTZMN33KSNBYTbsKVGoViz35DnVmAWnbdETlRhxsYqEPjjMgaTRI8pj6z+
         PtBvzIiWYWz6DxkPhR7PNDt1BB9dT0nbQE1X4wpcEKOzDZZOmyTxJw0mMHi4jp4NKtbI
         VVzfh0J4f3ZxwClAe7C7q6OYVb849vqu4biR8XC9EnkswY+Sl4EnhhVgOeQmcD7dY8Wq
         CksHgy9IZkQLP/EkRMc6zPfsF2OSxyBiDkVysIrE6VXyu+shqIaSK7AItFTSz2S3Tsua
         HMwNFlYtbtNYtVihV8hGZkwHQFP9reYDvOybX8wjIzuWHOljlYch3E15ndwjrNT9tAxe
         KwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Md9vBtTFAjaiwgDsvOjzjJkq6evr1B2WIkwyGNmksfI=;
        b=Fq0y2tYj9J2DKaeA4y1L6mK2+PR80grzksoD41IjSvMPAK5lmqVqZfsLj+etESI0W/
         PkxtFwR3Um6612lND4T0c/HlYj+FDriV4Rwik93DX+qlFPq3H9I6P/ZgqHO7pRdvhNo/
         ZXmAwnnd7SSPHRx/2Zvk1Jjq1DbGk81Cw1NAq7A3yCixNB36EqltJuAgkdfWUhb3N+lN
         vvJfF09QJhZDxPGo4eM6hILz8aeU/Kq5edCry2n0wYSsBUKG4+BdS2BVe/elTWYZ3O6v
         h2b3Ce9IicuD8gJClxUf5YH6aen5RAiY/TTWk8TfD32XdXcnQjqNEzin8uiiY12Fn5Pd
         wIdA==
X-Gm-Message-State: AOAM532E+fTvUjx3gXqS1rME3nleFsWVfFdZHriKj+KIye3vkPvcomP8
        Q93ACYLSoL0hF+jU6OASYI59hJRQ8ZOZCoKxQf67qg==
X-Google-Smtp-Source: ABdhPJxlgL+vBITZJwt/fbcvYDR5excdG4aWRgCAFwQDnOrgRQBB9byvTW2Qpodg3bkVx/RurZA49dRslFpf3drNnXE=
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr534164edc.360.1617746213871;
 Tue, 06 Apr 2021 14:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-2-jerry@skydio.com> <20210405221902.27998-1-jerry@skydio.com>
 <xmqqr1jo4aex.fsf@gitster.g> <CAMKO5CuLpa9Sn_oXMpgP6oGE9NFA8aLeTfeyaW6TOTErE0KgEg@mail.gmail.com>
 <xmqqh7kk2c49.fsf@gitster.g>
In-Reply-To: <xmqqh7kk2c49.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 6 Apr 2021 14:56:42 -0700
Message-ID: <CAMKO5Ctoa8cf9T0reE9DduC7oX8QgQw-sQH315mQN=KiLDS8ag@mail.gmail.com>
Subject: Re: [PATCH V2] git-apply: Allow simultaneous --cached and --3way options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 10:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Thanks for the comments! I've updated v3 with the changes. Let me know
> > if you have any
> > more thoughts on whether to block / warn the user before clobbering their cache.
>
> Please do not top-post on this list.
>
> I've already said that I think we should ensure the index is clean
> by default, because, unlike the case where the application is done
> on the working tree files, the use of "--cached" is a sign that the
> next step is likely to write a tree out.  As I've already said so in
> earlier reviews, there is nothing more from me to add on that issue.
Understood, but please bear with me to explain the risks a bit more. I'm
having some difficulty coming up with a name and explanation for flags
for this case, because I don't completely understand the safety issue
we are trying to mitigate.

Let me enumerate some behaviors in 3 different cases where the user
has "file.txt" changes staged in the index, so index differs from HEAD.

"git apply --cached" would either 1. combine the patch and cached version
and put that in the cache or 2. do nothing (patch failed). In 2 nothing happened
so the user's changes are safe. In 1 the user's changes may be gone, but
since the user was forewarned, this is presumably what they wanted.

"git apply --3way" would either 1. apply cleanly to working dir or
2. conflict, in which case user's changes would be moved to stage #2
in cache. For 1 the user's changes are in the cache, so they can check that out
to restore the original state, since this invocation requires the cache
and working dir to match. For 2, the user's changes are moved to cache
in stage #2. Although the changes are preserved, there doesn't seem to
be any atomic way to move a cache entry from stage #2 to stage #0.
Something like "git restore --staged --ours file.txt" seems like it should
work, but "git restore" doesn't allow combining those flags.
The non atomic way we can do is "git checkout --ours file.txt &&
git add file.txt", this is ok in this case since we've required the index
and working tree to match.

"git apply --3way --cached" would either 1. apply cleanly to the cache or
2. conflict, and the user's changes are moved to stage #2. In 1, the user's
changes are lost because they're combined with the patch, but this is
the same as the "--cached" case by itself. In 2, the user's changes are
preserved in stage #2 similar to "--3way" by itself. What's somewhat
tricky here is restoring it to stage #0 since we can't use the working
tree, but I think that is more of a limitation in "git restore", since moving
a cache entry from stage #2 to stage #0 is a conceptually possible and
simple operation.

In summary it seems to me that merge or no merge, the safety semantics
for "--3way" + "--cached" as it is are pretty similar to the existing semantics
for those options individually. The user could be preparing to write
a tree out in either the "--cached" or the "--cached --3way" operation
so I don't understand why those must differ in safety. In addition, the
both "--3way" and "--3way --cached" perform mergey operations that
changes the stages of a file in cache, so I don't understand why those
must differ in safety either.

>
> >> Give an order to the codebase to "be like so".  Here is my attempt.
> >>
> >>     Teach "git apply" to accept "--cached" and "--3way" at the same
> >>     time.  Only when all changes to all paths involved in the
> >>     application auto-resolve cleanly, the result is placed in the
> >>     index at stage #0 and the command exits with 0 status.  If there
> >>     is any path whose conflict cannot be cleanly auto-resolved, the
> >>     original contents from common ancestor (stage #1), our version
> >>     (stage #2) and the contents from the patch (stage #3) for the
> >>     conflicted paths are left at separate stages without any attempt
> >>     to resolve the conflict at the content level, and the command
> >>     exists with non-zero status, because there is no place (like the
> >>     working tree files) to leave a half-resolved conflicted merge
> >>     result to ask the end-user to resolve.
>
> I wrote the above as an example to illustrate the tone and the level
> of details expected in our proposed commit log message.  The
> behaviour it describes may not necessarily match what you have
> implemented in the patch.
>
> For example, imagine that we are applying a patch for two paths,
> where one auto-resolves cleanly and the other does not.  The above
> description expects both paths will leave the higher stages (instead
> of recording the auto-resolved path at stage #0, and leaving the
> other path that cannot be auto-resolved at higher stages) and the
> command exits with non-zero status, which may not be what you
> implemented.  As an illustration, I didn't necessarily mean such an
> all-or-none behaviour wrt resolving should be what we implement---I
> do not want to choose, as this is your itch and I want _you_ with
> the itch to think long and hard before deciding what the best design
> for end-users would be, and present it as a proposed solution.  An
> obvious alternative is to record auto-resolved paths at stage #0 and
> leave only the paths for which auto-resolution failed in conflicted
> state.
I missed the "all changes to all paths" requirement in that description,
I'll update it to be more consistent with what it actually does. As you say,
the leaving entries at higher orders behavior only happens for conflicting
paths, not for all paths.
>
> Thanks.
