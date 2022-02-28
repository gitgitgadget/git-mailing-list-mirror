Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B02C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiB1JkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiB1JkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:40:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230760A8D
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:39:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so23479652eje.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vXZLjh2hb/69nsvVNu4GyHlG4XEorECXKvKRmhpsi4A=;
        b=FFzICdww95iLD20i6BbhRf3HXUqF5Qx9rk1Mgt+887lCkzgIJScwRH22LiwZCuFRsf
         xeDWxq8R0Knkw0EL4ycCGReRgAB58ZK5SHe/w+35p2D/SWgiPD0OwaeSMpWc9hx3kyMO
         7BFHARoXmmuNcwFRqxG3aBAOOOOuVMB5jPXMq6oxrO9tv7JiSLt9a/jBI50z/qO1Wa9g
         HQmIKQRfSKolxxhh8p3RygTQRE6DoMC3IMQWoXaF1BmAxQrfdSIeBHvRJeo+nXc/x9vE
         k2mkce9bM4uT9ta0KIONTWAsklBsmBEnDBYZPhR4Hv9mB+8WtV1HcnlQbyOFzZOTOhUn
         SDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vXZLjh2hb/69nsvVNu4GyHlG4XEorECXKvKRmhpsi4A=;
        b=x0BTnZ8j6GVTBBuYLP9JaZywVHzLyN89BpT1+lZ86SYJqR0C8Hy9HakdaGVK5LWqeZ
         ofBqcfMHn50dUknCxqW1Xhx7pIHwL55Enyk4vRuEQtZ531QL8R+bX64VIp38aYeb9SWE
         NePvIj+hn70Uzvp76eFPRagLcVtZu7Gc8XqugWrpwEfpnUOO99IT0sNhtwAwv/DxGj7I
         w0OsQ4qETspx6wo5tWKDcNbghAikwNNCFqOWe3z7gX6opir3SG6NDn79m6EQ6ZsxLNun
         YAD9ZB7xT2Rt/3sbIIz5j0eUplgeMVMBucvTjHxu9uYawIr4Sz6AjWPYb6SUDmYwhvej
         Edrw==
X-Gm-Message-State: AOAM532QLP+cZmnrqs5gmftQgRxhemeyoJ3TPc6m2YeP5OsdrTnPH5hN
        2KAH7kn1dN9dG/dTsm1J+2g=
X-Google-Smtp-Source: ABdhPJywJmkI9buGUXJlqQ3Rr7sVIb8OG7toikZQFDzSgVIs8LES+SKRUJm1rG6RFWD1BuEtU/hQuQ==
X-Received: by 2002:a17:906:68c2:b0:6b4:9f26:c099 with SMTP id y2-20020a17090668c200b006b49f26c099mr14697137ejr.41.1646041166480;
        Mon, 28 Feb 2022 01:39:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0040f826f09fdsm5881097edt.81.2022.02.28.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:39:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOcV3-001GWs-4g;
        Mon, 28 Feb 2022 10:39:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3 2/2] t3200: tests for new branch.autosetupmerge
 option "simple"
Date:   Mon, 28 Feb 2022 10:34:32 +0100
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <d5b18c7949fdea966d31b2b8ca3f8aa8ed3a86b6.1646032466.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d5b18c7949fdea966d31b2b8ca3f8aa8ed3a86b6.1646032466.git.gitgitgadget@gmail.com>
Message-ID: <220228.86o82r5nzm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:

> From: Tao Klerks <tao@klerks.biz>
>
> In the previous commit a new autosetupmerge option was introduced.
>
> Extend the existing branch tests with three new cases testing this
> option - the obvious matching-name and non-matching-name cases, and
> also a non-matching-ref-type case.
>
> The matching-name case needs to temporarily create an independent
> repo to fetch from, as the general strategy of using the local repo as
> the remote in these tests precludes locally branching with the same
> name as in the "remote".
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>  t/t3200-branch.sh | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 7a0ff75ba86..15cc58f1e64 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -886,6 +886,41 @@ test_expect_success 'branch from tag w/--track causes failure' '
>  	test_must_fail git branch --track my11 foobar
>  '
>  
> +test_expect_success 'simple tracking works when remote branch name matches' '
> +	test_create_repo otherserver &&
> +	test_commit -C otherserver my_commit 1 &&
> +	git -C otherserver branch feature &&
> +	git config branch.autosetupmerge simple &&
> +	git config remote.otherserver.url otherserver &&
> +	git config remote.otherserver.fetch refs/heads/*:refs/remotes/otherserver/* &&

Shouldn't these use test_config, or if the tests below need them do that
via a helper, so later added tests don't need to reset this state?

> +	git fetch otherserver &&
> +	git branch feature otherserver/feature &&
> +	rm -fr otherserver &&

Instead of "rm -rf" after, do above:

    test_when_finished "rm -rf otherserver" &&
    git init otherserver

(you don't need "test_create_repo" either, just use "git init")

> +	test $(git config branch.feature.remote) = otherserver &&
> +	test $(git config branch.feature.merge) = refs/heads/feature

Use:

    echo otherserver >expect &&
    git config ... >actual &&
    test_cmp expect actual

etc., the pattern you're using here will hide git's exit code on
segfaults, abort() etc., and also makes for less useful debug info on
failure than test_cmp.

    
> +'
> +
> +test_expect_success 'simple tracking skips when remote branch name does not match' '
> +	git config branch.autosetupmerge simple &&
> +	git config remote.local.url . &&
> +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&

ditto config setup above, this is quite hard to follow in sequence since
yo uneed to reason about all existing config. Let's start with a clean
slate for each test_expect_success and setup the specific config we want
instead.fallow since

> +	(git show-ref -q refs/remotes/local/main || git fetch local) &&

This likewise hides segfaults etc. Use:

    test_might_fail git show-ref ...

But maybe this whole thing should use "git rev-parse --verify" or
something?

> +	git branch my-other local/main &&
> +	test -z "$(git config branch.my-other.remote)" &&
> +	test -z "$(git config branch.my-other.merge)"

ditto test_cmp comments, but here:

    git ... >out &&
    test_must_be_empty out

> +'
> +
> +test_expect_success 'simple tracking skips when remote ref is not a branch' '
> +	git config branch.autosetupmerge simple &&
> +	git tag mytag12 main &&
> +	git config remote.localtags.url . &&
> +	git config remote.localtags.fetch refs/tags/*:refs/remotes/localtags/* &&
> +	(git show-ref -q refs/remotes/localtags/mytag12 || git fetch localtags) &&
> +	git branch mytag12 localtags/mytag12 &&
> +	test -z "$(git config branch.mytag12.remote)" &&
> +	test -z "$(git config branch.mytag12.merge)"

ditto above.

> +'
> +
>  test_expect_success '--set-upstream-to fails on multiple branches' '
>  	echo "fatal: too many arguments to set new upstream" >expect &&
>  	test_must_fail git branch --set-upstream-to main a b c 2>err &&

