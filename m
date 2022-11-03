Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B42C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 22:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiKCWKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKCWKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 18:10:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7EE12E
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:10:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36810cfa61fso30226507b3.6
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTksdbRtn/fovZa/9x+1K2tm94j2vmTuJWKS/OuBGvA=;
        b=DSBXD8uPnFaHKVNZ6boX8k4ZaPa2NnodChriBmINRn0SazBAS0NWSNFxs2XT9admgi
         pDLDgGtZJ5TGmMd1Cc9wFunfb31CfwBUszGBdlryU5T9hYKxJi5kuY+cO/U2L3VxKOtH
         dJvGcG/2oMT3yP/Z+1MomPNapw3MVZPMHMEz8ByrEwWCsJqdWCBne4ZdV9T6ZkineHfl
         Ve2/9VpYDLXXCSl9RubvWxXWVhPI0YHcncTqDeF9+irfEDi703qjoV5mUi5ztzymTi9A
         wSWMT/x9stYWO4NW2Iq0IawimyA6AqzoscAZ8CaIoknIOR4/9eNxz9bXlXGsK8bmvumW
         gXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTksdbRtn/fovZa/9x+1K2tm94j2vmTuJWKS/OuBGvA=;
        b=Cl1Uc4gV5yX/JIx/zl/LXVcDP0Z4M/U1N2JHwN7dL44Kng3tvD13CeSBTchCouejLg
         2eJwoHAqEa3TYKWQ3WNWWz3L0ry99bOUWWqVemhimaaALgB5XbHuR50hXvLHxGMISYk/
         wxesxvgKVVyf/WH9SEJBam+yFg92WNrUc4uKoRUma7YX10tETZ3YS79oZPfrFkzpfOJV
         uWm1fzDUPedzqclBm8qFrMRWwP4snDIXheh6XNg+X1pNkgR6pJUpG1H07wMuxLhH5Led
         GJ9cD+zQGXToVKJWVTz9QEHOFGhPBpxE9dlbIhqxGB4Yiv+GH/Msjf/TiR3lXxbFP5hv
         K8IQ==
X-Gm-Message-State: ACrzQf2l3PGRnVujwNNOMXPafcpFaoh8wwexGW+ttonBnCNsr29b98PI
        MnuqTaLEv+a+D/WUk73Nv1RHZ53TGt8AdA==
X-Google-Smtp-Source: AMsMyM5M09hpbhHMZ7RaX7uQ2UhdBba3xTKc1G4eMvwdJNOaBoWdSxmZJ7rGYPkDNj95On/jkF6VGM1unYeQ3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:4444:0:b0:6cb:a59c:41ef with SMTP id
 r65-20020a254444000000b006cba59c41efmr28551974yba.228.1667513407074; Thu, 03
 Nov 2022 15:10:07 -0700 (PDT)
Date:   Thu, 03 Nov 2022 15:09:58 -0700
In-Reply-To: <patch-1.8-b2649f96715-20221102T074148Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <patch-1.8-b2649f96715-20221102T074148Z-avarab@gmail.com>
Message-ID: <kl6lfsezofk9.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 1/8] submodule--helper: move "config" to a test-tool
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As with other moves to "test-tool" in f322e9f51b5 (Merge branch
> 'ab/submodule-helper-prep', 2022-09-13) the "config" sub-command was
> only used by our own tests.
>
> Let's move it over, and while doing so make it easier to reason about
> by splitting up the various uses for it into separate sub-commands, so
> that we don't need to count arguments to see what it does.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c            | 46 --------------
>  t/helper/test-submodule.c              | 84 ++++++++++++++++++++++++++
>  t/t7411-submodule-config.sh            | 28 ++++-----
>  t/t7418-submodule-sparse-gitmodules.sh |  4 +-
>  4 files changed, 100 insertions(+), 62 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a7683d35299..6250b95a6f7 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2861,51 +2861,6 @@ static int absorb_git_dirs(int argc, const char **=
argv, const char *prefix)
>  	return ret;
>  }
> =20
> -static int module_config(int argc, const char **argv, const char *prefix=
)
> -{
> -	enum {
> -		CHECK_WRITEABLE =3D 1,
> -		DO_UNSET =3D 2
> -	} command =3D 0;
> -	struct option module_config_options[] =3D {
> -		OPT_CMDMODE(0, "check-writeable", &command,
> -			    N_("check if it is safe to write to the .gitmodules file"),
> -			    CHECK_WRITEABLE),
> -		OPT_CMDMODE(0, "unset", &command,
> -			    N_("unset the config in the .gitmodules file"),
> -			    DO_UNSET),
> -		OPT_END()
> -	};
> -	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper config <name> [<value>]"),
> -		N_("git submodule--helper config --unset <name>"),
> -		"git submodule--helper config --check-writeable",
> -		NULL
> -	};
> -
> -	argc =3D parse_options(argc, argv, prefix, module_config_options,
> -			     git_submodule_helper_usage, PARSE_OPT_KEEP_ARGV0);
> -
> -	if (argc =3D=3D 1 && command =3D=3D CHECK_WRITEABLE)
> -		return is_writing_gitmodules_ok() ? 0 : -1;
> -
> -	/* Equivalent to ACTION_GET in builtin/config.c */
> -	if (argc =3D=3D 2 && command !=3D DO_UNSET)
> -		return print_config_from_gitmodules(the_repository, argv[1]);
> -
> -	/* Equivalent to ACTION_SET in builtin/config.c */
> -	if (argc =3D=3D 3 || (argc =3D=3D 2 && command =3D=3D DO_UNSET)) {
> -		const char *value =3D (argc =3D=3D 3) ? argv[2] : NULL;
> -
> -		if (!is_writing_gitmodules_ok())
> -			die(_("please make sure that the .gitmodules file is in the working t=
ree"));
> -
> -		return config_set_in_gitmodules_file_gently(argv[1], value);
> -	}
> -
> -	usage_with_options(git_submodule_helper_usage, module_config_options);
> -}
> -
>  static int module_set_url(int argc, const char **argv, const char *prefi=
x)
>  {
>  	int quiet =3D 0;

"git submodule--helper config" isn't familiar to me, so I did a bit of
digging. It looks like it falls into the category of submodule--helper
subcommmands that exist to expose functionality that's easy to do
in-process, but otherwise inaccessible to git-submodule.sh.=20

Its last use (I think) was in a6226fd772 (submodule--helper: convert the
bulk of cmd_add() to C, 2021-08-10).

> @@ -3424,7 +3379,6 @@ static struct cmd_struct commands[] =3D {
>  	{"summary", module_summary, 0},
>  	{"push-check", push_check, 0},
>  	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> -	{"config", module_config, 0},
>  	{"set-url", module_set_url, 0},
>  	{"set-branch", module_set_branch, 0},
>  	{"create-branch", module_create_branch, 0},
> diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
> index b7d117cd557..c7cb463a583 100644
> --- a/t/helper/test-submodule.c
> +++ b/t/helper/test-submodule.c
> @@ -111,10 +111,94 @@ static int cmd__submodule_resolve_relative_url(int =
argc, const char **argv)
>  	return 0;
>  }
> =20
> +static int cmd__submodule_config_list(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	const char *const usage[] =3D {
> +		"test-tool submodule config-list <key>",
> +		NULL
> +	};
> +	argc =3D parse_options(argc, argv, "test-tools", options, usage,
> +			     PARSE_OPT_KEEP_ARGV0);
> +
> +	setup_git_directory();
> +
> +	if (argc =3D=3D 2)
> +		return print_config_from_gitmodules(the_repository, argv[1]);
> +	usage_with_options(usage, options);
> +}
> +
> +static int cmd__submodule_config_set(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	const char *const usage[] =3D {
> +		"test-tool submodule config-set <key> <value>",
> +		NULL
> +	};
> +	argc =3D parse_options(argc, argv, "test-tools", options, usage,
> +			     PARSE_OPT_KEEP_ARGV0);
> +
> +	setup_git_directory();
> +
> +	/* Equivalent to ACTION_SET in builtin/config.c */
> +	if (argc =3D=3D 3) {
> +		if (!is_writing_gitmodules_ok())
> +			die(_("please make sure that the .gitmodules file is in the working t=
ree"));
> +
> +		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> +	}
> +	usage_with_options(usage, options);
> +}
> +
> +static int cmd__submodule_config_unset(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	const char *const usage[] =3D {
> +		"test-tool submodule config-unset <key>",
> +		NULL
> +	};
> +
> +	setup_git_directory();
> +
> +	if (argc =3D=3D 2) {
> +		if (!is_writing_gitmodules_ok())
> +			die(_("please make sure that the .gitmodules file is in the working t=
ree"));
> +		return config_set_in_gitmodules_file_gently(argv[1], NULL);
> +	}
> +	usage_with_options(usage, options);
> +}
> +
> +static int cmd__submodule_config_writeable(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	const char *const usage[] =3D {
> +		"test-tool submodule config-writeable",
> +		NULL
> +	};
> +	setup_git_directory();
> +
> +	if (argc =3D=3D 1)
> +		return is_writing_gitmodules_ok() ? 0 : -1;
> +
> +	usage_with_options(usage, options);
> +}
> +
>  static struct test_cmd cmds[] =3D {
>  	{ "check-name", cmd__submodule_check_name },
>  	{ "is-active", cmd__submodule_is_active },
>  	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
> +	{ "config-list", cmd__submodule_config_list },
> +	{ "config-set", cmd__submodule_config_set },
> +	{ "config-unset", cmd__submodule_config_unset },
> +	{ "config-writeable", cmd__submodule_config_writeable },
>  };
> =20
>  int cmd__submodule(int argc, const char **argv)
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index c583c4e373a..2f57ecd177a 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -140,15 +140,15 @@ test_expect_success 'error in history in fetchrecur=
sesubmodule lets continue' '
>  test_expect_success 'reading submodules config from the working tree wit=
h "submodule--helper config"' '
>  	(cd super &&
>  		echo "../submodule" >expect &&
> -		git submodule--helper config submodule.submodule.url >actual &&
> +		test-tool submodule config-list submodule.submodule.url >actual &&
>  		test_cmp expect actual
>  	)
>  '
> =20
>  test_expect_success 'unsetting submodules config from the working tree w=
ith "submodule--helper config --unset"' '
>  	(cd super &&
> -		git submodule--helper config --unset submodule.submodule.url &&
> -		git submodule--helper config submodule.submodule.url >actual &&
> +		test-tool submodule config-unset submodule.submodule.url &&
> +		test-tool submodule config-list submodule.submodule.url >actual &&
>  		test_must_be_empty actual
>  	)
>  '

In a few of the test names, we still say 'do X with "submodule--helper
config [...]"'. I think just we can drop 'with "submodule--helper config
[...]"', e.g.

     test_expect_sucess 'unsetting submodules config from the working tree'

> @@ -157,8 +157,8 @@ test_expect_success 'unsetting submodules config from=
 the working tree with "sub
>  test_expect_success 'writing submodules config with "submodule--helper c=
onfig"' '
>  	(cd super &&
>  		echo "new_url" >expect &&
> -		git submodule--helper config submodule.submodule.url "new_url" &&
> -		git submodule--helper config submodule.submodule.url >actual &&
> +		test-tool submodule config-set submodule.submodule.url "new_url" &&
> +		test-tool submodule config-list submodule.submodule.url >actual &&
>  		test_cmp expect actual
>  	)
>  '
> @@ -167,14 +167,14 @@ test_expect_success 'overwriting unstaged submodule=
s config with "submodule--hel
>  	test_when_finished "git -C super checkout .gitmodules" &&
>  	(cd super &&
>  		echo "newer_url" >expect &&
> -		git submodule--helper config submodule.submodule.url "newer_url" &&
> -		git submodule--helper config submodule.submodule.url >actual &&
> +		test-tool submodule config-set submodule.submodule.url "newer_url" &&
> +		test-tool submodule config-list submodule.submodule.url >actual &&
>  		test_cmp expect actual
>  	)
>  '
> =20
>  test_expect_success 'writeable .gitmodules when it is in the working tre=
e' '
> -	git -C super submodule--helper config --check-writeable
> +	test-tool -C super submodule config-writeable
>  '
> =20
>  test_expect_success 'writeable .gitmodules when it is nowhere in the rep=
ository' '
> @@ -183,7 +183,7 @@ test_expect_success 'writeable .gitmodules when it is=
 nowhere in the repository'
>  	(cd super &&
>  		git rm .gitmodules &&
>  		git commit -m "remove .gitmodules from the current branch" &&
> -		git submodule--helper config --check-writeable
> +		test-tool submodule config-writeable
>  	)
>  '

The value of the writeable/unwriteable tests feels quite low to me, but
I am ok to keep them just to be safe.

> =20
> @@ -191,7 +191,7 @@ test_expect_success 'non-writeable .gitmodules when i=
t is in the index but not i
>  	test_when_finished "git -C super checkout .gitmodules" &&
>  	(cd super &&
>  		rm -f .gitmodules &&
> -		test_must_fail git submodule--helper config --check-writeable
> +		test_must_fail test-tool submodule config-writeable
>  	)
>  '
> =20
> @@ -200,7 +200,7 @@ test_expect_success 'non-writeable .gitmodules when i=
t is in the current branch
>  	test_when_finished "git -C super reset --hard $ORIG" &&
>  	(cd super &&
>  		git rm .gitmodules &&
> -		test_must_fail git submodule--helper config --check-writeable
> +		test_must_fail test-tool submodule config-writeable
>  	)
>  '
> =20
> @@ -208,11 +208,11 @@ test_expect_success 'reading submodules config from=
 the index when .gitmodules i
>  	ORIG=3D$(git -C super rev-parse HEAD) &&
>  	test_when_finished "git -C super reset --hard $ORIG" &&
>  	(cd super &&
> -		git submodule--helper config submodule.submodule.url "staged_url" &&
> +		test-tool submodule config-set submodule.submodule.url "staged_url" &&
>  		git add .gitmodules &&
>  		rm -f .gitmodules &&
>  		echo "staged_url" >expect &&
> -		git submodule--helper config submodule.submodule.url >actual &&
> +		test-tool submodule config-list submodule.submodule.url >actual &&
>  		test_cmp expect actual
>  	)
>  '
> @@ -223,7 +223,7 @@ test_expect_success 'reading submodules config from t=
he current branch when .git
>  	(cd super &&
>  		git rm .gitmodules &&
>  		echo "../submodule" >expect &&
> -		git submodule--helper config submodule.submodule.url >actual &&
> +		test-tool submodule config-list submodule.submodule.url >actual &&
>  		test_cmp expect actual
>  	)
>  '
> diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-s=
parse-gitmodules.sh
> index d5874200fdc..dde11ecce80 100755
> --- a/t/t7418-submodule-sparse-gitmodules.sh
> +++ b/t/t7418-submodule-sparse-gitmodules.sh
> @@ -50,12 +50,12 @@ test_expect_success 'sparse checkout setup which hide=
s .gitmodules' '
> =20
>  test_expect_success 'reading gitmodules config file when it is not check=
ed out' '
>  	echo "../submodule" >expect &&
> -	git -C super submodule--helper config submodule.submodule.url >actual &=
&
> +	test-tool -C super submodule config-list submodule.submodule.url >actua=
l &&
>  	test_cmp expect actual
>  '
> =20
>  test_expect_success 'not writing gitmodules config file when it is not c=
hecked out' '
> -	test_must_fail git -C super submodule--helper config submodule.submodul=
e.url newurl &&
> +	test_must_fail test-tool -C super submodule config-set submodule.submod=
ule.url newurl &&
>  	test_path_is_missing super/.gitmodules
>  '
> =20
> --=20
> 2.38.0.1280.g8136eb6fab2
