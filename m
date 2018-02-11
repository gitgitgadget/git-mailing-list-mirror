Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8358E1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeBKAKu (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:52877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbeBKAKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:48 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LqRKT-1fF4Il2djV-00e13E; Sun, 11 Feb 2018 01:10:42 +0100
Date:   Sun, 11 Feb 2018 01:10:41 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 12/12] rebase -i: introduce
 --recreate-merges=[no-]rebase-cousins
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <f80c21efe578a4bae7fed105954b9f738483c994.1518307772.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R7Wodf1k8UW2EZdo2b9AA4z2s37UI66weKMRT9awrGC6gamC+yR
 l1770FSZpqwqPdttC2HJJPVusbdIV1y2NaTq6YyP+PYQHBGy8STgEI1EMkV0K+1cJkN7py6
 pF9K6pTvRS9qkdQEhc3ILvN62KUnidEg1NfwZxWczhI1gOLXZ0G2GnJHAasgi0LcB//tNIx
 22g+DIvqbN1rjEtG1Y9VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r1VY5SQ7EKU=:t1iGK5Yg7kPPMYmoPK/Qvy
 3PbOVsP9OnIbeXuQwAwp7uaHHlc1oa0rO5N4piPBP+M1ihNxGrqT0mS8dWPkNGTAmFDMBpZvc
 1766WOLZyo6aFpTPqrZuTjOyxex+N0ICEXDmtXxbaS53TbbAqXD1ucKDO3HlsJFJ3ZMFLngMv
 QxWXUwO6UBfxgg3kYio2CTYbOKW/gsCp9pjJTfQxgrGHQjiwpC39FxakKq8dLkhvykwQkv1AZ
 4Ipd73DSwUyKQDWe957CZBhjDJdeO+na3VKVps4DqzmQ3zKgv8MFLLUdhdxxkqAM1fNBzn051
 GXJwrK8IsnkM9cXYyqmy5MDk458bTS4jU/DaOSVGPEuNGyvDHpJ3nuf1bRYrZxN5IbtpGwows
 Ow9enFQnd6SxCEQmu8eu2W4lGf16H1S3FYbKHbHcL4JOo855BGaIENn1EMeoWNbnEPX9exTnY
 syf64uLOLgVlE0/0SFeOTzUK7jjxNnYIsLz7z/FoJAmnel8lMY7Q7q1aulKE8TachnWyTLfGv
 PGQfLJ6acfWWdkUSVzGZv3tyZqE6S1o7ipEyldBNjP1ZmbQF4LLonB67ui9t9Gtc7BPBGDZVp
 CkfdiL8B6OaQlFIBqdyBPnOko+TF+1DfGm/IriAsVuC3VSJIFLyb/biqlXaWf4YiHja/Gqx+H
 FbMh9ENwCHdm4snxREWgU9pEjtWJkzPpFlrQEDcSGaVGh1d2CZsV1EpRpaF0cV0JoB3kFlIQh
 ZtYqtdJMwjvMO4vtRcmr4K7GVioL6uJ9oFoGcHJ84HBsClBrBn9lPEOQmvbZKScshmG/ObN/2
 R0ELMrHe4Yrm1qX8fUsT7HqkMHp4Y/7YfzDq2EyQxrrVqmS+vU=
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
index cfe3a537ac2..e199fe1cca5 100644
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
index 306ae014311..c877432d7b4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2931,6 +2931,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -3106,6 +3107,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
index 35a61ce90bb..9a59f12b670 100755
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
