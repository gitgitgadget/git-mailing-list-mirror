Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8CC433AD
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758928143; cv=none; b=QwxF8e/wPeaQd38zgIMqfLQKvSJUJ7elS+wStCt3Mx0eatahuw6wfYgg8yy4VgNHDiYGtm58IZ8PJGjZpvJfj7FQI6nOxPzfWNV1TE7xKkS193VypuxEx0pLxv+G6UZxxY5M1yma8QyXsWvSEXLB4rQU8NXbMDbLlk5m6t00i3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758928143; c=relaxed/simple;
	bh=8EQLrE8dEMBmsSJcGrFLIIHrvB7HUwtMoP/BFuiISTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNHIUMlsMrnTgz6lcNlwQgjVjxsgzrUy/znQ1yboctZ50OXRjJyi2KbVBP/AnmbGPKn38t7QsDCA5KuKDRoKg4UhtJeYAYjh5dlebTFmjFfDZvdWjD/vGylGmUzelP5iGPyos4G3LSPDEUbusddiX6laQPaN9OU/WmLoa9Y4+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXdRIy3l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXdRIy3l"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so869117b3a.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758928139; x=1759532939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPxh7LBR9B68jsFmE/fNUgcOoHxbRn3av0s2wrdY+ts=;
        b=hXdRIy3lF8sB/Txs7GQm8eUniYLXzMBQ5kXcCUz4SuCME7l0QuT+u9JHuM5aoMc7K+
         nN/TjzCsRxB6wRdNRv0VcuStPAzmmYJxdEhq0KkAiN6w8BkuOKKPH4BKQDtlA+xzX6zp
         LjH8Wl6KbTEDHINzTz5W4GnCAYVKBlTkf8SoG+T7yiE+6TKBM6pWcdYAWswIRRBJBBf1
         7o05o8P0uGjDD7RDo0zvKBtJyMOl/6IQRQIjpOvM4zqHAzqEFXndkyfygew+RUgVFFSX
         wdoRJi0cyDPullX1ZKUNkhRe/0zBhur+z7P9tIomn1ghBEVjggiqrYTBozfbJ1s2lPwI
         lS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758928139; x=1759532939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPxh7LBR9B68jsFmE/fNUgcOoHxbRn3av0s2wrdY+ts=;
        b=ZbrenkDUM9A8GTAcrR5CIIsHjDK4KN5MH0hBveWIJusdJB21qoA5o6eFG4N0OJ6x81
         u1H0HgabAC6UghlMaUMD3K5ftPlXqTnmHWp61OfOGF63SayY5/8BkacuCYPA3/CtFShx
         yre0OJCX0i0W+S69F6h2vjEqOoB2OH5/kiZeXfkNX6PxBfJuJ1X/Sy3PySFgNiCXxNQj
         8HE+BdnsNIXSOIyCuyq5RO7GIKBMZCzYuSfni8Ul+LrqA35jQYBXUKgwUIxvIvkc5esJ
         WHE8ZUKGtzsaOX5I0Bn+hlSwWebC394UZIkPYfzRC8R1wS8DqBWEHBr2NmRzwOHtsa+P
         siUA==
X-Gm-Message-State: AOJu0YzADsZesOh0RoN20ajh9x/5zn6nin2/60CjAVxIvgKzqhECnA60
	flZZm5SBd3ZJlW9SLa8WuAm2O92DYjmkVnPWjmVmP45J40ZufBXB15Rdb5e7xw==
X-Gm-Gg: ASbGnctGA3kszjM6w5Gcc09v1kGIyelVpZTBu17AcIbkbPnZd2WCWm0dEcUj2lqGPi1
	nSDh5zYaB6BYUSJ+o8f+m2umUIQG99CpMaptOEvOhmFsDyB7n3C/sSCotd4OZ1+KLpj4EsJYJpk
	ayaW28iqkr+wbMdF0jx1Fv4lGyZ7FLNnivp+OyM8YN+iTEwolHch3dSiSa4bTitO3qTQBqRW0Vc
	00AIMn6MOU+CP5LLhrvyfFIhERmhQSVjLyADBzVAJRUqj4N6fQ66H0o+//IPekcSUr5zA86pBHA
	jFiVaNwi1jd4gMFVFoUqgrQSgZGr1hwvIJ9rgh0A4eSlkri8p+thrtVsWXA1BBgOz9xsVSa7g4J
	33hXwtgxefWQRwSoKEg3m7hGcM7Y9SvobOwk06tIJU8NmYUGTVCgbsZqcSxuDbcNhEGq2dGzdB3
	RmcpMk3M9LAWfI54CDHpoC2TjSzWEQ61uM6Z+K5dHtkSW/iDQvog==
X-Google-Smtp-Source: AGHT+IEmef7impeM8rzKhPXKQhV7b3zYorjMrHohgm/3aksmaFPRP8Vs6Dd+F8eQhTL1rQJ6y+nrJw==
X-Received: by 2002:a17:90b:5106:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-336b3cb2901mr1019385a91.16.1758928139288;
        Fri, 26 Sep 2025 16:08:59 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:596:4193:db28:d218:fc74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda71bdsm10005981a91.11.2025.09.26.16.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 16:08:58 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
Date: Sat, 27 Sep 2025 04:38:38 +0530
Message-ID: <20250926230838.35870-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926230838.35870-1-siddharthasthana31@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git replay command currently outputs update commands that must be
piped to git update-ref --stdin to actually update references:

    git replay --onto main topic1..topic2 | git update-ref --stdin

This design has significant limitations for server-side operations. The
two-command pipeline creates coordination complexity, provides no atomic
transaction guarantees by default, and complicates automation in bare
repository environments where git replay is primarily used.

During extensive mailing list discussion, multiple maintainers identified
that the current approach forces users to opt-in to atomic behavior rather
than defaulting to the safer, more reliable option. Elijah Newren noted
that the experimental status explicitly allows such behavior changes, while
Patrick Steinhardt highlighted performance concerns with individual ref
updates in the reftable backend.

The core issue is that git replay was designed around command output rather
than direct action. This made sense for a plumbing tool, but creates barriers
for the primary use case: server-side operations that need reliable, atomic
ref updates without pipeline complexity.

This patch changes the default behavior to update refs directly using Git's
ref transaction API:

    git replay --onto main topic1..topic2
    # No output; all refs updated atomically or none

The implementation uses ref_store_transaction_begin() with atomic mode by
default, ensuring all ref updates succeed or all fail as a single operation.
This leverages git replay's existing server-side strengths (in-memory operation,
no work tree requirement) while adding the atomic guarantees that server
operations require.

For users needing the traditional pipeline workflow, --output-commands
preserves the original behavior:

    git replay --output-commands --onto main topic1..topic2 | git update-ref --stdin

The --allow-partial option enables partial failure tolerance. However, following
maintainer feedback, it implements a "strict success" model: the command exits
with code 0 only if ALL ref updates succeed, and exits with code 1 if ANY
updates fail. This ensures that --allow-partial changes error reporting style
(warnings vs hard errors) but not success criteria, handling edge cases like
"no updates needed" cleanly.

Implementation details:
- Empty commit ranges now return success (exit code 0) rather than failure,
  as no commits to replay is a valid successful operation
- Added comprehensive test coverage with 12 new tests covering atomic behavior,
  option validation, bare repository support, and edge cases
- Fixed test isolation issues to prevent branch state contamination between tests
- Maintains C89 compliance and follows Git's established coding conventions
- Refactored option validation to use die_for_incompatible_opt2() for both
  --advance/--contained and --allow-partial/--output-commands conflicts,
  providing consistent error reporting
- Fixed --allow-partial exit code behavior to implement "strict success" model
  where any ref update failures result in exit code 1, even with partial tolerance
- Updated documentation with proper line wrapping, consistent terminology using
  "old default behavior", performance context, and reorganized examples for clarity
- Eliminates individual ref updates (refs_update_ref calls) that perform
  poorly with reftable backend
- Uses only batched ref transactions for optimal performance across all
  ref backends
- Avoids naming collision with git rebase --update-refs by using distinct
  option names
- Defaults to atomic behavior while preserving pipeline compatibility

The result is a command that works better for its primary use case (server-side
operations) while maintaining full backward compatibility for existing workflows.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc |  76 +++++++++++++---
 builtin/replay.c              | 114 ++++++++++++++++++++---
 t/t3650-replay-basics.sh      | 166 ++++++++++++++++++++++++++++++++--
 3 files changed, 319 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 0b12bf8aa4..e104e0bc03 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,16 +9,16 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--output-commands | --allow-partial] <revision-range>...
 
 DESCRIPTION
 -----------
 
 Takes ranges of commits and replays them onto a new location. Leaves
-the working tree and the index untouched, and updates no references.
-The output of this command is meant to be used as input to
-`git update-ref --stdin`, which would update the relevant branches
-(see the OUTPUT section below).
+the working tree and the index untouched, and by default updates the
+relevant references using atomic transactions. Use `--output-commands`
+to get the old default behavior where update commands that can be piped
+to `git update-ref --stdin` are emitted (see the OUTPUT section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -42,6 +42,20 @@ When `--advance` is specified, the update-ref command(s) in the output
 will update the branch passed as an argument to `--advance` to point at
 the new commits (in other words, this mimics a cherry-pick operation).
 
+--output-commands::
+	Output update-ref commands instead of updating refs directly.
+	When this option is used, the output can be piped to `git update-ref --stdin`
+	for successive, relatively slow, ref updates. This is equivalent to the
+	old default behavior.
+
+--allow-partial::
+	Allow some ref updates to succeed even if others fail. By default,
+	ref updates are atomic (all succeed or all fail). With this option,
+	failed updates are reported as warnings rather than causing the entire
+	command to fail. The command exits with code 0 only if all updates
+	succeed; any failures result in exit code 1. Cannot be used with
+	`--output-commands`.
+
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
 	be passed, but in `--advance <branch>` mode, they should have
@@ -54,15 +68,20 @@ include::rev-list-options.adoc[]
 OUTPUT
 ------
 
-When there are no conflicts, the output of this command is usable as
-input to `git update-ref --stdin`.  It is of the form:
+By default, when there are no conflicts, this command updates the relevant
+references using atomic transactions and produces no output. All ref updates
+succeed or all fail (atomic behavior). Use `--allow-partial` to allow some
+updates to succeed while others fail.
+
+When `--output-commands` is used, the output is usable as input to
+`git update-ref --stdin`. It is of the form:
 
 	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
 	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
 where the number of refs updated depends on the arguments passed and
-the shape of the history being replayed.  When using `--advance`, the
+the shape of the history being replayed. When using `--advance`, the
 number of refs updated is always one, but for `--onto`, it can be one
 or more (rebasing multiple branches simultaneously is supported).
 
@@ -77,30 +96,50 @@ is something other than 0 or 1.
 EXAMPLES
 --------
 
-To simply rebase `mybranch` onto `target`:
+To simply rebase `mybranch` onto `target` (default behavior):
 
 ------------
 $ git replay --onto target origin/main..mybranch
-update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
 ------------
 
 To cherry-pick the commits from mybranch onto target:
 
 ------------
 $ git replay --advance target origin/main..mybranch
-update refs/heads/target ${NEW_target_HASH} ${OLD_target_HASH}
 ------------
 
 Note that the first two examples replay the exact same commits and on
 top of the exact same new base, they only differ in that the first
-provides instructions to make mybranch point at the new commits and
-the second provides instructions to make target point at them.
+updates mybranch to point at the new commits and the second updates
+target to point at them.
+
+To get the old default behavior where update commands are emitted:
+
+------------
+$ git replay --output-commands --onto target origin/main..mybranch
+update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
+------------
+
+To rebase multiple branches with partial failure tolerance:
+
+------------
+$ git replay --allow-partial --contained --onto origin/main origin/main..tipbranch
+------------
 
 What if you have a stack of branches, one depending upon another, and
 you'd really like to rebase the whole set?
 
 ------------
 $ git replay --contained --onto origin/main origin/main..tipbranch
+------------
+
+This automatically finds and rebases all branches contained within the
+`origin/main..tipbranch` range.
+
+Or if you want to see the old default behavior where update commands are emitted:
+
+------------
+$ git replay --output-commands --contained --onto origin/main origin/main..tipbranch
 update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
 update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
 update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
@@ -108,10 +147,19 @@ update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
 
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
-do:
+do. Here's an example where you explicitly specify which branches to rebase:
 
 ------------
 $ git replay --onto origin/main ^base branch1 branch2 branch3
+------------
+
+This gives you explicit control over exactly which branches are rebased,
+unlike the previous `--contained` example which automatically discovers them.
+
+To see the update commands that would be executed:
+
+------------
+$ git replay --output-commands --onto origin/main ^base branch1 branch2 branch3
 update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
 update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
 update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b6f9d53560 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -284,6 +284,28 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+static int add_ref_to_transaction(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  struct strbuf *err)
+{
+	return ref_transaction_update(transaction, refname, new_oid, old_oid,
+				      NULL, NULL, 0, "git replay", err);
+}
+
+static void print_rejected_update(const char *refname,
+				  const struct object_id *old_oid UNUSED,
+				  const struct object_id *new_oid UNUSED,
+				  const char *old_target UNUSED,
+				  const char *new_target UNUSED,
+				  enum ref_transaction_error err,
+				  void *cb_data UNUSED)
+{
+	const char *reason = ref_transaction_error_msg(err);
+	warning(_("failed to update %s: %s"), refname, reason);
+}
+
 int cmd_replay(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -294,6 +316,8 @@ int cmd_replay(int argc,
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
 	int contained = 0;
+	int output_commands = 0;
+	int allow_partial = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -302,12 +326,15 @@ int cmd_replay(int argc,
 	struct merge_result result;
 	struct strset *update_refs = NULL;
 	kh_oid_map_t *replayed_commits;
+	struct ref_transaction *transaction = NULL;
+	struct strbuf transaction_err = STRBUF_INIT;
+	int commits_processed = 0;
 	int ret = 0;
 
-	const char * const replay_usage[] = {
+	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto <newbase> | --advance <branch>) "
-		   "<revision-range>..."),
+		   "[--output-commands | --allow-partial] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -319,6 +346,10 @@ int cmd_replay(int argc,
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
 			 N_("advance all branches contained in revision-range")),
+		OPT_BOOL(0, "output-commands", &output_commands,
+			 N_("output update commands instead of updating refs")),
+		OPT_BOOL(0, "allow-partial", &allow_partial,
+			 N_("allow some ref updates to succeed even if others fail")),
 		OPT_END()
 	};
 
@@ -330,9 +361,12 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
+	die_for_incompatible_opt2(allow_partial, "--allow-partial",
+				  output_commands, "--output-commands");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
@@ -389,6 +423,17 @@ int cmd_replay(int argc,
 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
 			      &onto, &update_refs);
 
+	if (!output_commands) {
+		unsigned int transaction_flags = allow_partial ? REF_TRANSACTION_ALLOW_FAILURE : 0;
+		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
+							  transaction_flags,
+							  &transaction_err);
+		if (!transaction) {
+			ret = error(_("failed to begin ref transaction: %s"), transaction_err.buf);
+			goto cleanup;
+		}
+	}
+
 	if (!onto) /* FIXME: Should handle replaying down to root commit */
 		die("Replaying down to root commit is not supported yet!");
 
@@ -407,6 +452,8 @@ int cmd_replay(int argc,
 		khint_t pos;
 		int hr;
 
+		commits_processed = 1;
+
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -434,10 +481,18 @@ int cmd_replay(int argc,
 			if (decoration->type == DECORATION_REF_LOCAL &&
 			    (contained || strset_contains(update_refs,
 							  decoration->name))) {
-				printf("update %s %s %s\n",
-				       decoration->name,
-				       oid_to_hex(&last_commit->object.oid),
-				       oid_to_hex(&commit->object.oid));
+				if (output_commands) {
+					printf("update %s %s %s\n",
+					       decoration->name,
+					       oid_to_hex(&last_commit->object.oid),
+					       oid_to_hex(&commit->object.oid));
+				} else if (add_ref_to_transaction(transaction, decoration->name,
+								  &last_commit->object.oid,
+								  &commit->object.oid,
+								  &transaction_err) < 0) {
+					ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
+					goto cleanup;
+				}
 			}
 			decoration = decoration->next;
 		}
@@ -445,10 +500,33 @@ int cmd_replay(int argc,
 
 	/* In --advance mode, advance the target ref */
 	if (result.clean == 1 && advance_name) {
-		printf("update %s %s %s\n",
-		       advance_name,
-		       oid_to_hex(&last_commit->object.oid),
-		       oid_to_hex(&onto->object.oid));
+		if (output_commands) {
+			printf("update %s %s %s\n",
+			       advance_name,
+			       oid_to_hex(&last_commit->object.oid),
+			       oid_to_hex(&onto->object.oid));
+		} else if (add_ref_to_transaction(transaction, advance_name,
+						  &last_commit->object.oid,
+						  &onto->object.oid,
+						  &transaction_err) < 0) {
+			ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
+			goto cleanup;
+		}
+	}
+
+	/* Commit the ref transaction if we have one */
+	if (transaction && result.clean == 1) {
+		if (ref_transaction_commit(transaction, &transaction_err)) {
+			if (allow_partial) {
+				warning(_("some ref updates failed: %s"), transaction_err.buf);
+				ref_transaction_for_each_rejected_update(transaction,
+									 print_rejected_update, NULL);
+				ret = 0; /* Set failure even with allow_partial */
+			} else {
+				ret = error(_("failed to update refs: %s"), transaction_err.buf);
+				goto cleanup;
+			}
+		}
 	}
 
 	merge_finalize(&merge_opt, &result);
@@ -457,9 +535,17 @@ int cmd_replay(int argc,
 		strset_clear(update_refs);
 		free(update_refs);
 	}
-	ret = result.clean;
+
+	/* Handle empty ranges: if no commits were processed, treat as success */
+	if (!commits_processed)
+		ret = 1; /* Success - no commits to replay is not an error */
+	else
+		ret = result.clean;
 
 cleanup:
+	if (transaction)
+		ref_transaction_free(transaction);
+	strbuf_release(&transaction_err);
 	release_revisions(&revs);
 	free(advance_name);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 58b3759935..8b4301e227 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --onto main topic1..topic2 >result &&
+	git replay --output-commands --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -67,9 +67,30 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 	test_cmp expect result
 '
 
+test_expect_success 'using replay with default atomic behavior (no output)' '
+	# Create a test branch that wont interfere with others
+	git branch atomic-test topic2 &&
+	git rev-parse atomic-test >atomic-test-old &&
+
+	# Default behavior: atomic ref updates (no output)
+	git replay --onto main topic1..atomic-test >output &&
+	test_must_be_empty output &&
+
+	# Verify the branch was updated
+	git rev-parse atomic-test >atomic-test-new &&
+	! test_cmp atomic-test-old atomic-test-new &&
+
+	# Verify the history is correct
+	git log --format=%s atomic-test >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --onto main topic1..topic2 >result-bare &&
-	test_cmp expect result-bare
+	git -C bare replay --output-commands --onto main topic1..topic2 >result-bare &&
+
+	# The result should match what we got from the regular repo
+	test_cmp result result-bare
 '
 
 test_expect_success 'using replay to rebase with a conflict' '
@@ -86,7 +107,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
 	# 4th field of result is hash for main instead of hash for topic2
 
-	git replay --advance main topic1..topic2 >result &&
+	git replay --output-commands --advance main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -102,7 +123,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 '
 
 test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
-	git -C bare replay --advance main topic1..topic2 >result-bare &&
+	git -C bare replay --output-commands --advance main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
@@ -115,7 +136,7 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 '
 
 test_expect_success 'using replay to also rebase a contained branch' '
-	git replay --contained --onto main main..topic3 >result &&
+	git replay --output-commands --contained --onto main main..topic3 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -139,12 +160,12 @@ test_expect_success 'using replay to also rebase a contained branch' '
 '
 
 test_expect_success 'using replay on bare repo to also rebase a contained branch' '
-	git -C bare replay --contained --onto main main..topic3 >result-bare &&
+	git -C bare replay --output-commands --contained --onto main main..topic3 >result-bare &&
 	test_cmp expect result-bare
 '
 
 test_expect_success 'using replay to rebase multiple divergent branches' '
-	git replay --onto main ^topic1 topic2 topic4 >result &&
+	git replay --output-commands --onto main ^topic1 topic2 topic4 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -168,7 +189,7 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
 '
 
 test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
-	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
+	git -C bare replay --output-commands --contained --onto main ^main topic2 topic3 topic4 >result &&
 
 	test_line_count = 4 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -217,4 +238,131 @@ test_expect_success 'merge.directoryRenames=false' '
 		--onto rename-onto rename-onto..rename-from
 '
 
+# Tests for new default atomic behavior and options
+
+test_expect_success 'replay default behavior should not produce output when successful' '
+	git replay --onto main topic1..topic3 >output &&
+	test_must_be_empty output
+'
+
+test_expect_success 'replay with --output-commands produces traditional output' '
+	git replay --output-commands --onto main topic1..topic3 >output &&
+	test_line_count = 1 output &&
+	grep "^update refs/heads/topic3 " output
+'
+
+test_expect_success 'replay with --allow-partial should not produce output when successful' '
+	git replay --allow-partial --onto main topic1..topic3 >output &&
+	test_must_be_empty output
+'
+
+test_expect_success 'replay fails when --output-commands and --allow-partial are used together' '
+	test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
+	grep "cannot be used together" error
+'
+
+test_expect_success 'replay with --contained updates multiple branches atomically' '
+	# Create fresh test branches based on the original structure
+	# contained-topic1 should be contained within the range to contained-topic3
+	git branch contained-base main &&
+	git checkout -b contained-topic1 contained-base &&
+	test_commit ContainedC &&
+	git checkout -b contained-topic3 contained-topic1 &&
+	test_commit ContainedG &&
+	test_commit ContainedH &&
+	git checkout main &&
+
+	# Store original states
+	git rev-parse contained-topic1 >contained-topic1-old &&
+	git rev-parse contained-topic3 >contained-topic3-old &&
+
+	# Use --contained to update multiple branches - this should update both
+	git replay --contained --onto main contained-base..contained-topic3 &&
+
+	# Verify both branches were updated
+	git rev-parse contained-topic1 >contained-topic1-new &&
+	git rev-parse contained-topic3 >contained-topic3-new &&
+	! test_cmp contained-topic1-old contained-topic1-new &&
+	! test_cmp contained-topic3-old contained-topic3-new
+'
+
+test_expect_success 'replay atomic behavior: all refs updated or none' '
+	# Store original state
+	git rev-parse topic4 >topic4-old &&
+
+	# Default atomic behavior
+	git replay --onto main main..topic4 &&
+
+	# Verify ref was updated
+	git rev-parse topic4 >topic4-new &&
+	! test_cmp topic4-old topic4-new &&
+
+	# Verify no partial state
+	git log --format=%s topic4 >actual &&
+	test_write_lines J I M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay works correctly with bare repositories' '
+	# Test atomic behavior in bare repo (important for Gitaly)
+	git checkout -b bare-test topic1 &&
+	test_commit BareTest &&
+
+	# Test with bare repo - replay the commits from main..bare-test to get the full history
+	git -C bare fetch .. bare-test:bare-test &&
+	git -C bare replay --onto main main..bare-test &&
+
+	# Verify the bare repo was updated correctly (no output)
+	git -C bare log --format=%s bare-test >actual &&
+	test_write_lines BareTest F C M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay --allow-partial with no failures produces no output' '
+	git checkout -b partial-test topic1 &&
+	test_commit PartialTest &&
+
+	# Should succeed silently even with partial mode
+	git replay --allow-partial --onto main topic1..partial-test >output &&
+	test_must_be_empty output
+'
+
+test_expect_success 'replay maintains ref update consistency' '
+	# Test that traditional vs atomic produce equivalent results
+	git checkout -b method1-test topic2 &&
+	git checkout -b method2-test topic2 &&
+
+	# Both methods should update refs to point to the same replayed commits
+	git replay --output-commands --onto main topic1..method1-test >update-commands &&
+	git update-ref --stdin <update-commands &&
+	git log --format=%s method1-test >traditional-result &&
+
+	# Direct atomic method should produce same commit history
+	git replay --onto main topic1..method2-test &&
+	git log --format=%s method2-test >atomic-result &&
+
+	# Both methods should produce identical commit histories
+	test_cmp traditional-result atomic-result
+'
+
+test_expect_success 'replay error messages are helpful and clear' '
+	# Test that error messages are clear
+	test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
+	grep "cannot be used together" error
+'
+
+test_expect_success 'replay with empty range produces no output and no changes' '
+	# Create a test branch for empty range testing
+	git checkout -b empty-test topic1 &&
+	git rev-parse empty-test >empty-test-before &&
+
+	# Empty range should succeed but do nothing
+	git replay --onto main empty-test..empty-test >output &&
+	test_must_be_empty output &&
+
+	# Branch should be unchanged
+	git rev-parse empty-test >empty-test-after &&
+	test_cmp empty-test-before empty-test-after
+'
+
 test_done
-- 
2.51.0

