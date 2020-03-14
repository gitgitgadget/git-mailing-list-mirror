Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E7C5ACD6
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458C7206D5
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecv9TaYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCOBqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:46:20 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42303 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCOBqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:46:10 -0400
Received: by mail-ua1-f68.google.com with SMTP id v16so4076531ual.9
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7I7N0jR0aUEMBeacpisGT3gUhQ4cUd4tWMpQ8D30JQ=;
        b=ecv9TaYUsnAy5BAG2STOrGgiKIxZweion2oz20MKyfTfGIWk6XiRPLO8vBECNc/AaT
         +PvZ4NKzngFpanc/ZrEqPyjTZ3v3HZD90ojVC3MiOrYPxjrC1Vh3RqFvf3rI3tUiBoYq
         UXBwEivbF2anclGueIGwxXuAA5MIllPfYNqy/XQwjTNAScZsYZ41PeTkcPWzpLB01JGV
         dfVmu8uGNHPa3JD64KoP4tmChSDE3X9PjYFMM8zxOHX7B/e9A8EI/KBkaoOos4LA2Cmx
         sQtgyB8rNJQbprgk3hUfi2GkhHU5FuQTfSr02Vjxs6C22wJ/2FBzClpzlW0t1dITydOJ
         Z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7I7N0jR0aUEMBeacpisGT3gUhQ4cUd4tWMpQ8D30JQ=;
        b=p0f5H9VBuDao24vhsrkkRM7IIUSs4PFz9ajA1CrXQz5CveNIZF55+2OzqH+BqbwFZ6
         qKL+F3fNYE1e5FokrZ4TsE6lb6eg3owv4WE/tlXocrpBPe//GkuEbZvGSljRZyRo+Mxb
         8DsR9c8jMtTYGGDeWowCvcyFLV8G3NEF1XXeNCOMS3whX7SONgbkLSFV4tC3fz+R6DR2
         B3Ny53SiuuErn7QmCRA0M5rul+oHfk+y6nRYH1YVTLpHYw2ILFjyIEYbqJPAU5UrfQDj
         3TFTAPqvWR6S8K942ZlK27JtwjAEPKkgklyugy3oE7oyKZdbAMHdmQx947LRatE9DTM/
         csGg==
X-Gm-Message-State: ANhLgQ3EoaBKNrTHpYiYrWXNGc5vyhHjDIgPxF6KQM4XJhrqHBQjgFm6
        p0F2BJ1D7EwcjqxnF/84WA6TJK4wEKGwzZ0t4nbLNw==
X-Google-Smtp-Source: ADFU+vu/eHg5rz86dasgZxSYbr3En0g5DvB8NMECYrqwMXGMAwbwfW6BgGBnHJeQu4rXM645dy0PpcDc/eC76HrbC/4=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr16585281otl.162.1584213430111;
 Sat, 14 Mar 2020 12:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
In-Reply-To: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 14 Mar 2020 12:16:59 -0700
Message-ID: <CABPp-BHKEMp-nA0edS1bgDpTgsh1xuXGgq4pL+9K2ft=He6wQg@mail.gmail.com>
Subject: Re: [PATCH] clone: use --quiet when stderr is not a terminal
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 2:11 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> "git clone" is used by many build systems to download Git code before
> running a build. The output of these systems is usually color-coded to
> separate stdout and stderr output, which highlights anything over stderr
> as an error or warning. Most build systems use "--quiet" when cloning to
> avoid adding progress noise to these outputs, but occasionally users
> create their own scripts that call "git clone" and forget the --quiet
> option.
>
> Just such a user voiced a complaint that "git clone" was showing "error
> messages" in bright red. The messages were progress indicators for
> "Updating files".
>
> To save users from this confusion, let's default to --quiet when stderr
> is not a terminal window.
>
> To test that this works, use the GIT_PROGRESS_DELAY environment variable
> to enforce that all progress indicators appear immediately, and check
> that a redirected stderr has no output. We also need to update some
> tests that inspect stderr after a "git clone" or "git submodule update"
> command. It is easy to update the clone tests with the --verbose option,
> while we can remove the clone output from the expected output of the
> submodule test.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     clone: use --quiet when stderr is not a terminal
>
>     I think this is generally how we are intending Git builtins to work.
>     There was a complaint recently about my proposed addition of progress to
>     'git read-tree', but that was because scripts would suddenly get noisy
>     if they were not expecting it. This is the opposite: we will make 'git
>     clone' quieter.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-581%2Fderrickstolee%2Fclone-quiet-default-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-581/derrickstolee/clone-quiet-default-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/581
>
>  builtin/clone.c             | 3 +++
>  t/t5550-http-fetch-dumb.sh  | 2 +-
>  t/t5601-clone.sh            | 7 ++++++-
>  t/t7406-submodule-update.sh | 8 --------
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1ad26f4d8c8..a2e6905f0ef 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -957,6 +957,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>
>         struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
>
> +       if (!isatty(2))
> +               option_verbosity = -1;
> +
>         packet_trace_identity("clone");
>         argc = parse_options(argc, argv, prefix, builtin_clone_options,
>                              builtin_clone_usage, 0);
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index b811d89cfd6..c0bdcafa304 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -332,7 +332,7 @@ test_expect_success 'redirects can be forbidden/allowed' '
>         test_must_fail git -c http.followRedirects=false \
>                 clone $HTTPD_URL/dumb-redir/repo.git dumb-redir &&
>         git -c http.followRedirects=true \
> -               clone $HTTPD_URL/dumb-redir/repo.git dumb-redir 2>stderr
> +               clone --verbose $HTTPD_URL/dumb-redir/repo.git dumb-redir 2>stderr
>  '
>
>  test_expect_success 'redirects are reported to stderr' '
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 84ea2a3eb70..2902a201977 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -39,7 +39,7 @@ test_expect_success 'clone with excess parameters (2)' '
>
>  test_expect_success C_LOCALE_OUTPUT 'output from clone' '
>         rm -fr dst &&
> -       git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
> +       git clone --verbose -n "file://$(pwd)/src" dst >output 2>&1 &&
>         test $(grep Clon output | wc -l) = 1
>  '
>
> @@ -297,6 +297,11 @@ test_expect_success 'clone from original with relative alternate' '
>         grep /src/\\.git/objects target-10/objects/info/alternates
>  '
>
> +test_expect_success 'clone quietly without terminal' '
> +       GIT_PROGRESS_DELAY=0 git clone src progress 2>err &&
> +       test_must_be_empty err
> +'
> +
>  test_expect_success 'clone checking out a tag' '
>         git clone --branch=some-tag src dst.tag &&
>         GIT_DIR=src/.git git rev-parse some-tag >expected &&
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 4fb447a143e..ebf08e3a77a 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -115,18 +115,10 @@ Submodule path '../super/submodule': checked out '$submodulesha1'
>  EOF
>
>  cat <<EOF >expect2
> -Cloning into '$pwd/recursivesuper/super/merging'...
> -Cloning into '$pwd/recursivesuper/super/none'...
> -Cloning into '$pwd/recursivesuper/super/rebasing'...
> -Cloning into '$pwd/recursivesuper/super/submodule'...
>  Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
>  Submodule 'none' ($pwd/none) registered for path '../super/none'
>  Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
>  Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
> -done.
> -done.
> -done.
> -done.
>  EOF
>
>  test_expect_success 'submodule update --init --recursive from subdirectory' '
>
> base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
> --
> gitgitgadget

Seems reasonable to me.
