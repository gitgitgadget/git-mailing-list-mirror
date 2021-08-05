Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF55C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 03:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7561078
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 03:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhHEDQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbhHEDQv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 23:16:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8D2C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 20:16:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so6548704pjh.3
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Zp5AaJxdX8xxWNzTGuh0QIpxMBtixVmiRtXDLvf8YE=;
        b=JssqboUa3EzekPDMG+SmG0AfEU1upEgmqv4Pew8e22ZP5X1Q4/8oksqr4Szr4ttzZw
         w6Z1kIeTO6RZhxwZYwPlkwSHmZmC9f4dpjNXha5Nj8lspPhZsRh6cl550rMwQ8vGeHri
         ycNVEXBbBhl66XHqcAe36pCu5p/JbhBtxBIOLfuSlZ6AIbg3cuk3Havx4cBABaKI7rdK
         yTRSuV3oo6JlbTTkbS0X7MeQ+qotC8/l4Kmn1BDaP9JYtvoYAkVCgW267b2EU9hSfhnD
         ly4oEThMA/eLom0NUUh/Qwh/FGyf9IacytifSnwPrf46eby31zFlKrSYEzLd/7VjgKdZ
         5pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Zp5AaJxdX8xxWNzTGuh0QIpxMBtixVmiRtXDLvf8YE=;
        b=tZug9HyrGYtqfr/Hxthmayg3gHSCyfbnOMzcawBY3zCEw8asXNwJPR7EQG3pCPBdcF
         p7t55M/hdktMIi9Uc4bO6z131Ws2oaDMUDTHU1XWNzEyqDQAGJAR/VpT9meaZ1ooaxIx
         r+mFt6K6lLMBmmJ2DWFf58c42TS/yRVpNFddkk6aF2xah4cKXpnzvh3DDpmeAK3DMdfD
         ybf6YioCytaHtlwPlKkmvz07I7TuZcF1uy1HvwUMvwq8SvrRmhbTj4MUIsYJ9AEAGzyH
         TocQnJyPj5hQxyVIfiZodJMKe0A7MmT9QeZ611YFmxUP8dvh1bXSaRTOEtUxPm/zFrff
         SIgA==
X-Gm-Message-State: AOAM531YTYLDXWm7rVJA07cmu/+SNJVzD90/VhqyLiRIxMK+Lw8WW841
        m39Z+mvMdA7R/KKtH+wU78M=
X-Google-Smtp-Source: ABdhPJyKKIEp1OlUAWcNZYRmeG1cQg1Lmcosjdp6RBr5ITcSpZ8NttM76ulKK1tWkNBe5pM8E8z3JA==
X-Received: by 2002:aa7:8bd4:0:b029:3b4:d3d4:2ecd with SMTP id s20-20020aa78bd40000b02903b4d3d42ecdmr2587868pfd.58.1628133396943;
        Wed, 04 Aug 2021 20:16:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:f138:fa21:11ea:ee0a])
        by smtp.gmail.com with ESMTPSA id g25sm4532236pfk.138.2021.08.04.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 20:16:36 -0700 (PDT)
Date:   Wed, 4 Aug 2021 20:16:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>, Taylor Yu <tlyu@mit.edu>
Subject: Re: [PATCH v3 10/10] diff-merges: let "-m" imply "-p"
Message-ID: <YQtYEftByY8cNMml@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520214703.27323-11-sorganov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

Sergey Organov wrote:

> Fix long standing inconsistency between -c/--cc that do imply -p on
> one side, and -m that did not imply -p on the other side.

As I mentioned before, I quite like this change for interactive use.

But:

[...]
> It's also worth to be noticed that exact historical semantics of -m is
> still provided by --diff-merges=separate.

Is that true?  When I try it locally, -m shows no diff by default,
whereas --diff-merges=separate shows a diff for merges.

Anyway, the reason I write is that this ended up tripping up some
scripts, namely Rust's bootstrap.py
(https://github.com/rust-lang/rust/commit/df004df3a79b70b4af2b8c267457a5be76bb0d85):

	git log --author=bors --format=%H -n1 \
		-m --first-parent \
		-- src/llvm-project

It's not clear what that *meant* the -m to do --- perhaps they intended
it as an abbreviation for --merges.  That was fixed in Rust by
https://github.com/rust-lang/rust/pull/87513; in the current code at
https://github.com/rust-lang/rust/blob/master/src/bootstrap/bootstrap.py
Rust now uses

	git log --author=bors --format=%H -n1 \
		--no-patch --first-parent \
		-- [etc]

There's also an open pull request at
https://github.com/rust-lang/rust/pull/87532 to simplify it further, to

	git rev-list --author=bors@rust-lang.org -n1 \
		--merges --first-parent HEAD \
		-- [etc]

In any event, the code using -m was pretty clearly a typo, and people
trying to build current Rust won't be affected since it's fixed
already, so this might not be too worrisome.

What happens if someone wants to build an older version of Rust?
bootstrap.py is "symlinked" from x.py at the toplevel of a Rust
distribution; the README explains

	## Installing from Source

	The Rust build system uses a Python script called `x.py` to build the compiler,
	which manages the bootstrapping process. It lives in the root of the project.

	The `x.py` command can be run directly on most systems in the following format:

	```sh
	./x.py <subcommand> [flags]
	```

so this tool is fundamental to everything.  The relevant code using 'git
log -m' is used in the

	if self.downloading_llvm() and stage0:

case to find out how recently llvm changed, in order to check that we
have downloaded that recent of a version of llvm.  It has a
not-too-complicated workaround: if you build LLVM from source using
the src/llvm-project submodule then this logic does not get triggered.

In other words, I don't think this issue will be _too_ problematic for
people working with the Rust project.  Hudson or Taylor (cc-ed) may be
able to correct me if that's wrong.

Still, it does feel a bit like we've pulled the rug from underneath
script authors.  "git log --format=%H" is generally a pretty stable
tool, and here we've changed it when passing -m from not printing
diffs to printing diffs.  What do you think we should do?

Some possibilities:

 a. Revert 'diff-merges: let "-m" imply "-p"'.  This buys us time to
    make a more targeted change, make the change more gradually in a
    future release, or just stop encouraging use of "-m" in docs.

 b. Make "-m" imply "-p", except in some more 'script-ish'
    circumstances (e.g. when using log --format with a format string)

 c. Go ahead with the change and advertise it in release notes.

Searching for other examples using
https://codesearch.debian.net/search?q=%5Cbgit%5Cb.*%5Cblog%5Cb.*-m%5Cb&literal=0,
I find that almost all uses of "git log -m" also include "-p", so (c)
is kind of tempting.  What do you think?

Thanks,
Jonathan
