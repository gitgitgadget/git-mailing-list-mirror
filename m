Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE0C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjERRgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjERRgA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 13:36:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B24AA
        for <git@vger.kernel.org>; Thu, 18 May 2023 10:35:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso513a12.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684431357; x=1687023357;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZOV4F25+Vprh1mC9oZxW93Uz7bdkELpihYnlg854aU=;
        b=OL5UWkJ1wgaZH/zEaMUFwWHyhBQGywcewS9HCep298vr1+oy7QOO82dgjf1VMOt7Gx
         88RVoUL8STLTM9UqLyWeX5cJSnpgeRmHlh6yq+vuuaTxKPLQFniuGa+cpDY6VqO+i1vx
         3vMyHlkZ8nj3Tvs+2ocdEs0cQytHA5tCSjz8Fc7ggW3BP6NM+7uymsEfJKRMNtZD4eiM
         ULCi0IC8oHb0nSAGeoygJx2GN0BDtkAc/s0FL9+ZM4NJAbdHiny36Wd2uNslc2CnDSnx
         GmbagRw24y6Y1SF/fbgbz/sP0HYVuTEoBJjtc8bsdpunAfZVdFPNQI+JdcoS5mCPaLXy
         xDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431357; x=1687023357;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZOV4F25+Vprh1mC9oZxW93Uz7bdkELpihYnlg854aU=;
        b=bBmAxnWI+dqR9xh14EwFfOQzNjBF82htTOOh48mEtKlG3OEpwuT9ZNwCVjDnLDqU1w
         PU+alSYeSBQTUrB1mjId/Mjo8oCRkw0zXEP4agWOFQSoYwjyuBVOrjL0Q9Z1rKvjbkwQ
         72JdapxebRd/yRRPpn775e8vAxg4aycNEC1M+IAIa6u1a4JK66iV/9iai9Q0k8+48M6A
         44LWNdKXoU2f5I612maKK7oFNWjlo90g8N2nbaI8RjGyeZG080XXcAADQa0Uzoc4gvcC
         vC5aceP5xEVngzviNKiYuQ0CAVkgunoGV5TVW5MDNV0iZwWof+D9Di6GTnYfDtED6qka
         Aisw==
X-Gm-Message-State: AC+VfDzNT+VF26qZDacQ14ref28uXZWuZn/JpmH2VrMbHl2UHpUZs7hF
        NVbd6Fmyfz2YBUE+x5pyyMv14dzO/grkRsgREoqmX8JQzNtRQSsy7Z03VMJ6
X-Google-Smtp-Source: ACHHUZ4M0/E6GruEpCl3lyvPEFE5hQ8uqWx4YVe7OeLxiwbrr5eHHSFk/N+5C4q0yE1b6yAV3yrGjdNOTVg+YXuDv9g=
X-Received: by 2002:a50:c35d:0:b0:506:b280:4993 with SMTP id
 q29-20020a50c35d000000b00506b2804993mr2849edb.2.1684431356523; Thu, 18 May
 2023 10:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZk9m-yjOGa34pnc4-6vf5BBV=nMCN-QdFW-YV+jYruVUQ@mail.gmail.com>
In-Reply-To: <CAJoAoZk9m-yjOGa34pnc4-6vf5BBV=nMCN-QdFW-YV+jYruVUQ@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 18 May 2023 10:35:43 -0700
Message-ID: <CAJoAoZk2nv5KLE14LRA7Jzvei0yYOVAKNitHaQh+gR3dKHM7zg@mail.gmail.com>
Subject: Re: Video conference libification eng discussion, today at 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since I've been not very good at posting notes in a timely manner, I
added the comment-only link to the Google Doc to the event on
tinyurl.com/gitcal.

Here are the notes from today:

*   (asynchronous) What's cooking in libification?
    *   Patches we sent regarding libification
        *   Git-compat-util cleanup
https://lore.kernel.org/git/20230516170932.1358685-1-calvinwan@google.com/
            *   Emily will look tomorrow
        *   C TAP Harness v2
https://lore.kernel.org/git/20230517-unit-tests-v2-v2-0-21b5b60f4b32@google=
.com/
    *   Patches for review related to the libification effort
*   (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list at the beginning of
the meeting.)
*   Session topic: &lt;TBD>
*   Glen: C++ compatibility - maybe better to revisit with more folks later
    *   Trying to include these C libs from C++ code. Banned.h becomes
tricky; the C++ will have to #include some C headers we want, which
include C libraries we want. A lot of the Git C headers aren't C++
compatible (inline functions defined in header). What about
header-only libraries which aren't C++ compatible
    *   Emily: do we have any specific examples of problematic header-only =
libs?
    *   Glen: I need to grab some specific examples, but khash and
hash both seem to have problems
    *   Emily: at least for banned.h we can make sure to include it
from the source only, not the headers
    *   Junio: what kind of problem is it? Does just 'extern c' fix it?
    *   Glen: It fixes some of it, but e.g. implicit cast to/from
void\* doesn't work even after extern c. We do that kind of assignment
in macros a lot
    *   Junio: is it possible to update the macros and make them C++ friend=
ly?
    *   Glen: Yeah, we can, adding the explicit cast is OK for example.
    *   Junio: Might be worth the effort
    *   Emily: it's noise as far as Git is concerned, so do we really
care? Will the patches be reasonable to accept?
    *   Junio: for explicit goal of libification you kind of need to
be prepared to be built from other languages though
    *   Junio: could be acceptable, we had a similar effort some years
ago with a name collision between cpp/c
    *   Glen: if we have prior art where git is included from c++
codebase, then it might be useful
    *   Emily: can we refuse to expose some types to the public (e.g.
if khash doesn't work in c++ at all, then we can refuse to use khash
on a library interface?)
    *   Jonathan: that makes it easier to consume for other languages
because header-only macro libraries are really difficult to write
bindings for - e.g. khash writes the types as well as functions on the
fly, that makes it very difficult to bind to
    *   Emily: is there a performance hit for moving inlined functions
into the source instead of the header?
    *   Calvin: the compiler inlines some other stuff sometimes too,
so your inline function getting moved into the relevant .c might get
inlined anyway=E2=80=A6.
    *   Emily: maybe we just try it and see with godbolt or post-preprocess=
or
    *   Calvin: header-only files are a problem because we can't
libify them, because there's no .c to turn into .o/a/so, right? Can we
just shove it into something more generalized like khash-wrapper.[ch]
    *   Emily: because khash does code generation, not really.
    *   Glen: we could use an intermediate header to declare the
functions which would be generated, we can use that to hide khash for
a specific "template" type. If we really need to expose a
post-generated khash at an API we can do this
    *   It might be difficult to not ever expose khash, because the
headers might want it?
    *   Emily: &lt;contrived example about khash.h, config.h, config-public=
.h>
    *   Junio: packed-bitmap code uses khash, if we look for
identifies starting with kh\_\*, these are exposed, there are some
places where we can change the function definition, but the return
types are using kh\_iter, which is tricky to avoid exposing. Should we
hide it? Wrap it? Use it as is? Maybe we'll end up hiding some stuff
that was generated and exposing some other stuff that's basically
constant? Not sure
    *   Emily: for packed-bitmap for example, do we already know
consistently which type khash will use to generate stuff? Is it easy
to convert here to post-generated code instead of template/macro
generation stuff?
    *   Glen: The generation stuff happens when you invoke the C
macro, so when you already typed KHASH\_INIT(...), you only have so
many types that are used.
    *   Junio: if you grep kh\_.\* in the .h files, there aren't that
many places using it. Oidset exposes khash types, etc. Might be
tedious to wrap them but shouldn't be difficult, if we need it for
external libraries to call without being aware that those functions
are khash based.
    *   Jonathan: if they're just pointers, we can probably just
forward decl the generated shape. Elijah sent some code that does
something like this already.
    *   Elijah: if you look for KHASH\_INIT functions, we instantiate
6 of these throughout the codebase - one's specific for fsmonitor and
one specific to delta islands, and then the rest are used in a few
places for oidset, oidpathmap, etc. It's not that many places

On Thu, May 18, 2023 at 8:56=E2=80=AFAM Emily Shaffer <nasamuffin@google.co=
m> wrote:
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
> - (asynchronous) What's cooking in libification?
>   - Patches we sent regarding libification
>   - Patches for review related to the libification effort
> - (asynchronous) What happened in the past 1-2 weeks that interested
> parties or intermittent contributors need to know?
> - (asynchronous) Where are you stuck? What eng discussions do we want
> to have? (We'll choose a topic from this list at the beginning of the
> meeting.)
>
> Here's the notes from last week:
>
> *   What's cooking in libification?
>     *   Patches we sent regarding libification
>         *   https://lore.kernel.org/git/pull.1497.git.git.1682104398.gitg=
itgadget@gmail.com/
> config RFC
>             *   Some split opinion upstream, interested in reaching
> agreement before continuing
>             *   Whether to stand up libified API in parallel, or
> replace internal callers with new API
>             *   Not many places are using extra metadata. Avarab is
> suggesting to only change the API invoked for some callers, not all of
> them.
>             *   Glen: my concern is that the config API is already
> huge (bigger than it needs to be). I don't want to add another
> parallel set of APIs there =F0=9F=99=81
>             *   And, passing the metadata is something we probably
> wanted for a while, but considered too churny. With that refactor i
> think we can improve a lot of the diagnostics and error reporting in
> config in git overall. Would be less painful to not carry the burden
> of the two APIs and add new logging piecemeal.
>             *   Plus, we need to be able to make these large scale
> refactors for libification in general
>             *   Emily: how can we move forward? Pros and cons? Get
> avar to come to a chalk talk?
>             *   Jonathan: avar proposed something, glen explained why
> he disagreed, i don't think it's our turn, i think it's avar's turn.
>             *   Junio: avar is on pat leave =F0=9F=99=82
>             *   Emily: so we shouldn't be waiting for avar, we should
> be convincing someone else on the list to agree with glen, right?
>             *   Jonathan: originally i was interested in migrating
> stuff to the configset first, but past me didn't say that, so i trust
> past me too =F0=9F=99=82
>             *   There's a summary of that approach in the cover letter
> at the bottom.
>             *   Glen: avar proposed another option, also linked in the
> cover letter.
>             *   Jonathan: based on the nature of these patches,
> probably there is not less churn by converting to configset first.
>             *   Glen: I found the conversion to configset to be really
> difficult actually
>             *   Glen: The other approach suggested - the config API
> has a low-level get\_config\_from\_file() which doesn't evaluate
> includes etc. and git\_config(), which reads various sources and
> caches in a configset. git\_config() does cache. Avar's alternative
> proposal is that since very few places need to read from file
> directly, we can drop get\_config\_from\_file() and always use the
> caching api to read from things. So we do one complete pass and then
> read from cache the rest of the time.
>             *   There's a little extra cost of memory and runtime but
> it's not that big, and we have a smaller public API.
>             *   But it's taking away a sensible purpose-build API and
> replacing it with something more specific to the git binary. We don't
> need the caching to read a bundle-uri file, for example, we can just
> read the file directly.
>             *   Junio: one example of reading from file is bundle-uri,
> but that's not really a config, same for gitmodules? Why are we still
> reading from config file directly at all, even the oldest git config
> functions go through the in-memory cache, right?
>             *   Glen: yeah, we only use this to read stuff in config
> syntax that isn't actually config, those examples and also the
> sequencer.
>             *   For libification, it makes sense for a libified caller
> to want to leave things in config file format, and we can put that in
> a low-level config library somewhere, right? But config.h is huge now
> so it's not suited to a public api
>             *   Jonathan: are you looking for others' opinions? Do you
> want to rearrange the patches?
>             *   Glen: Would like someone else to agree the approach is
> promising before I start
>             *   Jonathan: well, I agree =F0=9F=99=82
>             *   Emily: might hold more weight to find a non-googler revie=
wer
>             *   Randall: I don't know enough about config to take a
> look at it unfortunately. I have a gut feeling of trepidation and not
> sure why. Not offering to review it in depth =F0=9F=99=82
>             *   Glen: because of the scale of the change, maybe?
>             *   Randall: users of the API vs. internal users of the
> API, what's the use case for not using cached config?
>             *   Emily: probably makes sense for VFS to use a file-only
> lib for reading local, gitmodules, etc.
>             *   Junio: that's not a reason not to use caching, though, ri=
ght?
>             *   Glen: basically, we don't have a general "read from
> file and put it in cache". Implementing it wouldn't necessarily make
> the API simpler, so nobody implemented it internally yet
>             *   Randall: Are we increasing IO as a tradeoff? If we
> normally should be using the cache, then getting config values
> shouldn't usually require going to the filesystem (except the first
> time). But if we have an alternate path to config data, then we're
> double-reading, right? Does this approach increase the amount of
> redundant IO we perform?
>             *   Junio: historical context: we didn't have
> git\_config\_get\_foo() that names a variable, we only had the
> git\_config() callback, and that callback always reads all the files.
> If you had this call twice, then it was very expensive, historically.
> That's why we added caching behavior.
>             *   Jonathan: nobody is proposing double read. The
> callback approach doesn't double-read anymore, right?
>     *   Patches for review related to the libification effort
>         *   Elijah=E2=80=99s final cleanup for cache.h:
> https://lore.kernel.org/git/pull.1525.git.1683431149.gitgitgadget@gmail.c=
om/
>             *   Calvin: currently finishing up review for this
>             *   Jonathan: does it need more reviews than calvin's?
>             *   Calvin: my main concern is that the split between
> objstore and objstore-lowlevel is not super clear. Otherwise i'm happy
> with the series
>             *   Jonathan: is that a blocking concern?
>             *   Calvin: depends on elijah's response. Right now it's
> unclear which file to add a new function to, so we need some kind of
> definition. So yes, it's blocking-ish? But I think elijah can solve
> the concern easily
>             *   Jonathan: i'll take a peek tomorrow
>             *   Glen: on a previous series, elijah referred to
> low-level as having no textual dependency on the header. Would be good
> to clarify this upstream
> *   (asynchronous) What happened in the past 1-2 weeks that interested
> parties or intermittent contributors need to know?
> *   (asynchronous) Where are you stuck? What eng discussions do we
> want to have? (We'll choose a topic from this list at the beginning of
> the meeting.)
> *
> *   Glen: how are the c-tap-harness discussions going?
>     *   Josh is taking this series over including pursuing
> discussions, so no update here unfortunately
