Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB7D1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 14:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756245AbeDVOt1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 10:49:27 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:32463 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757117AbeDVOPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 10:15:43 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id AFlyf1zdt4ZqzAFlyflNgl; Sun, 22 Apr 2018 15:15:41 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=UhTQcNhz9eT0pPCKhZ4A:9 a=wPNLvfGTeEIA:10
Message-ID: <E8BADD438B3F4D20B33BCC2CD92BC004@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Git List" <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Sergey Organov" <sorganov@gmail.com>,
        =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <0c92bdd1829328544269722cbbd3edcd169bb148.1524306547.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH v8 09/16] rebase: introduce the --rebase-merges option
Date:   Sun, 22 Apr 2018 15:15:27 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180422-0, 22/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDALFtyGOjEHnw5rD712VbrpYzBGm/joEQWbsgWr1YOXn2qtNROpZfTGNUx29/CZZFc6LnN52UDaj823lPLDa290FsplVPQhgBDfpIJbwPkC0mL3s+2Y
 EWFff7128UTHayQOBWa0fbw3kbWj0tpriyGzsk64wSYeaJITMdWzgNUb9EYTQ3lNDkpvcz6/IF0MV1UjMg4Uh2v0Z6dsAeVHsPsRQnv+Brjv7pDwH26T2MRM
 +gxXHjXPWnL7QPu5veXiAPyKTjunHyZRbibCtBNyKG5Gbm5YgR84CBdHuKWX/NdDqPdf+DEuwZ0+XvTnFN8CfocnSoHd97xHaVrR7GL4DyWUXBkltqmNJL0P
 +D6cUcxScThBCJ4gh9sV2ALNUC/AxpF3iVPpsvJtXy62Qx6Hz9fM4+reX9YfN98SoPFPYcPel1mViIfJbx7868gj7Z1gQvSP6taMABN0vvKg9kxiCpXhuLR6
 1hN2nbzOHNhFtE5JbtKUcyx+K/6K/LYkfFcJbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> Once upon a time, this here developer thought: wouldn't it be nice if,
> say, Git for Windows' patches on top of core Git could be represented as
> a thicket of branches, and be rebased on top of core Git in order to
> maintain a cherry-pick'able set of patch series?
>
> The original attempt to answer this was: git rebase --preserve-merges.
>
> However, that experiment was never intended as an interactive option,
> and it only piggy-backed on git rebase --interactive because that
> command's implementation looked already very, very familiar: it was
> designed by the same person who designed --preserve-merges: yours truly.
>
> Some time later, some other developer (I am looking at you, Andreas!
> ;-)) decided that it would be a good idea to allow --preserve-merges to
> be combined with --interactive (with caveats!) and the Git maintainer
> (well, the interim Git maintainer during Junio's absence, that is)
> agreed, and that is when the glamor of the --preserve-merges design
> started to fall apart rather quickly and unglamorously.
>
> The reason? In --preserve-merges mode, the parents of a merge commit (or
> for that matter, of *any* commit) were not stated explicitly, but were
> *implied* by the commit name passed to the `pick` command.
>
> This made it impossible, for example, to reorder commits. Not to mention
> to flatten the branch topology or, deity forbid, to split topic branches

Aside: The idea of a "flattened" topology is, to my mind, not actually
defined though may be understood by devs working in the area. Hopefully it's
going away as a term, though the new 'cousins' will need clarification
(there's no dot notation for that area of topology).

> into two.
>
> Alas, these shortcomings also prevented that mode (whose original
> purpose was to serve Git for Windows' needs, with the additional hope
> that it may be useful to others, too) from serving Git for Windows'
> needs.
>
> Five years later, when it became really untenable to have one unwieldy,
> big hodge-podge patch series of partly related, partly unrelated patches
> in Git for Windows that was rebased onto core Git's tags from time to
> time (earning the undeserved wrath of the developer of the ill-fated
> git-remote-hg series that first obsoleted Git for Windows' competing
> approach, only to be abandoned without maintainer later) was really
> untenable, the "Git garden shears" were born [*1*/*2*]: a script,
> piggy-backing on top of the interactive rebase, that would first
> determine the branch topology of the patches to be rebased, create a
> pseudo todo list for further editing, transform the result into a real
> todo list (making heavy use of the `exec` command to "implement" the
> missing todo list commands) and finally recreate the patch series on
> top of the new base commit.
>
> That was in 2013. And it took about three weeks to come up with the
> design and implement it as an out-of-tree script. Needless to say, the
> implementation needed quite a few years to stabilize, all the while the
> design itself proved itself sound.
>
> With this patch, the goodness of the Git garden shears comes to `git
> rebase -i` itself. Passing the `--rebase-merges` option will generate
> a todo list that can be understood readily, and where it is obvious
> how to reorder commits. New branches can be introduced by inserting
> `label` commands and calling `merge <label>`. And once this mode will
> have become stable and universally accepted, we can deprecate the design
> mistake that was `--preserve-merges`.
>
> Link *1*:
> https://github.com/msysgit/msysgit/blob/master/share/msysGit/shears.sh
> Link *2*:
> https://github.com/git-for-windows/build-extra/blob/master/shears.sh
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Documentation/git-rebase.txt           |  20 ++-
> contrib/completion/git-completion.bash |   2 +-
> git-rebase--interactive.sh             |   1 +
> git-rebase.sh                          |   6 +
> t/t3430-rebase-merges.sh               | 179 +++++++++++++++++++++++++
> 5 files changed, 206 insertions(+), 2 deletions(-)
> create mode 100755 t/t3430-rebase-merges.sh
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 3277ca14327..34e0f6a69c1 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -378,6 +378,23 @@ The commit list format can be changed by setting the
> configuration option
> rebase.instructionFormat.  A customized instruction format will
> automatically
> have the long commit hash prepended to the format.
>
> +-r::
> +--rebase-merges::
> + By default, a rebase will simply drop merge commits and only rebase
> + the non-merge commits. With this option, it will try to preserve
> + the branching structure within the commits that are to be rebased,
> + by recreating the merge commits. If a merge commit resolved any merge
> + or contained manual amendments, then they will have to be re-applied
> + manually.
> ++
> +This mode is similar in spirit to `--preserve-merges`, but in contrast to
> +that option works well in interactive rebases: commits can be reordered,
> +inserted and dropped at will.
> ++
> +It is currently only possible to recreate the merge commits using the
> +`recursive` merge strategy; Different merge strategies can be used only
> via
> +explicit `exec git merge -s <strategy> [...]` commands.
> +
> -p::
> --preserve-merges::
>  Recreate merge commits instead of flattening the history by replaying

Flatten is here in the context lines but its just a blunt statement that 'it
is what it is'...

> @@ -780,7 +797,8 @@ BUGS
> The todo list presented by `--preserve-merges --interactive` does not
> represent the topology of the revision graph.  Editing commits and
> rewording their commit messages should work fine, but attempts to
> -reorder commits tend to produce counterintuitive results.
> +reorder commits tend to produce counterintuitive results. Use
> +`--rebase-merges` in such scenarios instead.
>
> For example, an attempt to rearrange
> ------------
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index a7570739454..d4c0a995c39 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1949,7 +1949,7 @@ _git_rebase ()
>  --*)
>  __gitcomp "
>  --onto --merge --strategy --interactive
> - --preserve-merges --stat --no-stat
> + --rebase-merges --preserve-merges --stat --no-stat
>  --committer-date-is-author-date --ignore-date
>  --ignore-whitespace --whitespace=
>  --autosquash --no-autosquash
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ccd5254d1c9..7a3daf3e40c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -970,6 +970,7 @@ git_rebase__interactive () {
>  init_revisions_and_shortrevisions
>
>  git rebase--helper --make-script ${keep_empty:+--keep-empty} \
> + ${rebase_merges:+--rebase-merges} \
>  $revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
>  die "$(gettext "Could not generate todo list")"
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index fb64ee1fe42..a64460fd25a 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -17,6 +17,7 @@ q,quiet!           be quiet. implies --no-stat
> autostash          automatically stash/stash pop before and after
> fork-point         use 'merge-base --fork-point' to refine upstream
> onto=!             rebase onto given branch instead of upstream
> +r,rebase-merges!   try to rebase merges instead of skipping them
> p,preserve-merges! try to recreate merges instead of ignoring them
> s,strategy=!       use the given merge strategy
> no-ff!             cherry-pick all commits, even if unchanged
> @@ -88,6 +89,7 @@ type=
> state_dir=
> # One of {'', continue, skip, abort}, as parsed from command line
> action=
> +rebase_merges=
> preserve_merges=
> autosquash=
> keep_empty=
> @@ -270,6 +272,10 @@ do
>  --allow-empty-message)
>  allow_empty_message=--allow-empty-message
>  ;;
> + --rebase-merges)
> + rebase_merges=t
> + test -z "$interactive_rebase" && interactive_rebase=implied
> + ;;
>  --preserve-merges)
>  preserve_merges=t
>  test -z "$interactive_rebase" && interactive_rebase=implied
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> new file mode 100755
> index 00000000000..5f0febb9970
> --- /dev/null
> +++ b/t/t3430-rebase-merges.sh
> @@ -0,0 +1,179 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2018 Johannes E. Schindelin
> +#
> +
> +test_description='git rebase -i --rebase-merges
> +
> +This test runs git rebase "interactively", retaining the branch structure
> by
> +recreating merge commits.
> +
> +Initial setup:
> +
> +    -- B --                   (first)
> +   /       \
> + A - C - D - E - H            (master)
> +       \       /
> +         F - G                (second)
> +'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_cmp_graph () {
> + cat >expect &&
> + git log --graph --boundary --format=%s "$@" >output &&
> + sed "s/ *$//" <output >output.trimmed &&
> + test_cmp expect output.trimmed
> +}
> +
> +test_expect_success 'setup' '
> + write_script replace-editor.sh <<-\EOF &&
> + mv "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
> + cp script-from-scratch "$1"
> + EOF
> +
> + test_commit A &&
> + git checkout -b first &&
> + test_commit B &&
> + git checkout master &&
> + test_commit C &&
> + test_commit D &&
> + git merge --no-commit B &&
> + test_tick &&
> + git commit -m E &&
> + git tag -m E E &&
> + git checkout -b second C &&
> + test_commit F &&
> + test_commit G &&
> + git checkout master &&
> + git merge --no-commit G &&
> + test_tick &&
> + git commit -m H &&
> + git tag -m H H
> +'
> +
> +test_expect_success 'create completely different structure' '
> + cat >script-from-scratch <<-\EOF &&
> + label onto
> +
> + # onebranch
> + pick G
> + pick D
> + label onebranch
> +
> + # second
> + reset onto
> + pick B
> + label second
> +
> + reset onto
> + merge -C H second
> + merge onebranch # Merge the topic branch '\''onebranch'\''
> + EOF
> + test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
> + test_tick &&
> + git rebase -i -r A &&
> + test_cmp_graph <<-\EOF
> + *   Merge the topic branch '\''onebranch'\''
> + |\
> + | * D
> + | * G
> + * |   H
> + |\ \
> + | |/
> + |/|
> + | * B
> + |/
> + * A
> + EOF
> +'
> +
> +test_expect_success 'generate correct todo list' '
> + cat >expect <<-\EOF &&
> + label onto
> +
> + reset onto
> + pick d9df450 B
> + label E
> +
> + reset onto
> + pick 5dee784 C
> + label branch-point
> + pick ca2c861 F
> + pick 088b00a G
> + label H
> +
> + reset branch-point # C
> + pick 12bd07b D
> + merge -C 2051b56 E # E
> + merge -C 233d48a H # H
> +
> + EOF
> +
> + grep -v "^#" <.git/ORIGINAL-TODO >output &&
> + test_cmp expect output
> +'
> +
> +test_expect_success '`reset` refuses to overwrite untracked files' '
> + git checkout -b refuse-to-reset &&
> + test_commit dont-overwrite-untracked &&
> + git checkout @{-1} &&
> + : >dont-overwrite-untracked.t &&
> + echo "reset refs/tags/dont-overwrite-untracked" >script-from-scratch &&
> + test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
> + test_must_fail git rebase -r HEAD &&
> + git rebase --abort
> +'
> +
> +test_expect_success 'failed `merge` writes patch (may be rescheduled,
> too)' '
> + test_when_finished "test_might_fail git rebase --abort" &&
> + git checkout -b conflicting-merge A &&
> +
> + : fail because of conflicting untracked file &&
> + >G.t &&
> + echo "merge -C H G" >script-from-scratch &&
> + test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
> + test_tick &&
> + test_must_fail git rebase -ir HEAD &&
> + grep "^merge -C .* G$" .git/rebase-merge/done &&
> + grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
> + test_path_is_file .git/rebase-merge/patch &&
> +
> + : fail because of merge conflict &&
> + rm G.t .git/rebase-merge/patch &&
> + git reset --hard &&
> + test_commit conflicting-G G.t not-G conflicting-G &&
> + test_must_fail git rebase --continue &&
> + ! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
> + test_path_is_file .git/rebase-merge/patch
> +'
> +
> +test_expect_success 'with a branch tip that was cherry-picked already' '
> + git checkout -b already-upstream master &&
> + base="$(git rev-parse --verify HEAD)" &&
> +
> + test_commit A1 &&
> + test_commit A2 &&
> + git reset --hard $base &&
> + test_commit B1 &&
> + test_tick &&
> + git merge -m "Merge branch A" A2 &&
> +
> + git checkout -b upstream-with-a2 $base &&
> + test_tick &&
> + git cherry-pick A2 &&
> +
> + git checkout already-upstream &&
> + test_tick &&
> + git rebase -i -r upstream-with-a2 &&
> + test_cmp_graph upstream-with-a2.. <<-\EOF
> + *   Merge branch A
> + |\
> + | * A1
> + * | B1
> + |/
> + o A2
> + EOF
> +'
> +
> +test_done
> -- 
> 2.17.0.windows.1.15.gaa56ade3205
>
>
>

