Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843FC19F29
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiG2VzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbiG2VzK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:55:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94A9291
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:55:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id i9-20020a17090a65c900b001f03395643dso4877048pjs.9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=LR/pLopwpSlqmTXXblCt2OJR/pyHVtrM64I89xzK7b0=;
        b=Bg9tY8fGAEJjZK9uBBfmLOwghQtwMy2md/EX4NNsboXyMX7LCc4JYoe1aSbSgq/fqW
         u3jnH7Lrk0/B26S2BqWbfRYC8h35uAaaeh1xbMc80Zeo5FVChkA4tQj9Bs0WAix9VYk0
         /+GjZaqJihKpkScRO1xmrbWkqX5WyGEIJWB2kfk9p9M14eWVjgFftTD20wXGrpRnmvNT
         WJvJMZl3cc5/vDlsoExzIzv+8h71PrEfA1Vndd0ZN3w8tmffS2dj9gfqJim1a0lem1Vk
         GUzftlrGJDRBnUg82itDTp/QkNIAh2ofETH3dmZu/YIpZPY03VvYrWGHrBE4neHWHOoy
         4TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=LR/pLopwpSlqmTXXblCt2OJR/pyHVtrM64I89xzK7b0=;
        b=ws+M3xPFfank/+Mh/8FaEiHOH1++Pa9gNh5mwumFVxWcCqkFOsepqm6QneOUG+ADaz
         H5ZaM3H9zHlIpTllMGHtKFCkpmbomOkdKANTVBcAp0mKdVbn3YzvKvcp6OCN8w9tNufe
         MMqL0Mo78z+dSoQnM+Vj6Jw8kvI4k2YN5P3PXFu+x77xW0tTqPAzw5tlW0yzHCiKeJQJ
         Vh2+FKh8fqdnSHEE6cV7+CxbdLaOrr8RlyFrIxUyGXVSUxhidKxzPS81JKpeKoPEPVkg
         2pF5Hsg08heXVH3Q/ANcLQ4UpO7QD+Vkk3OZem0MfiS49JOZ7yZgYmnz3DIt+SxcwdaR
         HZpw==
X-Gm-Message-State: AJIora/SZU3iGKlNekSsnwVDYfgq2X/mUQ7POZhHNVPkpB585tg76bFV
        Bsj1s9emgQQwN7WULJz+o+WZMHfqXu9uhg==
X-Google-Smtp-Source: AGRyM1vrEZAkrSPBxpgAhJzwVGHi6np9o/cTLsz/iVBMlQhFAfwp538mEX8ubOmLC115wgzf/5vTyyITPpZsyw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:bd49:0:b0:41b:8a07:a6ed with SMTP id
 d9-20020a63bd49000000b0041b8a07a6edmr4356523pgp.124.1659131706149; Fri, 29
 Jul 2022 14:55:06 -0700 (PDT)
Date:   Fri, 29 Jul 2022 14:55:04 -0700
In-Reply-To: <patch-07.20-a2f3d812815-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6lsfmjr3d3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-07.20-a2f3d812815-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 07/20] submodule--helper: move "check-name" to a test-tool
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Move the "check-name" helper to a test-tool, since
> a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
> 2021-08-10) it has only been used by this test, not git-submodule.sh.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 24 -------------------
>  t/helper/test-submodule.c   | 46 +++++++++++++++++++++++++++++++++++++
>  t/t7450-bad-git-dotfiles.sh |  2 +-
>  3 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b2fc732b5d8..06307886080 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2728,29 +2728,6 @@ static int absorb_git_dirs(int argc, const char **=
argv, const char *prefix)
>  	return 0;
>  }
> =20
> -/*
> - * Exit non-zero if any of the submodule names given on the command line=
 is
> - * invalid. If no names are given, filter stdin to print only valid name=
s
> - * (which is primarily intended for testing).
> - */
> -static int check_name(int argc, const char **argv, const char *prefix)
> -{
> -	if (argc > 1) {
> -		while (*++argv) {
> -			if (check_submodule_name(*argv) < 0)
> -				return 1;
> -		}
> -	} else {
> -		struct strbuf buf =3D STRBUF_INIT;
> -		while (strbuf_getline(&buf, stdin) !=3D EOF) {
> -			if (!check_submodule_name(buf.buf))
> -				printf("%s\n", buf.buf);
> -		}
> -		strbuf_release(&buf);
> -	}
> -	return 0;
> -}
> -
>  static int module_config(int argc, const char **argv, const char *prefix=
)
>  {
>  	enum {
> @@ -3305,7 +3282,6 @@ static struct cmd_struct commands[] =3D {
>  	{"summary", module_summary, 0},
>  	{"push-check", push_check, 0},
>  	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> -	{"check-name", check_name, 0},
>  	{"config", module_config, 0},
>  	{"set-url", module_set_url, 0},
>  	{"set-branch", module_set_branch, 0},
> diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
> index 494c6558d9f..9f0eb440192 100644
> --- a/t/helper/test-submodule.c
> +++ b/t/helper/test-submodule.c
> @@ -2,8 +2,16 @@
>  #include "test-tool-utils.h"
>  #include "cache.h"
>  #include "parse-options.h"
> +#include "submodule-config.h"
>  #include "submodule.h"
> =20
> +#define TEST_TOOL_CHECK_NAME_USAGE \
> +	"test-tool submodule check-name <name>"
> +static const char *submodule_check_name_usage[] =3D {
> +	TEST_TOOL_CHECK_NAME_USAGE,
> +	NULL
> +};
> +
>  #define TEST_TOOL_IS_ACTIVE_USAGE \
>  	"test-tool submodule is-active <name>"
>  static const char *submodule_is_active_usage[] =3D {
> @@ -12,10 +20,47 @@ static const char *submodule_is_active_usage[] =3D {
>  };
> =20
>  static const char *submodule_usage[] =3D {
> +	TEST_TOOL_CHECK_NAME_USAGE,
>  	TEST_TOOL_IS_ACTIVE_USAGE,
>  	NULL
>  };
> =20
> +/*
> + * Exit non-zero if any of the submodule names given on the command line=
 is
> + * invalid. If no names are given, filter stdin to print only valid name=
s
> + * (which is primarily intended for testing).
> + */
> +static int check_name(int argc, const char **argv)
> +{
> +	if (argc > 1) {
> +		while (*++argv) {
> +			if (check_submodule_name(*argv) < 0)
> +				return 1;
> +		}
> +	} else {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		while (strbuf_getline(&buf, stdin) !=3D EOF) {
> +			if (!check_submodule_name(buf.buf))
> +				printf("%s\n", buf.buf);
> +		}
> +		strbuf_release(&buf);
> +	}
> +	return 0;
> +}
> +
> +static int cmd__submodule_check_name(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	argc =3D parse_options(argc, argv, "test-tools", options,
> +			     submodule_check_name_usage, 0);
> +	if (argc)
> +		usage_with_options(submodule_check_name_usage, options);
> +
> +	return check_name(argc, argv);
> +}
> +
>  static int cmd__submodule_is_active(int argc, const char **argv)
>  {
>  	struct option options[] =3D {
> @@ -32,6 +77,7 @@ static int cmd__submodule_is_active(int argc, const cha=
r **argv)
>  }
> =20
>  static struct test_cmd cmds[] =3D {
> +	{ "check-name", cmd__submodule_check_name },
>  	{ "is-active", cmd__submodule_is_active },
>  };
> =20
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index 41706c1c9ff..2c24f120da3 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -21,7 +21,7 @@ test_expect_success 'check names' '
>  	valid/with/paths
>  	EOF
> =20
> -	git submodule--helper check-name >actual <<-\EOF &&
> +	test-tool submodule check-name >actual <<-\EOF &&
>  	valid
>  	valid/with/paths

Similar to the previous patch, the only tests that use this are
verifying the behavior of "check-name" itself. But I think it makes
sense to keep this one since this seems to have always been intended to
be a sort of "unit test"; it was introduced in 0383bbb901
(submodule-config: verify submodule names as paths, 2018-04-30), and the
commit message indicates that this test protects us against certain
vulnerabilities from maliciously-crafted submodule names.

> =20
> --=20
> 2.37.1.1167.g38fda70d8c4
