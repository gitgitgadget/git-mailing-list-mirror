Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66CAC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94DB611EE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhFPBSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:18:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE6BC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 18:15:55 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p14so844542ilg.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rosekunkel-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VHGa/BO6MClJMKjfxq0HiMbSv8FInro/rLG7yFR5+WU=;
        b=Hz4YW50yq/tflPpGMKMxpBrhAP3uWoQImP2w0bEFP+3AbMCB/W8RkptsHt7mgqDe6D
         Tcfytd+jlvEPPxE7rvCIdlDwJ93XGfaYKgLU1itZidFPCu34eweDvCOFE9gxe4w+AVfo
         7G0apLWuPBEIpgOCD5VdriQjPQLBSKBMCjF2P75ELbD8eLbglFKH6SEDxwfun59gzeee
         LNKh8uVu68nh1LZ66KOd79dKN6P1sZ5k9C1LrQLehHOpd0nxjAyQUawgSBiRzZtfhgUu
         GxKb5Ht5j9kSRifgWDZqo0e+O9+33y5jlhrfENdxE/rNdkBJLbO+5UkUfZ/kK205gvvl
         0dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VHGa/BO6MClJMKjfxq0HiMbSv8FInro/rLG7yFR5+WU=;
        b=m6XCYp7WQuNVv0/AMhdCS5Dz4Nl9lKfXzlDzYych8CyQvjzNyLIrdGmc+XU7ggQhQ5
         olB3GT/m0horJzG8gTTDIfhuf4PQ5PAw2m4R4WzmsYyY/TZJqLJmgH0xZaiUhSElosrQ
         YvYlfDOWFnvUc64yCMDuYD7tYRc+LROE+uwhz12w2lLZgsDK/zxTNlgJd7POY+0Cjuaz
         gMkfhGqSwsrDtUwaP1esKLQ1R5vpFjfrvgqCDwK/81IqqYLj0TSV56Ntx5PHwow9zSXh
         p4tIheUwjH0wyg4bHVzJIeuhFNTx/+VBNYLrIcxY9atk9v4FxqUYmwlvEjkadVx7qGCQ
         6izA==
X-Gm-Message-State: AOAM5330ove51usaOQxIwg6WkdU7apYQPAJpj3l32Cisdk77K13r6iYE
        A07nI+7YVJWmiSpnxy4Ew1fWsvfu13WZouXpndOQPQ==
X-Google-Smtp-Source: ABdhPJzh1pkYv59p+Is1Fhw4d0gCu2HkiVMYrg5eQOdgvxJ02nSQpfUy7g/c31lSDbjCy0SbX636KIXdNbijP+AFubY=
X-Received: by 2002:a92:190f:: with SMTP id 15mr1550531ilz.45.1623806154968;
 Tue, 15 Jun 2021 18:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net> <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
 <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
In-Reply-To: <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
From:   Rose Kunkel <rose@rosekunkel.me>
Date:   Tue, 15 Jun 2021 18:15:43 -0700
Message-ID: <CAKjYmsFY4+jdvQ5T1UZmXpqvDrgTdy-vF5RD89dFkTqYbB-Ujg@mail.gmail.com>
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I set `submodule.recurse = false` in .git/config, I get the
behavior you're seeing.

On Tue, Jun 15, 2021 at 6:03 PM Rose Kunkel <rose@rosekunkel.me> wrote:
>
> Potentially relevant: `git config --global --list` shows
> ```
> status.showstash=true
> status.submodulesummary=true
> submodule.recurse=true
> user.name=Rose Kunkel
> user.email=rose@rosekunkel.me
> pull.rebase=false
> init.defaultbranch=main
> ```
>
> On Tue, Jun 15, 2021 at 5:57 PM Rose Kunkel <rose@rosekunkel.me> wrote:
> >
> > Running `git status` in the resulting repository gives
> > ```
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > nothing to commit, working tree clean
> > ```
> >
> > This is the output from the clone command:
> > ```
> > Cloning into 'tree-sitter-langs'...
> > remote: Enumerating objects: 609, done.
> > remote: Counting objects: 100% (83/83), done.
> > remote: Compressing objects: 100% (52/52), done.
> > remote: Total 609 (delta 40), reused 58 (delta 24), pack-reused 526
> > Receiving objects: 100% (609/609), 117.17 KiB | 1.05 MiB/s, done.
> > Resolving deltas: 100% (322/322), done.
> > Submodule 'repos/agda'
> > (https://github.com/tree-sitter/tree-sitter-agda) registered for path
> > 'repos/agda'
> > Submodule 'repos/bash'
> > (https://github.com/tree-sitter/tree-sitter-bash) registered for path
> > 'repos/bash'
> > Submodule 'repos/c' (https://github.com/tree-sitter/tree-sitter-c)
> > registered for path 'repos/c'
> > Submodule 'repos/c-sharp'
> > (https://github.com/tree-sitter/tree-sitter-c-sharp) registered for
> > path 'repos/c-sharp'
> > Submodule 'repos/cpp' (https://github.com/tree-sitter/tree-sitter-cpp)
> > registered for path 'repos/cpp'
> > Submodule 'repos/css' (https://github.com/tree-sitter/tree-sitter-css)
> > registered for path 'repos/css'
> > Submodule 'repos/elm' (https://github.com/razzeee/tree-sitter-elm)
> > registered for path 'repos/elm'
> > Submodule 'repos/fluent'
> > (https://github.com/tree-sitter/tree-sitter-fluent) registered for
> > path 'repos/fluent'
> > Submodule 'repos/go' (https://github.com/tree-sitter/tree-sitter-go)
> > registered for path 'repos/go'
> > Submodule 'repos/html'
> > (https://github.com/tree-sitter/tree-sitter-html) registered for path
> > 'repos/html'
> > Submodule 'repos/janet-simple'
> > (https://codeberg.org/sogaiu/tree-sitter-janet-simple) registered for
> > path 'repos/janet-simple'
> > Submodule 'repos/java'
> > (https://github.com/tree-sitter/tree-sitter-java) registered for path
> > 'repos/java'
> > Submodule 'repos/javascript'
> > (https://github.com/tree-sitter/tree-sitter-javascript) registered for
> > path 'repos/javascript'
> > Submodule 'repos/jsdoc'
> > (https://github.com/tree-sitter/tree-sitter-jsdoc) registered for path
> > 'repos/jsdoc'
> > Submodule 'repos/json'
> > (https://github.com/tree-sitter/tree-sitter-json) registered for path
> > 'repos/json'
> > Submodule 'repos/julia'
> > (https://github.com/tree-sitter/tree-sitter-julia) registered for path
> > 'repos/julia'
> > Submodule 'repos/ocaml'
> > (https://github.com/tree-sitter/tree-sitter-ocaml) registered for path
> > 'repos/ocaml'
> > Submodule 'repos/php' (https://github.com/tree-sitter/tree-sitter-php)
> > registered for path 'repos/php'
> > Submodule 'repos/python'
> > (https://github.com/tree-sitter/tree-sitter-python) registered for
> > path 'repos/python'
> > Submodule 'repos/ruby'
> > (https://github.com/tree-sitter/tree-sitter-ruby) registered for path
> > 'repos/ruby'
> > Submodule 'repos/rust'
> > (https://github.com/tree-sitter/tree-sitter-rust) registered for path
> > 'repos/rust'
> > Submodule 'repos/scala'
> > (https://github.com/tree-sitter/tree-sitter-scala) registered for path
> > 'repos/scala'
> > Submodule 'repos/swift'
> > (https://github.com/tree-sitter/tree-sitter-swift) registered for path
> > 'repos/swift'
> > Submodule 'repos/typescript'
> > (https://github.com/tree-sitter/tree-sitter-typescript) registered for
> > path 'repos/typescript'
> > Skipping submodule 'repos/agda'
> > Skipping submodule 'repos/bash'
> > Skipping submodule 'repos/c'
> > Skipping submodule 'repos/c-sharp'
> > Skipping submodule 'repos/cpp'
> > Skipping submodule 'repos/css'
> > Skipping submodule 'repos/elm'
> > Skipping submodule 'repos/fluent'
> > Skipping submodule 'repos/go'
> > Skipping submodule 'repos/html'
> > Skipping submodule 'repos/janet-simple'
> > Skipping submodule 'repos/java'
> > Skipping submodule 'repos/javascript'
> > Skipping submodule 'repos/jsdoc'
> > Skipping submodule 'repos/json'
> > Skipping submodule 'repos/julia'
> > Skipping submodule 'repos/ocaml'
> > Skipping submodule 'repos/php'
> > Skipping submodule 'repos/python'
> > Skipping submodule 'repos/ruby'
> > Skipping submodule 'repos/rust'
> > Skipping submodule 'repos/scala'
> > Skipping submodule 'repos/swift'
> > Skipping submodule 'repos/typescript'
> > ```
> >
> > On Tue, Jun 15, 2021 at 5:51 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > On 2021-06-16 at 00:16:06, Rose Kunkel wrote:
> > > > # What did you do before the bug happened? (Steps to reproduce your issue)
> > > > 1. Clone a git repository that sets `update = none` in .gitmodules:
> > > > $ git clone --recurse-submodules https://github.com/ubolonton/tree-sitter-langs
> > > >
> > > > 2. Perform a hard reset:
> > > > $ cd tree-sitter-langs
> > > > $ git reset --hard
> > > >
> > > > # What did you expect to happen? (Expected behavior)
> > > > The reset should succeed and do nothing.
> > >
> > > I think we're in agreement on this.  This should be a fresh clone and so
> > > a hard reset should change nothing.
> > >
> > > > # What happened instead? (Actual behavior)
> > > > The reset command fails with
> > > > ```
> > > > fatal: not a git repository: ../../.git/modules/repos/agda
> > > > fatal: could not reset submodule index
> > > > ```
> > >
> > > Hmmm, I can't reproduce this behavior.  What I see is this:
> > >
> > >   $ git reset --hard
> > >   HEAD is now at 5d362ce Release 0.10.0
> > >
> > > I'm running git version 2.32.0.272.g935e593368 on Debian sid (with the
> > > experimental packages).
> > >
> > > Can you try the clone and run a "git status" command in the repository
> > > to see if anything is modified after your clone?  Are the submodules
> > > checked out when you perform the clone?  In my case, I see lines like
> > > this:
> > >
> > >   Skipping submodule 'repos/agda'
> > >
> > > If you're seeing something different, then that might contribute to the
> > > different behavior we're seeing.
> > > --
> > > brian m. carlson (he/him or they/them)
> > > Toronto, Ontario, CA
