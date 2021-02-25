Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698DDC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 04:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279D564EC8
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 04:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhBYEr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 23:47:57 -0500
Received: from mimir.eigenstate.org ([206.124.132.107]:43590 "EHLO
        mimir.eigenstate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhBYEro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 23:47:44 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2021 23:47:44 EST
Received: from oneeye (pool-108-41-92-79.nycmny.fios.verizon.net [108.41.92.79])
        by mimir.eigenstate.org (OpenSMTPD) with ESMTPSA id 77f4bc9d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 24 Feb 2021 20:40:09 -0800 (PST)
Date:   Wed, 24 Feb 2021 20:40:07 -0800
From:   Ori Bernstein <ori@eigenstate.org>
To:     Stef Bon <stefbon@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: FUSE fs for git.
Message-Id: <20210224204007.4937ee80121aa1ed553a2d91@eigenstate.org>
In-Reply-To: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
References: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.1)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 21 Feb 2021 11:12:19 +0100, Stef Bon <stefbon@gmail.com> wrote:
<snip>
> Now I'm looking it's possible and usefull to add a git fuse fs. The
> thing I ask is:
> 
> - is there an api I can use (lowlevel and/or highlevel or whatever is
> available)?

Not provided as part of git, as far as I'm aware,
but there are other options.

You can probably look at what cgit does to abuse
git internals as an API:

	https://git.zx2c4.com/cgit/tree/cgit.h

It may also make sense to lift code from game
of trees:

	http://gameoftrees.org/

There's also libgit2:

	https://libgit2.org/

> - is it usefull, in other words is there a serious benefit of a git
> filesystem: does it add something?

That seems like a question you'd have to ask yourself.
What would you do with it?

For me: I've got a 9p based git file system as part of
my implementation of git[1].  It's convenient for scripts
on top of git, avoiding scratch files or pipeline wrangling.
But on Unix, git already has much of that implemented.

I also tend to open files from old commits or other branches
to peek at how some code evolved.

[1] http://shithub.us/ori/git9/HEAD/info.html

-- 
    Ori Bernstein
