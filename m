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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32381C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E8964F38
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhCQS25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhCQS2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:28:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A827DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:28:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y7so3411814oih.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=naG7lGTdOhfhcVh+PeOeG0+P76wYrRzie11njKYkPV4=;
        b=OJcPlC+6o8VAFODWbJpIjp8wJMO4+LPzrW97cfJByo6HpugNtv3lZKyk/emYROaUvq
         aWu5P46rc0bQAuq140VCxjFAfuoBzq6+ZFtPKu8kkKbwlJHeZTP79pr8PRuSYfPGK7e6
         oAsfUr4S6qAOgUUe2U4rmtw65kDg6R397OaORU5yidTkKFzq9EKOJmnutKC0NO63QPII
         HUNUGXWKApmiRbDNnyqNyYztTkErMyCrS3MbLtQ6AfJ041/0GuVQsLpT5UoqwtAyDiAb
         dG4CtLGsQzXMoNUAoyKCEx+T7Tlbb3EJFJO0Igh5Ke/OB8aVobZwogf2GU6W/xfyD0Rm
         TynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=naG7lGTdOhfhcVh+PeOeG0+P76wYrRzie11njKYkPV4=;
        b=h27N9zFtJk882o/jMFVlcsetEIreuH4QS2HX8IDfPlvVD4/njrX1tle0mzWtLIbl3E
         PfGFGcVbGxbIuETuBoWQRsEKpNoft9yciP9iZ0ZPiAudA+2hD0HiGu7bJgZqY/PqyTwa
         WF/vKFciOZfSIW8K/NA+sKFkpcvfiLx/okIRhLEPTuA/LVmzY38+5HbXDByM0Ihocppp
         H5ed+Z/oqV6KvTPiOwjj6qMhUhm/z/4n86j10dH/+gjFsH1FsHhnisKezGKWbSDZUtGu
         I1qGw3p3Ol8s6+rG5zUF1Sakk9N6UB5O1QY6qpx+elzMPmrSUVY1gtXW/rxM9LsGdvnf
         zEYg==
X-Gm-Message-State: AOAM532h68UveJifHXa8VyqhoFwV94wR2TiAqUHT5N9Q8yoo6fWJHkYB
        9P4hhyvIqQQkD0jihxdhX72+ImpMCxg5BhaZU9I=
X-Google-Smtp-Source: ABdhPJxr5p6svDLg4q864SnunZFsMfDaVsTlrRFE8Va6Nis4c7kAiWMY8ePyz5DeYsr4ODi/l0TACbWWkAJ5VbflWyI=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr67137oij.167.1616005729851;
 Wed, 17 Mar 2021 11:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-1-avarab@gmail.com>
In-Reply-To: <20210317132814.30175-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 11:28:38 -0700
Message-ID: <CABPp-BGS7BxbxiPvk7zoO1XdbZSkpyrfYLuyiNnR+d6orPn+rw@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] Re: [PATCH v3 07/20] test-read-cache: print cache
 entries with --table
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > This table is helpful for discovering data in the index to ensure it is
> > being written correctly, especially as we build and test the
> > sparse-index. This table includes an output format similar to 'git
> > ls-tree', but should not be compared to that directly. The biggest
> > reasons are that 'git ls-tree' includes a tree entry for every
> > subdirectory, even those that would not appear as a sparse directory in
> > a sparse-index. Further, 'git ls-tree' does not use a trailing director=
y
> > separator for its tree rows.
> >
> > This does not print the stat() information for the blobs. That could be
> > added in a future change with another option. The tests that are added
> > in the next few changes care only about the object types and IDs.
> >
> > To make the option parsing slightly more robust, wrap the string
> > comparisons in a loop adapted from test-dir-iterator.c.
> >
> > Care must be taken with the final check for the 'cnt' variable. We
> > continue the expectation that the numerical value is the final argument=
.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  t/helper/test-read-cache.c | 55 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 45 insertions(+), 10 deletions(-)
> >
> > diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> > index 244977a29bdf..6cfd8f2de71c 100644
> > --- a/t/helper/test-read-cache.c
> > +++ b/t/helper/test-read-cache.c
> > @@ -1,36 +1,71 @@
> >  #include "test-tool.h"
> >  #include "cache.h"
> >  #include "config.h"
> > +#include "blob.h"
> > +#include "commit.h"
> > +#include "tree.h"
> > +
> > +static void print_cache_entry(struct cache_entry *ce)
> > +{
> > +     const char *type;
> > +     printf("%06o ", ce->ce_mode & 0177777);
> > +
> > +     if (S_ISSPARSEDIR(ce->ce_mode))
> > +             type =3D tree_type;
> > +     else if (S_ISGITLINK(ce->ce_mode))
> > +             type =3D commit_type;
> > +     else
> > +             type =3D blob_type;
> > +
> > +     printf("%s %s\t%s\n",
> > +            type,
> > +            oid_to_hex(&ce->oid),
> > +            ce->name);
> > +}
> > +
>
> So we have a test tool that's mostly ls-files but mocks the output
> ls-tree would emit, won't these tests eventually care about what stage
> things are in?
>
> What follows is an RFC series on top that's the result of me wondering
> why if we're adding new index constructs we aren't updating our
> plumbing to emit that data, can we just add this to ls-files and drop
> this test helper?
>
> Turns out: Yes we can.

I like the idea of having ls-files be usable to show the entries that
are in the index; that seems great to me.  I very much dislike the
--sparse flag to ls-files, as noted on that commit.

Also, as a minor point, the first two patches seemed a bit confusing
to me.  The first commit said that it was there solely to make "the
next commit" easier, and the second was worded as just making the next
patch easier, which made me wonder if the wording in the first commit
message was referring to 3/5 when it said "the next commit".  Both of
the first two commits were so tiny that if they are both prep for 3/5,
maybe it makes sense to combine them (together or both to 3/5)?  If
not, maybe the commit messages could be cleaned up or clarified a bit?

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
>   ls-files: defer read_index() after parse_options() etc.
>   ls-files: make "mode" in show_ce() loop a variable
>   ls-files: add and use a new --sparse option
>   test-tool read-cache: --table is redundant to ls-files
>   test-tool: split up test-tool read-cache
>
>  Documentation/git-ls-files.txt           |  4 ++
>  Makefile                                 |  3 +-
>  builtin/ls-files.c                       | 29 +++++++--
>  t/helper/test-read-cache-again.c         | 31 +++++++++
>  t/helper/test-read-cache-perf.c          | 21 ++++++
>  t/helper/test-read-cache.c               | 82 ------------------------
>  t/helper/test-tool.c                     |  3 +-
>  t/helper/test-tool.h                     |  3 +-
>  t/perf/p0002-read-cache.sh               |  2 +-
>  t/t1091-sparse-checkout-builtin.sh       |  9 +--
>  t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++------
>  t/t7519-status-fsmonitor.sh              |  2 +-
>  12 files changed, 131 insertions(+), 115 deletions(-)
>  create mode 100644 t/helper/test-read-cache-again.c
>  create mode 100644 t/helper/test-read-cache-perf.c
>  delete mode 100644 t/helper/test-read-cache.c
>
> --
> 2.31.0.260.g719c683c1d
