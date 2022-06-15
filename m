Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5504AC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 04:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiFOEBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFOEBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 00:01:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003525298
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:01:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lk16-20020a17090b33d000b001e68a9ac3a1so643897pjb.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LnVe1EnZXrjWORav8AoPEiOf5RETPBftV6j4bRHdjyc=;
        b=JIVTxqrNltaUjyIlRriv++XPLgWBx3kJkRvcqJzhL5TBQFx6PGmYdX7sKpynxFVkr4
         ReUJxbH/yp5DW3XWHQbk3SLY2zUCEwzgvIYf9EEPS1q9XWKlsC/n8SaF3PBEFwDxWNvw
         tKZD1PmQx4xWhfkSan4w4QOm1Y7MV19XMH+Zja1C5HiIb+3PsgDY0STJA19zCFPUyVgX
         LnadQ3dNN9LJXoToi1gMJcJ0gKKQyP5WZYYyO16MdsYFwrvRsaBHGjBb1aanyEvu0/Rw
         9u4AFgPYMpnSSkhjkdCiPo658XVc0d7e2pqvPabMNtd/xc+FL5Vy2wCaqlAfUzA40KLP
         Qg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LnVe1EnZXrjWORav8AoPEiOf5RETPBftV6j4bRHdjyc=;
        b=x9/Cd7SwtZhe270HrHXOIBeLgB/+MztpdNn1w+PErvyhuQS0+qVwI2RWRpFQ9GV81f
         pJwjtl/0AakU0bru5U/3Ne3XuITxMZzGyxVVAxGzQDuN5jm6RHo9OsMdPNpJFtLQBClb
         GtL2ueKue3u0ILRNfWY30b3D5U8ySpjA7w5K49mNidnL1lSBFyNClUbrXaK3E4hEsk/8
         a+TMJCgECam0Rc0r74x2XL2xPsKRnWXhQ2HkGJ75/kW6QQ1V6EIu1OALoQNSDkc+X4Yh
         0vNZb5t4QOcwx367Lg8QTzauA+a3+acwZU58tOhBEx4NtFE4ccPklAFjVXd7+6soH7Ug
         OAXQ==
X-Gm-Message-State: AJIora9r+j/un/uMJK8k/d4zJxsqtHKgAV2LWRT0NAErKftNXNv0vh2d
        4EgZhgxTzAFsE/jwtExYrx9fNXi7Jro0GQ==
X-Google-Smtp-Source: AGRyM1vv1L48wVLuiUhHnPJuS6+L+T1aiWOeTBn4GKtcqpFBWuAwoJu1fNsz06EoFGamRa1EAFV4PuNAsOHLug==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:1249:b0:168:e059:59c1 with SMTP
 id u9-20020a170903124900b00168e05959c1mr7404420plh.0.1655265705442; Tue, 14
 Jun 2022 21:01:45 -0700 (PDT)
Date:   Tue, 14 Jun 2022 21:01:44 -0700
In-Reply-To: <patch-v2-08.12-99ac52d810f-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6lczfa60d3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-08.12-99ac52d810f-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 08/12] submodule--helper: report "submodule" as our
 name in "-h" output
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 574d6e0a79b..c2f55779cb1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -286,7 +286,7 @@ static int module_list(int argc, const char **argv, c=
onst char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper list [--prefix=3D<path>] [<path>...]"),
> +		N_("git submodule list [--prefix=3D<path>] [<path>...]"),
>  		NULL
>  	};
> @@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv=
, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <comman=
d>"),
> +		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
>  		NULL
>  	};
> =20
> @@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, c=
onst char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper init [<options>] [<path>]"),
> +		N_("git submodule init [<options>] [<path>]"),
>  		NULL
>  	};
> =20
> @@ -786,7 +786,7 @@ static int module_name(int argc, const char **argv, c=
onst char *prefix)
>  	const struct submodule *sub;
> =20
>  	if (argc !=3D 2)
> -		usage(_("git submodule--helper name <path>"));
> +		usage(_("git submodule name <path>"));
> =20
>  	sub =3D submodule_from_path(the_repository, null_oid(), argv[1]);
> =20
> @@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **ar=
gv, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]=
"),
> +		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
>  		NULL
>  	};
> =20
> @@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv,=
 const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
> +		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
>  		NULL
>  	};
> =20
> @@ -1789,7 +1789,7 @@ static int module_clone(int argc, const char **argv=
, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper clone [--prefix=3D<path>] [--quiet] "
> +		N_("git submodule clone [--prefix=3D<path>] [--quiet] "
>  		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
>  		   "[--single-branch] [--filter <filter-spec>] "
>  		   "--url <url> --path <path>"),
> @@ -2787,7 +2787,7 @@ static int absorb_git_dirs(int argc, const char **a=
rgv, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
> +		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
>  		NULL
>  	};
> =20
> @@ -2851,9 +2851,9 @@ static int module_config(int argc, const char **arg=
v, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper config <name> [<value>]"),
> -		N_("git submodule--helper config --unset <name>"),
> -		"git submodule--helper config --check-writeable",
> +		N_("git submodule config <name> [<value>]"),
> +		N_("git submodule config --unset <name>"),
> +		"git submodule config --check-writeable",
>  		NULL
>  	};
> =20
> @@ -2892,7 +2892,7 @@ static int module_set_url(int argc, const char **ar=
gv, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> +		N_("git submodule set-url [--quiet] <path> <newurl>"),
>  		NULL
>  	};
> =20
> @@ -2931,8 +2931,8 @@ static int module_set_branch(int argc, const char *=
*argv, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path=
>"),
> -		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branc=
h> <path>"),
> +		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
> +		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path=
>"),
>  		NULL
>  	};
> =20
> @@ -2973,7 +2973,7 @@ static int module_create_branch(int argc, const cha=
r **argv, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper create-branch [-f|--force] [--create-reflog]=
 [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>")=
,
> +		N_("git submodule create-branch [-f|--force] [--create-reflog] [-q|--q=
uiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
>  		NULL
>  	};
> =20
> @@ -3276,7 +3276,7 @@ static int module_add(int argc, const char **argv, =
const char *prefix)
>  	};
> =20
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper add [<options>] [--] <repository> [<path>]")=
,
> +		N_("git submodule add [<options>] [--] <repository> [<path>]"),
>  		NULL
>  	};

I don't feel positive about pretending to be "git submodule" when the
subcommand is internal-only. Such commands are only invoked as "git
submodule--helper foo" and we will probably never turn them into
external-facing "git submodule foo" [1]. Even if it is internal-only,
there is a debugging benefit to emitting a usage string with the
correct, non-user facing command name.

I admit it might be a bit confusing to have a mix of usage strings with
"submodule--helper" vs "submodule", but as long as we clearly label
which commands are user-facing and which aren't, it shouldn't be too
hard to maintain, e.g. this might just be a matter of adding comments to
the array of commands like:

  static struct cmd_struct commands[] =3D {
    /* User facing commands - pretend to be "git submodule" */
    {"name", module_name},
    {"add", module_add},
    [...]
    /* Internal-only commands */
    {"clone", module_clone},
    {"resolve-relative-url-test", resolve_relative_url_test},
    [...]
  };

Notably, even with this patch we still _kind of_ have 'pseudo usage
strings' that reference "git submodule--helper". These are just
internal-only commands that don't use the parse_options() API, e.g.

	if (argc < 3)
		die("submodule--helper push-check requires at least 2 arguments");

I think it's ok to leave them as-is, provided we also leave the other
internal-only commands as-is.

[1] For convenience, here is a list of all of the subcommands changed in
this patch and whether they are user-facing/internal-only:

User-facing                 Internal-only

- foreach                   - list
- init                      - name
- summary                   - clone
- sync                      - config
- absorbgitdirs             - create-branch
- set-url
- set-branch
- add
