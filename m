Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C9BC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49D320738
	for <git@archiver.kernel.org>; Fri, 22 May 2020 22:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KabcrPAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgEVWVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 18:21:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:40703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbgEVWVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 18:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590186064;
        bh=ZlqgPX9G+Au0/tc4PYvksE5XLfmr9hxdO5IOv6/kWpY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KabcrPATOtcciS9Qv8kLTV7Nmpq2zl3dxHDtHnOigSwE3CLAbL1sFXZx4AgPUeaGE
         QQ8TAcTOWK9wXWvdsw2UU62nHVVsqhLr5nHGVHJdxpCcoisK2NXNLUIJa47s11ok9e
         PguUz0Uxih4LgIF4iOP8NtrK3/n2P6Vs3tqCviC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1jnYiH0Zdx-00FjpT; Sat, 23
 May 2020 00:21:04 +0200
Date:   Sat, 23 May 2020 00:21:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        gitster@pobox.com, congdanhqx@gmail.com, sunshine@sunshineco.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell
 to C
In-Reply-To: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005230012090.56@tvgsbejvaqbjf.bet>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3p6ekQ78TJ5uabFcUrn2HgOk4MUUYoCzY9XRK6JU6rfWH3P6Pl5
 MS9Qu0NP4ds9yErZr3qaG3Gh1nnKwiaojBB3Ye3fwIvuDdRETy7zfJXvIURjyZU4U5rm6oR
 aV8nxqwBP+PXim8uCTalr/6bCgN2bWIyiSu1tAZQshZM4fZ5Faqh7w/Qo4uijjV3L/bF3Pf
 CuncTIGbNZtME0R7uIzfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:blR+DW0gqhc=:PAPO7By4D3lZHKQJ5PQCS/
 6LUk8RolF+tJHz1s/RylEbzGAcZpd6RhHksvzhrc5P8aGe8LL/MKfGEK4cqAp41dQNt2Pen9A
 XJsPKmdBiNh7PyUuD2nWiJbACHuuIqpeUCuMUXLcVfgAomjDNU5GGD8qIw7V7OxVOqAh630KL
 wqt20u4o0GFHFvNYzeiGnSzE1hKmfQhrd3y9+uYv7kCeVXZL0sfKDb0HjYINMU3oDOWE/+DGR
 sOliCmJinp+AO7or672R6BVuwf5Kr2WIUsox1dKlCSnhnR/5HP8Mz+qNOCDpYfhYDM/di/uVM
 /1bbHlNNpDynyc/SuGWg5Lqhvy2TQ3CF5w7C1jvthwLzQMcgy1Yen12iszf+xBUyLoVwaLOIF
 f/iIc44PJA4dmdPnl5Xm3oehdLOW8P2vFA82b25giZDpwDl7Z8C+DKPeKPnxMYCeGFH8K9r6u
 G6lh7FwHtd5a6VQOweLq1cJBETVZ8RDoNQt1rZJpMbFoDHuLm/FB8zoPyP2GQoBtovy6Ixka/
 5TWGNkcEeK2enKDXqMUWhrsQQ3LE+BMwxP+DVjUB2tHooLXUeqU9+qO3YwKfwfyKt+dfDp3jZ
 RERunkxCMJ7J+mYSAPt4dA2Zjy+jkqC6qeGlu+mf9RXAVrFeO9LbgwNLe5UR93PJlLZ8YjmX8
 BboSWLDfeQxJsz4UNUtuskpDLYhNKoAIdGwHlDRINYvbcVvrMFjZPfQ3+iGtm5J3p/XSar3sH
 JrWjIvJ4yfooyrMz60wenhiJCOo1ipY/+6d2xy6e29iBXM3lLU/WnO8WWmtUhLkdsqIcahFtt
 rVWIXVCfhL5xFCYnJ98Eh98rw+TNezF1n54F2WMXzFS7tJEbLb3M0O1pGfTsO5K+rqAJYQlzI
 SDAKRb45M4aXOCvcMzp8EvNvsOFywBk+8wf7n+3eZHu37G3sA/XHSgImNG0qU/Z+bdOt4O13E
 JrE01kDaBkKG+ttfERBgdG/zojaaluX9LQSDU3C4mr8j9lJv1Syog3llbVaszO94fd5lij8TQ
 vZNM97/XKGgNPW9v/ON1exWiEbCxT/EcA0IuG20SYx9yNu6UbHf3kv4iZNyK7FK5XyFXwFQh8
 A6IJEAqV7k36hZYfgyvle9IMuz9Aib90fA54ZDziLypN5EO46/q17rGGKPZrVQv8Un7YmMMDe
 eOmY2aQmal7rh8sqLnekc+tXQsKVdcjmUZAPZZpMVC/kG+nRwLD/UigL7YefaHUUlWlvbvn3d
 WkN3iiODLoFGc5A+E
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Thu, 21 May 2020, Shourya Shukla wrote:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f50745a03f..d14b9856a3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2284,6 +2284,50 @@ static int module_set_url(int argc, const char **=
argv, const char *prefix)
>  	return 0;
>  }
>
> +static int module_set_branch(int argc, const char **argv, const char *p=
refix)
> +{
> +	/*
> +	 * The `quiet` option is present for backward compatibility
> +	 * but is currently not used.
> +	 */
> +	int quiet =3D 0, opt_default =3D 0;
> +	const char *opt_branch =3D NULL;
> +	const char *path;
> +	char *config_name;
> +
> +	struct option options[] =3D {
> +		OPT__QUIET(&quiet,
> +			N_("suppress output for setting default tracking branch")),
> +		OPT_BOOL(0, "default", &opt_default,
> +			N_("set the default tracking branch to master")),
> +		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
> +			N_("set the default tracking branch")),
> +		OPT_END()
> +	};
> +	const char *const usage[] =3D {
> +		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"=
),
> +		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch>=
 <path>"),
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (!opt_branch && !opt_default)
> +		die(_("--branch or --default required"));
> +
> +	if (opt_branch && opt_default)
> +		die(_("--branch and --default are mutually exclusive"));
> +
> +	if (argc !=3D 1 || !(path =3D argv[0]))
> +		usage_with_options(usage, options);
> +
> +	config_name =3D xstrfmt("submodule.%s.branch", path);
> +	config_set_in_gitmodules_file_gently(config_name, opt_branch);

What happens if this fails? E.g. when the permission is denied or disk is
full? This C code would then still `return 0`, pretending that it
succeeded. But the original shell script calls `git submodule--helper
config [...]` which calls `module_config()`, which in turn passes through
the return value of the `config_set_in_gitmodules_file_gently()` call.

In other words, you need something like this:

	int ret;

	[...]

	ret =3D config_set_in_gitmodules_file_gently(config_name, opt_branch);

	free(config_name);
	return ret;

> +
> +	free(config_name);
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>
>  struct cmd_struct {
> @@ -2315,6 +2359,7 @@ static struct cmd_struct commands[] =3D {
>  	{"check-name", check_name, 0},
>  	{"config", module_config, 0},
>  	{"set-url", module_set_url, 0},
> +	{"set-branch", module_set_branch, 0},

BTW I just noticed that the return value of these helpers is returned by
the `cmd_submodule__helper()` function. That is not correct, as the
convention is for Git's functions to return negative values in case of
errors _except_ for `cmd_*()` functions, which need to return an exit code
(valid values are between 0 and 127).

So I think we'll also need this (it's unrelated to your patch, at least
unrelated enough that it merits its own, separate patch):

-                       return commands[i].fn(argc - 1, argv + 1, prefix);
+                       return !!commands[i].fn(argc - 1, argv + 1, prefix=
);

Ciao,
Dscho

>  };
>
>  int cmd_submodule__helper(int argc, const char **argv, const char *pref=
ix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 39ebdf25b5..8c56191f77 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -719,7 +719,7 @@ cmd_update()
>  # $@ =3D requested path
>  #
>  cmd_set_branch() {
> -	unset_branch=3Dfalse
> +	default=3D
>  	branch=3D
>
>  	while test $# -ne 0
> @@ -729,7 +729,7 @@ cmd_set_branch() {
>  			# we don't do anything with this but we need to accept it
>  			;;
>  		-d|--default)
> -			unset_branch=3Dtrue
> +			default=3D1
>  			;;
>  		-b|--branch)
>  			case "$2" in '') usage ;; esac
> @@ -750,33 +750,7 @@ cmd_set_branch() {
>  		shift
>  	done
>
> -	if test $# -ne 1
> -	then
> -		usage
> -	fi
> -
> -	# we can't use `git submodule--helper name` here because internally, i=
t
> -	# hashes the path so a trailing slash could lead to an unintentional n=
o match
> -	name=3D"$(git submodule--helper list "$1" | cut -f2)"
> -	if test -z "$name"
> -	then
> -		exit 1
> -	fi
> -
> -	test -n "$branch"; has_branch=3D$?
> -	test "$unset_branch" =3D true; has_unset_branch=3D$?
> -
> -	if test $((!$has_branch !=3D !$has_unset_branch)) -eq 0
> -	then
> -		usage
> -	fi
> -
> -	if test $has_branch -eq 0
> -	then
> -		git submodule--helper config submodule."$name".branch "$branch"
> -	else
> -		git submodule--helper config --unset submodule."$name".branch
> -	fi
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} =
submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $bra=
nch} ${default:+--default} -- "$@"
>  }
>
>  #
> --
> 2.26.2
>
>
