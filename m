Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1CC35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D58217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ub3ZU8Uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBEObe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:34565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgBEObc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580913071;
        bh=zCwy8enLvcDzQ80/auxDrAkOeYH2DzwqsqB4jZ3W7Mg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ub3ZU8UyFmrLUh/A53KtzRtjQzRs/Nb0oACvYmV+BJjFSPJXIJdNZVd2QQMAZejX5
         iA9EAsYZH4HvXwGS3LM+tMnBvQdfBWLbWEI4arH1IhGYHjXi4YmfcCeju+WWf7bLaZ
         imG419tTo5fcrdTWnDfjwDGmuf1SrQ0tFCYEwsFg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKyI-1j5vHz2huy-00SgsJ; Wed, 05
 Feb 2020 15:31:11 +0100
Date:   Wed, 5 Feb 2020 15:31:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] rebase -i: stop checking out the tip of the branch
 to rebase
In-Reply-To: <20200124150500.15260-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002051531000.3718@tvgsbejvaqbjf.bet>
References: <20200124144545.12984-1-alban.gruin@gmail.com> <20200124150500.15260-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2114773634-1580913071=:3718"
X-Provags-ID: V03:K1:dHogzTDi2oG9iaPT0BzvHKY5EO9+In9xtlSqEULBc7baeKSH2hS
 EmI6rTFUWvP7DTBXQFF+c/B273KphYyMGNn0Vu12HCmvzUqqVyB2kRAmGPaTg5KEj6zp2FN
 0jlOsReSSWq1NQSnt6Ty4mdVRLmucToEH6zsuEHDugdlqLSwLxb5PDYfp1EA6LIpaizAg1L
 pkP3VVEFKBJTNxFP+JWNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M0eMCgxEZCE=:sdJ/lZbKoUxqQs3o9AfzWA
 gZIOho5CLfTGSui10A9pORqAPDbWqAjfSPKnWhCNtFCHbTa+9cblwQYRzT6tmoOoAUpMHX5kN
 EPmBSdvixdyKaQkkrBw0mi3Z5uTX+cyOZFykbY93B6tYN23TEnsEI4mqhSk5UPstm6RdEx1fe
 eKZF/T5ZPEupLp2YtOP9DwEXVZWeda1UyGQscRnBDuihVokTwRysWRAO3+p/fLpak4chdUGdu
 7WX9oHqdLMNlM2ftnNaoZjS+UEBaIgySO81yUwrAyd49Jgv0Jlh2uRjREV5tWZC06IrePNH+1
 4uHo/e96Hjz2M2aOw81CfDyEYlVX8zL4kiHFOBiILeuSVsXUWoKYAKq2yFkq8YiMtzfMcQQc0
 WjM3ojVdOEOqx8jezB+cHtgyEXnA/DDTPBQdFA/ww1fWu/7M64nHcsETdnq5nTXIagsjlJRyt
 rPK8ueyLyzjfNMdFa1QMIgWkOOD66f1LCzURZZRwQ3ct/PoO/6UAN5mZnRycmzr/XQag9eUcy
 fP0hvYj58cQKcWlCeiPvBDmva46UtzasRRJ8JmIj8NqD2EM5556qlr1OlKt79nhsUnSQWIzIt
 2Z9fcagQgffHPYIxsQ2jvgwu4pfLTW6/EEdHGmGqEZMNlR/Cv486T/J92U0hAXD50TrqcEmLx
 4mwkDcngDxiLNXYIiXE5RckLuOp+z50YBiZdxnrnQlSmrnHl/aU0UHITvA+dyCPSGlkjwTVMl
 hIn6yrkA0/G4w7GqI/vyFyIoR6hRpk/HeX9KvGZec+Nfx6w+0rWn1ygt4KAal5BfQYH2rmNNk
 0OXoekfZctF5YOxqc4sz36DU6oUyo3WnszIKFNO0uQWmauf1fgY+ejyV2QN7VGKrz8GZfzmgx
 qe5pjzKhjfDzxPAZkMVy9aBaCmO7fNm7DEfdLSgswRdLNxvYNQ5xvSmZrWBVVRuxQ0YOZJKDJ
 nUfTDAKs7+6gdCA6w666kw9QOjHZiUE988J3au61wqtZ24s3M7+V8fl/n2ObdhQ4WDweo8Mk4
 SpKx2ntwG5GiwWXzd9FnLFq3E6e2bf5/3hhH4Pwar2pWvXs7DFlLYpWn+pPCl2Xwu1jHhH7mc
 jiAy7sWav2ulWYCpiZxLI6aF7IGpigVz/93xOBsAgAOJMFRUjPAFdV/g7TAzA3YmO4ZUgtgdT
 syCTxyaptMqqpkBqu0qgbKE00ISrKReMJybtJxcybqhZlWwuytD7Ie6TW83FZe57K49k03vnU
 r11xoo2fw5v8uShfm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2114773634-1580913071=:3718
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Fri, 24 Jan 2020, Alban Gruin wrote:

> One of the first things done when using a sequencer-based
> rebase (ie. `rebase -i', `rebase -r', or `rebase -m') is to make a todo
> list.  This requires knowledge of the commit range to rebase.  To get
> the oid of the last commit of the range, the tip of the branch to rebase
> is checked out with prepare_branch_to_be_rebased(), then the oid of the
> head is read.  After this, the tip of the branch is not even modified.
> The `am' backend, on the other hand, does not check out the branch.
>
> On big repositories, it's a performance penalty: with `rebase -i', the
> user may have to wait before editing the todo list while git is
> extracting the branch silently, and "quiet" rebases will be slower than
> `am'.
>
> Since we already have the oid of the tip of the branch in
> `opts->orig_head', it's useless to switch to this commit.
>
> This removes the call to prepare_branch_to_be_rebased() in
> do_interactive_rebase(), and adds a `orig_head' parameter to
> get_revision_ranges().  prepare_branch_to_be_rebased() is removed as it
> is no longer used.

At this point, I am a bit puzzled as a reader: why can we just drop this?
My immediate reaction was: isn't this required to switch to a new branch
when `switch_to` is non-`NULL`?

So I went digging a little. The `prepare_branch_to_be_rebased()` call was
introduced in 53bbcfbde7c (rebase -i: implement the main part of
interactive rebase as a builtin, 2018-09-27).

And looking at the `git-rebase--interactive` part of that patch, it
becomes relatively obvious that we inherited this behavior from the shell
scripting days.

2c58483a598 (rebase -i: rewrite setup_reflog_action() in C, 2018-08-10)
converted the `setup_reflog_action` function (which oddly enough not only
set up the reflog action, but also switched to a new branch if so
configured). That function was introduced in d48f97aa854 (rebase: reindent
function git_rebase__interactive, 2018-03-23), but that was _still_ not
the commit that introduced that "let's check out the upstream" behavior.

It goes _all_ the way back to 1b1dce4bae7 (Teach rebase an interactive
mode, 2007-06-25). Except that back then, it was only done when a branch
name was provided (`git rebase -i <upstream> <branch-to-switch-to>`). So
it behaved correctly.

The problem was introduced in 71786f54c41 (rebase: factor out reference
parsing, 2011-02-06), as it substituted the `if test ! -z "$1"` with `if
test ! -z "$switch_to"`, relying on the command-line parsing of
`git-rebase.sh`.

But wait! Wait, wait, wait! `switch_to` is still only set in that
incantation where we provide a branch name _in addition to_ an upstream
commit.

Ah, I think I slowly see where this is going. The problem is actually
2ec33cdd19b (rebase--interactive: don't require what's rebased to be a
branch, 2010-03-14) which failed to realize that essentially the entire
`git checkout` was necessary to accommodate the subsequent call a mere 8
lines further down from that `checkout`:

		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
                        echo "detached HEAD" > "$DOTEST"/head-name

So that 2ec33cdd19b commit could have saved itself a lot of trouble by
realizing what the role of that `git checkout` is, and should have pulled
that `head-name` logic into that conditional instead of _actually_
switching to a new branch.

Now, let's see what the C code does to determine "head-name". Indeed, it
is already handled in the option parsing, in that monster of a function
called `cmd_rebase()`.

And yes, I think that `head_name` should also be mentioned in this commit
message, as something like

	git rebase -i <base> <branch-to-switch-to>

should eventually indeed switch to the specified branch, and this here
patch does _not_ break that promise.

This is my only concern with this patch, though, therefore:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho

> This introduces a visible change: as we do not switch on the tip of the
> branch to rebase, no reflog entry is created at the beginning of the
> rebase for it.
>
> Unscientific performance measurements, performed on linux.git, are as
> follow:
>
>   Before this patch:
>
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
>
>     real    0m8,940s
>     user    0m6,830s
>     sys     0m2,121s
>
>   After this patch:
>
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
>
>     real    0m1,834s
>     user    0m0,916s
>     sys     0m0,206s
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>
> Added a line in the first paragraph to make it clear that the `am'
> backend is not affected.
>
>  builtin/rebase.c | 18 +++++-------------
>  sequencer.c      | 14 --------------
>  sequencer.h      |  3 ---
>  3 files changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8081741f8a..6154ad8fa5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -246,21 +246,17 @@ static int edit_todo_file(unsigned flags)
>  }
>
>  static int get_revision_ranges(struct commit *upstream, struct commit *=
onto,
> -			       const char **head_hash,
> +			       struct object_id *orig_head, const char **head_hash,
>  			       char **revisions, char **shortrevisions)
>  {
>  	struct commit *base_rev =3D upstream ? upstream : onto;
>  	const char *shorthead;
> -	struct object_id orig_head;
> -
> -	if (get_oid("HEAD", &orig_head))
> -		return error(_("no HEAD?"));
>
> -	*head_hash =3D find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
> +	*head_hash =3D find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
>  	*revisions =3D xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
>  						   *head_hash);
>
> -	shorthead =3D find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
> +	shorthead =3D find_unique_abbrev(orig_head, DEFAULT_ABBREV);
>
>  	if (upstream) {
>  		const char *shortrev;
> @@ -314,12 +310,8 @@ static int do_interactive_rebase(struct rebase_opti=
ons *opts, unsigned flags)
>  	struct replay_opts replay =3D get_replay_opts(opts);
>  	struct string_list commands =3D STRING_LIST_INIT_DUP;
>
> -	if (prepare_branch_to_be_rebased(the_repository, &replay,
> -					 opts->switch_to))
> -		return -1;
> -
> -	if (get_revision_ranges(opts->upstream, opts->onto, &head_hash,
> -				&revisions, &shortrevisions))
> +	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
> +				&head_hash, &revisions, &shortrevisions))
>  		return -1;
>
>  	if (init_basic_state(&replay,
> diff --git a/sequencer.c b/sequencer.c
> index b9dbf1adb0..4dc245d7ec 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3715,20 +3715,6 @@ static int run_git_checkout(struct repository *r,=
 struct replay_opts *opts,
>  	return ret;
>  }
>
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_op=
ts *opts,
> -				 const char *commit)
> -{
> -	const char *action;
> -
> -	if (commit && *commit) {
> -		action =3D reflog_message(opts, "start", "checkout %s", commit);
> -		if (run_git_checkout(r, opts, commit, action))
> -			return error(_("could not checkout %s"), commit);
> -	}
> -
> -	return 0;
> -}
> -
>  static int checkout_onto(struct repository *r, struct replay_opts *opts=
,
>  			 const char *onto_name, const struct object_id *onto,
>  			 const char *orig_head)
> diff --git a/sequencer.h b/sequencer.h
> index 9f9ae291e3..74f1e2673e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -190,9 +190,6 @@ void commit_post_rewrite(struct repository *r,
>  			 const struct commit *current_head,
>  			 const struct object_id *new_head);
>
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_op=
ts *opts,
> -				 const char *commit);
> -
>  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  void print_commit_summary(struct repository *repo,
> --
> 2.24.1
>
>

--8323328-2114773634-1580913071=:3718--
