Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8250EC11
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863291; cv=none; b=HSMuHVEZ64eHU8eNcAtO+RZTwB7qg5yutzCNvoEe1FsqCaJOAiZi8xH/VX/7s2tzM2xAmVfr9O0Ysr204JJ8hNTHjeCO7a2HAyMarwWr+m70ypk2Sj15PcG/XBQPxIrLj525Bxk51xJwp9bO7a4E6L2GAcJwo9t3zlc0oAEX4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863291; c=relaxed/simple;
	bh=Hd4fBubQqKPXCOM1isQBWVqpDgMXaGv64Ea8JHmnb7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KHNJbl0/oqlXGGyeLhdI4FjkYrR5Ua2BOdhaaez0tYZDcknXRVRNqkeBxlgBQtJ3dDNszDvXk9QJNhjn58ITCB/eQTF3mF3FkJJHiaKlnY/ZSOmIxesu3AxkKfAKtzw9793huTrxpv4rtBHF4VOx0GWm/9XE5oQCo7sXKcR2vNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coQo0INY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coQo0INY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso4852896a91.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863289; x=1789468089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A8wT/BeNqT6DAZpTP/fegcnygX5lfvxqFnH/ogqwfGE=;
        b=coQo0INYGzCiv1AvjAs+rHlca3kXqWL4Vs8RFYQpXeBpBRwY8hg9TZJOBRiiu+Lzo2
         sazTSCMDQM24MoHLDEt0FMI9sF2VwuocV0dcJligRgvQqq24qXsvy+HxiyTUd0vo5bWD
         +FoPO0zGunXgVkaRTebZETRB8lovEN4C2phezfJAll2yCYWAlT0OwuLJByNVxGlknnkD
         oFGmbi466+8fPzWEMzp/f/GOriYfENbPIMgpAPp0s3mZ5DDQS5e03wNShlcXAC6tVvZb
         Viqak0WncmB/7PBEU0uAHaRRJ2MDZKvTC/SHQgOOAGHEtGuLV4k2wJoy8103eXnoU/aR
         mD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863289; x=1789468089;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8wT/BeNqT6DAZpTP/fegcnygX5lfvxqFnH/ogqwfGE=;
        b=iNiy+yucn0iI0+/XFNzpErkJVsYu6ioYxxq4E/QvhM5stDGrs5i1F1fUfgPrxe/FuG
         JRVXh3wOU1VQIRY3GuqWjtBleTG8DFd01PJQSosy7mOvPdtcaMiXcXNzetg6/IYNOxyx
         FaZviVMvNeVAvTEktHkY5a1SFwM37c+Yw9LSBdgmgyX9TbLtVNFUuidtGpplRSZFTxB+
         mNFtkvBPsOvJ43VvjAFIWW43voDuo1grmtSow4pOKaTqr37xfAVdADYbP9FpF7dGUdYV
         n48NVa4ni8CIZsgep8iZDjYkrQmsLJA7vHAlugThUWIA6r3zzBrQnRxaQ3hz320BaSfH
         IQEg==
X-Gm-Message-State: AFuF++l4pGQ6tLnpujlxJ5XR+v9Fb7i2DsSTAYqIjmIBvkYj3ew9YyXm
	IZhwN/5o5shbn9pQC5Ka52QvNCZeYddfd57DikHL+QwTO25smKzG2p6DcFKzbg==
X-Gm-Gg: AYBFou3534puJrucqIO/GL5RjRgX01BaAp4HdBMFOwXw3eoLWgnkXaNaibdhKzHq5xQ
	iFT9DFZAZ636/ZySvFGwqr3x4358cOfxr9roa5xP6zhadb8axLBb+W0W7iJyTZnUq96kv03fRoR
	OOqrexYDeKpDB7qX5QXUztVwU7Jkfi1K+LZMCpjN5YR39Y+ibd0KuvTQNYeKsCsKwl9llyKe6qd
	NQG2TBR+MgcKzM0ESF/mOv3zkqg3iqdPcwC0xzDYrrS0hvCRYVenKWdWTbOsCPlgsWD/atRkmVX
	WPNBWFc2vSd9hAKujxO9k0hnobxICCNM29VUipYCwrja8L1Q/bGVnHlWWnavnalSfJdl4/Tj5LA
	IGWsaybdyWslX8nWHCjUStdhN9GhqRyL/ekjCJ97jCpcSEP7hSo3tChk//C+N/W+znpV32aJ+5O
	ndp/7Kyw5HPvOYaaTWrTCqFduYIxdXle2sbaUUa5QV/jjWuCxzQCezwBnijU7ZeA==
X-Received: by 2002:a17:90b:17cf:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39b26216cf7mr42650086a91.23.1788863288322;
        Tue, 08 Sep 2026 03:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm35536519eec.27.2026.09.08.03.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:28:07 -0700 (PDT)
Message-Id: <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 10:28:03 +0000
Subject: [PATCH v3 0/3] sequencer: leave auto maintenance to the end of a sequence
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>

Changes since v2:

 * Auto maintenance now runs from builtin/rebase.c and builtin/revert.c,
   once the command is done, instead of from three places inside the
   sequencer. That follows the apply backend, where "git am" leaves it to
   rebase.c (Patrick, Phillip).
 * gc.auto=0 dropped, maintenance.auto=false is enough (Patrick).
 * config_parameters is a char * built once with strbuf_detach() (Junio).
 * Patch 3 extends the tests of patch 2 instead of adding its own. They also
   assert that nothing runs before a stop, and cover a single pick with
   --edit and a sequence ending in --skip (Phillip).
 * Commit messages rewritten: what GIT_CONFIG_PARAMETERS is and looks like
   (Patrick), what patch 2 changes for the user and why the call moved
   (Patrick, Phillip), and the comment on the helper (Phillip).

Based on master. Independent of the rerere lock fix in [1].

[1] <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>

Thomas Bachem (3):
  config: add git_config_append_parameter()
  rebase, cherry-pick, revert: run auto maintenance when done
  sequencer: disable auto maintenance in spawned commands

 builtin/rebase.c                | 13 ++++++++---
 builtin/revert.c                | 19 +++++++++++------
 config.c                        | 20 +++++++++++------
 config.h                        | 13 +++++++++++
 sequencer.c                     | 38 ++++++++++++++++++++++++++++++---
 t/t3418-rebase-continue.sh      | 17 +++++++++++++++
 t/t3510-cherry-pick-sequence.sh | 31 +++++++++++++++++++++++++++
 7 files changed, 131 insertions(+), 20 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2217%2Fthomasbachem%2Frebase-auto-maintenance-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2217/thomasbachem/rebase-auto-maintenance-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2217

Range-diff vs v2:

 1:  ef8087e80d ! 1:  70db5ad084 config: add git_config_append_parameter()
     @@ Metadata
       ## Commit message ##
          config: add git_config_append_parameter()
      
     -    Split the part of git_config_push_split_parameter() that formats one
     -    GIT_CONFIG_PARAMETERS entry into a helper that appends it to a strbuf,
     -    so that a caller can build a value for a child's environment without
     -    knowing the quoting. The sequencer is about to do that.
     +    "git -c key=value" passes its settings on to the git commands it
     +    spawns through the environment variable GIT_CONFIG_PARAMETERS. The
     +    value is a space separated list of 'key'='value' pairs with both
     +    sides single quoted, which git_config_from_parameters() reads back in
     +    the child. The only place we write such an entry is
     +    git_config_push_split_parameter(), and it writes straight into our
     +    own environment.
     +
     +    Split the formatting out into git_config_append_parameter(), which
     +    appends one entry to a strbuf, so that we can build such a value for
     +    a child's environment without repeating the quoting. The sequencer
     +    will use it in a later commit to pass settings to the commands it
     +    spawns.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ config.h: int git_config_from_blob_oid(config_fn_t fn, const char *name,
       void git_config_push_env(const char *spec);
      +
      +/*
     -+ * Append `key=value` to the GIT_CONFIG_PARAMETERS value in `env`, quoted
     -+ * the way git_config_from_parameters() reads it, so that a child can be
     -+ * given configuration on top of what this process was given. A NULL
     -+ * `value` appends a boolean entry.
     ++ * Append a "-c key=value" setting to a GIT_CONFIG_PARAMETERS value in
     ++ * `env`. The variable carries such settings from a git process to the
     ++ * git commands it spawns, as a space separated list of 'key'='value'
     ++ * pairs with both sides single quoted, which git_config_from_parameters()
     ++ * reads back. A NULL `value` appends 'key'= with nothing after the equals
     ++ * sign, which stands for a boolean true, like "-c key" on the command
     ++ * line.
      + */
      +void git_config_append_parameter(struct strbuf *env, const char *key,
      +				 const char *value);
 2:  baab8d4876 ! 2:  68a728c5f4 sequencer: run auto maintenance once a sequence is done
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    sequencer: run auto maintenance once a sequence is done
     +    rebase, cherry-pick, revert: run auto maintenance when done
      
     -    The apply backend of "git rebase" runs "git maintenance run --auto"
     -    from finish_rebase() once it has applied its patches. The merge
     -    backend, "git cherry-pick" and "git revert" do not run it when they
     -    finish. They create their commits in process, and only the "git
     -    commit" they spawn for an edited message or a resolved conflict, the
     -    "git merge" a "rebase -r" spawns and an exec command start it, in the
     -    middle of the sequence.
     +    "git commit", "git merge", "git fetch" and "git am" run "git
     +    maintenance run --auto" when they are done, and so does the apply
     +    backend of "git rebase". That repacks the loose objects they wrote
     +    once there are enough of them, expires old rerere entries and does
     +    whatever other housekeeping is due.
      
     -    Run it where the sequencer finishes, so that every sequence ends the
     -    way the apply backend does, and so that the next commit can keep it
     -    out of the commands a sequence spawns.
     +    The merge backend of "git rebase", "git cherry-pick" and "git revert"
     +    do not. They create their commits in process, so auto maintenance
     +    runs only when they spawn a command that runs it on its own. That is
     +    the "git commit" for a resolved conflict or an edited message, the
     +    "git merge" that "--rebase-merges" spawns for an octopus merge, a
     +    strategy other than ort or any strategy option, and whatever an exec
     +    runs. A sequence that needs none of these never runs auto
     +    maintenance. One that stops for conflicts runs it after each
     +    resolution, in the middle of the sequence.
     +
     +    Run it once when the sequence is done, like the apply backend does.
     +
     +    The apply backend leaves that to builtin/rebase.c: "git am" skips
     +    auto maintenance in rebasing mode, and finish_rebase() runs it once
     +    the patches are applied. Do the same for the sequencer, from
     +    builtin/rebase.c and builtin/revert.c, because the sequencer itself
     +    has no single place where every sequence ends. A sequence of several
     +    commits ends inside pick_commits(). A single cherry-pick or revert
     +    never creates the sequencer's state directory and returns to its
     +    caller as soon as its commit is made. "--continue" and "--skip" have
     +    entry points of their own. Nothing but those two builtins starts or
     +    continues a sequence, so that is where we run auto maintenance.
     +    run_specific_rebase() runs it for the merge backend once the
     +    sequencer has returned successfully and removed its state directory,
     +    which it keeps while the rebase is stopped. run_sequencer() runs it
     +    for cherry-pick and revert when a pick, a "--continue" or a "--skip"
     +    returns successfully.
     +
     +    For the user, a sequence that never stops now runs auto maintenance
     +    once when it is done, where it never ran it before. That is the same
     +    "git maintenance run --auto --detach" as after "git commit": it
     +    detaches into the background by default and does nothing unless one
     +    of its tasks is due. The runs from the commands a sequence spawns
     +    stay for now. The next commit removes them, so that a sequence runs
     +    auto maintenance exactly once.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
     - ## sequencer.c ##
     -@@ sequencer.c: cleanup_head_ref:
     - 			return -1;
     - 	}
     + ## builtin/rebase.c ##
     +@@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts)
       
     -+	/*
     -+	 * We ignore errors in 'git maintenance run --auto', since the
     -+	 * user should see them.
     -+	 */
     -+	run_auto_maintenance(r, opts->quiet);
     + 	if (opts->dont_finish_rebase)
     + 		; /* do nothing */
     +-	else if (opts->type == REBASE_MERGE)
     +-		; /* merge backend cleans up after itself */
     +-	else if (status == 0) {
     ++	else if (opts->type == REBASE_MERGE) {
     ++		int quiet = !(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE));
      +
     - 	/*
     - 	 * Sequence of picks finished successfully; cleanup by
     - 	 * removing the .git/sequencer directory
     -@@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *opts)
     - 			res = -1;
     - 			goto release_todo_list;
     - 		}
     --	} else if (!file_exists(get_todo_path(opts)))
     --		return continue_single_pick(r, opts);
     --	else if ((res = read_populate_todo(r, &todo_list, opts)))
     -+	} else if (!file_exists(get_todo_path(opts))) {
     -+		res = continue_single_pick(r, opts);
     -+		if (!res)
     -+			run_auto_maintenance(r, opts->quiet);
     -+		return res;
     -+	} else if ((res = read_populate_todo(r, &todo_list, opts))) {
     - 		goto release_todo_list;
     -+	}
     ++		/*
     ++		 * The sequencer cleans up after itself. Its state directory
     ++		 * is gone once it is done, and stays while it is stopped.
     ++		 */
     ++		if (status == 0 && !is_directory(opts->state_dir))
     ++			run_auto_maintenance(the_repository, quiet);
     ++	} else if (status == 0) {
     + 		if (!file_exists(state_dir_path("stopped-sha", opts)))
     + 			finish_rebase(opts);
     + 	} else if (status == 2) {
     +
     + ## builtin/revert.c ##
     +@@
     + #include "gettext.h"
     + #include "revision.h"
     + #include "rerere.h"
     ++#include "run-command.h"
     + #include "sequencer.h"
     + #include "branch.h"
       
     - 	if (!is_rebase_i(opts)) {
     - 		/* Verify that the conflict has been resolved */
     -@@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
     - 			BUG("unexpected extra commit from walk");
     +@@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, const char *prefix,
     + 	const char *strategy = &sentinel_value;
     + 	const char *gpg_sign = &sentinel_value;
     + 	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
     +-	int cmd = 0;
     ++	int cmd = 0, ret;
     + 	struct option base_options[] = {
     + 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
     + 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
     +@@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, const char *prefix,
     + 	free(options);
       
     - 		res = single_pick(r, cmit, opts);
     -+		if (!res)
     -+			run_auto_maintenance(r, opts->quiet);
     - 		goto out;
     + 	if (cmd == 'q') {
     +-		int ret = sequencer_remove_state(opts);
     ++		ret = sequencer_remove_state(opts);
     + 		if (!ret)
     + 			remove_branch_state(the_repository, 0);
     + 		return ret;
       	}
     +-	if (cmd == 'c')
     +-		return sequencer_continue(the_repository, opts);
     + 	if (cmd == 'a')
     + 		return sequencer_rollback(the_repository, opts);
     +-	if (cmd == 's')
     +-		return sequencer_skip(the_repository, opts);
     +-	return sequencer_pick_revisions(the_repository, opts);
     ++	if (cmd == 'c')
     ++		ret = sequencer_continue(the_repository, opts);
     ++	else if (cmd == 's')
     ++		ret = sequencer_skip(the_repository, opts);
     ++	else
     ++		ret = sequencer_pick_revisions(the_repository, opts);
     ++	if (!ret)
     ++		run_auto_maintenance(the_repository, opts->quiet);
     ++	return ret;
     + }
       
     + int cmd_revert(int argc,
      
       ## t/t3418-rebase-continue.sh ##
      @@ t/t3418-rebase-continue.sh: test_orig_head () {
       test_orig_head --apply
       test_orig_head --merge
       
     -+test_expect_success 'rebase runs auto maintenance at its end' '
     -+	git checkout -b one-exec main^ &&
     -+	test_commit F4 &&
     -+	test_must_fail git rebase -x false main &&
     -+	GIT_TRACE2_EVENT="$(pwd)/finish.txt" git rebase --continue &&
     -+	test_subcommand_flex git maintenance run --auto <finish.txt
     ++test_expect_success 'rebase runs auto maintenance once it is done' '
     ++	git checkout -b auto-maintenance topic &&
     ++	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
     ++		git rebase -x false main &&
     ++	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
     ++	echo resolved >F2 &&
     ++	git add F2 &&
     ++	test_must_fail git rebase --continue &&
     ++	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
     ++	test_subcommand_flex git maintenance run --auto <end.txt
      +'
      +
       test_done
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'commit descriptions in ins
      +	test_subcommand_flex git maintenance run --auto <single.txt &&
      +	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
      +		git cherry-pick anotherpick yetanotherpick &&
     ++	test_subcommand_flex git maintenance run --auto <sequence.txt &&
      +	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&
      +	test_line_count = 1 maintenance
      +'
     ++
     ++test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence is done' '
     ++	pristine_detach initial &&
     ++	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
     ++		git cherry-pick base..anotherpick &&
     ++	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
     ++	echo resolved >foo &&
     ++	git add foo &&
     ++	test_must_fail git cherry-pick --continue &&
     ++	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
     ++	test_subcommand_flex git maintenance run --auto <end.txt
     ++'
      +
       test_done
 3:  9a6fc0427a ! 3:  7a353df3d9 sequencer: keep auto maintenance out of the commands a sequence spawns
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    sequencer: keep auto maintenance out of the commands a sequence spawns
     +    sequencer: disable auto maintenance in spawned commands
      
     -    The "git commit" and "git merge" the sequencer spawns, and the git
     -    commands an exec runs, each start "git maintenance run --auto
     -    --detach", which then works in the background against the sequence
     -    itself. A "rerere gc" started by the commit of one "git rebase
     -    --continue" holds MERGE_RR.lock when the next pick needs it, and a
     -    repack deletes packs the sequencer still has open, which 65cda10d5b
     -    (sequencer: release the ODB before spawning git commit, 2026-08-12)
     -    had to work around.
     +    The "git commit" and "git merge" the sequencer spawns run "git
     +    maintenance run --auto --detach" as they finish, and so does any
     +    such command an exec runs. That maintenance then works in the
     +    background while the sequencer goes on with the sequence, and the
     +    two get in each other's way. With rerere enabled, the maintenance
     +    started by the "git commit" of a "git rebase --continue" runs
     +    "rerere gc", which can still hold MERGE_RR.lock when the next pick
     +    conflicts. The rebase then dies with "Unable to create
     +    '.../MERGE_RR.lock': File exists" instead of stopping for the user
     +    to resolve the conflict. And a repack can delete a pack the
     +    sequencer still has open, which 65cda10d5b (sequencer: release the
     +    ODB before spawning git commit, 2026-08-12) works around.
      
     -    The loose objects a sequence creates wait for the run at its end that
     -    the previous commit added. Whether a sequence can be long enough to
     -    suffer from them before that remains to be seen. Pass
     -    maintenance.auto=false and gc.auto=0 to the spawned commands through
     -    GIT_CONFIG_PARAMETERS, which the shell of an exec command hands on to
     -    whatever it runs, appended after the user's own -c settings so that
     -    ours win, and built once per run. A command the user runs while the
     -    sequence is stopped, like "git commit --amend" at an edit, is not the
     -    sequencer's to control and still runs maintenance.
     +    Pass maintenance.auto=false to these commands through
     +    GIT_CONFIG_PARAMETERS, as "git -c" would. We build the value once
     +    from the one we inherited and append our setting after the user's
     +    own -c settings so that it wins. The environment also reaches
     +    everything the command spawns in turn, so a git command run from an
     +    exec is covered as well. The sequencer also spawns "git stash", "git
     +    reset" and "git notes", which never run auto maintenance.
     +
     +    With the previous commit, rebase, cherry-pick and revert run auto
     +    maintenance once when they are done, so a sequence now runs it
     +    exactly once, at the end. A sequence that stops for conflicts used
     +    to run it at every resolution and now piles up its loose objects
     +    until the end, as a sequence without conflicts always has.
     +
     +    A command the user runs while the sequence is stopped, like "git
     +    commit --amend" at an edit, still runs auto maintenance. The
     +    sequencer does not spawn it and has no say in it.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ sequencer.c: struct replay_ctx {
       	 */
       	unsigned have_message :1;
      +	/*
     -+	 * The GIT_CONFIG_PARAMETERS value that keeps auto maintenance out
     -+	 * of the commands we spawn, built on first use.
     ++	 * GIT_CONFIG_PARAMETERS for the commands we spawn, with auto
     ++	 * maintenance turned off. Built on first use.
      +	 */
     -+	struct strbuf config_parameters;
     ++	char *config_parameters;
       };
       
       struct replay_ctx* replay_ctx_new(void)
     -@@ sequencer.c: struct replay_ctx* replay_ctx_new(void)
     - 
     - 	strbuf_init(&ctx->current_fixups, 0);
     - 	strbuf_init(&ctx->message, 0);
     -+	strbuf_init(&ctx->config_parameters, 0);
     - 
     - 	return ctx;
     - }
      @@ sequencer.c: static void replay_ctx_release(struct replay_ctx *ctx)
       {
       	strbuf_release(&ctx->current_fixups);
       	strbuf_release(&ctx->message);
     -+	strbuf_release(&ctx->config_parameters);
     ++	free(ctx->config_parameters);
       }
       
       void replay_opts_release(struct replay_opts *opts)
     @@ sequencer.c: static int run_command_silent_on_success(struct child_process *cmd)
       }
       
      +/*
     -+ * A sequence runs auto maintenance once it is done, not from every command
     -+ * it spawns along the way: their background "rerere gc" or repack would
     -+ * race the sequencer for locks and files it still holds.
     ++ * Don't let the commands we spawn run auto maintenance. It would race
     ++ * us for MERGE_RR.lock or delete packs we still have open. Our caller
     ++ * runs it once the sequence is done.
      + */
      +static void disable_auto_maintenance(struct replay_opts *opts,
      +				     struct child_process *cmd)
      +{
     -+	struct strbuf *params = &opts->ctx->config_parameters;
     -+
     -+	if (!params->len) {
     ++	if (!opts->ctx->config_parameters) {
      +		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
     ++		struct strbuf buf = STRBUF_INIT;
      +
      +		if (old && *old)
     -+			strbuf_addstr(params, old);
     -+		git_config_append_parameter(params, "maintenance.auto", "false");
     -+		git_config_append_parameter(params, "gc.auto", "0");
     ++			strbuf_addstr(&buf, old);
     ++		git_config_append_parameter(&buf, "maintenance.auto", "false");
     ++		opts->ctx->config_parameters = strbuf_detach(&buf, NULL);
      +	}
     -+	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, params->buf);
     ++	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT,
     ++		     opts->ctx->config_parameters);
      +}
      +
       /*
     @@ sequencer.c: static int continue_single_pick(struct repository *r, struct replay
       	/*
      
       ## t/t3418-rebase-continue.sh ##
     -@@ t/t3418-rebase-continue.sh: test_expect_success 'rebase runs auto maintenance at its end' '
     - 	test_subcommand_flex git maintenance run --auto <finish.txt
     - '
     - 
     -+test_expect_success 'rebase spawns no auto maintenance before its end' '
     -+	git checkout -b two-conflicts topic &&
     -+	test_commit F2-again F2 222 &&
     -+	test_must_fail git rebase -x "git commit --allow-empty -m exec" main &&
     -+	echo resolved >F2 &&
     -+	git add F2 &&
     +@@ t/t3418-rebase-continue.sh: test_orig_head --merge
     + test_expect_success 'rebase runs auto maintenance once it is done' '
     + 	git checkout -b auto-maintenance topic &&
     + 	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
     +-		git rebase -x false main &&
     ++		git rebase -x "git commit --allow-empty -m exec && false" main &&
     + 	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
     + 	echo resolved >F2 &&
     + 	git add F2 &&
     +-	test_must_fail git rebase --continue &&
      +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
      +		git rebase --continue &&
      +	test_subcommand_flex git commit <mid.txt &&
      +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
     -+	echo resolved >F2 &&
     -+	git add F2 &&
     -+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
     + 	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
     +-	test_subcommand_flex git maintenance run --auto <end.txt
      +	test_subcommand_flex git maintenance run --auto <end.txt &&
      +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
      +	test_line_count = 1 maintenance
     -+'
     -+
     + '
     + 
       test_done
      
       ## t/t3510-cherry-pick-sequence.sh ##
     -@@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'cherry-pick runs auto maintenance once it is done' '
     - 	test_line_count = 1 maintenance
     - '
     - 
     -+test_expect_success 'cherry-pick spawns no auto maintenance before it is done' '
     -+	pristine_detach initial &&
     -+	test_must_fail git cherry-pick base..anotherpick &&
     -+	echo resolved >foo &&
     -+	git add foo &&
     +@@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'commit descriptions in insn sheet are optional' '
     + 
     + test_expect_success 'cherry-pick runs auto maintenance once it is done' '
     + 	pristine_detach base &&
     +-	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
     ++	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick --edit picked &&
     ++	test_subcommand_flex git commit <single.txt &&
     + 	test_subcommand_flex git maintenance run --auto <single.txt &&
     ++	grep "\"child_start\".*\"maintenance\"" single.txt >maintenance &&
     ++	test_line_count = 1 maintenance &&
     + 	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
     + 		git cherry-pick anotherpick yetanotherpick &&
     + 	test_subcommand_flex git maintenance run --auto <sequence.txt &&
     +@@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence i
     + 	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
     + 	echo resolved >foo &&
     + 	git add foo &&
     +-	test_must_fail git cherry-pick --continue &&
      +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
      +		git cherry-pick --continue &&
      +	test_subcommand_flex git commit <mid.txt &&
      +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
     -+	echo d >foo &&
     -+	git add foo &&
     -+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --continue &&
     -+	test_subcommand_flex git commit <end.txt &&
     + 	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
     +-	test_subcommand_flex git maintenance run --auto <end.txt
     ++	test_subcommand_flex git maintenance run --auto <end.txt &&
      +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
      +	test_line_count = 1 maintenance
     -+'
     -+
     + '
     + 
       test_done

-- 
gitgitgadget
