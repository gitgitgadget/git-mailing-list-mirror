Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FECB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeDYMaC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:30:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:33291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbeDYM3y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:54 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M5IdH-1eT6Jx3fUF-00zVoz; Wed, 25 Apr 2018 14:29:47 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 16/17] rebase -i: introduce --rebase-merges=[no-]rebase-cousins
Date:   Wed, 25 Apr 2018 14:29:40 +0200
Message-Id: <5824b4537d7879f492d3ac908b7a10db8976ad6a.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:IsR7grDfeb+WtUuTZ6kePxwoDMQnT5/zz0RaCBstIloy+gfLi4T
 KmfZ96nbLg5KZEK61QuVOXax+i0sjyyXm6PKlLREqEuV/PZL5AkN0ija8DU5jRU7Hcg6AuE
 BtUsZnTJbGNtelu9PCjLijvbL50TyJLckEBlH8QG0SXYH+PN/ggcOZdAlHLPyMCz/coXrYT
 iQMLQ6yaU6PfwEtYwNC4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7oSXbmPIiXM=:MRde7uDHsGYu5MN5X/IVqw
 9LKFU0O7mhP/21Txj4UWelXPL8Xx6evJmfLJeRCXmyMkWndY7sXjYgNE+dDgF7k/wpOjFBpXH
 xmwAb2HhVl8wGZ2yJoLJcNaT3knfx1i4PPw1SJhXicxHno5JM5vJZnmhWnPaUmo1GNE8LumBJ
 QGF2jIB+6mjA9FM69kPoLCaIF4iRivdcmXxoMqe8jeeS8+rDxL5VF/AOZdDjESika8MfWH7Hl
 yMcY/TmLqkzrzuip01cG2Te5Sk2OGcyoNYO4rEnalJWQ7wuTInBYLZ9OQY+Dg9G7FRtPyjLZz
 cVFN9fHVCtJVjFEZtyi+5mgM0fgzlMc8HILMGrVF5YpW+WuypAciO/7cq/UVNvIEz0ZFHYiA6
 rQv7gsgKpZSziGONjtqyDogGOEfU+fcrE5cB4typVhjc8zrkfw4tBTwO7aTIqDnzl6QTS+wYZ
 DebipC5A4wkkGwhkc2kS5d7Hqn9+JKpY6WXzwipIOsI/Ss6P9TyT7N5dE0m3cavvwFy38zfFo
 DHJB1ML61+gUTQmy0BUatZPekCx+tuKaLXghCyXZUcCWIOzqbVYSmuIvmWyXllgQzb2zXxUdY
 6srqg1xg5m6uf7YrX1WPbRUUfj+Ym1Yim3vcRwo6Vm3fr36246O4iLGhrzJGc7Qwn5Ca6IrJd
 /tZqkko6vOnGhH3/29NDvxzMtKg8GZXFIld2EVoSNhVcnXBmCj3RezkJmcEoTG9YtywLCAXJF
 ie952OQo9u9bKGlDCs++LHD9o3kZRJiG77hRo3kPBzA8236FHfXyzMaJThLLAjAw8GpSuLW5m
 Y4EptKtva9ReDJGSYIKsykApdtF653xdRXeiDVy0h2y30FwxytzAAPRy/4o3vn8hWkCMHJ9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running `git rebase --rebase-merges` non-interactively with an
ancestor of HEAD as <upstream> (or leaving the todo list unmodified),
we would ideally recreate the exact same commits as before the rebase.

However, if there are commits in the commit range <upstream>.. that do not
have <upstream> as direct ancestor (i.e. if `git log <upstream>..` would
show commits that are omitted by `git log --ancestry-path <upstream>..`),
this is currently not the case: we would turn them into commits that have
<upstream> as direct ancestor.

Let's illustrate that with a diagram:

        C
      /   \
A - B - E - F
  \   /
    D

Currently, after running `git rebase -i --rebase-merges B`, the new branch
structure would be (pay particular attention to the commit `D`):

       --- C' --
      /         \
A - B ------ E' - F'
      \    /
        D'

This is not really preserving the branch topology from before! The
reason is that the commit `D` does not have `B` as ancestor, and
therefore it gets rebased onto `B`.

This is unintuitive behavior. Even worse, when recreating branch
structure, most use cases would appear to want cousins *not* to be
rebased onto the new base commit. For example, Git for Windows (the
heaviest user of the Git garden shears, which served as the blueprint
for --rebase-merges) frequently merges branches from `next` early, and
these branches certainly do *not* want to be rebased. In the example
above, the desired outcome would look like this:

       --- C' --
      /         \
A - B ------ E' - F'
  \        /
   -- D' --

Let's introduce the term "cousins" for such commits ("D" in the
example), and let's not rebase them by default. For hypothetical
use cases where cousins *do* need to be rebased, `git rebase
--rebase=merges=rebase-cousins` needs to be used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 15 +++++++++++----
 builtin/rebase--helper.c     |  9 ++++++++-
 git-rebase--interactive.sh   |  1 +
 git-rebase.sh                | 12 +++++++++++-
 sequencer.c                  |  4 ++++
 sequencer.h                  |  6 ++++++
 t/t3430-rebase-merges.sh     | 18 ++++++++++++++++++
 7 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7f1756f1eba..fe681d69281 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -380,7 +380,7 @@ rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
 -r::
---rebase-merges::
+--rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
@@ -389,9 +389,16 @@ have the long commit hash prepended to the format.
 	manual amendments in these merge commits will have to be
 	resolved/re-applied manually.
 +
-This mode is similar in spirit to `--preserve-merges`, but in contrast to
-that option works well in interactive rebases: commits can be reordered,
-inserted and dropped at will.
+By default, or when `no-rebase-cousins` was specified, commits which do not
+have `<upstream>` as direct ancestor will keep their original branch point,
+i.e. commits that would be excluded by gitlink:git-log[1]'s
+`--ancestry-path` option will keep their original ancestry by default. If
+the `rebase-cousins` mode is turned on, such commits are instead rebased
+onto `<upstream>` (or `<onto>`, if specified).
++
+The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
+in contrast to that option works well in interactive rebases: commits can be
+reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 781782e7272..f7c2a5fdc81 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
-	int abbreviate_commands = 0;
+	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
@@ -25,6 +25,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
 			N_("allow commits with empty messages")),
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
+		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
+			 N_("keep original branch points of cousins")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -59,8 +61,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
+	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
+	if (rebase_cousins >= 0 && !rebase_merges)
+		warning(_("--[no-]rebase-cousins has no effect without "
+			  "--rebase-merges"));
+
 	if (command == CONTINUE && argc == 1)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e29da634339..cbf44f86482 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -971,6 +971,7 @@ git_rebase__interactive () {
 
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
+		${rebase_cousins:+--rebase-cousins} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
diff --git a/git-rebase.sh b/git-rebase.sh
index a553f969d11..40be59ecc47 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -17,7 +17,7 @@ q,quiet!           be quiet. implies --no-stat
 autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
-r,rebase-merges!   try to rebase merges instead of skipping them
+r,rebase-merges?   try to rebase merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -91,6 +91,7 @@ state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
 rebase_merges=
+rebase_cousins=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -286,6 +287,15 @@ do
 		rebase_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
+	--rebase-merges=*)
+		rebase_merges=t
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
diff --git a/sequencer.c b/sequencer.c
index afa155c2829..e2f83942843 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3578,6 +3578,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -3755,6 +3756,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 					   &commit->object.oid);
 			if (entry)
 				to = entry->string;
+			else if (!rebase_cousins)
+				to = label_oid(&commit->object.oid, NULL,
+					       &state);
 
 			if (!to || !strcmp(to, "onto"))
 				fprintf(out, "%s onto\n", cmd_reset);
diff --git a/sequencer.h b/sequencer.h
index 6bc4da17243..d9570d92b11 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -60,6 +60,12 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 #define TODO_LIST_REBASE_MERGES (1U << 3)
+/*
+ * When rebasing merges, commits that do have the base commit as ancestor
+ * ("cousins") are *not* rebased onto the new base by default. If those
+ * commits should be rebased onto the new base, this flag needs to be passed.
+ */
+#define TODO_LIST_REBASE_COUSINS (1U << 4)
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 1628c8dcc20..3d4dfdf7bec 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -176,6 +176,24 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success 'do not rebase cousins unless asked for' '
+	git checkout -b cousins master &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase -r HEAD^ &&
+	test_cmp_rev HEAD $before &&
+	test_tick &&
+	git rebase --rebase-merges=rebase-cousins HEAD^ &&
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
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.17.0.windows.1.33.gfcbb1fa0445


