Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49101FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeA2WzW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:55:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:53160 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752007AbeA2WzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:55:19 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LvEZe-1eoRIQ3OuA-010PWT; Mon, 29 Jan 2018 23:55:12 +0100
Date:   Mon, 29 Jan 2018 23:55:12 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 10/10] rebase -i: introduce
 --recreate-merges=[no-]rebase-cousins
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <0fc047807559b6f105494d1fc2bda4a48863835e.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gVRPlbm0eWJxBuzrJPFiBCspVrEwKqBXBTLHrdS79CN2Qp5m8vD
 Z5XNd54bwnMdmlDi10o8gX/XjJb+u33OJQCgLHFTPosGPE0Gtj/ArQAYNEJl1DlWte8cQQm
 eZTlr4gW8zrXLMLQL90NMWTHLYnW6HSFNgBgKjgUULOFPatsz6K5i92Ick8Amfj+8w63DEP
 M02si53rBUE4h7pRR6rxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xAZ59w1xdt4=:qOAhG8i+T2W2ROEGjN0TOA
 s9htn6G1B0adFsXhthZnVk+I9B/8HOGKXdq9xVTz6Bep7Tct8aGYsgQwyU1INjQTGeZ/Ok4od
 jMIK81QAgBR3ZgguWaIhuotJ8OLFb5Jswa71+dgylpzztfbHd0Gt+8K4UFYJC8SQGuB2xP8wn
 /7kOWwLFBBhaNFFbcJqTlBvPeY1Xg+LPA3wbY+2dWOzrDF+5xQ3btx5sOK6kD9E0r5Yu/4iam
 Wpw/7sAVFb/j/eFhCBh9qUZGlC7cI+gvyQMTpc70iQLtrAh5jLqXucnqZSUJbfeJIfAtOZYa7
 CW23AltdFWwJat6N8NrT9Fz8auqiDkBXP6Xyq3NqC5bck6WQoOT9g4XZAhiJQxloc5urig3un
 tuTGyrdGtDzcntcpIE2JDEOhWliFw4OoZexYxAT9Pl013ITo1/BVtO6KuapdM0a0LY6qDnuhq
 3iHj93kVZXcbSrMw91oOoD0yRPbTWxSQmDIiRMbpjEJzS3K3gRu/MndA6GiXnkG8+/vk+I8JJ
 RD6ax+rtZWOBj8ZUHmfvFhvQ3azhxIonfTR+JXUllIoKRvvx7+OOvMEAMbnKAJuS87CQunFzA
 jwaBaQQ5X+L02cuLagNPJX9Q2KQqOf/6mQid9xe3RKxm5Lp7D66Zj2oW8/FIlpzhqXLbcMQsY
 Zi04zhjrxpf+T8+czf76Tq2xoOVngXZtkzePelXdZLP7iWQjlrbBONjyEC++eSWiWg+gkq/qI
 aeT8+RmvVN6lkrmlCQrQwQas2uzz7oDw3vnKjrMA5jP7Q6G/RJrJZdSpFCS8XB7r3AP4l+dpx
 zouInGMQV/yVPKcejAvxcHvUnucPTRqWKlkU+8Q2oX89YjtUHH/pN9bMZrHp/4wqofI8rqL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one is a bit tricky to explain, so let's try with a diagram:

        C
      /   \
A - B - E - F
  \   /
    D

To illustrate what this new mode is all about, let's consider what
happens upon `git rebase -i --recreate-merges B`, in particular to
the commit `D`. So far, the new branch structure would be:

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
for --recreate-merges) frequently merges branches from `next` early, and
these branches certainly do *not* want to be rebased. In the example
above, the desired outcome would look like this:

       --- C' --
      /         \
A - B ------ E' - F'
  \        /
   -- D' --

Let's introduce the term "cousins" for such commits ("D" in the
example), and let's not rebase them by default, introducing the new
"rebase-cousins" mode for use cases where they should be rebased.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt      |  7 ++++++-
 builtin/rebase--helper.c          |  9 ++++++++-
 git-rebase--interactive.sh        |  1 +
 git-rebase.sh                     | 12 +++++++++++-
 sequencer.c                       |  4 ++++
 sequencer.h                       |  6 ++++++
 t/t3430-rebase-recreate-merges.sh | 23 +++++++++++++++++++++++
 7 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e9da7e26329..0e6d020d924 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,11 +368,16 @@ The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
---recreate-merges::
+--recreate-merges[=(rebase-cousins|no-rebase-cousins)]::
 	Recreate merge commits instead of flattening the history by replaying
 	merges. Merge conflict resolutions or manual amendments to merge
 	commits are not recreated automatically, but have to be recreated
 	manually.
++
+By default, or when `no-rebase-cousins` was specified, commits which do not
+have `<upstream>` as direct ancestor keep their original branch point.
+If the `rebase-cousins` mode is turned on, such commits are rebased onto
+`<upstream>` (or `<onto>`, if specified).
 
 -p::
 --preserve-merges::
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index a34ab5c0655..cea99cb3235 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, recreate_merges = 0;
-	int abbreviate_commands = 0;
+	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
@@ -23,6 +23,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
 		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
 		OPT_BOOL(0, "recreate-merges", &recreate_merges, N_("recreate merge commits")),
+		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
+			 N_("keep original branch points of cousins")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -57,8 +59,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= recreate_merges ? TODO_LIST_RECREATE_MERGES : 0;
+	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
+	if (rebase_cousins >= 0 && !recreate_merges)
+		warning(_("--[no-]rebase-cousins has no effect without "
+			  "--recreate-merges"));
+
 	if (command == CONTINUE && argc == 1)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 97b7954f7d3..5e21e4cf269 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -903,6 +903,7 @@ if test t != "$preserve_merges"
 then
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${recreate_merges:+--recreate-merges} \
+		${rebase_cousins:+--rebase-cousins} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 else
diff --git a/git-rebase.sh b/git-rebase.sh
index d69bc7d0e0d..58d778a2da0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -17,7 +17,7 @@ q,quiet!           be quiet. implies --no-stat
 autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
-recreate-merges!   try to recreate merges instead of skipping them
+recreate-merges?   try to recreate merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -88,6 +88,7 @@ state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
 recreate_merges=
+rebase_cousins=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -268,6 +269,15 @@ do
 		recreate_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
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
diff --git a/sequencer.c b/sequencer.c
index 4cc73775394..cd2f2ae5d53 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2906,6 +2906,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -3081,6 +3082,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 					   &commit->object.oid);
 			if (entry)
 				to = entry->string;
+			else if (!rebase_cousins)
+				to = label_oid(&commit->object.oid, NULL,
+					       &state);
 
 			if (!to || !strcmp(to, "onto"))
 				fprintf(out, "%s onto\n", cmd_reset);
diff --git a/sequencer.h b/sequencer.h
index 11d1ac925ef..deebc6e3258 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,12 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 #define TODO_LIST_RECREATE_MERGES (1U << 3)
+/*
+ * When recreating merges, commits that do have the base commit as ancestor
+ * ("cousins") are *not* rebased onto the new base by default. If those
+ * commits should be rebased onto the new base, this flag needs to be passed.
+ */
+#define TODO_LIST_REBASE_COUSINS (1U << 4)
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
index 2eeda0c512b..ab51b584ff9 100755
--- a/t/t3430-rebase-recreate-merges.sh
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -143,6 +143,29 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
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
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.16.1.windows.1
