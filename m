Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3557C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 09:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CA6233CE
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 09:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAMJZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbhAMJZb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 04:25:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8AC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 01:24:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t16so1316858wra.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 01:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MecyJAe7kfRdCcdfZsexcn+ezKDEDo60uYQ9XShufiU=;
        b=SuaOFtJPyds0PMGyyKUopaBoMupAz1Y71lAGce0QkVN1E6I6/FJO32T9JMP3RTdNjH
         U0xWwUXWGgf/1d9DIruCcexeX3UIJJcdcc0qqRRxuin1/g7oVIRlhgYsi4x0Fis0m9+N
         fD9v7DlLL0f6tevL6kQsCSL7r2/QiIA7PFe/+JXhqZYrn9zOwGqTVVGgaf0CWaSX2M13
         pUQkxNb9nMriDJC+Ej8+d2ySNWx5TEXd93lsdpu4nLP3mMdtk6PVbG/nrRHf3xfI8pzV
         argt5tNoBvZL9UVAnJGHvfvux4VYy5UzbBs7+GxhqodEq5jkUcnVV93tncd3mrpQW7CS
         mUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MecyJAe7kfRdCcdfZsexcn+ezKDEDo60uYQ9XShufiU=;
        b=QD0TbdHjb4j2GF2RRdxwVWQPpHl6g3M87ehYYks0Atpiyu5j0v4ZnXp/9ELPL3Ez4v
         o+DxZLfigFLycFcLK1gEKIz2U3YqrCfu78qlYZFREHAQTzvBfzJsuv7SjQWeHDcrO6r7
         TulrIWX3Rjc+G03hB1m1olNfK748RLknm/btq7Z2z73vpOa1VsuX7C2U6jF9jJrF3Cnc
         e2FZ5eYsbmPdBh9E5TDSqI5ICXYH7wXcJtRZYcM2OsBEqEXIltxLUS/HWcDE/76FrLUd
         +IrzEUU/WFan3HGjtRX0Dpw/X81PUgUtyedc8aNYG+oHqCvimEbl0c0Jtq0TeG0Waem1
         xpuA==
X-Gm-Message-State: AOAM532hznW2gMONIG7jNQGtVfxrH3+qIvXmrP27bLEQ33kvaI5GdCq7
        0LNg/KsvVYSCYoaxnlWJyQ==
X-Google-Smtp-Source: ABdhPJx7XVMO5aJ4VoQv1zYIoL+YbnscE8tAaFw4DnxAEky5ttgj/mdAPIr7TCja/IdMrHKc4HVvdQ==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr1607052wru.28.1610529889552;
        Wed, 13 Jan 2021 01:24:49 -0800 (PST)
Received: from sync (90.ip-167-114-239.eu. [167.114.239.90])
        by smtp.gmail.com with ESMTPSA id l8sm2696711wrb.73.2021.01.13.01.24.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jan 2021 01:24:48 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:24:48 +0000
From:   Arnaud Morin <arnaud.morin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] patch-ids: handle duplicate hashmap entries
Message-ID: <20210113092448.GE32482@sync>
References: <20210109162440.GM31701@sync>
 <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
 <X/28IXBpse2dNZQH@coredump.intra.peff.net>
 <20210112153438.GC32482@sync>
 <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
 <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this patch, that's even worst, consistency is broken.
Let me explain.

With your history example:

     ---o---o---M---o---o---W---o---o---M---o--- branch
         \
          o---o---o---M---o--- master

# WITHOUT PATCH
If we imagine that master is having more commits count than branch.
The result of rev-list will be like you described:
$ git rev-list --left-right --cherry-pick branch...master
<M
<W

In other words, it's showing both W and M.

BUT, if we imagine now that master is having less commits count than branch.
$ git rev-list --left-right --cherry-pick branch...master
<W

It's only showing W!

So the result is not consistent, depending on which branch is having
more commits.

# WITH PATCH
With the patch, everything is consistent, and only W is kept in ouptut,
no matter the size of history:
$ git.p rev-list --left-right --cherry-pick branch...master
<W

Cheers,

-- 
Arnaud Morin

On 12.01.21 - 11:13, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > At the end, we'll have eliminated commits from both sides that have a
> > matching patch-id on the other side. But there's a subtle assumption
> > here: for any given patch-id, we must have exactly one struct
> > representing it. If two commits from A both have the same patch-id and
> > we allow duplicates in the hashmap, then we run into a problem:
> 
> In practical terms, for one side of the history to have two
> identical patches, the most likely scenerio for that to happen is to
> have a patch, its reversion, and its reapplication, intermixed in
> its history with other commits, e.g.
> 
>     ---o---o---M---o---o---W---o---o---M---o--- ...
>         \
>          o---o---o---M---o--- ...
> 
> where "M" are commits that does an identical change, and "W"
> (upside-down "M") is its reversion.  On the top history, "M" was
> introduced, the bottom history cherry-picked, the top history found
> problems in it and reverted with "W", and later (perhaps with the
> help of preparatory patches on top of "W"), the top history now
> considers that "M" is safe, so reapplies it.
> 
> And a "--cherry-pick" output that excludes "identical patches" that
> appear on both sides on such a history would hide all "M"'s, leaving
> a history like
> 
>     ---o---o-------o---o---W---o---o-------o--- ...
>         \
>          o---o---o-------o--- ...
> 
> But is this result what the user really wanted to see, I have to
> wonder.
> 
> I do not see any problem in the patch itself.  We used to hide only
> one "M" from the history on the top half in the picture, leaving one
> "M" and "W", while hiding the sole "M" from the bottom half.  Now if
> we want to no longer show any "M", the updated code would correctly
> hide all of them.
> 
> It just feels to me that the resulting view of the history look
> weird, leaving only the reversion of a patch that has never been
> applied in the first place.
