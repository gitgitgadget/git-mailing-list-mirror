Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB18C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC76221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="qb5cFj0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgHFR3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgHFRAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:00:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661CC0A888D
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 07:39:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so15275906pgc.8
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEbKmXkS0WXCXcGfK4dFjSNJPM4mgcOahtuTj89X28k=;
        b=qb5cFj0ngnVUSOMKSaBiYVKgKLFpg+RJzJQKCFTuxJMcsp0R8f/itFZ+h0ArH/E9ay
         CgmgXWwtPgZFMWX34cxYcV8QnO2zX2cKDFzl3iAe6H4xoibCR4GGOkBRFJzTik/Xab0f
         NmSmVD5Cqr2Y55CJFDEo3ZHseYRIMVZnGZctEWeeHVP66IfyrIX+jQTeP155AIC8AD1F
         n7tboiX2IUEjxa9bCFRFRef0Z965AY3GvhoWamik797857fjT7OYmY33fBrF5xm1RToB
         Q1XohZWPw76UsJ6+8tgmEtqkMTT4Vb+RMOrrp9qLcvhSwZG+9nD2GbreGWSD6xpMzvAD
         XKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEbKmXkS0WXCXcGfK4dFjSNJPM4mgcOahtuTj89X28k=;
        b=DkS5lMdfUxchVN5DiMECR4PKShNxJJD5+FWv80QbC/fM2a7J3AfWipXwvoDnv0tgTv
         ruqtj79w0pKfFoKd8Jr1Hl1tdpsz+1ygz0TjehBmUNKL7ig6RaTLvM5loAaR0prOiwT8
         LK/6Ym6Qbc3r1KWkCkyv1JpuuWokBeZM/dziDBCUGn0D6D8MQEi9TMHHVAHwrzrQjtYW
         cGIPEhTX4dpXYbcxUcVYP4+NEYsSz5I0GislxRUyg5GLBvpZDBjQZY15qbrA4NgpVNQc
         BwMORfJnRlnlFAZgGWavHQ8xwpsOrH3j9wPbuld4ivd9j8a+Ej6tRixnuz8BdlsXxCEN
         oc+Q==
X-Gm-Message-State: AOAM532WgH3rLQg04liSZoAkg9irCbl4p5+MqJPapITXpVBJ7Hjd6mFm
        lUq7LoNBzj8xWuNKmHRnMJymBD1cMIi2tFOS74B7QCqeo77DmcKL
X-Google-Smtp-Source: ABdhPJzOQ6waxFoi9fgH9q3je79+0ePYyT676HR10LvsRf9oxQNZpCT35a9LCra5Y0tZV+BnRjx14zv8OWnc/WY+big=
X-Received: by 2002:a63:184a:: with SMTP id 10mr7382332pgy.446.1596724753752;
 Thu, 06 Aug 2020 07:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
 <20200806021354.GS6540@camp.crustytoothpaste.net> <CAPig+cRe2OUeHXE3XELtkS7b2GrZVxLm0pzduojDB97uLnBZKQ@mail.gmail.com>
In-Reply-To: <CAPig+cRe2OUeHXE3XELtkS7b2GrZVxLm0pzduojDB97uLnBZKQ@mail.gmail.com>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Thu, 6 Aug 2020 23:39:02 +0900
Message-ID: <CAFMepckNybt8drZ=5c3x3MvUyruB75nn0cNY34FRpu=supsFiA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Use $(SHELL_PATH) instead of sh in Makefile.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Aug 5, 2020 at 10:14 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2020-08-06 at 01:05:01, lufia via GitGitGadget wrote:
> > > In the not POSIX environment, like Plan 9, sh might not be looked up
> > > in the directories named by the $PATH.
> >
> > I think Git's editor handling assumes that sh is somewhere in the PATH,
> > so it might be fine for us to just ask the user to adjust PATH
> > appropriately before running make.  I don't have a strong preference; if
> > this works on a standard Unix machine, which it looks like it should
> > (although I haven't tested), I'm fine with it.
>
> This does, however, have a bit of a chicken-and-egg feel to it. The
> results of the "uname_FOO" assignments in config.mak.uname are
> consulted later in the file to _assign_ a value to SHELL_PATH on a
> number of platforms. So, making the "uname_FOO" assignments themselves
> depend upon SHELL_PATH is rather circular and confusing.

The problem is, Plan 9 APE's sh is placed on /bin/ape/sh by default.
By running /bin/ape/psh
APE commands existed under /bin/ape such as sh, uname, etc, will be
mounted on /bin.
In running of ape/psh, APE commands will prioritize than native commands.
So I've wanted to run /bin/ape/psh before executing some shell
commands by gmake.

----
kadota
