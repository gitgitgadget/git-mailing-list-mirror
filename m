Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922532E7F3A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688000; cv=none; b=dJoTW7BD3iT26HEZhmfc59nrEjLUvhkVc9g3K1ivJM/x/m59WM4l83Chg5y7btc6CYb++98Gr0sK57a39iEPX2/e7NBrRqF1vPZT1LTms/nGX8Fyu3UaN6M3R4sAZo+adpTAPh8ZSRzIUFjGIgu3iAdHlk12sWfcQFQrRvXLajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688000; c=relaxed/simple;
	bh=GC6eobmd4VtTz5vpg4CCyhZqoBrtGttd93dLMilMiew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtDwqUOuyclsZcmTpsYaWMbDaMXubjL6JU+NC34aKHCVO6lpZyockg2TAU4/VBfNRhOJYQ3nKxnel0HL2ctI4Vfopbr6oRyGU48Rjn+8YitHk/y+DJIbKry8vxNJSIaJWifxEqo8pAeeAJZCrRYykIfHh+J9gBf5bS0xrxEGmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqpDnDWY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqpDnDWY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eec33b737so93256255ad.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687997; x=1762292797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clCVfJ7TD2SZhELaDM8AUwfI4kkwELUiAjPsj1UZ6tg=;
        b=YqpDnDWYwvgaFNoK2jmb1mFv8+8C5YlMtkoomgoA+TLV7r3+DMYUtBAvVneCgU8oNt
         GPPyVtu0M9LrdEyxPyxiV9wHm0stvGxcPaD4JvFVmRa1Va6Dxhh9HSWJkQv8+0knbart
         k32EGEWwH45xPosGWxjytsvUFsYZWZQLd9HeezkSCUeHmvpkGkC6p162aIrRr2nWBLp7
         njIqMx9ErZf5xZ2AF2JX4eoABuoTheZSut4Z62+2P3PCoVVoi8sx/WCFYCGBvPABEZyx
         fSu3QPAGxu2mwNEHVrKlOVVY/E15VLn/KP7L7IZcKztQLxtfHyvwyMu8gOi+ObfimGUk
         bI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687997; x=1762292797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clCVfJ7TD2SZhELaDM8AUwfI4kkwELUiAjPsj1UZ6tg=;
        b=TlRXvsii8HJFbgkf4kPZrEVT7MzneW9SGaohDBaWmhGmLCoGXzPtNJBNevB9kcGekq
         sd0GOwddlLGP+ux3MC+pDK4B/dLWLjYdw32T8ojLsTgJxwQy6b+4ox39HRQqOs2eaJex
         gt6Y6gtkvDYMFcA+O/7Tcw8maJtUEXXucv351WO7rn2KPWv8qt+iTgxjjunbaklOz9sJ
         15n8pRpR8lyn1NMS9YFRh7WTEXUUN1oYwfwQPsTntokz/9gi/3HVpPYxIon9+d1EYyts
         9P+jRbWAH7G9CU2Pz5EKMLmX/Ck12UUb3Banry3O3jWlJHxfSUHG0q5U1bqC+7JmE1QC
         PY8A==
X-Gm-Message-State: AOJu0YyLWYImwwg5xX8F8GBYpT41Joo7RF7Xgbryxnrr3RtIrsjds1ua
	4thngE089XpFR43xO5RwTE30BObOpbuESfV3iz4SaSHDjhUWPZ1YYPhA8qE5lPilKr4=
X-Gm-Gg: ASbGnctHIN3jFBEz1YvjO/GSRw1TD1YIRvqVBj1v4ooUDjgN8UQkWVOC1VDjSiC0+Vy
	Z8sbfJCkol1K+rpg4zQtCP3TbYH+1ILtevMnsiJnm6+34SUBn+r2FnTXuk3dzh9G0bPsQnOi4Rd
	yIS5sVtLXvW+xZffIBCUpl90NrFonN9A+uQfDjr5yQEo1lnUD1UifATkZsZ7GU07kNwCZtUSYRl
	SioNjscVsfQhH+WH1fLfJY7O9bfICqUaZEN4ZiqcHnadTqQOt/eS6A4CP5OPEl771ApRmeR+UGB
	nxNPI1QCdYcscFwHcd1OuKo4B1tOYOEr3CyTagWqLMfiirl1WvC53axa/fOMrj6eitWcMgGqv3S
	0vLR36WNCTnbgNWCqZK2L+0mVD3h5vOMsxn4bURPsJxV+lTbtlxHTs+QGkR6a6c57RXCHBQJXPa
	KXmf5ZMjCdMDxT19UIFzNkjNWmMzPniaT8NnkmWXuqV4NQ4XdvPScHOZ81c+QHkSpCCnXsV0++Z
	NhOLVE16uRj6Dhwh4sI5eLpq1eWawIJ
X-Google-Smtp-Source: AGHT+IFvv71eBY4MlD5+guzkKFeA3bWNhep3Efs6JoQRzJ7c2eQtLMslRPKZ/u3cZFLgsfdTThjwsA==
X-Received: by 2002:a17:903:1108:b0:290:b53b:7456 with SMTP id d9443c01a7336-294dedfa877mr6827005ad.5.1761687997126;
        Tue, 28 Oct 2025 14:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm125645655ad.99.2025.10.28.14.46.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 14:46:36 -0700 (PDT)
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
Subject: [PATCH v5 2/3] replay: make atomic ref updates the default behavior
Date: Wed, 29 Oct 2025 03:16:08 +0530
Message-ID: <20251028214609.10041-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028214609.10041-1-siddharthasthana31@gmail.com>
References: <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251028214609.10041-1-siddharthasthana31@gmail.com>
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

Implementation details:

The atomic ref updates are implemented using Git's ref transaction API.
In cmd_replay(), when not in `print` mode, we initialize a transaction
using ref_store_transaction_begin() with the default atomic behavior.
As commits are replayed, ref updates are staged into the transaction
using ref_transaction_update(). Finally, ref_transaction_commit()
applies all updates atomically—either all updates succeed or none do.

To avoid code duplication between the 'print' and 'update' modes, this
commit extracts a handle_ref_update() helper function. This function
takes the mode (as an enum) and either prints the update command or
stages it into the transaction. Using an enum rather than passing the
string around provides type safety and allows the compiler to catch
typos. The switch statement makes it easy to add future modes.

The helper function signature:

  static int handle_ref_update(enum ref_action_mode mode,
                                struct ref_transaction *transaction,
                                const char *refname,
                                const struct object_id *new_oid,
                                const struct object_id *old_oid,
                                struct strbuf *err)

The enum is defined as:

  enum ref_action_mode {
      REF_ACTION_UPDATE,
      REF_ACTION_PRINT
  };

The mode string is converted to enum immediately after parse_options()
to avoid string comparisons throughout the codebase and provide compiler
protection against typos.

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

The bare repository tests were fixed to rebuild their expectations
independently rather than comparing to previous test output, improving
test reliability and isolation.

A following commit will add a replay.refAction configuration
option for users who prefer the traditional pipeline output as their
default behavior.

Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc | 65 +++++++++++++++--------
 builtin/replay.c              | 98 +++++++++++++++++++++++++++++++----
 t/t3650-replay-basics.sh      | 44 +++++++++++++---
 3 files changed, 167 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 0b12bf8aa4..037b093196 100644
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
@@ -29,18 +30,31 @@ OPTIONS
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-When `--onto` is specified, the update-ref command(s) in the output will
-update the branch(es) in the revision range to point at the new
-commits, similar to the way how `git rebase --update-refs` updates
-multiple branches in the affected range.
+When `--onto` is specified, the branch(es) in the revision range will be
+updated to point at the new commits (or update commands will be printed
+if `--ref-action=print` is used), similar to the way `git rebase --update-refs`
+updates multiple branches in the affected range.
 
 --advance <branch>::
 	Starting point at which to create the new commits; must be a
 	branch name.
 +
-When `--advance` is specified, the update-ref command(s) in the output
-will update the branch passed as an argument to `--advance` to point at
-the new commits (in other words, this mimics a cherry-pick operation).
+The history is replayed on top of the <branch> and <branch> is updated to
+point at the tip of the resulting history (or an update command will be
+printed if `--ref-action=print` is used). This is different from `--onto`,
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
++
+The default mode can be configured via the `replay.refAction` configuration variable.
 
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
@@ -54,8 +68,11 @@ include::rev-list-options.adoc[]
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
@@ -81,6 +98,14 @@ To simply rebase `mybranch` onto `target`:
 
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
 
@@ -88,33 +113,29 @@ To cherry-pick the commits from mybranch onto target:
 
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
index b64fc72063..0564d4d2e7 100644
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
@@ -284,6 +289,28 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+static int handle_ref_update(enum ref_action_mode mode,
+			     struct ref_transaction *transaction,
+			     const char *refname,
+			     const struct object_id *new_oid,
+			     const struct object_id *old_oid,
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
+					      NULL, NULL, 0, "git replay", err);
+	default:
+		BUG("unknown ref_action_mode %d", mode);
+	}
+}
+
 int cmd_replay(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -294,6 +321,8 @@ int cmd_replay(int argc,
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
 	int contained = 0;
+	const char *ref_action_str = NULL;
+	enum ref_action_mode ref_action = REF_ACTION_UPDATE;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -302,12 +331,14 @@ int cmd_replay(int argc,
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
+		   "[--ref-action[=<mode>]] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -319,6 +350,9 @@ int cmd_replay(int argc,
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
 			 N_("advance all branches contained in revision-range")),
+		OPT_STRING(0, "ref-action", &ref_action_str,
+			   N_("mode"),
+			   N_("control ref update behavior (update|print)")),
 		OPT_END()
 	};
 
@@ -333,6 +367,18 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
+	/* Default to update mode if not specified */
+	if (!ref_action_str)
+		ref_action_str = "update";
+
+	/* Parse ref action mode */
+	if (!strcmp(ref_action_str, "update"))
+		ref_action = REF_ACTION_UPDATE;
+	else if (!strcmp(ref_action_str, "print"))
+		ref_action = REF_ACTION_PRINT;
+	else
+		die(_("unknown --ref-action mode '%s'"), ref_action_str);
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
@@ -389,6 +435,17 @@ int cmd_replay(int argc,
 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
 			      &onto, &update_refs);
 
+	/* Initialize ref transaction if using update mode */
+	if (ref_action == REF_ACTION_UPDATE) {
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
 
@@ -434,10 +491,15 @@ int cmd_replay(int argc,
 			if (decoration->type == DECORATION_REF_LOCAL &&
 			    (contained || strset_contains(update_refs,
 							  decoration->name))) {
-				printf("update %s %s %s\n",
-				       decoration->name,
-				       oid_to_hex(&last_commit->object.oid),
-				       oid_to_hex(&commit->object.oid));
+				if (handle_ref_update(ref_action, transaction,
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
@@ -445,10 +507,23 @@ int cmd_replay(int argc,
 
 	/* In --advance mode, advance the target ref */
 	if (result.clean == 1 && advance_name) {
-		printf("update %s %s %s\n",
-		       advance_name,
-		       oid_to_hex(&last_commit->object.oid),
-		       oid_to_hex(&onto->object.oid));
+		if (handle_ref_update(ref_action, transaction, advance_name,
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
@@ -460,6 +535,9 @@ int cmd_replay(int argc,
 	ret = result.clean;
 
 cleanup:
+	if (transaction)
+		ref_transaction_free(transaction);
+	strbuf_release(&transaction_err);
 	release_revisions(&revs);
 	free(advance_name);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 58b3759935..123734b49f 100755
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
@@ -217,4 +217,32 @@ test_expect_success 'merge.directoryRenames=false' '
 		--onto rename-onto rename-onto..rename-from
 '
 
+test_expect_success 'default atomic behavior updates refs directly' '
+	# Store original state for cleanup
+	test_when_finished "git branch -f topic2 topic1" &&
+
+	# Test default atomic behavior (no output, refs updated)
+	git replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated
+	git log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'atomic behavior in bare repository' '
+	# Test atomic updates work in bare repo
+	git -C bare replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated in bare repo
+	git -C bare log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	# Reset for other tests
+	git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse topic1)
+'
+
 test_done
-- 
2.51.0

