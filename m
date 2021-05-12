Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE886C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF4A61352
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhELAqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELAqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:46:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A606DC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:44:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso19142865otg.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6ua6/uha08KKbhxhoWIP9qS8O7jIFlE7rsC3aBZKhM=;
        b=oMyLjGIfzdWxjidv+r1U4cWyrzvY6YixNvocFxnYxHIBU6T2nlI7QkHk325FX3Xpay
         bx+9MW8TD/w14wCvN28rgykyqDkP1q01m0oOBqtrkiBw14HcuaICCmzS7F15RmI72kvN
         ai6D276PstoEWqxljcqLYwFRmXy3MF8O5NAn59gUiJiPjtlj9O7QFxKI6jZr2SdkwDA5
         MEkr6+ub9DFepa1kbqVVo0N/p4990G//COQKWGzfWVeYJCJ8ksfnNv3fqtFsyBQgKL8u
         69lWFuc6Xcqvl4zy+nTqYx/P7NnLBAvMl+c7/KyjBw6NS4FEgOApoFaCV+HkM3dFMG7d
         j33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6ua6/uha08KKbhxhoWIP9qS8O7jIFlE7rsC3aBZKhM=;
        b=E1hHcsEGFjpPXXAhNdGPf4DtM+bBOfQlLhSE4vZiKGEEzCgEACOSTvBcvdRLXIbTx6
         on7X+ZesPttgru4vmbb74qmy/QBdkllRTecRDsJsxrY2D4vlY/pbTg9dWEO8/E9g2+nr
         Y1FWjjCAZN+HIjJ9s7V0im1no6yIUG7QCU8qiAJvVndGirkDZytEwnJ54Ui8autwXTMJ
         RGq5RllnRoC+oPevBNhRfaVEsBMgcP5onS4DMjk3iJfzJvIKfz6WOrU8cRlb7P6+yyDy
         EYFbgwcxNthmYCCXECm/d8g7zUKz1mC9TCCb8gPnyEqucqcTARxvzrel5+IncYY7OQDu
         Hebg==
X-Gm-Message-State: AOAM531pqPYxNYJMnAWGH1d5hWPbFukkpVljivSZyzzrP2sCMHLKKXbz
        xDEpQtWyyQZRCnMTPCQfXdPt1sAa5QW3SIgcisQ=
X-Google-Smtp-Source: ABdhPJw4QOTCPrxcltPqi8/RLgP6UPR5N6XpE7yelbomm9evVL23B9ETItki1tx6NTtSECaJ6i+9bkSsvfMmO9ifSKY=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr21203396otj.345.1620780293983;
 Tue, 11 May 2021 17:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
 <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com> <9204e36b7e9035c4cdda018d7ced8e8ca7acc8bc.1620758049.git.gitgitgadget@gmail.com>
 <df3695ad-5ba7-df22-2a2a-ca799c5d16d8@jeffhostetler.com> <CABPp-BGeOUOvYRD+gX4jVR0kN8O5_icKtT18F9BdeR424DjUmg@mail.gmail.com>
 <a01ffeaf-31de-fdf5-3992-bea40feb1213@jeffhostetler.com>
In-Reply-To: <a01ffeaf-31de-fdf5-3992-bea40feb1213@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 17:44:42 -0700
Message-ID: <CABPp-BF9ptJio+NSi-i-sQJqjsOiKfFxzVHQ=RTPQkV9hjPrMQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dir: convert trace calls to trace2 equivalents
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 4:12 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 5/11/21 4:12 PM, Elijah Newren wrote:
> > On Tue, May 11, 2021 at 12:06 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> >>
> >> On 5/11/21 2:34 PM, Elijah Newren via GitGitGadget wrote:
> >>> From: Elijah Newren <newren@gmail.com>
> >>>
> >>> Signed-off-by: Elijah Newren <newren@gmail.com>
> >>> ---
> >>>    dir.c                             |  43 +++++--
> >>>    t/t7063-status-untracked-cache.sh | 205 ++++++++++++++++++------------
> >>>    t/t7519-status-fsmonitor.sh       |   8 +-
> >>>    3 files changed, 155 insertions(+), 101 deletions(-)
> >>>
> >>> diff --git a/dir.c b/dir.c
> >>> index 3474e67e8f3c..122fcbffdf89 100644
> >>> --- a/dir.c
> >>> +++ b/dir.c
> >>> @@ -2760,15 +2760,34 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >>>        return root;
> >>>    }
> >>>
> >>> +static void trace2_read_directory_statistics(struct dir_struct *dir,
> >>> +                                          struct repository *repo,
> >>> +                                          const char *path)
> >>> +{
> >>> +     if (!dir->untracked)
> >>> +             return;
> >>> +     trace2_data_string("read_directory", repo, "path", path);
> >>
> >> I'm probably just nit-picking here, but should this look more like:
> >
> > nit-picking and questions are totally fine.  :-)  Thanks for reviewing.
> >
> >>
> >>          if (path && *path)
> >>                  trace2_data_string(...)
> >
> > path is always non-NULL (it'd be an error to call read_directory()
> > with a NULL path).  So the first part of the check isn't meaningful
> > for this particular code.  The second half is interesting.  Do we want
> > to omit the path when it happens to be the toplevel directory (the
> > case where !*path)?  The original trace_performance_leave() calls
> > certainly didn't, and I was just trying to provide the same info they
> > do, as you suggested.  I guess people could determine the path by
> > knowing that the code doesn't print it when it's empty, but do we want
> > trace2 users to need to read the code to figure out statistics and
> > info?
>
> that's fine.  it might be easier to just always print it (even if
> blank) so that post-processors know that rather than have to assume
> it.
>
> >
> >>          if (!dir->untracked)
> >>                  return;
> >>
> >> Then when you add the visitied fields in the next commit,
> >> you'll have the path with them (when present).
> >
> > There is always a path with them, it's just that the empty string
> > denotes the toplevel directory.
> >
> >> (and it would let you optionally avoid the tmp strbuf in
> >> the caller.)
> >
> > The path in read_directory() is not necessarily NUL-delimited, so
> > attempting to use it as-is, or even with your checks, would cause us
> > to possibly print garbage and do out-of-bounds reads.  We need the tmp
> > strbuf.
> >
>
> I just meant, "if (!len) pass NULL, else build and pass tmp.buf".

Ah, gotcha, that's why you were checking non-NULL.

However, what about the other case when len is nonzero.  Let's say
that len = 8 and path points at
"filename*%&#)aWholeBunchOfTotalGarbageAfterTheRealFilenameThatShouldNotBeReadOrIncluded\0\0\0\0\0\0\0\0\0\0"
?

How do you make it print "filename" and only "filename" without the
other stuff without using the tmp strbuf?
