Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F3C10F25
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F2220873
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 20:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKtIicS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCIUzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:55:36 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:52654 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCIUzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 16:55:36 -0400
Received: by mail-pj1-f74.google.com with SMTP id c6so579818pjs.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BRxx12qNaGjNBFLXYn3QZdGSPQl5jzB0WKrr8IIER+8=;
        b=RKtIicS+qUf4Kq/K7rKhCzOFzxEMO291q4R83S/GStQ0QLMRa2YOp6YLQirA5mx4C+
         ODRW1Rn36M5GIZ8DmqDt6tZdJG7SfSJxpXA9qGmnGFWttw0Mw7yEhw9slah96nIfzLNN
         Bqv5H1nwGFTnv6AgikJJCDYrnWjFI889cjYP43Af3V01Ac13ZsbN5tW6HRb0VbIVmaOx
         LTYm+3IhEXxJv9kr8n1xr1BBWTN2l5qIleyiSV1oqR4/Vn9NvzZ8o+2piAonPcT5oexT
         gLT/ZfVPRu42S/rVOO8M3MMvAnarDuArm/cMr/Iz8BuyJP643eZ2RTuldc0AkVrvNQkR
         XKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BRxx12qNaGjNBFLXYn3QZdGSPQl5jzB0WKrr8IIER+8=;
        b=O/dBRWbrrvIVVh4JJvqOQavfXihMOV8tpx8Jt7thu/51Y74+c+qW07wh6vk9mVRusD
         2dD0XugE3azb8jT6tgzxQwRrV/5TyinqKK6qxJQPt4PNTWIN4SfFPpIPbZG9NZufp0DQ
         UCWf7IKAxkNkCkyTMjRxVdZ+4aw7Km5STtWtN1nuOtRdXjwqFFVlEjebgzI5UliJ/eS9
         yPwSG3N41KwaeFkwxFe6O0jEGPg9pUh/FN/Azu7ST6NbBxoxFSAhOu74HSPq+eNUKfPl
         aGhVhii8AbreI2iu7mG9pPQV5impzxqM6KGyA/69WVvvmWDv3WRSPESFUtYIhNrpfVmC
         45ng==
X-Gm-Message-State: ANhLgQ37CnTA3bwtTIvcFvYtvl/R61o8S15unkqg/A8t8yydHzGpTVgD
        d2c/lczKkASKo55Ki2XG44d2Zp0eokyKyiBeM3AXEZH/UHZrWSCgA3NWZUsWvknxDOF4+S+t8l/
        DnetJ8Dv4Lk7q51lvzSHqPpjO1ZFfRDsquMtBd1kPVje100bMFNQLQjZmcdYm1SdoBAtW1nNcZ0
        cq
X-Google-Smtp-Source: ADFU+vuRjRcugYy4HoKOfo8pnW68rEzfPDbKf2KHkK4dBG7XfdehyMe5AtxoDf3L1hhDqtcrMml+IT5uJINxvpZOY04s
X-Received: by 2002:a17:90a:3ee5:: with SMTP id k92mr1172411pjc.81.1583787332853;
 Mon, 09 Mar 2020 13:55:32 -0700 (PDT)
Date:   Mon,  9 Mar 2020 13:55:23 -0700
Message-Id: <20200309205523.121319-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing against an upstream that has had many commits since the
original branch was created:

 O -- O -- ... -- O -- O (upstream)
  \
   -- O (my-dev-branch)

because "git rebase" attempts to exclude commits that are duplicates of
upstream ones, it must read the contents of every novel upstream commit,
in addition to the tip of the upstream and the merge base. This can be a
significant performance hit, especially in a partial clone, wherein a
read of an object may end up being a fetch.

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
---
More improvements for partial clone, but this is a benefit for
non-partial-clone as well, hence the way I wrote the commit message (not
focusing too much on partial clone) and the documentation.

I've chosen --skip-already-present and --no-skip-already-present to
reuse the language already existing in the documentation and to avoid a
double negative (e.g. --avoid-checking-if-already-present and
--no-avoid-checking-if-already-present) but this causes some clumsiness
in the documentation and in the code. Any suggestions for the name are
welcome.

I've only implemented this for the "merge" backend since I think that
there is an effort to migrate "rebase" to use the "merge" backend by
default, and also because "merge" uses diff internally which already has
the (per-commit) blob batch prefetching.
---
 Documentation/git-rebase.txt | 12 +++++-
 builtin/rebase.c             | 10 ++++-
 sequencer.c                  |  3 +-
 sequencer.h                  |  2 +-
 t/t3402-rebase-merge.sh      | 77 ++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0c4f038dd6..f73a82b4a9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -318,6 +318,15 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--skip-already-present::
+--no-skip-already-present::
+	Skip commits that are already present in the new upstream.
+	This is the default.
++
+If the skip-if-already-present feature is unnecessary or undesired,
+`--no-skip-already-present` may improve performance since it avoids
+the need to read the contents of every commit in the new upstream.
+
 --rerere-autoupdate::
 --no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
@@ -866,7 +875,8 @@ Only works if the changes (patch IDs based on the diff contents) on
 'subsystem' did.
 
 In that case, the fix is easy because 'git rebase' knows to skip
-changes that are already present in the new upstream.  So if you say
+changes that are already present in the new upstream (unless
+`--no-skip-already-present` is given). So if you say
 (assuming you're on 'topic')
 ------------
     $ git rebase subsystem
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6154ad8fa5..943211e5bb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -88,13 +88,15 @@ struct rebase_options {
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int use_legacy_rebase;
+	int skip_already_present;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
-		.git_format_patch_opt = STRBUF_INIT	\
+		.git_format_patch_opt = STRBUF_INIT,	\
+		.skip_already_present =	1		\
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -373,6 +375,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= opts->skip_already_present ? TODO_LIST_SKIP_ALREADY_PRESENT : 0;
 
 	switch (command) {
 	case ACTION_NONE: {
@@ -1507,6 +1510,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "reschedule-failed-exec",
 			 &reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
+		OPT_BOOL(0, "skip-already-present", &options.skip_already_present,
+			 N_("skip changes that are already present in the new upstream")),
 		OPT_END(),
 	};
 	int i;
@@ -1840,6 +1845,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			      "interactive or merge options"));
 	}
 
+	if (!options.skip_already_present && !is_interactive(&options))
+		die(_("--no-skip-already-present does not work with the 'am' backend"));
+
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
diff --git a/sequencer.c b/sequencer.c
index ba90a513b9..752580c017 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4797,12 +4797,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
+	int skip_already_present = !!(flags & TODO_LIST_SKIP_ALREADY_PRESENT);
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
-	revs.cherry_mark = 1;
+	revs.cherry_mark = skip_already_present;
 	revs.limited = 1;
 	revs.reverse = 1;
 	revs.right_only = 1;
diff --git a/sequencer.h b/sequencer.h
index 393571e89a..39bb12f624 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -149,7 +149,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  * `--onto`, we do not want to re-generate the root commits.
  */
 #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
-
+#define TODO_LIST_SKIP_ALREADY_PRESENT (1U << 7)
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index a1ec501a87..9b52739a10 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -162,4 +162,81 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git rebase --skip
 '
 
+test_expect_success '--no-skip-already-present' '
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
+	# With --no-skip-already-present, it works
+	git -C repo rebase --merge --no-skip-already-present master
+'
+
+test_expect_success '--no-skip-already-present refrains from reading unneeded blobs' '
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
+	grep "\\?$MERGE_BASE_BLOB" missing_list &&
+	grep "\\?$ADD_11_BLOB" missing_list &&
+
+	git -C client rebase --merge --no-skip-already-present origin/master &&
+
+	# The blob from the merge base had to be fetched, but not "add 11"
+	git -C client rev-list --objects --all --missing=print >missing_list &&
+	! grep "\\?$MERGE_BASE_BLOB" missing_list &&
+	grep "\\?$ADD_11_BLOB" missing_list
+'
+
 test_done
-- 
2.25.1.481.gfbce0eb801-goog

