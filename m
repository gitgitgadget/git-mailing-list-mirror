Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FBC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 02:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4972075F
	for <git@archiver.kernel.org>; Wed, 27 May 2020 02:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSAjSglj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgE0Cuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 22:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0Cuw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 22:50:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D69C061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 19:50:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q8so11097711pfu.5
        for <git@vger.kernel.org>; Tue, 26 May 2020 19:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GfmwOtfafwvq0aLhDpeqVnlBv7o/p6thxxK5P/oz93k=;
        b=qSAjSgljnKcHqfuhX/qhVPPJ7H6TQcmF8TPW0BymZr0EDtRCnZc+drjSxfz3QE+XJF
         sX78NN6fwi5kqkMRMC1nROEe6m7qBJStot0UBuYLQdQ0FLvHjnH1wr1TeK+o/Be5uous
         58OFVqY20lKPdSYDHECo7jKddXcgY01/ptSIAvwJiaY6Sjnjdu0bN67EYaPMlZgXOaNJ
         +l1cNS/ypMvGVwCpkLYqZ4Otd3mTxk6YIgbBX32r1fVwUjyGU5dxoUIbH+6FhQsHMiCI
         PHQUk8HuOWFuFU8Fq3Ab087z9q5Eeb20T02YiZNL08fZwwwaWoE9w7Hg5LUEAdRk5XNY
         UWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GfmwOtfafwvq0aLhDpeqVnlBv7o/p6thxxK5P/oz93k=;
        b=KKfjf7cnd3l24hSr5k59Hx+FNta81sOXfeNw+/+aB4T7j77Zk2Vg/uQJN9eYjK2V4p
         lHOL2g9dm5RzPBqV91IoF+4L5iyRxEbyMGi5xSEj5oYNLqSGNeE8S4gfH/csuelPlp8A
         J9/3Excsv7ijHqq147EL9NSJdboAuaovTIW1XVeF+5t457IdybeIySG5TYAF3/hte28t
         xZXdTQKhvcwtOmSaciVRUpaGjjBhhTu6jyjm927JuTAyL7cpuGmEE1DakHMTWicrKzRU
         /Xbslx8DyB16fOJdioB1HEPvVM05r530sU/UQop/dNVO295xZxrYVMgQVBlrKGg6Skrd
         zIWg==
X-Gm-Message-State: AOAM532kzCGMFjYjeulULzojjymZEomU1U0/j/I032HChehJjdGy/jIL
        n9bjXkgNBIvlZy5LtiZXmJXIBpav
X-Google-Smtp-Source: ABdhPJzG6Nt4Hjxfp5FCspw3r+Dd1q80xZ3V9NwvKS2RjQFjpPA7HMFedYjMYMK5eW+2Lv9cV1w+pg==
X-Received: by 2002:a62:2c8d:: with SMTP id s135mr1827715pfs.231.1590547850805;
        Tue, 26 May 2020 19:50:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x14sm787849pgj.14.2020.05.26.19.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 19:50:50 -0700 (PDT)
Date:   Tue, 26 May 2020 19:50:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kevin Buchs <kevin.buchs@newcontext.com>
Cc:     git@vger.kernel.org
Subject: Re: rationale behind git not tracking history of branches
Message-ID: <20200527025048.GC172669@google.com>
References: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kevin Buchs wrote:

> For many years of using Git, I always struggled to make sense of
> commit history graphs (git log --graph; gitk). Just recently I
> discovered that git does not track the history of branches to which
> commits belonged and the lightbulb turned on. This is proving to be
> painful in a project I inherited with permanent multiple branches.
> Now, I am a bit curious as to the rationale behind this intentional
> decision not to track branch history. Is it entirely a matter of
> keeping branches lightweight?
>
> I am assuming one can backfill for the missing capability by using a
> commit hook to manually track when a branch head is changed. Perhaps
> by storing the branch in the commit notes.

I think this comes down to a question of mental model: one thing I
value when using Git is that each commit does *not* belong to a
specific branch --- branches describe the shape of history, and
commits are points in that history.

This becomes particularly relevant when working with multiple
colleagues, sharing history between different servers: I may have a
branch I call "linus" that points to the same history that a colleague
called "master".

That said, I can understand how that may be difficult to get used to
coming from other version control systems (such as Subversion) in
which a revision does belong to a branch.

Can you say a little more about what aim you're trying to achieve when
you want to make this lookup?  For example:

- are you looking to figure out what the commit author was working
  on when they made the commit?  For that, the commit message is meant
  to provide context, and a commit hook like you describe can be a
  good way to enforce that (for example if you want every commit
  message to contain a bug number for context).

- are you looking to find out *when* a commit became part of a
  particular published branch?  It's true that Git doesn't provide a
  good way to do that today.  I have some hope that some best
  practices like discussed in [1][2] will coalesce for attesting to
  the history of a branch's state.

  If you always perform merges with --no-ff, then you can find some
  things out using the --first-parent history.  It is possible to
  enforce such practices using hooks, but this may be a lot of fuss
  for little gain, depending on the underlying need.

  I find "git log --ancestry-path" to be very useful for finding out
  *how* a commit became part of a particular published branch.

- or are you looking for this information for some other purpose?

Returning to your question: one reason that I find Git not recording
the current branch name to be liberating is that I am not great at
naming things.  I can use a placeholder name, knowing that I am its
only audience, without fear of embarrassment.

Thanks and hope that helps,
Jonathan

[1] https://git.eclipse.org/r/c/51128, describing refs/meta/push-certs
[2] https://lore.kernel.org/git/22945.15202.337224.529980@chiark.greenend.org.uk/
