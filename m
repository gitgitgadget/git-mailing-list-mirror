Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBEEC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2766109F
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhIIKt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:49:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:48779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234261AbhIIKtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631184483;
        bh=iKOkGVnjhmDATCNDr341e07uTquYr2SC7Bq1RNkvUPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BxQUjYFktTasRdegeUtIO+pBo5ZF5Xbzelx61ZzIAkj0TQb7ZNIxI5V1mP48bFuny
         Gzt1vxqwRM4pfxAYLDVAGgWRKdgYc11ZBqdBF+7FNksjipa9vdcGByLg1GGQDNEWRc
         sP7G/FEAxF1HmepIzLMZ4lwgLFCskiPv4KtyyWtI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1mJcu22y4v-004kKh; Thu, 09
 Sep 2021 12:48:03 +0200
Date:   Thu, 9 Sep 2021 12:48:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/5] rebase: fix todo-list rereading
In-Reply-To: <3b17a4e3d3fa620638299294a56adb9237fd5c56.1631108472.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091247370.59@tvgsbejvaqbjf.bet>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <3b17a4e3d3fa620638299294a56adb9237fd5c56.1631108472.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2089881960-1631184484=:59"
X-Provags-ID: V03:K1:jAq9SSojwQ1X19UjVD2LB2LSTGBjrXoeF5k5MHz/lm/rn9+1EdA
 ll94NCwWJPRvW7ZtiPAxVEkFqCos7pEg4SyRvMcKJF9HQyTu364xz0rZwtCWdglOdymmuGF
 mxv6vexNg+Y7DXCrSYmZziFEtyBu3KDLkEXwigGTzTkztg2ldCVerRT2Qb9YNhb6LXG16bB
 /c6x8vz6Ber6mGbo3irkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XAxyo16+y/M=:GPnNnVAF/rWsTTlJWYB+/+
 cjcG5z0AS1c+wnpcNXB2dnxhy/LU1lHRLSriQVLDw9D/8LC95+wLXSX7PUwx9XVjHJ1X0hwxs
 2JbIO6kpzF+bwajX49bIUkZ/cGib+eXOXQicXePUWZi49HcB5cKci03P0yQ2n18gNyJDVgKm5
 pMs2YzEgxYjjpRgzys5I8/17rF29gyTPOLm8u2QdTCuVek6aJ8BCbv8fiuPkgg2abOuz81F1y
 PlJ0O6Y7XQULDsj2xIVHEcEEBiPL5fkNaryqg+HkHHSYBhuangJE5erFTsh3TATQG0kGpyVHA
 5pcitKwLu8JfrFonyeRPayNAG4caGOGijabW4VLfpJKltPd2Ym5EuhzTjikSqiuGfmwf8B/fs
 AnCVmgv7LcIrRnGlFYyKqpT+/WMCDvX2snW/GjZPT/Q3nlnHWCc26+KKXGfQ1BJy2gzPm+AZJ
 TDjtN9/WcjvF20QMWwPfz9hMx7dzzHuca/1X1nXaQ7u5jDli8oy/A28j2YlAF2F1L0E0u4RM9
 3BnEJOTRG/u4F3/6Z84kPIzmCJcj1LcEbU6ouIgBmu3Hxq+ZsJE4SJuKblIaY6GTVR5JoT+hU
 mX2Q1F4AudvRU5DaF4q/DftUG3vX4p+0mfKlupudKApUyuSkcAFQ/8hGJeDKFOTB2oH5M6Q25
 G73yQPGsB09oV7t8hy8VDhl+/HtFh2QRTPx/y4U1v223oMPvOpWdaHccTd00oPL0vg1YkI31h
 3pPk1HkRwt2//h0KrhgnHqtH5mTZ+ZCKCzOBchyN65q3jN/8jZlBHlZ2xA+Qexm090sEOm6P7
 vl171hgeNGFXpGJ+jzKDfsjPSN1xpAcbxH6Y2/Tzs0HXfTGWbODCkXlq+G7+8Dqn1elwjgx9P
 nsHnsB+YHw9ggBAs6fQfiTVdL9GnOICz421jP8fQ0FiBpI4oX4np5k2V2k9CNmbbnGKTSzpHJ
 LvzALHgn4yiZPWCOeuPillB7HEFok7jSt68r9E+di5OUI+9C4hTK+7yRBnQtc6/E25vhgoSDp
 fJvad8szyMRZ69+RUnnjSGvMgyNZc406byO1UZWkBkEcD0zVFdRhDgFN3sXSUB8nH4hEWo+tK
 JIykHM1FZLir/8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2089881960-1631184484=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 8 Sep 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> 54fd3243da ("rebase -i: reread the todo list if `exec` touched it",
> 2017-04-26) sought to reread the todo list after running an exec
> command only if it had been changed. To accomplish this it checks the
> stat data of the todo list after running an exec command to see if it
> has changed. Unfortunately there are two problems, firstly the
> implementation is buggy we actually reread the list after each exec
> which is quadratic in the number of commit lookups and secondly the
> design is predicated on using nanosecond time stamps which are not the
> default.
>
> The implementation bug stems from the fact that we write a new todo
> list to disk before running each command but do not update the stat
> data to reflect this[1].
>
> The design problem is that it is possible for the user to edit the
> todo list without changing its size or inode which means we have to
> rely on the mtime to tell us if it has changed. Unfortunately unless
> git is built with USE_NSEC it is possible for the original and edited
> list to share the same mtime.
>
> Ideally "git rebase --edit-todo" would set a flag that we would then
> check in sequencer.c. Unfortunately this is approach will not work as
> there are scripts in the wild that write to the todo list directly
> without running "git rebase --edit-todo". Instead of relying on stat
> data this patch simply reads the possibly edited todo list and
> compares it to the original with memcmp(). This is much faster than
> reparsing the todo list each time. This patch reduces the time to run
>
>    git rebase -r -xtrue v2.32.0~100 v2.32.0
>
> which runs 419 exec commands by 6.6%. For comparison fixing the
> implementation bug in stat based approach reduces the time by a
> further 1.4% and is indistinguishable from never rereading the todo
> list.

Thank you for fixing my bug _and_ for improving performance,
Dscho

>
> [1] https://lore.kernel.org/git/20191125131833.GD23183@szeder.dev/
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 19 ++++++++-----------
>  sequencer.h |  1 -
>  2 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index a248c886c27..d51440ddcd9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2671,7 +2671,6 @@ static int read_populate_todo(struct repository *r=
,
>  			      struct todo_list *todo_list,
>  			      struct replay_opts *opts)
>  {
> -	struct stat st;
>  	const char *todo_file =3D get_todo_path(opts);
>  	int res;
>
> @@ -2679,11 +2678,6 @@ static int read_populate_todo(struct repository *=
r,
>  	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
>  		return -1;
>
> -	res =3D stat(todo_file, &st);
> -	if (res)
> -		return error(_("could not stat '%s'"), todo_file);
> -	fill_stat_data(&todo_list->stat, &st);
> -
>  	res =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
>  	if (res) {
>  		if (is_rebase_i(opts))
> @@ -4258,12 +4252,14 @@ static int reread_todo_if_changed(struct reposit=
ory *r,
>  				  struct todo_list *todo_list,
>  				  struct replay_opts *opts)
>  {
> -	struct stat st;
> +	int offset;
> +	struct strbuf buf =3D STRBUF_INIT;
>
> -	if (stat(get_todo_path(opts), &st)) {
> -		return error_errno(_("could not stat '%s'"),
> -				   get_todo_path(opts));
> -	} else if (match_stat_data(&todo_list->stat, &st)) {
> +	if (strbuf_read_file_or_whine(&buf, get_todo_path(opts)) < 0)
> +		return -1;
> +	offset =3D get_item_line_offset(todo_list, todo_list->current + 1);
> +	if (buf.len !=3D todo_list->buf.len - offset ||
> +	    memcmp(buf.buf, todo_list->buf.buf + offset, buf.len)) {
>  		/* Reread the todo file if it has changed. */
>  		todo_list_release(todo_list);
>  		if (read_populate_todo(r, todo_list, opts))
> @@ -4271,6 +4267,7 @@ static int reread_todo_if_changed(struct repositor=
y *r,
>  		/* `current` will be incremented on return */
>  		todo_list->current =3D -1;
>  	}
> +	strbuf_release(&buf);
>
>  	return 0;
>  }
> diff --git a/sequencer.h b/sequencer.h
> index d57d8ea23d7..cdeb0c6be47 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -116,7 +116,6 @@ struct todo_list {
>  	struct todo_item *items;
>  	int nr, alloc, current;
>  	int done_nr, total_nr;
> -	struct stat_data stat;
>  };
>
>  #define TODO_LIST_INIT { STRBUF_INIT }
> --
> gitgitgadget
>
>

--8323328-2089881960-1631184484=:59--
