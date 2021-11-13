Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E01C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08DB610FE
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 09:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhKMJmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 04:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhKMJmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 04:42:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FBBC061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 01:39:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r12so47817457edt.6
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=D1HHjwNVeyCGLtgCYSCWRbiMm4EX7sw+Q+OOl8We9io=;
        b=ptFFynPemCkTXzCNScj9qUlXidhHt+J8WlTxmP+0kKNub7ry9X7FawdSqIsSrZorSp
         sR9Y9QVnM1Q5pb8w2pkyNXf57C1EmEe56cNK9VCTPc6dixbSfSlNW8R8YdBYtGJLrXRN
         youBO17HrcfmrVsvuiDlNqcW6HxXd3rByASE4TTH3GJvHqBJzCeKuwneSQWvGKKtUHC4
         DD9z9vvFdq2ppw1SUPHT4DBiRgTqqQOnghIDN/rG20uGIPLqAi/zRis2GRFfWqcywUAe
         t2uXzeQdp3YgtbqK7Esq5SLtkA0q4guiB0EpJRAa/gKqZFBro4bhlmw+LrSdbL0E7JZn
         OnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=D1HHjwNVeyCGLtgCYSCWRbiMm4EX7sw+Q+OOl8We9io=;
        b=2Q/Fm2P0T9ZbwHJT9YyGMNo2vbNgK+ivaboj0lXndh2G2Q1bySUuZ7eY2JvKkR4Ep/
         BpPG8n8/U9ZScLiILSL3G+ML8monBII5raKstADMUQHfCpt6+r8jtvBnIZNyw2zonowz
         BkYPsRLF56heymY5lpqgW5vDAhPtO8yIZybEhfgfbGLU8Dg/5RUkBrqj33NBTRCwZkqR
         fix6CDzp9mHwOnXQ3O2U1mfDdbhGKPrltQzJRmb2vY9t57Ypgkh1BnhHlzE7dSXwNEWK
         w+86Er2vbyUZR7GU6H2qEr2gDlYcYwai0GJZs2x//FpOb280eab2WPPI44c+6b+VGdv9
         d93w==
X-Gm-Message-State: AOAM5335ROHhTgUHpFeWsUXnDh8fRZXsLNuu8zy83TFhQryn3yFtOq47
        kfsOfUl3KnKh6Y6Gp4mYfIn3VBPnHcxSHg==
X-Google-Smtp-Source: ABdhPJx3cysfVNgIii3yhMuXfLt9lRGb2hbkhPg2Zk9LB4Y3zRhk+pyO/ts3RsPM+YlIj/P7Sbk19A==
X-Received: by 2002:a17:906:1558:: with SMTP id c24mr28245813ejd.553.1636796391547;
        Sat, 13 Nov 2021 01:39:51 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j11sm3481749ejt.114.2021.11.13.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 01:39:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlpVm-000aeA-Ox;
        Sat, 13 Nov 2021 10:39:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: ab/config-based-hooks-2 etc. (was: What's cooking in git.git (Nov
 2021, #03; Tue, 9))
Date:   Sat, 13 Nov 2021 10:17:06 +0100
References: <xmqqy25wygek.fsf@gitster.g> <YY2W6ESIxSz9lakK@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YY2W6ESIxSz9lakK@google.com>
Message-ID: <211113.86tuggtmvt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 11 2021, Emily Shaffer wrote:

> Once more, updates to submodule-UX-overhaul related work.
>
> On Tue, Nov 09, 2021 at 04:59:31PM -0800, Junio C Hamano wrote:
[...]
>
>> * ab/config-based-hooks-2 (2021-11-01) 18 commits
>>  - run-command: remove old run_hook_{le,ve}() hook API
>>  - receive-pack: convert push-to-checkout hook to hook.h
>>  - read-cache: convert post-index-change to use hook.h
>>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>>  - git-p4: use 'git hook' to run hooks
>>  - send-email: use 'git hook run' for 'sendemail-validate'
>>  - git hook run: add an --ignore-missing flag
>>  - hooks: convert worktree 'post-checkout' hook to hook library
>>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>>  - merge: convert post-merge to use hook.h
>>  - am: convert applypatch-msg to use hook.h
>>  - rebase: convert pre-rebase to use hook.h
>>  - hook API: add a run_hooks_l() wrapper
>>  - am: convert {pre,post}-applypatch to use hook.h
>>  - gc: use hook library for pre-auto-gc hook
>>  - hook API: add a run_hooks() wrapper
>>  - hook: add 'run' subcommand
>>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
>>=20
>>  More "config-based hooks".
>
> I think I owe another review, but as always with these topics, I wrote a
> lot of the code so I'm not sure how much I can really help. Other eyes
> appreciated.

It's quite a bit of work, but one bit of valuable independent
verification would be to take your version of the eventual patches that
you've got and try to keep a version rebased on top of these
submissions.

As a spoiler my version is (you'll need gitster's and my github
remotes):
=20=20=20=20
    git range-diff \
        gitster/ab/config-based-hooks-base..gitster/es/config-based-hooks \
        avar/es-avar/config-based-hooks-7..avar/avar-nasamuffin/config-base=
d-hooks-restart-5

I.e. that's the difference between "your"
https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210909T122802Z-avara=
b@gmail.com/
and what I've currently got. I was intending to find the last version
you'd submitted, but I either missed it or I'd have to apply it from the
ML.

In any case, I've found that when I've made changes to the re-rolled
"base" topic based on on-list feedback that needing to roll those
changes forward can inform whether changes in the "base" are good ideas
or not. I.e. whether subsequent changes on top are just cosmetic, or
would require rewrites or a changed design.

That range-diff above doesn't represent any sort of "good" or ready
state, I've just been making the bare minimal set of changes to keep the
"really config-based" topic compiling and passing tests.

>> * es/superproject-aware-submodules (2021-11-04) 4 commits
>>  - submodule: record superproject gitdir during 'update'
>>  - submodule: record superproject gitdir during absorbgitdirs
>>  - introduce submodule.superprojectGitDir record
>>  - t7400-submodule-basic: modernize inspect() helper
>>=20
>>  A configuration variable in a submodule points at the location of
>>  the superproject it is bound to (RFC).
>
> To summarize the discussion from here: =C3=86var suggested this topic mig=
ht
> not be necessary anymore, and that we should rely on in-process
> discovery of the superproject's gitdir. However, after some more
> thought, I think it's valuable to strive for a definitive way to tell
> "yes, I am a submodule" - and I'd like for this topic to be it. I'm
> planning a reroll (and an explanation in the cover letter), and to drop
> language referring to that as a "cache" (because it isn't a cheap
> version of an operation the submodule would be doing otherwise). I will
> also add another patch to demonstrate how we can use that new
> information as a point of truth, instead of a performance shim.

Hopefully it's clear from the feedback I had there, but my opinion in
this topic is not that I don't think it's unnecessary, I honestly don't
know enough about submodules to say.

Rather that per [1] and [2] for someone who's got that ignorance on the
topic it would be really helpful if we clearly delineate what's a cache
and what's changed behavior.

And even if something is much slower non-cached having a canonical "slow
but correct" path is really valuable, because it may be the case that we
can drop (parts of?) the caching in the future/soon/now if we take the
*.sh<->*.c boundary out of the equation, and at that point being able to
test against the "canonical but slow" version is really helpful.

Especially as a "canonical cache" always runs the risk of what was
assumed to be mere caching becoming changed semantics inadvertently, and
then we'd be stuck with it. Maybe it's good that we'd be stuck with it
(the "point of truth" you mention above), but then let's go into that
behavior change with eyes wide open

1. https://lore.kernel.org/git/211109.86r1bqdsmu.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
