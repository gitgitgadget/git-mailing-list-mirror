Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F9C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbiBYQoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbiBYQn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:43:58 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8026916BFB1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:43:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n15so3034085plf.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rHuiRQWJVAm74bJbM7GcnZH1Yyn5nCg5ggfNZSl1q/M=;
        b=CIootXXwdCz7FA+3nGYab0BUt2kRRgLsF3OIAU6nAjoiWSYLc5RoKBdR1mFUYfiPnp
         Ua4xiiojYzhH+ZLtdizmPcOhF0uuRvVRi91G+du2SHzE+IE6DPOSuzgR6T8MFXKw4LuJ
         +/dZq+VtluH4djXXxY21fKCaduM30RLIwKSs/bF3QAy8omhEY7NNsX/RMIY7XHt5/wiO
         Wz/MnyecSPyzQWbxSrP56N2ivYwDgv2fze6q7rDxfXddajef1l0j+iyaqIVPGY2PiGtH
         /j3CZ+AYbRR5xZnjhB82qx/wXbKpBa9KkF9rxn7bqWmtHYCRLGOh3CUhYV0T53Z6kGyk
         Qrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rHuiRQWJVAm74bJbM7GcnZH1Yyn5nCg5ggfNZSl1q/M=;
        b=0p3zXypXRZkY4F9+sxcHKCJB8aRxdxGMUVmJD0thPOPixZqKTirIE9f3Uc5aIzeohM
         4PQnBezw5Ou8lNP9AT1DdltnWGvgo2cL86DhmLgr5xUV9SqwOYfl7NgXaIyaTtCGUIo6
         1ghWAwfG6U4kwsGRMOTjS4+Ei+AMOLX9Bewe6NWftu666tPOZbjr4zUzWOLHoC5/1GLN
         X6R5FmvPww+VB2vlSRl0AGMR2zTAnGu6dZ6AEf9kAemM0u6IN3INdUYMLZLRLq/gA4o7
         L+pIuGx+oca8jzBp2loZGj8e99VDPINcs9nUjf5Xo3G/B7IZ+8oAmo4MZNOpjCqztJ8L
         D+hA==
X-Gm-Message-State: AOAM532GPKYjY8vvRsMc1vAbGpv9NQboiBiMCnXbneLo+JY11Hv6tlNk
        6BX8w/qhOhwA4/iqnw05G4M=
X-Google-Smtp-Source: ABdhPJxgYAj8YM+MQo7d3zzwlAEs0c90o6hVy52ajb+XdlhFM3ROUP/wpSWrGN1UJCYXGzwb3fIuaQ==
X-Received: by 2002:a17:90a:4814:b0:1bc:ec27:b644 with SMTP id a20-20020a17090a481400b001bcec27b644mr3940362pjh.213.1645807404247;
        Fri, 25 Feb 2022 08:43:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:4559:4408:3487:ab8e])
        by smtp.gmail.com with ESMTPSA id w16-20020a056a0014d000b004e12fd48047sm4291319pfu.35.2022.02.25.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:43:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 08:43:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: en/present-despite-skipped (Re: What's cooking in git.git (Feb
 2022, #05; Thu, 17))
Message-ID: <YhkHKTY9MlR9gUkI@google.com>
References: <xmqqley93rkw.fsf@gitster.g>
 <YhBNgUFnujFGVcRo@google.com>
 <YhV3KruSTFYEDBAO@google.com>
 <xmqqo82xv0cj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo82xv0cj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Jonathan Nieder wrote:
>>> Junio C Hamano wrote:

>>>>  Will merge to 'master'.
>>>>  cf. <20220204081336.3194538-1-newren@gmail.com>
>>>>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
>>>
>>> I'd recommend holding off on merging to 'master' for now, until we
>>> figure out what to do about
>>> https://lore.kernel.org/git/YhBCsg2DCEd9FXjE@google.com/. Hopefully that
>>> won't take long.
>>
>> Since as discussed there this isn't a regression for existing users of
>> git 'master', I see no reason to hold off on merging to 'master'.
>
> I think I've read on what people said on this topic for the past few
> days while I was away.
>
> I do not quite follow the above, though.
>
> Does the logic go like this?
>
>  - Earlier you worried that VFS for Git and similar that have been
>    working happily with vanilla Git would break with this series;
>
>  - It turns out that VFS for Git comes with its own version of Git
>    that does not have this series;
>
>  - Hence we can do whatever we like to vanilla Git, and it won't
>    immediately hurt.

Yes, exactly.

> The config knob to tell the sparse logic that it is OK if lstat()
> tells us that there appears files that ought to be missing from the
> filesystem due to sparse settings would be needed and that is why
> you sent an updated proposal patch in separate thread, right?
>
> Shouldn't we iron out the details of that knob and release the topic
> with that knob at the same time?

That's fine with me.  I just figured that since this series is already
useful without that knob and the only known affected users are using
"next" anyway, there's no need to delay unaffected users getting the
rest of the improvements while we iron that out.

In practice, fewer people than I'd like run "master" (alas) and the
patch adding the knob looks close to landing anyway, so the difference
is likely mostly moot.

>                                   If Microsoft folks already have an
> existing knob to tweak the behaviour of sparse checkout to work better
> in vfs environment where lstat() lies, and if the necessary adjustment
> is wider than just the issue the sparse.expectFilesOutsideOfPatterns
> solves, I wonder if we should take the approach to align with their
> forked version of Git by matching the name and the behaviour of the
> knob somehow.

This is a good point.

I'd expect sparse.expectFilesOutsideOfPatterns to be useful in other
cases that are not a VFS setup, such as having some automation that is
the only writer to a perfectly normal ext4 backed working tree and
uses sparse checkout to tell which files Git should pay attention to
(similar to the old --assume-unchanged use cases but a little easier
to set up).  So I think it would okay for this to exist and be implied
by core.virtualFileystem instead of being solely keyed by that setting
(or in other words I don't think we're painting ourselves into a bad
corner, config naming wise).

Thanks,
Jonathan
