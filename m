Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59991FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755946AbdDRRJ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:09:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33751 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754470AbdDRRJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:09:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so582570wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DFU+OIHNH1XW93tq6JdQXFGv3MR/o/3r2i2yLvjOQQE=;
        b=brgpngz36jLhaYBm4p39RFEfD15negke8pBkUz0ZdeO2Tl9EvYPVQPC9Y2H0OdG7Gx
         uVJEuOVY8rwWn5SXQ+rI1rSgBZNILEsT9FXeh3Y+gaSZnVv1lEhvGt0/3YeJk1ppoj5M
         xy5vic51aoTabH1bad5XzkOwL91X5mKOyDig2M9mrXbIH92DdZ5+Gk429UqmlK2TeFED
         bOMUbyHNKoEW+o2vSquJNXxm6XQgu25ChSZy+4wT8h12QapNRImGhhrPbo70ZkqgVSV9
         qdN2/37KE3YpDnI0KciNpkH9IDXav3sRIxJYpBGZJSc+JvPv1oUWMqc0lOGPSFpEjoOC
         Vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DFU+OIHNH1XW93tq6JdQXFGv3MR/o/3r2i2yLvjOQQE=;
        b=KM1qWYE+pvJGxaSAmy6oVq6tj9d+osk7TxUmMNAEel4vBVNfuzbTLXlu2hLY8XcgvY
         +5hvAfqHfuuhvAd53mBf+NOkeUpjaTz9yeNzzzt567WLFKnAv0SfED5fAGvXHWF8eILO
         ET/xsYbAT5aW8EdQ1eBKomuiCVuPhVLymczEUjxB4A7fGD/YmBthAqOiKyvDVsZUXBlM
         daxuybwA8gDnf1rU69UwyS4aEbKmuMMQDCweREdSwp/T4dwesdC+akrBxR2NP8+RZPiO
         1gG3jVg+WGB2Wwpa6IAB19cbHvGZ7+LDIbWqMsX+aVlHic2XCpCM19Ivf0xRcFqfeL6Q
         WKsA==
X-Gm-Message-State: AN3rC/6eVfCJCbBTQuK6tUVhoEgJDsBCdFJiXrwX9ZO+rGJrr0mSb6i4
        1EKLCbv8nuQQvr2nFIg=
X-Received: by 10.28.198.65 with SMTP id w62mr13757504wmf.80.1492535364165;
        Tue, 18 Apr 2017 10:09:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u36sm19493998wrc.20.2017.04.18.10.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 10:09:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] various: disallow --no-no-OPT for --no-opt options
Date:   Tue, 18 Apr 2017 17:09:14 +0000
Message-Id: <20170418170914.9701-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various --no-OPT options which don't supply PARSE_OPT_NONEG to
make --no-no-OPT an error.

All of these worked before this change, e.g. doing cloning by doing
"git clone --no-no-checkout" is equivalent to just "git clone", but
this was never intended, and is inconsistent with other --no-OPT
options which do pass PARSE_OPT_NONEG.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

For this one I'm not bothering to track down & CC every single person
who originally added these --no-OPT options. Clearly just a trivial
bug we can fix.

 apply.c                       | 2 +-
 builtin/bisect--helper.c      | 2 +-
 builtin/check-ignore.c        | 2 +-
 builtin/checkout-index.c      | 2 +-
 builtin/clone.c               | 4 ++--
 builtin/commit.c              | 4 ++--
 builtin/fast-export.c         | 2 +-
 builtin/grep.c                | 2 +-
 builtin/hash-object.c         | 2 +-
 builtin/log.c                 | 4 ++--
 builtin/push.c                | 2 +-
 builtin/read-tree.c           | 2 +-
 builtin/revert.c              | 2 +-
 builtin/show-branch.c         | 2 +-
 builtin/update-ref.c          | 2 +-
 parse-options.h               | 7 +++++++
 t/helper/test-parse-options.c | 1 +
 t/t0040-parse-options.sh      | 3 +++
 18 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26ad..47a91d0762 100644
--- a/apply.c
+++ b/apply.c
@@ -4917,7 +4917,7 @@ int apply_parse_options(int argc, const char **argv,
 		{ OPTION_CALLBACK, 'p', NULL, state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, apply_option_parse_p },
-		OPT_BOOL(0, "no-add", &state->no_add,
+		OPT_BOOL_NONEG(0, "no-add", &state->no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state->diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229025..5fe9093947 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -15,7 +15,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "next-all", &next_all,
 			 N_("perform 'git bisect next'")),
-		OPT_BOOL(0, "no-checkout", &no_checkout,
+		OPT_BOOL_NONEG(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 1d73d3ca3d..cb6467946e 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -24,7 +24,7 @@ static const struct option check_ignore_options[] = {
 		 N_("terminate input and output records by a NUL character")),
 	OPT_BOOL('n', "non-matching", &show_non_matching,
 		 N_("show non-matching input paths")),
-	OPT_BOOL(0, "no-index", &no_index,
+	OPT_BOOL_NONEG(0, "no-index", &no_index,
 		 N_("ignore index when checking")),
 	OPT_END()
 };
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 07631d0c9c..cf84e31ce8 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -161,7 +161,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("force overwrite of existing files")),
 		OPT__QUIET(&quiet,
 			N_("no warning for existing files and files not in index")),
-		OPT_BOOL('n', "no-create", &not_new,
+		OPT_BOOL_NONEG('n', "no-create", &not_new,
 			N_("don't checkout new files")),
 		OPT_BOOL('u', "index", &index_opt,
 			 N_("update stat information in the index file")),
diff --git a/builtin/clone.c b/builtin/clone.c
index de85b85254..32c5843563 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -76,7 +76,7 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
-	OPT_BOOL('n', "no-checkout", &option_no_checkout,
+	OPT_BOOL_NONEG('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
 	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
@@ -85,7 +85,7 @@ static struct option builtin_clone_options[] = {
 		 N_("create a mirror repository (implies bare)")),
 	OPT_BOOL('l', "local", &option_local,
 		N_("to clone from a local repository")),
-	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
+	OPT_BOOL_NONEG(0, "no-hardlinks", &option_no_hardlinks,
 		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..46830ebfaf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1607,7 +1607,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
-		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
+		OPT_BOOL_NONEG('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
@@ -1620,7 +1620,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
-		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
+		OPT_BOOL_NONEG(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d0..dfbd245842 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -994,7 +994,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			 N_("Output full tree for each commit")),
 		OPT_BOOL(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
-		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
+		OPT_BOOL_NONEG(0, "no-data", &no_data, N_("Skip output of blob data")),
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52fc..923cc570e6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -978,7 +978,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
-		OPT_NEGBIT(0, "no-index", &use_index,
+		OPT_NEGBIT_NONEG(0, "no-index", &use_index,
 			 N_("find in contents not managed by git"), 1),
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index bbeaf20bcc..c563f2a9ad 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -96,7 +96,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 			HASH_WRITE_OBJECT),
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
-		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
+		OPT_BOOL_NONEG( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
 		OPT_END()
diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1ed..9824e137ec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1416,7 +1416,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_NOARG, numbered_callback },
 		{ OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
 			    N_("use [PATCH] even with multiple patches"),
-			    PARSE_OPT_NOARG, no_numbered_callback },
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG , no_numbered_callback },
 		OPT_BOOL('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
@@ -1442,7 +1442,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'k', "keep-subject", &rev, NULL,
 			    N_("don't strip/add [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback },
-		OPT_BOOL(0, "no-binary", &no_binary_diff,
+		OPT_BOOL_NONEG(0, "no-binary", &no_binary_diff,
 			 N_("don't output binary diffs")),
 		OPT_BOOL(0, "zero-commit", &zero_commit,
 			 N_("output all-zero hash in From header")),
diff --git a/builtin/push.c b/builtin/push.c
index 5c22e9f2e5..216307c0fa 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -539,7 +539,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
-		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
+		OPT_BIT_NONEG(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		{ OPTION_CALLBACK,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8c..e9359ecb1e 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -153,7 +153,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		OPT_BOOL('i', NULL, &opts.index_only,
 			 N_("don't check the working tree after merging")),
 		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work tree")),
-		OPT_BOOL(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
+		OPT_BOOL_NONEG(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
 			 N_("debug unpack-trees")),
diff --git a/builtin/revert.c b/builtin/revert.c
index 345d9586a7..e708fdc228 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -98,7 +98,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
-		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
+		OPT_BOOL_NONEG('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
 		OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 19756595d5..6827846b54 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -638,7 +638,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    N_("show <n> more commits after the common ancestor"),
 			    PARSE_OPT_OPTARG, NULL, (intptr_t)1 },
 		OPT_SET_INT(0, "list", &extra, N_("synonym to more=-1"), -1),
-		OPT_BOOL(0, "no-name", &no_name, N_("suppress naming strings")),
+		OPT_BOOL_NONEG(0, "no-name", &no_name, N_("suppress naming strings")),
 		OPT_BOOL(0, "current", &with_current_branch,
 			 N_("include the current branch")),
 		OPT_BOOL(0, "sha1-name", &sha1_name,
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0b2ecf41ae..b9622b2136 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -361,7 +361,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
-		OPT_BOOL( 0 , "no-deref", &no_deref,
+		OPT_BOOL_NONEG( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
diff --git a/parse-options.h b/parse-options.h
index af711227ae..8211d2d5f1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -118,13 +118,20 @@ struct option {
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), \
 				      PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_BIT_NONEG(s, l, v, h, b) { OPTION_BIT, (s), (l), (v), NULL, (h), \
+				       PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (b) }
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_NEGBIT_NONEG(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
+					    (h), PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_SET_INT_NONEG(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
+				            (h), PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_BOOL_NONEG(s, l, v, h)  OPT_SET_INT_NONEG(s, l, v, h, 1)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index a01430c24b..f6517a9305 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -105,6 +105,7 @@ int cmd_main(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
 		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
+		OPT_BOOL_NONEG(0, "no-neg", &boolean, "begins with 'no-', can't be negated"),
 		{ OPTION_SET_INT, 'B', "no-fear", &boolean, NULL,
 		  "be brave", PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
 		OPT_COUNTUP('b', "boolean", &boolean, "increment by one"),
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 74d2cd76fe..e571746775 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -12,6 +12,7 @@ usage: test-parse-options <options>
 
     --yes                 get a boolean
     -D, --no-doubt        begins with 'no-'
+    --no-neg              begins with 'no-', can't be negated
     -B, --no-fear         be brave
     -b, --boolean         increment by one
     -4, --or4             bitwise-or boolean with ...0100
@@ -80,6 +81,7 @@ check_unknown_i18n() {
 
 test_expect_success 'OPT_BOOL() #1' 'check boolean: 1 --yes'
 test_expect_success 'OPT_BOOL() #2' 'check boolean: 1 --no-doubt'
+test_expect_success 'OPT_BOOL() #2' 'check boolean: 1 --no-neg'
 test_expect_success 'OPT_BOOL() #3' 'check boolean: 1 -D'
 test_expect_success 'OPT_BOOL() #4' 'check boolean: 1 --no-fear'
 test_expect_success 'OPT_BOOL() #5' 'check boolean: 1 -B'
@@ -89,6 +91,7 @@ test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
 
 test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
 test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
+test_expect_success 'OPT_BOOL() negation #3' 'test_must_fail test-parse-options --no-no-neg'
 
 test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
 test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
-- 
2.11.0

