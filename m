Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9CA1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 19:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGYT6s (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 15:58:48 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36012 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYT6s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 15:58:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id v20so20371533uao.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSHvxuIOoOjK+U5Ero3o4vv2f+IrLJTyWsr6T0/rQDk=;
        b=WsKygdzg4fj1hxKKguA37DXPiByE6lkBpte6l6TKG8ouCX0KKvjmY98JgF1c+E/EXd
         bIHCjGmKZiCVFX1afeqMm1Nznn41p7IDos7w9jz625gPrFwmGzQtPqsJ8VxRfIHxCiwj
         rmH2SlmmAqyZtCTXUaaS+P2h+IyJ1EdPQNEAvIT9oEBgkDhwXdMkUu6o/1ur/mwf3IF6
         806wUQTL8GZPd8er6x8WeNYtjza7WiAHvMMnX5GelwqRHntsZW0eFFih8hW9P8+leCiC
         F83vwsEbee6Jdt3dTsbXSVtDfFJJI8bLQPfW4AH+crHCID4agtXyeye8/0P0yfPZPMtU
         z6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSHvxuIOoOjK+U5Ero3o4vv2f+IrLJTyWsr6T0/rQDk=;
        b=jyfdZBvaWMo0iRNTyMQBjgmpTzz0q/pNv8N4stqf+4srtiikcKemNc4fLeCg63l5vT
         4XTQM0Ucc5r2uqkLbeYvYaXhYx7KRzqp7OXvXrA19aPwvvwSQx9XZ3gsESv3nNhYdRYZ
         a3bpUiOz2Yt2EUV/TcxRo1e4gpAEYyL8s3AWUXGHPoe+CC4odpCRpQ3mDUcPuVRaqbI8
         8Dat0oEZYeSRMTTkbv+GW8rk7ysMGRSwm0+vk7FBL2CV7lKbtQi1nGzNZJoenvGJz/17
         gvPQcJcQEjYREKQloX31KtcrsiGZRCCnVrFIkJQLtHkWE+J+SU6TDp7hRaQmUUnpncqx
         Cvnw==
X-Gm-Message-State: APjAAAWthe0XwGnU4uXrogqD79LRSOBAvw4SB8EjDKZyQseqP6HHvu6u
        jKd/jJBUdU23VQYi1QcdjgmaGlhHNO3DMPv+6LJNcw==
X-Google-Smtp-Source: APXvYqxuvACjdhqkJMTupkRs4FCSJxLoKalvtLH9lG1f3h17fjgiaDDMhwAUBC4JuIQcSD/OpRtPSkqT9ij8yOlaECo=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr8805729uam.81.1564084727002;
 Thu, 25 Jul 2019 12:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-4-newren@gmail.com>
 <nycvar.QRO.7.76.6.1907252120300.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907252120300.21907@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Jul 2019 12:58:35 -0700
Message-ID: <CABPp-BHahUojy1+cBrOTCvg-w3n-xJp3yE3Br6v8jMwnMzQwCQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] Ensure index matches head before invoking merge
 machinery, round N
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jul 25, 2019 at 12:41 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 25 Jul 2019, Elijah Newren wrote:
>
<snip>
> > ...And it was fixed again in commit
> >   160252f81626 ("git-merge-ours: make sure our index matches HEAD", 2005-11-03)
> > ...and it was fixed again in commit
> >   3ec62ad9ffba ("merge-octopus: abort if index does not match HEAD", 2016-04-09)
> > ...and again in commit
> >   65170c07d466 ("merge-recursive: avoid incorporating uncommitted changes in a merge", 2017-12-21)
> > ...and again in commit
> >   eddd1a411d93 ("merge-recursive: enforce rule that index matches head before merging", 2018-06-30)
> >
> > ...with multiple testcases added to the testsuite that could be
> > enumerated in even more commits.
> >
> > Then, finally, in a patch in the same series as the last fix above, the
> > documentation about this requirement was fixed in commit 55f39cf7551b
> > ("merge: fix misleading pre-merge check documentation", 2018-06-30), and
> > we all lived happily ever after...
> >
> > </quick summary>
>
> Whoa. What a story.

I know, right?

> > diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> > index 5b910e351e..a4bfd8fc51 100644
> > --- a/builtin/merge-recursive.c
> > +++ b/builtin/merge-recursive.c
> > @@ -1,3 +1,4 @@
> > +#include "cache.h"
> >  #include "builtin.h"
> >  #include "commit.h"
> >  #include "tag.h"
> > @@ -63,6 +64,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
> >       if (argc - i != 3) /* "--" "<head>" "<remote>" */
> >               die(_("not handling anything other than two heads merge."));
> >
> > +     if (repo_read_index_unmerged(the_repository))
> > +             die_resolve_conflict("merge");
>
> For a moment I was unsure whether `_unmerged()` is the right thing to do
> here, as it specifically allows to read the index even when there are
> conflict stages. But I guess it does not matter too much here. I
> probably would have opted for `repo_read_index()` instead, though.

The names repo_read_index() and repo_read_index_unmerged() actually
seem slightly misleading to me; they seem to do the opposite of what
you'd think they do.

repo_read_index() reads in an index and allows unmerged entries and
returns istate->cache_nr.

repo_read_index_unmerged() calls repo_read_index(), then checks to see
if any of the entries are unmerged and returns whether or not any
unmerged entries were found.

So, the way to disallow conflict stages isn't to use
repo_read_index(), but to use repo_read_index_unmerged(), as I did.
Counter-intuitive, I know.

<snip>

> But of course, if there are uncommitted changes, this would write a tree
> different from HEAD, then reset the index to match HEAD, so indeed, this
> discard/read dance is necessary.
>
> So this hunk is good.
>
<snip>
>
> This is obviously a good change: it strengthens the test case by fixing
> a subtle bug.
>
> Thanks,
> Dscho


Thanks for taking a look!
