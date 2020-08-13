Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C00C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 13:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386CD20774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SrD0Qhu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMNrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:47:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:43771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMNq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 09:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597326408;
        bh=7P8kOlxee+jqecZu2Q9F2Zr8j/FWxi603dJpk/y3BrY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SrD0Qhu1PKqoZhvr9JrPgpqNnn6Y1J1HevIMiTIkh8q8LbCkcOG3sNk22yEZshX31
         +RqxLLbyJh9gD8IMWKiFl+eVmqZmuGEmcRby9LpA1z4Ap7jlZskmCSXqwj1Qi63MwI
         ednWLaWw70q9DZLa7aGntRK5iRKHzFDmTpwdLD1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.213.40]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1jsWC93XFe-00Er72; Thu, 13
 Aug 2020 15:46:47 +0200
Date:   Thu, 13 Aug 2020 15:46:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] rebase -i: support
 --committer-date-is-author-date
In-Reply-To: <20200716173221.103295-3-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008131535370.54@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200716173221.103295-1-phillip.wood123@gmail.com> <20200716173221.103295-3-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nUDJrw8AGz45qNShu39elFXqDjfzhEoQO0yEN1nFvrx+mRLY5vH
 TOk+QCgCFimBGlBJZncUiCcv5WOZA1cnScvsaiTeOgoSj49C1q9WqvXNs1UaWKE9kDAdwn1
 sL7jCtDNG3AjXgYR8WiqOV8GCIkSFjeYlvDsAPfEJsknlZm0moA12/Edcf3RkslwrKz2ouz
 HB3D5X7pEobKUv+k/HMrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hZTmoi9Luw4=:GmDz8OU6G/gLh188uwVkZl
 gggmzcTvrOKX+CIxLDfyruE0GHYQfafF0Uf9Fn6TOlXZS4DepsjCFe6XUbpJv1jEZH0GjnMAR
 nwozeOsZzAV4g1tKfMPzv4aFJ6ddsV9RJFReNvErYxcIr5Tm8dE3Nf9ARWxIkTPs2d3ilkAxZ
 sEB7MhpxnnFN8F6cPYFYLHMqKgEOObiyA+zH2PssogzHtoIlKGd+r/2RN6DU1y0wwQPYQu2yM
 HUGvMegB3U2fKMkIevOkYvvIxkBLgxvoqrxM2JEpetdsRIs79Y/J1sytBmhbEGhJhv5lCO4Es
 SJqjZC/UiB24p+dTVUiwr7gdXuPVvbrti5CNFi6RqJX0JhSIkGvkGFwmG8IFF72V5PGuovFtG
 FcTNL2mZiqMExjwcpc4l5xUQtjMlkupTHB1Fop+B4UFkh+zfSsfwEaRQONka/5L/iAD+o872O
 pkbZS7HqjjZucq74tXvahtzN7jG/3cpZi4uoq6tmWQ+gZinPWcBXO8i5YO613FvqMnfSy9aov
 nPdPb5M7xGEW/B7B9hPyKh8qhJPG/BNFw7YQZzQOEEmrYIuRuALIl2otrLQPeIMSN1RJ6BL3f
 Gimhao8FfHuczJ/AEscF2b12aR1ApIqKM5HMKjvW4UBnvWFELY2dIyvx72iXRYWprhy7YzLRm
 NxC/Ksc9n0zbrVujgxpeIkw4Aem/SwyFU+kwdk4Ff//Lb1nQIUaAYDh3EJyMLdIPDi1vqvdSG
 j9ONT2u6452KA8tvAesa24+r/73N51P/BTl/OLmEhjjh9234YrGv4DiA6qO4stW9ctX+96Q5S
 m71+TG8l1WHOac1R2k/sPQSC+Ugrng55sHZxE3C0rj4AW1FEkNhzCVrx+1glFLxPfMIiORXGd
 cpzLl8RQe0Hw7vZI+wRGRdYji7SEYilMRha69LEhPigg1aH5W2Oky3BfM04TrmXsBv2Bv32J3
 BuQbNEIhXKMOl0i7GC9sQFZTI41ccJIzTfyT705Of1gejhVwVUEGAxWC7Fuw1X8ZhD3U+QcKZ
 HIbxXK95QokJZUrXEKYvbtXBP5XK20WpCQFQCi9zuqpHL2rBq6uE3r7wSz8+wDWiF2uqov5CJ
 KE7HqXdwEBeLXUsr3gX88X7K/GOd+O8SiZFYtTxX+XuSw9GACt52usiMO2nuDOoXLSDHg8Zcv
 ereWGUE/jMllJ93b3MtAwXz8+iowzHDsZB35/CifQlsWxjlYEdDBXdffmuv7Q0Un+Sil1M5uQ
 Oss7rVZkgpSfAmApCpunc9BopxdXEXtSIpCxogw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 16 Jul 2020, Phillip Wood wrote:

> @@ -1349,6 +1370,31 @@ static int try_to_commit(struct repository *r,
>  		commit_list_insert(current_head, &parents);
>  	}
>
> +	if (opts->committer_date_is_author_date) {
> +		struct ident_split ident;
> +		struct strbuf date =3D STRBUF_INIT;
> +
> +		if (split_ident_line(&ident, author, (int)strlen(author)) < 0) {
> +			res =3D error(_("malformed ident line '%s'"), author);
> +			goto out;
> +		}
> +		if (!ident.date_begin) {
> +			res =3D error(_("corrupted author without date information"));
> +			goto out;
> +		}
> +
> +		strbuf_addf(&date, "@%.*s %.*s",
> +			    (int)(ident.date_end - ident.date_begin),
> +			    ident.date_begin,
> +			    (int)(ident.tz_end - ident.tz_begin),
> +			    ident.tz_begin);
> +		res =3D setenv("GIT_COMMITTER_DATE", date.buf, 1);

I am slightly worried that we do not unset this environment variable (or
revert to its previous value, if it had any).

I had a brief look and it seems that there are only two callers of
`commit_tree_extended()` (which uses `git_committer_info(IDENT_STRICT)` to
fill in the committer date), so it _should_ be possible to extend the
signature of `commit_tree_extended()` to specify the committer information
explicitly.

The bigger question is whether we _actually_ need this, and I _think_ that
the answer is "not right now", so I would be fine with the patch as-is.
Just thought that I point it out (and thereby demonstrate that I actually
looked at the patch ;-)).

Ciao,
Dscho

> +		strbuf_release(&date);
> +
> +		if (res)
> +			goto out;
> +	}
> +
>  	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>  		res =3D error(_("git write-tree failed to write a tree"));
>  		goto out;
> @@ -2532,6 +2578,11 @@ static int read_populate_opts(struct replay_opts =
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
> @@ -2622,6 +2673,8 @@ int write_basic_state(struct replay_opts *opts, co=
nst char *head_name,
>  		write_file(rebase_path_drop_redundant_commits(), "%s", "");
>  	if (opts->keep_redundant_commits)
>  		write_file(rebase_path_keep_redundant_commits(), "%s", "");
> +	if (opts->committer_date_is_author_date)
> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>  	if (opts->reschedule_failed_exec)
>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>
> @@ -3542,6 +3595,10 @@ static int do_merge(struct repository *r,
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
> @@ -3819,7 +3876,8 @@ static int pick_commits(struct repository *r,
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
> index 4f8a6e51c9..50a63d8ebe 100755
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
> @@ -21,11 +24,20 @@ test_expect_success 'setup' '
>  	test_write_lines "line 1" "new line 2" "line 3" >file &&
>  	git commit -am "update file" &&
>  	git tag side &&
> +	test_commit commit1 foo foo1 &&
> +	test_commit commit2 foo foo2 &&
> +	test_commit commit3 foo foo3 &&
>
>  	git checkout --orphan master &&
> +	rm foo &&
>  	test_write_lines "line 1" "        line 2" "line 3" >file &&
>  	git commit -am "add file" &&
> -	git tag main
> +	git tag main &&
> +
> +	mkdir test-bin &&
> +	write_script test-bin/git-merge-test <<-\EOF
> +	exec git-merge-recursive "$@"
> +	EOF
>  '
>
>  test_expect_success '--ignore-whitespace works with apply backend' '
> @@ -52,6 +64,50 @@ test_expect_success '--ignore-whitespace is remembere=
d when continuing' '
>  	git diff --exit-code side
>  '
>
> +test_ctime_is_atime () {
> +	git log $1 --format=3D%ai >authortime &&
> +	git log $1 --format=3D%ci >committertime &&
> +	test_cmp authortime committertime
> +}
> +
> +test_expect_success '--committer-date-is-author-date works with apply b=
ackend' '
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git commit --amend --reset-author &&
> +	git rebase --apply --committer-date-is-author-date HEAD^ &&
> +	test_ctime_is_atime -1
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with merge b=
ackend' '
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git commit --amend --reset-author &&
> +	git rebase -m --committer-date-is-author-date HEAD^ &&
> +	test_ctime_is_atime -1
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with rebase =
-r' '
> +	git checkout side &&
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git merge --no-ff commit3 &&
> +	git rebase -r --root --committer-date-is-author-date &&
> +	test_ctime_is_atime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when forking=
 merge' '
> +	git checkout side &&
> +	GIT_AUTHOR_DATE=3D"@1234 +0300" git merge --no-ff commit3 &&
> +	PATH=3D"./test-bin:$PATH" git rebase -r --root --strategy=3Dtest \
> +					--committer-date-is-author-date &&
> +	test_ctime_is_atime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when committ=
ing conflict resolution' '
> +	git checkout commit2 &&
> +	GIT_AUTHOR_DATE=3D"@1980 +0000" git commit --amend --only --reset-auth=
or &&
> +	test_must_fail git rebase -m --committer-date-is-author-date \
> +		--onto HEAD^^ HEAD^ &&
> +	echo resolved > foo &&
> +	git add foo &&
> +	git rebase --continue &&
> +	test_ctime_is_atime -1
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
> --
> 2.27.0
>
>
