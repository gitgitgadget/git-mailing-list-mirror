Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39185C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E48760F45
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhIFIf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhIFIfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 04:35:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8DC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 01:34:46 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x5so6118537ill.3
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQAWnDlQkFKw5qiZDJ4xvK1CG4pvErO+HfvO4Wgrzbg=;
        b=F/ajgjahDf1tAeVQryzaWbNDc34LhLqFXS64w8LtgA0rZNNDGqaHCuP5kpxN8hc40U
         Udwe0M7iqpTwKllCzLBQyl9iKpt7HU4CJbyiZCy+bMdinZN2gdSs1r4GFZcpfqfeqxQY
         AWGDNJNeONmf2IURM0gU2GHUgPnrVP3a6Om7ccDXYwYeqa1kNh2iUB/LMkYRVbQBi/+W
         wT2AhgPWiowLrUyIhGf7HXvYAsYi4e4wmiibJFrgu3Jab5pMRTuCjBkvbnfM+AAzQ1gj
         5FofHC/BcE7NK3Wgrzecy79l8b7jx7/DYy0nvPBXW8nuGDHAoAVz8ALnQrACNwbamtUk
         r18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQAWnDlQkFKw5qiZDJ4xvK1CG4pvErO+HfvO4Wgrzbg=;
        b=NnVkTAremDAIiQ1T2UMdo0mP9MABBKCelhabSvdFv3M8AVhSJXZw9Mj17Bj5KeSDvR
         EcbaqOhkli7RBOdKFqG3FS/POCnBpffNk8glbKrMZq+Dv/U92i+p9+TTtwZCOMHwlY+4
         3AWYOOuGELT1y94vcH/ae9Hj7rP68dVVYTSl63AZ5x6rMLbmA+cQ0BqiNtvdZydUgIlF
         pXKJjCG9Wq/DTCfHmmLBBslLJqHfZQqeB7l6Yc9uf+cfktw0L1/K5/JSHOi14fepfRQh
         MDP3QHof2z81i0cKvBMacuS1w91nsZPIy3J42dB9fhCEUHqrKGqsHsvCqdaHVEZgnMst
         +9xw==
X-Gm-Message-State: AOAM530dgzxpYoVlWUsMEJM/CR/nG8hiGSVe8QiBS87v3oRdnIweuTzN
        QVEO/Gl6+ze6RkdUcd+ntuBEUAG1JF6eJS6KsruJK5U1dTc=
X-Google-Smtp-Source: ABdhPJwmtGNrAPC8/jj0lvEVibDG8X1A+OrGIecDpSOXG1l57tZv3ttxeUslsfi09QumQnAVvJmbxJOjQl8h+zvgU84=
X-Received: by 2002:a92:d1c1:: with SMTP id u1mr7747985ilg.255.1630917286178;
 Mon, 06 Sep 2021 01:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210902090421.93113-1-mirucam@gmail.com> <20210902090421.93113-6-mirucam@gmail.com>
 <xmqqtuj2h7cp.fsf@gitster.g> <nycvar.QRO.7.76.6.2109060923390.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2109060923390.55@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 6 Sep 2021 10:34:35 +0200
Message-ID: <CAN7CjDANWsWwPcAG2cftAiadwaWZNXBtL=Q8MrqH2xVMj7kUOg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] bisect--helper: reimplement `bisect_run` shell
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El lun, 6 sept 2021 a las 9:33, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Junio & Miriam,
>
> On Thu, 2 Sep 2021, Junio C Hamano wrote:
>
> > Miriam Rubio <mirucam@gmail.com> writes:
> >
> > [...]
> > > @@ -1075,6 +1090,79 @@ static int bisect_visualize(struct bisect_term=
s *terms, const char **argv, int a
> > >     return res;
> > >  }
> > >
> > > +static int bisect_run(struct bisect_terms *terms, const char **argv,=
 int argc)
> > > +{
> > > +   int res =3D BISECT_OK;
> > > +   struct strbuf command =3D STRBUF_INIT;
> > > +   struct strvec args =3D STRVEC_INIT;
> > > +   struct strvec run_args =3D STRVEC_INIT;
> > > +   const char *new_state;
> > > +   int temporary_stdout_fd, saved_stdout;
> > > +
> > > +   if (bisect_next_check(terms, NULL))
> > > +           return BISECT_FAILED;
> > > +
> > > +   if (argc)
> > > +           sq_quote_argv(&command, argv);
> > > +   else {
> > > +           error(_("bisect run failed: no command provided."));
> > > +           return BISECT_FAILED;
> > > +   }
> > > +   strvec_push(&run_args, command.buf);
> > > +
> > > +   while (1) {
> > > +           strvec_clear(&args);
> > > +
> > > +           printf(_("running %s\n"), command.buf);
> > > +           res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
> > > +
> > > +           if (res < 0 || 128 <=3D res) {
> > > +                   error(_("bisect run failed: exit code %d from"
> > > +                           " '%s' is < 0 or >=3D 128"), res, command=
.buf);
> > > +                   strbuf_release(&command);
> > > +                   return res;
> > > +           }
> > > +
> > > +           if (res =3D=3D 125)
> > > +                   new_state =3D "skip";
> > > +           else
> > > +                   new_state =3D res > 0 ? terms->term_bad : terms->=
term_good;
> >
> > It is easier to follow the code if you spelled out this part as
> >
> >               else if (!res)
> >                       new_state =3D terms->term_good;
> >               else
> >                       new_state =3D terms->term_bad;
> >
> > because that would consistently handle the three cases.  Of course
> > you _could_ do
> >
> >               new_state =3D (res =3D=3D 125)
> >                         ? "skip"
> >                         : (res > 0)
> >                         ? terms->term_bad
> >                         : terms->term_good;
> >
> > instead, but that would be harder to read.
>
> FWIW I agree with this, after seeing the resulting code.
>
> > > +           temporary_stdout_fd =3D open(git_path_bisect_run(), O_CRE=
AT | O_WRONLY | O_TRUNC, 0666);
> >
> > Can this open fail, and if it fails, what do we want to do?
> >
> > > +           saved_stdout =3D dup(1);
> > > +           dup2(temporary_stdout_fd, 1);
> > > +
> > > +           res =3D bisect_state(terms, &new_state, 1);
> > > +
> > > +           dup2(saved_stdout, 1);
> > > +           close(saved_stdout);
> > > +           close(temporary_stdout_fd);
> >
> > Hmph, now you lost me.  Whose output are we working around here with
> > the redirection?
> >
> >       ... goes and looks ...
> >
> > Ahh, OK.  bisect_next_all() to bisect_checkout() all assume that
> > they only need to write to the standard output, so we need to do
> > this dance (unless we are willing to update the bisect.c functions
> > to accept FILE * as parameter, that is).
> >
> > However, they use not just write(2) but stdio to do their output,
> > no?  Don't we need to fflush(stdout) around the redirection dance,
> > one to empty the output that was associated with the real standard
> > output stream before asking bisect_state() to write to fd #1 via
> > stdio, and one more time to flush out what bisect_state() wrote to
> > the stdio after the call returns before closing the fd we opened to
> > the BISECT_RUN file?
>
> Yes, we would have to `fflush(stdout)`.
>
> However, I still don't like that we play such a `dup2()` game. I gave it =
a
> quick try to avoid it (see the diff below, which corresponds to the commi=
t
> I pushed up as `git-bisect-work-part4-v7` to
> https://github.com/dscho/git), which still could benefit from a bit of
> polishing (maybe we should rethink the object model and extend/rename
> `bisect_terms` to `bisect_state` and accumulate more fields, such as
> `out_fd`.
>
> Obviously this will need to be cleaned up, and while I would _love_ to se=
e
> this make it into your next iteration, ultimately it is up to you, Miriam=
,
> to decide whether you want to build on my diff (quite possibly making the
> entire object model of the bisect part of Git's code more elegant and mor=
e
> maintainable), and up to you, Junio, to decide whether you would be
> willing to accept the patch series without this refactoring.
>
I also don=E2=80=99t love this `dup2()` game but I implemented it as a
possible solution to recreate the cat command as it is
in the shell script, without changing behavior or parameters in other funct=
ions.
Also thank you for your solution, I agree that it is more elegant and
maintainable.

If Junio accepts the patch series with my `dup2()` solution, I can
implement your suggestion as an improvement after finishing the
porting of git bisect to C. Because after this patch series, there
will be only one last patch series left and I believe rethinking the
object model and extend/rename `bisect_terms` to `bisect_state` and
accumulate more fields, such as `out_fd` should be better separated of
the porting project.

Best,
Miriam.

> -- snipsnap --
> diff --git a/bisect.c b/bisect.c
> index af2863d044b..405bf60b4b6 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -683,20 +683,21 @@ static void bisect_common(struct rev_info *revs)
>  }
>
>  static enum bisect_error error_if_skipped_commits(struct commit_list *tr=
ied,
> -                                   const struct object_id *bad)
> +                                                 const struct object_id =
*bad,
> +                                                 FILE *out)
>  {
>         if (!tried)
>                 return BISECT_OK;
>
> -       printf("There are only 'skip'ped commits left to test.\n"
> -              "The first %s commit could be any of:\n", term_bad);
> +       fprintf(out, "There are only 'skip'ped commits left to test.\n"
> +               "The first %s commit could be any of:\n", term_bad);
>
>         for ( ; tried; tried =3D tried->next)
> -               printf("%s\n", oid_to_hex(&tried->item->object.oid));
> +               fprintf(out, "%s\n", oid_to_hex(&tried->item->object.oid)=
);
>
>         if (bad)
> -               printf("%s\n", oid_to_hex(bad));
> -       printf(_("We cannot bisect more!\n"));
> +               fprintf(out, "%s\n", oid_to_hex(bad));
> +       fprintf(out, _("We cannot bisect more!\n"));
>
>         return BISECT_ONLY_SKIPPED_LEFT;
>  }
> @@ -725,10 +726,12 @@ static int is_expected_rev(const struct object_id *=
oid)
>         return res;
>  }
>
> -static enum bisect_error bisect_checkout(const struct object_id *bisect_=
rev, int no_checkout)
> +static enum bisect_error bisect_checkout(const struct object_id *bisect_=
rev,
> +                                        int no_checkout, FILE *out)
>  {
>         char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>         enum bisect_error res =3D BISECT_OK;
> +       struct child_process cp =3D CHILD_PROCESS_INIT;
>
>         oid_to_hex_r(bisect_rev_hex, bisect_rev);
>         update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDA=
TE_REFS_DIE_ON_ERR);
> @@ -749,7 +752,10 @@ static enum bisect_error bisect_checkout(const struc=
t object_id *bisect_rev, int
>         }
>
>         argv_show_branch[1] =3D bisect_rev_hex;
> -       res =3D run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
> +       cp.argv =3D argv_show_branch;
> +       cp.git_cmd =3D 1;
> +       cp.out =3D dup(fileno(out));
> +       res =3D run_command(&cp);
>         /*
>          * Errors in `run_command()` itself, signaled by res < 0,
>          * and errors in the child process, signaled by res > 0
> @@ -841,7 +847,8 @@ static void handle_skipped_merge_base(const struct ob=
ject_id *mb)
>   * for early success, this will be converted back to 0 in
>   * check_good_are_ancestors_of_bad().
>   */
> -static enum bisect_error check_merge_bases(int rev_nr, struct commit **r=
ev, int no_checkout)
> +static enum bisect_error check_merge_bases(int rev_nr, struct commit **r=
ev,
> +                                          int no_checkout, FILE *out)
>  {
>         enum bisect_error res =3D BISECT_OK;
>         struct commit_list *result;
> @@ -858,8 +865,8 @@ static enum bisect_error check_merge_bases(int rev_nr=
, struct commit **rev, int
>                 } else if (0 <=3D oid_array_lookup(&skipped_revs, mb)) {
>                         handle_skipped_merge_base(mb);
>                 } else {
> -                       printf(_("Bisecting: a merge base must be tested\=
n"));
> -                       res =3D bisect_checkout(mb, no_checkout);
> +                       fprintf(out, _("Bisecting: a merge base must be t=
ested\n"));
> +                       res =3D bisect_checkout(mb, no_checkout, out);
>                         if (!res)
>                                 /* indicate early success */
>                                 res =3D BISECT_INTERNAL_SUCCESS_MERGE_BAS=
E;
> @@ -898,8 +905,9 @@ static int check_ancestors(struct repository *r, int =
rev_nr,
>   */
>
>  static enum bisect_error check_good_are_ancestors_of_bad(struct reposito=
ry *r,
> -                                           const char *prefix,
> -                                           int no_checkout)
> +                                                        const char *pref=
ix,
> +                                                        int no_checkout,
> +                                                        FILE *out)
>  {
>         char *filename;
>         struct stat st;
> @@ -924,7 +932,7 @@ static enum bisect_error check_good_are_ancestors_of_=
bad(struct repository *r,
>
>         rev =3D get_bad_and_good_commits(r, &rev_nr);
>         if (check_ancestors(r, rev_nr, rev, prefix))
> -               res =3D check_merge_bases(rev_nr, rev, no_checkout);
> +               res =3D check_merge_bases(rev_nr, rev, no_checkout, out);
>         free(rev);
>
>         if (!res) {
> @@ -953,7 +961,7 @@ static enum bisect_error check_good_are_ancestors_of_=
bad(struct repository *r,
>   */
>  static void show_diff_tree(struct repository *r,
>                            const char *prefix,
> -                          struct commit *commit)
> +                          struct commit *commit, FILE *out)
>  {
>         const char *argv[] =3D {
>                 "diff-tree", "--pretty", "--stat", "--summary", "--cc", N=
ULL
> @@ -964,6 +972,7 @@ static void show_diff_tree(struct repository *r,
>         repo_init_revisions(r, &opt, prefix);
>
>         setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
> +       opt.diffopt.file =3D out;
>         log_tree_commit(&opt, commit);
>  }
>
> @@ -1007,7 +1016,8 @@ void read_bisect_terms(const char **read_bad, const=
 char **read_good)
>   * the end of bisect_helper::cmd_bisect__helper() helps bypassing
>   * all the code related to finding a commit to test.
>   */
> -enum bisect_error bisect_next_all(struct repository *r, const char *pref=
ix)
> +enum bisect_error bisect_next_all(struct repository *r, const char *pref=
ix,
> +                                 FILE *out)
>  {
>         struct rev_info revs;
>         struct commit_list *tried;
> @@ -1032,7 +1042,7 @@ enum bisect_error bisect_next_all(struct repository=
 *r, const char *prefix)
>         if (skipped_revs.nr)
>                 bisect_flags |=3D FIND_BISECTION_ALL;
>
> -       res =3D check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> +       res =3D check_good_are_ancestors_of_bad(r, prefix, no_checkout, o=
ut);
>         if (res)
>                 return res;
>
> @@ -1051,10 +1061,10 @@ enum bisect_error bisect_next_all(struct reposito=
ry *r, const char *prefix)
>                  * We should return error here only if the "bad"
>                  * commit is also a "skip" commit.
>                  */
> -               res =3D error_if_skipped_commits(tried, NULL);
> +               res =3D error_if_skipped_commits(tried, NULL, out);
>                 if (res < 0)
>                         return res;
> -               printf(_("%s was both %s and %s\n"),
> +               fprintf(out, _("%s was both %s and %s\n"),
>                        oid_to_hex(current_bad_oid),
>                        term_good,
>                        term_bad);
> @@ -1072,13 +1082,13 @@ enum bisect_error bisect_next_all(struct reposito=
ry *r, const char *prefix)
>         bisect_rev =3D &revs.commits->item->object.oid;
>
>         if (oideq(bisect_rev, current_bad_oid)) {
> -               res =3D error_if_skipped_commits(tried, current_bad_oid);
> +               res =3D error_if_skipped_commits(tried, current_bad_oid, =
out);
>                 if (res)
>                         return res;
> -               printf("%s is the first %s commit\n", oid_to_hex(bisect_r=
ev),
> -                       term_bad);
> +               fprintf(out, "%s is the first %s commit\n",
> +                       oid_to_hex(bisect_rev), term_bad);
>
> -               show_diff_tree(r, prefix, revs.commits->item);
> +               show_diff_tree(r, prefix, revs.commits->item, out);
>                 /*
>                  * This means the bisection process succeeded.
>                  * Using BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10)
> @@ -1098,14 +1108,14 @@ enum bisect_error bisect_next_all(struct reposito=
ry *r, const char *prefix)
>          * TRANSLATORS: the last %s will be replaced with "(roughly %d
>          * steps)" translation.
>          */
> -       printf(Q_("Bisecting: %d revision left to test after this %s\n",
> -                 "Bisecting: %d revisions left to test after this %s\n",
> -                 nr), nr, steps_msg);
> +       fprintf(out, Q_("Bisecting: %d revision left to test after this %=
s\n",
> +                       "Bisecting: %d revisions left to test after this =
%s\n",
> +                       nr), nr, steps_msg);
>         free(steps_msg);
>         /* Clean up objects used, as they will be reused. */
>         repo_clear_commit_marks(r, ALL_REV_FLAGS);
>
> -       return bisect_checkout(bisect_rev, no_checkout);
> +       return bisect_checkout(bisect_rev, no_checkout, out);
>  }
>
>  static inline int log2i(int n)
> diff --git a/bisect.h b/bisect.h
> index ec24ac2d7ee..72bfd7b0053 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -61,7 +61,8 @@ enum bisect_error {
>         BISECT_INTERNAL_SUCCESS_MERGE_BASE =3D -11
>  };
>
> -enum bisect_error bisect_next_all(struct repository *r, const char *pref=
ix);
> +enum bisect_error bisect_next_all(struct repository *r, const char *pref=
ix,
> +                                 FILE *out);
>
>  int estimate_bisect_steps(int all);
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1c96580bd49..29969763d35 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -581,7 +581,8 @@ static int bisect_successful(struct bisect_terms *ter=
ms)
>         return res;
>  }
>
> -static enum bisect_error bisect_next(struct bisect_terms *terms, const c=
har *prefix)
> +static enum bisect_error bisect_next(struct bisect_terms *terms,
> +                                    const char *prefix, FILE *out)
>  {
>         enum bisect_error res;
>
> @@ -592,7 +593,7 @@ static enum bisect_error bisect_next(struct bisect_te=
rms *terms, const char *pre
>                 return BISECT_FAILED;
>
>         /* Perform all bisection computation */
> -       res =3D bisect_next_all(the_repository, prefix);
> +       res =3D bisect_next_all(the_repository, prefix, out);
>
>         if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
>                 res =3D bisect_successful(terms);
> @@ -604,12 +605,13 @@ static enum bisect_error bisect_next(struct bisect_=
terms *terms, const char *pre
>         return res;
>  }
>
> -static enum bisect_error bisect_auto_next(struct bisect_terms *terms, co=
nst char *prefix)
> +static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
> +                                         const char *prefix, FILE *out)
>  {
>         if (bisect_next_check(terms, NULL))
>                 return BISECT_OK;
>
> -       return bisect_next(terms, prefix);
> +       return bisect_next(terms, prefix, out);
>  }
>
>  static enum bisect_error bisect_start(struct bisect_terms *terms, const =
char **argv, int argc)
> @@ -808,7 +810,7 @@ static enum bisect_error bisect_start(struct bisect_t=
erms *terms, const char **a
>         if (res)
>                 return res;
>
> -       res =3D bisect_auto_next(terms, NULL);
> +       res =3D bisect_auto_next(terms, NULL, stdout);
>         if (!is_bisect_success(res))
>                 bisect_clean_state();
>         return res;
> @@ -847,7 +849,7 @@ static int bisect_autostart(struct bisect_terms *term=
s)
>  }
>
>  static enum bisect_error bisect_state(struct bisect_terms *terms, const =
char **argv,
> -                                     int argc)
> +                                     int argc, FILE *out)
>  {
>         const char *state;
>         int i, verify_expected =3D 1;
> @@ -924,7 +926,7 @@ static enum bisect_error bisect_state(struct bisect_t=
erms *terms, const char **a
>         }
>
>         oid_array_clear(&revs);
> -       return bisect_auto_next(terms, NULL);
> +       return bisect_auto_next(terms, NULL, out);
>  }
>
>  static enum bisect_error bisect_log(void)
> @@ -1013,7 +1015,7 @@ static enum bisect_error bisect_replay(struct bisec=
t_terms *terms, const char *f
>         if (res)
>                 return BISECT_FAILED;
>
> -       return bisect_auto_next(terms, NULL);
> +       return bisect_auto_next(terms, NULL, stdout);
>  }
>
>  static enum bisect_error bisect_skip(struct bisect_terms *terms, const c=
har **argv, int argc)
> @@ -1045,7 +1047,7 @@ static enum bisect_error bisect_skip(struct bisect_=
terms *terms, const char **ar
>                         strvec_push(&argv_state, argv[i]);
>                 }
>         }
> -       res =3D bisect_state(terms, argv_state.v, argv_state.nr);
> +       res =3D bisect_state(terms, argv_state.v, argv_state.nr, stdout);
>
>         strvec_clear(&argv_state);
>         return res;
> @@ -1096,7 +1098,6 @@ static int bisect_run(struct bisect_terms *terms, c=
onst char **argv, int argc)
>         struct strvec args =3D STRVEC_INIT;
>         struct strvec run_args =3D STRVEC_INIT;
>         const char *new_state;
> -       int temporary_stdout_fd, saved_stdout;
>
>         if (bisect_next_check(terms, NULL))
>                 return BISECT_FAILED;
> @@ -1111,6 +1112,8 @@ static int bisect_run(struct bisect_terms *terms, c=
onst char **argv, int argc)
>         strvec_push(&run_args, command.buf);
>
>         while (1) {
> +               FILE *f;
> +
>                 strvec_clear(&args);
>
>                 printf(_("running %s\n"), command.buf);
> @@ -1130,19 +1133,13 @@ static int bisect_run(struct bisect_terms *terms,=
 const char **argv, int argc)
>                 else
>                         new_state =3D terms->term_bad;
>
> -               temporary_stdout_fd =3D open(git_path_bisect_run(), O_CRE=
AT | O_WRONLY | O_TRUNC, 0666);
> +               f =3D fopen_for_writing(git_path_bisect_run());
>
> -               if (temporary_stdout_fd < 0)
> +               if (!f)
>                         return error_errno(_("cannot open file '%s' for w=
riting"), git_path_bisect_run());
>
> -               saved_stdout =3D dup(1);
> -               dup2(temporary_stdout_fd, 1);
> -
> -               res =3D bisect_state(terms, &new_state, 1);
> -
> -               dup2(saved_stdout, 1);
> -               close(saved_stdout);
> -               close(temporary_stdout_fd);
> +               res =3D bisect_state(terms, &new_state, 1, f);
> +               fclose(f);
>
>                 print_file_to_stdout(git_path_bisect_run());
>
> @@ -1240,12 +1237,12 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>                 if (argc)
>                         return error(_("--bisect-next requires 0 argument=
s"));
>                 get_terms(&terms);
> -               res =3D bisect_next(&terms, prefix);
> +               res =3D bisect_next(&terms, prefix, stdout);
>                 break;
>         case BISECT_STATE:
>                 set_terms(&terms, "bad", "good");
>                 get_terms(&terms);
> -               res =3D bisect_state(&terms, argv, argc);
> +               res =3D bisect_state(&terms, argv, argc, stdout);
>                 break;
>         case BISECT_LOG:
>                 if (argc)
