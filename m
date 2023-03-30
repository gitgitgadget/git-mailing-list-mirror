Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5DEC7619A
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjC3VcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjC3VcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4E0CA3F
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 14:32:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so82009879edd.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680211932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Uua4x6klhFRQzAgBLTOU7f2s10qVRY/ElcqesOoIM=;
        b=NBcNVQumIyZBq+k4dg1N7s7ErDRgxlejcUVE2JN3rlHi9BQzmRgaJqW/Cfb/QrSAnD
         ZnwBVFI00v6W6xXyepld6/XUNXZGGHRbj4HVe/8F8ZiMOXrkykQMdBQ8oMAjXM2KGqLz
         c8YTRtp4wusi14A6w+Dujo8gDaMPVqeAXLZpMXZIpJuoG4GHq9c56IciXufLOJY4cd7U
         0akQC2983ivOd1PvR69DmS/0ZUywKQLiRrbyOHG/ncrK9xj0gc+PgSp6YXOxygEfMqU8
         hqi6PBx2cU/ftS511p6KW1MOoLOX0RPYpOcNV19LS/jsmCJm+Ewd90qXYKmm6R+f4cWK
         pN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Uua4x6klhFRQzAgBLTOU7f2s10qVRY/ElcqesOoIM=;
        b=XtlA+ooi3GxkYZmvtK53xYfLIM2mXD/3LbaxXdnYau++7/b4uNy/xBWRV3iVO2yV4h
         RiJvPimTTaUUI/sqGgEH8DTJuoBKO+yyk5v5+1JHlpb/AK8vdh+N44yK7YhoBkogBdqp
         s1y7KNzU6cMptwqHdOjJAfnAXgw0viKl96NZUNhNJQMPB3PBlTlyJvxeJckxqkLMNMpA
         gVA9Mbgn4KNBrpYURvxkhGuKn+z7QTwJmLPE2dOnoMl+4TY/Z+ger8hZcZDeloXHknZ0
         n1SZA3N17xhzMreU8h9a1eKf1jdP1Lyot1jKq0+jARlQculNkTM/nAKU7qFDfuvFvclT
         wlgQ==
X-Gm-Message-State: AAQBX9fUPwIvaoDA6DjFLqVVFN72Kbv1jNFDttV6G4K6eNz9LSxiisEg
        219/Iv56grjNbGw3mPfwPvf5yhhiB3hIQ9GhettyJxdq19CyDwlXrmXqRw==
X-Google-Smtp-Source: AKy350YNnDcyjj2r5cNlCY9hRUj0OZILIWypJkqYjtXA76bHBHIGz9SJPSgFjYK9tCC6Vx+gjqOe81TeKO4b5+YanZw=
X-Received: by 2002:a17:906:9244:b0:8e3:da0f:f3ea with SMTP id
 c4-20020a170906924400b008e3da0ff3eamr11086534ejx.7.1680211931456; Thu, 30 Mar
 2023 14:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=KrnAWV3PpfBkYNs_KHFP5O2dVYOWY3jF=CM9+d89Dpg@mail.gmail.com>
In-Reply-To: <CAJoAoZ=KrnAWV3PpfBkYNs_KHFP5O2dVYOWY3jF=CM9+d89Dpg@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 30 Mar 2023 14:31:59 -0700
Message-ID: <CAJoAoZm7147oH9ECr=y+OXonK5WSgc9H0b95sF7BhKjMn+oMZg@mail.gmail.com>
Subject: Re: Video conference libification eng discussion, this Thursday 16:30UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 3:39=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:
> I'll reply to this mail tomorrow-ish with the topic we'll discuss
> during the meeting, and I'll reply again afterwards with the notes.

The notes follow:

*   (asynchronous) What's cooking in libification?
    *   Patches we sent regarding libification
        *   Glen: Clean up config parsing:
https://lore.kernel.org/git/pull.1463.v3.git.git.1680025914.gitgitgadget@gm=
ail.com
    *   Patches for review related to the libification effort
        *   =C3=86var: Remove some implicit the\_repository:
https://lore.kernel.org/git/cover-v2-00.17-00000000000-20230328T110946Z-ava=
rab@gmail.com
*   (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list a day ahead of the
meeting.
    *   Glen: I want to change the signature of config\_fn\_t, but I=E2=80=
=99m
not sure how ML will respond to such large scale changes. I might just
try it and send it anyway, but it will take time.
    *   Calvin: I moved some functions from strbuf.c to abspath.c, but
then I noticed that functionally, abspath.c and path.c have
non-distinct boundaries between what they both do. I=E2=80=99m wondering if=
 it
makes sense to combine both files. Also the functions defined in
abspath.c have their declarations in cache.h whereas path.c has its
functions defined in path.h. I think we should at least add abspath.h
with it included in cache.h to start reducing the size of cache.h.
*   Intros (if needed)
    *   Emily: TL of git-core at google
    *   Taylor: lots of Git stuff for some time
    *   Elijah: at Palantir, looking for more time to work on Git
stuff but for now it's \*mostly\* free time
    *   Glen: git-core at google
    *   Calvin: git-core at google
    *   Daniel: TPM for git-core at google
    *   Siddharth: working at git-core team for just this quarter at 80% ti=
me
*   Session topic: Calvin's topic - boundaries between abspath and
path and whether to combine
    *   Elijah: I did a series taking lots of these declarations out
of cache.h and into abspath.h and path.h
    *   Agree that the boundary is fuzzy, didn't try to fix it. Just
mechanically moved based on whether the impl was in abspath.c or
path.c. Might be useful for you to build on top of this series
    *   Calvin: extra context: cache.h is a grab bag of functions
implemented in other various .c files.
    *   Especially interested in discussing the boundary between these
two. Should we merge them together since they're all path-related?
    *   Within abspath.c we have stuff that's explicitly for absolute
or real paths. But in path.c we tend to have both.
    *   Log diving didn't make it clear why we made a distinction into absp=
ath.c
    *   Elijah: I was trying to guess whether anybody figured out the
rationale for the split. My guess was that it was actually pretty much
random =F0=9F=99=82
    *   Elijah: Do either of them bring extra headers/reduce dep size
compared to the other one?
    *   Glen: Python path libraries are split into path objects and
os.Path which handles OS-specific stuff like resolving symlinks etc.
Is that a more reasonable delineation between these two things? Would
create more churn but ignoring that for the moment
    *   Calvin: can look into it
    *   Emily: does that delineation make sense when we don't have a path t=
ype?
    *   Glen: You could consider strbuf + path-specific functions are
more like a "path class"... that might be too small though
    *   Emily: are callers always using both? Are callers of abspath
ones that need a minimal set of dependencies?
    *   Calvin: Does Elijah's patch manage to entirely remove cache.h
from path.c?
    *   Elijah: would have to check
        *   Yes, i did manage to drop it from path.c eventually but I
also had to remove setup.c stuff into setup.h so path.c could include
setup.h instead
    *   Glen: Check - do we know what "success" means for this discussion?
    *   Calvin: What problems might we have, what questions need to be
answered about those two things? Doing cleanups like this in the
future, what does that look like?
    *   Emily: The fact that path.c relies on setup.h makes me wonder
how much of this is super low level utility stuff vs. how much is more
semantically high level/git-specific. That might be a place to split
too
*
*   Elijah: Curious why Glen is trying to change the type? What's
wrong with it as it is?
    *   Glen: If we modify it a little bit then we don't have to keep
global state. For example, "the config line for the current value i'm
reading" requires global state because we don't have a way to send it
to the config\_fn\_t callback
    *   Glen: It'd be nice to change it=E2=80=A6 but we use it everywhere,
right? Is it too big to change?
    *   Elijah: Right but it gets rid of a global :) :) :)
    *   Glen: That's useful feedback actually!
    *   Emily: Probably should change it so we don't have to make
large scale change every time we want to add some functionality to
that callback (e.g. run-command.h or hook.h)
*   Glen: Did people find this discussion useful? Especially for
people outside of Google? Was this this useful/how you envisioned this
meeting? What is better?
    *   Elijah: Wasn't sure how it would go, I was already in the
middle of a bunch of cleanup and was excited for the chance to send
those patches and get review.
    *   I think we maybe went a little long on the abspath/path stuff,
the discussion was useful but don't want to cut it off.
    *   Taylor: Didn't have many expectations anyways, this seems like
mostly a Google effort so I didn't have expectations. Did think it was
useful and interesting
*   Glen: Next time can we talk about how to cope with cocci changes
e.g. `=C3=86var: Remove some implicit the\_repository:
https://lore.kernel.org/git/cover-v2-00.17-00000000000-20230328T110946Z-ava=
rab@gmail.com`?
Both Elijah and I weren't sure how to review this - is it well-written
coccinelle? Will it slow down the cocci check?
    *   Taylor: Yeah it's tricky because it's already too expensive to
run during CI, so we might not even care that it's slowing down the
check?
    *   Glen: Would like to talk about it and see if we can establish
some norms on the ML - explicitly state whether we care if it's
slower, etc.
    *   Taylor: We have a bunch of pending cocci changes, it never
quite seems right to land big changes like this. Would be nice to talk
about when to land these - is the beginning of the release cycle
better? etc
    *** Note - this conversation made it to the list at
https://lore.kernel.org/git/kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.=
google.com/
***
