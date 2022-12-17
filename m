Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12CFC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLQKxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 05:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiLQKxt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 05:53:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E805529807
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 02:53:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i7so4686564wrv.8
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eTC0uP38bZg2uvzHt/+fwQwt9NRw+d30LDLEvQlU7k=;
        b=BUolUPl+79V6cG0nco86xy8YoTxIyn9f+BPpU2C/9FzbSHczFG01tFthmemCTePVgL
         Xbn131o1j8XitHhVgEd7SPt77rC7GY8DcuKRDjOEjVxwf6OS7mQpOYd7Wwz8+htXpb4q
         vv/GzJY6+zPERrPBRetJbBhVQWHja6iww6LO+/y6cACW55KvgxyCM7BaRZe41y0bpcn8
         N48FZzDdxZ0rpSRjBD+9gOW+zRPvQYRX5oCtOjw3QBVeJPO2NvSUYb9PT8R3hbedP4x1
         2XL1gzjT6zsK94IzVfN2dphfHsSjW8T4Ju61vey1IvrOJ3xinnE6n77bxrtf78K6IHpB
         SFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eTC0uP38bZg2uvzHt/+fwQwt9NRw+d30LDLEvQlU7k=;
        b=K+vDD5EsT6uGLMF5zVlp8bvCYtsLo9399LGjMbQYQNUfX4Lqv+hHXH/Y+d24iyWiz3
         KTeXRpQ/AriHS9O3ttP9x2y0FABVsW4asptycw2FF1IQgllL+aDHeM/5r2y7Sn8O7osc
         xNcqMJhyHaGt88i5Pp+owPmzuSsOESPqNEdQbG1fbsR/cb2wKALUaR/uHmG87uwt7jQM
         nn8NzMjMshD4tL6pWnDd6Ifht9lCm4//igSPRGlipVPweA0E2bAbN74QeJalOMKf+Pkc
         h8GIuj4M05Ef8hwImssIqdCxNXYzEtsol3GniuAoIYMf4B9afnh4sMGJmHYcNLmjwJV2
         4QLw==
X-Gm-Message-State: ANoB5plw+wyZ94Cf5sA6oCOgI8bhtQkAdJWNjbtlifom+u9uSxFRVP8V
        5KUTlbdtZcbfRAJZj98ttfg=
X-Google-Smtp-Source: AA0mqf6VIGS801u6wob5mYi7ZEbsLlB+NY9jex8n5uA5d6MjYs6zfcLOWDrlzQOU2QSKQZhS5ux/Qg==
X-Received: by 2002:adf:efcc:0:b0:242:2d7:71e4 with SMTP id i12-20020adfefcc000000b0024202d771e4mr33889673wrp.2.1671274424470;
        Sat, 17 Dec 2022 02:53:44 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id q16-20020a05600c46d000b003d34f170487sm1420392wmo.0.2022.12.17.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 02:53:43 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <071e44b5-607e-0db5-af90-85daae81f611@dunelm.org.uk>
Date:   Sat, 17 Dec 2022 10:53:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
Content-Language: en-US
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc:     toon@iotcl.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20221216093552.3171319-1-karthik.188@gmail.com>
In-Reply-To: <20221216093552.3171319-1-karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karthik

On 16/12/2022 09:35, Karthik Nayak wrote:
> v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
> v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t
> 
> Given a pathname, git-check-attr(1) will list the attributes which apply to that
> pathname by reading all relevant gitattributes files. Currently there is no way
> to specify a revision to read the gitattributes from.
> 
> This is specifically useful in bare repositories wherein the gitattributes are
> only present in the git working tree but not available directly on the
> filesystem.

I was thinking about this and wondering if the problem is really that 
bare repositories ignore attributes because they don't have a working 
copy. If that's the case then we should perhaps be looking to fix that 
so that all git commands such as diff as log benefit rather than just 
adding a flag to check-attr. A simple solution would be to read the 
attributes from HEAD in a bare repository in the same way that we 
fallback to the index if there are no attributes in the working copy for 
non-bare repositories.

Best Wishes

Phillip

> This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
> allows us to read gitattributes from the specified revision.
> 
> Changes since version 2:
> - Changes to the commit message [1/2] to use more specific terms and to
>    be more descriptive.
> - Moved the flag's position in the documentation to be before the unbound
>    list of non-options.
> 
> Range-diff against v2:
> 
> 1:  2e71cbbddd < -:  ---------- Git 2.39-rc2
> -:  ---------- > 1:  57e2c6ebbe Start the 2.40 cycle
> 2:  898041f243 = 2:  c386de2d42 t0003: move setup for `--all` into new block
> 3:  12a72e09e0 ! 3:  b93a68b0c9 attr: add flag `-r|--revisions` to work with revisions
>      @@ Metadata
>        ## Commit message ##
>           attr: add flag `-r|--revisions` to work with revisions
>       
>      -    Git check-attr currently doesn't check the git worktree, it either
>      -    checks the index or the files directly. This means we cannot check the
>      -    attributes for a file against a certain revision.
>      +    The contents of the .gitattributes files may evolve over time, but "git
>      +    check-attr" always checks attributes against them in the working tree
>      +    and/or in the index. It may be beneficial to optionally allow the users
>      +    to check attributes against paths from older commits.
>       
>      -    Add a new flag `--revision`/`-r` which will allow it work with
>      -    revisions. This command will now, instead of checking the files/index,
>      -    try and receive the blob for the given attribute file against the
>      -    provided revision. The flag overrides checking against the index and
>      -    filesystem and also works with bare repositories.
>      +    Add a new flag `--revision`/`-r` which will allow users to check the
>      +    attributes against a tree-ish revision. When the user uses this flag, we
>      +    go through the stack of .gitattributes files but instead of checking the
>      +    current working tree and/or in the index, we check the blobs from the
>      +    provided tree-ish object. This allows the command to also be used in
>      +    bare repositories.
>      +
>      +    Since we use a tree-ish object, the user can pass "-r HEAD:subdirectory"
>      +    and all the attributes will be looked up as if subdirectory was the root
>      +    directory of the repository.
>       
>           We cannot use the `<rev>:<path>` syntax like the one used in `git show`
>           because any non-flag parameter before `--` is treated as an attribute
>           and any parameter after `--` is treated as a pathname.
>       
>      -    This involves creating a new function `read_attr_from_blob`, which given
>      -    the path reads the blob for the path against the provided revision and
>      +    The change involves creating a new function `read_attr_from_blob`, which
>      +    given the path reads the blob for the path against the provided revision and
>           parses the attributes line by line. This function is plugged into
>      -    `read_attr()` function wherein we go through the different attributes.
>      +    `read_attr()` function wherein we go through the stack of attributes
>      +    files.
>       
>           Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>           Co-authored-by: toon@iotcl.com
>      @@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes informa
>        [verse]
>       -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
>       -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
>      -+'git check-attr' [-a | --all | <attr>...] [-r <revision>] [--] <pathname>...
>      -+'git check-attr' --stdin [-z] [-a | --all | <attr>...] [-r <revision>]
>      ++'git check-attr' [-r <revision>] [-a | --all | <attr>...] [--] <pathname>...
>      ++'git check-attr' --stdin [-z] [-r <revision>] [-a | --all | <attr>...]
>        
>        DESCRIPTION
>        -----------
>      @@ Documentation/git-check-attr.txt: OPTIONS
>        
>       +--r <revision>::
>       +--revision=<revision>::
>      -+	Check attributes against the specified revision.
>      ++	Check attributes against the specified tree-ish revision. All the
>      ++	attributes will be checked against the provided revision. Paths provided
>      ++	as part of the revision will be treated as the root directory.
>       +
>        \--::
>        	Interpret all preceding arguments as attributes and all following
>      @@ builtin/check-attr.c
>        static const char * const check_attr_usage[] = {
>       -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
>       -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
>      -+N_("git check-attr [-a | --all | <attr>...] [-r <revision>] [--] <pathname>..."),
>      -+N_("git check-attr --stdin [-z] [-a | --all | <attr>...] [-r <revision>]"),
>      ++N_("git check-attr [-r <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
>      ++N_("git check-attr --stdin [-z] [-r <revision>] [-a | --all | <attr>...]"),
>        NULL
>        };
>        
> 
> 
> Karthik Nayak (2):
>    t0003: move setup for `--all` into new block
>    attr: add flag `-r|--revisions` to work with revisions
> 
>   Documentation/git-check-attr.txt |  10 +++-
>   archive.c                        |   2 +-
>   attr.c                           | 100 ++++++++++++++++++++++---------
>   attr.h                           |   7 ++-
>   builtin/check-attr.c             |  33 ++++++----
>   builtin/pack-objects.c           |   2 +-
>   convert.c                        |   2 +-
>   ll-merge.c                       |   4 +-
>   pathspec.c                       |   2 +-
>   t/t0003-attributes.sh            |  71 +++++++++++++++++++++-
>   userdiff.c                       |   2 +-
>   ws.c                             |   2 +-
>   12 files changed, 182 insertions(+), 55 deletions(-)
> 
