Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C03C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C0320771
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aYisk8md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHMOHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:07:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:37141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMOHv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597327663;
        bh=mKsmS+hM0IVcHz0NRVq7s1F4SY9yt40ede1c1JA0gNw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aYisk8mdT9WQEG796F3YB2KaBy2MVwvkW5eLTqvPT0Mv4f1+POy8FM/tt1FpTclHu
         K5p2cM1KuyW73BUv88vLqy9Ck4hH+GUfVK4n3QJDRCIJlbC6A8IcCnx3rWfiTBv5jm
         byXrDvJeSeRLVMCsWyhwGH2JNvgXSZq6eFacMbtA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.213.40]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpnm-1kV9dt17qE-00pHvq; Thu, 13
 Aug 2020 16:07:43 +0200
Date:   Thu, 13 Aug 2020 16:07:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] rebase -i: support --ignore-date
In-Reply-To: <20200716173221.103295-5-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008131554180.54@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200716173221.103295-1-phillip.wood123@gmail.com> <20200716173221.103295-5-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mv50uimeT8QEzEAy/KwcL+UREw/cUId5jpuXk0pbZ6bXIgeOXKQ
 UbUH664BUqXVwq++I6wM7yEVKCFINCHgYdwfx/VnLo1Lqm4e86yDlJaxZ2QZ1q/7i1s/Tys
 mUA7QnIf6LP79PgB3JBjENNBgfeot0QVmQKPfEzHeVf5B6SyXFa04eECQXC0CzrvRDmqMxT
 XRgh+cZCgo5PXQGwweNUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Vk1cyB0qCc=:4hMWwzobt9E3v/yYQsS/Ev
 F81iFY0H0fJ27Hs6N7I967Xvw9hUoSdxtWNpwxpCXHMGJkTCCyB7aDrNPe2Adgease+U0DJXB
 RhBhRegfYaRpVKjTzP0kN5HrvNApEJB/kJ8HD+3Cqt0g+5zkrydrQH5wTvSaR47ntqzxeMpft
 plWlE00Co5Hhah1Zp4mJVV00C4gZASe6bhFmmFNxG082oN9rrmARcFAcX8SYWSop+N246DYEJ
 NgN0y4LnM8VS+ghv3x8Ksjj8lsxBs+m+PcUJkqdqHm6CbhClq85sD5kAOZeGljh35AnYGvSXA
 LJQVtGde0PtwZunFvC8qPcOfovJ++o8mClIWFLiFXU5UpBgVLfFru+d1JGSL5NG7BrRGxhtol
 EY95XB2dZSU1TAZZUcH4z6e8EkTiz+cWSgYmYt7+abxDFcv0yg/pRrOv65jO36GN/XKchYbGU
 lrvi8FSPHt+Auhwg1L6u8UMYHmczLTDRuHmehoOg+52+B9PGV46Ou/auUtCrrqDWGChdVI/dW
 YMR8qb2jvs4CkNW3cNHRVINiFPOmyyuJ8mUGZH7Qnb2Y7qpNMZFZkD2bYcW1dTDjx4ab/bqIE
 8w44MfPyaVlN+x4rLNHE/jjvrCsKQt+HOIwvmDpirgs36OQrmLPUEVdDCd0QSwDKOOWjwg9o3
 n9hVUgNr3H+ENSKkvzHQF9386IWeZ+xXooyJrN+xifXvzS4D1G1mWeQd47fuUBezdeWnehEjb
 P0jzrBMRTZkx4SoXtjN63Cy9PCtQBnsszWLHs14hAzdP5IWOr2zIrEJdl5pE7W48/UN98hPYC
 pC8ozvce7Z/nk5HIz1J3wx2FRIfCgPCUNoDfStQ+RqHbOJGmpzmDKza3fgB6WhRkWsHrTUEoL
 YfDgeCAqloWrIJQwbNtgTrHMhc0y2RgOxVaHPPLeHz3pxaCicr6CxOZd9tp6PDHtTpb44MAMk
 M0YKBiuP6uI2YSHzcI73uNtPz06cj940nSHS2qnMN1C+yjJY6ufdeDryOvKL4rkA9W3FUxFwl
 TUrJV3aNv/v+i5OLXgVg6oKRdtMnx+JSu+7Fz6tj6ggQpZkpbpZjA/WzuLEM2bP+HJvDvgWGO
 +hX27z8KapWLEZS+cOBgc1CHm1xZybtXTLN458CKbxPz2r5EGupUwSyVHn52A0FAHkJ7QCOmM
 J+ouu8QVyAXJ8nQzL9bpS/1cPJy1w69uhd0DMbiHmUW6/76htvGJF++OdlRED2pejTN5VH9FB
 Gc2vQUEPymrnpsx2cfb3E9+0cPrSA3kpDT3tgAw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 16 Jul 2020, Phillip Wood wrote:

> @@ -957,7 +976,11 @@ static int run_git_commit(struct repository *r,
>
>  	if (opts->committer_date_is_author_date)
>  		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=3D%s",
> +				 opts->ignore_date ?
> +				 "" :
>  				 author_date_from_env_array(&cmd.env_array));
> +	if (opts->ignore_date)
> +		argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=3D");

Technically, if we switched those two `if` blocks, we would not have to
edit the committer date one. But this way is much clearer.

>
>  	argv_array_push(&cmd.args, "commit");
>
> @@ -1388,7 +1411,8 @@ static int try_to_commit(struct repository *r,
>  			    ident.date_begin,
>  			    (int)(ident.tz_end - ident.tz_begin),
>  			    ident.tz_begin);
> -		res =3D setenv("GIT_COMMITTER_DATE", date.buf, 1);
> +		res =3D setenv("GIT_COMMITTER_DATE",
> +			     opts->ignore_date ? "" : date.buf, 1);

Isn't this constructing the `date` string for nothing, if
`opts->ignore_date` is set?

I would much rather see it done this way:

-	if (opts->committer_date_is_author_date) {
+	if (opts->committer_date_is_author_date && opts->ignore_date)
+		setenv("GIT_COMMITTER_DATE", "", 1);
+	else if (opts->committer_date_is_author_date) {

Not enough of a reason to re-roll, though.

>  		strbuf_release(&date);
>
>  		if (res)
> @@ -1454,6 +1478,16 @@ static int try_to_commit(struct repository *r,
>
>  	reset_ident_date();
>
> +	if (opts->ignore_date) {
> +		author =3D ignore_author_date(author);
> +		if (!author) {
> +			res =3D -1;
> +			goto out;
> +		}
> +		free(author_to_free);

A better cadence might be to first `free(author_to_free)`, then assign
`author =3D author_to_free =3D ignore_author_date(author);` (at least in m=
y
perspective, it reads more naturally).

But again, not a big reason for a re-roll.

The rest of the patch looks good to me.

Thank you,
Dscho

> +		author_to_free =3D (char *)author;

> +	}
> +
>  	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
>  				 oid, author, opts->gpg_sign, extra)) {
>  		res =3D error(_("failed to write commit object"));
> @@ -2583,6 +2617,11 @@ static int read_populate_opts(struct replay_opts =
*opts)
>  			opts->committer_date_is_author_date =3D 1;
>  		}
>
> +		if (file_exists(rebase_path_ignore_date())) {
> +			opts->allow_ff =3D 0;
> +			opts->ignore_date =3D 1;
> +		}
> +
>  		if (file_exists(rebase_path_reschedule_failed_exec()))
>  			opts->reschedule_failed_exec =3D 1;
>
> @@ -2675,6 +2714,8 @@ int write_basic_state(struct replay_opts *opts, co=
nst char *head_name,
>  		write_file(rebase_path_keep_redundant_commits(), "%s", "");
>  	if (opts->committer_date_is_author_date)
>  		write_file(rebase_path_cdate_is_adate(), "%s", "");
> +	if (opts->ignore_date)
> +		write_file(rebase_path_ignore_date(), "%s", "");
>  	if (opts->reschedule_failed_exec)
>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>
> @@ -3597,7 +3638,11 @@ static int do_merge(struct repository *r,
>
>  		if (opts->committer_date_is_author_date)
>  			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=3D%s",
> +					 opts->ignore_date ?
> +					 "" :
>  					 author_date_from_env_array(&cmd.env_array));
> +		if (opts->ignore_date)
> +			argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=3D");
>
>  		cmd.git_cmd =3D 1;
>  		argv_array_push(&cmd.args, "merge");
> @@ -3877,7 +3922,8 @@ static int pick_commits(struct repository *r,
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
>  				opts->record_origin || opts->edit ||
> -				opts->committer_date_is_author_date));
> +				opts->committer_date_is_author_date ||
> +				opts->ignore_date));
>  	if (read_and_refresh_cache(r, opts))
>  		return -1;
>
> diff --git a/sequencer.h b/sequencer.h
> index 4ab94119ae..3587878e3b 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -46,6 +46,7 @@ struct replay_opts {
>  	int quiet;
>  	int reschedule_failed_exec;
>  	int committer_date_is_author_date;
> +	int ignore_date;
>
>  	int mainline;
>
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-option=
s.sh
> index 50a63d8ebe..0ede2b8900 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -108,6 +108,62 @@ test_expect_success '--committer-date-is-author-dat=
e works when committing confl
>  	test_ctime_is_atime -1
>  '
>
> +# Checking for +0000 in the author date is sufficient since the
> +# default timezone is UTC but the timezone used while committing is
> +# +0530. The inverted logic in the grep is necessary to check all the
> +# author dates in the file.
> +test_ctime_is_ignored () {
> +	git log $1 --format=3D%ai >authortime &&
> +	! grep -v +0000 authortime
> +}
> +
> +test_expect_success '--ignore-date works with apply backend' '
> +	git commit --amend --date=3D"$GIT_AUTHOR_DATE" &&
> +	git rebase --apply --ignore-date HEAD^ &&
> +	test_ctime_is_ignored -1
> +'
> +
> +test_expect_success '--ignore-date works with merge backend' '
> +	git commit --amend --date=3D"$GIT_AUTHOR_DATE" &&
> +	git rebase --ignore-date -m HEAD^ &&
> +	test_ctime_is_ignored -1
> +'
> +
> +test_expect_success '--ignore-date works after conflict resolution' '
> +	test_must_fail git rebase --ignore-date -m \
> +		--onto commit2^^ commit2^ commit2 &&
> +	echo resolved >foo &&
> +	git add foo &&
> +	git rebase --continue &&
> +	test_ctime_is_ignored -1
> +'
> +
> +test_expect_success '--ignore-date works with rebase -r' '
> +	git checkout side &&
> +	git merge --no-ff commit3 &&
> +	git rebase -r --root --ignore-date &&
> +	test_ctime_is_ignored
> +'
> +
> +test_expect_success '--ignore-date with --committer-date-is-author-date=
 works' '
> +	test_must_fail git rebase -m --committer-date-is-author-date \
> +		--ignore-date --onto commit2^^ commit2^ commit3 &&
> +	git checkout --theirs foo &&
> +	git add foo &&
> +	git rebase --continue &&
> +	test_ctime_is_atime -2 &&
> +	test_ctime_is_ignored -2
> +'
> +
> +test_expect_success '--ignore-date --committer-date-is-author-date work=
s when forking merge' '
> +	GIT_SEQUENCE_EDITOR=3D"echo \"merge -C $(git rev-parse HEAD) commit3\"=
>" \
> +		PATH=3D"./test-bin:$PATH" git rebase -i --strategy=3Dtest \
> +				--ignore-date --committer-date-is-author-date \
> +				side side &&
> +	test_ctime_is_atime -1 &&
> +	test_ctime_is_ignored -1
> + '
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
> --
> 2.27.0
>
>
