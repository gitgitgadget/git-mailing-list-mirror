Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D117C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAF2207D4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CWWfTFKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgE2T0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:26:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:42861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgE2T0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590780354;
        bh=6/d9mxqWl3Gf34WtwGlCrVMHMHi/aF8yvffoiGiygK8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CWWfTFKbGROK7bwO8/kLnruSOt7ZgGpBp6ekddFUfNgtCPyDjUSB1HEwcRzztNs0u
         43Hw8LQX0gcGSmKgO2hlojNvL1PVLIhCFokWpSJ+Web0C0EUSkbgmyE3vTXCX1XpDT
         bN+Xn0Js7DS/lS2S1MUL3hv7NWjcEE0/+qafuIjM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.207]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1jI2of0hSx-00mMe8; Fri, 29
 May 2020 21:25:54 +0200
Date:   Fri, 29 May 2020 04:52:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] rebase -i: support
 --committer-date-is-author-date
In-Reply-To: <20200527173356.47364-3-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005290439030.56@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200527173356.47364-1-phillip.wood123@gmail.com> <20200527173356.47364-3-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rD6UPCJTY6YmtAbMygb+VmJKCUmD2+4Oh+TycCaDVIJ1z7XWaCp
 MgPosI+5qTE2NsTDKsEO2Sd8Pkndp2k/gsV14RKDu140IxEgPehQi8HnAjyqrrSenXINHrY
 OOg/4DVMEq+l8k0MmWt3nkK8ZOsjHBwNKqodnX+jNazh0Yst3pKtOuJYQOlYonsu6jPIKyk
 APXDvGYxFBRDwSBhW26cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DqTLfhiHNww=:b9YZZDfR86oDX1AtszvQBo
 8Iwqb/GJwOWbizsxBeNmOOWdjMttEi4p1Hpgd1Qn2yhpQMhCl9msV4H03sQXWNGCB11UBpeLT
 n7UMDHmTDxmguyItSN7WKwV5XHZfxPl89X3ggZ21oAaQG8+jYrQtRj3SOIai0M3bz0qW5+iz5
 XYKCxE4dwHto8+Q4nPT3ONnBGIx0V6jAf8PTsXOX5jrBYzCHGR3d8l2AJeIJR1vEqPwiVJ392
 Khb6aPq8Qdm4ABFLIrt/tAqjsH8xDF2GA/HRnOZP3nkX9Jjf12f5ZhJ2oLv8Fossvkfb17xcf
 iS3i1ZeYB3Lo5jN6MZGkV+1CUZXZrHFeI9e6u0w65y/iScAVP31xXNsAfFfVEkID4xfw207zy
 VgRyzAv97ZMNVMmZo+Yv/OnPTaDaKXnGdlpzIFZTK7TkmpvUVrzJRIU565h5tTAK6uP4sqvBF
 GTkY2BBjpU+xwvqje1W+V9kHF/FsT9eFAoQ6W2/Pjys0hOb+Wfzevz7fHPgMcxFI0e3ZYeTqQ
 2FmIlQGvo4AzQB1nh9GA7jOD26RvdzdmppcZkWCiBn+mpk7tgBDj/iCR1KtXwM72jLbrZdOJA
 h8Yx4LVr/A6Kczszg901uhbDsPyl6dONyqB5N1YJXQa1rqjzTk5jQF6k8hggCM/Al0Cf6bjHo
 hkrpROKIwmbj3us6+0db93N2cW+F6UC5nIv1ty4zX+fn+pihUVBvd8WozVgDq0e9C4BvW+e1a
 NXhNZGd6OhIr5aSkYnw875XlFMGfc5WLMKBmL2BRB18xaOAH230+/FkgP604K6Hx3uvuqC6NL
 M066VtwceM5tfXr8x8PyySYLRYU+YVftUxzydoFXA/+AlsuAO7aHMEg2fT8jTVySGqjKZzVLZ
 0V6C3G1t+cjCERQhS5u6C1TAhl85Skt5dJMJ1mHyIynOVYGyRJgouKMTnV9vfAWdhMdnWrt/D
 6GZaf3u5tmXB51NYT4mcg8Cmo5MGX8tz5gPX9PLbp+1pD4vv+LJF+dbAsNygm4P9qcx2+bhF0
 FiV/52L7hl7M/QUzWSWgXWlqVJNCTsTZtkNUtPE0iCMNZtgGh05wtZvGgHMrsxwwb5va6QuAI
 G2EoKXmvdjGK9c7iOeEZC8T/9jXSE7Q9zu7slUlRqT2TeWhr3flIxdH4ir4Vvcbvw6ecWYqra
 TTQudlpLOy/uJtSIn6WQQoqnOMkTzC88kmisxrspC1ANm850BHFoJ2e5TQ88SD36h8vLZ7zA3
 Nt4MM/4qh/o5NEghw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 27 May 2020, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As part of the on-going effort to retire the apply rebase backend teach
> the merge backend how to handle --committer-date-is-author-date.

I forgot to mention this in my reply to the first patch in this series: it
strikes me as a mis-characterization that the `apply` backend is about to
be retired. What _is_ true is that the `merge` backend is the default
backend, and what is even more true is that it is cumbersome if certain
`rebase` options cannot be combined because they are only implemented by
one of both rebase backends.

>
> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt           | 10 +++--
>  builtin/rebase.c                       | 16 ++++---
>  sequencer.c                            | 59 +++++++++++++++++++++++++-
>  sequencer.h                            |  1 +
>  t/t3422-rebase-incompatible-options.sh |  1 -
>  t/t3436-rebase-more-options.sh         | 56 ++++++++++++++++++++++++
>  6 files changed, 133 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index b003784f01..dfa70263e6 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -445,9 +445,13 @@ if the other side had no changes that conflicted.
>  See also INCOMPATIBLE OPTIONS below.
>
>  --committer-date-is-author-date::
> +	Instead of using the current time as the committer date, use
> +	the author date of the commit being rebased as the committer
> +	date. This option implies --force-rebase.
> +
>  --ignore-date::
> -	These flags are passed to 'git am' to easily change the dates
> -	of the rebased commits (see linkgit:git-am[1]).
> +	This flag is passed to 'git am' to change the author date
> +	of each rebased commit (see linkgit:git-am[1]).
>  +
>  See also INCOMPATIBLE OPTIONS below.
>
> @@ -585,7 +589,6 @@ INCOMPATIBLE OPTIONS
>  The following options:
>
>   * --apply
> - * --committer-date-is-author-date
>   * --ignore-date
>   * --whitespace
>   * -C
> @@ -613,6 +616,7 @@ In addition, the following pairs of options are inco=
mpatible:
>   * --preserve-merges and --rebase-merges
>   * --preserve-merges and --empty=3D
>   * --preserve-merges and --ignore-whitespace
> + * --preserve-merges and --committer-date-is-author-date
>   * --keep-base and --onto
>   * --keep-base and --root
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5d8e117276..357cd6acf3 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -89,6 +89,7 @@ struct rebase_options {
>  	int ignore_whitespace;
>  	char *gpg_sign_opt;
>  	int autostash;
> +	int committer_date_is_author_date;
>  	char *cmd;
>  	int allow_empty_message;
>  	int rebase_merges, rebase_cousins;
> @@ -126,6 +127,8 @@ static struct replay_opts get_replay_opts(const stru=
ct rebase_options *opts)
>  	replay.quiet =3D !(opts->flags & REBASE_NO_QUIET);
>  	replay.verbose =3D opts->flags & REBASE_VERBOSE;
>  	replay.reschedule_failed_exec =3D opts->reschedule_failed_exec;
> +	replay.committer_date_is_author_date =3D
> +					opts->committer_date_is_author_date;
>  	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
>  	replay.strategy =3D opts->strategy;
>
> @@ -1003,6 +1006,8 @@ static int run_am(struct rebase_options *opts)
>
>  	if (opts->ignore_whitespace)
>  		argv_array_push(&am.args, "--ignore-whitespace");
> +	if (opts->committer_date_is_author_date)
> +		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date"=
);

As before, I would rather see this in `cmd__rebase()` rahn in `run_am()`.

>  	if (opts->action && !strcmp("continue", opts->action)) {
>  		argv_array_push(&am.args, "--resolved");
>  		argv_array_pushf(&am.args, "--resolvemsg=3D%s", resolvemsg);
> @@ -1507,9 +1512,9 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>  		OPT_BOOL(0, "signoff", &options.signoff,
>  			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
> -				  &options.git_am_opts, NULL,
> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> +		OPT_BOOL(0, "committer-date-is-author-date",
> +			 &options.committer_date_is_author_date,
> +			 N_("make committer date match author date")),
>  		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
> @@ -1804,11 +1809,12 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  	    options.autosquash) {
>  		allow_preemptive_ff =3D 0;
>  	}
> +	if (options.committer_date_is_author_date)
> +		options.flags |=3D REBASE_FORCE;
>
>  	for (i =3D 0; i < options.git_am_opts.argc; i++) {
>  		const char *option =3D options.git_am_opts.argv[i], *p;
> -		if (!strcmp(option, "--committer-date-is-author-date") ||
> -		    !strcmp(option, "--ignore-date") ||
> +		if (!strcmp(option, "--ignore-date") ||
>  		    !strcmp(option, "--whitespace=3Dfix") ||
>  		    !strcmp(option, "--whitespace=3Dstrip"))
>  			allow_preemptive_ff =3D 0;
> diff --git a/sequencer.c b/sequencer.c
> index 6fd2674632..8826c6325b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -149,6 +149,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "re=
base-merge/refs-to-delete")
>   * command-line.
>   */
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_o=
pt")
> +static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is=
_adate")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -872,6 +873,22 @@ static char *get_author(const char *message)
>  	return NULL;
>  }
>
> +static const char *author_date_from_env_array(const struct argv_array *=
env)
> +{
> +	int i;
> +	const char *date;
> +
> +	for (i =3D 0; i < env->argc; i++)
> +		if (skip_prefix(env->argv[i],
> +				"GIT_AUTHOR_DATE=3D", &date))
> +			return date;
> +	/*
> +	 * If GIT_AUTHOR_DATE is missing we should have already errored out wh=
en
> +	 * reading the script
> +	 */
> +	BUG("GIT_AUTHOR_DATE missing from author script");
> +}
> +
>  static const char staged_changes_advice[] =3D
>  N_("you have staged changes in your working tree\n"
>  "If these changes are meant to be squashed into the previous commit, ru=
n:\n"
> @@ -938,6 +955,10 @@ static int run_git_commit(struct repository *r,
>  			     gpg_opt, gpg_opt);
>  	}
>
> +	if (opts->committer_date_is_author_date)
> +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=3D%s",
> +				 author_date_from_env_array(&cmd.env_array));
> +
>  	argv_array_push(&cmd.args, "commit");
>
>  	if (!(flags & VERIFY_MSG))
> @@ -1349,6 +1370,30 @@ static int try_to_commit(struct repository *r,
>  		commit_list_insert(current_head, &parents);
>  	}
>
> +	if (opts->committer_date_is_author_date) {
> +		int len =3D strlen(author);

Given that `len` is used only once, is this local variable really
necessary? You could just as well pass `(int)strlen(author)` in the
`split_ident_line()` call below.

> +		struct ident_split ident;
> +		struct strbuf date =3D STRBUF_INIT;
> +
> +		if (split_ident_line(&ident, author, len) < 0) {
> +			res =3D error(_("malformed ident line '%s'"), author);
> +			goto out;
> +		}
> +		if (!ident.date_begin) {
> +			res =3D error(_("corrupted author without date information"));
> +			goto out;
> +		}
> +
> +		strbuf_addf(&date, "@%.*s %.*s",
> +			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
> +			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
> +		res =3D setenv("GIT_COMMITTER_DATE", date.buf, 1);
> +		strbuf_release(&date);

It might be easier to read if it was written this way:

		if (split_ident_line(...) < 0)
			res =3D ...
		else if (!ident.date_begin)
			res =3D ...
		else {
			strbuf_addf(...)
			res =3D ...
			strbuf_release(&date);
		}

		if (res)
			goto out;

> +
> +		if (res)
> +			goto out;
> +	}
> +
>  	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>  		res =3D error(_("git write-tree failed to write a tree"));
>  		goto out;
> @@ -2532,6 +2577,11 @@ static int read_populate_opts(struct replay_opts =
*opts)
>  			opts->signoff =3D 1;
>  		}
>
> +		if (file_exists(rebase_path_cdate_is_adate())) {
> +			opts->allow_ff =3D 0;
> +			opts->committer_date_is_author_date =3D 1;
> +		}
> +
>  		if (file_exists(rebase_path_reschedule_failed_exec()))
>  			opts->reschedule_failed_exec =3D 1;
>
> @@ -2622,6 +2672,8 @@ int write_basic_state(struct replay_opts *opts, co=
nst char *head_name,
>  		write_file(rebase_path_drop_redundant_commits(), "%s", "");
>  	if (opts->keep_redundant_commits)
>  		write_file(rebase_path_keep_redundant_commits(), "%s", "");
> +	if (opts->committer_date_is_author_date)
> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>  	if (opts->reschedule_failed_exec)
>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>
> @@ -3542,6 +3594,10 @@ static int do_merge(struct repository *r,
>  			goto leave_merge;
>  		}
>
> +		if (opts->committer_date_is_author_date)
> +			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=3D%s",
> +					 author_date_from_env_array(&cmd.env_array));
> +
>  		cmd.git_cmd =3D 1;
>  		argv_array_push(&cmd.args, "merge");
>  		argv_array_push(&cmd.args, "-s");
> @@ -3819,7 +3875,8 @@ static int pick_commits(struct repository *r,
>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
> -				opts->record_origin || opts->edit));
> +				opts->record_origin || opts->edit ||
> +				opts->committer_date_is_author_date));
>  	if (read_and_refresh_cache(r, opts))
>  		return -1;
>
> diff --git a/sequencer.h b/sequencer.h
> index 0bee85093e..4ab94119ae 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,6 +45,7 @@ struct replay_opts {
>  	int verbose;
>  	int quiet;
>  	int reschedule_failed_exec;
> +	int committer_date_is_author_date;
>
>  	int mainline;
>
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-inc=
ompatible-options.sh
> index 55ca46786d..c8234062c6 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>  }
>
>  test_rebase_am_only --whitespace=3Dfix
> -test_rebase_am_only --committer-date-is-author-date
>  test_rebase_am_only -C4
>
>  test_expect_success REBASE_P '--preserve-merges incompatible with --sig=
noff' '
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-option=
s.sh
> index fb5e747e86..7e68fb9753 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -9,6 +9,9 @@ test_description=3D'tests to ensure compatibility betwee=
n am and interactive backe
>
>  . "$TEST_DIRECTORY"/lib-rebase.sh
>
> +GIT_AUTHOR_DATE=3D"1999-04-02T08:03:20+05:30"
> +export GIT_AUTHOR_DATE
> +
>  # This is a special case in which both am and interactive backends
>  # provide the same output. It was done intentionally because
>  # both the backends fall short of optimal behaviour.
> @@ -28,8 +31,13 @@ test_expect_success 'setup' '
>  	EOF
>  	git commit -am "update file" &&
>  	git tag side &&
> +	test_commit commit1 foo foo1 &&
> +	test_commit commit2 foo foo2 &&
> +	test_commit commit3 foo foo3 &&
>
>  	git checkout --orphan master &&
> +	git rm --cached foo &&
> +	rm foo &&
>  	sed -e "s/^|//" >file <<-\EOF &&
>  	|line 1
>  	|        line 2
> @@ -78,6 +86,54 @@ test_expect_success '--ignore-whitespace is remembere=
d when continuing' '
>  	test_cmp expect file
>  '
>
> +test_expect_success '--committer-date-is-author-date works with apply b=
ackend' '
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git commit --amend --reset-author &&
> +	git rebase --apply --committer-date-is-author-date HEAD^ &&
> +	git log -1 --pretty=3D%ai >authortime &&
> +	git log -1 --pretty=3D%ci >committertime &&
> +	test_cmp authortime committertime

This seems to be a repeated pattern. To dry it up, it would make sense to
do this:

	test_ctime_is_atime () {
		git log -1 --pretty=3D%ai >authortime &&
		git log -1 --pretty=3D%ci >committertime &&
		test_cmp authortime committertime
	}

Ciao,
Dscho

> +'
> +
> +test_expect_success '--committer-date-is-author-date works with merge b=
ackend' '
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git commit --amend --reset-author &&
> +	git rebase -m --committer-date-is-author-date HEAD^ &&
> +	git log -1 --pretty=3D%ai >authortime &&
> +	git log -1 --pretty=3D%ci >committertime &&
> +	test_cmp authortime committertime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with rebase =
-r' '
> +	git checkout side &&
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git merge --no-ff commit3 &&
> +	git rebase -r --root --committer-date-is-author-date &&
> +	git log --pretty=3D%ai >authortime &&
> +	git log --pretty=3D%ci >committertime &&
> +	test_cmp authortime committertime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when forking=
 merge' '
> +	git checkout side &&
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git merge --no-ff commit3 &&
> +	git rebase -r --root --strategy=3Dresolve --committer-date-is-author-d=
ate &&
> +	git log --pretty=3D%ai >authortime &&
> +	git log --pretty=3D%ci >committertime &&
> +	test_cmp authortime committertime
> +
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when committ=
ing conflict resolution' '
> +	git checkout commit2 &&
> +	GIT_AUTHOR_DATE=3D"@1980 +0000" git commit --amend --only --reset-auth=
or &&
> +	git log -1 --format=3D%at HEAD >expect &&
> +	test_must_fail git rebase -m --committer-date-is-author-date \
> +		--onto HEAD^^ HEAD^ &&
> +	echo resolved > foo &&
> +	git add foo &&
> +	git rebase --continue &&
> +	git log -1 --format=3D%ct HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
> --
> 2.26.2
>
>
