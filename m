Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B69C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 09:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLRJhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 04:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRJhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 04:37:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E036384
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 01:37:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v8so9180861edi.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLnRl/7uafDzUoOUhQYBUf64oUiDr0iTiEKGo5dsgsQ=;
        b=mWjwG/mK30608aTt/7U6KK8wQBT1InFlzZmaeWX5dBPgVhCfMr/U84KI3V8j/QbNUL
         +ZcCDLaWz1p+v47T2NEpXbkh98OnBOiNsLHaXQ/zQbqmSAoHm120OfMGq2SiOVDusXbc
         D/JV3XdEuFKYztVtRpa25gynSp8R3y7QtKEz5o3HQ2a6s98TejO+zgTsPQwejg4IS1Ax
         nG7ESn5mKD8rVvJZJpDk0rRxzxNIyZAELsvS6CE59jn1UKiHifZZwQw3miZHlwUVBLk+
         kqY959wPPxLrAOTHC6qpvVg6feeFYfvDe55KM8hMQtU4niIIPGaPNet/djVPwdRT8F0B
         b29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLnRl/7uafDzUoOUhQYBUf64oUiDr0iTiEKGo5dsgsQ=;
        b=rXBBOzpTARMsCRZ3pXPmx5T+AwM5AHkN8V6ivrW3q1vfmEEjUI+U3vqzzwPxUv7Gq4
         y2TUGlMUs/RkG9BAiJDZVR+pJgHDdoKS0Vx/Q2/C7rvJ90Ky1H6MckoAtO2LppkYd/px
         sMW7qXpZMU672a6O/KlMbs90tK96TpP5J4ViBJyKj4xZ2uVwDbOLKhhVn7eskoNK/wQ5
         b4MVS6tyirJ4cc4/QuonQ4cmXMP0zE8BR+zCHiqLkK9vkFBZQhddX4dvE0YZzjBFX3c5
         1Sqm9x5s5nFb13PXb7XDhIIl/qdtB5B4dpBbBd5ToowhmG9Vva94hNNV+njjHh52nNPP
         ussg==
X-Gm-Message-State: ANoB5pln1yJQWrYn6dy5uuyc0gHkjudD+z5tBdgBmVpPacnq+CsHseN8
        zPsYBreZoxvouyhFl77fsJOqxJWH+0E=
X-Google-Smtp-Source: AA0mqf6nZvZpLpCShPpRytD+xsXxe14WOVavTg0nsK9zLXFgatigIMsqtNUDPbDzjEqKjNyBCIwFSA==
X-Received: by 2002:a05:6402:4cf:b0:463:c960:7589 with SMTP id n15-20020a05640204cf00b00463c9607589mr31079657edw.40.1671356256393;
        Sun, 18 Dec 2022 01:37:36 -0800 (PST)
Received: from localhost (78-131-14-113.pool.digikabel.hu. [78.131.14.113])
        by smtp.gmail.com with ESMTPSA id cy28-20020a0564021c9c00b00463597d2c25sm2960760edb.74.2022.12.18.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 01:37:35 -0800 (PST)
Date:   Sun, 18 Dec 2022 10:37:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Askar Safin <safinaskar@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: https://github.com/rust-lang/rust is not bisectable
Message-ID: <20221218093734.GC3411@szeder.dev>
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
 <878rj6rnuo.fsf@igel.home>
 <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 18, 2022 at 06:15:44AM +0300, Askar Safin wrote:
> At some point that "bootstrap" word appeared, then at some point it
> disappeared again. I'm trying to find a point where it has
> disappeared. Consider this script:
> 
> ==begin
> #!/bin/bash
> 
> set -e
> set -x
> 
> git bisect reset
> git bisect start
> git bisect good 7175c499ecc32cb3ff713be0bbac9fd12990a34e
> git bisect bad 49c2279ef658d8732597c4da93897d84838f3df5
> 
> while :; do
>   if grep -q bootstrap compiler/rustc_target/src/abi/mod.rs; then
>     git bisect good
>   else
>     git bisect bad
>   fi
>   sleep 1
> done
> ==end
> 
> Here is the output: https://paste.debian.net/1264444/ . As you can
> see, we always choose "else git bisect bad". And we reach... initial
> commit!

Yeah, but as you can see from all those

  grep: compiler/rustc_target/src/abi/mod.rs: No such file or directory

error messages, it didn't choose bad because "bootstrap" was not
present in the file in question, but because the file in question was
not present in the examined revision in the first place!  You must
take this into consideration when deciding whether a revision is good
or bad.

> Well, technically speaking, this is correct: initial commit is
> actually the first commit, where word "bootstrap" is not present in
> compiler/rustc_target/src/abi/mod.rs . But this is not what I want! I
> want to find commit, which is the first one, which doesn't have
> "bootstrap" in compiler/rustc_target/src/abi/mod.rs, AND which is
> descendant of good commit ( 7175c499ecc32cb3ff713be0bbac9fd12990a34e
> ).

No, you want to find the first commit which does contain a file 
compiler/rustc_target/src/abi/mod.rs, and where that file doesn't
contain "bootstrap".

  $ git bisect start 49c2279ef658d8732597c4da93897d84838f3df5 7175c499ecc32cb3ff713be0bbac9fd12990a34e
  Bisecting: 23901 revisions left to test after this (roughly 15 steps)
  [26562973b3482a635416b2b663a13016d4d90e20] Auto merge of #13653 - VannTen:fix/doc-typo-vim-lsp, r=Veykril
  $ cat run.sh
  #!/bin/sh
  
  file="compiler/rustc_target/src/abi/mod.rs"
  if test ! -f "$file"
  then
  	echo "  !!!  missing $file"
  elif grep -q bootstrap "$file"
  then
  	echo "  +++  found bootstrap in $file"
  else
  	echo "  ---  no bootstrap in $file"
  	false
  fi
  $ git bisect run ./run.sh
  running './run.sh'
    !!!  missing compiler/rustc_target/src/abi/mod.rs
  Bisecting: 11961 revisions left to test after this (roughly 14 steps)
  [7a8636c843bd24038fe1d1f69b4a8e4b0ea55d4e] Auto merge of #100982 - fee1-dead-contrib:const-impl-requires-const-trait, r=oli-obk
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 5974 revisions left to test after this (roughly 13 steps)
  [335e7d3e33300942ce99e7010a31ad4c1086a36a] Rollup merge of #98745 - thomcc:build-dir-arg, r=jyn514
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 2980 revisions left to test after this (roughly 12 steps)
  [512a328e2fb32bddd206461770a2c058368519cc] Auto merge of #95309 - lcnr:dropck-cleanup, r=nikomatsakis
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 1485 revisions left to test after this (roughly 11 steps)
  [143eaa8d441641251ab41ed73deaba0d8d0cf4a5] Auto merge of #93970 - cjgillot:novis, r=petrochenkov
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 748 revisions left to test after this (roughly 10 steps)
  [198a1548ea4c25e3756d70bb2cafed6bb1860d6a] Rollup merge of #95369 - jyn514:test-rustdoc, r=Mark-Simulacrum
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 374 revisions left to test after this (roughly 9 steps)
  [3c2f864ffbf0e3d01f3f684acbd0ee602619bf19] session: opt for enabling directionality markers
  running './run.sh'
    +++  found bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 186 revisions left to test after this (roughly 8 steps)
  [7b285d09e9e4ccf8273cc03dba28e8a428e6084e] Rollup merge of #95791 - oconnor663:doc_comment, r=thomcc
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 93 revisions left to test after this (roughly 7 steps)
  [201cf3dba302cec9b62e9b988858dcad47a88a4f] Auto merge of #95723 - SparrowLii:const_goto, r=fee1-dead
  running './run.sh'
    +++  found bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 47 revisions left to test after this (roughly 6 steps)
  [2e4964ed3d6a4de97b863777f97c7790808afce3] Rollup merge of #95714 - KSBilodeau:master, r=Dylan-DPC
  running './run.sh'
    +++  found bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 23 revisions left to test after this (roughly 5 steps)
  [ed6c958ee4bf081deec951996ace9c508360c1d9] Auto merge of #95760 - Dylan-DPC:rollup-uskzggh, r=Dylan-DPC
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 12 revisions left to test after this (roughly 4 steps)
  [870ab12ea7976ad3c56eac6f0559b122e0f055c5] Rollup merge of #95752 - compiler-errors:issue-82866, r=Dylan-DPC
  running './run.sh'
    +++  found bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 6 revisions left to test after this (roughly 3 steps)
  [73dc13058d37ebcfcdde46e7f63c4c69bd26685d] remove ~const Drop from rustdoc test
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 2 revisions left to test after this (roughly 2 steps)
  [b744bb67fdfd3e34404cc9df1d87acdfdb4a0cb4] rustc_trait_selection changes
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 0 revisions left to test after this (roughly 1 step)
  [181d28bb6110dc974879db20d433f21aa142db3a] trivial cfg(bootstrap) changes
  running './run.sh'
    ---  no bootstrap in compiler/rustc_target/src/abi/mod.rs
  Bisecting: 0 revisions left to test after this (roughly 0 steps)
  [e96538aeeb2a71e672e1d1a40dcaf0ad34a826b5] bump stage0 to the latest beta
  running './run.sh'
    +++  found bootstrap in compiler/rustc_target/src/abi/mod.rs
  181d28bb6110dc974879db20d433f21aa142db3a is the first bad commit
  commit 181d28bb6110dc974879db20d433f21aa142db3a
  Author: Pietro Albini <pietro@pietroalbini.org>
  Date:   Tue Apr 5 22:42:23 2022 +0200
  
      trivial cfg(bootstrap) changes
  
  [ ... diffstat ... ]
  bisect found first bad commit

