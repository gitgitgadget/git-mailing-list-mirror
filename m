Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D413C19F2C
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 22:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHCW7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCW7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 18:59:22 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CAB1659E
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 15:59:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l11-20020a170902f68b00b0016ee1c2c0deso6344531plg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=aAkidFG1r0u5W15JxiBoV4q7hkaWcTThfIrDYEY4H3g=;
        b=AmaF8UgGl0JJKGBBcRXM2JWHV5qKQf/TlcSPT6mr3x/qhAhh1jWW60pnCFQ8JwhSV/
         7G/EibZSTEfCIS3xodk9jowJ3PghnWWimQ7JFvLL1AUWHTfgLsh1A+RRhiEH8E6iol48
         WjvnTl4d2ZTo8P1LIHvA/4kQdVbugbqeuGG8ZZ/KDslTpapScAjpw2in2/6iNDGz3a+d
         X3Q3CQOXqyoWuXx7ETVWs1vQ8UOVKnU96tycw6eWDG1N3diQI4GcsYTyLSGSTZ7WQ91X
         d/VMIkdZbCqijm47yjnM+RY384tVYJs4K844T2a+u15NnuhaPrgdyHQczS1tnaNLqno9
         x83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=aAkidFG1r0u5W15JxiBoV4q7hkaWcTThfIrDYEY4H3g=;
        b=Wd6eD/Fb1n4upM5Fm+OMmGm8NRsNfnRLfQGnSWaCrH0kF9g/r2YVidM4YOCVEvwYHv
         bQY9Qcm3PAOdOpfPWljQsCRtoh0CGynEuOB6DKCOciPQoOFip1lpthW+JZX86IiFGvRr
         arnJ+OFyp5lR8IC/sWu51Qr56CsS6Bgogl7ZtbgKmaEjANT6eqpj9u5s9wE8WkmNFHTu
         TlDpkllReDrFXxsDIuWWDTglK7Y6o4DRhps6A2xY+WxacYhYe5gqw9hiU5jpm4FTdWnY
         IUe2M8P8vTKjOq1/bp1iWCS8HZWbozZ8yZGrnQME+XrQkWo1lmc8Q4J8Mn+1RvPMTxCs
         t8rA==
X-Gm-Message-State: ACgBeo1m77bK+yj+vHa05xEJhwOdHi3GKx4prU2OkABS+TVO9TlNs8Lg
        K43Xd4GR48paGh+T/82h07qn6hRmSTarNg==
X-Google-Smtp-Source: AA6agR6XsVA1k1a3EE48WGeyYpOTXhffC3BiWu6XSPUIULn9/5J3NwUgh1bG5CXI1G5KVS1fckaAmQnGpCSDuQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:41cd:b0:16e:e0c0:96d1 with SMTP
 id u13-20020a17090341cd00b0016ee0c096d1mr18959441ple.169.1659567560911; Wed,
 03 Aug 2022 15:59:20 -0700 (PDT)
Date:   Wed, 03 Aug 2022 15:59:19 -0700
In-Reply-To: <patch-v5-03.17-1f90348d61f-20220802T155002Z-avarab@gmail.com>
Message-Id: <kl6lbkt1szlk.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
 <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <patch-v5-03.17-1f90348d61f-20220802T155002Z-avarab@gmail.com>
Subject: Re: [PATCH v5 03/17] submodule--helper: fix most "struct pathspec"
 memory leaks
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

> Call clear_pathspec() at the end of various functions that work with
> and allocate a "struct pathspec".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 74 +++++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 23 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d958da7dddc..92d32f2877f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -367,7 +367,7 @@ static void runcommand_in_submodule_cb(const struct c=
ache_entry *list_item,
>  static int module_foreach(int argc, const char **argv, const char *prefi=
x)
>  {
>  	struct foreach_cb info =3D FOREACH_CB_INIT;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };

Out of curiousity, does this zero-initialization do anything for us
leaks-wise?

>  	struct module_list list =3D MODULE_LIST_INIT;
>  	struct option module_foreach_options[] =3D {
>  		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule=
 command")),
> @@ -379,12 +379,13 @@ static int module_foreach(int argc, const char **ar=
gv, const char *prefix)
>  		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
>  		NULL
>  	};
> +	int ret =3D 1;
> =20
>  	argc =3D parse_options(argc, argv, prefix, module_foreach_options,
>  			     git_submodule_helper_usage, 0);
> =20
>  	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
> -		return 1;
> +		goto cleanup;
> =20
>  	info.argc =3D argc;
>  	info.argv =3D argv;
> @@ -392,7 +393,10 @@ static int module_foreach(int argc, const char **arg=
v, const char *prefix)
> =20
>  	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	clear_pathspec(&pathspec);
> +	return ret;
>  }
> =20
>  static int starts_with_dot_slash(const char *const path)
> @@ -522,7 +526,7 @@ static void init_submodule_cb(const struct cache_entr=
y *list_item, void *cb_data
>  static int module_init(int argc, const char **argv, const char *prefix)
>  {
>  	struct init_cb info =3D INIT_CB_INIT;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
>  	int quiet =3D 0;
>  	struct option module_init_options[] =3D {
> @@ -533,12 +537,13 @@ static int module_init(int argc, const char **argv,=
 const char *prefix)
>  		N_("git submodule init [<options>] [<path>]"),
>  		NULL
>  	};
> +	int ret =3D 1;
> =20
>  	argc =3D parse_options(argc, argv, prefix, module_init_options,
>  			     git_submodule_helper_usage, 0);
> =20
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> +		goto cleanup;
> =20
>  	/*
>  	 * If there are no path args and submodule.active is set then,
> @@ -553,7 +558,10 @@ static int module_init(int argc, const char **argv, =
const char *prefix)
> =20
>  	for_each_listed_submodule(&list, init_submodule_cb, &info);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	clear_pathspec(&pathspec);
> +	return ret;
>  }
> =20
>  struct status_cb {
> @@ -700,7 +708,7 @@ static void status_submodule_cb(const struct cache_en=
try *list_item,
>  static int module_status(int argc, const char **argv, const char *prefix=
)
>  {
>  	struct status_cb info =3D STATUS_CB_INIT;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
>  	int quiet =3D 0;
>  	struct option module_status_options[] =3D {
> @@ -713,12 +721,13 @@ static int module_status(int argc, const char **arg=
v, const char *prefix)
>  		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...=
]"),
>  		NULL
>  	};
> +	int ret =3D 1;
> =20
>  	argc =3D parse_options(argc, argv, prefix, module_status_options,
>  			     git_submodule_helper_usage, 0);
> =20
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> +		goto cleanup;
> =20
>  	info.prefix =3D prefix;
>  	if (quiet)
> @@ -726,7 +735,10 @@ static int module_status(int argc, const char **argv=
, const char *prefix)
> =20
>  	for_each_listed_submodule(&list, status_submodule_cb, &info);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	clear_pathspec(&pathspec);
> +	return ret;
>  }
> =20
>  struct module_cb {
> @@ -1265,7 +1277,7 @@ static void sync_submodule_cb(const struct cache_en=
try *list_item, void *cb_data
>  static int module_sync(int argc, const char **argv, const char *prefix)
>  {
>  	struct sync_cb info =3D SYNC_CB_INIT;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
>  	int quiet =3D 0;
>  	int recursive =3D 0;
> @@ -1279,12 +1291,13 @@ static int module_sync(int argc, const char **arg=
v, const char *prefix)
>  		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
>  		NULL
>  	};
> +	int ret =3D 1;
> =20
>  	argc =3D parse_options(argc, argv, prefix, module_sync_options,
>  			     git_submodule_helper_usage, 0);
> =20
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> +		goto cleanup;
> =20
>  	info.prefix =3D prefix;
>  	if (quiet)
> @@ -1294,7 +1307,10 @@ static int module_sync(int argc, const char **argv=
, const char *prefix)
> =20
>  	for_each_listed_submodule(&list, sync_submodule_cb, &info);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	clear_pathspec(&pathspec);
> +	return ret;
>  }
> =20
>  struct deinit_cb {
> @@ -1403,7 +1419,7 @@ static void deinit_submodule_cb(const struct cache_=
entry *list_item,
>  static int module_deinit(int argc, const char **argv, const char *prefix=
)
>  {
>  	struct deinit_cb info =3D DEINIT_CB_INIT;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
>  	int quiet =3D 0;
>  	int force =3D 0;
> @@ -1418,6 +1434,7 @@ static int module_deinit(int argc, const char **arg=
v, const char *prefix)
>  		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path=
>...]]"),
>  		NULL
>  	};
> +	int ret =3D 1;
> =20
>  	argc =3D parse_options(argc, argv, prefix, module_deinit_options,
>  			     git_submodule_helper_usage, 0);
> @@ -1432,7 +1449,7 @@ static int module_deinit(int argc, const char **arg=
v, const char *prefix)
>  		die(_("Use '--all' if you really want to deinitialize all submodules")=
);
> =20
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> +		goto cleanup;
> =20
>  	info.prefix =3D prefix;
>  	if (quiet)
> @@ -1442,7 +1459,10 @@ static int module_deinit(int argc, const char **ar=
gv, const char *prefix)
> =20
>  	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	clear_pathspec(&pathspec);
> +	return ret;
>  }
> =20
>  struct module_clone_data {
> @@ -2531,7 +2551,7 @@ static int update_submodules(struct update_data *up=
date_data)
> =20
>  static int module_update(int argc, const char **argv, const char *prefix=
)
>  {
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct update_data opt =3D UPDATE_DATA_INIT;
>  	struct list_objects_filter_options filter_options =3D { 0 };
>  	int ret;
> @@ -2608,8 +2628,8 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  		opt.update_strategy.type =3D opt.update_default;
> =20
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) =
{
> -		list_objects_filter_release(&filter_options);
> -		return 1;
> +		ret =3D 1;
> +		goto cleanup;
>  	}
> =20
>  	if (pathspec.nr)
> @@ -2620,8 +2640,10 @@ static int module_update(int argc, const char **ar=
gv, const char *prefix)
>  		struct init_cb info =3D INIT_CB_INIT;
> =20
>  		if (module_list_compute(argc, argv, opt.prefix,
> -					&pathspec, &list) < 0)
> -			return 1;
> +					&pathspec, &list) < 0) {
> +			ret =3D 1;
> +			goto cleanup;
> +		}
> =20
>  		/*
>  		 * If there are no path args and submodule.active is set then,
> @@ -2638,7 +2660,9 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  	}
> =20
>  	ret =3D update_submodules(&opt);
> +cleanup:
>  	list_objects_filter_release(&filter_options);
> +	clear_pathspec(&pathspec);
>  	return ret;
>  }
> =20
> @@ -2722,7 +2746,7 @@ static int push_check(int argc, const char **argv, =
const char *prefix)
>  static int absorb_git_dirs(int argc, const char **argv, const char *pref=
ix)
>  {
>  	int i;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
>  	unsigned flags =3D ABSORB_GITDIR_RECURSE_SUBMODULES;
>  	struct option embed_gitdir_options[] =3D {
> @@ -2737,17 +2761,21 @@ static int absorb_git_dirs(int argc, const char *=
*argv, const char *prefix)
>  		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
>  		NULL
>  	};
> +	int ret =3D 1;
> =20
>  	argc =3D parse_options(argc, argv, prefix, embed_gitdir_options,
>  			     git_submodule_helper_usage, 0);
> =20
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> +		goto cleanup;
> =20
>  	for (i =3D 0; i < list.nr; i++)
>  		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	clear_pathspec(&pathspec);
> +	return ret;
>  }
> =20
>  static int module_config(int argc, const char **argv, const char *prefix=
)
> --=20
> 2.37.1.1233.ge8b09efaedc
