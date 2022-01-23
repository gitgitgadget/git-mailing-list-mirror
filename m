Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65824C433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 08:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiAWIFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 03:05:14 -0500
Received: from mout.web.de ([212.227.15.3]:55469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbiAWIFN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 03:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642925102;
        bh=UGiulYeu0wig7PB/fOJYo788UcFMSvuher4TFKE5aa0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=M6MAHxOdSObJzvR5bolyF6TlZRo/+RFrLAi3ORfKIdYibXPWhSODGKuNRtGXq/xdY
         mhia8PIOvf+3oYDbaEDwk85NMZjR13BRg4ge317vNmPoYNSNE8YDpNLeyBbt1VyrNl
         jyr4dk43Q1fyMjBGh2neIZwNYYhs+VfbzC9ByTRY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1mvOjJ1iBD-00Pri6; Sun, 23
 Jan 2022 09:05:02 +0100
Message-ID: <90488a50-c015-c9c8-e58b-81ccb66feaf6@web.de>
Date:   Sun, 23 Jan 2022 09:05:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 03/12] merge-tree: add option parsing and initial shell
 for real merge function
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:shEmMh7zIVQriHhg1MflXf+DLjQ8DZn1IfH9frWoCDWaH2zztga
 w0zS49Fv+sNuXJ26CYvYDavBGliukcLePYa1r/4oK6wEemNq7NQXXpwTXsVB1gRm9cKK2G6
 7YJ3rKAnoYWzg7EKPfF8JBDR8ftmFAtSpew44JcNCbod3e3jDDhaSZIobkq3pLwAHPdMcEM
 JaYllR31sAeKLdEFsRuYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zEHXy9mzepU=:x/DbaDT9ABRezp+3Cvozr3
 U+sHG0ORornyZ3ZJr7Nvn040CoY8VsTn+tImDrZ330kRWU5GU60vJP6CJS96zy7lXIP2ho9el
 dz9ljqlAEPikgXbd/EE3q0airBJ49lT5YxnlfA6uFLMt6x3yOgmH2EzOQm4hVyITER9VpPqsp
 dhZ65m7g4VcZDmnuRZs0ZbamiwXIQewuotiCRdWw+96e0KTTILsGcyy1f9Ty987S6vsOkI9jP
 gsg/DsylUolYBPZs3ubrDDGqKoFv1lWaNip8zjcrQrayydMCGWG1Evq1rdB2dbIjOkC5edwqZ
 lpVQsAl/J+stCdjfplEJ23nXc1RvBnHjZILLlDrzDyYtqTmLQEhh8bp8OzebZyHFpFPdJ76TJ
 qJPwjHUGbPu+7zj6iMXhCpFUK6Td47S1zsjqHU6ZNJBrMVPjsnBmXht3cmKs4t3MbUEo2d7Pa
 1tXsm5HWDngy5QDkLCasY3adoz8NSqWPl9SJ+V9RyBiK5DPJfkWRo9n2bGyakiz6e3vio4UUX
 7kRHQpsT6yn3asz9eHInxlNJu5gnD/lw/EEVqR2cNY7VMIZoBr5R+uPfNPGxLW6hXZiGDzoE/
 SJZNd1c2QFsbDEK3kkFI7dP9yApB5OM3joJ11YUrdzymOo5XGJ6Mdhhlw09JQR04eQA0GR0nd
 URKom7Ikeo01gAglXjwgacJj/yjWExJJi1p5UtyUnstFWsc3Hu0n8fzK07n3rn4ubLmRf157R
 qW7B4VPhnS7yF6d28KN0/rII8Du4sQ+Ok5aloWCDqK7xDqLUY/SeRkSuaFvZ/zEYyNRfJ21fz
 /o1tShKDhlmKVQ46daAIFKb0tW9mhkmlhK3gDHjDWpylvNF7q2YQ4HF56LZjh0amaR4xTfA6L
 NtDhpcuDv9aKQC44ZTJA9peZwEtPrfx/ozeqFjTh3qQDFjWI0wUM/U5jEjg3ujASSzmHU4XrZ
 21jw7HokzcT1kfkGFhqQY+D6iTCNFnfQDIHGKcUAlqH0uRFlWFIc8iKM/2h18zkccwOX5LsD5
 xxwtStoLUel/IIjfRsYJqKvW2md9r8GOPayo+sBnXqxpF9ZgwZ8440zsJqXx2QE2OpfVjNHrS
 mdB+PRsHYU3zB4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.01.22 um 22:55 schrieb Elijah Newren via GitGitGadget:
> From: Elijah Newren <newren@gmail.com>
>
> Let merge-tree accept a `--write-tree` parameter for choosing real
> merges instead of trivial merges, and accept an optional
> `--trivial-merge` option to get the traditional behavior.  Note that
> these accept different numbers of arguments, though, so these names
> need not actually be used.
>
> Note that real merges differ from trivial merges in that they handle:
>   - three way content merges
>   - recursive ancestor consolidation
>   - renames
>   - proper directory/file conflict handling
>   - etc.
> Basically all the stuff you'd expect from `git merge`, just without
> updating the index and working tree.  The initial shell added here does
> nothing more than die with "real merges are not yet implemented", but
> that will be fixed in subsequent commits.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge-tree.c | 67 ++++++++++++++++++++++++++++++++++++++------
>  git.c                |  2 +-
>  2 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 914ec960b7e..33e47cc1534 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -3,13 +3,12 @@
>  #include "tree-walk.h"
>  #include "xdiff-interface.h"
>  #include "object-store.h"
> +#include "parse-options.h"
>  #include "repository.h"
>  #include "blob.h"
>  #include "exec-cmd.h"
>  #include "merge-blobs.h"
>
> -static const char merge_tree_usage[] =3D "git merge-tree <base-tree> <b=
ranch1> <branch2>";
> -
>  struct merge_list {
>  	struct merge_list *next;
>  	struct merge_list *link;	/* other stages for this object */
> @@ -366,15 +365,17 @@ static void *get_tree_descriptor(struct repository=
 *r,
>  	return buf;
>  }
>
> -static int trivial_merge(int argc, const char **argv)
> +static int trivial_merge(const char *base,
> +			 const char *branch1,
> +			 const char *branch2)
>  {
>  	struct repository *r =3D the_repository;
>  	struct tree_desc t[3];
>  	void *buf1, *buf2, *buf3;
>
> -	buf1 =3D get_tree_descriptor(r, t+0, argv[1]);
> -	buf2 =3D get_tree_descriptor(r, t+1, argv[2]);
> -	buf3 =3D get_tree_descriptor(r, t+2, argv[3]);
> +	buf1 =3D get_tree_descriptor(r, t+0, base);
> +	buf2 =3D get_tree_descriptor(r, t+1, branch1);
> +	buf3 =3D get_tree_descriptor(r, t+2, branch2);
>  	trivial_merge_trees(t, "");
>  	free(buf1);
>  	free(buf2);
> @@ -384,9 +385,57 @@ static int trivial_merge(int argc, const char **arg=
v)
>  	return 0;
>  }
>
> +struct merge_tree_options {
> +	int real;
> +	int trivial;
> +};
> +
> +static int real_merge(struct merge_tree_options *o,
> +		      const char *branch1, const char *branch2)
> +{
> +	die(_("real merges are not yet implemented"));
> +}
> +
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc !=3D 4)
> -		usage(merge_tree_usage);
> -	return trivial_merge(argc, argv);
> +	struct merge_tree_options o =3D { 0 };
> +	int expected_remaining_argc;
> +
> +	const char * const merge_tree_usage[] =3D {
> +		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> +		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"=
),
> +		NULL
> +	};
> +	struct option mt_options[] =3D {
> +		OPT_BOOL(0, "write-tree", &o.real,
> +			 N_("do a real merge instead of a trivial merge")),
> +		OPT_BOOL(0, "trivial-merge", &o.trivial,
> +			 N_("do a trivial merge only")),
> +		OPT_END()
> +	};
> +
> +	/* Check for a request for basic help */
> +	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(merge_tree_usage, mt_options);

This is unnecessary; parse_options() handles -h already.

> +
> +	/* Parse arguments */
> +	argc =3D parse_options(argc, argv, prefix, mt_options,
> +			     merge_tree_usage, 0);
> +	if (o.real && o.trivial)
> +		die(_("--write-tree and --trivial-merge are incompatible"));

12909b6b8a (i18n: turn "options are incompatible" into "cannot be used
together", 2022-01-05) standardized messages of that kind; let's stick
to that to simplify translation:

		die(_("options '%s' and '%s' cannot be used together"),
		    "--write-tree", "--trivial-merge");

> +	if (o.real || o.trivial) {
> +		expected_remaining_argc =3D (o.real ? 2 : 3);
> +		if (argc !=3D expected_remaining_argc)
> +			usage_with_options(merge_tree_usage, mt_options);
> +	} else {
> +		if (argc < 2 || argc > 3)
> +			usage_with_options(merge_tree_usage, mt_options);
> +		o.real =3D (argc =3D=3D 2);
> +	}
> +
> +	/* Do the relevant type of merge */
> +	if (o.real)
> +		return real_merge(&o, argv[0], argv[1]);
> +	else
> +		return trivial_merge(argv[0], argv[1], argv[2]);
>  }
> diff --git a/git.c b/git.c
> index 5ff21be21f3..6090a1289db 100644
> --- a/git.c
> +++ b/git.c
> @@ -558,7 +558,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_T=
REE | NO_PARSEOPT },
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK=
_TREE | NO_PARSEOPT },
>  	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | N=
O_PARSEOPT },
> -	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
>  	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
>  	{ "mktree", cmd_mktree, RUN_SETUP },
>  	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
