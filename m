Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A368A1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBWMgF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:36:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:47135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeBWMgC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:36:02 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgGDK-1f48ha3Xew-00NijY; Fri, 23
 Feb 2018 13:35:53 +0100
Date:   Fri, 23 Feb 2018 13:35:37 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 00/12] rebase -i: offer to recreate merge commits
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3ZzQcv0Vc7SVnok/GOuxQGGddkmqFPSFAaqTtaQKoq17mlf2Qtc
 Ueo62RobIpCiE7fNoUOhCLH5hwFnZplarNro55CWspg7e9L9i8dFnm9O5z/g6lfonOIy1M9
 NFkoB4NLUIGaovMJ9uCBG+CAty4cUk23dGC74Ti4F6j7gVxCquSCOTioT25kA515f4s9WKu
 GfenqvicolOTx9DAYEYuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EFLAwuGanX0=:M2SYs4CscSDuvQiOkyM/FW
 Leen1/LTUF0pGShS7OMnx+WWDqNZkueBlPE7Pl+wmkQTAWY28XRcqKeE5R0/ERg309T04/3Ba
 jSv1o0vrCDmucyLHLkov8cBAAfKVNb2dItYf6kWhcIuHJMPx8dEMkK/9v3xYTVIWS5d99Eymj
 fT+9GjNr0lLEWlMow3kHYGYlUnrQKI2FQAVrTi+y83WzvBn3SK6wZX3vTBIkTII5k7QxQ4tdR
 M7byzftX2Mo0SG+yRxu0Ppux/k+2tTb1vThQ35MZxO2S5RBDVBC5Nb0rLNSH3yz6WTTIdiaQJ
 fHUWZIUM872oBMrnnbQ3yTky6/flQmQSMlXccV/RE4h/UYmiqShP5ndbICRSys2Z6X1PdHyTc
 B7rq/RoiJCoxlw64GAL2BP5P0kgEzJU5OygEkOOvMOdJ12NLvpuC6Xile7o1yFKD+Hd2r1Agv
 TnqIEqjAh5GHHDzrdgTdsJDLIqrHXDUf9AxYg4sMurCsvjpa9PBwn2EK9ad08n+Mud5vr5PMG
 l2sbjgBvmEGeftVdm9hzO+UQzwHLQHwjIKQidSyYqota5s71OiW1MJfXo1ca1EGkijqYs262/
 MaAzSSI7txwIEAFyqhoGO2a4XAGPwF8Ybrz+RLRFOuEXjFlTelj6T8w8JljA6YetCKVuXEdkq
 XFBzOi2+X/bS0bsoExnz8rA6tlpFemrDGOB7C2Mirl1cF+RTHAYKgf76F2Ri/tL9Ud2wZMSeC
 G+7fMXYahU6z+N3gCqVgGDnmou6rLWvFMVydcq0PL0GHU5qMD12z39fYC4NgYlQzSgWkt940k
 edwP5QnCvOAvq7J/c06Qvtop2CvAtvtErp0new4wyX3xA0JtC8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, I dreamt of an interactive rebase that would not
flatten branch structure, but instead recreate the commit topology
faithfully.

My original attempt was --preserve-merges, but that design was so
limited that I did not even enable it in interactive mode.

Subsequently, it *was* enabled in interactive mode, with the predictable
consequences: as the --preserve-merges design does not allow for
specifying the parents of merge commits explicitly, all the new commits'
parents are defined *implicitly* by the previous commit history, and
hence it is *not possible to even reorder commits*.

This design flaw cannot be fixed. Not without a complete re-design, at
least. This patch series offers such a re-design.

Think of --recreate-merges as "--preserve-merges done right". It
introduces new verbs for the todo list, `label`, `reset` and `merge`.
For a commit topology like this:

            A - B - C
              \   /
                D

the generated todo list would look like this:

            # branch D
            pick 0123 A
            label branch-point
            pick 1234 D
            label D

            reset branch-point
            pick 2345 B
            merge -C 3456 D # C

There are more patches in the pipeline, based on this patch series, but
left for later in the interest of reviewable patch series: one mini
series to use the sequencer even for `git rebase -i --root`, and another
one to add support for octopus merges to --recreate-merges.

Changes since v3:

- fixed a grammar error in "introduce the `merge` command"'s commit message.

- fixed a couple of resource leaks in safe_append() and do_reset(), pointed
  out by Eric Sunshine.


Johannes Schindelin (11):
  sequencer: avoid using errno clobbered by rollback_lock_file()
  sequencer: make rearrange_squash() a bit more obvious
  sequencer: introduce new commands to reset the revision
  sequencer: introduce the `merge` command
  sequencer: fast-forward merge commits, if possible
  rebase-helper --make-script: introduce a flag to recreate merges
  rebase: introduce the --recreate-merges option
  sequencer: make refs generated by the `label` command worktree-local
  sequencer: handle post-rewrite for merge commands
  pull: accept --rebase=recreate to recreate the branch topology
  rebase -i: introduce --recreate-merges=[no-]rebase-cousins

Stefan Beller (1):
  git-rebase--interactive: clarify arguments

 Documentation/config.txt               |   8 +
 Documentation/git-pull.txt             |   5 +-
 Documentation/git-rebase.txt           |  14 +-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |   2 +
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |  22 +-
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 742 ++++++++++++++++++++++++++++++++-
 sequencer.h                            |   7 +
 t/t3430-rebase-recreate-merges.sh      | 208 +++++++++
 13 files changed, 1027 insertions(+), 31 deletions(-)
 create mode 100755 t/t3430-rebase-recreate-merges.sh


base-commit: e3a80781f5932f5fea12a49eb06f3ade4ed8945c
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v4
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v4

Interdiff vs v3:
 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index f57e9cf10ca..8c9adea0d0c 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1058,6 +1058,10 @@ branch.<name>.rebase::
  	"git pull" is run. See "pull.rebase" for doing this in a non
  	branch-specific manner.
  +
 +When recreate, also pass `--recreate-merges` along to 'git rebase'
 +so that locally committed merge commits will not be flattened
 +by running 'git pull'.
 ++
  When preserve, also pass `--preserve-merges` along to 'git rebase'
  so that locally committed merge commits will not be flattened
  by running 'git pull'.
 @@ -2607,6 +2611,10 @@ pull.rebase::
  	pull" is run. See "branch.<name>.rebase" for setting this on a
  	per-branch basis.
  +
 +When recreate, also pass `--recreate-merges` along to 'git rebase'
 +so that locally committed merge commits will not be flattened
 +by running 'git pull'.
 ++
  When preserve, also pass `--preserve-merges` along to 'git rebase'
  so that locally committed merge commits will not be flattened
  by running 'git pull'.
 diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
 index ce05b7a5b13..b4f9f057ea9 100644
 --- a/Documentation/git-pull.txt
 +++ b/Documentation/git-pull.txt
 @@ -101,13 +101,16 @@ Options related to merging
  include::merge-options.txt[]
  
  -r::
 ---rebase[=false|true|preserve|interactive]::
 +--rebase[=false|true|recreate|preserve|interactive]::
  	When true, rebase the current branch on top of the upstream
  	branch after fetching. If there is a remote-tracking branch
  	corresponding to the upstream branch and the upstream branch
  	was rebased since last fetched, the rebase uses that information
  	to avoid rebasing non-local changes.
  +
 +When set to recreate, rebase with the `--recreate-merges` option passed
 +to `git rebase` so that locally created merge commits will not be flattened.
 ++
  When set to preserve, rebase with the `--preserve-merges` option passed
  to `git rebase` so that locally created merge commits will not be flattened.
  +
 diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
 index d713951b86a..c5a77599c47 100644
 --- a/Documentation/git-rebase.txt
 +++ b/Documentation/git-rebase.txt
 @@ -373,6 +373,17 @@ The commit list format can be changed by setting the configuration option
  rebase.instructionFormat.  A customized instruction format will automatically
  have the long commit hash prepended to the format.
  
 +--recreate-merges[=(rebase-cousins|no-rebase-cousins)]::
 +	Recreate merge commits instead of flattening the history by replaying
 +	merges. Merge conflict resolutions or manual amendments to merge
 +	commits are not recreated automatically, but have to be recreated
 +	manually.
 ++
 +By default, or when `no-rebase-cousins` was specified, commits which do not
 +have `<upstream>` as direct ancestor keep their original branch point.
 +If the `rebase-cousins` mode is turned on, such commits are rebased onto
 +`<upstream>` (or `<onto>`, if specified).
 +
  -p::
  --preserve-merges::
  	Recreate merge commits instead of flattening the history by replaying
 @@ -775,7 +786,8 @@ BUGS
  The todo list presented by `--preserve-merges --interactive` does not
  represent the topology of the revision graph.  Editing commits and
  rewording their commit messages should work fine, but attempts to
 -reorder commits tend to produce counterintuitive results.
 +reorder commits tend to produce counterintuitive results. Use
 +--recreate-merges for a more faithful representation.
  
  For example, an attempt to rearrange
  ------------
 diff --git a/builtin/pull.c b/builtin/pull.c
 index 1876271af94..9da2cfa0bd3 100644
 --- a/builtin/pull.c
 +++ b/builtin/pull.c
 @@ -27,14 +27,16 @@ enum rebase_type {
  	REBASE_FALSE = 0,
  	REBASE_TRUE,
  	REBASE_PRESERVE,
 +	REBASE_RECREATE,
  	REBASE_INTERACTIVE
  };
  
  /**
   * Parses the value of --rebase. If value is a false value, returns
   * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
 - * "preserve", returns REBASE_PRESERVE. If value is a invalid value, dies with
 - * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
 + * "recreate", returns REBASE_RECREATE. If value is "preserve", returns
 + * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
 + * fatal is true, otherwise returns REBASE_INVALID.
   */
  static enum rebase_type parse_config_rebase(const char *key, const char *value,
  		int fatal)
 @@ -47,6 +49,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
  		return REBASE_TRUE;
  	else if (!strcmp(value, "preserve"))
  		return REBASE_PRESERVE;
 +	else if (!strcmp(value, "recreate"))
 +		return REBASE_RECREATE;
  	else if (!strcmp(value, "interactive"))
  		return REBASE_INTERACTIVE;
  
 @@ -130,7 +134,7 @@ static struct option pull_options[] = {
  	/* Options passed to git-merge or git-rebase */
  	OPT_GROUP(N_("Options related to merging")),
  	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
 -	  "false|true|preserve|interactive",
 +	  "false|true|recreate|preserve|interactive",
  	  N_("incorporate changes by rebasing rather than merging"),
  	  PARSE_OPT_OPTARG, parse_opt_rebase },
  	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 @@ -800,7 +804,9 @@ static int run_rebase(const struct object_id *curr_head,
  	argv_push_verbosity(&args);
  
  	/* Options passed to git-rebase */
 -	if (opt_rebase == REBASE_PRESERVE)
 +	if (opt_rebase == REBASE_RECREATE)
 +		argv_array_push(&args, "--recreate-merges");
 +	else if (opt_rebase == REBASE_PRESERVE)
  		argv_array_push(&args, "--preserve-merges");
  	else if (opt_rebase == REBASE_INTERACTIVE)
  		argv_array_push(&args, "--interactive");
 diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
 index ad074705bb5..5d1f12de57b 100644
 --- a/builtin/rebase--helper.c
 +++ b/builtin/rebase--helper.c
 @@ -12,8 +12,8 @@ static const char * const builtin_rebase_helper_usage[] = {
  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  {
  	struct replay_opts opts = REPLAY_OPTS_INIT;
 -	unsigned flags = 0, keep_empty = 0;
 -	int abbreviate_commands = 0;
 +	unsigned flags = 0, keep_empty = 0, recreate_merges = 0;
 +	int abbreviate_commands = 0, rebase_cousins = -1;
  	enum {
  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
  		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
 @@ -24,6 +24,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
  		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
  			N_("allow commits with empty messages")),
 +		OPT_BOOL(0, "recreate-merges", &recreate_merges, N_("recreate merge commits")),
 +		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 +			 N_("keep original branch points of cousins")),
  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
  				CONTINUE),
  		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
 @@ -57,8 +60,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  
  	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
  	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 +	flags |= recreate_merges ? TODO_LIST_RECREATE_MERGES : 0;
 +	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
  	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
  
 +	if (rebase_cousins >= 0 && !recreate_merges)
 +		warning(_("--[no-]rebase-cousins has no effect without "
 +			  "--recreate-merges"));
 +
  	if (command == CONTINUE && argc == 1)
  		return !!sequencer_continue(&opts);
  	if (command == ABORT && argc == 1)
 diff --git a/builtin/remote.c b/builtin/remote.c
 index d95bf904c3b..b7d0f7ce596 100644
 --- a/builtin/remote.c
 +++ b/builtin/remote.c
 @@ -306,6 +306,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
  				info->rebase = v;
  			else if (!strcmp(value, "preserve"))
  				info->rebase = NORMAL_REBASE;
 +			else if (!strcmp(value, "recreate"))
 +				info->rebase = NORMAL_REBASE;
  			else if (!strcmp(value, "interactive"))
  				info->rebase = INTERACTIVE_REBASE;
  		}
 diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
 index 88813e91244..3d44cb6890c 100644
 --- a/contrib/completion/git-completion.bash
 +++ b/contrib/completion/git-completion.bash
 @@ -2008,7 +2008,7 @@ _git_rebase ()
  	--*)
  		__gitcomp "
  			--onto --merge --strategy --interactive
 -			--preserve-merges --stat --no-stat
 +			--recreate-merges --preserve-merges --stat --no-stat
  			--committer-date-is-author-date --ignore-date
  			--ignore-whitespace --whitespace=
  			--autosquash --no-autosquash
 @@ -2182,7 +2182,7 @@ _git_config ()
  		return
  		;;
  	branch.*.rebase)
 -		__gitcomp "false true preserve interactive"
 +		__gitcomp "false true recreate preserve interactive"
  		return
  		;;
  	remote.pushdefault)
 diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
 index a2659fea982..679d79e0d17 100644
 --- a/git-rebase--interactive.sh
 +++ b/git-rebase--interactive.sh
 @@ -162,6 +162,12 @@ s, squash <commit> = use commit, but meld into previous commit
  f, fixup <commit> = like \"squash\", but discard this commit's log message
  x, exec <commit> = run command (the rest of the line) using shell
  d, drop <commit> = remove commit
 +l, label <label> = label current HEAD with a name
 +t, reset <label> = reset HEAD to a label
 +m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
 +.       create a merge commit using the original merge commit's
 +.       message (or the oneline, if no original merge commit was
 +.       specified). Use -c <commit> to reword the commit message.
  
  These lines can be re-ordered; they are executed from top to bottom.
  " | git stripspace --comment-lines >>"$todo"
 @@ -900,6 +906,8 @@ fi
  if test t != "$preserve_merges"
  then
  	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 +		${recreate_merges:+--recreate-merges} \
 +		${rebase_cousins:+--rebase-cousins} \
  		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
  	die "$(gettext "Could not generate todo list")"
  else
 diff --git a/git-rebase.sh b/git-rebase.sh
 index b353c33d417..9487e543bec 100755
 --- a/git-rebase.sh
 +++ b/git-rebase.sh
 @@ -17,6 +17,7 @@ q,quiet!           be quiet. implies --no-stat
  autostash          automatically stash/stash pop before and after
  fork-point         use 'merge-base --fork-point' to refine upstream
  onto=!             rebase onto given branch instead of upstream
 +recreate-merges?   try to recreate merges instead of skipping them
  p,preserve-merges! try to recreate merges instead of ignoring them
  s,strategy=!       use the given merge strategy
  no-ff!             cherry-pick all commits, even if unchanged
 @@ -87,6 +88,8 @@ type=
  state_dir=
  # One of {'', continue, skip, abort}, as parsed from command line
  action=
 +recreate_merges=
 +rebase_cousins=
  preserve_merges=
  autosquash=
  keep_empty=
 @@ -267,6 +270,19 @@ do
  	--allow-empty-message)
  		allow_empty_message=--allow-empty-message
  		;;
 +	--recreate-merges)
 +		recreate_merges=t
 +		test -z "$interactive_rebase" && interactive_rebase=implied
 +		;;
 +	--recreate-merges=*)
 +		recreate_merges=t
 +		case "${1#*=}" in
 +		rebase-cousins) rebase_cousins=t;;
 +		no-rebase-cousins) rebase_cousins=;;
 +		*) die "Unknown mode: $1";;
 +		esac
 +		test -z "$interactive_rebase" && interactive_rebase=implied
 +		;;
  	--preserve-merges)
  		preserve_merges=t
  		test -z "$interactive_rebase" && interactive_rebase=implied
 diff --git a/refs.c b/refs.c
 index 20ba82b4343..e8b84c189ff 100644
 --- a/refs.c
 +++ b/refs.c
 @@ -600,7 +600,8 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
  static int is_per_worktree_ref(const char *refname)
  {
  	return !strcmp(refname, "HEAD") ||
 -		starts_with(refname, "refs/bisect/");
 +		starts_with(refname, "refs/bisect/") ||
 +		starts_with(refname, "refs/rewritten/");
  }
  
  static int is_pseudoref_syntax(const char *refname)
 diff --git a/sequencer.c b/sequencer.c
 index cfa01d3bdd2..b2bf63029d4 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -23,6 +23,10 @@
  #include "hashmap.h"
  #include "notes-utils.h"
  #include "sigchain.h"
 +#include "unpack-trees.h"
 +#include "worktree.h"
 +#include "oidmap.h"
 +#include "oidset.h"
  
  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
  
 @@ -120,6 +124,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
  	"rebase-merge/rewritten-pending")
 +
 +/*
 + * The path of the file listing refs that need to be deleted after the rebase
 + * finishes. This is used by the `label` command to record the need for cleanup.
 + */
 +static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
 +
  /*
   * The following files are written by git-rebase just after parsing the
   * command-line (and are only consumed, not modified, by the sequencer).
 @@ -244,18 +255,33 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
  
  int sequencer_remove_state(struct replay_opts *opts)
  {
 -	struct strbuf dir = STRBUF_INIT;
 +	struct strbuf buf = STRBUF_INIT;
  	int i;
  
 +	if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
 +		char *p = buf.buf;
 +		while (*p) {
 +			char *eol = strchr(p, '\n');
 +			if (eol)
 +				*eol = '\0';
 +			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0)
 +				warning(_("could not delete '%s'"), p);
 +			if (!eol)
 +				break;
 +			p = eol + 1;
 +		}
 +	}
 +
  	free(opts->gpg_sign);
  	free(opts->strategy);
  	for (i = 0; i < opts->xopts_nr; i++)
  		free(opts->xopts[i]);
  	free(opts->xopts);
  
 -	strbuf_addstr(&dir, get_dir(opts));
 -	remove_dir_recursively(&dir, 0);
 -	strbuf_release(&dir);
 +	strbuf_reset(&buf);
 +	strbuf_addstr(&buf, get_dir(opts));
 +	remove_dir_recursively(&buf, 0);
 +	strbuf_release(&buf);
  
  	return 0;
  }
 @@ -1280,6 +1306,10 @@ enum todo_command {
  	TODO_SQUASH,
  	/* commands that do something else than handling a single commit */
  	TODO_EXEC,
 +	TODO_LABEL,
 +	TODO_RESET,
 +	TODO_MERGE,
 +	TODO_MERGE_AND_EDIT,
  	/* commands that do nothing but are counted for reporting progress */
  	TODO_NOOP,
  	TODO_DROP,
 @@ -1298,6 +1328,10 @@ static struct {
  	{ 'f', "fixup" },
  	{ 's', "squash" },
  	{ 'x', "exec" },
 +	{ 'l', "label" },
 +	{ 't', "reset" },
 +	{ 'm', "merge" },
 +	{ 0, "merge" }, /* MERGE_AND_EDIT */
  	{ 0,   "noop" },
  	{ 'd', "drop" },
  	{ 0,   NULL }
 @@ -1803,13 +1837,29 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  		return error(_("missing arguments for %s"),
  			     command_to_string(item->command));
  
 -	if (item->command == TODO_EXEC) {
 +	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
 +	    item->command == TODO_RESET) {
  		item->commit = NULL;
  		item->arg = bol;
  		item->arg_len = (int)(eol - bol);
  		return 0;
  	}
  
 +	if (item->command == TODO_MERGE) {
 +		if (skip_prefix(bol, "-C", &bol))
 +			bol += strspn(bol, " \t");
 +		else if (skip_prefix(bol, "-c", &bol)) {
 +			bol += strspn(bol, " \t");
 +			item->command = TODO_MERGE_AND_EDIT;
 +		} else {
 +			item->command = TODO_MERGE_AND_EDIT;
 +			item->commit = NULL;
 +			item->arg = bol;
 +			item->arg_len = (int)(eol - bol);
 +			return 0;
 +		}
 +	}
 +
  	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
  	saved = *end_of_object_name;
  	*end_of_object_name = '\0';
 @@ -2444,6 +2494,304 @@ static int do_exec(const char *command_line)
  	return status;
  }
  
 +static int safe_append(const char *filename, const char *fmt, ...)
 +{
 +	va_list ap;
 +	struct lock_file lock = LOCK_INIT;
 +	int fd = hold_lock_file_for_update(&lock, filename,
 +					   LOCK_REPORT_ON_ERROR);
 +	struct strbuf buf = STRBUF_INIT;
 +
 +	if (fd < 0)
 +		return -1;
 +
 +	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
 +		return error_errno(_("could not read '%s'"), filename);
 +	strbuf_complete(&buf, '\n');
 +	va_start(ap, fmt);
 +	strbuf_vaddf(&buf, fmt, ap);
 +	va_end(ap);
 +
 +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 +		error_errno(_("could not write to '%s'"), filename);
 +		strbuf_release(&buf);
 +		rollback_lock_file(&lock);
 +		return -1;
 +	}
 +	if (commit_lock_file(&lock) < 0) {
 +		strbuf_release(&buf);
 +		rollback_lock_file(&lock);
 +		return error(_("failed to finalize '%s'"), filename);
 +	}
 +
 +	strbuf_release(&buf);
 +	return 0;
 +}
 +
 +static int do_label(const char *name, int len)
 +{
 +	struct ref_store *refs = get_main_ref_store();
 +	struct ref_transaction *transaction;
 +	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
 +	struct strbuf msg = STRBUF_INIT;
 +	int ret = 0;
 +	struct object_id head_oid;
 +
 +	if (len == 1 && *name == '#')
 +		return error("Illegal label name: '%.*s'", len, name);
 +
 +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 +	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
 +
 +	transaction = ref_store_transaction_begin(refs, &err);
 +	if (!transaction) {
 +		error("%s", err.buf);
 +		ret = -1;
 +	} else if (get_oid("HEAD", &head_oid)) {
 +		error(_("could not read HEAD"));
 +		ret = -1;
 +	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
 +					  NULL, 0, msg.buf, &err) < 0 ||
 +		   ref_transaction_commit(transaction, &err)) {
 +		error("%s", err.buf);
 +		ret = -1;
 +	}
 +	ref_transaction_free(transaction);
 +	strbuf_release(&err);
 +	strbuf_release(&msg);
 +
 +	if (!ret)
 +		ret = safe_append(rebase_path_refs_to_delete(),
 +				  "%s\n", ref_name.buf);
 +	strbuf_release(&ref_name);
 +
 +	return ret;
 +}
 +
 +static int do_reset(const char *name, int len, struct replay_opts *opts)
 +{
 +	struct strbuf ref_name = STRBUF_INIT;
 +	struct object_id oid;
 +	struct lock_file lock = LOCK_INIT;
 +	struct tree_desc desc;
 +	struct tree *tree;
 +	struct unpack_trees_options unpack_tree_opts;
 +	int ret = 0, i;
 +
 +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 +		return -1;
 +
 +	/* Determine the length of the label */
 +	for (i = 0; i < len; i++)
 +		if (isspace(name[i]))
 +			len = i;
 +
 +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 +	if (get_oid(ref_name.buf, &oid) &&
 +	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
 +		error(_("could not read '%s'"), ref_name.buf);
 +		rollback_lock_file(&lock);
 +		strbuf_release(&ref_name);
 +		return -1;
 +	}
 +
 +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 +	unpack_tree_opts.head_idx = 1;
 +	unpack_tree_opts.src_index = &the_index;
 +	unpack_tree_opts.dst_index = &the_index;
 +	unpack_tree_opts.fn = oneway_merge;
 +	unpack_tree_opts.merge = 1;
 +	unpack_tree_opts.update = 1;
 +	unpack_tree_opts.reset = 1;
 +
 +	if (read_cache_unmerged()) {
 +		rollback_lock_file(&lock);
 +		strbuf_release(&ref_name);
 +		return error_resolve_conflict(_(action_name(opts)));
 +	}
 +
 +	if (!fill_tree_descriptor(&desc, &oid)) {
 +		error(_("failed to find tree of %s"), oid_to_hex(&oid));
 +		rollback_lock_file(&lock);
 +		free((void *)desc.buffer);
 +		strbuf_release(&ref_name);
 +		return -1;
 +	}
 +
 +	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
 +		rollback_lock_file(&lock);
 +		free((void *)desc.buffer);
 +		strbuf_release(&ref_name);
 +		return -1;
 +	}
 +
 +	tree = parse_tree_indirect(&oid);
 +	prime_cache_tree(&the_index, tree);
 +
 +	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
 +		ret = error(_("could not write index"));
 +	free((void *)desc.buffer);
 +
 +	if (!ret) {
 +		struct strbuf msg = STRBUF_INIT;
 +
 +		strbuf_addf(&msg, "(rebase -i) reset '%.*s'", len, name);
 +		ret = update_ref(msg.buf, "HEAD", &oid, NULL, 0,
 +				 UPDATE_REFS_MSG_ON_ERR);
 +		strbuf_release(&msg);
 +	}
 +
 +	strbuf_release(&ref_name);
 +	return ret;
 +}
 +
 +static int do_merge(struct commit *commit, const char *arg, int arg_len,
 +		    int run_commit_flags, struct replay_opts *opts)
 +{
 +	int merge_arg_len;
 +	struct strbuf ref_name = STRBUF_INIT;
 +	struct commit *head_commit, *merge_commit, *i;
 +	struct commit_list *common, *j, *reversed = NULL;
 +	struct merge_options o;
 +	int can_fast_forward, ret;
 +	static struct lock_file lock;
 +
 +	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
 +		if (isspace(arg[merge_arg_len]))
 +			break;
 +
 +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 +		return -1;
 +
 +	head_commit = lookup_commit_reference_by_name("HEAD");
 +	if (!head_commit) {
 +		rollback_lock_file(&lock);
 +		return error(_("cannot merge without a current revision"));
 +	}
 +
 +	if (commit) {
 +		const char *message = get_commit_buffer(commit, NULL);
 +		const char *body;
 +		int len;
 +
 +		if (!message) {
 +			rollback_lock_file(&lock);
 +			return error(_("could not get commit message of '%s'"),
 +				     oid_to_hex(&commit->object.oid));
 +		}
 +		write_author_script(message);
 +		find_commit_subject(message, &body);
 +		len = strlen(body);
 +		if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
 +			error_errno(_("could not write '%s'"),
 +				    git_path_merge_msg());
 +			unuse_commit_buffer(commit, message);
 +			rollback_lock_file(&lock);
 +			return -1;
 +		}
 +		unuse_commit_buffer(commit, message);
 +	} else {
 +		const char *p = arg + merge_arg_len;
 +		struct strbuf buf = STRBUF_INIT;
 +		int len;
 +
 +		strbuf_addf(&buf, "author %s", git_author_info(0));
 +		write_author_script(buf.buf);
 +		strbuf_reset(&buf);
 +
 +		p += strspn(p, " \t");
 +		if (*p == '#' && isspace(p[1]))
 +			p += 1 + strspn(p + 1, " \t");
 +		if (*p)
 +			len = strlen(p);
 +		else {
 +			strbuf_addf(&buf, "Merge branch '%.*s'",
 +				    merge_arg_len, arg);
 +			p = buf.buf;
 +			len = buf.len;
 +		}
 +
 +		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
 +			error_errno(_("could not write '%s'"),
 +				    git_path_merge_msg());
 +			strbuf_release(&buf);
 +			rollback_lock_file(&lock);
 +			return -1;
 +		}
 +		strbuf_release(&buf);
 +	}
 +
 +	/*
 +	 * If HEAD is not identical to the parent of the original merge commit,
 +	 * we cannot fast-forward.
 +	 */
 +	can_fast_forward = opts->allow_ff && commit && commit->parents &&
 +		!oidcmp(&commit->parents->item->object.oid,
 +			&head_commit->object.oid);
 +
 +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 +	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 +	if (!merge_commit) {
 +		/* fall back to non-rewritten ref or commit */
 +		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
 +		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 +	}
 +	if (!merge_commit) {
 +		error(_("could not resolve '%s'"), ref_name.buf);
 +		strbuf_release(&ref_name);
 +		rollback_lock_file(&lock);
 +		return -1;
 +	}
 +
 +	if (can_fast_forward && commit->parents->next &&
 +	    !commit->parents->next->next &&
 +	    !oidcmp(&commit->parents->next->item->object.oid,
 +		    &merge_commit->object.oid)) {
 +		strbuf_release(&ref_name);
 +		rollback_lock_file(&lock);
 +		return fast_forward_to(&commit->object.oid,
 +				       &head_commit->object.oid, 0, opts);
 +	}
 +
 +	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 +		      git_path_merge_head(), 0);
 +	write_message("no-ff", 5, git_path_merge_mode(), 0);
 +
 +	common = get_merge_bases(head_commit, merge_commit);
 +	for (j = common; j; j = j->next)
 +		commit_list_insert(j->item, &reversed);
 +	free_commit_list(common);
 +
 +	read_cache();
 +	init_merge_options(&o);
 +	o.branch1 = "HEAD";
 +	o.branch2 = ref_name.buf;
 +	o.buffer_output = 2;
 +
 +	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
 +	if (ret <= 0)
 +		fputs(o.obuf.buf, stdout);
 +	strbuf_release(&o.obuf);
 +	if (ret < 0) {
 +		strbuf_release(&ref_name);
 +		rollback_lock_file(&lock);
 +		return error(_("conflicts while merging '%.*s'"),
 +			     merge_arg_len, arg);
 +	}
 +
 +	if (active_cache_changed &&
 +	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
 +		strbuf_release(&ref_name);
 +		return error(_("merge: Unable to write new index file"));
 +	}
 +	rollback_lock_file(&lock);
 +
 +	ret = run_git_commit(git_path_merge_msg(), opts, run_commit_flags);
 +	strbuf_release(&ref_name);
 +
 +	return ret;
 +}
 +
  static int is_final_fixup(struct todo_list *todo_list)
  {
  	int i = todo_list->current;
 @@ -2627,6 +2975,18 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  				/* `current` will be incremented below */
  				todo_list->current = -1;
  			}
 +		} else if (item->command == TODO_LABEL)
 +			res = do_label(item->arg, item->arg_len);
 +		else if (item->command == TODO_RESET)
 +			res = do_reset(item->arg, item->arg_len, opts);
 +		else if (item->command == TODO_MERGE ||
 +			 item->command == TODO_MERGE_AND_EDIT) {
 +			res = do_merge(item->commit, item->arg, item->arg_len,
 +				       item->command == TODO_MERGE_AND_EDIT ?
 +				       EDIT_MSG | VERIFY_MSG : 0, opts);
 +			if (item->commit)
 +				record_in_rewritten(&item->commit->object.oid,
 +						    peek_command(todo_list, 1));
  		} else if (!is_noop(item->command))
  			return error(_("unknown command %d"), item->command);
  
 @@ -2981,6 +3341,345 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
  	strbuf_release(&sob);
  }
  
 +struct labels_entry {
 +	struct hashmap_entry entry;
 +	char label[FLEX_ARRAY];
 +};
 +
 +static int labels_cmp(const void *fndata, const struct labels_entry *a,
 +		      const struct labels_entry *b, const void *key)
 +{
 +	return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
 +}
 +
 +struct string_entry {
 +	struct oidmap_entry entry;
 +	char string[FLEX_ARRAY];
 +};
 +
 +struct label_state {
 +	struct oidmap commit2label;
 +	struct hashmap labels;
 +	struct strbuf buf;
 +};
 +
 +static const char *label_oid(struct object_id *oid, const char *label,
 +			     struct label_state *state)
 +{
 +	struct labels_entry *labels_entry;
 +	struct string_entry *string_entry;
 +	struct object_id dummy;
 +	size_t len;
 +	int i;
 +
 +	string_entry = oidmap_get(&state->commit2label, oid);
 +	if (string_entry)
 +		return string_entry->string;
 +
 +	/*
 +	 * For "uninteresting" commits, i.e. commits that are not to be
 +	 * rebased, and which can therefore not be labeled, we use a unique
 +	 * abbreviation of the commit name. This is slightly more complicated
 +	 * than calling find_unique_abbrev() because we also need to make
 +	 * sure that the abbreviation does not conflict with any other
 +	 * label.
 +	 *
 +	 * We disallow "interesting" commits to be labeled by a string that
 +	 * is a valid full-length hash, to ensure that we always can find an
 +	 * abbreviation for any uninteresting commit's names that does not
 +	 * clash with any other label.
 +	 */
 +	if (!label) {
 +		char *p;
 +
 +		strbuf_reset(&state->buf);
 +		strbuf_grow(&state->buf, GIT_SHA1_HEXSZ);
 +		label = p = state->buf.buf;
 +
 +		find_unique_abbrev_r(p, oid->hash, default_abbrev);
 +
 +		/*
 +		 * We may need to extend the abbreviated hash so that there is
 +		 * no conflicting label.
 +		 */
 +		if (hashmap_get_from_hash(&state->labels, strihash(p), p)) {
 +			size_t i = strlen(p) + 1;
 +
 +			oid_to_hex_r(p, oid);
 +			for (; i < GIT_SHA1_HEXSZ; i++) {
 +				char save = p[i];
 +				p[i] = '\0';
 +				if (!hashmap_get_from_hash(&state->labels,
 +							   strihash(p), p))
 +					break;
 +				p[i] = save;
 +			}
 +		}
 +	} else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
 +		    !get_oid_hex(label, &dummy)) ||
 +		   (len == 1 && *label == '#') ||
 +		   hashmap_get_from_hash(&state->labels,
 +					 strihash(label), label)) {
 +		/*
 +		 * If the label already exists, or if the label is a valid full
 +		 * OID, or the label is a '#' (which we use as a separator
 +		 * between merge heads and oneline), we append a dash and a
 +		 * number to make it unique.
 +		 */
 +		struct strbuf *buf = &state->buf;
 +
 +		strbuf_reset(buf);
 +		strbuf_add(buf, label, len);
 +
 +		for (i = 2; ; i++) {
 +			strbuf_setlen(buf, len);
 +			strbuf_addf(buf, "-%d", i);
 +			if (!hashmap_get_from_hash(&state->labels,
 +						   strihash(buf->buf),
 +						   buf->buf))
 +				break;
 +		}
 +
 +		label = buf->buf;
 +	}
 +
 +	FLEX_ALLOC_STR(labels_entry, label, label);
 +	hashmap_entry_init(labels_entry, strihash(label));
 +	hashmap_add(&state->labels, labels_entry);
 +
 +	FLEX_ALLOC_STR(string_entry, string, label);
 +	oidcpy(&string_entry->entry.oid, oid);
 +	oidmap_put(&state->commit2label, string_entry);
 +
 +	return string_entry->string;
 +}
 +
 +static int make_script_with_merges(struct pretty_print_context *pp,
 +				   struct rev_info *revs, FILE *out,
 +				   unsigned flags)
 +{
 +	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 +	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 +	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 +	struct strbuf label = STRBUF_INIT;
 +	struct commit_list *commits = NULL, **tail = &commits, *iter;
 +	struct commit_list *tips = NULL, **tips_tail = &tips;
 +	struct commit *commit;
 +	struct oidmap commit2todo = OIDMAP_INIT;
 +	struct string_entry *entry;
 +	struct oidset interesting = OIDSET_INIT, child_seen = OIDSET_INIT,
 +		shown = OIDSET_INIT;
 +	struct label_state state = { OIDMAP_INIT, { NULL }, STRBUF_INIT };
 +
 +	int abbr = flags & TODO_LIST_ABBREVIATE_CMDS;
 +	const char *cmd_pick = abbr ? "p" : "pick",
 +		*cmd_label = abbr ? "l" : "label",
 +		*cmd_reset = abbr ? "t" : "reset",
 +		*cmd_merge = abbr ? "m" : "merge";
 +
 +	oidmap_init(&commit2todo, 0);
 +	oidmap_init(&state.commit2label, 0);
 +	hashmap_init(&state.labels, (hashmap_cmp_fn) labels_cmp, NULL, 0);
 +	strbuf_init(&state.buf, 32);
 +
 +	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
 +		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
 +		FLEX_ALLOC_STR(entry, string, "onto");
 +		oidcpy(&entry->entry.oid, oid);
 +		oidmap_put(&state.commit2label, entry);
 +	}
 +
 +	/*
 +	 * First phase:
 +	 * - get onelines for all commits
 +	 * - gather all branch tips (i.e. 2nd or later parents of merges)
 +	 * - label all branch tips
 +	 */
 +	while ((commit = get_revision(revs))) {
 +		struct commit_list *to_merge;
 +		int is_octopus;
 +		const char *p1, *p2;
 +		struct object_id *oid;
 +
 +		tail = &commit_list_insert(commit, tail)->next;
 +		oidset_insert(&interesting, &commit->object.oid);
 +
 +		if ((commit->object.flags & PATCHSAME))
 +			continue;
 +
 +		strbuf_reset(&oneline);
 +		pretty_print_commit(pp, commit, &oneline);
 +
 +		to_merge = commit->parents ? commit->parents->next : NULL;
 +		if (!to_merge) {
 +			/* non-merge commit: easy case */
 +			strbuf_reset(&buf);
 +			if (!keep_empty && is_original_commit_empty(commit))
 +				strbuf_addf(&buf, "%c ", comment_line_char);
 +			strbuf_addf(&buf, "%s %s %s", cmd_pick,
 +				    oid_to_hex(&commit->object.oid),
 +				    oneline.buf);
 +
 +			FLEX_ALLOC_STR(entry, string, buf.buf);
 +			oidcpy(&entry->entry.oid, &commit->object.oid);
 +			oidmap_put(&commit2todo, entry);
 +
 +			continue;
 +		}
 +
 +		is_octopus = to_merge && to_merge->next;
 +
 +		if (is_octopus)
 +			BUG("Octopus merges not yet supported");
 +
 +		/* Create a label */
 +		strbuf_reset(&label);
 +		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
 +		    (p1 = strchr(p1, '\'')) &&
 +		    (p2 = strchr(++p1, '\'')))
 +			strbuf_add(&label, p1, p2 - p1);
 +		else if (skip_prefix(oneline.buf, "Merge pull request ",
 +				     &p1) &&
 +			 (p1 = strstr(p1, " from ")))
 +			strbuf_addstr(&label, p1 + strlen(" from "));
 +		else
 +			strbuf_addbuf(&label, &oneline);
 +
 +		for (p1 = label.buf; *p1; p1++)
 +			if (isspace(*p1))
 +				*(char *)p1 = '-';
 +
 +		strbuf_reset(&buf);
 +		strbuf_addf(&buf, "%s -C %s",
 +			    cmd_merge, oid_to_hex(&commit->object.oid));
 +
 +		/* label the tip of merged branch */
 +		oid = &to_merge->item->object.oid;
 +		strbuf_addch(&buf, ' ');
 +
 +		if (!oidset_contains(&interesting, oid))
 +			strbuf_addstr(&buf, label_oid(oid, NULL, &state));
 +		else {
 +			tips_tail = &commit_list_insert(to_merge->item,
 +							tips_tail)->next;
 +
 +			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
 +		}
 +		strbuf_addf(&buf, " # %s", oneline.buf);
 +
 +		FLEX_ALLOC_STR(entry, string, buf.buf);
 +		oidcpy(&entry->entry.oid, &commit->object.oid);
 +		oidmap_put(&commit2todo, entry);
 +	}
 +
 +	/*
 +	 * Second phase:
 +	 * - label branch points
 +	 * - add HEAD to the branch tips
 +	 */
 +	for (iter = commits; iter; iter = iter->next) {
 +		struct commit_list *parent = iter->item->parents;
 +		for (; parent; parent = parent->next) {
 +			struct object_id *oid = &parent->item->object.oid;
 +			if (!oidset_contains(&interesting, oid))
 +				continue;
 +			if (!oidset_contains(&child_seen, oid))
 +				oidset_insert(&child_seen, oid);
 +			else
 +				label_oid(oid, "branch-point", &state);
 +		}
 +
 +		/* Add HEAD as implict "tip of branch" */
 +		if (!iter->next)
 +			tips_tail = &commit_list_insert(iter->item,
 +							tips_tail)->next;
 +	}
 +
 +	/*
 +	 * Third phase: output the todo list. This is a bit tricky, as we
 +	 * want to avoid jumping back and forth between revisions. To
 +	 * accomplish that goal, we walk backwards from the branch tips,
 +	 * gathering commits not yet shown, reversing the list on the fly,
 +	 * then outputting that list (labeling revisions as needed).
 +	 */
 +	fprintf(out, "%s onto\n", cmd_label);
 +	for (iter = tips; iter; iter = iter->next) {
 +		struct commit_list *list = NULL, *iter2;
 +
 +		commit = iter->item;
 +		if (oidset_contains(&shown, &commit->object.oid))
 +			continue;
 +		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 +
 +		if (entry)
 +			fprintf(out, "\n# Branch %s\n", entry->string);
 +		else
 +			fprintf(out, "\n");
 +
 +		while (oidset_contains(&interesting, &commit->object.oid) &&
 +		       !oidset_contains(&shown, &commit->object.oid)) {
 +			commit_list_insert(commit, &list);
 +			if (!commit->parents) {
 +				commit = NULL;
 +				break;
 +			}
 +			commit = commit->parents->item;
 +		}
 +
 +		if (!commit)
 +			fprintf(out, "%s onto\n", cmd_reset);
 +		else {
 +			const char *to = NULL;
 +
 +			entry = oidmap_get(&state.commit2label,
 +					   &commit->object.oid);
 +			if (entry)
 +				to = entry->string;
 +			else if (!rebase_cousins)
 +				to = label_oid(&commit->object.oid, NULL,
 +					       &state);
 +
 +			if (!to || !strcmp(to, "onto"))
 +				fprintf(out, "%s onto\n", cmd_reset);
 +			else {
 +				strbuf_reset(&oneline);
 +				pretty_print_commit(pp, commit, &oneline);
 +				fprintf(out, "%s %s # %s\n",
 +					cmd_reset, to, oneline.buf);
 +			}
 +		}
 +
 +		for (iter2 = list; iter2; iter2 = iter2->next) {
 +			struct object_id *oid = &iter2->item->object.oid;
 +			entry = oidmap_get(&commit2todo, oid);
 +			/* only show if not already upstream */
 +			if (entry)
 +				fprintf(out, "%s\n", entry->string);
 +			entry = oidmap_get(&state.commit2label, oid);
 +			if (entry)
 +				fprintf(out, "%s %s\n",
 +					cmd_label, entry->string);
 +			oidset_insert(&shown, oid);
 +		}
 +
 +		free_commit_list(list);
 +	}
 +
 +	free_commit_list(commits);
 +	free_commit_list(tips);
 +
 +	strbuf_release(&label);
 +	strbuf_release(&oneline);
 +	strbuf_release(&buf);
 +
 +	oidmap_free(&commit2todo, 1);
 +	oidmap_free(&state.commit2label, 1);
 +	hashmap_free(&state.labels, 1);
 +	strbuf_release(&state.buf);
 +
 +	return 0;
 +}
 +
  int sequencer_make_script(FILE *out, int argc, const char **argv,
  			  unsigned flags)
  {
 @@ -2991,11 +3690,16 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
  	struct commit *commit;
  	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
  	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 +	int recreate_merges = flags & TODO_LIST_RECREATE_MERGES;
  
  	init_revisions(&revs, NULL);
  	revs.verbose_header = 1;
 -	revs.max_parents = 1;
 -	revs.cherry_pick = 1;
 +	if (recreate_merges)
 +		revs.cherry_mark = 1;
 +	else {
 +		revs.max_parents = 1;
 +		revs.cherry_pick = 1;
 +	}
  	revs.limited = 1;
  	revs.reverse = 1;
  	revs.right_only = 1;
 @@ -3019,6 +3723,9 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
  	if (prepare_revision_walk(&revs) < 0)
  		return error(_("make_script: error preparing revisions"));
  
 +	if (recreate_merges)
 +		return make_script_with_merges(&pp, &revs, out, flags);
 +
  	while ((commit = get_revision(&revs))) {
  		strbuf_reset(&buf);
  		if (!keep_empty && is_original_commit_empty(commit))
 @@ -3108,8 +3815,14 @@ int transform_todos(unsigned flags)
  					  short_commit_name(item->commit) :
  					  oid_to_hex(&item->commit->object.oid);
  
 +			if (item->command == TODO_MERGE)
 +				strbuf_addstr(&buf, " -C");
 +			else if (item->command == TODO_MERGE_AND_EDIT)
 +				strbuf_addstr(&buf, " -c");
 +
  			strbuf_addf(&buf, " %s", oid);
  		}
 +
  		/* add all the rest */
  		if (!item->arg_len)
  			strbuf_addch(&buf, '\n');
 diff --git a/sequencer.h b/sequencer.h
 index e45b178dfc4..739dd0fa92b 100644
 --- a/sequencer.h
 +++ b/sequencer.h
 @@ -59,6 +59,13 @@ int sequencer_remove_state(struct replay_opts *opts);
  #define TODO_LIST_KEEP_EMPTY (1U << 0)
  #define TODO_LIST_SHORTEN_IDS (1U << 1)
  #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 +#define TODO_LIST_RECREATE_MERGES (1U << 3)
 +/*
 + * When recreating merges, commits that do have the base commit as ancestor
 + * ("cousins") are *not* rebased onto the new base by default. If those
 + * commits should be rebased onto the new base, this flag needs to be passed.
 + */
 +#define TODO_LIST_REBASE_COUSINS (1U << 4)
  int sequencer_make_script(FILE *out, int argc, const char **argv,
  			  unsigned flags);
  
 diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
 new file mode 100755
 index 00000000000..9a59f12b670
 --- /dev/null
 +++ b/t/t3430-rebase-recreate-merges.sh
 @@ -0,0 +1,208 @@
 +#!/bin/sh
 +#
 +# Copyright (c) 2017 Johannes E. Schindelin
 +#
 +
 +test_description='git rebase -i --recreate-merges
 +
 +This test runs git rebase "interactively", retaining the branch structure by
 +recreating merge commits.
 +
 +Initial setup:
 +
 +    -- B --                   (first)
 +   /       \
 + A - C - D - E - H            (master)
 +       \       /
 +         F - G                (second)
 +'
 +. ./test-lib.sh
 +. "$TEST_DIRECTORY"/lib-rebase.sh
 +
 +test_expect_success 'setup' '
 +	write_script replace-editor.sh <<-\EOF &&
 +	mv "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
 +	cp script-from-scratch "$1"
 +	EOF
 +
 +	test_commit A &&
 +	git checkout -b first &&
 +	test_commit B &&
 +	git checkout master &&
 +	test_commit C &&
 +	test_commit D &&
 +	git merge --no-commit B &&
 +	test_tick &&
 +	git commit -m E &&
 +	git tag -m E E &&
 +	git checkout -b second C &&
 +	test_commit F &&
 +	test_commit G &&
 +	git checkout master &&
 +	git merge --no-commit G &&
 +	test_tick &&
 +	git commit -m H &&
 +	git tag -m H H
 +'
 +
 +cat >script-from-scratch <<\EOF
 +label onto
 +
 +# onebranch
 +pick G
 +pick D
 +label onebranch
 +
 +# second
 +reset onto
 +pick B
 +label second
 +
 +reset onto
 +merge -C H second
 +merge onebranch # Merge the topic branch 'onebranch'
 +EOF
 +
 +test_cmp_graph () {
 +	cat >expect &&
 +	git log --graph --boundary --format=%s "$@" >output &&
 +	sed "s/ *$//" <output >output.trimmed &&
 +	test_cmp expect output.trimmed
 +}
 +
 +test_expect_success 'create completely different structure' '
 +	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 +	test_tick &&
 +	git rebase -i --recreate-merges A &&
 +	test_cmp_graph <<-\EOF
 +	*   Merge the topic branch '\''onebranch'\''
 +	|\
 +	| * D
 +	| * G
 +	* |   H
 +	|\ \
 +	| |/
 +	|/|
 +	| * B
 +	|/
 +	* A
 +	EOF
 +'
 +
 +test_expect_success 'generate correct todo list' '
 +	cat >expect <<-\EOF &&
 +	label onto
 +
 +	reset onto
 +	pick d9df450 B
 +	label E
 +
 +	reset onto
 +	pick 5dee784 C
 +	label branch-point
 +	pick ca2c861 F
 +	pick 088b00a G
 +	label H
 +
 +	reset branch-point # C
 +	pick 12bd07b D
 +	merge -C 2051b56 E # E
 +	merge -C 233d48a H # H
 +
 +	EOF
 +
 +	grep -v "^#" <.git/ORIGINAL-TODO >output &&
 +	test_cmp expect output
 +'
 +
 +test_expect_success 'with a branch tip that was cherry-picked already' '
 +	git checkout -b already-upstream master &&
 +	base="$(git rev-parse --verify HEAD)" &&
 +
 +	test_commit A1 &&
 +	test_commit A2 &&
 +	git reset --hard $base &&
 +	test_commit B1 &&
 +	test_tick &&
 +	git merge -m "Merge branch A" A2 &&
 +
 +	git checkout -b upstream-with-a2 $base &&
 +	test_tick &&
 +	git cherry-pick A2 &&
 +
 +	git checkout already-upstream &&
 +	test_tick &&
 +	git rebase -i --recreate-merges upstream-with-a2 &&
 +	test_cmp_graph upstream-with-a2.. <<-\EOF
 +	*   Merge branch A
 +	|\
 +	| * A1
 +	* | B1
 +	|/
 +	o A2
 +	EOF
 +'
 +
 +test_expect_success 'do not rebase cousins unless asked for' '
 +	write_script copy-editor.sh <<-\EOF &&
 +	cp "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
 +	EOF
 +
 +	test_config sequence.editor \""$PWD"/copy-editor.sh\" &&
 +	git checkout -b cousins master &&
 +	before="$(git rev-parse --verify HEAD)" &&
 +	test_tick &&
 +	git rebase -i --recreate-merges HEAD^ &&
 +	test_cmp_rev HEAD $before &&
 +	test_tick &&
 +	git rebase -i --recreate-merges=rebase-cousins HEAD^ &&
 +	test_cmp_graph HEAD^.. <<-\EOF
 +	*   Merge the topic branch '\''onebranch'\''
 +	|\
 +	| * D
 +	| * G
 +	|/
 +	o H
 +	EOF
 +'
 +
 +test_expect_success 'refs/rewritten/* is worktree-local' '
 +	git worktree add wt &&
 +	cat >wt/script-from-scratch <<-\EOF &&
 +	label xyz
 +	exec GIT_DIR=../.git git rev-parse --verify refs/rewritten/xyz >a || :
 +	exec git rev-parse --verify refs/rewritten/xyz >b
 +	EOF
 +
 +	test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
 +	git -C wt rebase -i HEAD &&
 +	test_must_be_empty wt/a &&
 +	test_cmp_rev HEAD "$(cat wt/b)"
 +'
 +
 +test_expect_success 'post-rewrite hook and fixups work for merges' '
 +	git checkout -b post-rewrite &&
 +	test_commit same1 &&
 +	git reset --hard HEAD^ &&
 +	test_commit same2 &&
 +	git merge -m "to fix up" same1 &&
 +	echo same old same old >same2.t &&
 +	test_tick &&
 +	git commit --fixup HEAD same2.t &&
 +	fixup="$(git rev-parse HEAD)" &&
 +
 +	mkdir -p .git/hooks &&
 +	test_when_finished "rm .git/hooks/post-rewrite" &&
 +	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
 +
 +	test_tick &&
 +	git rebase -i --autosquash --recreate-merges HEAD^^^ &&
 +	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
 +		$fixup^^2 HEAD^2 \
 +		$fixup^^ HEAD^ \
 +		$fixup^ HEAD \
 +		$fixup HEAD) &&
 +	test_cmp expect actual
 +'
 +
 +test_done
-- 
2.16.1.windows.4

