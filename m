Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CDAC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 21:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKOVNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 16:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKOVNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 16:13:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D3A462
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:13:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gv23so6570559ejb.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xi4jtm325n5ywyK2XrymrSgBiUxSPjh/+RZRJMIppg=;
        b=kfQBAQoVYXsoYahLNFXixUwcC2jzo7ACy9lfPSjGiH8yDIpaE7tya7ntW0at+nxRRl
         ZNva2mxqScJ5ZbcYUNlbYaEW8BFuw/wRJ2SY+KqGB58Gzt7pngqjbviycne4ULrVTYRx
         +uVZ9zLEWCB8WJ5/K1YZVDjttK8NSv1LjSu80NNqb4lPzrAFcekYomXaxjNyz/Mp5pn+
         +zWfZecDXH7W6PLNMQFAjBg2ifjVIY0I7gFEqLEZenQjnhZNbjZXAjpl0cBkJ47iOR4l
         Trd2dT5+2WH18qMQMfW1um80V6FQ+Tm/DRA03Uba+njKQqjUfZDRsXE3oigMKJNR81nq
         pgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xi4jtm325n5ywyK2XrymrSgBiUxSPjh/+RZRJMIppg=;
        b=28HIY3tvTl0k6PZTiwPgWagD+GgpgcIYeITWZ+g/ZgAhQZ5WKskInOtxOtDtP2nHpk
         W12BmqjsMGQl5ZhVfYQVoFoOwoFdOgOwhAkmWf2RNUyAgYg/cwLRdpqYUl+A73ujyvr3
         9ouUKfNwFdceCzSPYXXnPcR+o7gcZJbUEYx2VWAZWWN/YxPENJZz2VIoXnwwmHl+Svbe
         1AiNqBYIIOkfzrT2frEtLaJzKhcRoIWSfA3kluDtKsIROomY+Zbt5aaQhn2xmAgsywvY
         ThNU+0DwbIaBBZOqgWKJuImoNpzov9N0jpjUTlP60W8YZ5zquFSgHd5//HLPH2jzXrcS
         GfYg==
X-Gm-Message-State: ANoB5pkDSr5ntxpKKIU+SRpkAOEINGSm2EYfxP/gLnAZsOm3JPXRuUh0
        0I1Qa2H3yp5wf9qacZjcaeY=
X-Google-Smtp-Source: AA0mqf4vdXtltfh+J3KRWVbd4/yzHTPtLykTgLpTpTBBsOA09ypGmGApH3bilH7iIwN555VwT92OEA==
X-Received: by 2002:a17:906:6042:b0:7ae:f439:320c with SMTP id p2-20020a170906604200b007aef439320cmr9334534ejj.452.1668546828365;
        Tue, 15 Nov 2022 13:13:48 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b00731582babcasm6052456ejo.71.2022.11.15.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:13:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ov3Fb-003lBv-0U;
        Tue, 15 Nov 2022 22:13:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Date:   Tue, 15 Nov 2022 22:08:10 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221110233137.10414-3-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221110233137.10414-3-jacobabel@nullpo.dev>
Message-ID: <221115.86iljfkjjo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, Jacob Abel wrote:

> Adds support for creating an orphan branch when adding a new worktree.
> This functionality is equivalent to git switch's --orphan flag.
>
> The original reason this feature was implemented was to allow a user
> to initialise a new repository using solely the worktree oriented
> workflow. Example usage included below.
>
> $ GIT_DIR=".git" git init --bare
> $ git worktree add --orphan master master/
>
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>  Documentation/git-worktree.txt | 14 +++++++-
>  builtin/worktree.c             | 64 ++++++++++++++++++++++++++++++----
>  t/t2400-worktree-add.sh        | 45 ++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 4dd658012b..1310bfb564 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
> -		   [[-b | -B] <new-branch>] <path> [<commit-ish>]
> +		   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
>  'git worktree list' [-v | --porcelain [-z]]
>  'git worktree lock' [--reason <string>] <worktree>
>  'git worktree move' <worktree> <new-path>
> @@ -95,6 +95,14 @@ exist, a new branch based on `HEAD` is automatically created as if
>  `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
>  in the new worktree, if it's not checked out anywhere else, otherwise the
>  command will refuse to create the worktree (unless `--force` is used).
> ++
> +------------
> +$ git worktree add --orphan <branch> <path>
> +------------
> ++
> +Create a worktree containing an orphan branch named `<branch>` with a
> +clean working directory.  See `--orphan` in linkgit:git-switch[1] for
> +more details.

Seeing as "git switch" is still marked "EXPERIMENTAL", it may be prudent
in general to avoid linking to it in lieu of "git checkout".

In this case in particular though the "more details" are almost
completely absent from the "git-switch" docs, and they don't (which is
their won flaw) link to the more detailed "git-checkout" docs.

But for this patch, it seems much better to link to the "checkout" docs,
no?

> +--orphan <new-branch>::
> +	With `add`, create a new orphan branch named `<new-branch>` in the new
> +	worktree. See `--orphan` in linkgit:git-switch[1] for details.

Ditto.

> +test_expect_success '"add" --orphan/-b mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle -b poodle bamboo
> +'
> +
> +test_expect_success '"add" --orphan/-B mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle -B poodle bamboo
> +'
> +
> +test_expect_success '"add" --orphan/--detach mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle --detach bamboo
> +'
> +
> +test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle --no-checkout bamboo
> +'
> +
> +test_expect_success '"add" -B/--detach mutually exclusive' '
> +	test_must_fail git worktree add -B poodle --detach bamboo main
> +'
> +

This would be much better as a for-loop:

for opt in -b -B ...
do
	test_expect_success "...$opt" '<test here, uses $opt>'
done

Note the ""-quotes for the description, and '' for the test, that's not
a mistake, we eval() the latter.

> +test_expect_success '"add --orphan" fails if the branch already exists' '
> +	test_when_finished "git branch -D existingbranch" &&
> +	test_when_finished "git worktree remove -f -f orphandir" &&
> +	git worktree add -b existingbranch orphandir main &&
> +	test_must_fail git worktree add --orphan existingbranch orphandir2 &&
> +	test ! -d orphandir2

I'm not sure about "worktree" behavior, but maybe this "test ! -d" wants
to be a "test_path_is_missing"?

In general we try to test what a thing is, not what it isn't, in this
case don't we fail to create the dir entirely? So "not exists" would
cover it?
