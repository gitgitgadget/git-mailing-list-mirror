Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85192C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 18:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDKSjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKSjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 14:39:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B416ED
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:39:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sg7so34206445ejc.9
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681238352;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1mqdZGsB2+yrfn+hTqvD4Mp9QJIGR/cJXorVw9EpMg=;
        b=Pv1q2ENc+ku7CX7i/svrhp2D487U6yac8/vs6bx8RMag4TXMoZpoCLLW/q4m6IyJ5A
         xn6ZPnOBk+Euz3NcCzt0wPgkzgl/qcWscfYWjtc3HW1V3iC6A/ZDSUf1KPyZq44VCWBd
         hIZcdEsGV/brxXS+i0ssXZY41797XUeH1knZ5l4owkfDKDnmFvdqm58sa3lty+x4Q/Ur
         EQho5xRewE0UwNtQsTchE3jDd78Nfo5q36bYF7iu5rh6a3lCNN2khjP5Z2DTZVW+5EaF
         IEUu/KvGXIKJtNtplzL60h+qZLVTaGVmeYd4uKJlE4ILokFgu20aBzKnLjKSr8pCBfVm
         47vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238352;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1mqdZGsB2+yrfn+hTqvD4Mp9QJIGR/cJXorVw9EpMg=;
        b=MRj+hlJ3qbONaZ3uzBTl7IU5Y5Zmkg68aSwzn9TAVC7zKo8DLg2TB3pbCde8N0JrnC
         IlPSTxfCsazTaInuUeLfWxpk7RfmX0m3g4CaWuLg2SbvXTlf1WwgpJk5wFax0bfpSha8
         AVuCJ7Mna3lkbBKhgC+wJa6HibAWF86zGHviGtaeHy/w1V1Xbx12nDSE35kkfvx2cj+D
         dSs7zYb1M3CXYOC5x4idnJcmypIGoY/pBap4hbm9YPUUSVUUmpEWtK6zYk8ACdkXj37C
         eIKB2VL12UjNiTTZmuWn+bGZxEWPHFt4cghGcUdxaKKKpfeNWXmmTtQFeMZAmabhSPTf
         dsJg==
X-Gm-Message-State: AAQBX9f5G9V/gcOE1Qpp4hXFD2B4V8YQvUgrNVPN2RdDIviXLyu40BDh
        Ym7S+5EiJECxXH3n464ShrDAcARK7b3v411zJm1GfLMKFO1AYJ61t0kUeQ==
X-Google-Smtp-Source: AKy350bY+cpKguewQMC7C5W9Xytzvi87vDALxoglbSJleFUlYI2jwJEC3hkUoT7cr2eGbbcjMZuh7Os1+q6qmJjDZpQ=
X-Received: by 2002:a17:906:8447:b0:94a:7202:a68e with SMTP id
 e7-20020a170906844700b0094a7202a68emr3955029ejy.7.1681238352142; Tue, 11 Apr
 2023 11:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=q6ppzErzBT2VygdHbfhezYtFSkM3rLtt+gTvdSrLEHQ@mail.gmail.com>
In-Reply-To: <CAJoAoZ=q6ppzErzBT2VygdHbfhezYtFSkM3rLtt+gTvdSrLEHQ@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 11 Apr 2023 11:39:00 -0700
Message-ID: <CAJoAoZ=FqzODvRQdm9nQtq1wCaFo6sPduWAm2T78+MArddH4nA@mail.gmail.com>
Subject: Re: Video conference libification eng discussion, this Thursday 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The notes from this session follow:


 - (asynchronous) What's cooking in libification?

   - Patches we sent regarding libification

- How to review coccinelle?
https://lore.kernel.org/git/kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.=
google.com

   - Patches for review related to the libification effort

 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?

 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list a day ahead of the
meeting.)



*   Emily: what's the least ugly way to move existing code into
"libified" code? oldname\_lib.[ch] in the top level? lib/oldname.[ch]?
lib/oldname/oldname.[ch]? Something else?
*   Emily/Calvin: How do we feel about
https://github.com/rra/c-tap-harness/ ? (3)
*   Calvin: Git-compat-util contains many necessary includes, macros,
and inline functions used across all of git, so therefore any library
must include it. There are a couple of dependencies inside of it,
however, that prevent libraries from compiling independently with it.
(lots)

 - Session topic: git-compat-util



*   Intros
    *   Emily: TL git-core @ google
    *   Jonathan: git-core @ google
    *   Calvin: git-core @ google
    *   Randall: Platform maintainer for NonStop
    *   Cem: Interested in contributing to Git but haven't sent
anything yet, hi =F0=9F=99=82 Curious to hear what's going on and hoping to=
 help
    *   Siddharth: visiting git-core for just Q2 (@ google)
    *   Linus: 20%ing on git-core (@ google) - interested in libification s=
tuff
    *   Glen: git-core @ google
*   Randall: Mostly concerned about licensing and whether libification
will change the licensing stuff
    *   Emily: for now Google doesn't see a reason to try to relicense anyt=
hing
*   Calvin: Git-compat-util contains many necessary includes, macros,
and inline functions used across all of git, so therefore any library
must include it. There are a couple of dependencies inside of it,
however, that prevent libraries from compiling independently with it.
    *   Everything includes git-compat-util.h. So we need
git-compat-util.h to either be not a catchall (like we did with
cache.h), and should we libify git-compat-util dependencies?
    *   There are some things that are explicitly compatibility
related, like git\_pread(). This is ifdef'd so we always have a pread
implementation. That implementation comes from wrapper.h, and
wrapper.h/wrapper.c includes Lots Of Stuff :') including trace2 and
usage
    *   die() impl is pretty bad also
    *   Jonathan: We could say that git-compat-util.h can't depend on
anything else. For example, we can't die(). This might be good,
because anything provided by the platform shouldn't be die()ing
    *   Calvin: So that means we don't even want to define usage(),
die(), warn(), error() in git-compat-util.h. That kind of makes sense!
But some libraries want to use die() for now
    *   Emily: yeah, but we need to refactor that out =F0=9F=99=82
    *   Calvin: Probably that means we should figure out the error
returning design
    *   Linus: Are there already circular dependencies here?
    *   Emily: Does that mean we should build all the
everyone-needs-it libraries into one binary, so they can depend on
each other in a complicated way if they need to?
    *   Calvin: That doesn't really help with trace2 dependency
    *   Randall: Are we sure how the packaging is gonna happen? Is it
static, dynamic, =E2=80=A6?
    *   Emily: Within Git codebase, not really that worried yet beyond
making sure they CAN compile independently and unit test
    *   Jonathan: So mostly focusing on "can I compile this explicit
subset of .[ch] files and run unit tests on them"
    *   Randall: Similar experience with OpenSSL and they dll-ified
their code. That had a lot of platform-specific pain. Please tell me
if you're interested in dlls =F0=9F=99=82
    *   Emily: As far as the trace2 stuff, I imagine most people
calling Git libraries from their code won't want to trace at all. So
we probably want to libify trace2 stuff \*and\* provide a stubbed
version of the API, since that's such a common use case
    *   Calvin: Maybe it makes sense to build that tr2-noop lib right
into a large "git-common-lib"
    *   Calvin: and we can put strbuf, string\_list, hashmap, etc. in
there and we might even be able to leave some things stubbed in
git\_compat\_util.h=E2=80=A6.
    *   Calvin: This combined with packaging everything together into
a common library actually sounds really appealing
    *   Glen: Do we have a good idea of what everything that would be
included into this common library is? How can we annotate what is and
isn't part of it?
    *   Randall: A lot of platform problems we have had in the past
are coming from git-compat-util. I'm always worried about it, please
be careful with it =F0=9F=99=82
    *   Calvin: Hoping to avoid touching anything that's got an #ifdef
as a general rule
    *   Randall: the atexit() code is a place to be careful for sure.
And NonStop is trying to start using pthreads. So, yes, I'm very
worried here.
    *   Linus: Would it make sense to have some large "standard
library" file with no deps and start moving stuff into it?
    *   Emily: I'm worried about that turning into a mega-header like
cache.h (or git-compat-util.h)
    *   Randall: I like cleaner containment than making things extremely br=
oad
