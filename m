Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16875C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B4464E2A
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBJQCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:02:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:33199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhBJQCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612972830;
        bh=/phdu3xji/mopQpw09Dv9MW9omaXovbi5IidrIWH4aQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P8TfReVWfitWmwR4ukJIkgdRpMg2yCU9LysKVVjvDwUrpCp0H0ax37iVHXJ9FyUaB
         KpNjkSuLtZ7FGwGiXL5S1b+7Mwb3pm1CBXoUGsN3nQtsGMUeIE+FixTAUnfPDX3qKs
         seGncmqFAP6OoCUqcT//bi/a6gGDl6m91PHU4BjQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1l9ruo11Ga-0005SZ; Wed, 10
 Feb 2021 17:00:30 +0100
Date:   Wed, 10 Feb 2021 17:00:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] diff: add an API for deferred freeing
In-Reply-To: <20210205141320.18076-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102101557160.29765@tvgsbejvaqbjf.bet>
References: <20201020064809.14297-1-michal@isc.org> <20210205141320.18076-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-628271799-1612969074=:29765"
Content-ID: <nycvar.QRO.7.76.6.2102101558100.29765@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:XxBF1kZapjMcWigmQTDdBLNJGIaYpI3HwyNBb/w6ER5Wc5dkR6K
 UKmS5fkRwHbnFerV242jIzsEfVOfAa62TWW1xSfSa8DmZ3raphyJHoKloovSPUSuusFNHj0
 dCZ+8KH1nePdF5R+6/KGODLIXIQMmXpai/hCp9OKZEBcPSIx2ssPJvpc0L/mABfPZZR7FVx
 ueVf21ujUQANu7+R3cbHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3q5MTJ4QXs8=:B7hvkAQNytFcAqo5lD52HK
 CFZEHoZPNMOjJYrSCrX0KngjrevnyuWF2qZ8jtwnfV9DCwB9aqWEPB9VNZzC5XE/nHN84/wwT
 xWmB93CnFKGNRcV47+2R8cxlGhCcGYhY+ZFu9eEe8Dr7xe+mWmJDhHqmHQcX5m8lx7oFvIjLu
 vECme57k/a/QR6W8L/W+QHTz9iMTMKb3JPSDwcu+WDKa03rTRKb7Ik8Y4DJ2iB5wfcjUJIgEj
 31db3/8Ss8HRxiT6b7dlBcx8SxpIzIhU9R6S3geUCuF9jwUYDhoEPM1q+LqMoqRjppwgUrOOY
 Xg56GVvn+WM+7Z9oCG4K2Ajycq2d/0cdsPMtCuFNTMq4BCF7Pxv9RLFFILJvFOldMXJCpf+5m
 fTMU/bBlB58usUdCsvD8myuYvwTdTceWMc5+SBz7tVeq6jOdg0o+8r2Rk2MyCjduAE5h4Wqat
 UpU4pEjeU8y7fq3HIt9TCMdNJAX+b5shZ5K32B7URRjiSqJz5vftiThtmCE4ctBLiusMqeSDn
 B3gX6h8f1lpabAZTbmm0AqSwsouTmS8eOuq4qdFUDMe7yGBFBgkoZWHoq5HAsuOH0IMoGnI0u
 Qp/rzMdF8UQPbfm4jW60vO66xLvLn1S0doHMR8PclWDBjuGHv4ciXohPlFPF3luYwnR29eFuk
 OffK3aOwKM7C/1VoeyVqSx/jsmoCZ9SgQAldlpN2dc9eSSGRWsVfSuHeyX7qJ/38OqYSX86yd
 YTVv9ZQ7UtEYEbYjJ3lR+TTllA4QeaEr8HvB6j2lo+ZZ7Xw/Oq0RAq9fLQ/lkBIghd3UPbv8w
 2b7mtMk5mhPYen8hQ21x6giCgK2YGFgbsiUKm5N7r/8x2v4hh6sJ7caNeSuT8UNE8/c+3tCzh
 X8qOQTT9fRTpGKk+HNiETWdTS/s6cRQXpfj5Diurg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-628271799-1612969074=:29765
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2102101558101.29765@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Fri, 5 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add a diff_free() function to free anything we may have allocated in
> the "diff_options" struct, and the ability to make calling it a noop
> by setting "no_free" in "diff_options".

Why do we need a `no_free` flag? Why not simply set the `free()`d (or
`fclose()`d) attributes to `NULL`?

> This is required because when e.g. "git diff" is run we'll allocate
> things in that struct, use the diff machinery once, and then exit, but
> if we run e.g. "git log -p" we're going to re-use what we allocated
> across multiple diff_flush() calls, and only want to free things at
> the end.
>
> We've thus ended up with features like the recently added "diff -I"[1]
> where we'll leak memory. As it turns out it could have simply used the
> pattern established in 6ea57703f6 (log: prepare log/log-tree to reuse
> the diffopt.close_file attribute, 2016-06-22).
>
> Manually adding more such flags to things log_tree_commit() every time
> we need to allocate something would be tedious.
>
> Let's instead move that fclose() code it to a new diff_free(), in
> anticipation of freeing more things in that function in follow-up
> commits. I'm renaming the "close_file" struct member to "fclose_file"
> for the ease of validating this, we can be certain that these are all
> the relevant callsites.

I like that idea a lot.

> Some functions such as log_tree_commit() need an idiom of optionally
> retaining a previous "no_free", as they may either free the memory
> themselves, or their caller may do so. I'm keeping that idiom in
> log_show_early() even though I don't think it's currently called in
> this manner, since it also gets passed an existing "struct rev_info"..
>
> 1. 296d4a94e7 (diff: add -I<regex> that ignores matching changes,
>    2020-10-20)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/add.c |  2 +-
>  builtin/am.c  |  6 ++++--
>  builtin/log.c | 27 ++++++++++++++-------------
>  diff.c        | 18 +++++++++++++-----
>  diff.h        | 14 +++++++++++++-
>  log-tree.c    | 10 ++++++----
>  wt-status.c   |  2 +-
>  7 files changed, 52 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index a825887c50..6319710186 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -282,7 +282,7 @@ static int edit_patch(int argc, const char **argv, c=
onst char *prefix)
>  	if (out < 0)
>  		die(_("Could not open '%s' for writing."), file);
>  	rev.diffopt.file =3D xfdopen(out, "w");
> -	rev.diffopt.close_file =3D 1;
> +	rev.diffopt.fclose_file =3D 1;

This rename makes the patch unnecessarily tedious to review, and I do not
even agree with leaking the implementation detail that we need to
`fclose()` the file.

Let's just not?

>  	if (run_diff_files(&rev, 0))
>  		die(_("Could not write patch"));
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 8355e3566f..157d264583 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1315,7 +1315,7 @@ static void write_commit_patch(const struct am_sta=
te *state, struct commit *comm
>  	rev_info.diffopt.flags.full_index =3D 1;
>  	rev_info.diffopt.use_color =3D 0;
>  	rev_info.diffopt.file =3D fp;
> -	rev_info.diffopt.close_file =3D 1;
> +	rev_info.diffopt.fclose_file =3D 1; /* log_tree_commit() sets .no_free=
=3D1 */
>  	add_pending_object(&rev_info, &commit->object, "");
>  	diff_setup_done(&rev_info.diffopt);
>  	log_tree_commit(&rev_info, commit);
> @@ -1347,10 +1347,12 @@ static void write_index_patch(const struct am_st=
ate *state)
>  	rev_info.diffopt.output_format =3D DIFF_FORMAT_PATCH;
>  	rev_info.diffopt.use_color =3D 0;
>  	rev_info.diffopt.file =3D fp;
> -	rev_info.diffopt.close_file =3D 1;
> +	rev_info.diffopt.fclose_file =3D 1;
> +	rev_info.diffopt.no_free =3D 1;
>  	add_pending_object(&rev_info, &tree->object, "");
>  	diff_setup_done(&rev_info.diffopt);
>  	run_diff_index(&rev_info, 1);
> +	diff_free(&rev_info.diffopt);
>  }
>
>  /**
> diff --git a/builtin/log.c b/builtin/log.c
> index fd282def43..604ee29ec0 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -306,10 +306,11 @@ static struct itimerval early_output_timer;
>
>  static void log_show_early(struct rev_info *revs, struct commit_list *l=
ist)
>  {
> -	int i =3D revs->early_output, close_file =3D revs->diffopt.close_file;
> +	int i =3D revs->early_output;
>  	int show_header =3D 1;
> +	int no_free =3D revs->diffopt.no_free;
>
> -	revs->diffopt.close_file =3D 0;
> +	revs->diffopt.no_free =3D 0;
>  	sort_in_topological_order(&list, revs->sort_order);
>  	while (list && i) {
>  		struct commit *commit =3D list->item;
> @@ -326,8 +327,8 @@ static void log_show_early(struct rev_info *revs, st=
ruct commit_list *list)
>  		case commit_ignore:
>  			break;
>  		case commit_error:
> -			if (close_file)
> -				fclose(revs->diffopt.file);
> +			revs->diffopt.no_free =3D no_free;
> +			diff_free(&revs->diffopt);
>  			return;
>  		}
>  		list =3D list->next;
> @@ -335,8 +336,8 @@ static void log_show_early(struct rev_info *revs, st=
ruct commit_list *list)
>
>  	/* Did we already get enough commits for the early output? */
>  	if (!i) {
> -		if (close_file)
> -			fclose(revs->diffopt.file);
> +		revs->diffopt.no_free =3D 0;
> +		diff_free(&revs->diffopt);
>  		return;
>  	}
>
> @@ -400,7 +401,7 @@ static int cmd_log_walk(struct rev_info *rev)
>  {
>  	struct commit *commit;
>  	int saved_nrl =3D 0;
> -	int saved_dcctc =3D 0, close_file =3D rev->diffopt.close_file;
> +	int saved_dcctc =3D 0;
>
>  	if (rev->early_output)
>  		setup_early_output();
> @@ -416,7 +417,7 @@ static int cmd_log_walk(struct rev_info *rev)
>  	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
>  	 * retain that state information if replacing rev->diffopt in this loo=
p
>  	 */
> -	rev->diffopt.close_file =3D 0;
> +	rev->diffopt.no_free =3D 1;
>  	while ((commit =3D get_revision(rev)) !=3D NULL) {
>  		if (!log_tree_commit(rev, commit) && rev->max_count >=3D 0)
>  			/*
> @@ -441,8 +442,8 @@ static int cmd_log_walk(struct rev_info *rev)
>  	}
>  	rev->diffopt.degraded_cc_to_c =3D saved_dcctc;
>  	rev->diffopt.needed_rename_limit =3D saved_nrl;
> -	if (close_file)
> -		fclose(rev->diffopt.file);
> +	rev->diffopt.no_free =3D 0;
> +	diff_free(&rev->diffopt);
>
>  	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
>  	    rev->diffopt.flags.check_failed) {
> @@ -1952,18 +1953,18 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
>  	if (rev.show_notes)
>  		load_display_notes(&rev.notes_opt);
>
> -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
> +	if (use_stdout + rev.diffopt.fclose_file + !!output_directory > 1)
>  		die(_("--stdout, --output, and --output-directory are mutually exclus=
ive"));
>
>  	if (use_stdout) {
>  		setup_pager();
> -	} else if (rev.diffopt.close_file) {
> +	} else if (rev.diffopt.fclose_file) {
>  		/*
>  		 * The diff code parsed --output; it has already opened the
>  		 * file, but but we must instruct it not to close after each
>  		 * diff.
>  		 */
> -		rev.diffopt.close_file =3D 0;
> +		rev.diffopt.no_free =3D 1;
>  	} else {
>  		int saved;
>
> diff --git a/diff.c b/diff.c
> index 69e3bc00ed..3e6f8f0a71 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5187,7 +5187,7 @@ static enum parse_opt_result diff_opt_output(struc=
t parse_opt_ctx_t *ctx,
>  	BUG_ON_OPT_NEG(unset);
>  	path =3D prefix_filename(ctx->prefix, arg);
>  	options->file =3D xfopen(path, "w");
> -	options->close_file =3D 1;
> +	options->fclose_file =3D 1;
>  	if (options->use_color !=3D GIT_COLOR_ALWAYS)
>  		options->use_color =3D GIT_COLOR_NEVER;
>  	free(path);
> @@ -6399,10 +6399,10 @@ void diff_flush(struct diff_options *options)
>  		 * options->file to /dev/null should be safe, because we
>  		 * aren't supposed to produce any output anyway.
>  		 */
> -		if (options->close_file)
> +		if (options->fclose_file)
>  			fclose(options->file);

And at this stage, we should set `options->file =3D NULL`.

>  		options->file =3D xfopen("/dev/null", "w");
> -		options->close_file =3D 1;
> +		options->fclose_file =3D 1;
>  		options->color_moved =3D 0;
>  		for (i =3D 0; i < q->nr; i++) {
>  			struct diff_filepair *p =3D q->queue[i];
> @@ -6433,8 +6433,7 @@ void diff_flush(struct diff_options *options)
>  free_queue:
>  	free(q->queue);
>  	DIFF_QUEUE_CLEAR(q);
> -	if (options->close_file)
> -		fclose(options->file);
> +	diff_free(options);
>
>  	/*
>  	 * Report the content-level differences with HAS_CHANGES;
> @@ -6449,6 +6448,15 @@ void diff_flush(struct diff_options *options)
>  	}
>  }
>
> +void diff_free(struct diff_options *options)
> +{
> +	if (options->no_free)
> +		return;
> +	if (options->fclose_file)
> +		fclose(options->file);

And at this stage, we should set `options->file =3D NULL`.

> +}
> +
> +
>  static int match_filter(const struct diff_options *options, const struc=
t diff_filepair *p)
>  {
>  	return (((p->status =3D=3D DIFF_STATUS_MODIFIED) &&
> diff --git a/diff.h b/diff.h
> index 2ff2b1c7f2..d1d74c3a9e 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -49,7 +49,16 @@
>   * - Once you finish feeding the pairs of files, call `diffcore_std()`.
>   * This will tell the diffcore library to go ahead and do its work.
>   *
> + * - The `diff_opt_parse()` etc. functions might allocate memory in
> + *  `struct diff_options`. When running the API `N > 1` set `.no_free
> + *  =3D 1` to make the `diff_free()` invoked by `diff_flush()` below a
> + *  noop.

I have serious trouble parsing that last sentence. Would you mind
rephrasing it?

> + *
>   * - Calling `diff_flush()` will produce the output.
> + *
> + * - If you set `.no_free =3D 1` before set it to `0` and call
> + *   `diff_free()` again. If `.no_free =3D 1` was not set there's no
> + *   need to call `diff_free()`, `diff_flush()` will call it.

Again, as I mentioned before, the indicator whether things need to be
released should be whether the attribute is `NULL` or not. And once
released, ot should be set to `NULL`.

Other than that, it looks fine to me. And I definitely like the idea of
introducing a function to release all of the stuff in `struct diffopt`.

Thanks,
Dscho

>   */
>
>  struct combine_diff_path;
> @@ -328,7 +337,7 @@ struct diff_options {
>  	void (*set_default)(struct diff_options *);
>
>  	FILE *file;
> -	int close_file;
> +	int fclose_file;
>
>  #define OUTPUT_INDICATOR_NEW 0
>  #define OUTPUT_INDICATOR_OLD 1
> @@ -365,6 +374,8 @@ struct diff_options {
>
>  	struct repository *repo;
>  	struct option *parseopts;
> +
> +	int no_free;
>  };
>
>  unsigned diff_filter_bit(char status);
> @@ -559,6 +570,7 @@ void diffcore_fix_diff_index(void);
>
>  int diff_queue_is_empty(void);
>  void diff_flush(struct diff_options*);
> +void diff_free(struct diff_options*);
>  void diff_warn_rename_limit(const char *varname, int needed, int degrad=
ed_cc);
>
>  /* diff-raw status letters */
> diff --git a/log-tree.c b/log-tree.c
> index fd0dde97ec..bb946f15f1 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -952,12 +952,14 @@ static int log_tree_diff(struct rev_info *opt, str=
uct commit *commit, struct log
>  int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  {
>  	struct log_info log;
> -	int shown, close_file =3D opt->diffopt.close_file;
> +	int shown;
> +	/* maybe called by e.g. cmd_log_walk(), maybe stand-alone */
> +	int no_free =3D opt->diffopt.no_free;
>
>  	log.commit =3D commit;
>  	log.parent =3D NULL;
>  	opt->loginfo =3D &log;
> -	opt->diffopt.close_file =3D 0;
> +	opt->diffopt.no_free =3D 1;
>
>  	if (opt->line_level_traverse)
>  		return line_log_print(opt, commit);
> @@ -974,7 +976,7 @@ int log_tree_commit(struct rev_info *opt, struct com=
mit *commit)
>  		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
>  	opt->loginfo =3D NULL;
>  	maybe_flush_or_die(opt->diffopt.file, "stdout");
> -	if (close_file)
> -		fclose(opt->diffopt.file);
> +	opt->diffopt.no_free =3D no_free;
> +	diff_free(&opt->diffopt);
>  	return shown;
>  }
> diff --git a/wt-status.c b/wt-status.c
> index 0c8287a023..41b08474e5 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1052,7 +1052,7 @@ static void wt_longstatus_print_verbose(struct wt_=
status *s)
>  	rev.diffopt.rename_limit =3D s->rename_limit >=3D 0 ? s->rename_limit =
: rev.diffopt.rename_limit;
>  	rev.diffopt.rename_score =3D s->rename_score >=3D 0 ? s->rename_score =
: rev.diffopt.rename_score;
>  	rev.diffopt.file =3D s->fp;
> -	rev.diffopt.close_file =3D 0;
> +	rev.diffopt.fclose_file =3D 0; /* wt_status owns the s->fp */
>  	/*
>  	 * If we're not going to stdout, then we definitely don't
>  	 * want color, since we are going to the commit message
> --
> 2.30.0.284.gd98b1dd5eaa7
>
>

--8323328-628271799-1612969074=:29765--
