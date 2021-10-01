Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEFC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 23:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2688D61AAB
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 23:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJAXHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhJAXHg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 19:07:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6187C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 16:05:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g7so39063525edv.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUBw5brKL9davOVcGXRwcAF7bg1gl7Ww3mccZkLHO+c=;
        b=eI4skfhfGplNpB79+OXneOUdzuk7rRchuHquJdfgabW/B0mh5IrJ/PqwFSH2IsooX9
         gTfMoF1vlXdYWwAeB9Mx4QvvwwXN0DfqcveyVaxpiV93wNWO3WFoGZIGWOzjOkkegDom
         tEKXHYWXG7FMRL9pvhWKunVgQueeyXI0k5AR14vFScUAAA/kjnVapDksYEWZnWwYKPQO
         Wj+WEJ1FMprzzJe4hzS2xSOV54vlTaFbVcHER4lFNSBvrbM8nv/z4uOg+W4Zn4/F4rNv
         /kivyMPkUDaaXXNNmO9ECLFYYnF2ZBnrIHx2uVeyDxQsdYHMzxPV7eXWpO8ayXdY+30n
         2tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUBw5brKL9davOVcGXRwcAF7bg1gl7Ww3mccZkLHO+c=;
        b=n7tFkMCXL5DJ9gdIDe/IjNzvksYO6XTzU3DTT1dtrTEqvhQCfQx2tVwG6y6tH4S+wN
         HeXJEfK8ql9EiCiNxKEOiDYF4A58zquVd5Wu7Dhp8nKPYCltuaRx29EoZLNJ+9zbcrDC
         ar+jsi6VYCp0aGpI0OGK+sSYO/FaFqbSp8gXZuyeXWeR07GGg9x1BNrisENu2+VlLNs5
         Xd2GixMGs1GDccOh6Qhqx+sd9HWvFTFvRn7TVbMHC5VXrsjnLi1/34NoBxxCdBw4amdQ
         0jvildsclmmlzIhgXhLY/ykzfartmBrcvANBKLMu6W3o8LtetE3phz4MbSSwugz01S9O
         B0Xw==
X-Gm-Message-State: AOAM530+3KcZWMYSx2z0cOsAR0V6bCcAFBFcngB17+O80dpAgJDD3CGM
        wH7tIczrbnoORPTy8po6sHC6FWGYERUD6lOw1qw=
X-Google-Smtp-Source: ABdhPJxO99WgwS87jhfH+5MDDnniAhowiqcA9c+wcwe+PPWT0IJ5I2SlYTEeHRG5xhk82miCUdGw06Muleu7gQlpTvA=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr728259ejp.520.1633129550307;
 Fri, 01 Oct 2021 16:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net> <20210929184339.GA19712@neerajsi-x1.localdomain>
 <YVVyUkwYNfkEqNfU@coredump.intra.peff.net> <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
 <xmqq7dew8yq6.fsf@gitster.g> <CABPp-BEhLQ3b8OCn3EbTa=g7uh_YXmkQuuGazn=OsT=bG3ot1w@mail.gmail.com>
 <xmqqr1d42ykj.fsf@gitster.g>
In-Reply-To: <xmqqr1d42ykj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Oct 2021 16:05:38 -0700
Message-ID: <CABPp-BG9JNeFJ_gzepntcieJAMzT1OKNes9zEOiWY3JMXh4BMg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Neeraj Singh <nksingh85@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 3:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > So with that out of the way, let's return to discussing the textconv
> > cache.  If the remerge-diff results aren't cached, isn't it unsafe to
> > allow the textconv cache to persist anything while remerge-diff is
> > running because it could create corruption?
>
> I do not think anybody involved in this thread thinks it is
> practical to annotate each write_object_file() with "this is
> temporary" vs "this is to persist", so it is a given that it would
> be all-or-none.  If we want write_object_file() called while we are
> running remerge-diff to write to a temporary object store, we have
> to accept any other write_object_file() called by somebody else,
> like textconv cache, must become temporary.

Ok, good.

But is this write_object_file() specific?  I think
pretend_object_file() has the same problem where the textconv cache
could reference a pretend_object_file() and thus write objects and/or
refs that become corrupt.  (In particular, if the userdiff fires on
any of the new files created by the three-way content merges, then I
think we hit the exact same problem)  So, I think as long as there are
any "temporary" objects being fed to diff, the textconv cache needs to
also be considered temporary.  Or am I misunderstanding something?

> It may be sufficient to plug ref updates (which would cover the
> finialization of notes-cache used by the textconv cache) to avoid
> corruption, but that might give us a pointless and unpleasant error
> message, so it may be necessary to teach the notes-cache stuff to
> allow getting existing cached data while disabling it to accept
> cache updates.

All we need to do here is set the quarantine environment, as per
Neeraj's report[1], it already handles all of this:

"""
Peff's test case was invoking ref updates via the cachetextconv
setting. That particular code silently does nothing when a ref
update is forbidden
"""

Looking at the code, this appears to happen because
ref_transaction_prepare() doesn't print an error in the quarantine
environment, but returns one.  That error is passed all the way up the
stack to notes_cache_write() and then to fill_textconv().
fill_textconv() is the first level in the stack that ignores the
return code of what it's calling, namely notes_cache_write(), which
means that things work fine.  There's even a comment a few lines
stating, "ignore errors, as we might be in a readonly repository".
So, I think we're good as long as we ensure the quarantine environment
is setup.

[1] https://lore.kernel.org/git/20210929184339.GA19712@neerajsi-x1.localdomain/
