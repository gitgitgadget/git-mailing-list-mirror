Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C0C4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4C960F38
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhH3Ajx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbhH3Ajx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:39:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16596C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:39:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e21so27495728ejz.12
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITPUN7xeM1PtbKuLTo3WhQP3T2kpwFeQ1G35Q9nR1LI=;
        b=Pt/NYrcGKVLjGg7nGM6vPJi4gqNu0rGjD+h8I8TkeZQ2Hl1l/dB3FqDfQiZxciexFD
         xaxV7V1AuedfDm+ilV9zL6tBSLO5oAsc1xCFASeidl3UHpyAnAT5S6kffLLrPsTUM4fg
         5qMOCFQhIZGDkSMJYZK5i4ihQx12DWeP3T754LJuSqLziR75a4daNZTpjB/zZX0bzBus
         mLHV0yAffaVhjSzof2BQGoOWJaUnoBKxz7dfVc7TQDGYeKzYtxz9SPAGwJuxE0QL1CQA
         Q+wGpsR+dcljJu3ZEDP/T0bFhBhqTRLgWHYsgl7SjnOaPdwkd7NlTa3xRaCQP6lg4wRL
         SOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITPUN7xeM1PtbKuLTo3WhQP3T2kpwFeQ1G35Q9nR1LI=;
        b=LNqdPYPY/4jXdc4c1wOSGwePI+u7+vehrDaOwZrxfbb/iAsyBIoT6ghNtLZa14+1MI
         4ziS5QTZXyS9JaH+/z/16cwSA6cD4lIa2Kyp0mak0Dxzi3C1Fzimhr6PdbvBSFymAOL7
         y5qh8IFu1VLIlef4HbxwCvEHmZ5F7wVGjLsHU8aaIhRQ0vN1ytJy1oW7cTkZ2a7ni9pZ
         Isr08jSBGTfyFdw4F/yadL1ptwDMnVEm3iUjwweOqj6JLy+3soJGyVEx9FdQf81sxisn
         gJFvWkMdgjEc+m3LuxkDChEWNF+hyzzWsvDWOh3pwr8KlO1ux82vPdzgbXrAU7Ds8W51
         t1lQ==
X-Gm-Message-State: AOAM530lNzzV35OgLdQ4h8QTNci52glihzvmO2yh2n2eduxIC03+1RN9
        R+zbCMoT9i34n0PFoCOh/hC7eMVIl0lU196hFKQ20U5t
X-Google-Smtp-Source: ABdhPJwC2yxIUfOLdekBTLPCZliiFwiPeuS0rknW3Fnb89DWKiHdo+v+aQX3U5BJu1dEwFCAuFzR9NZVqvZ0FlqKQ3o=
X-Received: by 2002:a17:906:49d5:: with SMTP id w21mr22059869ejv.30.1630283938596;
 Sun, 29 Aug 2021 17:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net> <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
In-Reply-To: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 29 Aug 2021 17:38:21 -0700
Message-ID: <CAJDDKr7vXRxhwuTN=xFxqQkt_zt_Hpi3bYfc7rotcUAFjau9Sg@mail.gmail.com>
Subject: Re: Bug: All git operations fail when .git contains a non-existent gitdir
To:     Tom Cook <tom.k.cook@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 6:16 AM Tom Cook <tom.k.cook@gmail.com> wrote:
>
> The easiest way to reproduce it is this:
>
> $ mkdir test
> $ cd test
> $ echo "gitdir: /foo/bar" > .git
> $ git ls-remote https://github.com/torvalds/linux
>
> We happen to use overlay mounts in our build system in a way that maps
> a git submodule from one place to another so that its "gitdir" is
> invalid and then attempt a `git ls-remote` from that location which
> unexpectedly fails.  But the above reproduces the problem well enough.

I'm making a guess about your setup. To me it sounds like tweaking the
overlayfs or bind mounts to also map the .git directory of the parent
repository (at just the right relative location inside the build
environment) is the right approach towards making the .git-file links
happy.

Submodules point to the parent repository's .git/modules/ directory
these days so poking those paths through into the mapped file system
is the solution that's going to lead to the least amount of
hard-to-diagnose issues in the future.

The .git-file uses relative paths so it is possible to remap and
relocate them as you're doing, but it's going to require another mount
in the right relative location to do it.

It seems doable, even for most edge cases. For example if you end up
mapping some/deeply/nested/submod into /shallow inside your
container(?) and the .git-file contains
"../../../../.git/modules/submod", that might seem impossible to
resolve from a "/shallow" directory, but actually it's fine.

The solution in that situation is to map the parent repo's .git/ dir
to the "/.git" filesystem root inside the build environment. Unix
treats "/../../../../../../" as equivalent to "/" so if the .git-file
has a bunch of "../../../" parent-dir traversing going on then it'll
still work from a one-level deep "/shallow" directory. The parent git
repo directory would be expected to be found at "/.git" (with a
"modules" directory inside it) because the parent directory of "/" is
also "/".

This should mesh right in with the setup you described because you're
already using overlay mounts to synthesize a filesystem.

There are edge cases where this approach breaks down, though. One of
these cases is submodules inside submodules. Luckily it doesn't sound
like you have that problem.

There are patches now that special-case being able to run ls-remote
<url> in a broken setup, but the real fix is to extend the build
environment's filesystem view so that the submodules have access to
the underlying .git/modules/ storage.

Hopefully it's just a --mount or --volume docker(?) command-line flag
that has to be extended to poke the parent .git/ repository contents
into the environment. That's the avenue I would explore if I were
already down a path of using mount tricks.

I hope that helps and maybe sparks an idea that you can run with. I
certainly don't mean it to be a dismissive, "go change your setup"
kind of advice, but it would be interesting to know more details since
it seems like achieving correctness is going to require doing that
based on the limited information in this thread about the specifics of
the setup.

Also, I wouldn't be surprised if, even after the "git ls-remote"
robustness fixes are applied, you'll just stumble onto the next git
command that can only be resolved by mapping in the parent repo's .git
directory.

--
David
