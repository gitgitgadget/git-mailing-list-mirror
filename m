Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E99C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDAE218AC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNqXeG1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBMSyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:54:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46417 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBMSyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:54:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so6579834otb.13
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZDbY7vBzFnQraYvueq82cmIx+gZopo04lqMFft+SqI=;
        b=oNqXeG1xIbQYfCPHiu9Eh8hiKpAWaDrgQhYiItntv1VUUduxwZ9jXFa/ZpgbLQRN5P
         p9OgdfR6klEvuOQyC7dlYmTKbdEdXAu+jVzAat2pPS7G56RgXwX/OxKL0l+rgvRhx0UY
         MpLsD37YP4lPbXYrm8B7JPztejzfdOovC99ZkxwyBi8RM/6QyH0V4E42/HE2PbbHycc2
         yZlw2ejDHsF6+qPA8p/XHI9iTThBBqIY9gLURbqtsRcTVriTREO92TLycpj74ehKAzvj
         nPwkmZxlidvFc7PZ48DvtBwlJas0H4WM3XzEB7TP485A8QPFk7ukyDabk1eQn9D+kQyE
         qv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZDbY7vBzFnQraYvueq82cmIx+gZopo04lqMFft+SqI=;
        b=XwdgixqSjn3JwEY1AbBPN6V6JXEDE9aCWDI1lFG9CBvt6IYsAODTjpPfjICISJsC5t
         De6trpZWfukAdjxOUjEQSW1EwZqwx/wk4WRcxE7iaigCpptW6zgH76ES1I2Rf9/C/WNf
         /OkR6LwVb7DQZclSC6wyFPfJAMPoNfcQgpOkNhJ9PMPY+xDLoXe6cQrnB3eq6AWOr4XH
         lqRnk2YNiuqLWjZC9P+HUO2xzpgQuiVMDgXlt7vHdYaKL18Xia8IPqPnJUFqmWvWDk5N
         3QkYiWjB/63l2LsBH/qgp2bsNzBySRBIfSpWQEOGuI38XQjThzi0pzfX0kFMGCeqIOM5
         n2Ng==
X-Gm-Message-State: APjAAAXB7ZijtGTtvd0pV1Fbxn+FZlsnYUSNpwx8JrLQZSi3HEKtZgMo
        xZJHb4cj4e4zQKpJbofnGIXNhJOewZFqj+WVoi4=
X-Google-Smtp-Source: APXvYqwaWKW4OGJ/kGY0L0kU9pwGCaVkdWALtxIF7/oUmDLP5wp1MNxW0D3F1utsLSJzucAwqOn751NDP20veh/kJIY=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr14723484otl.162.1581620053960;
 Thu, 13 Feb 2020 10:54:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com> <c9542a2abe0da284c28f1c71566db8fc5c47c1a5.1579155273.git.gitgitgadget@gmail.com>
 <4da2874e-b96a-e81c-c2ac-4b3f06c9926d@gmail.com>
In-Reply-To: <4da2874e-b96a-e81c-c2ac-4b3f06c9926d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 13 Feb 2020 10:54:02 -0800
Message-ID: <CABPp-BGRGkjBk9aY8DUXJY52e5u_aAVd8-dspEcW6Se3v-G4-Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] rebase (interactive-backend): fix handling of
 commits that become empty
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 6:27 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 16/01/2020 06:14, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > As established in the previous commit and commit b00bf1c9a8dd
> > (git-rebase: make --allow-empty-message the default, 2018-06-27), the
> > behavior for rebase with different backends in various edge or corner
> > cases is often more happenstance than design.  This commit addresses
> > another such corner case: commits which "become empty".
> >
> > A careful reader may note that there are two types of commits which would
> > become empty due to a rebase:
> >
> >    * [clean cherry-pick] Commits which are clean cherry-picks of upstream
> >      commits, as determined by `git log --cherry-mark ...`.  Re-applying
> >      these commits would result in an empty set of changes and a
> >      duplicative commit message; i.e. these are commits that have
> >      "already been applied" upstream.
> >
> >    * [become empty] Commits which are not empty to start, are not clean
> >      cherry-picks of upstream commits, but which still become empty after
> >      being rebased.  This happens e.g. when a commit has changes which
> >      are a strict subset of the changes in an upstream commit, or when
> >      the changes of a commit can be found spread across or among several
> >      upstream commits.
> >
> > Clearly, in both cases the changes in the commit in question are found
> > upstream already, but the commit message may not be in the latter case.
> >
> > When cherry-mark can determine a commit is already upstream, then
> > because of how cherry-mark works this means the upstream commit message
> > was about the *exact* same set of changes.  Thus, the commit messages
> > can be assumed to be fully interchangeable (and are in fact likely to be
> > completely identical).  As such, the clean cherry-pick case represents a
> > case when there is no information to be gained by keeping the extra
> > commit around.  All rebase types have always dropped these commits, and
> > no one to my knowledge has ever requested that we do otherwise.
> >
> > For many of the become empty cases (and likely even most), we will also
> > be able to drop the commit without loss of information -- but this isn't
> > quite always the case.  Since these commits represent cases that were
> > not clean cherry-picks, there is no upstream commit message explaining
> > the same set of changes.  Projects with good commit message hygiene will
> > likely have the explanation from our commit message contained within or
> > spread among the relevant upstream commits, but not all projects run
> > that way.  As such, the commit message of the commit being rebased may
> > have reasoning that suggests additional changes that should be made to
> > adapt to the new base, or it may have information that someone wants to
> > add as a note to another commit, or perhaps someone even wants to create
> > an empty commit with the commit message as-is.
> >
> > Junio commented on the "become-empty" types of commits as follows[1]:
> >
> >      WRT a change that ends up being empty (as opposed to a change that
> >      is empty from the beginning), I'd think that the current behaviour
> >      is desireable one.  "am" based rebase is solely to transplant an
> >      existing history and want to stop much less than "interactive" one
> >      whose purpose is to polish a series before making it publishable,
> >      and asking for confirmation ("this has become empty--do you want to
> >      drop it?") is more appropriate from the workflow point of view.
> >
> > [1] https://lore.kernel.org/git/xmqqfu1fswdh.fsf@gitster-ct.c.googlers.com/
> >
> > I would simply add that his arguments for "am"-based rebases actually
> > apply to all non-explicitly-interactive rebases.  Also, since we are
> > stating that different cases should have different defaults, it may be
> > worth providing a flag to allow users to select which behavior they want
> > for these commits.
> >
> > Introduce a new command line flag for selecting the desired behavior:
> >      --empty={drop,keep,ask}
> > with the definitions:
> >      drop: drop commits which become empty
> >      keep: keep commits which become empty
> >      ask:  provide the user a chance to interact and pick what to do with
> >            commits which become empty on a case-by-case basis
> >
> > In line with Junio's suggestion, if the --empty flag is not specified,
> > pick defaults as follows:
> >      explicitly interactive: ask
> >      otherwise: drop
>
> Looking at the implementation there is a third option - if `--exec` is
> given without `-i` then the default is "keep". I'm not sure if having
> different defaults is convenient or confusing but don't feel that
> strongly about it.

Heh, in https://lore.kernel.org/git/404424d7-f520-8f89-efef-ca03e66fcd43@gmail.com/
you argued that having different defaults was confusing and sounded
like you felt strongly about it.  Granted, there has been a lot of
simplification to the implementation (and description) since then but
I'm still inclined to go with the simpler and more easily explained
behavior for the defaults based on what you said there.

> I've got a few minor comments below (the mains ones
> are saying which commit has been dropped and testing the default
> behavior when --empty is not given) but basically I like the new patch.
> Thanks for working on this, the commit message does a good job of
> explaining the changes.

:-)

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >   Documentation/git-rebase.txt | 27 ++++++++++++++++---
> >   builtin/rebase.c             | 52 ++++++++++++++++++++++++++++++++++++
> >   sequencer.c                  | 48 +++++++++++++++++++++++++--------
> >   sequencer.h                  |  1 +
> >   t/t3424-rebase-empty.sh      | 50 +++++++++++++++++++++++++++++-----
> >   t/t3427-rebase-subtree.sh    |  8 +++---
> >   6 files changed, 161 insertions(+), 25 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 1d19542d79..551a91d764 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -258,6 +258,22 @@ See also INCOMPATIBLE OPTIONS below.
> >       original branch. The index and working tree are also left
> >       unchanged as a result.
> >
> > +--empty={drop,keep,ask}::
> > +     How to handle commits that are not empty to start and are not
> > +     clean cherry-picks of any upstream commit, but which become
> > +     empty after rebasing (because they contain a subset of already
> > +     upstream changes).  With drop (the default), commits that
> > +     become empty are dropped.  With keep, such commits are kept.
> > +     With ask (implied by --interactive), the rebase will halt when
> > +     an empty commit is applied allowing you to choose whether to
> > +     drop it, edit files more, or just commit the empty changes.
>
> We should probably document the default for --exec without -i

I did, but I guess it wasn't clear enough.  Maybe I should add "Note
that other options like --exec will use the default of drop unless
-i/--interactive is specified."?

> > +Note that commits which start empty are kept, and commits which are
> > +clean cherry-picks (as determined by `git log --cherry-mark ...`) are
> > +always dropped.
> > ++
> > +See also INCOMPATIBLE OPTIONS below.
> > +
> >   --keep-empty::
> >       No-op.  Rebasing commits that started empty (had no change
> >       relative to their parent) used to fail and this option would
> > @@ -561,6 +577,7 @@ are incompatible with the following options:
> >    * --interactive
> >    * --exec
> >    * --keep-empty
> > + * --empty=
> >    * --edit-todo
> >    * --root when used in combination with --onto
> >
> > @@ -569,6 +586,7 @@ In addition, the following pairs of options are incompatible:
> >    * --preserve-merges and --interactive
> >    * --preserve-merges and --signoff
> >    * --preserve-merges and --rebase-merges
> > + * --preserve-merges and --empty=
> >    * --keep-base and --onto
> >    * --keep-base and --root
> >
> > @@ -585,9 +603,12 @@ commits that started empty, though these are rare in practice.  It
> >   also drops commits that become empty and has no option for controlling
> >   this behavior.
> >
> > -The interactive backend keeps intentionally empty commits.
> > -Unfortunately, it always halts whenever it runs across a commit that
> > -becomes empty, even when the rebase is not explicitly interactive.
> > +The interactive backend keeps intentionally empty commits.  Similar to
> > +the am backend, by default the interactive backend drops commits that
> > +become empty unless -i/--interactive is specified (in which case it
> > +stops and asks the user what to do).  The interactive backend also has
> > +an --empty={drop,keep,ask} option for changing the behavior of
> > +handling commits that become empty.
> >
> >   Directory rename detection
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 537b3241ce..c299869e7b 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -50,8 +50,16 @@ enum rebase_type {
> >       REBASE_PRESERVE_MERGES
> >   };
> >
> > +enum empty_type {
> > +     EMPTY_UNSPECIFIED = -1,
> > +     EMPTY_DROP,
> > +     EMPTY_KEEP,
> > +     EMPTY_ASK
> > +};
> > +
> >   struct rebase_options {
> >       enum rebase_type type;
> > +     enum empty_type empty;
> >       const char *state_dir;
> >       struct commit *upstream;
> >       const char *upstream_name;
> > @@ -91,6 +99,7 @@ struct rebase_options {
> >
> >   #define REBASE_OPTIONS_INIT {                               \
> >               .type = REBASE_UNSPECIFIED,             \
> > +             .empty = EMPTY_UNSPECIFIED,             \
> >               .flags = REBASE_NO_QUIET,               \
> >               .git_am_opts = ARGV_ARRAY_INIT,         \
> >               .git_format_patch_opt = STRBUF_INIT     \
> > @@ -109,6 +118,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> >               replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
> >       replay.allow_empty = 1;
> >       replay.allow_empty_message = opts->allow_empty_message;
> > +     replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
> > +     replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
> >       replay.verbose = opts->flags & REBASE_VERBOSE;
> >       replay.reschedule_failed_exec = opts->reschedule_failed_exec;
> >       replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
> > @@ -444,6 +455,10 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> >
> >       BUG_ON_OPT_ARG(arg);
> >
> > +     /*
> > +      * If we ever want to remap --keep-empty to --empty=keep, insert:
> > +      *      opts->empty = unset ? EMPTY_UNSPECIFIED : EMPTY_KEEP;
> > +      */
> >       opts->type = REBASE_INTERACTIVE;
> >       return 0;
> >   }
> > @@ -1350,6 +1365,29 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
> >       return 0;
> >   }
> >
> > +static enum empty_type parse_empty_value(const char *value)
> > +{
> > +     if (!strcasecmp(value, "drop"))
> > +             return EMPTY_DROP;
> > +     else if (!strcasecmp(value, "keep"))
> > +             return EMPTY_KEEP;
> > +     else if (!strcasecmp(value, "ask"))
> > +             return EMPTY_ASK;
> > +
> > +     die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
> > +}
> > +
> > +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
> > +{
> > +     struct rebase_options *options = opt->value;
> > +     enum empty_type value = parse_empty_value(arg);
> > +
> > +     BUG_ON_OPT_NEG(unset);
> > +
> > +     options->empty = value;
> > +     return 0;
> > +}
> > +
> >   static void NORETURN error_on_missing_default_upstream(void)
> >   {
> >       struct branch *current_branch = branch_get(NULL);
> > @@ -1494,6 +1532,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                                "ignoring them"),
> >                             REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
> >               OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> > +             OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
> > +                            N_("how to handle empty commits"),
>
> Maybe we should say "how to handle commits that become empty" to
> distinguish them from commits that start empty which we always keep

Ooh, good catch; will fix.

> > +                            PARSE_OPT_NONEG, parse_opt_empty),
> >               { OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
> >                       N_("(DEPRECATED) keep empty commits"),
> >                       PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
> > @@ -1760,6 +1801,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >       if (!(options.flags & REBASE_NO_QUIET))
> >               argv_array_push(&options.git_am_opts, "-q");
> >
> > +     if (options.empty != EMPTY_UNSPECIFIED)
> > +             imply_interactive(&options, "--empty");
> > +
> >       if (gpg_sign) {
> >               free(options.gpg_sign_opt);
> >               options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
> > @@ -1843,6 +1887,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >               break;
> >       }
> >
> > +     if (options.empty == EMPTY_UNSPECIFIED) {
> > +             if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
> > +                     options.empty = EMPTY_ASK;
> > +             else if (exec.nr > 0)
> > +                     options.empty = EMPTY_KEEP;
> > +             else
> > +                     options.empty = EMPTY_DROP;
> > +     }
> >       if (reschedule_failed_exec > 0 && !is_interactive(&options))
> >               die(_("--reschedule-failed-exec requires "
> >                     "--exec or --interactive"));
> > diff --git a/sequencer.c b/sequencer.c
> > index c21fc202b1..354d0b5a38 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -158,6 +158,8 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
> >   static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
> >   static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
> >   static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
> > +static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
> > +static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
> >
> >   static int git_sequencer_config(const char *k, const char *v, void *cb)
> >   {
> > @@ -1483,7 +1485,11 @@ static int is_original_commit_empty(struct commit *commit)
> >   }
> >
> >   /*
> > - * Do we run "git commit" with "--allow-empty"?
> > + * Should empty commits be allowed?  Return status:
> > + *    <0: Error in is_index_unchanged(r) or is_original_commit_empty(commit)
> > + *     0: Halt on empty commit
> > + *     1: Allow empty commit
> > + *     2: Drop empty commit
> >    */
> >   static int allow_empty(struct repository *r,
> >                      struct replay_opts *opts,
> > @@ -1492,14 +1498,17 @@ static int allow_empty(struct repository *r,
> >       int index_unchanged, originally_empty;
> >
> >       /*
> > -      * Three cases:
> > +      * Four cases:
> >        *
> >        * (1) we do not allow empty at all and error out.
> >        *
> > -      * (2) we allow ones that were initially empty, but
> > -      * forbid the ones that become empty;
> > +      * (2) we allow ones that were initially empty, and
> > +      *     just drop the ones that become empty
> >        *
> > -      * (3) we allow both.
> > +      * (3) we allow ones that were initially empty, but
> > +      *     halt for the ones that become empty;
> > +      *
> > +      * (4) we allow both.
> >        */
> >       if (!opts->allow_empty)
> >               return 0; /* let "git commit" barf as necessary */
> > @@ -1516,10 +1525,12 @@ static int allow_empty(struct repository *r,
> >       originally_empty = is_original_commit_empty(commit);
> >       if (originally_empty < 0)
> >               return originally_empty;
> > -     if (!originally_empty)
> > -             return 0;
> > -     else
> > +     if (originally_empty)
> >               return 1;
> > +     else if (opts->drop_redundant_commits)
> > +             return 2;
> > +     else
> > +             return 0;
> >   }
> >
> >   static struct {
> > @@ -1730,7 +1741,7 @@ static int do_pick_commit(struct repository *r,
> >       char *author = NULL;
> >       struct commit_message msg = { NULL, NULL, NULL, NULL };
> >       struct strbuf msgbuf = STRBUF_INIT;
> > -     int res, unborn = 0, reword = 0, allow;
> > +     int res, unborn = 0, reword = 0, allow, drop_commit;
> >
> >       if (opts->no_commit) {
> >               /*
> > @@ -1935,13 +1946,18 @@ static int do_pick_commit(struct repository *r,
> >               goto leave;
> >       }
> >
> > +     drop_commit = 0;
> >       allow = allow_empty(r, opts, commit);
> >       if (allow < 0) {
> >               res = allow;
> >               goto leave;
> > -     } else if (allow)
> > +     } else if (allow == 1) {
> >               flags |= ALLOW_EMPTY;
> > -     if (!opts->no_commit) {
> > +     } else if (allow == 2) {
> > +             drop_commit = 1;
> > +             fprintf(stderr, _("No changes -- Patch already applied.\n"));
>
> nit pick - usually messages start with a lowercase letter. Would it be
> helpful to explicitly state which commit is being dropped as well as
> why? Something like
>    dropping <oid> <subject> - patch contents already upstream

I was actually just trying to mimic the am-backend here, and copied
its message verbatim for this case (see am_run() in builtin/am.c).
However, your version does seem more helpful and informative.  I'll
look into it implementing it here.

>
> > +     } // else allow == 0 and there's nothing special to do
>
> We don't use // for comments

Oops, sorry.  Will fix.

>
> > +     if (!opts->no_commit && !drop_commit) {
> >               if (author || command == TODO_REVERT || (flags & AMEND_MSG))
> >                       res = do_commit(r, msg_file, author, opts, flags);
> >               else
> > @@ -2495,6 +2511,12 @@ static int read_populate_opts(struct replay_opts *opts)
> >               if (file_exists(rebase_path_reschedule_failed_exec()))
> >                       opts->reschedule_failed_exec = 1;
> >
> > +             if (file_exists(rebase_path_drop_redundant_commits()))
> > +                     opts->drop_redundant_commits = 1;
> > +
> > +             if (file_exists(rebase_path_keep_redundant_commits()))
> > +                     opts->keep_redundant_commits = 1;
> > +
> >               read_strategy_opts(opts, &buf);
> >               strbuf_release(&buf);
> >
> > @@ -2574,6 +2596,10 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
> >               write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
> >       if (opts->signoff)
> >               write_file(rebase_path_signoff(), "--signoff\n");
> > +     if (opts->drop_redundant_commits)
> > +             write_file(rebase_path_drop_redundant_commits(), "%s", "");
> > +     if (opts->keep_redundant_commits)
> > +             write_file(rebase_path_keep_redundant_commits(), "%s", "");
> >       if (opts->reschedule_failed_exec)
> >               write_file(rebase_path_reschedule_failed_exec(), "%s", "");
> >
> > diff --git a/sequencer.h b/sequencer.h
> > index c165e0ff25..3b0ab9141f 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -39,6 +39,7 @@ struct replay_opts {
> >       int allow_rerere_auto;
> >       int allow_empty;
> >       int allow_empty_message;
> > +     int drop_redundant_commits;
> >       int keep_redundant_commits;
> >       int verbose;
> >       int quiet;
> > diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
> > index 22d97e143b..dcb4cb4751 100755
> > --- a/t/t3424-rebase-empty.sh
> > +++ b/t/t3424-rebase-empty.sh
> > @@ -34,7 +34,7 @@ test_expect_success 'setup test repository' '
> >       git commit -m "Five letters ought to be enough for anybody"
> >   '
> >
> > -test_expect_failure 'rebase (am-backend) with a variety of empty commits' '
> > +test_expect_failure 'rebase (am-backend)' '
> >       test_when_finished "git rebase --abort" &&
> >       git checkout -B testing localmods &&
> >       # rebase (--am) should not drop commits that start empty
> > @@ -45,11 +45,29 @@ test_expect_failure 'rebase (am-backend) with a variety of empty commits' '
> >       test_cmp expect actual
> >   '
> >
> > -test_expect_failure 'rebase --merge with a variety of empty commits' '
> > -     test_when_finished "git rebase --abort" &&
> > +test_expect_success 'rebase --merge --empty=drop' '
> >       git checkout -B testing localmods &&
> > -     # rebase --merge should not halt on the commit that becomes empty
> > -     git rebase --merge upstream &&
> > +     git rebase --merge --empty=drop upstream &&
> > +
> > +     test_write_lines D C B A >expect &&
> > +     git log --format=%s >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'rebase --merge --empty=keep' '
> > +     git checkout -B testing localmods &&
> > +     git rebase --merge --empty=keep upstream &&
> > +
> > +     test_write_lines D C2 C B A >expect &&
> > +     git log --format=%s >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'rebase --merge --empty=ask' '
> > +     git checkout -B testing localmods &&
> > +     test_must_fail git rebase --merge --empty=ask upstream &&
> > +
> > +     git rebase --skip &&
> >
> >       test_write_lines D C B A >expect &&
> >       git log --format=%s >actual &&
> > @@ -58,9 +76,27 @@ test_expect_failure 'rebase --merge with a variety of empty commits' '
> >
> >   GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
> >
> > -test_expect_success 'rebase --interactive with a variety of empty commits' '
> > +test_expect_success 'rebase --interactive --empty=drop' '
> > +     git checkout -B testing localmods &&
> > +     git rebase --interactive --empty=drop upstream &&
> > +
> > +     test_write_lines D C B A >expect &&
> > +     git log --format=%s >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'rebase --interactive --empty=keep' '
> > +     git checkout -B testing localmods &&
> > +     git rebase --interactive --empty=keep upstream &&
> > +
> > +     test_write_lines D C2 C B A >expect &&
> > +     git log --format=%s >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'rebase --interactive --empty=ask' '
> >       git checkout -B testing localmods &&
> > -     test_must_fail git rebase --interactive upstream &&
> > +     test_must_fail git rebase --interactive --empty=ask upstream &&
> >
> >       git rebase --skip &&
>
> As the default if --empty is not given is supposed to vary depending on
> the other options given it would be good to test that I think

I'll add some tests.


Thanks for the thorough review!
Elijah
