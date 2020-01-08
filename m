Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5BDC00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248D92077B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9etzdjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgAHHvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:51:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35404 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAHHvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 02:51:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so2092254qto.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 23:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYwldSS5ldx0NjmLWfy0fPy4xpstJ9WSBEJfGrQDkAQ=;
        b=M9etzdjPmHcP+rYB14A7PMak/iXcdY4LuGDNUTNA7VUoYyay5uiD2Ea75xWouGRHTt
         X3fdvzyT+i1s3vh4SrIWkR7r/knSJRS0lQK8nUjv3DQuzcqvA/4NYcm0AlD0KVZlRtYW
         V6POTccuurSZtONwZ9zznJMu3B2/uxA6GEhtc0p8uRI2ve+Q0MHN6DotSgDoBKVVLEEO
         CCA3trn3yalRh6ukkRB17VuZG5/MZMVnIcxTiMCgILzPzS5vmF1T2AftXz2rDXto2JKC
         iInVqbdNTTMLPIzUZ5GFMXv6Ok9GapivFU/aoFD22PfnHE/Q03yMUR6FucGDihZi1jPd
         /bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYwldSS5ldx0NjmLWfy0fPy4xpstJ9WSBEJfGrQDkAQ=;
        b=AV93hpzhtiIpHjgseeSRlWyF0IqaqTQ6m9T33/PEb3a7jAQaPfeoRSdKbEHepPVdnH
         DzCsynjlRRCxyS9fhh2ulfaQNZ5IX2/Ygt4d0ovjUjH4iYILPps+pDw4d6WTib3e1sW5
         Bus+RkGveAEm2zOmJ9aTNiOIURCpPDlSwwEtHYI9eANHwDUM4pN9qvtab3/zfO6ejGiZ
         MHFSr3Sk3yli7tmp76hX30+VloMwHMRxkbEyr6GXQaKFLNaEz1enqy+uh9l96PRDQLmy
         Zrpq4BXK5k8jd9hY0oT3yxkbRv1Qfd1aKu7ikERZg/O4NzefTDkQtXY+VAeCvhCNw6hx
         Sdpw==
X-Gm-Message-State: APjAAAVCWYI0LVQQel0Ch+Z9F9GR6NdajpOLIwLKZULcxBcm+xXLXGq1
        GqzukAyzvnzSFc6b+vC8D5S2y+/3ZMF9FjAcUNI=
X-Google-Smtp-Source: APXvYqyIk53oDavAgp7XNKgV7yUlOsIlRVw61NZSlvdOzqTRFIhPGJeri80ThvLMo/Dltq7Qc6x771gy3jAUCN/Tiek=
X-Received: by 2002:ac8:1184:: with SMTP id d4mr2499499qtj.104.1578469909933;
 Tue, 07 Jan 2020 23:51:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
 <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2001071305330.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001071305330.46@tvgsbejvaqbjf.bet>
From:   Sergey Rudyshin <540555@gmail.com>
Date:   Wed, 8 Jan 2020 10:51:38 +0300
Message-ID: <CAFQTW8DhR4Zqvyq0S_9vhUOqvG2eE7fD62yKc_u130MHtCfz8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Preserve topological ordering after merges This
 modifies the algorithm of topopological ordering. The problem with the
 current algoritm is that it displays the graph below as follows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Johannes,
thank you for your comment
Indeed i forgot to put an emty line. Will fix it.

On Tue, Jan 7, 2020 at 3:08 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Sergey,
>
> please note that the commit message's first line should not be longer than
> 76 characters per line, and it should be followed by an empty line. I
> think that you forgot the empty line, looking at
> https://github.com/gitgitgadget/git/pull/514/commits/542a02020c8578d0e004cb9c929bced8719b902a
>
> Ciao,
> Johannes
>
> On Tue, 7 Jan 2020, Sergey Rudyshin via GitGitGadget wrote:
>
> > From: Sergey Rudyshin <540555@gmail.com>
> >
> > * E
> > |\
> > | * D
> > | |\
> > | |/
> > |/|
> > * | C
> > | * B
> > |/
> > * A
> >
> > commit B is placed between A and C, which is wrong
> > because E stays that D and B comes after C
> >
> > the only correct solution here is
> >
> > * E
> > |\
> > | * D
> > | |\
> > | |/
> > |/|
> > | * B
> > * | C
> > |/
> > * A
> >
> > while it seems that it contradicts to
> > D stating that C should be between D and B
> > The new algorithm solves this issue
> >
> > Here is an example:
> > * walk to to the root via "first" parents;
> > * go E -> C -> A;
> > * print A because it has no parents;
> > * step back to C;
> > * print C because it has no other parents;
> > * then step back to E;
> > * go D -> B -> A;
> > * do not print A because A is already printed;
> > * step back to B;
> > * print B;
> > * so on.
> >
> > This change makes option "--topo-order" obsolete, because
> > there is only one way to order parents of a single commit.
> > "--date-order" and "--author-date-order" are preserved and make sense
> > only for the case when multiple commits are given
> > to be able to sort those commits.
> >
> > Signed-off-by: Sergey Rudyshin <540555@gmail.com>
> > ---
> >  Documentation/git-rev-list.txt             |   4 +-
> >  Documentation/rev-list-options.txt         |  41 +++---
> >  commit.c                                   | 149 ++++++++++++++-------
> >  commit.h                                   |   4 +-
> >  t/t4202-log.sh                             |  15 +--
> >  t/t4215-log-skewed-merges.sh               |  44 +++---
> >  t/t6003-rev-list-topo-order.sh             |  54 ++++----
> >  t/t6012-rev-list-simplify.sh               |   8 +-
> >  t/t6016-rev-list-graph-simplify-history.sh |  41 +++---
> >  t/t6600-test-reach.sh                      |   6 +-
> >  10 files changed, 214 insertions(+), 152 deletions(-)
> >
> > diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> > index 025c911436..ad1fda7a54 100644
> > --- a/Documentation/git-rev-list.txt
> > +++ b/Documentation/git-rev-list.txt
> > @@ -3,7 +3,7 @@ git-rev-list(1)
> >
> >  NAME
> >  ----
> > -git-rev-list - Lists commit objects in reverse chronological order
> > +git-rev-list - Lists commit objects in reverse topological order
> >
> >
> >  SYNOPSIS
> > @@ -17,7 +17,7 @@ DESCRIPTION
> >  List commits that are reachable by following the `parent` links from the
> >  given commit(s), but exclude commits that are reachable from the one(s)
> >  given with a '{caret}' in front of them.  The output is given in reverse
> > -chronological order by default.
> > +topological order by default.
> >
> >  You can think of this as a set operation.  Commits given on the command
> >  line form a set of commits that are reachable from any of them, and then
> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > index bfd02ade99..7ab2f451ae 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -643,39 +643,42 @@ ifndef::git-shortlog[]
> >  Commit Ordering
> >  ~~~~~~~~~~~~~~~
> >
> > -By default, the commits are shown in reverse chronological order.
> > +By default, the commits are shown in reverse topological order.
> > ++
> > +Meaning that no parents are shown before all of its children and
> > +merges do not change the previous order.
> > ++
> > +E.g., if commit M0 produces topologically ordered list of
> > +commits L0 then commit M1 created by merging any commit into M0
> > +produces list L1 which starts with L0
> > ++
> > +In case if multiple commits are given via the command line
> > +the following parameters determine the order among them:
> >
> >  --date-order::
> > -     Show no parents before all of its children are shown, but
> > -     otherwise show commits in the commit timestamp order.
> > +     show commits in the commit timestamp order.
> >
> >  --author-date-order::
> > -     Show no parents before all of its children are shown, but
> > -     otherwise show commits in the author timestamp order.
> > +     show commits in the author timestamp order.
> >
> >  --topo-order::
> > -     Show no parents before all of its children are shown, and
> > -     avoid showing commits on multiple lines of history
> > -     intermixed.
> > +     show commits in the commit timestamp order.
> > +     this is deprecated and will be
> > +     removed in the future.
> >  +
> >  For example, in a commit history like this:
> >  +
> >  ----------------------------------------------------------------
> > -
> > -    ---1----2----4----7
> > -     \              \
> > -      3----5----6----8---
> > -
> > +   1----2-----------5
> > +    \    \         /
> > +     -----\---3---4---6
> > +           \     /
> > +            ----
> >  ----------------------------------------------------------------
> >  +
> >  where the numbers denote the order of commit timestamps, `git
> >  rev-list` and friends with `--date-order` show the commits in the
> > -timestamp order: 8 7 6 5 4 3 2 1.
> > -+
> > -With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
> > -3 1); some older commits are shown before newer ones in order to
> > -avoid showing the commits from two parallel development track mixed
> > -together.
> > +following order: 1 2 3 4 5 6.
> >
> >  --reverse::
> >       Output the commits chosen to be shown (see Commit Limiting
> > diff --git a/commit.c b/commit.c
> > index 434ec030d6..01e9d07db9 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -738,6 +738,12 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
> >       return 0;
> >  }
> >
> > +static int compare_commits_by_author_date_rev(const void *a_, const void *b_,
> > +                                void *cb_data)
> > +{
> > +     return compare_commits_by_author_date(b_, a_, cb_data);
> > +}
> > +
> >  int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
> >  {
> >       const struct commit *a = a_, *b = b_;
> > @@ -767,36 +773,83 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
> >       return 0;
> >  }
> >
> > +static int compare_commits_by_commit_date_rev(const void *a_, const void *b_, void *unused)
> > +{
> > +     return compare_commits_by_commit_date (b_, a_, unused);
> > +}
> > +
> > +struct maze {
> > +     struct commit *ret;
> > +     struct commit *out;
> > +};
> > +
> > +define_commit_slab(maze_slab, struct maze *);
> > +
> > +/*
> > + * returns the next commit while exploring the maze
> > + * current commit has the information:
> > + *   - what was the last commit we went for (OUT)
> > + *   - from which commit we came in (RET)
> > + * trying to find a parent next to OUT
> > + * if it does not exists returns RET
> > + * otherwise returns the found parent
> > + */
> > +static struct commit *get_next(struct commit *commit, struct maze *mz, struct indegree_slab *indegree)
> > +{
> > +     struct commit_list *parents = commit->parents;
> > +     struct commit *next = NULL;
> > +     int found = 0;
> > +
> > +     while (parents) {
> > +             struct commit *parent = parents->item;
> > +
> > +             if (*indegree_slab_at(indegree, parent)) {
> > +
> > +                     if (!mz->out || found) {
> > +                             next = parent;
> > +                             break;
> > +                     } else if  (mz->out == parent) {
> > +                             found = 1;
> > +                     }
> > +             }
> > +             parents = parents->next;
> > +     }
> > +
> > +     if (!next) next = mz->ret;
> > +
> > +     return next;
> > +}
> > +
> >  /*
> >   * Performs an in-place topological sort on the list supplied.
> >   */
> >  void sort_in_topological_order(struct commit_list **list, enum rev_sort_order sort_order)
> >  {
> >       struct commit_list *next, *orig = *list;
> > -     struct commit_list **pptr;
> > +     struct commit_list **pptr = list;
> >       struct indegree_slab indegree;
> > -     struct prio_queue queue;
> > +     struct prio_queue queue_tips;
> >       struct commit *commit;
> >       struct author_date_slab author_date;
> > +     struct maze_slab maze;
> > +     struct maze *mz;
> >
> >       if (!orig)
> >               return;
> >       *list = NULL;
> >
> >       init_indegree_slab(&indegree);
> > -     memset(&queue, '\0', sizeof(queue));
> > +     init_maze_slab(&maze);
> > +     memset(&queue_tips, '\0', sizeof(queue_tips));
> >
> >       switch (sort_order) {
> > -     default: /* REV_SORT_IN_GRAPH_ORDER */
> > -             queue.compare = NULL;
> > -             break;
> > -     case REV_SORT_BY_COMMIT_DATE:
> > -             queue.compare = compare_commits_by_commit_date;
> > +     default:
> > +             queue_tips.compare = compare_commits_by_commit_date_rev;
> >               break;
> >       case REV_SORT_BY_AUTHOR_DATE:
> >               init_author_date_slab(&author_date);
> > -             queue.compare = compare_commits_by_author_date;
> > -             queue.cb_data = &author_date;
> > +             queue_tips.compare = compare_commits_by_author_date_rev;
> > +             queue_tips.cb_data = &author_date;
> >               break;
> >       }
> >
> > @@ -804,9 +857,10 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
> >       for (next = orig; next; next = next->next) {
> >               struct commit *commit = next->item;
> >               *(indegree_slab_at(&indegree, commit)) = 1;
> > -             /* also record the author dates, if needed */
> > -             if (sort_order == REV_SORT_BY_AUTHOR_DATE)
> > -                     record_author_date(&author_date, commit);
> > +             mz = xmalloc(sizeof(struct maze));
> > +             mz->ret = NULL;
> > +             mz->out = NULL;
> > +             *(maze_slab_at(&maze, commit)) = mz;
> >       }
> >
> >       /* update the indegree */
> > @@ -832,51 +886,56 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
> >       for (next = orig; next; next = next->next) {
> >               struct commit *commit = next->item;
> >
> > -             if (*(indegree_slab_at(&indegree, commit)) == 1)
> > -                     prio_queue_put(&queue, commit);
> > +             if (*(indegree_slab_at(&indegree, commit)) == 1) {
> > +                     /* also record the author dates, if needed */
> > +                     if (sort_order == REV_SORT_BY_AUTHOR_DATE)
> > +                             record_author_date(&author_date, commit);
> > +                     prio_queue_put(&queue_tips, commit);
> > +             }
> >       }
> >
> > -     /*
> > -      * This is unfortunate; the initial tips need to be shown
> > -      * in the order given from the revision traversal machinery.
> > -      */
> > -     if (sort_order == REV_SORT_IN_GRAPH_ORDER)
> > -             prio_queue_reverse(&queue);
> > -
> >       /* We no longer need the commit list */
> >       free_commit_list(orig);
> >
> >       pptr = list;
> >       *list = NULL;
> > -     while ((commit = prio_queue_get(&queue)) != NULL) {
> > -             struct commit_list *parents;
> > -
> > -             for (parents = commit->parents; parents ; parents = parents->next) {
> > -                     struct commit *parent = parents->item;
> > -                     int *pi = indegree_slab_at(&indegree, parent);
> >
> > -                     if (!*pi)
> > +     while ((commit = prio_queue_get(&queue_tips)) != NULL) {
> > +             struct commit *prev_commit = NULL;
> > +             while (commit) {
> > +                     mz = *(maze_slab_at(&maze, commit));
> > +                     if (!prev_commit) {
> > +                             /* either a new tip or
> > +                              * after entering an already visited commit
> > +                              */
> > +                     }
> > +                     else if (!mz->out) {
> > +                             /* happens only once for every commit
> > +                              * note that for tips RET is set to NULL
> > +                              */
> > +                             mz->ret = prev_commit;
> > +                     }
> > +                     else if (prev_commit != mz->out) {
> > +                             /* entered an already visited commit
> > +                              * step back
> > +                              */
> > +                             commit = prev_commit;
> > +                             prev_commit = NULL;
> >                               continue;
> > -
> > -                     /*
> > -                      * parents are only enqueued for emission
> > -                      * when all their children have been emitted thereby
> > -                      * guaranteeing topological order.
> > -                      */
> > -                     if (--(*pi) == 1)
> > -                             prio_queue_put(&queue, parent);
> > +                     }
> > +                     mz->out = get_next(commit, mz, &indegree);
> > +                     if (mz->out == mz->ret) {
> > +                             /* upon leaving a commit emit it */
> > +                             *pptr = commit_list_insert(commit, pptr);
> > +                     }
> > +                     prev_commit = commit;
> > +                     commit = mz->out;
> >               }
> > -             /*
> > -              * all children of commit have already been
> > -              * emitted. we can emit it now.
> > -              */
> > -             *(indegree_slab_at(&indegree, commit)) = 0;
> > -
> > -             pptr = &commit_list_insert(commit, pptr)->next;
> >       }
> >
> >       clear_indegree_slab(&indegree);
> > -     clear_prio_queue(&queue);
> > +     clear_maze_slab(&maze);
> > +     clear_prio_queue(&queue_tips);
> >       if (sort_order == REV_SORT_BY_AUTHOR_DATE)
> >               clear_author_date_slab(&author_date);
> >  }
> > diff --git a/commit.h b/commit.h
> > index 221cdaa34b..1fe3cc240e 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -209,7 +209,7 @@ struct commit *pop_commit(struct commit_list **stack);
> >  void clear_commit_marks(struct commit *commit, unsigned int mark);
> >  void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark);
> >
> > -
> > +/* TODO get rid of rev_sort_order in a favour of positional parameters */
> >  enum rev_sort_order {
> >       REV_SORT_IN_GRAPH_ORDER = 0,
> >       REV_SORT_BY_COMMIT_DATE,
> > @@ -222,8 +222,6 @@ enum rev_sort_order {
> >   *   invariant of resulting list is:
> >   *      a reachable from b => ord(b) < ord(a)
> >   *   sort_order further specifies:
> > - *   REV_SORT_IN_GRAPH_ORDER: try to show a commit on a single-parent
> > - *                            chain together.
> >   *   REV_SORT_BY_COMMIT_DATE: show eligible commits in committer-date order.
> >   */
> >  void sort_in_topological_order(struct commit_list **, enum rev_sort_order);
> > diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> > index 2c9489484a..46f04b36a3 100755
> > --- a/t/t4202-log.sh
> > +++ b/t/t4202-log.sh
> > @@ -635,17 +635,16 @@ test_expect_success 'set up more tangled history' '
> >  cat > expect <<\EOF
> >  *   Merge tag 'reach'
> >  |\
> > -| \
> > +| * reach
> > +| |
> >  |  \
> >  *-. \   Merge tags 'octopus-a' and 'octopus-b'
> >  |\ \ \
> > -* | | | seventh
> >  | | * | octopus-b
> > -| |/ /
> > -|/| |
> > -| * | octopus-a
> > -|/ /
> > -| * reach
> > +| | |/
> > +| * / octopus-a
> > +| |/
> > +* / seventh
> >  |/
> >  *   Merge branch 'tangle'
> >  |\
> > @@ -673,7 +672,7 @@ cat > expect <<\EOF
> >  * initial
> >  EOF
> >
> > -test_expect_success 'log --graph with merge' '
> > +test_expect_success 'log --graph with merge tag reach' '
> >       git log --graph --date-order --pretty=tformat:%s |
> >               sed "s/ *\$//" >actual &&
> >       test_cmp expect actual
> > diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> > index 18709a723e..91630c0cae 100755
> > --- a/t/t4215-log-skewed-merges.sh
> > +++ b/t/t4215-log-skewed-merges.sh
> > @@ -5,7 +5,7 @@ test_description='git log --graph of skewed merges'
> >  . ./test-lib.sh
> >
> >  check_graph () {
> > -     cat >expect &&
> > +     sed "s/ *$//" >expect &&
> >       git log --graph --pretty=tformat:%s "$@" >actual.raw &&
> >       sed "s/ *$//" actual.raw >actual &&
> >       test_cmp expect actual
> > @@ -185,20 +185,21 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
> >
> >       check_graph --date-order <<-\EOF
> >       *   4_H
> > -     |\
> > +     |\
> >       | *   4_G
> > -     | |\
> > +     | |\
> > +     | | * 4_C
> >       | * | 4_F
> > -     |/| |
> > +     |/| |
> >       | * |   4_E
> > -     | |\ \
> > -     | | * | 4_D
> > -     | |/ /
> > -     |/| |
> > -     | | * 4_C
> > -     | |/
> > +     | |\ \
> > +     | | |/
> > +     | |/|
> > +     | | * 4_D
> > +     | |/
> > +     |/|
> >       | * 4_B
> > -     |/
> > +     |/
> >       * 4_A
> >       EOF
> >  '
> > @@ -221,21 +222,20 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
> >
> >       check_graph <<-\EOF
> >       *   5_H
> > -     |\
> > +     |\
> >       | *-.   5_G
> > -     | |\ \
> > +     | |\ \
> >       | | | * 5_F
> >       | | * |   5_E
> > -     | |/|\ \
> > -     | |_|/ /
> > -     |/| | /
> > -     | | |/
> > -     * | | 5_D
> > +     | |/|\ \
> > +     | |_|/ /
> > +     |/| | /
> > +     | | |/
> >       | | * 5_C
> > -     | |/
> > -     |/|
> > -     | * 5_B
> > -     |/
> > +     | * | 5_B
> > +     | |/
> > +     * / 5_D
> > +     |/
> >       * 5_A
> >       EOF
> >  '
> > diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
> > index 24d1836f41..19cb79bc29 100755
> > --- a/t/t6003-rev-list-topo-order.sh
> > +++ b/t/t6003-rev-list-topo-order.sh
> > @@ -87,12 +87,12 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > -a1
> >  b3
> >  b2
> >  b1
> > +a3
> > +a2
> > +a1
> >  a0
> >  l2
> >  l1
> > @@ -105,15 +105,15 @@ l5
> >  l4
> >  l3
> >  a4
> > -b4
> > -a3
> > -a2
> >  c3
> >  c2
> > +c1
> > +b4
> >  b3
> >  b2
> > -c1
> >  b1
> > +a3
> > +a2
> >  a1
> >  a0
> >  l2
> > @@ -127,12 +127,12 @@ l5
> >  l4
> >  l3
> >  a4
> > -b4
> >  c3
> >  c2
> > +c1
> > +b4
> >  b3
> >  b2
> > -c1
> >  b1
> >  a3
> >  a2
> > @@ -205,12 +205,12 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > -a1
> >  b3
> >  b2
> >  b1
> > +a3
> > +a2
> > +a1
> >  a0
> >  l2
> >  EOF
> > @@ -224,12 +224,12 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > -a1
> >  b3
> >  b2
> >  b1
> > +a3
> > +a2
> > +a1
> >  a0
> >  l2
> >  EOF
> > @@ -237,10 +237,10 @@ EOF
> >  test_output_expect_success 'prune near topo' 'git rev-list --topo-order a4 ^c3' <<EOF
> >  a4
> >  b4
> > +b3
> >  a3
> >  a2
> >  a1
> > -b3
> >  EOF
> >
> >  test_output_expect_success "head has no parent" 'git rev-list --topo-order  root' <<EOF
> > @@ -297,8 +297,8 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > +b3
> > +b2
> >  EOF
> >
> >  test_output_expect_success "max-count 10 - non topo order" 'git rev-list --max-count=10 l5' <<EOF
> > @@ -376,12 +376,12 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > -a1
> >  b3
> >  b2
> >  b1
> > +a3
> > +a2
> > +a1
> >  a0
> >  l2
> >  l1
> > @@ -399,12 +399,12 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > -a1
> >  b3
> >  b2
> >  b1
> > +a3
> > +a2
> > +a1
> >  a0
> >  l2
> >  l1
> > @@ -428,12 +428,12 @@ c3
> >  c2
> >  c1
> >  b4
> > -a3
> > -a2
> > -a1
> >  b3
> >  b2
> >  b1
> > +a3
> > +a2
> > +a1
> >  a0
> >  l2
> >  l1
> > diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> > index a10f0df02b..9f687b6b22 100755
> > --- a/t/t6012-rev-list-simplify.sh
> > +++ b/t/t6012-rev-list-simplify.sh
> > @@ -122,16 +122,16 @@ check_result () {
> >
> >  check_result 'L K J I H F E D C G B A' --full-history --topo-order
> >  check_result 'L K I H G F E D C B J A' --full-history
> > -check_result 'L K I H G F E D C B J A' --full-history --date-order
> > -check_result 'L K I H G F E D B C J A' --full-history --author-date-order
> > +check_result 'L K J I H F E D C G B A' --full-history --date-order
> > +check_result 'L K J I H F E D C G B A' --full-history --author-date-order
> >  check_result 'K I H E C B A' --full-history -- file
> >  check_result 'K I H E C B A' --full-history --topo-order -- file
> >  check_result 'K I H E C B A' --full-history --date-order -- file
> > -check_result 'K I H E B C A' --full-history --author-date-order -- file
> > +check_result 'K I H E C B A' --full-history --author-date-order -- file
> >  check_result 'I E C B A' --simplify-merges -- file
> >  check_result 'I E C B A' --simplify-merges --topo-order -- file
> >  check_result 'I E C B A' --simplify-merges --date-order -- file
> > -check_result 'I E B C A' --simplify-merges --author-date-order -- file
> > +check_result 'I E C B A' --simplify-merges --author-date-order -- file
> >  check_result 'I B A' -- file
> >  check_result 'I B A' --topo-order -- file
> >  check_result 'I B A' --date-order -- file
> > diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
> > index f5e6e92f5b..5750c6f0fd 100755
> > --- a/t/t6016-rev-list-graph-simplify-history.sh
> > +++ b/t/t6016-rev-list-graph-simplify-history.sh
> > @@ -235,27 +235,28 @@ test_expect_success '--graph ^C3' '
> >  # I don't think the ordering of the boundary commits is really
> >  # that important, but this test depends on it.  If the ordering ever changes
> >  # in the code, we'll need to update this test.
> > -test_expect_success '--graph --boundary ^C3' '
> > +test_expect_success '--graph --boundary --all ^C3' '
> >       rm -f expected &&
> > -     echo "* $A7" >> expected &&
> > -     echo "*   $A6" >> expected &&
> > -     echo "|\\  " >> expected &&
> > -     echo "| * $C4" >> expected &&
> > -     echo "* | $A5" >> expected &&
> > -     echo "| |     " >> expected &&
> > -     echo "|  \\    " >> expected &&
> > -     echo "*-. \\   $A4" >> expected &&
> > -     echo "|\\ \\ \\  " >> expected &&
> > -     echo "| * | | $B2" >> expected &&
> > -     echo "| * | | $B1" >> expected &&
> > -     echo "* | | | $A3" >> expected &&
> > -     echo "o | | | $A2" >> expected &&
> > -     echo "|/ / /  " >> expected &&
> > -     echo "o / / $A1" >> expected &&
> > -     echo " / /  " >> expected &&
> > -     echo "| o $C3" >> expected &&
> > -     echo "|/  " >> expected &&
> > -     echo "o $C2" >> expected &&
> > +     cat >> expected <<-TESTDATA &&
> > +     * $A7
> > +     *   $A6
> > +     |\
> > +     | * $C4
> > +     * | $A5
> > +     | |
> > +     |  \
> > +     *-. \   $A4
> > +     |\ \ \
> > +     | * | | $B2
> > +     | * | | $B1
> > +     * | | | $A3
> > +     | | | o $C3
> > +     | | |/
> > +     | | o $C2
> > +     o | $A2
> > +     |/
> > +     o $A1
> > +     TESTDATA
> >       git rev-list --graph --boundary --all ^C3 > actual &&
> >       test_cmp expected actual
> >       '
> > diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> > index b24d850036..a6d389c4fd 100755
> > --- a/t/t6600-test-reach.sh
> > +++ b/t/t6600-test-reach.sh
> > @@ -339,6 +339,8 @@ test_expect_success 'rev-list: ancestry-path topo-order' '
> >       run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
> >  '
> >
> > +# TODO get rid of the "sort" below
> > +# if commitGraph is enabled then sort_in_topological_order is not envoked
> >  test_expect_success 'rev-list: symmetric difference topo-order' '
> >       git rev-parse \
> >               commit-6-6 commit-5-6 commit-4-6 \
> > @@ -349,8 +351,8 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
> >               commit-6-1 commit-5-1 commit-4-1 \
> >               commit-3-8 commit-2-8 commit-1-8 \
> >               commit-3-7 commit-2-7 commit-1-7 \
> > -     >expect &&
> > -     run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
> > +     | sort >expect &&
> > +     run_three_modes git rev-list --topo-order commit-3-8...commit-6-6 | sort
> >  '
> >
> >  test_expect_success 'get_reachable_subset:all' '
> > --
> > gitgitgadget
> >
> >
