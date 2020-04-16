Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D103C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D1320767
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEpbviqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDPEKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDPEKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 00:10:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2ABC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 21:10:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q16so715424pje.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 21:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=az0FyA2d120C3+UUkmCZDaRlfGks8eqNLnu8XKhCTbE=;
        b=DEpbviqwvUp6uTQx/GGde12x0OpCZfnZJJgTwc/dt2ElrmoVD8oZ3tn0K4rqBT+zei
         m9zGRr3Xp3dsWXzi4qg+F+UQAhUAJ+ODtwon8zGQGmNSgvoyuNUxFoH+l7oX/hbHE+NL
         KLBjauqHGIyjig5X1dGiWQCGGBxT7YTJpNDpRruPl9D7KrlyezuDlK2LTRNiWSsFs34u
         vSsQgmg5h5dfLPTKkKQ6dcCdPI7d8nWEUchMnaVEET8wkaAVaPB1fgWzV6tgZQKmWcbA
         t0+xIvaBmV9JaxtpHAIK502CnmOhRpxJbDvlYxKq1qwneT2ICxtAdduyCzUT4oaL0ByX
         AwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=az0FyA2d120C3+UUkmCZDaRlfGks8eqNLnu8XKhCTbE=;
        b=ZGLP12cW5tNJQUr3sbx2ustaNuxeSVlvxSA/iur98zdkogTvuq0u+w6+tHXFS7Xbxf
         tUeUzEemxQkVL/cOh+A80TmYlW8q4O88j47HQZPJh5SCvfjso+xC1OwzheWj6Ryn9FNS
         CBctXWWZ7MgVgCR6/Ol2vCvObEOLoTd2d/dBcmgf3WgTLj4dR5gtI/qTp493P+VedhHd
         vZy17eajObINHVXnNThwA5rb1PnkDdR3vqTGu83zaqrD61tXWAK1kkNJJ8Kw3FSuzcM8
         u4dTb99uzLyMweY74HDbSzIrbMUT/xedzIzk5mGQQSVMIkbcNFvUsc598UAqEcULoYZ+
         sRXg==
X-Gm-Message-State: AGi0Puadf7vHt+sUay8QBLFGdlk8CUePyB6WsF8q/k6/2tr3rOsrG+Ym
        Xx3LRfIRxDlFCuaXeG9QwRjoAw==
X-Google-Smtp-Source: APiQypJNEB3KpZ/o5/W9XGomB76aX2EHNOkOOrJC/txW5QqatljYTJos98ESWfR8g6InLU9dG6edmA==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr2696795pjv.171.1587010243145;
        Wed, 15 Apr 2020 21:10:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g2sm1120005pjd.9.2020.04.15.21.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 21:10:42 -0700 (PDT)
Date:   Wed, 15 Apr 2020 21:10:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
Message-ID: <20200416041037.GA236872@google.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com>
 <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
 <xmqq1rovl54d.fsf@gitster.c.googlers.com>
 <20200410174141.GB27699@danh.dev>
 <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
 <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
 <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
 <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 08:45:05PM -0700, Elijah Newren wrote:
> 
> Hi Emily,
> 
> On Wed, Apr 15, 2020 at 7:01 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > On Wed, Apr 15, 2020 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > > > Danh Doan <congdanhqx@gmail.com> writes:
> > > >
> > > >> Excerpt from build log:
> > > >>
> > > >>> fatal error C1083: Cannot open include file: 'config-list.h'
> > > >>
> > > >> It's from bugreport topic.
> > > >> I've seen this failure in the past (when testing with pu),
> > > >> then I saw it disappear.
> > > >>
> > > >> I thought it was fixed during my testing for v4.
> > > >
> > > > Is the issue something similar to 976aaedc (msvc: add a Makefile
> > > > target to pre-generate the Visual Studio solution, 2019-07-29)?
> > > >
> > > > If that is the case, perhaps something like this would help?  I'll
> > > > tentatively queue it on top of es/bugreport and merge the result to
> > > > 'pu' to see what happens.
> > >
> > > The build just passed: https://github.com/git/git/runs/590781044
> > >
> > > Emily, you may need to squash in something along the line of this
> > > change to the commit in your series that starts building and using
> > > the config-list.h file (was it the first one?).  I've queued mine
> > > as a follow-up "oops, it was wrong" patch, but that would not be
> > > kosher from bisectability's point of view.
> >
> > Hm, ok. I'll send a reroll squashing this in verbatim tomorrow unless
> > I hear otherwise from Dscho? Looks like it's indeed the first one
> > (dd763e).
> > I'm curious to know how I can check this build method for myself for next time.
> 
> Create a fork of github.com/git/git and open a pull request against
> it.  (I believe you could also fork github.com/gitgitgadget/git and do
> a pull request against it, but I switched over to /git/git a while
> ago.) Immediately upon opening the pull request, a bunch of linux,
> mac, windows, and freebsd builds will be triggered with various runs
> of the testsuite.  Has been very useful for catching issues for me
> before I sent them off to the list.

I did before I sent this iteration, and it passed:
https://github.com/gitgitgadget/git/pull/573

That's why I'm confused :) Did I do something differently? I don't use
GGG to send the emails, but I do use it to run CI checks.

 - Emily
