Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC9C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B12E61001
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 22:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFTWLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 18:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFTWLc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 18:11:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFCC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 15:09:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id df12so13838541edb.2
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5ArrEio9Bt+FEl0nEHOiDgteOeJ4lr/NNdE12K6qC2Q=;
        b=jiC4pKSoUC4s0/WsOFyxagni+Tu67SFRT46Nth6AF7o/r25sJ0vU0t3Jud2KU7YVCw
         pskDI6jnVx0z5g/O9KhQFCKtF6SqsqNXAyN/wUXu527fISCCRRz4F9f5n/3vILtZXZtx
         L4S/G7K1X+xF1tzvVysgmv0pX9ROomle9m7+sLcTCLS0GY1K/vUxu1XtAfYUg2qr4Dx3
         Cu2L6iiOlMcnTzCGnyeTKOassxTjiCwzF2Wda8hEKtTf8gIG6OBE+dbn3h7/OEL6HWVP
         y1o5lhfYK3B7xUtL+kCeSxij1EuslootrSppAQ1N5Wii6YRqO6FTl4mBTUCyIRnD+E6V
         hrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5ArrEio9Bt+FEl0nEHOiDgteOeJ4lr/NNdE12K6qC2Q=;
        b=dPA7JU8BD70xfaaPQCsrNUXWXjX3IskmIgAzCXv+CRmEv2xzO7wummAM6d7ZIW8VY+
         sxS9yBuiGqS9AIaW7aPYCObOXK1QNJJf7aW5toixf2/2bln60EPdURPkVqkcfSMCVE8G
         BrvTrolJ37yFNt0Fggu336nl6pyJ2JuIiHgE+HVV6dy/G95P5uFO6LbG+GLHyjM8D2KY
         FlmQffdQqIN1HKFJLA9js+QCfhqoepkYBcGfbrApZfyrfTw8m4Pn/k3ZPTHhojy125Wi
         rIHGWWaQ6NMwn4Y5HW8n3cQkPBomFWubktus2DDlki2UKoYrioE2VfmitQO4rv6js3vx
         npOw==
X-Gm-Message-State: AOAM531H3vdCDXCfhNwCI3H+/FaYjw1qVHavSirohWAc6CrFQZCroog6
        FyxqgbRYlcU56QzlsLKANEA=
X-Google-Smtp-Source: ABdhPJxVPfBp1gld/62Hzo4FkxDp2rfxuaHDUuXV9e1XrEGsOUp7PtA5gxl62wxUO+4BwKSA3+FiMA==
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr3880984eds.143.1624226956228;
        Sun, 20 Jun 2021 15:09:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jz27sm3978092ejc.33.2021.06.20.15.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 15:09:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Hutt <tdhutt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: branch checkout is detached if the case doesn't match
Date:   Mon, 21 Jun 2021 00:03:41 +0200
References: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
Message-ID: <87czsg429h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 20 2021, Tim Hutt wrote:

> If you try to switch to a branch (e.g. `master`), but get the case wrong, e.g:
>
>     git switch MASTER
>     git checkout MASTER
>     git switch Master
>     git checkout Master
>
> etc. then it autocorrects the case (bad idea but ok), but it also
> enables the `--detach` flag! In other words
>
>     git switch Master
>
> acts like
>
>     git switch -d master
>
> Very unexpected!

This behavior isn't intentionaly, but ultimately isn't with Git, but
with your running of Git on a filesystem that doesn't respect POSIX
semantics.

The default FS on OSX is case insensitive, we store the "master"
reference (unpacked) under that name on the FS, so this is emergent
behavior. Can you reproduce this after a:

    git pack-refs --all

?

Even after that we'll have a .git/HEAD, and I know on OSX e.g. "git log
head...<branch>" unintentionally resolved to "HEAD" too at some point
(probably still).

There's various workarounds in git's code to deal with funny behavior on
OSX, but it's hard to catch them all as it means having to second-guess
standard library calls. I think you're best off creating a
case-sensitive partition on your computer and using git there if you
want to avoid these cases entirely.

> [System Info]
> git version:
> git version 2.32.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Fri Mar  5 01:14:14
> PST 2021; root:xnu-7195.101.1~3/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.5 (clang-1205.0.22.9)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
> [Enabled Hooks]

