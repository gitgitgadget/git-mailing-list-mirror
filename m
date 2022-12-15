Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5BCC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 20:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLOUyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLOUyf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 15:54:35 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAEA50D6B
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 12:54:34 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y1-20020a056a001c8100b00577d768ff3cso293786pfw.9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 12:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKmPwSsUDo3MmzzB26J0gSpj9egE9h4IInxuN2MRkE4=;
        b=Q9bBbAuaeMi4Rxcha8ztPs8n/wrHaZ5c8Mr/A0lF6WSzMi1CsoWnvE56OmozfS20SU
         Ro8FFtr260tNN/qVJWed2LwHYtG9UsDSnhwZK0tlBn00XFd7c2kJ1weX7YVIXvnxFILQ
         Xf81AQarjbg7/yPOr/F3/6Iwe0QfBfKVQHvOrnaSzNXPK4lUkRKfHYsYifuKn4vQn8XF
         bIqJqNWkTl7MJxuHA5ltwy+y6KnM6HYva7DyrJNnjQ7UWi0YcXmrD+4xz7GQMxmonKAW
         5EBHE8zIpP5uYzQNuLsBPIILCww0TSbkl0+56eudXrTlxNBV/fFKolWkYr70Zj1f2M7p
         djvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dKmPwSsUDo3MmzzB26J0gSpj9egE9h4IInxuN2MRkE4=;
        b=35mOURn7Th5tbiZ8iJ6J1rMqLhmnzw7jECG/7GSHufuxq18b9Pp7NN93di2og2hs/H
         cgWpfaNu935hH+69B6GIpbHCHXv3ltqt7F+XRCpxZZfxvzkgpEa5HcJsYO5z/XklPmSE
         Gb52TN9UTes1ZKiMnXyOtRrSXN0SBTlAaG6ys5ideqnuU49GlnJXTPaYclKRkVC73nrz
         HKES1E/eMh9y0kVJK91WuIUmhfzwWMJzWMATw6S+6lwSTrSnDTTzVK9SRWSx8jmES3Q7
         y3FKBUnfb1irYVFhrilMIfL4kSJ8RPuiDV87dPKdVD2PEK8FWSkxqXji8qxPQYCgbIDe
         v/Uw==
X-Gm-Message-State: ANoB5pneSO1EMHrb1bkyWZ88TUJezQC2OakszPJZn5jSrdpxGox1t/Gm
        mvT4bVdeZYGUtWd/Dkv69UGGtvWI8tNDPA==
X-Google-Smtp-Source: AA0mqf5SGaJLIhewCJ0dskoe1b11hb1BhmCyg3I3nbnn/jUYjySENEkgy9PnQJj2iuGl5s+DMtOeqUL3Uww4Bg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:21c1:b0:562:86a3:12fc with SMTP
 id t1-20020a056a0021c100b0056286a312fcmr80360665pfj.8.1671137673996; Thu, 15
 Dec 2022 12:54:33 -0800 (PST)
Date:   Thu, 15 Dec 2022 12:54:25 -0800
In-Reply-To: <patch-v4-1.9-f479003941b-20221215T083502Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <patch-v4-1.9-f479003941b-20221215T083502Z-avarab@gmail.com>
Message-ID: <kl6l7cyse6bi.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 1/9] submodule absorbgitdirs tests: add missing
 "Migrating git..." tests
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No comment on the structure of the tests themselves; those look good to
me.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absor=
bgitdirs.sh
> index 2859695c6d2..d556342ea57 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -10,6 +10,7 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  test_expect_success 'setup a real submodule' '
> +	cwd=3D"$(pwd)" &&
>  	git init sub1 &&
>  	test_commit -C sub1 first &&
>  	git submodule add ./sub1 &&

[...]
=20
> @@ -18,13 +19,21 @@ test_expect_success 'setup a real submodule' '
>  '
> =20
>  test_expect_success 'absorb the git dir' '
> +	>expect &&
> +	>actual &&
>  	>expect.1 &&
>  	>expect.2 &&
>  	>actual.1 &&
>  	>actual.2 &&
>  	git status >expect.1 &&
>  	git -C sub1 rev-parse HEAD >expect.2 &&
> -	git submodule absorbgitdirs &&
> +	cat >expect <<-EOF &&
> +	Migrating git directory of '\''sub1'\'' from
> +	'\''$cwd/sub1/.git'\'' to
> +	'\''$cwd/.git/modules/sub1'\''
> +	EOF
> +	git submodule absorbgitdirs 2>actual &&
> +	test_cmp expect actual &&
>  	git fsck &&
>  	test -f sub1/.git &&
>  	test -d .git/modules/sub1 &&

I thought that we typically avoid setting environment variables in the
test cases themselves, so when we set environment variables to be read
in later tests, we typically set them outside of the test case (e.g.
t/t5526-fetch-submodules.sh).

> @@ -97,6 +119,27 @@ test_expect_success 'absorb the git dir in a nested s=
ubmodule' '
>  	test_cmp expect.2 actual.2
>  '
> =20
> +test_expect_success 'absorb the git dir outside of primary worktree' '
> +	test_when_finished "rm -rf repo-bare.git" &&
> +	git clone --bare . repo-bare.git &&
> +	test_when_finished "rm -rf repo-wt" &&
> +	git -C repo-bare.git worktree add ../repo-wt &&
> +
> +	test_when_finished "rm -f .gitconfig" &&
> +	test_config_global protocol.file.allow always &&
> +	git -C repo-wt submodule update --init &&
> +	git init repo-wt/sub2 &&
> +	test_commit -C repo-wt/sub2 A &&
> +	git -C repo-wt submodule add ./sub2 sub2 &&
> +	cat >expect <<-EOF &&
> +	Migrating git directory of '\''sub2'\'' from
> +	'\''$cwd/repo-wt/sub2/.git'\'' to
> +	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
> +	EOF
> +	DO_IT=3D1 git -C repo-wt submodule absorbgitdirs 2>actual &&

DO_IT is a leftover from dev?

(I'm also curious as to what it does :)).
