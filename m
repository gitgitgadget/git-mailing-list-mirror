Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5548DC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiAFTdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiAFTdY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:33:24 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A36C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 11:33:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n18-20020a056a00213200b004baa74aca72so2280652pfj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=v8XOTGBSqQVXGnbWWmMgJChriOJsoZlausDmJbnDhwI=;
        b=VIKgzHu1s85SsbZeVBTmfS5a5GsAuwNSItxBH9jZY/LsrVVzqZgXCIrJqSNj5Or74m
         uFkWwyJjV5fILcoZA+CifpQvnLjzdtAbnzbWiR7qVfA+itFxV7I4+Gv8YRCDygsY2MCG
         9IcqpFkRDGEKYtKrYBVWQIj2JWnzmrPjyG3+nwZ6yXLnMSGM3sh2HlFCderl+kbTEGXs
         RmONwirL623nxmGHOB5Dti4DXKou9PsXXuBGJmqHWylL/hQ8y8a6Vc3EOouFP0nfUw41
         U99b+dSYmADVUq/UY+mApFs+VYBgvRVLtoogniBwbLlpNE3Q6M5IaQPkh/bsfOMLJa94
         Zxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=v8XOTGBSqQVXGnbWWmMgJChriOJsoZlausDmJbnDhwI=;
        b=Cg+BVnX6efxRZD5Ob8PtXElPMZP1A/vjg5W+qUTtk5uXlynEo7h4z1e/zWjSgoIUDz
         D3o69HMG4e3VBEUeguiATHNMmz2IznmsS9a5jgjbzLEkRpzTlYLe0DsaNKNXplYBqzTJ
         5TZiH5XVeuBT9w4AQSSVEYAHHO9/WrQd/dHBcMGC7RUawccvXCiihUibyh7C+szF/L5R
         qoN/pJSxfVRqIcGtYXXt85AbKGDDT2djC085FPq38GHgBWjMsFOtJXIBS+WnVUHgiQYA
         beqtwZt0STxxlH/ChiQOb3boDTQLjEMqkvFkIlcQ8mmrY2O4vhODUjZvWpBOhkNYJDn9
         sYFw==
X-Gm-Message-State: AOAM532Pb/rBZ22jrlVbdATVD+pxt3gy4lst/xEpQeW4e/TfW4FCg7j8
        2X6XZw4GEf29fA4ZzGHe3oRbIEqYWvQTXw==
X-Google-Smtp-Source: ABdhPJx2xIenqbFP3zMUgSGojhGToWIpv/6tVUOpCCC/k5+wPXYgkMzV/eHitaO+h4ortAuoDrYKwFZbFvcOeg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e884:b0:148:c5a6:7a64 with SMTP
 id w4-20020a170902e88400b00148c5a67a64mr60285626plg.19.1641497603593; Thu, 06
 Jan 2022 11:33:23 -0800 (PST)
Date:   Thu, 06 Jan 2022 11:33:21 -0800
In-Reply-To: <patch-v6-11.17-7d9c0a73568-20211222T035755Z-avarab@gmail.com>
Message-Id: <kl6lh7ag7j7i.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com> <patch-v6-11.17-7d9c0a73568-20211222T035755Z-avarab@gmail.com>
Subject: Re: [PATCH v6 11/17] git hook run: add an --ignore-missing flag
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> For certain one-shot hooks we'd like to optimistically run them, and
> not complain if they don't exist.
>
> This was already supported by the underlying hook.c library, but had
> not been exposed via "git hook run". The command version of this will
> be used by send-email in a subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-hook.txt | 10 +++++++++-
>  builtin/hook.c             |  8 ++++++--
>  t/t1800-hook.sh            |  5 +++++
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index e39b1b5d069..77c3a8ad909 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,7 +8,7 @@ git-hook - Run git hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook' run <hook-name> [-- <hook-args>]
> +'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
> =20
>  DESCRIPTION
>  -----------
> @@ -28,6 +28,14 @@ Any positional arguments to the hook should be passed =
after a
>  mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
>  linkgit:githooks[5] for arguments hooks might expect (if any).
> =20
> +OPTIONS
> +-------
> +
> +--ignore-missing::
> +	Ignore any missing hook by quietly returning zero. Used for
> +	tools that want to do a blind one-shot run of a hook that may
> +	or may not be present.

The most obvious question whenever a new option is introduced is "Is
this a descriptive and consistent option name?" The answer we came to in
review club is yes, "--ignore-missing" is good :)

However, the description isn't 100% clear about what it means for a hook
to be missing (possible confusion: is a missing hook a hook that isn't
documented in Documentation/githooks.txt?). I suspect that your wording
is intentionally open-ended because Git will eventually look for hooks
in the config as well as `.git/hooks`. Nevertheless, it would help to
get a precise definition in the docs so that readers know what to expect
and we can advise() users consistently.

> +
>  SEE ALSO
>  --------
>  linkgit:githooks[5]
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 9b67ff50cef..54e5c6ec933 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -7,7 +7,7 @@
>  #include "strvec.h"
> =20
>  #define BUILTIN_HOOK_RUN_USAGE \
> -	N_("git hook run <hook-name> [-- <hook-args>]")
> +	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
> =20
>  static const char * const builtin_hook_usage[] =3D {
>  	BUILTIN_HOOK_RUN_USAGE,
> @@ -23,8 +23,11 @@ static int run(int argc, const char **argv, const char=
 *prefix)
>  {
>  	int i;
>  	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +	int ignore_missing =3D 0;
>  	const char *hook_name;
>  	struct option run_options[] =3D {
> +		OPT_BOOL(0, "ignore-missing", &ignore_missing,
> +			 N_("silently ignore missing requested <hook-name>")),
>  		OPT_END(),
>  	};
>  	int ret;
> @@ -52,7 +55,8 @@ static int run(int argc, const char **argv, const char =
*prefix)
>  	git_config(git_default_config, NULL);
> =20
>  	hook_name =3D argv[0];
> -	opt.error_if_missing =3D 1;
> +	if (!ignore_missing)
> +		opt.error_if_missing =3D 1;

It's not clear why --ignore-missing isn't just the default behavior (and
judging from the lines above, it looks like it used to be?). After some
debate, most of the Google reviewers liked this new default, but it was
difficult to assess the merits of the decision because the thought
process wasn't obvious.

Here's the line of reasoning: if we only consider the hooks in-tree, it
certainly seems like none of the callers actually want to error out if
the hook is missing. This suggests that the default behavior of ignoring
missing hooks is actually what we want, so why change the default
behavior and add another option to worry about?

I can propose at least one reason, which is that "git hook" is also
meant to be invoked by end users in the shell and not just by programs.
I used to use npm quite a lot, and a pattern I am quite fond of is to
have an npm script called "precommit" which runs my linters and
formatters, and I'd make `npm run precommit` part of my pre-commit hook.
But a nice benefit is that I can also run `npm run precommit` at any
time to run all of my tooling, regardless of whether or not I am making
a commit. It would be pretty neat to be able to do away with npm and
just use `git hook run pre-commit'. In this scenario, I would certainly
expect `git hook run pre-commit` to fail if there is no `pre-commit`
hook, so yes, this new default behavior can make sense.

But I can't tell if this is something you had intended all along, or if
you had something else in mind. If anything, the original cover letter
[1] _almost_ seems to suggest otherwise.

  The new "git hook" command is (for now) only for the benefit of
  in-tree non-C programs that need to run hooks, and this series
  converts git-send-email and git-p4 to use it.

It's worth explaining the rationale in the commit message.

>  	ret =3D run_hooks_opt(hook_name, &opt);
>  	if (ret < 0) /* error() return */
>  		ret =3D 1;


> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 3aea1b105f0..29718aa9913 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -21,6 +21,11 @@ test_expect_success 'git hook run: nonexistent hook' '
>  	test_cmp stderr.expect stderr.actual
>  '
> =20
> +test_expect_success 'git hook run: nonexistent hook with --ignore-missin=
g' '
> +	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
> +	test_must_be_empty stderr.actual
> +'
> +

For completeness, this should include a test for the non-exceptional
case i.e. when the hook isn't missing.

>  test_expect_success 'git hook run: basic' '
>  	write_script .git/hooks/test-hook <<-EOF &&
>  	echo Test hook
> --=20
> 2.34.1.1146.gb52885e7c44

[1] https://lore.kernel.org/git/cover-00.13-00000000000-20211012T131934Z-av=
arab@gmail.com/
