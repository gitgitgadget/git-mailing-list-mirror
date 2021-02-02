Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F47C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A787864DA5
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBBDFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBBDFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:05:45 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11558C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:05:00 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k193so18558087qke.6
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvgUOiChauefCalS5rcv09lpezYzn3UAyDT0t2GD/j0=;
        b=J3jcdDkG8oDT7KfkHO+YtpyQecrBY7b3OJ8jLI9aj9TH26Yw88ii7iIYlnAT9XPGjo
         kS6UjarhZ/HtQbE1cSCv1s+4kagU2ZYGzQzM4A3Zh6O1HqqHi/vBYT0ehOqwpZqq67jt
         /qrWHPeFH2GiusvYdYhQN188r2xhXZlyP1IR9PCZ0w1M9MH/O4+Xy+wptYDQtiua96Tt
         8k5iM43uifgMI35BuND7+t6GRkoRUTT5F7ZrJc4ohcd8QdQvvwijLwlLusbDtb4+xyx3
         KCpAYQMdUdOASmSgLqD+fHVX4SdkfhucfNGFNk03QENVi3jg+T47/kAZoItuOUdXqbKJ
         S8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvgUOiChauefCalS5rcv09lpezYzn3UAyDT0t2GD/j0=;
        b=dIHqU6YMcX1NhXPE0hKypEH1wmDSk/m9jV7kP57nZsSWGqGIDk2zOGbiclI67f+E5W
         /Oyahu2zsZrC0wvqCH7+x2l5ztFxhJ1jkAsGScgcVh5/F0/x28FnOId1zTXfUMZDibSA
         JSv1P1fFeE2lZyo9Lp2Vx2duipwz4WLSU/EHOyp2NELYVM6Hz23gdwtb+EfaE/zyVRRH
         iV7+hDaHxWIsntJuDLLeVYq9+iOwop6JQYvFV5Mf8HENxlnyj0IR7nvJtiQ7qikQvBZm
         UQRVhN5epOL6WgtCSFQFaq3ARWds7eyR8NNU2UWACwK9IH8Yj1APqTI7BFQQ6L+YMpWp
         Lltg==
X-Gm-Message-State: AOAM531+2wypfJvXXeY66ZhEcQwAQttkvbwY1VSFGGJ0mULd+smEu1Oa
        XTXq9AHcD7hY6189T8t4+k0Azw==
X-Google-Smtp-Source: ABdhPJyUirBwCOv+/F5+GKomRdj2VBI+Ov2Aa+78G97xklLIiQ9kamHRksQpbhhkgpsfT3HYCB6e8Q==
X-Received: by 2002:a05:620a:1209:: with SMTP id u9mr19561802qkj.177.1612235099266;
        Mon, 01 Feb 2021 19:04:59 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id h6sm6150977qkf.96.2021.02.01.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:04:58 -0800 (PST)
Date:   Mon, 1 Feb 2021 22:04:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBjBWD8Lz81P9ElM@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <YBRprCmIX4IrHAi0@nand.local>
 <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
 <YBSHzG9T72nYYVt4@nand.local>
 <xmqqh7mzs5w3.fsf@gitster.c.googlers.com>
 <YBSaHHKV5ncjjJum@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBSaHHKV5ncjjJum@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 06:28:28PM -0500, Taylor Blau wrote:
> On Fri, Jan 29, 2021 at 03:03:08PM -0800, Junio C Hamano wrote:
> > Are our goals still include that the resulting packfile has good
> > delta compression and object locality?  Reachability traversal
> > discovers which commit comes close to which other commits to help
> > pack-objects to arrange the resulting pack so that objects that
> > appear close together in history appears close together.  It also
> > gives each object a pathname hint to help group objects of the same
> > type (either blobs or trees) with like-paths together for better
> > deltification.
>
> I think our goals here are somewhere between having fewer packfiles
> while also ensuring that the packfiles we had to create don't have
> horrible delta compression and locality.
>
> But now that you do mention it, I remember the reachability traversal's
> bringing in object names was a reason that we decided to implement this
> series using a reachability traversal in the first place.

Peff shared a very clever idea with me today. Like in the naive
approach, we fill the list of "objects to pack" with everything in the
packs that are about to get rolled up, excluding anything that appears
in the large packs.

But we do a reachability traversal whose starting points are all of the
commits in the packs that are about to be rolled up, filling in the
namehash of the objects we encounter along the way.

Like in the original version of this series, we'll stop early once we
encounter an object in any of the frozen packs (which are marked as kept
in core), and so we might not traverse through everything. But that's
completely OK, since we know we have the right list of objects to pack
(at worst, we would having some zero'd namehashes and come up with
slightly worse deltas).

But, I think that this is a nice middle-ground (and it allows us to
reuse lots of work from the original version), so I'm quite happy.

It's in my fork [1] in the tb/geometric-repack.wip branch, but I'll try
and clean those patches up tomorrow and send a v2 to the list.

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git
