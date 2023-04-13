Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A7BC77B71
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 17:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjDMRA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDMRA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 13:00:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D059F9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 10:00:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dm2so39197028ejc.8
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681405219; x=1683997219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCMDZxbvIwKbLwpKrDM5yDDjTbqb8MChAwzbqUrtwjw=;
        b=Zeux5IwW0Mp6ldPkHL1zPHK/xRbHeSSbiOjD5a3T5riv6OtDR/6P3Rt4Ff32tAartK
         +TKf0HrYgZIIa0ASI1yHkF28Aoe7zC9rCQQsfTDxqkXZ16avRgfGi1/mFy86oK5eD1ft
         nmQAgZrT9N3NXqpz8eLRTy6IMdbcoZHvbGrqOYXDOEGWt2t9WL8vykv4l8RdTBsUwcUb
         zlzQIxIbGDtrQDnKZFRlekCgdU4+vYd7uTNW0B/hG1qPzgRL/AcUfrS6KdpT/Jtyvwoo
         Z3Cmm+JYKhHyvaaQQI5CckTfjW//AfjBCX2Ko1AHixpEHSKTr7/QBhiW5ZzFZAkF/fbh
         yFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405219; x=1683997219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCMDZxbvIwKbLwpKrDM5yDDjTbqb8MChAwzbqUrtwjw=;
        b=RglQo02nbWCPcEOVPOehX2eM5VSJ99kNDm1eUlOb41alaFu1VuOuiJtkKXFn7PozEy
         FsT0cKw2YA5sci988snqccF0HHdlZi/BujheMtmM92BrC5waoIXSZuWgrQZA5Ti0M0Mn
         nEshH59rIeqaEI9DGBR7U50sCkkYQmP68T39eEXIyxEnEQXeCUaJ164Cm+epYpelHE6K
         rWw9IM5+eVXVxeRMK/i1/u3HIo0rYbYFNp1lhFfv41/rjNIeK+BP2hBfnQ4FNrxqeeFP
         fJiVuZjtYVFV0oyo98oFuxVU6hrTv3DoSWeV720d4p70nA32ktAOHDCtm9evnxG4yEJD
         iO1g==
X-Gm-Message-State: AAQBX9cg/oy1J2YgS0wXXz/TqWKkwJKQQXh3hIx5+1ankpLL/48Nj+GH
        +QDICTHPgO5XcMYvr3i86wfYB/8C11FJe9VMgb5qOstD8b29SFoASO+ibw==
X-Google-Smtp-Source: AKy350YAhMAO7L35u97V5UskIZtHXqSL8Of43sQzfYbGuwphlNbMcKtkQWTEYCMGkfauk/W0cT2TDCa0erDu8f+E/9Q=
X-Received: by 2002:a17:906:78e:b0:8eb:27de:447e with SMTP id
 l14-20020a170906078e00b008eb27de447emr1598188ejc.7.1681405219390; Thu, 13 Apr
 2023 10:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZnBPH6j93eRRuVKZkDix9h7S287eTMfF9dK0CvC+meMxQ@mail.gmail.com>
In-Reply-To: <CAJoAoZnBPH6j93eRRuVKZkDix9h7S287eTMfF9dK0CvC+meMxQ@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 13 Apr 2023 10:00:07 -0700
Message-ID: <CAJoAoZ=A7hPbFHw_7btD0+dFzpQOXSpVa7ss2O0zbG2S_d3rKQ@mail.gmail.com>
Subject: Re: Video conference libification eng discussion, this Thursday 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The notes from today's session follow.


 - (asynchronous) What's cooking in libification?
   - Patches we sent regarding libification
- Coccinelle conventions
https://lore.kernel.org/git/pull.1495.git.git.1681329955.gitgitgadget@gmail=
.com
   - Patches for review related to the libification effort
- cache.h cleanups
https://lore.kernel.org/git/pull.1509.v2.git.1680571348.gitgitgadget@gmail.=
com
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list at the beginning of the
meeting.)
 - Session topic: &lt;TBD>


*   Elijah: I have the next set of cache.h cleanups waiting around,
but I'm waiting for the first set to make it in, and wondering whether
I should rebase onto Calvin
    *   Calvin: you should send yours without waiting, I don't think
there will be a conflict
    *   Elijah: ok, will try to avoid strbuf and git-compat-util changes
*   Glen: Hey take a look at
https://lore.kernel.org/git/pull.1495.git.git.1681329955.gitgitgadget@gmail=
.com
    *   Elijah: I also wasn't sure how to review these, the how-to
sounds useful but I don't know any better either?
    *   Glen: If this series doesn't seem to make your life easier,
then it hasn't achieved its purpose
    *   Should this come with MyFirstSemanticPatch..?
        *   General approval =F0=9F=99=82
        *   Maybe it can come later
*   Calvin: We've been working on the idea of a "git-std-lib" internally
    *   Libification of "just strbuf" and "just hashmap" vs.
libification of "all the shared low-level stuff that depends on each
other"
    *   Removing the dependency on wrapper.h/usage.h is really tricky
    *   So instead, a standard library which is includable from git
library callers and also used throughout Git's own codebase
    *   Stuff like strbuf, string\_list, abspath, strmap, strvec,
wrapper, usage, utf8, etc etc etc all in a single library
    *   To get the proof of concept, made some cleanups to
git-compat-util, removed dependencies on repository.h, trace2.h, etc
were refactored or replaced with a stub in the unit test makefile
    *   Have something promising internally
    *   Does this seem like a good idea..? Hoping to send RFC after
OOO next week sometime
    *   Elijah: Expecting lots of people to ask what's the purpose of
the standard library, does it imply backwards compatibility, etc etc
        *   No backwards compatibility, if consumers want to accept
that churn then they can use it with no promises
        *   Emily: In fact, it's likely to start out pretty rough,
with still prints and dies and so on, so we will intend to change it a
lot afterwards
        *   Calvin: You might ask, why not do that first? Mostly, to
unblock others as quickly as possible =F0=9F=99=82 If we can make it possib=
le to
build something on top of it and prove it's usable, then that gives us
more momentum to keep polishing it
        *   Randall: Do we want to mark these apis as experimental?
            *   Emily: Yes, this and all the apis we're working on for
the foreseeable future
        *   Elijah: static? Dynamic?
            *   Calvin: static for now. I don't have a lot of
experience with Makefile
            *   Where are these makefile changes going?
            *   Emily: Early stages, we want to make a guarantee about
the ability to compile and unit test, that's likely to go into
t/Makefile
            *   Glen: Maybe later it makes sense to move things into
lib/ and stand up a lib/Makefile, but we can cross that bridge when we
come to it
            *   Randall: atexit() is used in Git, be careful with deps
on atexit() in a dynamic library please! It's not very platform
consistent
            *   Emily: Randall, can you take one of these sessions and
tell us all the stories about atexit() =F0=9F=99=82
        *   Elijah: hash.h depending on repository.h, stringmap
depending on hash.h, this is gross. But FYI I did work on something to
remove repository.h from hash.h
            *   Calvin: we ran into that problem, yeah. Very cool to
hear you have some fix, can we see it =F0=9F=99=82
            *   Elijah: mempool?
            *   Calvin: not worried about mempool
*   Elijah: Was doing some performance testing moving functions into a
new file and determining if it was helpful or not (to see if I can
replace rust stuff)
    *   Turns out there's a small performance degradation moving
something into a new file like this?
    *   We might be able to use this to increase performance in some places=
 too
    *   Calvin: do we know why?
    *   Elijah: maybe code locality..? It's a function that's being
passed to qsort, so it was being run in a very tight loop, it seems
like that difference in cache locality made a difference
    *   Jonathan: I've seen this kind of thing as an argument to be
pro-C++ because templates mean you can choose this functionality at
compile time and avoid this penalty.
    *   Elijah: I spent a lot of time on microoptimizations for the
merge code, it was difficult to parallelize it as it is (in C/++). Why
not =F0=9F=A6=80? Was an interesting experiment to look into performance
regressions. Putting the sort into rust actually gave some speedup.
Being able to optimize that sort was really helpful.
    *   Randall: Other compilers, like Intel C99, the optimizer can do
some things with comparators in the same object as the qsort
invocation to avoid that penalty.
    *   Randall: Happy to talk about C multithreading too, look over code, =
etc
*   Randall: Have been pressed into service as CVE analysis manager.
Thinking about the libification project and tests as a very good thing
for tracking down CVEs in the base code (if they lurk there). Being
able to test libraries on their own is really helpful from there,
thanks!

On Tue, Apr 11, 2023 at 11:40=E2=80=AFAM Emily Shaffer <nasamuffin@google.c=
om> wrote:
>
> Hello folks,
>
> Google is hosting a standing engineering discussion about libifying
> Git, for contributors interested in participating in or hearing about
> the progress of this effort. Expect this discussion to be free-form
> and casual - no powerpoints here!
>
> We're hoping to hold this meeting every Thursday at 9:30am Pacific
> (16:30 UTC) via Google Meet.
>
> To get an invite to the video conference and the notes document,
> please reply to this email. Please also add points to the agenda
> (template follows) if you want to raise awareness of them.
>
> We'll choose a topic to discuss at the beginning of the meeting, and
> I'll reply afterwards with the notes.
>
>  - (asynchronous) What's cooking in libification?
>    - Patches we sent regarding libification
>    - Patches for review related to the libification effort
>  - (asynchronous) What happened in the past 1-2 weeks that interested
> parties or intermittent contributors need to know?
>  - (asynchronous) Where are you stuck? What eng discussions do we want
> to have? (We'll choose a topic from this list a day ahead of the
> meeting.)
>  - Session topic: <TBD>
