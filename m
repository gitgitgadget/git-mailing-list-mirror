Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CA5C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A986020705
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHs6YOoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgC0LVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:21:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39653 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgC0LVD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 07:21:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so1754132lfp.6
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltT4AUNiJIeoElS6lick3yw8rrZcLr2fqBx63OkakQI=;
        b=QHs6YOoEMAKLsWzeeD1iDlIuV8GDD1gUX3lKrduZ6kP23fhfoQJnukDGRTlCiBd5IK
         ZntF7CWb7yHj0KnodR7VzWOw3iKJsPJX4F069PLefDkqnU80+EKqLHFLRRLJWS22IQ+j
         lGybzDDp2cJrYaIBvnqVt48Lo/o/RvXEYF3GVnQM5D20v6Kd+/tKIPGzt0G5h8YMkYxr
         DAa5d1tIG1YOMRaGfImrQkVE3gNUQ9TGHB90NwCMMe/sndvPuHDEm8wkx+P3TEjs4URR
         0lKKQzEw42su+bhXaArOQ1hiJQSPRbxwwrhIVv6bxlsPZnB1pFWOs/51NADyOfQaTKq7
         BbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltT4AUNiJIeoElS6lick3yw8rrZcLr2fqBx63OkakQI=;
        b=aRSmHKfgU/vMmGzJm6ERHC4pxes/dvSSlsSQSat7/u9KV7HjxwUNZWoLGaGSBKv+RX
         Ii8+oyyaWU3iNYBkscmoh5adUmWTqnr4WVF6zMrRddekf2cMCmyAqxZszJCVqUGN9FqU
         y/bpI/SSd+Og47IATvXAxJR4Atlh3VzMQfHxR/L1xotU33VuFsNrKjvuz1/r63yVuYoB
         L8f4hBx+NUV290/InqmSyWGeneq2xO2dMmVs6xqywaUfNmTVJdSBJ+alcO+QNeoYRn7h
         MG0d2kqRh5xg60eK4Me7MJYxZ+uxLOHiOjkeQocO4+WgajZYV1ja3aj2mfLOp7XFaiYn
         T17A==
X-Gm-Message-State: ANhLgQ2LB1JHenqPiQFAN3hS4+grkHlIg2NzfUKgkM7Y8wIDzSIu/O2Z
        dWCvsFG65HImGJcV/3wDvicGxvkSMiYvGttitHM=
X-Google-Smtp-Source: ADFU+vsrKbyWCZI4ifkcnuxaYL9Vw/2fzINg45h3ywluwr8WaQztl66nIy0YC78hMJ6z6IzF12gxMRbkDlUSEgxDv6k=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr8730001lfg.98.1585308060126;
 Fri, 27 Mar 2020 04:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <gitgitgadget/git/pull/539@github.com> <gitgitgadget/git/pull/539/c603037045@github.com>
In-Reply-To: <gitgitgadget/git/pull/539/c603037045@github.com>
From:   Han-Wen Nienhuys <hanwenn@gmail.com>
Date:   Fri, 27 Mar 2020 12:20:48 +0100
Message-ID: <CAOw_e7Z_uE5sf+n6hc2siKeQbUqwK=YS3an7Aq_MghbgzeiRLg@mail.gmail.com>
Subject: Re: [gitgitgadget/git] Reftable support git-core (#539)
To:     "gitgitgadget/git" 
        <reply+AAAHWO3G6HXTWTY36TPJHTV4QWCS7EVBNHHCCCWDZI@reply.github.com>,
        git@vger.kernel.org, jrn@google.com
Cc:     "gitgitgadget/git" <git@noreply.github.com>,
        Mention <mention@noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 7:09 AM gitgitgadget[bot]
<notifications@github.com> wrote:
> Contribution format
> ~~~~~~~~~~~~~~~~~~~
> This is a bit of an unusual contribution to Git:
>
> - the heart of the series is in a single commit
> - it is under a different license than most of Git
> - the code doesn't use the same dialect as and "look like" the rest of
>   Git
>
> All three of these are because the code is meant to be a standalone
> library that can be used by Git, libgit2, and any other project that
> wants to understand reftables.  But they create obstacles to reviewing
> (one reviewer said he had spent a two-hour block looking at the patch
> and not made much headway).
>
> On the other hand, people mostly agreed that having the ability to
> share this code with libgit2 is beneficial.  So how can we get a
> substantial review without losing that benefit?
>
>  1. Most importantly, people would like a series of multiple patches
>     that tell a story.  If review of an early patch in the series
>     reveals significant changes that should happen in reftable
>     upstream, that's fine --- upstream, that can happen in a patch on
>     top, whereas in the series being contributed, the patch would be
>     amended.
>
>     In the end, there would be two different series of commits: the
>     contributed series, and the upstream history.  The upstream
>     history might be messier, and that's fine.  The contributed series
>     would be applied to git.git.

This not very practical. I currently sync the reftable library into
git by means of the reftable/update.sh script,
and creating a layered commits is a lot of busywork.  Also, getting
the entire code in one go lets reviewers see how the whole thing fits
together.

I do understand the complaint, though. The good news is that there
already is a story in the source code; you just have to read it in the
right order. That order is (bottom-up):

* record.{c,h} - (de)serialized single records
* block.{c,h} - read and write blocks
* writer.c - write a reftable
* reader.c - read a reftable
* merged.{c,h}, pq.{c,h} - reading a stack of reftables
* stack.{c,h} - writing and compacting stacks of reftable on the filesystem.

before anyone attempts to review the code, they should read the
specification of the format very carefully.

>  2. Both Git and libgit2 have abstractions like strbuf.  We'd like
>     reftable to make use of similar abstractions where they make the
>     code cleaner.

Have you looked at slice.{c,h} ? Is there any specific code that
anyone had an issue with?

>  3. libgit2 has a git_malloc allocator.  reftable doesn't necessarily
>     have to use it or make it pluggable --- at worst, we can #define
>     malloc to use it.  But it's something to be aware of.

I added pluggable malloc routines.

> Maintenance
> ~~~~~~~~~~~
> There's some interest in the maintenance story: if we run into an
> issue with the reftable library, do we report and fix it on the git
> mailing list or does the reftable library have its own upstream forums
> for that?

There is no specific forum. The most practical solution would be
report to the git mailing list with cc to hanwen@google.com.

Alternatively, an issue on the github project would also work.

I don't foresee much need for maintenance, though. (Or do you foresee
a need to store more types of data besides refs and reflogs?)

> Portability
> ~~~~~~~~~~~
> There was some confusion about the scope of what the reftable library
> provides.  It provides a reader and a writer and the caller is
> responsible for connecting those to files.

No, it also does transactional updates to a stack of reftables on the
filesystem.

> There were some questions about mmap usage here (there is none) and

The format is suitable for mmap, but it seems premature optimization,
given the (lack of) efficiency of loose+packed refs storage that it
indends to replace.

> whether the library needs some kind of seeking reader interface for
> abstracting the OS interface to files.

Look at reftable_block_source in reftable.h

> I think the upshot is
>
>  4. Some summary documentation would be helpful e.g. in the README.md,
>     to point people to what header file a person should start with to
>     understand the library

reftable.h is a good start, as it declares the public interface, and
is extensively documented. It also addresses many of the points that
this email raised.

>  5. People are also interested in the file-oriented part of reftable,
>     even though this library doesn't implement it (that's patch 6,
>     which is Git-specific).

No, this is incorrect.

> Testing
> ~~~~~~~
> Git's testsuite has various GIT_TEST_* knobs.  A GIT_TEST_REF_BACKEND
> knob would be helpful, to allow running the full testsuite with
> reftable.  That's a good way to suss out edge cases.

I agree, but this outside my personal area of expertise. I think this
is best tackled by someone else.

> The testsuite should *also* include some specific tests designed for
> reftable.  They can demonstrate edge cases and demonstrate some of the
> benefits

There are unittests in the upstream project. Edge cases in the library
itself should be covered by unittests. Is there interest in adding
these to the git project itself?

I can add some Git tests for directory/file conflicts and case sensitivity.

> We also discussed table-driven tests that can be shared between
> implementations but didn't end up saying anything too concrete about
> that.

My plan is to add a cross-language tests, that passes data between
JGit, Go and C implementations to verify that they interoperate.


--
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
