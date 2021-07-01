Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE72C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260F361410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhGAWLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhGAWLn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:11:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B248C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:09:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hp26so199298ejc.6
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Io5JI6U+XZ5E72YwMtHHd7BWLNk22Napn38+vExNL2k=;
        b=L7o97M7HxJHYjDqnEXsnmp/XXJBSj1e/b3amRkn5blNyzZRl0/pObBln+7kMq9S0LK
         PQ2R7TwhpgOjP7LlYEtggo9RsuXGePh9TcmZQkfg4UXI2YjpAuBsfoU96xCdENZzV5SB
         cCSOhyK0Kc5JrLr9FATNv8H1320vIg/rTc/rUWJKFnfb6qGIO68wDYs50FawSwNzG8kc
         8hlEFc8RTJTtJQ1gHID12wWhYcrjkVOIvtL2+9H54m8P+7CghLKV/L4uVxkLFEJ3HJ36
         rTTfXZRJZ5GN8UG19IhnCow+o9SMrbXHr68opX5O1iKGQ3FODqBfTbDx294mADS4RG1O
         Qaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Io5JI6U+XZ5E72YwMtHHd7BWLNk22Napn38+vExNL2k=;
        b=pD5ZkaSYww2yPqC6iiiA4dX8UXS5xkA2ESFbrg/FltMGzs1KaVNAhcnZeTl/Fcvq/d
         fEqlf330/6Ein4Eg3jqhDYf2UWKapgh4i6HBQq2ky01jhHTESs2OKUhnLd30R5JPNEBG
         td9U0qbf4XP+MnK11p0xR0qrHlV1SqWPXXOPJlOolPj5/LVvnNrky9QecYDMhUhY4oft
         JtHHVqCD14s2oanc2s+JOsx/GAw7nBD4+pb0Dnbvinocl7FzBmpQgURvkovIiCvPzgeW
         toQl9Tl9MAjx1qn6eVhtY2PZKItO7hXpj+JREToQPkdBGjPzeVSaw0kHY42pp44gjvt9
         Acbw==
X-Gm-Message-State: AOAM530RKBnTbv7JaDqHHnGEUs7CoDgcUBjPwBetsuDMQF+bQtVMkdxx
        fW5jniygKFni+LZ6VGtuT+U=
X-Google-Smtp-Source: ABdhPJxsNRX6tPYwQ6nkkKOqcHnffDi4g7CEO5q4/Si2qVLxUjGEUtmUMWrcM/gN47P1XSRF/RY86w==
X-Received: by 2002:a17:906:3656:: with SMTP id r22mr2043004ejb.441.1625177350770;
        Thu, 01 Jul 2021 15:09:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o21sm464896eds.10.2021.07.01.15.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:09:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
Date:   Thu, 01 Jul 2021 23:26:06 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <87fswyc4dz.fsf@evledraar.gmail.com>
        <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
Message-ID: <87czs1d6uy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler wrote:

> On 7/1/21 1:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> Here is V3 of my patch series to add a builtin FSMonitor daemon to Git.=
 I
>>> rebased this series onto v2.32.0.
>>>
>>> V3 addresses most of the previous review comments and things we've lear=
ned
>>> from our experimental testing of V2. (A version of V2 was shipped as an
>>> experimental feature in the v2.32.0-based releases of Git for Windows a=
nd
>>> VFS for Git.)
>>>
>>> There are still a few items that I need to address, but that list is ge=
tting
>>> very short.
>> ...
>>>    fsmonitor-fs-listen-win32: stub in backend for Windows
>>>    fsmonitor-fs-listen-macos: stub in backend for MacOS
>> I left some light comments on the repo-settings.c part of this to
>> follow
>> up from a previous round.
>
> Thanks.
>
>> Any other testing of it is stalled by there being no linux backend
>> for
>> it as part of this series. I see from spelunking repos that Johannes had
>> a WIP compat/fsmonitor/linux.c which looks like it could/should mostly
>> work, but the API names all changed since then, and after a short try I
>> gave up on trying to rebase it.
>
> The early Linux version was dropped because inotify does not give
> recursive coverage -- only the requested directory.  Using inotify
> requires adding a watch to each subdirectory (recursively) in the
> worktree.  There's a system limit on the maximum number of watched
> directories (defaults to 8K IIRC) and that limit is system-wide.
>
> Since the whole point was to support large very large repos, using
> inotify was a non-starter, so I removed the Linux version from our
> patch series.  For example, the first repo I tried it on (outside
> of the test suite) had 25K subdirectories.
>
> I'm told there is a new fanotify API in recent Linux kernels that
> is a better fit for what we need, but we haven't had time to investigate
> it yet.

That default limit is a bit annoying, but I don't see how it's a blocker
in any way.

You simply adjust the limit. E.g. I deployed and tested the hook version
of inotify (using watchman) in a sizable development environment, and
written my own code using the API. This was all before fanotify(7)
existed. IIRC I set most of the limits to 2^24 or 2^20. I've used it
with really large Git repos, including with David Turner's
2015-04-03-1M-git for testing (`git ls-files | wc -l` on that is around
a quarter-million).

If you have a humongous repository and don't have root on your own
machine you're out of luck. But I think most people who'd use this are
either using their own laptop, or e.g. in a corporate setting where
administrators would tweak the sysctl limits given the performance
advantages (as I did).

Once you adjust the limits Linux deals with large trees just fine, it
just has overly conservative limits for most things in sysctl. The API
is a bit annoying, your event loop needs to run around and add watches.

AFAICT you need Linux 5.1 for fanotify(7) to be useful, e.g. Debian
stable, RHEL etc. aren't using anything that new. So having an inotify
backend as well as possibly a fanotify one would be very useful.

And linux.git's docs suggest that the default limit was bumped from 8192
to 1M in v5.10, a really recent kernel, so if you've got that you've
also got fanotify.

In any case, even if Linux's inotify limit was something hardcoded and
impossible to change you could still use such an API to test & debug the
basics of this feature on that platform.

>> I'd really prefer for git not to have features that place free
>> platforms
>> at a disadvantage against proprietary platforms if it can be avoided,
>> and in this case the lack of a Linux backend also means much less
>> widespread testing of the feature among the development community / CI.
>>=20
>
> This feature is always going to have platform-specific components,
> so the lack of one platform or another should not stop us from
> discussing it for the platforms that can be supported.

(I think per the above that's s/can be/are/)

> And given the size and complexity of the platform-specific code,
> we should not assume that "just test it on Linux" is sufficient.
> Yes, there are some common/shared routines/data structures in the
> daemon, but hard/tricky parts are in the platform layer.

I think we're talking past each other a bit here. I'm not saying that
you can get full or meaningful testing for it on Windows if you test it
on Linux, or the other way around.

Of course there's platform-specific stuff, although there's also a lot
of non-platform-specific stuff, so even a very basic implementation of
inotify would make reviwing this easier / give access to more reviewers.

I'm saying that I prefer that Git as a free software project not be in
the situation of saying the best use-case for a given size/shape of repo
is to use Git in combination with proprietary operating systems over
freely licensed ones.

IOW what the FSF has a policy for GNU projects. Now, I think the FSF
probably goes too far in that (famously removing rather obscure font
rendering features from Emacs on OSX), but "manage lots of data" is a
core feature of git.

