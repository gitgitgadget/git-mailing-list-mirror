Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B739EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 07:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF3HBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF3HBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 03:01:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476321981
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 00:01:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b7f5436076so9937525ad.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688108478; x=1690700478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHSkPZ2X/jjFB5OJpksaWefkZnheslennYXbkqZSxHs=;
        b=7a/EYuDK9h1K7jbh/HgXektZLfgSwVCZhwyJC+zR5D3XfZNz1C/FluZ9Ij3ZDDUXBT
         1UiXUGF+85yk+F1mD7b/sjm9gOQG45xPVqrK3mqnQ6mdaB/icv470mFqzWqiPZtWoF1M
         jouQI3e6gS3tbZaUU6U8xW7ncXhytnjGnHWWglmeV5VhkoBcLidBIJmQsQhyBi5YP0Mi
         lBEHEPgmX2oME807yU6sI+sc3p2EHH1vCmgr2N2DqKrRNPSWckx6ot1gSN8IjIyzX3aB
         0beN6mPvANJjYmKqgR8X955jyW0lMk/ZYRUwXy+y0Y9kBHZOe2AAF3+6EoT3RBEJRNhC
         vDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688108478; x=1690700478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHSkPZ2X/jjFB5OJpksaWefkZnheslennYXbkqZSxHs=;
        b=hjTO6o5+bqDT6q2i3WJ1XYJtDsfo/K4oActtBadoma2xO5HmFfqhvksSRrA/mzaYy8
         tbqiB9uRkR/xSotEZhwGIOpqzOm2kxQvozMRrZIHCIZuFTcZzhDvTqIO9Wg7QhiwGrX0
         lVfIBakdA6/+5PHZvuXQWKl/cD0IwUeWx2VwvEudZDY5qdgN7L1cJxcHbQBN9Z+cYT4y
         wtYIiBjgA/zsb8KABzTAvwMeRMMI8Xz7Du66ADKMsLnOh/dlSTKNPPmbUJcSTaFm0PnD
         ipVPounLQU6qyAA920nJUOFr1vTFbzXtfGPHNRjpSva+Oc/PlqwI5j3Rso0dsSptGrZ0
         3Kaw==
X-Gm-Message-State: ABy/qLa+G8UGo9RA5nJJDLp2a3+NnRifzGKtzXwE7Zczh9vtFcYEv6l6
        e1jNERNfYRRgtuT2eabuF91kguUEd5w=
X-Google-Smtp-Source: APBJJlGpbq5CZU38oTQfPTml7zc2a9Bp6XLgouQDpyhPQNa1v8kHU+B3BsgXTNW6PmuujCcy3z9uf1041eI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ed44:b0:1b5:2c0b:fa72 with SMTP id
 y4-20020a170902ed4400b001b52c0bfa72mr1002130plb.12.1688108477771; Fri, 30 Jun
 2023 00:01:17 -0700 (PDT)
Date:   Fri, 30 Jun 2023 00:01:16 -0700
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
Message-ID: <owly4jmp8mdf.fsf@fine.c.googlers.com>
Subject: Re: [RFC PATCH 0/8] Introduce Git Standard Library
From:   Linus Arver <linusa@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Calvin,

Calvin Wan <calvinwan@google.com> writes:
> With our current method of building Git, we can imagine the dependency
> graph as such:
>
>         Git
>          /\
>         /  \
>        /    \
>   libgit.a   ext deps
>
> In libifying parts of Git, we want to shrink the dependency graph to
> only the minimal set of dependencies, so libraries should not use
> libgit.a. Instead, it would look like:
>
>                 Git
>                 /\
>                /  \
>               /    \
>           libgit.a  ext deps
>              /\
>             /  \
>            /    \
> object-store.a  (other lib)
>       |        /
>       |       /
>       |      /
>  config.a   / 
>       |    /
>       |   /
>       |  /
> git-std-lib.a
>
> Instead of containing all of the objects in Git, libgit.a would contain
> objects that are not built by libraries it links against. Consequently,
> if someone wanted their own custom build of Git with their own custom
> implementation of the object store, they would only have to swap out
> object-store.a rather than do a hard fork of Git.

What about the case where someone wants to build program Foo which just
pulls in some bits of Git? For example, I am thinking of trailer.[ch]
which could be refactored to expose a public API. Then the Foo program
could pull this public trailer manipulation API in as a library
dependency (so that Foo can parse trailers in commit messages without
re-implementing that logic in Foo's own codebase). With the proposed Git
Standard Library (GSL) model above, would my Foo program also have to
pull in GSL? If so, isn't this onerous because of the additional bloat?
The Foo developers just want the banana, not the gorilla holding the
banana in the jungle, so to speak.

> Rationale behind Git Standard Library
> ================
>
> The rationale behind Git Standard Library essentially is the result of
> two observations within the Git codebase: every file includes
> git-compat-util.h which defines functions in a couple of different
> files, and wrapper.c + usage.c have difficult-to-separate circular
> dependencies with each other and other files.
>
> Ubiquity of git-compat-util.h and circular dependencies
> ========
>
> Every file in the Git codebase includes git-compat-util.h. It serves as
> "a compatibility aid that isolates the knowledge of platform specific
> inclusion order and what feature macros to define before including which
> system header" (Junio[5]). Since every file includes git-compat-util.h, and
> git-compat-util.h includes wrapper.h and usage.h, it would make sense
> for wrapper.c and usage.c to be a part of the root library. They have
> difficult to separate circular dependencies with each other so they

s/difficult to separate/difficult-to-separate

> can't be independent libraries. Wrapper.c has dependencies on parse.c,
> abspath.c, strbuf.c, which in turn also have dependencies on usage.c and
> wrapper.c -- more circular dependencies. 
>
> Tradeoff between swappability and refactoring
> ========
>
> From the above dependency graph, we can see that git-std-lib.a could be
> many smaller libraries rather than a singular library. So why choose a
> singular library when multiple libraries can be individually easier to
> swap and are more modular? A singular library requires less work to
> separate out circular dependencies within itself so it becomes a
> tradeoff question between work and reward. While there may be a point in
> the future where a file like usage.c would want its own library so that
> someone can have custom die() or error(), the work required to refactor
> out the circular dependencies in some files would be enormous due to
> their ubiquity so therefore I believe it is not worth the tradeoff
> currently. Additionally, we can in the future choose to do this refactor
> and change the API for the library if there becomes enough of a reason
> to do so (remember we are avoiding promising stability of the interfaces
> of those libraries).

Would getting us down the currently proposed path make it even more
difficult to do this refactor? If so, I think it's worth mentioning.

> Reuse of compatibility functions in git-compat-util.h
> ========
>
> Most functions defined in git-compat-util.h are implemented in compat/
> and have dependencies limited to strbuf.h and wrapper.h so they can be
> easily included in git-std-lib.a, which as a root dependency means that
> higher level libraries do not have to worry about compatibility files in
> compat/. The rest of the functions defined in git-compat-util.h are
> implemented in top level files and, in this patch set, are hidden behind
> an #ifdef if their implementation is not in git-std-lib.a.
>
> Rationale summary
> ========
>
> The Git Standard Library allows us to get the libification ball rolling
> with other libraries in Git (such as Glen's removal of global state from
> config iteration[6] prepares a config library). By not spending many
> more months attempting to refactor difficult circular dependencies and
> instead spending that time getting to a state where we can test out
> swapping a library out such as config or object store, we can prove the
> viability of Git libification on a much faster time scale. Additionally
> the code cleanups that have happened so far have been minor and
> beneficial for the codebase. It is probable that making large movements
> would negatively affect code clarity.

It sounds like the circular dependencies are so difficult to untangle that they
are the primary motivation behind grouping these tightly-coupled libraries
together into the Git Standard Library (GSL) banner. Still, I think it would
help reviewers if you explain what tradeoffs we are making by accepting the
circular dependencies as they are instead of untangling them. Conversely, if we
assume that there are no circular dependencies, what kind of benefits do we get
when designing the GSL from this (improved) position? Would there be little to
no additional benefits? If so, then I think it would be easier to support the
current approach (as removing the circularities would not give us significant
advantages for libification).

> Git Standard Library boundary
> ================
>
> While I have described above some useful heuristics for identifying
> potential candidates for git-std-lib.a, a standard library should not
> have a shaky definition for what belongs in it.
>
>  - Low-level files (aka operates only on other primitive types) that are
>    used everywhere within the codebase (wrapper.c, usage.c, strbuf.c)
>    - Dependencies that are low-level and widely used
>      (abspath.c, date.c, hex-ll.c, parse.c, utf8.c)
>  - low-level git/* files with functions defined in git-compat-util.h
>    (ctype.c)
>  - compat/*

I'm confused. Is the list above an example of a shaky definition, or the
opposite? IOW, do you mean that the list above should be the initial set
of content to include in the GSL? Or _not_ to include?

> Series structure
> ================
>
> While my strbuf and git-compat-util series can stand alone, they also
> function as preparatory patches for this series. There are more cleanup
> patches in this series, but since most of them have marginal benefits
> probably not worth the churn on its own, I decided not to split them
> into a separate series like with strbuf and git-compat-util. As an RFC,
> I am looking for comments on whether the rationale behind git-std-lib
> makes sense as well as whether there are better ways to build and enable
> git-std-lib in patch 7, specifically regarding Makefile rules and the
> usage of ifdef's to stub out certain functions and headers. 

If the cleanups are independent I think it would be simpler to put them
in a separate series.

In general, I think the doc would make a stronger case if it expanded
the discussions around alternative approaches to the one proposed, with
the reasons why they were rejected.

Minor nits:
- Documentation/technical/git-std-lib.txt: (style) prefer "we" over "I" ("we
  believe" instead of "I believe").
- There are some "\ No newline at end of file" warnings in this series.

Thanks,
Linus
