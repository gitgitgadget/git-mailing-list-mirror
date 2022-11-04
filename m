Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A47C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKDBmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKDBmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:42:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A04423BE5
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:42:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f27so9840808eje.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BWWLoJlYVcwKxCmu025WmrYP2AFa92Ob0DQUuQ4/E4=;
        b=qG80tRVT7w1iJChOVHHRrTmWHitaiQ2wXQ6a7Teheb66j3M+PKX0JkuhmnXOOj65s7
         JwShWUdEbOB2r4/ppBL22RKnZIRgoxalIIr7DH1le9zUjFrcXq7/MT1V09NbY/xH33gJ
         jJfjDuOa5zJnGIUkN9Akq5E5ONlcJWBCx+PPkZqRfWLwxAf/bgtj9dTgz2C9urwr/9cN
         4nYf3e8koGz+2eiKkOHVvfWTdnzCoV4gaOQrisGnuvfBax12eQLgJhggjv+wTrrAb103
         b0zZQ0/29uzqgpil9BOTTxMalyrnkvC+AFFgB0BTBU+YRsKmL7d+HLOtporWQ9braibb
         z3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BWWLoJlYVcwKxCmu025WmrYP2AFa92Ob0DQUuQ4/E4=;
        b=48kv4yG28s7qK1o4cgdrPUBzh4CMHB5V54tiL6a/n7SYHedeGkymCZS9S47W7g7xt4
         hi8Kmbimp+5i533L2hse4uwzc1kPOxDn6ufDB3s77pjMulBDPkOQjDyx+PauPggaHgCe
         6wgZ2IZlehMcVlrbMsPjFcNbsBC7Gu0elhRdbhD321WH3Xxnk50+XHZiAMVX1sIjEDGy
         OTcfyxWrTlBQyQ5hckEzZ6PSvrAvaHlBfboGfbpZ/GTnfWLJiWENo5qII7EqntEN6mG0
         7CLzZHosS+6wrHhCtsrEnqW7u5yHW+KbzTD8e3h4UnSjRMP6r1JFPeDIq8zmllhkxcb/
         Q3Kg==
X-Gm-Message-State: ACrzQf3eyZMQkChysGa2zzrFrxh+QlmluN9/SMHbfIDD8xmumVctt7rB
        kDg6+gXG4ovu4eUlWSZ5lTtYcvTBZ/v07Q==
X-Google-Smtp-Source: AMsMyM7dOj6WNIG0Gf+dMuNSVidmVragRL+gQoOKNy/D6Fpac7bhQ1it8fQj8/+ih5kOwQ7RM4SCWg==
X-Received: by 2002:a17:907:8d0b:b0:7ad:c7d6:eee4 with SMTP id tc11-20020a1709078d0b00b007adc7d6eee4mr26389848ejc.454.1667526127018;
        Thu, 03 Nov 2022 18:42:07 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906114600b0073dc4385d3bsm1146048eja.105.2022.11.03.18.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:42:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqlif-00D1y9-36;
        Fri, 04 Nov 2022 02:42:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] worktree add: Add unit tests for --orphan
Date:   Fri, 04 Nov 2022 02:37:48 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104010242.11555-5-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221104010242.11555-5-jacobabel@nullpo.dev>
Message-ID: <221104.86k04bzeaa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Jacob Abel wrote:

We usually add tests along with the feature, so this should be squashed
into your 3/4.

> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>  t/t2400-worktree-add.sh | 54 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index d587e0b20d..064e1336e2 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -310,6 +310,26 @@ test_expect_success '"add" -B/--detach mutually exclusive' '
>  	test_must_fail git worktree add -B poodle --detach bamboo main
>  '
>
> +test_expect_success '"add" --orphan/-b mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle -b poodle bamboo main
> +'
> +
> +test_expect_success '"add" --orphan/-B mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle -B poodle bamboo main
> +'
> +
> +test_expect_success '"add" --orphan/--detach mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle --detach bamboo main
> +'
> +
> +test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
> +	test_must_fail git worktree add --orphan poodle --no-checkout bamboo main
> +'
> +
> +test_expect_success '"add" -B/--detach mutually exclusive' '
> +	test_must_fail git worktree add -B poodle --detach bamboo main
> +'
> +
> [...]
> +test_expect_success '"add --orphan"' '
> +	git worktree add --orphan neworphan orphandir main &&
> +	git -C orphandir symbolic-ref HEAD >actual &&
> +	echo refs/heads/neworphan >expected &&
> +	test_cmp expected actual &&

nit: we usually do:

	echo ...
	git ...
	test_cmp

So there's never doubt that the "expected" is before the command
(i.e. not impacted by it).

> +	(
> +		cd orphandir &&
> +		git diff main
> +	)

Here you can avoid the sub-shell, with:

	git -C orphandir diff main

> +'
> +
> +test_expect_success '"add --orphan" fails if the branch already exists' '
> +	git worktree add -b existingbranch orphandir2 main &&
> +	test_must_fail git worktree add --orphan existingbranch orphandir3 main &&
> +	[ ! -d orphandir3 ]

Don't use "[", use "test", but in this case use one of the "test -d",
"test -f" etc. wrappers in test-lib-functions.sh.

> +'
> +
> +test_expect_success '"add --orphan" fails if the commit-ish doesnt exist' '
> +	test_must_fail git worktree add --orphan badcommitish orphandir4 eee2222 &&
> +	[ ! -d orphandir4 ]

ditto.

> +'
> +
> +test_expect_success '"add --orphan" with empty repository' '
> +	(
> +		mkdir emptyorphanrepo &&
> +		cd emptyorphanrepo &&
> +		GIT_DIR=".git" git init --bare &&
> +		git worktree add --orphan newbranch worktreedir &&
> +		git -C worktreedir symbolic-ref HEAD >actual &&
> +		echo refs/heads/newbranch >expected &&
> +		test_cmp expected actual
> +	)

Ditto we can avoid sub-shelling here, also when using sub-shells, make
the "cd" the first command in it, if you keep it the "mkdir" should go
outside of it.

But isn't this (untested, maybe I'm missing a subtlety):

	test_when_finished "rm -rf repo" &&
	GIT_DIR=.git git init --bare repo &&
	git -C worktree ...
	git -C worktree/subdir ..
	echo refs ...
	test_cmp ...

I.e. do we need to create the dir manually before "git init --bare"?
