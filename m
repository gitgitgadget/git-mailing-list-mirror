Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75905C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220B520721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sW/6tIDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgKWUed (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgKWUec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:34:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8779AC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:34:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so20064617wrg.7
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV4wmRt4DYsISy9UHgg4C3REYOZSuwfa9jc7EKxEAlA=;
        b=sW/6tIDYFY/mbSz5D8xaEpEBZBnKw3GRhLqq/gu3gQ73oElfhKfidLS+nFnxiq1cvu
         5HpVdFkyZtN1rNO0jpqSHP/X/i+0SnIq8EYI7+9SNs54HyNsehg41L/hSJMbMIiKhyt1
         sB4pNSMPOzYq2rzF6k7uk88wSLIsIOVrgxzYaXrlggtQQp6pOQzMNCkSLFOmdM5RTFvg
         I7SiLyYbndPdMtIVVZTwG0WAlDvHpkVKJk4/cYSuOfrB7FLDAd5iFVVNBUq1JOXIn5B0
         zLadgAOIHwmqhRw5ddJ+ZxMj6QAeoyjbghvuN54iWOrdvSq/YPbE1oEi/aeHe4OWcgSL
         O74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV4wmRt4DYsISy9UHgg4C3REYOZSuwfa9jc7EKxEAlA=;
        b=fpDnuf1ks2GBO2Xu9FHrlyqsVwgXVCmUevJg6ScOzCQY1fTzW4a9jUue0ff2Ml55aa
         0n4y9345UPdwyn6yBQkXeSLzFKP33r8nkaWHBPq2cW3cCfbRWTFaRJ6RZn8+zACmW94y
         BaDVbVSaOxAXZLTu1BxfDMyDXaMzTKeCjXoY3rrmw9Y/OPhDQsd1/OdAdGsTLiPyxsLC
         1Hzm5oQQp1rqYQB64dpjeMf+lUYMq8n1cLOFT0ULqA7wV0qRYwchZ/qUDKS5lhlUwZby
         sDEg3Xapd1/WS3m+DrewhaqItJdZuFk0JiSaztKcTJMhxD0ATWToMVlOCk6jcopqI84p
         Rzdg==
X-Gm-Message-State: AOAM532NZxtTTMLQg8NIezcpEK3oikNajqE79PRKzXjsa7LMIaRXoOGM
        bLL0rYO7vicBp4H5GC13luHrD7/i0IpuyxEG6/8=
X-Google-Smtp-Source: ABdhPJwAaNuNImam5Dnl6t4kaE/bJAr5hBRjlij3hgDXowQuwNfPkLI78S/Hj+cSdg16ydtg+87wd9bXfMtsOw3TMJE=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr1528108wrs.100.1606163670293;
 Mon, 23 Nov 2020 12:34:30 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu>
In-Reply-To: <20201123202003.GB132317@mit.edu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 14:34:18 -0600
Message-ID: <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 2:20 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Nov 23, 2020 at 01:40:38PM -0600, Felipe Contreras wrote:
> > On Mon, Nov 23, 2020 at 1:17 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > > If your repository is effectively a leaf repo, then rebasing may be
> > > harmless, although there are still who don't like rebasing because it
> > > invalidates your previous testing.  My personal preference is to do a
> > > git fetch, followed by a git merge --ff-only, and if that errors out,
> > > then I know I need to take a bit more care before deciding what to do
> > > next.
> >
> > Which is why I suggested to make fast-forward-only the default:
> >
> > https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/
> >
> > In what case would that default not be what most people want?
>
> Well, it *was* the default, previously, IIRC.

There has never been a "pull.mode=ff-only" option; that's what I tried
to introduce.

> The problem is that for
> "simple" use cases, using rebases for git-pull is "simpler".  Well,
> it's simpler until it does something super-surprising when the project
> becomes more complex, but if the goal is to have a more gentle
> learning curve for newbies, especially for small projects --- which
> are the vast majority of projectds, on, say github and sourceforge ---
> the case can be made.

The people that want rebases can configure git pull to do rebases.

This issue is about the *unconfigured* default.

> So intead of having a huge discussion which is going to be very hard
> to come to converge (much like the "main" vs "master" question),
> requiring people to set their own global default or per-repo default
> is a pretty good compromise.

This discussion already happened in 2014, and the conclusion was that
doing fast-forward merge if possible, and fail otherwise was a good
default.

The problem is that the patches were never merged.

Cheers.

-- 
Felipe Contreras
