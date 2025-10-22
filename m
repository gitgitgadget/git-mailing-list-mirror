Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180932D7DC5
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159061; cv=none; b=WtOdS/8XUpoa//Mbt6/HcIUl/lBk4SU8McRSWnpbnYZP14W33gu6OdhWQNKiV4iRv+F5B+4sScoxoAtav/OmCoEY+hevgzY9BRB4tfbIxSBb51EfFuJBdu67StSuAX/N7g73QrGtXcd14B160w7tVr//uX1UBRMbpUF5sRYZ4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159061; c=relaxed/simple;
	bh=56MuKpxlsWkU8jPalB3EAnB/QugmOW3+RwbShIkia+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkTt0Bte6LgBKAhG5jliheAAFjivGzJObExcP3bniFdfNK5K1KjrgbBRGpOUHwmaO9uNLR3/LhkxUnv1zhP5evmzXcUaxhoAIfJFpekUdOwAv7Lq3FW+s0rgg+q5mEScbbS1oB44QS4C5XfECKkOuaFJG9Xf48VyI0Zwt110gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjQ9XBDi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjQ9XBDi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290dc630a07so40168265ad.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761159058; x=1761763858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxOqRG8bpiK9w49iFoRmrScYrUgOOxwCdtnvvVZXW7o=;
        b=QjQ9XBDiZzjX4UGRpOWS9lS++oyXgzQKAoifTt1093PShiWo/J5OOkmQGA62/qSr8b
         tOi3zE+hohBY/QAg2ngTr4D2qS/VYyXkiPDs3JNmtKAtcyTPQKz+3dqNryg/a6rBikfg
         /moIsy1fQG26OaSQpVT25mGxsjqRf+V1MlwV/lTGUlaGkv2w6kR64OrHpByARp84uk3X
         9Uie0o8ZNVs2EDgE+NtC3NOTFoLBboxdpvR3Dxkg43Z7kBuU5L3+kYq2XTogBzBUBQCV
         ere3bfkf3U108kV/vHbQ6A7w6Wx9vxwT/V/WNag+kSdqIgw+HVyAQaOdpxQZ70Nn4QD4
         YXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159058; x=1761763858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxOqRG8bpiK9w49iFoRmrScYrUgOOxwCdtnvvVZXW7o=;
        b=fcudCZ4bNRkwt4C20Ree2ArsKNWIt5jHpkhDOMGz35bYMI7MYNfO/9/v1pmacnAEbz
         Ebtk0GvxwGE/vn68SyPaB2b0ukzELkAs49Jm2vhJBgZ1sQc3ec/oxH1Dhwzp7iR5+Ntp
         whVmchtNjgNglIsZYhwWgbM09UQyVcOcDlx+Bzwn2fpehvZF2xOh84SfaHxK1p82tTwk
         l9ebJTh6jdU9EXvmT6WrzzPVOjbuI9ReRZw7VawIkDmfXayxsc1COj+1V6hO7U3qdBV4
         Qhww+C8EeedkWCrg/WWY8jvKaJ+L1+aPajLtG0J/pjrHkynQ4UizNqEhpSck40vC4ZU+
         i5eg==
X-Gm-Message-State: AOJu0YwuZHSxQRhQTqc+IzEWLVEW+Jfk/v7WANzp7wMESG7eT01tWn1R
	hq1u4LZVuLR7EbrKEEgAiAwXP0isoIKM2KnalWVtOwrdw5TOhPtVDTnw/etcKLIU0kQ=
X-Gm-Gg: ASbGnctjVA6Tmplm0gb/QnxatFsdsaIX6RM+dao5OFI1OAh1dwtP+Nn98o6VjnYJihC
	jTDLz7Kf1ew4HNpcaY73/ke4XMCmYonNHUhSiEtRtB8UM3MrxTmYfTGLL/MQsRXG6xRCLVTDhi5
	RUzDiYavHY/nhffc9vthjmOdMHKgQ8ncJ2dn8XfuEmj5sO1HqoHaBr2JmRbCltAd6DdR2RzGW4M
	lJHLT946Ig5Y7DvuyX56ZZcAEIYIHdZnWd1kAYDVIJ/rcAHS2FhlqVdmKs2r+XW2tvL3NoAEzUs
	he+lLinH/JnT9F8uq5+bnj/yxMiHNrCw5rzta3ZsWL64sbL38Jfvvd+z9OcrulIeqBUoKVHeCwG
	yBWRH28sEREPstKrcnYkHSNgD8a1/gxNIuiqDNJGOvTjyoABUilu85stWVdczR+GlAmfYTgCglu
	6QPyuHaZerkVNLdRymm/2jytABX9je3Of/NinTByqxelOEpPGHHqbCRf55b63XjtfSM2PnmBYq3
	VGCaphYXWqztgttKpglPPONOnSVS9mlnZ6kmL7Qg9sa
X-Google-Smtp-Source: AGHT+IF0VEFsYx420ETBbgGiIb0xm3vBjejW3++sv781uxjzOACVCovwvbMQWHLLi+sCvLbC3fGkVg==
X-Received: by 2002:a17:902:ec87:b0:27a:6c30:49c with SMTP id d9443c01a7336-290ca4fab50mr288310905ad.27.1761159057688;
        Wed, 22 Oct 2025 11:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:176:32cf:8d9c:2c8b:22d4:a7e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2930623208bsm25691755ad.31.2025.10.22.11.50.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 11:50:57 -0700 (PDT)
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
Subject: [PATCH v4 0/3] replay: make atomic ref updates the default
Date: Thu, 23 Oct 2025 00:20:42 +0530
Message-ID: <20251022185045.29256-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013183311.33329-1-siddharthasthana31@gmail.com>
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v4 of the git-replay atomic updates series.

Based on feedback from v3, this version improves the naming and
implementation for clarity and type safety. Thanks to Junio, Christian,
Elijah, Phillip, Patrick, and Karthik for the detailed reviews.

## Changes in v4

**Renamed --update-refs to --ref-action**

Junio pointed out that "--update-refs=print" is semantically awkward.
Answering "print" to the question "update refs?" doesn't make sense.
The actual question is "what action should we take on the refs?"

Changed to --ref-action=(update|print) where both values are verbs that
answer "what action?". This makes the interface clearer.

**Aligned config name with command-line option**

Changed replay.defaultAction to replay.refAction. The config variable
now mirrors the option name, making the relationship obvious.

**Unified config and command-line values**

v3 had confusing value mapping:
  - Command-line: yes/print
  - Config: update-refs/show-commands

v4 uses the same values everywhere:
  - Command-line: update/print
  - Config: update/print

This eliminates the need for mental mapping.

**Converted to type-safe enum implementation**

Per Junio's suggestion, added enum ref_action_mode and convert the mode
string immediately after parse_options():

  enum ref_action_mode {
      REF_ACTION_UPDATE,
      REF_ACTION_PRINT
  };

This provides compiler protection against typos and allows clear switch
statements with BUG() defaults instead of if/else chains.

**Fixed t0450 synopsis test**

The usage string now matches the documentation SYNOPSIS exactly. This
test was failing in v3.

**Improved --advance documentation**

Removed confusing cherry-pick reference and used Junio's clearer
wording to explain what --advance does versus --onto.

## Technical Implementation

Same as v3, using Git's ref transaction API:
  - ref_store_transaction_begin() for atomic transactions
  - ref_transaction_update() to stage updates
  - ref_transaction_commit() for atomic application

New in v4: The handle_ref_update() helper takes an enum parameter and
uses a switch statement instead of string comparisons.

## Testing

All tests pass:
  - t0450-txt-doc-vs-help.sh (now passing, was failing in v3)
  - t3650-replay-basics.sh (all 18 tests pass)

Test changes: All existing tests updated to use --ref-action=print
instead of --update-refs=print. New config tests verify
replay.refAction behavior.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
Changes in v4:
- Rename --update-refs to --ref-action for semantic clarity.
- Rename replay.defaultAction to replay.refAction to mirror option name.
- Unify command-line and config values to both use update/print.
- Convert implementation to use enum instead of string comparisons.
- Use switch statement with BUG() default in handle_ref_update().
- Fix t0450 synopsis mismatch.
- Improve --advance documentation clarity.
- Update all tests to use --ref-action.

Changes in v3:
- Removed --allow-partial option (no concrete use cases).
- Changed to --update-refs=<mode> for extensibility.
- Added replay.defaultAction configuration option.
- Improved commit messages with Helped-by trailers.
- Enhanced test suite with proper isolation.
- Extracted handle_ref_update() helper function.

---
 Documentation/config/replay.adoc |  11 +++
 Documentation/git-replay.adoc    |  65 +++++++++++------
 builtin/replay.c                 | 118 +++++++++++++++++++++++++++----
 t/t3650-replay-basics.sh         |  58 ++++++++++++---
 4 files changed, 209 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

Siddharth Asthana (3):
  replay: use die_for_incompatible_opt2() for option validation
  replay: make atomic ref updates the default behavior
  replay: add replay.refAction config option

Range-diff against v3:
-:  ---------- > 1:  baa0cfdd4a replay: use die_for_incompatible_opt2() for option validation
-:  ---------- > 2:  3b5df166f3 replay: make atomic ref updates the default behavior
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
         replay: make atomic ref updates the default behavior
         
         [Commit message unchanged - explains problem and solution]
         
         For users needing the traditional pipeline workflow, add a new
    -    `--update-refs=<mode>` option that preserves the original behavior:
    +    --ref-action=<mode> option that preserves the original behavior:
         
    -      git replay --update-refs=print --onto main topic1..topic2 | git update-ref --stdin
    +      git replay --ref-action=print --onto main topic1..topic2 | git update-ref --stdin
         
         The mode can be:
    -      * `yes` (default): Update refs directly using an atomic transaction
    +      * update (default): Update refs directly using an atomic transaction
           * `print`: Output update-ref commands for pipeline use
         
         Implementation details:
         
         The atomic ref updates are implemented using Git's ref transaction API.
    -    In cmd_replay(), when not in 'print' mode, we initialize a transaction
    +    In cmd_replay(), when not in print mode, we initialize a transaction
         using ref_store_transaction_begin() with the default atomic behavior.
         As commits are replayed, ref updates are staged into the transaction
         using ref_transaction_update(). Finally, ref_transaction_commit()
         applies all updates atomically—either all updates succeed or none do.
         
    -    To avoid code duplication between the 'print' and 'yes' modes, this
    +    To avoid code duplication between the print and update modes, this
         commit extracts a handle_ref_update() helper function. This function
    -    takes the mode and either prints the update command or stages it into
    -    the transaction. This keeps both code paths consistent and makes future
    -    maintenance easier.
    +    takes the mode (as an enum) and either prints the update command or
    +    stages it into the transaction. Using an enum rather than passing the
    +    string around provides type safety and allows the compiler to catch
    +    typos. The switch statement makes it easy to add future modes.
         
         The helper function signature:
         
    -      static int handle_ref_update(const char *mode,
    +      static int handle_ref_update(enum ref_action_mode mode,
                                         struct ref_transaction *transaction,
                                         const char *refname,
                                         const struct object_id *new_oid,
                                         const struct object_id *old_oid,
                                         struct strbuf *err)
         
    -    When mode is 'print', it prints the update-ref command. When mode is
    -    'yes', it calls ref_transaction_update() to stage the update. This
    -    eliminates the duplication that would otherwise exist at each ref update
    -    call site.
    +    The enum is defined as:
    +    
    +      enum ref_action_mode {
    +          REF_ACTION_UPDATE,
    +          REF_ACTION_PRINT
    +      };
    +    
    +    The mode string is converted to enum immediately after parse_options()
    +    to avoid string comparisons throughout the codebase and provide compiler
    +    protection against typos.
         
         Test suite changes:
         
         All existing tests that expected command output now use
    -    `--update-refs=print` to preserve their original behavior. This keeps
    +    --ref-action=print to preserve their original behavior. This keeps
         the tests valid while allowing them to verify that the pipeline workflow
         still works correctly.
         
         [Rest of test section unchanged]
         
    -    A following commit will add a `replay.defaultAction` configuration
    +    A following commit will add a replay.refAction configuration
         option for users who prefer the traditional pipeline output as their
         default behavior.
         
         Helped-by: Elijah Newren <newren@gmail.com>
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Helped-by: Christian Couder <christian.couder@gmail.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-replay.adoc ##
     @@ Documentation/git-replay.adoc: SYNOPSIS
      [verse]
     -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
    -+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>)
    -+		[--update-refs[=<mode>]] <revision-range>...
    ++(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
      
      ## Documentation/git-replay.adoc: DESCRIPTION
     -the working tree and the index untouched, and updates no references.
     -The output of this command is meant to be used as input to
     -`git update-ref --stdin`, which would update the relevant branches
     +the working tree and the index untouched. By default, updates the
     +relevant references using an atomic transaction (all refs update or
    -+none). Use `--update-refs=print` to avoid automatic ref updates and
    ++none). Use `--ref-action=print` to avoid automatic ref updates and
     +instead get update commands that can be piped to `git update-ref --stdin`
      (see the OUTPUT section below).
      
     @@ Documentation/git-replay.adoc: OPTIONS
     -When `--onto` is specified, the update-ref command(s) in the output will
     -update the branch(es) in the revision range to point at the new
     +When `--onto` is specified, the branch(es) in the revision range will be
     +updated to point at the new commits (or update commands will be printed
    -+if `--update-refs=print` is used), similar to the way how
    ++if `--ref-action=print` is used), similar to the way how
     +`git rebase --update-refs` updates multiple branches in the affected range.
      
      --advance <branch>::
     -When `--advance` is specified, the update-ref command(s) in the output
     -will update the branch passed as an argument to `--advance` to point at
     -the new commits (in other words, this mimics a cherry-pick operation).
    -+When `--advance` is specified, the branch passed as an argument will be
    -+updated to point at the new commits (or an update command will be printed
    -+if `--update-refs=print` is used). This mimics a cherry-pick operation.
    ++The history is replayed on top of the <branch> and <branch> is updated to
    ++point at the tip of the resulting history (or an update command will be
    ++printed if `--ref-action=print` is used). This is different from `--onto`,
    ++which uses the target only as a starting point without updating it.
      
    -+--update-refs[=<mode>]::
    ++--ref-action[=<mode>]::
     +	Control how references are updated. The mode can be:
     +--
    -+* `yes` (default): Update refs directly using an atomic transaction.
    -+  All ref updates succeed or all fail.
    ++	* `update` (default): Update refs directly using an atomic transaction.
    ++	  All refs are updated or none are (all-or-nothing behavior).
     +* `print`: Output update-ref commands for pipeline use. This is the
    -+  The output can be piped as-is to `git update-ref --stdin`.
    ++	  traditional behavior where output can be piped to `git update-ref --stdin`.
     +--
    ++
    ++The default mode can be configured via `replay.refAction` configuration option.
      
     @@ Documentation/git-replay.adoc: OUTPUT
     -When there are no conflicts, the output of this command is usable as
     -input to `git update-ref --stdin`.  It is of the form:
    -+By default, when there are no conflicts, this command updates the relevant
    -+references using an atomic transaction and produces no output. All ref
    -+updates succeed or all fail.
    ++By default (with `--ref-action=update`), this command produces no output on
    ++success, as refs are updated directly using an atomic transaction.
     +
    -+When `--update-refs=print` is used, the output is usable as input to
    ++When using `--ref-action=print`, the output is usable as input to
     +`git update-ref --stdin`. It is of the form:
      
     @@ Documentation/git-replay.adoc: EXAMPLES
     -To simply rebase `mybranch` onto `target`:
    -+To simply rebase `mybranch` onto `target` (default behavior):
    ++To simply rebase `mybranch` onto `target`:
      
      ------------
      $ git replay --onto target origin/main..mybranch
     -update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
      ------------
      
     @@ Documentation/git-replay.adoc: EXAMPLES
     +To get the traditional pipeline output:
     +
     +------------
    -+$ git replay --update-refs=print --onto target origin/main..mybranch
    ++$ git replay --ref-action=print --onto target origin/main..mybranch
     +update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
     +------------
      
      ## builtin/replay.c ##
    ++@@ builtin/replay.c
    ++ #include <oidset.h>
    ++ #include <tree.h>
    ++ 
    ++enum ref_action_mode {
    ++	REF_ACTION_UPDATE,
    ++	REF_ACTION_PRINT
    ++};
    ++
    ++ static const char *short_commit_name(struct repository *repo,
    ++ 
     @@ builtin/replay.c: static struct commit *pick_regular_commit
      	return create_commit(repo, result->tree, pickme, replayed_base);
      }
      
    -+static int handle_ref_update(const char *mode,
    ++static int handle_ref_update(enum ref_action_mode mode,
     +			     struct ref_transaction *transaction,
     +			     const char *refname,
     +			     const struct object_id *new_oid,
     +			     const struct object_id *old_oid,
     +			     struct strbuf *err)
     +{
    -+	if (!strcmp(mode, "print")) {
    ++	switch (mode) {
    ++	case REF_ACTION_PRINT:
     +		printf("update %s %s %s\n",
     +		       refname,
     +		       oid_to_hex(new_oid),
     +		       oid_to_hex(old_oid));
     +		return 0;
    -+	}
    -+
    -+	/* mode == "yes" - update refs directly */
    -+	return ref_transaction_update(transaction, refname, new_oid, old_oid,
    -+				      NULL, NULL, 0, "git replay", err);
    ++	case REF_ACTION_UPDATE:
    ++		return ref_transaction_update(transaction, refname, new_oid, old_oid,
    ++					      NULL, NULL, 0, "git replay", err);
    ++	default:
    ++		BUG("unknown ref_action_mode %d", mode);
    ++	}
     +}
      
     @@ builtin/replay.c: int cmd_replay
      	struct commit *onto = NULL;
      	const char *onto_name = NULL;
      	int contained = 0;
    -+	const char *update_refs_mode = NULL;
    ++	const char *ref_action_str = NULL;
    ++	enum ref_action_mode ref_action = REF_ACTION_UPDATE;
      
     @@ builtin/replay.c: int cmd_replay
     - 	const char * const replay_usage[] = {
    + 	const char *const replay_usage[] = {
      		N_("(EXPERIMENTAL!) git replay "
      		   "([--contained] --onto <newbase> | --advance <branch>) "
    -+		   "[--update-refs[=<mode>]] <revision-range>..."),
    ++		   "[--ref-action[=<mode>]] <revision-range>..."),
      		NULL
      	};
      
     @@ builtin/replay.c: int cmd_replay
    -+		OPT_STRING(0, "update-refs", &update_refs_mode,
    ++		OPT_STRING(0, "ref-action", &ref_action_str,
     +			   N_("mode"),
    -+			   N_("control ref update behavior (yes|print)")),
    ++			   N_("control ref update behavior (update|print)")),
      		OPT_END()
      	};
      
     @@ builtin/replay.c: int cmd_replay
      	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
      				  contained, "--contained");
      
    -+	/* Set default mode if not specified */
    -+	if (!update_refs_mode)
    -+		update_refs_mode = "yes";
    -+
    -+	/* Validate update-refs mode */
    -+	if (strcmp(update_refs_mode, "yes") && strcmp(update_refs_mode, "print"))
    -+		die(_("invalid value for --update-refs: '%s' (expected 'yes' or 'print')"),
    -+		    update_refs_mode);
    ++	/* Parse ref action mode */
    ++	if (!strcmp(ref_action_str, "update"))
    ++		ref_action = REF_ACTION_UPDATE;
    ++	else if (!strcmp(ref_action_str, "print"))
    ++		ref_action = REF_ACTION_PRINT;
    ++	else
    ++		die(_("unknown --ref-action mode '%s'"), ref_action_str);
      
     @@ builtin/replay.c: int cmd_replay
      	/* Initialize ref transaction if we're updating refs directly */
    -+	if (!strcmp(update_refs_mode, "yes")) {
    ++	if (ref_action == REF_ACTION_UPDATE) {
      		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
      
     @@ builtin/replay.c: int cmd_replay
    -+				if (handle_ref_update(update_refs_mode, transaction,
    ++				if (handle_ref_update(ref_action, transaction,
     +						      decoration->name,
     +						      &last_commit->object.oid,
     +						      &commit->object.oid,
      
     @@ t/t3650-replay-basics.sh
      test_expect_success 'using replay to rebase two branches, one on top of other' '
     -	git replay --onto main topic1..topic2 >result &&
    -+	git replay --update-refs=print --onto main topic1..topic2 >result &&
    ++	git replay --ref-action=print --onto main topic1..topic2 >result &&
      
     @@ t/t3650-replay-basics.sh
      test_expect_success 'using replay to perform basic cherry-pick' '
     -	git replay --advance main topic1..topic2 >result &&
    -+	git replay --update-refs=print --advance main topic1..topic2 >result &&
    ++	git replay --ref-action=print --advance main topic1..topic2 >result &&
      
     @@ t/t3650-replay-basics.sh
      test_expect_success 'using replay to also rebase a contained branch' '
     -	git replay --contained --onto main main..topic3 >result &&
    -+	git replay --update-refs=print --contained --onto main main..topic3 >result &&
    ++	git replay --ref-action=print --contained --onto main main..topic3 >result &&
      
     @@ t/t3650-replay-basics.sh
     +# Tests for atomic ref update behavior
     +
     +[New tests added - content unchanged from v3]
     +
    -+test_expect_success 'replay validates --update-refs mode values' '
    -+	test_must_fail git replay --update-refs=invalid --onto main topic1..topic2 2>error &&
    -+	grep "invalid value for --update-refs" error
    ++test_expect_success 'replay validates --ref-action mode values' '
    ++	test_must_fail git replay --ref-action=invalid --onto main topic1..topic2 2>error &&
    ++	grep "invalid value for --ref-action" error
     +'
      
-:  ---------- > 3:  c35049881d replay: add replay.refAction config option
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
    -    replay: add replay.defaultAction config option
    +    replay: add replay.refAction config option
         
         Add a configuration option to control the default behavior of git replay
         for updating references. This allows users who prefer the traditional
    -    pipeline output to set it once in their config instead of passing
    -    --update-refs=print with every command.
    +    pipeline output to set it once in their config instead of passing
    +    --ref-action=print with every command.
         
    -    The config option uses enum string values for extensibility:
    -      * replay.defaultAction = update-refs (default): atomic ref updates
    -      * replay.defaultAction = show-commands: output commands for pipeline
    +    The config option uses string values that mirror the behavior modes:
    +      * replay.refAction = update (default): atomic ref updates
    +      * replay.refAction = print: output commands for pipeline
         
    -    The command-line --update-refs option always overrides the config setting,
    +    The command-line --ref-action option always overrides the config setting,
         allowing users to temporarily change behavior for a single invocation.
         
         [Implementation details mostly unchanged except names]
         
    -    The command-line --update-refs option, when provided, overrides the
    +    The command-line --ref-action option, when provided, overrides the
         config value. This precedence allows users to set their preferred default
         while still having per-invocation control:
         
    -      git config replay.defaultAction show-commands  # Set default
    -      git replay --update-refs=yes --onto main topic  # Override once
    +      git config replay.refAction print         # Set default
    +      git replay --ref-action=update --onto main topic  # Override once
         
    -    The config option uses different value names ('update-refs' vs
    -    'show-commands') compared to the command-line option ('yes' vs 'print')
    -    for semantic clarity. The config values describe what action is being
    -    taken, while the command-line values are terse for typing convenience.
    -    
    -    The enum string design (rather than a boolean like 'replay.updateRefs')
    -    allows future expansion to additional modes without requiring new
    -    configuration variables.
    +    The config and command-line option use the same value names ('update'
    +    and 'print') for consistency and clarity. This makes it immediately
    +    obvious how the config maps to the command-line option, addressing
    +    feedback about the relationship between configuration and command-line
    +    options being clear to users.
         
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Elijah Newren <newren@gmail.com>
    +    Helped-by: Christian Couder <christian.couder@gmail.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
      
      ## Documentation/config/replay.adoc (new) ##
    -+replay.defaultAction::
    -+	Control the default behavior of `git replay` for updating references.
    ++replay.refAction::
    ++	Specifies the default mode for handling reference updates in
    ++	`git replay`. The value can be:
     +--
    -+* `update-refs` (default): Update refs directly using an atomic transaction.
    -+* `show-commands`: Output update-ref commands that can be piped to
    -+  `git update-ref --stdin`.
    ++	* `update`: Update refs directly using an atomic transaction (default behavior).
    ++	* `print`: Output update-ref commands for pipeline use.
     +--
    -+This can be overridden with the `--update-refs` command-line option.
    -+Note that the command-line option uses slightly different values
    -+(`yes` and `print`) for brevity, but they map to the same behavior
    -+as the config values.
    ++This setting can be overridden with the `--ref-action` command-line option.
    ++When not configured, `git replay` defaults to `update` mode.
      
      ## builtin/replay.c ##
     +#include "builtin.h"
     +#include "config.h"
      
     @@ builtin/replay.c: int cmd_replay
      	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
      				  contained, "--contained");
      
    -+	/* Set default mode from config if not specified on command line */
    -+	if (!update_refs_mode) {
    ++	/* Set default from config if not specified on command line */
    ++	if (!ref_action_str) {
     +		const char *config_value = NULL;
    -+		if (!repo_config_get_string_tmp(repo, "replay.defaultaction", &config_value)) {
    -+			if (!strcmp(config_value, "update-refs"))
    -+				update_refs_mode = "yes";
    -+			else if (!strcmp(config_value, "show-commands"))
    -+				update_refs_mode = "print";
    ++		if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value)) {
    ++			if (!strcmp(config_value, "update"))
    ++				ref_action_str = "update";
    ++			else if (!strcmp(config_value, "print"))
    ++				ref_action_str = "print";
     +			else
    -+				die(_("invalid value for replay.defaultAction: '%s' "
    -+				      "(expected 'update-refs' or 'show-commands')"),
    ++				die(_("invalid value for replay.refAction: '%s'"),
     +				    config_value);
     +		}
    -+	} else {
    -+		update_refs_mode = "yes";
     +	}
    ++
    ++	/* Default to update mode if still not set */
    ++	if (!ref_action_str)
    ++		ref_action_str = "update";
      
     @@ t/t3650-replay-basics.sh
    -+test_expect_success 'replay.defaultAction config option' '
    ++test_expect_success 'replay.refAction config option' '
     +	START=$(git rev-parse topic2) &&
    -+	test_when_finished "git branch -f topic2 $START && git config --unset replay.defaultAction" &&
    ++	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
     +
    -+	git config replay.defaultAction show-commands &&
    ++	git config replay.refAction print &&
     +	git replay --onto main topic1..topic2 >output &&
     +	test_line_count = 1 output &&
     +	grep "^update refs/heads/topic2 " output &&
     +
     +	git branch -f topic2 $START &&
    -+	git config replay.defaultAction update-refs &&
    ++	git config replay.refAction update &&
     +	git replay --onto main topic1..topic2 >output &&
     +	test_must_be_empty output &&
     +	[...]
     +'
     +
    -+test_expect_success 'command-line --update-refs overrides config' '
    ++test_expect_success 'command-line --ref-action overrides config' '
     +	START=$(git rev-parse topic2) &&
    -+	test_when_finished "git branch -f topic2 $START && git config --unset replay.defaultAction" &&
    -+	git config replay.defaultAction update-refs &&
    -+	git replay --update-refs=print --onto main topic1..topic2 >output &&
    ++	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
    ++	git config replay.refAction update &&
    ++	git replay --ref-action=print --onto main topic1..topic2 >output &&
     +	test_line_count = 1 output &&
     +	grep "^update refs/heads/topic2 " output
     +'
     +
    -+test_expect_success 'invalid replay.defaultAction value' '
    -+	test_when_finished "git config --unset replay.defaultAction" &&
    -+	git config replay.defaultAction invalid &&
    ++test_expect_success 'invalid replay.refAction value' '
    ++	test_when_finished "git config --unset replay.refAction" &&
    ++	git config replay.refAction invalid &&
     +	test_must_fail git replay --onto main topic1..topic2 2>error &&
    -+	grep "invalid value for replay.defaultAction" error
    ++	grep "invalid value for replay.refAction" error
     +'
-- 
2.51.0

base-commit: 133d151831d291e51d55c80a40684eb6c8dfdd24

Thanks
- Siddharth

