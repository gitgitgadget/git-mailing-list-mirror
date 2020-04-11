Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE5DC2BB1D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531FE2078E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpAx3Vbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDKCof (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:44:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgDKCoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 22:44:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so4226320wrt.6
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 19:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=snKfnh5sl/wLxctOzhOVNO/6NCZr3REKfFixtr0Cmis=;
        b=RpAx3VbtzJpMcwDhcg42WgdKesoywisPSRE8ePLQm1e2ttqqWJV6vBuNgFdAawYO6C
         dLMr6nfSzAmMwtgVXW941XBx2wQ4xZxUIQ9KQZqO1OuKPs6a8ewaFCJ2f/j9AfpZkyrN
         lZYb9tKk7KDH4IhVFpaLfUc6Xy6au3Nq+gKt7e0KAx4tBDnhT/H/QahGBzjEbTpmTwvJ
         z5uUtExJkDfYoZ6jA8SA8dmJL+vGLiFm2f8dMkD2zI+hoqKkQA6vvy4G5k4LSqyqbmza
         LBn4eEquqakaHEh9OwUIRLKYpo4R2SrDpHijpcDnLuk2NAEu2/yhalQvjU1iSHx5PFZa
         y8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=snKfnh5sl/wLxctOzhOVNO/6NCZr3REKfFixtr0Cmis=;
        b=fgyaaA8Ay+Rvc8c1EN8/GH/CtWL25X8Gcy9zsWrzJyQTNO2hobsSlWYw/ag9gAhGAJ
         0A1a3tCH3mwEbHITWUPXBo6ugk+Ho4erinnniJL13s2npOVtdrnaR+W55SqpXZNkaH7U
         7Su0VC0mnigvWRjRWbrONeV2oq1uBh83Y9amG87Tg1OGRiibqUh6zc4+Ijwpg1bJUvop
         ClKvF4rQ/QPFJK9BWidNSLc7OHYWvpTfSwQf6uJhLadVeYOU4f65k2GLKJiu4dFhyxoI
         7WH23bkvaA3rsWKZ8TTuHP0ldE1ut37SyF949mz4glrUGC7X7jX2B66qr1sLGEX59CGU
         zLag==
X-Gm-Message-State: AGi0Pua3PAIQbAuw0siF61yopr+Bfvs4KaQsiO8xqiQ1dh1mjUIao/HL
        hXp1gmHxjvxZ3cD6yUistcXkfXb9
X-Google-Smtp-Source: APiQypJNO1jmtSijN8l1vFrCIZZTMCgPjOqmAUbkyqeJwuIZ3wZSGJ7FQgQiKd3EFJBukWI/EiXTdw==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr7339144wrw.250.1586573072251;
        Fri, 10 Apr 2020 19:44:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm5486227wrf.31.2020.04.10.19.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 19:44:31 -0700 (PDT)
Message-Id: <20d3a50f5a4bf91223c1b849d91e790683d70d66.1586573068.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
References: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
From:   "Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 02:44:27 +0000
Subject: [PATCH v3 4/4] rebase --merge: optionally skip upstreamed commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

When rebasing against an upstream that has had many commits since the
original branch was created:

 O -- O -- ... -- O -- O (upstream)
  \
   -- O (my-dev-branch)

it must read the contents of every novel upstream commit, in addition to
the tip of the upstream and the merge base, because "git rebase"
attempts to exclude commits that are duplicates of upstream ones. This
can be a significant performance hit, especially in a partial clone,
wherein a read of an object may end up being a fetch.

Add a flag to "git rebase" to allow suppression of this feature. This
flag only works when using the "merge" backend.

This flag changes the behavior of sequencer_make_script(), called from
do_interactive_rebase() <- run_rebase_interactive() <-
run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
(indirectly called from sequencer_make_script() through
prepare_revision_walk()) will no longer call cherry_pick_list(), and
thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
means that the intermediate commits in upstream are no longer read (as
shown by the test) and means that no PATCHSAME-caused skipping of
commits is done by sequencer_make_script(), either directly or through
make_script_with_merges().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt | 25 +++++++++++-
 builtin/rebase.c             |  7 ++++
 sequencer.c                  |  3 +-
 sequencer.h                  |  2 +-
 t/t3402-rebase-merge.sh      | 77 ++++++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 18d718ac61d..cccf76dfa4b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -279,7 +279,8 @@ See also INCOMPATIBLE OPTIONS below.
 +
 Note that commits which start empty are kept (unless --no-keep-empty
 is specified), and commits which are clean cherry-picks (as determined
-by `git log --cherry-mark ...`) are always dropped.
+by `git log --cherry-mark ...`) are detected and dropped as a
+preliminary step (unless --reapply-cherry-picks is passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -304,6 +305,24 @@ see the --empty flag.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--reapply-cherry-picks::
+--no-reapply-cherry-picks::
+	Reapply all clean cherry-picks of any upstream commit instead
+	of preemptively dropping them. (If these commits then become
+	empty after rebasing, because they contain a subset of already
+	upstream changes, the behavior towards them is controlled by
+	the `--empty` flag.)
++
+By default (or if `--no-reapply-cherry-picks` is given), these commits
+will be automatically dropped.  Because this necessitates reading all
+upstream commits, this can be expensive in repos with a large number
+of upstream commits that need to be read.
++
+`--reapply-cherry-picks` allows rebase to forgo reading all upstream
+commits, potentially improving performance.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --allow-empty-message::
 	No-op.  Rebasing commits with an empty message used to fail
 	and this option would override that behavior, allowing commits
@@ -601,6 +620,7 @@ are incompatible with the following options:
  * --exec
  * --no-keep-empty
  * --empty=
+ * --reapply-cherry-picks
  * --edit-todo
  * --root when used in combination with --onto
 
@@ -1017,7 +1037,8 @@ Only works if the changes (patch IDs based on the diff contents) on
 'subsystem' did.
 
 In that case, the fix is easy because 'git rebase' knows to skip
-changes that are already present in the new upstream.  So if you say
+changes that are already present in the new upstream (unless
+`--reapply-cherry-picks` is given). So if you say
 (assuming you're on 'topic')
 ------------
     $ git rebase subsystem
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0e223a96d46..75c2ebd4c35 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -96,6 +96,7 @@ struct rebase_options {
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int use_legacy_rebase;
+	int reapply_cherry_picks;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -387,6 +388,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
 
 	switch (command) {
 	case ACTION_NONE: {
@@ -1585,6 +1587,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "reschedule-failed-exec",
 			 &reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
+		OPT_BOOL(0, "reapply-cherry-picks", &options.reapply_cherry_picks,
+			 N_("apply all changes, even those already present upstream")),
 		OPT_END(),
 	};
 	int i;
@@ -1825,6 +1829,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
+	if (options.reapply_cherry_picks)
+		imply_merge(&options, "--reapply-cherry-picks");
+
 	if (gpg_sign) {
 		free(options.gpg_sign_opt);
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
diff --git a/sequencer.c b/sequencer.c
index d973e19729e..667648d6f9d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4828,12 +4828,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
+	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
-	revs.cherry_mark = 1;
+	revs.cherry_mark = !reapply_cherry_picks;
 	revs.limited = 1;
 	revs.reverse = 1;
 	revs.right_only = 1;
diff --git a/sequencer.h b/sequencer.h
index 7ebaa237340..25b396b9171 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -150,7 +150,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  * `--onto`, we do not want to re-generate the root commits.
  */
 #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
-
+#define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index a1ec501a872..6e032716a68 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -162,4 +162,81 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git rebase --skip
 '
 
+test_expect_success '--reapply-cherry-picks' '
+	git init repo &&
+
+	# O(1-10) -- O(1-11) -- O(0-10) master
+	#        \
+	#         -- O(1-11) -- O(1-12) otherbranch
+
+	printf "Line %d\n" $(test_seq 1 10) >repo/file.txt &&
+	git -C repo add file.txt &&
+	git -C repo commit -m "base commit" &&
+
+	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
+	git -C repo commit -a -m "add 11" &&
+
+	printf "Line %d\n" $(test_seq 0 10) >repo/file.txt &&
+	git -C repo commit -a -m "add 0 delete 11" &&
+
+	git -C repo checkout -b otherbranch HEAD^^ &&
+	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
+	git -C repo commit -a -m "add 11 in another branch" &&
+
+	printf "Line %d\n" $(test_seq 1 12) >repo/file.txt &&
+	git -C repo commit -a -m "add 12 in another branch" &&
+
+	# Regular rebase fails, because the 1-11 commit is deduplicated
+	test_must_fail git -C repo rebase --merge master 2> err &&
+	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
+	git -C repo rebase --abort &&
+
+	# With --reapply-cherry-picks, it works
+	git -C repo rebase --merge --reapply-cherry-picks master
+'
+
+test_expect_success '--reapply-cherry-picks refrains from reading unneeded blobs' '
+	git init server &&
+
+	# O(1-10) -- O(1-11) -- O(1-12) master
+	#        \
+	#         -- O(0-10) otherbranch
+
+	printf "Line %d\n" $(test_seq 1 10) >server/file.txt &&
+	git -C server add file.txt &&
+	git -C server commit -m "merge base" &&
+
+	printf "Line %d\n" $(test_seq 1 11) >server/file.txt &&
+	git -C server commit -a -m "add 11" &&
+
+	printf "Line %d\n" $(test_seq 1 12) >server/file.txt &&
+	git -C server commit -a -m "add 12" &&
+
+	git -C server checkout -b otherbranch HEAD^^ &&
+	printf "Line %d\n" $(test_seq 0 10) >server/file.txt &&
+	git -C server commit -a -m "add 0" &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	git -C client checkout origin/master &&
+	git -C client checkout origin/otherbranch &&
+
+	# Sanity check to ensure that the blobs from the merge base and "add
+	# 11" are missing
+	git -C client rev-list --objects --all --missing=print >missing_list &&
+	MERGE_BASE_BLOB=$(git -C server rev-parse master^^:file.txt) &&
+	ADD_11_BLOB=$(git -C server rev-parse master^:file.txt) &&
+	grep "[?]$MERGE_BASE_BLOB" missing_list &&
+	grep "[?]$ADD_11_BLOB" missing_list &&
+
+	git -C client rebase --merge --reapply-cherry-picks origin/master &&
+
+	# The blob from the merge base had to be fetched, but not "add 11"
+	git -C client rev-list --objects --all --missing=print >missing_list &&
+	! grep "[?]$MERGE_BASE_BLOB" missing_list &&
+	grep "[?]$ADD_11_BLOB" missing_list
+'
+
 test_done
-- 
gitgitgadget
