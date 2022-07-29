Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2EDC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiG2VpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiG2VpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:45:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA2E11469
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:45:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j21-20020aa78d15000000b0052ce8130818so473300pfe.23
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=O4LDehx/hO8oxpfODto3Y3DQOcRX+p3xUKRO9S3CbJs=;
        b=KLjzlEhtL46UyuIIFp8V4TrBpahTrhSu7gjpTVhPbgSkKRCRgli2qttt/ip9gN3QSl
         4EipDijxBtnueHwK4bwL7XIgJS5+ultgFneJZYXnFKHF3EdcP4jjoI3iAsrc6c/6FGSn
         VjVNOEC1hHcmBC4ceYetIBVZ42FaNSBiiaLcu29pnbLHKcURUpTu5Sij/Fs4dnU69Zbs
         i6xuk9O3rwvBA8fx0c3FwZqX8b7lmYzPczyUKnyACDjbZ2wUXY0I2qpK29wOpXhLotRz
         tFLAZNsdSj4uinAyfX58KuQHr1npYoqWRB9/NI3djZReUBjBK7Jvxm70KcNhCEhugwwP
         FPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=O4LDehx/hO8oxpfODto3Y3DQOcRX+p3xUKRO9S3CbJs=;
        b=zp9f7mjG1bNXnGeThCoDxW48OJq7o/I1mt7OfIVDHo8mqhVFZ6uEr31WLt5z4CyMbF
         jPslrXr5FjzbNuOX5m7oaCPyhHtmOEvfTac3LXm2z847KzmfsORByssri5iIXXZaWVFf
         vOsOWiRUhUSol/8NmwbIlEKDgQREUBEak3NGyi7+zqNuta9G+QUKohXNU6Ryq3/3UNrL
         y82hf2yUlaTQ5ZvvFQH/sdxIBHDDdz/hE61OtSyi9GTsflE00GIBCk9PblDM8yFMlCvp
         hKPpodFaEozMKM5s1BJEztGkx1GpY0Jhlz3iFTesGEfxX30zAw/C1FmsSqDaljSsbOVK
         08FQ==
X-Gm-Message-State: ACgBeo2yM8ESjY3opXraTSSwhMNv5oPJ2ncnPL4iTR9nNGaOVS0gXGZc
        mbcOzdDnbqddrnMsT4Tw6ia3V1fI7Z4EXg==
X-Google-Smtp-Source: AA6agR6TuUltuxi4P+gHYE54Gi+7cDPbDU9reif7TqnIX4FCZ3j2/KRmMwG6oUKv7PM5gruwsmCFqKesAE+qPw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:164d:b0:1f0:31c1:9e88 with SMTP
 id il13-20020a17090b164d00b001f031c19e88mr6346189pjb.206.1659131121574; Fri,
 29 Jul 2022 14:45:21 -0700 (PDT)
Date:   Fri, 29 Jul 2022 14:45:19 -0700
In-Reply-To: <patch-06.20-8e4d2b09d56-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6lv8rfr3tc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-06.20-8e4d2b09d56-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 06/20] submodule--helper: move "is-active" to a test-tool
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

> Create a new "test-tool submodule" and move the "is-active" subcommand
> over to it. It was added in 5c2bd8b77ae (submodule--helper: add
> is-active subcommand, 2017-03-16), since
> a452128a36c (submodule--helper: introduce add-config subcommand,
> 2021-08-06) it hasn't been used by git-submodule.sh.
>
> Since we're creating a command dispatch similar to test-tool.c itself
> let's split out the "struct test_cmd" into a new test-tool-utils.h,
> which both this new code and test-tool.c itself can use.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile                       |  1 +
>  builtin/submodule--helper.c    |  9 ------
>  t/helper/test-submodule.c      | 58 ++++++++++++++++++++++++++++++++++
>  t/helper/test-tool-utils.h     |  9 ++++++
>  t/helper/test-tool.c           |  7 ++--
>  t/helper/test-tool.h           |  1 +
>  t/t7413-submodule-is-active.sh | 32 +++++++++----------
>  7 files changed, 87 insertions(+), 30 deletions(-)
>  create mode 100644 t/helper/test-submodule.c
>  create mode 100644 t/helper/test-tool-utils.h
>
> diff --git a/Makefile b/Makefile
> index 1624471badc..ad7fbd36885 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -785,6 +785,7 @@ TEST_BUILTINS_OBJS +=3D test-strcmp-offset.o
>  TEST_BUILTINS_OBJS +=3D test-string-list.o
>  TEST_BUILTINS_OBJS +=3D test-submodule-config.o
>  TEST_BUILTINS_OBJS +=3D test-submodule-nested-repo-config.o
> +TEST_BUILTINS_OBJS +=3D test-submodule.o
>  TEST_BUILTINS_OBJS +=3D test-subprocess.o
>  TEST_BUILTINS_OBJS +=3D test-trace2.o
>  TEST_BUILTINS_OBJS +=3D test-urlmatch-normalization.o
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 47ed24c6a60..b2fc732b5d8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2728,14 +2728,6 @@ static int absorb_git_dirs(int argc, const char **=
argv, const char *prefix)
>  	return 0;
>  }
> =20
> -static int is_active(int argc, const char **argv, const char *prefix)
> -{
> -	if (argc !=3D 2)
> -		die("submodule--helper is-active takes exactly 1 argument");
> -
> -	return !is_submodule_active(the_repository, argv[1]);
> -}
> -
>  /*
>   * Exit non-zero if any of the submodule names given on the command line=
 is
>   * invalid. If no names are given, filter stdin to print only valid name=
s
> @@ -3313,7 +3305,6 @@ static struct cmd_struct commands[] =3D {
>  	{"summary", module_summary, 0},
>  	{"push-check", push_check, 0},
>  	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> -	{"is-active", is_active, 0},
>  	{"check-name", check_name, 0},
>  	{"config", module_config, 0},
>  	{"set-url", module_set_url, 0},
> diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
> new file mode 100644
> index 00000000000..494c6558d9f
> --- /dev/null
> +++ b/t/helper/test-submodule.c
> @@ -0,0 +1,58 @@
> +#include "test-tool.h"
> +#include "test-tool-utils.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "submodule.h"
> +
> +#define TEST_TOOL_IS_ACTIVE_USAGE \
> +	"test-tool submodule is-active <name>"
> +static const char *submodule_is_active_usage[] =3D {
> +	TEST_TOOL_IS_ACTIVE_USAGE,
> +	NULL
> +};
> +
> +static const char *submodule_usage[] =3D {
> +	TEST_TOOL_IS_ACTIVE_USAGE,
> +	NULL
> +};
> +
> +static int cmd__submodule_is_active(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	argc =3D parse_options(argc, argv, "test-tools", options,
> +			     submodule_is_active_usage, 0);
> +	if (argc !=3D 1)
> +		usage_with_options(submodule_is_active_usage, options);
> +
> +	setup_git_directory();
> +
> +	return !is_submodule_active(the_repository, argv[0]);
> +}
> +
> +static struct test_cmd cmds[] =3D {
> +	{ "is-active", cmd__submodule_is_active },
> +};
> +
> +int cmd__submodule(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	size_t i;
> +
> +	argc =3D parse_options(argc, argv, "test-tools", options, submodule_usa=
ge,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (argc < 1)
> +		usage_with_options(submodule_usage, options);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(cmds); i++)
> +		if (!strcmp(cmds[i].name, argv[0]))
> +			return cmds[i].fn(argc, argv);
> +
> +	usage_msg_optf("unknown subcommand '%s'", submodule_usage, options,
> +		       argv[0]);
> +
> +	return 0;
> +}
> diff --git a/t/helper/test-tool-utils.h b/t/helper/test-tool-utils.h
> new file mode 100644
> index 00000000000..6a0e5e0074f
> --- /dev/null
> +++ b/t/helper/test-tool-utils.h
> @@ -0,0 +1,9 @@
> +#ifndef TEST_TOOL_UTILS_H
> +#define TEST_TOOL_UTILS_H
> +
> +struct test_cmd {
> +	const char *name;
> +	int (*fn)(int argc, const char **argv);
> +};
> +
> +#endif
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 318fdbab0c3..7a6a8b88a91 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -1,5 +1,6 @@
>  #include "git-compat-util.h"
>  #include "test-tool.h"
> +#include "test-tool-utils.h"
>  #include "trace2.h"
>  #include "parse-options.h"
> =20
> @@ -8,11 +9,6 @@ static const char * const test_tool_usage[] =3D {
>  	NULL
>  };
> =20
> -struct test_cmd {
> -	const char *name;
> -	int (*fn)(int argc, const char **argv);
> -};
> -
>  static struct test_cmd cmds[] =3D {
>  	{ "advise", cmd__advise_if_enabled },
>  	{ "bitmap", cmd__bitmap },
> @@ -78,6 +74,7 @@ static struct test_cmd cmds[] =3D {
>  	{ "simple-ipc", cmd__simple_ipc },
>  	{ "strcmp-offset", cmd__strcmp_offset },
>  	{ "string-list", cmd__string_list },
> +	{ "submodule", cmd__submodule },
>  	{ "submodule-config", cmd__submodule_config },
>  	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
>  	{ "subprocess", cmd__subprocess },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index bb799271631..5f4f69dee81 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -68,6 +68,7 @@ int cmd__sigchain(int argc, const char **argv);
>  int cmd__simple_ipc(int argc, const char **argv);
>  int cmd__strcmp_offset(int argc, const char **argv);
>  int cmd__string_list(int argc, const char **argv);
> +int cmd__submodule(int argc, const char **argv);
>  int cmd__submodule_config(int argc, const char **argv);
>  int cmd__submodule_nested_repo_config(int argc, const char **argv);
>  int cmd__subprocess(int argc, const char **argv);

I'm underqualified to comment on structure of test-tool, so I won't
comment on that, but it makes sense to convert code that is only used in
tests into test helpers.

That said, don't we only use "git submodule--helper is-active" inside
the tests for "git submodule--helper is-active"? If so, I'd think the
right thing to do is to just get rid of the code altogether.

The exception IMO, is if we think that we want a kind of "unit test"
that checks our logic for determining if a submodule is active. I don't
really think that's necessary, but if so, we probably want to update the
description of t7413 to describe that intent.

> diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active=
.sh
> index c8e7e983317..9ead083371a 100755
> --- a/t/t7413-submodule-is-active.sh
> +++ b/t/t7413-submodule-is-active.sh
> @@ -1,8 +1,8 @@
>  #!/bin/sh
> =20
> -test_description=3D'Test submodule--helper is-active
> +test_description=3D'Test with test-tool submodule is-active
> =20
> -This test verifies that `git submodue--helper is-active` correctly ident=
ifies
> +This test verifies that `test-tool submodule is-active` correctly identi=
fies
>  submodules which are "active" and interesting to the user.
>  '
> =20
> @@ -25,13 +25,13 @@ test_expect_success 'setup' '
>  '
> =20
>  test_expect_success 'is-active works with urls' '
> -	git -C super submodule--helper is-active sub1 &&
> -	git -C super submodule--helper is-active sub2 &&
> +	test-tool -C super submodule is-active sub1 &&
> +	test-tool -C super submodule is-active sub2 &&
> =20
>  	git -C super config --unset submodule.sub1.URL &&
> -	test_must_fail git -C super submodule--helper is-active sub1 &&
> +	test_must_fail test-tool -C super submodule is-active sub1 &&
>  	git -C super config submodule.sub1.URL ../sub &&
> -	git -C super submodule--helper is-active sub1
> +	test-tool -C super submodule is-active sub1
>  '
> =20
>  test_expect_success 'is-active works with submodule.<name>.active config=
' '
> @@ -39,11 +39,11 @@ test_expect_success 'is-active works with submodule.<=
name>.active config' '
>  	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
> =20
>  	git -C super config --bool submodule.sub1.active "false" &&
> -	test_must_fail git -C super submodule--helper is-active sub1 &&
> +	test_must_fail test-tool -C super submodule is-active sub1 &&
> =20
>  	git -C super config --bool submodule.sub1.active "true" &&
>  	git -C super config --unset submodule.sub1.URL &&
> -	git -C super submodule--helper is-active sub1
> +	test-tool -C super submodule is-active sub1
>  '
> =20
>  test_expect_success 'is-active works with basic submodule.active config'=
 '
> @@ -53,17 +53,17 @@ test_expect_success 'is-active works with basic submo=
dule.active config' '
>  	git -C super config --add submodule.active "." &&
>  	git -C super config --unset submodule.sub1.URL &&
> =20
> -	git -C super submodule--helper is-active sub1 &&
> -	git -C super submodule--helper is-active sub2
> +	test-tool -C super submodule is-active sub1 &&
> +	test-tool -C super submodule is-active sub2
>  '
> =20
>  test_expect_success 'is-active correctly works with paths that are not s=
ubmodules' '
>  	test_when_finished "git -C super config --unset-all submodule.active" &=
&
> =20
> -	test_must_fail git -C super submodule--helper is-active not-a-submodule=
 &&
> +	test_must_fail test-tool -C super submodule is-active not-a-submodule &=
&
> =20
>  	git -C super config --add submodule.active "." &&
> -	test_must_fail git -C super submodule--helper is-active not-a-submodule
> +	test_must_fail test-tool -C super submodule is-active not-a-submodule
>  '
> =20
>  test_expect_success 'is-active works with exclusions in submodule.active=
 config' '
> @@ -72,8 +72,8 @@ test_expect_success 'is-active works with exclusions in=
 submodule.active config'
>  	git -C super config --add submodule.active "." &&
>  	git -C super config --add submodule.active ":(exclude)sub1" &&
> =20
> -	test_must_fail git -C super submodule--helper is-active sub1 &&
> -	git -C super submodule--helper is-active sub2
> +	test_must_fail test-tool -C super submodule is-active sub1 &&
> +	test-tool -C super submodule is-active sub2
>  '
> =20
>  test_expect_success 'is-active with submodule.active and submodule.<name=
>.active' '
> @@ -85,8 +85,8 @@ test_expect_success 'is-active with submodule.active an=
d submodule.<name>.active
>  	git -C super config --bool submodule.sub1.active "false" &&
>  	git -C super config --bool submodule.sub2.active "true" &&
> =20
> -	test_must_fail git -C super submodule--helper is-active sub1 &&
> -	git -C super submodule--helper is-active sub2
> +	test_must_fail test-tool -C super submodule is-active sub1 &&
> +	test-tool -C super submodule is-active sub2
>  '
> =20
>  test_expect_success 'is-active, submodule.active and submodule add' '
> --=20
> 2.37.1.1167.g38fda70d8c4
