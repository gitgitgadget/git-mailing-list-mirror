Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130FC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE4C222C3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoEslqDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAPAi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:38:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38927 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAPAi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 19:38:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so17368811oib.6
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 16:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7B3EaGR/gV3x02Ki8c3XhBDofMHYz1X/2z8Ix3b3bpM=;
        b=LoEslqDNu0SJFPJoBcPiLoncSGEdeI5FKxnbBleLKxA2fzoqkwlwO+N+EM2av56bV0
         SZZRcBtwSfnBUhVpHRRITYdcjvrYiY0M2c33wRrM7h8ztQ9Bifo9cCwhfENIJUEoxQVu
         aTD9XB32/iR/yGaVyyRFPKlAykCPxtc68Ml3nqBlnm7VVNVflrJQmHUYybL1GAK6GVIS
         fiGKYa40ZdTypKlkC7Y+UlUIzbegUlSB5KNyznSl8lU4TIZFqumn/HGKDyHVdcgZpP0/
         kvKRTgehUYodpUEL3qhhh8vJacdIWLHyJDMA3szlCFNjW50RoWB5tXI13t8g00P5Uju1
         8V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7B3EaGR/gV3x02Ki8c3XhBDofMHYz1X/2z8Ix3b3bpM=;
        b=kjqjqYnq2L6DMnGN+0OkbyZnEFc67MCQcCHpy6uGL/Iv6RDhxoa0QOpB0cGKZNF7kU
         K/FczD3bwKokYwpB2/Z7lt+pHaxBJ2+/C1Vcpv+qaeLS4KC5D/a5vWuUR7UtglO74E2e
         P9U6ZKTEeuKW3d3s3Nid6BpIZPQyJ/WYutuNWR88QGGeV2F2M3tbbPlADZCbF1jIg/6d
         pARONJE6mdm00J70yuECfzGJMdSTz3nfipvIt2tXM4FJ5bbjRsPveLHssRH55vGLt+WN
         Eyfm/xnX7D9BdIYN+CV85tfJXgGIapAU4Yad6tsSmWCRd9hTiYuNK4vt1lnAOrPWN/SK
         qcAg==
X-Gm-Message-State: APjAAAUZ19LvmE12kH4vbOxDt7M+siy+4N1UcZvxHkwDFVJQO+ek1AQs
        sDXsgYdABCpluaI22yQMX2uHpwPH5Jj/C7EHLr3LQA==
X-Google-Smtp-Source: APXvYqzbOMX1iIGgFCGJ1FC184PaXEfqscC3lSQOreJsZpbTicznZLLE2Vad9JL33AAIwKiJKLgq5NUBcB0OLKzL8WE=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr2108037oib.6.1579135107753;
 Wed, 15 Jan 2020 16:38:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
In-Reply-To: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Jan 2020 16:38:16 -0800
Message-ID: <CABPp-BHywo5Js0YGwDykV8G+=Y6-M_Wh3sE5BvC-7zArJd1rLw@mail.gmail.com>
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 12:25 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> b9660c1 (dir: fix checks on common prefix directory, 2019-12-19)
> modified the way pathspecs are handled when handling a directory
> during "git clean -f <path>". While this improved the behavior
> for known test breakages, it also regressed in how the clean
> command handles cleaning a specified file.
>
> Add a test case that demonstrates this behavior. This test passes
> before b9660c1 then fails after.
>
> Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     clean: demonstrate a bug with pathspecs
>
>     While integrating v2.25.0 into the microsoft/git fork, one of our VFS
>     for Git functional tests started failing. Looking into it, the only
>     possible place could have been where one of our integration points with
>     the virtualfilesystem hook was moved by c5c4edd (dir: break part of
>     read_directory_recursive() out for reuse, 2019-12-10) and then used in
>     the following two commits.
>
>     By reverting these two commits, we stopped the failure, but it took a
>     while before figuring out that it was a regression in Git and not a
>     failure in our integration to the new logic. Thanks to Kevin Willford
>     for producing a test case.
>
>     b9660c1 (dir: fix checks on common prefix directory, 2019-12-19) is the
>     culprit, so this patch is based on that. If rebased to c5c4edd, then the
>     test passes.
>
>     As for actually fixing this regression, I don't know how. This code is
>     pretty dense and I don't have a firm grasp of what is happening in both
>     b9660c1 and the following 777b420 (dir: synchronize tread_leading_path()
>     and read_directory_recursive()). Elijah is CC'd in case he still has
>     context on this area.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-526%2Fderrickstolee%2Fclean-bug-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-526/derrickstolee/clean-bug-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/526
>
>  t/t7300-clean.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 6e6d24c1c3..782e125c89 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -737,4 +737,13 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
>         test_i18ngrep "too long" .git/err
>  '
>
> +test_expect_failure 'clean untracked paths by pathspec' '
> +       git init untracked &&
> +       mkdir untracked/dir &&
> +       echo >untracked/dir/file.txt &&
> +       git -C untracked clean -f dir/file.txt &&
> +       ls untracked/dir >actual &&
> +       test_must_be_empty actual
> +'
> +
>  test_done
>
> base-commit: b9670c1f5e6b98837c489a03ac0d343d30e08505
> --
> gitgitgadget

Is there an inverted phrase corresponding to "the gift that keeps on
giving", something like "the punishment that keeps on punishing"?  If
so, it would be a very appropriate description of dir.c.

Yeah, I still have context.  I even think I've got an idea about what
the fix might be, though with dir.c my ideas about fixes usually just
serve as starting points for debugging before I find the real fix.
I'll try to dig in.
