Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E312259CA5
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380419; cv=none; b=oT0wEbN6uAGnqqzWeqQcP9rS/n8Df9TrTWdQOvJR/CcHExQDq8pc3VoV81yMtvpC904uvZoGCBw+rJI0e78We6EY/LXRk1EYe14UDbts6xxomExvQS+lEGG5fXzxUNyWaHwNIE0LiqQ37n8RW7JHgMxwQoGn4N5HHj2vGu/lWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380419; c=relaxed/simple;
	bh=rAuoDz9fzgWmr0dVpAjtjIiKgDZgg+YpKX5R4U/55hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3ne1MbqVgbQ7mTDO1pT1HaXtJz0PSzY3LMyZGjD3gh72EWYyz2kt9RC6cGx7v2v33Go1f6YvhsLwLJ4UQJP+FzLgKMmagJ5DI+0boEfvvaOFD4cNWq28N7rHs5dCCETJvdJcrEKH5T4iJEpXISyf6+qGaJdUJHY1zRtosBmg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIk9Wr6X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIk9Wr6X"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28e8c5d64d8so41426925ad.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760380416; x=1760985216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOZVUi0QoCuxOkeblD4IcJwiS/yZY05qTvJMKPtsFiU=;
        b=hIk9Wr6XkbT0al69Ksvdox/K26xWQk6Ag7WQUh4LjAHnlw0ZQ04ChHpdSCdyf3ac0v
         1WdHPcnXozQZ+sXJujKyTfPB0HAqgGe04tLI8NpNx5S/Hqv4734fzKyCtdIlVny+UNAg
         Nlk57+WsmFk8VmdosGIZAS7aLDxhLbNjhwMd0MbaCTo1FqVm68eLmCSAGKDCh/tly4Va
         k7uf0SM037eUb4GKyGU71fb4SY+4nfNppuH3A4bSX4dpvxySuzhxFEVZdyjwCaqGecG2
         TUeM7bNT2GYXBVnvZrCxDBCFWq7eSC5WpKZkohW7PiRLbuFQdDY3jRHqlebmIGc3JHLK
         PXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380416; x=1760985216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOZVUi0QoCuxOkeblD4IcJwiS/yZY05qTvJMKPtsFiU=;
        b=W3WH7QjR0sd6aXOsItx1Cr7wPiFvvwHH/Iui9gLrAWuc85GP5za2iPlKR+PCditl1E
         Zvg+YGdrP5AS3fqMXceGww9D3ZdDfhl6inLuZaqdEtUzR4W5ThRY+7zZWWihVYmMa3q9
         iGpPZZO7qbebAodzK8us5a24aev2ltGjB1YvRsKyqzcv0iwdDZdG9WFuM2I++IDu3o9h
         Mq7EUq8/l4kc64jXgsK+BthKTXObAL5BFfDgY8Vwemu5BgIA7gEwQQJXRxnQcFLjb3o1
         cIbx2pNSvpVG+MIyCkGbdlcw+TjO8ueElGZKFUITjch1TG2fMfjTXj0hGhMoHsc6/RBZ
         A/7A==
X-Gm-Message-State: AOJu0YyH3Q6F1msX0kBvVgLkOMe4BqsEQHpMkzfXpcyW/MDL/RKjEFVS
	z6xOhkGfXxE/ZSdp6/QiGqvdAhY9EQhbEyuLHXx7q61hllxgJ9AK6YTmWbZvR8m6hLw=
X-Gm-Gg: ASbGncvyGTn/1Z41TwyDeppAq42gKXXSllIapMRB9Lnf9HfBQIR5vp8Ez6SYnDcmZID
	3zFosEZzTSxxyjRDmQoqXDCSchyFc6feGpVaMuxJjWp+ImhS+qAFJJTddf4Hw+5eBXnwI8lT3lL
	jifMQ2oD0qKWYzEf8p3PEudbA1P2yCyS87uJunt4oikrzLzAiS2r7Eox44PIVHJBD6oJ/grg01B
	/yfjUxt1GwOf0AAleNPs+FnO7g5mTeEYOq5SMrXJ54pQZ8azbynJmt4J8bOP2BAhiYQgiih86TZ
	Ito2hY1B8l3Wkg3J5GGG7wjA/0ww0mkH2cCm51IMMj8DPCii4Q0f/kBkKT4cYOwd6ZLEh0qtpPB
	7Xv/DaLlROVxZD2iyZwXJnmzNeFSmyotc4UD+j4oXlSI7wPN1QjCAI19H0nqGpg1ggZVh4xmxDh
	W2zLK1pbjkI9lHQ6z+4OAxVaT4fQBGUlgVx3B4iNOpJxUjv7zQup/ot7uk2tP2Hgi8qw7unQ==
X-Google-Smtp-Source: AGHT+IEWcP2BUxiiJ00pPIuPWAG2ffwpHF1nvfqty/c8TXOj5k0Zy2iBL/HNCHSHUG3zxevt03OoKA==
X-Received: by 2002:a17:903:19e8:b0:283:c950:a76f with SMTP id d9443c01a7336-290273ffc69mr294897435ad.43.1760380415631;
        Mon, 13 Oct 2025 11:33:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:dc83:edd1:7853:510f:d37e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm140019905ad.13.2025.10.13.11.33.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 11:33:35 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 2/3] replay: make atomic ref updates the default behavior
Date: Tue, 14 Oct 2025 00:03:10 +0530
Message-ID: <20251013183311.33329-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013183311.33329-1-siddharthasthana31@gmail.com>
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The git replay command currently outputs update commands that can be
piped to update-ref to achieve a rebase, e.g.

  git replay --onto main topic1..topic2 | git update-ref --stdin

This separation had advantages for three special cases:
  * it made testing easy (when state isn't modified from one step to
    the next, you don't need to make temporary branches or have undo
    commands, or try to track the changes)
  * it provided a natural can-it-rebase-cleanly (and what would it
    rebase to) capability without automatically updating refs, similar
    to a --dry-run
  * it provided a natural low-level tool for the suite of hash-object,
    mktree, commit-tree, mktag, merge-tree, and update-ref, allowing
    users to have another building block for experimentation and making
    new tools

However, it should be noted that all three of these are somewhat
special cases; users, whether on the client or server side, would
almost certainly find it more ergonomical to simply have the updating
of refs be the default.

For server-side operations in particular, the pipeline architecture
creates process coordination overhead. Server implementations that need
to perform rebases atomically must maintain additional code to:

  1. Spawn and manage a pipeline between git-replay and git-update-ref
  2. Coordinate stdout/stderr streams across the pipe boundary
  3. Handle partial failure states if the pipeline breaks mid-execution
  4. Parse and validate the update-ref command output

Change the default behavior to update refs directly, and atomically (at
least to the extent supported by the refs backend in use). This
eliminates the process coordination overhead for the common case.

For users needing the traditional pipeline workflow, add a new
`--update-refs=<mode>` option that preserves the original behavior:

  git replay --update-refs=print --onto main topic1..topic2 | git update-ref --stdin

The mode can be:
  * `yes` (default): Update refs directly using an atomic transaction
  * `print`: Output update-ref commands for pipeline use

Implementation details:

The atomic ref updates are implemented using Git's ref transaction API.
In cmd_replay(), when not in 'print' mode, we initialize a transaction
using ref_store_transaction_begin() with the default atomic behavior.
As commits are replayed, ref updates are staged into the transaction
using ref_transaction_update(). Finally, ref_transaction_commit()
applies all updates atomically—either all updates succeed or none do.

To avoid code duplication between the 'print' and 'yes' modes, this
commit extracts a handle_ref_update() helper function. This function
takes the mode and either prints the update command or stages it into
the transaction. This keeps both code paths consistent and makes future
maintenance easier.

The helper function signature:

  static int handle_ref_update(const char *mode,
                                struct ref_transaction *transaction,
                                const char *refname,
                                const struct object_id *new_oid,
                                const struct object_id *old_oid,
                                struct strbuf *err)

When mode is 'print', it prints the update-ref command. When mode is
'yes', it calls ref_transaction_update() to stage the update. This
eliminates the duplication that would otherwise exist at each ref update
call site.

Test suite changes:

All existing tests that expected command output now use
`--update-refs=print` to preserve their original behavior. This keeps
the tests valid while allowing them to verify that the pipeline workflow
still works correctly.

New tests were added to verify:
  - Default atomic behavior (no output, refs updated directly)
  - Bare repository support (server-side use case)
  - Equivalence between traditional pipeline and atomic updates
  - Real atomicity using a lock file to verify all-or-nothing guarantee
  - Test isolation using test_when_finished to clean up state

The bare repository tests were fixed to rebuild their expectations
independently rather than comparing to previous test output, improving
test reliability and isolation.

A following commit will add a `replay.defaultAction` configuration
option for users who prefer the traditional pipeline output as their
default behavior.

Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc |  71 ++++++++++------
 builtin/replay.c              |  88 ++++++++++++++++---
 t/t3650-replay-basics.sh      | 153 ++++++++++++++++++++++++++++++++--
 3 files changed, 267 insertions(+), 45 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 0b12bf8aa4..ea04021a5f 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,15 +9,17 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>)
+		[--update-refs[=<mode>]] <revision-range>...
 
 DESCRIPTION
 -----------
 
 Takes ranges of commits and replays them onto a new location. Leaves
-the working tree and the index untouched, and updates no references.
-The output of this command is meant to be used as input to
-`git update-ref --stdin`, which would update the relevant branches
+the working tree and the index untouched. By default, updates the
+relevant references using an atomic transaction (all refs update or
+none). Use `--update-refs=print` to avoid automatic ref updates and
+instead get update commands that can be piped to `git update-ref --stdin`
 (see the OUTPUT section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
@@ -29,18 +31,28 @@ OPTIONS
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-When `--onto` is specified, the update-ref command(s) in the output will
-update the branch(es) in the revision range to point at the new
-commits, similar to the way how `git rebase --update-refs` updates
-multiple branches in the affected range.
+When `--onto` is specified, the branch(es) in the revision range will be
+updated to point at the new commits (or update commands will be printed
+if `--update-refs=print` is used), similar to the way how
+`git rebase --update-refs` updates multiple branches in the affected range.
 
 --advance <branch>::
 	Starting point at which to create the new commits; must be a
 	branch name.
 +
-When `--advance` is specified, the update-ref command(s) in the output
-will update the branch passed as an argument to `--advance` to point at
-the new commits (in other words, this mimics a cherry-pick operation).
+When `--advance` is specified, the branch passed as an argument will be
+updated to point at the new commits (or an update command will be printed
+if `--update-refs=print` is used). This mimics a cherry-pick operation.
+
+--update-refs[=<mode>]::
+	Control how references are updated. The mode can be:
++
+--
+* `yes` (default): Update refs directly using an atomic transaction.
+  All ref updates succeed or all fail.
+* `print`: Output update-ref commands instead of updating refs.
+  The output can be piped as-is to `git update-ref --stdin`.
+--
 
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
@@ -54,15 +66,19 @@ include::rev-list-options.adoc[]
 OUTPUT
 ------
 
-When there are no conflicts, the output of this command is usable as
-input to `git update-ref --stdin`.  It is of the form:
+By default, when there are no conflicts, this command updates the relevant
+references using an atomic transaction and produces no output. All ref
+updates succeed or all fail.
+
+When `--update-refs=print` is used, the output is usable as input to
+`git update-ref --stdin`. It is of the form:
 
 	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
 	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
 where the number of refs updated depends on the arguments passed and
-the shape of the history being replayed.  When using `--advance`, the
+the shape of the history being replayed. When using `--advance`, the
 number of refs updated is always one, but for `--onto`, it can be one
 or more (rebasing multiple branches simultaneously is supported).
 
@@ -77,44 +93,45 @@ is something other than 0 or 1.
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
+To get the traditional pipeline output:
+
+------------
+$ git replay --update-refs=print --onto target origin/main..mybranch
+update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
+------------
 
 What if you have a stack of branches, one depending upon another, and
 you'd really like to rebase the whole set?
 
 ------------
 $ git replay --contained --onto origin/main origin/main..tipbranch
-update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
-update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
-update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
 ------------
 
+This automatically finds and rebases all branches contained within the
+`origin/main..tipbranch` range.
+
 When calling `git replay`, one does not need to specify a range of
-commits to replay using the syntax `A..B`; any range expression will
-do:
+commits to replay using the syntax `A..B`; any range expression will do:
 
 ------------
 $ git replay --onto origin/main ^base branch1 branch2 branch3
-update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
-update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
-update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 ------------
 
 This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
diff --git a/builtin/replay.c b/builtin/replay.c
index b64fc72063..457225363e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -284,6 +284,26 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+static int handle_ref_update(const char *mode,
+			     struct ref_transaction *transaction,
+			     const char *refname,
+			     const struct object_id *new_oid,
+			     const struct object_id *old_oid,
+			     struct strbuf *err)
+{
+	if (!strcmp(mode, "print")) {
+		printf("update %s %s %s\n",
+		       refname,
+		       oid_to_hex(new_oid),
+		       oid_to_hex(old_oid));
+		return 0;
+	}
+
+	/* mode == "yes" - update refs directly */
+	return ref_transaction_update(transaction, refname, new_oid, old_oid,
+				      NULL, NULL, 0, "git replay", err);
+}
+
 int cmd_replay(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -294,6 +314,7 @@ int cmd_replay(int argc,
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
 	int contained = 0;
+	const char *update_refs_mode = NULL;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -302,12 +323,14 @@ int cmd_replay(int argc,
 	struct merge_result result;
 	struct strset *update_refs = NULL;
 	kh_oid_map_t *replayed_commits;
+	struct ref_transaction *transaction = NULL;
+	struct strbuf transaction_err = STRBUF_INIT;
 	int ret = 0;
 
-	const char * const replay_usage[] = {
+	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto <newbase> | --advance <branch>) "
-		   "<revision-range>..."),
+		   "[--update-refs[=<mode>]] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -319,6 +342,9 @@ int cmd_replay(int argc,
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
 			 N_("advance all branches contained in revision-range")),
+		OPT_STRING(0, "update-refs", &update_refs_mode,
+			   N_("mode"),
+			   N_("control ref update behavior (yes|print)")),
 		OPT_END()
 	};
 
@@ -333,6 +359,15 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
+	/* Set default mode if not specified */
+	if (!update_refs_mode)
+		update_refs_mode = "yes";
+
+	/* Validate update-refs mode */
+	if (strcmp(update_refs_mode, "yes") && strcmp(update_refs_mode, "print"))
+		die(_("invalid value for --update-refs: '%s' (expected 'yes' or 'print')"),
+		    update_refs_mode);
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
@@ -389,6 +424,17 @@ int cmd_replay(int argc,
 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
 			      &onto, &update_refs);
 
+	/* Initialize ref transaction if we're updating refs directly */
+	if (!strcmp(update_refs_mode, "yes")) {
+		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
+							  0, &transaction_err);
+		if (!transaction) {
+			ret = error(_("failed to begin ref transaction: %s"),
+				    transaction_err.buf);
+			goto cleanup;
+		}
+	}
+
 	if (!onto) /* FIXME: Should handle replaying down to root commit */
 		die("Replaying down to root commit is not supported yet!");
 
@@ -434,10 +480,15 @@ int cmd_replay(int argc,
 			if (decoration->type == DECORATION_REF_LOCAL &&
 			    (contained || strset_contains(update_refs,
 							  decoration->name))) {
-				printf("update %s %s %s\n",
-				       decoration->name,
-				       oid_to_hex(&last_commit->object.oid),
-				       oid_to_hex(&commit->object.oid));
+				if (handle_ref_update(update_refs_mode, transaction,
+						      decoration->name,
+						      &last_commit->object.oid,
+						      &commit->object.oid,
+						      &transaction_err) < 0) {
+					ret = error(_("failed to update ref '%s': %s"),
+						    decoration->name, transaction_err.buf);
+					goto cleanup;
+				}
 			}
 			decoration = decoration->next;
 		}
@@ -445,10 +496,24 @@ int cmd_replay(int argc,
 
 	/* In --advance mode, advance the target ref */
 	if (result.clean == 1 && advance_name) {
-		printf("update %s %s %s\n",
-		       advance_name,
-		       oid_to_hex(&last_commit->object.oid),
-		       oid_to_hex(&onto->object.oid));
+		if (handle_ref_update(update_refs_mode, transaction,
+				      advance_name,
+				      &last_commit->object.oid,
+				      &onto->object.oid,
+				      &transaction_err) < 0) {
+			ret = error(_("failed to update ref '%s': %s"),
+				    advance_name, transaction_err.buf);
+			goto cleanup;
+		}
+	}
+
+	/* Commit the ref transaction if we have one */
+	if (transaction && result.clean == 1) {
+		if (ref_transaction_commit(transaction, &transaction_err)) {
+			ret = error(_("failed to commit ref transaction: %s"),
+				    transaction_err.buf);
+			goto cleanup;
+		}
 	}
 
 	merge_finalize(&merge_opt, &result);
@@ -460,6 +525,9 @@ int cmd_replay(int argc,
 	ret = result.clean;
 
 cleanup:
+	if (transaction)
+		ref_transaction_free(transaction);
+	strbuf_release(&transaction_err);
 	release_revisions(&revs);
 	free(advance_name);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 58b3759935..c2c54fbba7 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --onto main topic1..topic2 >result &&
+	git replay --update-refs=print --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -67,8 +67,34 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 	test_cmp expect result
 '
 
+test_expect_success 'using replay with default atomic behavior (no output)' '
+	# Store the original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
+	# Default behavior: atomic ref updates (no output)
+	git replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify the history is correct
+	git log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --onto main topic1..topic2 >result-bare &&
+	git -C bare replay --update-refs=print --onto main topic1..topic2 >result-bare &&
+
+	test_line_count = 1 result-bare &&
+
+	git log --format=%s $(cut -f 3 -d " " result-bare) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $(cut -f 3 -d " " result-bare) >>expect &&
+	git -C bare rev-parse topic2 >>expect &&
+
 	test_cmp expect result-bare
 '
 
@@ -86,7 +112,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
 	# 4th field of result is hash for main instead of hash for topic2
 
-	git replay --advance main topic1..topic2 >result &&
+	git replay --update-refs=print --advance main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -102,7 +128,18 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 '
 
 test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
-	git -C bare replay --advance main topic1..topic2 >result-bare &&
+	git -C bare replay --update-refs=print --advance main topic1..topic2 >result-bare &&
+
+	test_line_count = 1 result-bare &&
+
+	git log --format=%s $(cut -f 3 -d " " result-bare) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/main " >expect &&
+	printf "%s " $(cut -f 3 -d " " result-bare) >>expect &&
+	git -C bare rev-parse main >>expect &&
+
 	test_cmp expect result-bare
 '
 
@@ -115,7 +152,7 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 '
 
 test_expect_success 'using replay to also rebase a contained branch' '
-	git replay --contained --onto main main..topic3 >result &&
+	git replay --update-refs=print --contained --onto main main..topic3 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -139,12 +176,31 @@ test_expect_success 'using replay to also rebase a contained branch' '
 '
 
 test_expect_success 'using replay on bare repo to also rebase a contained branch' '
-	git -C bare replay --contained --onto main main..topic3 >result-bare &&
+	git -C bare replay --update-refs=print --contained --onto main main..topic3 >result-bare &&
+
+	test_line_count = 2 result-bare &&
+	cut -f 3 -d " " result-bare >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines H G F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic1 " >expect &&
+	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
+	git -C bare rev-parse topic1 >>expect &&
+	printf "update refs/heads/topic3 " >>expect &&
+	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
+	git -C bare rev-parse topic3 >>expect &&
+
 	test_cmp expect result-bare
 '
 
 test_expect_success 'using replay to rebase multiple divergent branches' '
-	git replay --onto main ^topic1 topic2 topic4 >result &&
+	git replay --update-refs=print --onto main ^topic1 topic2 topic4 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -168,7 +224,7 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
 '
 
 test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
-	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
+	git -C bare replay --update-refs=print --contained --onto main ^main topic2 topic3 topic4 >result &&
 
 	test_line_count = 4 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -217,4 +273,85 @@ test_expect_success 'merge.directoryRenames=false' '
 		--onto rename-onto rename-onto..rename-from
 '
 
+# Tests for atomic ref update behavior
+
+test_expect_success 'replay with --contained updates multiple branches atomically' '
+	# Store original states
+	START_TOPIC1=$(git rev-parse topic1) &&
+	START_TOPIC3=$(git rev-parse topic3) &&
+	test_when_finished "git branch -f topic1 $START_TOPIC1 && git branch -f topic3 $START_TOPIC3" &&
+
+	# Use --contained to update multiple branches
+	git replay --contained --onto main main..topic3 >output &&
+	test_must_be_empty output &&
+
+	# Verify both branches were updated with correct commit sequences
+	git log --format=%s topic1 >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s topic3 >actual &&
+	test_write_lines H G F C M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay atomic guarantee: all refs updated or none' '
+	# Store original states
+	START_TOPIC1=$(git rev-parse topic1) &&
+	START_TOPIC3=$(git rev-parse topic3) &&
+	test_when_finished "git branch -f topic1 $START_TOPIC1 && git branch -f topic3 $START_TOPIC3 && rm -f .git/refs/heads/topic1.lock" &&
+
+	# Create a lock on topic1 to simulate a concurrent update
+	>.git/refs/heads/topic1.lock &&
+
+	# Try to update multiple branches with --contained
+	# This should fail atomically - neither branch should be updated
+	test_must_fail git replay --contained --onto main main..topic3 2>error &&
+
+	# Verify the transaction failed
+	grep "failed to commit ref transaction" error &&
+
+	# Verify NEITHER branch was updated (all-or-nothing guarantee)
+	test_cmp_rev $START_TOPIC1 topic1 &&
+	test_cmp_rev $START_TOPIC3 topic3
+'
+
+test_expect_success 'traditional pipeline and atomic update produce equivalent results' '
+	# Store original states
+	START_TOPIC2=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START_TOPIC2" &&
+
+	# Traditional method: output commands and pipe to update-ref
+	git replay --update-refs=print --onto main topic1..topic2 >update-commands &&
+	git update-ref --stdin <update-commands &&
+	git log --format=%s topic2 >traditional-result &&
+
+	# Reset topic2
+	git branch -f topic2 $START_TOPIC2 &&
+
+	# Atomic method: direct ref updates
+	git replay --onto main topic1..topic2 &&
+	git log --format=%s topic2 >atomic-result &&
+
+	# Both methods should produce identical commit histories
+	test_cmp traditional-result atomic-result
+'
+
+test_expect_success 'replay works correctly with bare repositories' '
+	# Test atomic behavior in bare repo
+	git -C bare fetch .. topic1:bare-test-branch &&
+	git -C bare replay --onto main main..bare-test-branch >output &&
+	test_must_be_empty output &&
+
+	# Verify the bare repo was updated correctly
+	git -C bare log --format=%s bare-test-branch >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay validates --update-refs mode values' '
+	test_must_fail git replay --update-refs=invalid --onto main topic1..topic2 2>error &&
+	grep "invalid value for --update-refs" error
+'
+
 test_done
-- 
2.51.0

