Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D14C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377B360FE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhFPA7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFPA7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:59:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07BC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:57:29 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h5so1196635iok.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rosekunkel-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W3ffi6vVmPCUGa6OZB9U22D9L2CniG+ThlivldP++M8=;
        b=ebt357gPUACAU3/52i2jynIOSe/lClYhLxOo9eNsRCB3rg/Cu0q206jOjLRXvyp/Oq
         gkK5oyz4o5D1gX4jsIryJcel8C//YCHXcE/BqVoQEgwZQzhRn4oLQ7IPDNXKejFb0ux6
         GG+MDGj0ab5gI6GliNxUs2BZlLA8g64RcvoW1g0/Iy5DQx8+GGj3qwHzclzKJOx0aZQb
         EeHsqS4te0n31uH6I9ZQVhvEC6BoUOlB7EObmnfeVN6tUAaGii8YPg2A8gW8gqAVnH2C
         F3oa8L74lGey8VdiDqwkBfrBHErglMwAg0h6mtrNxg4Vui4jqdwhfDoSUqAIf/4f65EM
         wCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W3ffi6vVmPCUGa6OZB9U22D9L2CniG+ThlivldP++M8=;
        b=TeUmLkTxhvx9WV0CskXpXSHS8a92VV69wAumLvODWdbAa0hWudnqrCYqAm1ktWxRU0
         e3x1QfyC6WtHIrptq3M9LDrx6WYjdEXRt9vLEbxIGA/AOO0Au7RUHATj+LKbZ1nuVc2X
         2Bgmod578Y53jVO9cvsBgNpioh3iYsGJRYrrAsq+5lao2uAk4kfTNavXOgU7gkuMja3o
         idaq4xx5RtO+PIcPJixB4fcdmScgxOn4I3D7n8oXbhvuZ0dbh/11ycREIatjPBqK2k9W
         8VHm0Cknct/OMMN7iDrWThMDWaABJlrCNjQaFgtATK4wRcT5fYqO4SLg8OmEO4zueTsC
         4tZQ==
X-Gm-Message-State: AOAM531VXm5d1AWjoTJda666Isynov7mHez/tqVG1TszCXvX1oyQQSES
        8xBvealICGaLZqjOmwI2pDuI4qAfMWKhcRmhcGJ7/d4Ix6DhRQ==
X-Google-Smtp-Source: ABdhPJyYbxFlcD28Y02Rw8Hss82m8nc14IucnOFYSfjyiJ4dAgGBAMb0EiCT5/g8DnIz8MptQiiwjmH/AcK/JQ5fLV8=
X-Received: by 2002:a05:6602:2215:: with SMTP id n21mr1572485ion.80.1623805049266;
 Tue, 15 Jun 2021 17:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
In-Reply-To: <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
From:   Rose Kunkel <rose@rosekunkel.me>
Date:   Tue, 15 Jun 2021 17:57:18 -0700
Message-ID: <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running `git status` in the resulting repository gives
```
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

This is the output from the clone command:
```
Cloning into 'tree-sitter-langs'...
remote: Enumerating objects: 609, done.
remote: Counting objects: 100% (83/83), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 609 (delta 40), reused 58 (delta 24), pack-reused 526
Receiving objects: 100% (609/609), 117.17 KiB | 1.05 MiB/s, done.
Resolving deltas: 100% (322/322), done.
Submodule 'repos/agda'
(https://github.com/tree-sitter/tree-sitter-agda) registered for path
'repos/agda'
Submodule 'repos/bash'
(https://github.com/tree-sitter/tree-sitter-bash) registered for path
'repos/bash'
Submodule 'repos/c' (https://github.com/tree-sitter/tree-sitter-c)
registered for path 'repos/c'
Submodule 'repos/c-sharp'
(https://github.com/tree-sitter/tree-sitter-c-sharp) registered for
path 'repos/c-sharp'
Submodule 'repos/cpp' (https://github.com/tree-sitter/tree-sitter-cpp)
registered for path 'repos/cpp'
Submodule 'repos/css' (https://github.com/tree-sitter/tree-sitter-css)
registered for path 'repos/css'
Submodule 'repos/elm' (https://github.com/razzeee/tree-sitter-elm)
registered for path 'repos/elm'
Submodule 'repos/fluent'
(https://github.com/tree-sitter/tree-sitter-fluent) registered for
path 'repos/fluent'
Submodule 'repos/go' (https://github.com/tree-sitter/tree-sitter-go)
registered for path 'repos/go'
Submodule 'repos/html'
(https://github.com/tree-sitter/tree-sitter-html) registered for path
'repos/html'
Submodule 'repos/janet-simple'
(https://codeberg.org/sogaiu/tree-sitter-janet-simple) registered for
path 'repos/janet-simple'
Submodule 'repos/java'
(https://github.com/tree-sitter/tree-sitter-java) registered for path
'repos/java'
Submodule 'repos/javascript'
(https://github.com/tree-sitter/tree-sitter-javascript) registered for
path 'repos/javascript'
Submodule 'repos/jsdoc'
(https://github.com/tree-sitter/tree-sitter-jsdoc) registered for path
'repos/jsdoc'
Submodule 'repos/json'
(https://github.com/tree-sitter/tree-sitter-json) registered for path
'repos/json'
Submodule 'repos/julia'
(https://github.com/tree-sitter/tree-sitter-julia) registered for path
'repos/julia'
Submodule 'repos/ocaml'
(https://github.com/tree-sitter/tree-sitter-ocaml) registered for path
'repos/ocaml'
Submodule 'repos/php' (https://github.com/tree-sitter/tree-sitter-php)
registered for path 'repos/php'
Submodule 'repos/python'
(https://github.com/tree-sitter/tree-sitter-python) registered for
path 'repos/python'
Submodule 'repos/ruby'
(https://github.com/tree-sitter/tree-sitter-ruby) registered for path
'repos/ruby'
Submodule 'repos/rust'
(https://github.com/tree-sitter/tree-sitter-rust) registered for path
'repos/rust'
Submodule 'repos/scala'
(https://github.com/tree-sitter/tree-sitter-scala) registered for path
'repos/scala'
Submodule 'repos/swift'
(https://github.com/tree-sitter/tree-sitter-swift) registered for path
'repos/swift'
Submodule 'repos/typescript'
(https://github.com/tree-sitter/tree-sitter-typescript) registered for
path 'repos/typescript'
Skipping submodule 'repos/agda'
Skipping submodule 'repos/bash'
Skipping submodule 'repos/c'
Skipping submodule 'repos/c-sharp'
Skipping submodule 'repos/cpp'
Skipping submodule 'repos/css'
Skipping submodule 'repos/elm'
Skipping submodule 'repos/fluent'
Skipping submodule 'repos/go'
Skipping submodule 'repos/html'
Skipping submodule 'repos/janet-simple'
Skipping submodule 'repos/java'
Skipping submodule 'repos/javascript'
Skipping submodule 'repos/jsdoc'
Skipping submodule 'repos/json'
Skipping submodule 'repos/julia'
Skipping submodule 'repos/ocaml'
Skipping submodule 'repos/php'
Skipping submodule 'repos/python'
Skipping submodule 'repos/ruby'
Skipping submodule 'repos/rust'
Skipping submodule 'repos/scala'
Skipping submodule 'repos/swift'
Skipping submodule 'repos/typescript'
```

On Tue, Jun 15, 2021 at 5:51 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-06-16 at 00:16:06, Rose Kunkel wrote:
> > # What did you do before the bug happened? (Steps to reproduce your issue)
> > 1. Clone a git repository that sets `update = none` in .gitmodules:
> > $ git clone --recurse-submodules https://github.com/ubolonton/tree-sitter-langs
> >
> > 2. Perform a hard reset:
> > $ cd tree-sitter-langs
> > $ git reset --hard
> >
> > # What did you expect to happen? (Expected behavior)
> > The reset should succeed and do nothing.
>
> I think we're in agreement on this.  This should be a fresh clone and so
> a hard reset should change nothing.
>
> > # What happened instead? (Actual behavior)
> > The reset command fails with
> > ```
> > fatal: not a git repository: ../../.git/modules/repos/agda
> > fatal: could not reset submodule index
> > ```
>
> Hmmm, I can't reproduce this behavior.  What I see is this:
>
>   $ git reset --hard
>   HEAD is now at 5d362ce Release 0.10.0
>
> I'm running git version 2.32.0.272.g935e593368 on Debian sid (with the
> experimental packages).
>
> Can you try the clone and run a "git status" command in the repository
> to see if anything is modified after your clone?  Are the submodules
> checked out when you perform the clone?  In my case, I see lines like
> this:
>
>   Skipping submodule 'repos/agda'
>
> If you're seeing something different, then that might contribute to the
> different behavior we're seeing.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
