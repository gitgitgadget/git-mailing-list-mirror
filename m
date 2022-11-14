Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B482EC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiKNWb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiKNWb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:31:26 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B74815A05
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:31:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b18-20020a170903229200b00186e357f3b9so9850067plh.6
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghcXN+YvtycWnHWJW0G2ufhIm47iQapeUN4L4EpwBos=;
        b=NhxZNu6eYixJamLS4ot+ajW4qAbNywlhQ+zxQ/VghvrYTU2zXPqS52a/RwN8lwARam
         V7LA0Cj4U4gLLdLyEtMJchfrd1fXeGXoLJZLgOYtjAbNjdWkn3cjUB7tynxJIMEMx65F
         f7/8JDpSr9MozO7xnZ8yOLHF1cCIHseDQzAWT4cjM8U+sV7rEKAcZmmBOcjd2XjsNM1C
         6Zxh9wv+MPZHKhQMkQ3NadlDMx7MZ2A3/s/R6w1AwPeCJ0TH8beC4NXQ63EOGUiCBYS1
         UUXLD35hW3C0+LrM/MHchDu0qU710IcA34d/4ij6Ibu0Cx5jsWI00lMK6D3kQ5nBjkB6
         jC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghcXN+YvtycWnHWJW0G2ufhIm47iQapeUN4L4EpwBos=;
        b=BDwB6QWCsXyq+VIDDWwmrKi8aR0HlCVsu1QVp6hPCLIgQynvmpS0WLObNTd3NbmFwC
         /X3Lu26CTi17Ofp14y51Ml/JQf6Q6TUEtrh4yqr9xTF1Y7vq09gpeHBvrYUcllk8NSOP
         8dsG2jDM+YGjxEUbC8tgEoi/rbJo9EhsEWoinW9TY8BjyI4HcIdMpVnjNgE70/XABrrR
         ZEu6iCn8Zd/u9kcXWmgNbk5XVjtjH5kIt+iWXuTuS8LZ7uIO7/n0ZQbDyPCpA4ZLhyuR
         tIRPjYQtHvG/41jPipjJ1vNJPLfe69Eqk1v5Kan9ypdKg2kiF07Mr+Or0o7KYETDvOpG
         xKHg==
X-Gm-Message-State: ANoB5pks3VEgKgC+gj0lzc0/IzmypwNFmkm4f/zRHMrJ4nQH/0gvqiyD
        8yZnXgsD2VTEKgokkn4f/6fSE5dG7q9JaA==
X-Google-Smtp-Source: AA0mqf6yPeDVfqI7WX5vr/Qwy2NWNY2uUNKT4kTUZGEIG8PZAWjXwkGox4emIXrzjA/UZJu57fIy85dXYR7Vsw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:cc7:b0:213:2708:8dc3 with SMTP id
 7-20020a17090a0cc700b0021327088dc3mr169414pjt.2.1668465084312; Mon, 14 Nov
 2022 14:31:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:31:22 -0800
In-Reply-To: <patch-v2-10.10-100ba36dfb7-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <patch-v2-10.10-100ba36dfb7-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6lsfilnp6t.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 10/10] fetch: rename "--submodule-prefix" to "--super-prefix"
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

Thanks for picking this up, especially since you feel "meh" about it :)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In preceding commits we've introduced a command-level "--super-prefix"
> option, which unlike the "git --super-prefix" it replaced doesn't rely
> on setenv() or getenv(), it's just a normal command-line option that
> the command passes down.
>
> Since we've done that, let's rename the "--submodule-prefix" option
> added in 7dce19d374a (fetch/pull: Add the --recurse-submodules option,
> 2010-11-12) to "--super-prefix" for consistency. This:
>
>  * Allows us to use OPT__SUPER_PREFIX().
>  * Leaves an unspecified "--super-prefix" with a "NULL" value, rather
>    than an empty string, as is the case with the other "--super-prefix"
>    users. We coerce the NULL to "" in submodule.c before using it.

[...]

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/fetch-options.txt |  5 -----
>  builtin/fetch.c                 |  7 +++----
>  submodule.c                     | 23 +++++++++++------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-option=
s.txt
> index 622bd84768b..20cbd2c2910 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -241,11 +241,6 @@ endif::git-pull[]
>  	linkgit:git-config[1].
> =20
>  ifndef::git-pull[]
> ---submodule-prefix=3D<path>::
> -	Prepend <path> to paths printed in informative messages
> -	such as "Fetching submodule foo".  This option is used
> -	internally when recursing over submodules.
> -
>  --recurse-submodules-default=3D[yes|on-demand]::
>  	This option is used internally to temporarily provide a
>  	non-negative default value for the --recurse-submodules
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7378cafeec9..353bcd36d24 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -74,7 +74,7 @@ static struct string_list deepen_not =3D STRING_LIST_IN=
IT_NODUP;
>  static struct strbuf default_rla =3D STRBUF_INIT;
>  static struct transport *gtransport;
>  static struct transport *gsecondary;
> -static const char *submodule_prefix =3D "";
> +static const char *super_prefix;

Is there a reason we can't keep the '=3D ""'?

>  static int recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
>  static int recurse_submodules_cli =3D RECURSE_SUBMODULES_DEFAULT;
>  static int recurse_submodules_default =3D RECURSE_SUBMODULES_ON_DEMAND;
> @@ -195,8 +195,7 @@ static struct option builtin_fetch_options[] =3D {
>  	OPT_SET_INT_F(0, "refetch", &refetch,
>  		      N_("re-fetch without negotiating common commits"),
>  		      1, PARSE_OPT_NONEG),
> -	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
> -		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
> +	OPT__SUPER_PREFIX(&super_prefix),
>  	OPT_CALLBACK_F(0, "recurse-submodules-default",
>  		   &recurse_submodules_default, N_("on-demand"),
>  		   N_("default for recursive fetching of submodules "
> @@ -2300,7 +2299,7 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
>  		add_options_to_argv(&options);
>  		result =3D fetch_submodules(the_repository,
>  					  &options,
> -					  submodule_prefix,
> +					  super_prefix,
>  					  recurse_submodules,
>  					  recurse_submodules_default,
>  					  verbosity < 0,
> diff --git a/submodule.c b/submodule.c
> index 5ac4e1b0568..1e4eee3492b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1376,7 +1376,7 @@ struct submodule_parallel_fetch {
>  	int changed_count;
>  	struct strvec args;
>  	struct repository *r;
> -	const char *prefix;
> +	const char *super_prefix;
>  	int command_line_option;
>  	int default_option;
>  	int quiet;
> @@ -1567,7 +1567,7 @@ get_fetch_task_from_index(struct submodule_parallel=
_fetch *spf,
>  		if (task->repo) {
>  			if (!spf->quiet)
>  				strbuf_addf(err, _("Fetching submodule %s%s\n"),
> -					    spf->prefix, ce->name);
> +					    spf->super_prefix, ce->name);
> =20
>  			spf->index_count++;
>  			return task;
> @@ -1629,7 +1629,7 @@ get_fetch_task_from_changed(struct submodule_parall=
el_fetch *spf,
>  		if (!spf->quiet)
>  			strbuf_addf(err,
>  				    _("Fetching submodule %s%s at commit %s\n"),
> -				    spf->prefix, task->sub->path,
> +				    spf->super_prefix, task->sub->path,
>  				    find_unique_abbrev(cs_data->super_oid,
>  						       DEFAULT_ABBREV));
> =20
> @@ -1687,11 +1687,10 @@ static int get_next_submodule(struct child_proces=
s *cp, struct strbuf *err,
>  			strvec_pushv(&cp->args, task->git_args.v);
>  		strvec_pushv(&cp->args, spf->args.v);
>  		strvec_push(&cp->args, task->default_argv);
> -		strvec_push(&cp->args, "--submodule-prefix");
> +		strvec_push(&cp->args, "--super-prefix");
> =20
> -		strbuf_addf(&submodule_prefix, "%s%s/",
> -						spf->prefix,
> -						task->sub->path);
> +		strbuf_addf(&submodule_prefix, "%s%s/", spf->super_prefix,
> +			    task->sub->path);
>  		strvec_push(&cp->args, submodule_prefix.buf);
>  		*task_cb =3D task;
> =20
> @@ -1707,7 +1706,7 @@ static int get_next_submodule(struct child_process =
*cp, struct strbuf *err,
>  		spf->oid_fetch_tasks_nr--;
> =20
>  		strbuf_addf(&submodule_prefix, "%s%s/",
> -			    spf->prefix, task->sub->path);
> +			    spf->super_prefix, task->sub->path);
> =20
>  		child_process_init(cp);
>  		prepare_submodule_repo_env_in_gitdir(&cp->env);
> @@ -1717,7 +1716,7 @@ static int get_next_submodule(struct child_process =
*cp, struct strbuf *err,
>  		strvec_init(&cp->args);
>  		strvec_pushv(&cp->args, spf->args.v);
>  		strvec_push(&cp->args, "on-demand");
> -		strvec_push(&cp->args, "--submodule-prefix");
> +		strvec_push(&cp->args, "--super-prefix");
>  		strvec_push(&cp->args, submodule_prefix.buf);
> =20
>  		/* NEEDSWORK: have get_default_remote from submodule--helper */
> @@ -1813,7 +1812,7 @@ static int fetch_finish(int retvalue, struct strbuf=
 *err,
> =20
>  int fetch_submodules(struct repository *r,
>  		     const struct strvec *options,
> -		     const char *prefix, int command_line_option,
> +		     const char *super_prefix, int command_line_option,
>  		     int default_option,
>  		     int quiet, int max_parallel_jobs)
>  {
> @@ -1835,7 +1834,7 @@ int fetch_submodules(struct repository *r,
>  	spf.command_line_option =3D command_line_option;
>  	spf.default_option =3D default_option;
>  	spf.quiet =3D quiet;
> -	spf.prefix =3D prefix;
> +	spf.super_prefix =3D super_prefix ? super_prefix : "";
> =20
>  	if (!r->worktree)
>  		goto out;
> @@ -1847,7 +1846,7 @@ int fetch_submodules(struct repository *r,
>  	for (i =3D 0; i < options->nr; i++)
>  		strvec_push(&spf.args, options->v[i]);
>  	strvec_push(&spf.args, "--recurse-submodules-default");
> -	/* default value, "--submodule-prefix" and its value are added later */
> +	/* default value, "--super-prefix" and its value are added later */
> =20
>  	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
>  	string_list_sort(&spf.changed_submodule_names);
> --=20
> 2.38.0.1471.ge4d8947e7aa
