Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC6C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA6060F35
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhHLAnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 20:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhHLAnh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 20:43:37 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253AC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so2302612qvt.20
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=6eY1S0uA7ZanyPqqOXv8vI+XfIDjgfd94KBk+0IjzgI=;
        b=Tfrlug/iYpuieu7CEHZjn6bg8RqfE57v8rAopD3hgFp5P01Ag7iksBY2CKtHTlve+Y
         59JC3/Qx3uFnRP4ysfJsMbhO3KuJ/8a2d48v/kPLN7+6ZQD5fVvOv7hm6V41YrmSZ7+H
         R/gUweyFp+xUGv1eEXHaBBjNv502tO3esKJwKverFD9ha69K/oZzcOu4i3W8/U1hDoEz
         Kc+WYDwUlog60lGTbAymItqJ8Rn8+ya/rP3BSV6OefNdXGwrNcyLQgbsW6KzEWLiNyIN
         dUYe48zfB70Y9vJG4kmWkHIlyBI90q90RH4MkKqpZQZNsDQb2Kn4ei974vcciIK40IQh
         haFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=6eY1S0uA7ZanyPqqOXv8vI+XfIDjgfd94KBk+0IjzgI=;
        b=pOvkLxpbHLUYhc1vrovbNFyyhS37691olHFe6fmoNiuoMb/WgkaB4RjEWq6T0u6tiF
         /pzf8iRUDVdbndiPA7KCec6Nob89g5swLyNaYleePW4MMuPpnw67Jt3ujBtmP1pbJK8E
         5aK357AIYnzEhxNY7qKqaQCdO5/8WHXcHXhM1BVBGX6wgVpB6ZTeWIySimFCZDU8vYUt
         KCtmARM87+KzccBlsF3wybPkXhrKW9VHwjQavsmvDvEO+xNmp/cgj3K9T49UVQXo3pkq
         9OVhk2Q0Ey/xXRL7gWIZ3Vt3hGl0sBEOUfXzMZl/q2OqOqyXlHfxK1EPVIxbv7vzIT9k
         3ycA==
X-Gm-Message-State: AOAM532LQRjE72oxDpxwJKhoo1AUuP4lpVKpV/hqmMNGq4gaREyqzDrF
        azPhpF9VObncfaJ4K/UCRV2tbvVXql9bN0I3txQ+0Az2CAG45zXrQ2mrvCbbW7LDNyn5yyAoS/y
        kCrfa3xIE1oxWww/qrPDyUjw2y4P1OEWfsl3iRsjV5xocSww09bJ4Haf9EUl/kUa/SPqgl+j9oA
        ==
X-Google-Smtp-Source: ABdhPJw3BaZvmYBWueRWjz4AbVe3fk1czoZ05/CCkM8viBLAL6NeJdT4R03I+gsQ2gvAzs33KEgLhZIf4kiWvGs3s3c=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:728:: with SMTP id
 c8mr1299717qvz.53.1628728991348; Wed, 11 Aug 2021 17:43:11 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:42:52 -0700
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
Message-Id: <20210812004258.74318-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 0/6] config-based hooks restarted
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the config-based hooks topic rebased onto v4 of =C3=86var's
branch[1]. There is a happy CI build of it on GitHub[2].

The topic overall adds the ability to set up hooks by modifying the
config, in addition to placing specially named hooks into the hookdir.
This enables users to specify multiple hooks for a given event, and so
this topic also fleshes out the use of the run_processes_parallel() API
which is now introduced in =C3=86var's reordering of prior patches.

Patches 1-4 make some minor changes to prepare =C3=86var's series to handle
more than one hook at a time. With the exception of patch 4, there
should be no behavior change for existing hooks.

Patch 2 is opinionated about which hooks should and shouldn't be allowed
to run in parallel; if you care about a specific hook, please take a
look there.

Patch 5 is the motivating feature - it begins to parse the config
looking for hooks.

Patch 6 takes advantage of the decoupling of hooks and GITDIR to allow
out-of-repo hook runs, which would only run hooks specified in the
system or global config. This mainly targets 'sendemail-validate', but
'git-sendemail.perl' still explicitly disallows out-of-repo hook
execution on that hook for now. (Maybe that change should be added in
this series? Or maybe patch 6 belongs with that kind of change?)

Since v1:

The largest change is that the config schema is different, following the
discussion from [3] and on. 'hookcmd' has gone away entirely, and all
config-specified hooks need a user-provided name associated with them.

I have also dropped the 'skip' config from this series (also discussed
in [3]) as users can reset their 'hook.myhook.command' to 'true' or some
other noop in a later config to effectively disable any hook. The 'skip'
feature may be added later or may not, depending on if users ask us for
it.

The 'from_hookdir' field has been removed entirely. When storing hooks
by name instead of by command, it makes sense enough to store the one
from the hookdir in a special way - NULL name - because it does not have
a name to specify. This way we can use that field as an indicator that
the hook came from the hookdir, and we also do not need to reserve a
name to use for hookdir hooks (as opposed to setting hookdir hooks to
have name =3D "FROM_HOOKDIR" or something).

The tests have been moved into t1800-hook.sh and simplified.

The 'struct run_hooks_opt' initializer has been moved to macros (as
opposed to functions), and .jobs=3D0 indicates that we should look up the
configured job count or nproc at hook run time. =C3=86var asked me to chang=
e
these macros to RUN_HOOKS_OPT_INIT and RUN_HOOKS_OPT_INIT_SYNC or
something to simplify the merge, but I did not do that - I removed all
instances of RUN_HOOKS_OPT_INIT and now everybody uses
RUN_HOOKS_OPT_INIT_SYNC or RUN_HOOKS_OPT_INIT_ASYNC. I think it's
important for contributors to be able to tell at a glance whether the
hook event expects resource contention that would prevent parallelism. I
also think it makes the review easier (if longer) for folks who are
reviewing trying to decide whether the parallelism is appropriate for
each hook event. I do think that run_hooks_oneshot() also is a step
backwards in this regard, but I didn't get a chance to say so on the
commit that introduces it yet.

Thanks in advance, all.

 - Emily

1: https://lore.kernel.org/git/cover-v4-00.36-00000000000-20210803T191505Z-=
avarab%40gmail.com
2: https://github.com/nasamuffin/git/actions/runs/1122126800 (which
points to an earlier successul run before I messed with the commit
messages)
3: https://lore.kernel.org/git/87fswey5wd.fsf%40evledraar.gmail.com

Emily Shaffer (6):
  hook: run a list of hooks instead
  hook: allow parallel hook execution
  hook: introduce "git hook list"
  hook: allow running non-native hooks
  hook: include hooks from the config
  hook: allow out-of-repo 'git hook' invocations

 Documentation/config/hook.txt |   9 ++
 Documentation/git-hook.txt    |  48 +++++-
 builtin/am.c                  |   4 +-
 builtin/checkout.c            |   2 +-
 builtin/clone.c               |   2 +-
 builtin/hook.c                |  68 +++++++-
 builtin/merge.c               |   2 +-
 builtin/rebase.c              |   2 +-
 builtin/receive-pack.c        |   9 +-
 builtin/worktree.c            |   2 +-
 commit.c                      |   2 +-
 git.c                         |   2 +-
 hook.c                        | 289 +++++++++++++++++++++++++++++-----
 hook.h                        |  61 +++++--
 read-cache.c                  |   2 +-
 refs.c                        |   2 +-
 reset.c                       |   3 +-
 sequencer.c                   |   4 +-
 t/t1800-hook.sh               | 161 ++++++++++++++++++-
 transport.c                   |   2 +-
 20 files changed, 596 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/config/hook.txt

Range-diff against v1:
1:  c4b95fb08a < -:  ---------- hook: treat hookdir hook specially
-:  ---------- > 1:  5177e8ba2c hook: run a list of hooks instead
-:  ---------- > 2:  eda439cd57 hook: allow parallel hook execution
-:  ---------- > 3:  cdfe3b6e16 hook: introduce "git hook list"
2:  e6a56ac674 =3D 4:  eb4e03e22b hook: allow running non-native hooks
3:  32ad49ea9b ! 5:  2c8e874158 hook: include hooks from the config
    @@ Commit message
         hooks to run for a given event.
    =20
         Multiple commands can be specified for a given hook by providing
    -    multiple "hook.<hookname>.command =3D <path-to-hook>" lines. Hooks=
 will be
    -    run in config order.
    +    multiple "hook.<friendly-name>.command =3D <path-to-hook>" and
    +    "hook.<friendly-name>.event =3D <hook-event>" lines. Hooks will be=
 run in
    +    config order of the "hook.<name>.event" lines.
    =20
         For example:
    =20
           $ git config --list | grep ^hook
    -      hook.pre-commit.command=3D~/bar.sh
    +      hook.bar.command=3D~/bar.sh
    +      hook.bar.event=3Dpre-commit
    =20
           $ git hook run
           # Runs ~/bar.sh
    @@ hook.c: const char *find_hook_gently(const char *name)
     -		struct hook *to_add =3D xmalloc(sizeof(*to_add));
     -		to_add->hook_path =3D hook_path;
     -		to_add->feed_pipe_cb_data =3D NULL;
    --		to_add->from_hookdir =3D 1;
     -		list_add_tail(&to_add->list, hook_head);
     -	}
     +	/* Add the hook from the hookdir. The placeholder makes it easier to
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
     +	cp->use_shell =3D !!run_me->name;
     +
      	/* add command */
    --	if (run_me->from_hookdir && hook_cb->options->absolute_path)
    +-	if (hook_cb->options->absolute_path)
     -		strvec_push(&cp->args, absolute_path(run_me->hook_path));
     -	else
     -		strvec_push(&cp->args, run_me->hook_path);
    @@ hook.h: int hook_exists(const char *hookname);
      	struct list_head list;
     -	/* The path to the hook */
     -	const char *hook_path;
    --
    --	unsigned from_hookdir : 1;
     +	/*
     +	 * The friendly name of the hook. NULL indicates the hook is from th=
e
     +	 * hookdir.
4:  91e54185b3 =3D 6:  3216e51b6b hook: allow out-of-repo 'git hook' invoca=
tions
--=20
2.32.0.605.g8dce9f2422-goog

