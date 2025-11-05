Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CB31618E
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370247; cv=none; b=bM9TXD1TJ4r5F2oVeoBudSRgz4Er+5FLrMurMfv2QgiHO0I1DlWkKeOrhsep5AWL95/i49bAWk8zXcwU0WTVMnCUMjnm/7mWb5IaCes7R8k5a/I/WBZWNEirJMm12PoFUvIrZYU4KBmK/t2afSyj6D/s9I5wKyeYlj2rp8FDKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370247; c=relaxed/simple;
	bh=ec9MTHw5+ILGq8NoC+ak++HvV0Yd9rJcelRVK8ZaGFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuNqSmEywXfSYVszFKeGU+qjMPS8dSJzKIGm2coluT9DkrC+uHn3IcpE+YzQ2v7oRqRh612xJS4dgefcfkGFPRQ8FX6NfeDLDky6iiWJxjGwuqIRmA9tuJzEv+9pb1kii7Y3lqyGn4Tn/zrldlFI52IoBt0ftIXSCZaJx39xZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5mIUJSD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5mIUJSD"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so182467a91.2
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370242; x=1762975042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6qD1CVXUj1TMT9jz353AUlceDHc/Lh7haXyePRulGY=;
        b=h5mIUJSDbQMWj9o+MRswC61XqYxvr9tLx40nAmkp/E9K2ovGtEgCkU+QZZ+Qi2NZh1
         cbh3W527r3zKiQqtuW8YnmqEy6QDYPDukTx8MdDu3LDaXbcJLdO/eJobivO9lKUQvrdr
         BxUvIBZQx39zcAzNAdfZIweLMGYrQTXVF8rXAJnWYYZZTReoEBgg/b6UA3lpWHzZqUMG
         fTE1/Nuo9awXZakxSSqXfTyWLxcGIsOWHaJLTb4ztJf+V9aljwll54mO66HeuhMd1FCV
         1/RrhPoeD1DIUcPTq9i1UrFhJmBwpoDTK0l22JK9lOyF9qufkhxhPr5/FM3Fe+yC5bzu
         B7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370242; x=1762975042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6qD1CVXUj1TMT9jz353AUlceDHc/Lh7haXyePRulGY=;
        b=jXqUUUQ/ar0AuCH/zmk4hqZFtaUabOQp7nN7g2oBVInxjlxwzftzvX08jKKeoUqEtT
         BUZnxY6gSWwu7ZwnwGmpAS1eMLWz0ri8tQM72lnEtpLAyeEDN1nOMYzJSIy6xfgyDV1Y
         NHxvzYDXgcDYBwtLVxFnE+WeoAV8JBWKU88kIXKpMnliISTjh3ddIhNUBrjbRqIn3oBs
         dIOAIWuVU2KTsPLdvJDbbuBGUtdiqMi6N9Ya4u5n2oaiXtiTHvTuR+4uprA3VHd5oJAW
         ZDauzxxEuZVV8PnpZGaDz2Xl/epX2fchUm7+fRd/DOdYIPKpMzhMUbbyxATcA+JUmTVu
         RG2w==
X-Gm-Message-State: AOJu0Yw4uGwhsinV/ic/eI1gqZ2ngBxP407/e01E3rluC/pmmZy/mwxG
	/5hwSuMRZniGJU3MFqe0nJq6SfOoNV2dvSyVOog0/qLYue1AvnzUXfBdSLgLGU8o
X-Gm-Gg: ASbGnctB6Ew8Dxb310eeggX6gq4Ycp87V7KekjCXafJROhAnLzkHMYSCzTmxozhiuAn
	ZURVnRI0BtCcbNlijezN8aPvFpPrJ1royNvlRDP1ehk3eIg+RApuc9Mk5KQpzNRcmSccohPjRya
	Z6963phuEwZSugnpcldSa4+/SJBQme3heT67tOPCWOovjOCXv23nG1XaF6s7Efr4RzpQy8/5/sD
	dRmbyk9Pt8K+DESnjjORCa927vggwJ8+ESWDFkuxLiqUsSr3MY1IvX0llcqcH2DhntpjWOqkLVR
	LLviL+XuF2WyxsouKSFXOVCB0w1aUjVA7yKfKxtDtjPWmRKBv/yKuRYzcq0FBi+hII1s+RzrvAs
	LmIncacytbAKzwbgKac7pYAVUj9Wmlb/kDPphMzRVG3Yr3UsrJZ1FhivddNZMdqNRqDqvbWXObA
	vnmcy6aVbrBoMEs2gRtN8IBTbU74VxaJrfvbx9f9IPNmNaydLsOJj73NtqRrsgRXcAPHYfLtakX
	VOq0GnoMk3VErsEzQ1TQcHC/rvVBtQz4w==
X-Google-Smtp-Source: AGHT+IECHcPlic1jncF3wAkfSoZfuEZMkUE5W5ebUu5y1gynRtAp8UOXpLdFWeEjJDIVqR+qU3J8hw==
X-Received: by 2002:a17:90b:548c:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-341a6c00cb7mr5252314a91.1.1762370241564;
        Wed, 05 Nov 2025 11:17:21 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bc8e9b7sm3056687a91.2.2025.11.05.11.17.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Nov 2025 11:17:20 -0800 (PST)
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
Subject: [PATCH v7 2/3] replay: make atomic ref updates the default behavior
Date: Thu,  6 Nov 2025 00:46:00 +0530
Message-ID: <20251105191650.89975-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105191650.89975-1-siddharthasthana31@gmail.com>
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
almost certainly find it more ergonomic to simply have the updating
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
--ref-action=<mode> option that preserves the original behavior:

  git replay --ref-action=print --onto main topic1..topic2 | git update-ref --stdin

The mode can be:
  * update (default): Update refs directly using an atomic transaction
  * print: Output update-ref commands for pipeline use

Test suite changes:

All existing tests that expected command output now use
--ref-action=print to preserve their original behavior. This keeps
the tests valid while allowing them to verify that the pipeline workflow
still works correctly.

New tests were added to verify:
  - Default atomic behavior (no output, refs updated directly)
  - Bare repository support (server-side use case)
  - Equivalence between traditional pipeline and atomic updates
  - Real atomicity using a lock file to verify all-or-nothing guarantee
  - Test isolation using test_when_finished to clean up state
  - Reflog messages include replay mode and target

A following commit will add a replay.refAction configuration
option for users who prefer the traditional pipeline output as their
default behavior.

Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc |  61 ++++++++++++-------
 builtin/replay.c              | 111 +++++++++++++++++++++++++++++++---
 t/t3650-replay-basics.sh      |  67 +++++++++++++++++---
 3 files changed, 199 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 0b12bf8aa4..2ef74ddb12 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,15 +9,16 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
 
 DESCRIPTION
 -----------
 
 Takes ranges of commits and replays them onto a new location. Leaves
-the working tree and the index untouched, and updates no references.
-The output of this command is meant to be used as input to
-`git update-ref --stdin`, which would update the relevant branches
+the working tree and the index untouched. By default, updates the
+relevant references using an atomic transaction (all refs update or
+none). Use `--ref-action=print` to avoid automatic ref updates and
+instead get update commands that can be piped to `git update-ref --stdin`
 (see the OUTPUT section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
@@ -29,18 +30,27 @@ OPTIONS
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-When `--onto` is specified, the update-ref command(s) in the output will
-update the branch(es) in the revision range to point at the new
-commits, similar to the way how `git rebase --update-refs` updates
-multiple branches in the affected range.
+When `--onto` is specified, the branch(es) in the revision range will be
+updated to point at the new commits, similar to the way `git rebase --update-refs`
+updates multiple branches in the affected range.
 
 --advance <branch>::
 	Starting point at which to create the new commits; must be a
 	branch name.
 +
-When `--advance` is specified, the update-ref command(s) in the output
-will update the branch passed as an argument to `--advance` to point at
-the new commits (in other words, this mimics a cherry-pick operation).
+The history is replayed on top of the <branch> and <branch> is updated to
+point at the tip of the resulting history. This is different from `--onto`,
+which uses the target only as a starting point without updating it.
+
+--ref-action[=<mode>]::
+	Control how references are updated. The mode can be:
++
+--
+	* `update` (default): Update refs directly using an atomic transaction.
+	  All refs are updated or none are (all-or-nothing behavior).
+	* `print`: Output update-ref commands for pipeline use. This is the
+	  traditional behavior where output can be piped to `git update-ref --stdin`.
+--
 
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
@@ -54,8 +64,11 @@ include::rev-list-options.adoc[]
 OUTPUT
 ------
 
-When there are no conflicts, the output of this command is usable as
-input to `git update-ref --stdin`.  It is of the form:
+By default, or with `--ref-action=update`, this command produces no output on
+success, as refs are updated directly using an atomic transaction.
+
+When using `--ref-action=print`, the output is usable as input to
+`git update-ref --stdin`. It is of the form:
 
 	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
 	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
@@ -81,6 +94,14 @@ To simply rebase `mybranch` onto `target`:
 
 ------------
 $ git replay --onto target origin/main..mybranch
+------------
+
+The refs are updated atomically and no output is produced on success.
+
+To see what would be updated without actually updating:
+
+------------
+$ git replay --ref-action=print --onto target origin/main..mybranch
 update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
 ------------
 
@@ -88,33 +109,29 @@ To cherry-pick the commits from mybranch onto target:
 
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
 
 What if you have a stack of branches, one depending upon another, and
 you'd really like to rebase the whole set?
 
 ------------
 $ git replay --contained --onto origin/main origin/main..tipbranch
-update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
-update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
-update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
 ------------
 
+All three branches (`branch1`, `branch2`, and `tipbranch`) are updated
+atomically.
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
 
 ------------
 $ git replay --onto origin/main ^base branch1 branch2 branch3
-update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
-update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
-update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 ------------
 
 This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
diff --git a/builtin/replay.c b/builtin/replay.c
index b64fc72063..94e60b5b10 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -20,6 +20,11 @@
 #include <oidset.h>
 #include <tree.h>
 
+enum ref_action_mode {
+	REF_ACTION_UPDATE,
+	REF_ACTION_PRINT,
+};
+
 static const char *short_commit_name(struct repository *repo,
 				     struct commit *commit)
 {
@@ -284,6 +289,38 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
+{
+	if (!ref_action || !strcmp(ref_action, "update"))
+		return REF_ACTION_UPDATE;
+	if (!strcmp(ref_action, "print"))
+		return REF_ACTION_PRINT;
+	die(_("invalid %s value: '%s'"), source, ref_action);
+}
+
+static int handle_ref_update(enum ref_action_mode mode,
+			     struct ref_transaction *transaction,
+			     const char *refname,
+			     const struct object_id *new_oid,
+			     const struct object_id *old_oid,
+			     const char *reflog_msg,
+			     struct strbuf *err)
+{
+	switch (mode) {
+	case REF_ACTION_PRINT:
+		printf("update %s %s %s\n",
+		       refname,
+		       oid_to_hex(new_oid),
+		       oid_to_hex(old_oid));
+		return 0;
+	case REF_ACTION_UPDATE:
+		return ref_transaction_update(transaction, refname, new_oid, old_oid,
+					      NULL, NULL, 0, reflog_msg, err);
+	default:
+		BUG("unknown ref_action_mode %d", mode);
+	}
+}
+
 int cmd_replay(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -294,6 +331,8 @@ int cmd_replay(int argc,
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
 	int contained = 0;
+	const char *ref_action = NULL;
+	enum ref_action_mode ref_mode = REF_ACTION_UPDATE;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -302,12 +341,15 @@ int cmd_replay(int argc,
 	struct merge_result result;
 	struct strset *update_refs = NULL;
 	kh_oid_map_t *replayed_commits;
+	struct ref_transaction *transaction = NULL;
+	struct strbuf transaction_err = STRBUF_INIT;
+	struct strbuf reflog_msg = STRBUF_INIT;
 	int ret = 0;
 
-	const char * const replay_usage[] = {
+	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto <newbase> | --advance <branch>) "
-		   "<revision-range>..."),
+		   "[--ref-action[=<mode>]] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -319,6 +361,9 @@ int cmd_replay(int argc,
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
 			 N_("advance all branches contained in revision-range")),
+		OPT_STRING(0, "ref-action", &ref_action,
+			   N_("mode"),
+			   N_("control ref update behavior (update|print)")),
 		OPT_END()
 	};
 
@@ -333,6 +378,10 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
+	/* Parse ref action mode */
+	if (ref_action)
+		ref_mode = parse_ref_action_mode(ref_action, "--ref-action");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
@@ -389,6 +438,24 @@ int cmd_replay(int argc,
 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
 			      &onto, &update_refs);
 
+	/* Build reflog message */
+	if (advance_name_opt)
+		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
+	else
+		strbuf_addf(&reflog_msg, "replay --onto %s",
+			    oid_to_hex(&onto->object.oid));
+
+	/* Initialize ref transaction if using update mode */
+	if (ref_mode == REF_ACTION_UPDATE) {
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
 
@@ -434,10 +501,16 @@ int cmd_replay(int argc,
 			if (decoration->type == DECORATION_REF_LOCAL &&
 			    (contained || strset_contains(update_refs,
 							  decoration->name))) {
-				printf("update %s %s %s\n",
-				       decoration->name,
-				       oid_to_hex(&last_commit->object.oid),
-				       oid_to_hex(&commit->object.oid));
+				if (handle_ref_update(ref_mode, transaction,
+						      decoration->name,
+						      &last_commit->object.oid,
+						      &commit->object.oid,
+						      reflog_msg.buf,
+						      &transaction_err) < 0) {
+					ret = error(_("failed to update ref '%s': %s"),
+						    decoration->name, transaction_err.buf);
+					goto cleanup;
+				}
 			}
 			decoration = decoration->next;
 		}
@@ -445,10 +518,24 @@ int cmd_replay(int argc,
 
 	/* In --advance mode, advance the target ref */
 	if (result.clean == 1 && advance_name) {
-		printf("update %s %s %s\n",
-		       advance_name,
-		       oid_to_hex(&last_commit->object.oid),
-		       oid_to_hex(&onto->object.oid));
+		if (handle_ref_update(ref_mode, transaction, advance_name,
+				      &last_commit->object.oid,
+				      &onto->object.oid,
+				      reflog_msg.buf,
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
@@ -460,6 +547,10 @@ int cmd_replay(int argc,
 	ret = result.clean;
 
 cleanup:
+	if (transaction)
+		ref_transaction_free(transaction);
+	strbuf_release(&transaction_err);
+	strbuf_release(&reflog_msg);
 	release_revisions(&revs);
 	free(advance_name);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 58b3759935..ec79234c80 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --onto main topic1..topic2 >result &&
+	git replay --ref-action=print --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -68,7 +68,7 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 '
 
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --onto main topic1..topic2 >result-bare &&
+	git -C bare replay --ref-action=print --onto main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
@@ -86,7 +86,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
 	# 4th field of result is hash for main instead of hash for topic2
 
-	git replay --advance main topic1..topic2 >result &&
+	git replay --ref-action=print --advance main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -102,7 +102,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 '
 
 test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
-	git -C bare replay --advance main topic1..topic2 >result-bare &&
+	git -C bare replay --ref-action=print --advance main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
@@ -115,7 +115,7 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 '
 
 test_expect_success 'using replay to also rebase a contained branch' '
-	git replay --contained --onto main main..topic3 >result &&
+	git replay --ref-action=print --contained --onto main main..topic3 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -139,12 +139,12 @@ test_expect_success 'using replay to also rebase a contained branch' '
 '
 
 test_expect_success 'using replay on bare repo to also rebase a contained branch' '
-	git -C bare replay --contained --onto main main..topic3 >result-bare &&
+	git -C bare replay --ref-action=print --contained --onto main main..topic3 >result-bare &&
 	test_cmp expect result-bare
 '
 
 test_expect_success 'using replay to rebase multiple divergent branches' '
-	git replay --onto main ^topic1 topic2 topic4 >result &&
+	git replay --ref-action=print --onto main ^topic1 topic2 topic4 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -168,7 +168,7 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
 '
 
 test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
-	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
+	git -C bare replay --ref-action=print --contained --onto main ^main topic2 topic3 topic4 >result &&
 
 	test_line_count = 4 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -217,4 +217,55 @@ test_expect_success 'merge.directoryRenames=false' '
 		--onto rename-onto rename-onto..rename-from
 '
 
+test_expect_success 'default atomic behavior updates refs directly' '
+	# Use a separate branch to avoid contaminating topic2 for later tests
+	git branch test-atomic topic2 &&
+	test_when_finished "git branch -D test-atomic" &&
+
+	# Test default atomic behavior (no output, refs updated)
+	git replay --onto main topic1..test-atomic >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated
+	git log --format=%s test-atomic >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	# Verify reflog message includes SHA of onto commit
+	git reflog test-atomic -1 --format=%gs >reflog-msg &&
+	ONTO_SHA=$(git rev-parse main) &&
+	echo "replay --onto $ONTO_SHA" >expect-reflog &&
+	test_cmp expect-reflog reflog-msg
+'
+
+test_expect_success 'atomic behavior in bare repository' '
+	# Store original state for cleanup
+	START=$(git -C bare rev-parse topic2) &&
+	test_when_finished "git -C bare update-ref refs/heads/topic2 $START" &&
+
+	# Test atomic updates work in bare repo
+	git -C bare replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated in bare repo
+	git -C bare log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reflog message for --advance mode' '
+	# Store original state
+	START=$(git rev-parse main) &&
+	test_when_finished "git update-ref refs/heads/main $START" &&
+
+	# Test --advance mode reflog message
+	git replay --advance main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify reflog message includes --advance and branch name
+	git reflog main -1 --format=%gs >reflog-msg &&
+	echo "replay --advance main" >expect-reflog &&
+	test_cmp expect-reflog reflog-msg
+'
+
 test_done
-- 
2.51.0

